---
description: "Fast-track a critical fix: investigate -> fix -> review -> ship. Skips brainstorm and planning."
---

Emergency fix workflow. Skip ceremony, maintain quality.

1. /investigate - Find root cause (auto-freeze to affected module)
2. Write failing test reproducing the bug
3. Apply minimal fix, verify test passes
4. /review - Quick review (security + correctness only)
5. /ship - Push with [hotfix] prefix in PR title

Rules:
- Hotfixes touch ONE thing. If you find other issues, log them for later.
- The fix must have a regression test. No exceptions, even for hotfixes.
- Auto-tag the PR with "hotfix" label.
