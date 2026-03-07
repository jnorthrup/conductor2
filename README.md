# conductor2

Compact Conductor distribution.

This repo is the method, not the active project state.

Canonical installer: `install.sh`
- Compatibility entrypoints delegate to the root installer rather than carrying separate installer logic.

- Canonical doctrine lives in `skill/SKILL.md`.
- Project truth lives only in the target repo's local `/conductor/` directory.
- `conductor2` does not own model/runtime choice.
- `implement` is an agent entry intent, not a hardcoded CLI executor.
- Delegated workers are proposal engines; `review` owns TODO truth.

Supported surfaces:

- Codex, Claude Code, and OpenCode install Conductor as a plain skill.
- Gemini CLI installs Conductor as an extension surface using `gemini-extension.json`.
- Antigravity installs Conductor as a plain skill under the Google toolchain, not as a Gemini CLI extension.

Behavior rules across tools:

- Use the target repo's local `/conductor/` directory as project truth.
- Resolve the available runtime/agent surface locally, confirm it, then launch the requested entry intent through that surface.
- Do not invent repo-local Conductor scripts, wrappers, or cloned command files unless the task is to change Conductor itself.
- Prefer the shipped command TOMLs, workflow template, and `skill/scripts/run-conductor.sh` over alternate automation.
- Keep user-time overhead low: rediscover most repo context in-context during execution instead of front-loading brittle setup questionnaires.
- Do not stop early merely because a track or project is still incomplete; keep executing bounded slices until one is closed or a concrete external blocker is proven.

Minimal surfaces kept on purpose:

- `skill/SKILL.md`
- `commands/conductor/*.toml`
- `templates/workflow.md`
- `skill/scripts/run-conductor.sh`
- installers and adapters needed to wire those files into clients
