#!/usr/bin/env bash
set -uo pipefail
AUTH_LOG="${1:-/var/log/auth.log}"
F2B_LOG="/var/log/fail2ban.log"

[ -f "$AUTH_LOG" ] || { echo "Log file not found: $AUTH_LOG"; exit 1; }
FAILED=$(sudo grep -a "Failed password" "$AUTH_LOG" | grep -v " sudo:")

echo "=== Mini-SOC SSH Auth Log Summary ($(hostname)) ==="
echo "[1] Failed SSH attempts:"
printf '%s' "$FAILED" | grep -c . || true

echo; echo "[2] Top source IPs:"
printf '%s' "$FAILED" | grep -Eo 'from ([0-9]{1,3}\.){3}[0-9]{1,3}' \
  | awk '{print $2}' | sort | uniq -c | sort -nr | head -n 5

echo; echo "[3] Top targeted usernames (valid + invalid):"
printf '%s' "$FAILED" \
  | sed -E 's/.*Failed password for (invalid user )?([^ ]+) from.*/\2/' \
  | sort | uniq -c | sort -nr | head -n 5

echo; echo "[4] Recent Fail2Ban Ban/Unban events:"
if [ -f "$F2B_LOG" ]; then
  sudo grep -aE '\] (Ban|Unban) ' "$F2B_LOG" | tail -n 5
else
  echo "No $F2B_LOG found"
fi
