# Solo Squad

> One developer with AI ships like a team of twenty.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude_Code-Plugin-blueviolet)](https://docs.anthropic.com/en/docs/claude-code)
[![Codex CLI](https://img.shields.io/badge/Codex_CLI-Plugin-green)](https://github.com/openai/codex)
[![OpenCode](https://img.shields.io/badge/OpenCode-Plugin-orange)](https://github.com/sst/opencode)

**27 skills + 6 workflow commands** that turn AI agents into disciplined engineers. Each skill is a battle-tested process with **DOT flowcharts**, **hard gates**, and **anti-slop defenses** — so your agent follows the playbook instead of improvising.

**Zero dependencies.** Pure markdown + shell scripts. Install in 10 seconds.

---

## Install

No dependencies. No build step. Pure markdown + shell scripts.

### Claude Code (Recommended)

#### Marketplace Install (Recommended)

```bash
claude plugins marketplace add https://github.com/efecanbasoz/solo-squad
claude plugins install solo-squad
```

Reload to activate:

```
/reload-plugins
```

#### Manual Install

```bash
git clone https://github.com/efecanbasoz/solo-squad ~/.claude/solo-squad
```

Then add to your Claude Code plugins directory. Skills are auto-discovered from `.claude-plugin/plugin.json`.

### Codex CLI

#### Marketplace Install (Recommended)

```bash
codex plugin marketplace add efecanbasoz/solo-squad
codex plugins install solo-squad
```

Or add the marketplace manually:

```bash
# Clone the repo
git clone https://github.com/efecanbasoz/solo-squad ~/.codex/solo-squad

# Add the marketplace
cp ~/.codex/solo-squad/.agents/plugins/marketplace.json ~/.agents/plugins/solo-squad-marketplace.json
```

Restart Codex to discover the plugin.

#### Manual Install (Legacy)

```bash
git clone https://github.com/efecanbasoz/solo-squad ~/.codex/solo-squad
mkdir -p ~/.agents/skills
ln -s ~/.codex/solo-squad/skills ~/.agents/skills/solo-squad
```

To enable subagent dispatch for skills like `/build` and `/sprint`, add to `~/.codex/config.toml`:

```toml
[features]
multi_agent = true
```

### OpenCode

#### Plugin Registry Install (Recommended)

```bash
opencode plugin "solo-squad@git+https://github.com/efecanbasoz/solo-squad.git" --global
```

Or add it manually to your `opencode.json`:

```json
{
  "plugin": ["solo-squad@git+https://github.com/efecanbasoz/solo-squad.git"]
}
```

#### Manual Install

```bash
git clone https://github.com/efecanbasoz/solo-squad ~/.config/opencode/solo-squad
```

Then add to `opencode.json`:

```json
{
  "plugin": ["/absolute/path/to/solo-squad"]
}
```

The JS plugin at `.opencode/plugins/solo-squad.js` registers skills, workflow commands, and subagents automatically, then injects session context on the first user message.

### Updating

Each platform picks up updates differently:

| Platform | Update command |
|----------|---------------|
| Claude Code | `claude plugins update solo-squad` |
| Codex CLI | `codex plugin marketplace upgrade` or `cd ~/.codex/solo-squad && git pull` |
| OpenCode | Remove + re-add in `opencode.json` (auto-fetches latest) |

### Uninstalling

| Platform | Uninstall command |
|----------|------------------|
| Claude Code | `claude plugins uninstall solo-squad` |
| Codex CLI | `codex plugins uninstall solo-squad` |
| OpenCode | Remove from `opencode.json` |

---

## What makes this different

Most AI coding plugins give you vague prompts. Solo Squad gives you **processes agents can't skip**.

| Other plugins | Solo Squad |
|---------------|------------|
| Vague instructions | **DOT flowcharts** — agents follow structured diagrams, not prose |
| Agents skip steps | **Hard gates** (`<HARD-GATE>`, `<SUBAGENT-STOP>`) — behavioral boundaries that can't be rationalized away |
| "Looks good to me" reviews | **Confidence calibration** — every finding rated 100/75/50/25. Only 8/10+ gets reported. Zero noise. |
| Generic code review | **Evidence-based certification** — Reality Checker defaults to `NEEDS WORK`. Overwhelming proof required for `READY`. |
| No memory between sessions | **Persistent learnings** — `/compound` and `/learn` capture patterns to `~/.solo-squad/learnings.jsonl` so your agent gets smarter over time |
| Hidden dependencies | **Zero dependencies** — pure markdown + shell scripts. No npm install, no compiled binaries, no Docker. |
| "AI slop" in output | **Anti-slop scan** — `/slop-scan` catches empty catches, redundant awaits, dead code, and copy-paste smell before review |

**The result:** Your agent actually follows the process. No more skipped tests, no more "looks good to me" on broken code, no more hallucinated deployments.

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

  Continue to /autoplan? [y/N]

You: y

Solo Squad:
  === AUTOPLAN VERDICT ===
  Overall: PROCEED

  CEO:    CLEAR — Scope matches the user problem
  Design: PASS  — Main UI flow is covered
  Eng:    CLEAR — Data flow and reconnect edge cases are explicit
  DevEx:  PASS  — Local verification path is straightforward

  → /build

[Subagents execute each task with TDD — 25 min]

Solo Squad: Build complete. 12/12 tasks, 94% coverage.
  → /review

  Multi-lens review:
    🔴 BLOCKER: Race condition in WebSocket reconnect (auto-fixed)
    🟡 SUGGESTION: Extract toast queue into custom hook
    💭 NIT: Inconsistent error message casing

  → /polish-beta

  ⏸ POLISH #1 — docs/notifications.md:42
  Current:  "Alerts are send instantly"
  Proposed: "Alerts are sent instantly"
  Reply: apply

You: apply

Solo Squad:
  ✓ Polish applied
  → /ship

  ✓ Tests passing (47/47)
  ✓ Coverage: 94% (threshold: 80%)
  ✓ PR opened: feat(notifications): add real-time alert system

[Review approved]

Solo Squad:
  → /land-and-deploy

  ✓ Merge complete
  ✓ Deploy ready: https://example.vercel.app
  ✓ Canary: PROCEED
  ✓ Docs synced: CHANGELOG.md, README.md
  → /compound
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
  Brand Alignment:   4/10  — off-brand colors in new components
  AI Slop Detection: CLEAN — no generic stock patterns detected

  Top fix: Unify border-radius to design token --radius-md
  Before/after diff generated.
```

---

## What's inside

### Development — 16 skills, 5 agents

| Skill | Your specialist |
|-------|----------------|
| `/brainstorm` | 💡 Product partner who challenges your assumptions |
| `/plan` | 🗺️ Architect who breaks work into 2-5 min tasks with file paths |
| `/plan-review` | 🔍 Multi-lens review: CEO, Design, Eng, DevEx in one pass |
| `/build` | 🔨 Lead engineer dispatching subagents with TDD enforcement |
| `/review` | 👁️ Senior reviewer classifying 🔴 BLOCKER / 🟡 SUGGESTION / 💭 NIT |
| `/qa` | 🧪 QA lead running real browser tests, filing bugs, writing regression tests |
| `/polish-beta` | ✨ HITL polish pass for copy, microcopy, and last-mile release quality |
| `/ship` | 🚀 Release engineer: tests, coverage audit, PR open, deploy handoff |
| `/land-and-deploy` | 🎯 Release owner who merges, deploys, canaries, and verifies health |
| `/canary` | 🐤 Post-deploy verifier for critical flows, console errors, and perf regressions |
| `/document-release` | 📝 Docs steward syncing CHANGELOG, README, API docs, and migration notes |
| `/compound` | 🧠 Knowledge curator capturing patterns for next time |
| `/investigate` | 🔎 Debugger who traces data flow and logs hypotheses |
| `/technical-writing` | 📚 Tech writer: README, API docs, migration guides |
| `/devops-pipeline` | ⚙️ DevOps engineer: CI/CD, IaC, zero-downtime deploys |
| `/database-optimization` | 🗄️ DBA: query plans, indexing, N+1 detection |

**Agents:** Architect (designs, never implements) · Tester (edge cases, screenshot evidence) · Debugger (read-only investigator) · Sentinel (security review, 8/10+ confidence gate) · Reality Checker (evidence-based certification, default NEEDS WORK)

### Design — 3 skills, 1 agent

| Skill | Your specialist |
|-------|----------------|
| `/design-system` | 🎨 Design lead building tokens, components, patterns from scratch |
| `/design-review` | 🖼️ Critic with AI slop detection, 0-10 scoring, and brand alignment |
| `/ux-research` | 🔬 Researcher: test scripts, personas, journey maps |

**Agent:** Design Critic (detects AI slop, scores craft, severity classification)

### Security — 2 skills, 1 agent

| Skill | Your specialist |
|-------|----------------|
| `/cso` | 🛡️ Security officer: OWASP + STRIDE + supply chain + zero-trust |
| `/benchmark` | ⚡ Performance engineer: Core Web Vitals, load testing, capacity planning |

**Agent:** Sentinel (read-only security review, 8/10+ confidence gate)

### Quality & Learning — 5 skills

| Skill | Your specialist |
|-------|----------------|
| `/slop-scan` | 🧹 AI slop detector: catches empty catches, redundant awaits, dead code, copy-paste smell |
| `/learn` | 📖 Knowledge engineer: captures cross-session operational learnings |
| `/health` | 🏥 Code health monitor: weighted 0-10 score for coverage, complexity, duplication, docs |
| `/scrape` | 🔧 Data extractor: structured data from web pages via curl + jq |
| `/retro` | 📊 Sprint retrospective: what worked, what didn't, data-driven action items |

### Workflow commands

Chain skills into end-to-end pipelines:

| Command | What happens |
|---------|-------------|
| `/autoplan` | 🔍 Multi-lens plan review before `/build` |
| `/sprint` | 💡 brainstorm → plan → build → review → qa → polish-beta → ship → land-and-deploy → document-release → compound |
| `/hotfix` | 🔥 investigate → fix → review → ship |
| `/tdd` | 🧪 red → green → refactor (enforced) |
| `/design-sprint` | 🎨 research → design system → review → iterate |
| `/security-scan` | 🛡️ OWASP + STRIDE + dependency audit |

---

## How it works

Each skill is a **structured process** — numbered steps, decision criteria, quality gates, explicit deliverables, and DOT flowcharts. Your agent follows the playbook instead of improvising.

```
skills/
├── brainstorm/SKILL.md     ← Role + Process + Rules + Deliverables + DOT Flowchart
├── plan/SKILL.md
├── build/SKILL.md
├── ...
agents/
├── architect.md            ← Persona + Expertise + Decision Framework
├── tester.md
├── reality-checker.md      ← Evidence-based certification, default NEEDS WORK
├── ...
commands/
├── sprint.md               ← Skill chain with human approval gates
├── hotfix.md
├── ...
hooks/
├── session-start           ← Universal bootstrap with feature discovery
├── hooks.json              ← SessionStart + PreToolUse + PostToolUse
```

Skills are written in **SKILL.md** with `name`, `description`, `version`, and `triggers` frontmatter — the universal format across all supported CLIs. Write once, run anywhere.

---

## Multi-CLI support

| Feature | Claude Code | Codex CLI | OpenCode |
|---------|:-----------:|:---------:|:--------:|
| Skills | Native (marketplace) | Native (plugin) | Native (plugin) |
| Agents | Native | With `multi_agent` | Native (plugin) |
| Hooks | Full (SessionStart + Pre/Post) | SessionStart + Pre/Post | Via JS plugin |
| Commands | Native | Native (plugin) | Native (plugin) |

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

- **[superpowers](https://github.com/obra/superpowers)** — TDD discipline, subagent-driven development, multi-CLI architecture, DOT flowcharts, rationalization tables
- **[gstack](https://github.com/garrytan/gstack)** — Host config system, browser automation, safety guardrails, persistent memory
- **[compound-engineering](https://github.com/EveryInc/compound-engineering-plugin)** — Knowledge compounding philosophy, converter architecture
- **[agency-agents](https://github.com/msitarzewski/agency-agents)** — Evidence-based certification, SRE frameworks, code review formats, orchestration patterns

---

## Contributing

Add a skill in your domain. Each one needs a `SKILL.md` with frontmatter, numbered process, explicit rules, defined deliverables, and a DOT flowchart. See [CONTRIBUTING.md](CONTRIBUTING.md).

---

## License

MIT
