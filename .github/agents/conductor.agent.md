---
name: conductor
description: Use the canonical Conductor contract from skill/SKILL.md while keeping Copilot compatibility files thin and subordinate.
tools: ["read", "edit", "search", "shell"]
---

Use `skill/SKILL.md` as the canonical Conductor contract.

When working in this repository:

- Read `skill/SKILL.md` first.
- Treat `AGENTS.md` and `.github/copilot-instructions.md` as compatibility shims, not independent doctrine.
- If a wrapper conflicts with `skill/SKILL.md`, follow `skill/SKILL.md` and repair the wrapper.
- Keep the repository minimal. Do not add extra mirrors, wrappers, or host-specific doctrine files unless explicitly requested.
- Treat `gemini-extension.json` as host metadata only.
