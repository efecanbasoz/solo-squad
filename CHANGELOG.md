# Changelog

All notable changes to Solo Squad will be documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
