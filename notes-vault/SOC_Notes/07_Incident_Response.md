# Incident Response

> The process of detecting, investigating, and responding to security incidents.

---

## SOC Team Names
- **SOC** - Security Operations Centre
- **CSIRT** - Cyber Security Incident Response Team
- **CERT** - Computer Emergency Response Team
- **SIRT** - Security Incident Response Team

---

## Incident Response Lifecycle

### 1. Preparation
- Establish SOC team and roles
- Deploy security tools (SIEM, EDR, Firewall, IDS/IPS)
- Create incident response playbooks
- Define SLAs and severity levels

### 2. Detection & Analysis
- Monitor SIEM for alerts
- Triage incoming alerts
- Determine if incident is genuine (True Positive) or false alarm (False Positive)
- Classify severity: Critical / High / Medium / Low / Informational

### 3. Containment
- Isolate affected systems
- Block malicious IPs, domains, URLs, hashes
- Prevent lateral movement

### 4. Eradication
- Remove malware and malicious artifacts
- Patch vulnerabilities
- Reset compromised credentials

### 5. Recovery
- Restore systems to normal operation
- Monitor for re-infection
- Validate business operations

### 6. Lessons Learned
- Post-incident review
- Update playbooks and procedures
- Implement improvements

---

## Alert Classification

| Type | Description |
|------|-------------|
| **True Positive (TP)** | Genuine attack correctly identified |
| **True Negative (TN)** | No attack, correctly identified as clean |
| **False Positive (FP)** | No attack, but incorrectly flagged as one |
| **False Negative (FN)** | Real attack, but missed by detection |

---

## Incident Severity Levels

| Level | Priority | SLA Response |
|-------|----------|-------------|
| **P1 - Critical** | Immediate | Business impact, data breach |
| **P2 - High** | Urgent | Significant security event |
| **P3 - Medium** | Standard | Moderate risk event |
| **P4 - Low** | Routine | Low-risk activity |
| **P5 - Informational** | FYI | No action required |

---

## Investigation Workflow

1. **Alert received** in SIEM tool
2. **Check source IP** - Internal (private range) or External?
3. **Identify attack type** - Malware? Phishing? Brute Force?
4. **Gather IOCs** - IPs, domains, URLs, hashes, email addresses
5. **Reputation check** - VirusTotal, AbuseIPDB, threat intel feeds
6. **Determine impact** - What systems/users are affected?
7. **Containment actions** - Block, isolate, disable accounts
8. **Document everything** - Ticket updates, evidence collection
9. **Escalate** if needed (L1 → L2 → L3)
10. **Close incident** with detailed resolution notes

---

## Ticketing Tools
- **ServiceNow** - Enterprise IT service management
- **Jira** - Project and incident tracking
- Used for: tracking, auditing, evidence, accountability

---

## Incident Tracker
- Can be Excel-based (manual) or tool-based (automated)
- Records: Incident ID, timestamp, analyst, actions taken, status
- Essential for **shift handover**

---

*Source: SOC Analyst Notes, Pages 6-7, various sections on incident handling*
