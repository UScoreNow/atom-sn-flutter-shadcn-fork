# PROGRESS.md — fork state

_Last reviewed: 2026-07-08. Update when syncing upstream, landing `usn/*` patches, or moving the atomsn pin._

## Done

- Fork synced with upstream `nank1ro/flutter-shadcn-ui` at package version **0.55.0** (`main` == `dev`).
- UScoreNow patch branch **`usn/0.54.0-elms-huge`** carries the fork-specific fixes consumed by AtomSN:
  app-wide default font family, time-picker text centering/padding fixes, checkbox/radio sublabel alignment fixes.
- `atom-sn-flutter/packages/atomsn` pins this repo at SHA `ef0dba5` (branch `usn/0.54.0-elms-huge`).

## In progress / pending

- Two commits on `usn/0.54.0-elms-huge` are **newer than the pinned SHA** (`647d359`, `23ab874` — checkbox/radio
  sublabel alignment). Bump the `ref:` in atomsn's pubspec when they should reach consumers.
- Upstream moves fast; periodic `main` sync + rebase/re-cut of the `usn/*` branch is recurring work.

## Blocked

- Nothing currently blocked.
