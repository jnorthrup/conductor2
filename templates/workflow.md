# Project Workflow

## Conductor Rules

- Project truth lives only in this repo's local `/conductor/` directory.
- Global installs, home-directory caches, and sibling repos are not truth artifacts.
- `conductor2` is the method, not the active project state.

## Agent Surface Rules

- Codex, Claude Code, OpenCode, and Antigravity use Conductor as a plain skill/context surface.
- Gemini CLI uses the extension surface; Antigravity is a separate Google skill surface and should not be treated like Gemini CLI.
- Do not create new Conductor scripts, wrappers, prompt files, or copied command definitions in this repo unless the work is explicitly about Conductor itself.
- Prefer the installed Conductor surfaces and the repo's local `/conductor/` state over ad hoc automation.

## Closure Mode

- Build until the slice is working, tested, and committed.
- Do not stop for plans, options, status narration, or partial TODO cleanup.
- Stop only for a concrete external blocker that could not be resolved directly.
- Incomplete tracks or incomplete projects are not blockers; continue until a concrete slice is closed or a real external blocker is proven.
- Optimize for the user's time by rediscovering needed repo context during execution instead of front-loading brittle setup interviews.

## Worker Protocol

- Workers are proposal engines, not truth authorities.
- Max 2 concurrent workers.
- Each worker declares an exact bounded corpus.
- Each worker stops after one slice or the first concrete blocker.
- Workers do not update `plan.md`, `tracks.md`, TODOs, or status summaries.

Required rendezvous payload:

- changed files
- verification command(s)
- actual result: passed | failed | blocked
- remaining blocker

## Runtime Contract

- Conductor does not choose models or runtimes.
- `implement` starts the implementation agent flow; it does not hardcode a vendor command.
- The host surface discovers the available agent/runtime surface locally, confirms the selected adapter, and then launches the flow.
- Humans or surrounding runtime surfaces choose models and adapters outside Conductor doctrine.
- Workers consume the supplied runtime only.
- Missing or broken runtime is a blocker, not a reason to improvise.

## Ownership Rules

- One canonical home per concept.
- Wrappers expose behavior but do not own semantics.
- Migration shells preserve parity but should not accumulate new semantics.
- If ownership is unclear, name the owner before expanding duplicate surfaces.

## TODO Truth

- `implement` may move code.
- `review` has the final word on checked TODOs and early-stop damage.
- Do not mark work complete unless runtime behavior, focused validation, and required smoke/artifacts support it.
- Reopen overstated TODOs instead of narrating around them.
- Incomplete track/project state never justifies stopping early on its own.

## Scope Discipline

- Work one repo at a time unless cross-repo work is actually required.
- Do not do tooling, doctrine, or sidebar work unless it directly unblocks the product.
- Prefer bounded, concrete slices over broad discovery.
- If a tool surface nudges you toward writing helper scripts, treat that as drift unless the task explicitly asks for Conductor maintenance.
