# Mini-SOC / IDS Lab (Kali Linux WSL - WARMACHINE)

A modular Blue Team and detection engineering lab built on Kali Linux under WSL to practice host firewalling, authentication log ingestion, intrusion prevention validation, and clear security documentation for portfolio development.

## What This Lab Demonstrates
- **Host Firewalling:** Enforcing default incoming deny rules using `UFW` on a Kali Linux WSL environment (`WARMACHINE`).
- **WSL Log Ingestion:** Running `rsyslog` so authentication events are reliably written to `/var/log/auth.log` for `Fail2Ban` `polling` mode.
- **Detection & Enforcement:** Validating `sshd` filter rules via `fail2ban-regex` and verifying active jail actions (`banip` / `unbanip`) with `fail2ban-client`.
- **Loopback (`ignoreip`) Precedence:** Documenting how `[DEFAULT]` `ignoreip = 127.0.0.1/8 ::1` prevents loopback auto-bans during local `Hydra` tests while keeping loopback exclusions intact to protect host access.

## Architecture & Stack
- **Environment:** `WARMACHINE` (Kali Linux on WSL)
- **Host Firewall:** `UFW` (default incoming deny)
- **Intrusion Prevention:** `Fail2Ban` (`sshd` jail using `backend = polling` and `/var/log/auth.log`)
- **Log Ingestion:** `rsyslog` (forwarding authentication events to `/var/log/auth.log`)
- **Simulated Attack Testing:** `Hydra` (controlled local SSH authentication attempts)

## Repository Structure
- `configs/` — Reference configuration snapshots (`sshd-wsl.local`)
- `docs/` — Lab planning notes, detection findings, and architecture documentation (`lab-plan.md`)
- `scripts/` — Automation and security posture scripts (`health-check.sh`, `log-summary.sh`, `recon_check.sh`)
- `screenshots/` — Visual evidence from lab runs

## Running the Lab Scripts

    ./scripts/health-check.sh
    ./scripts/log-summary.sh
    ./scripts/recon-check.sh 127.0.0.1 22

## Quick Status Checks

    sudo ufw status
    sudo service rsyslog status
    sudo fail2ban-client status sshd

