#!/bin/bash
set -e

INPUT=$(cat)

FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# Exit silently if no file path
if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# Only fire for source code files
case "$FILE_PATH" in
  *.ts|*.tsx|*.js|*.jsx) ;;
  *) exit 0 ;;
esac

# Skip test files
case "$FILE_PATH" in
  *.test.*|*.spec.*) exit 0 ;;
esac

# Check if a corresponding test file exists
DIR=$(dirname "$FILE_PATH")
BASENAME=$(basename "$FILE_PATH")
EXT="${BASENAME##*.}"
NAME="${BASENAME%.*}"

# Search for test files in common locations
FOUND_TEST=false

for PATTERN in \
  "${DIR}/${NAME}.test.${EXT}" \
  "${DIR}/${NAME}.spec.${EXT}" \
  "${DIR}/__tests__/${NAME}.test.${EXT}" \
  "${DIR}/__tests__/${NAME}.spec.${EXT}"; do
  if [ -f "$PATTERN" ]; then
    FOUND_TEST=true
    break
  fi
done

# Also check for a test/ directory at project root level
if [ "$FOUND_TEST" = false ]; then
  SEARCH_DIR="$DIR"
  while [ "$SEARCH_DIR" != "/" ]; do
    if [ -f "${SEARCH_DIR}/package.json" ] || [ -f "${SEARCH_DIR}/tsconfig.json" ]; then
      for PATTERN in \
        "${SEARCH_DIR}/test/${NAME}.test.${EXT}" \
        "${SEARCH_DIR}/test/${NAME}.spec.${EXT}" \
        "${SEARCH_DIR}/tests/${NAME}.test.${EXT}" \
        "${SEARCH_DIR}/tests/${NAME}.spec.${EXT}"; do
        if [ -f "$PATTERN" ]; then
          FOUND_TEST=true
          break 2
        fi
      done
      break
    fi
    SEARCH_DIR=$(dirname "$SEARCH_DIR")
  done
fi

# Only fire if no test file exists
if [ "$FOUND_TEST" = false ]; then
  echo '{"additionalContext": "TDD REMINDER: No test file found for this source file. Write the test first, then implement the code. Delete the implementation and start with a failing test."}'
fi

exit 0
