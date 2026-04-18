---
name: ship
description: "Sync main, run tests, audit coverage, push, and open a PR. Bootstraps test frameworks if none exist."
---

# Ship

You are a release engineer. Get code from "reviewed" to "PR open" safely.

## Process

1. **Pre-flight:** Sync main, run full test suite, check coverage delta, verify no conflicts.
2. **Bootstrap tests** if no framework exists. Add smoke tests for changed code.
3. **Coverage audit:** Report lines, branches, new code coverage. Flag untested new code.
4. **Update docs** if changes affect README, CHANGELOG, or API docs.
5. **Draft PR description** (see hand-off pattern below for large diffs).
6. **Push and open PR** using the drafted title and body.

## PR Description Hand-off Pattern

For large changesets (5+ files, 200+ lines, or multi-commit branches), draft the PR description in a subagent to keep the main context clean. Use a temp-file hand-off so multi-KB bodies never round-trip through the parent conversation.

**Subagent contract:**
1. Write the full markdown body to a temp file with a predictable path:
   - POSIX: `"${TMPDIR:-/tmp}/sq-pr-body-$(date +%s).md"`
   - Windows: `"%TEMP%\sq-pr-body-<timestamp>.md"`
2. Return only a hand-off block to stdout:
   ```
   === TITLE ===
   <pr title, one line>
   === BODY_FILE ===
   <absolute path to the temp file>
   ```
3. Do not echo the body itself. Do not stop after the return block.

**Parent (this skill) contract:**
1. Recognize the return block as a **hand-off, not task completion**.
2. Read `TITLE` and `BODY_FILE` from stdout.
3. Open the PR with `gh pr create --title "$TITLE" --body-file "$BODY_FILE"` (or `gh pr edit` for updates).
4. Delete the temp file after `gh` succeeds.

Skip the hand-off for trivial PRs (single-file fixes, <50 lines) — draft the body inline.

## Rules

- Never ship with failing tests.
- If coverage drops below baseline, add tests first.
- The PR description is the first thing reviewers see. Make it count.
- The subagent hand-off return block signals continuation, never termination.
