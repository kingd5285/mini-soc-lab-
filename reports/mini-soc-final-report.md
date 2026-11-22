# Mini-SOC Lab Report — WARMACHINE (Kali Linux WSL)

## Executive Summary
This report documents the local Blue Team / Mini-SOC lab built on **Kali Linux WSL (`WARMACHINE`)** over **Windows 11**, covering UFW firewall policy, `rsyslog` authentication logging, Fail2Ban `sshd` jail validation, and Bash automation scripts (`health-check.sh`, `log-summary.sh`, `recon-check.sh`).

## Implemented vs. Future Work
- **Implemented:** UFW policy setup, `rsyslog` log collection (`/var/log/auth.log`), Fail2Ban `sshd` jail (`polling` backend) with `192.0.2.50` Ban/Unban log verification, Hydra failed-SSH simulation against `127.0.0.1`, and Bash health/log/recon scripts.
- **Future Work:** Dedicated Ubuntu Server target and separate attacker host, Wazuh SIEM, Suricata IDS, centralized log collection, and dashboards.

## Key Outcomes & Honest Caveats
- `log-summary.sh` was updated to deduplicate failed SSH attempt entries, avoid counting `sudo` lines, and extract IPv4/IPv6 source addresses cleanly without misclassifying `HH:MM:SS` timestamps.
- `recon-check.sh` normalizes and sorts port lists before comparing against expected policy.
- Screenshots reflect exact point-in-time WSL states (including `Status: inactive` in `screenshots/firewall-status.png` when UFW was not active at capture time).
