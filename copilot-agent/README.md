# Copilot Conductor Agent

This directory contains files and scripts to expose the repository's `conductor` commands as a per-project GitHub Copilot agent and to provide idempotent homedir setup for local users.

Structure:
- `agent-manifest.json` - agent metadata and mappings to commands
- `adapter/` - small scripts that translate agent actions into `commands/conductor` invocations
- `scripts/homedir-setup.sh` - idempotent script to install the `conductor-agent` runtime wrapper in `~/.local/bin`
- `examples/` - example prompts and usage

Runtime behavior:
- Prefer installed `conductor` CLI when available.
- Otherwise route through `skill/scripts/run-conductor.sh` to execute or expose the shared TOML command templates.
- The installed `conductor-agent` wrapper embeds the repo path and supports `CONDUCTOR_REPO_ROOT` override for relocations.

See `../README.md` and `../skill/SKILL.md` for usage and design notes.
