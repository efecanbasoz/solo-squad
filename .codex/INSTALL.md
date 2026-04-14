# Solo Squad — Codex CLI Installation

## Quick Install

### macOS / Linux

```bash
git clone https://github.com/efecanbasoz/solo-squad ~/.codex/solo-squad
mkdir -p ~/.agents/skills
ln -s ~/.codex/solo-squad/skills ~/.agents/skills/solo-squad
```

### Windows (PowerShell)

```powershell
git clone https://github.com/efecanbasoz/solo-squad "$env:USERPROFILE\.codex\solo-squad"
New-Item -ItemType Directory -Force "$env:USERPROFILE\.agents\skills"
cmd /c mklink /J "$env:USERPROFILE\.agents\skills\solo-squad" "$env:USERPROFILE\.codex\solo-squad\skills"
```

## What This Does

1. Clones Solo Squad to `~/.codex/solo-squad`
2. Symlinks the `skills/` directory into Codex's skill discovery path (`~/.agents/skills/`)
3. Codex auto-discovers all 27 skills at startup

## Enable Subagent Support

Skills like `/build` and `/sprint` dispatch subagents. Enable multi-agent mode in `~/.codex/config.toml`:

```toml
[features]
multi_agent = true
```

Without this, subagent-based skills fall back to sequential execution.

## Usage

Access skills with the `$` prefix:

```
$brainstorm     — Refine an idea before coding
$plan           — Create step-by-step implementation plan
$build          — Execute plan with TDD
$review         — Multi-agent code review
$ship           — Push and open PR
$investigate    — Root-cause debugging
$cso            — Security audit (OWASP + STRIDE)
$careful        — Destructive command warnings
```

## Updating

```bash
cd ~/.codex/solo-squad && git pull
```

The symlink ensures updates are picked up immediately.

## Uninstalling

### macOS / Linux

```bash
rm ~/.agents/skills/solo-squad
rm -rf ~/.codex/solo-squad
```

### Windows (PowerShell)

```powershell
cmd /c rmdir "$env:USERPROFILE\.agents\skills\solo-squad"
Remove-Item -Recurse -Force "$env:USERPROFILE\.codex\solo-squad"
```

## Notes

- Agents (Architect, Tester, Debugger, Critic, Sentinel) are defined in `agents/` but require `multi_agent = true` in config.toml.
- Tool mapping differences are documented in `skills/using-solo-squad/references/codex-tools.md`.
- Read `AGENTS.md` at the repo root for project context (loaded automatically by Codex).
