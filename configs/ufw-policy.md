# UFW Host Firewall Policy (WARMACHINE - WSL)

- **Default Incoming Policy:** Deny (`ufw default deny incoming`)
- **Default Outgoing Policy:** Allow (`ufw default allow outgoing`)
- **Allowed Service:** SSH (port 22) for lab management and testing
- **Purpose:** Limit exposed host ports on Kali Linux (WSL) while maintaining local lab access.
