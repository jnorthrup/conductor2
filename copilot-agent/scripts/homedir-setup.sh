#!/usr/bin/env bash
set -euo pipefail

# Idempotent homedir setup for the conductor agent
# - installs local helpers to ~/.local/bin/conductor-agent
# - adds a small wrapper to call `conductor` or fallback to the repository scripts

INSTALL_DIR="$HOME/.local/bin"
WRAPPER="$INSTALL_DIR/conductor-agent"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
RUN_CONDUCTOR="$REPO_ROOT/skill/scripts/run-conductor.sh"

mkdir -p "$INSTALL_DIR"

cat > "$WRAPPER" <<EOF
#!/usr/bin/env bash
set -euo pipefail

# Wrapper: prefer installed 'conductor' CLI, otherwise invoke repository's skill script
if command -v conductor >/dev/null 2>&1; then
  conductor "\$@"
else
  REPO_ROOT="\${CONDUCTOR_REPO_ROOT:-$REPO_ROOT}"
  RUN_CONDUCTOR="\$REPO_ROOT/skill/scripts/run-conductor.sh"
  if [ -x "\$RUN_CONDUCTOR" ]; then
    "\$RUN_CONDUCTOR" "\$@"
  else
    echo "No conductor CLI available and no repository invoker found. Expected: \$RUN_CONDUCTOR"
    echo "Use the files in \$REPO_ROOT/commands/conductor or set CONDUCTOR_REPO_ROOT."
    exit 1
  fi
fi
EOF

chmod +x "$WRAPPER"

cat <<EOF
Installed conductor-agent wrapper to: $WRAPPER
Ensure $INSTALL_DIR is in your PATH (e.g., add 'export PATH="$INSTALL_DIR:$PATH"' to your shell rc file).
EOF
