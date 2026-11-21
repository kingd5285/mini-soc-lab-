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
