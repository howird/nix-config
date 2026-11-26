# Claude review for Pi

Run `/code-review` in Pi to ask Claude Code's bundled `/review medium` to review changes in Pi's current working directory. The command takes no arguments: it does not request fixes, post comments, or run `ultra`. It does not launch a Pi model or register a provider. Claude Code authenticates and makes its own review calls, which may use your Claude account or API quota.

## Provisioning

Add this package's directory to Pi's `settings.json` `packages` list alongside the patched `pi-subagents` package that provides `pi-subagents:background-runner:v1:submit`. In Nix, use the package path `${./claude-review}` from the containing `_pi` directory. The manifest points directly to the TypeScript entry point; no `npm install`, build, private fork import, or writable store path is needed. The packages can load in either order. Enable at least one named Pi agent to expose the subagents runtime; the review itself does not use that agent. If the v1 API isn't available, `/code-review` reports an error and does not start Claude.

Use a POSIX host and put a compatible `claude` on Pi's `PATH`. The CLI needs the bundled `/review` alias and noninteractive permission options (the contract was checked against Claude Code 2.1.325). Configure Claude authentication separately from Pi.

## Running and stopping a review

The review shares the Pi subagent concurrency limit. Open `/subagents` to inspect or stop it. Pi requests cancellation on session shutdown or at the 15-minute hard limit, then waits for the runner to clean up. The runner sends SIGTERM and escalates to SIGKILL for subprocesses in the same process group; it cannot stop processes that deliberately leave the group.

A completed report is displayed in the origin session without starting another Pi turn. If the parent has a session path, findings (including valid partial findings) are also saved as `code-review-<id>.md` in the normal session artifact directory. This preserves the report even if Pi has not written a session file yet. The review has no Pi child session, token counters, or resume action. Claude's JSON stdout is capped at 512 KiB and stderr diagnostics at 8 KiB. An oversized, invalid, or permission-denied result is a failure, not a clean review.

The runner disables session persistence, uses safe mode without user/project/local setting sources or custom MCP servers, and allows no interactive permission prompts. It retains Bash along with Read, Grep, Glob and Agent. It explicitly preapproves `git status`, `git diff`, and `git diff --cached` for Git inspection, without granting blanket Bash approval, and explicitly denies edit/write tools. This is **not** a filesystem or network sandbox: Claude's built-in behavior and managed policy still apply. Claude inherits Pi's environment, filtered by `PI_SUBAGENT_ENV_DENY` (comma/newline-separated names or `*` patterns). Run only in trusted workspaces.

## Tests

Run `npm test` with Node 22+; the tests use only a fake `claude` executable or a fake Pi command/event API, with no network calls.
