#!/usr/bin/env bash
# Authorized lab use only.
set -euo pipefail

AUTH_LOG="${AUTH_LOG:-/var/log/auth.log}"
F2B_LOG="${F2B_LOG:-/var/log/fail2ban.log}"

if [ ! -e "$AUTH_LOG" ]; then
  echo "[FAIL] Auth log does not exist: $AUTH_LOG" >&2
  exit 1
fi

if [ ! -r "$AUTH_LOG" ]; then
  echo "[FAIL] Auth log is not readable (try running with sudo): $AUTH_LOG" >&2
  exit 1
fi

echo "=== Mini-SOC SSH Auth Log Summary (WARMACHINE) ==="

# Exclude sudo self-logging lines and match IPv4 / IPv6 source addresses
FAILED_LINES="$(
  grep -E 'sshd\[' "$AUTH_LOG" \
    | grep -v 'sudo:' \
    | grep -E 'Failed password|Invalid user|authentication failure' || true
)"

FAILED_COUNT="$(printf '%s\n' "$FAILED_LINES" | sed '/^$/d' | wc -l | tr -d ' ')"
echo "[1] Failed SSH attempts: $FAILED_COUNT"

echo "[2] Top source IPs (IPv4 & IPv6):"
if [ "$FAILED_COUNT" -gt 0 ]; then
  printf '%s\n' "$FAILED_LINES" \
    | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}|([0-9a-fA-F]{0,4}:){2,7}[0-9a-fA-F]{1,4}|::1' \
    | sed '/^$/d' \
    | sort \
    | uniq -c \
    | sort -nr \
    | head -n 10
else
  echo "  none"
fi

echo "[3] Top targeted usernames (valid + invalid):"
if [ "$FAILED_COUNT" -gt 0 ]; then
  printf '%s\n' "$FAILED_LINES" \
    | sed -nE 's/.*Failed password for (invalid user )?([^ ]+) from .*/\2/p; s/.*Invalid user ([^ ]+) from .*/\1/p' \
    | sed '/^$/d' \
    | sort \
    | uniq -c \
    | sort -nr \
    | head -n 10
else
  echo "  none"
fi

echo "[4] Recent Fail2Ban Ban/Unban events:"
if [ -r "$F2B_LOG" ]; then
  BAN_EVENTS="$(grep -E '\[(sshd|recidive)\] (Ban|Unban) ' "$F2B_LOG" | tail -n 10 || true)"
  if [ -n "$BAN_EVENTS" ]; then
    printf '%s\n' "$BAN_EVENTS"
  else
    echo "  none"
  fi
else
  echo "  [WARN] Fail2Ban log not readable or missing: $F2B_LOG"
fi
