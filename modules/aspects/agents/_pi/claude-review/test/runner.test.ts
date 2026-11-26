import assert from "node:assert/strict";
import {
	existsSync,
	mkdtempSync,
	readFileSync,
	rmSync,
	writeFileSync,
} from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { describe, it, type TestContext } from "node:test";
import { runClaudeReview } from "../src/runner.ts";

const success = {
	type: "result",
	subtype: "success",
	is_error: false,
	permission_denials: [],
	result: "Report with line references.\n- src/main.ts:17",
};

function startFixture(t: TestContext, body: string | null, denyEnv = "") {
	const cwd = mkdtempSync(join(tmpdir(), "pi-claude-review-"));
	if (body !== null)
		writeFileSync(join(cwd, "claude"), `#!${process.execPath}\n${body}`, {
			mode: 0o700,
		});
	const controller = new AbortController();
	const originalPath = process.env.PATH;
	const originalDeny = process.env.PI_SUBAGENT_ENV_DENY;
	process.env.PATH = cwd;
	process.env.PI_SUBAGENT_ENV_DENY = denyEnv;
	let watch: ReturnType<typeof runClaudeReview>;
	try {
		watch = runClaudeReview({ cwd, signal: controller.signal }, 80);
	} finally {
		if (originalPath === undefined) delete process.env.PATH;
		else process.env.PATH = originalPath;
		if (originalDeny === undefined) delete process.env.PI_SUBAGENT_ENV_DENY;
		else process.env.PI_SUBAGENT_ENV_DENY = originalDeny;
	}
	t.after(async () => {
		controller.abort();
		await watch;
		rmSync(cwd, { recursive: true, force: true });
	});
	return { cwd, controller, watch };
}

function emit(result: unknown) {
	return `process.stdout.write(${JSON.stringify(JSON.stringify(result))});`;
}

