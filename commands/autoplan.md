---
description: "Run the full plan review pipeline: CEO -> design -> eng -> DX in a single consolidated skill. Returns PROCEED, REVISE, or HALT with a consolidated issue list. Use after /plan, before /build."
---

Run `/plan-review` against the current plan draft.

`/plan-review` runs four lenses in sequence (CEO, Design, Eng, DevEx) and returns a single consolidated verdict:

**Verdicts:**
- **PROCEED** — All lenses pass. Plan is ready for `/build`.
- **REVISE** — Some lenses need fixes. Apply cuts/adds/fixes to `docs/plans/`, then re-run `/autoplan`.
- **HALT** — Fundamental flaw. Route back to `/brainstorm` or `/plan`.

## Short-circuit rule
If any lens returns its most severe verdict (HALT, BLOCK, REWRITE), halt immediately. Do not run subsequent lenses on a plan that has already failed a gate.

## When to use

- Always after a `/plan` draft on non-trivial work (multi-file, cross-cutting, or production-facing).
- Skip for hotfixes, docs-only changes, or single-file internal refactors — full review becomes overhead.
- Re-run after applying REVISE actions to confirm the plan is now PROCEED.

## Rules

- Lenses run in order: CEO → Design → Eng → DX. Scope failures caught early save time.
- Skip Design and DX lenses only when they explicitly return N/A. Never skip CEO or Eng.
- Aggregate with most severe verdict winning: any HALT → HALT; any REVISE → REVISE; all mild → PROCEED.
- Present consolidated action list in one place. Do not make the human reassemble from four outputs.
