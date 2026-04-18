---
name: using-solo-squad
description: "Loaded at session start. Provides an overview of all Solo Squad skills, agents, and commands so you can route requests to the right tool."
---

# Using Solo Squad

You have access to Solo Squad — a collection of coding, design, and security skills that turn one developer into a full squad.

## Available Skills

### Coding

| Skill | When to Use |
|-------|-------------|
| `/brainstorm` | New feature ideas — refine before coding |
| `/plan` | Turn a design doc into step-by-step tasks |
| `/plan-ceo-review` | Challenge scope, outcome, and strategic fit |
| `/plan-design-review` | Stress-test UX and user-facing plan quality |
| `/plan-eng-review` | Review architecture, data flow, and delivery risk |
| `/plan-devex-review` | Catch tooling, operability, and team-friction issues |
| `/build` | Execute a plan with TDD and subagents |
| `/review` | Multi-agent code review before merge |
| `/qa` | Browser-based testing and bug fixing |
| `/polish-beta` | Human-in-the-loop final polish before release |
| `/ship` | Push, open PR, and hand off to deploy |
| `/land-and-deploy` | Merge, deploy, canary, and verify production health |
| `/canary` | Exercise the new deploy and return PROCEED, HOLD, or ROLLBACK |
| `/document-release` | Sync CHANGELOG, README, API docs, and migration notes |
| `/compound` | Capture learnings after a sprint |
| `/investigate` | Root-cause debugging without guessing |
| `/technical-writing` | README, API docs, migration guides |
| `/devops-pipeline` | CI/CD pipeline design |
| `/database-optimization` | Query and schema optimization |
| `/workflow-mapping` | Document workflows and handoff contracts |
| `/developer-advocacy` | DX audits, sample apps, SDK docs |

### Design

| Skill | When to Use |
|-------|-------------|
| `/design-system` | Build a design system from scratch |
| `/design-review` | Audit UI with AI slop detection |
| `/ux-research` | User testing, personas, journey maps |
| `/brand-check` | Brand consistency audit |
| `/image-prompts` | AI image prompt engineering |

### Security

| Skill | When to Use |
|-------|-------------|
| `/cso` | OWASP Top 10 + STRIDE security audit |
| `/benchmark` | Performance benchmarking |
| `/browse` | Headless browser automation |
| `/careful` | Destructive command warnings |
| `/codex-review` | Cross-AI second opinion on diffs |
| `/freeze` | Lock edits to a specific directory |
| `/guard` | Combine /careful + /freeze |
| `/incident-response` | Production incident management |
| `/legal-compliance` | GDPR, CCPA, KVKK, HIPAA compliance |

## Workflow Commands

| Command | Flow |
|---------|------|
| `/autoplan` | CEO -> design -> eng -> DX plan gate before `/build` |
| `/sprint` | brainstorm → plan → build → review → qa → polish-beta → ship → land-and-deploy → document-release → compound |
| `/hotfix` | investigate → fix → review → ship |
| `/tdd` | write tests → implement → refactor |
| `/design-sprint` | research → design system → review → iterate |
| `/asset-gen` | Generate AI image assets for a campaign |
| `/security-scan` | OWASP + STRIDE + dependency audit |
| `/lockdown` | Maximum safety mode for production work |

## Agents

| Agent | Role |
|-------|------|
| **Architect** | System design, data modeling, ADRs — never implements |
| **Tester** | Edge cases, coverage, test quality |
| **Debugger** | Root cause analysis — read-only investigation |
| **Critic** | Design quality, AI slop detection, craft scoring |
| **Sentinel** | Security review with 8/10+ confidence gate |

## Platform Compatibility

Solo Squad skills work across Claude Code, Codex CLI, OpenCode, Cursor, Gemini CLI, and Copilot CLI. If you are running on a non-Claude-Code platform, check the tool mapping references at `skills/using-solo-squad/references/` for equivalent tool names.
