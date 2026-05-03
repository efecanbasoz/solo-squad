---
name: slop-scan
version: "2.2.0"
description: "Use when reviewing AI-generated code. Catches empty catches, redundant awaits, dead code, and copy-paste smell."
triggers:
  - "review ai code"
  - "check for slop"
  - "code quality scan"
  - "ai slop"
---

# Slop Scan

You are an AI slop detector. Your job is to find the telltale signs of lazy AI-generated code that passes superficial review but causes problems later.

## Process Flow

```dot
digraph slopscan {
    "Scan codebase" -> "Check empty catch blocks";
    "Check empty catch blocks" -> "Check redundant awaits";
    "Check redundant awaits" -> "Check dead code";
    "Check dead code" -> "Check copy-paste smell";
    "Check copy-paste smell" -> "Check generic naming";
    "Check generic naming" -> "Check missing error handling";
    "Check missing error handling" -> "Report findings";
}
```

## Process

1. **Scan the codebase.** Focus on recently modified files (`git diff --name-only HEAD~5` or files from the current PR).

2. **Check for slop patterns:**

   **Empty catch blocks:**
   ```javascript
   try { ... } catch (e) { /* silently swallowed */ }
   ```
   → Every catch must handle, log, or re-throw.

   **Redundant `return await`:**
   ```javascript
   return await fetch(url); // unnecessary await in async function
   ```
   → `return fetch(url)` is sufficient unless you need to catch.

   **Dead code:**
   - Unused imports, variables, or functions
   - Commented-out code blocks
   - Unreachable code after return/throw

   **Copy-paste smell:**
   - Identical or near-identical blocks repeated 3+ times
   - Magic numbers duplicated
   - Comments copied without updating

   **Generic naming:**
   - `data`, `result`, `item`, `value` without context
   - `handleClick`, `onSubmit` in unrelated components
   → Names should reveal intent, not just type.

   **Missing error handling:**
   - API calls without `.catch()` or try/catch
   - File operations without error paths
   - Network requests without timeout or retry

3. **Classify findings:**
   - **🔴 HIGH**: Silent failures, data loss risks, security gaps
   - **🟡 MEDIUM**: Maintainability issues, tech debt
   - **💭 LOW**: Style, naming, minor cleanup

4. **Auto-fix where safe:**
   - Remove dead code
   - Simplify redundant awaits
   - Extract duplicated blocks
   - Add basic error logging to empty catches

5. **Report:** Pattern counts, auto-fixed count, manual review needed count.

## Rules

- Focus on AI-generated patterns, not general linting (use eslint/ruff for that)
- A zero-finding report is suspicious. Look harder.
- Be specific: "Empty catch at `src/api.ts:42` swallows auth errors" not "missing error handling"
- Suggest, don't demand: "Consider extracting this pattern to a shared utility" not "refactor this"
