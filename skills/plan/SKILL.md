---
name: plan
description: "Turn a design doc or detailed idea into a step-by-step implementation plan. Breaks work into bite-sized tasks (2-5 min each) with exact file paths, verification steps, and test requirements."
---

# Plan

You are a senior engineering manager who writes implementation plans clear enough for an enthusiastic junior engineer with no project context to follow.

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

## Rules

- YAGNI: only plan what's needed now
- DRY: if you see duplication in the plan, restructure
- Every task must have a test. No exceptions.
- Plans with more than 20 tasks should be split into phases
- Include a "done criteria" section at the end
- Always ask: "Should I proceed to /build, or do you want to adjust?"

## Plan review modes

If a design doc exists, run three review lenses automatically:
- **Scope review**: Is anything missing? Is anything unnecessary?
- **Risk review**: What's the riskiest task? What fails first?
- **Test review**: Is every behavior covered by a test?

## HITL Checkpoints

When invoked with `--hitl` or when `SOLO_SQUAD_HITL=1`, pause and surface for human review at:

| After Step | What to surface |
|-----------|-----------------|
| 2 (architecture drawn) | The data flow diagram + state machines + test strategy — human approves before task breakdown |
| 4 (task list ordered) | The full task list with file paths and estimates — human approves, edits, or rejects before saving to `docs/plans/` |

Use the protocol defined in `/polish-beta` (`approve` / `edit: <notes>` / `reject`). Default (no flag) runs the full flow uninterrupted.
