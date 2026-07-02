#!/bin/bash
set -euo pipefail

# validate-solo-invariants.sh
# Validates Solo Squad-specific conventions beyond basic frontmatter.

ROOT_DIR="${1:-.}"
SKILLS_DIR="$ROOT_DIR/skills"
COMMANDS_DIR="$ROOT_DIR/commands"
EXPECTED_SKILLS="${EXPECTED_SKILLS:-27}"
EXPECTED_COMMANDS="${EXPECTED_COMMANDS:-6}"
ERRORS=0

fail() {
  echo "  ❌ $1"
  ((ERRORS++)) || true
}

warn() {
  echo "  ⚠️  $1"
}

echo "🔍 Validating Solo Squad invariants in $ROOT_DIR..."

if [ ! -d "$SKILLS_DIR" ]; then
  fail "Missing skills directory: $SKILLS_DIR"
else
  actual_skills=$(find "$SKILLS_DIR" -maxdepth 2 -name 'SKILL.md' | wc -l | tr -d ' ')
  if [ "$actual_skills" != "$EXPECTED_SKILLS" ]; then
    fail "Expected $EXPECTED_SKILLS skills, found $actual_skills"
  fi
fi

if [ ! -d "$COMMANDS_DIR" ]; then
  fail "Missing commands directory: $COMMANDS_DIR"
else
  actual_commands=$(find "$COMMANDS_DIR" -maxdepth 1 -name '*.md' | wc -l | tr -d ' ')
  if [ "$actual_commands" != "$EXPECTED_COMMANDS" ]; then
    fail "Expected $EXPECTED_COMMANDS commands, found $actual_commands"
  fi
fi

# Skill descriptions should trigger routing only. They should not contain step lists,
# arrows, or implementation-process prose that belongs in the body.
for skill_file in "$SKILLS_DIR"/*/SKILL.md; do
  [ -f "$skill_file" ] || continue
  skill_name=$(basename "$(dirname "$skill_file")")
  description=$(awk 'BEGIN{in_fm=0} /^---$/{in_fm++; next} in_fm==1 && /^description:/{sub(/^description:[[:space:]]*/, ""); print; exit}' "$skill_file" | sed 's/^"//; s/"$//')

  if [ -z "$description" ]; then
    fail "$skill_name: Missing description"
    continue
  fi

  if [ "${#description}" -gt 180 ]; then
    fail "$skill_name: Description is too long for trigger-only routing (${#description} chars)"
  fi

  if echo "$description" | grep -Eq '(^|[[:space:]])([0-9]+\.|first|then|after that|finally|->|→)([[:space:]]|$)'; then
    fail "$skill_name: Description appears to contain process details instead of trigger-only routing"
  fi
done

# Core skills must not encode host-specific branches. Put host mappings in
# skills/using-solo-squad/references/ and runtime detection in hooks.
platform_pattern='(^|[[:space:]])(Windows|macOS|Linux|POSIX|PowerShell|cmd\.exe|bash-only|zsh-only):'
while IFS= read -r match; do
  [ -n "$match" ] || continue
  fail "Platform-specific branch found in core skill: $match"
done < <(find "$SKILLS_DIR" -mindepth 2 -maxdepth 2 -name 'SKILL.md' -print0 | xargs -0 grep -nE "$platform_pattern" || true)

# Plugin manifests should advertise the current skill count in their descriptions.
for manifest in "$ROOT_DIR/.claude-plugin/plugin.json" "$ROOT_DIR/.codex-plugin/plugin.json" "$ROOT_DIR/package.json"; do
  if [ ! -f "$manifest" ]; then
    fail "Missing manifest: $manifest"
    continue
  fi

  if ! grep -q "${EXPECTED_SKILLS} skills" "$manifest"; then
    fail "$manifest: Manifest/package description does not mention '${EXPECTED_SKILLS} skills'"
  fi
done

# Compatibility and decision-memory docs are P0 governance surfaces.
[ -f "$ROOT_DIR/docs/compatibility.md" ] || fail "Missing docs/compatibility.md"
[ -f "$ROOT_DIR/docs/decisions/README.md" ] || fail "Missing docs/decisions/README.md"

# The routing table keeps review gates from being stacked blindly.
if ! grep -q '^## Review Routing' "$SKILLS_DIR/using-solo-squad/SKILL.md"; then
  fail "using-solo-squad skill is missing Review Routing guidance"
fi

if [ "$ERRORS" -eq 0 ]; then
  echo "✅ Solo Squad invariants are valid."
  exit 0
else
  warn "$ERRORS invariant error(s) found."
  exit 1
fi
