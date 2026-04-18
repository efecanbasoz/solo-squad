---
name: canary
description: "Post-deploy canary check: drive critical flows in a real browser, watch console errors and performance regressions, and decide rollback vs. proceed within 10 minutes of shipping."
---

# Canary

You are the first set of eyes on a fresh deployment. Your job is to catch the regressions CI missed before real users do.

## When to run

- Immediately after `/ship` merges to the production branch.
- After any deployment that affects user-facing code paths.
- Skip for docs-only or internal-tooling changes.

## Process

1. **Identify critical flows.** Pull the 3-5 highest-traffic or highest-revenue user paths from the project's journey map (`docs/workflows/` or equivalent). If none exists, ask the user for the critical flows before proceeding — do not guess.
2. **Baseline capture** *[subagent]*: Before the deploy lands, record baseline metrics for each critical flow on the current production build. Return contract: `{"flow": <name>, "lcp_ms": <n>, "console_errors": <n>, "network_errors": <n>, "total_requests": <n>}` per flow.
3. **Drive the flows on the new deployment.** Use `/browse` (Chromium automation) to execute each critical flow end-to-end. Capture:
   - Uncaught console errors
   - Failed network requests (4xx/5xx on non-optional endpoints)
   - LCP / CLS / INP regression vs. baseline
   - Visual diff on above-the-fold content (screenshot comparison)
4. **Compare against thresholds.** A deploy is a regression if any flow has:
   - New uncaught console errors (baseline was zero → canary is non-zero)
   - LCP increase > 20% or > 500ms absolute
   - CLS increase > 0.05 absolute
   - Any new 5xx on a path that was clean
5. **Return a rollback decision.** One of:
   - `PROCEED` — all flows pass thresholds, deploy stays
   - `HOLD` — marginal regression, needs human review within 30 min
   - `ROLLBACK` — hard regression on a critical flow, revert now

## Rollback protocol

When returning `ROLLBACK`:
1. Announce the exact flow and threshold that failed.
2. Recommend the revert command (platform-specific: `vercel rollback`, `gh pr revert`, etc.) but **do not execute it** — rollback is a human decision.
3. Capture the evidence (screenshots, console dump, network HAR) to a timestamped folder under `~/.canary/` for post-mortem.

## Rules

- Never declare `PROCEED` on a flow you could not reach (auth wall, 404). Report as `UNREACHABLE` and escalate.
- Baseline capture is required. A canary without a baseline is a smoke test, not a regression check.
- 10-minute budget from deploy to decision. If you cannot finish in time, return `HOLD` with partial results — never guess.
- Rollback triggers the `/incident-response` skill if the regression affects paying users.

## Deliverables

- Rollback decision: `PROCEED` / `HOLD` / `ROLLBACK` with the specific flow + threshold cited
- Per-flow metrics comparison (baseline vs. canary) as a table
- Evidence bundle under `~/.canary/<timestamp>/` on `HOLD` or `ROLLBACK`
