-- Batch 3: 10 notes
BEGIN;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$WF_Senior_InfoSec_Part8_Architecture$VELSEC$, $VELSEC$Wf Senior Infosec Part8 Architecture$VELSEC$, $VELSEC$Career Development$VELSEC$, ARRAY['Interview_Preparation']::TEXT[], $VELSEC$# PART 8: SECURE ARCHITECTURE & DESIGN (15–20 minutes)

---

## 8.1 "When reviewing a new project, what are the first **security architecture** aspects you look at?"

**Answer Outline:**

**Security architecture review checklist (in priority order):**

**1. Data flow and trust boundaries:**
- "Where does data enter the system? Where does it leave? What trust boundaries does it cross?"
- Draw data flow diagram: User → Frontend → API → Backend → Database → External system
- "Every trust boundary crossing needs authentication, encryption, and validation."

**2. Authentication & authorization:**
- How are users authenticated? (Password? MFA? Certificate?)
- How is authorization enforced? (RBAC? ABAC? Per-resource checks?)
- "I check: Can any user access any resource? Or are there proper access controls per resource?"

**3. Data classification & protection:**
- What data is processed? (PII, PCI, financial, public?)
- How is data encrypted at rest and in transit?
- How is data retained and deleted?
- "If the system handles PCI data, it immediately pulls in PCI-DSS requirements."

**4. Network architecture:**
- Where is the system deployed? (Cloud, on-prem, hybrid?)
- Is it internet-facing? What's exposed?
- Network segmentation: Is the system isolated from other environments?
- "I check: Can a compromise in this system lead to lateral movement to other critical systems?"

**5. Third-party integrations:**
- What external services does it connect to?
- How are API keys/credentials managed?
- What data is shared with third parties?
- "Every external integration is a potential attack vector."

**6. Logging & monitoring:**
- What security events are logged?
- Are logs sent to SIEM?
- Can we detect and respond to attacks against this system?
- "If it's not logged, it didn't happen from a security perspective."

**7. Resilience & availability:**
- Single points of failure?
- Backup and recovery strategy?
- DDoS protection?
- "For banking systems, availability is as important as confidentiality."

**Your approach:** "For every new project, I start with a 1-hour architecture review session. I ask the team to walk me through the data flow diagram and explain trust boundaries. I then assess each boundary for authentication, encryption, and validation. This catches 80% of architectural security issues before a single line of code is written."

---

## 8.2 "How do you balance **business requirements, usability, and security** when designing controls?"

**Answer Outline:**

**The security-usability-business triangle:**

```
           SECURITY
          /        \
         /          \
        /   BALANCE  \
       /              \
USABILITY ———————— BUSINESS
```

**Principles:**

1. **Security should enable business, not block it:**
   - "If security makes the system unusable, users will find workarounds (which are even less secure)."
   - Example: "If password requirements are too strict (20 characters, change weekly), employees write passwords on sticky notes."

2. **Risk-based decisions:**
   - High-risk transactions (wire transfers): MFA + step-up authentication → worth the friction
   - Low-risk actions (checking balance): Single authentication → minimal friction
   - "Don't apply the same security level to everything. Tailor controls to risk."

