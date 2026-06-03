---
title: "Nmap Penetration Testing Cheat Sheet"
category: "Cheat Sheets"
tags: ["Recon", "Nmap", "Scanning", "Network"]
lastUpdated: "2026-06-03"
---

Nmap ("Network Mapper") is a free and open-source utility for network discovery and vulnerability auditing. This cheat sheet captures primary scanning switch commands for quick retrieval during engagements.

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
```
