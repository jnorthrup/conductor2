# Agents quick start

- Trigger Conductor by asking for setup, new track/feature, planning, implementation, status, or revert.
- Supported agents/paths:
  - Codex CLI/Desktop: `~/.codex/skills/conductor/`
  - Claude CLI: `~/.claude/skills/conductor/`
  - OpenCode: `~/.opencode/skill/conductor/`
  - Gemini CLI extension (unchanged)
- Ignores precedence when scanning: `.claudeignore` > `.geminiignore` > `.codexignore` > `.gitignore`.
- Templates are resolved from the first existing path in the list above.

For Codex users, enable skills once with `codex --enable skills`, then use the installer or release zip.
