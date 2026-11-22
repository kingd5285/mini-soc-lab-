#!/usr/bin/env bash
# Authorized lab use only.
set -euo pipefail
command -v nmap >/dev/null || { echo "nmap not installed"; exit 1; }

TARGET="${1:-127.0.0.1}"
EXPECTED="${2:-22}"   # ports zinazotarajiwa, mfano "22 80"

echo "Scanning $TARGET (expected open: $EXPECTED)..."
OPEN=$(nmap -Pn -T4 --top-ports 100 "$TARGET" -oG - \
  | grep -Eo '[0-9]+/open' | cut -d/ -f1 | sort -n | xargs || true)

echo "Open ports: ${OPEN:-none}"
if [ "${OPEN:-}" = "$EXPECTED" ]; then echo "[PASS] Matches policy"; else echo "[FAIL] Differs from policy"; exit 1; fi
