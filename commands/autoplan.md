---
description: "Run the full plan review pipeline: CEO -> design -> eng -> DX. Aggregates four verdicts and returns PROCEED, REVISE, or HALT with a consolidated issue list. Use after /plan, before /build."
---

Run the four plan review skills in sequence against the current plan draft.

Pipeline:
1. /plan-ceo-review — Strategic scope challenge (CLEAR | TIGHTEN | TRIAGE | HALT)
2. /plan-design-review — Design dimension audit (PASS | REVISE | BLOCK) — skip if no user-facing surface
3. /plan-eng-review — Architecture & data flow lockdown (CLEAR | ISSUES | REWRITE)
4. /plan-devex-review — Developer experience analysis (PASS | TRIAGE | BLOCK) — skip if no tooling impact

Short-circuit rule: If any review returns its most severe verdict (HALT, BLOCK, REWRITE), halt the pipeline immediately and report. Do not run subsequent reviews on a plan that has already failed a gate.

## Aggregate verdict

After all applicable reviews run, aggregate:

- **PROCEED** — All reviews returned their mildest verdict (CLEAR / PASS). Plan is ready for /build.
- **REVISE** — At least one review returned a middle verdict (TIGHTEN / TRIAGE / REVISE / ISSUES). Plan proceeds after the listed cuts, adds, and fixes are applied to `docs/plans/`.
- **HALT** — At least one review returned its most severe verdict. Plan does not proceed. Route back to /brainstorm (for HALT) or /plan (for REWRITE, BLOCK).

## Output format

```
=== AUTOPLAN VERDICT ===
Overall: <PROCEED|REVISE|HALT>

CEO:    <verdict>  — <1-line rationale>
Design: <verdict>  — <1-line rationale or N/A>
Eng:    <verdict>  — <1-line rationale>
DevEx:  <verdict>  — <1-line rationale or N/A>

=== CONSOLIDATED ACTIONS ===
Cuts:  (from CEO TIGHTEN)
  - <task name>
Adds:  (from design REVISE, eng ISSUES, DX TRIAGE)
  - <task description>
Modifies:
  - <task> → <new shape>

=== NEXT STEP ===
<one sentence: proceed to /build, apply actions and re-run /autoplan, or return to /brainstorm>
```

## When to use

- Always after a `/plan` draft on non-trivial work (multi-file, cross-cutting, or any production-facing change).
- Skip for hotfixes, docs-only changes, or single-file internal refactors — the four reviews become overhead.
- Re-run after applying REVISE actions to confirm the plan is now PROCEED.

## Rules

- Run reviews in the declared order (CEO → design → eng → DX). Scope failures caught early save the other reviewers time.
- Skip design and DX reviews only when they explicitly return N/A. Never skip CEO or eng.
- Aggregate with the most severe verdict winning: any HALT → HALT; any REVISE → REVISE; all mild → PROCEED.
- Present the consolidated action list in one place. Do not make the human reassemble it from four review outputs.
