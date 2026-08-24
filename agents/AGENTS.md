# Subagent Delegation

Subagents (Agent/Task, not `fork`) don't see this file.
When dispatching one, copy the relevant rules above into its prompt.

# Response tone

Respond terse like smart caveman. All technical substance stay. Only fluff die. But don't be rude.
When responding in Japanese, use です/ます (polite) form instead of casual/plain form, while keeping the terse caveman compression otherwise.
Stop it when:

- Security warnings
- Irreversible action confirmations
- Multi-step sequences where fragment order or omitted conjunctions risk misread
- Compression itself creates technical ambiguity
- User asks to clarify or repeats question

Resume it after clear part done.

# Shell Command Safety

One plain literal command per Bash call.
No `&&`, `||`, `|`, `;`, `>`, `<`, `$(...)`, backticks, or multi-line scripts — any of these makes the call something the permission checker can't statically verify, and it gets blocked.

If a task needs multiple steps: run each as a separate Bash call.
Carry data between them as literal values read from the previous call's output — not shell variables or substitution.
When a tool needs another tool's output as input, prefer file-based flags (`-o`, `-i`, etc.) over shell redirects.

## Examples

- Good: `git status` then `git diff` as separate calls.
- Bad: `git status && git diff`.

- Good: `grep -n foo file.txt`.
- Bad: `cat file.txt | grep foo`.

- Good: `curl -s $URL -o /tmp/resp.json` then `jq . /tmp/resp.json` as separate calls.
- Bad: `curl -s $URL | jq .` or `resp=$(curl -s $URL); jq --arg r "$resp" ...`.

# JSON Tools

Use the `jq` command instead of other commands like `python3` or `node` when parsing a json string.

# `gh` command

Always specify the HTTP method with the `-X` option when invoking `gh api`, even though it can be omitted.

```
// Bad
gh api repos/organization/repository

// Good
gh api -X GET repos/organization/repository
```

# Source Code Comments

As a rule, don't write comments.
When a comment is necessary, follow these rules.

- Write it in English.
- Keep it concise. A single short line is preferred.
    - If the background is complex, referring to the relevant Backlog issue key is acceptable.
- It must still be meaningful after the PR is merged (= after the task ends).
    - In other words, don't write comments specific to the task currently in progress.

# Git Commits

Git commits are only permitted when the user explicitly instructs you to commit.
You **MUST** use the `/committing-git-changes` skill when making a git commit.

# Backlog

Use the Backlog MCP Server when fetching information from the `*.backlog.(jp|com)` domain.
Text matching the pattern `[A-Z]+-[0-9]+` (e.g. PROJECT-1234) is a Backlog issue key — use the same server to retrieve or manipulate it.
