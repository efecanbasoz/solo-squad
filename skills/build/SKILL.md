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

## Rules

- Never write code before its test
- If a test was written AFTER the code, delete the code, write the test, watch it fail, then rewrite
- Stop after 3 consecutive task failures and ask the user for help
- Each commit must leave the codebase in a working state
- If the plan needs adjustment mid-build, update `docs/plans/` before continuing
- Commit messages follow conventional format: `feat:`, `fix:`, `test:`, `refactor:`, `docs:`. The subject line explains WHY, not WHAT.
