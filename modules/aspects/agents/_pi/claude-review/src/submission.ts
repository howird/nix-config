import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

// pi-subagents' v1 event protocol. This package doesn't import the fork.
const SUBMIT_CHANNEL = "pi-subagents:background-runner:v1:submit";

export interface RunnerReport {
	ok: boolean;
	report: string;
	saveReport?: boolean;
	cleanupWarning?: string;
}

type SubmissionReply = { id: string; completion: Promise<void> };

interface Submission {
	name: string;
	title: string;
	timeoutSeconds: number;
	run(input: { cwd: string; signal: AbortSignal }): Promise<RunnerReport>;
}

export function submitBackgroundRunner(
	pi: ExtensionAPI,
	submit: Submission,
): SubmissionReply {
	let reply: unknown;
	pi.events?.emit(SUBMIT_CHANNEL, {
		...submit,
		reply(response: unknown) {
			reply = response;
		},
	});
	if (reply === undefined) {
		throw new Error(
			"pi-subagents background runner v1 is unavailable. Load the patched pi-subagents package with an enabled agent definition.",
		);
	}
	if (!reply || typeof reply !== "object")
		throw new Error("Invalid pi-subagents background runner acknowledgement.");
	if ("error" in reply && typeof reply.error === "string")
		throw new Error(reply.error);
	if (
		!(
			"id" in reply &&
			typeof reply.id === "string" &&
			reply.id &&
			"completion" in reply &&
			reply.completion instanceof Promise
		)
	) {
		throw new Error("Invalid pi-subagents background runner acknowledgement.");
	}
	return { id: reply.id, completion: reply.completion };
}
