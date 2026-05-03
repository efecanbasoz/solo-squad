#!/bin/bash
set -euo pipefail

# validate-frontmatter.sh
# Validates that every SKILL.md has the required frontmatter fields.

SKILLS_DIR="${1:-./skills}"
ERRORS=0

echo "🔍 Validating SKILL.md frontmatter in $SKILLS_DIR..."

for skill_file in "$SKILLS_DIR"/*/SKILL.md; do
  if [ ! -f "$skill_file" ]; then
    continue
  fi

  skill_name=$(basename "$(dirname "$skill_file")")

  # Check frontmatter exists
  if ! head -n 1 "$skill_file" | grep -q '^---$'; then
    echo "  ❌ $skill_name: Missing frontmatter delimiter"
    ((ERRORS++)) || true
    continue
  fi

  # Extract frontmatter
  fm=$(awk 'BEGIN{skip=0} /^---$/{skip++; next} skip>=2{exit} skip>=1{print}' "$skill_file")

  # Required fields
  for field in name version description triggers; do
    if ! echo "$fm" | grep -qE "^${field}:"; then
      echo "  ❌ $skill_name: Missing '$field' in frontmatter"
      ((ERRORS++)) || true
    fi
  done

  # Validate name matches directory
  dir_name=$(basename "$(dirname "$skill_file")")
  fm_name=$(echo "$fm" | grep '^name:' | sed 's/^name: *//')
  if [ "$fm_name" != "$dir_name" ]; then
    echo "  ❌ $skill_name: Frontmatter name ('$fm_name') does not match directory ('$dir_name')"
    ((ERRORS++)) || true
  fi

  # Validate version is 2.2.0
  fm_version=$(echo "$fm" | grep '^version:' | sed 's/^version: *//; s/"//g')
  if [ "$fm_version" != "2.2.0" ]; then
    echo "  ⚠️  $skill_name: Version is '$fm_version', expected '2.2.0'"
  fi

  # Validate triggers is a list with at least 1 item
  trigger_count=$(echo "$fm" | grep -c '^  -')
  if [ "$trigger_count" -lt 1 ]; then
    echo "  ❌ $skill_name: No triggers defined"
    ((ERRORS++)) || true
  fi

done

if [ "$ERRORS" -eq 0 ]; then
  echo "✅ All SKILL.md files have valid frontmatter."
  exit 0
else
  echo "❌ $ERRORS frontmatter error(s) found."
  exit 1
fi
