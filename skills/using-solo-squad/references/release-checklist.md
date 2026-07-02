# Release Checklist Reference

Shared release-health checklist for `/ship`, `/land-and-deploy`, `/canary`, and `/document-release`. Each skill owns its phase, but they use the same evidence vocabulary to avoid drift.

## Phase gates

| Phase | Owner skill | Required evidence | Stop condition |
|---|---|---|---|
| PR readiness | `/ship` | Green tests, coverage summary, plan completion status, PR body | Failing tests, missing plan tasks, unreviewed blockers |
| Merge + deploy | `/land-and-deploy` | CI status, merge SHA, deploy URL, deploy status | Failing CI, deploy freeze, unknown deploy command, deploy timeout |
| Production canary | `/canary` | Critical flows, baseline metrics, canary metrics, evidence bundle | Unreachable critical flow, hard regression, missing baseline |
| Docs sync | `/document-release` | Diff scan, updated docs, changelog entry, stale screenshot list | Untested code examples, missing migration note, docs contradict release |

## Evidence bundle

Every release phase should preserve:

- branch, commit SHA, PR URL, and version/tag if available;
- commands run and their pass/fail status;
- deploy URL and observability links;
- canary decision and evidence location;
- documentation commits and known follow-ups.

## Ordering rules

1. `/ship` opens or updates the PR; it does not merge or deploy.
2. `/land-and-deploy` merges only after CI, review, and QA evidence are green.
3. `/canary` runs before post-release docs commits land.
4. `/document-release` updates docs only after the canary decision is `PROCEED` unless the change is docs-only.
5. Rollback recommendations are surfaced to a human; Solo Squad does not auto-execute rollback.
