# Changelog

All notable changes to Solo Squad will be documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.2.0] - 2026-05-03

Scope consolidation, native plugin manifests, skill standardization, and quality infrastructure. Solo Squad is now focused on 3 primary platforms with deeper integration.

### Added

- **5 new skills** — Quality & Learning division:
  - `/slop-scan` — AI-generated code quality detection (empty catches, redundant awaits, dead code, copy-paste smell). Pattern from garrytan/gstack.
  - `/learn` — Cross-session operational learning capture to `~/.solo-squad/learnings.jsonl`. Pattern from garrytan/gstack + EveryInc/compound-engineering.
  - `/health` — Weighted 0-10 codebase health score (coverage 30%, complexity 25%, duplication 20%, documentation 15%, test quality 10%). Pattern from garrytan/gstack.
  - `/scrape` — Structured data extraction via `curl` + `jq` with zero dependencies. Falls back to `/browse` for JS-rendered pages.
  - `/retro` — Data-driven sprint retrospective with metrics, root cause analysis, and action items. Pattern from garrytan/gstack.
- **Reality Checker agent** — Evidence-based certification agent that defaults to `NEEDS WORK`. Requires overwhelming proof for production readiness. Integrates `/qa` with agency-agents' reality-checker pattern.
- **Native Codex CLI plugin manifest** — `.codex-plugin/plugin.json` + `.agents/plugins/marketplace.json` for marketplace install (`codex plugin marketplace add efecanbasoz/solo-squad`).
- **Universal session-start preamble** — Update check, feature discovery (tip-of-the-day), project context recovery (recent designs, plans, learnings), and bootstrap injection. Supports Claude Code, Codex CLI, and OpenCode.
- **CI validation pipeline** — `.github/workflows/ci.yml` with frontmatter validation, agent validation, skill count checks, and stale reference detection. `tests/` contains 3 shell-based validators.

### Changed

- **Scope narrowed to 3 platforms** — Claude Code (primary), Codex CLI, OpenCode. Cursor, Gemini CLI, and Copilot CLI support removed to focus on native integration depth.
- **Skill frontmatter standardized** — All 40 skills now have `name`, `version: "2.2.0"`, `description` (trigger-only), and `triggers` (auto-trigger keywords).
- **DOT flowcharts added** to critical skills — `/brainstorm`, `/plan`, `/build`, `/review`, `/qa`, `/compound` now include executable process specifications as GraphViz `digraph` blocks.
- **Hard gates and rationalization tables** — `<HARD-GATE>` and `<SUBAGENT-STOP>` XML-style blocks prevent premature implementation. Red Flags tables counter common agent rationalizations.
- **Review format upgraded** — `/review` now uses 🔴 BLOCKER / 🟡 SUGGESTION / 💭 NIT markers with confidence calibration (100/75/50/25 rubric). "Explain why, not just what" and "praise good code" directives from agency-agents.
- **QA mindset shifted** — `/qa` defaults to `NEEDS WORK`, requires screenshot evidence, and auto-fails on fantasy assessments. Pattern from agency-agents/testing-reality-checker.
- **Build process hardened** — `/build` now enforces task-by-task QA validation (task PASS etmeden sonrakine geçilmez), max 3 retry, context isolation for subagents, and Agent Status Protocol (`DONE`, `DONE_WITH_CONCERNS`, `BLOCKED`, `NEEDS_CONTEXT`).
- **Incident Response expanded** — SRE framework integration: SLO definitions, error budgets, golden signals (latency, traffic, errors, saturation), observability stack, blameless post-mortems, game day planning.
- **Architect agent enriched** — ADR template, Architecture Selection Guide (Pattern / Use When / Avoid When), Quality Attribute Analysis.
- **OpenCode plugin enhanced** — AGENTS.md added to session context for richer bootstrap.
- **Tool mapping docs updated** — Codex CLI install now documents native plugin + marketplace paths. OpenCode docs updated for plugin registry install.
- **Skill count:** 35 → 40 (+5). Agents: 5 → 6 (+Reality Checker). Commands: 8 (unchanged).

