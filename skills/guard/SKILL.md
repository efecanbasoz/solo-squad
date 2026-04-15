---
name: guard
description: "Maximum safety mode: combines /careful (destructive command warnings) and /freeze (edit scope lock) in one command."
---

# Guard

Activate both `/careful` and `/freeze` simultaneously. Maximum safety for production work.

## Usage

`/guard src/payments/` activates:
1. Destructive command warnings (careful)
2. Edit scope locked to `src/payments/` (freeze)

## Rules
- Both protections stay active until explicitly deactivated.
- `/unfreeze` removes the edit lock but keeps careful active.
- To fully deactivate: "stand down" or "disable guard."
