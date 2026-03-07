#!/usr/bin/env bash
# Resolve script directory
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Generic installer
# $1 = target directory, $2 = type (skill|gemini)
install() {
    local TARGET="$1"
    local TYPE="$2"
    echo "  $TARGET"
    rm -rf "$TARGET" && mkdir -p "$TARGET"
    if [[ "$TYPE" == "gemini" ]]; then
        cp "$ROOT/skill/SKILL.md" "$TARGET/SKILL.md"
        cp "$ROOT/gemini-extension.json" "$TARGET/"
    else
        cp "$ROOT/skill/SKILL.md" "$TARGET/"
    fi
    ln -s "$ROOT/commands" "$TARGET/commands"
    ln -s "$ROOT/templates" "$TARGET/templates"
}

# Install primary skill destinations
for DIR in "$HOME/.opencode/skill/conductor" "$HOME/.claude/skills/conductor" "$HOME/.codex/skills/conductor"; do
    install "$DIR" skill
done

# Gemini extensions
install "$HOME/.gemini/extensions/conductor" gemini
install "$HOME/.gemini/antigravity/skills/conductor" skill

# Final user message
echo "Done - restart your AI shell."
