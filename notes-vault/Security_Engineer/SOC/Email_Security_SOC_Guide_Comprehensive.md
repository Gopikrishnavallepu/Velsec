---
title: "Email Security Soc Guide Comprehensive"
category: "Security Engineer"
tags: ["SOC"]
lastUpdated: "2026-06-05"
---

# 📧 Comprehensive Email Security Guide — SOC Analyst L2 Investigation

> **Purpose**: Complete reference for investigating email security alerts, determining True Positive (TP) vs False Positive (FP), and performing deep-dive email threat analysis.

---

## Table of Contents (Full Guide)

| Part | Coverage |
|------|----------|
| **Part 1** (this file) | Email Fundamentals, Threat Taxonomy, Authentication (SPF/DKIM/DMARC) |
| **Part 2** | Alert Triage & Investigation Workflow, TP vs FP Decision Framework |
| **Part 3** | Advanced Analysis — Headers, URLs, Attachments, IOC Extraction, Playbooks |

---

# PART 1: FOUNDATIONS & EMAIL AUTHENTICATION

---

## 1. Email Security Fundamentals

### 1.1 How Email Works (SMTP Flow)

```
Sender MUA → Sender MTA → DNS (MX Lookup) → Recipient MTA → Recipient MDA → Recipient MUA
```

| Component | Role |
|-----------|------|
| **MUA** (Mail User Agent) | Email client (Outlook, Gmail, Thunderbird) |
| **MTA** (Mail Transfer Agent) | Routes email between servers (Postfix, Exchange, Sendmail) |
| **MDA** (Mail Delivery Agent) | Delivers to mailbox (Dovecot, Exchange Store) |
| **MX Record** | DNS record pointing to the mail server for a domain |
| **SMTP** | Protocol for sending (port 25, 587, 465) |
| **IMAP/POP3** | Protocols for receiving (143/993, 110/995) |

### 1.2 Email Header Structure (Key Fields)

```
Return-Path: <sender@example.com>
Received: from mail-server.example.com (10.0.0.1) by recipient-mx.com; Date
Authentication-Results: spf=pass; dkim=pass; dmarc=pass
From: "John Doe" <john@example.com>
To: victim@company.com
Subject: Urgent Invoice
Date: Wed, 08 Apr 2026 10:30:00 +0000
Message-ID: <unique-id@example.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="boundary-string"
X-Mailer: Microsoft Outlook 16.0
X-Originating-IP: 203.0.113.50
```

### 1.3 Email Security Gateway (SEG) Stack

```
Inbound Email Flow Through Security Stack:
┌──────────────────────────────────────────────────┐
│  Internet → Connection Filtering (IP Reputation) │
│          → Authentication (SPF/DKIM/DMARC)       │
│          → Anti-Spam Engine                       │
│          → Anti-Malware / Sandboxing              │
│          → URL Rewriting / Time-of-Click          │
│          → DLP Policy Check                       │
│          → Content Filtering                      │
│          → Delivery to Mailbox                    │
└──────────────────────────────────────────────────┘
```

**Common SEG/Email Security Platforms:**
- Microsoft Defender for Office 365 (MDO)
- Proofpoint Email Protection
- Mimecast Secure Email Gateway
- Cisco Secure Email (IronPort)
- Barracuda Email Security Gateway
- Google Workspace Security (Gmail)
- Trend Micro Email Security
- Abnormal Security (API-based)

---

## 2. Email Threat Taxonomy

### 2.1 Threat Categories

| Category | Description | Common Indicators |
|----------|-------------|-------------------|
| **Phishing** | Social engineering to steal credentials | Fake login pages, urgency, spoofed sender |
| **Spear Phishing** | Targeted phishing at specific individuals | Personalized content, researched targets |
| **Business Email Compromise (BEC)** | Impersonation of executives/vendors | Display name spoofing, domain lookalikes, no malware |
| **Whaling** | BEC targeting C-suite executives | High-value wire transfers, CEO fraud |
| **Malware Delivery** | Emails with malicious attachments | Macros, executables, archive files |
| **Ransomware Delivery** | Malware that encrypts files | .zip, .js, .docm, .iso attachments |
| **Credential Harvesting** | Fake login pages to steal passwords | URL redirects to phishing kits |
| **Account Takeover (ATO)** | Compromised mailbox used for attacks | Impossible travel, inbox rule changes |
| **Spam / Graymail** | Unsolicited bulk email | Mass distribution, marketing content |
| **Email Bombing** | Flooding inbox to hide malicious activity | Thousands of subscription confirmations |
| **Callback Phishing (BazarCall)** | Email with phone number, no malicious link | Fake invoices with "call to cancel" |
| **QR Code Phishing (Quishing)** | QR codes leading to phishing sites | Image-only emails with QR codes |
| **Thread Hijacking** | Reply to existing email thread | Legitimate conversation thread with malicious insert |
| **HTML Smuggling** | HTML attachment generates malware on open | .html/.htm attachments with embedded JavaScript |

### 2.2 Attack Vectors & Kill Chain Mapping

```
Email Attack Kill Chain (Lockheed Martin + MITRE ATT&CK):

1. Reconnaissance     → T1598 (Phishing for Information)
2. Weaponization      → Craft malicious document/URL
3. Delivery           → T1566.001 (Spearphishing Attachment)
                        T1566.002 (Spearphishing Link)
                        T1566.003 (Spearphishing via Service)
4. Exploitation       → T1204.001 (User Execution: Malicious Link)
                        T1204.002 (User Execution: Malicious File)
5. Installation       → T1059 (Command & Scripting Interpreter)
6. C2                 → T1071 (Application Layer Protocol)
7. Actions on Obj.    → T1114 (Email Collection), T1534 (Internal Spearphishing)
```

### 2.3 Common Phishing Lure Themes

| Theme | Example Subject Lines |
|-------|----------------------|
| **IT/Password** | "Your password expires in 24 hours", "Verify your account" |
| **HR/Payroll** | "Updated benefits enrollment", "Payroll discrepancy" |
| **Finance** | "Invoice #INV-2026-0408 attached", "Wire transfer confirmation" |
| **Legal** | "Subpoena notification", "Contract review required" |
| **Shipping** | "Package delivery failed", "DHL shipment tracking" |
| **COVID/Health** | "Health screening results", "Updated safety protocol" |
| **Microsoft 365** | "Shared document via OneDrive", "Teams meeting update" |
| **Voicemail** | "New voicemail from +1-XXX", "Missed call notification" |
| **MFA/Security** | "Unusual sign-in activity", "MFA verification required" |

---

## 3. Email Authentication Protocols (SPF, DKIM, DMARC)

### 3.1 SPF (Sender Policy Framework)

**What it does**: Specifies which mail servers are authorized to send email on behalf of a domain.

**DNS Record Example:**
```
v=spf1 ip4:192.168.1.0/24 include:spf.google.com include:spf.protection.outlook.com -all
```

**SPF Qualifiers:**
| Qualifier | Meaning | Action |
|-----------|---------|--------|
| `+all` | Pass (allow all) | ⚠️ Dangerous — allows anyone |
| `-all` | Hard Fail | ✅ Reject unauthorized senders |
| `~all` | Soft Fail | ⚠️ Mark but don't reject |
| `?all` | Neutral | No policy |

**SPF Result Interpretations for SOC:**

