# SOC Analyst Interview Questions

> Key interview questions compiled from the SOC Analyst Notes.

---

## Networking

### Q: What is the difference between Router and Switch?
**A**: Router is a Layer 3 device (Network Layer) that routes using IP addresses. Switch is a Layer 2 device (Data Link Layer) that routes using MAC addresses. Routers support internet and VPN; switches do not.

### Q: What is the DORA Process?
**A**: DHCP IP assignment process: **D**iscovery (client broadcasts), **O**ffer (DHCP responds), **R**equest (client requests IP), **A**cknowledgement (DHCP assigns IP for a lease period).

### Q: What is the difference between TCP and UDP?
**A**: TCP is connection-oriented (reliable, error-checked, ordered delivery). UDP is connectionless (fast, no guarantees). TCP examples: web browsing, file downloads. UDP examples: Zoom calls, DNS.

### Q: What is MAC address bit size?
**A**: 48-bit.

### Q: What are the IP Address classes?
**A**: Class A (0-126), Class B (128-191), Class C (192-223), Class D (224-239), Class E (240-255). Loopback: 127.0.0.1.

### Q: What are private IP ranges?
**A**: Class A: 10.0.0.0-10.255.255.255, Class B: 172.16.0.0-172.31.255.255, Class C: 192.168.0.0-192.168.255.255.

---

## Security Concepts

### Q: What is the CIA Triad?
**A**: Confidentiality (privacy of data), Integrity (trustworthiness/unmodified data), Availability (systems accessible 24/7). Every security domain revolves around these three principles.

### Q: How to identify internal vs external attack?
**A**: Check source IP range. Private ranges (10.x, 172.16-31.x, 192.168.x) = internal/insider threat. Everything else = external attack.

### Q: Which ports are better - open or closed?
**A**: Closed ports are better. Open ports give attackers entry points via port scanning. Ports should only be opened with proper business justification and firewall team approval.

### Q: What are the network zones in an organization?
**A**: Trust (internal), Untrust (external/public), DMZ (demilitarized zone - buffer between trust and untrust).

---

## Security Tools

### Q: What is SIEM?
**A**: Security Information & Event Management. The main SOC tool for log collection, analysis, monitoring, processing, and security alerting. It enables instant forensic investigation of security incidents.

### Q: What are Windows Event IDs for authentication?
**A**: 4624 (Logon Success), 4625 (Logon Failure), 4672 (Special Logon), 4798 (User Access Management).

### Q: What Windows logs are there?
**A**: Application, Security, Setup, System, Forwarded Events. Domain Controller logs are in the Security category.

### Q: What is the difference between AD and Domain Controller?
**A**: AD (Active Directory) is a directory server containing all user, system, and server information. Domain Controller is a service running on top of AD that validates whether users are authorized domain members.

---

## Email Security

### Q: What are the email technical parameters?
**A**: SPF (Sender Policy Framework), DKIM (Domain Key Identified Mail), DMARC (Domain Message Authentication), Return Path, DNS Record, Header Analyzer, Domain Keys.

### Q: What is CNAME record?
**A**: Canonical Name record that converts one form of browser URL to another (e.g., google.com → https://www.google.com).

### Q: What is NS record?
**A**: Name Server record configured by domain and subdomain. Example: Google.com has NS records for gmail.com, youtube.com, etc.

### Q: What is SOA record?
**A**: Start of Authority - contains primary DNS, secondary DNS, DNS zones, admin email, admin username, and contact details.

---

## Cloud Security

### Q: What is Amazon GuardDuty?
**A**: AWS equivalent of a SIEM tool. Provides centralized log collection, processing, managing, and alerting. However, it doesn't have full SIEM capability, so organizations often integrate with Splunk/QRadar.

### Q: What is AWS DDoS protection?
**A**: AWS Shield provides DDoS protection without needing third-party tools like Akamai or Barracuda.

---

## Incident Response

### Q: What security controls would you implement for a server?
**A**: Username & password authentication, authentication keys, hardening benchmarks, logging & monitoring (integrated to SIEM), and role-based access control (RBAC) based on team roles.

### Q: What is the difference between IDS and IPS?
**A**: IDS (Intrusion Detection System) only detects and alerts - it works in outline mode. IPS (Intrusion Prevention System) detects AND blocks - it works in inline mode. IPS is placed after the firewall.

---

## Protocols

### Q: What is Kerberos?
**A**: Mutual authentication protocol (Port 88) that uses a ticket granting system for secure authentication.

### Q: What is the difference between SSL and TLS?
**A**: Both provide encryption for data in transit. SSL is the older version; TLS is the newer, more secure replacement. Both use port 443. They provide encryption, authenticity, non-repudiation, and integrity.

---

*Source: Questions marked as "Interview Question" throughout SOC Analyst Notes*
