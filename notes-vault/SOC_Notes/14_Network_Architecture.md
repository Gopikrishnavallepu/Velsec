# Network Architecture

> How security devices and servers are placed in organizational networks.

---

## Network Architecture Diagram
- Describes placement of: networks, servers, devices, databases, applications, endpoint security
- Applicable to both **on-premise** and **cloud** environments

---

## Network Zones

### Trust Zone (Internal)
- Contains all critical internal assets
- **Server LAN** (e.g., `10.10.10.0/24`):
  - Active Directory (AD)
  - DNS Server
  - DHCP Server
  - File Server
  - SMTP Server
  - Database Server
  - Web/Application Server

### User LAN (Endpoints)
- Employee devices (e.g., `10.10.20.0/24`)
- Laptops, MACs, Workstations, Desktops
- Protected by: AV, DLP, Encryption, HIDS/HIPS, FIM

### DMZ (Demilitarized Zone)
- Buffer zone between Trust and Untrust
- Houses external-facing services
- Limited LAN access

### Untrust Zone (External)
- Public internet
- Source of external threats

---

## Traffic Flow Architecture

```
[End User] → [Access Switch] → [Core Switch] → [NIDS/NIPS] → [Proxy] → [Firewall] → [Internet]
```

### On-Premise Architecture

```
Anti-DDoS → Load Balancer → NGFW → Proxy → Web Server → Database
```

### Cloud (AWS) Architecture

```
AWS Shield → ALB/ELB → AWS Network Firewall → WAF → Web Server → Database
```

---

## Server Types and Security

### Critical Servers (Server LAN)
| Server | Purpose |
|--------|---------|
| **AD** | User authentication & authorization |
| **DNS** | Domain name resolution |
| **DHCP** | Dynamic IP assignment |
| **File Server** | Centralized document storage (RBAC) |
| **SMTP** | Email sending/receiving |
| **DB Server** | Stores critical/non-critical data |
| **Web/App Server** | Hosts applications (Apache, Tomcat) |

### 3-Tier Application Architecture
1. **User Layer** (Frontend)
2. **Logical Layer** (Application Server)
3. **Database Layer** (Backend)

---

## Security Controls by Zone

| Zone | Controls |
|------|----------|
| **Endpoint** | AV, EDR, DLP, Encryption, HIDS/HIPS, FIM |
| **Network** | Firewall, IDS/IPS, Proxy, VPN |
| **Application** | WAF, Input validation, SSL/TLS |
| **Server** | Hardening, patching, access control, logging |
| **Email** | Email gateway, SPF/DKIM/DMARC |
| **DMZ** | Isolated services, limited access |

---

## Inbound vs Outbound Traffic

| Direction | Description |
|-----------|-------------|
| **Inbound** | External/public → Internal organization |
| **Outbound** | Internal → External/public |
| **NetFlow** | Inbound + Outbound combined (term by Cisco) |

---

## IP Packets

| Component | Description |
|-----------|-------------|
| **IP Header** | Version, Source IP, Destination IP, TTL |
| **Payload** | Message body / code |

> **SOC Tip**: When attacks arrive, always analyze the **payload** (the log data)

---

*Source: SOC Analyst Notes, Pages 55-60, 270-280*
