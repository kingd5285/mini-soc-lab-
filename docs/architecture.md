# Lab Architecture (WARMACHINE)

- **Host Environment:** Kali Linux on WSL (`WARMACHINE`)
- **Host Firewall:** `UFW` enforcing default incoming deny
- **Log Ingestion:** `rsyslog` forwarding SSH authentication events to `/var/log/auth.log`
- **Intrusion Prevention:** `Fail2Ban` monitoring `/var/log/auth.log` with `sshd` jail (`backend = polling`)
- **Attack Simulation:** `Hydra` targeting `127.0.0.1` within the controlled home lab
