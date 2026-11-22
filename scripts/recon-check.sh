#!/usr/bin/env bash
# Authorized lab use only.
set -euo pipefail

if ! command -v nmap >/dev/null 2>&1; then
  echo "[FAIL] nmap is not installed" >&2
  exit 1
fi

TARGET="${1:-127.0.0.1}"
EXPECTED_RAW="${2:-22}"

normalize_ports() {
  printf '%s\n' "$1" \
    | tr -cs '0-9' '\n' \
    | grep -Eo '^[0-9]+$' \
    | sort -nu \
    | tr '\n' ' ' \
    | sed 's/[[:space:]]*$//'
}

EXPECTED_NORM="$(normalize_ports "$EXPECTED_RAW")"

echo "Scanning $TARGET (expected open ports: ${EXPECTED_NORM:-none})..."
OPEN_NORM="$(
  nmap -Pn -T4 --top-ports 100 "$TARGET" -oG - 2>/dev/null \
    | grep -Eo '[0-9]+/open' \
    | cut -d'/' -f1 \
    | sort -nu \
    | tr '\n' ' ' \
    | sed 's/[[:space:]]*$//'
)"

echo "Open ports: ${OPEN_NORM:-none}"

if [ "$OPEN_NORM" = "$EXPECTED_NORM" ]; then
  echo "[PASS] Open ports match expected policy"
  exit 0
else
  echo "[FAIL] Open ports differ from expected policy (expected: ${EXPECTED_NORM:-none}, actual: ${OPEN_NORM:-none})" >&2
  exit 1
fi
