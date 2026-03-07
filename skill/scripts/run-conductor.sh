#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SUPPORTED_AGENTS=(opencode kilo gemini claude qwen aider)

default_cache_dir() {
  local git_dir

  if git_dir="$(git -C "$ROOT_DIR" rev-parse --git-dir 2>/dev/null)"; then
    case "$git_dir" in
      /*) printf '%s/conductor/cache\n' "$git_dir" ;;
      *) printf '%s/%s/conductor/cache\n' "$ROOT_DIR" "$git_dir" ;;
    esac
    return 0
  fi

  printf '%s\n' "${TMPDIR:-/tmp}/conductor-cache"
}

CACHE_DIR="${CONDUCTOR_PROJECT_CACHE_DIR:-$(default_cache_dir)}"
CACHE_FILE="$CACHE_DIR/agent-clients.tsv"

ensure_agent_cache() {
  mkdir -p "$CACHE_DIR"

  : > "$CACHE_FILE"
  for agent in "${SUPPORTED_AGENTS[@]}"; do
    if path="$(command -v "$agent" 2>/dev/null)"; then
      printf '%s\t%s\n' "$agent" "$path" >> "$CACHE_FILE"
    fi
  done
}

resolve_agent_surface() {
  local agent

  if [ ! -f "$CACHE_FILE" ]; then
    return 1
  fi

  while IFS=$'\t' read -r agent _; do
    if [ -n "$agent" ]; then
      printf '%s\n' "$agent"
      return 0
    fi
  done < "$CACHE_FILE"

  return 1
}

ensure_agent_cache

if command -v conductor >/dev/null 2>&1; then
  conductor "$@"
  exit 0
fi

cmd="${1:-}"
if [ -z "$cmd" ]; then
  echo "usage: run-conductor.sh <setup|newTrack|implement|review|status|revert> [args...]"
  exit 1
fi

case "$cmd" in
  setup|newTrack|implement|review|status|revert)
    command_path="$ROOT_DIR/commands/conductor/$cmd.toml"
    if surface="$(resolve_agent_surface)"; then
      printf 'surface=%s\ncommand=%s\ncache=%s\n' "$surface" "$command_path" "$CACHE_FILE"
    else
      printf 'surface=unresolved\ncommand=%s\ncache=%s\n' "$command_path" "$CACHE_FILE"
    fi
    ;;
  *)
    echo "unknown conductor command: $cmd"
    exit 1
    ;;
esac
