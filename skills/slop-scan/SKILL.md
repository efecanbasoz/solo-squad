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

## Critical Rules

1. **Focus on AI slop patterns, not general linting.** eslint/ruff handles style. You handle logic smell.
2. **A zero-finding report is suspicious.** Look harder.
3. **Be specific.** "Empty catch at `src/api.ts:42` swallows auth errors" not "missing error handling."
4. **Auto-fix only when safe.** Remove dead code, simplify awaits, extract duplicates, add basic logging.
5. **Classify every finding.** 🔴 HIGH / 🟡 MEDIUM / 💭 LOW with confidence.

## Mandatory Process

Before reporting, you MUST:

1. **Scan recently modified files.** `git diff --name-only HEAD~5` or PR files.
2. **Check all slop patterns.** Empty catches, redundant awaits, dead code, copy-paste smell, generic naming, missing error handling.
3. **Classify findings.** 🔴 HIGH: silent failures, data loss, security gaps. 🟡 MEDIUM: maintainability. 💭 LOW: style.
4. **Auto-fix where safe.** Remove dead code, simplify awaits, extract duplicates, add logging.
5. **Report with specifics.** File, line, pattern, impact.

## Automatic Fail Triggers

- Zero findings reported without exhaustive scan.
- General linting issues reported as slop (use eslint/ruff for style).
- Vague findings without file/line references.
- Auto-fix applied unsafely (changing behavior).
- Missing error handling classified as LOW.

## Deliverable Template

```
=== SLOP SCAN ===
Scope: <files scanned>

PATTERN COUNTS
- Empty catch blocks: <count>
- Redundant awaits: <count>
- Dead code: <count>
- Copy-paste smell: <count>
- Generic naming: <count>
- Missing error handling: <count>

🔴 HIGH (<count>)
- <File>:<Line> — <Pattern> — <Impact>

🟡 MEDIUM (<count>)
- <File>:<Line> — <Pattern> — <Impact>

💭 LOW (<count>)
- <File>:<Line> — <Pattern> — <Impact>

AUTO-FIXES APPLIED
- <File>: <What was fixed>

MANUAL REVIEW NEEDED
- <File>:<Line> — <Why auto-fix was unsafe>
```

## Success Metrics for This Skill

- All 6 patterns checked: 100%
- Every finding has file:line reference: 100%
- Auto-fixes are behavior-preserving: 100%
- Zero-finding reports double-checked: 100%

## Rules
- Suggest, don't demand: "Consider extracting this pattern to a shared utility" not "refactor this"
