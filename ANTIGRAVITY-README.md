# Conductor for Google Antigravity

**Measure twice, code once.**

Conductor is a skill for Google Antigravity that enables **Context-Driven Development**. It transforms Antigravity's AI agents into proactive project managers that follow a strict protocol to specify, plan, and implement software features and bug fixes.

Instead of just writing code, Conductor ensures a consistent, high-quality lifecycle for every task: **Context -> Spec & Plan -> Implement**.

## Installation

```bash
# Clone the repository
git clone https://github.com/gemini-cli-extensions/conductor.git
cd conductor

# Run the install script and select option 4 (Google Antigravity)
./skill/scripts/install.sh
```

The installer creates symlinks at `~/.gemini/antigravity/skills/conductor/`, so running `git pull` in this repository automatically updates the skill.

**After installation, restart Antigravity.**

## How It Works

Conductor introduces a structured workflow:

1. **Setup** (once per project): Define your product vision, tech stack, workflow, and style guides
2. **Create tracks**: For each feature or bug, generate a detailed spec and phased plan
3. **Implement**: The agent works through tasks systematically, following your workflow rules
4. **Track progress**: Monitor completion and revert when needed

All context is stored in the `conductor/` directory alongside your code.

## Usage

Simply ask the Antigravity agent to perform tasks using natural language. The agent will automatically invoke the Conductor protocols.

### First Time: Set Up Your Project

Ask the agent:

- "Set up conductor"
- "Initialize conductor for this project"

You'll interactively define:

- **Product context**: Users, goals, high-level features
- **Product guidelines**: Prose style, brand messaging, visual identity
- **Tech stack**: Languages, frameworks, databases
- **Workflow**: TDD requirements, commit strategy, coverage targets
- **Code style guides**: Language-specific conventions

### Create a Feature or Bug Fix

Ask the agent:

- "Create a new feature for user authentication"
- "Start a new track for the shopping cart"
- "Plan a bug fix for the payment flow"

The agent will:

1. Generate a detailed spec (`spec.md`) based on your product context
2. Create a phased implementation plan (`plan.md`) following your workflow
3. Present both for your review and approval

### Implement the Track

Ask the agent:

- "Implement the track"
- "Start implementing"
- "Continue with the next task"

The agent will:

1. Select the next pending task from the plan
2. Follow your defined workflow (e.g., write tests first if TDD is enabled)
3. Update task status as it progresses
4. Guide you through manual verification at the end of each phase
5. Commit changes after each task (or phase, based on your preferences)

### Check Status

Ask the agent:

- "Check project status"
- "Show conductor progress"
- "What's the current track status?"

### Revert Changes

Ask the agent:

- "Revert the last track"
- "Undo the authentication feature"
- "Roll back to before the last phase"

## Antigravity-Specific Features

Antigravity's agent produces **artifacts** (task lists, implementation plans, screenshots, browser recordings) that integrate naturally with Conductor's workflow:

- **Task artifacts** map to Conductor's `plan.md` tasks
- **Implementation plans** align with Conductor's `spec.md`
- **Browser recordings** can verify phase completion

## Task Status Markers

- `[ ]` - Pending
- `[~]` - In Progress
- `[x]` - Completed

## Key Workflow Principles

1. **The Plan is Source of Truth**: All work tracked in `plan.md`
2. **Test-Driven Development**: Write tests before implementing
3. **High Code Coverage**: Target >80% coverage
4. **Commit After Each Task**: With git notes for traceability
5. **Phase Checkpoints**: Manual verification at phase completion

## Resources

- [GitHub Repository](https://github.com/gemini-cli-extensions/conductor)
- [Report Issues](https://github.com/gemini-cli-extensions/conductor/issues)
- [General README](README.md) - Multi-platform documentation

## License

Apache License 2.0 - See [LICENSE](LICENSE)
