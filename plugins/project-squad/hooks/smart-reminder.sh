#!/bin/bash
set -e

INPUT=$(cat)

COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# Exit silently if no command
if [ -z "$COMMAND" ]; then
  exit 0
fi

# Only fire if command contains deployment-related keywords
if echo "$COMMAND" | grep -qE 'git push|deploy|vercel'; then
  echo '{"additionalContext": "DEPLOYMENT LOG: A deployment or push command was detected. Log this in PROGRESS.md for the sprint retro: what was deployed, which environment, and any config changes. Update TASKS.md if this completes a task."}'
fi

exit 0