### Removed

- `.cursor-plugin/` and `hooks/hooks-cursor.json` — Cursor support removed.
- `GEMINI.md` and `gemini-extension.json` — Gemini CLI support removed.
- `skills/using-solo-squad/references/copilot-tools.md` and `gemini-tools.md` — Copilot and Gemini tool mappings removed.
- `.local/` squads (marketing, sales, project) — Removed to focus on core.
- `scripts/bump-version.sh` no longer references removed manifests.

## [2.1.0] - 2026-04-19

Sprint 1 of the v2.x feature waves. Five upstream-inspired additions that tighten planning, lock down deploys, and put the human back in the loop when it matters.

### Added

- **Multi-phase plan review pipeline** — four new skills (`plan-ceo-review`, `plan-design-review`, `plan-eng-review`, `plan-devex-review`) and a new command `/autoplan` that orchestrates them with short-circuit rules and a consolidated action list. Each review has a single lens and a structured verdict. Pattern from garrytan/gstack.
- **Post-deploy verification suite** — three new skills: `canary` (drive critical flows on the new deploy, return PROCEED/HOLD/ROLLBACK within 10 minutes), `document-release` (diff-scan against previous tag, update CHANGELOG/README/API refs/migration notes), `land-and-deploy` (merge + deploy + canary + document-release + announce, single rollback seam). Pattern from garrytan/gstack.
- **HITL review-loop mode** — new skill `polish-beta` defines the canonical `approve | edit: <notes> | reject` protocol and handles last-mile polish between `/review` and `/land-and-deploy`. Pattern from EveryInc/compound-engineering-plugin.
- **HITL Checkpoints** declared in `/brainstorm`, `/plan`, `/build`, `/ship` — pauses activate with `--hitl` flag or `SOLO_SQUAD_HITL=1` environment variable. Default flow stays uninterrupted.
- **PR description hand-off pattern** in `/ship` — subagent drafts multi-KB PR bodies to a temp file; parent uses `--body-file` instead of round-tripping through context. Pattern from EveryInc/compound-engineering-plugin PR #593.
- **Context rot defense for `/ship`** — coverage audit, plan completion check, docs sync, and PR description drafting now dispatch as subagents. Parent only sees structured JSON conclusions. Pattern from garrytan/gstack v0.18.1 PR #1030.

### Changed

- `/ship` steps renumbered as clean integers; fractional sub-steps (e.g., `3.1`) explicitly forbidden to prevent silent skips under context rot.
- `/ship` now hands off to `/land-and-deploy` after PR is open and reviewed — ship no longer merges.
- `/plan` now points non-trivial plans to `/autoplan` for the full four-review gate; the existing three-lens quick check stays as a sanity step.
- `/sprint` pipeline extended: `… review → polish-beta → ship → land-and-deploy → document-release → compound`.
- `/sprint` now accepts `--hitl` to turn on in-phase checkpoints.
- Skill count: 27 → 35 (8 new). Commands: 7 → 8 (+`/autoplan`).

## [2.0.1] - 2026-04-15

Patch release focused on restoring OpenCode compatibility without changing Claude Code or Codex behavior.

### Fixed

- **OpenCode plugin compatibility** — updated `.opencode/plugins/solo-squad.js` to the current OpenCode server plugin API so the plugin loads correctly again
- **Skill discovery on OpenCode** — added `name` frontmatter to all shared `SKILL.md` files so OpenCode can register every skill while keeping the same files usable across other CLIs
- **OpenCode commands and subagents** — the plugin now registers workflow commands from `commands/` and subagents from `agents/` during config injection
- **OpenCode docs and install examples** — corrected the `plugin` config key, current tool mappings, and local install examples in the README and reference docs

### Changed

- Updated contribution and shared context docs to document the cross-CLI `name` + `description` skill frontmatter convention

## [2.0.0] - 2026-04-15

