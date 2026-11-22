#!/usr/bin/env bash
set -uo pipefail
FAIL=0
ok()  { echo "[PASS] $1"; }
bad() { echo "[FAIL] $1"; FAIL=1; }

echo "=== Mini-SOC Health Check ($(hostname)) ==="
UFW=$(sudo ufw status verbose 2>&1)
grep -q "Status: active" <<<"$UFW"   && ok "UFW active" || bad "UFW not active"
grep -q "deny (incoming)" <<<"$UFW"  && ok "UFW default deny incoming" || bad "UFW default is not deny incoming"
sudo service rsyslog status >/dev/null 2>&1 && ok "rsyslog running" || bad "rsyslog not running"
[ -s /var/log/auth.log ] && ok "auth.log exists and has data" || bad "auth.log missing/empty"
sudo fail2ban-client status sshd >/dev/null 2>&1 && ok "Fail2Ban sshd jail active" || bad "sshd jail not active"
sudo fail2ban-client get sshd ignoreip 2>/dev/null | grep -Eq '127\.0\.0\.' \
  && ok "Loopback in effective ignoreip" || bad "Loopback NOT in effective ignoreip"

exit $FAIL