| Result | Meaning | TP/FP Implication |
|--------|---------|-------------------|
| `spf=pass` | Sending IP is authorized | Could still be spoofed (compromised infra) |
| `spf=fail` | Sending IP NOT authorized | 🔴 Strong spoofing indicator |
| `spf=softfail` | Not authorized but not strictly rejected | ⚠️ Investigate further |
| `spf=neutral` | No SPF policy defined | ⚠️ Domain may lack email security |
| `spf=temperror` | Temporary DNS error | May cause FP — retry needed |
| `spf=permerror` | SPF record misconfigured | May cause FP — notify domain owner |

### 3.2 DKIM (DomainKeys Identified Mail)

**What it does**: Adds a digital signature to verify the email was not altered in transit and was sent by the claimed domain.

**DKIM Header Example:**
```
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=example.com; s=selector1;
  h=from:to:subject:date;
  bh=base64-body-hash;
  b=base64-signature;
```

| Field | Meaning |
|-------|---------|
| `d=` | Signing domain |
| `s=` | Selector (used for DNS key lookup) |
| `a=` | Algorithm (rsa-sha256) |
| `h=` | Headers included in signature |
| `b=` | The actual signature |
| `bh=` | Body hash |

**DKIM Results for SOC:**

| Result | Meaning | Investigation Action |
|--------|---------|---------------------|
| `dkim=pass` | Signature valid, email unaltered | Verify `d=` matches `From:` domain |
| `dkim=fail` | Signature invalid or tampered | 🔴 Possible tampering or spoofing |
| `dkim=none` | No DKIM signature present | ⚠️ Check if domain should have DKIM |

> **Key SOC Check**: Even with `dkim=pass`, verify that the `d=` domain in DKIM matches the `From:` header domain. A mismatch could indicate abuse of a legitimate signing infrastructure.

### 3.3 DMARC (Domain-based Message Authentication, Reporting & Conformance)

**What it does**: Ties SPF and DKIM together with a policy for handling failures.

**DMARC DNS Record Example:**
```
_dmarc.example.com  TXT  "v=DMARC1; p=reject; rua=mailto:dmarc-reports@example.com; pct=100; adkim=s; aspf=s"
```

**DMARC Policies:**

| Policy | Meaning | Security Level |
|--------|---------|----------------|
| `p=none` | Monitor only, no action | 🟡 Weak — only reporting |
| `p=quarantine` | Send to spam/junk | 🟠 Medium — messages flagged |
| `p=reject` | Block the email | 🟢 Strong — full protection |

**DMARC Alignment:**

| Type | Strict (`s`) | Relaxed (`r`) |
|------|-------------|---------------|
| **SPF Alignment** | `Return-Path` domain must exactly match `From` domain | Organizational domain match OK |
| **DKIM Alignment** | `d=` domain must exactly match `From` domain | Organizational domain match OK |

**DMARC Result Interpretation:**

| Result | Meaning | SOC Action |
|--------|---------|------------|
| `dmarc=pass` | SPF or DKIM passed AND aligned | Lower risk, but still analyze content |
| `dmarc=fail` | Neither SPF nor DKIM aligned | 🔴 High spoofing probability |
| `dmarc=bestguesspass` | No DMARC record, gateway guessed | ⚠️ Domain lacks DMARC |

### 3.4 Authentication Analysis Decision Matrix

```
┌─────────────────────────────────────────────────────────────┐
│              EMAIL AUTHENTICATION ANALYSIS                   │
├──────────┬──────────┬──────────┬────────────────────────────┤
│   SPF    │   DKIM   │  DMARC   │       Assessment           │
├──────────┼──────────┼──────────┼────────────────────────────┤
│   Pass   │   Pass   │   Pass   │ ✅ Legitimate (check content) │
│   Pass   │   Fail   │   Pass   │ ⚠️ DKIM issue — investigate  │
│   Fail   │   Pass   │   Pass   │ ⚠️ SPF issue — check IP      │
│   Fail   │   Fail   │   Fail   │ 🔴 HIGH RISK — likely spoof  │
│   Pass   │   Pass   │   Fail   │ ⚠️ Alignment issue           │
│   Fail   │   Fail   │   None   │ 🔴 No protection — suspicious│
│   None   │   None   │   None   │ 🟡 Domain has no email auth  │
│ SoftFail │   Pass   │   Pass   │ ⚠️ SPF misconfigured        │
└──────────┴──────────┴──────────┴────────────────────────────┘
```

---

## 4. Common Email Security Technologies & Controls

### 4.1 Protection Technologies

| Technology | Purpose | Examples |
|------------|---------|----------|
| **Secure Email Gateway (SEG)** | Filter inbound/outbound email | Proofpoint, Mimecast, Cisco ESA |
| **API-Based Email Security** | Post-delivery analysis via API | Abnormal Security, Material Security |
| **Sandboxing** | Detonate attachments/URLs in isolated env | Microsoft Defender, CrowdStrike Falcon Sandbox |
| **URL Rewriting** | Replace URLs with safe links for time-of-click | Proofpoint URL Defense, Mimecast URL Protect |
| **Email DLP** | Prevent sensitive data exfiltration | Microsoft Purview DLP, Symantec DLP |
| **Encryption** | Protect email content in transit/rest | TLS, S/MIME, PGP, Microsoft OME |
| **ICES** | Integrated Cloud Email Security | API-based, supplements SEG |
| **Email Archiving** | Retain emails for compliance/investigation | Mimecast Archive, Barracuda |

### 4.2 Microsoft Defender for Office 365 (MDO) — Key Features for SOC

| Feature | Description |
|---------|-------------|
| **Safe Attachments** | Sandboxing for email attachments |
| **Safe Links** | Time-of-click URL verification |
| **Anti-Phishing Policies** | Impersonation protection, mailbox intelligence |
| **ZAP** (Zero-hour Auto Purge) | Retroactive removal of delivered threats |
| **AIR** (Automated Investigation & Response) | Automated threat investigation |
| **Threat Explorer** | Email hunting and investigation tool |
| **Attack Simulator** | Phishing simulation for awareness training |
| **Submissions** | Submit FPs/FNs to Microsoft for analysis |
| **Campaign Views** | Group related phishing emails into campaigns |
| **Tenant Allow/Block List** | Override filtering decisions |

### 4.3 Proofpoint Email Protection — Key Features for SOC

| Feature | Description |
|---------|-------------|
| **TAP** (Targeted Attack Protection) | Advanced threat sandboxing |
| **URL Defense** | URL rewriting and click-time analysis |
| **Attachment Defense** | Sandbox & static analysis of files |
| **Impostor Detection** | BEC/impersonation detection |
| **TRAP** (Threat Response Auto-Pull) | Remove delivered threats from mailboxes |
| **Forensics Dashboard** | Detailed threat forensics |
| **Smart Search** | Email trace and investigation |
| **SER** (Sender Email Reputation) | IP and domain reputation scoring |

---

## 5. Key Email-Related MITRE ATT&CK Techniques

| Technique ID | Name | Description |
|-------------|------|-------------|
| T1566.001 | Spearphishing Attachment | Malicious file attached to email |
| T1566.002 | Spearphishing Link | Malicious URL in email body |
| T1566.003 | Spearphishing via Service | Phishing via social media/messaging |
| T1566.004 | Spearphishing Voice (Vishing) | Phone-based social engineering |
| T1598 | Phishing for Information | Recon phishing to gather info |
| T1534 | Internal Spearphishing | Lateral phishing from compromised account |
| T1114.001 | Local Email Collection | Accessing local email data |
| T1114.002 | Remote Email Collection | Accessing email via APIs/protocols |
| T1114.003 | Email Forwarding Rule | Auto-forwarding to external address |
| T1204.001 | User Execution: Malicious Link | User clicks malicious URL |
| T1204.002 | User Execution: Malicious File | User opens malicious attachment |
| T1586.002 | Compromise Accounts: Email | Attacker compromises email accounts |

