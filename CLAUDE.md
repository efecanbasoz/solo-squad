# Solo Squad

Solo Squad is a plugin for AI coding CLIs that provides 35 skills across coding, design, and security workflows. Works on Claude Code (primary), Codex CLI, OpenCode, Cursor, Gemini CLI, and Copilot CLI.

## Structure

```
skills/          — 35 SKILL.md files (the core content)
agents/          — 5 agent definitions (Architect, Tester, Debugger, Critic, Sentinel)
commands/        — 7 workflow commands (sprint, hotfix, tdd, etc.)
hooks/           — Runtime hooks + platform-detecting session-start + Windows wrapper
.claude-plugin/  — Claude Code plugin manifest + marketplace
.cursor-plugin/  — Cursor plugin manifest
.codex/          — Codex CLI install guide
.opencode/       — OpenCode ESM plugin
GEMINI.md        — Gemini CLI context file
gemini-extension.json — Gemini CLI extension manifest
AGENTS.md        — Codex/Copilot shared context
.local/          — Gitignored squads (marketing, project, sales) for future use
```

## Skill Format

Every skill is a `SKILL.md` file with YAML frontmatter (`name` and `description`) followed by markdown instructions. `name` should match the folder name. Skills are self-contained — each file has everything the agent needs to execute that workflow.

## Agent Format

Agents are `.md` files with frontmatter (`name`, `description`, `model`, `tools`) followed by a system prompt. Agents define specialist personas with restricted tool access.

## Categories

- **Coding**: brainstorm, plan, plan-ceo-review, plan-design-review, plan-eng-review, plan-devex-review, build, review, qa, polish-beta, ship, land-and-deploy, canary, document-release, compound, investigate, technical-writing, devops-pipeline, database-optimization, workflow-mapping, developer-advocacy
- **Design**: design-system, design-review, ux-research, brand-check, image-prompts
- **Security**: cso, benchmark, browse, careful, codex-review, freeze, guard, incident-response, legal-compliance

## Multi-CLI Rules

- Use Claude Code tool names as canonical (Read, Write, Edit, Bash, Agent)
- Never add platform-specific logic inside SKILL.md files
- Tool mapping references live at `skills/using-solo-squad/references/`
- CLAUDE.md and AGENTS.md must stay identical in content
- Session-start hook detects platform via env vars — don't hardcode platform checks in skills

## Development

- All files must be in English
- Commit format: `feat(scope):`, `fix(scope):`, `docs:`, `chore:`
- No runtime dependencies — pure markdown + shell scripts
- Version bump: `./scripts/bump-version.sh <version>` (updates package.json + plugin.json)
