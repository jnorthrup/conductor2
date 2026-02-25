<!-- tokens: T002 -->

## Problem
The installer was copying unnecessary repo metadata (README, CHANGELOG, LICENSE, etc.) and missing platform-specific files (gemini-extension.json for Gemini CLI).

## Solution
Streamlined installer to copy only:
- Context file (SKILL.md or GEMINI.md)
- Platform manifest (gemini-extension.json for Gemini only)
- Symlinks to commands/ and templates/

## Files Changed
- `skill/scripts/install.sh` - Simplified to ~50 lines

## Remaining
- [ ] Test on clean environment
- [ ] Update README with install instructions
