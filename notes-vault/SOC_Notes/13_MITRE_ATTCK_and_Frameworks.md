# MITRE ATT&CK & Security Frameworks

> Industry frameworks for classifying and responding to cyber threats.

---

## MITRE ATT&CK Framework
- **Adversarial Tactics, Techniques & Common Knowledge**
- Globally accessible knowledge base of adversary tactics and techniques
- Based on real-world observations
- Used for: threat modeling, detection engineering, red/blue team exercises

### ATT&CK Tactics (Phases of an Attack)

| # | Tactic | Description |
|---|--------|-------------|
| 1 | Reconnaissance | Gathering information about the target |
| 2 | Resource Development | Acquiring infrastructure and tools |
| 3 | Initial Access | Gaining first foothold (phishing, exploits) |
| 4 | Execution | Running malicious code |
| 5 | Persistence | Maintaining access across restarts |
| 6 | Privilege Escalation | Gaining higher-level permissions |
| 7 | Defense Evasion | Avoiding detection |
| 8 | Credential Access | Stealing credentials |
| 9 | Discovery | Learning about the environment |
| 10 | Lateral Movement | Moving through the network |
| 11 | Collection | Gathering target data |
| 12 | Command & Control (C2) | Communicating with compromised systems |
| 13 | Exfiltration | Stealing data out of the network |
| 14 | Impact | Disrupting, destroying, or manipulating data |

---

## Cyber Kill Chain (Lockheed Martin)

| Phase | Description | SOC Action |
|-------|-------------|-----------|
| 1. **Reconnaissance** | Attacker researches target | Monitor for scanning activity |
| 2. **Weaponization** | Creating malicious payload | Threat intelligence |
| 3. **Delivery** | Sending payload (email, web, USB) | Email gateway, web filtering |
| 4. **Exploitation** | Exploiting vulnerability | IDS/IPS, EDR |
| 5. **Installation** | Installing malware/backdoor | AV/EDR detection |
| 6. **Command & Control** | Establishing C2 channel | Network monitoring, DNS analysis |
| 7. **Actions on Objectives** | Achieving goal (data theft, destruction) | Incident response |

---

## TTP (Tactics, Techniques & Procedures)
- **Tactics**: The attacker's goal (what they want to achieve)
- **Techniques**: How they accomplish the tactic
- **Procedures**: Specific implementation details

---

## Compliance Frameworks

| Framework | Scope |
|-----------|-------|
| **GDPR** | General Data Protection Regulation (EU) |
| **HIPAA** | Health Insurance Portability (US healthcare) |
| **PCI DSS** | Payment Card Industry Data Security |
| **SOX** | Sarbanes-Oxley Act (Financial) |
| **ISO 27001** | Information Security Management |
| **NIST** | National Institute of Standards & Technology |

---

## IOC (Indicators of Compromise)
- Evidence of a potential security breach
- Types:
  - **IP Addresses** (malicious source/destination)
  - **Domain Names** (C2 servers, phishing domains)
  - **URLs** (malicious links)
  - **File Hashes** (MD5, SHA-1, SHA-256 of malware)
  - **Email Addresses** (phishing senders)
  - **User Agents** (suspicious browser strings)

---

*Source: SOC Analyst Notes, Pages 6, various framework references*
