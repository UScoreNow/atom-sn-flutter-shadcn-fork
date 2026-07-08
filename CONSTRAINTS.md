# CONSTRAINTS.md — hard rules for this repository

Each rule states its source. Remove a rule only when its source disappears.

## Code

- **MUST NOT** import `package:flutter/material.dart` or `package:flutter/cupertino.dart` under `lib/`.
  Source: `.github/workflows/check-imports.yaml` (build fails). Sanctioned exceptions are whitelisted inside that workflow.
- **MUST NOT** import `package:shadcn_ui/shadcn_ui.dart` (the barrel file) from within `lib/` — use relative/specific imports.
  Source: same workflow.
- New widgets **MUST** be prefixed `Shad`, have a paired theme class in `lib/src/theme/components/`, and be exported from `lib/shadcn_ui.dart`.
  Source: `CONTRIBUTING.md`.
- Component parameters **MUST** resolve as `widget.x ?? theme.<component>Theme.x ?? default`.
  Source: `CONTRIBUTING.md`.
- **MUST NOT** hand-edit generated files (`*.g.theme.dart`, `lib/src/i18n/`, `skills/`). Regenerate with
  `dart run build_runner build`, slang, or `dart scripts/generate_skills.dart`.
  Source: `.github/workflows/build-runner.yml` fails on drift.

## Fork discipline

- `main` **MUST** remain mergeable from upstream `nank1ro/flutter-shadcn-ui`; UScoreNow-specific
  patches (ElmsSans/HugeIcons era changes, pixel fixes for AtomSN) go on `usn/*` branches.
  Source: existing branch layout (`usn/0.54.0-elms-huge`) and the atomsn git-SHA dependency.
- **MUST NOT** publish to pub.dev (`dart pub publish`, `make publish`, `.github/workflows/publish.yaml`
  are upstream's release path, not the fork's). Consumers pin a git SHA.
  Source: `atom-sn-flutter/packages/atomsn/pubspec.yaml`.
- **MUST NOT** rewrite history (force-push) on `main`, `dev`, or any `usn/*` branch that a consumer SHA points at.
  Source: pinned-SHA consumption; user git guardrails.

## Workflow

- Working branches: `feature|fix|refactor|update/<name>`; PR to `dev`; `dev` → `main` by PR only.
  PR titles/descriptions in Spanish; branches, Conventional Commit messages, and code comments in English.
  Source: UScoreNow org contribution guidelines (linked from `README.md`) and owner policy.
- `make check` (analyze + test) **MUST** pass before committing library changes.
  Source: mirrors CI `.github/workflows/flutter-test.yaml`.
