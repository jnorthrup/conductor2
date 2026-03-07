#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

grep -F -- 'RUNTIME_ROUTE="<host-resolved and confirmed runtime surface>"' "$ROOT_DIR/skill/SKILL.md" >/dev/null
grep -F -- '- If delegating, print that scaffold before work starts.' "$ROOT_DIR/skill/SKILL.md" >/dev/null
grep -F -- '- If not delegating, say `DELEGATION=none`.' "$ROOT_DIR/skill/SKILL.md" >/dev/null
grep -F -- '- Workers do not update truth artifacts.' "$ROOT_DIR/skill/SKILL.md" >/dev/null

grep -F -- '- If delegated/background workers are used, the agent must emit the exact launch scaffold in the user-visible transcript before delegation begins.' "$ROOT_DIR/commands/conductor/implement.toml" >/dev/null
grep -F -- '| Launch Transcript | The exact launch scaffold must be printed in-thread before delegation starts. Withheld or post-hoc launch blocks are invalid. |' "$ROOT_DIR/commands/conductor/implement.toml" >/dev/null
grep -F -- '  Worker A: "<bounded corpus + one slice>"' "$ROOT_DIR/commands/conductor/implement.toml" >/dev/null
grep -F -- '- exact launch scaffold emitted for delegated work, or `DELEGATION=none`' "$ROOT_DIR/commands/conductor/implement.toml" >/dev/null

grep -F -- '- Hidden delegation and post-hoc launch narration are invalid.' "$ROOT_DIR/README.md" >/dev/null
grep -F -- '- If no delegation is used, state `DELEGATION=none` explicitly.' "$ROOT_DIR/README.md" >/dev/null
