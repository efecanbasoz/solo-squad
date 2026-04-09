# Solo Squad

> A squad of specialists for the solo operator.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Claude Code Plugin](https://img.shields.io/badge/Claude_Code-Plugin-blueviolet)](https://docs.anthropic.com/en/docs/claude-code)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

**6 squads. 60+ skills. 13 agents. One operator.**

Solo Squad is a Claude Code plugin marketplace that turns one person into a full agency. Engineering, marketing, sales, design, project management, and security — each squad has specialists who do one job well, and NEXUS orchestrates them all on a single client engagement.

---

## How it works

```
You have an idea or a client request
        │
        ▼
┌─────────────────────────────────────────────────────┐
│                    /orchestrate                      │
│                                                      │
│   NEXUS-Full         NEXUS-Sprint      NEXUS-Micro   │
│   (4-12 weeks)       (2-6 weeks)       (1-5 days)   │
│                                                      │
│   Discovery          Discover+Plan     Scope         │
│   Strategy           Build+Review      Build         │
│   Foundation         Harden+Ship       Ship          │
│   Build              Launch                          │
│   Hardening                                          │
│   Launch                                             │
│   Operate                                            │
└─────────────────────┬───────────────────────────────┘
                      │
        ┌─────────────┼─────────────┐
        ▼             ▼             ▼
  Engineering    Marketing     Design
  Sales          Project       Security
```

Each squad contributes its skills at the right phase. Quality gates between phases prevent broken work from advancing. Handoff protocols preserve context so nothing gets lost.

---

## Install

```
/plugin marketplace add efecanbasoz/solo-squad
/plugin install engineering-squad@solo-squad marketing-squad@solo-squad sales-squad@solo-squad design-squad@solo-squad project-squad@solo-squad security-squad@solo-squad
```

Or install only what you need today:

```
/plugin marketplace add efecanbasoz/solo-squad
/plugin install engineering-squad@solo-squad
```

---

## See it work

### A full marketing audit in 14 minutes

```
You: /client-audit https://acmewidgets.com

Solo Squad: Running full marketing audit. This dispatches:
  /seo-audit + /tracking-audit + /paid-audit + /social-strategy + /ai-citation
  Estimated time: 15-20 min. Estimated tokens: ~$2-4.
  Continue? [y/N]

You: y

[14 minutes later]

Solo Squad:

  SEO Audit: 6.2/10
    - Sitemap missing 47% of product pages
    - 12 broken redirect chains
    - LCP at 4.8s (target: under 2.5s)

  Tracking Audit:
    - Google Ads conversion firing 2x on thank-you page
    - Meta Pixel missing on checkout step
    - No CAPI for Meta — losing iOS attribution

  Paid Audit: 142/200 (Grade C)
    - Branded and non-branded mixed in same campaign
    - Wasted spend estimate: $1,840/month on irrelevant search terms

  Top 3 quick wins:
    1. Fix Meta CAPI + remove duplicate Google conversion
    2. Restructure paid campaigns + add negatives (~$1,800/mo recovered)
    3. Fix sitemap + redirects (unblocks indexing)

  Full report saved: ./reports/acmewidgets-audit.md
```

### NEXUS orchestrating a client website rebuild

```
You: /orchestrate

Solo Squad: Select NEXUS mode:
  1. Full (4-12 weeks) — complete lifecycle, all squads
  2. Sprint (2-6 weeks) — compressed, focused scope
  3. Micro (1-5 days) — rapid scope-build-ship

You: 1

Solo Squad: Loading client context for "acme-widgets"...
  Company: Acme Widgets (e-commerce, Shopify Plus)
  Last engagement: SEO audit (2026-03-15)
  Active project: website rebuild

  Pipeline: Discovery → Strategy → Foundation → Build → Hardening → Launch → Operate
  Estimated skills: 25+ across 6 squads
  Proceeding to Phase 0: Discovery. Continue? [y/N]

You: y

Solo Squad: [Phase 0: Discovery]
  Dispatching: /brainstorm + /ux-research + /seo-audit
  ...
  Quality Gate: ✓ Problem validated, ✓ Success criteria defined, ✓ Risks identified
  → Advancing to Phase 1: Strategy
```

---

## The six squads

| Squad | Skills | Agents | Focus |
|-------|--------|--------|-------|
| [Engineering](docs/squads/engineering.md) | 13 | 3 | Build, test, ship, debug |
| [Marketing](docs/squads/marketing.md) | 14 | 3 | SEO, PPC, social, content, growth |
| [Design](docs/squads/design.md) | 5 | 1 | Systems, reviews, research, brand |
| [Project](docs/squads/project.md) | 13 | 2 | NEXUS, client context, reporting |
| [Sales](docs/squads/sales.md) | 7 | 3 | Pipeline, deals, demos, proposals |
| [Security](docs/squads/security.md) | 9 | 1 | Audits, incidents, compliance |

<details>
<summary><strong>Engineering Squad</strong> — 13 skills, 3 agents</summary>

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

**Agents:** Architect (designs, never implements), Tester (edge cases, screenshot evidence), Debugger (read-only investigator)

</details>

<details>
<summary><strong>Marketing Squad</strong> — 14 skills, 3 agents</summary>

| Skill | What it does |
|-------|-------------|
| `/seo-audit` | Technical audit, topical clusters, SERP features |
| `/ppc-strategy` | Campaign architecture, bidding, audiences |
| `/social-strategy` | Cross-platform organic with algorithm mechanics |
| `/content-plan` | Editorial calendar, repurposing framework |
| `/ad-creative` | RSA, Meta copy, Performance Max assets |
| `/tracking-audit` | GTM, GA4, CAPI, attribution models |
| `/paid-audit` | 200+ points, severity-rated with financial impact |
| `/ai-citation` | Brand visibility in ChatGPT, Claude, Gemini, Perplexity |
| `/growth-hacking` | Funnel optimization, viral loops, CAC/LTV |
| `/search-query-analysis` | Query mining, negative keywords, waste elimination |
| `/paid-social` | Meta, LinkedIn, TikTok, Pinterest paid campaigns |
| `/programmatic-media` | GDN, DV360, ABM display |
| `/app-store-optimization` | ASO for iOS and Google Play |
| `/video-optimization` | YouTube SEO, retention, thumbnails |

**Agents:** SEO Analyst (crawl budgets, topical authority), Media Buyer (ROAS, incrementality), Content Strategist (distribution-first)

</details>

<details>
<summary><strong>Design Squad</strong> — 5 skills, 1 agent</summary>

| Skill | What it does |
|-------|-------------|
| `/design-system` | Tokens, components, patterns + starter templates (SaaS, marketing, e-commerce) |
| `/design-review` | AI slop detection, 0-10 scoring, before/after fixes |
| `/ux-research` | Study design through execution with analysis frameworks |
| `/brand-check` | Exact color/font matching, reverse-engineering when no guidelines exist |
| `/image-prompts` | Midjourney, DALL-E, Flux prompts with photography reference |

**Agent:** Design Critic (detects AI slop, scores craft, severity classification)

</details>

<details>
<summary><strong>Project Squad</strong> — 13 skills, 2 agents</summary>

| Skill | What it does |
|-------|-------------|
| `/nexus-full` | 7-phase pipeline with quality gates |
| `/nexus-sprint` | Compressed 4-phase pipeline |
| `/nexus-micro` | Rapid scope-build-ship |
| `/client-context` | Persistent client profiles across sessions |
| `/executive-summary` | C-suite briefings, SCQA framework |
| `/product-strategy` | Discovery, roadmap, GTM, OKRs |
| `/analytics-reporting` | Dashboards, KPIs, attribution |
| `/document-generation` | PDF, PPTX, DOCX automation |
| `/client-kickoff` | Onboarding, charter, communication plan |
| `/sprint-plan` | Multi-client capacity and prioritization |
| `/status-report` | KPI trends, milestones, action items |
| `/experiment-track` | A/B tests, hypothesis tracking |
| `/feedback-synthesis` | Theme extraction, priority scoring |

**Agents:** Orchestrator (NEXUS pipeline manager), Studio Producer (capacity, timelines, dependencies)

</details>

<details>
<summary><strong>Sales Squad</strong> — 7 skills, 3 agents</summary>

| Skill | What it does |
|-------|-------------|
| `/outbound` | Signal-based prospecting, multi-channel sequences |
| `/discovery-prep` | SPIN/Gap/Sandler frameworks, gap quantification |
| `/deal-strategy` | MEDDPICC scoring, competitive tactics, ghosting |
| `/proposal` | Win themes, SCQA executive summary, pricing |
| `/pipeline-review` | Velocity, conversion, risk-adjusted forecast |
| `/account-plan` | Land-and-expand, QBR prep, renewal strategy |
| `/technical-demo` | Demo engineering, POC scoping, battlecards |

**Agents:** Closer (BATNA/ZOPA, walk-away criteria), Researcher (10-min prospecting), Sales Engineer (demos, POCs)

</details>

<details>
<summary><strong>Security Squad</strong> — 9 skills, 1 agent</summary>

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

**Agent:** Sentinel (read-only security review, 8/10+ confidence gate)

</details>

---

## NEXUS Orchestration

NEXUS coordinates all six squads on a single engagement. Three operating modes, four scenario runbooks.

| Mode | Duration | Use when |
|------|----------|----------|
| **Full** | 4-12 weeks | Major projects, new client engagements |
| **Sprint** | 2-6 weeks | Focused projects with clear scope |
| **Micro** | 1-5 days | Urgent tasks, hotfixes, incidents |

**Quality gates** between each phase prevent broken work from advancing. **Handoff protocols** preserve context across phase boundaries. **Scenario runbooks** pre-configure the pipeline for common situations:

1. **Client Website Rebuild** — Full mode, all squads
2. **New Feature Sprint** — Full mode, engineering + design
3. **Marketing Campaign** — Sprint mode, marketing + design + project
4. **Production Incident** — Micro mode, engineering + security

---

## Client Context

Persistent client intelligence that carries across sessions. Initialize once, load at the start of every session.

```
/client-context init acme-widgets    # create profile
/client-context load acme-widgets    # load into session
/client-context save                 # update after work
```

Four files per client: company profile, brand guidelines, engagement history, active projects. Every skill benefits from loaded context — the SEO analyst knows the industry, the proposal writer knows past engagements, the orchestrator knows current project state.

---

## Real-world use cases

**Account takeover (agency):** New client signs. Run `/client-context init` → `/client-audit` → `/proposal` with findings. Day one: you have a scored audit, an action plan, and a proposal. That used to take a week.

**Feature sprint (product):** PM writes a spec. Run `/orchestrate` in Sprint mode → Discovery+Plan → Build+Review → Harden+Ship. Engineering, design, and security squads coordinate through quality gates. Two weeks, not six.

**Monthly reporting (ongoing):** Load client context → `/status-report` + `/analytics-reporting` + `/experiment-track`. Cross-channel performance, KPI trends, experiment results, and recommendations — all in one pass.

**Emergency (production):** Something breaks. `/orchestrate` in Micro mode → `/investigate` → fix → `/incident-response` post-mortem. Service restored, root cause documented, runbook created.

**Deal qualification (sales):** Discovery call at 2pm. Run `/prep-call` for research and agenda → after the call, `/meddpicc` for qualification scoring → `/deal-strategy` for the win plan. Pipeline stays clean.

---

## Why Solo Squad

Three projects already do parts of this well.

[Superpowers](https://github.com/obra/superpowers) has the most disciplined engineering methodology. [gstack](https://github.com/garrytan/gstack) has the most feature-complete dev tools. [Compound Engineering](https://github.com/EveryInc/compound-engineering-plugin) has the best knowledge-capture philosophy.

Solo Squad exists because none of them help when you need to audit a client's Google Ads account at 10am, prep for a discovery call at 2pm, score a deal with MEDDPICC at 4pm, and write next month's content calendar before end of day. **If you only need engineering, the older projects are better. If you run an agency solo, this is what that looks like.**

---

## What's solid, what's rough

**Solid:** All six squads are battle-tested on real client work. **60+ skills** with detailed processes and deliverables. **13 enriched agents** with standardized decision frameworks and behavioral directives. **NEXUS orchestration** coordinates multi-squad pipelines with quality gates. **Context-aware hooks** that only fire when relevant. **Persistent client context** across sessions.

**Rough:** Browser automation in `/browse` needs work to match gstack. No unit tests on skill structures yet. NEXUS handoff protocols will evolve with real multi-squad usage. Some marketing skill deliverable formats are still maturing.

---

## Cost warning

Solo Squad runs subagent-driven workflows. Token usage is higher than typical Claude Code.

| Workflow | Typical cost |
|----------|-------------|
| Single skill (e.g., `/seo-audit`) | < $1 |
| `/client-audit` (5 skills) | $2-4 |
| `/sprint` (full cycle) | $5-15 |
| NEXUS-Full (multi-phase) | $15-50+ |

On Claude Pro or Max with included usage, this rarely matters. On the API directly, watch your bill the first week.

---

## Contributing

Solo Squad accepts PRs for new skills, command improvements, agent refinements, and bug fixes. The fastest way to contribute is to add a skill in your domain. Each skill needs a `SKILL.md` with frontmatter, a numbered process, explicit rules, and defined deliverables. See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

---

## Built on the shoulders of giants

- [obra/superpowers](https://github.com/obra/superpowers) by Jesse Vincent — TDD methodology, subagent-driven development, systematic debugging
- [garrytan/gstack](https://github.com/garrytan/gstack) by Garry Tan — Browser automation, security audits, deploy pipelines, safety guardrails
- [EveryInc/compound-engineering-plugin](https://github.com/EveryInc/compound-engineering-plugin) by Every — Knowledge compounding philosophy, cross-platform converters
- [msitarzewski/agency-agents](https://github.com/msitarzewski/agency-agents) by Mike Sitarzewski — 200+ specialist agent personas across 12 divisions, NEXUS orchestration concepts

---

## License

MIT. Use it, fork it, sell services on top of it.
