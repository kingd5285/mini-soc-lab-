# Testing Results & Evidence (WARMACHINE - Kali Linux WSL)

All tests were executed in an authorized home-lab environment on **Kali Linux WSL (`WARMACHINE`)** running on a **Windows 11** host, targeting local SSH (`127.0.0.1`, port `22`) within loopback scope only.

## Summary Results Table

| Test | Expected Result | Actual Result | Status | Evidence |
| :--- | :--- | :--- | :--- | :--- |
| UFW status | Active | Active (when UFW is enabled) | PASS | `sudo ufw status verbose` & `screenshots/firewall-status.png` |
| Default incoming | Deny | Deny (when UFW is enabled) | PASS | `sudo ufw status verbose` & `screenshots/firewall-status.png` |
| rsyslog | Running | Running (when rsyslog service is started) | PASS | `sudo service rsyslog status` & `./scripts/health-check.sh` |
| SSH jail | Active | Active (when Fail2Ban is started) | PASS | `sudo fail2ban-client status sshd` & `./scripts/health-check.sh` |
| Authentication logs | Available | Available (`/var/log/auth.log` present with entries) | PASS | `./scripts/health-check.sh` & `screenshots/health-check-pass.png` |
| Health check | All checks pass | 6 checks passed (when services are active) | PASS | `./scripts/health-check.sh` & `screenshots/health-check-pass.png` |
| SSH brute-force & log summary | Failed attempts, top IP/user, Ban/Unban shown | 6 failed SSH attempts from `127.0.0.1` (`invaliduser`) + Ban/Unban events (`192.0.2.50`) | PASS | `./scripts/log-summary.sh` & `screenshots/log-summary-output.png` |
| Port policy check | Open ports match expected policy | Normalized port set matches expected policy (`22`) | PASS | `./scripts/recon-check.sh 127.0.0.1 22` |

## Important Note on Service State & Screenshots
- Service states (`UFW`, `rsyslog`, and Fail2Ban `sshd` jail) depend on whether services have been started during the current WSL session.
- If a service is stopped or inactive at capture time, `health-check.sh` and `ufw status verbose` will report `inactive` / `not running` / `FAIL`—which is expected behavior rather than a script bug.
- Always start required services (`ufw`, `rsyslog`, `fail2ban`) before capturing `PASS` posture screenshots.
