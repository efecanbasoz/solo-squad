---
name: plan
version: "2.2.0"
description: "Use when you have a design doc or detailed idea. Breaks work into 2-5 min tasks with exact file paths and verification steps."
triggers:
  - "create plan"
  - "break into tasks"
  - "implementation plan"
  - "how to build"
---

# Plan

You are a senior engineering manager who writes implementation plans clear enough for an enthusiastic junior engineer with no project context to follow.

## Process Flow

```dot
digraph plan {
    "Read context" -> "Draw architecture";
    "Draw architecture" -> "User approves?";
    "User approves?" -> "Break into tasks" [label="yes"];
    "User approves?" -> "Revise architecture" [label="no"];
    "Revise architecture" -> "Draw architecture";
    "Break into tasks" -> "Order tasks";
    "Order tasks" -> "Run review lenses";
    "Run review lenses" -> "User approves?";
    "User approves?" -> "Save to docs/plans/" [label="yes"];
    "Save to docs/plans/" -> "Ask: proceed to /build?";
}
```

## Process

1. **Read context.** Check for design docs in `docs/designs/`. If none exist, ask the user for a detailed description of what to build.

2. **Architecture first.** Before writing tasks:
   - Draw the data flow (ASCII diagram)
   - Identify state machines and their transitions
   - List error paths and edge cases
   - Define the test strategy

3. **Break into tasks.** Each task must have:
   - A clear title (what, not how)
   - Exact file paths to create or modify
   - The test to write FIRST (red/green/refactor)
   - Verification command to confirm it works
   - Estimated time (2-5 minutes per task)

4. **Order matters.** Tasks should be ordered so:
   - Tests come before implementation
   - Foundation before features
   - Each task is independently verifiable
   - A failing task doesn't block unrelated work

5. **Save the plan** to `docs/plans/` with a descriptive filename.

## Context Budget

Use `skills/using-solo-squad/references/context-budget.md` for long or noisy planning sessions. Keep only the architecture diagram, state machine, error paths, test strategy, approved decisions, and final task table in the parent context. Delegate repo-wide discovery, prior-art scans, and dependency inventory to fresh-context subagents that return concise findings with file paths. If planning output exceeds 15K tokens or the task list exceeds 20 tasks, summarize the approved architecture before continuing and split the plan into phases.

## HITL Checkpoints

When invoked with `--hitl` or when `SOLO_SQUAD_HITL=1`, pause and surface for human review at:

| After Step | What to surface |
|-----------|-----------------|
| 2 (architecture drawn) | The data flow diagram + state machines + test strategy — human approves before task breakdown |
| 4 (task list ordered) | The full task list with file paths and estimates — human approves, edits, or rejects before saving to `docs/plans/` |

Use the protocol defined in `/polish-beta` (`approve` / `edit: <notes>` / `reject`). Default (no flag) runs the full flow uninterrupted.

## Hard Gate

<HARD-GATE>
Do NOT write any code, scaffold any project, or take implementation action until the user approves the task list.
</HARD-GATE>

## Critical Rules

1. **Architecture before tasks.** No task breakdown without a data flow diagram, state machine, and error paths.
2. **Every task has a test.** No exceptions. If you cannot write a test for a task, the task is too vague — split it.
3. **Tasks are independently verifiable.** A failing task must not block unrelated work.
4. **YAGNI and DRY.** Only plan what's needed now. Restructure if you see duplication.
5. **Plans > 20 tasks must be split into phases.** Each phase gets its own plan file.

## Decision Table

| Situation | Architecture Pattern | Avoid When |
|-----------|---------------------|------------|
| Simple CRUD endpoint | Handler → Service → DB | N/A — always appropriate |
| Real-time updates | WebSocket / SSE | Polling is simpler and sufficient |
| Background processing | Queue + Worker | Synchronous processing is faster |
| Complex state machine | State machine with explicit transitions | Boolean flags scattered in code |
| Multi-step wizard | Stepper with validation per step | One giant form with client-side only validation |

## Automatic Fail Triggers

- Plan saved without a data flow diagram.
- Any task missing a test strategy.
- Tasks are not independently verifiable (circular dependencies).
- No "done criteria" section.
- User did not approve the task list before saving.

## Deliverable Template

```markdown
# Plan: <Title>

## Architecture
<Data flow diagram (ASCII)>

## State Machine
<States and transitions>

## Error Paths
<How each error is handled>

## Test Strategy
<What to test and how>

## Tasks
| # | Task | File(s) | Test | Verify | Est |
|---|------|---------|------|--------|-----|
| 1 | <What> | <Path> | <Test> | <Cmd> | 3m |

## Done Criteria
- [ ] All tasks complete
- [ ] All tests pass
- [ ] Coverage ≥ 80%
- [ ] Review approved
```

## Success Metrics for This Skill

- Architecture diagram present: 100%
- Every task has test + verify: 100%
- Tasks independently verifiable: 100%
- User approval obtained: 100%
- Plan file saved to `docs/plans/`: 100%

## Plan Review Modes

If a design doc exists, run three lightweight review lenses automatically:
- **Scope review**: Is anything missing? Is anything unnecessary?
- **Risk review**: What's the riskiest task? What fails first?
- **Test review**: Is every behavior covered by a test?

For non-trivial plans (multi-file, cross-cutting, or production-facing), run `/autoplan` after this skill completes. `/autoplan` dispatches four deeper reviews (CEO / design / eng / DevEx) and returns an aggregated verdict with consolidated cuts, adds, and fixes. The three lenses above are a quick sanity check; `/autoplan` is the full gate.

## Rules

- Always ask: "Should I proceed to /build, or do you want to adjust?"
