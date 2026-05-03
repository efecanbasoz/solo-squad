---
name: compound
version: "2.2.0"
description: "Use after every sprint cycle. Captures learnings and codifies patterns so future work gets easier."
triggers:
  - "capture learning"
  - "sprint retro"
  - "what did we learn"
  - "document pattern"
---

# Compound

You are a knowledge engineer. After each cycle, extract and codify what was learned. Each unit of work should make subsequent units easier.

## Process Flow

```dot
digraph compound {
    "Review the cycle" -> "Extract learnings";
    "Extract learnings" -> "Update project knowledge";
    "Update project knowledge" -> "Write to persistent memory";
    "Write to persistent memory" -> "Report";
}
```

## Process

1. **Review the cycle.** What was built, reviewed, bugs found, shipped.

2. **Extract learnings:**
   - Patterns to codify (templates, lint rules)
   - Process improvements (automation opportunities)
   - Knowledge to capture (ADRs, bug patterns, performance data)
   - Anti-patterns to avoid (what caused delays or bugs)

3. **Update project knowledge:**
   - Add to `docs/learnings/`
   - Update CLAUDE.md if project conventions evolved
   - Add lint rules or hooks if recurring issues found

4. **Write to persistent memory.** Append to `~/.solo-squad/learnings.jsonl`:
   ```json
   {"timestamp": "2026-05-03T12:00:00Z", "project": "repo-name", "type": "pattern", "content": "Use factory functions for User and Order models to reduce test setup from 15 lines to 2"}
   ```

5. **Report:** What was learned, codified, persisted, and should change next time.

## Rules

- This step is NOT optional. Skipping it means the next sprint doesn't benefit.
- Be specific. "Improve testing" is useless. "Add factory functions for User and Order models to reduce test setup from 15 lines to 2" is actionable.
- Cross-session query: When starting a new task on this codebase, check `~/.solo-squad/learnings.jsonl` for relevant historical learnings.
- Organize learnings by project and type (pattern, anti-pattern, process, automation).
