---
description: "After shipping, update every doc the change touched: README, CHANGELOG, API reference, migration notes, and in-repo guides. Catch stale docs before they mislead the next reader."
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

## Rules

- Every code example you add must run. Copy-paste test before commit.
- Never auto-regenerate screenshots — UI docs require a visual review pass.
- If the CHANGELOG is missing, create it with Keep-a-Changelog structure before adding entries.
- Preserve the existing voice and structure. This skill updates docs, it does not rewrite them.
- Hand off to `/technical-writing` for anything beyond mechanical updates (new guides, restructured references, major rewrites).

## Deliverables

- Diff-scan report (the subagent JSON, captured in the PR description)
- Inline edits to all affected doc files
- New CHANGELOG entry under the release version
- `docs/TODO.md` entries for remaining human-required updates
- List of stale screenshots flagged for regeneration
