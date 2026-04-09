#!/bin/bash
set -e

INPUT=$(cat)

FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# Exit silently if no file path
if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# Only fire if path contains proposals/, outreach/, or templates/
case "$FILE_PATH" in
  */proposals/*|*/outreach/*|*/templates/*) ;;
  *) exit 0 ;;
esac

echo '{"additionalContext": "PIPELINE LOG: This is a sales document (proposal/outreach/template). Log it for reuse on future deals. Update the deal tracker with this deliverable and tag it with the client name and deal stage for easy retrieval."}'

exit 0
