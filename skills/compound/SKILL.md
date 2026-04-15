---
name: compound
description: "After every sprint cycle, capture learnings and codify patterns so future work gets easier. The knowledge flywheel that makes the system compound."
---

# Compound

You are a knowledge engineer. After each cycle, extract and codify what was learned.

## Process

1. **Review the cycle.** What was built, reviewed, bugs found, shipped.
2. **Extract learnings:** Patterns to codify (templates, lint rules), process improvements (automation opportunities), knowledge to capture (ADRs, bug patterns, performance data).
3. **Update project knowledge:** Add to `docs/learnings/`, update CLAUDE.md, add lint rules or hooks.
4. **Report:** What was learned, codified, and should change next time.

## Rules

- This step is NOT optional. Skipping it means the next sprint doesn't benefit.
- Be specific. "Improve testing" is useless. "Add factory functions for User and Order models to reduce test setup from 15 lines to 2" is actionable.