describe("Claude review fake CLI", {
	skip: process.platform === "win32",
}, () => {
	it("invokes the exact restricted command and preserves a complete UTF-8 report", async (t) => {
		const report =
			"# Review findings\n\n" +
			"context ".repeat(1500) +
			"\n\n- src/foo.ts:42: lost update 🧪";
		const priorSecret = process.env.CLAUDE_REVIEW_TEST_SECRET;
		process.env.CLAUDE_REVIEW_TEST_SECRET = "not for the client";
		t.after(() => {
			if (priorSecret === undefined)
				delete process.env.CLAUDE_REVIEW_TEST_SECRET;
			else process.env.CLAUDE_REVIEW_TEST_SECRET = priorSecret;
		});
		const { cwd, watch } = startFixture(
			t,
			`
require('node:fs').writeFileSync('invocation.json', JSON.stringify({
  argv: process.argv.slice(2), cwd: process.cwd(), secret: process.env.CLAUDE_REVIEW_TEST_SECRET,
}));
const output = Buffer.from(${JSON.stringify(JSON.stringify({ ...success, result: report }))});
const split = output.indexOf(Buffer.from('🧪')) + 2;
process.stdout.write(output.subarray(0, split));
setTimeout(() => process.stdout.write(output.subarray(split)), 15);
`,
			"CLAUDE_REVIEW_TEST_*",
		);
		const outcome = await watch;
		assert.deepEqual(outcome, { ok: true, report, saveReport: true });
		assert.deepEqual(
			JSON.parse(readFileSync(join(cwd, "invocation.json"), "utf8")),
			{
				cwd,
				argv: [
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
					"--tools",
					"Bash,Read,Grep,Glob,Agent",
					"--allowed-tools",
					"Bash(git status),Bash(git diff),Bash(git diff --cached)",
					"--disallowed-tools",
					"Write,Edit,NotebookEdit",
					"--",
					"/review medium",
				],
			},
		);
	});

	it("fails malformed JSON and invalid result fields rather than reporting a clean review", async (t) => {
		const bad = startFixture(t, `process.stdout.write('not json\\n');`);
		const shape = startFixture(
			t,
			emit({ ...success, permission_denials: "unknown" }),
		);
		const blank = startFixture(t, emit({ ...success, result: "\n " }));
		for (const [fixture, expected] of [
			[bad, /not return valid JSON/],
			[shape, /unexpected JSON result shape/],
			[blank, /did not provide a review report/],
		] as const) {
			const result = await fixture.watch;
			assert.equal(result.ok, false);
			assert.match(result.report, expected);
		}
	});

	it("keeps partial findings when Claude reports permission denials even with exit zero", async (t) => {
		const { watch } = startFixture(
			t,
			emit({
				...success,
				permission_denials: [
					{
						tool_name: "Bash",
						tool_use_id: "id",
						tool_input: { command: "private input" },
					},
				],
			}),
		);
		const result = await watch;
		assert.equal(result.ok, false);
		assert.equal(result.saveReport, true);
		assert.match(result.report, /permission denials \(Bash\)/);
		assert.match(result.report, /may be incomplete/);
		assert.ok(result.report.endsWith(success.result));
		assert.doesNotMatch(result.report, /private input/);
	});

	it("reports JSON error envelopes and actual nonzero process exits", async (t) => {
		const cliError = startFixture(
			t,
			emit({
				type: "result",
				subtype: "error_during_execution",
				is_error: true,
				permission_denials: [],
				errors: ["Could not authenticate"],
			}),
		);
		const nonzero = startFixture(
			t,
			`${emit(success)} process.stderr.write('cli error\\n'); process.exitCode = 17;`,
		);
		const error = await cliError.watch;
		assert.equal(error.ok, false);
		assert.match(error.report, /error_during_execution/);
		assert.match(error.report, /Could not authenticate/);
		const failure = await nonzero.watch;
		assert.equal(failure.ok, false);
		assert.match(failure.report, /Claude exited with code 17/);
		assert.match(failure.report, /cli error/);
		assert.ok(failure.report.endsWith(success.result));
	});

	it("bounds stdout and stderr even when a fixture floods a pipe", async (t) => {
		const stdout = startFixture(
			t,
			`process.stdout.write('x'.repeat(768 * 1024)); setInterval(() => {}, 1000);`,
		);
		const stderr = startFixture(
			t,
			`process.stderr.write('x'.repeat(64 * 1024)); process.exitCode = 2;`,
		);
		const oversize = await stdout.watch;
		assert.equal(oversize.ok, false);
		assert.match(oversize.report, /512 KiB JSON output limit/);
		const noisy = await stderr.watch;
		assert.equal(noisy.ok, false);
		assert.match(noisy.report, /stderr truncated/);
		assert.ok(noisy.report.length < 8500);
	});

	it("reports a missing Claude CLI without falling back to Pi", async (t) => {
		const { watch } = startFixture(t, null);
		const result = await watch;
		assert.equal(result.ok, false);
		assert.match(result.report, /`claude` is on PATH/);
	});

	it("signals the whole process group on abort and escalates past an ignored TERM", async (t) => {
		const grandchildBody = `
const fs = require('node:fs');
process.on('SIGTERM', () => { fs.writeFileSync('descendant-saw-term', ''); process.exit(0); });
fs.writeFileSync('descendant-ready', '');
setInterval(() => {}, 1000);
`;
		const { cwd, controller, watch } = startFixture(
			t,
			`
const { spawn } = require('node:child_process');
process.on('SIGTERM', () => { require('node:fs').writeFileSync('leader-saw-term', ''); });
require('node:fs').writeFileSync('leader-pid', String(process.pid));
spawn(process.execPath, ['-e', ${JSON.stringify(grandchildBody)}], { stdio: 'ignore' });
setInterval(() => {}, 1000);
`,
		);
		const deadline = Date.now() + 3000;
		while (
			!existsSync(join(cwd, "descendant-ready")) &&
			Date.now() < deadline
		) {
			await new Promise((resolve) => setTimeout(resolve, 15));
		}
		assert.ok(existsSync(join(cwd, "descendant-ready")));
		const pid = Number(readFileSync(join(cwd, "leader-pid"), "utf8"));
		controller.abort();
		const result = await watch;
		assert.ok(existsSync(join(cwd, "leader-saw-term")));
		assert.ok(existsSync(join(cwd, "descendant-saw-term")));
		assert.equal(result.ok, false);
		assert.match(result.report, /cancelled/);
		assert.equal(result.cleanupWarning, undefined);
		assert.throws(() => process.kill(-pid, 0), { code: "ESRCH" });
	});
});
