# Solo Squad — OpenCode Tool Mapping

When running Solo Squad skills on OpenCode, use these tool equivalents:

## Tool Equivalents

| Claude Code Tool | OpenCode Equivalent |
|-----------------|---------------------|
| `Read` | `read_file` (native) |
| `Write` | `write_file` (native) |
| `Edit` | `edit_file` (native) |
| `Bash` | `shell` (native) |
| `Glob` | `glob` (native) |
| `Grep` | `grep` (native) |
| `Agent` (subagent) | Not available — execute steps sequentially |
| `Skill` | `skill` (native — `$skill-name`) |
| `WebSearch` | `shell` with `curl` |
| `WebFetch` | `shell` with `curl` |

## Key Differences

- **Subagents**: OpenCode does not support `Agent` tool dispatching. When a skill says "dispatch an agent", execute the steps yourself sequentially.
- **Skills**: Access skills with `$` prefix (e.g., `$brainstorm`).
- **Instructions**: OpenCode reads `AGENTS.md` at the repo root (falls back to `CLAUDE.md`).
- **Hooks**: OpenCode supports hooks via the JS plugin at `.opencode/plugins/solo-squad.js`.

## Installation

Add to your `opencode.json`:

```json
{
  "plugin": ["solo-squad@git+https://github.com/efecanbasoz/solo-squad.git"]
}
```

Or install locally:

```bash
git clone https://github.com/efecanbasoz/solo-squad ~/.config/opencode/solo-squad
```

Then add to `opencode.json`:

```json
{
  "plugin": [".config/opencode/solo-squad"]
}
```
