# SIEM & Log Management

> Security Information & Event Management - The SOC Analyst's primary tool.

---

## What is SIEM?
- **Security Information & Event Management**
- The **main tool** for SOC operations
- Functions: Log collection, Log analysis, Log monitoring, Log processing, Security alerting
- Enables **instant forensic investigation**

### How SIEM Works
1. Logs are generated from all systems (endpoints, servers, firewalls, etc.)
2. Logs are sent to the SIEM tool
3. Rules and policies are created for different attack types
4. When an attack is attempted → SIEM generates **alerts**
5. SOC analysts investigate alerts and determine if compromise occurred

---

## What is a Log?
- **Computer recorded activity**
- Generated from employee actions, system events, network traffic
- Every action generates a log entry in the background
- Types: Authentication logs, Application logs, Security logs, System logs

---

## SIEM Tools (Market Leaders)

| Tool | Vendor | Key Features |
|------|--------|-------------|
| **Splunk** | Splunk Inc. | Market leader, powerful search (SPL), dashboards |
| **IBM QRadar** | IBM | Enterprise SIEM, offense management |
| **Microsoft Sentinel** | Microsoft | Cloud-native SIEM on Azure |
| **LogRhythm** | LogRhythm | Unified security platform |
| **ArcSight** | Micro Focus | Enterprise-grade correlation |
| **AlienVault** | AT&T | Unified security management |

---

## Log Sources

### Endpoint Logs
- Windows Event Logs (Event IDs)
- EDR/AV alerts
- DLP alerts

### Network Logs
- Firewall logs
- IDS/IPS logs
- Proxy logs
- DNS logs
- VPN logs

### Application Logs
- Web server logs (Apache, Tomcat)
- Database logs
- Email gateway logs

### Cloud Logs
- AWS CloudTrail, CloudWatch
- Azure Activity Logs
- GCP Audit Logs

---

## Windows Event IDs (Critical for SOC)

| Event ID | Description |
|----------|-------------|
| **4624** | Successful Authentication (Logon) |
| **4625** | Authentication Failure (Failed Logon) |
| **4672** | Special Logon (Admin privileges) |
| **4798** | User Access Management |

### Windows Log Categories
- Application
- Security (Domain Controller logs here)
- Setup
- System
- Forwarded Events

---

## SIEM Alerts & Severity

| Severity | Response Time | Impact |
|----------|--------------|--------|
| **Critical** | Immediate | Business-critical compromise |
| **High** | Within SLA | Significant security event |
| **Medium** | Standard | Moderate risk |
| **Low** | Routine | Minimal impact |
| **Informational** | FYI | No immediate risk |

---

## SOAR (Security Orchestration Automated Response)
- **New technology** in cybersecurity
- Automates incident response actions:
  - IP Address blocking in Firewall
  - Domain blocking in DNS/Firewall/Proxy
  - URL blocking in Firewall/Proxy
  - Hash value blocking in EDR
  - MAC Address blocking
- Reduces manual effort and response time
- Uses Python, PowerShell for automation scripts

---

## UEBA (User & Entity Behavior Analytics)
- Detects anomalous user behavior
- Uses machine learning and statistical analysis
- Identifies insider threats and compromised accounts

---

*Source: SOC Analyst Notes, Pages 6-7, 53-54*
