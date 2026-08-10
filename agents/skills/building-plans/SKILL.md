---
name: building-plans
description: "Builds implementation or architecture design plans by gathering requirements through clarifying questions. Use when creating a plan, design proposal, technical approach, or architecture for a feature, system, or codebase change."
---

# Building Plans

## Information gathering

Before building a plan, collect the following through clarifying questions. Ask one question at a time and stop when you have enough to proceed.

**Required:**
- Goal and scope (what problem is being solved, what's in/out)
- Constraints (tech stack, existing architecture, deadlines, team size)
- Definition of done (how success is measured)

**If unclear, also ask:**
- Preferred architectural style or patterns
- Known risks or unknowns

## Workflow

1. Identify what information is missing
2. Ask clarifying questions until requirements are clear
3. Draft the plan
4. Evaluate your **Confidence Score (0-100%)** based on how strongly you recommend this solution and how well it addresses the user's core problems.
5. Present the plan alongside the confidence score and a brief justification for your recommendation.
6. Confirm the plan with the user before finalizing
7. Save the plan to disk and tell the user the resulting file path (see below)

### Saving the plan to disk

- Session ID = the coding agent session's own ID, not something to ask the user for.
  - In Claude Code, it's the last path segment of the scratchpad directory
    - e.g. `.../claude-501/.../a9befa93-fb47-4dad-b7e7-4c200c9198fe/scratchpad` => session id `a9befa93-fb47-4dad-b7e7-4c200c9198fe`.
  - Other coding agents may expose it differently — find the equivalent for the agent currently in use.
- File path: `~/.agents/plans/<session-id>.md`
- Write the full plan content (steps, subagent assignments, confidence score) to that file.
- On any later revision to the plan in this session, overwrite the same file — don't create a new one.

## Output Format for Plans

### Step decomposition

Structure the plan as discrete steps:

- Break the work into steps.
- Assign each step to a subagent; you act as the orchestrator, dispatching steps rather than doing the work yourself.
- For every step, write out the subagent assignment explicitly in the plan text itself (e.g. `**Subagent:** general-purpose` or `**Subagent:** code-reviewer`) — don't leave it implicit.
- Steps with no dependency on each other may run concurrently — call these out explicitly.

### Deviation handling

Every plan must state this explicitly in the plan text itself, in a prominent spot (top of the plan or its own short section) so subagents dispatched to execute steps see it too:

**Deviation rule:** If execution hits a situation that diverges from the plan or its assumptions, stop and ask the user for judgment before proceeding. Don't silently improvise, pick a fallback, or skip ahead.

### Confidence assessment

When presenting the plan, always include the following confidence metrics at the end of your proposal:

- **Confidence Score:** [0-100]% (100% means you highly recommend this as the absolute best approach; 0% means you have strong doubts about its effectiveness)
- **Reasoning:** [Briefly explain why you strongly recommend this plan, or what alternative paths/uncertainties kept it from being a 100% recommendation.]
