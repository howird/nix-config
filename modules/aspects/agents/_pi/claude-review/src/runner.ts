import { spawn } from "node:child_process";
import { cleanClaudeText, parseClaudeReviewResult } from "./result.ts";
import type { RunnerReport } from "./submission.ts";

const STDOUT_LIMIT = 512 * 1024;
const STDERR_LIMIT = 8 * 1024;
const KILL_ESCALATION_MS = 5000;
const VOLATILE_ENV = ["OLDPWD", "PWD", "SHLVL", "_"];

function buildClaudeEnv(): NodeJS.ProcessEnv {
	const denied = (process.env.PI_SUBAGENT_ENV_DENY ?? "")
		.split(/[,\n]/)
		.map((name) => name.trim())
		.filter(Boolean);
	const matchers = denied.map(
		(name) =>
			new RegExp(
				`^${name
					.split("*")
					.map((segment) => segment.replace(/[.*+?^${}()|[\]\\]/g, "\\$&"))
					.join(".*")}$`,
				"s",
			),
	);
	return Object.fromEntries(
		Object.entries(process.env).filter(
			([name]) =>
				!VOLATILE_ENV.includes(name) &&
				!matchers.some((matcher) => matcher.test(name)),
		),
	);
}

function isGroupAlive(pid: number): boolean {
	try {
		process.kill(-pid, 0);
		return true;
	} catch (error) {
		return (error as NodeJS.ErrnoException).code !== "ESRCH";
	}
}

async function stopGroup(pid: number, escalationMs: number): Promise<boolean> {
	function signalGroup(signal: NodeJS.Signals) {
		try {
			process.kill(-pid, signal);
		} catch (error) {
			if ((error as NodeJS.ErrnoException).code !== "ESRCH") throw error;
		}
	}
	signalGroup("SIGTERM");
	const escalationAt = Date.now() + escalationMs;
	const giveUpAt = escalationAt + 1000;
	let escalated = false;
	while (isGroupAlive(pid) && Date.now() < giveUpAt) {
		if (!escalated && Date.now() >= escalationAt) {
			escalated = true;
			signalGroup("SIGKILL");
		}
		await new Promise((resolve) => setTimeout(resolve, 25));
	}
	return !isGroupAlive(pid);
}

/** Own the process and its pipes until all report data or abort cleanup is accounted for. */
export function runClaudeReview(
	{ cwd, signal }: { cwd: string; signal: AbortSignal },
	killEscalationMs = KILL_ESCALATION_MS,
): Promise<RunnerReport> {
	if (signal.aborted)
		return Promise.resolve({ ok: false, report: "Claude review cancelled." });
	const child = spawn(
		"claude",
		[
			"-p",
			"--output-format",
			"json",
			"--no-session-persistence",
			"--safe-mode",
			"--setting-sources",
			"",
			"--strict-mcp-config",
			"--permission-mode",
			"manual",
			"--permission-prompts",
			"none",
			// The bundled skill needs git and can delegate parts of the review.
			// Do not grant blanket Bash permission or expose mutation tools.
			"--tools",
			"Bash,Read,Grep,Glob,Agent",
			"--allowed-tools",
			"Bash(git status),Bash(git diff),Bash(git diff --cached)",
			"--disallowed-tools",
			"Write,Edit,NotebookEdit",
			"--",
			"/review medium",
		],
		{
			cwd,
			env: buildClaudeEnv(),
			detached: true,
			stdio: ["ignore", "pipe", "pipe"],
		},
	);

	const stdout: Buffer[] = [];
	const stderr: Buffer[] = [];
	let stdoutBytes = 0;
	let stderrBytes = 0;
	let stderrTruncated = false;
	let stopReason: string | undefined;
	let stopping = false;
	let closed = false;
	let resolveClose: () => void;
	const close = new Promise<void>((resolve) => {
		resolveClose = resolve;
	});

	return new Promise((resolve, reject) => {
		const stop = (reason?: string) => {
			stopReason ??= reason;
			if (stopping) return;
			stopping = true;
			void finish().catch(reject);
		};

		const finish = async () => {
			// Also clean up helpers that outlive the leader on a normal exit.
			const pid = child.pid;
			const groupStopped =
				!pid ||
				!isGroupAlive(pid) ||
				(await stopGroup(pid, killEscalationMs).catch(() => false));
			if (!stopReason && !closed) {
				// `exit` can arrive before the last bytes, and descendants can keep
				// pipes open even after the leader leaves. Wait for `close`, bounded.
				let drainTimer: ReturnType<typeof setTimeout> | undefined;
				await Promise.race([
					close,
					new Promise<void>((done) => {
						drainTimer = setTimeout(done, 1000);
					}),
				]);
				clearTimeout(drainTimer);
			}
			signal.removeEventListener("abort", onAbort);
			child.unref();
			if (!closed) {
				child.stdout.destroy();
				child.stderr.destroy();
			}

			const diagnostic =
				stopReason ??
				(!closed
					? "Claude exited but its output pipes did not close."
					: undefined);
			const stderrText =
				cleanClaudeText(Buffer.concat(stderr).toString("utf8")).trim() +
				(stderrTruncated ? "\n[Claude stderr truncated]" : "");
			const outcome: RunnerReport = diagnostic
				? { ok: false, report: diagnostic }
				: parseClaudeReviewResult(
						Buffer.concat(stdout),
						stderrText,
						child.exitCode,
						child.signalCode,
					);
			resolve(
				groupStopped
					? outcome
					: {
							...outcome,
							ok: false,
							cleanupWarning:
								"Warning: Pi could not confirm that Claude's process group stopped.",
						},
			);
		};

		const onAbort = () => stop("Claude review cancelled.");
		child.stdout.on("data", (chunk: Buffer) => {
			if (stopReason) return;
			stdoutBytes += chunk.length;
			if (stdoutBytes > STDOUT_LIMIT) {
				stop(
					"Claude exceeded the 512 KiB JSON output limit; no complete report was accepted.",
				);
				return;
			}
			stdout.push(chunk);
		});
		child.stderr.on("data", (chunk: Buffer) => {
			const remaining = STDERR_LIMIT - stderrBytes;
			if (chunk.length > remaining) stderrTruncated = true;
			if (remaining <= 0) return;
			const saved = chunk.subarray(0, remaining);
			stderr.push(saved);
			stderrBytes += saved.length;
		});
		child.once("close", () => {
			closed = true;
			resolveClose();
			stop();
		});
		child.once("exit", () => stop());
		child.on("error", (error: NodeJS.ErrnoException) =>
			stop(
				error.code === "ENOENT"
					? "Could not start Claude: check that `claude` is on PATH and the working directory exists."
					: `Could not run Claude: ${cleanClaudeText(error.message)}`,
			),
		);
		signal.addEventListener("abort", onAbort, { once: true });
		if (signal.aborted) onAbort();
	});
}
