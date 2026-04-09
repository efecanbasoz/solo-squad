# Changelog

All notable changes to Solo Squad will be documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
