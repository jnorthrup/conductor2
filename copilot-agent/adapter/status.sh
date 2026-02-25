#!/usr/bin/env bash
set -euo pipefail

if command -v conductor >/dev/null 2>&1; then
  conductor status
elif [ -x "$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/skill/scripts/run-conductor.sh" ]; then
  "$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/skill/scripts/run-conductor.sh" status
else
  echo "No 'conductor' CLI detected; to run status open: ../commands/conductor/status.toml"
fi
