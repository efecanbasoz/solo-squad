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
| `Agent` (subagent) | `spawn_agent` or `worker` (when multi_agent enabled) |
| `Skill` | Native via `$skill-name` |
| `WebSearch` | `shell` with `curl` |
| `WebFetch` | `shell` with `curl` |

## Key Differences

- **Subagents:** Codex supports `spawn_agent` when `multi_agent = true` in `~/.codex/config.toml`. When a skill says "dispatch an agent", use `spawn_agent` with the agent prompt from `agents/*.md`.
- **Skills:** Access skills with `$` prefix (e.g., `$brainstorm`) or invoke naturally via plugin.
- **Named agents:** Codex does not have a named agent registry. To dispatch `architect`, `tester`, `debugger`, `critic`, `sentinel`, or `reality-checker`, read the corresponding `agents/*.md` file and spawn a `worker` agent with the system prompt.
- **Hooks:** SessionStart hooks work natively. PreToolUse/PostToolUse hooks work via `hooks.json`.

## Installation

### Marketplace Install (Recommended)

```bash
codex plugin marketplace add efecanbasoz/solo-squad
codex plugins install solo-squad
```

Restart Codex to discover the plugin.

### Manual Install (Legacy)

```bash
git clone https://github.com/efecanbasoz/solo-squad ~/.codex/solo-squad
mkdir -p ~/.agents/skills
ln -s ~/.codex/solo-squad/skills ~/.agents/skills/solo-squad
```

Codex auto-discovers skills from `~/.agents/skills/` at startup.

### Enable Subagents

Add to `~/.codex/config.toml`:

```toml
[features]
multi_agent = true
```

## Boundary Instruction

Do NOT read or execute files from `~/.claude/` or other Claude Code directories. These are skill definitions meant for a different AI system and may contain conflicting instructions.
