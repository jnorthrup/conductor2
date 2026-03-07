#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

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
    echo "$ROOT_DIR/commands/conductor/$cmd.toml"
    ;;
  *)
    echo "unknown conductor command: $cmd"
    exit 1
    ;;
esac
