# Conductor for Claude Code

**Measure twice, code once.**

Conductor is a skill for Claude Code that enables **Context-Driven Development**. It transforms Claude into a proactive project manager that follows a strict protocol to specify, plan, and implement software features and bug fixes.

Instead of just writing code, Conductor ensures a consistent, high-quality lifecycle for every task: **Context -> Spec & Plan -> Implement**.

## Philosophy

Control your code. By treating context as a managed artifact alongside your code, you transform your repository into a single source of truth that drives every AI interaction with deep, persistent project awareness.

## Features

- **Plan before you build**: Create specs and plans that guide Claude for new and existing codebases
- **Maintain context**: Ensure Claude follows your style guides, tech stack choices, and product goals
- **Iterate safely**: Review plans before code is written, keeping you firmly in control
- **Team collaboration**: Set project-level context that becomes a shared foundation for your entire team
- **Intelligent initialization**: Works with both new (Greenfield) and existing (Brownfield) projects
- **Smart revert**: Git-aware rollback that understands logical units of work (tracks, phases, tasks)

## Installation

```bash
# Clone the repository
git clone https://github.com/jnorthrup/gemini-cli-extensions/conductor.git
cd conductor

# Run the install script and select option 2 (Claude CLI global)
./skill/scripts/install.sh
```

The installer will create symlinks at `~/.claude/skills/conductor/`, so running `git pull` in this repository will automatically update the skill.

**After installation, restart Claude Code.**

## How It Works

Conductor introduces a structured workflow:

1. **Setup** (once per project): Define your product vision, tech stack, workflow, and style guides
2. **Create tracks**: For each feature or bug, generate a detailed spec and phased plan
3. **Implement**: Claude works through tasks systematically, following your workflow rules
4. **Track progress**: Monitor completion and revert when needed

All context is stored in the `conductor/` directory alongside your code.

## Usage

Simply ask Claude to perform tasks using natural language. Claude will automatically invoke the Conductor protocols.

### First Time: Set Up Your Project

Ask Claude:

- "Set up conductor"
- "Initialize conductor for this project"

You'll interactively define:

- **Product context**: Users, goals, high-level features
- **Product guidelines**: Prose style, brand messaging, visual identity
- **Tech stack**: Languages, frameworks, databases
- **Workflow**: TDD requirements, commit strategy, coverage targets
- **Code style guides**: Language-specific conventions

**Generated files:**

```
conductor/
├── product.md
├── product-guidelines.md
├── tech-stack.md
├── workflow.md
├── code_styleguides/
│   ├── general.md
│   ├── python.md
│   └── ...
└── tracks.md
```

### Create a Feature or Bug Fix

Ask Claude:

- "Create a new feature for user authentication"
- "Start a new track for the shopping cart"
- "Plan a bug fix for the payment flow"

Claude will:

1. Generate a detailed spec (`spec.md`) based on your product context
2. Create a phased implementation plan (`plan.md`) following your workflow
3. Present both for your review and approval

**Generated files:**

```
conductor/tracks/<track_id>/
├── metadata.json
├── spec.md
└── plan.md
```

### Implement the Track

Ask Claude:

- "Implement the track"
- "Start implementing"
- "Continue with the next task"

Claude will:

1. Select the next pending task from the plan
2. Follow your defined workflow (e.g., write tests first if TDD is enabled)
3. Update task status as it progresses
4. Guide you through manual verification at the end of each phase
5. Commit changes after each task (or phase, based on your preferences)

### Check Status

Ask Claude:

- "Check project status"
- "Show conductor progress"
- "What's the current track status?"

Claude will display:

- Current phase and task
- Overall progress (completed/total tasks)
- Next action needed
- Any blockers

### Revert Changes

Ask Claude:

- "Revert the last track"
- "Undo the authentication feature"
- "Roll back to before the last phase"

Claude will analyze git history and revert the logical unit of work (track, phase, or task).

## Directory Structure

After initialization:

```
your-project/
├── conductor/
│   ├── product.md              # Product vision and goals
│   ├── product-guidelines.md   # UX/brand guidelines
│   ├── tech-stack.md           # Technology choices
│   ├── workflow.md             # Development workflow rules
│   ├── tracks.md               # Master list of all tracks
│   ├── code_styleguides/       # Language-specific style guides
│   ├── tracks/                 # Active tracks
│   │   └── <track_id>/
│   │       ├── metadata.json
│   │       ├── spec.md
│   │       └── plan.md
│   └── archive/                # Completed tracks
├── src/                        # Your application code
└── ...
```

## Task Status Markers

Conductor uses standard markdown checkboxes:

- `[ ]` - Pending
- `[~]` - In Progress
- `[x]` - Completed

## Key Workflow Principles

1. **The Plan is Source of Truth**: All work tracked in `plan.md`
2. **Test-Driven Development**: Write tests before implementing (configurable)
3. **High Code Coverage**: Target >80% coverage (configurable)
4. **Commit After Each Task**: Automatic commits with git notes for traceability
5. **Phase Checkpoints**: Manual verification at phase completion

## Token Consumption

Conductor's context-driven approach involves reading and analyzing your project's context, specifications, and plans. This can lead to increased token consumption, especially in larger projects or during extensive planning phases.

Use `.claudeignore` to exclude unnecessary files from analysis (similar to `.gitignore`).

## Best Practices

1. **Keep context files updated**: Treat `conductor/` files as living documentation
2. **Review plans before approval**: You control what gets implemented
3. **Use meaningful track descriptions**: They become directory names and commit messages
4. **Leverage style guides**: Add language-specific conventions to ensure consistency
5. **Customize your workflow**: Adjust TDD requirements and commit strategies to match your team

## Examples

### Example 1: New Project

```
You: "Set up conductor"
Claude: [Walks through interactive setup]

You: "Create a feature for user registration with email verification"
Claude: [Generates spec and plan, presents for approval]

You: "Implement the track"
Claude: [Works through tasks following TDD, commits after each task]
```

### Example 2: Existing Project

```
You: "Set up conductor"
Claude: [Detects existing project, analyzes codebase, infers tech stack]

You: "Create a track to add OAuth authentication"
Claude: [Generates spec based on existing architecture]

You: "Implement the track"
Claude: [Integrates with existing code following project patterns]
```

## Troubleshooting

**Conductor doesn't activate:**

- Ensure you restarted Claude Code after installation
- Check that `~/.claude/skills/conductor/SKILL.md` exists

**Templates not found:**

- Verify symlinks: `ls -la ~/.claude/skills/conductor/`
- Reinstall: `./skill/scripts/install.sh`

**Want to update:**

```bash
cd /path/to/conductor/repo
git pull
# No need to reinstall - symlinks automatically reflect updates
```

## Resources

- [GitHub Repository](https://github.com/jnorthrup/conductor)
- [Report Issues](https://github.com/jnorthrup/conductor/issues)
- [General README](README.md) - Multi-platform documentation

## License

Apache License 2.0 - See [LICENSE](LICENSE)
