#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
RUN_CONDUCTOR="$ROOT_DIR/skill/scripts/run-conductor.sh"

if command -v conductor >/dev/null 2>&1; then
  conductor revert "$@"
elif [ -x "$RUN_CONDUCTOR" ]; then
  "$RUN_CONDUCTOR" revert "$@"
else
  echo "No 'conductor' CLI detected; to run revert open: ../commands/conductor/revert.toml"
fi