---

*Continued in Part 2 → Alert Triage, Investigation Workflow, TP vs FP Framework*


---

# 📧 Email Security SOC Guide — Part 2: Alert Triage, TP vs FP Framework

---

# PART 2: ALERT TRIAGE & TP vs FP DECISION FRAMEWORK

---

## 6. Email Alert Triage Workflow (L2 SOC Analyst)

### 6.1 Standard Investigation Workflow

```
┌───────────────────────────────────────────────────────────────────┐
│                    EMAIL ALERT TRIAGE WORKFLOW                     │
├───────────────────────────────────────────────────────────────────┤
│                                                                   │
│  1. ALERT INTAKE                                                  │
│     ├─ Review alert source (SEG, SIEM, user report, phishing sim)│
│     ├─ Capture alert metadata (severity, category, timestamp)     │
│     └─ Check for related/duplicate alerts                        │
│                                                                   │
│  2. INITIAL ASSESSMENT (5-min quick look)                        │
│     ├─ Who sent it? (From, Return-Path, sending IP)              │
│     ├─ Who received it? (To, CC, BCC, distribution lists)        │
│     ├─ What's the subject/content? (Lure theme, urgency cues)    │
│     ├─ Authentication results? (SPF/DKIM/DMARC)                 │
│     └─ Any attachments or URLs?                                  │
│                                                                   │
│  3. DEEP ANALYSIS                                                 │
│     ├─ Full header analysis                                      │
│     ├─ Sender reputation & domain age check                      │
│     ├─ URL analysis (defanged, deobfuscated, sandboxed)          │
│     ├─ Attachment analysis (hash, sandbox, VirusTotal)           │
│     ├─ Content analysis (language, branding, social engineering) │
│     └─ Cross-reference threat intelligence                       │
│                                                                   │
│  4. VERDICT DETERMINATION                                        │
│     ├─ True Positive (TP) → Containment & Remediation            │
│     ├─ Benign True Positive (BTP) → Suspicious but authorized    │
│     ├─ False Positive (FP) → Release & Tune                      │
│     └─ False Negative (FN) → Retroactive hunt & remediate        │
│                                                                   │
│  5. RESPONSE ACTIONS                                              │
│     ├─ Block sender/domain/IP                                    │
│     ├─ Remove email from all mailboxes (purge/TRAP/ZAP)          │
│     ├─ Reset credentials if clicked/compromised                  │
│     ├─ Isolate endpoint if malware executed                      │
│     ├─ Submit IOCs to threat intel platform                      │
│     └─ Document & close ticket                                   │
│                                                                   │
│  6. POST-INCIDENT                                                 │
│     ├─ Update detection rules                                    │
│     ├─ Conduct threat hunting for similar emails                 │
│     ├─ User awareness notification                               │
│     └─ Lessons learned / metrics update                          │
└───────────────────────────────────────────────────────────────────┘
```

### 6.2 Critical Questions During Investigation

| Phase | Key Questions |
|-------|--------------|
| **Sender** | Is the sender internal or external? Is the domain legitimate or lookalike? Was the account compromised? What is the domain age? |
| **Recipient** | Is the recipient a high-value target (executive, finance, IT admin)? How many recipients? Is this a targeted or mass campaign? |
| **Content** | Does the email create urgency/fear? Is there brand impersonation? Does the language match expected communication? |
| **URLs** | Where does the URL redirect? Is URL shortening used? Does the landing page mimic a login portal? Is it behind CAPTCHA? |
| **Attachments** | What file type? Does it contain macros? What's the file hash? Does it match known malware signatures? |
| **Delivery** | Was it delivered or quarantined? Did ZAP/TRAP remove it post-delivery? Did the user interact with it? |
| **Context** | Is this part of a larger campaign? Have we seen this IOC before? Does it correlate with any ongoing incidents? |

---

## 7. True Positive (TP) vs False Positive (FP) Decision Framework

### 7.1 TP vs FP Definitions

| Verdict | Definition | Example |
|---------|------------|---------|
| **True Positive (TP)** | Alert correctly identified a real threat | Phishing email with credential harvesting URL correctly blocked |
| **False Positive (FP)** | Alert triggered on legitimate/benign email | Legitimate invoice from vendor flagged as phishing |
| **True Negative (TN)** | Legitimate email correctly allowed | Normal business email delivered successfully |
| **False Negative (FN)** | Real threat missed by security controls | Phishing email bypassed SEG and reached inbox |
| **Benign True Positive (BTP)** | Alert is technically correct but activity is authorized | Penetration test phishing simulation flagged |

### 7.2 Comprehensive TP Indicators

#### 🔴 Strong TP Indicators (High Confidence)

| Category | Indicator | Why It Matters |
|----------|-----------|----------------|
| **Sender** | Domain registered < 30 days ago | Attackers register fresh domains for campaigns |
| **Sender** | Lookalike/typosquat domain (e.g., `micr0soft.com`) | Classic impersonation technique |
| **Sender** | SPF=Fail, DKIM=Fail, DMARC=Fail | Email authentication completely failed |
| **Sender** | Sending IP on known blocklists | Infrastructure associated with malicious activity |
| **Sender** | Display name mismatch with email address | "Microsoft Support" \<support@randomdomain.xyz\> |
| **URL** | URL redirects to credential harvesting page | Designed to steal login credentials |
| **URL** | Known malicious URL in threat intel feeds | Previously reported as malicious |
| **URL** | URL uses URL shortener + redirect chain | Evasion technique to hide true destination |
| **URL** | Landing page mimics legitimate login portal | Brand impersonation for credential theft |
| **Attachment** | File hash matches known malware on VirusTotal | Previously identified malware sample |
| **Attachment** | Contains malicious macros (VBA, PowerShell) | Weaponized document |
| **Attachment** | Password-protected archive with executable inside | Evasion of security scanning |
| **Attachment** | .iso, .img, .vhd files (MOTW bypass) | Mark-of-the-Web bypass technique |
| **Content** | Urgency + threat of account closure/legal action | Social engineering pressure tactics |
| **Content** | Request for credentials, PII, or financial data | Data harvesting attempt |
| **Content** | Mismatch between claimed sender and content origin | Spoofing evidence |
| **Behavior** | User clicked link and credentials were entered | Confirmed compromise |
| **Behavior** | Post-click: new inbox rules, forwarding rules created | Account takeover indicators |
| **Behavior** | Post-click: impossible travel login detected | Compromised credentials in use |

#### 🟡 Medium Confidence TP Indicators

| Indicator | Context |
|-----------|---------|
| Email from free email provider claiming to be business | Could be legitimate for small businesses |
| Generic greeting ("Dear Customer") in targeted context | Could be mass marketing |
| Suspicious attachment type (.js, .vbs, .scr, .lnk) | Rarely used in legitimate business |
| URL with excessive subdomains or IP-based URL | Evasion technique but some legitimate services do this |
| Email sent outside business hours from internal domain | Could be remote worker in different timezone |
| Reply-to differs from From address | Some legitimate use cases exist (mailing lists) |

### 7.3 Comprehensive FP Indicators

#### 🟢 Strong FP Indicators (High Confidence)

