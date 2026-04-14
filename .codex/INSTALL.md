# Solo Squad — Codex CLI Installation

## Quick Install

```bash
git clone https://github.com/efecanbasoz/solo-squad ~/.codex/solo-squad
ln -s ~/.codex/solo-squad/skills ~/.agents/skills/solo-squad
```

## What This Does

1. Clones Solo Squad to `~/.codex/solo-squad`
2. Symlinks the `skills/` directory into Codex's skill discovery path (`~/.agents/skills/`)
3. Codex auto-discovers all 27 skills at startup

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

```bash
rm ~/.agents/skills/solo-squad
rm -rf ~/.codex/solo-squad
```

## Notes

- Agents (Architect, Tester, Debugger, Critic, Sentinel) are defined in `agents/` but Codex does not natively support agent dispatch. Skills reference them as personas — follow their behavioral directives when a skill says "dispatch this agent".
- Tool mapping differences are documented in `skills/using-solo-squad/references/codex-tools.md`.
- Read `AGENTS.md` at the repo root for project context (loaded automatically by Codex).
