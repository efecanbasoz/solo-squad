---
description: "Fast-track a critical fix: investigate -> fix -> review -> ship. Skips brainstorm and planning."
---

Emergency fix workflow. Skip ceremony, maintain quality.

1. /investigate - Find root cause (auto-freeze to affected module)
2. Write failing test reproducing the bug
3. Apply minimal fix, verify test passes
4. /review - Quick review (security + correctness only)
5. /ship - Push with [hotfix] prefix in PR title

## Critical Rules

1. Touch exactly one system per hotfix; scope creep is prohibited.
2. Every hotfix must include a regression test that fails before the fix and passes after.
3. The investigation phase must complete before any code change is written.
4. Use the `/freeze` skill to lock edits to the affected module during investigation.
5. Hotfixes skip planning and brainstorming, but never skip review and testing.

## Mandatory Process

1. MUST reproduce the bug locally or in a test before writing any fix.
2. MUST run the full test suite for the affected module after the fix.
3. MUST open a PR with `[hotfix]` prefix and `hotfix` label.
4. MUST request at least one reviewer focused on security and correctness.
5. MUST verify the fix in a staging or preview environment before merging.
6. MUST document the root cause in the PR description for post-mortem reference.

## Automatic Fail Triggers

- The PR changes more than one logical system or feature area.
- No regression test is included with the fix.
- The fix is merged without passing review or CI checks.
- The bug cannot be reproduced before the fix is applied.
- Secrets, credentials, or environment-specific values are committed in the diff.

## Deliverable Template

```markdown
## Hotfix Report

- **Issue:** [Brief description of the bug]
- **Root Cause:** [What caused it]
- **Affected Module:** [Module/file path]
- **Fix Summary:** [One-line description of the change]
- **Regression Test:** [Test file and case name]
- **Verification:** [Staging/preview result]
- **PR:** [Link to hotfix PR]
```

## Success Metrics for This Skill

- 100% of hotfixes include a regression test.
- 100% of hotfixes pass module-level test suites before merge.
- 100% of hotfixes are tagged with the `hotfix` label.
- 95% of hotfixes are merged within 4 hours of issue identification.
- 0% of hotfixes introduce new critical or high-severity bugs.

## Rules

- Hotfixes touch ONE thing. If you find other issues, log them for later.
- The fix must have a regression test. No exceptions, even for hotfixes.
- Auto-tag the PR with "hotfix" label.
