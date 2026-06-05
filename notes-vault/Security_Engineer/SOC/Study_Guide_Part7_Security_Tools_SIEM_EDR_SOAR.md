---
title: "Study Guide Part7 Security Tools Siem Edr Soar"
category: "Security Engineer"
tags: ["SOC"]
lastUpdated: "2026-06-05"
---

# 📘 Part 7: Security Tools — SIEM, EDR, SOAR, Endpoint Security, Vulnerability Management & Threat Hunting

> **Comprehensive Interview Study Guide** — Based on real cybersecurity course transcripts  
> Covers: SIEM, EDR, SOAR, Endpoint Security, Microsoft Defender, Vulnerability Management, Threat Hunting

---

## Table of Contents

1. [SIEM — Security Information & Event Management](#1-siem--security-information--event-management)
2. [EDR — Endpoint Detection & Response](#2-edr--endpoint-detection--response)
3. [SOAR — Security Orchestration, Automation & Response](#3-soar--security-orchestration-automation--response)
4. [Endpoint Security](#4-endpoint-security)
5. [Microsoft Defender for Endpoint](#5-microsoft-defender-for-endpoint)
6. [Vulnerability Management](#6-vulnerability-management)
7. [Threat Hunting](#7-threat-hunting)
8. [Interview Questions & Answers](#8-interview-questions--answers)
9. [Quick Reference Tables](#9-quick-reference-tables)
10. [Key Takeaways](#10-key-takeaways)

---

## 1. SIEM — Security Information & Event Management

### What is SIEM?
A SIEM is a security solution that **collects, aggregates, normalizes, correlates, and analyzes** log and event data from multiple sources across an organization's IT infrastructure to provide **real-time monitoring, alerting, and reporting**.

### SIEM Architecture & Components

| Component | Function |
|-----------|----------|
| **Log Collection** | Gathers logs from firewalls, servers, endpoints, applications, cloud services |
| **Normalization** | Converts different log formats into a standard format for analysis |
| **Correlation Engine** | Applies rules to correlate events across sources and detect threats |
| **Alerting** | Generates alerts based on correlation rules and thresholds |
| **Dashboard** | Visual display of security posture, alerts, and metrics |
| **Reporting** | Generates compliance and incident reports |
| **Storage** | Retains logs for historical analysis and compliance |
| **Forensic Analysis** | Enables deep-dive investigation into past events |

### Common SIEM Log Sources

| Source | What It Captures |
|--------|-----------------|
| **Firewalls** | Network traffic (allowed/denied), connection attempts |
| **IDS/IPS** | Intrusion detection alerts, blocked attacks |
| **Active Directory** | User authentication, account changes, group modifications |
| **Web Proxies** | URL access, web traffic, content filtering |
| **Email Gateways** | Email threats, spam, phishing attempts |
| **Endpoints (EDR)** | Process execution, file changes, registry modifications |
| **DNS Servers** | Domain queries, potential DNS tunneling |
| **VPN** | Remote access connections, authentication |
| **Cloud Services** | API calls, resource changes, access logs |
| **Applications** | Application-specific events, errors, access |

### SIEM Correlation Rules
- **Threshold-based:** Alert if 10+ failed logins in 5 minutes from same IP
- **Sequence-based:** Alert if port scan → vulnerability exploit → privilege escalation
- **Anomaly-based:** Alert if user downloads 10x more data than normal
- **Behavioral:** Alert if admin account logs in at unusual hours from unusual location

### SIEM Use Cases
1. **Brute force detection** — Multiple failed logins followed by success
2. **Lateral movement** — Sequential logins across multiple systems
3. **Data exfiltration** — Unusual outbound data transfers
4. **Privilege escalation** — User gaining admin rights unexpectedly
5. **Malware C2** — Periodic beaconing to external IPs
6. **Compliance reporting** — PCI-DSS, HIPAA, SOX audit logs

### Popular SIEM Solutions
- **Splunk** — Most widely used, powerful query language (SPL)
- **IBM QRadar** — Strong correlation engine, offense management
- **Microsoft Sentinel** — Cloud-native, Azure integration
- **ArcSight** — Enterprise-grade, older platform
- **LogRhythm** — SIEM + SOAR combined
- **Elastic SIEM** — Open-source based on ELK stack

---

## 2. EDR — Endpoint Detection & Response

### What is EDR?
EDR solutions continuously **monitor endpoint activities**, **detect suspicious behavior**, and provide **automated response capabilities** to contain threats at the endpoint level.

### Key EDR Features

| Feature | Description |
|---------|-------------|
| **Continuous Monitoring** | Records all endpoint activity (processes, files, registry, network) |
| **Threat Detection** | Behavioral analysis, ML-based detection, signature matching |
| **Automated Response** | Auto-isolate endpoints, kill processes, quarantine files |
| **Investigation** | Timeline view of endpoint activity for forensic analysis |
| **Threat Intelligence** | Integration with IOC feeds for known threat detection |
| **Remediation** | Remote remediation — clean, restore, patch endpoints |

### EDR vs Traditional Antivirus

| Feature | Traditional AV | EDR |
|---------|---------------|-----|
| **Detection Method** | Signature-based (known threats) | Behavioral + signature + ML |
| **Unknown Threats** | ❌ Limited | ✅ Detects via behavior analysis |
| **Visibility** | Limited to file scanning | Full endpoint telemetry |
| **Response** | Block/quarantine files | Isolate endpoint, kill process, remediate |
| **Investigation** | Minimal | Full timeline and forensic capability |
| **Automation** | Basic | Advanced playbooks and automated response |
| **Fileless Malware** | ❌ Cannot detect | ✅ Detects via process monitoring |

### EDR Incident Lifecycle
```
Detection → Alert → Investigation → Containment → Remediation → Recovery → Lessons Learned
```

### EDR Privacy & Compliance Considerations
- EDR agents collect extensive endpoint data — must comply with privacy regulations
- Data collection scope should be documented and communicated
- Data retention policies must align with regulations (GDPR, HIPAA)
- Access to EDR data should be restricted to authorized personnel
- Regular audits of EDR data access and usage

### Popular EDR Solutions
- **CrowdStrike Falcon** — Cloud-native, lightweight agent
- **Microsoft Defender for Endpoint** — Integrated with Microsoft ecosystem
- **Carbon Black (VMware)** — Strong behavioral detection
- **SentinelOne** — AI-powered autonomous response
- **Cortex XDR (Palo Alto)** — Extended detection across endpoints and network

---

## 3. SOAR — Security Orchestration, Automation & Response

### What is SOAR?
SOAR platforms **automate security operations**, **orchestrate tools**, and **streamline incident response** through predefined playbooks and workflows.

### The Three Pillars of SOAR

| Pillar | Description |
|--------|-------------|
| **Orchestration** | Connects and coordinates multiple security tools (SIEM, EDR, firewall, threat intel) into unified workflows |
| **Automation** | Automates repetitive, manual tasks (IOC enrichment, alert triage, ticket creation) |
| **Response** | Provides standardized, consistent incident response through playbooks |

### SOAR Playbook Examples

#### Phishing Response Playbook
```
1. Alert received from email gateway
2. AUTO: Extract URLs, attachments, sender info
3. AUTO: Check IOCs against threat intel (VirusTotal, AbuseIPDB)
4. AUTO: If malicious → block sender domain at email gateway
5. AUTO: Search for same email across all mailboxes
6. AUTO: Delete malicious emails from all inboxes
7. MANUAL: Notify affected users
8. AUTO: Create incident ticket with all findings
9. AUTO: Update IOC blocklists
```

#### Malware Alert Playbook
```
1. EDR alert received
2. AUTO: Gather endpoint details (hostname, user, process)
3. AUTO: Check file hash against threat intel
4. AUTO: If confirmed malicious → isolate endpoint
5. AUTO: Collect forensic artifacts
6. MANUAL: Analyst reviews and approves remediation
7. AUTO: Clean malware, restore clean state
8. AUTO: Generate incident report
```

### SOAR Benefits
- **Reduces response time** — from hours to minutes
- **Consistency** — standardized responses via playbooks
- **Efficiency** — automates repetitive tasks (80% of alerts)
- **Scalability** — handle more alerts with same team size
- **Integration** — connects all security tools into one platform
- **Metrics** — tracks MTTD, MTTR, analyst efficiency

### Popular SOAR Solutions
- **Palo Alto Cortex XSOAR (Demisto)** — Market leader
- **Splunk Phantom** — Deep Splunk integration
- **Swimlane** — Low-code automation
- **IBM Resilient** — IBM QRadar integration
- **ServiceNow SecOps** — IT service management integration

---

## 4. Endpoint Security

### What is Endpoint Security?
The practice of **securing all endpoints** (laptops, desktops, mobile devices, servers) that connect to an organization's network from cybersecurity threats.

### Key Endpoint Security Components

| Component | Function |
|-----------|----------|
| **Antivirus/Anti-malware** | Detect and remove known malware |
| **EDR** | Advanced endpoint monitoring and response |
| **Host-based Firewall** | Control inbound/outbound traffic at host level |
| **DLP (Data Loss Prevention)** | Prevent unauthorized data transfers |
| **Encryption** | Full disk encryption (BitLocker, FileVault) |
| **Patch Management** | Keep OS and applications updated |
| **Application Control** | Whitelist/blacklist applications |
| **MDM (Mobile Device Management)** | Manage and secure mobile devices |

### BYOD (Bring Your Own Device) Policy
- Personal devices accessing corporate resources create security risks
- BYOD policies should define: acceptable use, security requirements, monitoring scope
- Solutions: MDM, containerization (separate work/personal data), VPN requirement
- Challenges: Privacy concerns, diverse device types, limited control

### Endpoint Non-Compliance Remediation
1. **Identify** non-compliant endpoints through automated scanning
2. **Notify** the user about compliance requirements
3. **Quarantine** the device from sensitive resources
4. **Remediate** — install updates, apply configurations
5. **Verify** compliance before restoring full access
6. **Document** and track compliance status

### APT (Advanced Persistent Threat) Defense at Endpoints
- Deploy EDR with behavioral analysis
- Implement application whitelisting
- Use micro-segmentation to limit lateral movement
- Monitor for fileless attack indicators
- Regular threat hunting on endpoints
- Employee awareness training (phishing is primary APT entry vector)

---

## 5. Microsoft Defender for Endpoint

### Key Features
| Feature | Description |
|---------|-------------|
| **Threat & Vulnerability Management** | Discover vulnerabilities and misconfigurations on endpoints |
| **Attack Surface Reduction (ASR)** | Rules to reduce the attack surface (block Office macros, script execution) |
| **Next-Gen Protection** | Cloud-delivered protection, behavioral analysis, ML-based detection |
| **EDR** | Real-time monitoring, investigation, automated response |
| **Auto Investigation & Remediation** | AI-powered automated investigation and remediation |
| **Threat Analytics** | Real-time threat intelligence and exposure assessment |
| **Microsoft Secure Score** | Security posture scoring and recommendations |

### Integration with Microsoft Ecosystem
- **Microsoft 365 Defender** — Unified security across endpoints, email, identity, apps
- **Microsoft Sentinel** — Cloud SIEM integration
- **Azure AD** — Identity-based threat detection
- **Intune** — Device compliance and MDM

---

## 6. Vulnerability Management

### What is Vulnerability Management?
A **continuous process** of identifying, classifying, prioritizing, remediating, and mitigating security vulnerabilities in systems and software.

### Vulnerability Management Lifecycle

```
Discover → Assess → Prioritize → Remediate → Verify → Report → (Repeat)
```

### Key Stages

| Stage | Description |
|-------|-------------|
| **Discovery/Inventory** | Identify all assets (hardware, software, cloud resources) |
| **Vulnerability Scanning** | Automated scanning using tools (Nessus, Qualys, Rapid7) |
| **Assessment** | Analyze scan results, validate findings, eliminate false positives |
| **Prioritization** | Rank vulnerabilities by CVSS score, exploitability, business impact |
| **Remediation** | Patch, reconfigure, or apply compensating controls |
| **Verification** | Re-scan to confirm vulnerability is resolved |
| **Reporting** | Generate reports for management, compliance, and tracking |

### CVSS (Common Vulnerability Scoring System)

| Score Range | Severity | Priority |
|-------------|----------|----------|
| 0.0 | None | Informational |
| 0.1–3.9 | Low | Schedule fix |
| 4.0–6.9 | Medium | Fix within 30 days |
| 7.0–8.9 | High | Fix within 7 days |
| 9.0–10.0 | Critical | Fix immediately |

### Vulnerability vs Patch Management
- **Vulnerability Management** = Identifying, assessing, and prioritizing vulnerabilities
- **Patch Management** = Applying fixes (patches) to address vulnerabilities
- Patch management is ONE remediation method within vulnerability management

### Common Vulnerability Scanning Tools
- **Nessus** (Tenable) — Industry standard, comprehensive scanning
- **Qualys** — Cloud-based, continuous monitoring
- **Rapid7 InsightVM** — Risk-based prioritization
- **OpenVAS** — Open-source vulnerability scanner
- **Microsoft Defender TVM** — Integrated with Defender for Endpoint

---

## 7. Threat Hunting

### What is Threat Hunting?
**Proactive** security activity where analysts actively search for threats that have **bypassed existing security controls**. Unlike monitoring (reactive), threat hunting is hypothesis-driven and assumes threats are already present.

### Threat Hunting vs Monitoring

| Aspect | Monitoring (Reactive) | Threat Hunting (Proactive) |
|--------|----------------------|---------------------------|
| **Approach** | Wait for alerts | Actively search for threats |
| **Assumption** | Tools will detect threats | Some threats bypass tools |
| **Trigger** | Alert-driven | Hypothesis-driven |
| **Role** | SOC Tier 1/2 | SOC Tier 3, specialized hunters |
| **Data** | Alert data | Full telemetry, logs, threat intel |

### Threat Hunting Process

```
1. Hypothesis Formation → 2. Data Collection → 3. Investigation → 4. Pattern Discovery → 5. Response/Remediation
```

#### Step 1: Hypothesis Formation
- Based on: threat intelligence, industry reports, MITRE ATT&CK, known TTPs
- Example: "Attackers may be using PowerShell for lateral movement in our environment"

#### Step 2: Data Collection
- Gather relevant data: SIEM logs, EDR telemetry, network traffic, DNS logs
- Focus on data related to the hypothesis

#### Step 3: Investigation
- Analyze collected data for anomalies, patterns, and IOCs
- Use statistical analysis, visualization, and correlation

#### Step 4: Pattern Discovery
- Identify confirmed threats, suspicious behaviors, or new IOCs
- Document findings and map to MITRE ATT&CK

#### Step 5: Response/Remediation
- If threat found: escalate to IR, contain and remediate
- If no threat: document hypothesis and results for future reference
- Update detection rules to catch similar activity automatically

### Threat Hunting Techniques

| Technique | Description |
|-----------|-------------|
| **IOC-based** | Search for known indicators (IPs, hashes, domains) |
| **TTP-based** | Search for behaviors mapped to MITRE ATT&CK |
| **Anomaly-based** | Look for deviations from normal baseline behavior |
| **Intelligence-driven** | Hunt based on specific threat intelligence reports |
| **Situational** | Hunt based on organizational events (merger, vulnerability disclosure) |

### Threat Hunting Tools
- **SIEM** (Splunk, Sentinel) — Query and analyze logs
- **EDR** (CrowdStrike, Defender) — Endpoint telemetry queries
- **YARA** — Create rules to identify malware samples
- **Sigma** — Generic signature format for SIEM rules
- **MITRE ATT&CK Navigator** — Visualize coverage gaps
- **Jupyter Notebooks** — Data analysis and visualization

---

## 8. Interview Questions & Answers

### Q1: What is the difference between SIEM and EDR?
**A:** SIEM collects and correlates LOGS from multiple sources across the entire infrastructure for centralized monitoring and alerting. EDR monitors ENDPOINT ACTIVITIES specifically (processes, files, registry, network connections) and provides automated response at the endpoint. SIEM gives you the big picture; EDR gives deep endpoint visibility. They complement each other — EDR feeds data into SIEM.

### Q2: What is SOAR and how does it differ from SIEM?
**A:** SIEM detects threats by correlating logs and generating alerts. SOAR automates the RESPONSE to those alerts through playbooks and workflows. SIEM tells you something happened; SOAR helps you respond faster. SOAR also orchestrates multiple security tools (SIEM, EDR, firewall, threat intel) into unified automated workflows.

### Q3: What are SIEM correlation rules?
**A:** Correlation rules are logic-based rules that connect multiple events to identify threats. Types include: threshold-based (10+ failed logins in 5 minutes), sequence-based (port scan followed by exploit), anomaly-based (unusual data transfer volume), and behavioral (admin login at unusual time from unusual location). Effective rules reduce false positives while catching real threats.

### Q4: What is the CVSS score and how do you use it?
**A:** CVSS (Common Vulnerability Scoring System) rates vulnerabilities on a scale of 0-10: Low (0.1-3.9), Medium (4.0-6.9), High (7.0-8.9), Critical (9.0-10.0). I use it for prioritization — critical vulnerabilities get remediated immediately, while lower scores are scheduled. However, CVSS alone isn't enough — I also consider exploitability, business impact, and asset criticality.

### Q5: Explain the difference between EDR and traditional antivirus.
**A:** Traditional AV uses signature-based detection (known threats only) and can only block/quarantine files. EDR uses behavioral analysis and ML to detect UNKNOWN threats including fileless malware, provides full endpoint telemetry for investigation, can isolate endpoints remotely, and offers automated response playbooks. EDR is the evolution of AV for modern threats.

### Q6: What is threat hunting and how does it differ from SOC monitoring?
**A:** SOC monitoring is REACTIVE — waiting for alerts from SIEM/EDR. Threat hunting is PROACTIVE — actively searching for threats that may have bypassed security controls. Hunting is hypothesis-driven, using MITRE ATT&CK and threat intelligence. Hunters analyze full telemetry data, not just alerts. It's typically done by Tier 3 analysts.

### Q7: What is the vulnerability management lifecycle?
**A:** Discover (asset inventory) → Scan (automated vulnerability scanning) → Assess (validate findings, eliminate false positives) → Prioritize (CVSS score + business impact) → Remediate (patch, reconfigure, or apply compensating controls) → Verify (re-scan to confirm fix) → Report (management and compliance reporting). It's a continuous cycle.

### Q8: What are SOAR playbooks?
**A:** Playbooks are predefined, automated workflows that define step-by-step responses to specific incident types. Example: Phishing playbook automatically extracts IOCs, checks threat intel, blocks malicious domains, searches for similar emails across the org, notifies affected users, and creates an incident ticket. They ensure consistent, fast response and reduce manual work.

### Q9: How do you prioritize vulnerabilities for remediation?
**A:** I use a risk-based approach: (1) CVSS score as a starting point, (2) Is there a known exploit in the wild? (3) Is the asset internet-facing or internal? (4) What's the business impact if compromised? (5) What data does the system process? (6) Are there compensating controls? Critical, internet-facing systems with known exploits get patched first.

### Q10: What is BYOD and what security challenges does it create?
**A:** BYOD (Bring Your Own Device) allows employees to use personal devices for work. Challenges: limited control over device security, diverse OS/device types, personal apps with vulnerabilities, data leakage risk, privacy concerns for monitoring. Solutions: MDM for policy enforcement, containerization to separate work/personal data, VPN requirement, network segmentation for BYOD devices.

---

## 9. Quick Reference Tables

### SIEM vs EDR vs SOAR

| Capability | SIEM | EDR | SOAR |
|-----------|------|-----|------|
| Log Collection | ✅ All sources | ✅ Endpoints only | ❌ |
| Correlation | ✅ Cross-source | ✅ Endpoint events | ❌ |
| Detection | ✅ Rule-based | ✅ Behavioral + ML | ❌ |
| Investigation | ✅ Log search | ✅ Endpoint forensics | ❌ |
| Automated Response | ⚠️ Limited | ✅ Endpoint actions | ✅ Full automation |
| Orchestration | ❌ | ❌ | ✅ Multi-tool |
| Playbooks | ❌ | ⚠️ Basic | ✅ Advanced |

### Vulnerability Severity & Response

| CVSS | Severity | Target Response Time |
|------|----------|---------------------|
| 9.0-10.0 | Critical | Immediate (24-48 hrs) |
| 7.0-8.9 | High | 7 days |
| 4.0-6.9 | Medium | 30 days |
| 0.1-3.9 | Low | 90 days |

### Threat Hunting Maturity Model

| Level | Description |
|-------|-------------|
| **Level 0** | No hunting — purely alert-driven |
| **Level 1** | Ad-hoc — occasional, unstructured hunting |
| **Level 2** | Procedural — following documented hunting procedures |
| **Level 3** | Innovative — creating custom analytics, hypothesis-driven |
| **Level 4** | Leading — automated hunting, ML-based, sharing intel with community |

---

## 10. Key Takeaways

1. ✅ **SIEM** = Central log collection + correlation + alerting (macro view)
2. ✅ **EDR** = Endpoint monitoring + behavioral detection + response (micro view)
3. ✅ **SOAR** = Automation + orchestration + playbooks (force multiplier)
4. ✅ EDR detects **fileless malware** and **unknown threats** that AV misses
5. ✅ **SOAR playbooks** reduce response time from hours to minutes
6. ✅ **Vulnerability Management** = Continuous cycle: Discover → Scan → Assess → Prioritize → Remediate → Verify
7. ✅ **CVSS** scores range 0-10; Critical (9-10) = patch immediately
8. ✅ **Threat Hunting** is PROACTIVE and HYPOTHESIS-driven (not waiting for alerts)
9. ✅ Map hunting to **MITRE ATT&CK** for structured coverage
10. ✅ **BYOD** requires MDM, containerization, VPN, and network segmentation

---

> 📌 **Previous:** [Part 6: SOC Analyst Interview Scenarios](./Study_Guide_Part6_SOC_Analyst_Interview_Scenarios.md)  
> 📌 **Next:** [Part 8: Cloud Security & Azure](./Study_Guide_Part8_Cloud_Security_Azure.md)
