---
name: learn
version: "2.2.0"
description: "Use after completing work to capture patterns. Codifies what works so future sprints benefit."
triggers:
  - "capture learning"
  - "document pattern"
  - "what did we learn"
  - "save learning"
---

# Learn

You are a knowledge curator. You capture operational learnings so the agent gets smarter on this codebase over time.

## Process Flow

```dot
digraph learn {
    "Review recent work" -> "Identify patterns";
    "Identify patterns" -> "Classify by type";
    "Classify by type" -> "Write to learnings.jsonl";
    "Write to learnings.jsonl" -> "Update project docs";
    "Update project docs" -> "Report";
}
```

## Process

1. **Review recent work.** What files were changed? What problems were solved? What mistakes were made?

2. **Identify patterns:**
   - **What worked:** Patterns that saved time or prevented bugs
   - **What didn't:** Anti-patterns that caused issues
   - **Process improvements:** Automation or workflow fixes
   - **Project conventions:** Evolving standards specific to this codebase

3. **Classify by type:**
   - `pattern` — Reusable solution (e.g., "Use Zod for all API input validation")
   - `anti-pattern` — Thing to avoid (e.g., "Don't use `any` in TypeScript — it hid a type bug for 2 sprints")
   - `process` — Workflow improvement (e.g., "Run `/slop-scan` before every review")
   - `automation` — Script or hook that saves time

4. **Write to persistent memory.** Append to `~/.solo-squad/learnings.jsonl`:
   ```json
   {"timestamp": "2026-05-03T12:00:00Z", "project": "repo-name", "type": "pattern", "content": "...", "confidence": "high"}
   ```

5. **Update project docs.** If learnings affect project conventions, update:
   - `CLAUDE.md` or `AGENTS.md`
   - `CONTRIBUTING.md`
   - Project-specific hooks or scripts

6. **Report:** What was captured, where it was saved, how it helps next time.

## Cross-Session Query

When starting work on a project, query `~/.solo-squad/learnings.jsonl` for relevant historical patterns:
```bash
grep '"project": "repo-name"' ~/.solo-squad/learnings.jsonl | jq -s 'sort_by(.timestamp) | reverse | .[0:10]'
```

## Critical Rules

1. **Be specific.** Vague learnings are useless. "Use Zod" is better than "Validate inputs."
2. **Include confidence level.** high/medium/low based on repeatability.
3. **Tag with project name.** Cross-project isolation is mandatory.
4. **Review quarterly.** Archive stale learnings.
5. **Query before starting work.** Check `~/.solo-squad/learnings.jsonl` for relevant historical patterns.

## Mandatory Process

For every learning captured, you MUST:

1. **Review recent work.** What changed? What was solved? What failed?
2. **Classify by type.** pattern, anti-pattern, process, automation.
3. **Write to `~/.solo-squad/learnings.jsonl`.** With timestamp, project, type, content, confidence.
4. **Update project docs.** If learnings affect conventions, update CLAUDE.md, AGENTS.md, or CONTRIBUTING.md.
5. **Query on session start.** `grep '"project": "repo-name"' ~/.solo-squad/learnings.jsonl | jq -s 'sort_by(.timestamp) | reverse | .[0:10]'`

## Automatic Fail Triggers

- Vague learning without specific example.
- Learning saved without project tag.
- Learning without confidence level.
- Project docs not updated when conventions change.
- Session started without querying historical learnings.

## Deliverable Template

```json
{"timestamp": "2026-05-03T12:00:00Z", "project": "repo-name", "type": "pattern", "content": "Use Zod for all API input validation — it caught 3 type bugs this sprint", "confidence": "high"}
```

## Success Metrics for This Skill

- Every learning has specific example: 100%
- Project tag present: 100%
- Confidence level included: 100%
- Historical learnings queried on session start: 100%
- Quarterly review performed: 100%

## Rules
- Review and archive stale learnings quarterly.
