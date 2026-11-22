# Testing Results & Evidence (WARMACHINE - Kali Linux WSL)

All tests were conducted on **Kali Linux WSL (`WARMACHINE`)** running on **Windows 11**, targeting local SSH (`127.0.0.1`, port `22`) within loopback scope only.

## Detailed Results & Evidence

| Test | Command / Check | Expected Result | Actual Result & Evidence Notes | Status |
| :--- | :--- | :--- | :--- | :--- |
| UFW status | `sudo ufw status verbose` | `Status: active` when enabled | `screenshots/firewall-status.png` shows `Status: inactive` at capture time; UFW is `active` when started | VERIFIED IN CAPTURE (`inactive`) / PASS WHEN ENABLED |
| Default incoming | `sudo ufw status verbose` | `Default: deny (incoming)` when active | Matches policy when UFW is active | PASS (when active) |
| rsyslog | `sudo service rsyslog status` | Service running | Running when started in WSL session | PASS (when running) |
| Fail2Ban `sshd` jail | `sudo fail2ban-client status sshd` | Jail active | Active when Fail2Ban service is started in WSL session | PASS (when running) |
| Auth log availability | `./scripts/health-check.sh` | `/var/log/auth.log` exists and has data | Confirmed in `screenshots/health-check-pass.png` | PASS |
| SSH brute-force simulation | Hydra against `127.0.0.1` + `./scripts/log-summary.sh` | Failed SSH attempts recorded without double-counting | Deduplicated attempt summary and target usernames reported; direct Hydra live-ban is not claimed as verified evidence | PASS (attempt logging) |
| Fail2Ban Ban/Unban event | `./scripts/log-summary.sh` (`/var/log/fail2ban.log`) | `Ban` / `Unban` entries visible | `Ban` and `Unban` events for `192.0.2.50` observed in Fail2Ban log | PASS (test IP `192.0.2.50`) |
| Port policy check | `./scripts/recon-check.sh 127.0.0.1 22` | Normalized open ports match expected (`22`) | Normalized port comparison prevents formatting/order false fails | PASS |

## Evidence Integrity Rules
- Captures must never be misrepresented: if a screenshot shows a stopped or inactive service (`inactive`, `not running`, `not active`), documentation states that exact state rather than labeling it `PASS` blindly.
- Re-capture screenshots after starting required services (`ufw`, `rsyslog`, `fail2ban`) and re-running scripts when updated `PASS` evidence is needed.
