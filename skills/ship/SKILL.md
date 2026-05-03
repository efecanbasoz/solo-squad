---
name: ship
version: "2.2.0"
description: Sync main, run tests, audit coverage, push, and open a PR.
triggers:
  - "ship code"
  - "open pr"
  - "release"
  - "deploy"
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

## HITL Checkpoints

When invoked with `--hitl` or when `SOLO_SQUAD_HITL=1`, pause and surface for human review at:

| After Step | What to surface |
|-----------|-----------------|
| 3 (coverage audit) | Coverage numbers — human approves if new-code coverage < 80% |
| 4 (plan completion check) | Missing tasks list (if any) — human approves override or halts ship |
| 6 (PR description drafted) | The drafted title and body — human approves, edits, or rejects before `gh pr create` runs |

Use the protocol defined in `/polish-beta` (`approve` / `edit: <notes>` / `reject`). Default (no flag) runs the full flow uninterrupted.

## Next step

Once the PR is open and reviewed, hand off to `/land-and-deploy` to merge, deploy, and verify production health. `/ship` stops at "PR open" — it does not merge, deploy, or monitor.

## Critical Rules

1. Never merge, deploy, or bypass CI from this skill — `/ship` opens PRs only.
2. If any test fails, halt immediately and report the failure — do not proceed to coverage audit.
3. New code without tests is untested code — flag every untested file and block the PR until covered or explicitly overridden.
4. The PR description is a contract with reviewers — draft it completely before opening the PR.
5. Context rot kills accuracy — steps 3–6 MUST run as subagents when the parent session exceeds 15K tokens.

## Mandatory Process

1. Sync `main` and verify no merge conflicts.
2. Run the full test suite — all tests MUST pass.
3. Audit test coverage for lines, branches, and new code; flag any untested files.
4. Verify plan completion if a plan file exists; block on missing tasks unless user overrides.
5. Sync docs — scan README, CHANGELOG, and API docs for stale references.
6. Draft the PR description using the hand-off pattern for large changesets.
7. Push the branch and open the PR with the drafted title and body.
8. Confirm the PR URL and link to the user before exiting.

## Automatic Fail Triggers

- Failing tests in the pre-flight suite.
- Coverage on new code drops below 80% without human override.
- Plan file exists but tasks are incomplete without explicit user approval.
- Stale docs reference removed or renamed APIs without an update applied.
- PR opened with an empty or auto-generated description (no hand-off draft).

## Deliverable Template

```markdown
## Ship Summary

- **Branch:** `<branch-name>`
- **PR:** `<pr-url>`
- **Tests:** `<pass/fail>` — `<count>` tests run
- **Coverage:** Lines `<pct>%` / Branches `<pct>%` / New Code `<pct>%`
- **Untested Files:** `<list or "None">`
- **Plan Completion:** `<complete/missing — list if missing>`
- **Docs Updated:** `<list or "No changes">`
- **PR Description:** `<inline or hand-off file path>`
```

## Success Metrics for This Skill

- 100% of shipped PRs pass CI before opening.
- 100% of new code has ≥80% test coverage or explicit HITL override.
- 100% of plan files are verified complete before PR creation.
- 100% of PR descriptions are human-drafted or subagent-drafted (never empty/auto-generated).
- 95% of ships open the PR on the first attempt without post-push edits.

## Rules

- Never ship with failing tests.
- If coverage drops below baseline, add tests first.
- Ship opens the PR. Land-and-deploy closes the loop. Do not merge from this skill.
