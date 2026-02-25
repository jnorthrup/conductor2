#!/usr/bin/env bash
set -euo pipefail

# Simple invoker for Conductor commands defined in commands/conductor/*.toml
# Usage: run-conductor.sh <command> [args]

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
CMD_DIR="$REPO_ROOT/commands/conductor"

if [ $# -lt 1 ]; then
  echo "Usage: $0 <command> [args]"
  echo "Available commands:"
  ls -1 "$CMD_DIR" | sed 's/\.toml$//'
  exit 1
fi

cmd="$1"
shift || true

# Prefer local project binary, then global CLI. Fall back to showing the TOML.
if [ -f "$REPO_ROOT/conductor" ] && [ -x "$REPO_ROOT/conductor" ]; then
  "$REPO_ROOT/conductor" "$cmd" "$@"
  exit 0
fi

if command -v conductor >/dev/null 2>&1; then
  conductor "$cmd" "$@"
  exit 0
fi

# Fallback: show the TOML for the requested command (local project assumption)
toml="$CMD_DIR/${cmd}.toml"
if [ -f "$toml" ]; then
  echo "No conductor binary found. Showing command template for '$cmd': $toml"
  if [ $# -gt 0 ]; then
    echo "Args provided: $*"
  fi
  echo "---"
  sed -n '1,240p' "$toml"
else
  echo "Unknown command: $cmd"
  echo "Available commands:"
  ls -1 "$CMD_DIR" | sed 's/\.toml$//'
  exit 2
fi
