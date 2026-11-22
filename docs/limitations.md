# Lab Limitations & Environment Scope

## Current Environment Scope
- **Host OS:** Windows 11
- **Linux Environment:** Kali Linux WSL (`WARMACHINE`)
- **Target & Scope:** Local SSH service on loopback (`127.0.0.1`, port `22`) only
- **Implemented Stack:** UFW, `rsyslog` (`/var/log/auth.log`), Fail2Ban (`sshd` jail), and Bash verification/analysis scripts (`health-check.sh`, `log-summary.sh`, `recon-check.sh`).

## WSL & Lab Limitations
- **Not a production or bare-metal server:** WSL service management, networking, and firewall/ban enforcement can differ from a standalone Ubuntu Server or bare-metal Linux host.
- **Service persistence across sessions:** Services such as `rsyslog`, `fail2ban`, and `ufw` may not remain running automatically across WSL restarts unless started in the session, affecting point-in-time `health-check.sh` and `ufw status` outputs.
- **Loopback-only testing:** Attack simulation (such as Hydra brute-force testing) is restricted to `127.0.0.1`; external network hosts and multi-host traffic are out of scope for the current implementation.
- **Log-based detection only:** Current detection relies on host authentication and Fail2Ban logs rather than network packet inspection or centralized SIEM correlation.

## Future Work (Not Yet Implemented)
- Dedicated Ubuntu Server target and separate attacker host
- Wazuh SIEM deployment and centralized log collection/dashboards
- Suricata IDS deployment and rule-based network detection
