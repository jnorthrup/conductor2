#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

assert_exact_entries() {
  local dir="$1"
  shift

  local expected
  local actual

  expected="$(printf '%s\n' "$@" | LC_ALL=C sort)"
  actual="$(cd "$dir" && printf '%s\n' * | LC_ALL=C sort)"

  if [ "$actual" != "$expected" ]; then
    echo "unexpected entries in $dir" >&2
    echo "expected:" >&2
    printf '%s\n' "$expected" >&2
    echo "actual:" >&2
    printf '%s\n' "$actual" >&2
    exit 1
  fi
}

assert_symlink_target() {
  local path="$1"
  local expected="$2"
  local actual

  [ -L "$path" ]
  actual="$(readlink "$path")"
  if [ "$actual" != "$expected" ]; then
    echo "unexpected symlink target for $path: $actual" >&2
    exit 1
  fi
}

assert_skill_layout() {
  local dir="$1"

  [ -f "$dir/SKILL.md" ]
  assert_exact_entries "$dir" "SKILL.md" "commands" "templates"
  assert_symlink_target "$dir/commands" "$ROOT_DIR/commands"
  assert_symlink_target "$dir/templates" "$ROOT_DIR/templates"
}

assert_gemini_layout() {
  local dir="$1"

  [ -f "$dir/SKILL.md" ]
  [ -f "$dir/gemini-extension.json" ]
  assert_exact_entries "$dir" "SKILL.md" "commands" "gemini-extension.json" "templates"
  assert_symlink_target "$dir/commands" "$ROOT_DIR/commands"
  assert_symlink_target "$dir/templates" "$ROOT_DIR/templates"
}

run_install_case() {
  local name="$1"
  local installer="$2"
  local home_dir="$TMP_DIR/$name-home"
  local work_dir="$TMP_DIR/$name-work"

  mkdir -p "$home_dir" "$work_dir"

  (
    cd "$work_dir"
    HOME="$home_dir" bash "$installer" >/dev/null
  )

  assert_skill_layout "$home_dir/.opencode/skill/conductor"
  assert_skill_layout "$home_dir/.claude/skills/conductor"
  assert_skill_layout "$home_dir/.codex/skills/conductor"
  assert_gemini_layout "$home_dir/.gemini/extensions/conductor"
  assert_skill_layout "$home_dir/.gemini/antigravity/skills/conductor"
}

run_install_case root "$ROOT_DIR/install.sh"
run_install_case skill-wrapper "$ROOT_DIR/skill/scripts/install.sh"
run_install_case compat-wrapper "$ROOT_DIR/install_en.sh"

GUARD_HOME="$TMP_DIR/guard-home"
mkdir -p "$GUARD_HOME"

if (
  cd "$ROOT_DIR"
  HOME="$GUARD_HOME" bash "$ROOT_DIR/install.sh" >"$TMP_DIR/guard-output.txt" 2>&1
); then
  echo "expected root installer guard to reject execution from source tree" >&2
  exit 1
fi

grep -F "Installer must not be run from the Conductor source tree" "$TMP_DIR/guard-output.txt" >/dev/null
