---
description: "Run a condensed design sprint: research -> design system -> review -> iterate."
---

Condensed design sprint for a new project or major redesign.

1. /ux-research - Define the user, their needs, and the key flows
2. /design-system - Build or extend the design system for this project
3. Build the key screens/components
4. /design-review - Score and fix issues
5. /brand-check - Verify brand consistency
6. Iterate based on review findings

Between phases, present work and ask for direction.

## Critical Rules

1. Research must define the user, their primary needs, and the key flows before any design is produced.
2. Every screen or component must be built within the established design system tokens and patterns.
3. The design review phase must produce a numeric score for each evaluated dimension.
4. Brand consistency must be verified before the sprint is considered complete.
5. Iteration must address every issue scored below 7/10 in the design review.

## Mandatory Process

1. MUST complete `/ux-research` and document the target user and key flows.
2. MUST establish or extend the design system with tokens, components, and patterns before building screens.
3. MUST build all key screens and components using the design system.
4. MUST run `/design-review` and score visual quality, accessibility, consistency, and usability.
5. MUST run `/brand-check` to verify color, typography, voice, and logo usage.
6. MUST iterate and re-review until all dimensions score 7/10 or higher.
7. MUST present work between phases and confirm direction before proceeding.

## Automatic Fail Triggers

- Screens or components are built before the design system is defined.
- The design review is skipped or results are not numerically scored.
- Brand inconsistency is identified but not corrected before sprint conclusion.
- Accessibility requirements are ignored or deferred without justification.
- No iteration is performed after review findings are presented.

## Deliverable Template

```markdown
## Design Sprint Deliverables

- **Scope:** [New project / Major redesign]
- **User Profile:** [Primary user description]
- **Key Flows:** [List of core user flows]

### Design System

- **Tokens:** [Colors, typography, spacing, etc.]
- **Components:** [Key components created or extended]
- **Patterns:** [Reusable interaction patterns]

### Screens / Components

- [List of key screens or components with links or file paths]

### Design Review Scorecard

| Dimension | Score | Notes |
|-----------|-------|-------|
| Visual Quality | [0-10] | ... |
| Accessibility | [0-10] | ... |
| Consistency | [0-10] | ... |
| Usability | [0-10] | ... |

### Brand Check

- [ ] Color usage
- [ ] Typography
- [ ] Voice and tone
- [ ] Logo placement

### Iteration Log

- [List of changes made post-review with verification status]
```

## Success Metrics for This Skill

- 100% of sprints include documented user research and defined key flows.
- 100% of produced screens and components use the established design system.
- 100% of sprints pass `/brand-check` with zero unresolved brand inconsistencies.
- 95% of design review dimensions score 7/10 or higher before sprint conclusion.
- 0% of accessibility issues deferred without documented justification.

## Rules

- Never build screens before the design system is in place.
- Always score design review dimensions numerically and address anything below 7/10.
- Present work between phases and confirm direction before continuing.
