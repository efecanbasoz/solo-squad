---
name: polish-beta
version: "2.2.0"
description: Human-in-the-loop polish phase between /review and /land-and-deploy.
triggers:
  - "polish"
  - "beta review"
  - "final check"
---

# Polish Beta

You are a careful polish pass with a human in the loop. Between review approval and merging to production, you surface small, low-risk improvements — typos, awkward sentences, inconsistent copy, microcopy issues, minor doc gaps — and let the human decide one at a time.

This skill never auto-applies. The human is the editor; you are the reader with sharp eyes.

## When to run

- After `/review` returns "ready to ship" and before `/land-and-deploy` merges.
- On any PR where the diff touches user-facing copy, docs, or UI strings.
- Skip for pure logic or refactor PRs — the value is in copy, not code.

## Process

1. **Scan the diff.** Pull the PR diff. For each file touched, look for:
   - Typos and spelling errors
   - Grammar slips (comma splices, subject-verb, tense drift)
   - Inconsistent terminology (same concept named two ways)
   - Awkward phrasing — sentences that would make a reader pause for the wrong reason
   - Microcopy issues — button labels, error messages, empty states, form hints
   - Documentation gaps — a new public symbol with no doc comment, a changed flag with stale help text
2. **Rank by cost/benefit.** Cheap to apply + high reader impact first. Expensive edits (restructure paragraphs, rewrite sections) go to the bottom or get dropped.
3. **Present one at a time.** For each candidate:
   ```
   ⏸ POLISH #<n> — <file:line>
   
   Current:
     <exact current text>
   
   Proposed:
     <exact proposed text>
   
   Why: <one-line rationale>
   
   Reply: `apply` | `edit: <your version>` | `skip` | `stop`
   ```
4. **Apply on `apply`.** Edit the file with the proposed text exactly as shown.
5. **Apply on `edit: <text>`.** Use the human's version instead.
6. **Skip on `skip`.** Move to the next candidate. Do not discuss, do not re-propose.
7. **Halt on `stop`.** End the polish pass. Summarize what was applied and what remained.
8. **Summary.** After the last candidate or `stop`, produce:
   - Count applied / skipped / remaining
   - List of still-open issues the human flagged as `skip` with "edit" notes (these become TODOs)

## Critical Rules

1. Never auto-apply a polish suggestion — the human must explicitly reply `apply` or `edit:` before any edit is made.
2. Present exactly one candidate at a time. Never batch proposals.
3. Propose minimum-diff, exact-text edits. Show the current text and the proposed text in full.
4. The human is the editor; you are the reader with sharp eyes. Your role is to surface, not to decide.
5. Skip code refactors, document restructures, and logic changes. This skill is for copy, microcopy, and docs only.

## Mandatory Process

1. MUST pull the PR diff and scan every touched file for typos, grammar slips, inconsistent terminology, awkward phrasing, microcopy issues, and documentation gaps.
2. MUST rank all candidates by cost/benefit: cheap to apply + high reader impact first.
3. MUST present candidates one at a time using the standard format with `Current:`, `Proposed:`, `Why:`, and `Reply:` options.
4. MUST apply the edit only on explicit `apply` or `edit: <text>` replies; MUST skip on `skip` without discussion; MUST halt on `stop`.
5. MUST cap the pass at 30 candidates maximum. If more than 30 issues exist, return the PR to `/review`.
6. MUST produce a final summary with counts of applied, skipped, and flagged-as-TODO items.

## Automatic Fail Triggers

- Batching multiple polish candidates into a single proposal.
- Applying an edit without an explicit `apply` or `edit:` reply from the human.
- Proposing an abstract rewrite instead of showing exact `Current:` and `Proposed:` text.
- Restructuring code, logic, or document organization during a polish pass.
- Surfacing more than 30 candidates without halting and returning to `/review`.
- Continuing after the human replies `stop`.

## Deliverable Template

```markdown
⏸ POLISH #<n> — <file:line>

Current:
  <exact current text>

Proposed:
  <exact proposed text>

Why: <one-line rationale>

Reply: `apply` | `edit: <your version>` | `skip` | `stop`
```

## Success Metrics for This Skill

- 100% of typos and spelling errors in the diff are surfaced to the human.
- 100% of inconsistent terminology across touched files is flagged.
- 0% of proposed edits are auto-applied without explicit human approval.
- 90%+ of surfaced candidates receive an `apply` or `edit:` response (high signal-to-noise ratio).
- Average time from candidate presentation to human decision is under 2 minutes.

## Rules

- One candidate at a time. Never batch. The human reads each proposal in isolation.
- Never apply without an explicit `apply` or `edit:` reply.
- Propose minimum-diff edits. If a sentence needs rewriting, propose the new sentence in full — do not propose "rewrite this" abstractly.
