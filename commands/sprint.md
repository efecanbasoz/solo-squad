---
description: "Run the full engineering sprint: brainstorm -> plan -> build -> review -> qa -> ship -> compound"
---

Run the full engineering sprint sequence. Start with /brainstorm to refine the idea, then flow through each phase automatically, pausing for human approval between major phases.

Phases:
1. /brainstorm - Refine the idea (pause for approval)
2. /plan - Create implementation plan (pause for approval)  
3. /build - Execute with TDD and subagents
4. /review - Multi-lens code review
5. /qa - Browser-based testing
6. /ship - Push and open PR
7. /compound - Capture learnings

Between each phase, present a summary and ask: "Continue to [next phase]?"

If the user provides a design doc or plan as input, skip to the appropriate phase.
