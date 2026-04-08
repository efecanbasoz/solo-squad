# Project Squad

Multi-client project management and team operations. Built for agencies juggling several engagements at once.

**Plugin name:** `project-squad`

## Skills

| Skill | What it does |
|-------|--------------|
| `/client-kickoff` | New client onboarding: discovery questionnaire, project charter, communication plan, access checklist. |
| `/sprint-plan` | Sprint planning across multiple clients: capacity check, backlog triage, prioritization, risk flags. |
| `/status-report` | Client-facing status reports: progress summary, KPI dashboard, milestones, blockers, action items. |
| `/experiment-track` | A/B test management: hypothesis documentation, test design, significance checks, result synthesis. |
| `/feedback-synthesis` | Turn raw feedback into insights: theme extraction, severity scoring, pattern identification. |
| `/retro` | Team retrospective: metrics review, per-person breakdown, wins, problems, action items. |

## Commands

| Command | What it does |
|---------|-------------|
| `/standup` | Daily standup summary across all active client projects |
| `/weekly-sync` | Weekly client sync prep: progress, blockers, decisions needed |
| `/onboard` | Full new client onboarding: kickoff -> access -> scaffolding -> first sprint |

## Agents

| Agent | Role |
|-------|------|
| Studio Producer | Multi-project orchestrator. Capacity, timelines, cross-project dependencies. |

## Hooks

After every bash command, a hook suggests logging the action for the sprint retro so context isn't lost.
