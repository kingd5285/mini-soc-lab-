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

# Extract normalized failed SSH attempts without double-counting Invalid user + Failed password
# Output format per attempt: <ip>\t<user>
ATTEMPTS="$(
  grep -E 'sshd\[' "$AUTH_LOG" \
    | grep -v 'sudo:' \
    | grep -E 'Failed password|Invalid user|authentication failure' \
    | awk '
      {
        line = $0
        # Extract IP after "from " if present
        ip = ""
        if (match(line, /from[[:space:]]+[^[:space:]]+/)) {
          ip = substr(line, RSTART + 5, RLENGTH - 5)
          sub(/[^0-9a-fA-F:.].*$/, "", ip)
        }

        # Extract username if present
        user = "unknown"
        if (match(line, /Failed password for (invalid user )?[^[:space:]]+/)) {
          m = substr(line, RSTART, RLENGTH)
          sub(/^Failed password for (invalid user )?/, "", m)
          if (length(m) > 0) user = m
        } else if (match(line, /Invalid user [^[:space:]]+/)) {
          m = substr(line, RSTART, RLENGTH)
          sub(/^Invalid user /, "", m)
          if (length(m) > 0) user = m
        }

        # Extract PID to deduplicate multi-line auth failure messages for the same SSH session
        pid = "nopid"
        if (match(line, /sshd\[[0-9]+\]/)) {
          pid = substr(line, RSTART + 5, RLENGTH - 6)
        }

        # Extract timestamp prefix (date + HH:MM:SS) to group same-second session lines
        ts = $1 " " $2 " " $3

        if (length(ip) > 0) {
          key = ts "|" pid "|" ip "|" user
          if (!(key in seen)) {
            seen[key] = 1
            print ip "\t" user
          }
        }
      }
    ' || true
)"

FAILED_COUNT="$(printf '%s\n' "$ATTEMPTS" | sed '/^$/d' | wc -l | tr -d ' ')"
echo "[1] Failed SSH attempts: $FAILED_COUNT"

echo "[2] Top source IPs (IPv4 & IPv6):"
if [ "$FAILED_COUNT" -gt 0 ]; then
  printf '%s\n' "$ATTEMPTS" \
    | awk -F'\t' 'NF >= 1 && $1 != "" { print $1 }' \
    | sort \
    | uniq -c \
    | sort -nr \
    | head -n 10
else
  echo "  none"
fi

echo "[3] Top targeted usernames (valid + invalid):"
if [ "$FAILED_COUNT" -gt 0 ]; then
  printf '%s\n' "$ATTEMPTS" \
    | awk -F'\t' 'NF >= 2 && $2 != "" { print $2 }' \
    | sort \
    | uniq -c \
    | sort -nr \
    | head -n 10
else
  echo "  none"
fi

echo "[4] Recent Fail2Ban Ban/Unban events:"
if [ -r "$F2B_LOG" ]; then
  BAN_EVENTS="$(grep -aE '\[(sshd|recidive)\] (Ban|Unban) ' "$F2B_LOG" | tail -n 10 || true)"
  if [ -n "$BAN_EVENTS" ]; then
    printf '%s\n' "$BAN_EVENTS"
  else
    echo "  none"
  fi
else
  echo "  [WARN] Fail2Ban log not readable or missing: $F2B_LOG"
fi
