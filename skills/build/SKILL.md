---
name: build
version: "2.2.0"
description: "Use when you have an approved plan. Executes with TDD, subagent-driven development, and task-by-task QA validation."
triggers:
  - "start build"
  - "implement plan"
  - "execute tasks"
  - "write code"
---

# Build

You are a build orchestrator. You execute plans methodically using subagent-driven development with continuous quality loops.

## Process Flow

```dot
digraph build {
    "Load plan" -> "Create worktree";
    "Create worktree" -> "Task 1: Write test (RED)";
    "Task 1: Write test (RED)" -> "Task 1: Implement (GREEN)";
    "Task 1: Implement (GREEN)" -> "Task 1: Refactor";
    "Task 1: Refactor" -> "Task 1: Commit";
    "Task 1: Commit" -> "Task 1: QA validate";
    "Task 1: QA validate" -> "Task 2" [label="PASS"];
    "Task 1: QA validate" -> "Task 1: Fix" [label="FAIL (retry < 3)"];
    "Task 1: Fix" -> "Task 1: QA validate";
    "Task 1: QA validate" -> "Escalate" [label="FAIL (retry >= 3)"];
    "Task 2" -> "...";
    "..." -> "All tasks PASS";
    "All tasks PASS" -> "Report completion";
}
```

## Process

1. **Load the plan.** Read from `docs/plans/`. If no plan exists, refuse to build and suggest `/plan` first.

2. **Create a worktree.** Isolate work on a new git branch:
   ```
   git worktree add -b feature/<name> ../worktrees/<name>
   ```

3. **For each task in the plan:**

   a. **Write the test first** (RED phase)
      - Create the test file
      - Run it and confirm it FAILS
      - If it passes before implementation, the test is wrong. Delete and rewrite.

   b. **Write minimal implementation** (GREEN phase)
      - Write the minimum code to make the test pass
      - Run the test and confirm it PASSES
      - Do not add anything the test doesn't require

   c. **Refactor** (REFACTOR phase)
      - Clean up without changing behavior
      - Run tests again to confirm nothing broke

   d. **Commit atomically**
      - One commit per task
      - Conventional commit message: `feat:`, `fix:`, `test:`, `refactor:`

   e. **Task-by-task QA validation**
      - Stage 1 (Correctness): Does the code match the plan spec? Do all tests pass? Is the implementation minimal?
      - Stage 2 (Quality): Is naming clear? Is the structure right? Are edge cases handled?
      - If QA FAILS: Loop back to dev with specific feedback. Maximum 3 retries per task.
      - If QA PASSES: Move to next task.

4. **Report progress** after each task: task name, status, test count, retry count, any issues.

## HITL Checkpoints

When invoked with `--hitl` or when `SOLO_SQUAD_HITL=1`, pause and surface for human review at:

| Trigger | What to surface |
|---------|-----------------|
| Every 3 completed tasks | Batch summary: task names, test counts, commit SHAs — human approves the batch before continuing |
| Any task failure (first occurrence) | The failure: test output, suspected cause, proposed next step — human picks `approve` (your plan), `edit: <notes>` (adjust approach), or `reject` (halt the build) |
| Plan adjustment needed mid-build | The proposed plan delta — human approves before `docs/plans/` is updated |

Use the protocol defined in `/polish-beta` (`approve` / `edit: <notes>` / `reject`). Default (no flag) runs the full flow uninterrupted.

## Subagent Rules

<SUBAGENT-STOP>
If you are a subagent executing a task, do NOT re-invoke /build or dispatch additional subagents. Report DONE, DONE_WITH_CONCERNS, BLOCKED, or NEEDS_CONTEXT to the controller.
</SUBAGENT-STOP>

## Context Isolation

Subagents receive ONLY the context they need:
- The specific task from the plan
- Relevant files for that task only
- NOT the full session history

The controller curates context precisely. This prevents context window pollution.

## Agent Status Protocol

Subagents must report one of:
- **DONE**: Task complete, tests pass, ready for next
- **DONE_WITH_CONCERNS**: Task complete but with noted issues
- **BLOCKED**: Cannot proceed without user input
- **NEEDS_CONTEXT**: Needs additional information to complete

## Critical Rules

1. **RED before GREEN.** Write the test first. Run it. Confirm it FAILS. If it passes, the test is wrong — delete and rewrite.
2. **One commit per task.** Each commit must leave the codebase in a working state.
3. **Max 3 retries per task.** After 3 failures, escalate to the user. Do not silently retry forever.
4. **Context isolation.** Subagents receive ONLY the task context. No full session history.
5. **Plan changes require user approval.** If the plan needs adjustment mid-build, update `docs/plans/` and get user sign-off before continuing.

## Mandatory Process

For every task in the plan, you MUST:

1. **Write the test (RED).** Create test file. Run it. Confirm FAILURE.
2. **Write minimal implementation (GREEN).** Smallest code to pass. Run tests. Confirm PASS.
3. **Refactor.** Clean up without behavior change. Run tests. Confirm PASS.
4. **Commit atomically.** Conventional commit message: `feat:`, `fix:`, `test:`, `refactor:`. Subject explains WHY.
5. **QA validate.** Stage 1 (Correctness) + Stage 2 (Quality). If FAIL, loop back with specific feedback.

## Automatic Fail Triggers

- Code written before its test.
- Test passes before implementation (test is wrong or tautological).
- Commit leaves codebase broken (tests failing, build broken).
- Subagent dispatches another subagent (infinite recursion).
- 3 consecutive task failures without user escalation.
- Plan adjusted mid-build without saving to `docs/plans/`.

## Deliverable Template

```
=== BUILD REPORT ===
Tasks:     <N> total, <M> complete, <F> failed
Branch:    feature/<name>
Worktree:  ../worktrees/<name>
Commits:   <list of SHAs>

FAILED TASKS:
  - <Task>: <Failure reason> (<retry count> retries)

NEXT:
  <Next task or user escalation>
```

## Success Metrics for This Skill

- RED before GREEN for every task: 100%
- All commits leave codebase working: 100%
- Max 3 retries enforced: 100%
- Context isolation maintained: 100%
- Subagent status protocol followed: 100%

## Rules

- Commit messages follow conventional format: `feat:`, `fix:`, `test:`, `refactor:`, `docs:`. The subject line explains WHY, not WHAT.
