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
| Model Truth | Gateway `/models`, `/providers`, `/models-by-provider` is authoritative; client catalogs are hints. |
| Free-Lane Default | Use verified `:free` routes first for delegated workers unless paid capacity is explicitly required. |
| Host Wrapper | Prefer Literbike/OpenAI-compatible host wrappers for agent execution when available. |
| Env Contract | Declare required API keys up front; missing env is a blocker, not a guess. |
| Ownership Map | Cross-repo work must declare canonical home, host wrapper, compatibility shell, and duplicate surfaces. |
| Overlap Rule | One home per concept. Wrappers wrap, migration shells translate, duplicates do not become second truth centers. |
| TODO Authority | `review` is the inspector for TODO truth; `implement` does not self-certify ambiguous completion. |
| Early-Stop Rule | If work stops early, reopen to `[ ]` or leave `[~]` only with a concrete blocker note and resumable state. |
| Truth-Artifact Ownership | Only closing agent writes plan.md, tracks.md, status |
| Reconciliation Order | 1) Runtime, 2) Tests, 3) Smoke/artifacts, 4) Truth docs |
| History Hygiene | No branches/worktrees/sessions. Squash theatrical history. |
| Forbidden Moves | Workers cannot flip status, claim completion from tests alone, or touch truth artifacts. |

Workers are proposal engines, not truth authorities. Output must survive hostile reconciliation before plan advancement.

### Gateway-First Worker Routing

1. Discover delegated-worker models from the live gateway surface first:
   - `/models`
   - `/providers`
   - `/models-by-provider`
2. Choose a verified `provider/model:free` lane by default.
3. Launch workers through the host wrapper when available (for example Literbike/OpenAI-compatible routing) instead of trusting stale client-side model caches.
4. Declare the env contract before launch:
   - preferred gateway keys such as `KILO_API_KEY` or `KILOAI_API_KEY` for free gateway lanes
   - provider aliases when directly supported (`KIMI_API_KEY`, `ZAI_API_KEY`, etc.)
5. Treat missing env, missing gateway route, or route/entitlement mismatch as concrete blockers.

### Ownership and Overlap Resolution

For any concept that appears in more than one repo or runtime surface, declare:

1. **Canonical home**: where the concept should ultimately live
2. **Host wrapper / adapter**: which surface may expose or route it without owning it
3. **Compatibility shell**: which system exists temporarily for migration or regression parity
4. **Duplicate surfaces**: where the same behavior currently exists and should stop expanding

Decision rule:

- stable, deterministic, hot-path logic belongs in its long-term home
- wrappers expose but do not redefine
- migration shells maintain parity but do not accumulate new semantics
- deliberate parallel research must be labeled as such, or it is treated as drift

If the ownership map is unclear, the next action is not “code more”; it is “name the owner and freeze the duplicates.”

### TODO Truth and Early Stops

Conductor treats TODO state as an inspected claim, not a vibe.

1. `implement` may advance code and validation, but it should not mark a TODO `[x]` if:
   - the runtime path is still unproven
   - validation is partial or indirect
   - smoke/artifact evidence is missing where required
   - a concrete blocker still exists
2. `review` is the inspector of checked TODOs and early-stopped sessions.
3. `status` should report suspicious states, not just progress counts.

Inspector decision rule:

- keep `[x]` only when evidence is defensible
- reset to `[ ]` when completion was overstated
- allow `[~]` only when a concrete blocker/resume note exists

Early-stop damage is drift in plan state. The fix is not narrative; the fix is reopening the TODO or writing the blocker down explicitly.

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
