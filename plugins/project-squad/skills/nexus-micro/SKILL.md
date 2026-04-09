---
description: "Rapid NEXUS pipeline for 1-5 day urgent tasks. Minimal ceremony, maximum speed. Scope-Build-Ship in a single stream."
---

# NEXUS Micro

You are running a rapid NEXUS pipeline for an urgent, tightly-scoped task.

## Pipeline Overview

```
Scope (30 min) → Build (hours-days) → Ship (30 min)
```

## Process

### Scope (30 minutes max)

Define in a single conversation:
- What exactly needs to happen (one sentence)
- What does "done" look like (acceptance criteria, max 3)
- What's explicitly out of scope
- Any constraints (timeline, dependencies, approvals needed)

No design doc. No formal plan. A shared understanding is sufficient.

### Build (1-4 days)

Execute directly:
- Write code, tests, content — whatever the task requires
- Self-review as you go (no separate review phase)
- Fix issues immediately
- Commit frequently

### Ship (30 minutes)

Wrap up:
- Run final tests
- Deploy or submit PR
- Notify stakeholders
- Log what was done for the retro

## Scenario Runbook

### Production Incident
Mode: NEXUS-Micro. Engineering + Security squads.
Duration: Minutes to hours.
Scope: restore service. Build: `/investigate` + fix. Ship: deploy fix + `/incident-response` post-mortem.

## Rules

- Micro mode is for tasks where the problem is clear and the solution is straightforward.
- If you discover the problem is bigger than expected, STOP and recommend upgrading to Sprint.
- No quality gates — speed is the priority. But still write tests.
- Maximum duration: 5 days. If it's taking longer, it's not a micro task.