| Category | Indicator | Why It's Likely FP |
|----------|-----------|-------------------|
| **Sender** | Known trusted vendor/partner domain | Established business relationship |
| **Sender** | SPF=Pass, DKIM=Pass, DMARC=Pass | Full authentication verified |
| **Sender** | Domain age > 1 year with good reputation | Established domain |
| **Sender** | Consistent sending patterns from this sender | Not anomalous behavior |
| **URL** | URL resolves to known legitimate service | Office 365, Google, DocuSign, etc. |
| **URL** | URL matches known SaaS platform patterns | Legitimate business tools |
| **Attachment** | Clean on VirusTotal (0 detections, known hash) | Not flagged by any AV engine |
| **Attachment** | File type matches expected business content | .pdf invoice from known vendor |
| **Content** | Expected communication matching business context | Scheduled report, newsletter |
| **Content** | Part of ongoing legitimate email thread | Pre-existing conversation |
| **Context** | User confirms they were expecting this email | Legitimate business transaction |
| **Context** | Matches known marketing/newsletter pattern | Opted-in communications |
| **Technical** | SEG rule triggered on keyword heuristic only | Overly broad detection rule |
| **Technical** | Quarantined due to bulk sending but content is clean | Marketing email misclassified |

#### 🟡 FP Scenarios Requiring Careful Validation

| Scenario | Investigation Steps |
|----------|-------------------|
| Legitimate email flagged by new detection rule | Review rule logic, check for overmatching |
| Encrypted attachment blocked by policy | Verify sender, request unencrypted version |
| Marketing email from new vendor platform | Verify vendor relationship, check headers |
| Internal email flagged due to external relay | Verify email flow, check for misconfigured routing |
| Auto-forwarded email flagged as external threat | Check forwarding rules, verify original sender |
| Calendar invite with external URL flagged | Verify meeting organizer, check URL destination |

### 7.4 TP vs FP Decision Tree

```
                        📧 Email Alert Received
                                │
                    ┌───────────┴───────────┐
                    │  Check Authentication  │
                    │  (SPF/DKIM/DMARC)      │
                    └───────────┬───────────┘
                         │            │
                    ALL FAIL      ANY PASS
                         │            │
                   🔴 High Risk   ┌───┴───┐
                         │        │       │
                         ▼        ▼       │
                   Check Sender   Check   │
                   Domain Age    Sender   │
                         │      Known?    │
                    < 30 days    │    │    │
                         │     YES   NO   │
                    🔴 Likely    │    │    │
                       TP       │    ▼    │
                         │      │  Check  │
                         │      │ Content │
                         │      │    │    │
                         │      │   ┌┴┐   │
                         │      │  Sus Normal
                         │      │   │    │
                         │      │  🟡    🟢
                         │      │ Invest. Likely
                         │      │ More    FP
                         │      │
                         │      ▼
                         │   Check URL/
                         │   Attachment
                         │      │
                         │   ┌──┴──┐
                         │  Clean  Malicious
                         │   │      │
                         │  🟢     🔴
                         │  FP     TP
                         ▼
                    Deep Analysis
                    Required
```

### 7.5 Alert-Specific TP/FP Analysis

#### Phishing Alert

| Check | TP Signal | FP Signal |
|-------|-----------|-----------|
| Sender domain | Lookalike, newly registered | Known vendor domain with history |
| Authentication | SPF/DKIM/DMARC fail | All pass with alignment |
| URL destination | Fake login page, IP-based | Known legitimate service |
| Content urgency | "Act now or account suspended" | Normal business tone |
| Branding | Slightly off logos/formatting | Professional, matches real brand |
| Recipients | Mass distribution, random targets | Expected business distribution |

#### BEC Alert

| Check | TP Signal | FP Signal |
|-------|-----------|-----------|
| Display name | Matches executive but email differs | Legitimate executive email |
| Reply-to | Points to external free email | Same as From address |
| Request type | Wire transfer, gift cards, W-2 | Normal business request |
| Tone | Unusual urgency, secrecy requested | Normal communication style |
| Timing | Sent while executive is traveling/OOO | During normal business hours |
| Previous pattern | First time this type of request | Regular recurring communication |

#### Malware Alert

| Check | TP Signal | FP Signal |
|-------|-----------|-----------|
| File hash | Known malware hash on VT | Clean hash, known software |
| Macro content | Obfuscated VBA, external call | Standard business macro |
| File extension | Double extension (.pdf.exe) | Normal extension for type |
| Sandbox result | Malicious behavior detected | Clean execution |
| Sender context | Unexpected attachment from unknown | Expected file from known sender |
| Password protection | "Password in email body" pattern | Enterprise-standard encryption |

#### Account Compromise / ATO Alert

| Check | TP Signal | FP Signal |
|-------|-----------|-----------|
| Login location | Impossible travel detected | User traveling (confirmed) |
| Inbox rules | New forward-to-external rule | User-configured legitimate rule |
| Sent items | Mass phishing from account | Normal sent activity |
| MFA | MFA challenged and bypassed | Normal MFA approval |
| Password change | Unauthorized password reset | User-initiated reset |
| Login pattern | Login from TOR/VPN exit node | Corporate VPN usage |

---

## 8. Investigation Checklist by Alert Type

### 8.1 Phishing Email Investigation Checklist

```
□ Capture the full email (including headers)
□ Identify sender: From, Return-Path, X-Originating-IP
□ Check SPF/DKIM/DMARC results in Authentication-Results header
□ WHOIS lookup on sender domain (age, registrar, registrant)
□ Check sender IP reputation (AbuseIPDB, VirusTotal, Talos)
□ Analyze all URLs (defang, expand shorteners, check URLScan.io)
□ Analyze all attachments (hash check, sandbox, VirusTotal)
□ Check if email was delivered or quarantined
□ Identify total recipients (scope assessment)
□ Check if any user clicked URLs or opened attachments
□ Check for similar emails in the environment (threat hunting)
□ Cross-reference with threat intelligence feeds
□ Determine verdict: TP / FP / BTP
□ Execute response actions based on verdict
□ Document findings in ticketing system
```

### 8.2 BEC Investigation Checklist

```
□ Verify the claimed sender via out-of-band communication
□ Check email headers for external origin indicators
□ Compare display name vs actual email address
□ Check Reply-To header for mismatch
□ Analyze communication pattern (tone, style, grammar)
□ Check if the real person's account is compromised
□ Review authentication results
□ Check if financial action was requested
□ Check for domain lookalike (homoglyph analysis)
□ Review recent inbox rules on the claimed sender's account
□ Determine if the real person is traveling/unavailable
□ Engage finance team if wire transfer was initiated
□ Document and escalate per BEC response procedure
```

### 8.3 Account Compromise Investigation Checklist

```
□ Review sign-in logs (location, IP, device, time)
□ Check for impossible travel
□ Review MFA logs and challenges
□ Audit inbox rules (forwarding, auto-delete, move)
□ Review sent items for internal/external phishing
□ Check for OAuth app consents
□ Review mailbox delegation changes
□ Check for PowerShell/Graph API access
□ Review password/MFA changes
□ Check for data exfiltration (mail forwarding, eDiscovery)
□ Analyze any emails sent from the compromised account
□ Check Azure AD / Entra ID sign-in risk events
□ Block & revoke sessions
□ Reset password and MFA
□ Remove malicious inbox rules
□ Notify affected recipients of phishing from this account
```

---

*Continued in Part 3 → Advanced Analysis: Headers, URLs, Attachments, IOC Extraction, Playbooks*


---

# 📧 Email Security SOC Guide — Part 3: Advanced Analysis & IOC Extraction

---

# PART 3: ADVANCED EMAIL ANALYSIS TECHNIQUES

---

