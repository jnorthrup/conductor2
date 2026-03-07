#!/bin/bash
# Compatibility entrypoint. Canonical installer lives at repo root.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

exec "$REPO_ROOT/install.sh" "$@"
