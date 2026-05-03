# Solo Squad

Solo Squad is a plugin for AI coding CLIs that provides 27 skills across development, design, security, and quality workflows. Works on Claude Code (primary), Codex CLI, and OpenCode.

## Structure

```
skills/          — 27 SKILL.md files (the core content)
agents/          — 6 agent definitions (Architect, Tester, Debugger, Critic, Sentinel, Reality Checker)
commands/        — 6 workflow commands (autoplan, sprint, hotfix, tdd, design-sprint, security-scan)
hooks/           — Runtime hooks + platform-detecting session-start + Windows wrapper
.claude-plugin/  — Claude Code plugin manifest + marketplace
.codex-plugin/   — Codex CLI plugin manifest
.opencode/       — OpenCode ESM plugin
AGENTS.md        — Codex CLI shared context
```

## Skill Format

Every skill is a `SKILL.md` file with YAML frontmatter (`name`, `description`, `version`, `triggers`) followed by markdown instructions. `name` should match the folder name. Skills are self-contained — each file has everything the agent needs to execute that workflow.

## Agent Format

Agents are `.md` files with frontmatter (`name`, `description`, `model`, `tools`, `version`) followed by a system prompt. Agents define specialist personas with restricted tool access.

## Categories

- **Development**: brainstorm, plan, plan-review, build, review, qa, polish-beta, ship, land-and-deploy, canary, document-release, compound, investigate, technical-writing, devops-pipeline, database-optimization
- **Design**: design-system, design-review, ux-research
- **Security**: cso, benchmark
- **Quality & Learning**: slop-scan, learn, health, scrape, retro

## Multi-CLI Rules

- Use Claude Code tool names as canonical (Read, Write, Edit, Bash, Agent)
- Never add platform-specific logic inside SKILL.md files
- Tool mapping references live at `skills/using-solo-squad/references/`
- Session-start hook detects platform via env vars — don't hardcode platform checks in skills
- All descriptions are trigger-only: "Use when X. No process details here."

## Instruction Priority Hierarchy

When instructions conflict, resolve in this order:

1. User instructions (direct requests, AGENTS.md, CLAUDE.md)
2. Solo Squad skills (invoke the skill, follow its process)
3. Default system prompt

## Rationalization Defense

Agents constantly rationalize skipping skills. You do not have a choice. If there is even a 1% chance a skill applies, invoke it.

| Thought | Reality |
|---------|---------|
| "This is just a simple question" | Questions are tasks. Check for skills. |
| "I know what that means" | Knowing the concept ≠ using the skill. |
| "This feels productive" | Undisciplined action wastes time. |
| "The user said to code" | Users ask for outcomes. Skills deliver outcomes with discipline. |
| "I already reviewed this" | Review is a skill. Use `/review`. |
| "I don't need to plan" | Every non-trivial change benefits from `/plan`. |

## Description Trap

Skill descriptions must be **trigger-only**. Do not put process details in the description. If the description contains workflow steps, agents follow the short description instead of reading the full skill.

**Bad:** `"Start here for any new engineering work. Refines rough ideas through Socratic questioning..."`
**Good:** `"Use when starting new engineering work. No implementation without design."`

## Development

- All files must be in English
- Commit format: `feat(scope):`, `fix(scope):`, `docs:`, `chore:`
- No runtime dependencies — pure markdown + shell scripts
- Version bump: `./scripts/bump-version.sh <version>` (updates package.json + plugin.json)
