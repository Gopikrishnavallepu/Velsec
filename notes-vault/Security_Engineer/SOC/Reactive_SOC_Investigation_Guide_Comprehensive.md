---
title: "Reactive Soc Investigation Guide Comprehensive"
category: "Security Engineer"
tags: ["SOC"]
lastUpdated: "2026-06-05"
---

# 🔍 Reactive SOC Investigation Guide — Part 1: Deep-Dive TP Determination Framework

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


---

