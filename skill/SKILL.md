---
name: conductor
description: Compact Conductor skill. Use when the user wants the Conductor workflow or asks to run `conductor implement`.
---

# Conductor

Core command:

`conductor implement`

This file is the canonical doctrine in `conductor2`.

## What Conductor Owns

- Conductor is the method.
- Project truth lives only in the target repo's local `/conductor/` directory.
- `conductor2` itself is not the active project state.
- Home-directory installs, caches, and sibling repos are not truth artifacts.

## Agent Surface Rules

- Codex, Claude Code, OpenCode, and Antigravity consume Conductor as a plain skill/context surface.
- Gemini CLI consumes Conductor through the extension surface (`SKILL.md` plus `gemini-extension.json`).
- Antigravity is not Gemini CLI; do not assume Gemini-specific slash-command or extension behavior there.
- Unless the task explicitly targets Conductor itself, do not create or rewrite Conductor's own scripts, wrappers, installers, or command TOMLs in the target repo.
- Prefer the existing surfaces (`skill/SKILL.md`, `commands/conductor/*.toml`, `templates/workflow.md`, `skill/scripts/run-conductor.sh`) over inventing alternate Conductor automation.
- In product repos, work on product code plus the repo's local `/conductor/` artifacts, not on copied Conductor machinery.

## Closure Mode

- Build until the slice is working, tested, and committed.
- Do not stop for plans, options, status narration, or partial TODO cleanup.
- Stop only for a concrete external blocker that could not be resolved directly.
- Incomplete tracks or incomplete projects are not blockers; continue until a concrete slice is closed or a real external blocker is proven.
- Streamline the user's time: rediscover most context from the repo in-context during execution rather than front-loading brittle questionnaires.

## Worker Protocol

```
DELEGATED WORKER LAUNCH:
  WORKER_LIMITS=2
  BOUNDED_CORPUS="<exact files/dirs>"
  STOP_CONDITION="one slice or first blocker"

WORKER RETURNS:
  - changed files
  - verification command
  - result: passed|failed|blocked
  - blocker

CLOSING AGENT RECONCILIATION:
  1. Run verification
  2. Run focused tests
  3. Smoke/artifacts if relevant
  4. Only then update truth artifacts
```

- Workers are bounded executors, not truth authorities.
- Max 2 concurrent workers.
- Each worker declares an exact bounded corpus before starting.
- Workers stop after one slice or the first concrete blocker.
- Workers do not update `plan.md`, `tracks.md`, TODOs, or status artifacts.
- Workers do not claim TODO completion from tests alone.

## Runtime Contract

- Conductor does not choose models or runtimes.
- Humans or surrounding runtime surfaces choose them outside Conductor.
- Workers consume the supplied runtime only.
- If the supplied runtime is missing or broken, stop and report the blocker.

## Ownership Rules

- One canonical home per concept.
- Wrappers may expose behavior but do not own semantics.
- Migration shells preserve parity but should not accumulate new semantics.
- If ownership is unclear, name the owner before expanding duplicate surfaces.
- Work one repo at a time unless cross-repo work is actually required.

## TODO Rules

- `implement` may move code.
- `review` is the inspector for TODO truth.
- Do not mark TODOs complete when validation is partial, runtime is unproven, smoke evidence is missing, or a blocker remains.
- Early-stop sessions must reopen the TODO or leave a concrete blocker note.

## Anti-Drift Rules

- Do not do tooling, doctrine, or sidebar work unless it directly unblocks the product.
- Prefer bounded, concrete slices over broad discovery.
- Keep commands agent-agnostic where practical.
- Prefer minimal context and minimal drift.
