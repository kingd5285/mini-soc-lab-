#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-127.0.0.1}"
echo "Checking reachable ports on $TARGET..."
nmap -Pn -T4 --top-ports 20 "$TARGET"
