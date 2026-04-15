# Solo Squad — OpenCode Tool Mapping

When running Solo Squad skills on OpenCode, use these tool equivalents:

## Tool Equivalents

| Claude Code Tool | OpenCode Equivalent |
|-----------------|---------------------|
| `Read` | `read` (native) |
| `Write` | `write` (native) |
| `Edit` | `edit` or `apply_patch` (native) |
| `Bash` | `bash` (native) |
| `Glob` | `glob` (native) |
| `Grep` | `grep` (native) |
| `Agent` (subagent) | `task` (native subagent dispatch) |
| `Skill` | `skill` (native) or `/skill-name` command |
| `WebSearch` | `websearch` (native) |
| `WebFetch` | `webfetch` (native) |

## Key Differences

- **Subagents**: Solo Squad registers `architect`, `tester`, `debugger`, `critic`, and `sentinel` as OpenCode subagents. Call them through the `task` tool when a workflow asks for an agent.
- **Skills and commands**: Skills are available through the `skill` tool and as slash commands like `/brainstorm`. Workflow commands from `commands/` are also registered, such as `/sprint` and `/security-scan`.
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
  "plugin": ["/absolute/path/to/solo-squad"]
}
```

If the config file lives inside `~/.config/opencode/opencode.json`, a relative entry like `"./solo-squad"` also works.
