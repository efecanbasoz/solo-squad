---
name: codex-review
version: "2.2.0"
description: Cross-AI code review
triggers:
  - "second opinion"
  - "cross ai review"
  - "codex check"
---

# Codex Review

Get an independent code review perspective.

## Process

1. **Generate diff.** Extract the changes to review.
2. **Independent analysis.** Review the code from scratch, without seeing previous review notes.
3. **Cross-reference.** If a previous review exists, compare: which findings overlap? Which are unique?
4. **Synthesis.** Merged findings with consensus assessment.

## Rules
- Independence matters. Don't anchor on previous review findings.
- Disagreements between reviewers should be flagged for human judgment.
- Focus on findings the primary review might have missed.
