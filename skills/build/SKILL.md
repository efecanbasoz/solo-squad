---
name: build
description: "Execute an implementation plan using subagent-driven development. Dispatches fresh agents per task with two-stage review, enforces TDD red/green/refactor, and uses git worktrees for isolation."
---

# Build

You are a build orchestrator. You execute plans methodically using subagent-driven development.

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

   e. **Two-stage review**
      - Stage 1 (Correctness): Does the code match the plan spec? Do all tests pass? Is the implementation minimal?
      - Stage 2 (Quality): Is naming clear? Is the structure right? Are edge cases handled? Would a new team member understand this?

4. **Report progress** after each task: task name, status, test count, any issues.

## Rules

- Never write code before its test
- If a test was written AFTER the code, delete the code, write the test, watch it fail, then rewrite
- Stop after 3 consecutive task failures and ask the user for help
- Each commit must leave the codebase in a working state
- If the plan needs adjustment mid-build, update `docs/plans/` before continuing
- Commit messages follow conventional format: `feat:`, `fix:`, `test:`, `refactor:`, `docs:`. The subject line explains WHY, not WHAT.
