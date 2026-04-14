#!/bin/bash
set -e

# Solo Squad version bump script
# Usage: ./scripts/bump-version.sh <new-version>
# Example: ./scripts/bump-version.sh 2.1.0

if [ -z "$1" ]; then
  echo "Usage: $0 <new-version>"
  echo "Current versions:"
  echo "  package.json:            $(jq -r .version package.json)"
  echo "  plugin.json:             $(jq -r .version .claude-plugin/plugin.json)"
  echo "  marketplace.json:        $(jq -r '.plugins[0].version' .claude-plugin/marketplace.json)"
  echo "  cursor plugin.json:      $(jq -r .version .cursor-plugin/plugin.json)"
  echo "  gemini-extension.json:   $(jq -r .version gemini-extension.json)"
  exit 1
fi

NEW_VERSION="$1"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$SCRIPT_DIR")"

cd "$ROOT"

echo "Bumping to $NEW_VERSION..."

# package.json
jq --arg v "$NEW_VERSION" '.version = $v' package.json > tmp.$$.json && mv tmp.$$.json package.json
echo "  ✓ package.json"

# .claude-plugin/plugin.json
jq --arg v "$NEW_VERSION" '.version = $v' .claude-plugin/plugin.json > tmp.$$.json && mv tmp.$$.json .claude-plugin/plugin.json
echo "  ✓ .claude-plugin/plugin.json"

# .claude-plugin/marketplace.json
jq --arg v "$NEW_VERSION" '.plugins[0].version = $v' .claude-plugin/marketplace.json > tmp.$$.json && mv tmp.$$.json .claude-plugin/marketplace.json
echo "  ✓ .claude-plugin/marketplace.json"

# .cursor-plugin/plugin.json
jq --arg v "$NEW_VERSION" '.version = $v' .cursor-plugin/plugin.json > tmp.$$.json && mv tmp.$$.json .cursor-plugin/plugin.json
echo "  ✓ .cursor-plugin/plugin.json"

# gemini-extension.json
jq --arg v "$NEW_VERSION" '.version = $v' gemini-extension.json > tmp.$$.json && mv tmp.$$.json gemini-extension.json
echo "  ✓ gemini-extension.json"

echo ""
echo "Done. All manifests now at $NEW_VERSION"
echo "Don't forget to update CHANGELOG.md"
