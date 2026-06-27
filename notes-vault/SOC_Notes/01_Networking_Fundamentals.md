# Networking Fundamentals

> Core networking concepts every SOC Analyst must understand.

---

## LAN (Local Area Network)
- Connects all devices **within a single building** or location
- Internet is **not mandatory**
- Connects: load balancers, routers, switches, printers, workstations, servers, databases
- **Keywords**: Single Building, Single Office, Single Organization

## WAN (Wide Area Network)
- Internet and Router are **compulsory**
- Connects devices across **geographical locations** (different countries, cities)
- Several LANs combined = WAN
- Uses **public network** (internet) for connectivity
- **Keywords**: Geographical Location, Internet, Public Network

## MAN (Metropolitan Area Network)
- Connects devices **within a country** across metro cities
- Internet and Public Network are **mandatory**

---

## Data Centre (DC)
- A dedicated room housing all networking devices:
  - Physical servers, routers, switches, load balancers, firewalls, proxy servers
- Expensive to maintain → organizations shifting to **cloud**
- Requires **cooling systems** (AC, plantations)
- Types: **Rack Mounted** | **Wall Mounted**

## Domain Controller (DC)
- **Centralized authentication and authorization server**
- Validates whether user is an authorized domain member
- Runs on top of **Active Directory (AD)**

## Active Directory (AD)
- Windows server maintaining all user information under the domain controller
- Contains: user info, system info, server info, team groups (DevOps, HR, etc.)
- Managed by **Windows Admin / Sys Admin**

---

## IP Address (Internet Protocol)
- Numerical label assigned to each device on a network
- **Logical address** (can change)

### IPv4 vs IPv6

| Property | IPv4 | IPv6 |
|----------|------|------|
| Bit Size | 32-bit | 128-bit |
| Format | `10.10.10.1` | `abcd:10cd:1234:1011` |
| Octets | 4 octets | 8 groups |
| Range | 0-255 per octet | Hex characters + numbers |

### IP Address Classes (Public + Private)

| Class | Range | Usage |
|-------|-------|-------|
| A | `0.0.0.0` - `126.255.255.255` | Enterprise / Large networks |
| B | `128.0.0.0` - `191.255.255.255` | Medium organizations |
| C | `192.0.0.0` - `223.255.255.255` | LAN |
| D | `224.0.0.0` - `239.255.255.255` | Multicasting |
| E | `240.0.0.0` - `255.255.255.255` | R&D |
| Loopback | `127.0.0.1` | Localhost |

### Private IP Address Ranges

| Class | Range |
|-------|-------|
| A | `10.0.0.0` - `10.255.255.255` |
| B | `172.16.0.0` - `172.31.255.255` |
| C | `192.168.0.0` - `192.168.255.255` |

> **SOC Tip**: If source IP is in private range → **Internal/Insider Threat**. Otherwise → **External Attack**.

### Static IP vs Dynamic IP

| Static IP | Dynamic IP |
|-----------|------------|
| Fixed/constant | Changes over time |
| Manual assignment | Automatic via DHCP |
| Used for: servers, databases, tools | Used for: employee laptops, desktops |
| Drawbacks: manual, IP conflicts, time-consuming | Easy, secure, no human intervention |

---

## MAC Address (Media Access Control)
- **Physical address** of a NIC card
- **48-bit**, fixed and unique
- Format: `00:10:ab:cd:ef:11`
- Command: `getmac` in CMD

## NIC (Network Interface Card)
- Converts electrical signals into data signals
- Each NIC has one unique MAC address
- Both a Physical Layer and Data Link Layer device

---

## ARP & RARP

| Protocol | Function |
|----------|----------|
| **ARP** (Address Resolution Protocol) | Converts Layer 3 IP → Layer 2 MAC |
| **RARP** (Reverse ARP) | Converts Layer 2 MAC → Layer 3 IP |

---

## DNS (Domain Name Server) - Port 53
- Converts domain names into IP addresses (and vice versa)
- Acts like an **internet phonebook**
- Process: User → Private DNS → Cache check → Authoritative Server → Response
- **DNS Records**: A, AAAA, PTR, MX, CNAME, NS, SOA, TXT, HINFO, ISDN
- Classification: **Public DNS** (e.g., `8.8.8.8`) | **Private DNS** (organization internal)

## DHCP (Dynamic Host Configuration Protocol) - Port 67 & 68
- Automatically assigns IP addresses to client devices
- Uses **DORA Process**:
  1. **D**iscovery - Client broadcasts request
  2. **O**ffer - DHCP server responds
  3. **R**equest - Client requests IP
  4. **A**cknowledgement - DHCP server assigns IP for a lease period

> **DDI** = DHCP + IPAM + DNS (combined solution)
> Tools: Microsoft, Infoblox

---

## Key Commands

| Command | Purpose |
|---------|---------|
| `ipconfig` | Display IP address |
| `ipconfig /all` | Display full network details |
| `getmac` | Display MAC address |
| `nslookup <domain>` | DNS lookup |
| `ping <IP>` | Test connectivity |

---

*Source: SOC Analyst Notes, Pages 1-50*
