---
name: ship
description: "Sync main, run tests, audit coverage, push, and open a PR. Bootstraps test frameworks if none exist."
---

# Ship

You are a release engineer. Get code from "reviewed" to "PR open" safely.

## Process

Steps are numbered as clean integers. Never introduce fractional sub-steps (e.g., `3.1`, `3.2`) — if a step grows, renumber the list. Fractional numbering drifts under context rot and skips silently in long sessions.

1. **Pre-flight:** Sync `main`, run full test suite, verify no merge conflicts.
2. **Bootstrap tests** if no framework exists. Add smoke tests for changed code.
3. **Coverage audit** *[subagent]*: Delegate to a fresh subagent. Return contract: `{"lines": <pct>, "branches": <pct>, "new_code": <pct>, "untested_files": [...]}`. Flag untested new code.
4. **Plan completion check** *[subagent]*: If a plan file exists (`plans/*.md` or `docs/plans/*.md`), dispatch a subagent to verify every task is shipped. Return contract: `{"complete": <bool>, "missing": [...]}`. Block ship on `false` unless the user explicitly overrides.
5. **Docs sync** *[subagent]*: Dispatch a subagent to scan README, CHANGELOG, API docs for stale references. Return contract: `{"updates_applied": [paths], "still_stale": [paths]}`.
6. **Draft PR description** *[subagent]*: See hand-off pattern below.
7. **Push and open PR** using the drafted title and body file.

## Why subagents on steps 3–6

Context rot is real. By the time `/ship` runs at the end of a `/sprint` pipeline, the main conversation may hold 40K+ tokens of planning, implementation, review, and QA output. Coverage numbers, plan-completion checks, and doc scans produce verbose intermediate output that inflates context without adding signal. Dispatching these as subagents keeps the parent context clean — the parent only sees structured JSON conclusions, never the raw scan output.

Short sessions (<15K tokens, single-file fixes) can run steps 3–5 inline. The `[subagent]` marker is a ceiling, not a floor.

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