3. **Transparent security (invisible to user when possible):**
   - Behavioral analytics runs in background (user doesn't see it)
   - Encryption is automatic (user doesn't choose)
   - Device health checks happen at VPN connection (user just clicks connect)
   - "Best security is security users don't notice."

4. **Offer alternatives, not just "no":**
   - Business: "We need this feature launched in 2 weeks."
   - Bad response: "No, it's not secure."
   - Good response: "We can launch with these controls now, and add advanced controls in phase 2. Here's the residual risk we're accepting."

**Real example:**
- Business wanted to launch a new payment feature quickly.
- Security concern: Missing input validation and transaction monitoring.
- My approach: "Let's launch with WAF protection and basic validation (2 days of work). We'll add full input validation and transaction monitoring in the next sprint. I'll document the residual risk. Business owner signs off on temporary risk acceptance."
- Result: Feature launched on time. Full security controls implemented 3 weeks later. No incidents in the interim.

---

## 8.3 "Describe a time you rejected or pushed back on an application design due to security concerns."

**Answer Outline (STAR format):**

**Situation:** "Development team proposed a new microservice architecture where all internal services communicated over unencrypted HTTP. They argued: 'It's all internal, so encryption isn't needed. TLS adds latency.'"

**Task:** "As the security architect, I needed to ensure the design met our security standards without blocking the project."

**Action:**
1. **Quantified the risk:** "If any internal host is compromised, attacker can eavesdrop on ALL internal traffic—including customer data, authentication tokens, and financial transactions."
2. **Referenced compliance:** "PCI-DSS requires encryption of cardholder data in transit, even within the internal network."
3. **Addressed performance concern:** "TLS 1.3 handshake adds <5ms latency. For our use case, this is negligible. I ran benchmarks to prove it."
4. **Proposed implementation path:** "Use service mesh (Istio) for automatic mTLS. Zero code changes needed. Infrastructure team handles setup."
5. **Demonstrated business risk:** "A recent breach at [competitor] was caused by exactly this—unencrypted internal traffic. Attacker intercepted API tokens after gaining initial foothold."

**Result:** "Team agreed to implement mTLS via Istio. Total implementation time: 1 week. Performance impact: <3ms additional latency. The architecture was approved by compliance. This became the standard for all new microservice deployments."

---

## 8.4 "How do you approach **segmentation** of high-value assets (e.g., payment systems, core banking) from other networks?"

**Answer Outline:**

**Segmentation strategy for banking:**

```
┌─────────────────────────────────────────────────────────┐
│  ZONE 1: CORE BANKING (Highest Security)                │
│  ┌─────────────────────────────────────────────────┐   │
│  │ Payment Processing | Core Banking DB | SWIFT     │   │
│  │ • Dedicated VLAN/VPC                            │   │
│  │ • Only app-tier can access (not web tier)       │   │
│  │ • All traffic encrypted (mTLS)                  │   │
│  │ • No internet access (air-gapped from internet) │   │
│  │ • PAM required for admin access                 │   │
│  │ • IDS/IPS monitoring on all interfaces          │   │
│  │ • Change control: Dual approval required        │   │
│  └─────────────────────────────────────────────────┘   │
├─────────────────────────────────────────────────────────┤
│  ZONE 2: APPLICATION TIER (Medium-High Security)        │
│  ┌─────────────────────────────────────────────────┐   │
│  │ App Servers | API Gateway | Message Queue        │   │
│  │ • Can access Core Banking zone (specific ports)  │   │
│  │ • Can receive from DMZ (specific ports)          │   │
│  │ • Cannot access internet directly                │   │
│  └─────────────────────────────────────────────────┘   │
├─────────────────────────────────────────────────────────┤
│  ZONE 3: DMZ (Medium Security)                          │
│  ┌─────────────────────────────────────────────────┐   │
│  │ Web Servers | Load Balancers | WAF               │   │
│  │ • Internet-facing (HTTPS only)                   │   │
│  │ • Can forward to App Tier (specific ports)       │   │
│  │ • Cannot access Core Banking directly            │   │
│  └─────────────────────────────────────────────────┘   │
├─────────────────────────────────────────────────────────┤
│  ZONE 4: CORPORATE (Standard Security)                  │
│  ┌─────────────────────────────────────────────────┐   │
│  │ Employee Workstations | Email | File Servers     │   │
│  │ • Cannot access Core Banking or App Tier         │   │
│  │ • Admin access to zones requires VPN + PAM       │   │
│  └─────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
```

**Implementation mechanisms:**
- **VLANs:** Physical/logical network separation
- **Firewalls:** Rules between zones (deny by default, explicit allow)
- **AWS Security Groups/NACLs:** Cloud-native segmentation
- **Kubernetes Network Policies:** Pod-level microsegmentation
- **Monitoring:** All cross-zone traffic logged and analyzed in SIEM

---

## 8.5 "Explain how you would design **access control** for privileged users and administrators."

**Answer Outline:**

**Privileged Access Management (PAM) architecture:**

```
┌────────────────────────────────────────────────────┐
│           PRIVILEGED ACCESS WORKFLOW                │
│                                                     │
│  1. Admin requests access via PAM tool              │
│     (CyberArk, BeyondTrust, HashiCorp Vault)       │
│                                                     │
│  2. Approval workflow:                              │
│     - Manager approves                              │
│     - Security team validates business justification│
│     - Dual approval for critical systems            │
│                                                     │
│  3. Time-limited access granted:                    │
│     - 4-hour window for specific task               │
│     - Auto-revoked after expiry                     │
│     - All actions logged and recorded               │
│                                                     │
│  4. Session monitoring:                             │
│     - Screen recording of admin sessions            │
│     - Keystroke logging (for compliance)            │
│     - Real-time alerting on suspicious commands     │
│                                                     │
│  5. Post-session review:                            │
│     - Audit logs reviewed by security team          │
│     - Anomalous activity investigated               │
└────────────────────────────────────────────────────┘
```

**Key principles:**
1. **No standing privileges:** Admin access is temporary. Zero standing admin accounts.
2. **Just-In-Time (JIT):** Access granted only when needed, for minimum duration.
3. **Just-Enough-Access (JEA):** Grant only the specific permissions needed for the task.
4. **Break-glass accounts:** Emergency admin accounts with extra logging and alerting. Used only when PAM is unavailable.
5. **Separation of duties:** Person requesting access ≠ person approving ≠ person auditing.
6. **MFA everywhere:** All admin access requires MFA (certificate + OTP minimum).

---

## 8.6 "What is your approach to **key management** for encryption at scale (HSMs, KMS, rotation, segregation of duties)?"

**Answer Outline:**

**Key management architecture:**

```
┌───────────────────────────────────────────────────────┐
│  KEY HIERARCHY                                         │
│                                                        │
│  Master Key (HSM-protected)                            │
│    └── Data Encryption Keys (DEKs)                    │
│          ├── DEK for Customer Data (AES-256)           │
│          ├── DEK for Payment Data (AES-256)            │
│          ├── DEK for Backup Encryption                 │
│          └── DEK for Log Encryption                    │
│                                                        │
│  Key Wrapping: Master key encrypts DEKs (envelope     │
│  encryption). DEKs encrypt actual data.               │
│  Compromise of one DEK doesn't expose all data.       │
└───────────────────────────────────────────────────────┘
```

**Key management practices:**

| Practice | Implementation | Why |
|----------|---------------|-----|
| **HSM for master keys** | CloudHSM or on-prem HSM (FIPS 140-2 Level 3) | Master key never leaves HSM; tamper-resistant |
| **KMS for DEKs** | AWS KMS / Azure Key Vault | Managed service; auto-rotation; IAM-controlled access |
| **Key rotation** | Automatic annual rotation for KMS keys; manual rotation if compromise suspected | Limits exposure if key is compromised |
| **Separation of duties** | Key admin ≠ data admin. Key admin can manage keys but can't decrypt data. Data admin can use keys but can't manage them. | Prevents single person from both managing keys and accessing data |
| **Key access logging** | All key usage logged in CloudTrail | Audit trail for compliance |
| **Key access policies** | IAM policies restrict which roles can use which keys | Least privilege for encryption/decryption |
| **Backup & escrow** | Key material backed up in secondary HSM. Escrow for disaster recovery. | Business continuity |
| **Key deletion** | Soft delete with 30-day recovery window. Hard delete requires dual approval. | Prevent accidental data loss |

**PCI-DSS key management requirements:**
- Split knowledge: No single person knows the full key
- Dual control: Key operations require two authorized individuals
- Key custodians formally appointed and trained
- Key ceremony documented and witnessed

**Your experience:** "We use AWS KMS with customer-managed keys for all production encryption. Master keys reside in CloudHSM (FIPS 140-2 Level 3). Key access is controlled by IAM policies—only specific service roles can encrypt/decrypt. All key usage is logged in CloudTrail and monitored by SIEM. Keys rotate annually. For PCI environments, we implement dual control: key generation requires two authorized custodians. This architecture meets PCI-DSS and SOX key management requirements."

---$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$WF_VM_Self_Intro_Pitch$VELSEC$, $VELSEC$Wf Vm Self Intro Pitch$VELSEC$, $VELSEC$Career Development$VELSEC$, ARRAY['Interview_Preparation']::TEXT[], $VELSEC$# Self-Introduction Pitch: Vulnerability Management Focus
## For Senior Information Security Analyst Role at Wells Fargo

---

## **60-Second Elevator Pitch (Recruiter Round)**

"Hi, I'm [Your Name], with [X] years in cybersecurity, specializing in **vulnerability management at enterprise scale**. I've built and optimized VM programs from the ground up—managing 50,000+ vulnerabilities across cloud, container, and on-prem infrastructure. My focus is turning vulnerability data into actionable intelligence for the business.

At my current organization, I reduced our mean time to remediation (MTTR) from 60 days to 15 days through better prioritization and automation. I also cut vulnerability scan noise by 70% by implementing risk-based scoring and contextual asset importance.

I'm drawn to Wells Fargo because banking faces unique threats and regulatory pressure. My experience with cloud security, CNAPP, and compliance frameworks like PCI-DSS directly aligns with your needs. I'm looking for a role where I can architect a world-class vulnerability management program—not just run scans, but drive strategic risk reduction."

---

## **2-Minute Deep Dive (Technical Screening Round)**

"Thanks for having me. I want to give you a sense of my VM philosophy and track record.

**My background:** I started as a Tier-1 SOC analyst focused on alert triage. Over [X] years, I realized that vulnerabilities are the root cause of most incidents we were responding to. So I moved into vulnerability management, then expanded to cloud security and container security—all areas where vulnerabilities compound quickly if not managed.

**My VM approach:**

1. **Risk-based prioritization** (not just CVSS scores): I don't just list vulnerabilities; I score them based on:
   - Exploitability (is this actively exploited?)
   - Asset criticality (is this server talking to customer data?)
   - Environmental context (is this port exposed to the internet?)
   - Compensating controls (are we mitigating this risk another way?)
   - Result: A business-aligned priority list. C-suite sees top 20 risks requiring immediate attention, not 10,000 line items.

2. **Automation & efficiency:** I've integrated scanning tools (Qualys, Tenable, Chainer, etc.) into CI/CD pipelines:
   - Pre-deployment scanning: Catch vulns before they hit production.
   - Automated remediation recommendations: We parse vendor patches, correlate with our environment, auto-create tickets for DevOps.
   - Result: 70% fewer scan false positives; faster remediation cycles.

3. **Compliance integration:** VM isn't separate from compliance—it's the same thing with different stakeholders.
   - PCI-DSS requires vulnerability scanning + remediation SLAs. I tie our scanning schedule and SLAs directly to audit requirements.
   - We track scan evidence, remediation evidence, and exceptions—audit-ready from day one.
   - Result: Zero audit findings on VM program in past 3 years.

4. **Cloud & container-specific gaps:** This is where most organizations fall short.
   - Cloud: Misconfigurations are often more impactful than code vulnerabilities. I use tools like CloudMapper and Prowler for continuous cloud security scanning.
   - Containers: Image scanning, runtime threat detection (CNAPP), supply chain risks. I've implemented CNAPP to catch zero-days in container environments.
   - Result: Detected 100+ cloud misconfigurations that would've been missed by traditional scanners.

**Quantified impact:**
- Mean time to remediation: 60 days → 15 days
- Vulnerability scan noise: 10,000 alerts → 30 high-confidence alerts (97% reduction)
- Critical vulnerabilities resolved before active exploitation: 100% (detected via threat intel correlation)
- Audit findings related to vulnerability management: Zero in 3 years

**Why Wells Fargo:**
Banking has unique challenges: legacy systems, regulatory complexity, high-value targets. Vulnerabilities can directly lead to customer data breach or trading platform outage—existential threats. I want to work in an environment where VM is treated as a strategic risk function, not a checkbox. I'm confident I can help Wells Fargo mature its VM program to world-class standards while supporting your cloud modernization and compliance goals."

---

## **Detailed Self-Intro (Leadership / Final Round)**

"I appreciate the opportunity to dive deeper. Let me walk you through my VM philosophy and why I'm excited about this role.

**The case for a mature VM program:**

Vulnerabilities are like technical debt—the longer you ignore them, the more expensive they become. A typical enterprise:
- Discovers 50,000 vulnerabilities/year (from scans, threat intel, audits).
- Has capacity to remediate maybe 5,000.
- The other 45,000 pile up, creating surface area every day.

Without a mature VM program, you're hoping:
1. Attackers don't find these vulns before you patch.
2. If they do, your other controls catch the attack.

Both are risky bets in a high-value target like a bank.

**My approach changes this:**

**Phase 1: Assessments & data collection (Month 1–2)**
- Where are we now? What scanners do we have? What's the current state?
- Audit: What vulns exist? What's our MTTR? What's our backlog?
- Gap analysis: PCI-DSS, SOX, GLBA requirements vs. current state.

**Phase 2: Program framework (Month 2–3)**
- Define roles: Who owns scanning? Who remediates? Who tracks metrics?
- Standards: Which scanners do we use? What's our scanning cadence?
- Prioritization framework: Risk-based scoring (CVSS + context + threat intel).
- SLA framework: Critical vulns = 7 days, High = 30 days, Medium = 90 days.
- Tooling: Integrate scanners into SIEM, ticketing system, compliance tracking.

**Phase 3: Automation (Month 3–6)**
- CI/CD integration: Scan every build; fail fast.
- Cloud scanning: Continuous monitoring of cloud configurations.
- Threat intel feed: Correlation with active exploits; elevate priority immediately.
- Auto-remediation: Where possible (config fixes, patches), trigger automatically with approval gates.
- Ticketing automation: Scan finding → auto-create ticket → route to owner.

**Phase 4: Maturity (Month 6+)**
- Metrics & dashboards: MTTR trending, top remediation blockers, compliance status.
- Executive reporting: "Here are our top 10 risks; here's our mitigation plan; here's our trend."
- Risk-adjusted budgeting: "If we invest $X in these remediations, risk goes down by Y%."
- Continuous tuning: Reduce false positives, optimize scanning, improve prioritization.

**Expected outcomes (Year 1):**
- MTTR: 60 days → 30 days
- Backlog clearance: 60% of backlog resolved or accepted as acceptable risk
- Audit readiness: 100% of critical/high vulns documented with remediation status
- False positive rate: 80% reduction through better baseline + tuning
- Executive alignment: Board can speak to vulnerability risk with confidence

**Why I'm excited about Wells Fargo:**

1. **Scale & complexity:** Your infrastructure is complex (legacy + cloud hybrid). I love tackling large-scale VM programs.
2. **Regulatory scrutiny:** Banking regulators care about vulnerability management. Doing this well = audit confidence + regulatory points.
3. **Team impact:** I'm not just running scans; I'm building a program that enables the business to move fast while managing risk.
4. **Cloud modernization:** You're adopting AWS/Azure. VM needs to evolve with containerization and serverless. I bring that expertise.
5. **Incident prevention:** Reducing vulnerability surface directly prevents breaches. That's meaningful work.

**My track record shows I can:**
- Build programs from ground up or improve existing ones.
- Lead cross-functional teams (DevOps, app dev, infrastructure, compliance).
- Communicate risk clearly to both technical and business stakeholders.
- Drive automation and efficiency without sacrificing security.
- Deliver measurable outcomes (metrics, audit compliance, risk reduction).

**In this role, I'd focus on:**
- Assessing current state and building a multi-year roadmap.
- Designing a risk-based prioritization framework specific to banking threats.
- Integrating VM with your compliance program (PCI-DSS, SOX, GLBA).
- Automating scanning and remediation where possible.
- Building a team that's both thorough and efficient.
- Providing executive-ready insights: 'Here's our risk; here's our mitigation; here's our trend.'

I'm confident in my ability to elevate Wells Fargo's vulnerability management program to a competitive advantage. Happy to dive into specifics about how I'd approach any of these areas."

---

## **Key Talking Points (Memorize These)**

### Vulnerability Management Philosophy:
- ✅ Risk-based prioritization (not just CVSS)
- ✅ Context matters (asset criticality, exploitability, threat intel)
- ✅ Automation reduces noise and accelerates remediation
- ✅ Compliance & risk management are deeply integrated
- ✅ Maturing programs is a journey; expect Year 1 improvements in MTTR, Year 2-3 in strategic alignment

### Quantifiable Achievements (Use these numbers):
- "Reduced MTTR from 60 days to 15 days"
- "Cut scan noise by 70% through risk-based scoring"
- "Zero audit findings in 3 years on VM program"
- "Detected 100+ cloud misconfigurations before they became incidents"
- "100% of critical/high vulnerabilities resolved or accepted before active exploitation"

### Banking-Specific Language:
- "Regulatory audit readiness"
- "PCI-DSS compliance through continuous scanning + evidence tracking"
- "Risk-adjusted budgeting: link vulnerability remediation to risk reduction"
- "Executive reporting on vulnerability risk at board level"
- "Legacy + cloud hybrid: VM must span both worlds"

### Technical Depth:
- Scanning tools: Qualys, Tenable, Rapid7, Chainer, Acunetix, Veracode
- Cloud scanning: CloudMapper, Prowler, Wiz, Orca Security
- Container/CNAPP: Falco, Wiz, Snyk, Anchore, Aqua
- Integration points: SIEM, ticketing systems, CI/CD pipelines
- Frameworks: NIST CSF, PCI-DSS, CIS Controls, OWASP

### Leadership Signal (Senior-level differentiator):
- "Built programs from ground up; scaled to enterprise"
- "Mentored junior analysts on VM methodologies"
- "Influenced cross-functional teams to adopt security scanning practices"
- "Presented risk data to C-suite and board; drove decision-making"
- "Took on automation projects that freed up analyst time for higher-value work"

---

## **Common Follow-Up Questions & Quick Answers**

**Q: How do you balance toil (scanning, reporting) with strategic work?**
A: "Automation is key. I automate 70% of scanning, report generation, and ticketing. That frees up the team for strategic work: tuning rules, investigating outliers, working with business units on exceptions. A senior analyst should spend 30% on strategic initiatives, 70% I automate away."

**Q: What's your experience with False Positives?**
A: "False positives are the enemy of vulnerability management—they create fatigue and missed real risks. I've implemented several techniques: baselining (know what 'normal' looks like), tuning (adjust thresholds per asset type), correlating with threat intel (only alert on exploitable vulns), and manual review gates for noisy categories. We went from 10,000 alerts to 30 high-confidence alerts."

**Q: How do you handle vulnerabilities that can't be patched immediately?**
A: "We use a risk register: document the vulnerability, why it can't be patched, compensating controls, and target remediation date. This is audit-friendly. Example: 'Legacy mainframe can't be patched until Q4 maintenance window. Mitigated by: network segmentation, EDR monitoring, compensating control X.' We track and revisit quarterly."

**Q: Cloud and container vulnerabilities differ from traditional VM. What's your experience?**
A: "Absolutely. Traditional: patch OS and application vulnerabilities. Cloud: misconfigurations are equally important (e.g., open S3 bucket). Containers: supply chain risks, base image vulns, runtime zero-days. I've used tools like Prowler for cloud, Wiz for serverless/container, Falco for runtime threat detection. The key is integrating these into your overall VM program, not treating them separately."

**Q: How do you measure VM program effectiveness?**
A: "Primary metrics: MTTR (trending down), critical vulnerability count (trending down), scan coverage (% of assets scanned), remediation rate (% of vulns closed). Secondary: audit findings (trending down), business acceptance (exec confidence in risk rating), team satisfaction (tool/process feedback). I report these monthly to leadership, quarterly to board."

---

## **Final Tips for Delivery**

✅ **Be confident but humble:** "Here's what I've achieved. Here's what I'd like to learn from your team's specific environment."

✅ **Connect to their business:** "Banking faces [specific threats]. VM is the foundation for [specific objective like 'regulatory compliance' or 'zero breaches']."

✅ **Show self-awareness:** "VM can be seen as a 'checkbox' function. I see it as a strategic risk driver. I'd transform perception and outcomes."

✅ **Ask thoughtful questions:** "What's your current VM maturity? What are your biggest challenges? How is VM currently perceived in your organization?"

✅ **Use analogies if explaining to non-technical audience:** "Vulnerabilities are like broken locks on doors. We inventory them (scan), rank which doors are most important (risk score), and fix them (remediate). Our program makes sure this happens systematically and efficiently."

---

**End of VM-Focused Self-Intro Pitch.**$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$INDEX$VELSEC$, $VELSEC$Index$VELSEC$, $VELSEC$Career Development$VELSEC$, ARRAY['resume']::TEXT[], $VELSEC$﻿# resume

Index of files in this directory:

- [index.html](./index.html)$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$nmap-cheatsheet$VELSEC$, $VELSEC$Nmap Penetration Testing Cheat Sheet$VELSEC$, $VELSEC$Cheat Sheets$VELSEC$, ARRAY['Recon', 'Nmap', 'Scanning', 'Network']::TEXT[], $VELSEC$Nmap ("Network Mapper") is a free and open-source utility for network discovery and vulnerability auditing. This cheat sheet captures primary scanning switch commands for quick retrieval during engagements.

### Critical Scan Commands

#### Stealth / SYN Scan
Standard stealth scanning option that doesn't trigger full TCP connections.
```bash
nmap -sS -T4 <target-ip>
```

#### Service Version Detection
Queries target ports to determine service protocols, applications, and versions.
```bash
nmap -sV -p- <target-ip>
```

#### OS and Script Scanning
Enables OS detection, version detection, script scanning, and traceroute.
```bash
nmap -A -v <target-ip>
```

#### Vuln Assessment Scripts
Runs standard Nmap Scripting Engine (NSE) scripts focused on vulnerability discovery.
```bash
nmap --script vuln -p 80,443 <target-ip>
```$VELSEC$, '2026-06-03')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$BUILD_REPORT_WITH_MCP_SERVER$VELSEC$, $VELSEC$Build Report With Mcp Server$VELSEC$, $VELSEC$Data Analyst$VELSEC$, ARRAY['Data_Analytics']::TEXT[], $VELSEC$# 🚀 Build a Power BI Report Using MCP Server — Complete Beginner Guide

> **For:** Complete beginners with no prior MCP/Power Query experience
> **Goal:** Create a working Power BI executive dashboard from CSV data + MCP metadata server
> **Time:** ~2 hours total

---

## Table of Contents
1. [What is MCP and why use it?](#what-is-mcp)
2. [Part 1: Set up the MCP Server (Python+Flask)](#part-1-mcp-server)
3. [Part 2: Start Power BI Desktop and connect](#part-2-power-bi-setup)
4. [Part 3: Load data into Power BI](#part-3-load-data)
5. [Part 4: Transform data in Power Query](#part-4-transform-data)
6. [Part 5: Create relationships](#part-5-relationships)
7. [Part 6: Build DAX measures](#part-6-dax-measures)
8. [Part 7: Build report pages](#part-7-report-pages)
9. [Part 8: Publish and refresh](#part-8-publish)

---

## What is MCP?

**MCP (Model Context Protocol)** is a metadata standard. Think of it as a "blueprint" that describes:
- What tables you have (Findings, Assets, Tickets)
- What columns are in each table (name, type, relationships)
- How tables connect together

Instead of manually building this in Power BI, you ask the MCP server "what tables do you have?" and it tells you in JSON format. Then Power BI uses that info to auto-load and connect everything.

**Why use it?**
- Automated schema discovery (no manual clicking for each column)
- Repeatable — run again next month, same structure
- Reduces errors — schema is source of truth

---

# PART 1: Set Up the MCP Server (Python+Flask)

## Step 1.1: Check if Python is installed

Open PowerShell and type:
```powershell
python --version
```

**Expected output:** `Python 3.x.x` (any 3.8+)

**If you see error:** Download Python from https://www.python.org/downloads/
- Install with ✅ "Add Python to PATH"
- Restart PowerShell after install

---

## Step 1.2: Create MCP server directory

In PowerShell, type:
```powershell
cd "c:\Users\gopik\Desktop\New folder\CNAPP\PowerBI_Project"
mkdir mcp
cd mcp
```

This creates folder `PowerBI_Project/mcp/` where we'll put the server code.

---

## Step 1.3: Create `server.py` file

In the `mcp` folder, create a file named `server.py`.

Copy this code into it:

```python
from flask import Flask, jsonify, request
import csv
import os
from datetime import datetime
from pathlib import Path

app = Flask(__name__)

# Get the data folder path
DATA_FOLDER = Path(__file__).parent.parent / "data"

# ============================================
# METADATA SCHEMA (answers "what tables exist?")
# ============================================
@app.route("/mcp/model", methods=["GET"])
def get_model():
    """Returns the schema: tables, columns, types, relationships"""
    return jsonify({
        "id": "CNAPP",
        "name": "Cloud Security Posture Dashboard",
        "tables": [
            {
                "name": "Findings",
                "description": "Security findings from Wiz cloud scanning",
                "columns": [
                    {"name": "finding_id", "dataType": "string", "description": "Unique finding ID"},
                    {"name": "severity", "dataType": "string", "description": "CRITICAL, HIGH, MEDIUM, LOW"},
                    {"name": "status", "dataType": "string", "description": "Open or Closed"},
                    {"name": "created_date", "dataType": "date", "description": "When finding was discovered"},
                    {"name": "closed_date", "dataType": "date", "description": "When finding was closed (if closed)"},
                    {"name": "internet_facing", "dataType": "string", "description": "Yes/No"},
                    {"name": "resource_id", "dataType": "string", "description": "Cloud resource identifier"},
                    {"name": "category", "dataType": "string", "description": "Finding category (Network, IAM, Storage, etc)"},
                    {"name": "sla_hours", "dataType": "integer", "description": "SLA target hours for remediation"}
                ]
            },
            {
                "name": "Assets",
                "description": "Cloud assets (servers, databases, storage accounts)",
                "columns": [
                    {"name": "resource_id", "dataType": "string", "description": "Cloud resource ID"},
                    {"name": "asset_name", "dataType": "string", "description": "Human-readable asset name"},
                    {"name": "business_unit", "dataType": "string", "description": "Team that owns this asset"},
                    {"name": "environment", "dataType": "string", "description": "Prod, Staging, Dev"},
                    {"name": "owner", "dataType": "string", "description": "Person responsible for this asset"}
                ]
            },
            {
                "name": "Tickets",
                "description": "ServiceNow tickets for remediation",
                "columns": [
                    {"name": "ticket_id", "dataType": "string", "description": "ServiceNow ticket number"},
                    {"name": "finding_id", "dataType": "string", "description": "Links to Findings table"},
                    {"name": "sla_status", "dataType": "string", "description": "Met, Missed, On Track, Breached"},
                    {"name": "created_date", "dataType": "date", "description": "When ticket was opened"},
                    {"name": "resolved_date", "dataType": "date", "description": "When ticket was resolved"},
                    {"name": "assignment_group", "dataType": "string", "description": "Team assigned to fix"}
                ]
            }
        ],
        "relationships": [
            {"from": "Findings.resource_id", "to": "Assets.resource_id", "type": "Many-to-One"},
            {"from": "Findings.finding_id", "to": "Tickets.finding_id", "type": "One-to-One"}
        ]
    })

# ============================================
# DATA ENDPOINTS (answers "give me the actual data")
# ============================================

@app.route("/mcp/data/Findings", methods=["GET"])
def get_findings_data():
    """Load Findings table from CSV"""
    findings_path = DATA_FOLDER / "wiz_findings.csv"
    if not findings_path.exists():
        return jsonify({"error": f"File not found: {findings_path}"}), 404
    
    data = []
    with open(findings_path, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            data.append(row)
    
    return jsonify({"table": "Findings", "rowCount": len(data), "data": data[:100]})  # First 100 rows

@app.route("/mcp/data/Assets", methods=["GET"])
def get_assets_data():
    """Load Assets table from CSV"""
    assets_path = DATA_FOLDER / "cmdb_assets.csv"
    if not assets_path.exists():
        return jsonify({"error": f"File not found: {assets_path}"}), 404
    
    data = []
    with open(assets_path, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            data.append(row)
    
    return jsonify({"table": "Assets", "rowCount": len(data), "data": data[:100]})

@app.route("/mcp/data/Tickets", methods=["GET"])
def get_tickets_data():
    """Load Tickets table from CSV"""
    tickets_path = DATA_FOLDER / "servicenow_tickets.csv"
    if not tickets_path.exists():
        return jsonify({"error": f"File not found: {tickets_path}"}), 404
    
    data = []
    with open(tickets_path, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            data.append(row)
    
    return jsonify({"table": "Tickets", "rowCount": len(data), "data": data[:100]})

# ============================================
# HEALTH CHECK & REFRESH
# ============================================

@app.route("/mcp/health", methods=["GET"])
def health():
    """Check if MCP server is alive"""
    return jsonify({"status": "ok", "timestamp": datetime.now().isoformat()})

@app.route("/mcp/refresh", methods=["POST"])
def refresh_data():
    """Trigger a data refresh (for Power BI scheduled refresh)"""
    return jsonify({
        "status": "refresh_started",
        "message": "Data refresh triggered. CSV files will be reloaded next query.",
        "timestamp": datetime.now().isoformat()
    })

if __name__ == "__main__":
    print("🚀 MCP Server starting...")
    print("📊 Endpoints:")
    print("   GET  http://localhost:5000/mcp/model")
    print("   GET  http://localhost:5000/mcp/data/Findings")
    print("   GET  http://localhost:5000/mcp/data/Assets")
    print("   GET  http://localhost:5000/mcp/data/Tickets")
    print("   GET  http://localhost:5000/mcp/health")
    print("   POST http://localhost:5000/mcp/refresh")
    print("\n💡 Tip: Keep this window open while using Power BI!")
    app.run(port=5000, debug=True)
```

---

## Step 1.4: Install Flask dependency

Still in PowerShell (in `mcp` folder), type:
```powershell
pip install flask
```

Wait for it to complete (should say "Successfully installed").

---

## Step 1.5: Start the MCP server

In PowerShell, type:
```powershell
python server.py
```

**Expected output:**
```
 * Serving Flask app 'server'
 * Running on http://127.0.0.1:5000
```

✅ **Keep this PowerShell window open!** The server must stay running while you use Power BI.

---

## Step 1.6: Test the MCP server

Open a web browser and go to:
```
http://localhost:5000/mcp/model
```

You should see JSON with table schema (Findings, Assets, Tickets).

✅ **Great!** MCP server is working.

---

# PART 2: Power BI Setup

## Step 2.1: Open Power BI Desktop

If not already open, click Start → type "Power BI Desktop" → open it.

Go to **File** → **Open**.

Look for your file (if you already have a PBIX) or click **Create Blank Report**.

For now, create **Blank Report**.

---

## Step 2.2: Get Data from API

In Power BI ribbon, click:
```
Home → Get Data → Web
```

In the dialog box, paste:
```
http://localhost:5000/mcp/data/Findings
```

Click **OK**.

Power BI will ask to authenticate (click **Anonymous**).

Click **Load**.

---

## Step 2.3: Inspect the Findings data

You should see a table appear with columns: `finding_id`, `severity`, `status`, etc.

If you see data, ✅ **connection works!**

---

# PART 3: Load All Three Tables

Repeat the **Get Data → Web** process for:
1. `http://localhost:5000/mcp/data/Assets`
2. `http://localhost:5000/mcp/data/Tickets`

You now have 3 tables loaded into Power BI.

---

# PART 4: Transform Data (Power Query)

Power Query is where you "clean up" your data before putting it into the model.

## Step 4.1: Open Power Query Editor

Click: **Queries** (on the left) or **Home** → **Transform Data**.

---

## Step 4.2: Transform Findings table

In the left panel, click **Findings**.

### Set data types:
- Click column **created_date** → **Transform** → change to **Date**
- Click column **closed_date** → **Transform** → change to **Date**
- Click column **sla_hours** → **Transform** → change to **Whole Number**

### Add a new column: "Days Open"

Right-click the last column → **Insert Column** → **Custom Column**.

Name: `Days Open`

Formula:
```
if [status] = "Open" then Duration.Days(DateTime.LocalNow() - [created_date]) else Duration.Days([closed_date] - [created_date])
```

Click **OK**.

### Add a new column: "SLA Met"

Right-click the last column → **Insert Column** → **Custom Column**.

Name: `SLA Met`

Formula:
```
if [status] = "Closed" then (if Duration.TotalHours([closed_date] - [created_date]) <= [sla_hours] then "Met" else "Missed") else (if Duration.TotalHours(DateTime.LocalNow() - [created_date]) > [sla_hours] then "Breached" else "On Track")
```

---

### Add "Severity Order" (for correct sorting)

Name: `Severity Order`

Formula:
```
if [severity] = "CRITICAL" then 1 else if [severity] = "HIGH" then 2 else if [severity] = "MEDIUM" then 3 else 4
```

---

## Step 4.3: Transform Tickets table

Click **Tickets** in left panel.

### Set data types:
- **created_date** → Date
- **resolved_date** → Date

### Add "Days to Resolve"

Name: `Days to Resolve`

Formula:
```
if [resolved_date] <> null then Duration.Days([resolved_date] - [created_date]) else null
```

---

## Step 4.4: Transform Assets table

Click **Assets** in left panel.

No transformations needed — this is a dimension table. Just verify data types are correct.

---

## Step 4.5: Close Power Query

Click **Close & Apply** (top-left).

Power Query disappears and data loads into Power BI model.

---

# PART 5: Create Relationships

Relationships tell Power BI how tables connect to each other.

## Step 5.1: Open Model view

Click the **diagram icon** (left sidebar) to go to Model view.

You should see 3 table boxes: **Findings**, **Assets**, **Tickets**.

---

## Step 5.2: Create relationship 1 (Findings → Assets)

Click **Findings** table and drag the **resource_id** column onto **Assets** table's **resource_id** column.

A line should appear connecting them.

Right-click the line → **Properties**:
- From: **Findings** → **resource_id**
- To: **Assets** → **resource_id**
- Cardinality: **Many to One**
- Click **OK**

---

## Step 5.3: Create relationship 2 (Findings → Tickets)

Drag **Findings.finding_id** onto **Tickets.finding_id**.

Right-click → **Properties**:
- Cardinality: **One to One**
- Click **OK**

---

## Step 5.4: Create a Date table (for time intelligence)

In Model view, click **Modeling** tab → **New Table**.

Paste this formula:
```dax
DateTable = ADDCOLUMNS(
    CALENDAR(DATE(2024, 1, 1), DATE(2025, 12, 31)),
    "Year", YEAR([Date]),
    "Month", MONTH([Date]),
    "MonthName", FORMAT([Date], "MMM"),
    "YearMonth", FORMAT([Date], "YYYY-MM")
)
```

Click checkmark to save.

---

## Step 5.5: Mark DateTable as a date table

Select the **DateTable** → **Modeling** → **Mark as Date Table** → select **[Date]** column.

Now create a relationship:
Drag **DateTable[Date]** → **Findings[created_date]** (Many to One).

---

# PART 6: Build DAX Measures

DAX is the formula language for Power BI. Measures are calculated fields.

## Step 6.1: Create a Measures table

In Model view, click **Modeling** → **New Table**.

Paste:
```dax
Measures = ROW("x", 0)
```

Then delete the "x" column (right-click → Delete).

This empty table is just a container for measures.

---

## Step 6.2: Add measures to Measures table

Click **Measures** table → right-click → **New Measure**.

Add each measure one by one:

### Measure 1: Total Findings
```dax
Total Findings = COUNTROWS(Findings)
```

### Measure 2: Open Findings
```dax
Open Findings = CALCULATE(COUNTROWS(Findings), Findings[status] = "Open")
```

### Measure 3: Critical Open
```dax
Critical Open = CALCULATE(COUNTROWS(Findings), Findings[severity] = "CRITICAL", Findings[status] = "Open")
```

### Measure 4: SLA Compliance %
```dax
SLA Compliance % = DIVIDE(CALCULATE(COUNTROWS(Tickets), Tickets[sla_status] = "Met"), COUNTROWS(Tickets), 0) * 100
```

### Measure 5: MTTR (days)
```dax
MTTR Days = DIVIDE(
    SUMX(FILTER(Tickets, NOT(ISBLANK(Tickets[resolved_date]))), DATEDIFF(Tickets[created_date], Tickets[resolved_date], DAY)),
    COUNTROWS(FILTER(Tickets, NOT(ISBLANK(Tickets[resolved_date])))),
    BLANK()
)
```

### Measure 6: Internet-Facing Criticals
```dax
Internet Facing Critical = CALCULATE(COUNTROWS(Findings), Findings[internet_facing] = "Yes", Findings[severity] = "CRITICAL")
```

---

# PART 7: Build Report Pages

Now let's create visuals (charts, tables, cards).

## Step 7.1: Go to Report view

Click the **chart icon** (left sidebar) to go to Report view.

---

## Step 7.2: Create Page 1 (Executive Summary)

### Add Title

Click **Insert** → **Text Box** → type **Executive Security Dashboard**.

---

### Add KPI Cards

**Card 1: Total Findings**
- Click **Insert** → **Card**
- Drag **Measures[Total Findings]** to the card
- You should see the number appear (e.g., "50")

**Card 2: Open Findings**
- Add another Card
- Drag **Measures[Open Findings]**

**Card 3: Critical Open**
- Add another Card
- Drag **Measures[Critical Open]**

**Card 4: SLA Compliance %**
- Add another Card
- Drag **Measures[SLA Compliance %]**

Arrange cards horizontally at the top.

---

### Add a Bar Chart: Findings by Severity

- Click **Insert** → **Bar Chart**
- Drag **Findings[severity]** to Axis
- Drag **Measures[Total Findings]** to Value
- Title: "Findings by Severity"

---

### Add a Table: Top Open Findings

- Click **Insert** → **Table**
- Drag columns: **finding_id**, **severity**, **status**, **Days Open**
- Filter to show only `status = "Open"` and sort by `Days Open` descending
- Title: "Top 10 Oldest Open Findings"

---

## Step 7.3: Create Page 2 (Operational)

Click the **+** icon to add a new page.

### Add Trend Line: Open vs Closed over time

- Click **Insert** → **Line Chart**
- Drag **DateTable[YearMonth]** to Axis
- Drag **Measures[Open Findings]** to Values (creates one line)
- Drag **Measures[Closed Findings]** to Values (creates second line)
- Title: "Findings Trend"

### Add Matrix: SLA Status by Assignment Group

- Click **Insert** → **Matrix**
- Rows: **Tickets[assignment_group]**
- Columns: **Tickets[sla_status]**
- Values: **Measures[Total Findings]** (count)

### Add Gauge: SLA Compliance %

- Click **Insert** → **Gauge Chart**
- Value: **Measures[SLA Compliance %]**
- Minimum Value: 0, Target: 100
- Title: "SLA Compliance Target"

---

## Step 7.4: Create Page 3 (Risk Analysis)

Click **+** to add a new page.

### Add Scatter Plot: Internet-Facing vs Severity

- Click **Insert** → **Scatter Chart**
- X Axis: **Findings[Days Open]**
- Y Axis: **Findings[Severity Order]** (so CRITICAL at top)
- Legend: **Findings[internet_facing]**
- Title: "Risk Exposure: Internet-Facing + Age"

---

# PART 8: Publish and Use

## Step 8.1: Save locally

**File** → **Save** → Save as `CSPM_MCP_Report.pbix` in your `PowerBI_Project` folder.

---

## Step 8.2: Publish to Power BI Service (optional)

**File** → **Publish** (requires Power BI Pro account and internet).

Select your workspace → **Select**.

---

## Step 8.3: Set up refresh

For your MCP server to refresh data:

**Home** → **Refresh** (to manually refresh)

For **automatic refresh**: 
- Publish to Power BI Service
- Settings → **Dataset settings** → **Scheduled refresh**
- Set frequency (e.g., daily at 6 AM)

---

# 📋 Troubleshooting

## Problem: "Unable to connect to localhost:5000"
**Solution:** 
- Check MCP server is still running in PowerShell
- Verify no other app is using port 5000
- Try `http://127.0.0.1:5000/mcp/health` in browser

## Problem: "Column not found" in Power Query
**Solution:**
- Check CSV file headers match exactly (case-sensitive)
- Verify CSV files are in `PowerBI_Project/data/` folder

## Problem: Relationships don't appear in Model view
**Solution:**
- Check columns have same data type (both text, both date, etc.)
- Drag carefully from one column header to the other

## Problem: DAX formula gives error
**Solution:**
- Copy formula exactly as shown (including brackets and commas)
- Click outside measure formula box to save

---

# 🎉 You're Done!

You now have a working Power BI report built with MCP metadata + data.

**Next steps:**
1. Keep MCP server running for live data
2. Add more pages/visuals as needed
3. Share report link with team
4. Set up automatic refresh schedule

Congratulations! 🚀$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Excel_Data_Analysis_Complete_Tutorial$VELSEC$, $VELSEC$Excel Data Analysis Complete Tutorial$VELSEC$, $VELSEC$Data Analyst$VELSEC$, ARRAY['Data_Analytics']::TEXT[], $VELSEC$# 📊 Complete Excel Tutorial for Data Analysis — From Zero to Dashboard

> **What you'll learn:** Excel basics → Power Query → 20+ formulas → Pivot Tables → Interactive Dashboard
> **Data used:** Employee HR dataset + Call center dataset (1,000 records)
> **Level:** Beginner to Advanced | **Estimated time:** 4-5 hours hands-on

---

# TABLE OF CONTENTS

| # | Section | Key Skills |
|---|---------|-----------|
| 1 | [Excel Basics](#part-1-excel-basics) | Filters, sorting, duplicates, conditional formatting, auto-sum |
| 2 | [Power Query](#part-2-power-query) | Web scraping, file connections, transformations, M language |
| 3 | [Formulas & Functions](#part-3-excel-formulas--functions) | COUNTIFS, SUMIFS, FILTER, VLOOKUP, XLOOKUP, INDEX MATCH |
| 4 | [Pivot Tables & Charts](#part-4-pivot-tables-slicers--charts) | 10 analysis themes, slicers, conditional formatting, grouping |
| 5 | [Portfolio Dashboard](#part-5-portfolio-dashboard-project) | Power Pivot, DAX measures, interactive charts, slicer-driven dashboard |

---

# PART 1: EXCEL BASICS

## 1.1 The Excel Interface

When you open a blank Excel file, the screen is divided into **3 main areas**:

```
┌──────────────────────────────────────────────────────────┐
│  RIBBON (Home, Insert, Data, etc.)                        │ ← All buttons/tools
├──────────────────────────────────────────────────────────┤
│                                                          │
│  GRID AREA                                               │
│  ├── Columns: A, B, C, D, E...                          │
│  ├── Rows: 1, 2, 3, 4, 5...                             │
│  └── Cell = intersection of row + column (e.g., B3)     │
│                                                          │
│  The grid is divided into SHEETS (tabs at the bottom)    │
│  Click [+] to add more sheets                            │
│                                                          │
├──────────────────────────────────────────────────────────┤
│  STATUS BAR (bottom) — shows count, sum, zoom control    │
└──────────────────────────────────────────────────────────┘
```

**Key concept:** A **cell** is where you put values — numbers, text, images, or formulas.

---

## 1.2 Filtering Data

Filtering lets you **view a subset** of your data based on conditions.

### How to Apply Filters

```
Step 1: Select all data
        → Ctrl+A (select all)
        → OR Ctrl+Shift+8 (select contiguous data)

Step 2: Home ribbon → Sort & Filter → Filter
        → Shortcut: Ctrl+Shift+L

Step 3: Click the dropdown arrow (▼) on any column header
        → Check/uncheck values to filter
```

### Filter Types

| Filter Type | How to Use | Example |
|------------|-----------|---------|
| **Single value** | Uncheck "Select All", check one value | Show only "Chennai" employees |
| **Multiple values** | Check multiple items | Show "Chennai" + "Wellington" |
| **Multi-column** | Apply filters on different columns | Location = Chennai AND Gender = Female |
| **Number filter** | Column ▼ → Number Filters → Greater Than | Salary > $80,000 |
| **Date filter** | Column ▼ → Date Filters → Last Month/Quarter/Year | Employees joined last quarter |
| **Top N** | Column ▼ → Number Filters → Top 10 | Show top 10 salaries |
| **Right-click** | Right-click a cell → Filter → By selected cell value | Quick filter on any value |

### Clearing Filters

```
Clear ONE column:  Click column ▼ → Clear Filter from [column name]
Clear ALL columns: Home → Sort & Filter → Clear
                   OR: Alt → H → S → C (keyboard sequence)
```

> **Pro Tip:** Press **Alt** briefly to see keyboard shortcuts for every ribbon button. Then press the letter sequence to reach any button without using the mouse.

---

## 1.3 Sorting Data

Sorting arranges your data in ascending or descending order.

```
Single-level sort:
  Click column header ▼ → Sort Smallest to Largest (or A to Z)

Multi-level sort (e.g., Gender first, then Salary within gender):
  Home → Sort & Filter → Custom Sort
  → Level 1: Sort by Gender (A to Z)
  → Level 2: Then by Salary (Smallest to Largest)
```

---

## 1.4 Finding Duplicates with Conditional Formatting

```
Step 1: Select the column you want to check (e.g., Employee ID)
        → Ctrl+Shift+Down Arrow (to select entire column)

Step 2: Home → Conditional Formatting → Highlight Cell Rules → Duplicate Values

Step 3: Click OK → all duplicates highlighted in pink

Step 4: To FILTER the duplicates:
        Apply filter → Column ▼ → Filter by Color → select the pink color
        → Now you see only the duplicate rows

Step 5: To REMOVE the highlighting:
        Select cells → Home → Conditional Formatting → Clear Rules → From Selected Cells
```

> **Why this matters:** Duplicate employee IDs with different names = data quality issue. This technique helps you catch them instantly.

---

## 1.5 Quick Summary with Auto-Sum

```
To calculate totals at the bottom of a column:

Step 1: Select the column (Ctrl+Shift+Down Arrow)
Step 2: Press Alt+= (Auto-Sum shortcut)
        → Excel writes =SUM(...) and adds the total below the column

Works for: Salary totals, FTE counts, numeric columns
Does NOT work for: Text columns (use COUNTA instead for counting text)

To examine a formula: Select the cell → press F2 (edit mode)
```

---

# PART 2: POWER QUERY

## 2.1 What is Power Query?

```
Power Query = Data Cleaning + Data Transformation software

✅ Comes built into Excel 2016+ and Power BI
✅ Steps are RECORDED — run them again on new data with one click
✅ Works with: Web pages, Excel files, CSV, text files, PDFs, SQL, SharePoint
✅ Same approach in Excel and Power BI

WHERE TO FIND IT: Data ribbon → Get & Transform Data section
```

## 2.2 Power Query Interface

```
┌──────────────────────────────────────────────────────────────┐
│  RIBBON: Home | Transform | Add Column | View                 │
├──────────┬─────────────────────────────────┬─────────────────┤
│          │                                 │                 │
│  QUERIES │  DATA PREVIEW                   │  APPLIED STEPS  │
│  LIST    │  (shows your data)              │  (what you did) │
│          │                                 │                 │
│  List of │  Each column shows:             │  Source          │
│  all     │  - Column name + type icon      │  Navigation     │
│  queries │  - Green bar = data quality     │  Promoted Headers│
│          │    (% valid / empty / error)    │  Changed Type   │
│          │                                 │  Replaced Value │
│          │                                 │  ...            │
│          │                                 │                 │
│          │  Formula bar: shows M code      │  ⚙ = edit step  │
│          │  for selected step              │  ✕ = delete step│
├──────────┴─────────────────────────────────┴─────────────────┤
│  Enable formula bar: View → check "Formula Bar"              │
└──────────────────────────────────────────────────────────────┘
```

---

## 2.3 Example 1: Web Scraping (Wikipedia Medal Table)

### Step-by-Step

```
1. CONNECT TO WEB
   Data ribbon → From Web → paste URL → OK
   → Navigator screen shows all HTML tables on the page
   → Select the table you want
   → Click "Transform Data" (not "Load" — we want to clean first)

2. PROMOTE HEADERS
   Home → Use First Row as Headers
   → The first data row becomes column headers

3. RENAME COLUMNS
   Double-click any column header → type new name
   Example: Rename "No" → "Country"

4. REPLACE VALUES
   Right-click column → Replace Values
   → Find: *  (asterisk after "Japan" for host nation)
   → Replace with: (nothing)
   → Click OK

5. FILL DOWN (fix merged cells)
   Select the Rank column → Transform → Fill → Down
   → Fills blank cells with the value from the cell above
   → Fixes shared-rank rows where Wikipedia merged cells

6. CHANGE DATA TYPES
   Select columns (Gold, Silver, Bronze, Total) → Right-click → Change Type → Whole Number

7. ADD CALCULATED COLUMN
   Select Gold column → hold Ctrl → select Total column
   → Add Column → Standard → Divide
   → Right-click new column → Change Type → Percentage
   → Now you see gold medals as % of total

8. FILTER OUT TOTALS ROW
   Click Rank column ▼ → uncheck the "Totals" row → OK

9. RENAME QUERY
   Double-click query name in left panel → type "Medals"

10. LOAD TO EXCEL
    Home → Close & Load
    → Data appears as a live, refreshable table in Excel
```

### Key Concept: Dynamic Connection

```
The Power Query connection is LIVE:
  → Right-click the table → Refresh
  → OR: Query ribbon → Refresh
  → Excel re-runs ALL steps against the source and updates data

This means: If the website changes, your Excel updates too!
```

---

## 2.4 Example 2: Local File Connection (Staff Data)

### Common Data Problems & Fixes

| Problem | Power Query Fix | How |
|---------|---------------|-----|
| Wrong headers | Promote first row | Home → Use First Row as Headers |
| Extra spaces in names | Trim | Select column → Transform → Format → Trim |
| `null` in Gender column | Replace values | Right-click → Replace Values → null → "Missing" |
| `???` in Department | Replace values | Right-click → Replace → `???` → "Engineering" |
| Zero/null salary (inactive) | Filter | Click Salary ▼ → uncheck null and 0 |
| Inconsistent dates | Change type | Right-click → Change Type → Date |
| Full name → First + Last | Split column | Transform → Split Column → By Delimiter (Space) |

### Adding Calculated Columns

```
SALARY BUCKET (using Conditional Column):
  Add Column → Conditional Column
  Name: Salary Bucket
  Rules:
    IF Salary < 50000    THEN "Under 50K"
    IF Salary < 100000   THEN "50K to 100K"
    ELSE                      "Above 100K"

EMPLOYEE TENURE (using Date functions):
  Select Start Date → Add Column → Date → Age
  → Gives days since start date
  → Transform → Duration → Total Years
  → Now you see years of service (e.g., 5.61 years)

EMPLOYEE WORK TYPE (using Custom Column):
  Add Column → Custom Column
  Name: Employee Work Type
  Formula: if [FTE] = 1 then "Full Time" else "Part Time"
```

### Editing & Managing Steps

```
Every step you do is recorded in "Applied Steps":

⚙ (gear icon)  = Edit that step's parameters
✕ (x icon)     = Delete that step entirely

Example: If file path changes:
  → Click ⚙ on "Source" step → Browse to new file → OK
  → All subsequent steps replay automatically on the new file!

TO REFRESH after source data changes:
  Right-click the table in Excel → Refresh
  → Power Query replays ALL steps on the updated source file
```

---

# PART 3: EXCEL FORMULAS & FUNCTIONS

## 3.1 Business Problem 1: Total Salary & Head Count by Department

### COUNTIFS — Count with Conditions

```
=COUNTIFS(Staff[Department], B3)

┌─ WHAT: Counts rows where Department matches the value in B3
├─ Staff[Department] = the criteria range (which column to check)
└─ B3 = the criteria value (what to look for — e.g., "Training")

DRAG DOWN to get counts for all departments.

EXCEL 365 TRICK (spilling): Instead of B3, use the entire range B3:B14
  → Formula automatically spills ALL department counts at once!
```

### SUMIFS — Sum with Conditions

```
=SUMIFS(Staff[Salary], Staff[Department], B3:B14)

┌─ WHAT: Adds up salaries where Department matches
├─ Staff[Salary] = what to sum (the numbers)
├─ Staff[Department] = criteria range
└─ B3:B14 = criteria values (all department names)

Multi-criteria version (permanent staff only):
=COUNTIFS(Staff[Department], B3, Staff[Employee Type], "Permanent")
```

### AVERAGEIFS — Average with Conditions

```
=AVERAGEIFS(Staff[Salary], Staff[Department], B3:B14)

Result: Training = $83,400 avg | Engineering = $81,000 | Marketing = $64,000
```

---

## 3.2 Business Problem 2: Filter Employees by Salary

### FILTER Function (Excel 365)

```
Basic: All employees with salary > 100K
=FILTER(Staff, Staff[Salary] > 100000)

With input cell (dynamic threshold):
=FILTER(Staff, Staff[Salary] > F67)
→ Change F67 from 100000 to 115000 = instantly fewer results

Select specific columns only:
=CHOOSECOLS(FILTER(Staff, Staff[Salary] > F67), 1, 2, 3, 5, 6)
→ Returns columns 1,2,3,5,6 (skips column 4)

Add headers:
=CHOOSECOLS(Staff[#Headers], 1, 2, 3, 5, 6)
→ Staff[#Headers] returns the column names of the table
```

### Multiple Conditions in FILTER

```
Female employees with salary > 100K:
=FILTER(Staff, (Staff[Salary] > F67) * (Staff[Gender] = "Female"))

┌─ Each condition gets its own parentheses
├─ Multiply (*) conditions together = AND logic
└─ Add (+) conditions = OR logic

Three conditions (Female, >100K, joined 2020+):
=FILTER(Staff,
    (Staff[Salary] > 100000) *
    (Staff[Gender] = "Female") *
    (YEAR(Staff[Start Date]) >= 2020)
)
```

### Continuous Column Range Syntax

```
Instead of CHOOSECOLS for continuous columns (1-6), use:
=FILTER(Staff[[Employee ID]:[Salary]],
    (Staff[Salary] > 100000) * (Staff[Gender] = "Female"))

Staff[[Employee ID]:[Salary]] = all columns from Employee ID to Salary
→ Cleaner than CHOOSECOLS when columns are contiguous
```

---

## 3.3 Business Problem 3: MIN, MAX, LARGE, SORT+TAKE

### Basic Min/Max

```
Lowest salary:   =MIN(Staff[Salary])          → $28,600
Highest salary:  =MAX(Staff[Salary])          → $120,000
```

### Top 5 Salaries with LARGE

```
=LARGE(Staff[Salary], 1)   → 1st highest = $120,000
=LARGE(Staff[Salary], 2)   → 2nd highest = $120,000
=LARGE(Staff[Salary], 3)   → 3rd highest
...

Pro tip: Put numbers 1-5 in a helper column (e.g., G2:G6)
Then: =LARGE(Staff[Salary], G2) and drag down
```

### Top 5 with SORT + TAKE (Excel 365)

```
=TAKE(SORT(Staff[Salary], , -1), 5)

┌─ SORT(Staff[Salary], , -1) = sort descending (-1)
├─ TAKE( ... , 5) = take first 5 rows from the sorted result
└─ Dynamic: Change 5 to any number, or link to a cell

Even more dynamic:
=TAKE(SORT(Staff[Salary], , -1), I12)
→ Change I12 from 5 → 10 → 8 = different number of results
```

### Gender-Specific Min/Max (MINIFS, MAXIFS)

```
Lowest male salary:   =MINIFS(Staff[Salary], Staff[Gender], "Male")
Highest female salary: =MAXIFS(Staff[Salary], Staff[Gender], "Female")

Top 5 male salaries (FILTER + LARGE):
=LARGE(FILTER(Staff[Salary], Staff[Gender] = "Male"), {1,2,3,4,5})

Or using SORT+TAKE on filtered data:
=TAKE(SORT(FILTER(Staff[Salary], Staff[Gender] = "Male"), , -1), 5)
```

---

## 3.4 Business Problem 4: List Unique Departments

### UNIQUE + SORT

```
All departments (deduplicated):
=UNIQUE(Staff[Department])                → 12 departments

Alphabetically sorted:
=SORT(UNIQUE(Staff[Department]))          → Accounting to Training

Count of departments:
=COUNTA(B4#)
→ B4# = the "spill range" starting at B4 (auto-expands!)
→ The # operator references everything a spilled formula produced
```

### The Hash (#) Operator

```
When a formula "spills" results (like UNIQUE, FILTER, SORT):
  =B4#   references the ENTIRE spilled range
  → If UNIQUE returns 12 items, B4# = B4:B15
  → If UNIQUE grows to 13 items, B4# = B4:B16 (auto-adjusts!)

Use B4# inside other formulas:
  =COUNTA(B4#)        → count the spilled values
  =TEXTJOIN(", ", TRUE, B4#)  → comma-separated list in ONE cell
```

---

## 3.5 Business Problem 5: Lookups (VLOOKUP, INDEX MATCH, XLOOKUP)

### VLOOKUP

```
=VLOOKUP(C4, Staff, 2, FALSE)

┌─ C4 = lookup value (employee ID to find)
├─ Staff = table to search (looks in FIRST column only!)
├─ 2 = column number to return (2 = first name, 3 = last name, etc.)
└─ FALSE = exact match (ALWAYS use FALSE, never omit this!)

LIMITATIONS:
  ❌ Can only look up in the FIRST column of the table
  ❌ No built-in "not found" handling — use IFERROR wrapper:
     =IFERROR(VLOOKUP(C4, Staff, 2, FALSE), "Not Found")
```

### INDEX MATCH

```
=INDEX(Staff[Employee ID], MATCH("Scard", Staff[Last Name], 0))

MATCH: Finds the ROW POSITION of "Scard" in the Last Name column
  → Result: 43 (Scard is the 43rd person)

INDEX: Returns the value at that position from another column
  → INDEX(Staff[Employee ID], 43) = the Employee ID of person #43

ADVANTAGE over VLOOKUP:
  ✅ Can look up in ANY column (not just the first)
  ✅ More flexible for complex scenarios
```

### XLOOKUP (Recommended — Excel 365)

```
=XLOOKUP(C4, Staff[Employee ID], Staff[First Name], "Not Found")

┌─ C4 = what to search for
├─ Staff[Employee ID] = where to search (lookup array)
├─ Staff[First Name] = what to return (return array)
└─ "Not Found" = optional error message (no IFERROR needed!)

ADVANTAGES over VLOOKUP/INDEX MATCH:
  ✅ Lookup in ANY column (not limited to first column)
  ✅ Built-in "if not found" parameter
  ✅ Can return MULTIPLE columns at once
  ✅ Cleaner syntax — one function does it all
```

### XLOOKUP Advanced Tricks

```
Return full name (combine columns in return):
=XLOOKUP(MAX(Staff[Salary]), Staff[Salary],
    Staff[First Name] & " " & Staff[Last Name])
→ Returns: "Minerva Ricardot" (the highest-paid employee)

Return ENTIRE ROW:
=XLOOKUP("Tuxwell", Staff[Last Name], Staff)
→ Returns all columns for that person, horizontally

Transpose to vertical:
=TRANSPOSE(XLOOKUP("Tuxwell", Staff[Last Name], Staff))
→ Same data, but laid out vertically (one field per row)
```

---

## 3.6 Business Problem 6: Finding Highest-Paid Person by Name

### Combining XLOOKUP + MAX

```
First person with highest salary:
=XLOOKUP(MAX(Staff[Salary]), Staff[Salary],
    Staff[First Name] & " " & Staff[Last Name])
→ "Minerva Ricardot"

ALL people with highest salary (in case of ties):
=FILTER(Staff[First Name] & " " & Staff[Last Name],
    Staff[Salary] = MAX(Staff[Salary]))
→ "Minerva Ricardot" and "Mick Praberry" (both at $120K)

Comma-separated in ONE cell:
=TEXTJOIN(", ", TRUE,
    FILTER(Staff[First Name] & " " & Staff[Last Name],
        Staff[Salary] = MAX(Staff[Salary])))
→ "Minerva Ricardot, Mick Praberry"
```

---

## 3.7 Business Problem 7: Employees Joined in March

### Using MONTH() Inside FILTER

```
All employees who joined in March (any year):
=FILTER(Staff[[Employee ID]:[Last Name]],
    MONTH(Staff[Start Date]) = 3)

Employees who joined since 2020:
=FILTER(Staff, Staff[Start Date] >= DATE(2020, 1, 1))

Names starting with "H":
=FILTER(Staff, LEFT(Staff[First Name], 1) = "H")
```

---

## 3.8 Business Problem 8: Department Report with Data Bars

### Percentage Difference from Average

```
Average salary per department:
=AVERAGEIFS(Staff[Salary], Staff[Department], B6#)

Difference from overall average:
=D6# - D3    (D6# = department averages, D3 = overall average)
→ Positive = above average, Negative = below average

Conditional formatting with DATA BARS:
  1. Select the difference column
  2. Home → Conditional Formatting → Data Bars → Solid Fill
  3. Click the tiny icon → "All cells showing 'Difference' values"
  4. Edit Rule: Show Bar Only = YES
  5. Add a separate column: =E6# (duplicates the values for readability)
```

### MAXIFS — Highest Salary per Department

```
=MAXIFS(Staff[Salary], Staff[Department], B6#)
```

---

# PART 4: PIVOT TABLES, SLICERS & CHARTS

## 4.1 Data Preparation

```
ALWAYS convert raw data to a TABLE before creating pivots:

Step 1: Select any cell in the data
Step 2: Ctrl+T → click OK
Step 3: Table Design → rename table (e.g., "Calls")
Step 4: Insert → Pivot Table → New Worksheet → OK
```

## 4.2 The Pivot Table Interface

```
┌──────────────────────────────────────────────────────────┐
│  PIVOT TABLE FIELDS (right panel)                         │
│                                                          │
│  FIELD LIST (top)                                        │
│  ☑ Call Number                                           │
│  ☐ Customer ID                                           │
│  ☐ Duration                                              │
│  ☐ Representative                                        │
│  ☐ Purchase Amount                                       │
│                                                          │
│  AREAS (bottom — drag fields here)                       │
│  ┌────────────┐  ┌────────────┐                         │
│  │  FILTERS   │  │  COLUMNS   │  → across the screen    │
│  └────────────┘  └────────────┘                         │
│  ┌────────────┐  ┌────────────┐                         │
│  │   ROWS     │  │   VALUES   │  → counted/summed/avg   │
│  └────────────┘  └────────────┘                         │
│                                                          │
│  Rows = labels going DOWN the screen                     │
│  Columns = labels going ACROSS the screen                │
│  Values = the NUMBERS (counts, sums, averages)           │
│  Filters = report-level filters (dropdown at top)        │
└──────────────────────────────────────────────────────────┘
```

---

## 4.3 The 10 Analysis Themes

### Theme 1: Calls by Customer

```
ROWS:    Customer ID
VALUES:  Count of Call Number

→ Shows how many calls each customer made (e.g., Customer 4 = 82 calls)
```

### Theme 2: Customer Satisfaction

```
Add Satisfaction Rating to VALUES
→ Default: Sum (ridiculous — "249" total satisfaction)
→ Fix: Right-click number → Summarize Values By → Average
→ Fix decimals: Right-click → Number Format → Number → 1 decimal

Result: Average rating per customer, overall average = 3.9
```

### Theme 3: Top 10 Customers (Value Filters + Slicers)

```
ROWS:    Customer ID
VALUES:  Sum of Purchase Amount

Apply Top 10 filter:
  Click Customer ID ▼ → Value Filters → Top 10 → OK
  Right-click → Sort → Largest to Smallest

Add report-level filter:
  Drag Representative to FILTERS area
  → Filter dropdown appears above pivot
  → Select specific rep to see THEIR top 10

SLICERS (better than report filters!):
  Right-click Representative → Add as Slicer
  → Click buttons to filter interactively
  → Ctrl+Click for multi-select
  → Linked to pivot charts too!
```

### Theme 4: Interactive Pivot Chart

```
Step 1: Select any pivot cell
Step 2: Insert → Column Chart
Step 3: The chart is MARRIED to the pivot table:
        → Change the slicer = chart updates
        → Expand/collapse pivot rows = chart updates
        → Filter the pivot = chart filters too
```

### Theme 5: Call Duration Analysis (Grouping)

```
ROWS:    Duration
VALUES:  Count of Call Number

Manual grouping:
  Select range of values (e.g., 2-10) → Right-click → Group
  Repeat for 10-30, 30-60, 60-120, 120+

⚠️ PROBLEM with manual grouping:
  If new data has a value NOT in any group (e.g., 9),
  it creates its OWN separate group!

✅ BETTER APPROACH: Use formulas in source data:
  =IFS(Duration<=10, "Under 10 min",
       Duration<=30, "10-30 min",
       Duration<=60, "30-60 min",
       Duration<=120, "1-2 hours",
       TRUE, "More than 2 hours")
  → Always works, even with new data values
```

### Theme 6: Monthly Call Trends (Date Grouping)

```
ROWS:    Date of Call → Excel auto-groups by Month
VALUES:  Count of Call Number

Date auto-grouping:
  → Excel adds: Years, Quarters, Months, Days as fields
  → Click [+] on any month to expand to daily detail
  → Pivot chart updates when you expand/collapse

Add line chart:
  Insert → Line Chart → see call volume trends over the year
  → Jan/Feb slow, March-May peak, October-November peak
```

### Theme 7: Year-to-Date Running Totals

```
VALUES:  Sum of Purchase Amount
→ Right-click → Show Values As → Running Total In → Month
→ December shows $96,000 (cumulative total)

Add area chart to visualize the S-curve of revenue accumulation.

Financial Year (FY) calculation:
  Add column in source data:
  =IF(MONTH(Date) <= 6, YEAR(Date), YEAR(Date) + 1)
  → Refresh pivot → use FY as a Row field above Month
  → Running total resets at FY boundary (July → new FY)
```

### Theme 8: Busiest Day of Week (Heatmap)

```
COLUMNS: Day of Week (from =TEXT(Date, "DDDD"))
ROWS:    Representative
VALUES:  Count of Call Number

Show as percentages:
  Right-click → Show Values As → % of Row Total

Apply heatmap:
  Home → Conditional Formatting → Color Scales → Green-Red
  → Click the tiny icon → select "All cells showing Values"
  → Instantly see: Saturday is consistently busiest day

INSIGHT: Tell boss "Saturday is our peak day — customers
are free on weekends and call us more."
```

### Theme 9: Duration vs Satisfaction (Cross-Analysis)

```
ROWS:    Duration Bucket
COLUMNS: Rating Rounded (0-5)
VALUES:  Count of Call Number

REORDER rows manually:
  Click on "Under 10 min" → place cursor on cell border
  → Drag to correct position (top)
  
Apply conditional formatting to spot patterns:
  → Shorter calls = higher satisfaction %
  → Conclusion: "Keep calls quick and to-the-point"
```

### Theme 10: Staffing Recommendations

```
ROWS:    Representative
COLUMNS: Month
VALUES:  Count of Call Number

Apply data bars:
  → Spot months where a rep has 2x their normal volume
  
Example insight:
  "R02 gets ~20 calls/month normally but spikes to 40 in March/April.
   Recommend temp support for R02 during Q1 peak."
```

---

# PART 5: PORTFOLIO DASHBOARD PROJECT

## 5.1 Project Overview

```
BUILD THIS: An interactive Call Center Performance Dashboard

FEATURES:
├── Slicer to select representatives (with photos!)
├── KPI cards: Total calls, selected calls, amount, duration, rating
├── Bar chart: Calls by representative (selected one highlighted)
├── Bar chart: Revenue by representative
├── Customer table by city/region
├── Dynamic — all visuals update when slicer selection changes
```

## 5.2 Data Setup

```
TWO TABLES:
├── Calls table (1,000 rows): Call#, Customer, Duration, Rep, Date,
│   Purchase Amount, Rating, FY, Day of Week, Duration Bucket, Rating Rounded
│
└── Customers table (15 rows): Customer ID, Gender, Age, City
    (Cities: Columbus, Cincinnati, Cleveland)

ASSETS TAB: Representative photos (stock images from Excel)
```

## 5.3 Step 1: Color Theme & Fonts

```
Page Layout → Colors → select "Slipstream"
Page Layout → Fonts → select "Aptos ExtraBold + Aptos"
  (Or customize: Page Layout → Fonts → Customize Fonts)

WHY DO THIS FIRST:
  All subsequent tables, charts, and formatting will inherit
  these choices automatically. Saves massive formatting time later.
```

## 5.4 Step 2: Set Up Pivot Tables Using Data Model

```
SELECT any cell in Calls table
→ Insert → Pivot Table
→ ☑ CHECK "Add this data to the Data Model"  ← IMPORTANT!
→ New Worksheet → OK
→ Rename sheet as "Pivots"

WHY Data Model:
  Enables relationships between multiple tables (Calls + Customers)
  Enables DAX measures (powerful calculated fields)
  Enables Power Pivot features
```

### Create Table Relationship

```
Pivot Table Analyze → Relationships → New

Table:         Calls
Column:        Customer ID
Related Table: Customers
Related Column: Customer ID

→ Now fields from BOTH tables appear in the pivot field list
→ Use "All" tab to see both Calls and Customers fields
```

## 5.5 Step 3: Create DAX Measures

DAX (Data Analysis Expressions) is the formula language for Power Pivot. Unlike regular formulas, DAX measures live **inside the data model** and automatically respect slicer/filter context.

### How to Add a Measure

```
In the PivotTable Fields list:
  Right-click on table name (e.g., "Calls") → Add Measure
  → Give it a name
  → Write the DAX formula
  → Set number format
  → Click OK
  → The measure appears in the field list (with a tiny calculator icon)
```

### The 5 Essential Measures

```dax
// MEASURE 1: Call Count
Call Count = COUNTROWS(Calls)
Format: Number, 0 decimals, use thousands separator

// MEASURE 2: Total Amount
Total Amount = SUM(Calls[Purchase Amount])
Format: Currency, 0 decimals

// MEASURE 3: Total Duration
Total Duration = SUM(Calls[Duration])
Format: Number, 0 decimals

// MEASURE 4: Average Rating
Average Rating = AVERAGE(Calls[Satisfaction Rating])
Format: Number, 1 decimal

// MEASURE 5: Five Star Calls
Five Star Calls = CALCULATE(
    [Call Count],
    Calls[Rating Rounded] = 5
)
Format: Number, 0 decimals
```

> **Key concept — CALCULATE:** This function modifies the filter context. `CALCULATE([Call Count], Rating = 5)` means "count rows, but ONLY where rating = 5." This is the most powerful DAX function.

## 5.6 Step 4: Build Pivot Tables

```
PIVOT 1: "Summary Pivot" (overall KPIs)
  VALUES: Call Count, Total Amount, Total Duration, Average Rating, Five Star Calls
  NO ROWS/COLUMNS — just shows one summary row of totals

PIVOT 2: "Rep Pivot" (per-representative KPIs)
  Copy Pivot 1 (Ctrl+C → Ctrl+V)
  Rename as "Rep Pivot"
  Add Representative slicer → connects ONLY to this pivot

PIVOT 3: "Rep-Customer-City Pivot" (for the customer table by city)
  ROWS: City (from Customers table), then Customer ID
  VALUES: Call Count, Total Amount
  Add same Representative slicer connection

PIVOT 4: "Rep Chart Pivot" (for bar charts)
  ROWS: Representative
  VALUES: Call Count, Total Amount
  Connect to same slicer
```

## 5.7 Step 5: Add Slicers & Connect to Multiple Pivots

```
Create slicer:
  Right-click Representative → Add as Slicer

Connect slicer to MULTIPLE pivots:
  Right-click the slicer → Report Connections
  → Check ALL pivot tables you want this slicer to control
  → Now ONE slicer drives ALL pivots simultaneously!

Slicer formatting:
  Slicer → Options → Columns: 5 (show all 5 reps in one row)
  Slicer → Options → customize button height/width
```

## 5.8 Step 6: Build the Dashboard Layout

```
┌──────────────────────────────────────────────────────────────┐
│  CALL CENTER PERFORMANCE DASHBOARD          [Rep Photo]       │
│                                                              │
│  ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐              │
│  │R01   │ │R02   │ │R03   │ │R04   │ │R05   │  ← SLICER    │
│  └──────┘ └──────┘ └──────┘ └──────┘ └──────┘              │
│                                                              │
│  ┌───────────────┐ ┌───────────────┐ ┌───────────────┐      │
│  │ TOTAL CALLS   │ │ TOTAL AMOUNT  │ │ AVG RATING    │      │
│  │    1,000      │ │   $96,623     │ │    3.9        │      │
│  │ Selected: 214 │ │ Sel: $20,412  │ │  ★★★★☆       │      │
│  └───────────────┘ └───────────────┘ └───────────────┘      │
│                                                              │
│  ┌──────────────────────┐  ┌─────────────────────────────┐  │
│  │ CALLS BY REP         │  │ CUSTOMER TABLE BY CITY      │  │
│  │ (Bar chart)          │  │                             │  │
│  │ ████ R01 = 214       │  │ Cincinnati                  │  │
│  │ ████ R02 = 198  ←HL  │  │  C001  42  $4,200          │  │
│  │ ████ R03 = 195       │  │  C005  55  $5,500          │  │
│  │ ████ R04 = 199       │  │ Cleveland                   │  │
│  │ ████ R05 = 194       │  │  C002  38  $3,800          │  │
│  └──────────────────────┘  └─────────────────────────────┘  │
│                                                              │
│  ┌──────────────────────┐                                    │
│  │ AMOUNT BY REP        │                                    │
│  │ (Bar chart)          │                                    │
│  │ ████ R01 = $20,412   │                                    │
│  └──────────────────────┘                                    │
└──────────────────────────────────────────────────────────────┘
```

### Dashboard Construction Steps

```
Step 1: CREATE the dashboard sheet
  → Add new sheet → rename "Call Center Report"
  → Make first two columns narrow (cosmetic margin)
  → Select a large range → fill with light gray background

Step 2: REFERENCE the pivot table values
  → In KPI card cells, use = to reference Summary Pivot values
  → In "Selected" sub-values, reference Rep Pivot values
  → Both pivots use the SAME DAX measures (Call Count, Total Amount, etc.)
  → When slicer changes, Rep Pivot updates → dashboard cards update!

Step 3: CREATE charts from the chart pivot tables
  → Select Rep Chart Pivot → Insert → Bar Chart
  → Move chart to the dashboard sheet
  → Format: remove gridlines, remove legend, add data labels
  → The selected rep's bar is auto-highlighted by the slicer

Step 4: FORMAT the customer table
  → Reference the Rep-Customer-City pivot
  → Add conditional formatting to highlight selected rep's data

Step 5: ADD representative photo
  → Use INDEX to select the correct image based on slicer
  → Or use a formula to swap images dynamically
```

## 5.9 Step 7: Highlighting the Selected Representative

```
TO HIGHLIGHT the selected rep's bar in the chart:

Method: Use a "helper" measure in DAX

// This measure returns the amount ONLY for the selected rep
Selected Rep Amount = CALCULATE(
    [Total Amount],
    ALLSELECTED(Calls[Representative])
)

// Another measure shows amount for ALL reps (ignores slicer)
All Rep Amount = CALCULATE(
    [Total Amount],
    ALL(Calls[Representative])
)

→ Plot BOTH measures as overlapping bars
→ The "Selected" bar appears highlighted (different color)
→ The "All" bar shows the base (lighter color)
```

## 5.10 Step 8: Final Polish

```
FORMATTING CHECKLIST:
  ✅ Remove gridlines: View → uncheck Gridlines
  ✅ Remove headings: View → uncheck Headings
  ✅ Set print area if needed
  ✅ Lock cells to prevent accidental edits
  ✅ Hide the Pivots sheet (right-click tab → Hide)
  ✅ Hide row/column headers
  ✅ Add company logo and title with styled text
  ✅ Use consistent colors from your theme
  ✅ Test all slicer combinations

INTERACTION TESTING:
  → Click each rep → verify ALL visuals update
  → Multi-select reps (Ctrl+Click) → verify aggregation
  → Clear slicer → verify "All" state shows correctly
```

---

# PART 6: FORMULA CHEAT SHEET

## Quick Reference — All Functions Covered

| Category | Function | Syntax | Purpose |
|----------|----------|--------|---------|
| **Counting** | `COUNTIFS` | `=COUNTIFS(range, criteria)` | Count rows matching criteria |
| | `COUNTA` | `=COUNTA(range)` | Count non-empty cells |
| **Summing** | `SUMIFS` | `=SUMIFS(sum_range, criteria_range, criteria)` | Sum values matching criteria |
| | `SUM` | `=SUM(range)` | Sum all values |
| **Averaging** | `AVERAGEIFS` | `=AVERAGEIFS(avg_range, criteria_range, criteria)` | Average matching criteria |
| | `AVERAGE` | `=AVERAGE(range)` | Average all values |
| **Min/Max** | `MIN` / `MAX` | `=MIN(range)` | Smallest / largest value |
| | `MINIFS` / `MAXIFS` | `=MINIFS(range, criteria_range, criteria)` | Min/Max with conditions |
| | `LARGE` | `=LARGE(range, k)` | k-th largest value |
| **Lookup** | `VLOOKUP` | `=VLOOKUP(value, table, col#, FALSE)` | Vertical lookup (first column only) |
| | `INDEX+MATCH` | `=INDEX(return, MATCH(value, lookup, 0))` | Flexible lookup (any column) |
| | `XLOOKUP` | `=XLOOKUP(value, lookup, return, "not found")` | Modern lookup (any direction) |
| **filtering** | `FILTER` | `=FILTER(data, condition)` | Extract rows meeting criteria |
| | `UNIQUE` | `=UNIQUE(range)` | Remove duplicates |
| | `SORT` | `=SORT(range, col, order)` | Sort data (-1 = descending) |
| | `TAKE` | `=TAKE(range, rows)` | First N rows from range |
| | `CHOOSECOLS` | `=CHOOSECOLS(range, col1, col2...)` | Select specific columns |
| **Text** | `TEXTJOIN` | `=TEXTJOIN(", ", TRUE, range)` | Combine text with delimiter |
| | `LEFT` | `=LEFT(text, n)` | First n characters |
| | `TEXT` | `=TEXT(date, "DDDD")` | Format value as text |
| | `TRIM` | `=TRIM(text)` | Remove extra spaces |
| **Date** | `YEAR` / `MONTH` / `DAY` | `=MONTH(date)` | Extract date parts |
| | `DATE` | `=DATE(2020, 1, 1)` | Create a date |
| **Logic** | `IF` | `=IF(condition, true, false)` | Single condition |
| | `IFS` | `=IFS(cond1, val1, cond2, val2...)` | Multiple conditions |
| | `IFERROR` | `=IFERROR(formula, "error msg")` | Handle errors gracefully |
| **Other** | `ROUND` | `=ROUND(number, decimals)` | Round a number |
| | `TRANSPOSE` | `=TRANSPOSE(range)` | Flip rows ↔ columns |

---

## Essential Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Ctrl+A` | Select all data |
| `Ctrl+Shift+L` | Toggle filters on/off |
| `Ctrl+Shift+↓` | Select to bottom of column |
| `Ctrl+Shift+→` | Select to end of row |
| `Ctrl+T` | Convert to table |
| `Ctrl+Shift+8` | Select current region |
| `Alt+=` | Auto-sum |
| `F2` | Edit cell (see formula) |
| `F4` | Toggle absolute reference ($) |
| `Ctrl+Shift+4` | Currency format |
| `Ctrl+Shift+3` | Date format |
| `Ctrl+C / Ctrl+V` | Copy / Paste |
| `Ctrl+S` | Save |
| `Alt` (tap briefly) | Show ribbon shortcuts |
| `Alt+H+S+C` | Clear all filters |

---

## DAX Measures Reference (Power Pivot)

```dax
// Count rows
COUNTROWS(TableName)

// Sum a column
SUM(Table[Column])

// Average a column
AVERAGE(Table[Column])

// Count with filter (THE most powerful DAX function)
CALCULATE(
    [MeasureName],              // What to calculate
    Table[Column] = "Value"     // Filter to apply
)

// Example: Count only 5-star calls
Five Star = CALCULATE([Call Count], Calls[Rating Rounded] = 5)

// Ignore slicer context (show ALL regardless of slicer)
ALL(Table[Column])

// Respect slicer but show selected subset
ALLSELECTED(Table[Column])
```$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Excel_Skills_Mastery_Guide$VELSEC$, $VELSEC$Excel Skills Mastery Guide$VELSEC$, $VELSEC$Data Analyst$VELSEC$, ARRAY['Data_Analytics']::TEXT[], $VELSEC$# 📗 EXCEL SKILLS MASTERY — Basic to Advanced with Practicals

> **For:** Wells Fargo Findings Management — Extract, Clean, Shape, Report, Audit
> **Approach:** Every concept has a practical exercise using security findings data

---

# MODULE 1: EXCEL FUNDAMENTALS (30 min)

## 1.1 Workbook Structure

```
WORKBOOK (.xlsx) → contains multiple SHEETS (tabs)

For our security work, create these sheets:
├── Sheet 1: "Raw_Findings"      → paste Wiz export here
├── Sheet 2: "CMDB_Lookup"       → paste CMDB data here
├── Sheet 3: "Analysis"          → your formulas & calculations
├── Sheet 4: "PivotTable"        → summary pivots
└── Sheet 5: "Dashboard"         → visual summary for management
```

## 1.2 Cell References — The Foundation

```excel
// RELATIVE reference (changes when copied):
=A2 + B2     → when copied down: =A3 + B3, =A4 + B4...

// ABSOLUTE reference (stays fixed with $):
=$A$2 + B2   → when copied down: =$A$2 + B3, =$A$2 + B4...

// MIXED reference:
=$A2          → column locked, row changes
=A$2          → row locked, column changes

WHEN TO USE WHAT:
├── Relative: most formulas (auto-adjust when copying)
├── Absolute: lookup ranges, constants, target values
└── Mixed: building matrices (lock row OR column)
```

## 1.3 Essential Functions — Level 1

```excel
// COUNTING
=COUNT(A2:A100)        → counts cells with numbers
=COUNTA(A2:A100)       → counts non-empty cells (text + numbers)
=COUNTBLANK(A2:A100)   → counts empty cells
=COUNTIF(D2:D100, "CRITICAL")    → count cells matching criteria
=COUNTIFS(D2:D100, "CRITICAL", G2:G100, "Open")  → multiple criteria

// SUMMING
=SUM(H2:H100)          → add all values
=SUMIF(D2:D100, "HIGH", H2:H100)  → sum where severity is HIGH
=SUMIFS(H2:H100, D2:D100, "HIGH", G2:G100, "Open")  → multiple criteria

// AVERAGING
=AVERAGE(H2:H100)      → average of all
=AVERAGEIF(D2:D100, "CRITICAL", H2:H100)  → avg where Critical
=AVERAGEIFS(H2:H100, D2:D100, "CRITICAL", G2:G100, "Closed")

// MIN / MAX
=MIN(H2:H100)          → lowest value
=MAX(H2:H100)          → highest value
=MINIFS(H2:H100, D2:D100, "CRITICAL")  → min for Critical only
```

### 🔧 PRACTICAL 1: Basic Counts

```
SETUP: Open wiz_findings.csv from the PowerBI_Project/data/ folder

In a new sheet called "Analysis", create these:

Cell A1: "METRIC"              Cell B1: "VALUE"
Cell A2: "Total Findings"      Cell B2: =COUNTA(Raw_Findings!A2:A51)
Cell A3: "Open Findings"       Cell B3: =COUNTIF(Raw_Findings!F2:F51,"Open")
Cell A4: "Closed Findings"     Cell B4: =COUNTIF(Raw_Findings!F2:F51,"Closed")
Cell A5: "Critical Open"       Cell B5: =COUNTIFS(Raw_Findings!D2:D51,"CRITICAL",Raw_Findings!F2:F51,"Open")
Cell A6: "High Open"           Cell B6: =COUNTIFS(Raw_Findings!D2:D51,"HIGH",Raw_Findings!F2:F51,"Open")
Cell A7: "Medium Open"         Cell B7: =COUNTIFS(Raw_Findings!D2:D51,"MEDIUM",Raw_Findings!F2:F51,"Open")
Cell A8: "Low Open"            Cell B8: =COUNTIFS(Raw_Findings!D2:D51,"LOW",Raw_Findings!F2:F51,"Open")
Cell A9: "Azure Findings"      Cell B9: =COUNTIF(Raw_Findings!E2:E51,"Azure")
Cell A10: "GCP Findings"       Cell B10: =COUNTIF(Raw_Findings!E2:E51,"GCP")

EXPECTED RESULTS:
Total: 50, Open: 40, Closed: 10, CritOpen: 8, HighOpen: 14, MedOpen: 13, LowOpen: 5
```

---

# MODULE 2: LOOKUP FUNCTIONS (45 min)

## 2.1 VLOOKUP — The Classic

```excel
// Syntax: =VLOOKUP(lookup_value, table_array, col_index, [exact_match])

=VLOOKUP(A2, CMDB!$A:$F, 4, FALSE)
//        ↑       ↑        ↑    ↑
//   what to     where    which  FALSE = exact match
//   look for    to look  column (ALWAYS use FALSE)
//               (must be to
//               first col) return

LIMITATIONS:
├── Can only look RIGHT (lookup column must be leftmost)
├── Returns only ONE value (first match)
├── Breaks if columns are inserted/deleted
└── col_index is a number — hard to maintain
```

## 2.2 XLOOKUP — The Replacement (Excel 365+)

```excel
// Syntax: =XLOOKUP(lookup_value, lookup_array, return_array, [not_found], [match_mode], [search_mode])

=XLOOKUP(A2, CMDB!$B:$B, CMDB!$D:$D, "NOT FOUND")
//       ↑       ↑            ↑            ↑
//   what to   where to     what to      if no
//   find      search       return       match

ADVANTAGES OVER VLOOKUP:
├── Can look LEFT, RIGHT, or any direction
├── Has built-in "not found" value
├── Exact match by default
├── Can return multiple columns at once
├── Doesn't need column index number
└── More readable
```

## 2.3 INDEX-MATCH — The Power Combo

```excel
// Syntax: =INDEX(return_range, MATCH(lookup_value, lookup_range, 0))

=INDEX(CMDB!$D:$D, MATCH(A2, CMDB!$B:$B, 0))
//        ↑                ↑       ↑       ↑
//   column to       what to   where    0 = exact
//   return from     find      to look  match

WHY USE INDEX-MATCH:
├── Works in ALL Excel versions (XLOOKUP needs 365)
├── Can look in any direction
├── More flexible than VLOOKUP
├── Faster on large datasets
└── Can do multi-criteria lookups (see below)

// MULTI-CRITERIA INDEX-MATCH:
=INDEX(CMDB!$D:$D, MATCH(A2&B2, CMDB!$A:$A&CMDB!$B:$B, 0))
// Press Ctrl+Shift+Enter (array formula in older Excel)
// Matches where BOTH resource_id AND cloud match
```

### 🔧 PRACTICAL 2: Lookup Owner from CMDB

```
SETUP:
1. Open wiz_findings.csv in Sheet "Findings"
2. Open cmdb_assets.csv in Sheet "CMDB"
3. In Findings sheet, add column header in cell L1: "Owner"

EXERCISE 1 — VLOOKUP:
Cell L2: =VLOOKUP(H2, CMDB!$B:$D, 3, FALSE)
// Looks up resource_id (col H) in CMDB col B, returns col D (owner)
// Copy down to L51

EXERCISE 2 — XLOOKUP (if you have Excel 365):
Cell M1: "Owner_XL"
Cell M2: =XLOOKUP(H2, CMDB!$B:$B, CMDB!$D:$D, "UNASSIGNED")
// Same result but with "UNASSIGNED" for any unmatched findings

EXERCISE 3 — INDEX-MATCH:
Cell N1: "Owner_IM"
Cell N2: =INDEX(CMDB!$D:$D, MATCH(H2, CMDB!$B:$B, 0))

EXERCISE 4 — Get Assignment Group too:
Cell O1: "Team"
Cell O2: =XLOOKUP(H2, CMDB!$B:$B, CMDB!$F:$F, "UNASSIGNED")
// Returns the assignment_group for this finding

VERIFY: Finding WIZ-001 (stgprod01) should return "Rajesh Kumar"
VERIFY: Finding WIZ-012 (gke-prod-01) should return "Kevin Zhang"
```

### 🔧 PRACTICAL 3: Handle Missing Lookups

```
EXERCISE 5 — Count unmatched findings:
Cell A15: "Unmatched Findings"
Cell B15: =COUNTIF(M2:M51, "UNASSIGNED")
// Shows how many findings have no CMDB entry (orphaned assets)

EXERCISE 6 — IFERROR with VLOOKUP:
Cell P1: "Owner_Safe"
Cell P2: =IFERROR(VLOOKUP(H2, CMDB!$B:$D, 3, FALSE), "⚠️ NOT IN CMDB")
// Shows warning for any unmatched items

EXERCISE 7 — Flag orphaned assets:
Cell Q1: "CMDB_Status"
Cell Q2: =IF(ISNA(MATCH(H2, CMDB!$B:$B, 0)), "❌ ORPHANED", "✅ REGISTERED")
// Binary flag: is this asset in CMDB or not?
```

---

# MODULE 3: TEXT & DATE FUNCTIONS (30 min)

## 3.1 Text Functions

```excel
// CONCATENATION
=A2 & " - " & B2              → "WIZ-001 - S3 Bucket Public Access"
=TEXTJOIN(", ", TRUE, A2:A5)   → "WIZ-001, WIZ-002, WIZ-003, WIZ-004"

// EXTRACTION
=LEFT(A2, 3)          → "WIZ"
=RIGHT(A2, 3)         → "001"
=MID(A2, 5, 3)        → "001" (start at pos 5, take 3 chars)
=LEN(A2)              → 7

// CLEANING
=TRIM(A2)             → removes extra spaces
=CLEAN(A2)            → removes non-printable characters
=UPPER(D2)            → "CRITICAL"
=LOWER(D2)            → "critical"
=PROPER(D2)           → "Critical"

// SEARCH & REPLACE
=FIND("NSG", C2)      → position of "NSG" in title (error if not found)
=SEARCH("nsg", C2)    → same but case-insensitive
=SUBSTITUTE(C2, "0.0.0.0/0", "ANY")  → replace text
```

## 3.2 Date Functions

```excel
// CURRENT DATE
=TODAY()               → today's date (no time)
=NOW()                 → current date + time

// DATE MATH
=TODAY() - F2          → days since created_date (result is a number)
=DATEDIF(F2, TODAY(), "d")  → days between two dates
=DATEDIF(F2, TODAY(), "m")  → months between

// DATE PARTS
=YEAR(F2)              → 2025
=MONTH(F2)             → 1
=DAY(F2)               → 15
=WEEKNUM(F2)           → week number
=TEXT(F2, "MMM-YYYY")  → "Jan-2025"
=TEXT(F2, "ddd")       → "Wed"

// DATE CREATION
=DATE(2025, 1, 15)     → creates date Jan 15, 2025
=EOMONTH(F2, 0)       → end of same month as F2
=WORKDAY(F2, 7)        → 7 business days after F2
```

### 🔧 PRACTICAL 4: Calculate Finding Age & SLA

```
ADD THESE COLUMNS TO YOUR FINDINGS SHEET:

Cell R1: "Age_Days"
Cell R2: =IF(G2="Closed", F7-F2, TODAY()-F2)
// If closed: days between created and closed
// If open: days since created until today
// Copy down to R51

Cell S1: "SLA_Days"
Cell S2: =SWITCH(D2, "CRITICAL",1, "HIGH",7, "MEDIUM",30, "LOW",90, 90)
// SLA target in days based on severity

Cell T1: "SLA_Pct_Used"
Cell T2: =ROUND(R2/S2*100, 0)
// What percentage of SLA has been consumed

Cell U1: "SLA_Status"
Cell U2: =IF(G2="Closed","✅ Resolved",IF(T2>=100,"🔴 Breached",IF(T2>=75,"🟡 At Risk","🟢 On Track")))
// Visual SLA status with emojis

Cell V1: "Days_Remaining"
Cell V2: =IF(G2="Closed","N/A", MAX(S2-R2, 0))
// Days left before SLA breach (0 if already breached)

Cell W1: "Month_Created"
Cell W2: =TEXT(F2, "MMM-YYYY")
// For grouping by month in PivotTables

VERIFY: WIZ-001 (Critical, created Jan 5) should show Breached (>1 day old)
VERIFY: WIZ-050 (Low, created Mar 20) should show On Track
```

---

# MODULE 4: LOGICAL & CONDITIONAL FUNCTIONS (30 min)

## 4.1 IF, IFS, SWITCH, AND, OR

```excel
// BASIC IF
=IF(D2="CRITICAL", "P1", "P2+")

// NESTED IF (old way — messy)
=IF(D2="CRITICAL","P1", IF(D2="HIGH","P2", IF(D2="MEDIUM","P3","P4")))

// IFS (cleaner — Excel 365)
=IFS(D2="CRITICAL","P1", D2="HIGH","P2", D2="MEDIUM","P3", TRUE,"P4")

// SWITCH (cleanest)
=SWITCH(D2, "CRITICAL","P1", "HIGH","P2", "MEDIUM","P3", "P4")

// AND / OR for complex conditions
=IF(AND(D2="CRITICAL", E2="Yes"), "🚨 URGENT", "Normal")
// Critical AND internet-facing → URGENT

=IF(OR(D2="CRITICAL", D2="HIGH"), "Priority", "Standard")
// Critical OR High → Priority
```

## 4.2 LET — Make Complex Formulas Readable (Excel 365)

```excel
// WITHOUT LET (unreadable):
=IF(((TODAY()-F2)/IF(D2="CRITICAL",1,IF(D2="HIGH",7,30)))>=1,"Breached","OK")

// WITH LET (readable):
=LET(
    age, TODAY()-F2,
    sla, SWITCH(D2, "CRITICAL",1, "HIGH",7, "MEDIUM",30, 90),
    pct, age/sla,
    IF(pct>=1, "🔴 BREACHED",
    IF(pct>=0.75, "🟡 AT RISK",
    "🟢 ON TRACK"))
)
```

### 🔧 PRACTICAL 5: Risk Scoring Formula

```
Cell X1: "Risk_Score"
Cell X2: =LET(
    sev_score, SWITCH(D2, "CRITICAL",40, "HIGH",30, "MEDIUM",20, "LOW",10),
    exposure, IF(K2="Yes", 25, 0),
    data_score, SWITCH(L2, "Restricted",25, "Confidential",20, "Internal",10, "Public",5, 10),
    age_score, MIN(R2/7*10, 10),
    sev_score + exposure + data_score + age_score
)

// Scoring:
// Severity:      CRITICAL=40, HIGH=30, MEDIUM=20, LOW=10
// Internet-facing: Yes=25, No=0
// Data class:    Restricted=25, Confidential=20, Internal=10, Public=5
// Age factor:    +10 for every 7 days old (max 10)
// MAX SCORE: 100

Cell Y1: "Risk_Level"
Cell Y2: =IF(X2>=80,"🔴 CRITICAL",IF(X2>=60,"🟠 HIGH",IF(X2>=40,"🟡 MEDIUM","🟢 LOW")))

VERIFY: WIZ-001 (Critical+Internet+Confidential+Old) should be 80+
VERIFY: WIZ-050 (Low+NoInternet+Internal+New) should be <40
```

---

# MODULE 5: PIVOTTABLES (45 min)

## 5.1 Creating Your First PivotTable

```
STEPS:
1. Click anywhere in your Findings data
2. Insert → PivotTable → New Worksheet
3. Name the sheet "PivotAnalysis"
4. The PivotTable Fields pane appears on the right
```

## 5.2 PivotTable Configurations

### 🔧 PRACTICAL 6: Build 5 PivotTables

```
PIVOT 1: Findings by Severity × Status
├── ROWS: severity
├── COLUMNS: status (Open/Closed)
├── VALUES: Count of finding_id
├── EXPECTED RESULT:
│   Severity  | Closed | Open | Total
│   CRITICAL  |   4    |  8   |  12
│   HIGH      |   4    |  14  |  18
│   MEDIUM    |   1    |  13  |  14
│   LOW       |   1    |  5   |   6
│   Total     |  10    |  40  |  50

PIVOT 2: Findings by Team (needs XLOOKUP column first)
├── ROWS: assignment_group (from your lookup column)
├── COLUMNS: severity
├── VALUES: Count of finding_id
├── FILTER: status = "Open" only
├── Sort: by Grand Total descending
├── Shows: which teams have the most open findings

PIVOT 3: Findings by Category × Cloud Provider
├── ROWS: category
├── COLUMNS: cloud_provider
├── VALUES: Count of finding_id
├── FILTER: status = "Open"
├── Shows: IAM vs Network vs Storage vs Container distribution

PIVOT 4: Monthly Trend
├── ROWS: Month_Created (your calculated column)
├── COLUMNS: severity
├── VALUES: Count of finding_id
├── Shows: are findings increasing or decreasing over time?

PIVOT 5: SLA Status Summary
├── ROWS: SLA_Status (your calculated column)
├── VALUES: Count of finding_id
├── Shows: how many On Track vs At Risk vs Breached
```

## 5.3 PivotTable Advanced Techniques

```
TECHNIQUE 1: Show Values As → % of Grand Total
├── Right-click any value → Show Values As → % of Grand Total
├── Shows: "42% of all findings are HIGH severity"

TECHNIQUE 2: Calculated Field
├── PivotTable Analyze → Fields, Items & Sets → Calculated Field
├── Name: Breach_Rate
├── Formula: = Breached / (Breached + OnTrack)
├── Shows: breach rate without adding a column

TECHNIQUE 3: Group Dates by Month/Quarter
├── Right-click any date in ROWS → Group
├── Select: Months + Quarters
├── Now you have auto time hierarchy

TECHNIQUE 4: Slicers for Visual Filtering
├── PivotTable Analyze → Insert Slicer
├── Check: severity, cloud_provider, category
├── Click buttons to instantly filter the PivotTable
├── Connect to multiple PivotTables:
│   Right-click slicer → Report Connections → check all PivotTables

TECHNIQUE 5: Conditional Formatting in PivotTable
├── Select the value cells in the PivotTable
├── Home → Conditional Formatting → Color Scales
├── Green-Yellow-Red: low=green, high=red
├── Now your PivotTable is a heatmap
```

### 🔧 PRACTICAL 7: Executive Summary PivotTable

```
Create a single PivotTable that leadership can glance at:

ROWS: assignment_group
VALUES (multiple):
├── Count of finding_id → rename "Total Findings"
├── Count of finding_id (add again) → filter "CRITICAL" → rename "Critical"
├── Count of finding_id (add again) → Show Values As % → rename "% of Total"

Add Slicer: cloud_provider (tiles at top)
Add Slicer: status (tiles: Open / Closed)

FORMAT:
├── PivotTable Design → Report Layout → Tabular
├── PivotTable Design → Subtotals → Do Not Show
├── Conditional Formatting on Critical column: data bar (red)
```

---

# MODULE 6: CONDITIONAL FORMATTING (30 min)

## 6.1 Rules You Need

```
RULE 1: Color by Severity
├── Select severity column → Conditional Formatting → New Rule
├── Rule Type: Format only cells that contain
├── Cell Value → equal to → "CRITICAL"
├── Format: Fill = #e74c3c (red), Font = White, Bold
├── Repeat for HIGH (orange), MEDIUM (yellow), LOW (green)

RULE 2: SLA Status Colors
├── Select SLA_Status column
├── "🔴 Breached" → Red fill
├── "🟡 At Risk" → Yellow fill
├── "🟢 On Track" → Green fill

RULE 3: Age Heatmap (Color Scale)
├── Select Age_Days column
├── Conditional Formatting → Color Scales → Green-Yellow-Red
├── Minimum (green) = 0
├── Maximum (red) = 90

RULE 4: Entire Row Highlight
├── Select entire data range (A2:Y51)
├── Conditional Formatting → New Rule
├── Use a formula: =$D2="CRITICAL"
├── Format: Light red fill
├── Now entire rows with CRITICAL findings are highlighted

RULE 5: Data Bars for Risk Score
├── Select Risk_Score column
├── Conditional Formatting → Data Bars
├── Solid fill → gradient from green to red
├── Shows: visual bar proportional to risk score

RULE 6: Icon Sets for Age
├── Select Age_Days column
├── Conditional Formatting → Icon Sets → 3 Traffic Lights
├── Custom: ⚫ Red >= 30, 🟡 Yellow >= 15, 🟢 Green < 15
```

### 🔧 PRACTICAL 8: Build a Formatted Findings Table

```
STEPS:
1. Copy columns A-Y to a new sheet "Formatted_Report"
2. Select all data → Ctrl+T → Create Table → Name: "FindingsTable"
3. Apply ALL 6 conditional formatting rules above
4. Sort by: Severity_Order ASC, then Age_Days DESC
5. Freeze top row: View → Freeze Panes → Freeze Top Row
6. Auto-fit column widths: Select all → Format → AutoFit Column Width

RESULT: A color-coded, sortable, filterable findings report that
        looks professional when shared with management or auditors
```

---

# MODULE 7: POWER QUERY IN EXCEL (45 min)

## 7.1 Why Power Query

```
POWER QUERY vs FORMULAS:

Without Power Query:
├── Open CSV → copy/paste into sheet
├── Write VLOOKUP formulas for each lookup
├── Manually clean data (remove blanks, fix types)
├── Redo everything when new CSV arrives next week

With Power Query:
├── Connect to CSV file/folder (one-time setup)
├── Define transformations (merge, clean, calculate)
├── Click REFRESH when new data arrives
├── Everything auto-updates
└── No formulas needed
```

## 7.2 Steps to Build

### 🔧 PRACTICAL 9: Power Query — Auto-Merge Findings + CMDB

```
STEP 1: Import Findings
├── Data → Get Data → From File → From Text/CSV
├── Select wiz_findings.csv → Import
├── Click "Transform Data" (opens Power Query Editor)

STEP 2: Clean Findings Data
In Power Query Editor:
├── Change created_date type: Click column header → Date
├── Change closed_date type: Date
├── Change sla_hours type: Whole Number
├── Remove columns you don't need: Right-click → Remove Columns
│   (keep: finding_id, title, severity, status, category, 
│    cloud_provider, resource_id, internet_facing, created_date, 
│    closed_date, sla_hours)

STEP 3: Add Calculated Columns
├── Add Column → Custom Column → Name: "Age_Days"
├── Formula:
    if [status] = "Closed" then
        Duration.Days([closed_date] - [created_date])
    else
        Duration.Days(DateTime.LocalNow() - [created_date])

├── Add Column → Custom Column → Name: "SLA_Status"
├── Formula:
    let
        age = Duration.Days(DateTime.LocalNow() - [created_date]),
        sla = if [severity] = "CRITICAL" then 1
              else if [severity] = "HIGH" then 7
              else if [severity] = "MEDIUM" then 30
              else 90
    in
        if [status] = "Closed" then "Resolved"
        else if age >= sla then "Breached"
        else if age >= sla * 0.75 then "At Risk"
        else "On Track"

STEP 4: Import CMDB Data
├── Home → New Source → File → Text/CSV
├── Select cmdb_assets.csv → OK

STEP 5: Merge Queries (= JOIN in SQL)
├── Back on the Findings query
├── Home → Merge Queries
├── Select: Findings[resource_id] = cmdb_assets[cloud_resource_id]
├── Join Kind: Left Outer (keep ALL findings, add CMDB where matched)
├── Click OK
├── Expand the merged column (click the expand icon ⇔)
├── Select: owner, assignment_group, environment
├── Uncheck "Use original column name as prefix"

STEP 6: Close & Apply
├── Home → Close & Apply
├── Your merged, cleaned data appears as an Excel Table
├── PivotTables will auto-reference this data

NEXT WEEK: When you get a new findings CSV:
├── Just replace the old CSV file with the new one
├── Open Excel → Data → Refresh All
├── Everything updates automatically — zero manual work!
```

## 7.3 Advanced Power Query Operations

```
OPERATION: Group By (for summary tables)
├── Transform → Group By
├── Group by: severity
├── New column: Count → Count Rows
├── Result: summary table (like PivotTable but in ETL)

OPERATION: Unpivot (wide → tall)
├── Select columns to keep → Right-click → Unpivot Other Columns
├── Use when: CSV has months as columns (Jan, Feb, Mar...)
├── Result: one row per month per finding

OPERATION: Pivot (tall → wide)
├── Transform → Pivot Column
├── Select value column → Values Column: Count
├── Use when: you need a cross-tab from flat data

OPERATION: Append (combine multiple CSVs)
├── Home → Append Queries → Three or More
├── Select all monthly exports
├── Result: one combined table

OPERATION: Data From Folder (auto-combine all CSVs in a folder)
├── Data → Get Data → From File → From Folder
├── Select folder path
├── Power Query finds all files, combines them
├── Next month: just drop new CSV in folder → Refresh → done
```

### 🔧 PRACTICAL 10: Auto-Refresh Weekly Report

```
BUILD THIS ONCE, USE FOREVER:

1. Create a folder: C:\SecurityReports\Weekly\
2. Put wiz_findings.csv in that folder
3. In Excel: Data → Get Data → From File → From Folder
4. Select the folder
5. Power Query imports all CSVs in the folder
6. Apply transform steps (add Age, SLA_Status, merge with CMDB)
7. Close & Apply

EVERY WEEK:
├── Drop the new wiz_findings.csv into the folder
├── Open Excel → Data → Refresh All
├── Report auto-updates
├── PivotTables auto-update
├── Conditional formatting auto-applies
└── Total time: 10 seconds instead of 30 minutes
```

---

# MODULE 8: DATA VALIDATION & FORMS (20 min)

### 🔧 PRACTICAL 11: Build a Triage Input Form

```
PURPOSE: Analysts use this sheet to triage findings

COLUMN A: "Finding ID" → populated by Power Query
COLUMN B: "Title" → populated by Power Query
COLUMN C: "Severity" → populated by Power Query

COLUMN D: "Triage Status" (analyst input — use Data Validation)
├── Select D2:D100
├── Data → Data Validation
├── Allow: List
├── Source: True Positive,False Positive,Duplicate,Needs Review
├── Error Alert: "Please select a valid triage status"

COLUMN E: "Action" (analyst input)
├── Data → Data Validation → List
├── Source: Assign Ticket,Accept Risk,Suppress,Escalate

COLUMN F: "Notes" (free text — no validation)

COLUMN G: "Triaged By" (auto-populate)
├── Formula: =IF(D2<>"", ENVIRON("USERNAME"), "")
├── Or hardcode your name

COLUMN H: "Triage Date" (auto-populate)
├── Formula: =IF(D2<>"", TODAY(), "")

PROTECT THE SHEET:
├── Unlock columns D, E, F (right-click → Format Cells → Protection → Unlock)
├── Review → Protect Sheet → set password
├── Now analysts can ONLY edit the triage columns
```

---

# MODULE 9: CHARTS & DASHBOARD (30 min)

### 🔧 PRACTICAL 12: Build an Excel Dashboard

```
CREATE A NEW SHEET: "Dashboard"

CHART 1: Severity Distribution (Pie Chart)
├── Use PivotTable 1 data (severity × count)
├── Insert → Pie Chart → 3D Pie
├── Colors: CRITICAL=Red, HIGH=Orange, MEDIUM=Yellow, LOW=Green
├── Data Labels: Show percentage + category
├── Title: "Open Findings by Severity"
├── Size: 300x250, Position: A1

CHART 2: Findings by Team (Horizontal Bar Chart)
├── Use PivotTable 2 data (team × count)
├── Insert → Bar Chart → Clustered Bar
├── Sort: largest to smallest
├── Data Labels: show values
├── Title: "Open Findings by Team"
├── Size: 400x250, Position: D1

CHART 3: Monthly Trend (Line Chart)
├── Use PivotTable 4 data (month × count)
├── Insert → Line Chart → Line with Markers
├── Separate lines for CRITICAL, HIGH, MEDIUM, LOW
├── Title: "Finding Trend by Month"
├── Size: 400x200, Position: A15

CHART 4: SLA Status (Donut Chart)
├── Use PivotTable 5 data (SLA status × count)
├── Insert → Doughnut Chart
├── Colors: OnTrack=Green, AtRisk=Yellow, Breached=Red
├── Title: "SLA Compliance"
├── Size: 300x250, Position: D15

SUMMARY CARDS (Text Boxes):
├── Insert → Text Box → "TOTAL OPEN: " & link to cell B3
├── Create 4 text boxes:
│   ├── Total Open (blue border)
│   ├── Critical (red border)
│   ├── SLA Compliance % (green border)
│   └── Avg Age (purple border)
├── Position: across the top of the dashboard

SLICER:
├── Click any PivotTable → Analyze → Insert Slicer
├── Select: cloud_provider, severity
├── Connect slicer to ALL PivotTables on this sheet
├── Position: right side panel
```

---

# MODULE 10: AUDIT PREPARATION WORKBOOK (20 min)

### 🔧 PRACTICAL 13: Build an Audit-Ready Export

```
CREATE A NEW SHEET: "Audit_Report"

STRUCTURE:
Row 1: "CLOUD SECURITY FINDINGS AUDIT REPORT"
Row 2: "Report Period: Jan 2025 - Mar 2025"
Row 3: "Generated: " & =TEXT(TODAY(), "DD-MMM-YYYY")
Row 4: blank
Row 5: Headers

HEADERS (Row 5):
A: Finding ID      H: SLA Status
B: Severity         I: Age (Days)  
C: Title            J: Owner
D: Cloud Provider   K: Team
E: Category         L: Triage Decision
F: Status           M: SNOW Ticket
G: Created Date     N: Resolution/Notes

BELOW THE TABLE — Summary Section:
Row 55: "SUMMARY STATISTICS"
A56: "Total Findings Discovered"    B56: =COUNTA(A6:A54)
A57: "Findings Remediated"         B57: =COUNTIF(F6:F54,"Closed")
A58: "Remediation Rate"            B58: =B57/B56*100 & "%"
A59: "SLA Compliance (Open)"       B59: =COUNTIF(H6:H54,"On Track")/(COUNTA(H6:H54)-COUNTIF(H6:H54,"Resolved"))*100 & "%"
A60: "Avg MTTR (Closed, Days)"     B60: =AVERAGEIF(F6:F54,"Closed",I6:I54)
A61: "Findings with SNOW Ticket"   B61: =COUNTA(M6:M54)
A62: "Orphaned (No CMDB Owner)"    B62: =COUNTIF(J6:J54,"UNASSIGNED")

PRINT SETUP:
├── Page Layout → Orientation → Landscape
├── Page Layout → Print Area → Set Print Area (select all)
├── Page Layout → Scale to Fit → Width: 1 page
├── File → Print Preview → verify it looks clean
└── File → Save As → PDF for auditors
```

---

# 📋 SKILLS CHECKLIST — Track Your Progress

```
MODULE 1: FUNDAMENTALS
☐ Understand cell references (relative, absolute, mixed)
☐ Use COUNT, COUNTIF, COUNTIFS
☐ Use SUM, SUMIF, SUMIFS
☐ Use AVERAGE, AVERAGEIF

MODULE 2: LOOKUPS
☐ Write VLOOKUP formula
☐ Write XLOOKUP formula
☐ Write INDEX-MATCH formula
☐ Handle errors with IFERROR
☐ Do multi-criteria lookup

MODULE 3: TEXT & DATES
☐ Use TODAY(), DATEDIF for age calculation
☐ Use TEXT for date formatting
☐ Use SWITCH for severity mapping

MODULE 4: LOGIC
☐ Write nested IF/IFS/SWITCH
☐ Use AND/OR in conditions
☐ Build risk scoring formula with LET

MODULE 5: PIVOTTABLES
☐ Create basic PivotTable (severity × status)
☐ Add multiple value fields
☐ Use Show Values As (% of total)
☐ Group dates by month
☐ Add Slicers and connect to multiple PivotTables

MODULE 6: CONDITIONAL FORMATTING
☐ Color by severity
☐ Color scale for number columns
☐ Data bars for risk scores
☐ Icon sets for age buckets
☐ Entire row highlighting by formula

MODULE 7: POWER QUERY
☐ Import CSV via Power Query
☐ Add custom calculated columns
☐ Merge queries (JOIN findings + CMDB)
☐ Refresh auto-updates everything

MODULE 8: DATA VALIDATION
☐ Create dropdown lists for triage
☐ Protect sheet allowing only input columns

MODULE 9: DASHBOARDS
☐ Create pie, bar, line, donut charts from PivotTable
☐ Add text box KPI cards
☐ Connect slicers to multiple PivotTables

MODULE 10: AUDIT PREP
☐ Build formatted audit export table
☐ Add summary statistics section  
☐ Export to PDF
```$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Executive_Dashboard_Guide$VELSEC$, $VELSEC$Executive Dashboard Guide$VELSEC$, $VELSEC$Data Analyst$VELSEC$, ARRAY['Data_Analytics']::TEXT[], $VELSEC$# 📊 CEO/CISO Executive Security Posture Dashboard — Complete Build Guide

> **Purpose:** Step-by-step guide to build a 3-page Power BI dashboard for executive
> security reporting using Wiz findings, CMDB, and ServiceNow data.
> **Audience:** You (the analyst building it) + CEO/CISO/Board (consuming it)

---

# PART 1: DATA ANALYSIS — What the Numbers Tell Us

## 1.1 Current Security Posture Snapshot

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    SECURITY POSTURE AT A GLANCE                          │
│                                                                          │
│   Total Findings: 50         Closed: 10 (20%)     Open: 40 (80%)        │
│                                                                          │
│   ┌─────────────────────────────────────────────────────────┐           │
│   │ CRITICAL  ████████████░░░  11 total (8 OPEN, 3 Closed)  │           │
│   │ HIGH      ████████████████  16 total (12 OPEN, 4 Closed)│           │
│   │ MEDIUM    ██████████████░░  14 total (12 OPEN, 2 Closed)│           │
│   │ LOW       █████░░░░░░░░░░   5 total (4 OPEN, 1 Closed) │           │
│   └─────────────────────────────────────────────────────────┘           │
│                                                                          │
│   SLA Compliance: 50%  ← 🔴 UNACCEPTABLE FOR BANKING                   │
│   SLA Breached:   18 tickets (36%)                                       │
│   SLA At Risk:     7 tickets (14%)                                       │
│   SLA On Track:   15 tickets (30%)                                       │
│   SLA Met:         9 tickets (closed on time)                            │
│   SLA Missed:      1 ticket (closed late)                                │
│                                                                          │
│   Internet-Facing + Critical/High:  ~8 findings ← 🔴 HIGHEST RISK      │
└─────────────────────────────────────────────────────────────────────────┘
```

## 1.2 Parameters a CEO/CISO Dashboard MUST Show

### Tier 1 — CEO Level (Board-Ready)

| # | Parameter | What It Answers | Data Source |
|---|-----------|----------------|-------------|
| 1 | **Overall Security Score** (0-100) | "Are we secure?" | Calculated from all findings |
| 2 | **Risk Trend** (month-over-month) | "Are we getting better or worse?" | findings.created_date, closed_date |
| 3 | **Critical Open Findings Count** | "How many fires exist right now?" | findings.severity = CRITICAL, status = Open |
| 4 | **SLA Compliance Rate (%)** | "Are teams fixing issues on time?" | tickets.sla_status |
| 5 | **Internet-Facing Exposure** | "How many assets are visible to attackers?" | findings.internet_facing = Yes |
| 6 | **Risk by Business Unit** | "Which business line has the most risk?" | cmdb.business_unit joined to findings |
| 7 | **Cloud Provider Risk Split** | "Azure vs GCP — where's the risk?" | findings.cloud_provider |

### Tier 2 — CISO Level (Operational)

| # | Parameter | What It Answers | Data Source |
|---|-----------|----------------|-------------|
| 8 | **Mean Time to Remediate (MTTR)** | "How fast are we fixing issues?" | tickets.resolved_date - created_date |
| 9 | **SLA Breach by Team** | "Which teams are struggling?" | tickets.assignment_group + sla_status |
| 10 | **Findings by Category** | "Where are the gaps? (Network, IAM, Storage...)" | findings.category |
| 11 | **Open Findings Aging** | "How old are our oldest unfixed issues?" | DATEDIFF(created_date, TODAY) |
| 12 | **Findings Opened vs Closed Trend** | "Is the backlog growing?" | Monthly count comparison |
| 13 | **Top Repeat Offender Assets** | "Which resources keep failing?" | COUNT findings per resource |
| 14 | **Owner Accountability Matrix** | "Who owns what? Who is behind?" | cmdb.owner + tickets.sla_status |
| 15 | **Remediation Velocity** | "How many findings do we close per week?" | Rolling close rate |

### Tier 3 — GRC / Audit Level (Compliance)

| # | Parameter | What It Answers | Data Source |
|---|-----------|----------------|-------------|
| 16 | **CIS Benchmark Coverage** | "Which CIS controls are we failing?" | findings.cis_control |
| 17 | **Compliance by Framework** | "CIS Azure vs CIS GCP vs CIS EKS status" | findings.compliance_framework |
| 18 | **Data Classification × Severity** | "Are our most sensitive assets protected?" | findings.data_classification × severity |
| 19 | **Environment Risk** (Prod vs Dev) | "Is production properly secured?" | cmdb.environment |
| 20 | **Evidence of Remediation** | "Can we prove we fixed things?" | tickets.resolution_notes + change_request_id |

---

# PART 2: POWER BI SETUP — Step by Step

## Step 1: Import Data

```
1. Open Power BI Desktop
2. Home → Get Data → Text/CSV
3. Import these 3 files:
   ├── wiz_findings.csv       → rename query to "Findings"
   ├── cmdb_assets.csv        → rename query to "Assets"
   └── servicenow_tickets.csv → rename query to "Tickets"
4. Click "Transform Data" to open Power Query Editor
```

## Step 2: Power Query Transformations

### Findings Table

```
// In Power Query Editor → select "Findings" query

// Step 2.1: Set data types
Select columns → Transform → Detect Data Types
Then manually verify:
  - created_date → Date
  - closed_date → Date
  - sla_hours → Whole Number
  - internet_facing → Text

// Step 2.2: Add calculated columns

// Column: Days Open
= if [status] = "Open"
  then Duration.Days(DateTime.LocalNow() - [created_date])
  else Duration.Days([closed_date] - [created_date])

// Column: Resolution Time (hours) — only for closed findings
= if [closed_date] <> null
  then Duration.TotalHours([closed_date] - [created_date])
  else null

// Column: SLA Met (calculated)
= if [status] = "Closed" then
    (if Duration.TotalHours([closed_date] - [created_date]) <= [sla_hours]
     then "Met" else "Missed")
  else
    (if Duration.TotalHours(DateTime.LocalNow() - [created_date]) > [sla_hours]
     then "Breached" else "On Track")

// Column: Severity Order (for correct sorting)
= if [severity] = "CRITICAL" then 1
  else if [severity] = "HIGH" then 2
  else if [severity] = "MEDIUM" then 3
  else 4

// Column: Risk Score (weighted)
= if [severity] = "CRITICAL" then 10
  else if [severity] = "HIGH" then 5
  else if [severity] = "MEDIUM" then 2
  else 1

// Column: Exposure Risk (combines internet + severity)
= if [internet_facing] = "Yes" and [severity] = "CRITICAL" then "EXTREME"
  else if [internet_facing] = "Yes" and [severity] = "HIGH" then "VERY HIGH"
  else if [internet_facing] = "Yes" then "ELEVATED"
  else [severity]

// Column: Age Bucket
= if Duration.Days(DateTime.LocalNow() - [created_date]) <= 7 then "0-7 days"
  else if Duration.Days(DateTime.LocalNow() - [created_date]) <= 30 then "8-30 days"
  else if Duration.Days(DateTime.LocalNow() - [created_date]) <= 60 then "31-60 days"
  else "60+ days"

// Column: Month-Year (for trending)
= Date.ToText([created_date], "yyyy-MM")
```

### Assets Table

```
// In Power Query Editor → select "Assets" query

// Rename cloud_resource_id to resource_id (to match findings table for JOIN)
Right-click column → Rename → "resource_id"

// No other transformations needed — this is a lookup/dimension table
```

### Tickets Table

```
// In Power Query Editor → select "Tickets" query

// Step: Set data types
  - created_date → Date
  - resolved_date → Date
  - sla_target_date → Date

// Column: Days to Resolve (for closed tickets)
= if [resolved_date] <> null
  then Duration.Days([resolved_date] - [created_date])
  else null

// Column: Priority Order
= if [priority] = "P1" then 1
  else if [priority] = "P2" then 2
  else if [priority] = "P3" then 3
  else 4
```

## Step 3: Click "Close & Apply" → Power Query loads data into model

## Step 4: Data Model — Create Relationships

```
In Model View (left sidebar → diagram icon):

┌────────────┐        ┌────────────┐        ┌────────────┐
│  Findings   │───────▶│   Assets    │        │  Tickets   │
│             │        │             │        │            │
│ resource_id │──1:1──▶│ resource_id │        │ finding_id │
│ finding_id  │◀──1:1──────────────────────────│ finding_id │
└────────────┘        └────────────┘        └────────────┘

Create relationships:
1. Findings[resource_id] → Assets[resource_id]  (Many to One)
2. Findings[finding_id]  → Tickets[finding_id]  (One to One)
```

## Step 5: Create a Date Table (for time intelligence)

```
// In Power BI → Modeling → New Table:

DateTable =
ADDCOLUMNS(
    CALENDAR(DATE(2024, 12, 1), DATE(2025, 6, 30)),
    "Year", YEAR([Date]),
    "MonthNum", MONTH([Date]),
    "MonthName", FORMAT([Date], "MMM"),
    "YearMonth", FORMAT([Date], "YYYY-MM"),
    "WeekNum", WEEKNUM([Date]),
    "Quarter", "Q" & FORMAT([Date], "Q"),
    "IsCurrentMonth", IF(MONTH([Date]) = MONTH(TODAY()) && YEAR([Date]) = YEAR(TODAY()), TRUE, FALSE)
)

// Mark as Date Table:
// Select DateTable → Modeling → Mark as Date Table → select [Date]

// Create relationships:
// DateTable[Date] → Findings[created_date]
```

---

# PART 3: DAX MEASURES — The Analytics Engine

## Create all measures in a "Measures" table:

```
// Modeling → New Table → Measures = ROW("x", 0)
// Then delete the "x" column — this is just a container for measures
```

### 3.1 Core Counts

```dax
// MEASURE 1: Total Findings
Total Findings = COUNTROWS(Findings)

// MEASURE 2: Open Findings
Open Findings = CALCULATE(COUNTROWS(Findings), Findings[status] = "Open")

// MEASURE 3: Closed Findings
Closed Findings = CALCULATE(COUNTROWS(Findings), Findings[status] = "Closed")

// MEASURE 4: Closure Rate
Closure Rate % = DIVIDE([Closed Findings], [Total Findings], 0) * 100
```

### 3.2 Severity Breakdowns

```dax
// MEASURE 5: Critical Open
Critical Open = CALCULATE(
    COUNTROWS(Findings),
    Findings[severity] = "CRITICAL",
    Findings[status] = "Open"
)

// MEASURE 6: High Open
High Open = CALCULATE(
    COUNTROWS(Findings),
    Findings[severity] = "HIGH",
    Findings[status] = "Open"
)

// MEASURE 7: Internet-Facing Critical/High Open
Internet Exposure Count = CALCULATE(
    COUNTROWS(Findings),
    Findings[internet_facing] = "Yes",
    Findings[status] = "Open",
    Findings[severity] IN {"CRITICAL", "HIGH"}
)
```

### 3.3 Security Score (THE most important executive metric)

```dax
// MEASURE 8: Overall Security Score (0-100, higher = more secure)
//
// LOGIC: Start at 100. Deduct points for every open finding:
//   Critical = -4 points each
//   High = -2 points each
//   Medium = -0.5 points each
//   Low = -0.25 points each
// Floor at 0 (can't go negative)
//
// WHY THIS FORMULA: Executive boards need ONE number.
// This creates a weighted score that drops fast when Criticals accumulate.

Security Score =
VAR CriticalCount = [Critical Open]
VAR HighCount = [High Open]
VAR MediumCount = CALCULATE(COUNTROWS(Findings), Findings[severity] = "MEDIUM", Findings[status] = "Open")
VAR LowCount = CALCULATE(COUNTROWS(Findings), Findings[severity] = "LOW", Findings[status] = "Open")
VAR Deductions = (CriticalCount * 4) + (HighCount * 2) + (MediumCount * 0.5) + (LowCount * 0.25)
RETURN MAX(0, 100 - Deductions)

// CURRENT VALUE: 100 - (8*4) - (12*2) - (12*0.5) - (4*0.25) = 100 - 32 - 24 - 6 - 1 = 37
// SCORE: 37/100 = 🔴 POOR
```

### 3.4 SLA Metrics

```dax
// MEASURE 9: SLA Compliance Rate
SLA Compliance % = DIVIDE(
    CALCULATE(COUNTROWS(Tickets), Tickets[sla_status] IN {"Met", "On Track"}),
    COUNTROWS(Tickets),
    0
) * 100

// MEASURE 10: SLA Breach Count
SLA Breached Count = CALCULATE(COUNTROWS(Tickets), Tickets[sla_status] = "Breached")

// MEASURE 11: SLA At Risk Count
SLA At Risk Count = CALCULATE(COUNTROWS(Tickets), Tickets[sla_status] = "At Risk")
```

### 3.5 MTTR (Mean Time to Remediate)

```dax
// MEASURE 12: MTTR in Days (for closed findings only)
MTTR Days = AVERAGE(Tickets[Days to Resolve])

// MEASURE 13: MTTR by Critical (use with slicer)
MTTR Critical = CALCULATE(
    AVERAGE(Tickets[Days to Resolve]),
    Tickets[priority] = "P1"
)

// MEASURE 14: MTTR by High
MTTR High = CALCULATE(
    AVERAGE(Tickets[Days to Resolve]),
    Tickets[priority] = "P2"
)
```

### 3.6 Trend & Comparison

```dax
// MEASURE 15: Findings Opened This Month
Opened This Month = CALCULATE(
    COUNTROWS(Findings),
    DATESMTD(DateTable[Date])
)

// MEASURE 16: Findings Closed This Month
Closed This Month = CALCULATE(
    COUNTROWS(Findings),
    Findings[status] = "Closed",
    DATESMTD(DateTable[Date])
)

// MEASURE 17: Net Change (Opened minus Closed)
Net Change = [Opened This Month] - [Closed This Month]
// Positive = backlog growing 🔴 | Negative = backlog shrinking 🟢

// MEASURE 18: Risk Score Total (for BU comparison)
Total Risk Score = SUMX(
    FILTER(Findings, Findings[status] = "Open"),
    Findings[Risk Score]
)
```

### 3.7 Aging Analysis

```dax
// MEASURE 19: Average Age of Open Findings (days)
Avg Age Days = CALCULATE(
    AVERAGE(Findings[Days Open]),
    Findings[status] = "Open"
)

// MEASURE 20: Findings Over 30 Days Old
Overdue Findings = CALCULATE(
    COUNTROWS(Findings),
    Findings[status] = "Open",
    Findings[Days Open] > 30
)
```

---

# PART 4: DASHBOARD PAGES — Layout & Visual Design

## 🎨 Color Theme

```
Executive Dashboard Color Palette:

Background:     #1E1E2E (dark navy — executive/premium feel)
Card Background: #2A2A3E
Text Primary:    #FFFFFF
Text Secondary:  #A0A0C0

CRITICAL:  #FF4444 (red)
HIGH:      #FF8C00 (orange)
MEDIUM:    #FFD700 (gold)
LOW:       #4CAF50 (green)

Score Gauge:
  0-30:    #FF4444 (red — poor)
  31-60:   #FF8C00 (orange — needs work)
  61-80:   #FFD700 (gold — acceptable)
  81-100:  #4CAF50 (green — strong)

SLA Status:
  Breached: #FF4444
  At Risk:  #FF8C00
  On Track: #4CAF50
  Met:      #2196F3 (blue)
```

## 📊 PAGE 1: EXECUTIVE RISK OVERVIEW

```
┌──────────────────────────────────────────────────────────────────────────┐
│ EXECUTIVE RISK OVERVIEW                                    [ March 2025 ]│
│                                                                          │
│ ┌───────────┐  ┌───────────┐  ┌───────────┐  ┌───────────┐            │
│ │ SECURITY  │  │ OPEN      │  │ CRITICAL  │  │ INTERNET  │            │
│ │ SCORE     │  │ FINDINGS  │  │ OPEN      │  │ EXPOSED   │            │
│ │           │  │           │  │           │  │           │            │
│ │   37/100  │  │    40     │  │    8      │  │    8      │            │
│ │   🔴 POOR │  │   🔴 HIGH │  │  🔴 CRIT  │  │  🔴 RISK  │            │
│ └───────────┘  └───────────┘  └───────────┘  └───────────┘            │
│                                                                          │
│ ┌──────────────────────────────┐  ┌───────────────────────────────────┐│
│ │  RISK TREND (Line Chart)     │  │  RISK BY CLOUD PROVIDER (Donut)  ││
│ │                              │  │                                   ││
│ │  ↗ Critical ─── 5→8 (↑60%)  │  │    Azure: 68% (34 findings)      ││
│ │  → High ──── 10→12 (↑20%)   │  │    GCP:   32% (16 findings)      ││
│ │  → Medium ── 10→12 (↑20%)   │  │                                   ││
│ │  ↘ Low ───── 5→4  (↓20%)    │  │                                   ││
│ └──────────────────────────────┘  └───────────────────────────────────┘│
│                                                                          │
│ ┌──────────────────────────────┐  ┌───────────────────────────────────┐│
│ │  RISK BY BUSINESS UNIT       │  │  DATA CLASSIFICATION × SEVERITY  ││
│ │  (Stacked Bar Chart)         │  │  (Heat Map / Matrix)             ││
│ │                              │  │                                   ││
│ │  Risk Analytics ████████ 38  │  │        CRIT  HIGH  MED   LOW     ││
│ │  Digital Banking ██████ 30   │  │  REST:   2    2     0     0  🔴  ││
│ │  Capital Markets ████ 20     │  │  CONF:   3    5     3     0  🟠  ││
│ │  Retail Banking ███ 15       │  │  INTR:   2    4     9     4  🟡  ││
│ │  Enterprise Sec ██ 12        │  │  PUBL:   1    0     0     0  🟡  ││
│ │  Infrastructure █ 5          │  │                                   ││
│ └──────────────────────────────┘  └───────────────────────────────────┘│
└──────────────────────────────────────────────────────────────────────────┘
```

### Build Instructions — Page 1 (Detailed)

#### Step 1: Page Setup

```
1. Right-click "Page 1" tab at bottom → Rename → type "Executive Risk Overview"
2. With this page selected, click the empty canvas area (no visual selected)
3. In the Visualizations pane (right side), click the FORMAT icon
   (the paint roller 🖌️ icon — NOT the fields icon)
4. Expand "Canvas background":
   → Color: #1E1E2E (click the color box → Custom color → paste hex)
   → Transparency: 0%
5. Expand "Canvas settings":
   → Type: Custom
   → Width: 1920
   → Height: 1080
6. View menu (top ribbon) → UNCHECK "Gridlines" and "Snap to grid"
   → This gives you precise visual placement
```

#### Step 2: Add Header Text Box

```
1. Insert ribbon (top) → Text box
2. Click-drag across the top of the canvas (full width, ~60px tall)
3. Type: "☁️ CLOUD SECURITY — EXECUTIVE RISK OVERVIEW"
4. Select the text → set:
   → Font: Segoe UI Semibold
   → Size: 22
   → Color: White (#FFFFFF)
   → Alignment: Center
5. With the text box selected, go to Format pane:
   → General → Properties → Position:
     X: 0, Y: 0, Width: 1920, Height: 60
   → General → Effects → Background: OFF
```

#### Step 3: Add Security Score Gauge

```
1. Click empty canvas area
2. Visualizations pane → click the GAUGE icon (🎯 speedometer)
   → An empty gauge appears on canvas
3. From Fields pane (right side), expand "_Measures" table
   → Drag [Security Score] into the "Value" field well
4. Still in Fields wells:
   → Min value: click the ▼ dropdown → type 0
   → Max value: click the ▼ dropdown → type 100
   → Target value: click the ▼ dropdown → type 75
5. FORMAT the gauge (click paint roller 🖌️):
   → Visual → Gauge axis:
     Min: 0, Max: 100
     Target: 75
   → Visual → Colors:
     Fill: #3498db (blue arc)
     Target: #FFFFFF (white target line)
   → Visual → Callout value:
     Font: Segoe UI, Size: 36, Color: #FFFFFF
   → Visual → Data labels: ON
   → General → Title: ON
     Text: "Security Posture Score"
     Font: Segoe UI, Size: 14, Color: #A0A0C0
   → General → Effects → Background:
     Color: #2A2A3E, Transparency: 0%
   → General → Effects → Border:
     ON, Color: #3A3A5E, Rounded corners: 8px
   → General → Properties → Position:
     X: 40, Y: 80, Width: 300, Height: 250

6. ADD CONDITIONAL FORMATTING to gauge fill:
   → Still in Format → Visual → Colors → Fill color
   → Click "fx" (conditional formatting button)
   → Format style: Rules
   → Based on: [Security Score]
   → Rules:
     IF value >= 0  AND < 30  THEN #FF4444 (red)
     IF value >= 30 AND < 60  THEN #FF8C00 (orange)
     IF value >= 60 AND < 80  THEN #FFD700 (gold)
     IF value >= 80 AND <= 100 THEN #4CAF50 (green)
   → Click OK
```

#### Step 4: Add 4 KPI Cards (Top Row)

```
FOR EACH CARD, repeat these steps:

1. Click empty canvas → Visualizations pane → "Card" visual (rectangle with number)
2. Drag the measure from _Measures into the "Fields" well

CARD 1 — Open Findings:
  → Drag [Open Findings] into Fields
  → FORMAT (paint roller):
    → Visual → Callout value:
      Font: Segoe UI, Size: 36, Bold, Color: #FFFFFF
      Display units: None
    → Visual → Category label:
      ON, Text: "OPEN FINDINGS", Size: 11, Color: #A0A0C0
    → General → Title: OFF (category label replaces it)
    → General → Effects → Background: Color #2A2A3E
    → General → Effects → Visual border:
      ON, Color: #3498db (blue left accent), Width: 4
    → General → Properties → Position:
      X: 360, Y: 80, Width: 220, Height: 120
  → CONDITIONAL FORMATTING on callout value:
    Right-click the card number → "Conditional formatting" → "Font color"
    → Format style: Rules
    → Rules:
      IF value > 30 THEN #FF4444 (red)
      IF value >= 20 AND <= 30 THEN #FF8C00 (orange)
      IF value < 20 THEN #4CAF50 (green)
    → Click OK

CARD 2 — Critical Open:
  → Drag [Critical Open] into Fields
  → Same formatting as Card 1 EXCEPT:
    → Category label text: "CRITICAL"
    → Border Color: #FF4444 (red accent)
    → Position: X: 600, Y: 80, Width: 220, Height: 120
  → Conditional formatting:
    IF value > 0 THEN #FF4444 (always red when criticals exist)
    IF value = 0 THEN #4CAF50 (green when zero)

CARD 3 — Internet Exposure:
  → Drag [Internet Exposure Count] into Fields
  → Category label text: "INTERNET-FACING"
  → Border Color: #FF4444 (red)
  → Position: X: 840, Y: 80, Width: 220, Height: 120
  → Same conditional as Card 2

CARD 4 — SLA Compliance:
  → Drag [SLA Compliance %] into Fields
  → Category label text: "SLA COMPLIANCE"
  → Border Color: #4CAF50 (green accent)
  → Position: X: 1080, Y: 80, Width: 220, Height: 120
  → FORMAT the number:
    Click the measure in Fields well → Modeling ribbon → Format: Percentage
    OR: Format pane → Visual → Callout value → Display units: None, Decimal: 1
  → Conditional formatting:
    IF value < 70 THEN #FF4444 (red)
    IF value >= 70 AND < 90 THEN #FF8C00 (orange)
    IF value >= 90 THEN #4CAF50 (green)
```

#### Step 5: Add Slicers (Below Header)

```
SLICER 1 — Cloud Provider:
  1. Visualizations pane → Slicer icon (funnel with lines)
  2. Drag wiz_findings[cloud_provider] into "Field" well
  3. FORMAT:
     → Visual → Slicer settings → Style: "Tile"
       (click the dropdown — options are: Vertical list, Tile, Dropdown)
     → Visual → Slicer settings → Orientation: Horizontal
     → Visual → Selection → Single select: OFF (allow multi-select)
     → Visual → Values:
       Font: Segoe UI, Size: 11, Color: #FFFFFF
       Background: #2A2A3E
     → When selected: Background: #3498db (blue highlight)
     → General → Properties → Position:
       X: 1340, Y: 85, Width: 250, Height: 45

SLICER 2 — Severity:
  1. Same process → drag wiz_findings[severity] → Tile style
  2. Position: X: 1340, Y: 135, Width: 250, Height: 45

SLICER 3 — Category:
  1. Same process → drag wiz_findings[category] → Style: "Dropdown"
     (Dropdown is better here because there are many categories)
  2. Position: X: 1600, Y: 85, Width: 280, Height: 45
```

#### Step 6: Add Risk Trend Line Chart (Middle-Left)

```
1. Click empty canvas → Visualizations pane → "Line chart" icon
2. FIELD ASSIGNMENTS (drag from Fields pane):
   → X-axis: drag wiz_findings[Month_Year]
   → Y-axis: drag [Open Findings] from _Measures
   → Legend: drag wiz_findings[severity]
3. FORMAT (paint roller):
   → Visual → X-axis:
     Font: Segoe UI, Size: 10, Color: #A0A0C0
     Title: OFF
   → Visual → Y-axis:
     Font: Segoe UI, Size: 10, Color: #A0A0C0
     Title: OFF
     Gridlines: Color #3A3A5E
   → Visual → Lines:
     Stroke width: 2
   → Visual → Data colors:
     Click each series → set colors:
     CRITICAL: #FF4444, HIGH: #FF8C00, MEDIUM: #FFD700, LOW: #4CAF50
   → Visual → Markers: ON, Size: 4
   → Visual → Legend:
     Position: Top, Font Color: #A0A0C0, Size: 10
   → General → Title:
     Text: "Risk Trend — Open Findings by Severity"
     Font: Segoe UI, Size: 14, Color: #A0A0C0
   → General → Effects → Background: Color #2A2A3E
   → General → Effects → Border: ON, Color #3A3A5E, Round: 8px
   → General → Properties → Position:
     X: 40, Y: 350, Width: 600, Height: 300
```

#### Step 7: Add Cloud Provider Donut (Middle-Right)

```
1. Click empty canvas → Visualizations → "Donut chart" icon
2. FIELD ASSIGNMENTS:
   → Legend: drag wiz_findings[cloud_provider]
   → Values: drag [Open Findings] from _Measures
3. FORMAT:
   → Visual → Slices:
     Azure: #0078D4 (Microsoft blue)
     GCP: #4285F4 (Google blue)
   → Visual → Detail labels:
     ON, Label style: "Category, data value, percent of total"
     Font Size: 11, Color: #FFFFFF
   → Visual → Legend:
     Position: Bottom, Font Color: #A0A0C0
   → Visual → Inner radius: 60% (controls donut hole size)
   → General → Title: "Open Findings by Cloud Provider"
   → General → Effects → Background: #2A2A3E
   → General → Properties → Position:
     X: 660, Y: 350, Width: 400, Height: 300
```

#### Step 8: Add Risk by Business Unit Stacked Bar (Bottom-Left)

```
1. Click empty canvas → Visualizations → "Stacked bar chart" icon
2. FIELD ASSIGNMENTS:
   → Y-axis: drag cmdb_assets[business_unit]
   → X-axis: drag [Total Risk Score] from _Measures
   → Legend: drag wiz_findings[severity]
3. FORMAT:
   → Visual → Bars:
     CRITICAL: #FF4444, HIGH: #FF8C00, MEDIUM: #FFD700, LOW: #4CAF50
   → Visual → X-axis: Color: #A0A0C0, Gridlines: #3A3A5E
   → Visual → Y-axis: Color: #A0A0C0
   → Visual → Data labels: ON, Color: #FFFFFF, Size: 10
   → General → Title: "Risk Exposure by Business Unit"
   → General → Effects → Background: #2A2A3E
   → Position: X: 40, Y: 670, Width: 600, Height: 300

4. SORT the chart:
   → Click the three-dot menu (⋯) on the chart header
   → Sort by → "Total Risk Score"
   → Click again → Sort descending
   → Now the highest-risk BU is at the top
```

#### Step 9: Add Data Classification × Severity Matrix (Bottom-Right)

```
1. Click empty canvas → Visualizations → "Matrix" icon (grid with header)
2. FIELD ASSIGNMENTS:
   → Rows: drag wiz_findings[data_classification]
   → Columns: drag wiz_findings[severity]
   → Values: drag [Open Findings] from _Measures
3. FORMAT:
   → Visual → Column headers:
     Font: Segoe UI Bold, Size: 11, Color: #FFFFFF
     Background: #2A2A3E
   → Visual → Row headers:
     Font: Segoe UI, Size: 11, Color: #A0A0C0
   → Visual → Values:
     Font: Segoe UI, Size: 12, Color: #FFFFFF
   → Visual → Grid:
     Vertical gridlines: #3A3A5E
     Horizontal gridlines: #3A3A5E
     Row padding: 6
   → General → Title: "Sensitive Data Risk Heatmap"
   → General → Effects → Background: #2A2A3E
   → Position: X: 660, Y: 670, Width: 600, Height: 300

4. ADD HEATMAP CONDITIONAL FORMATTING:
   → In the Values field well, click the ▼ dropdown on [Open Findings]
   → Select "Conditional formatting" → "Background color"
   → Format style: Gradient
   → Minimum: Value 0, Color: #2A2A3E (dark — blends with background)
   → Maximum: Value 5, Color: #FF4444 (red — danger)
   → Click OK
   → Now cells with more findings glow increasingly red
```

---

## 📊 PAGE 2: SLA & REMEDIATION OPERATIONS

```
┌──────────────────────────────────────────────────────────────────────────┐
│ SLA & REMEDIATION OPERATIONS                              [ March 2025 ]│
│                                                                          │
│ ┌───────────┐  ┌───────────┐  ┌───────────┐  ┌───────────┐            │
│ │ SLA       │  │ SLA       │  │ SLA       │  │ MTTR      │            │
│ │ COMPLI-   │  │ BREACHED  │  │ AT RISK   │  │ (DAYS)    │            │
│ │ ANCE %    │  │           │  │           │  │           │            │
│ │   48%     │  │    18     │  │    7      │  │   5.2     │            │
│ │  🔴 FAIL  │  │  🔴 CRIT  │  │  🟠 WARN │  │  🟡 AVG   │            │
│ └───────────┘  └───────────┘  └───────────┘  └───────────┘            │
│                                                                          │
│ ┌──────────────────────────────────────────────────────────────────────┐│
│ │  SLA PERFORMANCE BY TEAM (Stacked Bar — most important chart)       ││
│ │                                                                      ││
│ │  Container-Platform  ████████ 3 breach │ 4 at risk │ 2 on track     ││
│ │  Platform-Eng        █████ 3 breach │ 0 at risk │ 2 on track       ││
│ │  Network-Ops         ████ 2 breach │ 0 at risk │ 3 on track        ││
│ │  Data-Engineering    ███ 2 breach │ 2 at risk │ 5 on track         ││
│ │  AppDev-Team         ███ 3 breach │ 1 at risk │ 1 on track         ││
│ │  Identity-Security   ██ 1 breach │ 0 at risk │ 2 on track          ││
│ └──────────────────────────────────────────────────────────────────────┘│
│                                                                          │
│ ┌────────────────────────────┐  ┌─────────────────────────────────────┐│
│ │  MTTR BY PRIORITY (Column) │  │  OPEN vs CLOSED TREND (Area Chart) ││
│ │                            │  │                                     ││
│ │  P1: 1.5 days (target: 1) │  │  Opened ↗ climbing steadily        ││
│ │  P2: 6.0 days (target: 7) │  │  Closed → flat (not keeping up)    ││
│ │  P3: 18 days (target: 30) │  │  Gap widening 🔴                    ││
│ │  P4: N/A (none closed)    │  │                                     ││
│ └────────────────────────────┘  └─────────────────────────────────────┘│
│                                                                          │
│ ┌──────────────────────────────────────────────────────────────────────┐│
│ │  OPEN CRITICAL FINDINGS — DRILLTHROUGH TABLE                        ││
│ │                                                                      ││
│ │  Finding | Title              | Days | Owner       | SLA    | BU     ││
│ │  WIZ-001 | S3 Public Access   | 75d  | Rajesh K    | BREACH | CapMkt ││
│ │  WIZ-002 | NSG SSH 0.0.0.0/0  | 72d  | Amit P      | BREACH | DigBnk ││
│ │  WIZ-009 | MFA Not Enforced   | 60d  | Priya S     | BREACH | EntSec ││
│ │  WIZ-012 | GKE Legacy ABAC    | 55d  | Kevin Z     | BREACH | DigBnk ││
│ │  WIZ-016 | NSG All Inbound    | 47d  | Amit P      | BREACH | Infra  ││
│ │  WIZ-023 | SA Owner Role      | 36d  | Kevin Z     | ATRISK | DigBnk ││
│ │  WIZ-024 | AKS Privileged     | 34d  | Kevin Z     | ATRISK | DigBnk ││
│ │  WIZ-040 | NSG MySQL Open     | 9d   | Sarah J     | ATRISK | RetBnk ││
│ └──────────────────────────────────────────────────────────────────────┘│
└──────────────────────────────────────────────────────────────────────────┘
```

### Build Instructions — Page 2 (Detailed)

#### Step 1: Page Setup

```
1. Click "+" at the bottom to add a new page
2. Right-click the new tab → Rename → "SLA & Remediation Operations"
3. Click empty canvas → Format pane (paint roller):
   → Canvas background: Color #1E1E2E, Transparency 0%
   → Canvas settings: Custom, 1920 × 1080
4. Add header text box (same method as Page 1):
   Text: "🔧 SLA & REMEDIATION OPERATIONS"
   Position: X: 0, Y: 0, Width: 1920, Height: 60
```

#### Step 2: Create 3 Additional DAX Measures (Needed for This Page)

```
Before building visuals, create these measures in _Measures table:
(Modeling → New Measure → paste each one)
```

```dax
Opened This Month = CALCULATE(
    COUNTROWS(wiz_findings),
    MONTH(wiz_findings[created_date]) = MONTH(TODAY()) &&
    YEAR(wiz_findings[created_date]) = YEAR(TODAY())
)
```

```dax
Closed This Month = CALCULATE(
    COUNTROWS(wiz_findings),
    wiz_findings[status] = "Closed",
    MONTH(wiz_findings[closed_date]) = MONTH(TODAY()) &&
    YEAR(wiz_findings[closed_date]) = YEAR(TODAY())
)
```

```dax
Net Change = [Opened This Month] - [Closed This Month]
```

#### Step 3: Add 4 SLA KPI Cards (Top Row)

```
Create 4 cards using the same method as Page 1:

CARD 1 — SLA Compliance %:
  → Drag [SLA Compliance %] into Fields
  → FORMAT:
    Callout value: Size 36, Color #FFFFFF
    Category label: "SLA COMPLIANCE", Color #A0A0C0
    Background: #2A2A3E
    Border: Left bar, Color #4CAF50, Width 4
    Position: X: 40, Y: 80, Width: 220, Height: 120
  → Conditional formatting (font color):
    < 70: #FF4444 (red)
    70-90: #FF8C00 (orange)
    ≥ 90: #4CAF50 (green)

CARD 2 — SLA Breached:
  → Drag [SLA Breached Count]
  → Category label: "SLA BREACHED"
  → Border: #FF4444 (red)
  → Position: X: 280, Y: 80, Width: 220, Height: 120
  → Conditional: > 0 THEN #FF4444 (always red)

CARD 3 — MTTR Days:
  → Drag [MTTR Days]
  → Category label: "AVG MTTR (DAYS)"
  → FORMAT: Decimal places: 1
  → Border: #FFD700 (gold)
  → Position: X: 520, Y: 80, Width: 220, Height: 120
  → Conditional: > 7 THEN #FF4444, 3-7 THEN #FF8C00, < 3 THEN #4CAF50

CARD 4 — Net Change:
  → Drag [Net Change]
  → Category label: "NET CHANGE (OPENED - CLOSED)"
  → Border: #9b59b6 (purple)
  → Position: X: 760, Y: 80, Width: 220, Height: 120
  → Conditional: > 0 THEN #FF4444 (backlog growing = bad)
                  = 0 THEN #FFD700
                  < 0 THEN #4CAF50 (backlog shrinking = good)
```

#### Step 4: Add SLA by Team — 100% Stacked Bar Chart

```
1. Visualizations → "100% Stacked bar chart" icon
   (NOT regular stacked bar — this shows PROPORTIONS)
2. FIELD ASSIGNMENTS:
   → Y-axis: drag wiz_findings[assignment_group]
             (or cmdb_assets[assignment_group] if using CMDB)
   → X-axis: drag [Open Findings] from _Measures
   → Legend: drag wiz_findings[SLA_Met]
3. FORMAT:
   → Visual → Bars → Data colors:
     Click each legend entry to set colors:
     "Breached": #FF4444 (red)
     "On Track": #4CAF50 (green)
     "Met": #2196F3 (blue)
     "Missed": #FF8C00 (orange)
   → Visual → Y-axis:
     Font: Segoe UI, Size: 11, Color: #FFFFFF
   → Visual → X-axis:
     Title: OFF
     Labels: ON, Color: #A0A0C0
   → Visual → Data labels:
     ON, Color: #FFFFFF, Size: 10
     Display units: None
   → Visual → Legend:
     Position: Top, Color: #A0A0C0
   → General → Title:
     Text: "SLA Performance by Assignment Group"
     Font: Segoe UI, Size: 14, Color: #A0A0C0
   → General → Effects → Background: #2A2A3E
   → General → Effects → Border: ON, #3A3A5E, Round 8px
   → Position: X: 40, Y: 220, Width: 940, Height: 300

4. SORT:
   → Click ⋯ (three dots) on chart → Sort by → Count of SLA Breached
   → Sort descending (team with most breaches at top)
```

#### Step 5: Add MTTR by Severity — Clustered Column Chart

```
1. Visualizations → "Clustered column chart"
2. FIELD ASSIGNMENTS:
   → X-axis: drag wiz_findings[severity]
   → Y-axis: drag [MTTR Days] from _Measures
3. FORMAT:
   → Visual → Columns → Data colors:
     CRITICAL: #FF4444, HIGH: #FF8C00, MEDIUM: #FFD700, LOW: #4CAF50
   → Visual → X-axis:
     Sort order: Use Severity_Order column
     HOW TO SORT BY Severity_Order:
       a. Click ⋯ on chart → Sort by → Severity_Order
       b. Now CRITICAL appears first, then HIGH, MEDIUM, LOW
     Font: Segoe UI, Size: 11, Color: #A0A0C0
   → Visual → Y-axis:
     Title: "Average Days to Resolve"
     Color: #A0A0C0
     Gridlines: #3A3A5E
   → Visual → Data labels: ON, Color #FFFFFF, Size 11
   → General → Title: "Mean Time to Remediate by Severity"
   → General → Effects → Background: #2A2A3E
   → Position: X: 40, Y: 540, Width: 450, Height: 280

4. ADD REFERENCE LINES (SLA targets):
   → Format → Visual → Reference lines (or "Analytics" pane on older versions)
   → Click "+" Add line → Constant line
     Value: 1, Label: "P1 Target (1 day)", Color: #FFFFFF, Style: Dashed
   → Add another: Value: 7, Label: "P2 Target (7 days)", Style: Dashed
   → Add another: Value: 30, Label: "P3 Target (30 days)", Style: Dashed
   → These horizontal lines show if teams meet their SLA targets
```

#### Step 6: Add Opened vs Closed Trend — Area Chart

```
1. Visualizations → "Area chart" icon
2. FIELD ASSIGNMENTS:
   → X-axis: drag wiz_findings[Month_Year]
   → Y-axis: drag BOTH measures:
     [Opened This Month]
     [Closed This Month]
3. FORMAT:
   → Visual → Data colors:
     Opened This Month: #FF4444 (red — new problems)
     Closed This Month: #4CAF50 (green — problems fixed)
   → Visual → Area transparency: 60% (so you can see overlap)
   → Visual → Lines: Stroke width 2
   → Visual → Legend:
     Position: Top, Color: #A0A0C0
   → Visual → X-axis: Color #A0A0C0, Title OFF
   → Visual → Y-axis: Color #A0A0C0, Gridlines #3A3A5E
   → General → Title: "Findings Opened vs Closed — Monthly Trend"
   → General → Effects → Background: #2A2A3E
   → Position: X: 510, Y: 540, Width: 470, Height: 280

INSIGHT TO LOOK FOR:
  → If red area > green area → backlog is GROWING (bad)
  → If green area > red area → backlog is SHRINKING (good)
  → The GAP between lines = net change per month
```

#### Step 7: Add Open Critical Findings Table

```
1. Visualizations → "Table" icon (grid with rows)
2. FIELD ASSIGNMENTS (drag each into the "Columns" well):
   → wiz_findings[finding_id]
   → wiz_findings[title]
   → wiz_findings[severity]
   → wiz_findings[Days_Open]
   → cmdb_assets[owner]
   → wiz_findings[SLA_Met]
   → cmdb_assets[business_unit]
3. ADD FILTERS (Filters pane on the right):
   → Drag wiz_findings[severity] into "Filters on this visual"
   → Expand it → check ONLY "CRITICAL" and "HIGH"
   → Drag wiz_findings[status] into "Filters on this visual"
   → Expand it → check ONLY "Open"
4. FORMAT:
   → Visual → Style: "Minimal" (from the Style dropdown at top)
   → Visual → Column headers:
     Font: Segoe UI Bold, Size: 11, Color: #FFFFFF
     Background: #3A3A5E
   → Visual → Values:
     Font: Segoe UI, Size: 10, Color: #FFFFFF
     Background: #2A2A3E, Alternate: #252540
   → Visual → Grid:
     Horizontal gridlines: #3A3A5E
     Row padding: 4
   → General → Title: "Open Critical/High Findings — Action Required"
   → General → Effects → Background: #2A2A3E
   → Position: X: 1000, Y: 80, Width: 880, Height: 740

5. SORT the table:
   → Click the "Days_Open" column header in the visual → sort descending
   → Oldest (most urgent) findings appear first

6. CONDITIONAL FORMATTING on Days_Open column:
   → Click ▼ dropdown on Days_Open in the Columns well
   → "Conditional formatting" → "Background color"
   → Format style: Rules
   → Rules:
     IF value > 60 THEN Background: #FF4444 (red — severely overdue)
     IF value > 30 AND ≤ 60 THEN Background: #FF8C00 (orange)
     IF value ≤ 30 THEN Background: #2A2A3E (dark — normal)
   → Click OK

7. CONDITIONAL FORMATTING on SLA_Met column:
   → Click ▼ dropdown on SLA_Met in Columns well
   → "Conditional formatting" → "Background color"
   → Format style: Rules
   → Rules:
     IF value = "Breached" THEN Background: #FF4444
     IF value = "Missed" THEN Background: #FF8C00
     IF value = "On Track" THEN Background: #4CAF50
     IF value = "Met" THEN Background: #2196F3
   → Click OK
```

---

## 📊 PAGE 3: POSTURE IMPROVEMENT & COMPLIANCE

```
┌──────────────────────────────────────────────────────────────────────────┐
│ POSTURE IMPROVEMENT & COMPLIANCE                          [ March 2025 ]│
│                                                                          │
│ ┌──────────────────────────────────────────────────────────────────────┐│
│ │  FINDINGS BY CATEGORY (Treemap)                                     ││
│ │                                                                      ││
│ │  ┌──────────────┬──────────────┬──────────────┐                     ││
│ │  │   NETWORK    │     IAM      │   STORAGE    │                     ││
│ │  │   10 (20%)   │   10 (20%)   │   10 (20%)   │                     ││
│ │  ├──────────────┼──────────┬───┴──────────────┤                     ││
│ │  │  CONTAINER   │ COMPUTE  │ ENCRYPT │  DB    │                     ││
│ │  │   8 (16%)    │  4 (8%)  │ 3 (6%)  │ 3 (6%)│                     ││
│ │  └──────────────┴──────────┴─────────┴────────┘                     ││
│ └──────────────────────────────────────────────────────────────────────┘│
│                                                                          │
│ ┌────────────────────────────┐  ┌─────────────────────────────────────┐│
│ │  CIS BENCHMARK GAPS        │  │  AGING ANALYSIS (Histogram)        ││
│ │  (Horizontal Bar)          │  │                                     ││
│ │                            │  │  0-7d:   ████ 8 findings            ││
│ │  CIS Azure 6.x Network: 5 │  │  8-30d:  ██████ 12 findings        ││
│ │  CIS Azure 1.x IAM:     4 │  │  31-60d: ████████ 14 findings      ││
│ │  CIS Azure 3.x Storage: 4 │  │  60+d:   ██████ 6 findings 🔴      ││
│ │  CIS GKE 6.x Container: 3 │  │                                     ││
│ │  CIS GCP 1.x IAM:       3 │  │                                     ││
│ │  CIS Azure 7.x Compute: 2 │  │                                     ││
│ └────────────────────────────┘  └─────────────────────────────────────┘│
│                                                                          │
│ ┌──────────────────────────────────────────────────────────────────────┐│
│ │  🔑 TOP 5 IMPROVEMENT RECOMMENDATIONS                              ││
│ │                                                                      ││
│ │  1. 🔴 ELIMINATE SLA BREACHES: 18 breached tickets (36%).           ││
│ │     → Implement automated escalation at 75% of SLA window.          ││
│ │     → Impact: SLA compliance from 48% → target 85%+                 ││
│ │                                                                      ││
│ │  2. 🔴 CLOSE 8 OPEN CRITICAL FINDINGS: Some are 60-75 days old.    ││
│ │     → Weekly CISO review for all P1s. War-room for findings >30d.   ││
│ │     → Impact: Security Score from 37 → estimated 69                  ││
│ │                                                                      ││
│ │  3. 🟠 HARDEN CONTAINER SECURITY: 8 container findings (16%).       ││
│ │     → Deploy PSA restricted on production namespaces.               ││
│ │     → Enable KAC to block privileged/root pods. Impact: -8 findings ││
│ │                                                                      ││
│ │  4. 🟠 LOCK DOWN NETWORK LAYER: 10 network findings (20%).         ││
│ │     → Auto-remediate 0.0.0.0/0 rules via Lambda/Azure Function.    ││
│ │     → Enforce NSG baseline via Azure Policy. Impact: -6 findings    ││
│ │                                                                      ││
│ │  5. 🟡 ENFORCE MFA & IAM HYGIENE: 10 IAM findings (20%).           ││
│ │     → Entra ID Conditional Access policies. Rotate stale SA keys.   ││
│ │     → Automate key rotation for GCP Service Accounts.               ││
│ └──────────────────────────────────────────────────────────────────────┘│
│                                                                          │
│ ┌──────────────────────────────────────────────────────────────────────┐│
│ │  OWNER ACCOUNTABILITY MATRIX                                        ││
│ │                                                                      ││
│ │  Owner          │ Critical │ High │ Breached │ Score │ Status        ││
│ │  Kevin Zhang    │    3     │   3  │    3     │  48   │ 🔴 Overloaded ││
│ │  Amit Patel     │    2     │   0  │    2     │  24   │ 🟠 At Limit   ││
│ │  Rajesh Kumar   │    1     │   2  │    3     │  19   │ 🟠 At Limit   ││
│ │  Sarah Johnson  │    1     │   1  │    2     │  17   │ 🟠 At Limit   ││
│ │  Priya Sharma   │    1     │   1  │    1     │  14   │ 🟡 Managing   ││
│ │  Others         │    0     │   5  │    3     │  10   │ 🟡 Managing   ││
│ └──────────────────────────────────────────────────────────────────────┘│
└──────────────────────────────────────────────────────────────────────────┘
```

### Build Instructions — Page 3 (Detailed)

#### Step 1: Page Setup

```
1. Click "+" at bottom → Rename → "Posture Improvement & Compliance"
2. Canvas background: #1E1E2E, Canvas: 1920 × 1080
3. Add header text box:
   Text: "📋 POSTURE IMPROVEMENT & COMPLIANCE"
   Position: X: 0, Y: 0, Width: 1920, Height: 60
```

#### Step 2: Add Category Treemap (Top — Full Width)

```
1. Visualizations → "Treemap" icon (nested rectangles)
2. FIELD ASSIGNMENTS:
   → Group: drag wiz_findings[category]
   → Values: drag [Open Findings] from _Measures
3. ADD FILTER:
   → Drag wiz_findings[status] into "Filters on this visual"
   → Check ONLY "Open"
4. FORMAT:
   → Visual → Data colors:
     Click each category rectangle to set color:
     Network: #FF4444, IAM: #FF8C00, Storage: #FFD700
     Container: #e74c3c, Compute: #9b59b6
     Encryption: #3498db, Database: #2ecc71
   → Visual → Category labels:
     Font: Segoe UI Bold, Size: 12, Color: #FFFFFF
   → Visual → Data labels:
     ON, Display units: None, Color: #FFFFFF
     Label format: Category + Value (e.g., "Network - 10")
   → General → Title: "Open Findings by Security Category"
   → General → Effects → Background: #2A2A3E
   → General → Effects → Border: ON, #3A3A5E, Round 8px
   → Position: X: 40, Y: 80, Width: 1840, Height: 250

5. INTERACTION:
   → Clicking a category filters ALL other visuals on this page
   → Click "Network" → CIS gaps chart shows only network benchmarks
```

#### Step 3: Add CIS Benchmark Gaps — Clustered Bar Chart (Middle-Left)

```
1. Visualizations → "Clustered bar chart" (horizontal bars)
2. FIELD ASSIGNMENTS:
   → Y-axis: drag wiz_findings[compliance_framework]
   → X-axis: drag [Open Findings] from _Measures
3. ADD FILTER:
   → wiz_findings[status] → check only "Open"
4. FORMAT:
   → Visual → Bars:
     All bars: #3498db (or conditional by count)
   → Visual → Y-axis:
     Font: Segoe UI, Size: 10, Color: #A0A0C0
     Title: OFF
   → Visual → X-axis:
     Color: #A0A0C0, Gridlines: #3A3A5E
   → Visual → Data labels: ON, Color #FFFFFF, Size: 10
   → General → Title: "CIS Benchmark Gaps — Open Findings by Framework"
   → General → Effects → Background: #2A2A3E
   → Position: X: 40, Y: 350, Width: 450, Height: 280

5. SORT:
   → Click ⋯ → Sort by → Open Findings → Sort descending
   → Framework with most gaps appears at top
```

#### Step 4: Add Finding Age Distribution — Column Chart (Middle-Right)

```
1. Visualizations → "Clustered column chart" (vertical bars)
2. FIELD ASSIGNMENTS:
   → X-axis: drag wiz_findings[Age_Bucket]
   → Y-axis: drag [Open Findings] from _Measures
3. ADD FILTER:
   → wiz_findings[status] → check only "Open"
4. FORMAT:
   → Visual → Columns:
     Default: #3498db
   → Visual → X-axis:
     Font: Segoe UI, Size: 11, Color: #A0A0C0
   → Visual → Data labels: ON, Color #FFFFFF
   → General → Title: "Finding Age Distribution"
   → General → Effects → Background: #2A2A3E
   → Position: X: 510, Y: 350, Width: 450, Height: 280

5. SORT X-axis to correct order (0-7, 8-30, 31-60, 60+):
   → Click ⋯ → Sort by → Age_Bucket
   → If wrong order, you need a sort column:
     Go to Modeling → New Column on wiz_findings table:
     Age_Bucket_Order =
       SWITCH([Age_Bucket],
         "0-7 days", 1,
         "8-30 days", 2,
         "31-60 days", 3,
         "60+ days", 4, 5)
   → Then: Click ⋯ → Sort by → Age_Bucket_Order

6. CONDITIONAL FORMATTING on columns:
   → Format → Visual → Columns → Color → click "fx"
   → Format style: Rules, Based on: [Open Findings]
   → Rules:
     IF Age_Bucket = "60+ days" THEN #FF4444 (red)
     IF Age_Bucket = "31-60 days" THEN #FF8C00 (orange)
     ELSE #3498db (blue)
   → Click OK → the "60+ days" column is now RED (urgency!)
```

#### Step 5: Add Improvement Recommendations — Text Box (Bottom-Left)

```
1. Insert ribbon → Text box
2. Click-drag a rectangle on the canvas
3. Type the following (with formatting):

   🔑 TOP 5 IMPROVEMENT RECOMMENDATIONS

   1. 🔴 ELIMINATE SLA BREACHES
      18 breached tickets (36%). Implement automated escalation
      at 75% of SLA window. Target: 85%+ SLA compliance.

   2. 🔴 CLOSE OPEN CRITICALS
      8 open Criticals, some 60+ days old. Weekly CISO review.
      Impact: Security Score 37 → 69.

   3. 🟠 HARDEN CONTAINERS
      8 container findings. Deploy PSA restricted + KAC.
      Impact: -8 findings.

   4. 🟠 LOCK DOWN NETWORK
      10 network findings. Auto-remediate 0.0.0.0/0 rules.
      Impact: -6 findings.

   5. 🟡 ENFORCE IAM HYGIENE
      10 IAM findings. MFA via Conditional Access. Rotate SA keys.

4. FORMAT the text:
   → Title line: Segoe UI Bold, Size 14, Color: #FFD700 (gold)
   → Item numbers: Bold, Color: #FFFFFF
   → Body text: Segoe UI, Size: 10, Color: #A0A0C0
5. FORMAT the text box:
   → General → Effects → Background: #2A2A3E
   → General → Effects → Border: ON, #3A3A5E, Round 8px
   → Position: X: 40, Y: 650, Width: 600, Height: 350

NOTE: This is STATIC text — update it monthly based on current data.
```

#### Step 6: Add Owner Accountability Matrix (Bottom-Right)

```
1. Visualizations → "Matrix" icon
2. FIELD ASSIGNMENTS:
   → Rows: drag cmdb_assets[owner]
   → Values: drag these in ORDER:
     [Critical Open]
     [High Open]
     [SLA Breached Count]
     [MTTR Days]
     [Total Risk Score]
3. FORMAT:
   → Visual → Row headers:
     Font: Segoe UI, Size: 11, Color: #FFFFFF
   → Visual → Column headers:
     Font: Segoe UI Bold, Size: 10, Color: #A0A0C0
     Background: #3A3A5E
   → Visual → Values:
     Font: Segoe UI, Size: 11, Color: #FFFFFF
   → Visual → Grid:
     Row padding: 6
     Horizontal gridlines: #3A3A5E
   → General → Title: "Owner Accountability — Risk & SLA Performance"
   → General → Effects → Background: #2A2A3E
   → Position: X: 660, Y: 650, Width: 600, Height: 350

4. SORT:
   → Click ⋯ → Sort by → Total Risk Score → descending
   → Highest-risk owner appears first

5. CONDITIONAL FORMATTING on Critical Open column:
   → Click ▼ on [Critical Open] in Values well
   → "Conditional formatting" → "Background color"
   → Rules:
     IF value > 2 THEN Background: #FF4444 (red)
     IF value = 1 or 2 THEN Background: #FF8C00 (orange)
     IF value = 0 THEN Background: #2A2A3E (dark)
   → Click OK

6. CONDITIONAL FORMATTING on SLA Breached Count:
   → Same process:
     IF value > 2 THEN #FF4444 (red)
     IF value = 1 or 2 THEN #FF8C00 (orange)
     IF value = 0 THEN #4CAF50 (green)

7. CONDITIONAL FORMATTING on Total Risk Score (data bars):
   → Click ▼ on [Total Risk Score] → "Conditional formatting" → "Data bars"
   → Positive bar: #FF4444 (red fill)
   → Show bar only: NO (show number AND bar)
   → Click OK → horizontal bars inside cells show relative risk
```

---

## 📊 BONUS PAGE: DRILL-THROUGH DETAIL PAGE (Detailed Setup)

```
This page shows FULL DETAILS when someone right-clicks a finding,
team, or severity on any other page and selects "Drill through."
```

#### Step 1: Create the Drill-Through Page

```
1. Click "+" → Rename → "Finding Detail"
2. Canvas background: #1E1E2E
3. Add header text: "🔍 FINDING DETAIL — DRILL-THROUGH"

4. CONFIGURE DRILL-THROUGH FIELDS:
   → Click the empty canvas (no visual selected)
   → In the Visualizations pane, find "Drill through" section at bottom
   → Drag these fields into the Drill-through wells:
     wiz_findings[severity]
     cmdb_assets[assignment_group]
     cmdb_assets[owner]
   → Cross-report drill-through: ON (allows drill from other pages)

5. Power BI auto-adds a "← Back" button — keep it!
   → Format the back button:
     Text: "← Back to Dashboard"
     Background: #3498db
     Font color: #FFFFFF
     Position: X: 40, Y: 80, Width: 180, Height: 35
```

#### Step 2: Add Detail Table on Drill-Through Page

```
1. Visualizations → "Table"
2. COLUMNS (drag all of these):
   → wiz_findings[finding_id]
   → wiz_findings[title]
   → wiz_findings[severity]
   → wiz_findings[status]
   → wiz_findings[category]
   → wiz_findings[cloud_provider]
   → wiz_findings[resource_name]
   → wiz_findings[Days_Open]
   → wiz_findings[SLA_Met]
   → cmdb_assets[owner]
   → cmdb_assets[owner_email]
   → cmdb_assets[assignment_group]
   → cmdb_assets[business_unit]
   → cmdb_assets[environment]
   → cmdb_assets[data_classification]
   → wiz_findings[compliance_framework]
3. FORMAT:
   → Same dark theme as other tables
   → Full page width: X: 40, Y: 130, Width: 1840, Height: 900
   → Conditional formatting on severity, SLA_Met, Days_Open
     (same rules as Page 2 table)

HOW TO USE:
  → On Page 1, right-click any bar in the "Risk by BU" chart
  → Select "Drill through" → "Finding Detail"
  → The detail page shows ONLY findings for that business unit
  → Click "← Back" to return to the original page
```

---

## ✅ PAGE NAVIGATION — Connect All Pages

#### Option 1: Page Navigator (Recommended)

```
1. On EACH page, add navigation:
   → Insert ribbon → Buttons → Navigator → "Page navigator"
   → Power BI auto-creates buttons for all pages
2. FORMAT:
   → Shape → Fill: #2A2A3E
   → Shape → Outline: #3A3A5E
   → Text → Color: #FFFFFF, Size: 11
   → Selected state → Fill: #3498db (blue highlight for current page)
   → Position: top-right corner of each page
     X: 1400, Y: 10, Width: 500, Height: 40
3. HIDE the drill-through page from navigation:
   → Right-click "Finding Detail" tab → "Hide page"
   → It won't show in the navigator but is still accessible via drill-through
```

#### Option 2: Custom Buttons

```
1. Insert → Buttons → Blank
2. Format:
   → Text: "Executive Summary" (or whichever page)
   → Action → Type: "Page navigation"
   → Action → Destination: select the target page
3. Repeat for each page
4. Style them as tabs across the top
```

---

## 🕐 ADD LAST REFRESH DATE

```
1. Create a DAX measure:

Last Refresh = "Data as of: " & FORMAT(NOW(), "DD-MMM-YYYY HH:MM")

2. Add a Card visual on each page:
   → Drag [Last Refresh] into Fields
   → FORMAT:
     Callout value: Size 11, Color: #A0A0C0
     Category label: OFF
     Background: transparent (or match header)
   → Position: top-right corner, X: 1700, Y: 15, Width: 200, Height: 35
3. This updates automatically every time the dashboard refreshes
```

---

# PART 6: WHAT THE DATA TELLS US — IMPROVEMENT ROADMAP

## 6.1 Current State Assessment

| Metric | Current | Target | Gap | Priority |
|--------|---------|--------|-----|----------|
| Security Score | **37/100** | 75/100 | 38 points | 🔴 P1 |
| SLA Compliance | **48%** | 90% | 42% gap | 🔴 P1 |
| Critical Open | **8** | 0 | 8 findings | 🔴 P1 |
| MTTR (P1) | **~5 days** | 1 day | 4 days | 🟠 P2 |
| Closure Rate | **20%** | 80%+ | 60% gap | 🟠 P2 |
| Internet Exposure | **8** | 0 | 8 findings | 🔴 P1 |

## 6.2 30-60-90 Day Improvement Plan

### Days 1-30: STOP THE BLEEDING
```
OBJECTIVE: Close all Critical findings and fix SLA breach process

ACTIONS:
├── Week 1: War room for 8 open Criticals
│   ├── WIZ-001: S3 public access → disable public access (1 hour fix)
│   ├── WIZ-002: NSG SSH 0.0.0.0/0 → restrict to VPN CIDR (1 hour fix)
│   ├── WIZ-009: MFA not enforced → enable Conditional Access policy
│   └── WIZ-016: NSG all inbound → restrict immediately
│
├── Week 2: Fix remaining Criticals
│   ├── WIZ-012: GKE legacy ABAC → enable RBAC, disable ABAC
│   ├── WIZ-023: SA Owner role → scope down to specific permissions
│   ├── WIZ-024: AKS privileged pod → remove privileged, add specific caps
│   └── WIZ-040: NSG MySQL open → restrict to app subnet CIDR
│
├── Week 3-4: Fix SLA process
│   ├── Implement auto-escalation: 50% SLA → email owner
│   ├── 75% SLA → email manager
│   ├── 100% SLA breached → email director + CISO
│   └── Weekly SLA dashboard review with all team leads

EXPECTED IMPACT:
├── Security Score: 37 → 69 (closing 8 Criticals removes 32 points of deductions)
├── Critical Open: 8 → 0
├── SLA Breach Rate: 36% → starts declining
└── Internet Exposure: 8 → 0
```

### Days 31-60: FIX THE FOUNDATION
```
OBJECTIVE: Address High-severity backlog and implement preventive controls

ACTIONS:
├── Close 12 open HIGH findings (prioritize internet-facing and Restricted data)
├── Deploy KAC/PSA on all production K8s namespaces
│   ├── PSA enforce: baseline on all namespaces
│   ├── PSA enforce: restricted on payments, PII namespaces
│   └── KAC: block privileged, unscanned images, Docker Hub
├── Deploy auto-remediation for:
│   ├── S3/GCS public access → auto-disable via Lambda/Cloud Function
│   ├── NSG 0.0.0.0/0 rules → auto-fix via Azure Function
│   └── Unencrypted storage → auto-enable encryption
├── Implement NetworkPolicies: default-deny on all prod namespaces

EXPECTED IMPACT:
├── Security Score: 69 → 81
├── High Open: 12 → 0
├── New findings auto-remediated before becoming tickets
└── Container findings reduced by 80%
```

### Days 61-90: CONTINUOUS IMPROVEMENT
```
OBJECTIVE: Achieve steady-state security posture management

ACTIONS:
├── Clear Medium/Low backlog (16 findings)
├── Implement shift-left scanning in CI/CD
│   ├── IaC scanning (Checkov/tfsec) in Terraform pipelines
│   ├── Container image scanning in build pipeline
│   └── Break builds for Critical CVEs
├── Monthly executive report automation (Power BI scheduled refresh)
├── Quarterly CIS benchmark assessment review
├── Set up Wiz → ServiceNow auto-ticket creation for new findings

EXPECTED IMPACT:
├── Security Score: 81 → 90+
├── SLA Compliance: 90%+
├── New findings caught at build time (before production)
└── MTTR: P1 = <24 hours, P2 = <7 days
```

---

# PART 7: INTERVIEW TALKING POINTS

### Q: "How would you present cloud security posture to the CEO?"

> "I build a 3-page Power BI dashboard. Page 1 is the CEO view: one Security Score number (0-100), risk trend, and business unit exposure — they see in 10 seconds if we're improving or declining. Page 2 is operational: SLA compliance, team performance, MTTR, and a drill-through table of every open Critical finding. Page 3 is for GRC and audit: CIS benchmark gaps, compliance framework coverage, and actionable improvement recommendations. The dashboard connects to Wiz findings via API, enriches with CMDB ownership data, and pulls ticket SLA status from ServiceNow. I refresh it daily and present monthly to leadership."

### Q: "What metrics matter most for a CISO?"

> "Three metrics. **One: SLA Compliance %** — are we fixing things on time? In our current data, we're at 48% which is unacceptable for a financial institution. **Two: Security Score trend** — is the number going up or down month-over-month? A declining score means we're falling behind. **Three: MTTR by severity** — how fast are we closing Critical vs High vs Medium? If our P1 MTTR is 5 days but our SLA is 24 hours, there's a fundamental process failure. These three metrics together tell the CISO: are we finding things, are we fixing them fast enough, and is the overall trend positive?"

### Q: "What improvement would you recommend based on the data?"

> "Based on 50 findings, three immediate actions. **First:** War-room the 8 open Criticals — some are 60+ days old and internet-facing. Most are quick fixes (disable public access, restrict NSG rules). Closing these alone raises our Security Score from 37 to 69. **Second:** Fix the SLA process — 36% breach rate means automated escalation isn't working. I'd implement tiered escalation (50% → owner, 75% → manager, 100% → CISO) via ServiceNow workflow. **Third:** Deploy preventive controls — KAC for Kubernetes, auto-remediation Lambda for network/storage misconfigs, and IaC scanning to catch issues before they reach production."

---

# PART 8: MCP payload → Power BI model mapping (final mapping for `PowerBI_Project/EXECUTIVE_DASHBOARD_GUIDE`)

## 8.1 MCP payload schema (discover from `/mcp/model`)

Assume API returns:

```json
{
  "id": "CNAPP",
  "tables": [
    {"name":"Findings","columns":[{"name":"finding_id","dataType":"string"},{"name":"severity","dataType":"string"},{"name":"status","dataType":"string"},{"name":"created_date","dataType":"date"},{"name":"closed_date","dataType":"date"},{"name":"internet_facing","dataType":"string"},{"name":"resource_id","dataType":"string"},{"name":"category","dataType":"string"},{"name":"risk_score","dataType":"int64"}]},
    {"name":"Assets","columns":[{"name":"resource_id","dataType":"string"},{"name":"business_unit","dataType":"string"},{"name":"environment","dataType":"string"},{"name":"owner","dataType":"string"}]},
    {"name":"Tickets","columns":[{"name":"ticket_id","dataType":"string"},{"name":"finding_id","dataType":"string"},{"name":"sla_status","dataType":"string"},{"name":"created_date","dataType":"date"},{"name":"resolved_date","dataType":"date"},{"name":"assignment_group","dataType":"string"}]}
  ]
}
```

## 8.2 Power Query mapping

- Keep all MCP columns verbatim in the respective queries: `Findings`, `Assets`, `Tickets`.
- Apply the same transformations in PART 2, Step 2
  - `Findings` → add `Days Open`, `SLA Met`, `Risk Score`, etc.
  - `Assets` → keep as dimension, add any lookup mappings
  - `Tickets` → add `Days to Resolve`, `Priority Order`

## 8.3 Relationships from MCP to DAX

In Model view:
1. `Findings[resource_id]` (many) → `Assets[resource_id]` (one)
2. `Findings[finding_id]` (one) → `Tickets[finding_id]` (one)
3. `DateTable[Date]` (one) → `Findings[created_date]` (many)

This transforms MCP object graph into tabular in-memory relationship graph for DAX.

## 8.4 DAX measures (from MCP contextual data)

`Total Findings = COUNTROWS(Findings)`

`Open Findings = CALCULATE(COUNTROWS(Findings), Findings[status] = "Open")`

`Critical Open = CALCULATE(COUNTROWS(Findings), Findings[severity] = "CRITICAL", Findings[status] = "Open")`

`SLA Compliance % = DIVIDE(CALCULATE(COUNTROWS(Tickets), Tickets[sla_status] = "Met"), COUNTROWS(Tickets), 0) * 100`

`Enterprise Risk Score = SUMX(Findings, Findings[risk_score])`

`MTTR (days) =
DIVIDE(
   SUMX(FILTER(Tickets, NOT(ISBLANK(Tickets[resolved_date]))), DATEDIFF(Tickets[created_date], Tickets[resolved_date], DAY)),
   COUNTROWS(FILTER(Tickets, NOT(ISBLANK(Tickets[resolved_date])))),
   BLANK()
)`

`Findings trend (monthly) = CALCULATE([Total Findings], DATESINPERIOD(DateTable[Date], LASTDATE(DateTable[Date]), -12, MONTH))`

## 8.5 Final Power BI report (from Executive_Dashboard_Guide)

- Page 1: CEO snapshot (risk score, total findings, SLA compliance, business unit exposure, internet-facing criticals)
- Page 2: Operations production (open/closed trend, SLA breach by assignment group, MTTR, backlog age buckets)
- Page 3: GRC (compliance framework, CIS coverage, production/dev risk posture)

> Now you have a full mapping from MCP API model (schema + relationships) to Power BI implementation and final executive report layout.$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$INDEX$VELSEC$, $VELSEC$Index$VELSEC$, $VELSEC$Data Analyst$VELSEC$, ARRAY['Data_Analytics']::TEXT[], $VELSEC$﻿# Data Analytics

Index of files in this directory:

- [Excel_Data_Analysis_Complete_Tutorial.md](./Excel/Excel_Data_Analysis_Complete_Tutorial.md)
- [Excel_Skills_Mastery_Guide.md](./Excel/Excel_Skills_Mastery_Guide.md)
- [PowerBI_Learning_Module.md](./PowerBI/PowerBI_Learning_Module.md)
- [BUILD_REPORT_WITH_MCP_SERVER.md](./PowerBI/PowerBI_Project/BUILD_REPORT_WITH_MCP_SERVER.md)
- [Executive_Dashboard_Guide.md](./PowerBI/PowerBI_Project/Executive_Dashboard_Guide.md)
- [Live_Data_Pipeline_Guide.md](./PowerBI/PowerBI_Project/Live_Data_Pipeline_Guide.md)
- [PART_7A_EXECUTIVE_PAGE_DETAILED.md](./PowerBI/PowerBI_Project/PART_7A_EXECUTIVE_PAGE_DETAILED.md)
- [PART_7B_OPERATIONAL_PAGE_DETAILED.md](./PowerBI/PowerBI_Project/PART_7B_OPERATIONAL_PAGE_DETAILED.md)
- [PART_7C_RISK_ANALYSIS_PAGE_DETAILED.md](./PowerBI/PowerBI_Project/PART_7C_RISK_ANALYSIS_PAGE_DETAILED.md)
- [PROJECT_GUIDE.md](./PowerBI/PowerBI_Project/PROJECT_GUIDE.md)
- [Role_Validation_Workflow_Guide.md](./PowerBI/PowerBI_Project/Role_Validation_Workflow_Guide.md)
- [cmdb_assets.csv](./PowerBI/PowerBI_Project/data/cmdb_assets.csv)
- [cspm.pbix](./PowerBI/PowerBI_Project/data/cspm.pbix)
- [servicenow_tickets.csv](./PowerBI/PowerBI_Project/data/servicenow_tickets.csv)
- [wiz_findings.csv](./PowerBI/PowerBI_Project/data/wiz_findings.csv)
- [server.py](./PowerBI/PowerBI_Project/mcp/server.py)
- [SQL_Masterclass_Part1_Foundations.md](./SQL/SQL_Masterclass_Part1_Foundations.md)
- [SQL_Masterclass_Part2_Intermediate.md](./SQL/SQL_Masterclass_Part2_Intermediate.md)
- [SQL_Masterclass_Part3_Advanced.md](./SQL/SQL_Masterclass_Part3_Advanced.md)
- [Phase1_Foundations.md](./SQL/SQL_Mastery/Phase1_Foundations.md)
- [Phase2_Intermediate.md](./SQL/SQL_Mastery/Phase2_Intermediate.md)
- [Phase3_Advanced.md](./SQL/SQL_Mastery/Phase3_Advanced.md)
- [Phase4_Expert.md](./SQL/SQL_Mastery/Phase4_Expert.md)
- [Phase5_Scenarios.md](./SQL/SQL_Mastery/Phase5_Scenarios.md)
- [Phase6_SIEM_Project.md](./SQL/SQL_Mastery/Phase6_SIEM_Project.md)$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Live_Data_Pipeline_Guide$VELSEC$, $VELSEC$Live Data Pipeline Guide$VELSEC$, $VELSEC$Data Analyst$VELSEC$, ARRAY['Data_Analytics']::TEXT[], $VELSEC$# 🔗 Live Data Pipeline — Wiz API + SQL CMDB + ServiceNow → Power BI

> **Goal:** Automate daily data extraction from 3 sources using Python,
> store in a central SQL database, and connect Power BI with scheduled refresh.
> Present to leadership monthly with zero manual data prep.

---

# ARCHITECTURE OVERVIEW

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                     LIVE DATA PIPELINE ARCHITECTURE                          │
│                                                                              │
│  ┌──────────┐    ┌──────────┐    ┌──────────────┐                           │
│  │  WIZ      │    │  CMDB    │    │  SERVICENOW  │                           │
│  │  (API)    │    │  (SQL)   │    │  (REST API)  │                           │
│  └─────┬────┘    └────┬─────┘    └──────┬───────┘                           │
│        │              │                  │                                    │
│        ▼              ▼                  ▼                                    │
│  ┌─────────────────────────────────────────────────┐                        │
│  │           PYTHON ETL SCRIPTS                     │                        │
│  │                                                  │                        │
│  │  extract_wiz.py     → wiz_findings table         │                        │
│  │  extract_cmdb.py    → cmdb_assets table          │                        │
│  │  extract_snow.py    → servicenow_tickets table   │                        │
│  │  run_pipeline.py    → orchestrator (runs all 3)  │                        │
│  └──────────────────────┬───────────────────────────┘                        │
│                         │                                                    │
│                         ▼                                                    │
│  ┌──────────────────────────────────────────────────┐                        │
│  │          SQL SERVER / POSTGRESQL                   │                        │
│  │          (Central Data Warehouse)                  │                        │
│  │                                                    │                        │
│  │  security_dashboard.wiz_findings                   │                        │
│  │  security_dashboard.cmdb_assets                    │                        │
│  │  security_dashboard.servicenow_tickets             │                        │
│  │  security_dashboard.refresh_log                    │                        │
│  └──────────────────────┬────────────────────────────┘                        │
│                         │                                                    │
│                         ▼                                                    │
│  ┌──────────────────────────────────────────────────┐                        │
│  │          POWER BI                                  │                        │
│  │  DirectQuery / Import + Scheduled Refresh          │                        │
│  │                                                    │                        │
│  │  Page 1: CEO Risk Overview                         │                        │
│  │  Page 2: SLA Operations                            │                        │
│  │  Page 3: Posture Improvement                       │                        │
│  └────────────────────────────────────────────────────┘                        │
│                                                                              │
│  ┌────────────────────────────────────────────────────┐                       │
│  │  SCHEDULER                                          │                       │
│  │  Windows Task Scheduler / cron / Azure Function     │                       │
│  │  Runs: daily at 6:00 AM UTC                         │                       │
│  └────────────────────────────────────────────────────┘                       │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

# PART 1: PREREQUISITES & SETUP

## 1.1 Install Python Dependencies

```bash
# Create a virtual environment for the pipeline
python -m venv C:\SecurityDashboard\venv
C:\SecurityDashboard\venv\Scripts\activate

# Install required packages
pip install requests         # HTTP calls to Wiz & ServiceNow APIs
pip install pyodbc           # SQL Server connection
pip install psycopg2-binary  # PostgreSQL connection (alternative)
pip install sqlalchemy       # ORM for database operations
pip install pandas           # Data manipulation
pip install python-dotenv    # Environment variable management
pip install schedule         # Task scheduling (optional)
pip install logging          # Already built-in, just import
```

## 1.2 Project Folder Structure

```
C:\SecurityDashboard\
├── .env                      # API keys and DB credentials (NEVER commit)
├── config.py                 # Configuration loader
├── extract_wiz.py            # Wiz API extractor
├── extract_cmdb.py           # SQL CMDB extractor
├── extract_snow.py           # ServiceNow API extractor
├── run_pipeline.py           # Orchestrator — runs all 3 + logs results
├── db_setup.py               # Creates tables in SQL Server
├── requirements.txt          # pip freeze output
└── logs/
    └── pipeline.log          # Execution logs
```

## 1.3 Environment Variables (`.env` file)

```env
# ========================
# WIZ API CREDENTIALS
# ========================
WIZ_CLIENT_ID=your-wiz-service-account-client-id
WIZ_CLIENT_SECRET=your-wiz-service-account-client-secret
WIZ_API_URL=https://api.us20.app.wiz.io/graphql
WIZ_AUTH_URL=https://auth.app.wiz.io/oauth/token
WIZ_AUDIENCE=wiz-api

# ========================
# SQL SERVER (CMDB + Data Warehouse)
# ========================
SQL_SERVER=your-sql-server.database.windows.net
SQL_DATABASE=security_dashboard
SQL_USERNAME=dashboard_svc_account
SQL_PASSWORD=your-strong-password
SQL_DRIVER=ODBC Driver 17 for SQL Server

# CMDB is on a DIFFERENT SQL server (or same server, different DB)
CMDB_SQL_SERVER=cmdb-server.database.windows.net
CMDB_SQL_DATABASE=cmdb_production
CMDB_SQL_USERNAME=cmdb_readonly_user
CMDB_SQL_PASSWORD=cmdb-readonly-password

# ========================
# SERVICENOW API CREDENTIALS
# ========================
SNOW_INSTANCE=yourcompany.service-now.com
SNOW_USERNAME=api_dashboard_user
SNOW_PASSWORD=your-snow-password
# OR use OAuth:
# SNOW_CLIENT_ID=your-snow-oauth-client-id
# SNOW_CLIENT_SECRET=your-snow-oauth-client-secret
```

---

# PART 2: CONFIGURATION MODULE

## `config.py`

```python
"""
config.py — Loads credentials from .env file
WHY: Never hardcode API keys or passwords in scripts.
     .env file stays on the server, never in git.
"""

import os
from dotenv import load_dotenv

load_dotenv()  # Reads .env file and sets environment variables

class Config:
    # ── Wiz API ──────────────────────────────────────────────
    WIZ_CLIENT_ID     = os.getenv("WIZ_CLIENT_ID")
    WIZ_CLIENT_SECRET = os.getenv("WIZ_CLIENT_SECRET")
    WIZ_API_URL       = os.getenv("WIZ_API_URL")
    WIZ_AUTH_URL      = os.getenv("WIZ_AUTH_URL")
    WIZ_AUDIENCE      = os.getenv("WIZ_AUDIENCE", "wiz-api")

    # ── SQL Server (Data Warehouse) ──────────────────────────
    SQL_SERVER    = os.getenv("SQL_SERVER")
    SQL_DATABASE  = os.getenv("SQL_DATABASE")
    SQL_USERNAME  = os.getenv("SQL_USERNAME")
    SQL_PASSWORD  = os.getenv("SQL_PASSWORD")
    SQL_DRIVER    = os.getenv("SQL_DRIVER", "ODBC Driver 17 for SQL Server")

    # ── CMDB SQL Server ──────────────────────────────────────
    CMDB_SQL_SERVER   = os.getenv("CMDB_SQL_SERVER")
    CMDB_SQL_DATABASE = os.getenv("CMDB_SQL_DATABASE")
    CMDB_SQL_USERNAME = os.getenv("CMDB_SQL_USERNAME")
    CMDB_SQL_PASSWORD = os.getenv("CMDB_SQL_PASSWORD")

    # ── ServiceNow ───────────────────────────────────────────
    SNOW_INSTANCE = os.getenv("SNOW_INSTANCE")
    SNOW_USERNAME = os.getenv("SNOW_USERNAME")
    SNOW_PASSWORD = os.getenv("SNOW_PASSWORD")

    @classmethod
    def get_warehouse_connection_string(cls):
        """SQLAlchemy connection string for the data warehouse."""
        return (
            f"mssql+pyodbc://{cls.SQL_USERNAME}:{cls.SQL_PASSWORD}"
            f"@{cls.SQL_SERVER}/{cls.SQL_DATABASE}"
            f"?driver={cls.SQL_DRIVER.replace(' ', '+')}"
        )

    @classmethod
    def get_cmdb_connection_string(cls):
        """SQLAlchemy connection string for the CMDB database."""
        return (
            f"mssql+pyodbc://{cls.CMDB_SQL_USERNAME}:{cls.CMDB_SQL_PASSWORD}"
            f"@{cls.CMDB_SQL_SERVER}/{cls.CMDB_SQL_DATABASE}"
            f"?driver={cls.SQL_DRIVER.replace(' ', '+')}"
        )
```

---

# PART 3: DATABASE SETUP

## `db_setup.py`

```python
"""
db_setup.py — Creates the data warehouse tables.
Run ONCE to initialize the database schema.
"""

from sqlalchemy import create_engine, text
from config import Config

def create_tables():
    engine = create_engine(Config.get_warehouse_connection_string())

    with engine.connect() as conn:
        # ── Create schema ────────────────────────────────────
        conn.execute(text("""
            IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'dashboard')
                EXEC('CREATE SCHEMA dashboard')
        """))

        # ── Table 1: Wiz Findings ────────────────────────────
        conn.execute(text("""
            IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES
                           WHERE TABLE_SCHEMA = 'dashboard'
                           AND TABLE_NAME = 'wiz_findings')
            CREATE TABLE dashboard.wiz_findings (
                finding_id          NVARCHAR(50) PRIMARY KEY,
                title               NVARCHAR(500),
                severity            NVARCHAR(20),      -- CRITICAL, HIGH, MEDIUM, LOW
                status              NVARCHAR(20),      -- Open, Closed, Resolved
                category            NVARCHAR(100),     -- Network, IAM, Storage, etc.
                cloud_provider      NVARCHAR(20),      -- Azure, GCP, AWS
                cloud_account       NVARCHAR(100),
                resource_id         NVARCHAR(500),
                resource_type       NVARCHAR(100),
                resource_name       NVARCHAR(200),
                region              NVARCHAR(50),
                internet_facing     NVARCHAR(5),       -- Yes / No
                data_classification NVARCHAR(50),      -- Confidential, Restricted, etc.
                compliance_framework NVARCHAR(100),    -- CIS Azure 3.7, etc.
                cis_control         NVARCHAR(20),
                created_date        DATE,
                closed_date         DATE NULL,
                sla_hours           INT,
                assignee            NVARCHAR(100) NULL,
                assignment_group    NVARCHAR(100) NULL,
                last_refreshed      DATETIME DEFAULT GETDATE()
            )
        """))

        # ── Table 2: CMDB Assets ─────────────────────────────
        conn.execute(text("""
            IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES
                           WHERE TABLE_SCHEMA = 'dashboard'
                           AND TABLE_NAME = 'cmdb_assets')
            CREATE TABLE dashboard.cmdb_assets (
                ci_id               NVARCHAR(50) PRIMARY KEY,
                cloud_resource_id   NVARCHAR(500),     -- JOIN key to wiz_findings.resource_id
                ci_name             NVARCHAR(200),
                owner               NVARCHAR(100),
                owner_email         NVARCHAR(200),
                assignment_group    NVARCHAR(100),
                environment         NVARCHAR(20),      -- Production, Development, Corporate
                application         NVARCHAR(200),
                support_group       NVARCHAR(100),
                operational_status  NVARCHAR(20),
                cloud_provider      NVARCHAR(20),
                cloud_account       NVARCHAR(100),
                region              NVARCHAR(50),
                business_unit       NVARCHAR(100),
                data_classification NVARCHAR(50),
                manager             NVARCHAR(100),
                last_refreshed      DATETIME DEFAULT GETDATE()
            )
        """))

        # ── Table 3: ServiceNow Tickets ──────────────────────
        conn.execute(text("""
            IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES
                           WHERE TABLE_SCHEMA = 'dashboard'
                           AND TABLE_NAME = 'servicenow_tickets')
            CREATE TABLE dashboard.servicenow_tickets (
                ticket_id           NVARCHAR(50) PRIMARY KEY,
                finding_id          NVARCHAR(50),      -- JOIN key to wiz_findings
                short_description   NVARCHAR(500),
                priority            NVARCHAR(5),       -- P1, P2, P3, P4
                status              NVARCHAR(20),      -- Open, Closed, In Progress
                assignment_group    NVARCHAR(100),
                assigned_to         NVARCHAR(100),
                created_date        DATE,
                resolved_date       DATE NULL,
                sla_target_date     DATE NULL,
                sla_status          NVARCHAR(20),      -- Met, Breached, On Track, At Risk
                resolution_notes    NVARCHAR(MAX) NULL,
                change_request_id   NVARCHAR(50) NULL,
                last_refreshed      DATETIME DEFAULT GETDATE()
            )
        """))

        # ── Table 4: Refresh Log (audit trail) ───────────────
        conn.execute(text("""
            IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES
                           WHERE TABLE_SCHEMA = 'dashboard'
                           AND TABLE_NAME = 'refresh_log')
            CREATE TABLE dashboard.refresh_log (
                id              INT IDENTITY(1,1) PRIMARY KEY,
                source          NVARCHAR(50),      -- 'wiz', 'cmdb', 'servicenow'
                status          NVARCHAR(20),      -- 'success', 'failed'
                rows_processed  INT,
                start_time      DATETIME,
                end_time        DATETIME,
                error_message   NVARCHAR(MAX) NULL
            )
        """))

        conn.commit()
        print("✅ All tables created successfully.")

if __name__ == "__main__":
    create_tables()
```

---

# PART 4: PYTHON EXTRACTORS

## 4.1 `extract_wiz.py` — Wiz GraphQL API

```python
"""
extract_wiz.py — Pulls findings from Wiz via GraphQL API

HOW WIZ API WORKS:
1. Authenticate with client_id + client_secret → get OAuth token
2. Send GraphQL query to fetch Issues (findings)
3. Wiz paginates results — loop until all pages retrieved
4. Transform JSON → DataFrame → SQL Server

AUTHENTICATION:
  Wiz uses service accounts (not user accounts).
  Create one at: Wiz Console → Settings → Service Accounts
  Grant it "read:issues" scope (minimum privilege).
"""

import requests
import pandas as pd
from datetime import datetime
from sqlalchemy import create_engine
from config import Config
import logging

logger = logging.getLogger(__name__)


def get_wiz_token():
    """
    Step 1: Get OAuth2 access token from Wiz.

    WHY OAuth: Wiz doesn't use API keys. It uses OAuth2 client_credentials flow.
    The token expires after 24 hours — we get a fresh one each pipeline run.
    """
    response = requests.post(
        Config.WIZ_AUTH_URL,
        headers={"Content-Type": "application/x-www-form-urlencoded"},
        data={
            "grant_type": "client_credentials",
            "client_id": Config.WIZ_CLIENT_ID,
            "client_secret": Config.WIZ_CLIENT_SECRET,
            "audience": Config.WIZ_AUDIENCE,
        },
    )
    response.raise_for_status()
    token = response.json()["access_token"]
    logger.info("✅ Wiz authentication successful")
    return token


def fetch_wiz_findings(token):
    """
    Step 2: Query Wiz GraphQL API for all open and recently closed findings.

    WHY GraphQL: Wiz uses GraphQL (not REST). You send a query string
    that specifies exactly which fields you want. This is more efficient
    than REST because you only get the fields you need.

    PAGINATION: Wiz returns max 500 results per page. We use cursor-based
    pagination (after: $endCursor) to get all pages.
    """

    # The GraphQL query — asks for specific fields we need for the dashboard
    query = """
    query GetIssues($first: Int, $after: String, $filterBy: IssueFilters) {
        issues(first: $first, after: $after, filterBy: $filterBy) {
            nodes {
                id
                sourceRule {
                    name
                }
                severity
                status
                type
                entitySnapshot {
                    cloudProvider
                    subscriptionExternalId
                    nativeType
                    name
                    region
                    externalId
                    tags
                }
                projects {
                    name
                }
                notes {
                    text
                }
                createdAt
                resolvedAt
                dueAt
                control {
                    name
                    controlId
                    securityFrameworks {
                        name
                        category {
                            name
                        }
                    }
                }
            }
            pageInfo {
                hasNextPage
                endCursor
            }
            totalCount
        }
    }
    """

    all_findings = []
    has_next_page = True
    cursor = None
    page = 1

    while has_next_page:
        variables = {
            "first": 500,               # Max 500 per page
            "after": cursor,
            "filterBy": {
                "status": ["OPEN", "RESOLVED", "REJECTED"],
                # Fetch all statuses so we can track closure trends
                # Filter to last 180 days to keep dataset manageable
            },
        }

        response = requests.post(
            Config.WIZ_API_URL,
            headers={
                "Authorization": f"Bearer {token}",
                "Content-Type": "application/json",
            },
            json={"query": query, "variables": variables},
        )
        response.raise_for_status()
        data = response.json()["data"]["issues"]

        all_findings.extend(data["nodes"])
        has_next_page = data["pageInfo"]["hasNextPage"]
        cursor = data["pageInfo"]["endCursor"]

        logger.info(f"  Page {page}: fetched {len(data['nodes'])} issues "
                     f"(total so far: {len(all_findings)}/{data['totalCount']})")
        page += 1

    logger.info(f"✅ Fetched {len(all_findings)} total Wiz findings")
    return all_findings


def transform_wiz_findings(raw_findings):
    """
    Step 3: Transform Wiz JSON into a flat DataFrame matching our SQL schema.

    WHY TRANSFORM: Wiz returns nested JSON (entity → cloudProvider, control →
    frameworks → category). We flatten it into simple columns for SQL/Power BI.
    """
    records = []
    for f in raw_findings:
        entity = f.get("entitySnapshot", {}) or {}
        control = f.get("control", {}) or {}

        # Extract compliance framework from nested structure
        frameworks = control.get("securityFrameworks", []) or []
        compliance_fw = frameworks[0]["name"] if frameworks else ""
        cis_category = ""
        if frameworks and frameworks[0].get("category"):
            cis_category = frameworks[0]["category"]["name"]

        # Determine data classification from tags
        tags = entity.get("tags", {}) or {}
        data_class = tags.get("data-classification", "Internal")

        # Determine internet-facing (Wiz has this as a graph property)
        # Simplified: check if type contains "public" or tags indicate it
        internet_facing = "No"  # Default; Wiz Attack Path analysis
                                # provides this via separate graph query

        # Map Wiz severity to SLA hours (your org's SLA policy)
        severity = f.get("severity", "MEDIUM")
        sla_map = {"CRITICAL": 24, "HIGH": 168, "MEDIUM": 720, "LOW": 2160}
        sla_hours = sla_map.get(severity, 720)

        records.append({
            "finding_id": f["id"],
            "title": (f.get("sourceRule", {}) or {}).get("name", "Unknown"),
            "severity": severity,
            "status": "Open" if f["status"] == "OPEN" else "Closed",
            "category": f.get("type", "Unknown"),
            "cloud_provider": entity.get("cloudProvider", "Unknown"),
            "cloud_account": entity.get("subscriptionExternalId", ""),
            "resource_id": entity.get("externalId", ""),
            "resource_type": entity.get("nativeType", ""),
            "resource_name": entity.get("name", ""),
            "region": entity.get("region", "global"),
            "internet_facing": internet_facing,
            "data_classification": data_class,
            "compliance_framework": compliance_fw,
            "cis_control": control.get("controlId", ""),
            "created_date": f.get("createdAt", "")[:10],  # YYYY-MM-DD
            "closed_date": (f.get("resolvedAt") or "")[:10] or None,
            "sla_hours": sla_hours,
            "assignee": None,        # Populated from CMDB join
            "assignment_group": None, # Populated from CMDB join
        })

    df = pd.DataFrame(records)
    logger.info(f"✅ Transformed {len(df)} findings into DataFrame")
    return df


def load_wiz_findings(df):
    """
    Step 4: Load transformed data into SQL Server.

    WHY TRUNCATE+INSERT (not UPSERT): For dashboard data, a full refresh
    is simpler and ensures no stale records. Wiz findings change status
    frequently — full refresh catches all changes.
    """
    engine = create_engine(Config.get_warehouse_connection_string())

    with engine.connect() as conn:
        # Truncate existing data (full refresh pattern)
        conn.execute("TRUNCATE TABLE dashboard.wiz_findings")
        conn.commit()

    # Bulk insert using pandas
    df.to_sql(
        name="wiz_findings",
        schema="dashboard",
        con=engine,
        if_exists="append",    # Table already exists (truncated above)
        index=False,
        method="multi",        # Batch insert for performance
        chunksize=500,
    )
    logger.info(f"✅ Loaded {len(df)} findings into SQL Server")
    return len(df)


def run():
    """Main entry point — called by orchestrator."""
    start = datetime.now()
    try:
        token = get_wiz_token()
        raw = fetch_wiz_findings(token)
        df = transform_wiz_findings(raw)
        rows = load_wiz_findings(df)
        return {"status": "success", "rows": rows,
                "start": start, "end": datetime.now()}
    except Exception as e:
        logger.error(f"❌ Wiz extraction failed: {e}")
        return {"status": "failed", "rows": 0,
                "start": start, "end": datetime.now(), "error": str(e)}


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    result = run()
    print(result)
```

---

## 4.2 `extract_cmdb.py` — SQL Server CMDB

```python
"""
extract_cmdb.py — Pulls asset inventory from CMDB SQL database

HOW THIS WORKS:
  CMDB data lives in a SQL Server database (typically ServiceNow's
  underlying DB, or a replicated CMDB warehouse). We query it directly
  with a SQL SELECT and copy the results into our dashboard warehouse.

WHY SEPARATE DB: The CMDB is a production system — we NEVER run
  Power BI directly against it (performance impact). Instead, we copy
  the relevant subset into our dashboard warehouse.

INTERVIEW EXPLANATION:
  "I don't connect Power BI directly to the CMDB because it's a production
   system with thousands of concurrent users. Instead, I run a nightly
   Python ETL that copies the relevant asset records into a dedicated
   dashboard warehouse. This isolates the dashboard from CMDB performance
   and lets me add dashboard-specific indexes."
"""

import pandas as pd
from datetime import datetime
from sqlalchemy import create_engine
from config import Config
import logging

logger = logging.getLogger(__name__)


def extract_from_cmdb():
    """
    Step 1: Query CMDB for cloud asset records.

    WHY THIS QUERY: We only pull assets that are:
    - Cloud resources (Azure or GCP)
    - Active status
    - Owned by our organization

    We don't pull ALL CMDB records — just the subset relevant to
    cloud security findings.
    """
    engine = create_engine(Config.get_cmdb_connection_string())

    query = """
    SELECT
        ci.ci_id,
        ci.cloud_resource_id,   -- This is the JOIN key to Wiz findings
        ci.ci_name,
        ci.owner,
        ci.owner_email,
        ci.assignment_group,
        ci.environment,
        ci.application,
        ci.support_group,
        ci.operational_status,
        ci.cloud_provider,
        ci.cloud_account,
        ci.region,
        ci.business_unit,
        ci.data_classification,
        ci.manager
    FROM dbo.cmdb_ci_cloud_resources ci
    WHERE ci.operational_status = 'Active'
      AND ci.cloud_provider IN ('Azure', 'GCP', 'AWS')
    ORDER BY ci.cloud_provider, ci.business_unit
    """

    # Alternative: If your CMDB uses ServiceNow table structure:
    # query = """
    #     SELECT
    #         sys_id as ci_id,
    #         u_cloud_resource_id as cloud_resource_id,
    #         name as ci_name,
    #         owned_by.name as owner,
    #         owned_by.email as owner_email,
    #         assignment_group.name as assignment_group,
    #         u_environment as environment,
    #         u_application as application,
    #         support_group.name as support_group,
    #         operational_status as operational_status,
    #         u_cloud_provider as cloud_provider,
    #         u_cloud_account as cloud_account,
    #         u_region as region,
    #         u_business_unit as business_unit,
    #         u_data_classification as data_classification,
    #         managed_by.name as manager
    #     FROM cmdb_ci_cloud_service
    #     WHERE operational_status = 1  -- Active
    # """

    df = pd.read_sql(query, engine)
    logger.info(f"✅ Extracted {len(df)} assets from CMDB")
    return df


def load_cmdb_assets(df):
    """
    Step 2: Full-refresh load into dashboard warehouse.
    """
    engine = create_engine(Config.get_warehouse_connection_string())

    with engine.connect() as conn:
        conn.execute("TRUNCATE TABLE dashboard.cmdb_assets")
        conn.commit()

    df.to_sql(
        name="cmdb_assets",
        schema="dashboard",
        con=engine,
        if_exists="append",
        index=False,
        method="multi",
        chunksize=500,
    )
    logger.info(f"✅ Loaded {len(df)} assets into dashboard warehouse")
    return len(df)


def run():
    """Main entry point."""
    start = datetime.now()
    try:
        df = extract_from_cmdb()
        rows = load_cmdb_assets(df)
        return {"status": "success", "rows": rows,
                "start": start, "end": datetime.now()}
    except Exception as e:
        logger.error(f"❌ CMDB extraction failed: {e}")
        return {"status": "failed", "rows": 0,
                "start": start, "end": datetime.now(), "error": str(e)}


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    result = run()
    print(result)
```

---

## 4.3 `extract_snow.py` — ServiceNow REST API

```python
"""
extract_snow.py — Pulls security tickets from ServiceNow Table API

HOW SERVICENOW API WORKS:
  ServiceNow exposes every table via REST API at:
  https://<instance>.service-now.com/api/now/table/<table_name>

  We query the "incident" table (or a custom "u_security_findings" table)
  filtered by category = "Security".

AUTHENTICATION:
  - Basic Auth: username + password (simple but works)
  - OAuth2: client_id + client_secret (better for production)
  We support both in this script.

PAGINATION:
  ServiceNow returns max 10,000 per request. We use sysparm_offset
  to paginate through all records.

INTERVIEW EXPLANATION:
  "I pull security tickets from ServiceNow via the Table API. The query
   filters by assignment group matching our cloud security teams, and
   I include both open and recently closed tickets to track MTTR trends.
   The data refreshes daily at 6 AM, and Power BI picks it up within
   an hour via scheduled refresh."
"""

import requests
import pandas as pd
from datetime import datetime, timedelta
from sqlalchemy import create_engine
from config import Config
import logging

logger = logging.getLogger(__name__)


def fetch_snow_tickets():
    """
    Step 1: Query ServiceNow Table API for security tickets.

    QUERY PARAMETERS EXPLAINED:
    - sysparm_query: Filter expression (like SQL WHERE clause)
    - sysparm_fields: Which fields to return (like SQL SELECT)
    - sysparm_limit: Max records per page (10000 max)
    - sysparm_offset: For pagination
    - sysparm_display_value: true = show display names, not sys_ids
    """
    base_url = f"https://{Config.SNOW_INSTANCE}/api/now/table/incident"

    # ServiceNow query language (encoded):
    # - Get tickets from specific assignment groups (cloud security teams)
    # - Created in last 180 days (or all open regardless of date)
    # - Ordered by created_on descending

    # Our cloud security teams
    security_groups = [
        "Platform-Engineering",
        "Network-Operations",
        "AppDev-Team",
        "Data-Engineering",
        "Container-Platform",
        "Identity-Security",
    ]
    group_filter = "^OR".join([f"assignment_group.name={g}" for g in security_groups])

    # Date filter: tickets created in last 180 days OR still open
    six_months_ago = (datetime.now() - timedelta(days=180)).strftime("%Y-%m-%d")

    query = (
        f"({group_filter})"
        f"^sys_created_on>={six_months_ago}"
        f"^ORstateIN1,2,3"       # Include all open tickets regardless of date
        f"^short_descriptionLIKECRITICAL^ORshort_descriptionLIKEHIGH"
        f"^ORshort_descriptionLIKEMEDIUM^ORshort_descriptionLIKELOW"
    )

    # Alternative simpler query if you have a custom field linking to Wiz:
    # query = f"u_source_tool=Wiz^sys_created_on>={six_months_ago}"

    all_tickets = []
    offset = 0
    limit = 1000   # Fetch 1000 at a time

    while True:
        response = requests.get(
            base_url,
            auth=(Config.SNOW_USERNAME, Config.SNOW_PASSWORD),
            headers={"Accept": "application/json"},
            params={
                "sysparm_query": query,
                "sysparm_fields": (
                    "number,"          # ticket_id (e.g., INC0012345)
                    "u_finding_id,"    # custom field linking to Wiz finding ID
                    "short_description,"
                    "priority,"
                    "state,"
                    "assignment_group.name,"
                    "assigned_to.name,"
                    "sys_created_on,"
                    "resolved_at,"
                    "u_sla_target_date,"
                    "u_sla_status,"
                    "close_notes,"
                    "u_change_request"
                ),
                "sysparm_limit": limit,
                "sysparm_offset": offset,
                "sysparm_display_value": "true",
            },
        )
        response.raise_for_status()
        data = response.json()["result"]

        if not data:
            break   # No more records

        all_tickets.extend(data)
        logger.info(f"  Fetched {len(data)} tickets (offset {offset})")

        if len(data) < limit:
            break   # Last page

        offset += limit

    logger.info(f"✅ Fetched {len(all_tickets)} total ServiceNow tickets")
    return all_tickets


def transform_snow_tickets(raw_tickets):
    """
    Step 2: Transform ServiceNow JSON into flat DataFrame.

    WHY TRANSFORM: ServiceNow returns fields differently based on
    sysparm_display_value setting. We normalize everything to
    consistent column names matching our SQL schema.
    """
    records = []

    # ServiceNow state codes → readable status
    state_map = {
        "1": "Open", "New": "Open",
        "2": "In Progress", "In Progress": "In Progress",
        "3": "On Hold", "On Hold": "On Hold",
        "6": "Resolved", "Resolved": "Closed",
        "7": "Closed", "Closed": "Closed",
    }

    # ServiceNow priority codes → P1/P2/P3/P4
    priority_map = {
        "1": "P1", "1 - Critical": "P1",
        "2": "P2", "2 - High": "P2",
        "3": "P3", "3 - Moderate": "P3",
        "4": "P4", "4 - Low": "P4",
    }

    for t in raw_tickets:
        status = state_map.get(str(t.get("state", "")), t.get("state", "Open"))
        priority = priority_map.get(str(t.get("priority", "")), t.get("priority", "P3"))

        # Calculate SLA status if not provided by ServiceNow
        sla_status = t.get("u_sla_status", "")
        if not sla_status and t.get("u_sla_target_date"):
            target = pd.to_datetime(t["u_sla_target_date"])
            if status in ("Closed", "Resolved"):
                resolved = pd.to_datetime(t.get("resolved_at", ""))
                sla_status = "Met" if resolved <= target else "Missed"
            else:
                now = pd.Timestamp.now()
                remaining_pct = (target - now) / (target - pd.to_datetime(t["sys_created_on"]))
                if now > target:
                    sla_status = "Breached"
                elif remaining_pct < 0.25:
                    sla_status = "At Risk"
                else:
                    sla_status = "On Track"

        records.append({
            "ticket_id": t.get("number", ""),
            "finding_id": t.get("u_finding_id", ""),
            "short_description": t.get("short_description", ""),
            "priority": priority,
            "status": status,
            "assignment_group": t.get("assignment_group.name",
                                      t.get("assignment_group", {}).get("display_value", "")),
            "assigned_to": t.get("assigned_to.name",
                                  t.get("assigned_to", {}).get("display_value", "")),
            "created_date": (t.get("sys_created_on", "") or "")[:10] or None,
            "resolved_date": (t.get("resolved_at", "") or "")[:10] or None,
            "sla_target_date": (t.get("u_sla_target_date", "") or "")[:10] or None,
            "sla_status": sla_status,
            "resolution_notes": t.get("close_notes", ""),
            "change_request_id": t.get("u_change_request", ""),
        })

    df = pd.DataFrame(records)
    logger.info(f"✅ Transformed {len(df)} tickets into DataFrame")
    return df


def load_snow_tickets(df):
    """Step 3: Full-refresh load into dashboard warehouse."""
    engine = create_engine(Config.get_warehouse_connection_string())

    with engine.connect() as conn:
        conn.execute("TRUNCATE TABLE dashboard.servicenow_tickets")
        conn.commit()

    df.to_sql(
        name="servicenow_tickets",
        schema="dashboard",
        con=engine,
        if_exists="append",
        index=False,
        method="multi",
        chunksize=500,
    )
    logger.info(f"✅ Loaded {len(df)} tickets into dashboard warehouse")
    return len(df)


def run():
    """Main entry point."""
    start = datetime.now()
    try:
        raw = fetch_snow_tickets()
        df = transform_snow_tickets(raw)
        rows = load_snow_tickets(df)
        return {"status": "success", "rows": rows,
                "start": start, "end": datetime.now()}
    except Exception as e:
        logger.error(f"❌ ServiceNow extraction failed: {e}")
        return {"status": "failed", "rows": 0,
                "start": start, "end": datetime.now(), "error": str(e)}


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    result = run()
    print(result)
```

---

# PART 5: PIPELINE ORCHESTRATOR

## `run_pipeline.py`

```python
"""
run_pipeline.py — Daily pipeline orchestrator.
Runs all 3 extractors, logs results, sends alert on failure.

USAGE:
  python run_pipeline.py            # Run full pipeline
  python run_pipeline.py --wiz      # Run Wiz only
  python run_pipeline.py --snow     # Run ServiceNow only
  python run_pipeline.py --cmdb     # Run CMDB only

SCHEDULING:
  Windows Task Scheduler: runs this script at 6:00 AM daily
  Linux: crontab -e → 0 6 * * * cd /opt/SecurityDashboard && python run_pipeline.py
"""

import sys
import logging
from datetime import datetime
from sqlalchemy import create_engine, text
from config import Config

import extract_wiz
import extract_cmdb
import extract_snow

# ── Logging Setup ────────────────────────────────────────────
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(name)s: %(message)s",
    handlers=[
        logging.FileHandler("logs/pipeline.log"),
        logging.StreamHandler(sys.stdout),
    ],
)
logger = logging.getLogger("pipeline")


def log_to_db(source, result):
    """Write pipeline execution results to the refresh_log table."""
    engine = create_engine(Config.get_warehouse_connection_string())
    with engine.connect() as conn:
        conn.execute(text("""
            INSERT INTO dashboard.refresh_log
                (source, status, rows_processed, start_time, end_time, error_message)
            VALUES
                (:source, :status, :rows, :start, :end, :error)
        """), {
            "source": source,
            "status": result["status"],
            "rows": result.get("rows", 0),
            "start": result["start"],
            "end": result["end"],
            "error": result.get("error"),
        })
        conn.commit()


def send_alert(source, error):
    """
    Send failure alert via email or Teams webhook.

    In production, use one of these:
    - Microsoft Teams webhook (HTTP POST with JSON)
    - SMTP email via smtplib
    - PagerDuty / Opsgenie API
    """
    logger.critical(f"🚨 PIPELINE FAILURE: {source} — {error}")

    # Example: Teams webhook notification
    # import requests
    # webhook_url = "https://outlook.office.com/webhook/xxx/IncomingWebhook/yyy"
    # payload = {
    #     "title": f"🚨 Security Dashboard Pipeline Failed: {source}",
    #     "text": f"Error: {error}\nTime: {datetime.now()}\nAction: Check logs at C:\\SecurityDashboard\\logs\\pipeline.log",
    #     "themeColor": "FF0000",
    # }
    # requests.post(webhook_url, json=payload)


def run_full_pipeline():
    """Execute all 3 extractors in sequence."""
    pipeline_start = datetime.now()
    logger.info("=" * 60)
    logger.info(f"🚀 PIPELINE STARTED at {pipeline_start}")
    logger.info("=" * 60)

    results = {}

    # ── Step 1: Extract Wiz Findings ───────────────────────
    logger.info("\n📡 [1/3] Extracting Wiz findings...")
    result = extract_wiz.run()
    results["wiz"] = result
    log_to_db("wiz", result)
    if result["status"] == "failed":
        send_alert("Wiz", result.get("error", "Unknown"))

    # ── Step 2: Extract CMDB Assets ────────────────────────
    logger.info("\n🗄️ [2/3] Extracting CMDB assets...")
    result = extract_cmdb.run()
    results["cmdb"] = result
    log_to_db("cmdb", result)
    if result["status"] == "failed":
        send_alert("CMDB", result.get("error", "Unknown"))

    # ── Step 3: Extract ServiceNow Tickets ─────────────────
    logger.info("\n🎫 [3/3] Extracting ServiceNow tickets...")
    result = extract_snow.run()
    results["snow"] = result
    log_to_db("servicenow", result)
    if result["status"] == "failed":
        send_alert("ServiceNow", result.get("error", "Unknown"))

    # ── Summary ────────────────────────────────────────────
    pipeline_end = datetime.now()
    duration = (pipeline_end - pipeline_start).total_seconds()

    logger.info("\n" + "=" * 60)
    logger.info(f"📊 PIPELINE COMPLETED in {duration:.0f} seconds")
    for source, r in results.items():
        status_icon = "✅" if r["status"] == "success" else "❌"
        logger.info(f"   {status_icon} {source}: {r['status']} ({r.get('rows', 0)} rows)")
    logger.info("=" * 60)

    return results


if __name__ == "__main__":
    args = sys.argv[1:]

    if "--wiz" in args:
        result = extract_wiz.run()
        log_to_db("wiz", result)
    elif "--cmdb" in args:
        result = extract_cmdb.run()
        log_to_db("cmdb", result)
    elif "--snow" in args:
        result = extract_snow.run()
        log_to_db("servicenow", result)
    else:
        run_full_pipeline()
```

---

# PART 6: SCHEDULING — Automate Daily Runs

## Option A: Windows Task Scheduler

```
Step 1: Open Task Scheduler → Create Task

Step 2: General Tab
   Name: SecurityDashboard_DailyRefresh
   Description: Daily extraction from Wiz, CMDB, ServiceNow
   Run whether user is logged on or not: YES
   Run with highest privileges: YES

Step 3: Triggers Tab
   New → Daily
   Start: 6:00 AM
   Recur every: 1 day
   Enabled: YES

Step 4: Actions Tab
   New → Start a Program
   Program: C:\SecurityDashboard\venv\Scripts\python.exe
   Arguments: run_pipeline.py
   Start in: C:\SecurityDashboard

Step 5: Conditions Tab
   Wake the computer to run this task: YES
   Start only if network is available: YES

Step 6: OK → Enter service account password
```

## Option B: Azure Function (Serverless)

```python
# function_app.py — Azure Function Timer Trigger
# Runs as serverless function — no VM needed

import azure.functions as func
import datetime
import logging

app = func.FunctionApp()

@app.timer_trigger(schedule="0 0 6 * * *",   # 6:00 AM UTC daily
                   arg_name="timer",
                   run_on_startup=False)
def daily_security_refresh(timer: func.TimerRequest):
    """Azure Function that runs the pipeline daily."""
    logging.info(f"Pipeline triggered at {datetime.datetime.now()}")

    # Import and run the pipeline
    from run_pipeline import run_full_pipeline
    results = run_full_pipeline()

    logging.info(f"Pipeline completed: {results}")
```

## Option C: Linux Cron

```bash
# crontab -e
# Run at 6:00 AM UTC every day
0 6 * * * cd /opt/SecurityDashboard && /opt/SecurityDashboard/venv/bin/python run_pipeline.py >> /opt/SecurityDashboard/logs/cron.log 2>&1
```

---

# PART 7: POWER BI CONNECTION — SQL Server

## Step 1: Connect Power BI to the Data Warehouse

```
1. Power BI Desktop → Home → Get Data → SQL Server

2. Server: your-sql-server.database.windows.net
   Database: security_dashboard
   Data Connectivity Mode: Import
   ↑ WHY Import (not DirectQuery):
     - Faster dashboard performance (data cached locally)
     - No live query load on SQL Server during presentations
     - Scheduled refresh updates the cache daily

3. Advanced Options:
   SQL Statement (paste this for the Findings table):

   SELECT
       f.*,
       a.ci_name,
       a.owner,
       a.owner_email,
       a.assignment_group AS asset_assignment_group,
       a.environment,
       a.application,
       a.business_unit,
       a.data_classification AS asset_data_classification,
       a.manager,
       t.ticket_id,
       t.priority AS ticket_priority,
       t.status AS ticket_status,
       t.sla_status,
       t.sla_target_date,
       t.resolved_date,
       t.resolution_notes,
       t.change_request_id,
       DATEDIFF(day, f.created_date, ISNULL(f.closed_date, GETDATE())) AS days_open,
       CASE
           WHEN f.severity = 'CRITICAL' THEN 10
           WHEN f.severity = 'HIGH' THEN 5
           WHEN f.severity = 'MEDIUM' THEN 2
           ELSE 1
       END AS risk_score
   FROM dashboard.wiz_findings f
   LEFT JOIN dashboard.cmdb_assets a
       ON f.resource_id = a.cloud_resource_id
   LEFT JOIN dashboard.servicenow_tickets t
       ON f.finding_id = t.finding_id

4. Click OK → Load
   This gives you ONE enriched table with all 3 data sources joined.
```

## Step 2: Set Up Scheduled Refresh (Power BI Service)

```
1. Publish your .pbix file to Power BI Service:
   Home → Publish → Select your workspace

2. In Power BI Service (app.powerbi.com):
   a. Go to Settings → Datasets → your dataset
   b. Gateway Connection:
      - If data is in Azure SQL: No gateway needed ✅
      - If data is on-prem SQL: Install Power BI Gateway

3. Scheduled Refresh:
   a. Turn ON scheduled refresh
   b. Refresh frequency: Daily
   c. Time zone: Your local time zone
   d. Time: 7:00 AM (1 hour after Python pipeline finishes)
      WHY 7 AM: Python pipeline runs at 6 AM, takes ~10 minutes.
      Power BI refreshes at 7 AM = always fresh data.

   e. Failure notifications: ENABLED → send to your email
      WHY: If refresh fails, you want to know before the CEO opens the dashboard

4. Row-Level Security (RLS) — OPTIONAL:
   If different leaders should see different data:
   a. Modeling → Manage Roles
   b. Create role "Capital Markets" with filter:
      [business_unit] = "Capital Markets"
   c. Assign users to roles in Power BI Service:
      Workspace → Security → Add members to roles
```

## Step 3: Monthly Report Distribution

```
1. Power BI Service → Your Dashboard
2. Subscribe:
   - Click "Subscribe to report"
   - Add CEO, CISO email addresses
   - Frequency: Monthly (1st of each month, 9:00 AM)
   - Include: Screenshot + link to live dashboard
   - Subject: "Monthly Security Posture Report — [Month Year]"

3. Export for Board Meetings:
   - File → Export → PowerPoint (best for board presentations)
   - File → Export → PDF (for email attachments)

4. Teams Integration:
   - Pin the Power BI dashboard tab in your Security team's channel
   - Anyone in the channel sees the live dashboard
```

---

# PART 8: COMPLETE WORKFLOW DIAGRAM

```
┌──────────────────────────────────────────────────────────────────────────┐
│                     DAILY AUTOMATED WORKFLOW                              │
│                                                                          │
│  6:00 AM ─── Python Pipeline Starts ──────────────────────────────────  │
│              │                                                           │
│              ├── extract_wiz.py                                          │
│              │   1. OAuth token from Wiz auth endpoint                   │
│              │   2. GraphQL query (paginated, 500/page)                  │
│              │   3. Transform nested JSON → flat DataFrame               │
│              │   4. TRUNCATE + INSERT into dashboard.wiz_findings        │
│              │                                                           │
│              ├── extract_cmdb.py                                         │
│              │   1. SQL query to CMDB database (read-only)               │
│              │   2. Copy relevant cloud assets only                      │
│              │   3. TRUNCATE + INSERT into dashboard.cmdb_assets         │
│              │                                                           │
│              ├── extract_snow.py                                         │
│              │   1. REST API GET to ServiceNow Table API                 │
│              │   2. Paginate (sysparm_offset, 1000/page)                 │
│              │   3. Map state codes to readable statuses                 │
│              │   4. TRUNCATE + INSERT into dashboard.servicenow_tickets  │
│              │                                                           │
│              └── Log results to dashboard.refresh_log                    │
│                  Alert on failure via Teams webhook / email              │
│                                                                          │
│  6:10 AM ─── Pipeline Complete ───────────────────────────────────────  │
│                                                                          │
│  7:00 AM ─── Power BI Scheduled Refresh ──────────────────────────────  │
│              │                                                           │
│              ├── Connects to SQL Server (Azure SQL / Gateway)            │
│              ├── Runs the enriched JOIN query (Part 7, Step 1)           │
│              ├── Refreshes all 20 DAX measures                           │
│              └── Dashboard is live with today's data ✅                  │
│                                                                          │
│  7:05 AM ─── CISO opens dashboard = today's data ─────────────────────  │
│                                                                          │
│  Monthly ─── Auto-email to CEO + CISO with PDF snapshot ──────────────  │
│                                                                          │
└──────────────────────────────────────────────────────────────────────────┘
```

---

# PART 9: INTERVIEW TALKING POINTS

### Q: "How do you automate security reporting?"

> "I built a Python ETL pipeline that runs daily at 6 AM. It pulls findings from Wiz via GraphQL API, enriches them with asset ownership from the CMDB SQL database, and links to remediation tickets from ServiceNow's Table API. Everything lands in a central SQL Server warehouse. Power BI connects to this warehouse with scheduled refresh at 7 AM, so the dashboard is always showing today's data when the CISO opens it. I also set up monthly email subscriptions to send the CEO a PDF snapshot on the 1st of each month."

### Q: "Why not connect Power BI directly to Wiz/ServiceNow APIs?"

> "Three reasons. **First**, Power BI's web connector has limited support for GraphQL and OAuth2 — Wiz uses both. Python handles this cleanly. **Second**, performance — a Power BI refresh that makes 200 API calls takes 15 minutes; pre-loading into SQL takes 2 minutes. **Third**, reliability — if the Wiz API is slow or ServiceNow has maintenance, the Python pipeline retries and logs the failure. Power BI would just show a blank dashboard with an error message. The SQL warehouse acts as a buffer between fragile APIs and executive-facing dashboards."

### Q: "How do you handle API failures?"

> "The pipeline has three safety nets. **First**, each extractor is independent — if ServiceNow fails, Wiz and CMDB data still refresh. **Second**, failures are logged to a `refresh_log` table, so I can see exactly when and why something failed. **Third**, an alert fires via Teams webhook to the security operations channel. We don't use TRUNCATE-then-fail — if the extract fails, the previous day's data stays in the table until the next successful run."

### Q: "Walk me through the data flow for a single finding."

> "A misconfiguration is detected by Wiz — say, an S3 bucket with public access. Wiz creates an Issue with severity CRITICAL. My pipeline picks it up at 6 AM via GraphQL, writes it to `dashboard.wiz_findings`. The JOIN enriches it with the CMDB owner (Rajesh Kumar, Platform Engineering team). Meanwhile, our Wiz-to-ServiceNow integration auto-creates a P1 ticket in ServiceNow, which my pipeline pulls into `servicenow_tickets`. Power BI shows all three dimensions — the finding severity, the asset owner, and the ticket SLA status — in one unified view. The CISO can click on Rajesh's name and see every finding assigned to him with SLA status."

---

# PART 10: SECURITY CONSIDERATIONS

```
┌──────────────────────────────────────────────────────────────────────┐
│  🔒 SECURITY CHECKLIST FOR THE PIPELINE                              │
│                                                                      │
│  ✅ API credentials stored in .env file (never in code)              │
│  ✅ .env file added to .gitignore                                    │
│  ✅ Service accounts have READ-ONLY access (no write to source)      │
│  ✅ SQL warehouse user has INSERT/TRUNCATE on dashboard schema only   │
│  ✅ CMDB query is SELECT-only (no INSERT/UPDATE/DELETE)               │
│  ✅ Wiz service account scope: "read:issues" only                    │
│  ✅ ServiceNow API user has "itil_reader" role only                   │
│  ✅ Pipeline logs do NOT contain credentials                          │
│  ✅ Power BI RLS restricts who sees what data                         │
│  ✅ Scheduled refresh uses encrypted credentials in PBI Service       │
│                                                                      │
│  ❌ NEVER DO:                                                        │
│  ❌ Hardcode passwords in Python scripts                              │
│  ❌ Give pipeline user admin access to CMDB                           │
│  ❌ Connect Power BI directly to production CMDB                      │
│  ❌ Store .env in git repository                                      │
│  ❌ Use personal accounts for scheduled tasks                         │
└──────────────────────────────────────────────────────────────────────┘
```$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

COMMIT;