## 9. Email Header Deep-Dive Analysis

### 9.1 Reading Headers (Bottom to Top)

> **Critical Rule**: Email headers are read **bottom-to-top**. The bottom-most `Received:` header is the originating server. Each subsequent header is added by each MTA in the delivery chain.

```
Received: from final-hop.company.com (10.0.0.5)      ← 3rd hop (recipient MTA)
    by mailbox-server.company.com; Wed, 08 Apr 2026 10:30:05
Received: from relay.example.com (203.0.113.50)       ← 2nd hop (relay/SEG)
    by final-hop.company.com; Wed, 08 Apr 2026 10:30:03
Received: from sender-mta.attacker.com (198.51.100.1) ← 1st hop (ORIGINATOR)
    by relay.example.com; Wed, 08 Apr 2026 10:30:00
```

### 9.2 Key Headers & SOC Relevance

| Header | What to Check | Red Flags |
|--------|--------------|-----------|
| **From** | Display name and email address | Display name ≠ email domain; impersonation |
| **Return-Path / Envelope-From** | Actual sender for bounce handling | Different domain from `From:` header |
| **Reply-To** | Where replies are directed | External free email (Gmail, Yahoo) when From is corporate |
| **Received** | Delivery chain, originating IP | Mismatched geolocation; known bad IPs |
| **X-Originating-IP** | Original sender's IP | Residential IP, TOR exit node, VPN |
| **Authentication-Results** | SPF/DKIM/DMARC verdict | Any fail or softfail |
| **X-Mailer / User-Agent** | Email client used | Unusual or outdated client for the claimed sender |
| **Message-ID** | Unique message identifier | Domain in Message-ID doesn't match sender domain |
| **Content-Type** | MIME type of message body | multipart/mixed with unexpected attachment types |
| **X-MS-Exchange-Organization-SCL** | Spam Confidence Level (Exchange) | High SCL value (≥5) indicates spam likelihood |
| **X-Forefront-Antispam-Report** | Microsoft's detailed spam analysis | Contains CAT (category), SFV (spam filter verdict) |
| **X-Microsoft-Antispam** | Additional Microsoft filtering data | BCL (Bulk Complaint Level), PCL values |
| **Received-SPF** | SPF check result | softfail or fail |
| **ARC-Authentication-Results** | Authenticated Received Chain | Useful when email passes through intermediaries |

### 9.3 Header Anomaly Detection

| Anomaly | Description | Likely Verdict |
|---------|-------------|----------------|
| **Hop count mismatch** | Too many or too few Received headers | ⚠️ Possible relay abuse or header injection |
| **Timestamp inconsistency** | Received timestamps go backwards | 🔴 Header forgery |
| **Missing headers** | No Authentication-Results, no Message-ID | ⚠️ Non-standard or crafted email |
| **From ≠ Return-Path** | Envelope sender differs from display sender | ⚠️ May be legitimate (mailing list) or spoofing |
| **Reply-To mismatch** | Reply-To points to different domain | 🔴 BEC indicator |
| **Internal-looking but external origin** | Claims to be from @company.com but Received shows external | 🔴 Spoofing attempt |
| **Encoded/obfuscated subject** | Base64 or unusual encoding in Subject | ⚠️ Evasion attempt |

### 9.4 Microsoft 365 Specific Headers

| Header | Values & Meaning |
|--------|-----------------|
| **X-MS-Exchange-Organization-SCL** | -1 (bypass), 0-4 (low risk), 5-6 (spam), 7-9 (high confidence spam) |
| **X-Forefront-Antispam-Report: CAT** | `PHSH` (phishing), `MALW` (malware), `SPM` (spam), `HSPM` (high confidence spam), `SPOOF` (spoofing) |
| **X-Forefront-Antispam-Report: SFV** | `BLK` (blocked), `NSPM` (not spam), `SPM` (spam), `SKS` (skipped scanning) |
| **X-MS-Exchange-Organization-AuthSource** | Server that performed authentication |
| **X-MS-Exchange-Organization-AuthAs** | `Anonymous` (external), `Internal` (internal) |
| **X-MS-Exchange-Transport-CrossTenantHeadersStamped** | Cross-tenant routing information |
| **X-OriginatorOrg** | Originating organization |

### 9.5 Header Analysis Tools

| Tool | Purpose | URL/Access |
|------|---------|------------|
| **MXToolbox Header Analyzer** | Parse and visualize email headers | mxtoolbox.com/HeaderAnalyzer.aspx |
| **Google Admin Toolbox** | Analyze email headers | toolbox.googleapps.com/apps/messageheader |
| **Mail Header Analyzer (by GlockApps)** | Detailed header breakdown | glockapps.com/email-header-analyzer |
| **Message Trace (M365 Admin)** | Trace email delivery in Microsoft 365 | admin.microsoft.com → Mail flow → Message trace |
| **Threat Explorer (MDO)** | Hunt emails in Microsoft Defender | security.microsoft.com → Email & collaboration |

---

## 10. URL Analysis

### 10.1 URL Investigation Workflow

```
URL Found in Email
       │
       ▼
┌─────────────────┐
│ 1. DEFANG the URL│ → Replace http with hxxp, . with [.]
└────────┬────────┘
         ▼
┌─────────────────┐
│ 2. Expand URL    │ → Unshorten bit.ly, tinyurl, etc.
└────────┬────────┘
         ▼
┌─────────────────┐
│ 3. Check         │ → VirusTotal, URLScan.io, URLhaus
│    Reputation    │    PhishTank, Google Safe Browsing
└────────┬────────┘
         ▼
┌─────────────────┐
│ 4. Inspect       │ → WHOIS domain lookup, DNS records
│    Domain        │    Domain age, registrar, hosting
└────────┬────────┘
         ▼
┌─────────────────┐
│ 5. Safe Browse   │ → Open in sandbox/isolated browser
│    the URL       │    Check for credential harvesting form
└────────┬────────┘
         ▼
┌─────────────────┐
│ 6. Screenshot    │ → Capture landing page for evidence
│    & Document    │    Archive with urlscan.io or Wayback
└─────────────────┘
```

### 10.2 URL Red Flags

| Indicator | Example | Risk Level |
|-----------|---------|------------|
| **IP-based URL** | `http://198.51.100.1/login` | 🔴 High |
| **Lookalike domain** | `micros0ft-login.com` | 🔴 High |
| **Excessive subdomains** | `login.microsoft.com.evil.com` | 🔴 High |
| **URL shortener** | `bit.ly/3xAbCdE` | 🟡 Medium |
| **Base64 in URL path** | `/redirect?url=aHR0cDov...` | 🔴 High |
| **Multiple redirects** | 3+ hops before final destination | 🔴 High |
| **Newly registered domain** | Domain age < 30 days | 🔴 High |
| **Free hosting/sites** | `sites.google.com`, `weebly.com` | 🟡 Medium |
| **Credential form on landing** | Username/password fields | 🔴 High |
| **Brand logos on non-brand domain** | Microsoft logo on `random-site.xyz` | 🔴 High |
| **CAPTCHA before phishing page** | CloudFlare turnstile hiding content | 🔴 High (evasion) |
| **URL encoded characters** | `%2F%2Flogin%2Ephishing%2Ecom` | 🟡 Medium |
| **Data URI** | `data:text/html;base64,...` | 🔴 High |
| **JavaScript redirect** | `javascript:window.location=...` | 🔴 High |

### 10.3 URL Analysis Tools

