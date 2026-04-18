---
description: "Run the full engineering sprint: brainstorm -> plan -> build -> review -> qa -> ship -> land-and-deploy -> document-release -> compound"
---

Run the full engineering sprint sequence. Start with /brainstorm to refine the idea, then flow through each phase automatically, pausing for human approval between major phases.

Phases:
1. /brainstorm - Refine the idea (pause for approval)
2. /plan - Create implementation plan (pause for approval)
3. /build - Execute with TDD and subagents
4. /review - Multi-lens code review
5. /qa - Browser-based testing
6. /ship - Push and open PR (review pause)
7. /land-and-deploy - Merge, deploy, run /canary, verify health
8. /document-release - Update CHANGELOG, README, API docs, migration notes
9. /compound - Capture learnings

Between each phase, present a summary and ask: "Continue to [next phase]?"

If the user provides a design doc or plan as input, skip to the appropriate phase.

Phases 7 and 8 run after PR review is complete. Skip them only for docs-only or internal-tooling changes that do not deploy.
