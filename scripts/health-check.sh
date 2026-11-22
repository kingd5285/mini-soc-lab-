#!/usr/bin/env bash
set -u

echo "=== Mini-SOC Health Check (WARMACHINE) ==="
echo "[1] UFW Status:"
sudo ufw status || true

echo ""
echo "[2] rsyslog Service:"
sudo service rsyslog status | head -n 5 || true

echo ""
echo "[3] Fail2Ban sshd Jail:"
sudo fail2ban-client status sshd || true