Major restructure: 6-platform multi-CLI support, flattened architecture, focused scope.

### Breaking Changes

- **Structure flattened** — removed squad-per-plugin architecture. All skills, agents, and commands now live at root level (`skills/`, `agents/`, `commands/`).
- **Squads removed from public release** — marketing, project, and sales squads moved to `.local/` (gitignored). Coding, design, and security remain.
- **"engineering" renamed to "coding"** — reflects broader scope beyond traditional engineering.

### Added

- **Multi-CLI support** — Solo Squad now works on 6 platforms:
  - **Claude Code**: `.claude-plugin/plugin.json` + `marketplace.json` for native plugin install
  - **Codex CLI**: `.codex/INSTALL.md` — clone + symlink, with Windows junction support
  - **OpenCode**: `.opencode/plugins/solo-squad.js` — ESM plugin with skill discovery and session bootstrap
  - **Cursor**: `.cursor-plugin/plugin.json` — native plugin with skills, agents, commands, hooks
  - **Gemini CLI**: `GEMINI.md` + `gemini-extension.json` — native extension
  - **Copilot CLI**: shares `.claude-plugin/` manifest, native plugin install
  - `AGENTS.md` — shared instruction file for Codex and Copilot (identical to CLAUDE.md)
  - `package.json` — npm entry point for OpenCode plugin installation
- **Tool mapping references** for each platform:
  - `skills/using-solo-squad/references/codex-tools.md`
  - `skills/using-solo-squad/references/opencode-tools.md`
  - `skills/using-solo-squad/references/gemini-tools.md`
  - `skills/using-solo-squad/references/copilot-tools.md`
- **Bootstrap skill** (`skills/using-solo-squad/SKILL.md`) — loaded at session start, provides full skill/agent/command reference
- **Platform-detecting session-start hook** — single bash script that outputs the correct JSON format for Claude Code, Codex, OpenCode, Cursor, Gemini CLI, and Copilot CLI
- **Windows support** — `hooks/run-hook.cmd` polyglot wrapper (batch + bash), Windows install instructions for Codex CLI
- **Cursor hooks** — `hooks/hooks-cursor.json` with `CURSOR_PLUGIN_ROOT` paths
- **Unified hooks** — merged 3 squad-specific hook configs into one `hooks/hooks.json` with SessionStart, PreToolUse, and PostToolUse events
- `CLAUDE.md` — project context file for Claude Code

### Changed

- Skills, agents, and commands unchanged in content — only moved from `plugins/{squad}/` to root level
- Hook scripts renamed for clarity: `tdd-reminder.sh`, `brand-check.sh`, `destructive-warning.sh`
- `scripts/bump-version.sh` now updates all 5 manifest files (package.json, plugin.json, marketplace.json, cursor plugin.json, gemini-extension.json)

### Removed

- Per-squad `.claude-plugin/plugin.json` files
- Per-squad `hooks/hooks.json` files
- `plugins/` directory structure

## [1.2.0] - 2026-04-08

Major release: from skill collection to coordinated agency operating system.

### Added

- **NEXUS Orchestration** — cross-squad coordination with 3 operating modes:
  - NEXUS-Full: 7-phase lifecycle with quality gates and handoff protocols
  - NEXUS-Sprint: compressed 4-phase pipeline for focused projects
  - NEXUS-Micro: rapid scope-build-ship for urgent tasks
  - `/orchestrate` command as entry point with scenario runbooks
  - Orchestrator agent managing multi-squad pipelines
- **Client Context System** — persistent client intelligence across sessions
  - `/client-context` skill: init, load, save, list operations
  - 4 context files per client: company profile, brand, history, active projects
  - Context loaded at session start, updated after significant work
- **18 new skills across all squads:**
  - Engineering: technical-writing, devops-pipeline, database-optimization, workflow-mapping, developer-advocacy
  - Marketing: growth-hacking, search-query-analysis, paid-social, programmatic-media, app-store-optimization, video-optimization
  - Project: executive-summary, product-strategy, analytics-reporting, document-generation
  - Sales: technical-demo
  - Security: incident-response, legal-compliance
