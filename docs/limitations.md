# Lab Limitations & Environment Scope

## Current Environment
- **Host OS:** Windows 11
- **Linux Environment:** Kali Linux WSL (`WARMACHINE`)
- **Scope:** Localhost (`127.0.0.1`) SSH service only

## Limitations
- **WSL service and network behavior:** Services (`ufw`, `rsyslog`, `fail2ban`) may not persist automatically across WSL restarts and can behave differently from bare-metal Linux or a dedicated Ubuntu Server.
- **Loopback-only testing:** Simulation is limited to `127.0.0.1`; external attacker hosts and multi-host traffic are not part of the current implementation.
- **No direct Hydra live-ban proof:** Ban/unban verification in logs was performed with `192.0.2.50`, so an automatic live ban triggered by Hydra is not claimed as verified.
- **Host log-only detection:** No Wazuh SIEM, Suricata IDS, or centralized log pipeline is deployed yet.
