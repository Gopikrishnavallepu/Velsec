---
title: "Study Guide Part4 Security Frameworks Models"
category: "Security Engineer"
tags: ["SOC"]
lastUpdated: "2026-06-05"
---

# 📘 Part 4: Security Frameworks & Models

> **Comprehensive Interview Study Guide** — Based on real cybersecurity course transcripts  
> Covers: Cyber Kill Chain, MITRE ATT&CK, NIST RMF, Access Control Models (DAC/MAC/RBAC/ABAC), Access Control Types

---

## Table of Contents

1. [Cyber Kill Chain](#1-cyber-kill-chain)
2. [MITRE ATT&CK Framework](#2-mitre-attck-framework)
3. [NIST Risk Management Framework (RMF)](#3-nist-risk-management-framework-rmf)
4. [Access Control Models](#4-access-control-models)
5. [Access Control Types](#5-access-control-types)
6. [Interview Questions & Answers](#6-interview-questions--answers)
7. [Quick Reference Tables](#7-quick-reference-tables)
8. [Key Takeaways](#8-key-takeaways)

---

## 1. Cyber Kill Chain

### What is the Cyber Kill Chain?
A framework developed by **Lockheed Martin** that describes the **7 stages of a cyberattack**. Understanding each stage helps defenders detect and disrupt attacks at any point.

### The 7 Phases

#### Phase 1: Reconnaissance
- **What:** Attacker gathers information about the target
- **Techniques:** OSINT (social media, websites, WHOIS), network scanning, Google dorking, social engineering
- **Types:** Passive (no direct contact) and Active (probing systems directly)
- **Defense:** Limit public exposure of information, monitor for scanning activity, employee awareness training

#### Phase 2: Weaponization
- **What:** Attacker creates a weaponized deliverable (malware, exploit)
- **Techniques:** Creating malicious documents, developing custom malware, crafting phishing emails with payloads
- **Defense:** Threat intelligence sharing, malware analysis capability, signature-based detection

#### Phase 3: Delivery
- **What:** Transmitting the weapon to the target
- **Methods:** Phishing emails (most common), malicious websites, USB drops, compromised software updates, watering hole attacks
- **Defense:** Email filtering, web proxies, endpoint protection, user awareness training

#### Phase 4: Exploitation
- **What:** Exploiting a vulnerability to execute malicious code
- **Targets:** Software vulnerabilities, zero-days, human error (clicking links)
- **Defense:** Patch management, application whitelisting, exploit prevention (DEP, ASLR), IDS/IPS

#### Phase 5: Installation
- **What:** Installing malware/backdoor on the victim's system
- **Activities:** Installing persistent backdoors, rootkits, RATs, creating scheduled tasks
- **Defense:** Endpoint detection (EDR), application whitelisting, file integrity monitoring, host-based IDS

#### Phase 6: Command & Control (C2)
- **What:** Establishing communication channel between malware and attacker
- **Methods:** HTTP/HTTPS beaconing, DNS tunneling, encrypted channels, social media C2
- **Defense:** Network monitoring, DNS filtering, egress filtering, proxy inspection, threat intelligence feeds

#### Phase 7: Actions on Objectives
- **What:** Attacker achieves their goal
- **Activities:** Data exfiltration, data destruction, ransomware deployment, lateral movement, privilege escalation, espionage
- **Defense:** DLP (Data Loss Prevention), network segmentation, user behavior analytics, incident response

### Cyber Kill Chain Summary

```
Reconnaissance → Weaponization → Delivery → Exploitation → Installation → C2 → Actions on Objectives
     ↑                                                                              ↑
  EARLY DETECTION                                                           LAST CHANCE TO STOP
```

> **Key Insight:** The earlier you detect and disrupt the kill chain, the less damage occurs. Each phase offers an opportunity for defense.

---

## 2. MITRE ATT&CK Framework

### What is MITRE ATT&CK?
A globally accessible **knowledge base of adversary tactics, techniques, and procedures (TTPs)** based on real-world observations. ATT&CK stands for **Adversarial Tactics, Techniques, and Common Knowledge**.

### Structure
- **Tactics** — The "WHY" (adversary's goal) — 14 tactical categories
- **Techniques** — The "HOW" (methods to achieve the goal)
- **Sub-Techniques** — More specific methods under each technique
- **Procedures** — Specific implementation details by threat groups

### The 14 Tactics (Enterprise Matrix)

| # | Tactic | Description |
|---|--------|-------------|
| 1 | **Reconnaissance** | Gather information for planning operations |
| 2 | **Resource Development** | Establish resources for operations (infrastructure, accounts) |
| 3 | **Initial Access** | Gain entry to the target network |
| 4 | **Execution** | Run malicious code on the target system |
| 5 | **Persistence** | Maintain foothold across restarts/credential changes |
| 6 | **Privilege Escalation** | Gain higher-level permissions |
| 7 | **Defense Evasion** | Avoid detection by security controls |
| 8 | **Credential Access** | Steal account credentials |
| 9 | **Discovery** | Understand the target environment |
| 10 | **Lateral Movement** | Move through the network to reach objectives |
| 11 | **Collection** | Gather data of interest |
| 12 | **Command and Control** | Establish communication with compromised systems |
| 13 | **Exfiltration** | Steal data from the target network |
| 14 | **Impact** | Disrupt availability or compromise integrity |

### How MITRE ATT&CK is Used

| Use Case | Description |
|----------|-------------|
| **Threat Intelligence** | Map observed attack behaviors to known techniques |
| **Detection Engineering** | Create detection rules based on known techniques |
| **Security Assessment** | Evaluate security coverage against the framework |
| **Red Teaming** | Simulate real-world attacks using documented techniques |
| **Incident Response** | Classify and understand attack patterns during incidents |
| **Security Gap Analysis** | Identify which techniques your defenses don't cover |

### Kill Chain vs MITRE ATT&CK

| Aspect | Cyber Kill Chain | MITRE ATT&CK |
|--------|-----------------|---------------|
| **Creator** | Lockheed Martin | MITRE Corporation |
| **Approach** | Linear, sequential phases | Non-linear matrix of tactics/techniques |
| **Focus** | Attack lifecycle (macro view) | Detailed adversary behaviors (micro view) |
| **Granularity** | 7 phases | 14 tactics, 200+ techniques, 400+ sub-techniques |
| **Best For** | Understanding attack flow | Detailed threat hunting & detection |

---

## 3. NIST Risk Management Framework (RMF)

### What is NIST RMF?
A **systematic, structured approach** developed by the National Institute of Standards and Technology (NIST) to help organizations **manage and mitigate cybersecurity risks**. Linked to NIST SP 800-53 (security controls) and FISMA (Federal Information Security Modernization Act).

### Key Characteristics
- **Comprehensive** — Covers all aspects of risk management
- **Flexible** — Adaptable to different organization types and sizes
- **Repeatable** — Cyclical process for continuous assessment
- **Measurable** — Incorporates metrics to evaluate effectiveness

### The 7 Steps of NIST RMF

#### Step 1: PREPARE
- **Purpose:** Set foundation for effective risk management
- **Activities:**
  - Establish organizational context (mission, objectives, priorities)
  - Develop risk management strategy and risk tolerance
  - Assign roles and responsibilities
  - Create communication and training plans
  - Establish risk executive function
  - Develop policies, procedures, and risk register
- **Outcomes:** Management roles identified, risk strategy established, continuous monitoring strategy developed

#### Step 2: CATEGORIZE
- **Purpose:** Classify information systems and determine adverse impact
- **Activities:**
  - System identification and boundary definition
  - Data classification (sensitivity levels)
  - Impact level determination (Low, Moderate, High) for CIA
  - Assign security categories
  - Tailor security controls from NIST SP 800-53
- **Outcomes:** System documented, security categorization completed, approved by authorizing official

#### Step 3: SELECT
- **Purpose:** Choose, tailor, and document security controls
- **Activities:**
  - Establish security control baseline from NIST SP 800-53
  - Tailor controls to specific system needs
  - Identify supplemental controls for unique risks
  - Consider continuous monitoring requirements
  - Align with organizational policies and regulations
- **Outcomes:** Control baselines selected/tailored, continuous monitoring strategy developed

#### Step 4: IMPLEMENT
- **Purpose:** Integrate selected controls into the system
- **Activities:**
  - Integrate controls into system architecture/design
  - Configuration management (secure baseline)
  - Security control documentation
  - Security training and awareness
  - Security testing (vulnerability assessments, pen testing)
  - Set up continuous monitoring capabilities
- **Outcomes:** Controls implemented, security plans updated

#### Step 5: ASSESS
- **Purpose:** Evaluate effectiveness of implemented controls
- **Activities:**
  - Security Control Assessment (SCA) — verify controls work correctly
  - Independent verification and validation (third-party assessment)
  - Continuous monitoring initiation
  - Assess residual risks
  - Review documentation accuracy
  - Generate assessment reports
- **Outcomes:** Assessment reports developed, remediation actions taken, plan of action and milestones created

#### Step 6: AUTHORIZE
- **Purpose:** Senior official makes risk-based decision to operate the system
- **Activities:**
  - Authorizing official evaluates assessment reports and residual risks
  - May impose conditions for authorization
  - Compile authorization package (reports, risk assessments, conditions)
  - Grant or deny Authorization to Operate (ATO)
  - Document decision and communicate to stakeholders
- **Outcomes:** Authorization package compiled, ATO granted/denied, risk responses provided

#### Step 7: MONITOR
- **Purpose:** Continuously monitor security posture (ongoing/iterative)
- **Activities:**
  - Real-time monitoring of security controls and events
  - Incident detection and response
  - Security control effectiveness measurement
  - Configuration management and tracking changes
  - Vulnerability management (scanning, patching)
  - Security awareness training (ongoing)
  - Audit trails and compliance reporting
  - Feedback loop back to other RMF steps
- **Outcomes:** Ongoing control assessments, continuous monitoring, periodic reauthorization

### NIST RMF Visual Flow
```
PREPARE → CATEGORIZE → SELECT → IMPLEMENT → ASSESS → AUTHORIZE → MONITOR
                                                                    ↓
                                                              (Cycle back)
```

---

## 4. Access Control Models

### What is Access Control?
A security mechanism that determines **who can access a specific resource** and **what actions they can perform** on that resource.

### Two Main Categories

### DAC (Discretionary Access Control)
- **The owner/creator decides** who can access the resource
- Uses **Access Control Lists (ACLs)** on objects
- **Decentralized** — owners can change ACLs anytime
- **Identity-based** — relies on the identity of the resource owner

| Pros | Cons |
|------|------|
| ✅ Flexible | ❌ Security risk (owner may grant inappropriate access) |
| ✅ Fine-grained control | ❌ No centralized control |
| ✅ Simple to implement | ❌ Challenging in large organizations |
| ✅ Cost effective | ❌ Difficult to track permissions |

### Non-DAC (Non-Discretionary) Access Control
- Access is **centrally managed** by policies and rules
- NOT at the discretion of the resource owner

| Pros | Cons |
|------|------|
| ✅ Better security (predefined policies) | ❌ Less flexible |
| ✅ Consistent access control | ❌ Complex to implement |
| ✅ Easier to manage at scale | ❌ Requires centralized authority |
| ✅ More scalable | ❌ Challenging in large organizations |

### Non-DAC Models in Detail

#### RBAC (Role-Based Access Control)
- Access based on **user's role/job function**
- Users assigned to **groups** → permissions assigned to groups
- **Example:** Hospital — Doctor group (view+edit records), Nurse group (view only), Admin group (financial data only)
- Enforces **least privilege**
- Prevents **privilege creep** (accumulation of unnecessary access over time)
- **T-BAC** (Task-Based) is similar but based on assigned tasks

#### Rule-Based Access Control
- Access based on **predefined global rules** applied to ALL subjects
- Rules defined by system admin
- **Example:** Firewall rules — allow only HTTP traffic, block specific IPs
- Rules are universal, not user-specific

#### ABAC (Attribute-Based Access Control)
- **Advanced version** of rule-based access control
- Access based on **specific attributes** (location, time, device, user characteristics)
- More **fine-grained** than rule-based
- **Example:** Allow access to File1 only for users in the US location, or only from company laptops
- Used in Software-Defined Networking (SDN)

#### MAC (Mandatory Access Control)
- Access based on **classification labels** (security clearance levels)
- Used in **high-security environments** (government, military)
- Also called **Lattice Model**
- Labels: Top Secret > Secret > Confidential

##### MAC Sub-Types:

| Model | Description | Example |
|-------|-------------|---------|
| **Hierarchical** | Higher clearance grants access to own level + ALL lower levels | Top Secret clearance → access TS + Secret + Confidential |
| **Compartmentalized** | Enforces **need-to-know**; each compartment is isolated; no access to other levels | Top Secret clearance → access ONLY the specific TS files needed for your job |
| **Hybrid** | Combination of hierarchical and compartmentalized | Elements of both models |

#### Risk-Based Access Control
- Uses **real-time intelligence** to make access decisions
- Factors analyzed: device (known/unknown), location, network (familiar IP), resource sensitivity
- Outcome: Normal login, additional MFA required, or device registration

### Access Control Models Summary

| Model | Basis | Control By | Example |
|-------|-------|-----------|---------|
| **DAC** | Owner's discretion | Resource owner | File permissions on Windows |
| **RBAC** | User role | Central admin | Hospital role-based access |
| **Rule-Based** | Global rules | System admin | Firewall rules |
| **ABAC** | User/resource attributes | Policy engine | Location-based access |
| **MAC** | Security labels | Central authority | Military classification |
| **Risk-Based** | Real-time context | Automated analysis | Adaptive MFA |

---

## 5. Access Control Types

### By Implementation Method

| Type | Description | Examples |
|------|-------------|---------|
| **Administrative** | Policies, procedures, and managerial controls | Access policies, password policies, user account management, RBAC implementation, security training, auditing |
| **Technical/Logical** | Software/hardware-based controls | Authentication (password, MFA, biometric), ACLs, encryption, firewalls, IDS/IPS, VPN, SIEM |
| **Physical** | Physical security measures | Barriers (fences, gates, turnstiles), locks & keys, access cards/badges, biometric systems, surveillance cameras, security guards, man traps, alarm systems |

### By Function

| Type | Purpose | Examples |
|------|---------|---------|
| **Preventive** | Proactively prevent unauthorized access | Fences, firewalls, access controls, AV, security training, separation of duties, data classification |
| **Detective** | Detect unauthorized access after it occurs | Security logging/auditing, SIEM, IDS, cameras, UBA (User Behavior Analysis), honeypots, security audits |
| **Corrective** | Mitigate impact and restore after a breach | Incident response plan, access revocation, system patches, password reset, system restoration, forensics |
| **Deterrent** | Discourage unauthorized access attempts | Warning signs, visible cameras, security guards, lighting, alarm systems, security patrols |
| **Recovery** | Restore normal operations after an incident | IR plan execution, system restoration from backups, patch management, system hardening, lessons learned |
| **Directive** | Direct subjects to comply with security policies | Exit signs, notifications, security policy requirements |
| **Compensating** | Supplementary controls when primary controls aren't sufficient | MFA (when passwords alone aren't enough), VPN, data encryption, SIEM, network segmentation, redundancy |

> **Key Insight:** Controls can belong to MULTIPLE categories. Example: Security guards are preventive AND detective AND deterrent. Job rotation is preventive AND detective.

---

## 6. Interview Questions & Answers

### Q1: What is the Cyber Kill Chain?
**A:** The Cyber Kill Chain, developed by Lockheed Martin, describes 7 stages of a cyberattack: Reconnaissance (gathering intel), Weaponization (creating malware), Delivery (transmitting to target via phishing/USB), Exploitation (executing the exploit), Installation (installing backdoor), Command & Control (establishing communication), and Actions on Objectives (achieving the goal — data theft, ransomware). The key concept is that disrupting any stage breaks the chain.

### Q2: How does MITRE ATT&CK differ from the Cyber Kill Chain?
**A:** The Kill Chain is a linear, sequential model (7 phases) showing the high-level attack lifecycle — it's great for understanding attack flow. MITRE ATT&CK is a non-linear, detailed matrix with 14 tactics and 200+ techniques based on real-world observations — it's better for threat hunting, detection engineering, and assessing security coverage. They complement each other: Kill Chain for macro understanding, ATT&CK for micro-level detail.

### Q3: Explain the NIST RMF steps.
**A:** NIST RMF has 7 steps: (1) Prepare — establish context, risk strategy; (2) Categorize — classify systems and data by impact level; (3) Select — choose security controls from NIST SP 800-53; (4) Implement — integrate controls into system design; (5) Assess — evaluate control effectiveness; (6) Authorize — senior official grants Authorization to Operate; (7) Monitor — continuous monitoring and periodic reauthorization. It's a cyclical process.

### Q4: What is the difference between DAC and MAC?
**A:** DAC (Discretionary Access Control) — the resource OWNER decides who gets access. It's flexible but decentralized with security risks. MAC (Mandatory Access Control) — access is based on security clearance LABELS controlled by a central authority. It's more secure but rigid. DAC is used in general environments; MAC is used in high-security environments like military (Top Secret/Secret/Confidential levels).

### Q5: Explain RBAC and why it prevents privilege creep.
**A:** RBAC assigns permissions to ROLES (groups), not individual users. When users change roles, they're moved to a new group — automatically gaining appropriate permissions and losing old ones. This prevents privilege creep (accumulation of unnecessary permissions over time). Example: Moving from Customer Service to Finance — remove from CS group, add to Finance group.

### Q6: What is the difference between preventive and detective access controls?
**A:** Preventive controls proactively PREVENT unauthorized access (firewalls, fences, encryption, security training). Detective controls DETECT unauthorized access after it occurs (SIEM, IDS, security auditing, cameras, honeypots). Both are needed: preventive controls reduce incidents, detective controls catch what slips through.

### Q7: What are compensating controls?
**A:** Compensating controls are supplementary security measures implemented when primary controls are insufficient, impractical, or not feasible. Examples: MFA when password policies alone aren't strong enough, VPN for secure remote access, data encryption when storage systems have vulnerabilities, SIEM for enhanced monitoring. They compensate for gaps in primary controls.

### Q8: What is ABAC and how does it differ from RBAC?
**A:** RBAC assigns access based on user's ROLE (group membership). ABAC is more granular — it considers multiple ATTRIBUTES like location, time, device type, clearance level. Example: "Allow access only from company laptops in the US during business hours." ABAC provides finer-grained access control but is more complex to manage.

---

## 7. Quick Reference Tables

### Cyber Kill Chain at a Glance

| Phase | Activity | Defense |
|-------|----------|---------|
| Reconnaissance | Information gathering | Limit exposure, monitor scanning |
| Weaponization | Create malware | Threat intelligence |
| Delivery | Send to target | Email filtering, user training |
| Exploitation | Execute exploit | Patching, IDS/IPS |
| Installation | Install backdoor | EDR, whitelisting |
| C2 | Establish comms | DNS filtering, egress monitoring |
| Actions | Achieve objective | DLP, segmentation, IR |

### NIST RMF 7 Steps

| Step | Action | Key Outcome |
|------|--------|-------------|
| Prepare | Establish context & strategy | Risk strategy, roles defined |
| Categorize | Classify systems & data | Security categories assigned |
| Select | Choose controls | Control baseline tailored |
| Implement | Deploy controls | Controls integrated into systems |
| Assess | Evaluate effectiveness | Assessment reports, remediation |
| Authorize | Risk-based decision | ATO granted/denied |
| Monitor | Continuous monitoring | Ongoing assessment & feedback |

### Access Control Models Comparison

| Model | Who Decides? | Basis | Flexibility | Security |
|-------|-------------|-------|-------------|----------|
| DAC | Resource owner | Identity | High | Lower |
| RBAC | Central admin | Role | Moderate | Moderate |
| ABAC | Policy engine | Attributes | High | High |
| MAC | Central authority | Labels | Low | Highest |
| Rule-Based | System admin | Global rules | Low | Moderate |
| Risk-Based | Automated | Real-time context | Dynamic | High |

---

## 8. Key Takeaways

1. ✅ **Cyber Kill Chain** = 7 phases (Recon → Weaponize → Deliver → Exploit → Install → C2 → Actions)
2. ✅ **MITRE ATT&CK** = 14 tactics, 200+ techniques — detailed adversary behavior knowledge base
3. ✅ Kill Chain = **macro/linear** | ATT&CK = **micro/non-linear** — they complement each other
4. ✅ **NIST RMF** = 7 steps (Prepare → Categorize → Select → Implement → Assess → Authorize → Monitor)
5. ✅ **DAC** = owner decides | **MAC** = labels/clearance | **RBAC** = roles | **ABAC** = attributes
6. ✅ **RBAC prevents privilege creep** by assigning permissions to roles, not individuals
7. ✅ **MAC** has two models: Hierarchical (access to lower levels) and Compartmentalized (need-to-know)
8. ✅ Access control types by function: Preventive, Detective, Corrective, Deterrent, Recovery, Directive, Compensating
9. ✅ Controls can belong to **multiple categories** (e.g., cameras are preventive + detective + deterrent)
10. ✅ **Compensating controls** supplement primary controls when they're insufficient or impractical

---

> 📌 **Previous:** [Part 3: Attacks, Threats & Countermeasures](./Study_Guide_Part3_Attacks_Threats_Countermeasures.md)  
> 📌 **Next:** [Part 5: Incident Response & DFIR](./Study_Guide_Part5_Incident_Response_DFIR.md)
