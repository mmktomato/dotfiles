---
name: requesting-review
description: "Writes a review request file for a completed task and a delegation prompt for another AI agent to review it. Use when asked to request a review, get a second opinion, or hand off work for independent review."
model: sonnet
---

# Requesting Review

## Workflow

1. Determine the session ID (see below).
2. Check whether `~/.agents/reviews` exists; only run `mkdir -p ~/.agents/reviews` if it doesn't.
3. Before writing, check for and read anything relevant to this session that already exists:
   - a plan file at `~/.agents/plans/<session-id>.md`
   - files in this session's scratchpad directory
   - etc
   Fold anything relevant into the request.
4. Write the review request to `~/.agents/reviews/<session-id>-request.md`.
   If it already exists, overwrite or append — either is fine, no branch numbering needed.
   Make sure it covers
   - the task's background
   - how it came about
   - every decision the user made
     - explicit instructions and constraints
     - choices between options you presented
     - concerns you raised that the user overruled or reaffirmed
   - what was investigated
   - every change made
   - every destructive/breaking change
     - file operations
     - git operations
     - command execution
     - network calls
     - MCP calls
     - etc
   - any other consideration the reviewer should know.
5. Output a prompt, as your final response, for the user to hand to another AI agent.
   Make sure it instructs the other agent to:
   - read the review request at `~/.agents/reviews/<session-id>-request.md`
   - **perform no destructive operations while reviewing**
   - write its findings to `~/.agents/reviews/<session-id>-result.md` (overwrite or append if it already exists).

Do not call the Agent tool yourself unless the user explicitly asks you to dispatch the review — this skill's job
is producing the request file and the prompt, not running the review.

If the user gives any additional instructions when invoking this skill, follow those too.

### Determining the session ID

Session ID = the coding agent session's own ID, not something to ask the user for.

- In Claude Code, it's the last path segment of the scratchpad directory.
  - e.g. `.../claude-501/.../a9befa93-fb47-4dad-b7e7-4c200c9198fe/scratchpad`
  - → session id `a9befa93-fb47-4dad-b7e7-4c200c9198fe`.
- Other coding agents may expose it differently — find the equivalent for the agent currently in use.
