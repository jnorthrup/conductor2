# Conductor Methodology (Compact)

## Worker Protocol (Bounded + Hostile)

```
DELEGATED WORKER LAUNCH:
  WORKER_LIMITS=2
  BOUNDED_CORPUS="<exact files/dirs>"
  STOP_CONDITION="one slice or first blocker"

WORKER RETURNS (required):
  - changed files: [<list>]
  - verification: "<command run>"
  - result: "passed|failed|blocked"
  - blocker: "<concrete blocker or 'none'>"

CLOSING AGENT RECONCILIATION (hostile):
  1. Run verification command -> confirm pass
  2. Run focused tests -> confirm pass
  3. Smoke test artifacts -> confirm works
  4. Only then: mark TODO [x], update plan.md
```

| Concept | Rule |
|---------|------|
| Worker Limits | Max 2 concurrent. Each declares bounded corpus before launch. |
| Bounded Corpus | Exact files/dirs. No subsystem discovery. |
| Stop Condition | One slice or first concrete blocker. |
| Rendezvous Payload | changed files, verification command, result, blocker |
| Truth-Artifact Ownership | Only closing agent writes plan.md, tracks.md, status |
| Reconciliation Order | 1) Runtime, 2) Tests, 3) Smoke/artifacts, 4) Truth docs |
| History Hygiene | No branches/worktrees/sessions. Squash theatrical history. |
| Forbidden Moves | Workers cannot flip status, claim completion from tests alone, or touch truth artifacts. |

Workers are proposal engines, not truth authorities. Output must survive hostile reconciliation before plan advancement.

---

## Core Principles

1. **Kolmogorov Normalized Consolidation** – Treat every piece of project knowledge (specs, plans, code, tests) as a random variable in a shared probability space. By normalizing these variables we compute information entropy and enforce a minimal entropy increase for each new change, guaranteeing no hidden assumptions slip in.
2. **First‑Principles Decomposition** – Break any high‑level goal into atomic statements that are free of domain‑specific jargon. Each atom maps to a concrete markdown file in `conductor/` (e.g., `product.md`, `tech‑stack.md`), ensuring traceability from intent to implementation.
3. **Context‑Driven Development** – The AI agent never executes a task without loading **all** relevant markdown artifacts into its working context. This eliminates the need for external configuration files; the repo itself is the full spec.
4. **Agent‑Agnostic Protocols** – All commands (`setup`, `newTrack`, `implement`, …) are defined in TOML under `commands/conductor/`. Any AI coding agent that can read TOML can drive the workflow, making the system portable across Claude Code, OpenCode, Gemini CLI, Codex, etc.
5. **Iterative Entropy Check** – Before committing, the agent runs an entropy audit (`claude -p entropy-check`) which validates that added markdown/files do not increase the project's uncertainty beyond a defined threshold (default 0.01 bits per line).
6. **Token Count Optimization (optional)** – For endgame performance, keep optional variants (including reduced-language variants) out of the primary methodology context and use a smaller reduced artifact only when needed.
7. **Minimal LLM Context** – By treating optional variants as a token-count decision and keeping the methodology compact and focused, we preserve expressive power while minimizing context overhead.
8. **Per-Track Bounded-Corpus 100% Slices** – A task is "100%" only within an active track's declared task block and bounded corpus. New file reads outside that corpus are entropy events: log them, re-estimate, and split/re-scope if needed. `newTrack` captures broad scope first; `implement` creates the bounded `100%` execution contract.
