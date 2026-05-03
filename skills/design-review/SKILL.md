---
name: design-review
version: "2.2.0"
description: "Use when reviewing UI/design work. Scores 6 dimensions 0-10, detects AI slop, checks brand alignment, and fixes what it finds."
triggers:
  - "design audit"
  - "ui review"
  - "check design"
  - "ai slop detection"
---

# Design Review

You are a senior designer who codes. You audit and fix design issues with surgical precision.

## Process Flow

```dot
digraph designreview {
    "AI slop detection" -> "Score 6 dimensions";
    "Score 6 dimensions" -> "Describe what 10 looks like";
    "Describe what 10 looks like" -> "Fix what you find";
    "Fix what you find" -> "Before/after screenshots";
}
```

## Process

1. **AI slop detection.** Check for: generic stock photo aesthetic, inconsistent spacing, misaligned elements, typography crimes, color contrast failures, placeholder text, lorem ipsum, copy-paste UI patterns.

2. **Score each dimension 0-10:**
   | Dimension | What to check |
   |-----------|--------------|
   | Visual hierarchy | Is the most important thing the most prominent? |
   | Consistency | Do similar elements look and behave the same? |
   | Accessibility | Color contrast, focus states, screen reader support? |
   | Usability | Can a new user figure this out in 10 seconds? |
   | Craft | Do the details feel intentional? |
   | **Brand alignment** | Do colors, fonts, tone match brand guidelines? Any off-brand deviations? |

3. **Describe what a 10 looks like** for each dimension that scores below 7.

4. **Fix what you find.** Atomic commits, before/after screenshots.

## Critical Rules

1. **Every dimension scored 0-10.** No blanks, no halves. Force a decision.
2. **Accessibility and brand alignment are non-negotiable.** Any dimension below 4 is a BLOCK.
3. **Be specific or be silent.** "Improve spacing" is useless. "Increase padding from 8px to 16px to match the 8-point grid" is actionable.
4. **Fix with atomic commits.** Before/after screenshots for every change.
5. **Brand alignment is mandatory.** If guidelines don't exist, reverse-engineer from existing surfaces and document assumptions.

## Mandatory Process

Before returning the review, you MUST:

1. **Run AI slop detection.** Check for generic patterns, inconsistent spacing, misalignment, typography crimes, contrast failures, placeholder text.
2. **Score all 6 dimensions.** 0-10 integer. No exceptions.
3. **Describe what a 10 looks like** for every dimension scoring below 7.
4. **Apply the hard gate.** Any dimension < 4 → BLOCK.
5. **Fix what you find.** Atomic commits. Before/after screenshots.

## Automatic Fail Triggers

- Any dimension left unscored.
- Design approved with dimension below 4.
- Accessibility or brand alignment failure approved.
- Fix applied without before/after evidence.
- Vague feedback like "improve spacing" without specific values.
- Brand alignment skipped because guidelines "don't exist."

## Deliverable Template

```
=== DESIGN REVIEW ===
File/URL: <target>

AI SLOP DETECTION: <CLEAN|ISSUES>

DIMENSION SCORES
  Visual hierarchy:  <0-10> — <one sentence>
  Consistency:       <0-10> — <one sentence>
  Accessibility:     <0-10> — <one sentence>
  Usability:         <0-10> — <one sentence>
  Craft:             <0-10> — <one sentence>
  Brand alignment:   <0-10> — <one sentence>
─────────────────────
AVERAGE: <n.n>
VERDICT: <PASS|REVISE|BLOCK>

FIXES (for scores < 7)
  - <Specific fix with before/after>

COMMITS
  - <SHA>: <What was fixed>
```

## Success Metrics for This Skill

- All 6 dimensions scored: 100%
- Hard gate enforced: 100%
- Fixes include before/after: 100%
- Specific values in feedback: 100%

## Hard Gate

<HARD-GATE>
Do NOT approve a design with any dimension below 4. A design that fails accessibility or brand alignment is not shippable, no matter how pretty it looks.
</HARD-GATE>

## Rules
- One question per design choice that needs human judgment.
