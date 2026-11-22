# Mini-SOC / IDS Lab (Kali Linux WSL - WARMACHINE)

A modular Blue Team and detection engineering lab built on Kali Linux under WSL to practice host firewalling, authentication log ingestion, intrusion prevention validation, and clear security documentation for portfolio development.

## Architecture & Stack
- **Environment:** `WARMACHINE` (Kali Linux on WSL)
- **Host Firewall:** `UFW` (configured with default incoming deny)
- **Intrusion Prevention:** `Fail2Ban` (`sshd` jail using `backend = polling` and `/var/log/auth.log`)
- **Log Ingestion:** `rsyslog` (forwarding authentication events to `/var/log/auth.log`)
- **Simulated Attack Testing:** `Hydra` (controlled local SSH authentication attempts)

## Repository Structure
- `configs/` — Reference configuration snapshots (`sshd-wsl.local`)
- `docs/` — Lab planning notes, detection findings, and architecture documentation (`lab-plan.md`)
- `scripts/` — Automation and security posture health-check scripts

## Key Findings & Validation
- **WSL Log Ingestion:** Enabled and verified `rsyslog` so `Fail2Ban` reliably polls `/var/log/auth.log` rather than relying solely on direct journal queries.
- **Filter & Enforcement Testing:** Validated `sshd` filter regex matching against authentication logs with `fail2ban-regex`, and confirmed active jail enforcement using `fail2ban-client` (`banip` and `unbanip`).
- **Loopback (`ignoreip`) Precedence:** Confirmed that `[DEFAULT]` `ignoreip = 127.0.0.1/8 ::1` prevents automated bans on loopback traffic even when testing against `127.0.0.1`, and preserved loopback exclusions to avoid locking out local access.

## Quick Status Checks

    sudo ufw status
    sudo service rsyslog status
    sudo fail2ban-client status sshd

