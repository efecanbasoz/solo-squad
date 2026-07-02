# Decision Log

Use this directory for durable decisions that should survive a single chat session. The goal is to prevent repeated debates, hidden assumptions, and context rot.

## When to write a decision

Create a decision record when work changes any of these:

- architecture boundaries, data models, APIs, or persistence strategy;
- product scope, launch criteria, pricing, or user-facing behavior;
- security posture, threat model, compliance assumptions, or risk acceptance;
- release, deployment, rollback, or compatibility policy;
- Solo Squad skill, agent, command, hook, or plugin packaging conventions.

Do not write a decision record for routine implementation details that are obvious from the code or plan.

## File naming

Use monotonically increasing numbers and kebab-case titles:

```text
docs/decisions/0001-short-title.md
```

## Template

```markdown
# 0001: Short title

- **Date:** YYYY-MM-DD
- **Status:** Proposed | Accepted | Superseded | Rejected
- **Owners:** @name or team
- **Related work:** PRs, plans, issues, or docs

## Context

What forced the decision now? Include constraints, alternatives, and relevant evidence.

## Decision

State the decision in one or two direct paragraphs.

## Consequences

- Positive outcomes expected.
- Tradeoffs accepted.
- Follow-up work required.

## Review trigger

When should this be revisited? Examples: after launch, after a metric crosses a threshold, before a major version bump, or when a dependency changes.
```

## Skill integration

- `/plan` should create or reference a decision record for material architecture or product tradeoffs.
- `/plan-review` should flag missing decision records when a plan depends on an unstated tradeoff.
- `/compound` should convert repeated lessons into accepted decisions when they become policy.
- `/retro` should propose decision updates when process evidence contradicts an accepted policy.
