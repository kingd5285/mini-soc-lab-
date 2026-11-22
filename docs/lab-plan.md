# Lab Plan (WARMACHINE - Kali Linux WSL)

## Objective
Build and document a reproducible local Blue Team / Mini-SOC lab on **Kali Linux WSL (`WARMACHINE`)** under **Windows 11**, focusing on host firewall policy, SSH authentication log analysis, Fail2Ban validation, and honest evidence reporting.

## Scope & Boundaries
- **Target:** Local SSH service (`127.0.0.1`, port `22`)
- **Network scope:** Loopback interface (`127.0.0.1`) only
- **Out of scope (Future Work):** Ubuntu Server target, external attacker host, Wazuh SIEM, Suricata IDS, centralized log shipping, and dashboards.

## Key Configuration & Verification Notes
- **Firewall (`UFW`):** Default incoming policy set to `deny`, SSH (`22/tcp`) permitted, and status checked via `ufw status verbose`.
- **Logging (`rsyslog`):** Writes SSH authentication events to `/var/log/auth.log` for inspection and parsing by `scripts/log-summary.sh`.
- **Fail2Ban (`sshd` jail):** Configured with `backend = polling` on WSL; `Ban` and `Unban` actions were tested using `192.0.2.50` without making unverified claims about `ignoreip` precedence rules.
