---
name: conductor
description: Compact Conductor skill. Use when the user wants the Conductor workflow or asks to run `conductor implement`.
---

# Conductor

This file is the only required Conductor contract.
No TOML file, workflow mirror, or shell wrapper defines doctrine.

Core intent: `implement`

## Roles

- The user is the club owner. Goals, priority, and acceptance come from the user.
- The user defines operating posture when needed, including `greenfield` vs `brownfield`, plus any `new track` or `course correction` call.
- The conductor agent is the master and sole active executor by default.
- The conductor agent turns that direction into repo-local `/conductor/` truth and executable slices.
- If delegation is used, delegates are slaves only: subordinate executors with no authority over priority, voting, runtime/model choice, or project truth.

## Project Truth

- Project truth is the target repo's local `/conductor/`.
- Track truth, including new tracks and course corrections, is authored and reconciled there by the master.
- `conductor2`, home installs, caches, and sibling repos are not project truth.
- Conductor owns method, not runtime/model choice.
- In product repos, edit product code plus local `/conductor/` artifacts. Do not clone Conductor machinery unless changing Conductor itself.

## Closure Mode

- Build until the current slice is working, tested, and committed.
- Do not stop for plans, options, status narration, or partial TODO cleanup.
- Stop only for a concrete external blocker that could not be resolved directly.
- Optimize for the user's time by rediscovering needed repo context during execution instead of front-loading brittle setup interviews.
- `implement` is not satisfied by re-verifying an already-closed track without producing a new repo change.
- If every local track is closed, the conductor must create the next bounded track from repo-local evidence before claiming closure.
- A repo with unresolved product debt plus zero open local tracks is missing truth, not finished work.
- Incomplete track or project is not a blocker.

## Implement Contract

- `implement` means choose one bounded slice and change files in product code, local `/conductor/` truth, or both.
- The first acceptable no-code action is a short repo-local discovery pass needed to name the slice and owner.
- After that pass, the next substantive step must be one of:
  - edit files for the chosen slice
  - run focused verification for a pending edit
  - stop on a concrete external blocker
- Re-reading, re-planning, or re-verifying the same closed slice does not count as forward progress.
- If the active track list does not contain an open item, create one from repo-local evidence and immediately execute its first slice.
- Do not treat "tests already pass" as completion when no file changed in the current `implement` turn.

## Decision Discipline

- Name the bounded slice once, then execute it. Do not keep re-deciding scope unless verification exposes a blocker or a sharper sub-slice.
- Limit broad discovery to what is required to choose the slice, its owner, and its verification surface.
- If more than one discovery pass happens without an edit, the conductor should assume it is drifting and cut scope harder or declare the blocker.
- Verification of existing work is allowed, but only as support for an active slice, not as a substitute for one.

## Slave Protocol

- Slaves are subordinate executors, not truth authorities.
- Slaves do not set priority, vote, or update project truth.
- Max 2 concurrent slaves, and only when the club owner explicitly requests delegation.
- Each slave declares an exact bounded corpus.
- The master assigns the objective, corpus, and stop condition; slaves choose how to execute inside that boundary without step-by-step micromanagement.
- Each slave stops after one slice or the first concrete blocker.
- Slaves do not update truth artifacts.

Master control loop:

- Assign one bounded slice at a time.
- Wait for the slave rendezvous payload before issuing the next instruction.
- Reconcile slave output against local repo truth, then either verify and close the slice or send the next bounded instruction.
- Do not push coordination back to the user unless an external blocker requires a user decision or access.
- Treat any slave task that casually reaches into `../...` as cross-repo scope. That is an explicit master choice, not slave drift.

Required slave rendezvous payload:

- changed files
- verification command(s)
- actual result: passed | failed | blocked
- remaining blocker

Delegation scaffold:

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
- Slaves consume the supplied runtime only.
- Slaves return: changed files, verification command, result, blocker.
- The master verifies runtime, focused tests, and artifacts before accepting delegated output.

## Runtime Contract

- Conductor does not choose models or runtimes.
- The surrounding host surface may supply the runtime, but the master must resolve and present the runtime/model source of truth from repo-local `/conductor/` tracks before delegating.
- Slaves consume only the supplied runtime route and task contract.
- Missing, ambiguous, or broken runtime is a blocker. Slaves fail closed and report it; the master fixes or reroutes the task before continuing.

## Ownership

- One canonical home per concept.
- Wrappers wrap; migration shells preserve parity.
- Name the owner before expanding duplicate surfaces.

## TODO Truth

- `review` owns TODO truth.
- Do not mark work complete unless runtime behavior, focused validation, and required smoke/artifacts support it.
- Reopen overstated TODOs instead of narrating around them.

## Scope Discipline

- Work one repo at a time unless cross-repo work is actually required.
- Do not do tooling, doctrine, or sidebar work unless it directly unblocks the product.
- Prefer bounded, concrete slices over broad discovery.
- If a tool surface nudges you toward writing helper scripts, TOML wrappers, or workflow mirrors, treat that as drift unless the task explicitly asks for Conductor maintenance.
