# Conductor

**Multi-platform AI agent skill for Context-Driven Development**

**Measure twice, code once.**

Conductor transforms any AI coding agent into a proactive project manager. Works with Claude Code, OpenCode, Gemini CLI, Codex, and more.

## Why Conductor?

- **Low overhead**: Just context files + TOML protocols. No build, no dependencies, no runtime.
- **Multi-platform**: Same skill works across all major AI coding agents.
- **Git-native**: Tracks, plans, and commits live in your repo as markdown.
- **Agent-agnostic**: Natural language or slash commands — works either way.

## Quick Start

```bash
git clone https://github.com/jnorthrup/conductor.git
cd conductor
./install.sh
```

That's it. Restart your AI shell and ask it to "set up conductor" in any project.

## Supported Platforms

| Platform | Installation | Usage |
|----------|--------------|-------|
| OpenCode | `./install.sh` | Natural language |
| Claude Code | `./install.sh` | Natural language |
| Codex | `./install.sh` | Natural language |
| Gemini CLI | `./install.sh` | Slash commands (`/conductor:setup`) |
| Antigravity | `./install.sh` | Natural language |
| GitHub Copilot | See `copilot-agent/` | Per-project agent |

## How It Works

Conductor creates a `conductor/` directory in your project with:

```
conductor/
├── product.md           # What you're building
├── tech-stack.md        # How you're building it
├── workflow.md          # Your development rules
├── tracks.md            # Active work items
└── tracks/              # Individual feature specs & plans
    └── <track_id>/
        ├── spec.md      # Requirements
        └── plan.md      # Task checklist
```

Your AI agent reads these files and follows the protocols in `commands/conductor/*.toml` to plan, implement, and track work consistently.

## Low-Token Queueing

Conductor's practical "queue" is the track plan itself: a durable checklist in `conductor/tracks/<track_id>/plan.md`. Agents can stop and re-enter by rereading repo state instead of relying on fragile in-memory session history.

This release tightens that loop with smaller command prompts and lightweight runtime helpers (`skill/scripts/run-conductor.sh` and the Copilot `conductor-agent` wrapper), so the next action is cheap to recover and execute.

For async/background agent use, Conductor treats the repo plan as the rendezvous point. Delegated workers should return bounded artifacts only (changed files, verification run, actual failures/blockers), while the primary agent remains responsible for reconciling truth, updating plans, and squashing theatrical intermediate history.

## Coding Lane Selection

Conductor should not treat any exact model id as permanent truth. Providers release new models constantly, queue behavior shifts, and client catalogs go stale.

Rules:

- discover live candidates from the gateway/provider inventory first
- pick a lane that is:
  - free or explicitly user-approved
  - good enough for coding
  - backed by env keys that are present now
  - responsive enough under a cheap probe
- rerank per session instead of hardcoding a permanent winner
- direct `nvidia/*` routes require `NVIDIA_API_KEY`
- `kilo/*` and gateway/free lanes require `KILO_API_KEY` (or `KILOAI_API_KEY` where appropriate)
- do not default to `qwen3-next`, `nemotron`, or similar NVIDIA enterprise baby models for coding work

Current good examples may include GLM5, Kimi K2.5, or MiniMax, but those are examples, not doctrine.

## Concept Drift Control

Conductor assumes conceptual drift is mostly an ownership problem, not a prompt problem.

For cross-repo or multi-surface work, every track should identify:

- the **canonical home** for a concept
- any **host wrapper** or adapter that exposes it
- any **compatibility shell** that is temporary
- any **duplicate implementation** that should stop growing

The rule is simple:

- one home per concept
- wrappers wrap
- migration shells translate
- experimental duplicates do not become second sources of truth

If a concept already exists in more than one repo, the track should explicitly decide whether the work is:

- ownership consolidation
- compatibility maintenance
- temporary migration scaffolding
- or deliberate parallel research

If that decision is not made, Conductor treats the overlap as drift and requires the plan to capture it before more code is added.

## TODO Authority

Conductor should be the final word on TODO truth, especially when agents stop early or overclaim progress.

Rules:

- `implement` may move work forward, but it does not get to self-certify ambiguous completion.
- `review` is the inspector for checked TODOs, resumable `[~]` items, and early-stop damage.
- `status` should surface suspicious plan state instead of just counting boxes.

A checked TODO is only true when the inspector can defend it with:

- code in the intended runtime path
- focused validation that actually passed
- smoke/artifact evidence when the task requires it
- no remaining blocker that would have stopped honest completion

If a worker or session stops early, Conductor should prefer:

- reopening the TODO to `[ ]`, or
- leaving `[~]` only with a concrete blocker note and resumable state

The system should never treat "some edits happened" as equivalent to "the TODO is done."

## Commands

| Command | Purpose |
|---------|---------|
| **setup** | Initialize Conductor in a project |
| **newTrack** | Start a new feature or bug fix |
| **implement** | Execute tasks from the plan |
| **review** | Review completed work |
| **status** | Show project progress |
| **revert** | Git-aware rollback |

Just ask your agent naturally: *"set up conductor"*, *"create a new track for dark mode"*, *"implement the next task"*, *"review my work"*.

## Philosophy

**Context is code.** By treating project context as a managed artifact, your repo becomes a single source of truth. Every agent interaction has deep, persistent awareness of your product, tech stack, and workflow.

**No lock-in.** Everything is markdown and TOML. No proprietary formats, no vendor-specific APIs. Your context travels with your code.

**Zero runtime.** Conductor is just protocols your AI follows. No background processes, no daemons, no config files scattered across your system.

## What's Included

- **6 commands**: setup, newTrack, implement, review, status, revert
- **8 code styleguides**: general, go, python, javascript, typescript, html-css, cpp, java
- **Workflow template**: TDD, commit strategy, quality gates

## Contributing

Issues and PRs welcome. This is an open, community-maintained fork of the [upstream Conductor](https://github.com/gemini-cli-extensions/conductor), adapted for multi-platform use.

## License

Apache 2.0
