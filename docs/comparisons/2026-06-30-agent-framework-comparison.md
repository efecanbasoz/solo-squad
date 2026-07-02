# Agent Framework Comparison — 2026-06-30

## Scope and method

Compared Solo Squad 2.2.0 against the latest publicly visible state of these repositories on 2026-06-30:

- `obra/superpowers` — <https://github.com/obra/superpowers>
- `msitarzewski/agency-agents` — <https://github.com/msitarzewski/agency-agents>
- `EveryInc/compound-engineering-plugin` — <https://github.com/EveryInc/compound-engineering-plugin>
- `open-gsd/gsd-core` — <https://github.com/open-gsd/gsd-core>
- `garrytan/gstack` — <https://github.com/garrytan/gstack>

Direct `git clone` and raw GitHub fetches from the container failed with a proxy `CONNECT tunnel failed, response 403`, so this comparison uses the current GitHub web summaries available through search plus the local Solo Squad repository inventory. Re-run this review from an unrestricted network before implementing large compatibility changes.

## Solo Squad baseline

Solo Squad currently ships:

- 27 skills across development, design, security, quality, learning, DevOps, database, documentation, and release workflows.
- 7 agents: Architect, Critic, Debugger, Reality Checker, Sentinel, Tester, and DevEx Maintainer.
- 6 commands: autoplan, sprint, hotfix, tdd, design-sprint, and security-scan.
- Multi-CLI packaging for Claude Code, Codex CLI, and OpenCode.
- Runtime hooks for session start, destructive command warnings, and TDD reminders.

## External repository signals

| Repository | Public signal | Comparison note for Solo Squad |
|---|---|---|
| `obra/superpowers` | Agentic skills framework focused on disciplined engineering workflow; public references emphasize brainstorm, planning, TDD, debugging, verification, and broad CLI support. | Solo Squad already overlaps strongly on lifecycle discipline, but can strengthen install/update ergonomics and explicit skill-invocation enforcement. |
| `msitarzewski/agency-agents` | Large persona library described as a complete AI agency with many specialized agents. | Solo Squad is intentionally smaller and workflow-first. The gap is breadth of domain personas, not core SDLC coverage. |
| `EveryInc/compound-engineering-plugin` | Compound Engineering plugin with multi-platform installation paths and companion subagent tooling; public docs emphasize Codex, Copilot, Droid, Qwen, OpenCode, Pi, and Antigravity support. | Solo Squad has multi-CLI support but fewer documented installer paths and less explicit companion-tool guidance for subagent-heavy workflows. |
| `open-gsd/gsd-core` | Context-engineering/spec-driven framework that prevents context rot by keeping main session lean and pushing heavy research/planning/execution into fresh-context subagents. | Solo Squad has subagent-driven build/review concepts, but could add first-class context-budget, handoff, and checkpoint rules. |
| `garrytan/gstack` | Role/governance-oriented Claude Code setup; public comparisons describe decision-memory and role-based review/governance. | Solo Squad has agents and plan-review lenses, but could add durable decision logs and more explicit governance roles for tradeoff approvals. |

## Findings

### 1. Areas to improve

1. **Current-state installation matrix**
   - Compound Engineering publicly documents more install targets than Solo Squad currently advertises.
   - Add a maintained compatibility table for Claude Code, Codex CLI, OpenCode, Copilot CLI, Cursor, Gemini/Qwen-family CLIs, and any unsupported tools.
   - Include exact install, update, uninstall, and pinning instructions per host.

2. **Context-rot controls**
   - GSD Core's strongest differentiator is keeping the main session lean through fresh-context subagents.
   - Solo Squad should add explicit context budget rules to `/plan`, `/build`, `/review`, and `/compound`:
     - what must stay in the main thread,
     - what must be delegated,
     - what must be summarized before returning,
     - when to start a fresh pass instead of continuing.

3. **Durable decision memory**
   - gstack-style governance appears to rely on remembering decisions across sessions.
   - Solo Squad's `learn`, `retro`, and `compound` skills capture patterns, but there is no single durable decision-log convention.
   - Add `docs/decisions/` guidance or an ADR-style skill/command path for architecture, product, security, and release decisions.

