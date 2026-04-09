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
| `/orchestrate` | NEXUS cross-squad orchestration: coordinate multi-squad pipelines with Full, Sprint, or Micro operating modes. |
| `/client-context` | Persistent client intelligence: init, load, save, list. Maintains company profile, brand, history, and active projects across sessions. |
| `/executive-summary` | Generate executive summaries: high-level progress, key decisions, risks, and recommendations for stakeholders. |
| `/product-strategy` | Product strategy: market analysis, competitive positioning, feature prioritization, and go-to-market planning. |
| `/analytics-reporting` | Analytics reporting: KPI dashboards, trend analysis, attribution modeling, and data-driven recommendations. |
| `/document-generation` | Document generation: SOWs, proposals, reports, and presentations from templates with project data. |

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
| Orchestrator | NEXUS cross-squad pipeline manager. Routes work between squads, enforces quality gates, manages handoffs. |

## Hooks

Context-aware shell script that checks file type, path, and content before firing. Suggests logging actions for the sprint retro so context isn't lost.
