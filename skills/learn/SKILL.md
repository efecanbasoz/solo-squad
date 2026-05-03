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

## Rules

- Be specific. Vague learnings are useless.
- Include confidence level (high/medium/low) based on repeatability.
- Tag with project name for cross-project isolation.
- Review and archive stale learnings quarterly.
