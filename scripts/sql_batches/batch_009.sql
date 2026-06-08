-- Batch 9: 10 notes
BEGIN;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Email_Security_SOC_Guide_Part1$VELSEC$, $VELSEC$Email Security Soc Guide Part1$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['SOC']::TEXT[], $VELSEC$# 📧 Comprehensive Email Security Guide — SOC Analyst L2 Investigation

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

*Continued in Part 2 → Alert Triage, Investigation Workflow, TP vs FP Framework*$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Email_Security_SOC_Guide_Part2$VELSEC$, $VELSEC$Email Security Soc Guide Part2$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['SOC']::TEXT[], $VELSEC$# 📧 Email Security SOC Guide — Part 2: Alert Triage, TP vs FP Framework

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

*Continued in Part 3 → Advanced Analysis: Headers, URLs, Attachments, IOC Extraction, Playbooks*$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Email_Security_SOC_Guide_Part3$VELSEC$, $VELSEC$Email Security Soc Guide Part3$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['SOC']::TEXT[], $VELSEC$# 📧 Email Security SOC Guide — Part 3: Advanced Analysis & IOC Extraction

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

*Continued in Part 4 → Real-World Scenarios, Interview Q&A, and Quick Reference Card*$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$INDEX$VELSEC$, $VELSEC$Index$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['SOC']::TEXT[], $VELSEC$﻿# SOC

Index of files in this directory:

- [Comprehensive_SOC_Interview_Guide.md](./Comprehensive_SOC_Interview_Guide.md)
- [Cisco_SOC_Part1_Core_SOC_IR.md](./Cisco_SOC_Prep/Cisco_SOC_Part1_Core_SOC_IR.md)
- [Cisco_SOC_Part2_ThreatIntel_MITRE_Hunting.md](./Cisco_SOC_Prep/Cisco_SOC_Part2_ThreatIntel_MITRE_Hunting.md)
- [Cisco_SOC_Part3_Network_Endpoint_Tools.md](./Cisco_SOC_Prep/Cisco_SOC_Part3_Network_Endpoint_Tools.md)
- [Cisco_SOC_Part4_Scenarios_Behavioral.md](./Cisco_SOC_Prep/Cisco_SOC_Part4_Scenarios_Behavioral.md)
- [Email_Security_SOC_Guide_Part1.md](./SOC_Threat_Investigation/Email_Security_SOC_Guide_Part1.md)
- [Email_Security_SOC_Guide_Part2.md](./SOC_Threat_Investigation/Email_Security_SOC_Guide_Part2.md)
- [Email_Security_SOC_Guide_Part3.md](./SOC_Threat_Investigation/Email_Security_SOC_Guide_Part3.md)
- [Reactive_SOC_Investigation_Guide_Part1.md](./SOC_Threat_Investigation/Reactive_SOC_Investigation_Guide_Part1.md)
- [Reactive_SOC_Investigation_Guide_Part2.md](./SOC_Threat_Investigation/Reactive_SOC_Investigation_Guide_Part2.md)
- [Security Operations Centre (SOC) Concepts.pdf](./SOC_Threat_Investigation/Security%20Operations%20Centre%20(SOC)%20Concepts.pdf)
- [SOC_Concepts_Interview_Guide.md](./SOC_Threat_Investigation/SOC_Concepts_Interview_Guide.md)
- [SOC_TP_FP_Checklist.md](./SOC_Threat_Investigation/SOC_TP_FP_Checklist.md)
- [Threat_Hunting_SOC_Guide_Part1.md](./SOC_Threat_Investigation/Threat_Hunting_SOC_Guide_Part1.md)
- [Threat_Hunting_SOC_Guide_Part2.md](./SOC_Threat_Investigation/Threat_Hunting_SOC_Guide_Part2.md)
- [Threat_Hunting_SOC_Guide_Part3.md](./SOC_Threat_Investigation/Threat_Hunting_SOC_Guide_Part3.md)
- [Threat_Hunting_SOC_Guide_Part4.md](./SOC_Threat_Investigation/Threat_Hunting_SOC_Guide_Part4.md)$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Reactive_SOC_Investigation_Guide_Comprehensive$VELSEC$, $VELSEC$Reactive Soc Investigation Guide Comprehensive$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['SOC']::TEXT[], $VELSEC$# 🔍 Reactive SOC Investigation Guide — Part 1: Deep-Dive TP Determination Framework

---

# PART 1: ALERT INVESTIGATION METHODOLOGY & ENDPOINT/MALWARE DEEP DIVES

---

## 1. Reactive Investigation — Core Philosophy

### 1.1 What Makes This Guide Different?

| Proactive (Threat Hunting) | Reactive (This Guide) |
|---------------------------|----------------------|
| You go looking for threats | Alert comes TO you |
| Hypothesis-driven | Alert-driven |
| "What might be hiding?" | "Is THIS alert real?" |
| Broad scope | Focused on specific alert |
| Schedule-based | Real-time / SLA-driven |
| Output: new detections | Output: TP/FP verdict + response |

### 1.2 The TP Determination Mindset

```
┌───────────────────────────────────────────────────────────────────────┐
│              THE ANALYST'S INVESTIGATION MINDSET                      │
├───────────────────────────────────────────────────────────────────────┤
│                                                                       │
│  ❌ WRONG MINDSET:                                                   │
│     "This alert fired, it must be real. Let me confirm it."          │
│     "This looks like a false positive, let me close it quickly."     │
│                                                                       │
│  ✅ CORRECT MINDSET:                                                 │
│     "I have a SECURITY EVENT. I don't know if it's malicious yet."   │
│     "I will gather evidence, analyze context, and form a judgment."  │
│     "I will prove or disprove malicious intent with DATA."           │
│                                                                       │
│  KEY PRINCIPLES:                                                      │
│  1. Never assume TP or FP until you have EVIDENCE                    │
│  2. Context is everything — same activity can be TP or FP            │
│  3. Ask "WHY would this happen legitimately?"                        │
│  4. Ask "WHY would an attacker do this?"                             │
│  5. Correlate: One indicator is suspicious, three is a pattern       │
│  6. Document EVERYTHING — your notes are evidence                    │
│  7. When in doubt, ESCALATE — never close unsure as FP              │
│                                                                       │
└───────────────────────────────────────────────────────────────────────┘
```

---

## 2. Universal Deep-Dive Investigation Framework

### 2.1 The 7-Layer Investigation Model

Every alert, regardless of type, should be investigated using this layered approach:

```
┌────────────────────────────────────────────────────────────────────────┐
│              7-LAYER DEEP INVESTIGATION MODEL                          │
├────────────────────────────────────────────────────────────────────────┤
│                                                                        │
│  LAYER 1: ALERT CONTEXT  (What triggered this?)                       │
│  ├─ What rule/signature/detection fired?                               │
│  ├─ What is the rule logic? (understand WHY it triggered)             │
│  ├─ What is the severity and confidence level?                        │
│  ├─ Has this rule produced FPs before? (check tuning history)         │
│  └─ Is this part of a known alert storm or rule issue?                │
│                                                                        │
│  LAYER 2: ACTOR CONTEXT  (Who did this?)                              │
│  ├─ What user account was involved?                                   │
│  ├─ What is their role? (IT admin vs. HR vs. executive)               │
│  ├─ Is this normal behavior for this user?                            │
│  ├─ Have they been involved in prior alerts?                          │
│  ├─ Is the account a service account, shared, or personal?           │
│  └─ Has the account shown signs of compromise? (impossible travel)   │
│                                                                        │
│  LAYER 3: ASSET CONTEXT  (Where did this happen?)                     │
│  ├─ What system/endpoint is involved?                                 │
│  ├─ Is it a workstation, server, DC, or cloud resource?              │
│  ├─ What is its criticality? (crown jewel, standard, DMZ)            │
│  ├─ What software/services run on this asset?                        │
│  ├─ Is this asset part of an admin tier?                              │
│  └─ Has this asset been involved in prior incidents?                  │
│                                                                        │
│  LAYER 4: TEMPORAL CONTEXT  (When did this happen?)                   │
│  ├─ What time did the event occur? (business hours vs. off-hours)    │
│  ├─ Was there a change window or maintenance scheduled?              │
│  ├─ Does this correlate with user's normal work schedule?            │
│  ├─ Did similar events occur before/after? (pattern?)                │
│  └─ Does the timing match known threat campaign patterns?             │
│                                                                        │
│  LAYER 5: TECHNICAL ANALYSIS  (What exactly happened?)               │
│  ├─ Full process chain analysis (parent → child tree)                │
│  ├─ Command line argument analysis                                    │
│  ├─ Network connection analysis (src, dst, port, protocol)           │
│  ├─ File analysis (hash, origin, behavior in sandbox)                │
│  ├─ Authentication analysis (how did they get access?)               │
│  └─ Correlation with other log sources                                │
│                                                                        │
│  LAYER 6: THREAT INTELLIGENCE  (Is this known bad?)                  │
│  ├─ Check IOCs against threat intel (VirusTotal, OTX, MISP)         │
│  ├─ Check IP/domain reputation (AbuseIPDB, Shodan, Talos)           │
│  ├─ Match file hash against known malware databases                  │
│  ├─ Check MITRE ATT&CK for technique identification                 │
│  └─ Check recent threat reports for matching TTPs                     │
│                                                                        │
│  LAYER 7: IMPACT ASSESSMENT  (How bad is this?)                      │
│  ├─ What data/systems are at risk?                                   │
│  ├─ Has the attacker achieved their objective?                       │
│  ├─ What is the blast radius? (affected scope)                       │
│  ├─ Is containment needed immediately?                                │
│  └─ What is the business and regulatory impact?                       │
│                                                                        │
└────────────────────────────────────────────────────────────────────────┘
```

### 2.2 Evidence Strength Matrix

Not all evidence carries equal weight. Rate your findings:

| Evidence Level | Description | Examples | TP Likelihood |
|---------------|-------------|---------|---------------|
| 🔴 **Definitive** | Irrefutable proof of malicious activity | Known malware hash, confirmed C2 traffic, ransom note | 99%+ |
| 🟠 **Strong** | Multiple correlated indicators pointing to malicious | Encoded PowerShell + C2 beaconing + new persistence | 85-99% |
| 🟡 **Moderate** | Suspicious but could have legitimate explanation | LOLBin execution, unusual logon hours, new scheduled task | 50-85% |
| 🟢 **Weak** | Single anomaly with many legitimate explanations | Single failed login, large file download, new software install | 10-50% |
| ⚪ **Informational** | Normal variation or known-benign activity | IT admin running admin tools, scheduled backup job | <10% |

### 2.3 Correlation Multiplier — The Power of Combined Evidence

```
Single anomaly     = Suspicious (investigate further)
Two correlated     = Concerning (deep dive required)
Three correlated   = Probable TP (begin containment planning)
Four+ correlated   = Confirmed TP (contain immediately + investigate)

Example:  
  1. PowerShell -Enc execution               → 🟡 Moderate alone
  2. + From a non-IT user workstation         → 🟠 Now Strong
  3. + Beacon-like outbound connections       → 🔴 Near Definitive
  4. + Followed by LSASS access              → 🔴 CONFIRMED TP — CONTAIN NOW
```

---

## 3. Deep-Dive: Endpoint Alert Investigation

### 3.1 Suspicious Process Execution Alert

**Alert Example:** "Suspicious process execution detected — powershell.exe with encoded command on WKST-FIN-042"

#### Step-by-Step Deep Dive:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 1: DECODE THE COMMAND (2 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Extract the -Enc (Base64) value from the alert
□ Decode it: [System.Text.Encoding]::Unicode.GetString(
    [System.Convert]::FromBase64String('<encoded_string>'))
