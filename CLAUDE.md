# Solo Squad

Solo Squad is a plugin for AI coding CLIs that provides 27 skills across coding, design, and security workflows.

## Structure

```
skills/       — 27 SKILL.md files (the core content)
agents/       — 5 agent definitions (Architect, Tester, Debugger, Critic, Sentinel)
commands/     — 7 workflow commands (sprint, hotfix, tdd, etc.)
hooks/        — Runtime hooks (TDD reminder, brand check, destructive warning)
```

## Skill Format

Every skill is a `SKILL.md` file with YAML frontmatter (`description` field) followed by markdown instructions. Skills are self-contained — each file has everything the agent needs to execute that workflow.

## Agent Format

Agents are `.md` files with frontmatter (`name`, `description`, `model`, `tools`) followed by a system prompt. Agents define specialist personas with restricted tool access.

## Categories

- **Coding**: brainstorm, plan, build, review, qa, ship, compound, investigate, technical-writing, devops-pipeline, database-optimization, workflow-mapping, developer-advocacy
- **Design**: design-system, design-review, ux-research, brand-check, image-prompts
- **Security**: cso, benchmark, browse, careful, codex-review, freeze, guard, incident-response, legal-compliance

## Development

- All files must be in English
- Commit format: `feat(scope):`, `fix(scope):`, `docs:`, `chore:`
- Test with: `npm test`
- No runtime dependencies — pure markdown + shell scripts
