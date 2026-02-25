#!/usr/bin/env bash
set -euo pipefail

if command -v conductor >/dev/null 2>&1; then
  conductor implement "$@"
elif [ -x "$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/skill/scripts/run-conductor.sh" ]; then
  "$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/skill/scripts/run-conductor.sh" implement "$@"
else
  echo "No 'conductor' CLI detected; to run implement open: ../commands/conductor/implement.toml"
fi
