# Embedded/Host-Code Doctrine Fixes

Two corrections to Conductor doctrine, both found by evaluating the Android
support added in
`docs/superpowers/specs/2026-10-06-android-style-guides-design.md` against a
real-world plugin SDK — a framework where third-party code is compiled into a
host application's process rather than shipped as a standalone app.

Neither change is specific to that SDK, or to Android. The evaluation was the
discovery vector; the defects affect any codebase whose code runs inside a
host process it does not own.

## Motivation

The Android support branch assumed the common case: an application that owns
its own `Activity`, navigation, and process. Evaluating a plugin SDK surfaced
two places where that assumption leaked into doctrine as a stated requirement.

### Evidence

The SDK evaluated ships 29 sample plugins. Measured across all of them:

| Construct | Occurrences |
| --- | --- |
| `ViewModel` | 0 |
| `Activity` subclasses | 5 (permission and camera shims, not screens) |
| Host-provided UI-container subclasses | 18 |
| Host-provided component-registration references | 17 |

A plugin in this model has no `Activity` of its own. It is a class loaded into
the host application's process that registers a toolbar entry and hands a
`View` to the host's own pane system. The host owns the `Activity`, the
configuration change, and the process lifetime.

On testability, the same sample set contains exactly one non-trivial unit
test. It requires seven static-mock scopes to stand up — covering the host's
logging, preferences, filesystem, geospatial-math, and map-view entry points —
and its single assertion checks a value the test itself stubbed. It asserts
its own mock. Every other sample's unit-test source set contains only
`assertEquals(4, 2 + 2)`.

That is a property of the API shape, not sample laziness. The host's primary
entry point is a static accessor returning a `View` subclass, and the
surrounding API is statics-on-platform-types throughout. There is no seam to
inject.

## Fix 1 — Scope `android.md` §6 to code that owns its `Activity`

### Problem

`conductor/assets/code_styleguides/android.md` §6 "Architectural Guidance"
states that "state needed after rotation belongs in a `ViewModel`." For a
plugin or embedded library, this is not merely unverifiable — it is incorrect
guidance, because the host owns the `Activity` and the configuration change.

