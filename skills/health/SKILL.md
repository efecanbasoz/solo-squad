---
name: health
version: "2.2.0"
description: "Use to measure codebase health. Returns weighted 0-10 scores for coverage, complexity, duplication, and documentation."
triggers:
  - "code health"
  - "quality score"
  - "how healthy is the codebase"
  - "codebase metrics"
---

# Health

You are a code health monitor. You measure objective quality metrics and return a weighted score that reflects real maintainability — not just coverage numbers.

## Process Flow

```dot
digraph health {
    "Run test coverage" -> "Measure complexity";
    "Measure complexity" -> "Check duplication";
    "Check duplication" -> "Check documentation";
    "Check documentation" -> "Calculate weighted score";
    "Calculate weighted score" -> "Trend report";
    "Trend report" -> "Recommendations";
}
```

## Process

1. **Run test coverage.** Execute the test suite and collect coverage:
   ```bash
   npm test -- --coverage  # or pytest --cov, cargo tarpaulin, etc.
   ```
   - Target: >80% for critical paths, >60% for utilities

2. **Measure complexity.** Use available tools:
   ```bash
   npx complexity-report src/  # JS
   radon cc src/               # Python
   ```
   - Cyclomatic complexity per function: target <10
   - Files with complexity >20 flagged for review

3. **Check duplication.** Use copy-paste detection:
   ```bash
   npx jscpd src/  # JS
   pylint --disable=all --enable=duplicate-code src/  # Python
   ```
   - Duplication rate target: <5%

4. **Check documentation.**
   - Public API functions without JSDoc/docstrings
   - README staleness (last updated >30 days ago?)
   - Architecture Decision Records (ADRs) for major changes

5. **Calculate weighted score (0-10):**
   ```
   Coverage (30%):        X/10
   Complexity (25%):      X/10
   Duplication (20%):     X/10
   Documentation (15%):   X/10
   Test quality (10%):    X/10
   ─────────────────────────
   Overall Health:        X.X/10
   ```

6. **Trend report.** Compare with previous run if data exists in `docs/health-reports/`.

7. **Recommendations.** Top 3 actions to improve health score.

## Critical Rules

1. **Weighted scoring prevents gaming.** 100% coverage of worthless tests is not a 10.
2. **Trends over absolutes.** A dropping trend is more important than a single low score.
3. **Honest reporting.** No inflating scores to look good.
4. **Top 3 actions only.** Don't overwhelm with recommendations.
5. **Compare with previous run.** Trend report is mandatory if historical data exists.

## Mandatory Process

Before delivering the report, you MUST:

1. **Run test coverage.** `npm test -- --coverage` or equivalent. Target: >80% critical paths, >60% utilities.
2. **Measure complexity.** Cyclomatic complexity per function <10. Files >20 flagged.
3. **Check duplication.** Target <5% duplication rate.
4. **Check documentation.** Public API without docs, README staleness >30 days, missing ADRs.
5. **Calculate weighted score.** Coverage 30%, Complexity 25%, Duplication 20%, Documentation 15%, Test quality 10%.
6. **Trend report.** Compare with previous run in `docs/health-reports/`.
7. **Top 3 recommendations.** Prioritized by impact.

## Automatic Fail Triggers

- Score calculated without running actual tools.
- Trend report skipped when historical data exists.
- Recommendations not prioritized (all marked "high priority").
- Score inflated to look good.
- No comparison with previous run when data exists.

## Deliverable Template

```
=== CODEBASE HEALTH ===
Date: <date>
Branch: <name>

SCORES (0-10)
Coverage:        <score> (weight: 30%)
Complexity:      <score> (weight: 25%)
Duplication:     <score> (weight: 20%)
Documentation:   <score> (weight: 15%)
Test quality:    <score> (weight: 10%)
─────────────────────────
OVERALL:         <score>/10

TREND (vs previous)
| Metric | Previous | Current | Delta |
|--------|----------|---------|-------|
| Overall | <score> | <score> | <+/-> |

TOP 3 ACTIONS
| Priority | Action | Expected Impact |
|----------|--------|----------------|
| 1 | <What> | <Impact> |
| 2 | <What> | <Impact> |
| 3 | <What> | <Impact> |

FLAGS
- Complexity >20: <files>
- Duplication >5%: <files>
- Missing docs: <files>
```

## Success Metrics for This Skill

- All 5 metrics measured with real tools: 100%
- Weighted score calculated correctly: 100%
- Trend report included when data exists: 100%
- Top 3 recommendations prioritized: 100%

## Rules
- Health score is a guide, not a gate. A 6/10 codebase with clear ownership is better than a 9/10 with none.
