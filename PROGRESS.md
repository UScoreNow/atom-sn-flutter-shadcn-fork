# PROGRESS.md — fork state

**Last updated:** 2026-07-08. Update when syncing upstream, landing `usn/*` patches, moving the atomsn pin, or ending a session.

## Current objective

Agent harness in place (`update/agent-harness` branch); next real work is the `usn/*` re-cut onto 0.55.0 (see `feature_list.json`).

## Current state

- Fork synced with upstream `nank1ro/flutter-shadcn-ui` at package version **0.55.0** (`dev` at `c5ddeed`, merged into `main` via PR #4).
- UScoreNow patch branch **`usn/0.54.0-elms-huge`** (based on upstream **0.54.0**) carries the fork-specific fixes consumed by AtomSN:
  app-wide default font family, time-picker text centering/padding fixes, checkbox/radio sublabel alignment fixes.
- `atom-sn-flutter/packages/atomsn` pins this repo at SHA `23ab874` — the **tip** of `usn/0.54.0-elms-huge`. No pin bump pending.

## Next / pending

- **Re-cut the `usn/*` patch branch onto 0.55.0**: `usn/0.54.0-elms-huge` is still based on upstream 0.54.0 while `main`/`dev` are at 0.55.0. Replay the patches onto the new base (new branch `usn/0.55.0-elms-huge`), verify, then bump the atomsn pin. Tracked in `feature_list.json` (`usn-recut-0.55.0`).
- Upstream moves fast; periodic `main` sync + re-cut of the `usn/*` branch is recurring work.

## Blockers

- Nothing currently blocked.

## Recommended next step

Merge the harness PR, then start `usn-recut-0.55.0` from `feature_list.json`.

## Verification evidence

Append `command → output` proof here (or in `SESSION-HANDOFF.md`) when closing a feature.

- 2026-07-08: `./init.sh` full run green — `flutter analyze` clean, `flutter test` `+326: All tests passed!`, exit 0.
- 2026-07-08: pin verified current — `gh api repos/UScoreNow/atom-sn-flutter/contents/packages/atomsn/pubspec.yaml?ref=dev` shows `ref: 23ab874…`, and `git log origin/usn/0.54.0-elms-huge -1` is `23ab874`.
