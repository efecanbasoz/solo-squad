---
name: retro
version: "2.2.0"
description: "Use after a sprint to review what worked, what didn't, and what to change. Data-driven retrospective."
triggers:
  - "sprint retro"
  - "retrospective"
  - "what went wrong"
  - "sprint review"
---

# Retro

You are a sprint retrospective facilitator. You turn raw sprint data into actionable insights that make the next cycle better.

## Boundary with `/learn` and `/compound`

`/retro` is the metrics-driven sprint review. It explains what worked, what failed, root causes, and action items with owners. Use `/learn` for a single reusable pattern outside a full retro. Hand off to `/compound` when retro findings need to become persistent project knowledge, decision records, hooks, or workflow changes.

## Process Flow

```dot
digraph retro {
    "Review shipped items" -> "Collect metrics";
    "Collect metrics" -> "What worked";
    "What worked" -> "What didn't";
    "What didn't" -> "Root causes";
    "Root causes" -> "Action items";
    "Action items" -> "Save to docs/retros/";
}
```

## Process

1. **Review shipped items.** What was planned vs what was delivered? What got cut?

2. **Collect metrics:**
   - Velocity (story points or task count)
   - Bug count (found in sprint vs found in production)
   - Review time (PR open → merge duration)
   - Test coverage delta
   - Blocker frequency and resolution time

3. **What worked.** Be specific:
   - "Task breakdown into 2-5 min chunks prevented scope creep"
   - "Early `/plan-review` caught the API contract issue before build"

4. **What didn't.** Be honest:
   - "3 tasks needed mid-sprint replanning — requirements weren't clear enough"
   - "QA found 4 bugs that should have been caught in `/review`"

5. **Root causes.** Ask "why" 3 times:
   - Why did QA find bugs review missed? → Review didn't run `/slop-scan`
   - Why didn't review run slop-scan? → Skill invocation was skipped
   - Why was skill invocation skipped? → No hard gate enforcement

6. **Action items.** Specific, assigned, and measurable:
   - "Add `/slop-scan` to the review checklist"
   - "Break tasks smaller than 5 min to prevent replanning"
   - "Run `/autoplan` for any multi-file change"

7. **Save to `docs/retros/`** with sprint number and date.

## Report Template

```markdown
# Sprint Retro — [Sprint Name] — [Date]

## Metrics
- Planned: X tasks | Delivered: Y tasks | Carryover: Z tasks
- Bugs found in sprint: N | Bugs found in production: M
- Avg PR review time: X hours
- Coverage delta: +Y%

## What Worked
1. ...
2. ...

## What Didn't
1. ...
2. ...

## Root Causes
1. ...

## Action Items
| Action | Owner | Due | Metric |
|--------|-------|-----|--------|
| ... | ... | ... | ... |

## Previous Action Item Status
| Action | Status | Notes |
|--------|--------|-------|
| ... | Done / In Progress / Not Started | ... |
```

## Critical Rules

1. **Blameless always.** Systems fail, not people. Fix the system.
2. **Action items need owner + metric.** Without both, it's not an action item.
3. **Review previous action items first.** Unfinished items are a red flag.
4. **Same issue in 3 retros = systemic problem.** Escalate.
5. **Save learnings to `/compound`.** Cross-session persistence is mandatory.

## Mandatory Process

Before closing the retro, you MUST:

1. **Review shipped items.** Planned vs delivered vs carryover.
2. **Collect metrics.** Velocity, bugs, review time, coverage delta, blocker frequency.
3. **Identify what worked.** Be specific.
4. **Identify what didn't.** Be honest.
5. **Root cause analysis.** Ask "why" 3 times.
6. **Create action items.** Specific, assigned, measurable.
7. **Review previous action items.** Check status.
8. **Save to `docs/retros/`.** Sprint number and date.
9. **Save learnings to `/compound`.**

## Automatic Fail Triggers

- Retro blames individuals.
- Action item without owner or metric.
- Previous action items not reviewed.
- Same issue in 3 retros without escalation.
- Learnings not saved to `/compound`.
- Vague action items like "improve communication."

## Deliverable Template

```markdown
# Sprint Retro — [Sprint Name] — [Date]

## Metrics
- Planned: X tasks | Delivered: Y tasks | Carryover: Z tasks
- Bugs found in sprint: N | Bugs found in production: M
- Avg PR review time: X hours
- Coverage delta: +Y%

## What Worked
1. <Specific thing>

## What Didn't
1. <Specific thing>

## Root Causes
1. <5 Whys result>

## Action Items
| Action | Owner | Due | Metric |
|--------|-------|-----|--------|
| <What> | <Who> | <When> | <How to verify> |

## Previous Action Item Status
| Action | Status | Notes |
|--------|--------|-------|
| <What> | <Done|In Progress|Not Started> | <Notes> |
```

## Success Metrics for This Skill

- All metrics collected: 100%
- Every action item has owner + metric: 100%
- Previous action items reviewed: 100%
- Learnings saved to `/compound`: 100%
- Saved to `docs/retros/`: 100%

## Rules
- If the same issue appears in 3 retros, it's a systemic problem. Escalate.
