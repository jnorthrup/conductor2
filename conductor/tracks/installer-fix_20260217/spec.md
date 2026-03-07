<!-- tokens: T002 -->

## Problem
The installer was copying unnecessary repo metadata (README, CHANGELOG, LICENSE, etc.) and missing platform-specific files (gemini-extension.json for Gemini CLI).

## Solution
Streamlined the install surface to:
- Keep `install.sh` as the canonical installer
- Make compatibility entrypoints delegate to the root installer
- Copy only the LLM-facing files needed per surface
- Expose the locally resolved runtime surface through `skill/scripts/run-conductor.sh`

## Files Changed
- `install.sh`
- `install_en.sh`
- `skill/scripts/install.sh`
- `skill/scripts/run-conductor.sh`
- `README.md`
- `tests/*.sh`

## Remaining
- [x] Test on clean environment
- [x] Update README with install instructions
