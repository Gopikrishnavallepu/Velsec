# Network Security Devices

> Security appliances and their placement in the network architecture.

---

## Firewall (FW)
- Monitors **inbound** and **outbound** traffic
- Allows or denies traffic based on **security policies**
- Barrier between private internal network and public internet
- **Port management**: Opens/closes ports based on approved tickets

### Firewall Port Opening Process
1. Requesting team fills **firewall template** (source/dest IP, port, protocol)
2. Creates ticket in **ticketing tool** (ServiceNow, Jira)
3. Assigns to **Firewall Team**
4. **Approver** reviews → performs risk assessment
5. **Implementer** creates policy/rule in firewall

### Firewall Zones
| Zone | Description |
|------|-------------|
| **Trust** | Internal organizational network |
| **Untrust** | External / public network |
| **DMZ** | Demilitarized zone - buffer between trust & untrust |

---

## WAF (Web Application Firewall)
- Blocks **Application Layer (Layer 7)** attacks
- Protects against: XSS, CSRF, SQL Injection, File Inclusion
- Monitors HTTP traffic between web app and internet

## NGFW (Next Generation Firewall)
- Current generation firewalls
- Blocks at **Network Layer** as per OSI
- Deep packet inspection capabilities

---

## IDS (Intrusion Detection System)
- **Detects** malicious traffic based on signatures
- Works in **Outline Mode**
- **Does NOT block** - only alerts
- Types: Network-based IDS (NIDS) | Host-based IDS (HIDS)
- Detects: Reconnaissance Attacks, DoS, Access Attacks

## IPS (Intrusion Prevention System)
- **Detects AND blocks** malicious activity
- Works in **Inline Mode**
- Placed **after the firewall**
- Does deep packet inspection

### IDS vs IPS

| IDS | IPS |
|-----|-----|
| Detection only | Detection + Prevention |
| Outline mode | Inline mode |
| Passive | Active |
| Alerts | Blocks |

---

## Proxy Server
- Also called: **Web Gateway** / **Application Gateway**
- Acts as intermediary between user and application
- Functions: URL filtering, content inspection, caching
- Blocking capabilities: Domain, URL, Website

---

## VPN (Virtual Private Network)
- Types: **Site-to-Site VPN** | **Remote VPN**
- Uses **IPSec** protocol (Port 500)
- Creates encrypted tunnel between networks

---

## DMZ (Demilitarized Zone)
- Perimeter network between public internet and private LAN
- Adds extra security layer to internal network
- Houses: DNS, FTP, Mail, Proxy, VoIP, Web servers
- Servers in DMZ have limited LAN access

---

## Blocking Quick Reference

| What to Block | Where to Block |
|--------------|----------------|
| IP Address | Firewall |
| MAC Address | Switch / Firewall |
| Domain Name | DNS / Firewall |
| Website | Firewall / Proxy |
| URL Links | Firewall / Proxy |
| Hash Value | EDR Tool |

> **Tip**: Use [VirusTotal](https://virustotal.com) for IP reputation checks

---

*Source: SOC Analyst Notes, Pages 13-14, 55-60*
