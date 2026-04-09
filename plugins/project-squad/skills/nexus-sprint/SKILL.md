---
description: "Compressed NEXUS pipeline for 2-6 week projects. Combines discovery+strategy and hardening+ship phases for faster delivery with essential quality gates."
---

# NEXUS Sprint

You are running a compressed NEXUS pipeline for a focused, time-boxed project.

## Pipeline Overview

```
Phase A: Discovery + Strategy (combined)  → Define + plan in one pass
Phase B: Build + Review                   → Implement with concurrent QA
Phase C: Harden + Ship                    → Security, performance, deploy
Phase D: Launch (optional)                → Marketing and announcement
```

## Process

### Phase A: Discovery + Strategy (3-7 days)

**Skills dispatched:**
- `/brainstorm` — problem framing and approach selection
- `/plan` — implementation plan with tasks
- `/client-kickoff` — project charter and communication plan

**Quality gate → Build:**
- [ ] Problem statement and approach are agreed
- [ ] Implementation plan exists with task-level detail
- [ ] Success criteria are defined

### Phase B: Build + Review (1-4 weeks)

**Skills dispatched (concurrent):**
- `/build` — task implementation with TDD
- `/review` — code review after each batch of tasks
- `/qa` — testing runs concurrently, not sequentially

**Quality gate → Harden + Ship:**
- [ ] All tasks complete
- [ ] Tests pass
- [ ] No open BLOCKER findings

### Phase C: Harden + Ship (2-5 days)

**Skills dispatched:**
- `/cso` — focused security review (OWASP Top 10, no full STRIDE)
- `/qa` — final end-to-end pass
- `/ship` — deploy and PR

**Quality gate → Launch:**
- [ ] Zero Critical security findings
- [ ] Core user flows pass QA
- [ ] Deployment successful

### Phase D: Launch (optional, 3-7 days)

**Skills dispatched:**
- `/content-plan` — supporting content
- `/social-strategy` — announcement plan

## Scenario Runbook

### Marketing Campaign
Mode: NEXUS-Sprint. Phases A-D.
Duration: 2-4 weeks. Marketing + Design + Project squads primary.
Phase A: campaign brief + content plan. Phase B: content creation + design. Phase C: review + publish. Phase D: amplification + reporting.

## Rules

- Sprint mode sacrifices thoroughness for speed. Acknowledge this tradeoff.
- Quality gates are simpler but still mandatory.
- If scope grows beyond sprint capacity, recommend switching to NEXUS-Full.
- Timeboxing is sacred. If a phase runs over, cut scope, don't extend time.
