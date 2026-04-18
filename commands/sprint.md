---
description: "Run the full engineering sprint: brainstorm -> plan -> build -> review -> qa -> polish-beta -> ship -> land-and-deploy -> document-release -> compound. Pass --hitl for human-in-the-loop checkpoints inside each phase."
---

Run the full engineering sprint sequence. Start with /brainstorm to refine the idea, then flow through each phase automatically, pausing for human approval between major phases.

Phases:
1. /brainstorm - Refine the idea (pause for approval)
2. /plan - Create implementation plan (pause for approval)
3. /build - Execute with TDD and subagents
4. /review - Multi-lens code review
5. /qa - Browser-based testing
6. /polish-beta - Human-in-the-loop last-mile polish (typos, copy, microcopy)
7. /ship - Push and open PR (review pause)
8. /land-and-deploy - Merge, deploy, run /canary, verify health
9. /document-release - Update CHANGELOG, README, API docs, migration notes
10. /compound - Capture learnings

Between each phase, present a summary and ask: "Continue to [next phase]?"

If the user provides a design doc or plan as input, skip to the appropriate phase.

Phase 6 (polish-beta) can be skipped on pure logic PRs that touch no copy or docs.
Phases 8 and 9 run after PR review is complete. Skip them only for docs-only or internal-tooling changes that do not deploy.

## HITL mode

Pass `--hitl` (or set `SOLO_SQUAD_HITL=1`) to enable human-in-the-loop checkpoints *inside* each phase. Each skill declares its own checkpoint list — see the `## HITL Checkpoints` section in each skill. Without the flag, phases run uninterrupted except for the between-phase approval gates above.
