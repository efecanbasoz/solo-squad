# Solo Squad

> A squad of specialists for the solo developer.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Claude Code Plugin](https://img.shields.io/badge/Claude_Code-Plugin-blueviolet)](https://docs.anthropic.com/en/docs/claude-code)
[![Codex CLI](https://img.shields.io/badge/Codex_CLI-Compatible-green)](https://github.com/openai/codex)
[![OpenCode](https://img.shields.io/badge/OpenCode-Compatible-orange)](https://github.com/sst/opencode)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

**27 skills. 5 agents. 7 workflows. Three CLI platforms.**

Solo Squad is a plugin for AI coding CLIs that turns one developer into a full squad. Coding, design, and security — each category has specialists who do one job well.

Works with **Claude Code** (primary), **Codex CLI**, and **OpenCode**.

---

## Install

### Claude Code

```bash
/install-plugin efecanbasoz/solo-squad
```

### Codex CLI

```bash
git clone https://github.com/efecanbasoz/solo-squad ~/.codex/solo-squad
ln -s ~/.codex/solo-squad/skills ~/.agents/skills/solo-squad
```

### OpenCode

Add to your `opencode.json`:

```json
{
  "plugin": ["solo-squad@git+https://github.com/efecanbasoz/solo-squad.git"]
}
```

---

## What you get

### Coding — 13 skills

| Skill | What it does |
|-------|-------------|
| `/brainstorm` | Socratic questioning, alternatives, design doc |
| `/plan` | Step-by-step implementation plan with file paths |
| `/build` | Subagent-driven development with TDD |
| `/review` | Multi-lens code review (BLOCKER/SUGGESTION/NIT) |
| `/qa` | Real browser testing, bug fixing, regression tests |
| `/ship` | Tests, coverage audit, PR, deploy |
| `/compound` | Capture learnings, codify patterns |
| `/investigate` | Root-cause debugging with hypothesis logging |
| `/technical-writing` | README, API docs, migration guides |
| `/devops-pipeline` | CI/CD, IaC, zero-downtime deploys |
| `/database-optimization` | Query plans, indexing, N+1 detection |
| `/workflow-mapping` | System workflows, failure modes, handoffs |
| `/developer-advocacy` | DX audits, tutorials, sample apps |

### Design — 5 skills

| Skill | What it does |
|-------|-------------|
| `/design-system` | Tokens, components, patterns + starter templates |
| `/design-review` | AI slop detection, 0-10 scoring, before/after fixes |
| `/ux-research` | Study design through execution with analysis frameworks |
| `/brand-check` | Exact color/font matching, reverse-engineering guidelines |
| `/image-prompts` | Midjourney, DALL-E, Flux prompts with photography reference |

### Security — 9 skills

| Skill | What it does |
|-------|-------------|
| `/cso` | OWASP + STRIDE + supply chain + zero-trust audit |
| `/benchmark` | Core Web Vitals, load/stress testing, capacity planning |
| `/incident-response` | SEV classification, post-mortems, runbooks |
| `/legal-compliance` | GDPR, CCPA, KVKK, HIPAA checks |
| `/browse` | Real Chromium browser automation |
| `/careful` | Destructive command warnings |
| `/freeze` | Edit scope lock |
| `/guard` | Maximum safety mode |
| `/codex-review` | Cross-AI independent code review |

### Workflow commands

| Command | Flow |
|---------|------|
| `/sprint` | brainstorm → plan → build → review → qa → ship → compound |
| `/hotfix` | investigate → fix → review → ship |
| `/tdd` | write tests → implement → refactor |
| `/design-sprint` | research → design system → review → iterate |
| `/asset-gen` | Generate AI image assets for a campaign |
| `/security-scan` | OWASP + STRIDE + dependency audit |
| `/lockdown` | Maximum safety mode for production work |

### Agents

| Agent | Role |
|-------|------|
| **Architect** | System design, data modeling, ADRs — never implements |
| **Tester** | Edge cases, coverage, test quality |
| **Debugger** | Root cause analysis — read-only investigation |
| **Critic** | Design quality, AI slop detection, craft scoring |
| **Sentinel** | Security review with 8/10+ confidence gate |

---

## See it work

### A full engineering sprint

```
You: /sprint

Solo Squad: Starting sprint sequence.
  Phase 1: /brainstorm — refine the idea
  Ready? [y/N]

You: I want to add real-time notifications to the dashboard

[brainstorm conversation — 5 min]

Solo Squad: Design doc saved. Continue to /plan? [y/N]

You: y

[plan generated — 2 min]

Solo Squad: 12 tasks created (2-5 min each).
  Continue to /build? [y/N]

You: y

[subagent-driven build with TDD — 20 min]

Solo Squad: Build complete. 12/12 tasks done, 94% test coverage.
  Continue to /review? [y/N]
```

### Security audit before deploy

```
You: /security-scan

Solo Squad: Running full security scan:
  1. OWASP Top 10 check
  2. STRIDE threat model
  3. Dependency audit

  Findings (8/10+ confidence only):

  CRITICAL: SQL injection in /api/users (parameterize query)
  HIGH: Missing rate limiting on /api/auth/login
  MEDIUM: Outdated dependency jsonwebtoken@8.5.1 (CVE-2022-23529)

  3 findings. Auto-fix available for 2. Proceed? [y/N]
```

---

## Multi-CLI compatibility

Solo Squad skills are written in SKILL.md format — the universal standard across Claude Code, Codex CLI, and OpenCode.

| Feature | Claude Code | Codex CLI | OpenCode |
|---------|-------------|-----------|----------|
| Skills | Native | Native (via symlink) | Native (via plugin) |
| Agents | Native | Reference only | Reference only |
| Hooks | Native | SessionStart only | Via JS plugin |
| Commands | Native | Via skills | Via skills |
| Instruction file | `CLAUDE.md` | `AGENTS.md` | `AGENTS.md` (fallback: `CLAUDE.md`) |

Tool name differences between platforms are documented in `skills/using-solo-squad/references/`.

---

## Cost warning

Solo Squad runs subagent-driven workflows. Token usage is higher than typical.

| Workflow | Typical cost |
|----------|-------------|
| Single skill (e.g., `/cso`) | < $1 |
| `/sprint` (full cycle) | $5-15 |
| `/security-scan` | $2-4 |

On Claude Pro/Max or Codex with included usage, this rarely matters.

---

## Project structure

```
solo-squad/
├── skills/          — 27 SKILL.md files (the core content)
├── agents/          — 5 agent definitions
├── commands/        — 7 workflow commands
├── hooks/           — Runtime hooks + session bootstrap
├── .claude-plugin/  — Claude Code manifest
├── .codex/          — Codex CLI install guide
├── .opencode/       — OpenCode ESM plugin
├── CLAUDE.md        — Claude Code context
└── AGENTS.md        — Codex/OpenCode context
```

---

## Built on the shoulders of giants

- [obra/superpowers](https://github.com/obra/superpowers) — TDD methodology, subagent-driven development, multi-CLI architecture
- [garrytan/gstack](https://github.com/garrytan/gstack) — Browser automation, security audits, host config system
- [EveryInc/compound-engineering-plugin](https://github.com/EveryInc/compound-engineering-plugin) — Knowledge compounding philosophy

---

## Contributing

Solo Squad accepts PRs for new skills, improvements, and bug fixes. Each skill needs a `SKILL.md` with frontmatter, a numbered process, explicit rules, and defined deliverables. See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

---

## License

MIT. Use it, fork it, sell services on top of it.
