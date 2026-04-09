# Design Squad

Design systems, design reviews, UX research, and brand consistency. Built for agencies producing client deliverables.

**Plugin name:** `design-squad`

## Skills

| Skill | What it does |
|-------|--------------|
| `/design-system` | Build a complete design system with starter templates (SaaS, marketing site, e-commerce): tokens, component library, pattern library, documentation. |
| `/design-review` | Visual audit with AI slop detection. Score 0-10 on hierarchy, consistency, accessibility, usability, craft. Fix issues. |
| `/ux-research` | UX research with execution methodology: study design, participant recruitment, facilitation scripts, analysis frameworks, and usability testing. |
| `/brand-check` | Brand consistency audit: exact color matching, typography, voice/tone, logo usage across deliverables. |
| `/image-prompts` | AI image prompt engineering for Midjourney, DALL-E, Flux. Optimized for each model's strengths. |

## Commands

| Command | What it does |
|---------|-------------|
| `/design-sprint` | Condensed sprint: research -> system -> build -> review -> brand check |
| `/asset-gen` | Batch AI image prompt generation for campaign assets across formats |

## Agents

| Agent | Role |
|-------|------|
| Design Critic | Visual quality reviewer. Detects AI slop, scores craft, gives specific fixes. |

## Hooks

Context-aware shell script that checks file type, path, and content before firing. Verifies colors and typography match brand guidelines.