□ Read the decoded command — what does it DO?

  IF decoded contains:
    → IEX / Invoke-Expression + Download    = 🔴 Download cradle
    → Net.WebClient / Invoke-WebRequest     = 🔴 Downloading payload
    → -WindowStyle Hidden / -W Hidden       = 🔴 Hiding from user
    → Start-Process with remote binary      = 🔴 Executing downloaded file
    → AMSI bypass strings                   = 🔴 Evading detection
    → Get-Process / Get-Service             = 🟡 Could be recon or admin
    → Set-ExecutionPolicy Bypass            = 🟠 Enabling script execution

  IF decoded contains:
    → Known IT automation scripts           = 🟢 Likely FP
    → SCCM / Intune / GPO script patterns  = 🟢 Likely management tool
    → Software installation commands        = 🟡 Verify with IT

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 2: ANALYZE PROCESS TREE (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ What is the PARENT process of powershell.exe?

  SUSPICIOUS PARENTS (🔴):
    → WINWORD.EXE / EXCEL.EXE / OUTLOOK.EXE  (macro execution)
    → wscript.exe / cscript.exe               (script launched PS)
    → mshta.exe                                (HTA launched PS)
    → WmiPrvSE.exe                             (WMI remote execution)
    → services.exe                             (service-based execution)
    → cmd.exe with /c or /k                    (chained execution)
    → rundll32.exe                             (DLL-based launch)

  NORMAL PARENTS (🟢):
    → explorer.exe    (user manually opened PowerShell)
    → svchost.exe     (system service — check which service)
    → sccm/intune     (management tool — verify deployment)
    → scheduled task   (verify task is legitimate)

□ What CHILD processes did PowerShell spawn?

  SUSPICIOUS CHILDREN (🔴):
    → cmd.exe, certutil.exe, bitsadmin.exe     (tool download/exec)
    → net.exe, nltest.exe, whoami.exe           (discovery)
    → reg.exe (add Run key)                     (persistence)
    → schtasks.exe                              (persistence)
    → mshta.exe, rundll32.exe                   (further execution)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 3: CHECK NETWORK CONNECTIONS (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Did the PowerShell process make outbound connections?
   → Sysmon Event 3 / EDR network telemetry / Firewall logs

□ Where did it connect to?
   → External IP?  Check: VirusTotal, AbuseIPDB, Shodan
   → External domain?  Check: WHOIS (age, registrar), URLScan.io
   → Internal IP?  Could be lateral movement

□ What was downloaded?
   → Check proxy logs for the URL
   → What content type was returned?
   → Was it a script (.ps1), binary (.exe), or DLL?

□ Was there beaconing behavior after initial connection?
   → Regular interval connections = C2

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 4: CHECK USER AND ASSET CONTEXT (3 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Who is the user on WKST-FIN-042?
   → Finance user running encoded PowerShell = 🔴 (not their job)
   → IT admin on their assigned workstation = 🟡 (possible but verify)

□ Is this workstation known for IT activity?
   → Standard user workstation running admin tools = 🔴
   → IT admin jump box = 🟡 (still verify the specific command)

□ Check user's alert history:
   → First-time alert = could be fresh compromise
   → Repeat alerts = either persistent issue or ongoing attack

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 5: MAKE VERDICT (2 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Score your findings:

  CONFIRM TP IF:
  ✓ Decoded command = download cradle / C2 beacon / credential theft
  ✓ Parent process = Office app, script engine, or unexpected parent
  ✓ Network connection to known-bad or newly registered domain
  ✓ User has no legitimate reason for this activity
  ✓ Post-execution: persistence / discovery / credential access seen

  CONFIRM FP IF:
  ✓ Decoded command = known IT automation script  
  ✓ Parent process = SCCM, Intune, GPO, or IT tool
  ✓ Network connection to internal management server
  ✓ User is IT admin performing documented task
  ✓ Activity matches known change window
  ✓ Same alert fires on many machines = deployment push

  ESCALATE IF UNSURE:
  ✓ Command is obfuscated beyond your analysis capability
  ✓ Conflicting signals (admin user but suspicious command)
  ✓ New technique you haven't seen before
```

---

### 3.2 Suspicious File/Malware Detection Alert

**Alert Example:** "Malicious file detected — `update_client.exe` with high-risk score on SVR-APP-019"

#### Step-by-Step Deep Dive:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 1: FILE STATIC ANALYSIS (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Collect file metadata:
   → Full file path:  C:\ProgramData\update_client.exe
   → File size:       [note size — tiny or huge is suspicious]
   → Creation time:   [when was it dropped?]
   → Modified time:   [matches creation? or timestomped?]
   → File hash:       SHA256 = [calculate]

□ Check hash on VirusTotal:
   → 0 detections = unknown (not necessarily clean — could be new)
   → 1-5 detections = possibly suspicious (check which AVs detected)
   → 10+ detections = likely malicious → 🔴
   → 30+ detections = confirmed malware → 🔴 DEFINITIVE

□ Check code signing:
   → Unsigned executable in ProgramData → 🔴 SUSPICIOUS
   → Signed by Microsoft/known vendor → 🟢 (but verify hash)
   → Signed by unknown/expired cert → 🟠 INVESTIGATE
   → Self-signed certificate → 🔴 SUSPICIOUS

□ Check file naming:
   → Does name mimic legitimate software? (update_client, svchost)
   → Double extension? (report.pdf.exe) → 🔴
   → Random characters? (a3f8x9.exe) → 🔴
   → Matches legitimate software exactly? Verify path is correct

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 2: FILE ORIGIN — HOW DID IT GET THERE? (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Check Sysmon Event 11 (File Create):
   → What process CREATED this file?

  SUSPICIOUS ORIGINS (🔴):
   → powershell.exe    (downloaded via script)
   → cmd.exe           (downloaded via certutil/bitsadmin)
   → outlook.exe       (email attachment saved)
   → browser process   (downloaded from web)
   → wmiprvse.exe      (WMI remote file drop)
   → services.exe      (service-based file creation)

  NORMAL ORIGINS (🟢):
   → msiexec.exe       (software installer — verify legitimacy)
   → setup.exe         (installation — verify source)
   → sccm/intune agent (management deployment)
   → windows update    (legitimate update)

□ Check browser download history / proxy logs:
   → What URL was the file downloaded from?
   → Was the domain legitimate or suspicious?

□ Check email logs:
   → Was this file attached to an email?
   → Was the email from a known sender?

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 3: FILE EXECUTION ANALYSIS (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Did the file EXECUTE? (Critical question)
   → Sysmon Event 1: was update_client.exe started as a process?
   → If NOT executed: lower risk (file was only dropped, not run)
   → If EXECUTED: high risk → full investigation required

□ If executed, what did it DO?
   → Child processes spawned?
   → Network connections made? (Sysmon Event 3)
   → Files created/modified? (Sysmon Event 11)
   → Registry changes? (Sysmon Event 13)
   → LSASS accessed? (Sysmon Event 10)

□ Sandbox analysis (if available):
   → Submit file hash to Any.Run, Hybrid Analysis, Joe Sandbox
   → Review behavioral report:
     - Does it establish persistence?
     - Does it connect to C2?
     - Does it access credentials?
     - Does it perform discovery?
     - Does it encrypt files?

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 4: SCOPE AND SPREAD (3 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Is this file on other endpoints?
   → EDR: search for same file hash across environment
   → How many hosts have this file? 1 = targeted, 100 = campaign

□ Is this part of a known malware family?
   → VirusTotal: check "Community" and "Relations" tabs
   → Check if linked to known APT group or ransomware strain

□ Are other IOCs from sandbox analysis present in environment?
   → Search for C2 domains/IPs in DNS and proxy logs
   → Search for related file hashes on other endpoints

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 5: VERDICT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  CONFIRM TP IF:
  ✓ VT detections > 5 from reputable engines
  ✓ File dropped by suspicious process (PS, cmd, browser)
  ✓ File is unsigned or signed with suspicious cert
  ✓ File executed and made C2 connections
  ✓ Sandbox confirms malicious behavior

  CONFIRM FP IF:
  ✓ VT detections = 0 with high submission count (well-known clean)
  ✓ File is from legitimate software installation
  ✓ Signed by verified vendor with valid certificate
  ✓ File path matches expected software location
  ✓ IT confirms planned deployment
  ✓ AV triggered on heuristic with no behavioral confirmation
```

---

## 4. Deep-Dive: Authentication & Identity Alert Investigation

### 4.1 Impossible Travel / Anomalous Login Alert

**Alert Example:** "Impossible travel detected — user john.doe logged in from New York and Lagos, Nigeria within 30 minutes"

#### Step-by-Step Deep Dive:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 1: VERIFY THE GEOGRAPHIC DATA (3 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Pull both login events:
   Login 1: Time, IP, Geo, Device, App, Status, MFA result
   Login 2: Time, IP, Geo, Device, App, Status, MFA result

□ Verify geo accuracy:
   → Not all IP-to-geo is accurate (CDN, mobile data can shift)
   → Check if either IP is a known VPN provider
   → Check if either IP belongs to your corporate infrastructure
   → Some ISPs geolocate inaccurately

□ Calculate travel feasibility:
   → Time difference between logins
   → Distance between locations
   → Is it physically possible? (NYC to London in 30 min = impossible)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 2: ANALYZE EACH LOGIN SESSION (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ FOR EACH LOGIN — Check:
   → Device fingerprint: known device name? Registered device?
   → Browser/User-Agent: matches user's normal browser?
   → App accessed: O365? VPN? Business app?
   → MFA status: MFA passed? MFA challenged but not completed?
   → Login result: Success or failure?

□ Red flags on the suspicious login:
   → Unknown device / unregistered device → 🔴
   → Linux User-Agent when user uses Windows → 🔴
   → No MFA challenge (token replay?) → 🔴
   → MFA completed via push (MFA fatigue?) → 🟠
   → Accessing email immediately after login → 🟠

□ Check if the user has VPN/proxy configured:
   → Personal VPN can cause false "impossible travel"
   → Corporate split-tunnel VPN can cause dual-location
   → Mobile hotspot handoff can cause location jump

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 3: POST-LOGIN BEHAVIOR ANALYSIS (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ What happened AFTER the suspicious login?
   This is the MOST IMPORTANT step — behavior reveals intent.

  MALICIOUS POST-LOGIN (🔴 Confirm TP):
   → Inbox rules created (forwarding to external)
   → Mass email download / mailbox search
   → Password change attempted
   → MFA method changed or added
   → OAuth app consent granted
   → SharePoint/OneDrive mass download  
   → Sent phishing emails from the account
   → Accessed other users' mailboxes
   → Added to privileged groups

  NORMAL POST-LOGIN (🟢 Likely FP):
   → Normal email reading pattern
   → No configuration changes
   → Activity matches user's typical behavior
   → Same applications accessed as usual
   → Session duration matches normal patterns

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 4: OUT-OF-BAND VERIFICATION (3 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Contact the user via PHONE (not email — email may be compromised)
   → "Did you log in from [location] at [time]?"
   → "Are you using a VPN or proxy?"
   → "Did you share your credentials with anyone?"
   → "Did you receive an unusual MFA prompt?"

□ If user confirms: NOT ME
   → CONFIRMED TP → Account compromised → Immediate response

□ If user confirms: Yes, that was me (VPN, travel, etc.)
   → CONFIRMED FP → Document and close
   → Consider tuning alert for this user's VPN if recurring

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 5: RESPOND IF TP CONFIRMED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Revoke all active sessions immediately
□ Reset password
□ Reset MFA (re-register clean device)
□ Remove any malicious inbox rules
□ Revoke any OAuth app consents granted
□ Revert any password/MFA changes by attacker
□ Check for data exfiltration (DLP, download logs)
□ Notify the user about the compromise
□ Check if credentials were in known breach database
□ Search for same attacker IP across all user accounts
```

### 4.2 Brute Force / Password Spray Alert

**Alert Example:** "Account lockout detected — 50 failed logins for user jane.smith from IP 203.x.x.x in 5 minutes"

#### Step-by-Step Deep Dive:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 1: CLASSIFY THE ATTACK TYPE (2 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Check the PATTERN of failures:
   → 1 account, many passwords = BRUTE FORCE
   → Many accounts, 1-2 passwords = PASSWORD SPRAY
   → Many accounts, many passwords = CREDENTIAL STUFFING
   → 1 account, constant attempts = automated script or misconfiguration

□ Check the failure reason code:
   → 0xC000006A = Wrong password (attack in progress)
   → 0xC0000234 = Account locked (lockout triggered)
   → 0xC0000072 = Account disabled
   → 0xC000006D = Bad username (account enumeration)
   → 0xC0000064 = Username does not exist (enumeration)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 2: ANALYZE THE SOURCE (3 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Where is 203.x.x.x?
   → Geolocation: what country?
   → Reputation: AbuseIPDB, VirusTotal, Shodan
   → Is it a known VPN/TOR node?
   → Is it a cloud provider IP (AWS, Azure, GCP)?
   → Does it belong to your organization?

□ What protocol/service was targeted?
   → RDP (3389) → 🔴 Direct remote access attempt
   → OWA/O365 → 🔴 Email access attempt
   → VPN → 🔴 Network access attempt
   → SSH (22) → 🔴 Linux/network device access
   → SMB (445) → 🔴 Internal network attack
   → Web app login → 🟠 Application-specific

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 3: CHECK FOR SUCCESS (5 minutes — CRITICAL)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ After the failures, was there a SUCCESSFUL login?
   → 4625 (fail) × 50 → 4624 (success) = 🔴 CREDENTIAL COMPROMISED
   → 4625 (fail) × 50 → no success = Attack failed (but still a TP for attack)

□ If successful login occurred:
   → Was it from the SAME source IP? = attacker guessed correctly
   → Was it from a DIFFERENT IP shortly after? = attacker using creds elsewhere
   → What did the attacker do after logging in?
     Check all post-login activity (see Section 4.1 Step 3)

□ Check OTHER accounts from same source IP:
   → Did the same IP target multiple accounts? (spray indicator)
   → Were any OTHER accounts successfully compromised?
   → Search: all 4625 events WHERE source_IP = 203.x.x.x

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 4: VERDICT AND RESPONSE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  TP — Attack WITH Compromise:
  □ Failures followed by success from attacker IP
  □ Reset compromised account passwords
  □ Revoke sessions and enforce MFA
  □ Block attacker IP at perimeter
  □ Check for post-compromise activity
  □ Full account compromise investigation

  TP — Attack WITHOUT Compromise:
  □ 50+ failures from external suspicious IP
  □ Block attacker IP at perimeter  
  □ Verify account lockout policy is enforced
  □ Ensure MFA is enabled on targeted accounts
  □ Monitor for continued attempts from different IPs
  □ Consider adding IP range to blocklist

  FP — Misconfiguration:
  □ Failed logins from internal service account
  □ Password recently changed but cached creds not updated
  □ IT identifies a misconfigured service/script
  □ Fix the misconfiguration and close as FP
```

---

## 5. TP Determination Decision Matrix — Quick Reference

| Alert Type | Strongest TP Indicator | Strongest FP Indicator | Tiebreaker Question |
|------------|----------------------|----------------------|-------------------|
| **Suspicious Process** | Encoded download cradle from Office child process | IT management tool (SCCM/Intune) as parent | "Is this user an admin running an expected script?" |
| **Malware Detection** | VT 10+ detections + process executed + C2 connection | Known software, signed, clean VT, expected path | "What process created this file and why?" |
| **Impossible Travel** | Unknown device + malicious post-login behavior | User confirms VPN/travel + normal post-login | "What happened AFTER the login?" |
| **Brute Force** | Failures → success from same attacker IP | Cached creds / misconfigured service | "Did the attacker get in?" |
| **Privilege Escalation** | Non-admin exploiting UAC + credential dump after | Admin using admin tools on their workstation | "Does this user NEED these privileges for their job?" |
| **Lateral Movement** | PsExec from workstation to multiple servers | SCCM push deployment across managed hosts | "Why is this workstation connecting to server admin shares?" |
| **Data Exfil** | 4GB upload to personal Mega.nz at 2 AM | Cloud backup service syncing to corporate cloud | "Is this in line with the user's job function and timing?" |

---

*Continued in Part 2 → Network Alert Deep Dives, Cloud/SaaS Alert Investigations, Email Alert Investigation, Insider Threat, and Complete SOC Analyst Investigation Checklists*


---

# 🔍 Reactive SOC Investigation Guide — Part 2: Network, Cloud, Email & Insider Threat Deep Dives

---

# PART 2: NETWORK, CLOUD/SAAS, EMAIL ALERT INVESTIGATIONS & MASTER CHECKLISTS

---

## 6. Deep-Dive: Network Alert Investigation

### 6.1 C2 / Beaconing Alert

**Alert Example:** "Potential C2 beaconing — host WKST-HR-017 connecting to `cdn-update[.]xyz` every 60-65 seconds for 6 hours"

#### Step-by-Step Deep Dive:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 1: VALIDATE THE BEACONING PATTERN (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Pull proxy/firewall connection logs for the host + domain
□ Plot the connection intervals on a timeline
□ Calculate standard deviation of intervals:
   → Low jitter (±2-5 sec) = automated C2 beacon → 🔴
   → High jitter (±30+ sec) = possibly legitimate polling
   → Exact same interval = scripted / cron job (check if legit)

□ Check data sizes per connection:
   → Small POST (check-in) → larger GET (commands) = C2 pattern → 🔴
   → Consistent small sizes = heartbeat/monitoring
   → Large downloads only = could be CDN/update service

□ Check connection duration:
   → 6+ hours continuous = persistent implant → 🔴
   → Brief burst then stops = might be legitimate retry loop

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 2: INVESTIGATE THE DOMAIN/IP (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ WHOIS lookup on cdn-update[.]xyz:
   → Domain age < 30 days → 🔴 HIGH RISK
   → Privacy-protected registrant → 🟠
   → Registrar known for abuse (cheap bulk registration) → 🔴

□ VirusTotal domain report:
   → Any AV vendors flag as malicious?
   → What files have communicated with this domain?
   → What subdomains exist?

□ URLScan.io:
   → What content is served? (empty page, fake site, parking page)
   → What technologies are running?

□ Passive DNS (SecurityTrails, RiskIQ):
   → What IPs has this domain resolved to historically?
   → Are those IPs associated with other malicious domains?
   → IP hosted on VPS (DigitalOcean, Linode, Vultr) → 🟠

□ Shodan / Censys on the IP:
   → What services are running? (Cobalt Strike default profile?)
   → Open ports matching C2 frameworks?
   → TLS certificate: self-signed? Default Cobalt Strike cert?

□ JA3/JA3S fingerprint (if available):
   → Match against known C2 framework JA3 hashes
   → Cobalt Strike, Metasploit, Sliver all have known JA3s

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 3: ENDPOINT INVESTIGATION (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ What process is making the connections?
   → EDR / Sysmon Event 3: SourceImage for network connections
   → Legitimate process? (chrome.exe, outlook.exe) or unusual?
   → If legitimate name (svchost.exe): verify path and hash
   → If unknown binary: file analysis (hash, signing, origin)

□ Check for process injection:
   → Is a legitimate process (explorer.exe) making unusual connections?
   → Sysmon Event 8: CreateRemoteThread into that process?
   → Memory-only implant? (no file on disk)

□ Check what ELSE happened on this endpoint:
   → Any discovery commands (whoami, net user)?
   → Any credential access (LSASS)?
   → Any persistence installed?
   → Any lateral movement from this host?

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 4: VERDICT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  CONFIRM TP IF:
  ✓ Regular beacon interval with low jitter
  ✓ Domain is newly registered / known malicious
  ✓ JA3 matches known C2 framework
  ✓ Process making connections is injected or suspicious
  ✓ Post-beacon: discovery/credential access activity observed

  CONFIRM FP IF:
  ✓ Domain belongs to legitimate SaaS (telemetry, monitoring)
  ✓ Software update check pattern (known software, signed)
  ✓ IT confirms: monitoring agent heartbeat
  ✓ Domain age > 2 years with clean reputation
  ✓ Process is verified legitimate with correct hash/path
```

---

### 6.2 Suspicious DNS Activity Alert

**Alert Example:** "DNS anomaly — host SRV-DB-003 querying 400+ unique subdomains of `data-sync[.]top` with long encoded labels"

#### Step-by-Step Deep Dive:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 1: CLASSIFY THE DNS ANOMALY (3 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Pull DNS query logs for this host + domain:
   → Query types: A, AAAA, TXT, NULL, CNAME, MX?
   → TXT or NULL queries = 🔴 (commonly used for DNS tunneling)
   → Subdomain label length > 50 chars = 🔴 (data encoded in query)

□ Classify the behavior:
   SCENARIO A: DNS TUNNELING (data exfil/C2) → 🔴
     Indicators: Long subdomains, high entropy, TXT records,
     high query rate, encoded data in labels

   SCENARIO B: DGA (Domain Generation Algorithm) → 🔴
     Indicators: Many NXDOMAIN responses, random-looking domains,
     algorithmic pattern in domain names

   SCENARIO C: Legitimate high DNS volume → 🟢
     Indicators: CDN resolution, load balancing, service mesh,
     known cloud service subdomains

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 2: ANALYZE THE DATA (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Decode subdomain labels:
   → Try Base64 decode → readable data = data exfil → 🔴
   → Try Base32/Hex decode
   → High Shannon entropy (>3.5) = encoded data → 🔴
   → Readable strings = might be legitimate (but unusual)

□ Check query responses:
   → Are TXT responses also long/encoded? = C2 commands → 🔴
   → All NXDOMAIN? = DGA waiting for activation → 🔴
   → Valid A/CNAME responses? = possibly legitimate

□ Calculate data volume:
   → (avg subdomain length × queries) = data exfiltrated
   → 400 queries × 60 chars × ~0.75 bytes = ~18KB (commands/small exfil)
   → Thousands of queries = larger data exfil attempt

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 3: ENDPOINT + NETWORK CORRELATION (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Critical: This is a DATABASE SERVER (SRV-DB-003) → 🔴🔴
   → Data exfil from a DB server is worst-case scenario
   → Check what database is hosted and its sensitivity level

□ What process is generating DNS queries?
   → Expected: database engine (sqlservr.exe) resolving clients
   → Suspicious: powershell.exe, unknown binary, python, dnscat

□ Check for related indicators:
   → File access logs on the DB server
   → Database query logs (unusual bulk SELECT queries?)
   → Any data export operations (BCP, mysqldump)?
   → Network connections beyond DNS?

□ RESPOND IF TP:
   → Sinkhole the domain at DNS resolver
   → Isolate SRV-DB-003 from network
   → Capture the DNS tunneling tool
   → Assess what data was potentially exfiltrated
   → THIS IS A DATA BREACH → notify Legal and CISO
   → Full database audit (what was accessed?)
```

---

## 7. Deep-Dive: Cloud / SaaS Alert Investigation

### 7.1 Suspicious OAuth / App Consent Alert

**Alert Example:** "High-risk OAuth app consent — user mike.johnson granted 'Mail.ReadWrite, Files.ReadWrite.All' to app 'Productivity Helper' from publisher 'Unknown'"

#### Step-by-Step Deep Dive:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 1: ANALYZE THE APP CONSENT (3 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ What permissions were granted?
   → Mail.ReadWrite = read/modify ALL email → 🔴
   → Files.ReadWrite.All = access ALL OneDrive/SharePoint → 🔴
   → User.Read = basic profile only → 🟢 (benign)
   → Directory.ReadWrite.All = modify AD → 🔴 CRITICAL

□ Who is the publisher?
   → "Unknown" or unverified publisher → 🔴
   → Known vendor (Microsoft, Google, Salesforce) → 🟢
   → Publisher name mimics known brand → 🔴 (impersonation)

□ App registration details (Azure AD > Enterprise Apps):
   → When was the app registered?
   → Multi-tenant or single-tenant?
   → How many users in your org have consented?
   → App homepage URL — does it look legitimate?

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 2: INVESTIGATE THE USER (3 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ How did mike.johnson encounter this app?
   → Check email for OAuth consent phishing (common attack vector)
   → Was there a phishing email with "Click to authorize app"?
   → Did user click a link leading to Microsoft consent screen?

□ Check sign-in logs around consent time:
   → Was there an anomalous login before consent?
   → Different IP/location than usual?

□ Check if user was socially engineered:
   → Contact user: "Did you intentionally install Productivity Helper?"
   → If NO / unsure → 🔴 consent phishing attack

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 3: CHECK APP ACTIVITY POST-CONSENT (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Azure AD audit logs → filter by App ID:
   → Has the app read email? How many messages?
   → Has the app accessed OneDrive/SharePoint files?
   → Has the app sent emails on behalf of the user?
   → Has the app modified mailbox rules?

□ If the app DID access data → 🔴 CONFIRMED TP:
   → What data was accessed/exfiltrated?
   → Were emails forwarded externally?
   → Were files downloaded in bulk?

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 4: RESPOND IF TP
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ REVOKE the app consent immediately
   → Azure AD > Enterprise Apps > Permissions > Revoke
□ Remove the app from the tenant
□ Reset the user's password and MFA
□ Revoke all user sessions
□ Audit what data the app accessed
□ Block non-verified app consents via policy:
   → Azure AD > User Settings > App Registrations > "No" for user consent
   → Require admin approval for all app consents
□ Check if other users also consented to this app
□ Report the app to Microsoft (if hosted on Azure AD)
```

### 7.2 Cloud IAM / Privilege Change Alert

**Alert Example:** "User added to Global Administrator role — target: svc_helpdesk@corp.com, added by: admin@corp.com at 11:45 PM"

#### Step-by-Step Deep Dive:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 1: ANALYZE THE CHANGE (2 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ What role was assigned?
   → Global Administrator = highest privilege → 🔴 ALWAYS INVESTIGATE
   → Billing Admin = financial access → 🟠
   → Helpdesk Admin = password reset → 🟡 (for helpdesk user, maybe ok)

□ svc_helpdesk as Global Admin → 🔴🔴
   → Helpdesk service account NEVER needs Global Admin
   → This is either a mistake or malicious privilege escalation

□ Timing: 11:45 PM → outside business hours → 🔴

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 2: VERIFY THE ADMIN (3 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Is admin@corp.com a legitimate Global Admin?
□ Check admin@corp.com's sign-in logs:
   → Where did they log in from at 11:45 PM?
   → Known device? Known IP? Known location?
   → Was MFA completed?
   → Any impossible travel or anomalous access?

□ Contact admin@corp.com out-of-band:
   → "Did you add svc_helpdesk to Global Admin at 11:45 PM?"
   → If YES → ask for justification and change management ticket
   → If NO → admin's account is COMPROMISED → 🔴 CRITICAL

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 3: CHECK POST-ESCALATION ACTIVITY (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ What did svc_helpdesk do WITH Global Admin rights?
   → Create new admin accounts?
   → Modify conditional access policies?
   → Disable MFA for accounts?
   → Access Exchange admin center?
   → Modify mail flow rules (org-wide forwarding)?
   → Create new OAuth apps with admin consent?
   → Access Azure subscriptions or resources?
   → Export data from admin portals?

□ If ANY of the above → 🔴 CONFIRMED TP — ACTIVE COMPROMISE

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 4: RESPOND IF TP
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Remove svc_helpdesk from Global Admin IMMEDIATELY
□ Disable svc_helpdesk account
□ If admin@corp.com was compromised:
   → Reset password and MFA
   → Revoke sessions
   → Audit all actions by admin@corp.com in last 30 days
□ Audit ALL Global Admin role assignments
□ Review all changes made by svc_helpdesk as Global Admin
□ Revert any unauthorized changes (policies, rules, apps)
□ Implement PIM (Privileged Identity Management):
   → Just-in-time admin access
   → Require approval for Global Admin activation
   → Set maximum activation duration
□ Enable alerts for ALL critical role assignments
```

---

## 8. Deep-Dive: Insider Threat Alert Investigation

### 8.1 Data Exfiltration / DLP Alert

**Alert Example:** "DLP policy violation — user sarah.chen downloaded 2,400 files from SharePoint Engineering site in 45 minutes, then uploaded 1.8GB to personal Google Drive"

#### Step-by-Step Deep Dive:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 1: ASSESS THE ACTIVITY (3 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Volume assessment:
   → 2,400 files in 45 min = ~53 files/minute → 🔴 AUTOMATED
   → 1.8 GB to personal cloud → 🔴 DATA LEAVING ORGANIZATION
   → Engineering site = likely intellectual property → 🔴

□ Is sarah.chen authorized to access Engineering SharePoint?
   → YES → access is legitimate, but DATA TRANSFER is not
   → NO → unauthorized access + exfil → DOUBLY SUSPICIOUS

□ Check DLP classification of files:
   → Classified as Confidential/Restricted? → 🔴
   → Source code files? Design documents? → 🔴
   → Public/Internal only? → 🟡 (still a policy violation)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 2: ESTABLISH USER CONTEXT (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ WHO is sarah.chen?
   → Role: Engineer, Manager, Contractor?
   → Department: Engineering (relevant to data accessed?)
   → Employment status: Active? Notice period? PIP?

□ HR INTELLIGENCE (coordinate with HR/Legal):
   → Has sarah.chen submitted resignation? → 🔴🔴
   → Is sarah.chen on a performance improvement plan? → 🔴
   → Is sarah.chen interviewing elsewhere? (if known) → 🔴
   → Any recent disciplinary actions? → 🟠
   → None of the above → 🟡 (but still investigate)

□ Historic behavior:
   → Has sarah.chen downloaded large volumes before?
   → Is bulk download part of their normal work pattern?
   → Prior DLP violations?
   → Check last 30/60/90 days of activity for trending

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 3: ANALYZE THE FULL ACTIVITY CHAIN (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ BEFORE the download:
   → Any searches for specific file types or keywords?
   → SharePoint audit: search queries run by the user?
   → Did they browse systematically through folders?

□ DURING the download:
   → Was OneDrive Sync used? Browser download? API?
   → Sync client = might be accidental mass sync
   → Browser/API download = deliberate selection

□ AFTER the download → TRANSFER:
   → Uploaded to personal Google Drive → 🔴
   → Copied to USB drive? (check endpoint DLP) → 🔴
   → Emailed to personal email? → 🔴
   → Uploaded to other cloud? (Dropbox, WeTransfer) → 🔴
   → Printed large volumes? → 🟠

□ OTHER suspicious behavior:
   → Accessing systems/files they don't normally access?
   → Working at unusual hours?
   → Using personal devices?
   → Clearing browser history or app logs?

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 4: VERDICT AND RESPONSE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  CONFIRM TP — INSIDER THREAT IF:
  ✓ Mass file download + transfer to personal cloud
  ✓ Files contain confidential/IP data
  ✓ User is departing / under performance review
  ✓ Activity is outside normal work patterns
  ✓ Deliberate circumvention of DLP controls

  POSSIBLE FP IF:
  ✓ OneDrive sync misconfiguration (accidental full sync)
  ✓ Legitimate work-from-home needing offline copies
  ✓ IT-approved backup or migration activity
  ✓ User explains valid business reason
  → STILL requires manager + HR + Legal review

  RESPOND:
  □ DO NOT alert the user initially (preserve investigation)
  □ Notify Legal and HR immediately
  □ Preserve ALL evidence (audit logs, DLP logs, email)
  □ Legal decides on approach (interview, monitoring, etc.)
  □ Consider: restrict access to sensitive SharePoint sites
  □ Consider: block personal cloud storage uploads
  □ If confirmed malicious: engage Legal for employment action
  □ If data contained trade secrets: consider legal action
  □ Document for potential litigation hold
```

---

## 9. Master SOC Investigation Checklists

### 9.1 The Universal 5-Minute Triage Checklist

**Use this for EVERY alert to quickly determine if deep investigation is needed:**

```
┌───────────────────────────────────────────────────────────────────────┐
│            5-MINUTE INITIAL TRIAGE CHECKLIST                          │
│           (Complete before deciding to deep-dive)                     │
├───────────────────────────────────────────────────────────────────────┤
│                                                                       │
│  □ 1. READ THE ALERT: What exactly fired and why?                    │
│  □ 2. CHECK THE USER: Who is involved? Role? Privileged?             │
│  □ 3. CHECK THE ASSET: What system? Criticality? Server/Workstation? │
│  □ 4. CHECK THE TIME: Business hours? Change window? Weekend?        │
│  □ 5. CHECK HISTORY: Has this alert fired before? Known FP pattern?  │
│  □ 6. CHECK SEVERITY: Critical/High = deep dive immediately          │
│  □ 7. FIRST INSTINCT: Does this FEEL like a real attack?             │
│                                                                       │
│  DECISION:                                                            │
│  → If 3+ red flags from above → DEEP DIVE (proceed with full invest)│
│  → If appears routine with known FP pattern → Quick verify, then FP  │
│  → If unsure → DEEP DIVE (always err on side of investigation)       │
│                                                                       │
└───────────────────────────────────────────────────────────────────────┘
```

### 9.2 Investigation Documentation Template

```
═══════════════════════════════════════════════════════════
              INVESTIGATION DOCUMENTATION
═══════════════════════════════════════════════════════════

TICKET ID:          INC-YYYY-#####
ANALYST:            [Your Name]
DATE/TIME STARTED:  [Timestamp]
ALERT SOURCE:       [SIEM Rule / EDR Alert / User Report / TI Feed]
ALERT NAME:         [Exact alert name/rule]
SEVERITY:           [Critical / High / Medium / Low]
SLA TARGET:         [Time to respond based on severity]

───────────────────────────────────────────────────────────
AFFECTED ENTITIES
───────────────────────────────────────────────────────────
User(s):    [username, domain, role]
Host(s):    [hostname, IP, OS, criticality]
Service(s): [application, service, cloud resource]

───────────────────────────────────────────────────────────
INVESTIGATION TIMELINE
───────────────────────────────────────────────────────────
[HH:MM] Alert received, initial triage started
[HH:MM] [Action taken — e.g., "Pulled process tree from EDR"]
[HH:MM] [Finding — e.g., "PowerShell decoded to download cradle"]
[HH:MM] [Action taken — e.g., "Checked VirusTotal for domain"]
[HH:MM] [Finding — e.g., "Domain registered 3 days ago"]
[HH:MM] Verdict determined
[HH:MM] Response actions initiated

───────────────────────────────────────────────────────────
EVIDENCE COLLECTED
───────────────────────────────────────────────────────────
□ Process tree screenshot / export
□ SIEM query results (with query text)
□ EDR timeline export
□ IOCs extracted (IPs, domains, hashes)
□ Email headers (if email-related)
□ Sandbox report URL
□ VirusTotal links
□ User confirmation (phone/email)

───────────────────────────────────────────────────────────
VERDICT
───────────────────────────────────────────────────────────
□ TRUE POSITIVE — Confirmed threat, response required
□ BENIGN TRUE POSITIVE — Correct detection, authorized activity
□ FALSE POSITIVE — No threat, rule tuning recommended
□ INCONCLUSIVE — Escalated to [L3 / IR / Threat Intel]

Confidence Level: [High / Medium / Low]
MITRE ATT&CK:     [Tactic] — [Technique ID + Name]
Justification:    [2-3 sentences explaining your verdict]

───────────────────────────────────────────────────────────
RESPONSE ACTIONS TAKEN
───────────────────────────────────────────────────────────
□ Host isolated                    □ Account disabled
□ IOCs blocked (firewall/proxy)    □ Password reset
□ Malware quarantined             □ Sessions revoked
□ Email purged                    □ Rule tuning requested
□ IOCs shared to TI platform      □ Escalated to IR team
□ User notified                   □ No action required

───────────────────────────────────────────────────────────
FOLLOW-UP / RECOMMENDATIONS
───────────────────────────────────────────────────────────
[What should be done next? New detections? Policy changes?]

═══════════════════════════════════════════════════════════
```

### 9.3 Alert-Specific Quick Reference: TP vs FP Cheat Sheet

| Alert Type | #1 Question to Ask | TP Pattern | FP Pattern |
|------------|-------------------|------------|------------|
| **Encoded PowerShell** | What does the decoded command do? | Download cradle, C2 beacon, AMSI bypass | SCCM deployment, IT automation script |
| **Malware File** | What's the VT score + did it execute? | 10+ VT, executed, made network calls | Legit software, heuristic-only detection |
| **Impossible Travel** | What happened AFTER the suspicious login? | Inbox rules, OAuth grants, mass download | User VPN, mobile handoff, geo inaccuracy |
| **Brute Force** | Did any account get successfully compromised? | Failures → success → post-compromise activity | Cached creds, misconfigured service |
| **Lateral Movement** | Why is this host connecting to that host? | Workstation → server admin shares → multi-hop | IT admin from jump box, SCCM agent push |
| **C2 Beacon** | Is the domain new + is the interval regular? | New domain, low-jitter beacon, VPS hosting | SaaS heartbeat, monitoring agent, update check |
| **DNS Anomaly** | Is data encoded in subdomain labels? | Encoded labels, TXT queries, high entropy | CDN lookups, service mesh, cloud endpoints |
| **OAuth Consent** | What permissions + is publisher verified? | Mail.ReadWrite, unknown publisher, consent phish | Microsoft verified app, minimal permissions |
| **Privilege Change** | Did the admin confirm + was it after-hours? | Unauthorized role assignment, no change ticket | Approved change, documented request |
| **Data Exfil/DLP** | Is the user departing + is data sensitive? | Mass download → personal cloud, departing employee | OneDrive sync, approved backup |
| **Account Created** | Was it created through normal provisioning? | Manual creation outside HR workflow → 🔴 | HR onboarding, IT provisioning ticket |
| **Log Cleared** | Was it on a critical system (DC/Server)? | Security log cleared on DC at night → 🔴 | Log rotation, disk space management |

---

### 9.4 SOC Analyst Investigation Toolkit — Tools Reference

| Tool | Purpose | When to Use |
|------|---------|-------------|
| **VirusTotal** | File/URL/IP/domain reputation | Every alert with IOCs |
| **AbuseIPDB** | IP abuse reporting and reputation | External IP investigation |
| **Shodan / Censys** | Internet-facing service discovery | C2 IP infrastructure analysis |
| **URLScan.io** | Safe URL rendering and analysis | Suspicious URLs |
| **WHOIS** | Domain registration info | New/suspicious domains |
| **Any.Run / Hybrid Analysis** | Malware sandboxing | Suspicious files |
| **CyberChef** | Data decoding, transformation | Encoded commands, Base64 |
| **MXToolbox** | Email/DNS/blacklist checks | Email investigations |
| **Have I Been Pwned** | Credential exposure check | Account compromise |
| **MITRE ATT&CK Navigator** | Technique mapping and coverage | Mapping findings to ATT&CK |

---

*End of Reactive SOC Investigation Guide (Parts 1-2). This guide provides deep-dive investigation procedures for every major alert type, TP determination frameworks, evidence collection standards, and comprehensive SOC analyst checklists.*


---$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Reactive_SOC_Investigation_Guide_Part1$VELSEC$, $VELSEC$Reactive Soc Investigation Guide Part1$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['SOC']::TEXT[], $VELSEC$# 🔍 Reactive SOC Investigation Guide — Part 1: Deep-Dive TP Determination Framework

---

# PART 1: ALERT INVESTIGATION METHODOLOGY & ENDPOINT/MALWARE DEEP DIVES

---

## 1. Reactive Investigation — Core Philosophy

### 1.1 What Makes This Guide Different?

| Proactive (Threat Hunting) | Reactive (This Guide) |
|---------------------------|----------------------|
| You go looking for threats | Alert comes TO you |
| Hypothesis-driven | Alert-driven |
| "What might be hiding?" | "Is THIS alert real?" |
| Broad scope | Focused on specific alert |
| Schedule-based | Real-time / SLA-driven |
| Output: new detections | Output: TP/FP verdict + response |

### 1.2 The TP Determination Mindset

```
┌───────────────────────────────────────────────────────────────────────┐
│              THE ANALYST'S INVESTIGATION MINDSET                      │
├───────────────────────────────────────────────────────────────────────┤
│                                                                       │
│  ❌ WRONG MINDSET:                                                   │
│     "This alert fired, it must be real. Let me confirm it."          │
│     "This looks like a false positive, let me close it quickly."     │
│                                                                       │
│  ✅ CORRECT MINDSET:                                                 │
│     "I have a SECURITY EVENT. I don't know if it's malicious yet."   │
│     "I will gather evidence, analyze context, and form a judgment."  │
│     "I will prove or disprove malicious intent with DATA."           │
│                                                                       │
│  KEY PRINCIPLES:                                                      │
│  1. Never assume TP or FP until you have EVIDENCE                    │
│  2. Context is everything — same activity can be TP or FP            │
│  3. Ask "WHY would this happen legitimately?"                        │
│  4. Ask "WHY would an attacker do this?"                             │
│  5. Correlate: One indicator is suspicious, three is a pattern       │
│  6. Document EVERYTHING — your notes are evidence                    │
│  7. When in doubt, ESCALATE — never close unsure as FP              │
│                                                                       │
└───────────────────────────────────────────────────────────────────────┘
```

---

## 2. Universal Deep-Dive Investigation Framework

### 2.1 The 7-Layer Investigation Model

Every alert, regardless of type, should be investigated using this layered approach:

```
┌────────────────────────────────────────────────────────────────────────┐
│              7-LAYER DEEP INVESTIGATION MODEL                          │
├────────────────────────────────────────────────────────────────────────┤
│                                                                        │
│  LAYER 1: ALERT CONTEXT  (What triggered this?)                       │
│  ├─ What rule/signature/detection fired?                               │
│  ├─ What is the rule logic? (understand WHY it triggered)             │
│  ├─ What is the severity and confidence level?                        │
│  ├─ Has this rule produced FPs before? (check tuning history)         │
│  └─ Is this part of a known alert storm or rule issue?                │
│                                                                        │
│  LAYER 2: ACTOR CONTEXT  (Who did this?)                              │
│  ├─ What user account was involved?                                   │
│  ├─ What is their role? (IT admin vs. HR vs. executive)               │
│  ├─ Is this normal behavior for this user?                            │
│  ├─ Have they been involved in prior alerts?                          │
│  ├─ Is the account a service account, shared, or personal?           │
│  └─ Has the account shown signs of compromise? (impossible travel)   │
│                                                                        │
│  LAYER 3: ASSET CONTEXT  (Where did this happen?)                     │
│  ├─ What system/endpoint is involved?                                 │
│  ├─ Is it a workstation, server, DC, or cloud resource?              │
│  ├─ What is its criticality? (crown jewel, standard, DMZ)            │
│  ├─ What software/services run on this asset?                        │
│  ├─ Is this asset part of an admin tier?                              │
│  └─ Has this asset been involved in prior incidents?                  │
│                                                                        │
│  LAYER 4: TEMPORAL CONTEXT  (When did this happen?)                   │
│  ├─ What time did the event occur? (business hours vs. off-hours)    │
│  ├─ Was there a change window or maintenance scheduled?              │
│  ├─ Does this correlate with user's normal work schedule?            │
│  ├─ Did similar events occur before/after? (pattern?)                │
│  └─ Does the timing match known threat campaign patterns?             │
│                                                                        │
│  LAYER 5: TECHNICAL ANALYSIS  (What exactly happened?)               │
│  ├─ Full process chain analysis (parent → child tree)                │
│  ├─ Command line argument analysis                                    │
│  ├─ Network connection analysis (src, dst, port, protocol)           │
│  ├─ File analysis (hash, origin, behavior in sandbox)                │
│  ├─ Authentication analysis (how did they get access?)               │
│  └─ Correlation with other log sources                                │
│                                                                        │
│  LAYER 6: THREAT INTELLIGENCE  (Is this known bad?)                  │
│  ├─ Check IOCs against threat intel (VirusTotal, OTX, MISP)         │
│  ├─ Check IP/domain reputation (AbuseIPDB, Shodan, Talos)           │
│  ├─ Match file hash against known malware databases                  │
│  ├─ Check MITRE ATT&CK for technique identification                 │
│  └─ Check recent threat reports for matching TTPs                     │
│                                                                        │
│  LAYER 7: IMPACT ASSESSMENT  (How bad is this?)                      │
│  ├─ What data/systems are at risk?                                   │
│  ├─ Has the attacker achieved their objective?                       │
│  ├─ What is the blast radius? (affected scope)                       │
│  ├─ Is containment needed immediately?                                │
│  └─ What is the business and regulatory impact?                       │
│                                                                        │
└────────────────────────────────────────────────────────────────────────┘
```

### 2.2 Evidence Strength Matrix

Not all evidence carries equal weight. Rate your findings:

| Evidence Level | Description | Examples | TP Likelihood |
|---------------|-------------|---------|---------------|
| 🔴 **Definitive** | Irrefutable proof of malicious activity | Known malware hash, confirmed C2 traffic, ransom note | 99%+ |
| 🟠 **Strong** | Multiple correlated indicators pointing to malicious | Encoded PowerShell + C2 beaconing + new persistence | 85-99% |
| 🟡 **Moderate** | Suspicious but could have legitimate explanation | LOLBin execution, unusual logon hours, new scheduled task | 50-85% |
| 🟢 **Weak** | Single anomaly with many legitimate explanations | Single failed login, large file download, new software install | 10-50% |
| ⚪ **Informational** | Normal variation or known-benign activity | IT admin running admin tools, scheduled backup job | <10% |

### 2.3 Correlation Multiplier — The Power of Combined Evidence

```
Single anomaly     = Suspicious (investigate further)
Two correlated     = Concerning (deep dive required)
Three correlated   = Probable TP (begin containment planning)
Four+ correlated   = Confirmed TP (contain immediately + investigate)

Example:  
  1. PowerShell -Enc execution               → 🟡 Moderate alone
  2. + From a non-IT user workstation         → 🟠 Now Strong
  3. + Beacon-like outbound connections       → 🔴 Near Definitive
  4. + Followed by LSASS access              → 🔴 CONFIRMED TP — CONTAIN NOW
```

---

## 3. Deep-Dive: Endpoint Alert Investigation

### 3.1 Suspicious Process Execution Alert

**Alert Example:** "Suspicious process execution detected — powershell.exe with encoded command on WKST-FIN-042"

#### Step-by-Step Deep Dive:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 1: DECODE THE COMMAND (2 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Extract the -Enc (Base64) value from the alert
□ Decode it: [System.Text.Encoding]::Unicode.GetString(
    [System.Convert]::FromBase64String('<encoded_string>'))
□ Read the decoded command — what does it DO?

  IF decoded contains:
    → IEX / Invoke-Expression + Download    = 🔴 Download cradle
    → Net.WebClient / Invoke-WebRequest     = 🔴 Downloading payload
    → -WindowStyle Hidden / -W Hidden       = 🔴 Hiding from user
    → Start-Process with remote binary      = 🔴 Executing downloaded file
    → AMSI bypass strings                   = 🔴 Evading detection
    → Get-Process / Get-Service             = 🟡 Could be recon or admin
    → Set-ExecutionPolicy Bypass            = 🟠 Enabling script execution

  IF decoded contains:
    → Known IT automation scripts           = 🟢 Likely FP
    → SCCM / Intune / GPO script patterns  = 🟢 Likely management tool
    → Software installation commands        = 🟡 Verify with IT

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 2: ANALYZE PROCESS TREE (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ What is the PARENT process of powershell.exe?

  SUSPICIOUS PARENTS (🔴):
    → WINWORD.EXE / EXCEL.EXE / OUTLOOK.EXE  (macro execution)
    → wscript.exe / cscript.exe               (script launched PS)
    → mshta.exe                                (HTA launched PS)
    → WmiPrvSE.exe                             (WMI remote execution)
    → services.exe                             (service-based execution)
    → cmd.exe with /c or /k                    (chained execution)
    → rundll32.exe                             (DLL-based launch)

  NORMAL PARENTS (🟢):
    → explorer.exe    (user manually opened PowerShell)
    → svchost.exe     (system service — check which service)
    → sccm/intune     (management tool — verify deployment)
    → scheduled task   (verify task is legitimate)

□ What CHILD processes did PowerShell spawn?

  SUSPICIOUS CHILDREN (🔴):
    → cmd.exe, certutil.exe, bitsadmin.exe     (tool download/exec)
    → net.exe, nltest.exe, whoami.exe           (discovery)
    → reg.exe (add Run key)                     (persistence)
    → schtasks.exe                              (persistence)
    → mshta.exe, rundll32.exe                   (further execution)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 3: CHECK NETWORK CONNECTIONS (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Did the PowerShell process make outbound connections?
   → Sysmon Event 3 / EDR network telemetry / Firewall logs

□ Where did it connect to?
   → External IP?  Check: VirusTotal, AbuseIPDB, Shodan
   → External domain?  Check: WHOIS (age, registrar), URLScan.io
   → Internal IP?  Could be lateral movement

□ What was downloaded?
   → Check proxy logs for the URL
   → What content type was returned?
   → Was it a script (.ps1), binary (.exe), or DLL?

□ Was there beaconing behavior after initial connection?
   → Regular interval connections = C2

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 4: CHECK USER AND ASSET CONTEXT (3 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Who is the user on WKST-FIN-042?
   → Finance user running encoded PowerShell = 🔴 (not their job)
   → IT admin on their assigned workstation = 🟡 (possible but verify)

□ Is this workstation known for IT activity?
   → Standard user workstation running admin tools = 🔴
   → IT admin jump box = 🟡 (still verify the specific command)

□ Check user's alert history:
   → First-time alert = could be fresh compromise
   → Repeat alerts = either persistent issue or ongoing attack

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 5: MAKE VERDICT (2 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Score your findings:

  CONFIRM TP IF:
  ✓ Decoded command = download cradle / C2 beacon / credential theft
  ✓ Parent process = Office app, script engine, or unexpected parent
  ✓ Network connection to known-bad or newly registered domain
  ✓ User has no legitimate reason for this activity
  ✓ Post-execution: persistence / discovery / credential access seen

  CONFIRM FP IF:
  ✓ Decoded command = known IT automation script  
  ✓ Parent process = SCCM, Intune, GPO, or IT tool
  ✓ Network connection to internal management server
  ✓ User is IT admin performing documented task
  ✓ Activity matches known change window
  ✓ Same alert fires on many machines = deployment push

  ESCALATE IF UNSURE:
  ✓ Command is obfuscated beyond your analysis capability
  ✓ Conflicting signals (admin user but suspicious command)
  ✓ New technique you haven't seen before
```

---

### 3.2 Suspicious File/Malware Detection Alert

**Alert Example:** "Malicious file detected — `update_client.exe` with high-risk score on SVR-APP-019"

#### Step-by-Step Deep Dive:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 1: FILE STATIC ANALYSIS (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Collect file metadata:
   → Full file path:  C:\ProgramData\update_client.exe
   → File size:       [note size — tiny or huge is suspicious]
   → Creation time:   [when was it dropped?]
   → Modified time:   [matches creation? or timestomped?]
   → File hash:       SHA256 = [calculate]

□ Check hash on VirusTotal:
   → 0 detections = unknown (not necessarily clean — could be new)
   → 1-5 detections = possibly suspicious (check which AVs detected)
   → 10+ detections = likely malicious → 🔴
   → 30+ detections = confirmed malware → 🔴 DEFINITIVE

□ Check code signing:
   → Unsigned executable in ProgramData → 🔴 SUSPICIOUS
   → Signed by Microsoft/known vendor → 🟢 (but verify hash)
   → Signed by unknown/expired cert → 🟠 INVESTIGATE
   → Self-signed certificate → 🔴 SUSPICIOUS

□ Check file naming:
   → Does name mimic legitimate software? (update_client, svchost)
   → Double extension? (report.pdf.exe) → 🔴
   → Random characters? (a3f8x9.exe) → 🔴
   → Matches legitimate software exactly? Verify path is correct

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 2: FILE ORIGIN — HOW DID IT GET THERE? (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Check Sysmon Event 11 (File Create):
   → What process CREATED this file?

  SUSPICIOUS ORIGINS (🔴):
   → powershell.exe    (downloaded via script)
   → cmd.exe           (downloaded via certutil/bitsadmin)
   → outlook.exe       (email attachment saved)
   → browser process   (downloaded from web)
   → wmiprvse.exe      (WMI remote file drop)
   → services.exe      (service-based file creation)

  NORMAL ORIGINS (🟢):
   → msiexec.exe       (software installer — verify legitimacy)
   → setup.exe         (installation — verify source)
   → sccm/intune agent (management deployment)
   → windows update    (legitimate update)

□ Check browser download history / proxy logs:
   → What URL was the file downloaded from?
   → Was the domain legitimate or suspicious?

□ Check email logs:
   → Was this file attached to an email?
   → Was the email from a known sender?

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 3: FILE EXECUTION ANALYSIS (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Did the file EXECUTE? (Critical question)
   → Sysmon Event 1: was update_client.exe started as a process?
   → If NOT executed: lower risk (file was only dropped, not run)
   → If EXECUTED: high risk → full investigation required

□ If executed, what did it DO?
   → Child processes spawned?
   → Network connections made? (Sysmon Event 3)
   → Files created/modified? (Sysmon Event 11)
   → Registry changes? (Sysmon Event 13)
   → LSASS accessed? (Sysmon Event 10)

□ Sandbox analysis (if available):
   → Submit file hash to Any.Run, Hybrid Analysis, Joe Sandbox
   → Review behavioral report:
     - Does it establish persistence?
     - Does it connect to C2?
     - Does it access credentials?
     - Does it perform discovery?
     - Does it encrypt files?

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 4: SCOPE AND SPREAD (3 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Is this file on other endpoints?
   → EDR: search for same file hash across environment
   → How many hosts have this file? 1 = targeted, 100 = campaign

□ Is this part of a known malware family?
   → VirusTotal: check "Community" and "Relations" tabs
   → Check if linked to known APT group or ransomware strain

□ Are other IOCs from sandbox analysis present in environment?
   → Search for C2 domains/IPs in DNS and proxy logs
   → Search for related file hashes on other endpoints

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 5: VERDICT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  CONFIRM TP IF:
  ✓ VT detections > 5 from reputable engines
  ✓ File dropped by suspicious process (PS, cmd, browser)
  ✓ File is unsigned or signed with suspicious cert
  ✓ File executed and made C2 connections
  ✓ Sandbox confirms malicious behavior

  CONFIRM FP IF:
  ✓ VT detections = 0 with high submission count (well-known clean)
  ✓ File is from legitimate software installation
  ✓ Signed by verified vendor with valid certificate
  ✓ File path matches expected software location
  ✓ IT confirms planned deployment
  ✓ AV triggered on heuristic with no behavioral confirmation
```

---

## 4. Deep-Dive: Authentication & Identity Alert Investigation

### 4.1 Impossible Travel / Anomalous Login Alert

**Alert Example:** "Impossible travel detected — user john.doe logged in from New York and Lagos, Nigeria within 30 minutes"

#### Step-by-Step Deep Dive:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 1: VERIFY THE GEOGRAPHIC DATA (3 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Pull both login events:
   Login 1: Time, IP, Geo, Device, App, Status, MFA result
   Login 2: Time, IP, Geo, Device, App, Status, MFA result

□ Verify geo accuracy:
   → Not all IP-to-geo is accurate (CDN, mobile data can shift)
   → Check if either IP is a known VPN provider
   → Check if either IP belongs to your corporate infrastructure
   → Some ISPs geolocate inaccurately

□ Calculate travel feasibility:
   → Time difference between logins
   → Distance between locations
   → Is it physically possible? (NYC to London in 30 min = impossible)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 2: ANALYZE EACH LOGIN SESSION (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ FOR EACH LOGIN — Check:
   → Device fingerprint: known device name? Registered device?
   → Browser/User-Agent: matches user's normal browser?
   → App accessed: O365? VPN? Business app?
   → MFA status: MFA passed? MFA challenged but not completed?
   → Login result: Success or failure?

□ Red flags on the suspicious login:
   → Unknown device / unregistered device → 🔴
   → Linux User-Agent when user uses Windows → 🔴
   → No MFA challenge (token replay?) → 🔴
   → MFA completed via push (MFA fatigue?) → 🟠
   → Accessing email immediately after login → 🟠

□ Check if the user has VPN/proxy configured:
   → Personal VPN can cause false "impossible travel"
   → Corporate split-tunnel VPN can cause dual-location
   → Mobile hotspot handoff can cause location jump

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 3: POST-LOGIN BEHAVIOR ANALYSIS (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ What happened AFTER the suspicious login?
   This is the MOST IMPORTANT step — behavior reveals intent.

  MALICIOUS POST-LOGIN (🔴 Confirm TP):
   → Inbox rules created (forwarding to external)
   → Mass email download / mailbox search
   → Password change attempted
   → MFA method changed or added
   → OAuth app consent granted
   → SharePoint/OneDrive mass download  
   → Sent phishing emails from the account
   → Accessed other users' mailboxes
   → Added to privileged groups

  NORMAL POST-LOGIN (🟢 Likely FP):
   → Normal email reading pattern
   → No configuration changes
   → Activity matches user's typical behavior
   → Same applications accessed as usual
   → Session duration matches normal patterns

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 4: OUT-OF-BAND VERIFICATION (3 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Contact the user via PHONE (not email — email may be compromised)
   → "Did you log in from [location] at [time]?"
   → "Are you using a VPN or proxy?"
   → "Did you share your credentials with anyone?"
   → "Did you receive an unusual MFA prompt?"

□ If user confirms: NOT ME
   → CONFIRMED TP → Account compromised → Immediate response

□ If user confirms: Yes, that was me (VPN, travel, etc.)
   → CONFIRMED FP → Document and close
   → Consider tuning alert for this user's VPN if recurring

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 5: RESPOND IF TP CONFIRMED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Revoke all active sessions immediately
□ Reset password
□ Reset MFA (re-register clean device)
□ Remove any malicious inbox rules
□ Revoke any OAuth app consents granted
□ Revert any password/MFA changes by attacker
□ Check for data exfiltration (DLP, download logs)
□ Notify the user about the compromise
□ Check if credentials were in known breach database
□ Search for same attacker IP across all user accounts
```

### 4.2 Brute Force / Password Spray Alert

**Alert Example:** "Account lockout detected — 50 failed logins for user jane.smith from IP 203.x.x.x in 5 minutes"

#### Step-by-Step Deep Dive:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 1: CLASSIFY THE ATTACK TYPE (2 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Check the PATTERN of failures:
   → 1 account, many passwords = BRUTE FORCE
   → Many accounts, 1-2 passwords = PASSWORD SPRAY
   → Many accounts, many passwords = CREDENTIAL STUFFING
   → 1 account, constant attempts = automated script or misconfiguration

□ Check the failure reason code:
   → 0xC000006A = Wrong password (attack in progress)
   → 0xC0000234 = Account locked (lockout triggered)
   → 0xC0000072 = Account disabled
   → 0xC000006D = Bad username (account enumeration)
   → 0xC0000064 = Username does not exist (enumeration)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 2: ANALYZE THE SOURCE (3 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Where is 203.x.x.x?
   → Geolocation: what country?
   → Reputation: AbuseIPDB, VirusTotal, Shodan
   → Is it a known VPN/TOR node?
   → Is it a cloud provider IP (AWS, Azure, GCP)?
   → Does it belong to your organization?

□ What protocol/service was targeted?
   → RDP (3389) → 🔴 Direct remote access attempt
   → OWA/O365 → 🔴 Email access attempt
   → VPN → 🔴 Network access attempt
   → SSH (22) → 🔴 Linux/network device access
   → SMB (445) → 🔴 Internal network attack
   → Web app login → 🟠 Application-specific

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 3: CHECK FOR SUCCESS (5 minutes — CRITICAL)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ After the failures, was there a SUCCESSFUL login?
   → 4625 (fail) × 50 → 4624 (success) = 🔴 CREDENTIAL COMPROMISED
   → 4625 (fail) × 50 → no success = Attack failed (but still a TP for attack)

□ If successful login occurred:
   → Was it from the SAME source IP? = attacker guessed correctly
   → Was it from a DIFFERENT IP shortly after? = attacker using creds elsewhere
   → What did the attacker do after logging in?
     Check all post-login activity (see Section 4.1 Step 3)

□ Check OTHER accounts from same source IP:
   → Did the same IP target multiple accounts? (spray indicator)
   → Were any OTHER accounts successfully compromised?
   → Search: all 4625 events WHERE source_IP = 203.x.x.x

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 4: VERDICT AND RESPONSE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  TP — Attack WITH Compromise:
  □ Failures followed by success from attacker IP
  □ Reset compromised account passwords
  □ Revoke sessions and enforce MFA
  □ Block attacker IP at perimeter
  □ Check for post-compromise activity
  □ Full account compromise investigation

  TP — Attack WITHOUT Compromise:
  □ 50+ failures from external suspicious IP
  □ Block attacker IP at perimeter  
  □ Verify account lockout policy is enforced
  □ Ensure MFA is enabled on targeted accounts
  □ Monitor for continued attempts from different IPs
  □ Consider adding IP range to blocklist

  FP — Misconfiguration:
  □ Failed logins from internal service account
  □ Password recently changed but cached creds not updated
  □ IT identifies a misconfigured service/script
  □ Fix the misconfiguration and close as FP
```

---

## 5. TP Determination Decision Matrix — Quick Reference

| Alert Type | Strongest TP Indicator | Strongest FP Indicator | Tiebreaker Question |
|------------|----------------------|----------------------|-------------------|
| **Suspicious Process** | Encoded download cradle from Office child process | IT management tool (SCCM/Intune) as parent | "Is this user an admin running an expected script?" |
| **Malware Detection** | VT 10+ detections + process executed + C2 connection | Known software, signed, clean VT, expected path | "What process created this file and why?" |
| **Impossible Travel** | Unknown device + malicious post-login behavior | User confirms VPN/travel + normal post-login | "What happened AFTER the login?" |
| **Brute Force** | Failures → success from same attacker IP | Cached creds / misconfigured service | "Did the attacker get in?" |
| **Privilege Escalation** | Non-admin exploiting UAC + credential dump after | Admin using admin tools on their workstation | "Does this user NEED these privileges for their job?" |
| **Lateral Movement** | PsExec from workstation to multiple servers | SCCM push deployment across managed hosts | "Why is this workstation connecting to server admin shares?" |
| **Data Exfil** | 4GB upload to personal Mega.nz at 2 AM | Cloud backup service syncing to corporate cloud | "Is this in line with the user's job function and timing?" |

---

*Continued in Part 2 → Network Alert Deep Dives, Cloud/SaaS Alert Investigations, Email Alert Investigation, Insider Threat, and Complete SOC Analyst Investigation Checklists*$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Reactive_SOC_Investigation_Guide_Part2$VELSEC$, $VELSEC$Reactive Soc Investigation Guide Part2$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['SOC']::TEXT[], $VELSEC$# 🔍 Reactive SOC Investigation Guide — Part 2: Network, Cloud, Email & Insider Threat Deep Dives

---

# PART 2: NETWORK, CLOUD/SAAS, EMAIL ALERT INVESTIGATIONS & MASTER CHECKLISTS

---

## 6. Deep-Dive: Network Alert Investigation

### 6.1 C2 / Beaconing Alert

**Alert Example:** "Potential C2 beaconing — host WKST-HR-017 connecting to `cdn-update[.]xyz` every 60-65 seconds for 6 hours"

#### Step-by-Step Deep Dive:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 1: VALIDATE THE BEACONING PATTERN (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Pull proxy/firewall connection logs for the host + domain
□ Plot the connection intervals on a timeline
□ Calculate standard deviation of intervals:
   → Low jitter (±2-5 sec) = automated C2 beacon → 🔴
   → High jitter (±30+ sec) = possibly legitimate polling
   → Exact same interval = scripted / cron job (check if legit)

□ Check data sizes per connection:
   → Small POST (check-in) → larger GET (commands) = C2 pattern → 🔴
   → Consistent small sizes = heartbeat/monitoring
   → Large downloads only = could be CDN/update service

□ Check connection duration:
   → 6+ hours continuous = persistent implant → 🔴
   → Brief burst then stops = might be legitimate retry loop

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 2: INVESTIGATE THE DOMAIN/IP (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ WHOIS lookup on cdn-update[.]xyz:
   → Domain age < 30 days → 🔴 HIGH RISK
   → Privacy-protected registrant → 🟠
   → Registrar known for abuse (cheap bulk registration) → 🔴

□ VirusTotal domain report:
   → Any AV vendors flag as malicious?
   → What files have communicated with this domain?
   → What subdomains exist?

□ URLScan.io:
   → What content is served? (empty page, fake site, parking page)
   → What technologies are running?

□ Passive DNS (SecurityTrails, RiskIQ):
   → What IPs has this domain resolved to historically?
   → Are those IPs associated with other malicious domains?
   → IP hosted on VPS (DigitalOcean, Linode, Vultr) → 🟠

□ Shodan / Censys on the IP:
   → What services are running? (Cobalt Strike default profile?)
   → Open ports matching C2 frameworks?
   → TLS certificate: self-signed? Default Cobalt Strike cert?

□ JA3/JA3S fingerprint (if available):
   → Match against known C2 framework JA3 hashes
   → Cobalt Strike, Metasploit, Sliver all have known JA3s

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 3: ENDPOINT INVESTIGATION (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ What process is making the connections?
   → EDR / Sysmon Event 3: SourceImage for network connections
   → Legitimate process? (chrome.exe, outlook.exe) or unusual?
   → If legitimate name (svchost.exe): verify path and hash
   → If unknown binary: file analysis (hash, signing, origin)

□ Check for process injection:
   → Is a legitimate process (explorer.exe) making unusual connections?
   → Sysmon Event 8: CreateRemoteThread into that process?
   → Memory-only implant? (no file on disk)

□ Check what ELSE happened on this endpoint:
   → Any discovery commands (whoami, net user)?
   → Any credential access (LSASS)?
   → Any persistence installed?
   → Any lateral movement from this host?

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 4: VERDICT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  CONFIRM TP IF:
  ✓ Regular beacon interval with low jitter
  ✓ Domain is newly registered / known malicious
  ✓ JA3 matches known C2 framework
  ✓ Process making connections is injected or suspicious
  ✓ Post-beacon: discovery/credential access activity observed

  CONFIRM FP IF:
  ✓ Domain belongs to legitimate SaaS (telemetry, monitoring)
  ✓ Software update check pattern (known software, signed)
  ✓ IT confirms: monitoring agent heartbeat
  ✓ Domain age > 2 years with clean reputation
  ✓ Process is verified legitimate with correct hash/path
```

---

### 6.2 Suspicious DNS Activity Alert

**Alert Example:** "DNS anomaly — host SRV-DB-003 querying 400+ unique subdomains of `data-sync[.]top` with long encoded labels"

#### Step-by-Step Deep Dive:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 1: CLASSIFY THE DNS ANOMALY (3 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Pull DNS query logs for this host + domain:
   → Query types: A, AAAA, TXT, NULL, CNAME, MX?
   → TXT or NULL queries = 🔴 (commonly used for DNS tunneling)
   → Subdomain label length > 50 chars = 🔴 (data encoded in query)

□ Classify the behavior:
   SCENARIO A: DNS TUNNELING (data exfil/C2) → 🔴
     Indicators: Long subdomains, high entropy, TXT records,
     high query rate, encoded data in labels

   SCENARIO B: DGA (Domain Generation Algorithm) → 🔴
     Indicators: Many NXDOMAIN responses, random-looking domains,
     algorithmic pattern in domain names

   SCENARIO C: Legitimate high DNS volume → 🟢
     Indicators: CDN resolution, load balancing, service mesh,
     known cloud service subdomains

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 2: ANALYZE THE DATA (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Decode subdomain labels:
   → Try Base64 decode → readable data = data exfil → 🔴
   → Try Base32/Hex decode
   → High Shannon entropy (>3.5) = encoded data → 🔴
   → Readable strings = might be legitimate (but unusual)

□ Check query responses:
   → Are TXT responses also long/encoded? = C2 commands → 🔴
   → All NXDOMAIN? = DGA waiting for activation → 🔴
   → Valid A/CNAME responses? = possibly legitimate

□ Calculate data volume:
   → (avg subdomain length × queries) = data exfiltrated
   → 400 queries × 60 chars × ~0.75 bytes = ~18KB (commands/small exfil)
   → Thousands of queries = larger data exfil attempt

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 3: ENDPOINT + NETWORK CORRELATION (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Critical: This is a DATABASE SERVER (SRV-DB-003) → 🔴🔴
   → Data exfil from a DB server is worst-case scenario
   → Check what database is hosted and its sensitivity level

□ What process is generating DNS queries?
   → Expected: database engine (sqlservr.exe) resolving clients
   → Suspicious: powershell.exe, unknown binary, python, dnscat

□ Check for related indicators:
   → File access logs on the DB server
   → Database query logs (unusual bulk SELECT queries?)
   → Any data export operations (BCP, mysqldump)?
   → Network connections beyond DNS?

□ RESPOND IF TP:
   → Sinkhole the domain at DNS resolver
   → Isolate SRV-DB-003 from network
   → Capture the DNS tunneling tool
   → Assess what data was potentially exfiltrated
   → THIS IS A DATA BREACH → notify Legal and CISO
   → Full database audit (what was accessed?)
```

---

## 7. Deep-Dive: Cloud / SaaS Alert Investigation

### 7.1 Suspicious OAuth / App Consent Alert

**Alert Example:** "High-risk OAuth app consent — user mike.johnson granted 'Mail.ReadWrite, Files.ReadWrite.All' to app 'Productivity Helper' from publisher 'Unknown'"

#### Step-by-Step Deep Dive:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 1: ANALYZE THE APP CONSENT (3 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ What permissions were granted?
   → Mail.ReadWrite = read/modify ALL email → 🔴
   → Files.ReadWrite.All = access ALL OneDrive/SharePoint → 🔴
   → User.Read = basic profile only → 🟢 (benign)
   → Directory.ReadWrite.All = modify AD → 🔴 CRITICAL

□ Who is the publisher?
   → "Unknown" or unverified publisher → 🔴
   → Known vendor (Microsoft, Google, Salesforce) → 🟢
   → Publisher name mimics known brand → 🔴 (impersonation)

□ App registration details (Azure AD > Enterprise Apps):
   → When was the app registered?
   → Multi-tenant or single-tenant?
   → How many users in your org have consented?
   → App homepage URL — does it look legitimate?

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 2: INVESTIGATE THE USER (3 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ How did mike.johnson encounter this app?
   → Check email for OAuth consent phishing (common attack vector)
   → Was there a phishing email with "Click to authorize app"?
   → Did user click a link leading to Microsoft consent screen?

□ Check sign-in logs around consent time:
   → Was there an anomalous login before consent?
   → Different IP/location than usual?

□ Check if user was socially engineered:
   → Contact user: "Did you intentionally install Productivity Helper?"
   → If NO / unsure → 🔴 consent phishing attack

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 3: CHECK APP ACTIVITY POST-CONSENT (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Azure AD audit logs → filter by App ID:
   → Has the app read email? How many messages?
   → Has the app accessed OneDrive/SharePoint files?
   → Has the app sent emails on behalf of the user?
   → Has the app modified mailbox rules?

□ If the app DID access data → 🔴 CONFIRMED TP:
   → What data was accessed/exfiltrated?
   → Were emails forwarded externally?
   → Were files downloaded in bulk?

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 4: RESPOND IF TP
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ REVOKE the app consent immediately
   → Azure AD > Enterprise Apps > Permissions > Revoke
□ Remove the app from the tenant
□ Reset the user's password and MFA
□ Revoke all user sessions
□ Audit what data the app accessed
□ Block non-verified app consents via policy:
   → Azure AD > User Settings > App Registrations > "No" for user consent
   → Require admin approval for all app consents
□ Check if other users also consented to this app
□ Report the app to Microsoft (if hosted on Azure AD)
```

### 7.2 Cloud IAM / Privilege Change Alert

**Alert Example:** "User added to Global Administrator role — target: svc_helpdesk@corp.com, added by: admin@corp.com at 11:45 PM"

#### Step-by-Step Deep Dive:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 1: ANALYZE THE CHANGE (2 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ What role was assigned?
   → Global Administrator = highest privilege → 🔴 ALWAYS INVESTIGATE
   → Billing Admin = financial access → 🟠
   → Helpdesk Admin = password reset → 🟡 (for helpdesk user, maybe ok)

□ svc_helpdesk as Global Admin → 🔴🔴
   → Helpdesk service account NEVER needs Global Admin
   → This is either a mistake or malicious privilege escalation

□ Timing: 11:45 PM → outside business hours → 🔴

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 2: VERIFY THE ADMIN (3 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Is admin@corp.com a legitimate Global Admin?
□ Check admin@corp.com's sign-in logs:
   → Where did they log in from at 11:45 PM?
   → Known device? Known IP? Known location?
   → Was MFA completed?
   → Any impossible travel or anomalous access?

□ Contact admin@corp.com out-of-band:
   → "Did you add svc_helpdesk to Global Admin at 11:45 PM?"
   → If YES → ask for justification and change management ticket
   → If NO → admin's account is COMPROMISED → 🔴 CRITICAL

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 3: CHECK POST-ESCALATION ACTIVITY (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ What did svc_helpdesk do WITH Global Admin rights?
   → Create new admin accounts?
   → Modify conditional access policies?
   → Disable MFA for accounts?
   → Access Exchange admin center?
   → Modify mail flow rules (org-wide forwarding)?
   → Create new OAuth apps with admin consent?
   → Access Azure subscriptions or resources?
   → Export data from admin portals?

□ If ANY of the above → 🔴 CONFIRMED TP — ACTIVE COMPROMISE

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 4: RESPOND IF TP
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Remove svc_helpdesk from Global Admin IMMEDIATELY
□ Disable svc_helpdesk account
□ If admin@corp.com was compromised:
   → Reset password and MFA
   → Revoke sessions
   → Audit all actions by admin@corp.com in last 30 days
□ Audit ALL Global Admin role assignments
□ Review all changes made by svc_helpdesk as Global Admin
□ Revert any unauthorized changes (policies, rules, apps)
□ Implement PIM (Privileged Identity Management):
   → Just-in-time admin access
   → Require approval for Global Admin activation
   → Set maximum activation duration
□ Enable alerts for ALL critical role assignments
```

---

## 8. Deep-Dive: Insider Threat Alert Investigation

### 8.1 Data Exfiltration / DLP Alert

**Alert Example:** "DLP policy violation — user sarah.chen downloaded 2,400 files from SharePoint Engineering site in 45 minutes, then uploaded 1.8GB to personal Google Drive"

#### Step-by-Step Deep Dive:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 1: ASSESS THE ACTIVITY (3 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Volume assessment:
   → 2,400 files in 45 min = ~53 files/minute → 🔴 AUTOMATED
   → 1.8 GB to personal cloud → 🔴 DATA LEAVING ORGANIZATION
   → Engineering site = likely intellectual property → 🔴

□ Is sarah.chen authorized to access Engineering SharePoint?
   → YES → access is legitimate, but DATA TRANSFER is not
   → NO → unauthorized access + exfil → DOUBLY SUSPICIOUS

□ Check DLP classification of files:
   → Classified as Confidential/Restricted? → 🔴
   → Source code files? Design documents? → 🔴
   → Public/Internal only? → 🟡 (still a policy violation)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 2: ESTABLISH USER CONTEXT (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ WHO is sarah.chen?
   → Role: Engineer, Manager, Contractor?
   → Department: Engineering (relevant to data accessed?)
   → Employment status: Active? Notice period? PIP?

□ HR INTELLIGENCE (coordinate with HR/Legal):
   → Has sarah.chen submitted resignation? → 🔴🔴
   → Is sarah.chen on a performance improvement plan? → 🔴
   → Is sarah.chen interviewing elsewhere? (if known) → 🔴
   → Any recent disciplinary actions? → 🟠
   → None of the above → 🟡 (but still investigate)

□ Historic behavior:
   → Has sarah.chen downloaded large volumes before?
   → Is bulk download part of their normal work pattern?
   → Prior DLP violations?
   → Check last 30/60/90 days of activity for trending

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 3: ANALYZE THE FULL ACTIVITY CHAIN (5 minutes)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ BEFORE the download:
   → Any searches for specific file types or keywords?
   → SharePoint audit: search queries run by the user?
   → Did they browse systematically through folders?

□ DURING the download:
   → Was OneDrive Sync used? Browser download? API?
   → Sync client = might be accidental mass sync
   → Browser/API download = deliberate selection

□ AFTER the download → TRANSFER:
   → Uploaded to personal Google Drive → 🔴
   → Copied to USB drive? (check endpoint DLP) → 🔴
   → Emailed to personal email? → 🔴
   → Uploaded to other cloud? (Dropbox, WeTransfer) → 🔴
   → Printed large volumes? → 🟠

□ OTHER suspicious behavior:
   → Accessing systems/files they don't normally access?
   → Working at unusual hours?
   → Using personal devices?
   → Clearing browser history or app logs?

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 4: VERDICT AND RESPONSE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  CONFIRM TP — INSIDER THREAT IF:
  ✓ Mass file download + transfer to personal cloud
  ✓ Files contain confidential/IP data
  ✓ User is departing / under performance review
  ✓ Activity is outside normal work patterns
  ✓ Deliberate circumvention of DLP controls

  POSSIBLE FP IF:
  ✓ OneDrive sync misconfiguration (accidental full sync)
  ✓ Legitimate work-from-home needing offline copies
  ✓ IT-approved backup or migration activity
  ✓ User explains valid business reason
  → STILL requires manager + HR + Legal review

  RESPOND:
  □ DO NOT alert the user initially (preserve investigation)
  □ Notify Legal and HR immediately
  □ Preserve ALL evidence (audit logs, DLP logs, email)
  □ Legal decides on approach (interview, monitoring, etc.)
  □ Consider: restrict access to sensitive SharePoint sites
  □ Consider: block personal cloud storage uploads
  □ If confirmed malicious: engage Legal for employment action
  □ If data contained trade secrets: consider legal action
  □ Document for potential litigation hold
```

---

## 9. Master SOC Investigation Checklists

### 9.1 The Universal 5-Minute Triage Checklist

**Use this for EVERY alert to quickly determine if deep investigation is needed:**

```
┌───────────────────────────────────────────────────────────────────────┐
│            5-MINUTE INITIAL TRIAGE CHECKLIST                          │
│           (Complete before deciding to deep-dive)                     │
├───────────────────────────────────────────────────────────────────────┤
│                                                                       │
│  □ 1. READ THE ALERT: What exactly fired and why?                    │
│  □ 2. CHECK THE USER: Who is involved? Role? Privileged?             │
│  □ 3. CHECK THE ASSET: What system? Criticality? Server/Workstation? │
│  □ 4. CHECK THE TIME: Business hours? Change window? Weekend?        │
│  □ 5. CHECK HISTORY: Has this alert fired before? Known FP pattern?  │
│  □ 6. CHECK SEVERITY: Critical/High = deep dive immediately          │
│  □ 7. FIRST INSTINCT: Does this FEEL like a real attack?             │
│                                                                       │
│  DECISION:                                                            │
│  → If 3+ red flags from above → DEEP DIVE (proceed with full invest)│
│  → If appears routine with known FP pattern → Quick verify, then FP  │
│  → If unsure → DEEP DIVE (always err on side of investigation)       │
│                                                                       │
└───────────────────────────────────────────────────────────────────────┘
```

### 9.2 Investigation Documentation Template

```
═══════════════════════════════════════════════════════════
              INVESTIGATION DOCUMENTATION
═══════════════════════════════════════════════════════════

TICKET ID:          INC-YYYY-#####
ANALYST:            [Your Name]
DATE/TIME STARTED:  [Timestamp]
ALERT SOURCE:       [SIEM Rule / EDR Alert / User Report / TI Feed]
ALERT NAME:         [Exact alert name/rule]
SEVERITY:           [Critical / High / Medium / Low]
SLA TARGET:         [Time to respond based on severity]

───────────────────────────────────────────────────────────
AFFECTED ENTITIES
───────────────────────────────────────────────────────────
User(s):    [username, domain, role]
Host(s):    [hostname, IP, OS, criticality]
Service(s): [application, service, cloud resource]

───────────────────────────────────────────────────────────
INVESTIGATION TIMELINE
───────────────────────────────────────────────────────────
[HH:MM] Alert received, initial triage started
[HH:MM] [Action taken — e.g., "Pulled process tree from EDR"]
[HH:MM] [Finding — e.g., "PowerShell decoded to download cradle"]
[HH:MM] [Action taken — e.g., "Checked VirusTotal for domain"]
[HH:MM] [Finding — e.g., "Domain registered 3 days ago"]
[HH:MM] Verdict determined
[HH:MM] Response actions initiated

───────────────────────────────────────────────────────────
EVIDENCE COLLECTED
───────────────────────────────────────────────────────────
□ Process tree screenshot / export
□ SIEM query results (with query text)
□ EDR timeline export
□ IOCs extracted (IPs, domains, hashes)
□ Email headers (if email-related)
□ Sandbox report URL
□ VirusTotal links
□ User confirmation (phone/email)

───────────────────────────────────────────────────────────
VERDICT
───────────────────────────────────────────────────────────
□ TRUE POSITIVE — Confirmed threat, response required
□ BENIGN TRUE POSITIVE — Correct detection, authorized activity
□ FALSE POSITIVE — No threat, rule tuning recommended
□ INCONCLUSIVE — Escalated to [L3 / IR / Threat Intel]

Confidence Level: [High / Medium / Low]
MITRE ATT&CK:     [Tactic] — [Technique ID + Name]
Justification:    [2-3 sentences explaining your verdict]

───────────────────────────────────────────────────────────
RESPONSE ACTIONS TAKEN
───────────────────────────────────────────────────────────
□ Host isolated                    □ Account disabled
□ IOCs blocked (firewall/proxy)    □ Password reset
□ Malware quarantined             □ Sessions revoked
□ Email purged                    □ Rule tuning requested
□ IOCs shared to TI platform      □ Escalated to IR team
□ User notified                   □ No action required

───────────────────────────────────────────────────────────
FOLLOW-UP / RECOMMENDATIONS
───────────────────────────────────────────────────────────
[What should be done next? New detections? Policy changes?]

═══════════════════════════════════════════════════════════
```

### 9.3 Alert-Specific Quick Reference: TP vs FP Cheat Sheet

| Alert Type | #1 Question to Ask | TP Pattern | FP Pattern |
|------------|-------------------|------------|------------|
| **Encoded PowerShell** | What does the decoded command do? | Download cradle, C2 beacon, AMSI bypass | SCCM deployment, IT automation script |
| **Malware File** | What's the VT score + did it execute? | 10+ VT, executed, made network calls | Legit software, heuristic-only detection |
| **Impossible Travel** | What happened AFTER the suspicious login? | Inbox rules, OAuth grants, mass download | User VPN, mobile handoff, geo inaccuracy |
| **Brute Force** | Did any account get successfully compromised? | Failures → success → post-compromise activity | Cached creds, misconfigured service |
| **Lateral Movement** | Why is this host connecting to that host? | Workstation → server admin shares → multi-hop | IT admin from jump box, SCCM agent push |
| **C2 Beacon** | Is the domain new + is the interval regular? | New domain, low-jitter beacon, VPS hosting | SaaS heartbeat, monitoring agent, update check |
| **DNS Anomaly** | Is data encoded in subdomain labels? | Encoded labels, TXT queries, high entropy | CDN lookups, service mesh, cloud endpoints |
| **OAuth Consent** | What permissions + is publisher verified? | Mail.ReadWrite, unknown publisher, consent phish | Microsoft verified app, minimal permissions |
| **Privilege Change** | Did the admin confirm + was it after-hours? | Unauthorized role assignment, no change ticket | Approved change, documented request |
| **Data Exfil/DLP** | Is the user departing + is data sensitive? | Mass download → personal cloud, departing employee | OneDrive sync, approved backup |
| **Account Created** | Was it created through normal provisioning? | Manual creation outside HR workflow → 🔴 | HR onboarding, IT provisioning ticket |
| **Log Cleared** | Was it on a critical system (DC/Server)? | Security log cleared on DC at night → 🔴 | Log rotation, disk space management |

---

### 9.4 SOC Analyst Investigation Toolkit — Tools Reference

| Tool | Purpose | When to Use |
|------|---------|-------------|
| **VirusTotal** | File/URL/IP/domain reputation | Every alert with IOCs |
| **AbuseIPDB** | IP abuse reporting and reputation | External IP investigation |
| **Shodan / Censys** | Internet-facing service discovery | C2 IP infrastructure analysis |
| **URLScan.io** | Safe URL rendering and analysis | Suspicious URLs |
| **WHOIS** | Domain registration info | New/suspicious domains |
| **Any.Run / Hybrid Analysis** | Malware sandboxing | Suspicious files |
| **CyberChef** | Data decoding, transformation | Encoded commands, Base64 |
| **MXToolbox** | Email/DNS/blacklist checks | Email investigations |
| **Have I Been Pwned** | Credential exposure check | Account compromise |
| **MITRE ATT&CK Navigator** | Technique mapping and coverage | Mapping findings to ATT&CK |

---

*End of Reactive SOC Investigation Guide (Parts 1-2). This guide provides deep-dive investigation procedures for every major alert type, TP determination frameworks, evidence collection standards, and comprehensive SOC analyst checklists.*$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$SOC_Concepts_Interview_Guide$VELSEC$, $VELSEC$Soc Concepts Interview Guide$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['SOC']::TEXT[], $VELSEC$# 🛡️ SOC Concepts — Complete Interview Guide
> **Goal**: Explain every concept clearly so you can confidently answer in an interview.  
> **Format**: Each topic has a **One-Liner** (quick recall), **Explain Like a Story** (for interviews), **Key Points**, and **Memory Tricks**.

---

## Table of Contents
1. [IOC vs IOA](#1-ioc-vs-ioa)
2. [Threat Intelligence](#2-threat-intelligence)
3. [System Hardening](#3-system-hardening)
4. [Privilege Escalation](#4-privilege-escalation)
5. [Persistence](#5-persistence)
6. [Lateral Movement](#6-lateral-movement)
7. [SANS Incident Response Steps](#7-sans-incident-response-steps)
8. [Types of Logs](#8-types-of-logs)
9. [Protocol Logs](#9-protocol-logs)
10. [Windows Event IDs (Must-Know)](#10-windows-event-ids)
11. [Kerberos Authentication](#11-kerberos-authentication)
12. [SAM & NTLM](#12-sam--ntlm)
13. [Phishing Emails](#13-phishing-emails)
14. [SPF, DKIM & DMARC](#14-spf-dkim--dmarc)
15. [Email Flow](#15-email-flow)
16. [Malicious Activity Indicators](#16-malicious-activity-indicators)
17. [Defensive Measures & Detection](#17-defensive-measures--detection)
18. [NetBIOS & SMB](#18-netbios--smb)
19. [Digital Certificates & HTTPS](#19-digital-certificates--https)
20. [SIEM Solutions](#20-siem-solutions)
21. [EDR vs XDR](#21-edr-vs-xdr)
22. [IDS vs IPS vs Firewall](#22-ids-vs-ips-vs-firewall)
23. [Firewall Types](#23-firewall-types)
24. [Security Definitions (CIA + More)](#24-security-definitions)
25. [Common Vulnerabilities](#25-common-vulnerabilities)
26. [Detection Categories (TP/FP/TN/FN)](#26-detection-categories)
27. [OSI Layer Attacks](#27-osi-layer-attacks)
28. [MITRE ATT&CK Framework](#28-mitre-attck-framework)
29. [Incident Response Playbooks (Scenarios)](#29-incident-response-playbooks)

---

## 1. IOC vs IOA

### One-Liner
> **IOC** = Evidence a crime happened (like bloodstains) | **IOA** = Suspicious behavior happening NOW (like someone picking a lock)

### Interview Answer
"IOCs are **forensic artifacts** — things like malicious IPs, file hashes, or suspicious URLs that tell us a breach **may have already occurred**. IOAs focus on **attacker behavior in real-time** — like unusual PowerShell usage or lateral movement patterns — helping us **detect and stop attacks before damage is done**."

### Quick Comparison Table

| Aspect | IOC (Indicator of Compromise) | IOA (Indicator of Attack) |
|--------|-------------------------------|---------------------------|
| **Focus** | Evidence of an incident | Behavior indicating an attack |
| **When** | Post-incident (reactive) | Real-time (proactive) |
| **Nature** | Static & specific | Dynamic & behavior-based |
| **Examples** | Malicious IPs, file hashes, URLs | Unusual PowerShell downloads, lateral movement patterns |

### 🧠 Memory Trick
> **IOC = "C" for Crime Scene** (after the fact)  
> **IOA = "A" for Active Threat** (happening now)

---

## 2. Threat Intelligence

### One-Liner
> Gathering & analyzing info about threats so you can **predict, prevent, and respond** to attacks.

### Interview Answer
"Threat Intelligence is the process of collecting data from sources like open-source feeds, dark web monitoring, and commercial feeds — then analyzing it to understand attacker **TTPs** (Tactics, Techniques, Procedures). It helps us move from **reactive to proactive** defense."

### Key Benefits
- ⚡ **Faster Response** — know what you're dealing with
- 🎯 **Better Detection** — recognize known threat patterns
- 🧠 **Informed Decisions** — prioritize real risks
- 🛡️ **Risk Mitigation** — strengthen defenses before attacks

### Well-Known Threat Intel Platforms
| Platform | What It Does |
|----------|-------------|
| **VirusTotal** | Scan files/URLs against 70+ AV engines |
| **AbuseIPDB** | Check & report malicious IPs |
| **IBM X-Force** | Threat research & IP reputation |
| **Cisco Talos** | World's largest commercial threat intel team |

### 🧠 Memory Trick
> **"Know Thy Enemy"** — Threat Intel = studying the attacker's playbook before the game starts.

---

## 3. System Hardening

### One-Liner
> **Reducing the attack surface** by removing what's unnecessary and securing what remains.

### Interview Answer
"System hardening is about minimizing vulnerabilities. We **remove unnecessary services and software**, apply **patches regularly**, enforce **strong passwords with MFA**, configure **firewalls and IDS/IPS**, enable **logging**, and **encrypt sensitive data**."

### 6 Steps of Hardening (mnemonic: **R-A-U-N-L-D**)

| Step | Action | Example |
|------|--------|---------|
| **R**emove | Unneeded services & software | Disable FTP if not needed |
| **A**pply | Security patches & updates | Windows Update, WSUS |
| **U**ser controls | Strong passwords, MFA, least privilege | Disable default admin accounts |
| **N**etwork security | Firewalls, IDS/IPS | Block unnecessary ports |
| **L**ogging | Enable system & security logs | Forward to SIEM |
| **D**ata protection | Encryption + Backups | BitLocker, AES-256 |

### 🧠 Memory Trick
> **"RAUNLD"** → Think: "**R**un **A** **U**nified **N**etwork **L**ock**D**own"

---

## 4. Privilege Escalation

### One-Liner
> Attacker goes from **"regular user" → "admin/root"** to gain full control.

### Interview Answer
"Privilege escalation is when an attacker elevates their access level. **Vertical** means going from user to admin. **Horizontal** means accessing another user's resources at the same level. Common methods include exploiting **unpatched software**, **misconfigurations**, **credential theft** (keylogging, pass-the-hash), and **social engineering**."

### Two Types

```
Vertical:   User ──────▲──────► Admin/Root  (going UP)
Horizontal: User A ────►────── User B      (going SIDEWAYS)
```

### Common Methods
1. **Buffer Overflow / Zero-day** — exploit software bugs
2. **Insecure Permissions** — weak file/directory ACLs
3. **Pass-the-Hash** — use stolen password hashes to authenticate
4. **Keylogging** — capture admin credentials via keylogger
5. **Phishing** — trick user into running elevated payload

### Prevention
- ✅ Patch Management
- ✅ Principle of Least Privilege
- ✅ MFA everywhere
- ✅ Secure credential storage

### 🧠 Memory Trick
> **Vertical = Elevator** (going up floors) | **Horizontal = Hallway** (moving between rooms on same floor)

---

## 5. Persistence

### One-Liner
> How attackers **stay inside your system** even after reboots and logouts.

### Interview Answer
"Persistence is about maintaining access. Attackers use **registry autostart keys**, **scheduled tasks**, **rootkits**, **backdoor accounts**, **DLL injection/hijacking**, and **C2 channels (RATs)** to ensure they can always get back in."

### 6 Methods (mnemonic: **A-S-R-U-D-N**)

| Method | How It Works |
|--------|-------------|
| **A**utoStart entries | Registry run keys, startup folder shortcuts |
| **S**cheduled Tasks | Windows Task Scheduler runs malware at intervals |
| **R**ootkits | Hide malware deep in the OS |
| **U**ser accounts | Create hidden backdoor admin accounts |
| **D**LL Injection/Hijacking | Inject malicious code into legit processes |
| **N**etwork-based | RATs + C2 channels for remote control |

### 🧠 Memory Trick
> Think of persistence like a **cockroach** 🪳 — it survives everything and keeps coming back!

---

## 6. Lateral Movement

### One-Liner
> Attacker **moves sideways through the network** from one system to another after the initial compromise.

### Interview Answer
"After compromising one system, attackers use lateral movement to access additional systems. Common techniques include **credential dumping** (Mimikatz), **pass-the-hash**, **pass-the-ticket** (Kerberos), and **remote execution** tools like PsExec, WMI, and RDP."

### 5 Key Techniques

| Technique | Tool/Method |
|-----------|------------|
| Credential Dumping | **Mimikatz**, WCE |
| Pass-the-Hash | Use NTLM hashes without cracking |
| Pass-the-Ticket | Steal Kerberos TGT/TGS tickets |
| Remote Execution | **PsExec**, WMI, RDP, SSH |
| Service Creation | Create malicious services on remote hosts |

### Prevention (mnemonic: **"N-L-M-M-B-E-P-R"**)
1. **N**etwork Segmentation
2. **L**east Privilege
3. **M**onitoring & Logging
4. **M**FA
5. **B**ehavioral Analysis
6. **E**DR
7. **P**atch Management
8. **R**egular Audits & Pen Testing

### 🧠 Memory Trick
> Lateral movement = **"Hopping from room to room"** inside a building you've broken into.

---

## 7. SANS Incident Response Steps

### One-Liner
> **P-I-C-E-R-L-R**: The 7-step playbook every SOC analyst follows during a security incident.

### Interview Answer
"The SANS IR framework has 7 phases: **Preparation** (build the team & tools), **Identification** (detect & triage the alert), **Containment** (stop the bleeding), **Eradication** (remove the root cause), **Recovery** (restore systems), **Lessons Learned** (what went wrong & how to improve), and **Reporting** (document everything)."

### The 7 Steps Explained

```
┌─────────────────────────────────────────────────────┐
│  1. PREPARATION    → Build team, tools, policies    │
│  2. IDENTIFICATION → Detect, alert, triage          │
│  3. CONTAINMENT    → Isolate, stop the spread       │
│  4. ERADICATION    → Remove root cause, patch       │
│  5. RECOVERY       → Restore from backup, validate  │
│  6. LESSONS LEARNED→ Post-incident review           │
│  7. REPORTING      → Internal + External reports    │
└─────────────────────────────────────────────────────┘
```

### 🧠 Memory Trick — Use the story:
> **P**olice **I**dentified the **C**rime, **E**liminated the threat, **R**estored order, **L**earned from it, and **R**eported it.

---

## 8. Types of Logs

### One-Liner
> Logs are the **black box recordings** of your IT environment — without them, you're flying blind.

### The 12 Log Types Every SOC Analyst Must Know

| # | Log Type | What It Captures | Example |
|---|----------|------------------|---------|
| 1 | **System** | OS events: boot, crash, shutdown | Windows Event Viewer |
| 2 | **Application** | App-level events | Apache, Nginx, MySQL logs |
| 3 | **Security** | Auth attempts, access control, policy changes | Login success/failure |
| 4 | **Network** | Traffic flow, routing | NetFlow, sFlow, router logs |
| 5 | **Web Server** | HTTP requests/responses | Apache access & error logs |
| 6 | **Database** | Queries, transactions, errors | SQL query logs |
| 7 | **Email** | Email transactions | SMTP logs, Exchange logs |
| 8 | **Authentication** | Login attempts, MFA events | AD auth logs |
| 9 | **Firewall** | Allowed/blocked traffic | Rule matches, packet logs |
| 10 | **IDS/IPS** | Intrusion alerts | Snort, Suricata alerts |
| 11 | **Endpoint** | Device-level activity | EDR logs, AV scan results |
| 12 | **Audit** | Compliance-related events | Access audits, config changes |

### 🧠 Memory Trick
> Think: **"SANSWNDEFIA"** — or just remember the categories: **System, App, Security, Network, Web, Database, Email, Firewall, IDS, Authentication, Endpoint**

---

## 9. Protocol Logs

### What Each Protocol Log Contains

| Protocol | Key Fields Logged |
|----------|------------------|
| **HTTP/HTTPS** | Timestamp, Client IP, Method (GET/POST), URI, Status Code, User-Agent, Referer |
| **DNS** | Timestamp, Client IP, Query Name, Query Type (A/AAAA/MX), Response Code |
| **SMTP** | Timestamp, Client IP, Sender, Recipient, Message ID, Status Code |
| **FTP** | Timestamp, Client IP, Username, Command (RETR/STOR), File Path, Transfer Size |
| **SSH** | Timestamp, Client IP, Username, Auth Method (password/key), Result, Commands |
| **IMAP/POP3** | Timestamp, Client IP, Username, Command (LOGIN/FETCH), Result |
| **Kerberos** | Timestamp, Client IP, Username, Ticket Type (TGT/Service), Result |

### 🧠 Interview Tip
> "In a SOC investigation, I correlate logs across protocols. For example, a suspicious DNS query → then HTTP traffic to the resolved IP → then SMTP logs showing data exfiltration."

---

## 10. Windows Event IDs

> [!IMPORTANT]
> These are the **MOST ASKED** Event IDs in SOC interviews. Memorize these!

### 🔐 Security Log — Authentication Events

| Event ID | What Happened | Why It Matters |
|----------|--------------|----------------|
| **4624** | ✅ Successful logon | Normal — but check for unusual times/locations |
| **4625** | ❌ Failed logon | Multiple = possible brute force |
| **4648** | Logon with explicit credentials | Could indicate pass-the-hash |
| **4672** | Special privileges assigned | Admin logon — watch for unexpected ones |
| **4720** | User account created | New account by attacker? |
| **4740** | Account locked out | Brute force evidence |

### 👤 Account Management Events

| Event ID | What Happened |
|----------|--------------|
| **4722** | Account enabled |
| **4723** | Password change attempt |
| **4724** | Password reset attempt |
| **4725** | Account disabled |
| **4726** | Account deleted |
| **4732** | Member added to local security group |
| **4738** | Account changed |
| **4767** | Account unlocked |

### ⏰ Scheduled Tasks (Persistence Detection!)

| Event ID | What Happened |
|----------|--------------|
| **4698** | Scheduled task created ⚠️ |
| **4699** | Scheduled task deleted |
| **4700** | Scheduled task enabled |
| **4701** | Scheduled task disabled |

### 🔍 Process & Audit Events

| Event ID | What Happened |
|----------|--------------|
| **4688** | New process created (track malicious executables) |
| **4689** | Process exited |
| **4719** | Audit policy changed ⚠️ |

### ⚡ System Events

| Event ID | What Happened |
|----------|--------------|
| **6005** | Event log service started |
| **6006** | Event log service stopped |
| **6008** | Unexpected shutdown |
| **41** | Kernel-Power: system rebooted without clean shutdown |

### 🧠 Memory Trick for Top 5 Event IDs
> **"4-6-2-4, 4-6-2-5, 4-6-4-8, 4-6-7-2, 4-7-2-0"**  
> → **Success, Fail, ExplicitCreds, AdminPrivs, NewAccount**  
> Think: **"S-F-E-A-N"** = **S**uccessful **F**ailed **E**xplicit **A**dmin **N**ew

---

## 11. Kerberos Authentication

### One-Liner
> Kerberos is a **ticket-based authentication system** — like getting a movie ticket from a box office, then showing it to the usher.

### How Kerberos Works (6 Steps)

```
┌──────────┐         ┌──────────┐         ┌──────────┐
│   USER   │         │    KDC   │         │  SERVER  │
│ (Client) │         │ (AS+TGS) │         │(Resource)│
└────┬─────┘         └────┬─────┘         └────┬─────┘
     │                     │                     │
     │ 1. "I want access"  │                     │
     │ ──────────────────►  │                     │
     │                     │                     │
     │ 2. Here's your TGT  │                     │
     │ ◄──────────────────  │                     │
     │   (encrypted with    │                     │
     │    user's password)  │                     │
     │                     │                     │
     │ 3. TGT + "I need    │                     │
     │    Service X"        │                     │
     │ ──────────────────►  │                     │
     │                     │                     │
     │ 4. Here's Service   │                     │
     │    Ticket (TGS)      │                     │
     │ ◄──────────────────  │                     │
     │                     │                     │
     │ 5. Service Ticket ──────────────────────► │
     │                     │                     │
     │ 6. Access Granted ◄──────────────────────│
     │                     │                     │
```

### 3 Key Components
| Component | Role |
|-----------|------|
| **AS (Authentication Server)** | Verifies identity, issues TGT |
| **TGS (Ticket Granting Server)** | Issues service tickets using TGT |
| **Database** | Stores user credentials |

### ⚔️ Kerberos Attacks (MUST KNOW for interviews)

| Attack | How It Works | Severity |
|--------|-------------|----------|
| **Pass-the-Ticket (PtT)** | Steal a Kerberos ticket and reuse it | 🔴 High |
| **Pass-the-Hash (PtH)** | Use stolen NTLM hash to authenticate | 🔴 High |
| **Overpass-the-Hash** | Use NTLM hash to request Kerberos tickets | 🔴 High |
| **Golden Ticket** | Forge a TGT with domain admin rights using KRBTGT hash | 🔴🔴 Critical |

### 🧠 Memory Trick
> **Golden Ticket** = Willy Wonka's golden ticket — it gives you **unlimited access to everything** forever!

---

## 12. SAM & NTLM

### SAM (Security Accounts Manager)

| Aspect | Detail |
|--------|--------|
| **What** | Database file storing usernames + password hashes |
| **Where** | `C:\Windows\System32\config\SAM` |
| **Registry** | `HKEY_LOCAL_MACHINE\SAM` |
| **Protected by** | LSASS (Local Security Authority Subsystem Service) |
| **Purpose** | Authenticate local user logins |

### NTLM (NT LAN Manager)

**How NTLM Works (3-step handshake):**
```
Client ──── 1. NEGOTIATE ────► Server
       ◄─── 2. CHALLENGE ─────        (Server sends random nonce)
       ──── 3. AUTHENTICATE ──►        (Client sends hashed response)
```

| Aspect | Detail |
|--------|--------|
| **Type** | Challenge-response authentication protocol |
| **Used when** | Kerberos can't be used (non-domain, legacy systems) |
| **Weakness** | Vulnerable to relay attacks, pass-the-hash, brute force |
| **Versions** | NTLMv1 (weak) → NTLMv2 (stronger, uses HMAC-MD5) |

### 🧠 Memory Trick
> **SAM = the safe** where passwords are stored  
> **NTLM = the old lock** (use Kerberos — the newer, better lock — whenever possible!)

---

## 13. Phishing Emails

### One-Liner
> Fake emails pretending to be legit, designed to **steal your credentials or install malware**.

### 4 Types of Phishing

| Type | Target | Example |
|------|--------|---------|
| **Spear Phishing** | Specific person/org | "Hi John, please review this invoice from your boss" |
| **Clone Phishing** | Copy of real email | Exact copy of a real invoice but with a malicious link |
| **Whaling** | Executives/VIPs | Email impersonating the CEO requesting a wire transfer |
| **Vishing/Smishing** | Voice calls / SMS | "Your bank account is locked. Call this number..." |

### 4 Common Tactics
1. **Urgency & Fear** — "Your account will be locked in 24 hours!"
2. **Spoofed Addresses** — `support@paypal.com` vs `support@paipal.com`
3. **Compelling Subject Lines** — "Urgent: Invoice Overdue"
4. **Malicious Links/Attachments** — Links to fake login pages or malware downloads

### 🔍 How to Identify a Phishing Email
1. Check sender's **email address** for misspellings
2. **Hover over links** (don't click!) to see the real URL
3. Look for **poor grammar** and spelling errors
4. Be wary of **urgency** and unusual requests
5. **Verify** directly with the supposed sender

### 📋 What to Collect During Email Investigation
| Artifact | Why |
|----------|-----|
| Sender email address | Identify the attacker |
| Sender IP address | Trace origin |
| Subject line | Pattern matching |
| Recipient email | Scope of attack |
| Reply-to address | Often different from sender |
| Date/time | Timeline |
| URL links (expanded) | Check reputation |
| Attachment name | File analysis |
| Attachment hash (MD5/SHA256) | Malware lookup on VirusTotal |

### Attacker Evasion Techniques
- Use **newly created domains** (no reputation yet)
- Use **non-blacklisted SMTP servers**
- Employ **sandbox evasion** techniques

### 🧠 Memory Trick
> **S-C-W-V**: **S**pear, **C**lone, **W**haling, **V**ishing — Think: "**S**ome **C**riminals **W**ant **V**ictims"

---

## 14. SPF, DKIM & DMARC

### One-Liner
> Three protocols that work together to **prove an email is really from who it claims to be**.

### The Trio Explained

| Protocol | What It Checks | Analogy |
|----------|---------------|---------|
| **SPF** | "Is this mail server **authorized** to send for this domain?" | Checking the **return address** on a letter |
| **DKIM** | "Was this email **tampered with** in transit?" | A **wax seal** on the envelope |
| **DMARC** | "What should I **do** if SPF or DKIM fails?" | The **policy** (reject, quarantine, or accept) |

### How Each Works

**SPF (Sender Policy Framework)**
```
DNS Record:  v=spf1 ip4:192.168.0.1 include:spf.google.com -all
             ↑                                                 ↑
    "Only these servers can send for us"         "Reject all others"
```

**DKIM (DomainKeys Identified Mail)**
```
Sending Server: Signs email with PRIVATE key → adds DKIM-Signature header
Receiving Server: Gets PUBLIC key from DNS → verifies signature
Result: Email content integrity confirmed ✅
```

**DMARC (Domain-based Message Authentication, Reporting & Conformance)**
```
DNS Record:  v=DMARC1; p=reject; rua=mailto:dmarc-reports@example.com
             ↑         ↑ policy    ↑ send reports here
```
- **p=none** → just monitor
- **p=quarantine** → send to spam
- **p=reject** → block completely

### Combined Flow
```
Email arrives → Check SPF ✅ → Check DKIM ✅ → Apply DMARC policy → DELIVER
Email arrives → Check SPF ❌ → Check DKIM ❌ → Apply DMARC policy → REJECT/QUARANTINE
```

### 🧠 Memory Trick
> **SPF** = "**S**erver **P**ermission **F**ile" (who can send?)  
> **DKIM** = "**D**igital **K**ey for **I**ntegrity of **M**ail" (was it tampered?)  
> **DMARC** = "**D**ecision **M**aker for **A**uthentication **R**ules & **C**ompliance" (what to do about failures?)

---

## 15. Email Flow

### One-Liner
> Email travels through **6 stages**: Compose → Submit → Route → Deliver → Store → Read

### The Complete Flow

```
Step 1: COMPOSE         → MUA (Mail User Agent) — Outlook, Gmail
          ↓
Step 2: SUBMIT           → MSA (Mail Submission Agent) — Port 587/465
          ↓
Step 3: ROUTE            → MTA (Mail Transfer Agent) — DNS MX lookup
          ↓
Step 4: DELIVER          → MX Server — SPF/DKIM/DMARC checks happen here
          ↓
Step 5: STORE            → MDA (Mail Delivery Agent) — stores in mailbox
          ↓
Step 6: READ             → MUA retrieves via IMAP (143/993) or POP3 (110/995)
```

### Key Ports to Remember

| Protocol | Port | Secure Port |
|----------|------|-------------|
| **SMTP Submission** | 587 | 465 (SSL) |
| **IMAP** | 143 | 993 (TLS) |
| **POP3** | 110 | 995 (TLS) |

### IMAP vs POP3
| | IMAP | POP3 |
|---|------|------|
| **Emails** | Stay on server | Downloaded, usually deleted from server |
| **Access** | Multiple devices | Typically one device |
| **Best for** | Modern use | Legacy/offline use |

### 🧠 Memory Trick
> **"MUA → MSA → MTA → MX → MDA → MUA"**  
> Think: **"My Mail Moves Through Many Doors And Back"**

---

## 16. Malicious Activity Indicators

### The 7 Categories of Suspicious Behavior

| Category | Red Flags 🚩 |
|----------|-------------|
| **1. Network** | Large data transfers to external IPs, unusual port activity, connections to known malicious IPs, internal scanning |
| **2. User Behavior** | Multiple failed logins, logins from unfamiliar locations, access to unusual data |
| **3. Endpoint** | Unknown processes running, unauthorized PowerShell/CMD, file encryption (ransomware), registry changes |
| **4. Application** | Apps crashing, unauthorized external connections, suspicious macros/scripts |
| **5. Email** | Phishing indicators, spoofed addresses, high volume outbound emails |
| **6. Logs** | Unexplained gaps/deletions in logs, privilege escalation attempts |
| **7. External** | Threat intel alerts, compromised credentials on dark web |

### 🧠 Interview Tip
> When asked "How would you detect malicious activity?", organize your answer by these 7 categories!

---

## 17. Defensive Measures & Detection

### 6 Key Defensive Strategies

| Strategy | Tool/Approach |
|----------|--------------|
| **Network Monitoring** | IDS/IPS + SIEM |
| **User Behavior Analytics** | UEBA tools — detect anomalies |
| **Endpoint Protection** | EDR solutions |
| **Access Controls** | Least Privilege (PoLP) + MFA |
| **Email Security** | Email filtering + user training |
| **Regular Testing** | Audits + Penetration Testing |

---

## 18. NetBIOS & SMB

### NetBIOS

| Aspect | Detail |
|--------|--------|
| **What** | Legacy networking protocol for LAN communication |
| **OSI Layer** | Session Layer (Layer 5) |
| **Ports** | **137** (Name Service), **138** (Datagram), **139** (Session) |
| **Status** | Mostly replaced by TCP/IP but still in some legacy systems |

### SMB (Server Message Block)

| Aspect | Detail |
|--------|--------|
| **What** | Network file sharing protocol |
| **OSI Layer** | Application Layer (Layer 7) |
| **Port** | **445** |
| **Versions** | SMB1 (vulnerable!) → SMB2 → SMB3 (encrypted) |
| **Famous Exploit** | **WannaCry ransomware** exploited SMB1 (EternalBlue) |

### 🧠 Memory Trick
> **SMB1 = WannaCry** — always disable SMB1!  
> NetBIOS ports: **137-138-139** (three consecutive numbers starting from 137)

---

## 19. Digital Certificates & HTTPS

### Digital Certificates
| Component | Purpose |
|-----------|---------|
| **Public Key** | Encrypt data / verify signatures |
| **Owner Identity** | Who the cert belongs to |
| **Issuer (CA)** | Trusted authority that verified the owner |
| **Digital Signature** | CA's signature proving authenticity |
| **Validity Period** | Start and expiry dates |

### How HTTPS Works (The Handshake)

```
┌──────────┐                           ┌──────────┐
│  CLIENT  │                           │  SERVER  │
│(Browser) │                           │(Website) │
└────┬─────┘                           └────┬─────┘
     │                                      │
     │ 1. CLIENT HELLO ───────────────────► │  (supported TLS versions, ciphers)
     │                                      │
     │ ◄─────────────────── 2. SERVER HELLO │  (chosen TLS version, cipher + certificate)
     │                                      │
     │ 3. VERIFY CERTIFICATE                │  (check CA, validity, domain match)
     │                                      │
     │ 4. KEY EXCHANGE ───────────────────► │  (generate shared session key)
     │                                      │
     │ ◄══════ 5. ENCRYPTED DATA ═════════► │  (symmetric encryption with session key)
     │                                      │
```

### Interview Summary
"HTTPS uses a **TLS handshake** to establish a secure connection. The client and server exchange hellos, the server presents its **certificate** (verified against a trusted CA), they perform a **key exchange** to create a shared **symmetric session key**, and all subsequent data is **encrypted** with that key."

### 🧠 Memory Trick
> **"Client Hello → Server Hello → Certificate Check → Key Exchange → Encrypted Talk"**  
> = **"C-S-C-K-E"** = "**C**ars **S**top, **C**heck **K**eys, **E**nter"

---

## 20. SIEM Solutions

### One-Liner
> **SIEM = Security's Central Nervous System** — it collects, correlates, and alerts on all security events.

### What SIEM Stands For
- **S**ecurity **I**nformation (**log collection & analysis**) +
- **E**vent **M**anagement (**real-time monitoring & correlation**)

### 7 Key Functions

| Function | What It Does |
|----------|-------------|
| 1. **Data Collection** | Collects logs from everywhere (network, endpoints, apps, cloud) |
| 2. **Normalization** | Converts different log formats into a standard format |
| 3. **Correlation** | Connects related events to detect patterns |
| 4. **Real-time Monitoring** | Watches events as they happen |
| 5. **Alerting** | Triggers alerts based on rules/thresholds |
| 6. **Forensic Analysis** | Deep-dive investigation of incidents |
| 7. **Compliance Reporting** | Generates audit reports for regulations |

### SIEM Challenges
- ⚠️ **Complex** to implement and manage
- ⚠️ Requires **tuning** to reduce false positives
- ⚠️ Needs **skilled analysts** to operate effectively

### 🧠 Memory Trick
> SIEM = **"See Everything In Motion"** — it's your security surveillance camera system for ALL logs.

---

## 21. EDR vs XDR

### One-Liner
> **EDR** watches endpoints only | **XDR** watches **everything** (endpoints + network + email + cloud)

### Comparison

| Aspect | EDR | XDR |
|--------|-----|-----|
| **Scope** | Endpoints only | Endpoints + Network + Email + Cloud |
| **Visibility** | Deep endpoint visibility | Unified cross-layer visibility |
| **Detection** | Endpoint threats | Complex multi-stage attacks |
| **Response** | Isolate endpoints | Automated response across all layers |
| **Data Sources** | Process, file, registry, network on endpoint | EDR + NDR + email + cloud telemetry |
| **Example** | CrowdStrike Falcon | Microsoft Sentinel + Defender XDR |

### Key Term: Dwell Time
> **Dwell Time** = how long an attacker stays undetected in your environment. EDR/XDR reduce this!

### 🧠 Memory Trick
> **EDR = "E"ndpoint only** (single room security camera)  
> **XDR = "X"tended** (security cameras covering the ENTIRE building)

---

## 22. IDS vs IPS vs Firewall

### Quick Comparison

| | IDS | IPS | Firewall |
|---|-----|-----|----------|
| **What** | Detects intrusions | Detects AND prevents intrusions | Controls traffic flow |
| **Action** | Alerts only (passive) | Alerts + blocks (active) | Allow/deny based on rules |
| **Position** | Monitors traffic (TAP/SPAN) | Inline (traffic flows through it) | Network boundary |
| **Analogy** | Security **camera** | Security **guard** | **Gate** with a checkpoint |

### Key Definitions
- **Event** = a log of a specific action at a specific time (e.g., user login)
- **Flow** = a record of network activity between two hosts over a period (seconds to hours)

---

## 23. Firewall Types

### 7 Types of Firewalls

| Type | Layer | Key Feature | Pros/Cons |
|------|-------|-------------|-----------|
| **Packet-Filtering** | Network (L3) | Examines individual packets | Simple but can be bypassed |
| **Stateful Inspection** | Network (L3-4) | Tracks connection state | More secure but resource-heavy |
| **Proxy (App Gateway)** | Application (L7) | Intermediary between users & services | Deep inspection but adds latency |
| **NGFW** | All layers | FW + IPS + DPI + app awareness | Comprehensive but expensive |
| **UTM** | All layers | All-in-one security appliance | Simple management but single point of failure |
| **WAF** | Application (L7) | Protects web apps (HTTP/HTTPS) | Stops SQL injection, XSS |
| **Software Firewall** | Host-based | Installed on individual devices | Flexible but uses system resources |

### Firewall Log Fields
```
Date/Time | Source IP | Destination IP | Source Port | Dest Port | Action (Allow/Deny) | Packets Sent/Received
```

### WAF Specifically
- Monitors, filters, and blocks HTTP traffic to/from web applications
- Works at **Application Layer** (Layer 7)
- Prevents: SQL Injection, XSS, and other web-based attacks

### 🧠 Memory Trick
> **"P-S-P-N-U-W-S"** = **P**acket, **S**tateful, **P**roxy, **N**GFW, **U**TM, **W**AF, **S**oftware
> Think: "**P**lease **S**top **P**eople **N**ow **U**sing **W**eird **S**tuff"

---

## 24. Security Definitions

### CIA Triad (The Foundation!)

```
         Confidentiality
              ▲
             / \
            /   \
           /     \
          / CIA   \
         / Triad   \
        /___________\
Integrity            Availability
```

| Principle | Meaning | How to Achieve |
|-----------|---------|----------------|
| **Confidentiality** | Only authorized people see the data | Encryption, access controls |
| **Integrity** | Data is accurate and untampered | Checksums, version control, validation |
| **Availability** | Data is accessible when needed | Redundancy, backups, DR plans |

### Other Key Definitions

| Term | One-Line Definition |
|------|-------------------|
| **Authentication** | "Are you who you say you are?" (passwords, biometrics, MFA) |
| **Authorization** | "What are you allowed to do?" (RBAC, least privilege) |
| **Risk Management** | Identify, assess, and mitigate risks |
| **Vulnerability Management** | Scan → find vulns → patch them |
| **Incident Response** | Plan to contain, investigate, recover from attacks |
| **Zero Trust** | "**Never trust, always verify**" — even internal users |
| **Trust but Verify** | Always verify even trusted entities |
| **Attack Surface** | All potential vulnerabilities a threat actor could exploit |

### Detection Categories

| | Alert Triggered | No Alert |
|---|:---:|:---:|
| **Actual Threat** | ✅ **True Positive** | ❌ **False Negative** (DANGEROUS!) |
| **No Threat** | ⚠️ **False Positive** (annoying) | ✅ **True Negative** |

### 🧠 Memory Trick
> - **Positive = Alert fires** | **Negative = No alert**
> - **True = Correct** | **False = Wrong**
> - **False Negative is the worst** — real attack, no alert! 💀

---

## 25. Common Vulnerabilities

| # | Vulnerability | Impact |
|---|--------------|--------|
| 1 | **Unpatched Software** | Known exploits used by attackers |
| 2 | **Weak Passwords** | Easy brute force / credential stuffing |
| 3 | **Lack of Encryption** | Data exposed in transit/at rest |
| 4 | **SQL Injection** | Unauthorized database access |
| 5 | **Cross-Site Scripting (XSS)** | Inject malicious scripts into web pages |
| 6 | **Phishing** | Credential theft, malware installation |
| 7 | **Insider Threats** | Employees misuse access |
| 8 | **Social Engineering** | Manipulate people into revealing info |
| 9 | **Remote Work Risks** | Unsecured home networks, data leakage |

---

## 26. Detection Categories

### The 2x2 Matrix (Favorite Interview Question!)

```
                     ACTUALLY MALICIOUS?
                    ┌─────────┬──────────┐
                    │   YES   │    NO    │
         ┌──────────┼─────────┼──────────┤
ALERT    │   YES    │   TP ✅  │   FP ⚠️  │
FIRED?   ├──────────┼─────────┼──────────┤
         │   NO     │   FN 💀  │   TN ✅  │
         └──────────┴─────────┴──────────┘
```

| Category | Meaning | Impact |
|----------|---------|--------|
| **True Positive (TP)** | Real attack → Alert fired ✅ | System working correctly! |
| **True Negative (TN)** | No attack → No alert ✅ | System working correctly! |
| **False Positive (FP)** | No attack → Alert fired ⚠️ | Wastes analyst time |
| **False Negative (FN)** | Real attack → No alert 💀 | **MOST DANGEROUS** — missed attack! |

---

## 27. OSI Layer Attacks

### Attacks Mapped to Each Layer

| Layer | Name | Common Attacks |
|-------|------|---------------|
| **7** | Application | DNS Zone Transfer/Spoofing, Web attacks (SQLi, XSS), FTP brute force, Telnet brute force |
| **6** | Presentation | SSL Stripping |
| **5** | Session | Session Hijacking |
| **4** | Transport | **TCP SYN Flood**, TCP Session Hijacking, TCP Reset, **UDP Flooding** |
| **3** | Network | IP Spoofing, Smurf Attack, **ICMP Flooding**, DHCP Spoofing/Starvation, IPv6 Tunneling |
| **2** | Data Link | **ARP Spoofing/Poisoning**, **MAC Flooding** |
| **1** | Physical | Wire tapping, hardware tampering |

### 🧠 Interview Tip
> "When investigating, I consider which OSI layer the attack targets to narrow down my analysis — Layer 3 attacks show in network/firewall logs, Layer 7 attacks show in web/application logs."

---

## 28. MITRE ATT&CK Framework

### One-Liner
> A **global knowledge base** of real-world attacker tactics and techniques used to improve detection and response.

### Interview Answer
"MITRE ATT&CK stands for **Adversarial Tactics, Techniques, and Common Knowledge**. It maps out the different stages and methods attackers use in real-world attacks. As a SOC analyst, I use it to:
- **Map alerts** to specific techniques
- **Identify gaps** in our detection coverage
- **Understand attacker behavior** during investigations
- **Build detection rules** based on known techniques"

### Key Tactics (The Attack Lifecycle)
```
Reconnaissance → Resource Development → Initial Access → Execution →
Persistence → Privilege Escalation → Defense Evasion → Credential Access →
Discovery → Lateral Movement → Collection → C2 → Exfiltration → Impact
```

---

## 29. Incident Response Playbooks

### 🔴 Playbook 1: Brute Force Attack

| Step | Action |
|------|--------|
| **Detect** | Multiple failed login attempts (Event ID **4625**) in a short period |
| **Investigate** | AD logs, Application logs, OS logs → Contact the user |
| **Respond** | If not legitimate → **Disable the account** + **Block attacker IP** |

---

### 🔴 Playbook 2: Botnet Infection

| Step | Action |
|------|--------|
| **Detect** | Connection to suspicious IPs, abnormally high network traffic |
| **Investigate** | Network traffic, OS logs (new processes), Contact server owner |
| **Respond** | **Isolate server** → Remove malicious processes → Patch the vulnerability |

---

### 🔴 Playbook 3: Ransomware

| Step | Action |
|------|--------|
| **Detect** | AV alerts, connection to suspicious IPs, files encrypted with unusual extensions |
| **Investigate** | AV logs, OS logs, Account logs, Network traffic |
| **Respond** | **Isolate machine** → Run AV scan → Restore from backup → Patch |
| **Log Sources** | Firewall logs, Network logs, AV/Anti-malware logs |

---

### 🔴 Playbook 4: Data Exfiltration

| Step | Action |
|------|--------|
| **Detect** | High outbound traffic, connections to cloud storage (Dropbox, Google Drive) |
| **Investigate** | Network traffic, Proxy logs, OS logs |
| **Respond (Insider)** | Contact manager → Full forensics |
| **Respond (External)** | **Isolate machine** → Disconnect from network |

---

### 🔴 Playbook 5: APT (Advanced Persistent Threat)

| Step | Action |
|------|--------|
| **Detect** | Suspicious IP connections, high traffic, off-hours access, new admin accounts created |
| **Investigate** | Network traffic, Access logs, OS logs (processes, connections, users) |
| **Respond** | **Isolate machine** → Start formal forensics process |

---

### 🔴 Playbook 6: Phishing Attack

| Step | Action |
|------|--------|
| **Detect** | Suspicious email reported by user or email security tool |
| **Investigate** | Sender address, links, attachments (check hash on VirusTotal) |
| **Respond** | Report to IT → Block sender domain → If attachment downloaded: run malware scan |
| **Logs** | Email Server logs, Firewall logs, Endpoint Security logs |

---

### 🔴 Playbook 7: Data Breach

| Step | Action |
|------|--------|
| **Detect** | Unauthorized access to sensitive data |
| **Investigate** | Access logs, System event logs, Network logs |
| **Respond** | Disconnect affected systems → Patch vulnerabilities → Notify affected parties |

---

### 🧠 Universal Incident Response Pattern (Remember This!)

> For **ANY** incident, the approach is always:
> ```
> 1. How to DETECT it?       → What alerts/logs tell you?
> 2. How to RESPOND?         → Contain, investigate, communicate
> 3. How to MITIGATE?        → Fix root cause, prevent recurrence
> ```

---

## 🎯 Quick Interview Cheat Sheet

### If asked "Walk me through investigating an alert..."
```
1. Understand the alert (source, severity, affected assets)
2. Gather context (SIEM logs, threat intel, affected user)
3. Correlate with other events (look for patterns)
4. Determine TP or FP (evidence-based decision)
5. If TP → Contain, Eradicate, Recover (SANS steps)
6. Document everything
```

### If asked "What tools do you use?"
| Category | Tools |
|----------|-------|
| **SIEM** | Splunk, QRadar, Microsoft Sentinel, ELK |
| **EDR** | CrowdStrike, Carbon Black, Microsoft Defender |
| **Threat Intel** | VirusTotal, AbuseIPDB, IBM X-Force, MITRE ATT&CK |
| **Network** | Wireshark, Zeek, tcpdump |
| **Email** | PhishTool, MX Toolbox, Header Analyzer |

### If asked "What's your approach to security?"
> "I follow a **defense-in-depth** strategy — multiple layers of security (network, endpoint, email, user awareness) — combined with **Zero Trust** principles (never trust, always verify) and continuous monitoring through **SIEM** and **EDR/XDR** platforms."

---

> [!TIP]
> **Best study approach**: Read each section's **One-Liner** first, then the **Interview Answer**. Use the **Memory Tricks** to recall the details. Practice explaining each concept out loud as if you're in an interview.

---
*Generated from "Security Operations Centre (SOC) Concepts" — 41 pages covering core SOC knowledge for interview preparation.*$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$SOC_TP_FP_Checklist$VELSEC$, $VELSEC$Soc Tp Fp Checklist$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['SOC']::TEXT[], $VELSEC$# 🔍 SOC Detection Checklist — TP or FP?

> **Purpose**: A step-by-step checklist to determine if a detection/alert is a **True Positive (TP)** or **False Positive (FP)**.  
> **How to use**: When an alert fires → go to the matching section → follow the checklist → make your decision.

---

## Quick Recall: What Are We Deciding?

```
┌─────────────────────────────────────────────────────────┐
│                  IS THERE A REAL THREAT?                 │
│                                                         │
│              YES (Real Attack)    NO (No Attack)         │
│   ┌─────────┼────────────────────┼──────────┐           │
│   │ ALERT   │  ✅ True Positive  │ ⚠️ False  │           │
│   │ FIRED   │     (Correct!)     │  Positive │           │
│   ├─────────┼────────────────────┼──────────┤           │
│   │ NO      │  💀 False Negative │ ✅ True   │           │
│   │ ALERT   │    (DANGEROUS!)    │ Negative  │           │
│   └─────────┴────────────────────┴──────────┘           │
└─────────────────────────────────────────────────────────┘
```

> **Your job as a SOC analyst**: Every alert starts as "Unknown" — your investigation turns it into TP or FP.

---

## 🧭 Universal First-Response Checklist (Do This EVERY Time)

Before diving into specific detection types, run through these **5 universal checks**:

- [ ] **1. READ the alert details** — Source, severity, timestamp, affected asset, triggered rule name
- [ ] **2. CHECK the user/source** — Is this a known user? Known system? Service account?
- [ ] **3. CHECK the timing** — Did this happen during business hours or off-hours?
- [ ] **4. CHECK history** — Has this alert fired before for this user/system? Was it TP or FP last time?
- [ ] **5. CHECK threat intel** — Are any IPs, domains, or hashes flagged in VirusTotal, AbuseIPDB, or your TI feeds?

> Once done, move to the **specific checklist** below based on your alert type.

---

## 1. 🔐 Brute Force Detection

**Alert Trigger**: Multiple failed login attempts (Event ID **4625**) in a short period

### Step-by-Step Checklist

| # | Check | How to Verify | TP Signal 🔴 | FP Signal 🟢 |
|---|-------|---------------|-------------|-------------|
| 1 | **Source IP** | Check the IP in SIEM — is it internal or external? | External / unknown IP | Internal / known VPN IP |
| 2 | **Number of failures** | Count failed attempts in time window | 10+ failures in < 5 min | 2-3 failures (user typo) |
| 3 | **Target accounts** | One account or many? | Multiple accounts targeted | Single account (user forgot password) |
| 4 | **Success after failures?** | Check for Event ID **4624** after the 4625s | ✅ Yes → Compromised! (TP) | No success → attack failed |
| 5 | **Time of activity** | Business hours or off-hours? | 3 AM on a weekend | 9 AM on Monday |
| 6 | **Geo-location** | Where is the source IP from? | Foreign country, unusual location | User's normal location |
| 7 | **Contact the user** | Call/message the user directly | "I didn't try to log in" | "Yes, I forgot my password" |

### Decision Flow

```
Multiple 4625 events?
  ├── YES
  │   ├── From external/unknown IP?
  │   │   ├── YES → Followed by 4624 (success)?
  │   │   │   ├── YES → 🔴 TP — Account Compromised! → Disable account, block IP
  │   │   │   └── NO  → 🟡 TP (Attack attempted, not successful) → Block IP, monitor
  │   │   └── NO (internal IP)
  │   │       ├── User confirms activity? → 🟢 FP — Password issue
  │   │       └── User denies activity?   → 🔴 TP — Internal threat
  └── NO → 🟢 FP — Normal failed login
```

### Logs to Check
- [ ] Windows Security Logs (Event ID 4625, 4624, 4740)
- [ ] Active Directory logs
- [ ] VPN / Remote Access logs
- [ ] SIEM correlation rules

---

## 2. 📧 Phishing Email Detection

**Alert Trigger**: Suspicious email reported by user or caught by email security gateway

### Step-by-Step Checklist

| # | Check | How to Verify | TP Signal 🔴 | FP Signal 🟢 |
|---|-------|---------------|-------------|-------------|
| 1 | **Sender address** | Inspect the "From" field carefully | Misspelled domain (e.g., `@paypa1.com`) | Exact match to legitimate domain |
| 2 | **SPF check** | View email headers → look for SPF result | `SPF: FAIL` | `SPF: PASS` |
| 3 | **DKIM check** | View email headers → look for DKIM result | `DKIM: FAIL` | `DKIM: PASS` |
| 4 | **DMARC check** | View email headers → look for DMARC result | `DMARC: FAIL` | `DMARC: PASS` |
| 5 | **Reply-to address** | Compare reply-to with sender | Different from sender address | Same as sender or not present |
| 6 | **URLs in body** | Hover over / extract all URLs | URL domain ≠ display text, uses URL shortener | Legitimate known URL |
| 7 | **URL reputation** | Check URLs in VirusTotal / URLhaus | Flagged as malicious | Clean reputation |
| 8 | **Attachments** | Check file type and hash | `.exe`, `.js`, `.scr`, `.bat`, macro-enabled `.docm` | `.pdf`, `.png` from known sender |
| 9 | **Attachment hash** | Get MD5/SHA256 → check VirusTotal | Hash flagged by multiple AV engines | Clean / 0 detections |
| 10 | **Email content** | Read the body text | Urgency, threats, "click now", grammar errors | Normal business communication |
| 11 | **Who else received?** | Search SIEM for same subject/sender | Sent to many users (campaign) | Only this recipient |
| 12 | **Did user click?** | Check proxy/web logs for URL visit | User visited the malicious URL | No click recorded |

### Decision Flow

```
Suspicious email alert?
  ├── Check SPF/DKIM/DMARC
  │   ├── ALL PASS + Legitimate domain → 🟢 Likely FP
  │   └── ANY FAIL or spoofed domain
  │       ├── Contains malicious URL/attachment?
  │       │   ├── YES
  │       │   │   ├── User clicked/opened?
  │       │   │   │   ├── YES → 🔴 TP — URGENT! → Isolate endpoint, reset creds
  │       │   │   │   └── NO  → 🔴 TP — Blocked → Block sender, purge from mailboxes
  │       │   └── NO → 🟡 Suspicious but not directly malicious → Monitor, block sender
  └── Legitimate email miscategorized → 🟢 FP → Whitelist sender
```

### Artifacts to Collect
- [ ] Sender email address
- [ ] Sender IP address
- [ ] Email subject line
- [ ] Recipient email addresses (all)
- [ ] Reply-to email address
- [ ] Date/time
- [ ] All URLs (expanded if shortened)
- [ ] Attachment names
- [ ] Attachment hash (MD5 / SHA256)
- [ ] Email headers (full)

### Logs to Check
- [ ] Email Server / Gateway logs
- [ ] Proxy / Web filter logs (did user click?)
- [ ] Endpoint / EDR logs (did attachment execute?)
- [ ] DNS logs (did endpoint resolve the malicious domain?)
- [ ] Firewall logs (outbound connection to malicious IP?)

---

## 3. 💀 Ransomware Detection

**Alert Trigger**: AV/EDR alert for ransomware, files encrypted, ransom note displayed

### Step-by-Step Checklist

| # | Check | How to Verify | TP Signal 🔴 | FP Signal 🟢 |
|---|-------|---------------|-------------|-------------|
| 1 | **AV/EDR alert** | Review the alert details and signature name | Known ransomware family detected | Generic / heuristic low-confidence alert |
| 2 | **File activity** | Check for mass file renames/encryption | Many files with new extensions (`.encrypted`, `.locked`) | Normal file operations |
| 3 | **Ransom note** | Look for ransom note files on disk | `README.txt`, `HOW_TO_DECRYPT.html` found | No ransom artifacts |
| 4 | **Process activity** | Check EDR for suspicious processes | Unknown process encrypting files rapidly | Known backup / encryption tool |
| 5 | **Network connections** | Check for C2 communication | Outbound connections to suspicious IPs | No unusual connections |
| 6 | **User confirmation** | Contact the endpoint user | "My files are locked, I see a ransom message" | "I was running a legitimate encryption tool" |
| 7 | **Lateral spread** | Check other endpoints for similar activity | Same behavior on multiple machines | Isolated to one machine |

### Decision Flow

```
AV/EDR ransomware alert?
  ├── Files actually encrypted + ransom note present?
  │   ├── YES → 🔴 TP — CRITICAL!
  │   │         → Isolate machine immediately
  │   │         → Check for lateral spread
  │   │         → Activate IR playbook
  │   └── NO
  │       ├── Process known/legitimate? (e.g., BitLocker, backup tool)
  │       │   ├── YES → 🟢 FP — Legitimate encryption activity
  │       │   └── NO  → 🟡 Suspicious — Investigate further, sandbox the file
  └── Heuristic-only detection, no file changes → 🟢 Likely FP → Tune the rule
```

### Logs to Check
- [ ] AV / Anti-malware logs
- [ ] EDR logs (process tree, file activity)
- [ ] Windows Event logs (Event ID 4688 — new process)
- [ ] Firewall logs (outbound C2 traffic)
- [ ] Network flow logs (unusual traffic volume)

---

## 4. 📤 Data Exfiltration Detection

**Alert Trigger**: Large outbound data transfer, connection to cloud storage, unusual upload activity

### Step-by-Step Checklist

| # | Check | How to Verify | TP Signal 🔴 | FP Signal 🟢 |
|---|-------|---------------|-------------|-------------|
| 1 | **Data volume** | Check bytes transferred in proxy/firewall logs | Unusually large upload (GBs) | Normal-sized transfers |
| 2 | **Destination** | Where is data going? | Dropbox, Google Drive, personal email, Mega, unknown IPs | Approved business cloud storage |
| 3 | **User context** | Who is the user? What do they normally do? | User doesn't normally transfer large data | Data analyst doing routine export |
| 4 | **Time** | When did it happen? | Off-hours, weekend | During business hours |
| 5 | **Data type** | What data is being transferred? | Sensitive files, database exports, source code | Marketing materials, public docs |
| 6 | **Authorization** | Was this transfer approved? | No ticket / approval | Change request / approved transfer |
| 7 | **User leaving?** | Check HR — is user on notice period? | Yes, resignation submitted | No, long-term employee |
| 8 | **Endpoint check** | Any malware or suspicious tools? | Unknown upload tools, encrypted archives being created | Standard business tools |

### Decision Flow

```
Large outbound data transfer detected?
  ├── To unauthorized destination (personal cloud, unknown IP)?
  │   ├── YES
  │   │   ├── User on notice period / HR flagged?
  │   │   │   ├── YES → 🔴 TP — Insider Threat → Contact manager, forensics
  │   │   │   └── NO  → Is endpoint compromised (malware)?
  │   │   │       ├── YES → 🔴 TP — External attacker exfiltrating
  │   │   │       └── NO  → 🟡 Investigate — may be policy violation
  │   └── NO (to approved destination)
  │       ├── Volume matches normal pattern? → 🟢 FP
  │       └── Volume abnormally high?        → 🟡 Investigate further
```

### Logs to Check
- [ ] Proxy logs (URL, destination, bytes transferred)
- [ ] DLP (Data Loss Prevention) alerts
- [ ] Firewall logs (outbound connections)
- [ ] Endpoint / EDR logs
- [ ] Cloud access logs (CASB)

---

## 5. 🕸️ Lateral Movement Detection

**Alert Trigger**: Internal scanning, unusual admin tool usage (PsExec, WMI), RDP to unexpected hosts

### Step-by-Step Checklist

| # | Check | How to Verify | TP Signal 🔴 | FP Signal 🟢 |
|---|-------|---------------|-------------|-------------|
| 1 | **Source system** | Is this machine already flagged/compromised? | Yes, previous alert on this host | No prior alerts |
| 2 | **Tool used** | What tool triggered the alert? | PsExec, Mimikatz, WMI, PowerShell remoting | SCCM, Intune, legit admin tool |
| 3 | **User account** | Who initiated the connection? | Compromised account, or unusual account | IT admin performing routine maintenance |
| 4 | **Destination** | Which systems are being accessed? | Servers the user never accesses | Normal systems for this user's role |
| 5 | **Number of targets** | How many systems? | Multiple systems in rapid succession | Single system |
| 6 | **Time** | Business hours? | Off-hours | During maintenance window |
| 7 | **Credential use** | Any pass-the-hash / pass-the-ticket signs? | Event ID 4648, NTLM auth where Kerberos expected | Normal Kerberos authentication |
| 8 | **IT team confirmation** | Is IT doing maintenance/patching? | "No, we have no activity planned" | "Yes, we're patching servers" |

### Decision Flow

```
Lateral movement alert (PsExec, WMI, internal scan)?
  ├── Initiated by IT admin during maintenance?        → 🟢 FP
  ├── Tool = Mimikatz or credential dumping?           → 🔴 TP — Immediate containment!
  ├── User accessing systems they never access?
  │   ├── YES + Off-hours + Multiple targets           → 🔴 TP — Active compromise
  │   └── Single target + business hours               → 🟡 Verify with user/IT
  └── Automated scan from security tool (Nessus, Qualys)? → 🟢 FP
```

### Key Event IDs to Check
- [ ] **4648** — Logon with explicit credentials (Pass-the-Hash indicator)
- [ ] **4624** — Successful logon (Type 3 = network, Type 10 = RDP)
- [ ] **4688** — New process created (look for PsExec, cmd.exe, powershell.exe)
- [ ] **4698** — Scheduled task created (persistence after lateral move)

### Logs to Check
- [ ] Windows Security logs on source AND destination
- [ ] EDR logs (process tree, network connections)
- [ ] Network flow logs (internal traffic patterns)
- [ ] Firewall logs (internal segment traffic)

---

## 6. ⬆️ Privilege Escalation Detection

**Alert Trigger**: Unexpected admin privilege assignment, new admin account, sudo abuse

### Step-by-Step Checklist

| # | Check | How to Verify | TP Signal 🔴 | FP Signal 🟢 |
|---|-------|---------------|-------------|-------------|
| 1 | **Event ID 4672** | Special privileges assigned — to whom? | Unexpected user gets admin rights | Known admin logging in |
| 2 | **Event ID 4720** | New account created — by whom? | Created by non-admin, or unfamiliar account | Created by IT via ticketing system |
| 3 | **Event ID 4732** | Added to admin group — authorized? | No change request/ticket | Matches approved change request |
| 4 | **Process context** | How was the privilege obtained? | Exploit, buffer overflow, unknown binary | sudo with valid justification |
| 5 | **Timing** | When did it happen? | Off-hours, no maintenance window | During approved change window |
| 6 | **Change management** | Is there a matching change ticket? | No ticket exists | Ticket # matches the activity |

### Decision Flow

```
Privilege escalation alert?
  ├── Matches an approved change request / IT ticket?     → 🟢 FP
  ├── New admin account created by unknown user?          → 🔴 TP — Backdoor account!
  ├── 4672 for a non-admin user?
  │   ├── Known exploit / suspicious process?              → 🔴 TP — Active exploitation
  │   └── Application service account?                     → 🟢 FP — Expected behavior
  └── User added to Domain Admins unexpectedly?            → 🔴 TP — Immediate investigation
```

### Logs to Check
- [ ] Windows Security logs (4672, 4720, 4732, 4728)
- [ ] Active Directory audit logs
- [ ] EDR logs (exploit detection, process lineage)
- [ ] Change management / ticketing system

---

## 7. 🪝 Persistence Detection

**Alert Trigger**: New registry autostart entry, new scheduled task, startup folder modification

### Step-by-Step Checklist

| # | Check | How to Verify | TP Signal 🔴 | FP Signal 🟢 |
|---|-------|---------------|-------------|-------------|
| 1 | **What was created?** | Registry key? Scheduled task? Service? | Points to unknown executable | Points to known software (Chrome updater, etc.) |
| 2 | **Who created it?** | Which user/process? | Unknown user, compromised account | SYSTEM or known installer |
| 3 | **Executable path** | Where does the autostart point to? | `C:\Temp\`, `C:\Users\Public\`, random name | `C:\Program Files\` standard path |
| 4 | **File hash** | Hash the executable → check VirusTotal | Flagged as malicious | Clean / known good |
| 5 | **Signed?** | Is the binary digitally signed? | Unsigned or invalid signature | Valid signature from known vendor |
| 6 | **Event ID 4698** | Scheduled task created | Unknown task, suspicious name | Matches known software or IT deployment |
| 7 | **Recent software install?** | Was software installed recently? | No installation recorded | Yes, legitimate software installed today |

### Decision Flow

```
New persistence mechanism detected?
  ├── Created by known software installer?                       → 🟢 FP
  ├── Executable is unsigned + in temp/unusual directory?
  │   ├── Hash flagged on VirusTotal?                             → 🔴 TP — Malware!
  │   └── Hash clean but suspicious path?                         → 🟡 Investigate — sandbox it
  ├── Scheduled task pointing to PowerShell + encoded command?    → 🔴 TP
  └── New service created by SYSTEM during patch cycle?           → 🟢 FP
```

### Logs to Check
- [ ] Windows Security logs (4698, 4697 — service installed)
- [ ] Sysmon logs (Event 1 — process creation, Event 13 — registry modification)
- [ ] EDR logs (autostart enumeration)
- [ ] File system audit logs

---

## 8. 📡 C2 (Command & Control) Communication Detection

**Alert Trigger**: Beaconing traffic to suspicious domain/IP, DNS tunneling, encoded traffic

### Step-by-Step Checklist

| # | Check | How to Verify | TP Signal 🔴 | FP Signal 🟢 |
|---|-------|---------------|-------------|-------------|
| 1 | **Destination IP/Domain** | Check reputation on VirusTotal, AbuseIPDB | Flagged as C2/malware | Known CDN, SaaS provider |
| 2 | **Traffic pattern** | Is it beaconing (regular intervals)? | Fixed interval (e.g., every 60 sec) | Irregular / random pattern |
| 3 | **Data volume** | Size of packets? | Small, consistent packets (heartbeat) | Large, varied (normal browsing) |
| 4 | **Protocol** | What protocol is used? | DNS over HTTPS, unusual port usage | Standard HTTPS on port 443 |
| 5 | **DNS queries** | Abnormal DNS query patterns? | Long subdomain names (DNS tunneling), high volume | Normal domain queries |
| 6 | **Process on endpoint** | What process is making the connection? | Unknown process, renamed system binary | Browser, Teams, Slack |
| 7 | **Domain age** | When was the domain registered? | < 30 days old | Years old, well-established |
| 8 | **GeoIP** | Where is the server located? | Suspicious country, known APT infra | Expected business location |

### Decision Flow

```
Suspicious outbound connection / beaconing alert?
  ├── Destination flagged as C2 on TI feeds?               → 🔴 TP — Isolate endpoint!
  ├── Regular beaconing interval from unknown process?
  │   ├── Process unsigned + connects to new domain?        → 🔴 TP
  │   └── Known app (Slack, Teams) with regular pings?      → 🟢 FP — Normal keepalive
  ├── DNS tunneling indicators (long subdomains)?            → 🔴 TP
  └── Connection to known CDN / cloud provider?              → 🟢 FP — Verify the specific URL
```

### Logs to Check
- [ ] Firewall logs (outbound connections, blocked connections)
- [ ] Proxy / Web gateway logs
- [ ] DNS logs (query names, volume, response sizes)
- [ ] EDR logs (process → network mapping)
- [ ] NetFlow data (traffic patterns)

---

## 9. 🤖 Botnet Detection

**Alert Trigger**: Connection to known botnet C2, abnormal outbound traffic volume, DDoS participation

### Step-by-Step Checklist

| # | Check | How to Verify | TP Signal 🔴 | FP Signal 🟢 |
|---|-------|---------------|-------------|-------------|
| 1 | **Destination IP** | Check against botnet C2 lists | Known botnet infrastructure | Legitimate service |
| 2 | **Traffic volume** | Outbound traffic spike? | Massive outbound (DDoS participation) | Normal traffic levels |
| 3 | **Processes** | New/unknown processes running? | Unknown process, connects to multiple IPs | Known application |
| 4 | **IRC/P2P traffic** | Unusual protocol usage? | IRC connections, P2P traffic from server | No unusual protocols |
| 5 | **Multiple endpoints** | Same behavior across machines? | Yes → Botnet spread confirmed | Isolated to one machine |
| 6 | **Server owner** | Contact system owner | "This server shouldn't have outbound traffic" | "We're running a load test" |

### Decision Flow

```
Botnet alert triggered?
  ├── IP matches known botnet C2 list?                      → 🔴 TP — Isolate immediately
  ├── Massive outbound traffic to many IPs?
  │   ├── Server owner confirms no activity planned?         → 🔴 TP — DDoS participation
  │   └── Load test / stress test running?                   → 🟢 FP
  └── Single connection to suspicious IP, low volume?        → 🟡 Investigate — early infection?
```

### Logs to Check
- [ ] Network flow logs (traffic volume, destinations)
- [ ] Firewall logs
- [ ] OS logs (new processes, new services)
- [ ] EDR logs

---

## 10. 🎯 APT (Advanced Persistent Threat) Detection

**Alert Trigger**: Combination of multiple low-severity alerts, off-hours access, new admin accounts, slow exfiltration

### Step-by-Step Checklist

| # | Check | How to Verify | TP Signal 🔴 | FP Signal 🟢 |
|---|-------|---------------|-------------|-------------|
| 1 | **Alert correlation** | Multiple related alerts across time? | Chain: phishing → persistence → lateral movement | Isolated, unrelated alerts |
| 2 | **Off-hours access** | Login times unusual? | Consistent off-hours access over days/weeks | One-time late login (overtime) |
| 3 | **New admin accounts** | 4720 events? | Accounts created without IT tickets | IT-provisioned accounts |
| 4 | **Slow exfiltration** | Small but consistent data transfers? | Regular small uploads to unknown destinations | Normal business uploads |
| 5 | **Dwell time** | How long has the activity been going on? | Weeks or months of low-noise activity | Single recent event |
| 6 | **MITRE ATT&CK mapping** | Activity maps to multiple ATT&CK tactics? | Covers 3+ tactics in the kill chain | Matches only 1 tactic |
| 7 | **Threat intel match** | IOCs match known APT groups? | Matches known APT campaign IOCs | No TI matches |

### Decision Flow

```
Suspected APT activity?
  ├── Multiple ATT&CK tactics observed over extended period? → 🔴 TP — Escalate to IR team!
  ├── IOCs match known APT group?                            → 🔴 TP — CRITICAL
  ├── Single suspicious event, no correlation?               → 🟡 Monitor, correlate further
  └── Matches known IT activity / maintenance?               → 🟢 FP
```

---

## 11. 🗃️ Data Breach Detection

**Alert Trigger**: Unauthorized access to sensitive data, unusual database queries, access policy violations

### Step-by-Step Checklist

| # | Check | How to Verify | TP Signal 🔴 | FP Signal 🟢 |
|---|-------|---------------|-------------|-------------|
| 1 | **Who accessed?** | Check the user account | Unauthorized user, or compromised account | Authorized user with valid access |
| 2 | **What data?** | What was accessed/exported? | PII, financial data, credentials, source code | Public / non-sensitive data |
| 3 | **Volume** | How much data was accessed? | Large bulk export, full table dump | Normal query result set |
| 4 | **Access pattern** | Normal for this user? | First time accessing this database/table | Regular scheduled report |
| 5 | **Failed access attempts** | Event ID 4625, DB auth failures? | Multiple failures before success | No failures |
| 6 | **Permission changes** | Was access recently granted? | Permissions changed without ticket | Standard access review |

### Decision Flow

```
Unauthorized data access alert?
  ├── User authorized + normal access pattern?                 → 🟢 FP
  ├── User accessing data outside their role?
  │   ├── Large volume / bulk export?                           → 🔴 TP — Data breach!
  │   └── Small query, one-time?                                → 🟡 Investigate further
  ├── Compromised account indicators (impossible travel, etc.)? → 🔴 TP
  └── Automated scan / vulnerability assessment?                → 🟢 FP — Expected
```

### Logs to Check
- [ ] Database access / query logs
- [ ] Application access logs
- [ ] Windows Security logs (4663 — object access)
- [ ] DLP alerts
- [ ] Network logs (data transfer volume)

---

## 🧰 Master Decision Framework

> For **ANY** alert type, follow this **5-step framework** (mnemonic: **U-G-C-V-D**):

```
┌───────────────────────────────────────────────────────────┐
│              SOC ANALYST DECISION FLOW                    │
│                                                           │
│  Step 1: U — UNDERSTAND the alert                        │
│    → What rule fired? What is the expected behavior?      │
│                                                           │
│  Step 2: G — GATHER EVIDENCE                             │
│    → Collect logs from all relevant sources               │
│    → Check threat intel (VirusTotal, AbuseIPDB)           │
│                                                           │
│  Step 3: C — CORRELATE                                   │
│    → Link to other events (same user, same IP, etc.)      │
│    → Look for attack chain patterns                       │
│                                                           │
│  Step 4: V — VERIFY                                      │
│    → Contact the user / system owner                      │
│    → Check change management tickets                      │
│    → Check with IT team                                   │
│                                                           │
│  Step 5: D — DECIDE                                      │
│    → TP → Escalate, Contain, Follow IR playbook           │
│    → FP → Document, tune the rule, close the alert        │
│                                                           │
└───────────────────────────────────────────────────────────┘
```

### 🧠 Memory Trick
> **U-G-C-V-D** = "**U**nderstand, **G**ather, **C**orrelate, **V**erify, **D**ecide"
> Think: **"U Got Caught? Verify Dude!"**

---

## 📊 Evidence Strength Quick Reference

| Strength | What You Have | Example |
|----------|--------------|---------|
| 🔴 **Strong TP** | TI-confirmed IOC + endpoint activity + user denies | Malicious hash on endpoint + C2 traffic + user says "wasn't me" |
| 🟠 **Moderate TP** | Suspicious behavior + no business justification | Off-hours admin login + no change ticket |
| 🟡 **Needs More Info** | Single indicator, no correlation | One failed login from unknown IP |
| 🟢 **Likely FP** | Business justification exists | IT admin patching servers after hours |
| ✅ **Confirmed FP** | User/IT confirms + matches known pattern | Vulnerability scanner triggered IDS alert |

---

## 📋 Log Source Quick Reference by Alert Type

| Alert Type | Primary Logs | Secondary Logs |
|-----------|-------------|----------------|
| **Brute Force** | Windows Security (4625, 4624) | AD logs, VPN logs |
| **Phishing** | Email Gateway, Email Headers | Proxy, DNS, EDR |
| **Ransomware** | AV/EDR, Windows Security (4688) | Firewall, Network Flow |
| **Data Exfiltration** | Proxy, DLP | Firewall, Cloud Access (CASB) |
| **Lateral Movement** | Windows Security (4648, 4624) | EDR, Network Flow |
| **Privilege Escalation** | Windows Security (4672, 4720, 4732) | AD Audit, Change Mgmt |
| **Persistence** | Sysmon (Event 1, 13), Security (4698) | EDR, File Audit |
| **C2 / Beaconing** | Firewall, Proxy, DNS | EDR, NetFlow |
| **Botnet** | Network Flow, Firewall | OS Logs, EDR |
| **APT** | SIEM Correlation (all sources) | Threat Intel, MITRE ATT&CK |
| **Data Breach** | Database Logs, App Access Logs | DLP, Network, Security (4663) |

---

## ✅ Post-Decision Actions

### If TP (True Positive)
- [ ] Follow the SANS IR steps: **Contain → Eradicate → Recover → Lessons Learned**
- [ ] Document the incident timeline
- [ ] Collect all evidence and IOCs
- [ ] Escalate to the IR team if high severity
- [ ] Update threat intel feeds with new IOCs
- [ ] Notify management (if required)

### If FP (False Positive)
- [ ] Document **why** it's FP (for future reference)
- [ ] Tune the detection rule to reduce future FPs
- [ ] Add whitelist/exception if appropriate
- [ ] Close the alert with proper notes
- [ ] Track FP rate per rule (high FP rate = rule needs fixing)

---

> [!TIP]
> **Interview tip**: When explaining your TP/FP process, always structure your answer around the **U-G-C-V-D** framework. Interviewers love hearing a clear, repeatable methodology.

---
*Use this checklist alongside the [SOC Concepts Interview Guide](./SOC_Concepts_Interview_Guide.md) for complete interview preparation.*$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Study_Guide_Master_Index$VELSEC$, $VELSEC$Study Guide Master Index$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['SOC']::TEXT[], $VELSEC$# 📘 Cybersecurity & SOC Analyst Master Study Guide

> **Comprehensive Interview Preparation Guide**  
> Compiled from 45+ specialized course transcripts covering Fundamentals, Network Security, Incident Response, SOC Operations, Tools, and Cloud Security.

Welcome to the Master Study Guide. Due to the comprehensive nature of the material, this guide has been divided into 8 thematic parts to ensure detailed coverage without information overload. 

Use this Master Index to navigate through the topics.

---

## 📚 Study Guide Parts

### [Part 1: Cybersecurity Fundamentals](./Study_Guide_Part1_Cybersecurity_Fundamentals.md)
- CIA Triad (Confidentiality, Integrity, Availability)
- IAAA (Identification, Authentication, Authorization, Accountability)
- Zero Trust Architecture (Never Trust, Always Verify)
- Defense-in-Depth Strategy
- Fundamental Interview Questions & Scenarios

### [Part 2: Network Security & Cryptography](./Study_Guide_Part2_Network_Security_Cryptography.md)
- The OSI Model & Network Ports
- TCP vs UDP
- Cryptography (Symmetric vs Asymmetric, Hashing)
- Public Key Infrastructure (PKI) & Digital Certificates
- IPSec, VPNs, and Firewall Types

### [Part 3: Attacks, Threats & Countermeasures](./Study_Guide_Part3_Attacks_Threats_Countermeasures.md)
- Malware Types (Virus, Worm, Trojan, Ransomware, Rootkit)
- Network Attacks (DoS/DDoS, Spoofing, MitM)
- Web Attacks (SQLi, XSS, CSRF)
- Social Engineering & Password Attacks
- Vulnerability vs Threat vs Risk

### [Part 4: Security Frameworks & Models](./Study_Guide_Part4_Security_Frameworks_Models.md)
- Cyber Kill Chain (7 Phases)
- MITRE ATT&CK Framework
- NIST Risk Management Framework (RMF)
- Access Control Models (DAC, MAC, RBAC, ABAC)
- Access Control Types (Preventive, Detective, Compensating, etc.)

### [Part 5: Incident Response & Digital Forensics](./Study_Guide_Part5_Incident_Response_DFIR.md)
- NIST SP 800-61 Incident Response Lifecycle (4 Phases)
- The 10-Step DFIR Process
- Order of Volatility & Evidence Handling
- Chain of Custody
- Handling Ransomware and Data Breaches

### [Part 6: SOC Analyst — Interview Questions & Scenarios](./Study_Guide_Part6_SOC_Analyst_Interview_Scenarios.md)
- SOC Operations and Analyst Tiers
- Alert Triage & Investigation Workflows
- Entry-Level Interview Q&A
- 8 Detailed Real-World Scenarios (Brute Force, Insider Threat, Mass Phishing, etc.)
- Threat Intelligence (Strategic, Tactical, Operational, Technical)

### [Part 7: Security Tools (SIEM, EDR, SOAR) & Vulnerability Management](./Study_Guide_Part7_Security_Tools_SIEM_EDR_SOAR.md)
- SIEM (Log Aggregation & Correlation Rules)
- EDR vs Traditional Antivirus
- SOAR (Orchestration & Automated Playbooks)
- Vulnerability Management Lifecycle & CVSS Scoring
- Threat Hunting vs SOC Monitoring

### [Part 8: Cloud Security & Azure](./Study_Guide_Part8_Cloud_Security_Azure.md)
- Cloud Service Models (IaaS, PaaS, SaaS)
- Shared Responsibility Model
- Container Security (Docker & Kubernetes)
- Managing Shadow IT and Insider Threats in the Cloud
- Azure Security (NSGs, ASGs, AKS Architecture, Micro-segmentation)

---

## 🎯 How to Use This Guide for Interviews

1. **Start with the Fundamentals (Part 1 & 2):** Ensure you have a rock-solid understanding of the CIA triad, OSI model, and cryptography. You will be tested on these regardless of the role.
2. **Understand the Attacker (Part 3 & 4):** Learn how attackers operate using frameworks like the Cyber Kill Chain and MITRE ATT&CK.
3. **Master the Response (Part 5 & 6):** For SOC roles, focus heavily on the scenarios in Part 6. Memorize the Incident Response lifecycle. Use the `Assess → Contain → Investigate → Remediate → Communicate → Learn` framework for any scenario question.
4. **Know the Tools (Part 7):** Be able to confidently explain the difference between SIEM, EDR, and SOAR.
5. **Modernize your Knowledge (Part 8):** Cloud and container security are standard requirements today. Understand the Shared Responsibility Model perfectly.

*Good luck with your interview preparation!*$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

COMMIT;
