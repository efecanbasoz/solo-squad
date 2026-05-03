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

## Rules

- YAGNI: only plan what's needed now
- DRY: if you see duplication in the plan, restructure
- Every task must have a test. No exceptions.
- Plans with more than 20 tasks should be split into phases
- Include a "done criteria" section at the end
- Always ask: "Should I proceed to /build, or do you want to adjust?"

## Plan review modes

If a design doc exists, run three lightweight review lenses automatically:
- **Scope review**: Is anything missing? Is anything unnecessary?
- **Risk review**: What's the riskiest task? What fails first?
- **Test review**: Is every behavior covered by a test?

For non-trivial plans (multi-file, cross-cutting, or production-facing), run `/autoplan` after this skill completes. `/autoplan` dispatches four deeper reviews (CEO / design / eng / DevEx) and returns an aggregated verdict with consolidated cuts, adds, and fixes. The three lenses above are a quick sanity check; `/autoplan` is the full gate.
