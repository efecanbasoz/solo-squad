---
description: "Start a NEXUS pipeline. Select operating mode (Full/Sprint/Micro), load client context, and orchestrate cross-squad execution."
---

# Orchestrate

Entry point for NEXUS pipeline execution.

## Process

1. **Select mode.** Ask the user which NEXUS mode to run:
   - **Full** (4-12 weeks): Complete 7-phase lifecycle. For major projects and new client engagements.
   - **Sprint** (2-6 weeks): Compressed 4-phase pipeline. For focused projects with clear scope.
   - **Micro** (1-5 days): Rapid scope-build-ship. For urgent tasks and hotfixes.

2. **Load context.** If a client context exists (`clients/{name}/`), load it with `/client-context load`. If not, gather basic project context from the user.

3. **Select scenario (optional).** If the project matches a pre-built scenario runbook, offer it:
   - Client Website Rebuild → NEXUS-Full
   - New Feature Sprint → NEXUS-Full (compressed)
   - Marketing Campaign → NEXUS-Sprint
   - Production Incident → NEXUS-Micro

4. **Display pipeline overview.** Show the phases, estimated skills per phase, and expected duration.

5. **Confirm and launch.** Get user approval, then invoke the appropriate NEXUS skill:
   - Full → `/nexus-full`
   - Sprint → `/nexus-sprint`
   - Micro → `/nexus-micro`

## Rules

- Always confirm mode before starting. Don't assume.
- If the user describes a project that's clearly too big for Micro or too small for Full, recommend the right mode.
- Load client context when available — it significantly improves output quality.
