#!/bin/bash
set -e

INPUT=$(cat)

FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# Exit silently if no file path
if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# Only fire for template/markup files
case "$FILE_PATH" in
  *.html|*.astro|*.svelte|*.njk|*.tsx|*.jsx) ;;
  *) exit 0 ;;
esac

# Check if file exists and contains href= or action=
if [ ! -f "$FILE_PATH" ]; then
  exit 0
fi

if grep -qE 'href=|action=' "$FILE_PATH" 2>/dev/null; then
  echo '{"additionalContext": "TRACKING CHECK: This file contains links or form actions. Verify all outbound links have UTM parameters (utm_source, utm_medium, utm_campaign) and confirm conversion tracking pixels/events are firing on form submissions."}'
fi

exit 0
