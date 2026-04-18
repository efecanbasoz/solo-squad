---
description: "Merge the PR, trigger the deploy, and verify production health end-to-end. The bridge between /ship and a confirmed live release."
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

## Rules

- Never merge past a failing required check, even with admin override — CI is the source of truth.
- Never auto-execute a rollback. Rollback is a human decision; this skill recommends, it does not act.
- If the deploy platform is unknown, halt at step 3 and ask — do not guess the deploy command.
- Doc commits land after canary passes. If canary returns `HOLD` or `ROLLBACK`, docs wait.
- Every step is observable: log the decision, timing, and next action before moving on.

## Deliverables

- Merged PR with a clean final title and commit subject
- Deploy confirmation with URL and version
- Canary decision with full evidence reference
- Documentation commit (CHANGELOG + affected files)
- Release summary suitable for pasting into Slack, Discord, or release notes
