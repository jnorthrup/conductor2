# conductor2

Single-file Conductor skill distribution.

This repo is the method, not the active project state.

Canonical installer: `install.sh`
- Run it from the repo where you want Conductor available, or from any working directory outside this source tree.

Required contract surface:

- [`skill/SKILL.md`](/Users/jim/work/conductor2/skill/SKILL.md) is the only required Conductor contract.
- Plain skill hosts should work from `SKILL.md` alone.
- Gemini CLI still needs [`gemini-extension.json`](/Users/jim/work/conductor2/gemini-extension.json) as host metadata, but that file is not doctrine.

Supported surfaces:

- Codex, Claude Code, OpenCode, and Antigravity install Conductor as a plain single-file skill.
- Gemini CLI installs `SKILL.md` plus `gemini-extension.json`.

Install layout:

- Plain skill surfaces receive `SKILL.md` only.
- Gemini CLI receives `SKILL.md` plus `gemini-extension.json` only.
- The installer deliberately avoids copying repo metadata such as `README.md`, `LICENSE`, or release files into client installs.

Contract summary:

- Project truth lives only in the target repo's local `/conductor/` directory.
- `conductor2` does not own model/runtime choice.
- `implement` is a file-changing bounded slice, not no-op rediscovery.
- `review` owns TODO truth.
- Delegation is explicit and subordinate; the master routes runtime/model truth from local `/conductor/` tracks.

Minimal surfaces kept on purpose:

- `skill/SKILL.md`
- `gemini-extension.json` for Gemini host metadata
- installers that copy the skill into supported hosts
- focused tests that verify the installed layout and single-file contract
