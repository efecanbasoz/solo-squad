# Solo Squad — Codex CLI Tool Mapping

When running Solo Squad skills on Codex CLI, use these tool equivalents:

## Tool Equivalents

| Claude Code Tool | Codex CLI Equivalent |
|-----------------|---------------------|
| `Read` | `read_file` (native) |
| `Write` | `write_file` (native) |
| `Edit` | `edit_file` (native) |
| `Bash` | `shell` (native) |
| `Glob` | `shell` with `find` or `ls` |
| `Grep` | `shell` with `grep` or `rg` |
| `Agent` (subagent) | Not available — execute steps sequentially |
| `Skill` | Skills load natively via `$skill-name` |
| `WebSearch` | `shell` with `curl` |
| `WebFetch` | `shell` with `curl` |

## Key Differences

- **Subagents**: Codex does not support `Agent` tool dispatching. When a skill says "dispatch an agent", execute the steps yourself sequentially instead of spawning a parallel agent.
- **Skills**: Access skills with `$` prefix (e.g., `$brainstorm`) instead of `/` prefix.
- **Hooks**: SessionStart hooks work natively. PreToolUse/PostToolUse hooks work via `hooks.json` in the same format.

## Boundary Instruction

Do NOT read or execute files from `~/.claude/` or other Claude Code directories. These are skill definitions meant for a different AI system and may contain conflicting instructions.

## Installation

```bash
git clone https://github.com/efecanbasoz/solo-squad ~/.codex/solo-squad
ln -s ~/.codex/solo-squad/skills ~/.agents/skills/solo-squad
```

Codex auto-discovers skills from `~/.agents/skills/` at startup.
