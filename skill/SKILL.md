---
name: conductor
description: Compact Conductor skill. Use when the user wants the Conductor workflow or asks to run `conductor implement`.
---

# Conductor

Core intent: `implement`

- Project truth is the target repo's local `/conductor/`.
- `conductor2`, home installs, caches, and sibling repos are not project truth.
- Conductor owns method, not runtime/model choice.
- In product repos, edit product code plus local `/conductor/` artifacts. Do not clone Conductor machinery unless changing Conductor itself.
- Prefer shipped surfaces: `skill/SKILL.md`, `commands/conductor/*.toml`, `templates/workflow.md`, `skill/scripts/run-conductor.sh`.
- Gemini CLI uses `SKILL.md` + `gemini-extension.json`; Antigravity is a plain skill surface.
- Stay in closure mode: work until the current slice is working, tested, and committed, or a concrete external blocker is proven.
- Incomplete track or project is not a blocker.
- `review` owns TODO truth.

Delegation:

```
DELEGATED WORKER LAUNCH:
  WORKER_LIMITS=2
  BOUNDED_CORPUS="<exact files/dirs>"
  STOP_CONDITION="one slice or first blocker"
  RUNTIME_ROUTE="<host-resolved and confirmed runtime surface>"
  Worker A: "<bounded corpus + one slice>"
  Worker B: "<bounded corpus + one slice>"  # omit if unused
```

- If delegating, print that scaffold before work starts.
- Use the literal field names. No hidden or post-hoc delegation.
- If not delegating, say `DELEGATION=none`.
- Workers are bounded executors, not truth authorities.
- Workers consume the supplied runtime only.
- Workers stop after one slice or first concrete blocker.
- Workers do not update truth artifacts.
- Workers return: changed files, verification command, result, blocker.
- Closing agent verifies runtime, focused tests, smoke/artifacts, then updates truth artifacts.

Ownership:

- One canonical home per concept.
- Wrappers wrap; migration shells preserve parity.
- Name the owner before expanding duplicate surfaces.