| Tool | Purpose | Type |
|------|---------|------|
| **URLScan.io** | Scan & screenshot URLs safely | Free/Paid |
| **VirusTotal** | Multi-engine URL scanning | Free/Paid |
| **PhishTank** | Community phishing URL database | Free |
| **URLhaus** (abuse.ch) | Malware URL database | Free |
| **Google Safe Browsing** | Google's URL threat check | Free API |
| **Hybrid Analysis** | URL sandbox detonation | Free/Paid |
| **ANY.RUN** | Interactive URL sandbox | Free/Paid |
| **CheckPhish.ai** | AI-powered phishing detection | Free |
| **Unfurl** | Parse & visualize URL components | Free |
| **CyberChef** | Decode/deobfuscate URL encoding | Free |
| **WhoisXML API** | Domain WHOIS and history | Paid |
| **SecurityTrails** | Historical DNS data | Free/Paid |

### 10.4 Phishing Kit Indicators

| Component | Description |
|-----------|-------------|
| **Login form clone** | Pixel-perfect copy of Microsoft 365, Google, bank login |
| **Hidden form fields** | Captures additional data (user-agent, IP, location) |
| **Exfiltration method** | Form POST to attacker server, Telegram bot, email |
| **Anti-analysis** | GeoIP blocking, user-agent filtering, bot detection |
| **Token theft** | AiTM (Adversary-in-the-Middle) proxying real login to steal session tokens |
| **Progressive phishing** | First page asks for email, second for password, third for MFA |

---

## 11. Attachment Analysis

### 11.1 High-Risk Attachment Types

| File Type | Risk | Common Attack Vector |
|-----------|------|---------------------|
| `.exe, .scr, .bat, .cmd, .com` | 🔴 Critical | Direct executable — malware dropper |
| `.js, .vbs, .wsf, .ps1` | 🔴 Critical | Script-based malware execution |
| `.docm, .xlsm, .pptm` | 🔴 High | Macro-enabled Office documents |
| `.doc, .xls` (legacy) | 🔴 High | Legacy formats support macros by default |
| `.iso, .img, .vhd, .vhdx` | 🔴 High | Disk image — bypasses Mark-of-the-Web (MOTW) |
| `.lnk` | 🔴 High | Windows shortcut executing hidden commands |
| `.html, .htm, .mht` | 🟠 High | HTML smuggling — generates payload on open |
| `.zip, .rar, .7z, .gz` | 🟡 Medium | May contain hidden executables |
| `.pdf` | 🟡 Medium | Can contain JavaScript, embedded objects, URLs |
| `.one` (OneNote) | 🟠 High | Embedded scripts in OneNote files (newer vector) |
| `.svg` | 🟡 Medium | Can contain embedded JavaScript |
| `.eml, .msg` | 🟡 Medium | Nested email with malicious content inside |

### 11.2 Attachment Analysis Workflow

```
Attachment Received
       │
       ▼
┌──────────────────────┐
│ 1. DO NOT OPEN on    │
│    production system  │
└──────────┬───────────┘
           ▼
┌──────────────────────┐
│ 2. Calculate hash    │ → MD5, SHA1, SHA256
│    (without opening) │    Use: certutil, sha256sum, PowerShell
└──────────┬───────────┘
           ▼
┌──────────────────────┐
│ 3. Check hash on     │ → VirusTotal, Malware Bazaar,
│    threat intel      │    Hybrid Analysis, OPSWAT
└──────────┬───────────┘
           ▼
┌──────────────────────┐         ┌───────────────────┐
│ 4. Known malware?    │──YES──▶ │ 🔴 TP Confirmed   │
│                      │         │ Proceed to contain │
└──────────┬───────────┘         └───────────────────┘
           NO
           ▼
┌──────────────────────┐
│ 5. Submit to sandbox │ → ANY.RUN, Joe Sandbox, Hybrid Analysis
│    for detonation    │    Microsoft Defender Sandbox, Cuckoo
└──────────┬───────────┘
           ▼
┌──────────────────────┐
│ 6. Analyze behavior  │ → Process creation, network connections,
│                      │    file system changes, registry mods
└──────────┬───────────┘
           ▼
┌──────────────────────┐
│ 7. Static analysis   │ → Strings, YARA rules, macro extraction
│    (if needed)       │    PE analysis, OLE analysis
└──────────┬───────────┘
           ▼
    Determine Verdict
```

### 11.3 Attachment Analysis Tools

| Tool | Purpose | Type |
|------|---------|------|
| **VirusTotal** | Multi-AV hash/file scanning | Free/Paid |
| **Hybrid Analysis** | Automated sandbox analysis | Free/Paid |
| **ANY.RUN** | Interactive malware sandbox | Free/Paid |
| **Joe Sandbox** | Deep malware analysis | Paid |
| **Cuckoo Sandbox** | Open-source sandbox | Free (self-hosted) |
| **Malware Bazaar** (abuse.ch) | Malware sample sharing | Free |
| **OPSWAT MetaDefender** | Multi-engine file scanning | Free/Paid |
| **OLETools** | Analyze OLE/Office macro documents | Free |
| **YARA** | Pattern matching for malware detection | Free |
| **PEStudio** | Static PE file analysis | Free |
| **CyberChef** | Decode/deobfuscate payloads | Free |
| **Didier Stevens Suite** | PDF & Office document analysis tools | Free |
| **ExifTool** | Metadata extraction from files | Free |

### 11.4 Office Macro Analysis

```
Macro Analysis Steps:
1. Extract with olevba (oletools):
   $ olevba suspicious.docm

2. Look for:
   ├─ AutoOpen / Document_Open (auto-execute triggers)
   ├─ Shell / WScript.Shell (command execution)
   ├─ PowerShell invocations
   ├─ URLDownloadToFile / XMLHTTP (downloading payloads)
   ├─ Environment variable access
   ├─ Base64 encoded strings
   └─ Heavily obfuscated variable names

3. Red flags in macro code:
   ├─ CreateObject("WScript.Shell").Run
   ├─ powershell -encodedcommand
   ├─ Invoke-Expression (IEX)
   ├─ certutil -decode
   ├─ bitsadmin /transfer
   └─ regsvr32 /s /n /u /i:http://...
```

---

## 12. IOC (Indicators of Compromise) Extraction & Enrichment

### 12.1 Email IOC Types

| IOC Type | Example | Where to Find |
|----------|---------|---------------|
| **Sender Email** | attacker@malicious-domain.com | From header |
| **Sender Domain** | malicious-domain.com | From header, Return-Path |
| **Sender IP** | 198.51.100.1 | Received headers, X-Originating-IP |
| **Phishing URL** | hxxps://fake-login[.]com/o365 | Email body, HTML source |
| **Redirect URL** | hxxps://bit[.]ly/3xAbCdE | Email body |
| **Final Landing URL** | hxxps://credential-harvest[.]xyz | URL redirect chain |
| **Attachment Hash (MD5)** | d41d8cd98f00b204e9800998ecf8427e | File hash calculation |
| **Attachment Hash (SHA256)** | e3b0c44298fc1c149afbf4c8996... | File hash calculation |
| **Attachment Filename** | Invoice_April_2026.docm | MIME part headers |
| **Subject Line** | "Urgent: Verify Your Account" | Subject header |
| **Message-ID** | \<unique-id@malicious.com\> | Message-ID header |
| **User-Agent** | Custom-Mailer/1.0 | X-Mailer header |
| **DKIM Selector** | selector1 | DKIM-Signature header |
| **Reply-To Address** | reply@different-domain.com | Reply-To header |

### 12.2 IOC Enrichment Matrix