4. **Persona coverage without bloat**
   - Agency Agents competes on persona breadth.
   - Solo Squad should not copy a large persona catalog, but it can add a small routing matrix for when to use existing agents versus skills.
   - Consider 2-3 new agents only where they unlock repeated workflows:
     - Product Strategist for scope/value decisions,
     - DevEx Maintainer for installation and onboarding friction,
     - Release Manager for versioning, changelog, packaging, and rollout.

5. **Skill enforcement feedback loop**
   - Superpowers and Solo Squad both emphasize disciplined workflows.
   - Solo Squad can improve by adding automated checks that descriptions stay trigger-only, no platform-specific logic leaks into `SKILL.md`, and every skill has hard gates, success metrics, and automatic fail triggers where applicable.

### 2. Areas to add or remove

#### Add

- `docs/compatibility.md`: host support matrix with install/update/pinning commands.
- `docs/decisions/README.md`: ADR/decision-log convention used by `plan`, `plan-review`, `compound`, and `retro`.
- A context-budget section in the session-start/using skill documentation.
- Validation script for Solo Squad-specific invariants:
  - skill frontmatter descriptions are trigger-only,
  - skill names match folder names,
  - plugin manifests list the expected skill and command counts,
  - no platform-specific install logic appears inside core skills.
- Optional `Release Manager` or `DevEx Maintainer` agent if install/update support becomes a maintained surface area.

#### Do not add yet

- A large Agency Agents-style persona catalog. It would dilute Solo Squad's workflow-first positioning and increase maintenance burden.
- Repo-specific platform branches inside `SKILL.md` files. Keep platform detection in hooks and mapping references.
- Runtime dependencies. The current pure-markdown-plus-shell posture is a differentiator.

#### Possible removals or reductions

- No immediate removals are recommended.
- Instead, consolidate overlapping workflow documentation so `learn`, `retro`, and `compound` have clear boundaries.
- Review whether `document-release`, `ship`, and `land-and-deploy` should share a single release checklist reference to avoid drift.

### 3. Consolidation opportunities

| Area | Current overlap | Recommendation |
|---|---|---|
| Learning loop | `learn`, `retro`, and `compound` all capture knowledge after work. | Keep all three, but define boundaries: `learn` for reusable patterns, `retro` for process health, `compound` for codifying workflow improvements. Add cross-links. |
| Release flow | `ship`, `land-and-deploy`, `document-release`, and `canary` cover adjacent release tasks. | Keep separate skills, but extract a shared release checklist reference consumed by all four. |
| Review flow | `review`, `plan-review`, `design-review`, `slop-scan`, `cso`, and `qa` are all gates. | Add a review-routing table so agents choose the right gate instead of stacking all gates by default. |
| Agents vs skills | Architect/Tester/Debugger/Sentinel/Reality Checker/Critic partially mirror plan, qa, investigate, cso, review, and design-review. | Document that skills own process, agents own specialist perspective. Use agents inside skills only when the skill requires that perspective. |
| DevOps/release | `devops-pipeline`, `ship`, `land-and-deploy`, `canary` can repeat deploy-health details. | Consolidate deploy-health checks in a shared reference and keep each skill focused on its phase. |

## Prioritized roadmap

### P0 — Low risk, high leverage

1. Add `docs/compatibility.md` with supported/unsupported host matrix.
2. Add `docs/decisions/README.md` for durable decision memory.
3. Add a review-routing table to `skills/using-solo-squad/SKILL.md`.
4. Add validation for trigger-only descriptions and no platform-specific logic in core skills.

### P1 — Workflow hardening

1. Add context-budget and fresh-context delegation rules to `using-solo-squad`, `plan`, `build`, `review`, and `compound`.
2. Extract shared release checklist reference for `ship`, `land-and-deploy`, `document-release`, and `canary`.
3. Clarify `learn` vs `retro` vs `compound` in each skill.

### P2 — Selective expansion

1. Add a `Release Manager` agent if release packaging becomes a frequent pain point.
2. Add a `DevEx Maintainer` agent if multi-host installation support grows. **Implemented first as the initial P2 expansion.**
3. Add a `Product Strategist` agent only if scope/value tradeoffs repeatedly require a dedicated persona.

## Bottom line

Solo Squad is already competitive on disciplined SDLC coverage. The biggest gaps versus the compared repositories are not raw skill count; they are installation breadth, context-rot controls, durable decision memory, and explicit routing/governance documentation. The recommended direction is to improve orchestration and documentation rather than adding many new personas.
