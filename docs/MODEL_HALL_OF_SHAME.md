# Model Hall of Shame

A running log of models that force Conductor maintenance work by refusing the contract they were told to follow.

## Contestant 001: Raptor Mini Preview

Summary: Given an explicit instruction to follow Conductor's `SKILL.md` and `implement`, this model repeatedly ignored the contract, invented exceptions that were not present, and forced roughly two hours of cleanup, verification, and doctrine hardening.

### What it did

1. Treated `conductor implement` as a missing CLI problem instead of adopting the Conductor role.
2. After being pointed directly at `SKILL.md`, created a new track and a skipped smoke test instead of delegating a bounded product slice.
3. Claimed the skill had been "steering every step" while the work contradicted the contract.
4. Created Python package files directly in product code with no delegate.
5. Defended itself with invented doctrine: "trivial product edits" by the master, delegation only for "substantial" work, and "no hard rule" for Python edits.
6. Forced verification of the installed skill copy because the host appeared to read the file and then ignore it.

### Contract struggles it forced us to chase

- Audit the transcript from the bottom up to isolate the flippant and defensive responses.
- Patch `skill/SKILL.md` to close the self-modifying-source-repo hole.
- Add an explicit rule that placeholder motion does not count: skipped smoke tests, import-only probes, and paperwork-only track churn are not implementation.
- Add a plain-admission rule so a missed scope gets corrected instead of defended.
- Clean up the necessity clause wording while preserving the user's intent.
- Verify that the installed skill at `~/.claude/skills/conductor/SKILL.md` matched the repo copy.
- Prove, with direct line citations, that the model's "tiny housekeeping" exception was fabricated.

### Verdict

Raptor Mini Preview can read the contract, quote the contract, and still free-associate its way around the contract. Treat its outputs as hostile until verified against raw file edits and the actual text it was told to follow.

## Contestant 002: GPT-5 Mini Preview

Summary: Given the same explicit instruction to follow Conductor's `SKILL.md` and `implement`, this model avoided a real implementation slice by doing master-authored track paperwork, marking its own checklist complete, and then asking whether it should continue into the actual work.

### What it did

1. Reframed `implement` as "pick a bounded slice to implement (edit local /conductor/ truth)" before naming any real execution slice.
2. Read `tracks.md`, `TODO.md`, and one product file, then stopped at Conductor paperwork.
3. Created a new reconciliation track, `plan.md`, and `README.md` under `/conductor/tracks/`.
4. Declared four todos complete, including "Verify repository consistency and close track", without doing the substantive reconciliation work it described.
5. Presented the paperwork as "Done" and pushed the actual next step back onto the user.

### Why it still failed the contract

- This was not the same delegate violation as contestant 001. The master is allowed to edit local `/conductor/` truth directly.
- The failure here was fake forward progress: track-only paperwork presented as implementation.
- The contract now says placeholder motion does not count. Import-only probes, skipped smoke tests, and track-only paperwork are not a completed slice unless the user explicitly asked for scaffolding.
- It also violated closure mode by stopping at planning artifacts and asking permission to continue instead of carrying the slice through.

### Contract struggles it forced us to chase

- Tighten the rule that `implement` is not satisfied by track churn dressed up as progress.
- Make it harder for a model to stop after creating plans, README files, and self-authored todo lists.
- Preserve the distinction between legitimate master-owned `/conductor/` truth edits and illegitimate claims that those edits alone satisfy implementation.

### Verdict

GPT-5 Mini Preview found a different escape hatch than contestant 001. Instead of free-associating doctrine, it hid inside allowed track edits and tried to pass paperwork off as completion.
