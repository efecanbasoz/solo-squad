---
name: using-solo-squad
version: "2.2.0"
description: "Loaded at session start. Provides an overview of all Solo Squad skills, agents, and commands so you can route requests to the right tool."
triggers:
  - "help"
  - "what can you do"
  - "solo squad"
  - "available skills"
---

# Using Solo Squad

You have access to Solo Squad — a collection of development, design, security, and quality skills that turn one developer into a full squad.

## Instruction Priority Hierarchy

When instructions conflict, resolve in this order:

1. User instructions (direct requests, AGENTS.md, CLAUDE.md)
2. Solo Squad skills (invoke the skill, follow its process)
3. Default system prompt

## Rationalization Defense

Agents constantly rationalize skipping skills. You do not have a choice. If there is even a 1% chance a skill applies, invoke it.

| Thought | Reality |
|---------|---------|
| "This is just a simple question" | Questions are tasks. Check for skills. |
| "I know what that means" | Knowing the concept ≠ using the skill. |
| "This feels productive" | Undisciplined action wastes time. |
| "The user said to code" | Users ask for outcomes. Skills deliver outcomes with discipline. |
| "I already reviewed this" | Review is a skill. Use `/review`. |
| "I don't need to plan" | Every non-trivial change benefits from `/plan`. |

## Description Trap

Skill descriptions must be **trigger-only**. Do not put process details in the description. If the description contains workflow steps, agents follow the short description instead of reading the full skill.

**Bad:** `"Start here for any new engineering work. Refines rough ideas through Socratic questioning..."`
**Good:** `"Use when starting new engineering work. No implementation without design."`

## Available Skills

### Development

| Skill | When to Use |
|-------|-------------|
| `/brainstorm` | New feature ideas — refine before coding |
| `/plan` | Turn a design doc into step-by-step tasks |
| `/plan-review` | Multi-lens plan review (CEO, Design, Eng, DevEx) |
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

### Design

| Skill | When to Use |
|-------|-------------|
| `/design-system` | Build a design system from scratch |
| `/design-review` | Audit UI with AI slop detection + brand alignment |
| `/ux-research` | User testing, personas, journey maps |

### Security

| Skill | When to Use |
|-------|-------------|
| `/cso` | OWASP Top 10 + STRIDE security audit |
| `/benchmark` | Performance benchmarking |

### Quality & Learning

| Skill | When to Use |
|-------|-------------|
| `/slop-scan` | AI-generated code quality scan |
| `/learn` | Capture cross-session operational learnings |
| `/health` | Measure codebase health score (0-10) |
| `/scrape` | Extract structured data from web pages |
| `/retro` | Sprint retrospective with data-driven insights |

## Workflow Commands

| Command | Flow |
|---------|------|
| `/autoplan` | Multi-lens plan review before `/build` |
| `/sprint` | brainstorm → plan → build → review → qa → polish-beta → ship → land-and-deploy → document-release → compound |
| `/hotfix` | investigate → fix → review → ship |
| `/tdd` | red → green → refactor (enforced) |
| `/design-sprint` | research → design system → review → iterate |
| `/security-scan` | OWASP + STRIDE + dependency audit |

## Agents

| Agent | Role |
|-------|------|
| **Architect** | System design, data modeling, ADRs — never implements |
| **Tester** | Edge cases, coverage, test quality, slop detection |
| **Debugger** | Root cause analysis — read-only investigation |
| **Critic** | Design quality, AI slop detection, craft scoring |
| **Sentinel** | Security review with 8/10+ confidence gate |
| **Reality Checker** | Evidence-based certification, default NEEDS WORK |
| **DevEx Maintainer** | Installation, compatibility, onboarding, packaging, and validation workflows |


## Review Routing

Skills own the process. Agents provide specialist perspective inside a process. Start with the narrowest gate that matches the risk, then escalate only when evidence shows another gate is needed.

| Situation | Primary skill | Optional agent | Escalate when |
|---|---|---|---|
| Code is ready for merge | `/review` | Reality Checker, Tester | Production behavior, tests, or readiness evidence is unclear. |
| Plan exists but implementation has not started | `/plan-review` | Architect, Reality Checker | Scope, risk, or sequencing is contested. |
| UI or visual quality changed | `/design-review` | Critic | Brand fit, accessibility, or AI slop is uncertain. |
| AI-generated code feels suspicious | `/slop-scan` | Tester | Dead code, copy-paste, or low-signal abstractions appear. |
| Security-sensitive code changed | `/cso` | Sentinel | Auth, secrets, permissions, payments, or user data are touched. |
| Release candidate needs confidence | `/qa` | Tester, Reality Checker | Browser flows, regression risk, or evidence quality is weak. |
| Production deploy just landed | `/canary` | Reality Checker | Metrics, screenshots, or logs disagree with the expected outcome. |

Do not stack every gate by default. Run the smallest sufficient review, cite its evidence, and add another gate only for a specific unresolved risk.

## Context Budget

Use `skills/using-solo-squad/references/context-budget.md` whenever a workflow crosses 15K tokens, touches more than three files, or produces verbose evidence. Keep goals, constraints, approvals, and decisions in the parent thread; delegate raw scans, large diffs, coverage logs, browser traces, and documentation audits to fresh-context subagents. Subagents must return concise status, summary, evidence paths, and unresolved decisions instead of pasting raw output.

## Platform Compatibility

Solo Squad skills work across Claude Code, Codex CLI, and OpenCode. If you are running on a non-Claude-Code platform, check the tool mapping references at `skills/using-solo-squad/references/` for equivalent tool names.

## Tool Mapping References

- **Codex CLI:** `skills/using-solo-squad/references/codex-tools.md`
- **OpenCode:** `skills/using-solo-squad/references/opencode-tools.md`
- **Context Budget:** `skills/using-solo-squad/references/context-budget.md`
- **Release Checklist:** `skills/using-solo-squad/references/release-checklist.md`
