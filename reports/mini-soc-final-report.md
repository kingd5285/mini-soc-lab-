# Mini-SOC Lab Final Report (WARMACHINE)

## Executive Summary
A modular Blue Team and detection engineering lab (`mini-soc-lab`) was deployed and validated on Kali Linux under WSL (`WARMACHINE`), combining `UFW` host firewalling, `rsyslog` log collection, `Fail2Ban` intrusion prevention (`polling` backend), and automated shell scripts for health and log analysis.

## Key Technical Outcomes
- **Firewall & Service Hardening:** Configured `UFW` with default incoming deny and verified SSH access.
- **Reliable Log Pipeline:** Enabled `rsyslog` to populate `/var/log/auth.log` for `Fail2Ban` polling.
- **Detection & Response:** Validated `sshd` filter rules, tested ban/unban workflows, and documented `[DEFAULT]` `ignoreip` behavior for loopback safety.
- **Automation & Portfolio Readiness:** Built `health-check.sh`, `log-summary.sh`, and `recon-check.sh`, and organized documentation and configuration snapshots in Git.

## Next Steps
- Add visual evidence (`screenshots/health-check-pass.png`, `screenshots/log-summary-output.png`, `screenshots/firewall-status.png`) as captured.
- Expand into external test hosts, `Suricata`, `Wazuh`, and `iptables`/`nftables` rule verification.
