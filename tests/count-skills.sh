#!/bin/bash
set -euo pipefail

# count-skills.sh
# Validates the expected number of skills exist.

SKILLS_DIR="${1:-./skills}"
EXPECTED_COUNT="${2:-27}"

echo "🔍 Counting skills in $SKILLS_DIR..."

ACTUAL_COUNT=$(find "$SKILLS_DIR" -maxdepth 2 -name 'SKILL.md' | wc -l)

echo "  Expected: $EXPECTED_COUNT"
echo "  Actual:   $ACTUAL_COUNT"

if [ "$ACTUAL_COUNT" -eq "$EXPECTED_COUNT" ]; then
  echo "✅ Skill count matches."
  exit 0
else
  echo "❌ Skill count mismatch. Expected $EXPECTED_COUNT, found $ACTUAL_COUNT."
  exit 1
fi
