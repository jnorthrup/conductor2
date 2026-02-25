#!/bin/bash
# Install Conductor for multiple AI shells
# Copies only the essential LLM-facing files, ignoring repo metadata.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
CONDUCTOR_ROOT="$(dirname "$SKILL_DIR")"

echo "Conductor Installer"
echo "==================="
echo ""

if [ ! -f "$CONDUCTOR_ROOT/commands/conductor/setup.toml" ]; then
    echo "Error: Run from within the Conductor repository."
    exit 1
fi

echo "Source: $CONDUCTOR_ROOT"
echo ""

install_skill() {
    local TARGET="$1"
    local CONTEXT_FILE="$2"
    echo "  $TARGET"
    rm -rf "$TARGET"
    mkdir -p "$TARGET"
    cp "$CONTEXT_FILE" "$TARGET/SKILL.md"
    cp "$SKILL_DIR/methodology_compact.md" "$TARGET/methodology_compact.md"
    cp "$SKILL_DIR/methodology_compact.md" "$TARGET/methodology.md"
    ln -s "$CONDUCTOR_ROOT/commands" "$TARGET/commands"
    ln -s "$CONDUCTOR_ROOT/templates" "$TARGET/templates"
}

install_gemini() {
    local TARGET="$1"
    echo "  $TARGET (Gemini CLI)"
    rm -rf "$TARGET"
    mkdir -p "$TARGET"
    cp "$CONDUCTOR_ROOT/GEMINI.md" "$TARGET/GEMINI.md"
    cp "$CONDUCTOR_ROOT/gemini-extension.json" "$TARGET/gemini-extension.json"
    ln -s "$CONDUCTOR_ROOT/commands" "$TARGET/commands"
    ln -s "$CONDUCTOR_ROOT/templates" "$TARGET/templates"
}

echo "Installing to:"
install_skill "$HOME/.opencode/skill/conductor" "$SKILL_DIR/SKILL.md"
install_skill "$HOME/.claude/skills/conductor" "$SKILL_DIR/SKILL.md"
install_skill "$HOME/.codex/skills/conductor" "$SKILL_DIR/SKILL.md"
install_gemini "$HOME/.gemini/extensions/conductor"
install_skill "$HOME/.gemini/antigravity/skills/conductor" "$SKILL_DIR/SKILL.md"

echo ""
echo "Done. Installed:"
echo "  commands/   -> setup, newTrack, implement, status, revert"
echo "  templates/  -> workflow.md, code_styleguides/"
echo ""
echo "Restart your AI shell to activate."
