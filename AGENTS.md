# AGENTS.md — atom-sn-shadcn-fork

UScoreNow's private fork of [nank1ro/flutter-shadcn-ui](https://github.com/nank1ro/flutter-shadcn-ui)
(pub package `shadcn_ui`, Flutter port of shadcn/ui). It is the base component layer of the
**AtomSN** design system: `packages/atomsn` in [UScoreNow/atom-sn-flutter](https://github.com/UScoreNow/atom-sn-flutter)
depends on this repo as a git dependency **pinned to an immutable commit SHA**.

## Hard constraints (MUST / MUST NOT)

1. **MUST NOT** import `material.dart` or `cupertino.dart` inside `lib/` (CI `check-imports.yaml` fails the build; the few sanctioned exceptions are listed in that workflow).
2. New components **MUST** follow the `Shad` prefix + paired theme + export pattern — see `CONTRIBUTING.md` before adding or modifying components.
3. `main` **MUST** stay a mirror of upstream `nank1ro/flutter-shadcn-ui`; UScoreNow-specific patches live on `usn/*` branches (currently `usn/0.54.0-elms-huge`). Do not commit fork-only changes to `main`/`dev` unless they are meant to be upstreamed or are repo meta (docs, CI).
4. **MUST NOT** run `dart pub publish` / `make publish` — this fork is never published to pub.dev; it is consumed via git SHA.
5. After merging changes intended for AtomSN, the consumer pin **MUST** be updated: bump the `ref:` SHA in `atom-sn-flutter/packages/atomsn/pubspec.yaml` (the branch can move, the pinned SHA cannot).
6. Generated files (`*.g.theme.dart`, `lib/src/i18n/*`) **MUST** be regenerated via build_runner/slang, never hand-edited (CI `build-runner.yml` checks for drift).
7. Git flow: working branch → PR to `dev` → PR to `main`. PR titles/descriptions in Spanish; branch names, commits (Conventional Commits) and code comments in English.

## What is where

- `lib/src/components/` — one file per widget (`ShadButton`, `ShadDialog`, …).
- `lib/src/theme/` — theme data, per-component themes (`theme/components/`), color schemes, text themes. See `lib/ARCHITECTURE.md` when touching library code.
- `lib/src/raw_components/`, `lib/src/utils/` — primitives (portal, focus, mouse area) and helpers.
- `test/src/` — mirrors `lib/src/`; widget tests with mocktail.
- `example/`, `playground/` — runnable demo apps (playground is the web demo behind mariuti.com docs).
- `docs/` — Astro documentation site (upstream's; not agent docs).
- `cli/` — standalone `shadcn_ui` CLI package (own pubspec/changelog).
- `skills/` — generated agent skill (`dart scripts/generate_skills.dart`); regenerate, don't hand-edit.

## Run / verify

Flutter is at `/opt/flutter` (off PATH): `export PATH=/opt/flutter/bin:$PATH`.

- `make setup` — `flutter pub get`
- `make lint` — `flutter analyze` (very_good_analysis ruleset)
- `make test` — `flutter test`
- `make check` — lint + test; the pass/fail predicate before any commit. CI equivalent: `.github/workflows/flutter-test.yaml` (check-imports + build_runner drift + analyze + test, plus a dependency-downgrade matrix).
- Run demos: `cd example && flutter run` / `cd playground && flutter run -d chrome`.

## Current state

See `PROGRESS.md` for the fork's state (upstream sync point, `usn/*` patch branch, which SHA atomsn currently pins). Component coverage checklist lives in `README.md`.
