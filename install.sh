#!/bin/bash
# Install Conductor for OpenCode, Claude, Codex, Gemini CLI, Antigravity
# Usage: ./install.sh

set -e
ROOT="$(cd "$(dirname "$0")" && pwd)"

# Guard: do not run installer from the repository root
if [ "$(pwd)" = "$ROOT" ]; then
  echo "Installer must not be run from the Conductor source tree (current directory: $(pwd))."
  exit 1
fi

echo "Installing Conductor..."

install_skill_flavor() {
  local dir="$1"
  rm -rf "$dir"
  mkdir -p "$dir"
  cp "$ROOT/skill/SKILL.md" "$dir/"
  cp "$ROOT/skill/methodology_compact.md" "$dir/methodology_compact.md"
  cp "$ROOT/skill/methodology_compact.md" "$dir/methodology.md"
  ln -s "$ROOT/commands" "$dir/commands"
  ln -s "$ROOT/templates" "$dir/templates"
  echo "  $dir"
}

for dir in "$HOME/.opencode/skill/conductor" "$HOME/.claude/skills/conductor" "$HOME/.codex/skills/conductor"; do
  install_skill_flavor "$dir"
done

 dir="$HOME/.gemini/extensions/conductor"
rm -rf "$dir"
mkdir -p "$dir"
cp "$ROOT/GEMINI.md" "$dir/"
cp "$ROOT/gemini-extension.json" "$dir/"
ln -s "$ROOT/commands" "$dir/commands"
ln -s "$ROOT/templates" "$dir/templates"
echo "  $dir (Gemini CLI)"

dir="$HOME/.gemini/antigravity/skills/conductor"
install_skill_flavor "$dir"

echo "Done. Restart your AI shell."
