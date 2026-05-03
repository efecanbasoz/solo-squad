---
name: document-release
version: "2.2.0"
description: After shipping, update every doc the change touched
triggers:
  - "update docs"
  - "sync docs"
  - "release notes"
---

# Document Release

You are the docs steward for a shipped change. Stale documentation is worse than no documentation — it actively misleads. Your job is to close the gap between what the code does and what the docs claim within the same release cycle.

## When to run

- Automatically after `/ship` merges a user-facing change.
- Manually when you suspect docs drift after a string of merges.
- Skip for pure internal refactors that do not touch public APIs, CLI flags, env vars, or user-facing UI strings.

## Process

1. **Diff scan** *[subagent]*: Dispatch a subagent to compare the release against the previous tag. Return contract:
   ```
   {
     "public_api_changes": [{ "file": ..., "symbol": ..., "kind": "added|changed|removed" }],
     "cli_flag_changes": [...],
     "env_var_changes": [...],
     "user_string_changes": [...],
     "config_schema_changes": [...]
   }
   ```
2. **Map changes to docs.** For each change, locate the doc sections that describe it:
   - Public API change → `docs/api/`, `README.md` API section, inline JSDoc/docstrings
   - CLI flag change → `README.md` usage section, `docs/cli/`, help-text strings
   - Env var change → `.env.example`, `README.md` configuration section, deployment guide
   - User string change → i18n files, in-app help content, screenshots in `docs/`
   - Config schema → example configs, schema reference, migration guide
3. **Apply updates directly.** Edit the doc sections to match current behavior. Include:
   - New: add the entry with a minimal working example
   - Changed: update the description, mark the previous form as deprecated if still supported
   - Removed: delete the entry; add a migration note to `CHANGELOG.md`
4. **CHANGELOG entry.** Add an entry under the next release version using Keep-a-Changelog format (`Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`, `Security`).
5. **Screenshot audit.** For UI changes, flag any screenshots in docs that now show outdated state. Do not regenerate screenshots here — that is a separate task. Just list the stale paths.
6. **Report remaining gaps.** Some updates require human input (architectural rationale, migration strategy prose). List these as `docs/TODO.md` entries with enough context for the next writer to finish them.

## Critical Rules

1. Every code example added to docs must be copy-paste tested and confirmed running before commit.
2. Preserve the existing documentation voice, structure, and terminology — update facts, never rewrite style.
3. All public API, CLI flag, env var, and config schema changes must be reflected in docs within the same release cycle.
4. CHANGELOG entries must follow Keep-a-Changelog format and be added before the PR is considered complete.
5. Complex rewrites, new guides, or structural changes must be handed off to `/technical-writing` — this skill handles mechanical updates only.

## Mandatory Process

1. MUST run a diff scan comparing the release against the previous tag to identify all public-facing changes.
2. MUST map each identified change to its corresponding documentation section (API docs, README, CLI docs, env examples, i18n, config references).
3. MUST apply inline updates directly: add new entries with working examples, update changed entries with deprecation notes, remove deleted entries with migration notes.
4. MUST add a CHANGELOG entry under the next release version in Keep-a-Changelog format.
5. MUST audit all screenshots in docs for UI changes and flag stale paths for regeneration.
6. MUST report remaining gaps requiring human input as structured `docs/TODO.md` entries with full context.

## Automatic Fail Triggers

- Adding or updating a code example that has not been executed and verified to run.
- Deleting a documented feature without adding a migration note to `CHANGELOG.md`.
- Rewriting documentation voice, structure, or terminology beyond mechanical fact updates.
- Skipping the CHANGELOG entry for any user-facing change.
- Auto-generating or replacing screenshots without a dedicated visual review pass.
- Shipping docs that describe behavior different from the released code.

## Deliverable Template

```markdown
## Document Release Report

### Diff-Scan Summary
- Public API changes: [N]
- CLI flag changes: [N]
- Env var changes: [N]
- User string changes: [N]
- Config schema changes: [N]

### Updated Docs
| Change | Doc File | Status |
|--------|----------|--------|
| ...    | ...      | Done   |

### CHANGELOG Entry
- [Version] — [Category]: [Description]

### Screenshot Audit
- Stale screenshots flagged: [paths]

### Remaining Gaps (docs/TODO.md)
- [ ] [File]: [Context for human writer]
```

## Success Metrics for This Skill

- 100% of public API changes documented in the same release cycle.
- 100% of CLI flag and env var changes reflected in README or dedicated docs.
- 100% of code examples added or updated are copy-paste tested and confirmed running.
- 0 stale screenshots in docs following a UI change (all flagged for regeneration).
- 100% of user-facing changes have a corresponding CHANGELOG entry in Keep-a-Changelog format.

## Rules

- Every code example you add must run. Copy-paste test before commit.
- Preserve the existing voice and structure. This skill updates docs, it does not rewrite them.
- Hand off to `/technical-writing` for anything beyond mechanical updates (new guides, restructured references, major rewrites).
