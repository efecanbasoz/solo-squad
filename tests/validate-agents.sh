#!/bin/bash
set -euo pipefail

# validate-agents.sh
# Validates that every agent .md has the required frontmatter fields.

AGENTS_DIR="${1:-./agents}"
ERRORS=0

echo "🔍 Validating agent frontmatter in $AGENTS_DIR..."

for agent_file in "$AGENTS_DIR"/*.md; do
  if [ ! -f "$agent_file" ]; then
    continue
  fi

  agent_name=$(basename "$agent_file" .md)

  # Check frontmatter exists
  if ! head -n 1 "$agent_file" | grep -q '^---$'; then
    echo "  ❌ $agent_name: Missing frontmatter delimiter"
    ((ERRORS++)) || true
    continue
  fi

  # Extract frontmatter
  fm=$(awk 'BEGIN{skip=0} /^---$/{skip++; next} skip>=2{exit} skip>=1{print}' "$agent_file")

  # Required fields
  for field in name description model tools version; do
    if ! echo "$fm" | grep -qE "^${field}:"; then
      echo "  ❌ $agent_name: Missing '$field' in frontmatter"
      ((ERRORS++)) || true
    fi
  done

done

if [ "$ERRORS" -eq 0 ]; then
  echo "✅ All agent files have valid frontmatter."
  exit 0
else
  echo "❌ $ERRORS frontmatter error(s) found."
  exit 1
fi
