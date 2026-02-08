# Conductor for Codex CLI/Desktop

Conductor brings Context-Driven Development to Codex. It manages the flow **Context -> Spec & Plan -> Implement** with strict protocols and artifacts stored in your repo.

## Prerequisites
- Codex CLI/Desktop with skills enabled: `codex --enable skills`
- Git available in PATH

## Install
### Option A: Installer (recommended)
```bash
git clone https://github.com/gemini-cli-extensions/conductor.git
cd conductor
./skill/scripts/install.sh  # choose Codex when prompted
```

### Option B: Release zip
1) Download `conductor-codex-skill.zip` from the latest GitHub release.
2) Unzip into `~/.codex/skills/` so that SKILL.md sits at `~/.codex/skills/conductor/SKILL.md`.
3) Restart Codex CLI or Desktop.

## Use
Just ask Codex in natural language:
- "Set up conductor" (initializes product/tech/workflow context)
- "Create a new feature" (generates spec + plan in `conductor/tracks/<id>/`)
- "Implement the track" (executes plan with TDD workflow)
- "Check conductor status" (reads `conductor/tracks.md`)

## Paths Conductor uses
- Skill location: `~/.codex/skills/conductor/`
- Templates (copied into projects): `~/.codex/skills/conductor/templates/`
- Project artifacts (per repo): `conductor/` directory inside your project

## Notes
- Conductor respects `.claudeignore`, `.geminiignore`, `.codexignore`, then `.gitignore` (in that priority) when scanning.
- Backward compatible: installers and prompts still work for Claude/OpenCode/Gemini.
