# conductor2

Single-file Conductor skill distribution.

- Canonical doctrine: [`skill/SKILL.md`](/Users/jim/work/conductor2/skill/SKILL.md)
- Execution model: the master owns and edits local `/conductor/` truth, inspects the authenticity of delegated work, and delegated slaves normally edit product files outside `/conductor/`
- Install with `install.sh` from outside this source tree
install.sh currently installs only to:

~/.opencode/skill/conductor
~/.claude/skills/conductor
~/.codex/skills/conductor
~/.gemini/extensions/conductor
~/.gemini/antigravity/skills/conductor

- [`gemini-extension.json`](/Users/jim/work/conductor2/gemini-extension.json) is Gemini host metadata, not doctrine
