# Changelog

All notable changes to Solo Squad will be documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2026-04-15

Major restructure: multi-CLI support, flattened architecture, focused scope.

### Breaking Changes

- **Structure flattened** — removed squad-per-plugin architecture. All skills, agents, and commands now live at root level (`skills/`, `agents/`, `commands/`).
- **Marketplace removed** — single plugin manifest replaces the marketplace + per-squad plugin.json pattern.
- **Squads removed from public release** — marketing, project, and sales squads moved to `.local/` (gitignore). Coding, design, and security remain.
- **"engineering" renamed to "coding"** — reflects broader scope beyond traditional engineering.

### Added

- **Multi-CLI support** — Solo Squad now works on Claude Code, Codex CLI, and OpenCode:
  - `.codex/INSTALL.md` — Codex CLI installation via symlink
  - `.opencode/plugins/solo-squad.js` — OpenCode ESM plugin with skill discovery and session bootstrap
  - `AGENTS.md` — instruction file for Codex and OpenCode (identical to CLAUDE.md)
  - `package.json` — npm entry point for OpenCode plugin installation
- **Bootstrap skill** (`skills/using-solo-squad/SKILL.md`) — loaded at session start, provides full skill/agent/command reference
- **Tool mapping references** — platform-specific tool equivalence tables:
  - `skills/using-solo-squad/references/codex-tools.md`
  - `skills/using-solo-squad/references/opencode-tools.md`
- **Platform-detecting session-start hook** — single bash script that outputs the correct JSON format for Claude Code, Codex, OpenCode, Cursor, and Copilot CLI
- **Unified hooks** — merged 3 squad-specific hook configs into one `hooks/hooks.json` with SessionStart, PreToolUse, and PostToolUse events
- `CLAUDE.md` — project context file for Claude Code

### Changed

- Skills, agents, and commands unchanged in content — only moved from `plugins/{squad}/` to root level
- Hook scripts renamed for clarity: `tdd-reminder.sh`, `brand-check.sh`, `destructive-warning.sh`
- Version bumped to 2.0.0 across all manifests

### Removed

- `.claude-plugin/marketplace.json` — no longer needed (single plugin)
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
- **18 existing skills improved** with Agency Agents insights:
  - review: BLOCKER/SUGGESTION/NIT classification, single-pass rule
  - investigate: hypothesis logging, escalation path
  - build: two-stage review detail, commit standards
  - ai-citation: entity clarity audit, citation pattern tracking
  - seo-audit: topical clusters, SERP features, cannibalization detection
  - social-strategy: per-platform algorithm mechanics
  - paid-audit: severity ratings with financial impact projections
  - content-plan: repurposing framework, distribution matrix
  - ux-research: execution steps (recruit, facilitate, analyze)
  - brand-check: no-guidelines reverse-engineering path
  - image-prompts: photography technical reference
  - deal-strategy: competitive tactics, Challenger reframes, ghosting
  - discovery-prep: current-state mapping, gap quantification
  - proposal: SCQA executive summary craft
  - feedback-synthesis: quantification framework
  - status-report: trend arrows, client/team action separation
  - cso: supply chain security, zero-trust checklist
  - benchmark: load/stress/endurance testing, capacity planning
- **Smart hooks** — all 6 squads upgraded from generic reminders to context-aware shell scripts that check file type, path, and content before firing
- **Version bumped** to 1.2.0 across all manifests

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

- Browser automation in `/browse` is minimal compared to gstack equivalents
- Hooks fire generic reminders rather than context-aware suggestions
- Agent tool permissions are generic and need tightening per role
- No unit tests on skill structures yet
- Campaign-ops deliverable formats will evolve based on real client audit feedback
