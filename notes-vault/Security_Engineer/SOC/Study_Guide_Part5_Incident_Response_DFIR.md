---
title: "Study Guide Part5 Incident Response Dfir"
category: "Security Engineer"
tags: ["SOC"]
lastUpdated: "2026-06-05"
---

# 📘 Part 5: Incident Response & Digital Forensics (DFIR)

> **Comprehensive Interview Study Guide** — Based on real cybersecurity course transcripts  
> Covers: NIST SP 800-61 IR Lifecycle, DFIR 10-Step Process, IR Interview Q&A, Evidence Handling, Post-Incident Review

---

## Table of Contents

1. [What is Incident Response?](#1-what-is-incident-response)
2. [NIST SP 800-61 IR Lifecycle (4 Phases)](#2-nist-sp-800-61-ir-lifecycle-4-phases)
3. [DFIR — Digital Forensics & Incident Response (10 Steps)](#3-dfir--digital-forensics--incident-response-10-steps)
4. [Evidence Handling & Chain of Custody](#4-evidence-handling--chain-of-custody)
5. [IR Plan Development](#5-ir-plan-development)
6. [Interview Questions & Answers](#6-interview-questions--answers)
7. [Quick Reference Tables](#7-quick-reference-tables)
8. [Key Takeaways](#8-key-takeaways)

---

## 1. What is Incident Response?

**Incident Response (IR)** is the organized approach to addressing and managing the aftermath of a security breach or cyberattack. The goal is to:

- **Minimize damage** and reduce recovery time and costs
- **Contain the threat** to prevent further spread
- **Preserve evidence** for investigation and legal proceedings
- **Learn from incidents** to improve security posture
- **Comply with regulatory requirements** (GDPR, HIPAA, PCI-DSS)

### Security Event vs Security Incident

| Concept | Definition | Example |
|---------|-----------|---------|
| **Security Event** | Any observable occurrence in a system or network — can be routine or significant | User login, file access, failed login attempt |
| **Security Incident** | A security event that represents a REAL or POTENTIAL threat to CIA and requires investigation and response | Data breach, malware infection, unauthorized access, DDoS attack |

> **Key Point:** Not all security events are incidents. A failed login attempt is an event. Multiple failed login attempts from the same IP targeting multiple accounts is likely an incident.

---

## 2. NIST SP 800-61 IR Lifecycle (4 Phases)

### Phase 1: Preparation
**Purpose:** Establish IR capability before incidents occur

| Activity | Description |
|----------|-------------|
| **IR Team Formation** | Assemble a dedicated IR team with clear roles and responsibilities |
| **IR Plan Development** | Document procedures, escalation paths, communication protocols |
| **Tool Deployment** | Deploy SIEM, EDR, IDS/IPS, forensic tools |
| **Training & Exercises** | Conduct tabletop exercises, simulations, and regular training |
| **Communication Plans** | Define internal/external communication channels and stakeholders |
| **Documentation Templates** | Prepare incident report templates, runbooks, playbooks |
| **Baseline Establishment** | Document normal system behavior for anomaly detection |

### Phase 2: Detection & Analysis
**Purpose:** Identify and validate security incidents

| Activity | Description |
|----------|-------------|
| **Monitoring** | Continuous monitoring via SIEM, EDR, IDS/IPS, log analysis |
| **Alert Triage** | Classify alerts by severity (Critical/High/Medium/Low) |
| **Incident Validation** | Confirm whether the alert is a true positive or false positive |
| **Impact Assessment** | Determine scope, affected systems, data at risk |
| **Categorization** | Classify incident type (malware, phishing, unauthorized access, etc.) |
| **Prioritization** | Prioritize based on impact, urgency, and affected assets |
| **IOC Identification** | Identify Indicators of Compromise (file hashes, IPs, domains) |
| **Documentation** | Begin documenting timeline, findings, and evidence |

### Phase 3: Containment, Eradication & Recovery
**Purpose:** Stop the spread, remove the threat, and restore operations

#### Containment
| Strategy | Description |
|----------|-------------|
| **Short-term Containment** | Immediate actions to stop the spread (isolate systems, block IPs, disable accounts) |
| **Long-term Containment** | Implement temporary fixes while preparing for full eradication (patch systems, add monitoring) |
| **Evidence Preservation** | Capture forensic images, memory dumps, and logs BEFORE making changes |

#### Eradication
| Activity | Description |
|----------|-------------|
| **Root Cause Analysis** | Identify and eliminate the root cause of the incident |
| **Malware Removal** | Remove all malicious code, backdoors, and artifacts |
| **Vulnerability Remediation** | Patch vulnerabilities that were exploited |
| **Account Remediation** | Reset compromised credentials, review access permissions |
| **System Hardening** | Apply security configurations to prevent recurrence |

#### Recovery
| Activity | Description |
|----------|-------------|
| **System Restoration** | Restore from clean backups or rebuild compromised systems |
| **Validation** | Verify systems are clean and functioning normally |
| **Monitoring** | Enhanced monitoring for signs of re-infection or lingering threats |
| **Phased Return** | Gradually bring systems back online with careful observation |

### Phase 4: Post-Incident Activity (Lessons Learned)
**Purpose:** Learn from the incident and improve

| Activity | Description |
|----------|-------------|
| **Post-Incident Review** | Conduct a formal review meeting with all stakeholders |
| **Root Cause Documentation** | Document the root cause, attack vector, and timeline |
| **Gap Analysis** | Identify what worked, what didn't, and what needs improvement |
| **Policy/Procedure Updates** | Update IR plans, runbooks, and security policies |
| **Training Updates** | Incorporate lessons into training programs |
| **Metrics & Reporting** | Track MTTD (Mean Time to Detect), MTTR (Mean Time to Respond) |
| **Evidence Retention** | Retain evidence per legal and regulatory requirements |

---

## 3. DFIR — Digital Forensics & Incident Response (10 Steps)

### The 10-Step DFIR Process

#### Step 1: Preparation
- Have IR team, tools, and procedures ready BEFORE an incident
- Deploy forensic workstations, chain of custody forms, evidence bags
- Conduct regular training and tabletop exercises

#### Step 2: Identification
- Detect and identify the security incident
- Sources: SIEM alerts, IDS/IPS, user reports, threat intelligence feeds
- Determine: What happened? When? Where? Who is affected?

#### Step 3: Containment
- Stop the incident from spreading
- Short-term: Isolate affected systems, block malicious IPs/domains
- Long-term: Apply temporary patches, increase monitoring
- **Critical:** Preserve evidence BEFORE containment actions

#### Step 4: Evidence Collection
- Collect volatile data FIRST (memory, running processes, network connections)
- Then collect non-volatile data (hard drive images, log files)
- Follow **order of volatility**: Registers → Cache → RAM → Disk → Logs → Archives
- Use write-blockers for disk imaging
- Calculate and verify hashes (SHA-256) for integrity

#### Step 5: Evidence Preservation
- Maintain **chain of custody** — document who handled evidence, when, and why
- Store evidence in secure, tamper-proof locations
- Create forensic copies — NEVER work on original evidence
- Document storage conditions, access logs

#### Step 6: Analysis
- Analyze collected evidence to reconstruct the incident
- **Timeline Analysis** — Build chronological timeline of events
- **Malware Analysis** — Static and dynamic analysis of malicious code
- **Log Analysis** — Correlate logs from multiple sources
- **Memory Analysis** — Examine RAM for processes, network connections, injected code
- **File System Analysis** — Examine file modifications, deletions, hidden files

#### Step 7: Eradication
- Remove the root cause and all traces of the threat
- Remove malware, backdoors, unauthorized accounts
- Patch exploited vulnerabilities
- Reset compromised credentials

#### Step 8: Recovery
- Restore affected systems to normal operation
- Rebuild from clean backups if necessary
- Validate system integrity before reconnecting
- Implement enhanced monitoring

#### Step 9: Reporting
- Create comprehensive incident report documenting:
  - Incident summary and timeline
  - Affected systems and data
  - Root cause analysis
  - Actions taken
  - Evidence collected
  - Recommendations for improvement
- Reports for: management, legal, compliance, law enforcement (if applicable)

#### Step 10: Lessons Learned
- Conduct post-incident review meeting
- Document what worked well and what needs improvement
- Update IR plans, procedures, and playbooks
- Incorporate findings into security training
- Implement recommended security improvements
- Track metrics (MTTD, MTTR, number of incidents)

---

## 4. Evidence Handling & Chain of Custody

### Order of Volatility (Collect First → Last)

| Priority | Evidence Type | Volatility |
|----------|--------------|------------|
| 1 | CPU Registers, Cache | Most volatile |
| 2 | RAM (Memory) | Very volatile |
| 3 | Running Processes, Network Connections | Volatile |
| 4 | Hard Drive / Disk Images | Less volatile |
| 5 | Log Files (local) | Less volatile |
| 6 | Archived Data, Backups | Least volatile |

### Chain of Custody Requirements
- **Who** collected the evidence
- **When** it was collected (date/time)
- **Where** it was stored
- **How** it was transported
- **Who** had access to it at each point
- **What** was done with it (analysis, copying)

### Evidence Integrity
- Always calculate **cryptographic hashes** (SHA-256) of evidence
- Hash BEFORE and AFTER collection to prove no tampering
- Use **write-blockers** when imaging disks
- Work on **forensic copies**, never originals
- Document EVERYTHING

---

## 5. IR Plan Development

### Essential Components of an IR Plan

| Component | Description |
|-----------|-------------|
| **Purpose & Scope** | Define what constitutes an incident and what's covered |
| **Roles & Responsibilities** | IR team members, management, legal, HR, communications |
| **Incident Classification** | Severity levels (Critical/High/Medium/Low) and categories |
| **Escalation Procedures** | When and to whom incidents should be escalated |
| **Communication Plan** | Internal and external communication protocols |
| **Response Procedures** | Step-by-step procedures for different incident types |
| **Evidence Handling** | Collection, preservation, and chain of custody procedures |
| **Recovery Procedures** | System restoration and business continuity |
| **Reporting Requirements** | Regulatory reporting timelines and stakeholders |
| **Review & Update Schedule** | Regular review and improvement cycle |

### IR Team Roles

| Role | Responsibility |
|------|---------------|
| **IR Manager/Lead** | Oversees the entire response process, coordinates team |
| **SOC Analyst** | Monitors, detects, and performs initial triage |
| **Forensic Analyst** | Collects and analyzes digital evidence |
| **Threat Intelligence** | Provides context about threat actors and TTPs |
| **Communications** | Manages internal/external communications |
| **Legal Counsel** | Advises on legal obligations, evidence admissibility |
| **Management** | Makes business decisions, authorizes containment actions |

---

## 6. Interview Questions & Answers

### Q1: What is the NIST Incident Response lifecycle?
**A:** NIST SP 800-61 defines 4 phases: (1) Preparation — establish IR team, tools, plans; (2) Detection & Analysis — monitor, detect, validate, and assess incidents; (3) Containment, Eradication & Recovery — contain the spread, remove the threat, restore systems; (4) Post-Incident Activity — lessons learned, update plans, improve. It's a cyclical process — lessons feed back into preparation.

### Q2: What is the difference between a security event and a security incident?
**A:** A security event is any observable occurrence in a system — it could be routine (user login) or significant (failed login). A security incident is a specific type of event that represents a real or potential threat to confidentiality, integrity, or availability and requires investigation and response (data breach, malware infection). Not all events are incidents, but all incidents are events.

### Q3: What is the order of volatility and why does it matter?
**A:** The order of volatility determines which evidence to collect first based on how quickly it disappears: CPU registers/cache (most volatile) → RAM/memory → running processes/network connections → disk data → log files → archives (least volatile). It matters because volatile data (like memory) is lost when a system is powered off, so we must capture it first.

### Q4: What is chain of custody?
**A:** Chain of custody is the documented chronological record of who handled evidence, when, and for what purpose. It ensures evidence integrity and admissibility in legal proceedings. It tracks: who collected it, when and where, how it was stored/transported, and who accessed it. Breaking the chain can make evidence inadmissible in court.

### Q5: How would you handle a ransomware incident?
**A:** (1) Immediately isolate affected systems to prevent spread. (2) Preserve evidence — capture forensic images before remediation. (3) Identify the ransomware variant and check for known decryptors. (4) Assess impact — what systems and data are affected? (5) Do NOT pay the ransom — notify law enforcement. (6) Restore from clean backups after verifying they're uninfected. (7) Patch the vulnerability that allowed initial access. (8) Conduct lessons learned review. (9) Update security controls and training.

### Q6: What is the purpose of the post-incident review?
**A:** To learn from the incident and improve future response. We review: what happened (root cause and timeline), what worked well, what failed, and what needs improvement. The outcomes include updated IR plans, improved security controls, new training material, and metrics tracking (MTTD/MTTR). It's critical for continuous improvement.

### Q7: What tools do you use in incident response?
**A:** SIEM (Splunk, QRadar) for log correlation and alerting; EDR (CrowdStrike, Defender for Endpoint) for endpoint detection; Network analysis tools (Wireshark, Zeek) for traffic analysis; Forensic tools (FTK, Autopsy, Volatility) for evidence analysis; Threat intelligence platforms for IOC lookups; Ticketing systems for incident tracking.

### Q8: What are IOCs (Indicators of Compromise)?
**A:** IOCs are artifacts or evidence that indicate a system has been compromised. Examples include: malicious IP addresses, suspicious domains, file hashes of known malware, unusual registry modifications, unexpected network connections, suspicious user behavior, and unauthorized file changes. IOCs are used for detection, threat hunting, and sharing threat intelligence.

### Q9: Explain the difference between containment and eradication.
**A:** Containment stops the incident from spreading (isolating systems, blocking IPs, disabling accounts) — it's about limiting damage NOW. Eradication removes the root cause and all traces of the threat (removing malware, patching vulnerabilities, resetting credentials). Containment is immediate; eradication is thorough. Containment happens before eradication.

### Q10: What metrics would you track for IR effectiveness?
**A:** Key metrics include: MTTD (Mean Time to Detect) — how quickly we identify incidents; MTTR (Mean Time to Respond/Resolve) — how quickly we contain and resolve; number of incidents by type/severity; false positive rate; number of incidents requiring escalation; cost per incident; recurrence rate; and compliance with SLAs.

---

## 7. Quick Reference Tables

### NIST IR Lifecycle Summary

| Phase | Purpose | Key Activities |
|-------|---------|---------------|
| Preparation | Build capability | Team, tools, plans, training |
| Detection & Analysis | Find & validate | Monitor, triage, assess, document |
| Containment/Eradication/Recovery | Stop, remove, restore | Isolate, remove threat, rebuild |
| Post-Incident | Learn & improve | Review, update, train, metrics |

### DFIR 10 Steps

| Step | Action | Key Concern |
|------|--------|-------------|
| 1. Preparation | Ready team & tools | Before incident occurs |
| 2. Identification | Detect incident | Alert sources, validation |
| 3. Containment | Stop the spread | Preserve evidence first |
| 4. Evidence Collection | Gather evidence | Order of volatility |
| 5. Evidence Preservation | Maintain integrity | Chain of custody |
| 6. Analysis | Investigate | Timeline, malware, logs |
| 7. Eradication | Remove threat | Root cause, patches |
| 8. Recovery | Restore operations | Clean backups, validation |
| 9. Reporting | Document findings | Stakeholder reports |
| 10. Lessons Learned | Improve | Update plans, training |

### IR Severity Levels

| Level | Description | Response Time | Example |
|-------|-------------|--------------|---------|
| **Critical** | Immediate threat to business operations | Immediate (< 1 hour) | Active ransomware, data breach |
| **High** | Significant risk, potential for major impact | < 4 hours | Compromised admin account |
| **Medium** | Moderate risk, limited impact | < 24 hours | Malware on single endpoint |
| **Low** | Minimal risk, no immediate threat | < 72 hours | Phishing attempt (no click) |

---

## 8. Key Takeaways

1. ✅ **NIST IR = 4 phases:** Preparation → Detection & Analysis → Containment/Eradication/Recovery → Lessons Learned
2. ✅ **DFIR = 10 steps:** Prep → ID → Contain → Collect → Preserve → Analyze → Eradicate → Recover → Report → Lessons
3. ✅ **Security event ≠ Security incident** — incidents require investigation and response
4. ✅ **Order of volatility:** Collect most volatile evidence FIRST (registers → RAM → disk → logs)
5. ✅ **Chain of custody** ensures evidence integrity and legal admissibility
6. ✅ **NEVER work on original evidence** — always use forensic copies
7. ✅ **Containment before eradication** — stop the spread, then remove the threat
8. ✅ **Post-incident review** is CRITICAL — drives continuous improvement
9. ✅ Track **MTTD and MTTR** as key IR effectiveness metrics
10. ✅ **Preparation is the most important phase** — you can't respond effectively without it

---

> 📌 **Previous:** [Part 4: Security Frameworks & Models](./Study_Guide_Part4_Security_Frameworks_Models.md)  
> 📌 **Next:** [Part 6: SOC Analyst Interview Scenarios](./Study_Guide_Part6_SOC_Analyst_Interview_Scenarios.md)
