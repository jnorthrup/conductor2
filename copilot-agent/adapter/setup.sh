#!/usr/bin/env bash
set -euo pipefail

# Adapter: run the conductor setup command
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
CONDUCTOR_CMD="$ROOT_DIR/commands/conductor/setup.toml"
RUN_CONDUCTOR="$ROOT_DIR/skill/scripts/run-conductor.sh"

# The repository organizes conductor commands as TOML; we assume a helper exists (`skill/` or `scripts`) to run them.
# Fallback: if there's an `skill/scripts` or similar, call an invoker; otherwise print the path.

if command -v conductor >/dev/null 2>&1; then
  conductor setup "$@"
elif [ -x "$RUN_CONDUCTOR" ]; then
  "$RUN_CONDUCTOR" setup "$@"
else
  echo "No 'conductor' CLI detected; to run the setup open: $CONDUCTOR_CMD"
fi
