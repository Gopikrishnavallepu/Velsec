# SOC Operations

> Structure, roles, and operational procedures of a Security Operations Center.

---

## What is a SOC?
- A **room or site** where security analysts sit, monitor, and investigate security incidents **24/7**
- Also known as: CSIRT, CERT, SIRT

---

## SOC Team Structure

### L1 - Security Analyst (Tier 1)
- **8 analysts** per shift (typical)
- First line of defense
- Monitor SIEM dashboards and alerts
- Triage and classify alerts
- Handle low/medium severity incidents
- Escalate to L2 when needed

### L2 - Senior Security Analyst (Tier 2)
- **4 analysts** per shift (typical)
- Handle escalated incidents from L1
- Deep-dive investigation
- Incident containment and eradication
- Communicate with affected teams

### L3 - Security Engineer / Threat Hunter (Tier 3)
- **2 analysts** per shift (typical)
- Advanced threat hunting
- Malware analysis and reverse engineering
- Proactive threat intelligence
- Create and tune detection rules

### SOC Manager
- Oversees all SOC operations
- Manages team, KPIs, reporting
- Stakeholder communication

---

## SOC KPI (Key Performance Indicators)
- SOC stabilization takes approximately **6 weeks** (36 days minimum)
- SIEM tool deployment does NOT stabilize within 1 day

### Mature SOC Parameters
- **Fine tuning** - Ensuring all log sources reflect in SIEM
- **Alert quality** - Reducing false positives
- **MTTD** - Mean Time To Detection
- **MTTR** - Mean Time To Recovery
- **SOAR integration** - Automation maturity
- **UEBA** - User behavior analytics
- **Proactive threat hunting** - Beyond reactive monitoring

---

## Shift Operations

### 24/7 Coverage Model
- Typically **3 shifts** covering 24 hours
- Each shift has L1, L2, L3 analysts + SOC Manager

### Shift Handover Process
1. Outgoing team documents all **open incidents**
2. Records what was completed vs pending
3. Example: "Received 50 incidents, closed 40, 10 pending"
4. Incoming team reviews pending incidents
5. Handover via **Incident Tracker** (JIRA / ServiceNow / Excel)

---

## SOC Tools Stack

| Category | Tools |
|----------|-------|
| **SIEM** | Splunk, QRadar, Sentinel, ArcSight |
| **EDR** | CrowdStrike, Carbon Black, Microsoft Defender |
| **Firewall** | Palo Alto, Fortinet, Check Point |
| **IDS/IPS** | Snort, Suricata |
| **Proxy** | Zscaler, Blue Coat |
| **Email Security** | Proofpoint, Mimecast |
| **Ticketing** | ServiceNow, Jira |
| **Threat Intel** | VirusTotal, AbuseIPDB, MITRE ATT&CK |
| **SOAR** | Phantom, Demisto, Swimlane |
| **Vulnerability** | Nessus, Qualys, Rapid7 |

---

## Automation in SOC
- Using **Python** and **PowerShell** for:
  - Auto-filling incident templates
  - Auto-creating tickets from SIEM alerts
  - Integrating alerts with SOAR tools
  - Automated blocking of IOCs

---

*Source: SOC Analyst Notes, Pages 6-7, 280-296*