| IOC Type | Enrichment Sources | What to Check |
|----------|-------------------|---------------|
| **IP Address** | VirusTotal, AbuseIPDB, Shodan, IPVoid, Talos Intelligence, OTX | Geolocation, ASN, abuse reports, open ports, reputation score |
| **Domain** | VirusTotal, URLScan, WHOIS, DomainTools, SecurityTrails, PassiveTotal | Registration date, registrar, nameservers, historical DNS, subdomains |
| **URL** | URLScan.io, VirusTotal, PhishTank, Google Safe Browsing, URLhaus | Screenshot, final destination, technologies, categorization |
| **File Hash** | VirusTotal, Malware Bazaar, Hybrid Analysis, OPSWAT, ThreatFox | AV detections, sandbox results, associated campaigns, YARA matches |
| **Email Address** | Have I Been Pwned, Hunter.io, EmailRep.io | Breach history, disposable check, reputation |

### 12.3 IOC Documentation Template

```markdown
## Email Security Incident — IOC Report

**Ticket ID**: INC-2026-XXXX
**Date**: 2026-04-08
**Analyst**: [Name]
**Severity**: [Critical/High/Medium/Low]
**Verdict**: [TP/FP/BTP]

### Email Metadata
- **Subject**: 
- **From (Display)**: 
- **From (Address)**: 
- **Return-Path**: 
- **Reply-To**: 
- **Date/Time**: 
- **Message-ID**: 
- **Recipients**: 
- **SPF**: [pass/fail/softfail/none]
- **DKIM**: [pass/fail/none]
- **DMARC**: [pass/fail/none]
- **X-Originating-IP**: 

### Sender Analysis
- **Domain**: 
- **Domain Age**: 
- **WHOIS Registrant**: 
- **Reputation**: 
- **Sending IP**: 
- **IP Geolocation**: 
- **IP Reputation**: 

### URL IOCs
| # | Defanged URL | Type | Verdict | VT Score |
|---|-------------|------|---------|----------|
| 1 | hxxps://... | Redirect | Malicious | 15/90 |
| 2 | hxxps://... | Landing Page | Malicious | 22/90 |

### Attachment IOCs
| Filename | SHA256 | File Type | VT Score | Sandbox Result |
|----------|--------|-----------|----------|----------------|
| file.docm | abc123... | Office/Macro | 30/70 | Malicious |

### Network IOCs (from sandbox)
| IOC | Type | Context |
|-----|------|---------|
| 198.51.100.50 | C2 IP | PowerShell beacon |
| evil-c2.com | C2 Domain | Payload download |

### Analysis Summary
[Detailed narrative of findings]

### Response Actions Taken
- [ ] Email purged from all mailboxes
- [ ] Sender domain blocked
- [ ] URL blocked at proxy/firewall
- [ ] File hash blocked at endpoint
- [ ] Affected users notified
- [ ] Credentials reset (if clicked)
- [ ] IOCs shared with threat intel team
```

---

## 13. Email Threat Hunting Queries

### 13.1 Microsoft 365 — Threat Explorer / Advanced Hunting (KQL)

```kusto
// Find emails from a specific sender domain
EmailEvents
| where SenderFromDomain == "suspicious-domain.com"
| where Timestamp > ago(7d)
| project Timestamp, SenderFromAddress, RecipientEmailAddress, Subject, DeliveryAction, DeliveryLocation

// Find emails with specific attachment type
EmailAttachmentInfo
| where FileName endswith ".docm" or FileName endswith ".xlsm" or FileName endswith ".iso"
| where Timestamp > ago(7d)
| join EmailEvents on NetworkMessageId
| project Timestamp, SenderFromAddress, RecipientEmailAddress, Subject, FileName, FileType

// Find emails containing specific URL domain
EmailUrlInfo
| where UrlDomain contains "phishing-domain"
| where Timestamp > ago(7d)
| join EmailEvents on NetworkMessageId
| project Timestamp, SenderFromAddress, RecipientEmailAddress, Subject, Url

// Find emails with specific subject pattern
EmailEvents
| where Subject contains "invoice" and Subject contains "urgent"
| where Timestamp > ago(7d)
| where DeliveryAction == "Delivered"

// Detect potential BEC — Display name spoofing executives
EmailEvents
| where SenderFromAddress !endswith "@company.com"
| where SenderDisplayName in ("CEO Name", "CFO Name", "CTO Name")
| where Timestamp > ago(30d)

// Find emails where user clicked URLs
EmailEvents
| join UrlClickEvents on NetworkMessageId
| where Timestamp > ago(7d)
| project Timestamp, SenderFromAddress, RecipientEmailAddress, Url, ActionType, IsClickedThrough

// Detect inbox rule creation (account compromise indicator)
CloudAppEvents
| where ActionType == "New-InboxRule"
| where Timestamp > ago(30d)
| extend RuleName = tostring(parse_json(RawEventData).Parameters[0].Value)
| project Timestamp, AccountDisplayName, RuleName, RawEventData

// Hunt for emails from newly registered domains
EmailEvents
| where Timestamp > ago(7d)
| where DeliveryAction == "Delivered"
| join kind=leftouter (
    EmailAttachmentInfo | project NetworkMessageId, FileName
) on NetworkMessageId
| where SenderFromDomain !endswith ".com" or SenderFromDomain matches regex @"[0-9]{4,}"
```

### 13.2 Splunk — Email Security Queries

```spl
// Phishing emails with failed authentication
index=email sourcetype=email:headers
| where spf_result="fail" OR dkim_result="fail" OR dmarc_result="fail"
| stats count by sender_domain, sender_address, subject, spf_result, dkim_result, dmarc_result
| sort -count

// Emails with suspicious attachment types
index=email sourcetype=email:attachments
| where match(attachment_name, "\.(exe|scr|js|vbs|docm|xlsm|iso|lnk|html|ps1)$")
| stats count by sender_address, attachment_name, attachment_hash
| sort -count

// URL click analysis
index=email_proxy sourcetype=urlclick
| where action="allowed"
| stats count by user, url_domain, url_full
| where count > 0
| sort -count

// Detect email bombing (high volume to single recipient)
index=email sourcetype=email:headers
| bin _time span=1h
| stats count by recipient_address, _time
| where count > 50
| sort -count

// BEC detection — Reply-To mismatch
index=email sourcetype=email:headers
| where reply_to != sender_address AND reply_to != ""
| stats count by sender_address, reply_to, subject
| sort -count
```

### 13.3 Google Workspace — Email Log Search

```
// Admin Console → Reporting → Email Log Search
// Key filters:
- Sender: attacker@domain.com
- Recipient: victim@company.com
- Date range: [specific period]
- Subject: contains "invoice"
- Message ID: <specific-message-id>
- Has attachment: yes
- Attachment name: contains ".docm"

// Gmail Security Investigation Tool
// Admin Console → Security → Investigation Tool
// Search by: Message ID, sender, subject, attachment hash
// Actions: Delete, Mark as phishing, Move to inbox
```

---

## 14. Response & Remediation Playbooks

### 14.1 Phishing Email — Response Playbook

