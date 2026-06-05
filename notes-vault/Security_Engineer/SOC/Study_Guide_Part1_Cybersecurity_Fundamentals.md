---
title: "Study Guide Part1 Cybersecurity Fundamentals"
category: "Security Engineer"
tags: ["SOC"]
lastUpdated: "2026-06-05"
---

# 📘 Part 1: Cybersecurity Fundamentals & Core Concepts

> **Comprehensive Interview Study Guide** — Based on real cybersecurity course transcripts  
> Covers: CIA Triad, Cybersecurity vs InfoSec, Vulnerability/Threat/Risk, Zero-Day, Zero Trust, IAAA, Roles, Defense-in-Depth

---

## Table of Contents

1. [What is Cybersecurity?](#1-what-is-cybersecurity)
2. [The CIA Triad](#2-the-cia-triad)
3. [Cybersecurity vs Information Security](#3-cybersecurity-vs-information-security)
4. [Vulnerability, Threat, and Risk](#4-vulnerability-threat-and-risk)
5. [Zero-Day Vulnerabilities & Patches](#5-zero-day-vulnerabilities--patches)
6. [Zero Trust Security Model](#6-zero-trust-security-model)
7. [IAAA — Identification, Authentication, Authorization, Auditing, Accountability](#7-iaaa--identification-authentication-authorization-auditing-accountability)
8. [Security Analyst vs Security Engineer](#8-security-analyst-vs-security-engineer)
9. [Defense-in-Depth](#9-defense-in-depth)
10. [Interview Questions & Answers](#10-interview-questions--answers)
11. [Quick Reference Tables](#11-quick-reference-tables)
12. [Key Takeaways](#12-key-takeaways)

---

## 1. What is Cybersecurity?

Cybersecurity is the practice of **protecting systems, networks, and programs from digital attacks**. These attacks are usually aimed at:

- Accessing, changing, or destroying sensitive information
- Extorting money from users
- Interrupting normal business processes

Cybersecurity involves implementing **multiple layers of defense** across computers, networks, programs, and data. In an organization, people, processes, and technology must complement each other to create an effective defense.

---

## 2. The CIA Triad

The **CIA Triad** is the foundational model for information security. It consists of three core principles:

### Confidentiality
- Ensuring that information is **accessible only to authorized individuals**
- Achieved through: encryption, access controls, authentication mechanisms
- **Example:** Only HR personnel can access employee salary data

### Integrity
- Ensuring that data is **accurate, consistent, and unaltered** during storage and transit
- Achieved through: hashing, digital signatures, checksums, version control
- **Example:** Ensuring a financial transaction record hasn't been tampered with

### Availability
- Ensuring that systems, data, and resources are **accessible when needed** by authorized users
- Achieved through: redundancy, backups, disaster recovery, load balancing
- **Example:** An e-commerce website remains accessible during peak traffic

> **Interview Tip:** When asked "What is the CIA Triad?", always define all three components with real-world examples.

---

## 3. Cybersecurity vs Information Security

| Aspect | Cybersecurity | Information Security |
|--------|--------------|---------------------|
| **Scope** | Protects digital assets in cyberspace | Protects all forms of information (digital & physical) |
| **Focus** | Protection against cyber threats (hacking, malware) | Protection of data regardless of form |
| **Domain** | Digital/electronic systems only | Digital, physical, and verbal information |
| **Example** | Protecting a web server from DDoS | Ensuring paper files are locked in a cabinet |

> **Key Point:** Cybersecurity is a **subset** of Information Security. All cybersecurity is information security, but not all information security is cybersecurity.

---

## 4. Vulnerability, Threat, and Risk

### Vulnerability
- A **weakness or flaw** in a system, process, or design that can be exploited
- Examples: Unpatched software, weak passwords, misconfigured firewalls, open ports

### Threat
- A **potential cause of an unwanted incident** that could exploit a vulnerability and cause harm
- Examples: Hackers, malware, natural disasters, insider threats
- Threats can be **intentional** (hacker) or **unintentional** (accidental data deletion)

### Risk
- The **likelihood and impact** of a threat exploiting a vulnerability
- **Risk = Threat × Vulnerability × Impact**
- Example: An unpatched web server (vulnerability) + known exploit in the wild (threat) = HIGH risk

### Relationship Diagram
```
Threat ──exploits──> Vulnerability ──causes──> Risk ──leads to──> Impact
```

> **Interview Tip:** Always explain the relationship between these three. Risk is the business concern; vulnerability is the technical issue; threat is the actor or event.

---

## 5. Zero-Day Vulnerabilities & Patches

### Zero-Day Vulnerability
- A vulnerability that is **unknown to the vendor** and has **no patch available**
- Called "zero-day" because the vendor has had **zero days** to fix it
- Extremely dangerous because there is no known defense

### Types of Patches

| Patch Type | Description |
|-----------|-------------|
| **Hotfix** | A quick, urgent fix for a critical vulnerability — applied immediately |
| **Patch** | A standard update that addresses one or more known vulnerabilities |
| **Service Pack** | A collection of multiple patches and updates bundled together |

### Best Practices for Patch Management
1. Maintain an inventory of all systems and software
2. Prioritize patches based on risk and criticality
3. Test patches in a staging environment before deployment
4. Deploy patches in a timely manner
5. Verify successful patch installation
6. Document all patch activities

---

## 6. Zero Trust Security Model

### Core Principle
> **"Never trust, always verify"**

Zero Trust assumes that **no user, device, or network** should be automatically trusted, whether inside or outside the organization's network perimeter.

### Key Principles of Zero Trust:
1. **Verify explicitly** — Always authenticate and authorize based on all available data points
2. **Use least privilege access** — Limit user access to only what is needed
3. **Assume breach** — Minimize blast radius and segment access; verify end-to-end encryption

### Components of Zero Trust:
- **Identity verification** — Multi-factor authentication for all users
- **Micro-segmentation** — Divide the network into small zones
- **Least privilege** — Grant minimum necessary permissions
- **Continuous monitoring** — Monitor all network traffic and user behavior
- **Device trust** — Verify the health and compliance of devices

### Zero Trust vs Traditional Security

| Aspect | Traditional (Castle-and-Moat) | Zero Trust |
|--------|------------------------------|------------|
| Trust model | Trust everything inside the perimeter | Trust nothing, verify everything |
| Perimeter | Strong perimeter, soft interior | No defined perimeter |
| Access | Broad access once inside | Granular, least-privilege access |
| Verification | At entry point only | Continuous verification |

---

## 7. IAAA — Identification, Authentication, Authorization, Auditing, Accountability

IAAA represents the **Access Control Concepts** that govern security:

### Step 1: Identification
- **Establishing who you are** — the ability to identify a user
- Examples: Username, email ID, account number, process ID
- Identity is usually **public** information (e.g., your email address)
- Identity should be **unique** (except admin accounts)

### Step 2: Authentication
- **Verifying the claimed identity** — proving you are who you claim to be
- Authentication Types:

| Type | Description | Examples |
|------|-------------|---------|
| **Type 1: Something you know** | Knowledge-based | Password, PIN, passphrase |
| **Type 2: Something you have** | Possession-based | Access card, token, smart card |
| **Type 3: Something you are** | Biometrics | Fingerprint, retina scan, iris scan |
| **Type 4: Where you are** | Location-based | Office network, specific country |

#### Single Factor vs Multi-Factor Authentication
- **SFA (Single Factor):** Uses only ONE type (e.g., just a password)
- **MFA (Multi-Factor):** Uses TWO or MORE **different types** (e.g., password + token)
- ⚠️ Using password + PIN is **NOT** MFA because both are Type 1
- MFA is the **strongest** form of authentication

### Step 3: Authorization
- **Determining what the authenticated user can do**
- Defines rights and permissions assigned to subjects
- Happens AFTER authentication
- Implemented using Access Control Models (MAC, RBAC, DAC, ABAC)
- **Example:** You can board a flight (authenticated), but you can only sit in your assigned seat, not the cockpit (authorized)

### Step 4: Auditing
- **Monitoring and recording actions** taken by authenticated users
- Records events in **log files**
- Purpose: Establish accountability, detect malicious activity, validate compliance
- Collects logs from: user actions, system events, application activities, OS events

### Step 5: Accountability
- **Holding individuals responsible** for their actions
- Achieved by reviewing audit logs
- Ensures every information asset is **owned** and every action is **traceable**
- Enables **non-repudiation** — users cannot deny their actions because evidence exists

### IAAA Flow
```
Identification → Authentication → Authorization → Auditing → Accountability
                                                                    ↓
                                                            Non-Repudiation
```

---

## 8. Security Analyst vs Security Engineer

| Aspect | Security Analyst | Security Engineer |
|--------|-----------------|------------------|
| **Primary Role** | Monitor, detect, and respond to security threats | Design, build, and maintain security infrastructure |
| **Focus** | Reactive — responding to incidents | Proactive — building defenses |
| **Daily Tasks** | Monitor SIEM alerts, investigate incidents, triage alerts | Configure firewalls, deploy security tools, architect solutions |
| **Tools Used** | SIEM, EDR, SOAR, ticketing systems | Firewalls, IDS/IPS, network security tools |
| **Skills** | Log analysis, threat intelligence, incident response | Networking, scripting, system administration |
| **Certifications** | CompTIA Security+, CySA+, CEH | CISSP, CCNP Security, cloud certs |

> **Key Insight:** An analyst is like a **security guard** watching cameras, while an engineer is the **architect** who designed the building's security system.

---

## 9. Defense-in-Depth

### What is Defense-in-Depth?
A security strategy that employs **multiple layers of security measures** based on the principle that no single security measure can provide complete protection. Also known as:
- **Layered Defense** — uses multiple layers
- **Castle Approach** — draws analogy to fortified castles
- **Defense in Breadth** — emphasizes broad coverage

### The 7 Layers of Defense-in-Depth

#### Layer 1: Data Layer
- Protects sensitive and critical data
- Measures: Data classification, encryption (at rest & in transit), access controls, DLP (Data Loss Prevention), backup & recovery, secure data storage, data monitoring & auditing

#### Layer 2: Application Layer
- Secures software applications
- Measures: Secure SDLC, input validation, authentication & authorization, session management, error handling, secure configuration, security testing

#### Layer 3: Host Layer
- Secures individual endpoints (servers, workstations)
- Measures: Endpoint protection (AV/AM), patch management, host-based firewalls, strong authentication, privilege management, disk encryption, application whitelisting, continuous monitoring

#### Layer 4: Internal Network
- Protects the internal network infrastructure
- Measures: Network segmentation (VLANs, SDN), access control lists, NAC, network monitoring, secure remote access (VPN)

#### Layer 5: Perimeter
- Protects the boundary between internal and external networks
- Measures: Firewalls (stateful + NGFW), IDS/IPS, DMZ, secure gateways (web & email), WAF

#### Layer 6: Physical Security
- Protects physical assets and infrastructure
- Measures: Fences/gates/walls, access cards/biometrics, surveillance cameras, security guards, data center security, secure disposal, emergency preparedness

#### Layer 7: Policies, Procedures & Awareness
- Establishes security governance
- Measures: Risk assessment, security policies (acceptable use, access control, data handling, IR), employee training, compliance monitoring, continuous improvement

### Defense-in-Depth Summary Table

| Layer | Focus | Example Controls |
|-------|-------|-----------------|
| Data | Information protection | Encryption, DLP, backups |
| Application | Software security | Input validation, secure SDLC |
| Host | Endpoint security | AV, patching, firewalls |
| Internal Network | Internal traffic | Segmentation, NAC, monitoring |
| Perimeter | Boundary protection | Firewalls, IDS/IPS, DMZ |
| Physical | Facility security | Cameras, locks, guards |
| Policies/Awareness | Governance | Policies, training, audits |

---

## 10. Interview Questions & Answers

### Q1: What is the CIA Triad?
**A:** The CIA Triad stands for Confidentiality, Integrity, and Availability. Confidentiality ensures data is accessible only to authorized users (via encryption, access controls). Integrity ensures data hasn't been tampered with (via hashing, digital signatures). Availability ensures systems are accessible when needed (via redundancy, backups).

### Q2: What is the difference between a vulnerability, a threat, and a risk?
**A:** A vulnerability is a weakness in a system (e.g., unpatched software). A threat is anything that can exploit a vulnerability (e.g., a hacker). Risk is the potential for loss when a threat exploits a vulnerability. Risk = Threat × Vulnerability × Impact.

### Q3: What is a Zero-Day vulnerability?
**A:** A zero-day vulnerability is a security flaw unknown to the software vendor with no available patch. It's called "zero-day" because the vendor has had zero days to address it. These are extremely dangerous because there's no known defense until a patch is developed.

### Q4: Explain the Zero Trust model.
**A:** Zero Trust operates on the principle of "never trust, always verify." It assumes no user, device, or network should be trusted by default. Key principles include: verify explicitly (always authenticate), use least privilege access, and assume breach. This contrasts with traditional perimeter-based security where anything inside the network is trusted.

### Q5: What is IAAA in cybersecurity?
**A:** IAAA stands for Identification (who you are — username), Authentication (proving identity — password/MFA), Authorization (what you can do — permissions), Auditing (recording actions — logs), and Accountability (holding users responsible — reviewing logs). Together, they enable non-repudiation.

### Q6: What is Multi-Factor Authentication (MFA)?
**A:** MFA requires two or more authentication types from DIFFERENT categories: something you know (password), something you have (token), something you are (biometrics), or somewhere you are (location). Using two factors from the same type (e.g., password + PIN) is NOT MFA. MFA is the strongest form of authentication.

### Q7: Explain Defense-in-Depth.
**A:** Defense-in-Depth is a layered security strategy where multiple security controls are implemented at different layers — data, application, host, internal network, perimeter, physical, and policies. The concept is that if one layer fails, the next layer provides protection. It originated from military strategy of fortifying castles with multiple defensive layers.

### Q8: What is the difference between a Security Analyst and a Security Engineer?
**A:** A Security Analyst focuses on monitoring, detecting, and responding to security incidents (reactive role). They use tools like SIEM and EDR. A Security Engineer focuses on designing, building, and maintaining security infrastructure (proactive role). They configure firewalls, architect security solutions, and deploy security tools.

### Q9: What is a hotfix vs a patch vs a service pack?
**A:** A hotfix is an urgent, quick fix for a critical vulnerability applied immediately. A patch is a standard update addressing one or more known vulnerabilities. A service pack is a collection of multiple patches and updates bundled together into a single installation.

### Q10: Why is accountability important in access control?
**A:** Accountability ensures that every action on a system can be traced back to a specific individual. It's achieved through auditing (logging actions) and reviewing those logs. It ensures non-repudiation — users cannot deny their actions because evidence exists. Accountability is essential for enforcing security policies and detecting malicious activity.

---

## 11. Quick Reference Tables

### Authentication Types at a Glance

| Type | Category | Examples |
|------|----------|---------|
| Type 1 | Something you **know** | Password, PIN, passphrase |
| Type 2 | Something you **have** | Smart card, token, access card |
| Type 3 | Something you **are** | Fingerprint, retina, iris, facial |
| Type 4 | Where you **are** | GPS location, office network |

### Security Model Comparison

| Model | Trust Basis | Perimeter | Verification |
|-------|------------|-----------|--------------|
| Traditional | Inside = trusted | Strong perimeter | At entry only |
| Zero Trust | Nothing trusted | No perimeter | Continuous |
| Defense-in-Depth | Layered controls | Multiple layers | At every layer |

### Patch Types

| Type | Urgency | Scope | Use Case |
|------|---------|-------|----------|
| Hotfix | Critical/Immediate | Single issue | Active exploit |
| Patch | Standard | One or more issues | Regular updates |
| Service Pack | Planned | Multiple patches | Major updates |

---

## 12. Key Takeaways

1. ✅ **CIA Triad** is the foundation — Confidentiality, Integrity, Availability
2. ✅ **Cybersecurity ⊂ Information Security** — cybersecurity is a subset
3. ✅ **Risk = Threat × Vulnerability × Impact** — understand the relationship
4. ✅ **Zero-Day** = Unknown vulnerability with NO patch available
5. ✅ **Zero Trust** = "Never trust, always verify" — no implicit trust
6. ✅ **IAAA** = Identification → Authentication → Authorization → Auditing → Accountability
7. ✅ **MFA** requires different TYPE categories (not just two passwords)
8. ✅ **Defense-in-Depth** = 7 layers of security controls
9. ✅ **Analyst = Monitor & Respond** | **Engineer = Design & Build**
10. ✅ **Non-repudiation** is achieved through IAAA — users can't deny actions

---

> 📌 **Next:** [Part 2: Network Security & Cryptography](./Study_Guide_Part2_Network_Security_Cryptography.md)
