# AGENTS.md — atom-sn-flutter-shadcn-fork

UScoreNow's private fork of [nank1ro/flutter-shadcn-ui](https://github.com/nank1ro/flutter-shadcn-ui)
(pub package `shadcn_ui`, Flutter port of shadcn/ui). It is the base component layer of the
**AtomSN** design system: `packages/atomsn` in [UScoreNow/atom-sn-flutter](https://github.com/UScoreNow/atom-sn-flutter)
depends on this repo as a git dependency **pinned to an immutable commit SHA**.
(The repo was renamed from `atom-sn-shadcn-fork`; the old URL still appears in atomsn's pubspec and redirects here.)

## Startup workflow (before writing code)

1. Run `./init.sh` — exports Flutter (`/opt/flutter`, off PATH), installs deps, runs analyze + tests. A clean baseline before any change.
2. Read `PROGRESS.md` (current fork state) and `feature_list.json` (work items and their status).
3. Read `CONSTRAINTS.md` — the authoritative, sourced MUST/MUST NOT list.
4. Pick **one** item and work only on it.

## Hard constraints (MUST / MUST NOT)

Authoritative list with sources: `CONSTRAINTS.md`. The ones that most often bite:

1. **MUST NOT** import `material.dart` or `cupertino.dart` inside `lib/` (CI `check-imports.yaml` fails the build; the few sanctioned exceptions are listed in that workflow).
2. New components **MUST** follow the `Shad` prefix + paired theme + export pattern — see `CONTRIBUTING.md` before adding or modifying components.
3. `main` **MUST** stay a mirror of upstream `nank1ro/flutter-shadcn-ui`; UScoreNow-specific patches live on `usn/*` branches (currently `usn/0.54.0-elms-huge`). Do not commit fork-only changes to `main`/`dev` unless they are meant to be upstreamed or are repo meta (docs, CI).
4. **MUST NOT** run `dart pub publish` / `make publish` — this fork is never published to pub.dev; it is consumed via git SHA.
5. After merging changes intended for AtomSN, the consumer pin **MUST** be updated: bump the `ref:` SHA in `atom-sn-flutter/packages/atomsn/pubspec.yaml` (the branch can move, the pinned SHA cannot).
6. Generated files (`*.g.theme.dart`, `lib/src/i18n/*`) **MUST** be regenerated via build_runner/slang, never hand-edited (CI `build-runner.yml` checks for drift).
7. Git flow: working branch → PR to `dev` → PR to `main`. PR titles/descriptions in Spanish; branch names, commits (Conventional Commits) and code comments in English.

## Scope

- **One feature at a time**: exactly one `feature_list.json` item `in_progress`; finish or hand it off before starting another.
- **Stay in scope**: touch only what the active item needs. Upstream code you aren't fixing is out of scope — this repo must stay mergeable from upstream, so gratuitous diffs are debt.
- New work found mid-task becomes a new `feature_list.json` entry, not a detour.

## Definition of done

A feature or fix is done only when **all** of these hold:

- `make check` (analyze + test) passes — same predicate as CI `.github/workflows/flutter-test.yaml`.
- No hand-edits to generated files; build_runner/slang drift is clean.
- Verification evidence (command and output) is recorded in `PROGRESS.md` or `SESSION-HANDOFF.md`.
- The `feature_list.json` entry's `done_when` criteria are met and its `status` updated.
- If the change is meant for AtomSN consumers: it is merged on the `usn/*` branch **and** the atomsn pin bump is done or explicitly tracked as pending.

## What is where

- `lib/src/components/` — one file per widget (`ShadButton`, `ShadDialog`, …).
- `lib/src/theme/` — theme data, per-component themes (`theme/components/`), color schemes, text themes. See `lib/ARCHITECTURE.md` when touching library code.
- `lib/src/raw_components/`, `lib/src/utils/` — primitives (portal, focus, mouse area) and helpers.
- `test/src/` — mirrors `lib/src/`; widget tests with mocktail.
- `example/`, `playground/` — runnable demo apps (playground is the web demo behind mariuti.com docs).
- `docs/` — Astro documentation site (upstream's; not agent docs).
- `cli/` — standalone `shadcn_ui` CLI package (own pubspec/changelog).
- `skills/` — generated agent skill (`dart scripts/generate_skills.dart`); regenerate, don't hand-edit.
- Harness state: `feature_list.json`, `PROGRESS.md`, `SESSION-HANDOFF.md`, `CONSTRAINTS.md`, `init.sh` (lowercase `progress.md`/`session-handoff.md` are compat symlinks for harness tooling, like `CLAUDE.md → AGENTS.md`).

## Run / verify

Flutter is at `/opt/flutter` (off PATH): `export PATH=/opt/flutter/bin:$PATH`.

- `./init.sh` — setup + full verification in one restartable entrypoint (what a fresh session runs first).
- `make setup` — `flutter pub get` (root, cli, playground)
- `make lint` — `flutter analyze` (very_good_analysis ruleset)
- `make test` — `flutter test`
- `make check` — lint + test; the pass/fail predicate before any commit. CI equivalent: `.github/workflows/flutter-test.yaml` (check-imports + build_runner drift + analyze + test, plus a dependency-downgrade matrix).
- Run demos: `cd example && flutter run` / `cd playground && flutter run -d chrome`.

## End of session (before ending)

1. Update `feature_list.json` statuses and `PROGRESS.md` (state, blockers, recommended next step).
2. Fill `SESSION-HANDOFF.md` if work is unfinished: objective, files touched, verification evidence, next step.
3. Leave the tree clean or committed on a working branch — never half-staged.

## Current state

See `PROGRESS.md` for the fork's state (upstream sync point, `usn/*` patch branch, which SHA atomsn currently pins). Component coverage checklist lives in `README.md`.
