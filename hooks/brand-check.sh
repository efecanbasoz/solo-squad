#!/bin/bash
set -e

INPUT=$(cat)

FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# Exit silently if no file path
if [ -z "$FILE_PATH" ]; then
  exit 0
fi

SHOULD_FIRE=false

# Fire for style and asset files
case "$FILE_PATH" in
  *.css|*.scss|*.svg) SHOULD_FIRE=true ;;
esac

# Fire if path contains /images/ or /assets/
case "$FILE_PATH" in
  */images/*|*/assets/*) SHOULD_FIRE=true ;;
esac

if [ "$SHOULD_FIRE" = true ]; then
  echo '{"additionalContext": "BRAND CHECK: Verify colors match the brand palette, typography uses approved font families and sizes, and any visual assets follow the brand guidelines. Check contrast ratios meet WCAG AA (4.5:1 for text, 3:1 for large text)."}'
fi

exit 0
