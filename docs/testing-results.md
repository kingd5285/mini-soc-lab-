# Testing & Validation Results

- **Log Ingestion (`rsyslog`):** Verified SSH authentication logs are written to `/var/log/auth.log` for `Fail2Ban` polling.
- **Filter & Jail Validation:** Tested `sshd` regex matching with `fail2ban-regex` and verified active enforcement (`banip` / `unbanip`) via `fail2ban-client`.
- **Loopback (`ignoreip`) Precedence:** Confirmed `[DEFAULT]` `ignoreip = 127.0.0.1/8 ::1` prevents loopback bans during standard testing while protecting local host access.
- **Brute-Force Simulation (`MITRE ATT&CK T1110`):** Recorded failed SSH login attempts from `127.0.0.1` using `Hydra` and summarized results via `scripts/log-summary.sh`.
- **Health Checks:** Verified host security posture checks via `scripts/health-check.sh`.
