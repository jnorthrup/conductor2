#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT="$ROOT_DIR/skill/scripts/run-conductor.sh"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

BIN_DIR="$TMP_DIR/bin"
CACHE_DIR="$TMP_DIR/cache"
mkdir -p "$BIN_DIR"

for agent in qwen aider claude; do
  cat > "$BIN_DIR/$agent" <<EOF
#!/usr/bin/env bash
exit 0
EOF
  chmod +x "$BIN_DIR/$agent"
done

OUTPUT="$(
  PATH="$BIN_DIR:/usr/bin:/bin" \
  CONDUCTOR_PROJECT_CACHE_DIR="$CACHE_DIR" \
  "$SCRIPT" implement
)"

CACHE_FILE="$CACHE_DIR/agent-clients.tsv"
[ -f "$CACHE_FILE" ]

grep -Fx "claude	$BIN_DIR/claude" "$CACHE_FILE" >/dev/null
grep -Fx "qwen	$BIN_DIR/qwen" "$CACHE_FILE" >/dev/null
grep -Fx "aider	$BIN_DIR/aider" "$CACHE_FILE" >/dev/null

if grep -q '^surface=claude$' <<<"$OUTPUT"; then
  :
else
  echo "expected claude to be selected from supported priority order" >&2
  exit 1
fi

if grep -q '^cache='"$CACHE_FILE"'$' <<<"$OUTPUT"; then
  :
else
  echo "expected output to expose the cache path" >&2
  exit 1
fi
