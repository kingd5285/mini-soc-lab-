# Lab Plan & Scope
- Attacker: Kali Linux (WSL / WARMACHINE)
- Target & SOC Components: Ubuntu Server, Wazuh / Suricata, UFW, Fail2Ban
- Rules of Engagement: Authorized home lab environment only.
- Status: Credential store enabled
- Firewall (UFW): Active (22/tcp OpenSSH allowed, default incoming deny)
- Intrusion Prevention (Fail2Ban): Active with sshd jail enabled

## Step 2: SSH Service, UFW & Fail2Ban Hardening
- Target: Localhost (127.0.0.1) on WARMACHINE (Kali WSL)
- SSH: OpenSSH server enabled on port 22/tcp
- UFW: Active with OpenSSH allowed and default incoming traffic denied
- Fail2Ban: Active with sshd jail enabled
- Validation: Verified journald fields (SYSLOG_IDENTIFIER=sshd, _COMM=sshd, _SYSTEMD_UNIT=ssh.service) and tested Fail2Ban detection against SSH login attempts on 127.0.0.1.
- Session Wrap-up: Confirmed rsyslog active, verified 127.0.0.1/8 in default Fail2Ban ignoreip, and validated sshd jail ban/unban actions using test IP 192.0.2.50 on WARMACHINE.
