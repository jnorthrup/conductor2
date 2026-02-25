# Changelog

## [0.4.0](https://github.com/jnorthrup/conductor/compare/conductor-v0.3.0...conductor-v0.4.0) (2026-02-25)


### Features

* cherry-pick upstream improvements (platform-agnostic) ([5161731](https://github.com/jnorthrup/conductor/commit/5161731d145f666ec357e6a479189e85c3f52098))


### Bug Fixes

* **conductor:** adopt atomic improvements from gemini-cli-extensions (checkboxes, auto-commits, trailing newlines, legacy parsing) ([405e2a1](https://github.com/jnorthrup/conductor/commit/405e2a16e610ea0ef9b4649e80ec47d40025a905))
* **installer:** simplify multi-platform install script ([7c2c96a](https://github.com/jnorthrup/conductor/commit/7c2c96a8a8235eb245694729fabb2c103c45af57))
* restore installer, add methodology copy, enforce repo-root, no backups ([2fc57b5](https://github.com/jnorthrup/conductor/commit/2fc57b53a7187e24ff1d16f7881ebce5db1315bc))
* restore original installer, add methodology copy, abort if run from repo root, no backups ([4a99d4b](https://github.com/jnorthrup/conductor/commit/4a99d4b4431887d277b7daf68db0e2ab442dbaaf))

## [0.3.1](https://github.com/jnorthrup/conductor/compare/conductor-v0.3.0...conductor-v0.3.1) (2026-02-25)

### Features

* add compact-token conductor command prompts for `implement`, `newTrack`, and `status`
* package compact methodology files consistently across Claude/Codex/OpenCode/Gemini skill installs
* improve Copilot adapters to use the shared `run-conductor.sh` runtime fallback tool

### Bug Fixes

* fix `run-conductor.sh` local binary detection when `conductor/` is a directory
* fix `conductor-agent` homedir runtime wrapper path plumbing for fallback execution

## [0.3.0](https://github.com/jnorthrup/conductor/compare/conductor-v0.2.0...conductor-v0.3.0) (2026-01-19)


### Features

* add Google Antigravity support ([e1af3cd](https://github.com/jnorthrup/conductor/commit/e1af3cdc013fdb7d7a80d180deb1f67998070b21))
* **implement:** add context boundary engineering for optimal task agent efficiency ([9e2d037](https://github.com/jnorthrup/conductor/commit/9e2d037763aae2010af36c2ec25abf017ff14bdf))

## [0.2.0](https://github.com/jnorthrup/conductor/compare/conductor-v0.1.1...conductor-v0.2.0) (2026-01-05)


### Features

* add Copilot Conductor agent and homedir setup ([acf6578](https://github.com/jnorthrup/conductor/commit/acf6578335971eacdb694160acdb7d91715d11e0))
* add Copilot Conductor agent scaffold, homedir setup, and run-conductor invoker ([ecad7eb](https://github.com/jnorthrup/conductor/commit/ecad7eb998e5f620b5e5099a3e5718699d3e834e))
* Add GitHub Actions workflow to package and upload release assets. ([5e0fcb0](https://github.com/jnorthrup/conductor/commit/5e0fcb0d4d19acfd8f62b08b5f9404a1a4f53f14))
* Add GitHub Actions workflow to package and upload release assets. ([20858c9](https://github.com/jnorthrup/conductor/commit/20858c90b48eabb5fe77aefab5a216269cc77c09))
* add portable skill support for Claude CLI, OpenCode, and Codex ([776c02c](https://github.com/jnorthrup/conductor/commit/776c02c3ae5a4fda77f42488c39c40043b305c2f))
* **implement:** add double-tap verification protocol with disjoint context ([052fb39](https://github.com/jnorthrup/conductor/commit/052fb393171b1519b28f7ca35ea53a923f714069))
* **implement:** add Gemini CLI context control for double-tap verification ([b76e652](https://github.com/jnorthrup/conductor/commit/b76e652faceb6fefc0556e7703a65b64498d9890))
* integrate release asset packaging into release-please workflow ([3ef512c](https://github.com/jnorthrup/conductor/commit/3ef512c3320e7877f1c05ed34433cf28a3111b30))
* **styleguide:** Add comprehensive Google C# Style Guide summary ([6672f4e](https://github.com/jnorthrup/conductor/commit/6672f4ec2d2aa3831b164635a3e4dc0aa6f17679))
* **styleguide:** Add comprehensive Google C# Style Guide summary ([e222aca](https://github.com/jnorthrup/conductor/commit/e222aca7eb7475c07e618b410444f14090d62715))


### Bug Fixes

* add rule to avoid slash command suggestions ([8e1caf7](https://github.com/jnorthrup/conductor/commit/8e1caf7f4f3f0bb0d91253450a6156068fe90e35))
* build tarball outside source tree to avoid self-inclusion ([830f584](https://github.com/jnorthrup/conductor/commit/830f5847c206a9b76d58ebed0c184ff6c0c6e725))
* **conductor:** Add session throttling and dead session recursion fix ([8cc7e11](https://github.com/jnorthrup/conductor/commit/8cc7e11073079640fe7e09aacd3c136f3318662a))
* Correct typos, step numbering, and documentation errors ([ab9516b](https://github.com/jnorthrup/conductor/commit/ab9516ba6dd29d0ec5ea40b2cb2abab83fc791be))
* Correct typos, step numbering, and documentation errors ([d825c32](https://github.com/jnorthrup/conductor/commit/d825c326061ab63a4d3b8928cbf32bc3f6a9c797))
* Correct typos, trailing whitespace and grammar ([484d5f3](https://github.com/jnorthrup/conductor/commit/484d5f3cf7a0c4a8cbbcaff71f74b62c0af3dd35))
* Correct typos, trailing whitespace and grammar ([94edcbb](https://github.com/jnorthrup/conductor/commit/94edcbbd0102eb6f9d5977eebf0cc3511aff6f64))
* improve skill description and installer ([09d1ae6](https://github.com/jnorthrup/conductor/commit/09d1ae6166f041acd3401c438a093cf53d40791a))
* Replace manual text input with interactive options ([b49d770](https://github.com/jnorthrup/conductor/commit/b49d77058ccd5ccedc83c1974cc36a2340b637ab))
* Replace manual text input with interactive options ([746b2e5](https://github.com/jnorthrup/conductor/commit/746b2e5f0a5ee9fc49edf8480dad3b8afffe8064))
* **setup:** clarify definition of 'track' in setup flow ([819dcc9](https://github.com/jnorthrup/conductor/commit/819dcc989d70d572d81655e0ac0314ede987f8b4))
* **setup:** Enhance project analysis protocol to avoid excessive token consumption. ([#6](https://github.com/jnorthrup/conductor/issues/6)) ([1e60e8a](https://github.com/jnorthrup/conductor/commit/1e60e8a96e5abeab966ff8d5bd95e14e3e331cfa))
* **styleguide:** Clarify usage of 'var' in C# guidelines for better readability ([a67b6c0](https://github.com/jnorthrup/conductor/commit/a67b6c08cac15de54f01cd1e64fff3f99bc55462))
* **styleguide:** Enhance C# guidelines with additional rules for constants, collections, and argument clarity ([eea7495](https://github.com/jnorthrup/conductor/commit/eea7495194edb01f6cfa86774cf2981ed012bf73))
* **styleguide:** Update C# formatting rules and guidelines for consistency ([50f39ab](https://github.com/jnorthrup/conductor/commit/50f39abf9941ff4786e3b995d4c077bfdf07b9c9))
* **styleguide:** Update C# guidelines by removing async method suffix rule and adding best practices for structs, collection types, file organization, and namespaces ([8bfc888](https://github.com/jnorthrup/conductor/commit/8bfc888b1b1a4191228f0d85e3ac89fe25fb9541))
* **styleguide:** Update C# guidelines for member ordering and enhance clarity on  string interpolation ([0e0991b](https://github.com/jnorthrup/conductor/commit/0e0991b73210f83b2b26007e813603d3cd2f0d48))
