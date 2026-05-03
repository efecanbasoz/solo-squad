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

## Rules

- Health score is a guide, not a gate. A 6/10 codebase with clear ownership is better than a 9/10 with none.
- Focus on trends, not absolute numbers.
- Weighted scoring prevents gaming (e.g., 100% coverage of worthless tests).
- Report honestly. A dropping trend is more important than a single low score.
