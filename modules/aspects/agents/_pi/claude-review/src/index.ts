import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { runClaudeReview } from "./runner.ts";
import { submitBackgroundRunner } from "./submission.ts";

export default function claudeReview(pi: ExtensionAPI): void {
	pi.registerCommand("code-review", {
		description:
			"Run Claude Code's bundled /review at medium effort (report only)",
		handler: async (args, ctx) => {
			if (args.trim()) {
				ctx.ui.notify("Usage: /code-review (no arguments)", "error");
				return;
			}
			try {
				if (process.platform === "win32") {
					throw new Error(
						"/code-review requires POSIX process groups to stop Claude and its subprocesses.",
					);
				}
				const { id, completion } = submitBackgroundRunner(pi, {
					name: "code-review",
					title: "Claude Code review",
					timeoutSeconds: 15 * 60,
					run: runClaudeReview,
				});
				if (ctx.hasUI) {
					ctx.ui.notify(
						`Started Claude review (${id}). Manage it with /subagents.`,
						"info",
					);
				} else {
					// Keep a noninteractive command invocation alive through result routing.
					await completion;
				}
			} catch (error) {
				ctx.ui.notify(
					`Claude review: ${error instanceof Error ? error.message : String(error)}`,
					"error",
				);
			}
		},
	});
}
