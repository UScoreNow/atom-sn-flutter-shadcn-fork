#!/bin/bash
# Session entrypoint: environment + dependencies + full verification.
# Restartable and idempotent — safe to run at the start of every session.
set -e

echo "=== atom-sn-flutter-shadcn-fork: init ==="

if ! command -v flutter >/dev/null 2>&1; then
  if [ -x /opt/flutter/bin/flutter ]; then
    export PATH="/opt/flutter/bin:$PATH"
  else
    echo "ERROR: flutter not found (expected on PATH or at /opt/flutter/bin)." >&2
    exit 1
  fi
fi
flutter --version | head -1

echo "=== make setup (pub get: root, cli, playground) ==="
make setup

echo "=== make check (flutter analyze + flutter test) ==="
make check

echo "=== Verification complete ==="
echo ""
echo "Next steps:"
echo "1. Read PROGRESS.md (fork state) and feature_list.json (work items)"
echo "2. Pick ONE item that is pending/in_progress; keep a single item in_progress"
echo "3. Implement only that item; CONSTRAINTS.md lists the hard rules"
echo "4. Re-run make check and record evidence before claiming done"
