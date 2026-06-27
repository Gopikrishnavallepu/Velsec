# Security Fundamentals

> Core security principles every SOC Analyst must master.

---

## CIA Triad (Confidentiality, Integrity, Availability)

The foundation of all information security.

### Confidentiality
- Only **authorized users** should access data
- Protects: projects, company policies, patents, copyrights, trademarks, financial data, PII
- Enforced through: encryption, access controls, data classification

### Integrity
- Data must be **trustworthy and unmodified** by unauthorized entities
- Only legitimate users can add, delete, or modify data
- If modification fails → data should revert to original state

### Availability
- Systems and services must be **accessible 24/7** (99.99999% uptime)
- Requires: hardware maintenance, regular upgrades, data backups, recovery plans
- Prevents: server outages, application crashes

---

## Authentication vs Authorization

| Authentication | Authorization |
|---------------|---------------|
| **Who am I?** | **Who are you?** |
| Identity verification | Permission granting |
| User provides credentials | Server validates access |
| Username + Password | Role-based access control |
| End user level | Server level |

---

## Encryption & Decryption

| Concept | Description |
|---------|-------------|
| **Encryption** | Plaintext → Ciphertext (using algorithm + key) |
| **Decryption** | Ciphertext → Plaintext (reverse process) |
| **SSL** | Secure Sockets Layer - encrypted connection between browser & server |
| **TLS** | Transport Layer Security - end-to-end encryption over internet |

---

## Vulnerability, Threat & Risk

### Vulnerability
- **Weakness** in a system exploitable for unauthorized access
- Reasons: Complexity, Design Flaws, User Input, Poor Configuration, Unsecured Connectivity
- Examples: Missing AV agent, Firewall misconfiguration

### Threat
- **Action** that potentially compromises security
- Exploits vulnerabilities
- Three components: **Intent**, **Opportunity**, **Capability**
- Sources: Nation states, terrorists, hackers, insiders

### Risk
- **Risk = Vulnerability × Threat**
- Or: **Likelihood × Impact**
- Calculated across: endpoints, network, applications, cloud, servers, databases, physical security
- Documented in a **Risk Register** by IT Security team

---

## Key Security Metrics

| Metric | Full Name | Meaning |
|--------|-----------|---------|
| **MTTD** | Mean Time To Detection | Average time to detect an attack |
| **MTTI** | Mean Time To Identification | Time to identify a vulnerable system |
| **MTTR** | Mean Time To Recovery | Time to neutralize and remediate a threat |

---

## Data Classification

| Type | Description |
|------|-------------|
| **Confidential** | Trademarks, copyrights, patents |
| **Restricted** | Financial results, quarterly data |
| **Public** | Advertisements, product information |
| **PII** | Personal Identifiable Information (Aadhar, passport, email, phone) |
| **PHI** | Personal Health Information (patient records) |

> **GDPR** = General Data Protection Regulation (European countries)

---

## Whitelisting vs Blocklisting

| Whitelist (Allow) | Blocklist (Block) |
|-------------------|-------------------|
| Pre-approved access | Denied access |
| Programs, IPs, emails | Specific IPs, domains, URLs |
| Customizable per needs | Prevents intrusion |

---

## SLA (Service Level Agreement)
- Contractual agreement between service provider and client
- Based on **time** and **severity**
- Defines response and resolution times for incidents

---

*Source: SOC Analyst Notes, Pages 11-20, 50-54*