§6 already carries a hedge ("review discussion points rather than mechanical
checks"), so `/conductor/review` raises these as discussion rather than hard
findings. The severity is therefore moderate, not critical. The defect is the
incorrect prescription, not a review-blocking false positive.

### Change

Append three lines to §6's existing preamble paragraph (`android.md:101-102`),
with no intervening blank line:

```
They also assume an application that owns its own `Activity` and navigation.
Code running inside a host application — a plugin, SDK, or embedded library —
follows the host's architecture; these rules apply only to the parts it owns.
```

### Rationale

This scopes the existing rules rather than contradicting them, so the cited
Android architecture guide remains accurate for the case it actually
describes. `plugin`, `SDK`, and `embedded library` are generic; the text names
no vendor, product, or host framework, and pins no versions.

### Budget

`android.md` is 126 lines against a 130-line ceiling. An earlier four-line
draft projected to 131 and was tightened to three lines rather than raising
the budget a second time. Projected final: 129 lines, all lines under 85
columns.

## Fix 2 — Add a `host-integration` row to the enforcement table

### Problem

The task-type table in `conductor/assets/workflow-template.md` has no row for
code where a unit test is *writable but worthless*. The only
`No test required` row is styling/layout-only.

Host-glue code therefore classifies as `frontend-ui` component-bound —
"test-after, still required." The sole way to satisfy that for a method whose
entire behavior is calling host statics is a test that mocks the host and then
asserts the mock. The single non-trivial sample test described above is
precisely that artifact, which suggests the pattern is what practitioners
actually produce under this constraint.

The enforcement does not fail open; it fails into writing fake tests. That is
worse, because it produces passing checkmarks carrying zero signal.

### Change

Insert one row after `frontend-ui` — styling/layout only and before
`e2e-flow`:

| Task type | Enforcement | Rationale |
| --- | --- | --- |
| `host-integration` — code whose only behavior is invoking a host framework or platform API, where a unit test could assert nothing but mocks of that host | **No unit test required for the glue itself. Any logic beyond wiring must be extracted into a unit testable in-process, and that unit is strict test-first** | A test that stubs the host and then asserts the stub verifies nothing. Extracting the logic yields a real contract to test instead of a tautology |

### Rationale

The row is written so that invoking it *obligates* work rather than excusing
it. The exemption covers only "the glue," and the same row requires any
non-trivial logic to be extracted into a testable unit held to strict
test-first. This encodes the humble-object pattern, so an agent cannot use the
row to skip testing logic — claiming it requires producing a testable unit.

Placement is with the other rows whose enforcement is weaker than default,
adjacent to `e2e-flow`, rather than beside `backend-logic` where it would read
as a backend carve-out.

### Interaction with `## Coverage expectations`

That section enumerates `backend-logic` and `api-client` by name.
`host-integration` is not named, so no exception clause is required there.
Logic extracted per this row typically classifies as `backend-logic` and picks
up that section's requirement naturally.

### Generality

The pattern this addresses is not Android-specific. It recurs in game-engine
component scripts, modding frameworks for desktop applications, IDE plugin
platforms, office-suite add-ins, and design-tool plugins — any situation where
the code under test is a guest in another process, reachable only through that
host's statics.

## Scope

### In scope

- `conductor/assets/code_styleguides/android.md` — §6 preamble only
- `conductor/assets/workflow-template.md` — one new enforcement-table row

### Out of scope

- `.opencode/command/setup.md` — no host-plugin or vendor-SDK detection
- `new-track.md`, `implement.md`, `review.md` — unchanged; command logic stays
  platform-neutral
- `install.sh` — must remain byte-unchanged
- Any bundled style guide for a specific host SDK. Deliberately rejected: the
  bundled set is for technologies with published, stable, vendor-maintained
  style guides. The SDK evaluated here ships no style guide — only an
  environment-setup walkthrough covering emulator configuration and device
  commands — distributes its artifacts from a credential-gated repository in
  several audience-specific build flavors, and shows steady API churn across
  consecutive point releases. Bundling that would pin facts that rot on the
  next SDK drop and would ship audience-specific doctrine to every Conductor
  user.

Project-specific conventions for any such SDK belong in that project's own
`conductor/code_styleguides/`, which `setup.md:109` already supports via its
custom-rules hook. That is tracked as separate work and is not part of this
spec.

## Verification

- `android.md` is 129 lines or fewer; no line exceeds 85 columns except table
  rows and reference-link definitions
- `workflow-template.md` enforcement table grows from 9 rows to 10
- Vendor- and platform-neutrality grep returns zero matches across all
  changed files. Use word-boundary matching —
  `grep -rniE '\b(android|gradle|kotlin|compose)\b'` for the template, plus a
  check that no host-SDK product name, class name, or artifact domain appears
  in any changed file. Word boundaries matter: a bare three-letter vendor
  abbreviation can match ordinary English words such as `mistake`, `taken`,
  and `stake`, producing false positives
- The text added to `android.md` names no vendor, product, or host framework
- `install.sh` is byte-identical to its pre-branch state
- `conductor/assets/workflow-template.md` contains no
  `conductor-workflow-version` marker; the marker is generated at install time
  by `install.sh:42`

## A note on attribution

This repository is public. This spec therefore describes the evaluated SDK by
its structural properties rather than by name, and refers to its host API by
role rather than by class name. The reasoning is reproducible without the
attribution: the argument rests on the *shape* of the API — statics on
platform types, no injection seam, host-owned `Activity` — not on which
product has that shape.

The same constraint applies to the implementation. No file changed by this
spec may name a specific host SDK, and that is a verification criterion above
rather than a matter of taste.

## Delivery

Both changes amend PR #17 rather than landing as a follow-up branch.
`android.md` does not yet exist in `main`, so this is "do not ship the
defect," not "patch a defect in `main`." PR #17 already edits the same
enforcement table (Edit H, 7 rows to 9), making this the same surface and
cheaper than a stacked branch that would block on the merge.
