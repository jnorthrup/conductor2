#!/bin/bash
# Install the compact Conductor skill.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"

echo "Conductor Installer"
echo "==================="
echo ""

install_skill() {
    local TARGET="$1"
    echo "  $TARGET"
    rm -rf "$TARGET"
    mkdir -p "$TARGET"
    cp "$SKILL_DIR/SKILL.md" "$TARGET/SKILL.md"
}

echo "Installing to:"
install_skill "$HOME/.opencode/skill/conductor"
install_skill "$HOME/.claude/skills/conductor"
install_skill "$HOME/.codex/skills/conductor"
install_skill "$HOME/.gemini/antigravity/skills/conductor"

echo ""
echo "Done. Installed:"
echo "  SKILL.md"
echo ""
echo "Restart your AI shell to activate."
