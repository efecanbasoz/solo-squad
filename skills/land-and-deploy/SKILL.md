---
name: land-and-deploy
version: "2.2.0"
description: Merge the PR, trigger the deploy, and verify production health end-to-end.
triggers:
  - "merge deploy"
  - "deploy production"
  - "go live"
---

# Land and Deploy

You own the PR from "approved" to "confirmed healthy in production." This skill runs after `/ship` opens the PR and review is complete. It chains merge, deploy trigger, canary verification, and documentation into one flow with a single rollback seam.

## When to run

- After `/ship` opens a PR and the review is approved.
- When merging release branches that have passed CI, review, and QA.
- Not for emergency rollbacks — use `/incident-response` instead.

## Process

1. **Final gate.** Before merging, confirm:
   - All required CI checks are green
   - All review blockers are resolved
   - The target branch (usually `main` or `production`) is not under a deploy freeze
   - If any check fails, halt and report — do not merge.
2. **Merge.** Use the project's preferred merge strategy (squash, rebase, or merge commit — read from `CONTRIBUTING.md` or repo settings). Apply the final PR title as the commit subject.
3. **Trigger deploy.** For repos with auto-deploy on merge (Vercel, Netlify, GitHub Actions → platform), wait for the deploy event. For manual deploys, dispatch the deploy command read from `docs/deploy.md` or the project's deploy runbook.
4. **Watch the deploy.** Track the deploy until it reaches `READY` or equivalent. Timeout: 15 minutes. On failure, trigger `/incident-response` with the build logs and deploy URL.
5. **Run `/canary`.** Hand off to the canary skill with the new deploy URL. Return contract from canary: `PROCEED | HOLD | ROLLBACK`.
   - `PROCEED` → continue to step 6
   - `HOLD` → pause; surface canary evidence and wait for human call
   - `ROLLBACK` → recommend revert command, do not execute, trigger `/incident-response`
6. **Run `/document-release`.** Update CHANGELOG, README, and affected docs. Commit the doc updates to `main` as a follow-up `docs: post-release notes for vX.Y.Z` commit.
7. **Announce.** Post a release summary:
   - Version / commit SHA / deploy URL
   - Canary decision + evidence link
   - Docs commits
   - Known follow-ups (from `/document-release` TODO output)

## Critical Rules

1. Never merge past a failing required check — CI is the source of truth, admin override is forbidden.
2. Never auto-execute a rollback — recommend and trigger `/incident-response`, but let a human decide.
3. If the deploy platform or command is unknown, halt and ask — do not guess or assume.
4. Documentation commits land ONLY after canary returns `PROCEED` — never before.
5. Every decision must be logged with timestamp, evidence, and next action before advancing.

## Mandatory Process

1. Confirm all required CI checks are green and all review blockers are resolved.
2. Verify the target branch is not under a deploy freeze.
3. Merge using the project's preferred strategy with a clean final commit title.
4. Trigger or wait for the deploy event; track until `READY` or timeout (15 min).
5. Run `/canary` on the new deploy URL and capture the decision (`PROCEED` / `HOLD` / `ROLLBACK`).
6. If canary returns `PROCEED`, run `/document-release` and commit doc updates to `main`.
7. Post the release summary with version, URL, canary evidence, docs commits, and known follow-ups.
8. If canary returns `HOLD`, pause and surface evidence; if `ROLLBACK`, trigger `/incident-response`.

## Automatic Fail Triggers

- Merging with any failing required CI check.
- Deploy timeout exceeds 15 minutes without status update.
- Canary returns `ROLLBACK` and the skill continues without triggering `/incident-response`.
- Doc commits pushed before canary completes or on a `HOLD`/`ROLLBACK` decision.
- Missing observability — any step advanced without logging decision, timing, and evidence.

## Deliverable Template

```markdown
## Land and Deploy Summary

- **PR:** `<pr-url>` → **Merged:** `<commit-sha>`
- **Deploy URL:** `<url>` — **Status:** `<ready/failed/timeout>`
- **Canary Decision:** `<PROCEED/HOLD/ROLLBACK>` — **Evidence:** `<link or notes>`
- **Doc Commits:** `<list or "Skipped — canary did not pass">`
- **Release Summary:** `<pasted to channel or link>`
- **Follow-ups:** `<list or "None">`
- **Rollback Command (if needed):** `<git revert / rollback command>`
```

## Success Metrics for This Skill

- 100% of merges pass all required CI checks with zero admin overrides.
- 100% of deploys are tracked to `READY` or explicitly timed out and escalated.
- 100% of canary decisions are captured with evidence before proceeding to docs.
- 100% of doc commits land after canary `PROCEED` — never before.
- 95% of releases complete end-to-end (merge → deploy → canary → docs → announce) without human intervention.

## Rules

- Never merge past a failing required check, even with admin override — CI is the source of truth.
- Never auto-execute a rollback. Rollback is a human decision; this skill recommends, it does not act.
- Every step is observable: log the decision, timing, and next action before moving on.

## Deliverables

- Merged PR with a clean final title and commit subject
- Deploy confirmation with URL and version
- Canary decision with full evidence reference
- Documentation commit (CHANGELOG + affected files)
- Release summary suitable for pasting into Slack, Discord, or release notes
