# Cyber Attacks & Threats

> Classification and understanding of cyber attack types.

---

## Malware
**Malicious software** designed to interfere with normal computer functioning.

### Malware Categories

| Type | Description |
|------|-------------|
| **Virus** | Self-replicating malicious code that attaches to files |
| **Worm** | Self-propagating without user interaction |
| **Ransomware** | Encrypts files and demands payment for decryption |
| **Trojan** | Disguised as legitimate software |
| **Botnet** | Network of compromised machines controlled remotely |
| **Backdoor** | Hidden access point bypassing normal authentication |
| **Logic Bomb** | Malicious code triggered by specific conditions |
| **Spyware** | Secretly monitors user activity |
| **Adware** | Displays unwanted advertisements |
| **Rootkit** | Hides presence of malware in the system |

### Malware Objectives
- Provide remote control of infected machine
- Send spam from infected machine
- Investigate local network
- Steal sensitive data

---

## OWASP Top 10 (Open Web Application Security Project)
- Organization conducting surveys on application layer attacks
- Releases **Top 10 web application vulnerabilities** periodically (2010, 2013, 2017, 2021)

### 2021 OWASP Top 10
1. Broken Access Control
2. Cryptographic Failures
3. Injection (SQL, XSS)
4. Insecure Design
5. Security Misconfiguration
6. Vulnerable Components
7. Authentication Failures
8. Software Integrity Failures
9. Logging & Monitoring Failures
10. Server-Side Request Forgery (SSRF)

---

## Common Attack Types

### Phishing
- Fraudulent emails mimicking legitimate sources
- Types: Spear Phishing, Whaling, Vishing, Smishing
- Investigation: Check SPF, DKIM, DMARC, Return Path, Header Analysis

### Brute Force Attack
- Trying every possible password combination
- Mitigated by: account lockout policies, MFA, strong passwords

### DDoS (Distributed Denial of Service)
- Overwhelming server with millions of requests from multiple sources
- Anti-DDoS tools: Akamai, Barracuda, Imperva

### Man-in-the-Middle (MITM)
- Attacker intercepts communication between two parties
- Occurs between: User & User, User & Server, User & Application

### SQL Injection
- Inserting malicious SQL code into application queries
- Layer 7 (Application) attack
- Mitigated by WAF

### Cross-Site Scripting (XSS)
- Injecting malicious scripts into web pages
- Mitigated by WAF

### Session Hijacking
- Taking over an active user session
- Layer 5 (Session) and Layer 7 (Application) attack

### ARP Spoofing/Poisoning
- Sending fake ARP messages to link attacker's MAC with a legitimate IP
- Layer 2 and Layer 4 attack

### MAC Flood Attack
- Overwhelming switch's MAC address table
- Layer 2 (Data Link) attack

### IP Flooding/Spoofing
- Sending millions of requests or packets with fake source IP
- Layer 4 (Transport) attack

---

## TTP (Tactics, Techniques & Procedures)
- The methodology attackers use to compromise systems
- Defines: what to target, how to exploit, what tools to use
- Example: Using phishing emails to compromise endpoints

---

## Attacker Types

| Type | Motivation |
|------|-----------|
| **Black Hat** | Malicious intent (money, data theft) |
| **White Hat** | Ethical hacking, authorized testing |
| **Grey Hat** | Between ethical and malicious |
| **Script Kiddie** | Uses existing tools without deep knowledge |
| **Insider Threat** | Employee/contractor abusing privileges |
| **Nation State** | Government-sponsored cyber warfare |

---

## Identifying Internal vs External Attack
- Check the **source IP address**:
  - `10.x.x.x`, `172.16.x.x - 172.31.x.x`, `192.168.x.x` → **Internal (Insider Threat)**
  - Any other IP range → **External Attack**

### Response:
- **Internal**: Contact the end user (if permitted)
- **External**: Check IP reputation → Block in firewall

---

*Source: SOC Analyst Notes, Pages 4-5, 15-19, 37-38*
