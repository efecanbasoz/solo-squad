# Solo Squad

> One developer. A full squad of specialists.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude_Code-Plugin-blueviolet)](https://docs.anthropic.com/en/docs/claude-code)
[![Codex CLI](https://img.shields.io/badge/Codex_CLI-Compatible-green)](https://github.com/openai/codex)
[![OpenCode](https://img.shields.io/badge/OpenCode-Compatible-orange)](https://github.com/sst/opencode)
[![Cursor](https://img.shields.io/badge/Cursor-Compatible-blue)](https://cursor.com)
[![Gemini CLI](https://img.shields.io/badge/Gemini_CLI-Compatible-yellow)](https://github.com/google-gemini/gemini-cli)
[![Copilot CLI](https://img.shields.io/badge/Copilot_CLI-Compatible-lightgrey)](https://githubnext.com/projects/copilot-cli)

**27 structured workflows** across coding, design, and security for any AI coding CLI. No vague instructions — each skill is a battle-tested process with numbered steps, quality gates, and defined deliverables.

---

## Install

No dependencies. No build step. Pure markdown + shell scripts.

### Claude Code

Add the Solo Squad marketplace, then install:

```bash
claude plugins marketplace add https://github.com/efecanbasoz/solo-squad
claude plugins install solo-squad
```

Reload to activate:

```
/reload-plugins
```

### Codex CLI

Clone and symlink so Codex auto-discovers skills at startup:

```bash
git clone https://github.com/efecanbasoz/solo-squad ~/.codex/solo-squad
mkdir -p ~/.agents/skills
ln -s ~/.codex/solo-squad/skills ~/.agents/skills/solo-squad
```

<details>
<summary>Windows (PowerShell)</summary>

```powershell
git clone https://github.com/efecanbasoz/solo-squad "$env:USERPROFILE\.codex\solo-squad"
New-Item -ItemType Directory -Force "$env:USERPROFILE\.agents\skills"
cmd /c mklink /J "$env:USERPROFILE\.agents\skills\solo-squad" "$env:USERPROFILE\.codex\solo-squad\skills"
```

</details>

To enable subagent dispatch for skills like `/build` and `/sprint`, add to `~/.codex/config.toml`:

```toml
[features]
multi_agent = true
```

### OpenCode

Add to your `opencode.json`:

```json
{
  "plugins": ["solo-squad@git+https://github.com/efecanbasoz/solo-squad.git"]
}
```

The JS plugin at `.opencode/plugins/solo-squad.js` registers skills automatically and injects session context on first message.

### Cursor

Install from the agent chat:

```
/install-plugin efecanbasoz/solo-squad
```

Skills, agents, commands, and hooks are discovered from `.cursor-plugin/plugin.json`.

### Gemini CLI

Install as a Gemini extension:

```bash
gemini extensions install https://github.com/efecanbasoz/solo-squad
```

`GEMINI.md` and `gemini-extension.json` at the repo root provide context and tool mapping.

> **Note:** Gemini CLI does not support subagents. Skills that dispatch agents fall back to sequential execution.

### Copilot CLI

Add the marketplace and install:

```bash
copilot plugins marketplace add efecanbasoz/solo-squad
copilot plugins install solo-squad
```

Copilot uses the same `.claude-plugin/` manifest and shares full hook support.

### Updating

Each platform picks up updates differently:

| Platform | Update command |
|----------|---------------|
| Claude Code | `claude plugins update solo-squad` |
| Codex CLI | `cd ~/.codex/solo-squad && git pull` |
| OpenCode | Remove + re-add in `opencode.json` (auto-fetches latest) |
| Cursor | `/update-plugin solo-squad` |
| Gemini CLI | `gemini extensions update solo-squad` |
| Copilot CLI | `copilot plugins update solo-squad` |

### Uninstalling

| Platform | Uninstall command |
|----------|------------------|
| Claude Code | `claude plugins uninstall solo-squad` |
| Codex CLI | `rm ~/.agents/skills/solo-squad && rm -rf ~/.codex/solo-squad` |
| OpenCode | Remove from `opencode.json` |
| Cursor | `/remove-plugin solo-squad` |
| Gemini CLI | `gemini extensions uninstall solo-squad` |
| Copilot CLI | `copilot plugins uninstall solo-squad` |

---

## See it work

### Ship a feature in one command

```
You: /sprint

Solo Squad: Starting sprint. Phase 1: /brainstorm
  What are you building and why?

You: Real-time notifications for the dashboard. Users miss critical alerts.

Solo Squad: Before we code — three questions:
  1. WebSocket, SSE, or polling? (trade-offs below)
  2. What's the simplest version that delivers value?
  3. What are you intentionally NOT building?

[5 min conversation — design doc produced]

Solo Squad: Design doc saved. → /plan

  12 tasks created (2-5 min each):
  ├── #1  NotificationProvider context
  ├── #2  WebSocket hook with reconnect
  ├── #3  Toast component with severity levels
  ├── ...
  └── #12 E2E test: notification lifecycle

  Continue to /build? [y/N]

You: y

[Subagents execute each task with TDD — 25 min]

Solo Squad: Build complete. 12/12 tasks, 94% coverage.
  → /review

  Multi-lens review:
    BLOCKER: Race condition in WebSocket reconnect (auto-fixed)
    SUGGESTION: Extract toast queue into custom hook
    NIT: Inconsistent error message casing

  → /ship

  ✓ Tests passing (47/47)
  ✓ Coverage: 94% (threshold: 80%)
  ✓ PR opened: feat(notifications): add real-time alert system
```

### Catch what CI misses

```
You: /security-scan

Solo Squad:
  CRITICAL  SQL injection in /api/users?search= — parameterize query
  HIGH      No rate limiting on /api/auth/login — add express-rate-limit
  MEDIUM    jsonwebtoken@8.5.1 has CVE-2022-23529 — upgrade to 9.x

  3 findings (8/10+ confidence). Auto-fix available for 2. Proceed? [y/N]
```

### Get a design review that actually helps

```
You: /design-review

Solo Squad:
  Visual Quality:    7/10  — spacing inconsistent between card variants
  Consistency:       5/10  — three different border-radius values used
  Accessibility:     6/10  — contrast ratio 3.2:1 on muted text (need 4.5:1)
  AI Slop Detection: CLEAN — no generic stock patterns detected

  Top fix: Unify border-radius to design token --radius-md
  Before/after diff generated.
```

---

## What's inside

### Coding — 13 skills, 3 agents

| Skill | Your specialist |
|-------|----------------|
| `/brainstorm` | Product partner who challenges your assumptions |
| `/plan` | Architect who breaks work into 2-5 min tasks with file paths |
| `/build` | Lead engineer dispatching subagents with TDD enforcement |
| `/review` | Senior reviewer classifying BLOCKER / SUGGESTION / NIT |
| `/qa` | QA lead running real browser tests, filing bugs, writing regression tests |
| `/ship` | Release engineer: tests, coverage audit, PR, verify CI |
| `/compound` | Knowledge curator capturing patterns for next time |
| `/investigate` | Debugger who traces data flow and logs hypotheses |
| `/technical-writing` | Tech writer: README, API docs, migration guides |
| `/devops-pipeline` | DevOps engineer: CI/CD, IaC, zero-downtime deploys |
| `/database-optimization` | DBA: query plans, indexing, N+1 detection |
| `/workflow-mapping` | Systems analyst: happy paths, failure modes, handoffs |
| `/developer-advocacy` | DevRel: DX audits, tutorials, sample apps |

**Agents:** Architect (designs, never implements) · Tester (edge cases, screenshot evidence) · Debugger (read-only investigator)

### Design — 5 skills, 1 agent

| Skill | Your specialist |
|-------|----------------|
| `/design-system` | Design lead building tokens, components, patterns from scratch |
| `/design-review` | Critic with AI slop detection and 0-10 scoring |
| `/ux-research` | Researcher: test scripts, personas, journey maps |
| `/brand-check` | Brand guardian: color/font matching, guideline reverse-engineering |
| `/image-prompts` | Art director: Midjourney, DALL-E, Flux prompts with photo reference |

**Agent:** Design Critic (detects AI slop, scores craft, severity classification)

### Security — 9 skills, 1 agent

| Skill | Your specialist |
|-------|----------------|
| `/cso` | Security officer: OWASP + STRIDE + supply chain + zero-trust |
| `/benchmark` | Performance engineer: Core Web Vitals, load testing, capacity planning |
| `/incident-response` | Incident commander: SEV classification, post-mortems, runbooks |
| `/legal-compliance` | Compliance officer: GDPR, CCPA, KVKK, HIPAA |
| `/browse` | Browser automation: navigate, click, fill, screenshot, verify |
| `/careful` | Safety net: warns before rm -rf, DROP TABLE, force-push |
| `/freeze` | Scope lock: restrict edits to one directory |
| `/guard` | Maximum safety: /careful + /freeze combined |
| `/codex-review` | Second opinion: cross-AI independent code review |

**Agent:** Sentinel (read-only security review, 8/10+ confidence gate)

### Workflow commands

Chain skills into end-to-end pipelines:

| Command | What happens |
|---------|-------------|
| `/sprint` | brainstorm → plan → build → review → qa → ship → compound |
| `/hotfix` | investigate → fix → review → ship |
| `/tdd` | red → green → refactor (enforced) |
| `/design-sprint` | research → design system → review → iterate |
| `/asset-gen` | Generate AI image assets for a campaign |
| `/security-scan` | OWASP + STRIDE + dependency audit |
| `/lockdown` | Maximum safety mode for production work |

---

## How it works

Each skill is a **structured process** — numbered steps, decision criteria, quality gates, and explicit deliverables. Your agent follows the playbook instead of improvising.

```
skills/
├── brainstorm/SKILL.md     ← Role + Process + Rules + Deliverables
├── plan/SKILL.md
├── build/SKILL.md
├── ...
agents/
├── architect.md            ← Persona + Expertise + Decision Framework
├── tester.md
├── ...
commands/
├── sprint.md               ← Skill chain with human approval gates
├── hotfix.md
├── ...
hooks/
├── tdd-reminder.sh         ← Fires when you write code without tests
├── brand-check.sh          ← Fires when you edit CSS/SVG/assets
├── destructive-warning.sh  ← Fires before rm -rf, DROP TABLE, etc.
```

Skills are written in **SKILL.md** — the universal format across all supported CLIs. Write once, run anywhere.

---

## Multi-CLI support

| Feature | Claude Code | Codex CLI | OpenCode | Cursor | Gemini CLI | Copilot CLI |
|---------|:-----------:|:---------:|:--------:|:------:|:----------:|:-----------:|
| Skills | Native | Native (symlink) | Native (plugin) | Native | Native | Native |
| Agents | Native | With `multi_agent` | Reference | Native | Reference | Native |
| Hooks | Full | SessionStart | Via JS plugin | Full | SessionStart | Full |
| Commands | Native | Via skills | Via skills | Native | Via skills | Native |

Tool name differences are bridged automatically via reference docs in `skills/using-solo-squad/references/`.

---

## Cost

Subagent workflows use more tokens than simple prompting.

| Workflow | Typical cost |
|----------|-------------|
| Single skill | < $1 |
| `/sprint` (full cycle) | $5-15 |
| `/security-scan` | $2-4 |

On Pro/Max/Team plans with included usage, this rarely matters.

---

## Built on

- **[superpowers](https://github.com/obra/superpowers)** — TDD discipline, subagent-driven development, multi-CLI architecture
- **[gstack](https://github.com/garrytan/gstack)** — Host config system, browser automation, safety guardrails
- **[compound-engineering](https://github.com/EveryInc/compound-engineering-plugin)** — Knowledge compounding philosophy

---

## Contributing

Add a skill in your domain. Each one needs a `SKILL.md` with frontmatter, numbered process, explicit rules, and defined deliverables. See [CONTRIBUTING.md](CONTRIBUTING.md).

---

## License

MIT
