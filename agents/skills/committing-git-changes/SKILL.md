---
name: committing-git-changes
description: Guides AI agents on how to split commits appropriately, write concise commit messages. Use this skill whenever making git commits.
allowed-tools: Bash(git rev-parse:*) Read(/.git) shell(git rev-parse:*) read(.git)
---

# Git Commit Guidelines

## Commit Splitting

Each commit must be a self-contained, meaningful change that works on its own when checked out in isolation:

- Separate unrelated concerns into distinct commits (e.g., feature additions vs. refactoring, main change vs. minor incidental fixes)
- Split further even within the same concern if the diff becomes too large to review
- Respect dependency order: commits that introduce a function/module must come before commits that use it; commits that remove an old implementation must come only after nothing else still depends on it
- Never leave a commit with dangling references (undefined symbols, imports of files that don't exist yet)
- Each commit must build and its unit tests must pass on its own
- Before finalizing a split, self-check every commit boundary: "would this commit work if checked out alone?"

## Commit Message

Write a single-line message that concisely summarizes the change.

## Branch Check

Always retrieve the current branch before committing:

```sh
git rev-parse --abbrev-ref HEAD
```

Then **show the branch name to the user and get explicit confirmation before committing** — every time, without exception.

Use the following decision tree. If you encounter any situation not covered here, **warn the user and ask for confirmation** — never proceed automatically.

```
Could not retrieve the branch? (command failed / unexpected value)
└── Warn the user and ask how to proceed

Show the current branch and ask the user whether to commit on it
│   (If it matches `^((main|master|develop|beta)$|releases?/)` — state explicitly
│    in the question that this is a protected branch)
│
├── User does not confirm → Do NOT commit
│                           Ask which branch to use instead
│
└── User confirms → Branch matches `^[A-Z]+-[0-9]+/` ? (e.g., PROJECT-1234/impl-feature)
    ├── Yes → Prefix message with the issue key
    │         Format : "<KEY> <message>"
    │         Example: "PROJECT-1234 implement new feature"
    └── No  → Commit normally following all guidelines in this document
```
