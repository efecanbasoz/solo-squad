---
description: "Full NEXUS pipeline: 7-phase lifecycle from discovery to operations. Comprehensive project execution coordinating all squads with quality gates and handoff protocols."
---

# NEXUS Full

You are running a full NEXUS pipeline — the complete 7-phase lifecycle for a major project or client engagement.

## Pipeline Overview

```
Phase 0: Discovery    → Understand the problem and validate the opportunity
Phase 1: Strategy     → Define what to build, how to build it, how to measure success
Phase 2: Foundation   → Set up infrastructure, design system, and development environment
Phase 3: Build        → Implement features through Dev-QA loops until quality gates pass
Phase 4: Hardening    → Security audit, performance testing, QA sign-off
Phase 5: Launch       → Deploy, market, and announce
Phase 6: Operate      → Monitor, report, iterate, improve
```

## Process

### Phase 0: Discovery (3-7 days)

**Skills dispatched:**
- `/brainstorm` — problem exploration, alternative approaches, design document
- `/ux-research` — user needs validation, persona development
- `/seo-audit` — market opportunity and search landscape analysis (if web project)

**Quality gate → Strategy:**
- [ ] Problem statement is validated and specific
- [ ] Success criteria are defined and measurable
- [ ] Key risks are identified with mitigation strategies
- [ ] At least 2 approaches were evaluated

### Phase 1: Strategy (5-10 days)

**Skills dispatched:**
- `/plan` — implementation plan with tasks, file paths, test requirements
- `/design-system` — design tokens, component inventory, visual language
- `/product-strategy` — roadmap, prioritization, go-to-market alignment
- `/client-kickoff` — project charter, communication plan, access setup

**Quality gate → Foundation:**
- [ ] Architecture is approved (design doc reviewed)
- [ ] Implementation plan is reviewed with task-level detail
- [ ] Dependencies are mapped across squads
- [ ] Design tokens and component inventory exist

### Phase 2: Foundation (3-5 days)

**Skills dispatched:**
- `/devops-pipeline` — CI/CD, infrastructure, deployment strategy
- `/workflow-mapping` — system workflows documented with failure modes
- Design token implementation from design-system output

**Quality gate → Build:**
- [ ] CI/CD pipeline is green
- [ ] Development environment works for all team members
- [ ] Design tokens are implemented and available
- [ ] Core infrastructure is deployed (staging at minimum)

### Phase 3: Build (2-12 weeks)

**Skills dispatched (iterative loops):**
- `/build` — task-by-task implementation with TDD
- `/review` — multi-lens code review after each feature
- `/qa` — browser-based testing, bug detection, regression tests

**Loop protocol:** Build → Review → QA → Fix → Review → QA until clean.
Maximum 3 loops per feature. If a feature fails QA 3 times, escalate to user.

**Quality gate → Hardening:**
- [ ] All planned tasks are complete
- [ ] All tests pass
- [ ] Code coverage meets project threshold
- [ ] No open BLOCKER-level review findings

### Phase 4: Hardening (3-7 days)

**Skills dispatched:**
- `/cso` — OWASP Top 10 + STRIDE security audit
- `/benchmark` — performance testing, Core Web Vitals, load testing
- `/qa` — comprehensive end-to-end testing
- `/legal-compliance` — regulatory compliance check (if applicable)

**Quality gate → Launch:**
- [ ] Security audit passed (zero Critical, zero High unresolved)
- [ ] Performance budgets met (LCP < 2.5s, CLS < 0.1)
- [ ] QA signed off on all user flows
- [ ] Legal/compliance requirements met (if applicable)

### Phase 5: Launch (1-2 weeks)

**Skills dispatched:**
- `/ship` — deploy, PR, documentation updates
- `/social-strategy` — organic launch content plan
- `/paid-social` — paid launch campaigns (if applicable)
- `/content-plan` — supporting content calendar
- `/ad-creative` — launch creative assets

**Quality gate → Operate:**
- [ ] Deployment successful and verified
- [ ] Monitoring and alerting active
- [ ] Incident runbook exists
- [ ] Launch content published

### Phase 6: Operate (ongoing)

**Skills dispatched (recurring cadence):**
- `/status-report` — weekly client reports
- `/analytics-reporting` — performance dashboards and insights
- `/experiment-track` — A/B tests and optimization experiments
- `/retro` — sprint retrospectives and process improvements

**No quality gate — this phase continues until the engagement ends.**

## Handoff Protocol

When transitioning between phases, generate a handoff document:

```
## Handoff: {Phase N} → {Phase N+1}

### Context
{What was accomplished in this phase and why}

### Deliverables
{List of artifacts with file paths}

### Decisions Made
{Key decisions and rationale — future phases need this context}

### Open Items
{Unresolved questions or deferred work}

### Quality Gate
{Pass/Fail with evidence for each criterion}
```

## Scenario Runbooks

### Client Website Rebuild
Mode: NEXUS-Full, all phases, all squads.
Duration: 8-16 weeks. Skip Phase 6 for handoff projects.

### New Feature Sprint
Mode: NEXUS-Full, skip Phase 0 (problem already defined), compress Phases 1-2.
Duration: 4-8 weeks. Engineering + Design squads primary.

## Rules

- Never skip a quality gate. If a gate fails, re-run the failing skills.
- Pause for human approval at phase boundaries.
- Load client context at pipeline start.
- Log everything — the pipeline log is the project history.
- When skills from multiple squads can run in parallel, run them in parallel.
