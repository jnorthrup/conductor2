#!/bin/bash
set -euo pipefail

# Packages the Conductor skill into a Codex-friendly zip archive.
# Output: conductor-codex-skill.zip in repo root.

ROOT_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
OUTPUT="$ROOT_DIR/conductor-codex-skill.zip"
TEMP_DIR="$(mktemp -d)"

cleanup() {
  rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

SKILL_DST="$TEMP_DIR/conductor"
mkdir -p "$SKILL_DST"

# Copy required artifacts (no VCS/CI files)
cp "$ROOT_DIR/skill/SKILL.md" "$SKILL_DST/"
cp -r "$ROOT_DIR/commands" "$SKILL_DST/"
cp -r "$ROOT_DIR/templates" "$SKILL_DST/"

# Remove unwanted files (e.g., macOS metadata, CI)
find "$SKILL_DST" -name '.DS_Store' -delete

# Create zip
cd "$TEMP_DIR"
zip -rq "$OUTPUT" conductor -x '*/.git*' '*/.github*' '*/.DS_Store'

echo "Created Codex skill archive at: $OUTPUT"
