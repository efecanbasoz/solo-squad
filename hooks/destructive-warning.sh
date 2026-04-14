#!/bin/bash
set -e

INPUT=$(cat)

COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# Exit silently if no command
if [ -z "$COMMAND" ]; then
  exit 0
fi

# Check for destructive patterns
if echo "$COMMAND" | grep -qE 'rm -rf|DROP TABLE|DROP DATABASE|TRUNCATE|git push --force|git push -f |git reset --hard|git clean|chmod -R 777'; then
  echo '{"additionalContext": "DESTRUCTIVE COMMAND WARNING: This command matches a destructive pattern and could cause irreversible damage. Confirm with the user before proceeding. Suggest a safer alternative if one exists (e.g., git stash instead of git reset --hard, rm with explicit paths instead of rm -rf)."}'
fi

exit 0
