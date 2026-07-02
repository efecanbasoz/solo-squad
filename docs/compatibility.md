# Compatibility Matrix

Solo Squad is a pure markdown + shell-script plugin. Skills are written with Claude Code tool names as the canonical vocabulary, while host-specific tool mappings live in references and hooks.

## Support levels

| Level | Meaning |
|---|---|
| Supported | The repository includes a manifest, references, or hook path for this host. Keep installation and update instructions current. |
| Compatible | Solo Squad content can be used, but the repository does not yet ship a first-class manifest or wrapper. Document manual setup before claiming support. |
| Not supported | Do not advertise support until a manifest, wrapper, or tested manual setup exists. |

## Host matrix

| Host | Status | Entry point | Install / update notes | Owner guidance |
|---|---|---|---|---|
| Claude Code | Supported | `.claude-plugin/plugin.json` | Install through Claude Code plugin mechanisms or copy this repository into the expected plugin directory. Update by pulling the repository and reloading the session. | Primary target. Claude Code tool names remain canonical in skills. |
| Codex CLI | Supported | `.codex-plugin/plugin.json` and `.codex/INSTALL.md` | Install through Codex plugin mechanisms or copy this repository into the configured Codex plugin directory. Update by pulling the repository and restarting Codex. | Keep Codex mappings in `skills/using-solo-squad/references/codex-tools.md`. |
| OpenCode | Supported | `.opencode/` plugin files | Install through OpenCode plugin mechanisms or copy this repository into the configured OpenCode plugin directory. Update by pulling the repository and restarting OpenCode. | Keep OpenCode mappings in `skills/using-solo-squad/references/opencode-tools.md`. |
| GitHub Copilot CLI / coding agent | Compatible | Manual skill import | No first-class manifest yet. Use Solo Squad as reference markdown until a tested installer exists. | Do not claim full support until install and tool mapping references are added. |
| Cursor | Compatible | Manual rules / docs import | No first-class manifest yet. Import relevant skills manually as project rules or docs. | Add a mapping reference before moving to Supported. |
| Gemini / Qwen-family CLIs | Compatible | Manual docs import | No first-class manifest yet. Use skills as workflow documentation and map tools manually. | Add a mapping reference and smoke-test hooks before moving to Supported. |
| Antigravity / other emerging hosts | Not supported | None | Track demand, but do not advertise support without tested packaging. | Prefer adding a reference mapping first, then a manifest/wrapper if the host supports plugins. |

## Pinning and updates

- Pin production usage to a git tag or commit SHA.
- Update by pulling the repository, running validation scripts, then restarting the host CLI.
- For releases, use `./scripts/bump-version.sh <version>` so `package.json` and plugin manifests stay aligned.

## Adding a new supported host

Before marking a host as Supported, dispatch the DevEx Maintainer agent to review the install path, update path, validation command, and troubleshooting notes.

1. Add or document the host entry point.
2. Add a tool mapping reference under `skills/using-solo-squad/references/`.
3. Verify session-start behavior does not hardcode platform checks in `SKILL.md` files.
4. Run the validation suite.
5. Update this matrix with install, update, and owner guidance.