- **Sales Engineer agent** — technical pre-sales specialist for demos, POCs, and battlecards
- **MEDDPICC command** — standalone 5-minute deal scoring tool
- **Design system starter templates** — SaaS, marketing site, and e-commerce presets

### Changed

- **All 13 agents enriched** with standard template: Expertise, Decision Framework, Behavioral Directives, Deliverables sections
- **18 existing skills improved** with deeper process definitions:
  - review: BLOCKER/SUGGESTION/NIT classification, single-pass rule
  - investigate: hypothesis logging, escalation path
  - build: two-stage review detail, commit standards
  - seo-audit: topical clusters, SERP features, cannibalization detection
  - social-strategy: per-platform algorithm mechanics
  - paid-audit: severity ratings with financial impact projections
  - content-plan: repurposing framework, distribution matrix
  - ux-research: execution steps (recruit, facilitate, analyze)
  - brand-check: no-guidelines reverse-engineering path
  - image-prompts: photography technical reference
  - deal-strategy: competitive tactics, reframes, ghosting recovery
  - discovery-prep: current-state mapping, gap quantification
  - proposal: SCQA executive summary craft
  - feedback-synthesis: quantification framework
  - status-report: trend arrows, client/team action separation
  - cso: supply chain security, zero-trust checklist
  - benchmark: load/stress/endurance testing, capacity planning
  - ai-citation: entity clarity audit, citation pattern tracking
- **Smart hooks** — all squads upgraded from generic reminders to context-aware shell scripts that check file type, path, and content before firing

## [1.0.0] - 2026-04-07

Initial release.

### Added

- Marketplace catalog at `.claude-plugin/marketplace.json` with six plugin entries
- **Engineering Squad** (`engineering-squad`): 8 skills, 3 commands, 3 agents, 1 hook
  - Skills: brainstorm, plan, build, review, qa, ship, compound, investigate
  - Commands: /sprint, /hotfix, /tdd
  - Agents: Architect, Tester, Debugger
- **Marketing Squad** (`marketing-squad`): 8 skills, 3 commands, 3 agents, 1 hook
  - Skills: seo-audit, ppc-strategy, social-strategy, content-plan, ad-creative, tracking-audit, paid-audit, ai-citation
  - Commands: /client-audit, /monthly-report, /campaign-launch
  - Agents: SEO Analyst, Media Buyer, Content Strategist
- **Sales Squad** (`sales-squad`): 6 skills, 2 commands, 2 agents, 1 hook
  - Skills: outbound, discovery-prep, deal-strategy, proposal, pipeline-review, account-plan
  - Commands: /deal-review, /prep-call
  - Agents: Closer, Researcher
- **Design Squad** (`design-squad`): 5 skills, 2 commands, 1 agent, 1 hook
  - Skills: design-system, design-review, ux-research, brand-check, image-prompts
  - Commands: /design-sprint, /asset-gen
  - Agents: Design Critic
- **Project Squad** (`project-squad`): 6 skills, 3 commands, 1 agent, 1 hook
  - Skills: client-kickoff, sprint-plan, status-report, experiment-track, feedback-synthesis, retro
  - Commands: /standup, /weekly-sync, /onboard
  - Agents: Studio Producer
- **Security Squad** (`security-squad`): 7 skills, 2 commands, 1 agent, 1 hook
  - Skills: cso, browse, benchmark, careful, freeze, guard, codex-review
  - Commands: /lockdown, /security-scan
  - Agents: Sentinel
- Documentation for each squad in `docs/squads/`
- MIT License
- CONTRIBUTING.md

### Known limitations

- Browser automation in `/browse` is minimal compared to dedicated headless browser tools
- Hooks fire generic reminders rather than context-aware suggestions
- Agent tool permissions are generic and need tightening per role
- No unit tests on skill structures yet
