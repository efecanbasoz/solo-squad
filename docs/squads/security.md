# Security Squad

Safety guardrails, security audits, performance benchmarks, and cross-AI tooling. Built for shipping production code without breaking it.

**Plugin name:** `security-squad`

## Skills

| Skill | What it does |
|-------|--------------|
| `/cso` | Security audit: OWASP Top 10 + STRIDE threat model. 8/10+ confidence gate. Concrete exploit scenarios. |
| `/benchmark` | Performance baseline: page load, Core Web Vitals, resource sizes. Before/after comparison per PR. |
| `/browse` | Real Chromium browser for visual verification, user flow testing, form filling, screenshot capture. |
| `/careful` | Warns before destructive commands: rm -rf, DROP TABLE, force-push. Requires explicit confirmation. |
| `/freeze` | Lock edits to one directory. Everything else is read-only. Prevents scope creep during debugging. |
| `/guard` | Maximum safety: /careful + /freeze combined. For production work. |
| `/codex-review` | Independent second-opinion code review. Cross-references with primary review findings. |

## Commands

| Command | What it does |
|---------|-------------|
| `/lockdown` | Maximum safety: guard + careful + freeze for production work |
| `/security-scan` | Full scan: OWASP + STRIDE + dependency CVEs + secrets + permissions |

## Agents

| Agent | Role |
|-------|------|
| Sentinel | Read-only security reviewer. Checks all code for vulnerabilities before shipping. |

## Hooks

Before every bash command, a hook checks for destructive patterns when careful mode is active.
