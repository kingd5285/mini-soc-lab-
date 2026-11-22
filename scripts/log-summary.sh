#!/usr/bin/env bash
set -u

LOG_FILE="/var/log/auth.log"

echo "=== Mini-SOC SSH Auth Log Summary (WARMACHINE) ==="
if [ ! -f "$LOG_FILE" ]; then
    echo "Log file not found: $LOG_FILE"
    exit 1
fi

echo "[1] Total Failed / Invalid SSH Events:"
sudo grep -Ec "Failed password|Invalid user|authentication failure" "$LOG_FILE" || true

echo ""
echo "[2] Top Source IP Addresses (Failed/Invalid):"
sudo grep -E "Failed password|Invalid user" "$LOG_FILE" | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | sort | uniq -c | sort -nr | head -n 5 || true

echo ""
echo "[3] Top Targeted Usernames:"
sudo grep -E "Invalid user" "$LOG_FILE" | awk '{for(i=1;i<=NF;i++) if($i=="user") print $(i+1)}' | sort | uniq -c | sort -nr | head -n 5 || true

echo ""
echo "[4] Recent 5 Auth Alerts:"
sudo grep -E "Failed password|Invalid user|Ban|Unban" "$LOG_FILE" | tail -n 5 || true
