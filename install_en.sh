#!/usr/bin/env bash
# Compatibility entrypoint. Canonical installer lives at repo root.

set -e

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

exec "$ROOT/install.sh" "$@"
