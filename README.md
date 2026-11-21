# Mini-SOC & Network Intrusion Detection Lab

## Overview
A hands-on cybersecurity home lab simulating real-world attack scenarios from *Kali Linux (Red Team)* against a target server, while detecting, analyzing, and mitigating threats using *Wazuh/Suricata and Fail2Ban (Blue Team)*.

## Lab Architecture
- *Attacker Machine:* Kali Linux (WSL / VM)
- *Target Server:* Ubuntu Server / DVWA
- *Monitoring & SIEM:* Ubuntu Server + Wazuh / Suricata

## Project Phases
1. *Environment & Network Setup:* Isolated lab network configuration.
2. *Reconnaissance & Exploitation:* Port scanning (nmap), SSH brute-force (hydra), and web enumeration (gobuster).
3. *Detection & Log Analysis:* Monitoring security alerts and auth logs (/var/log/auth.log).
4. *Hardening & Remediation:* Implementing ufw, fail2ban, and SSH key-based authentication.

## Repository Structure
- docs/ - Network diagrams and incident response reports
- configs/ - Sanitized firewall (ufw) and fail2ban configurations
- scripts/ - Automation and log-parsing scripts
- screenshots/ - Redacted proof-of-concept and SIEM alert captures