```
┌─────────────────────────────────────────────────────────┐
│           PHISHING EMAIL RESPONSE PLAYBOOK               │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  PHASE 1: CONTAIN (0-15 minutes)                       │
│  ├─ Block sender domain/address at SEG                  │
│  ├─ Block malicious URLs at proxy/firewall              │
│  ├─ Block file hash at endpoint (EDR)                   │
│  ├─ Purge email from all mailboxes (ZAP/TRAP/purge)    │
│  └─ Quarantine affected endpoints (if malware executed) │
│                                                         │
│  PHASE 2: ASSESS IMPACT (15-60 minutes)                │
│  ├─ Identify all recipients                             │
│  ├─ Determine who opened/clicked/downloaded             │
│  ├─ Check endpoint telemetry for execution              │
│  ├─ Check authentication logs for credential use        │
│  └─ Assess data exposure risk                           │
│                                                         │
│  PHASE 3: REMEDIATE (1-4 hours)                        │
│  ├─ Reset passwords for compromised users               │
│  ├─ Revoke active sessions (Azure AD/Okta)             │
│  ├─ Re-enroll MFA if MFA was bypassed                  │
│  ├─ Remove malware from affected endpoints              │
│  ├─ Remove malicious inbox rules                        │
│  └─ Restore any modified files/settings                 │
│                                                         │
│  PHASE 4: COMMUNICATE (ongoing)                        │
│  ├─ Notify affected users                               │
│  ├─ Send org-wide awareness alert (if widespread)      │
│  ├─ Notify management/CISO (if significant impact)     │
│  └─ Report to external authorities if required          │
│                                                         │
│  PHASE 5: LEARN (post-incident)                        │
│  ├─ Update detection rules to catch similar emails      │
│  ├─ Add IOCs to blocklists and threat intel feeds      │
│  ├─ Conduct targeted phishing awareness training        │
│  ├─ Document lessons learned                            │
│  └─ Update playbook based on findings                   │
└─────────────────────────────────────────────────────────┘
```

### 14.2 BEC — Response Playbook

```
PHASE 1: IMMEDIATE (0-30 minutes)
├─ Contact the impersonated person via out-of-band channel
├─ If financial transaction initiated → IMMEDIATELY contact bank
├─ Block the attacker's email address
├─ Quarantine all related emails
└─ Preserve evidence (full email with headers)

PHASE 2: INVESTIGATE (30 min - 2 hours)
├─ Determine if impersonated person's account is compromised
├─ Review sign-in logs for the impersonated account
├─ Check for inbox rules/forwarding on impersonated account
├─ Analyze email headers for origin
├─ Check for domain lookalike registration
└─ Identify all recipients and check for responses

PHASE 3: REMEDIATE
├─ If account compromised: Reset password, revoke sessions, re-enroll MFA
├─ Remove any unauthorized inbox rules
├─ If wire transfer sent: Work with legal and banking to recall
├─ Block the lookalike domain at DNS/proxy level
└─ Report the lookalike domain (registrar abuse, takedown request)

PHASE 4: PREVENT
├─ Implement/strengthen DMARC to p=reject
├─ Enable external email banner/warning
├─ Configure impersonation protection in email security
├─ Require dual approval for financial transactions
└─ Conduct BEC-specific awareness training for finance team
```

### 14.3 Account Compromise — Response Playbook

```
PHASE 1: CONTAIN (0-15 minutes)
├─ Reset user password immediately
├─ Revoke all active sessions and refresh tokens
├─ Disable account temporarily (if active attack)
├─ Block the attacker's IP at firewall/proxy
└─ Enable enhanced monitoring on the account

PHASE 2: INVESTIGATE (15 min - 2 hours)
├─ Review sign-in logs (Impossible travel? New devices? TOR/VPN?)
├─ Audit inbox rules (forwarding, auto-delete, move rules)
├─ Review sent items (internal phishing from this account?)
├─ Check OAuth app consents (malicious apps added?)
├─ Review mailbox delegation changes
├─ Check for eDiscovery searches or mail export
├─ Review admin role assignments (privilege escalation?)
└─ Timeline the compromise (first attacker action → last)

PHASE 3: REMEDIATE
├─ Remove all malicious inbox rules
├─ Revoke malicious OAuth app consents
├─ Remove unauthorized mailbox delegates
├─ Re-enroll MFA (new device, new method)
├─ Notify all recipients of phishing sent from this account
├─ If data was exfiltrated: Engage legal/compliance
└─ Restore mailbox to pre-compromise state if needed

PHASE 4: MONITOR
├─ Enable enhanced sign-in monitoring for 30 days
├─ Review for any additional compromised accounts
├─ Monitor for credential reuse on other platforms
└─ Check dark web for leaked credentials
```

---

## 15. Email Security Metrics for SOC

| Metric | Description | Target |
|--------|-------------|--------|
| **Mean Time to Detect (MTTD)** | Time from email delivery to alert | < 5 minutes |
| **Mean Time to Respond (MTTR)** | Time from alert to containment | < 30 minutes |
| **Phishing Report Rate** | % of users who report phishing | > 20% |
| **Click Rate** | % of users who click phishing links | < 5% |
| **False Positive Rate** | % of alerts that are FP | < 15% |
| **Email Purge Time** | Time to remove threat from all mailboxes | < 15 minutes |
| **Detection Coverage** | % of phishing caught by automation | > 95% |
| **User Report vs Auto-Detection** | Ratio of user reports to auto-caught | Track trend |
| **Repeat Clicker Rate** | Users who click phishing more than once | < 2% |
| **DMARC Adoption** | % of org domains with DMARC p=reject | 100% goal |

---

## 16. Quick Reference — Common Investigation Commands

### PowerShell (Exchange Online / M365)

```powershell
# Connect to Exchange Online
Connect-ExchangeOnline -UserPrincipalName admin@company.com

# Search for specific email by Message-ID
Get-MessageTrace -MessageId "<message-id@domain.com>" -StartDate (Get-Date).AddDays(-10) -EndDate (Get-Date)

# Search by sender
Get-MessageTrace -SenderAddress "attacker@domain.com" -StartDate (Get-Date).AddDays(-7) -EndDate (Get-Date)

# Check inbox rules for a user
Get-InboxRule -Mailbox "user@company.com" | Format-List Name, Description, Enabled, ForwardTo, RedirectTo, DeleteMessage

# Remove malicious inbox rule
Remove-InboxRule -Mailbox "user@company.com" -Identity "Rule Name" -Confirm:$false

# Purge emails from mailboxes (Compliance Search)
New-ComplianceSearch -Name "Phishing Purge" -ExchangeLocation All -ContentMatchQuery 'subject:"malicious subject" AND received:2026-04-08'
Start-ComplianceSearch -Identity "Phishing Purge"
New-ComplianceSearchAction -SearchName "Phishing Purge" -Purge -PurgeType SoftDelete

# Check mail forwarding rules
Get-Mailbox -Identity "user@company.com" | Select ForwardingAddress, ForwardingSmtpAddress, DeliverToMailboxAndForward

# Get mailbox audit log
Search-UnifiedAuditLog -StartDate (Get-Date).AddDays(-7) -EndDate (Get-Date) -UserIds "user@company.com" -Operations "New-InboxRule","Set-InboxRule","UpdateInboxRules"
```

### Linux CLI Tools

```bash
# Calculate file hash
sha256sum suspicious_file.docm
md5sum suspicious_file.docm

# Extract strings from attachment
strings suspicious_file.exe | grep -i "http\|powershell\|cmd\|invoke"

# Analyze Office document macros
olevba suspicious.docm
oleid suspicious.docm

# Check domain DNS records
dig TXT _dmarc.domain.com
dig TXT domain.com    # SPF record
dig MX domain.com

# WHOIS lookup
whois suspicious-domain.com

# Decode Base64 content
echo "base64string" | base64 -d
```

---

*Continued in Part 4 → Real-World Scenarios, Interview Q&A, and Quick Reference Card*


---

