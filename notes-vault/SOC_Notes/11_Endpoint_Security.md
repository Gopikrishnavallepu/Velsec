# Endpoint Security

> Protecting end-user devices (laptops, desktops, workstations) from threats.

---

## Endpoint Security Solutions

### EDR (Endpoint Detection & Response)
- **Next-generation antivirus**
- Blocks malware and malicious activities
- Provides real-time monitoring and threat detection
- Tools: CrowdStrike, Carbon Black, Microsoft Defender ATP, SentinelOne

### AV (Antivirus)
- Traditional virus detection and removal
- Signature-based detection
- Virus is the attack → Antivirus is the solution

### AM (Anti-Malware)
- Broader than antivirus
- Covers entire malware category (viruses, worms, trojans, ransomware, etc.)

### HIDS (Host Intrusion Detection System)
- Detects harmful/malicious activities on **employee laptops**
- **Detection only** - does NOT block
- Monitors file changes, process activities, registry modifications

### HIPS (Host Intrusion Prevention System)
- Detects AND **blocks** malicious activities on endpoints
- Preferred in organizations over HIDS
- Real-time prevention capability

### DLP (Data Loss/Leak Prevention)
- Prevents unauthorized data transfers
- Monitors employee actions with company assets
- Blocks: USB copying, email forwarding of sensitive data, printing restrictions
- Protects against both insider threats and external attackers

### FIM (File Integrity Monitoring)
- Monitors file system for unauthorized changes
- Detects: file encryption, deletion, modification, addition
- Critical for detecting ransomware activity
- Tool: **Varonis**

### Encryption
- Encrypts data on endpoints
- Protects data at rest and in transit
- Full disk encryption for laptops

---

## Endpoint Security Deployment

| Solution | Function |
|----------|----------|
| AV / EDR | Malware detection & prevention |
| DLP | Data loss prevention |
| Encryption | Data protection |
| HIDS / HIPS | Host intrusion detection/prevention |
| FIM | File integrity monitoring |

---

## Agent-Based Security
- **Agent**: A piece of software provided by the security vendor
- Must be installed on **each and every endpoint**
- Communicates with central management server
- Provides: real-time protection, policy enforcement, log forwarding

---

## Identity & Access Management

| Tool | Function |
|------|----------|
| **CyberArk** | IAM/IDM - Identity Access Management |
| **Microsoft PAM** | Privileged Access Management |
| **Varonis** | FIM - File Integrity Monitoring |

---

## Endpoint Hardening Checklist
- Install and update AV/EDR agent
- Enable full disk encryption
- Configure HIPS/HIDS
- Deploy DLP policies
- Enable FIM
- Set strong password policies
- Enable MFA (Multi-Factor Authentication)
- Regular patching and updates
- Disable unnecessary ports and services
- Configure logging to forward to SIEM

---

*Source: SOC Analyst Notes, Pages 4, 55-56*
