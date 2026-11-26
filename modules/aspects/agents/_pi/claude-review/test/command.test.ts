import assert from "node:assert/strict";
import { describe, it } from "node:test";
import type {
	ExtensionAPI,
	ExtensionCommandContext,
} from "@earendil-works/pi-coding-agent";
import claudeReview from "../src/index.ts";
import { runClaudeReview } from "../src/runner.ts";

type CommandOptions = Parameters<ExtensionAPI["registerCommand"]>[1];
type Submit = {
	name: string;
	title: string;
	timeoutSeconds: number;
	run: unknown;
	reply: (response: unknown) => void;
};

function fixture(handle?: (submit: Submit) => void, hasUI = true) {
	let command: CommandOptions | undefined;
	const topics: string[] = [];
	const notes: Array<{ message: string; level: string }> = [];
	claudeReview({
		registerCommand(name: string, options: CommandOptions) {
			assert.equal(name, "code-review");
			command = options;
		},
		events: {
			emit(topic: string, payload: Submit) {
				topics.push(topic);
				handle?.(payload);
			},
		},
	} as unknown as ExtensionAPI);
	const ctx = {
		hasUI,
		ui: {
			notify: (message: string, level: string) =>
				notes.push({ message, level }),
		},
	} as unknown as ExtensionCommandContext;
	assert.ok(command);
	const { handler } = command;
	return { run: (args: string) => handler(args, ctx), topics, notes };
}

describe("/code-review", { skip: process.platform === "win32" }, () => {
	it("rejects fix, comment, ultra, and all other arguments before submitting", async () => {
		const { run, notes, topics } = fixture();
		for (const args of ["--fix", "--comment", "ultra", "medium", "other"])
			await run(args);
		assert.equal(notes.length, 5);
		assert.ok(
			notes.every(
				(note) =>
					note.message === "Usage: /code-review (no arguments)" &&
					note.level === "error",
			),
		);
		assert.deepEqual(topics, []);
	});

	it("reports missing, malformed, and rejected v1 acknowledgements as errors", async () => {
		for (const [reply, expected] of [
			[undefined, /background runner v1 is unavailable/],
			[{ id: "run", completion: true }, /Invalid .* acknowledgement/],
			[{ error: "concurrency limit reached" }, /concurrency limit reached/],
		] as const) {
			const { run, notes } = fixture((submit) => {
				if (reply !== undefined) submit.reply(reply);
			});
			await run("");
			assert.equal(notes.length, 1);
			assert.equal(notes[0].level, "error");
			assert.match(notes[0].message, expected);
		}
	});

	it("submits promptly to v1 with the fixed runner metadata", async () => {
		const { run, notes, topics } = fixture(({ reply, ...metadata }) => {
			assert.deepEqual(metadata, {
				name: "code-review",
				title: "Claude Code review",
				timeoutSeconds: 900,
				run: runClaudeReview,
			});
			reply({ id: "abc", completion: Promise.resolve() });
		});
		await run("   ");
		assert.deepEqual(topics, ["pi-subagents:background-runner:v1:submit"]);
		assert.match(notes[0].message, /Started Claude review \(abc\)/);
	});

	it("waits through report routing when there is no UI", async () => {
		let finish!: () => void;
		const completion = new Promise<void>((resolve) => {
			finish = resolve;
		});
		const { run, notes } = fixture(
			({ reply }) => reply({ id: "abc", completion }),
			false,
		);
		let returned = false;
		const command = run("").then(() => {
			returned = true;
		});
		await new Promise<void>((resolve) => setImmediate(resolve));
		assert.equal(returned, false);
		finish();
		await command;
		assert.equal(returned, true);
		assert.deepEqual(notes, []);
	});
});
