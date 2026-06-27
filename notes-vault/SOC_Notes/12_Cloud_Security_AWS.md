# Cloud Security (AWS)

> AWS security services and cloud security monitoring for SOC operations.

---

## AWS Security Services Overview

| Service | Purpose | On-Premise Equivalent |
|---------|---------|----------------------|
| **AWS IAM** | Identity & Access Management, role-based access | Active Directory |
| **AWS Security Hub** | Centralized security alerts dashboard | SIEM Dashboard |
| **Amazon GuardDuty** | SIEM-like tool: log collection, processing, alerting | Splunk / QRadar |
| **Amazon Inspector** | Vulnerability management & assessment | Nessus / Qualys |
| **AWS CloudWatch** | Log monitoring & metrics | Syslog server |
| **AWS CloudTrail** | IAM/security audit logging | Windows Event Logs |
| **AWS Network Firewall** | Network-level firewall | Palo Alto / Fortinet |
| **AWS Shield** | DDoS protection | Akamai / Barracuda |
| **AWS WAF** | Web Application Firewall (OWASP Top 10) | F5 WAF |
| **AWS Firewall Manager** | Centralized firewall management | Firewall Manager |
| **Amazon Detective** | Incident investigation & analysis | Forensic Tools |
| **AWS Route 53 DNS Firewall** | DNS resolution & protection | DNS Firewall |
| **AWS Organizations** | Centralized account management | Domain Controller |

---

## Key AWS Security Services (Detail)

### Amazon GuardDuty
- AWS equivalent of a **SIEM Tool**
- Centralized log collection, processing, managing, alerting
- **Limitation**: Doesn't have full SIEM capability for advanced SOC operations
- For full SIEM → integrate with Splunk/QRadar via CloudWatch

### AWS CloudTrail
- Logs **IAM-related activities**: login success, login failure, configuration changes
- Stores logs in **S3 Buckets**
- Essential for traceability and auditing

### AWS CloudWatch
- Used to **integrate cloud logs to third-party SIEM tools**
- Integration methods: **Cloud Connector** or **API Token Management**
- Captures: performance metrics, configuration changes, operational data

### Amazon Inspector
- **Vulnerability Assessment** tool
- Scans for vulnerabilities in EC2 instances and containers
- Alternative: Use Nessus/Qualys if Inspector doesn't meet requirements

### Amazon Detective
- **Incident investigation** tool
- Identifies and analyzes potential threats and alerts
- Works alongside GuardDuty for comprehensive security monitoring

### AWS Shield
- **DDoS Protection** service
- No need for third-party anti-DDoS tools (Akamai, Barracuda, Imperva)
- Available in Standard (free) and Advanced (paid) tiers

---

## Cloud Log Integration to SIEM

### Process Flow
1. Enable **CloudTrail** for IAM and security logs
2. Store logs in **S3 Buckets**
3. Use **Cloud Connector** or **API Token** method
4. Integrate logs to on-premise **SIEM** (Splunk, QRadar, etc.)

### Why Integrate with Third-Party SIEM?
- GuardDuty has limited SIEM capability
- Enterprise SOCs need advanced correlation, hunting, and reporting
- Centralized view of both cloud and on-premise environments

---

## AWS Network Architecture
Similar to on-premise with key differences:
1. **Anti-DDoS** → AWS Shield
2. **Load Balancer** → AWS ELB/ALB
3. **Firewall** → AWS Network Firewall
4. **WAF** → AWS WAF
5. **Proxy** → Web Gateway services
6. **Logging** → CloudTrail + CloudWatch

---

## Interview Answer Template
> "I'm working as a Security Analyst. We integrate cloud logs as well. First, we enable CloudTrail, store logs in S3 Buckets, then use the Cloud Connector or API Token method to integrate Amazon cloud logs to our SIEM Tool. I'm also aware of GuardDuty as our cloud-native alerting solution."

---

*Source: SOC Analyst Notes, Pages 275-290*
