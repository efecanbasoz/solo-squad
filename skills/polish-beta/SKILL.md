---
description: "Human-in-the-loop polish phase between /review and /land-and-deploy. Surfaces low-risk last-mile tweaks (typos, tone, copy, microcopy) one at a time for human approval. Never auto-applies."
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

## Rules

- One candidate at a time. Never batch. The human reads each proposal in isolation.
- Never apply without an explicit `apply` or `edit:` reply.
- Propose minimum-diff edits. If a sentence needs rewriting, propose the new sentence in full — do not propose "rewrite this" abstractly.
- Skip refactors. This is not the place to restructure code or reorganize documents.
- If there are more than 15 candidates, propose the top 10 by cost/benefit and ask the human whether to surface the rest.
- Maximum 30 candidates per pass. Beyond that, the PR is not ready for polish — send it back to `/review`.

## HITL protocol (used by other skills)

Other Solo Squad skills reference this protocol when running in `--hitl` mode. The format is:

```
⏸ HITL — <one-line context of what to review>
Reply: `approve` | `edit: <notes>` | `reject`
```

- `approve` → proceed with the current proposal/artifact unchanged
- `edit: <notes>` → revise using the notes, re-surface for approval
- `reject` → halt the skill; the human will redirect

Skills that use this protocol declare their checkpoints in an `## HITL Checkpoints` section so the human knows where pauses will happen.

## Deliverables

- Applied edits (one commit per batch, or per edit if the human prefers)
- Summary: applied / skipped / flagged-as-TODO counts
- List of TODO items from `skip` replies with "edit" notes for follow-up
