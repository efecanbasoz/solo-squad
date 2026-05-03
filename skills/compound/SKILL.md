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

## Critical Rules

1. Run this skill after every sprint cycle without exception — skipping compounds future debt.
2. Write learnings with measurable specificity; vague advice is discarded noise.
3. Query `~/.solo-squad/learnings.jsonl` at the start of every new task on this codebase.
4. Persist learnings in structured JSONL with timestamp, project, type, and content fields.
5. Update project docs (CLAUDE.md, `docs/learnings/`) within the same session — delayed updates are forgotten updates.

## Mandatory Process

1. MUST review what was built, reviewed, bug-fixed, and shipped in the cycle.
2. MUST extract at least one pattern, one anti-pattern, and one process improvement.
3. MUST write entries to `~/.solo-squad/learnings.jsonl` before ending the session.
4. MUST update project knowledge docs if conventions or patterns evolved.
5. MUST report what was learned, codified, persisted, and what should change next time.

## Automatic Fail Triggers

- Skipping the skill after a sprint or significant task.
- Writing vague learnings without before/after metrics or concrete file references.
- Failing to persist to `~/.solo-squad/learnings.jsonl` or project docs.
- Ignoring historical learnings when starting a new task on the same codebase.
- Duplicating an existing learning without linking to the prior entry.

## Deliverable Template

```markdown
## Compound Report — [PROJECT] — [DATE]

### Patterns Codified
- [Specific pattern with file paths and measurable impact]

### Anti-Patterns Flagged
- [What caused delays or bugs with root cause]

### Process Improvements
- [Automation or workflow change with expected time savings]

### Persistent Memory Updated
- `~/.solo-squad/learnings.jsonl` — [N] new entries
- `docs/learnings/` — [files updated]

### Next Cycle Changes
- [What should be done differently next time]
```

## Success Metrics for This Skill

- 100% of sprint cycles followed by compound session
- 100% of learnings include concrete file references or measurable deltas
- ≥90% of new tasks on existing codebases begin with historical learning query
- 0% duplicate learnings without cross-reference to prior entries
- 100% of extracted patterns reflected in updated project docs

## Rules

- This step is NOT optional. Skipping it means the next sprint doesn't benefit.
- Be specific. "Improve testing" is useless. "Add factory functions for User and Order models to reduce test setup from 15 lines to 2" is actionable.
- Cross-session query: When starting a new task on this codebase, check `~/.solo-squad/learnings.jsonl` for relevant historical learnings.
