# Environment Limitations

- **WSL vs. Bare Metal:** WSL runs inside a Windows environment, so firewall and packet filtering behavior can differ from a standalone Linux server or bare-metal host.
- **Loopback Scope:** Attack simulation has focused on local loopback (`127.0.0.1`) rather than an external network host.
- **Detection Scope:** Current detection relies on host authentication logs and `Fail2Ban` rather than full network packet inspection or centralized SIEM correlation.
