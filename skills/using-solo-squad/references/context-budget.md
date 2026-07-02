# Context Budget Reference

Use this reference when a skill risks context rot from long plans, verbose logs, large diffs, or repeated subagent output.

## Budgets

| Session shape | Parent context rule | Delegation rule |
|---|---|---|
| Short task (<15K tokens, <=3 files) | Keep essential commands and decisions inline. | Delegate only specialist checks. |
| Medium task (15K-40K tokens, 4-10 files) | Summarize after each phase. Keep raw logs out of the parent thread. | Delegate scans, audits, and verbose comparisons. |
| Long task (>40K tokens, 10+ files, or multi-day) | Start fresh-context passes for planning, review, QA, and release. | Subagents return structured summaries only. |

## Parent thread keeps

- User goals, constraints, and approvals.
- Current phase, next action, and blockers.
- Final decisions with evidence links.
- Paths to artifacts created by subagents.

## Delegate or externalize

- Raw test logs, coverage reports, browser traces, HAR files, and screenshots.
- Large diffs and repetitive lint findings.
- Repo-wide scans and documentation audits.
- Any output that is useful as evidence but not needed for next-step reasoning.

## Return contract

Subagents should return:

```json
{
  "status": "DONE|DONE_WITH_CONCERNS|BLOCKED|NEEDS_CONTEXT",
  "summary": "one paragraph",
  "evidence": ["paths or commands"],
  "decisions_needed": ["specific unresolved calls"]
}
```

Never paste multi-KB raw output into the parent thread when a file path or concise summary is enough.
