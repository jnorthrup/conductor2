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
