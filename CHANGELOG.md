# Changelog

All notable changes to Solo Squad will be documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
