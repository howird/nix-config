import type { RunnerReport } from "./submission.ts";

function isRecord(value: unknown): value is Record<string, unknown> {
	return value !== null && typeof value === "object" && !Array.isArray(value);
}

/** Keep report formatting but never forward terminal control sequences to Pi's TUI. */
export function cleanClaudeText(text: string): string {
	return text
		.replace(/\r\n/g, "\n")
		.replace(/\p{Cc}/gu, (ch) => (ch === "\n" || ch === "\t" ? ch : ""));
}

export function parseClaudeReviewResult(
	stdout: Buffer,
	stderr: string,
	code: number | null,
	signal: NodeJS.Signals | null,
): RunnerReport {
	const processFailure = signal
		? `Claude was stopped by ${signal}.`
		: code === null
			? "Claude did not exit cleanly."
			: code !== 0
				? `Claude exited with code ${code}.`
				: "";
	const failed = (messages: string[], report = ""): RunnerReport => ({
		ok: false,
		saveReport: Boolean(report.trim()),
		report: [
			...messages,
			processFailure,
			stderr && `Claude stderr:\n${stderr}`,
			report && `Claude's output (may be incomplete):\n\n${report}`,
		]
			.filter(Boolean)
			.join("\n\n"),
	});

	let result: unknown;
	try {
		result = JSON.parse(
			new TextDecoder("utf-8", { fatal: true }).decode(stdout),
		);
	} catch {
		return failed([
			stdout.length
				? "Claude did not return valid JSON."
				: "Claude returned no JSON result.",
		]);
	}
	if (
		!isRecord(result) ||
		result.type !== "result" ||
		typeof result.is_error !== "boolean" ||
		typeof result.subtype !== "string" ||
		!result.subtype ||
		!Array.isArray(result.permission_denials) ||
		!result.permission_denials.every(
			(denial) =>
				isRecord(denial) &&
				typeof denial.tool_name === "string" &&
				denial.tool_name.trim(),
		) ||
		(result.result !== undefined && typeof result.result !== "string") ||
		(result.errors !== undefined &&
			(!Array.isArray(result.errors) ||
				!result.errors.every((error) => typeof error === "string"))) ||
		(result.stopped_by_permission_check !== undefined &&
			typeof result.stopped_by_permission_check !== "boolean") ||
		(result.stop_reason != null && typeof result.stop_reason !== "string")
	) {
		return failed(["Claude returned an unexpected JSON result shape."]);
	}

	const report =
		typeof result.result === "string" ? cleanClaudeText(result.result) : "";
	const diagnostics: string[] = [];
	if (result.is_error || result.subtype !== "success") {
		diagnostics.push(
			`Claude reported an error (${cleanClaudeText(result.subtype)}).`,
		);
	}
	if (result.errors?.length)
		diagnostics.push(cleanClaudeText(result.errors.join("\n")));
	if (
		result.permission_denials.length ||
		result.stopped_by_permission_check === true
	) {
		const tools = [
			...new Set(
				result.permission_denials.map((denial) =>
					cleanClaudeText(denial.tool_name),
				),
			),
		];
		diagnostics.push(
			`Claude encountered permission denials${tools.length ? ` (${tools.join(", ")})` : ""}. The review may be incomplete.`,
		);
	}
	if (result.stop_reason === "max_tokens")
		diagnostics.push("Claude hit its output token limit.");
	if (result.stop_reason === "refusal")
		diagnostics.push("Claude refused to complete the request.");
	if (!report.trim())
		diagnostics.push("Claude did not provide a review report.");
	if (processFailure || diagnostics.length) return failed(diagnostics, report);
	return { ok: true, report, saveReport: true };
}
