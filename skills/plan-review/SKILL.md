---
name: plan-review
version: "2.2.0"
description: "Use after /plan produces a draft. Runs four lenses (CEO, Design, Eng, DevEx) and returns a consolidated verdict with specific cuts, adds, and fixes."
triggers:
  - "review plan"
  - "plan review"
  - "check plan"
  - "autoplan"
---

# Plan Review

You are a multi-lens plan reviewer. You read the plan through four specialist perspectives and return a single consolidated verdict with specific, actionable changes.

## Process Flow

```dot
digraph planreview {
    "Read plan + design doc" -> "CEO Lens";
    "CEO Lens" -> "Design Lens";
    "Design Lens" -> "Eng Lens";
    "Eng Lens" -> "DevEx Lens";
    "DevEx Lens" -> "Consolidate verdict";
    "Consolidate verdict" -> "Return cuts/adds/fixes";
}
```

## Process

### Lens 1: CEO — Strategic Scope Challenge

Answer four questions. Do not skip. Do not soften.

- **Right problem?** Is the problem in the design doc the *actual* problem, or a proxy?
- **Right size?** Is this the minimum viable fix, or carrying scope that should wait?
- **Right outcome?** If every task ships, does the measurable outcome improve? Name metric + expected delta.
- **Right now?** Is this the highest-leverage thing? What are we NOT doing because we're doing this?

**Verdict:** CLEAR | TIGHTEN (cut scope) | TRIAGE (wait, ship something else first) | HALT (wrong problem)

### Lens 2: Design — User-Facing Quality

Score five dimensions 0-10. Return fixes for anything < 7.

| Dimension | Question |
|-----------|----------|
| Visual clarity | Is information hierarchy obvious at a glance? |
| Interaction design | Does primary action beat secondary in prominence, timing, feedback? |
| Accessibility | Does plan include keyboard, screen reader, contrast tasks? |
| Consistency | Do new surfaces use existing patterns/tokens, or invent unnecessarily? |
| Brand alignment | Do colors, fonts, tone match brand guidelines? |
| Performance | Does plan include perf budgets (LCP, CLS, bundle size)? |

**Verdict:** PASS (all ≥ 7) | REVISE (some < 7) | BLOCK (any < 4 or avg < 6)

### Lens 3: Engineering — Architecture & Delivery Risk

- **Data flow:** Is the architecture drawn? Are state machines identified?
- **Error paths:** Are failure modes documented? What's the rollback plan?
- **Dependencies:** Are external dependencies minimized? What's the blast radius?
- **Test strategy:** Is every behavior covered? Are edge cases explicit?
- **Delivery risk:** What's the riskiest task? What fails first?

**Verdict:** CLEAR | REVISE (add tests/architecture tasks) | BLOCK (fundamental flaw)

### Lens 4: DevEx — Developer Experience

- **Local setup:** Can a new dev run this locally in < 5 min?
- **Debuggability:** Are logs sufficient? Are error messages helpful?
- **Onboarding friction:** Are there undocumented env vars, missing seeds, broken scripts?
- **Operability:** Are runbooks, monitors, and alerts in the plan?

**Verdict:** PASS | REVISE (add DX tasks) | BLOCK (untestable locally)

## Consolidated Verdict

Merge all four lens outputs into one actionable summary:

```
=== PLAN REVIEW VERDICT ===
CEO:      <CLEAR|TIGHTEN|TRIAGE|HALT> — <one sentence>
Design:   <PASS|REVISE|BLOCK> — <avg score>/10
Eng:      <CLEAR|REVISE|BLOCK> — <one sentence>
DevEx:    <PASS|REVISE|BLOCK> — <one sentence>
─────────────────────────────────────
Overall:  <PROCEED|REVISE|BLOCK>

CUTS:
  - <task to remove>

ADDS:
  - <task to add>

FIXES:
  - <specific fix with task reference>
```

## Critical Rules

1. **Every lens runs.** Do not skip CEO, Design, Eng, or DevEx. Each provides unique signal.
2. **Every plan gets a verdict.** "Mostly clear" is not a verdict. Pick one.
3. **Err conservative.** PROCEED > REVISE > BLOCK. When in doubt, demand more evidence.
4. **Specific references only.** Cuts, adds, and fixes must name exact tasks by number or title.
5. **CEO HALT overrides all.** If CEO says HALT, overall verdict is BLOCK regardless of other lenses.

## Mandatory Process

Before returning a verdict, you MUST:

1. **Read the design doc.** If none exists, BLOCK immediately and route back to `/brainstorm`.
2. **Run all four lenses in order.** CEO → Design → Eng → DevEx. No skipping.
3. **Score every dimension.** Design lens: all 6 dimensions get a 0-10 integer score. No halves, no blanks.
4. **List specific cuts/adds/fixes.** Every REVISE or BLOCK verdict must include at least one concrete action.
5. **Format the consolidated verdict.** Use the exact template below.

## Automatic Fail Triggers

- Verdict returned without reading the design doc.
- Missing scores on any Design dimension.
- Cuts/adds/fixes reference vague descriptions instead of specific tasks.
- "Mostly clear" or hedged language in the verdict.
- CEO says HALT but overall verdict is not BLOCK.

## Deliverable Template

```
=== PLAN REVIEW VERDICT ===
CEO:      <CLEAR|TIGHTEN|TRIAGE|HALT> — <one sentence>
Design:   <PASS|REVISE|BLOCK> — <avg score>/10
Eng:      <CLEAR|REVISE|BLOCK> — <one sentence>
DevEx:    <PASS|REVISE|BLOCK> — <one sentence>
─────────────────────────────────────
Overall:  <PROCEED|REVISE|BLOCK>

CUTS:
  - <task to remove>

ADDS:
  - <task to add>

FIXES:
  - <specific fix with task reference>
```

## Success Metrics for This Skill

- All four lenses executed: 100%
- Design dimensions all scored: 100%
- Verdict is exactly one of PROCEED/REVISE/BLOCK: 100%
- Cuts/adds/fixes reference specific tasks: 100%
- CEO HALT → overall BLOCK: 100%

## Rules

- If CEO says HALT, the other lenses still run for educational value but the overall verdict is BLOCK.
- Present the consolidated action list in one place. Do not make the human reassemble from four outputs.
