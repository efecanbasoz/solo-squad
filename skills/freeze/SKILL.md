---
name: freeze
version: "2.2.0"
description: Edit lock
triggers:
  - "lock edits"
  - "scope lock"
  - "restrict directory"
---

# Freeze

Restrict all file edits to a specified directory. Everything outside is read-only.

## Usage

Invoke with a directory path: `/freeze src/auth/`

## Behavior

- All file writes, edits, and deletions are BLOCKED outside the frozen scope.
- Read operations (cat, grep, find) work everywhere.
- The freeze boundary is displayed in every response as a reminder.
- Use `/unfreeze` to remove the restriction.

## Rules
- Freeze is advisory for the AI agent, not a filesystem permission change.
- Always display the freeze boundary when active.
- If the user asks to edit outside the boundary, remind them and ask if they want to unfreeze.
