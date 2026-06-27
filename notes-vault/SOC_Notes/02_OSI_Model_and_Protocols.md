# OSI Model & Protocols

> The 7-layer OSI Model is a communication channel provided by ISO in 1984.

---

## OSI Model Summary

| Layer | Name | Data Format | Key Protocols | Device | Key Attacks |
|-------|------|-------------|---------------|--------|-------------|
| 7 | Application | Data | HTTP(80), HTTPS(443), FTP(20/21), SSH(22), DNS(53), SMTP(25), RDP(3389) | - | OWASP Top 10, MITM, Session Hijacking |
| 6 | Presentation | Data | SSL/TLS(443) | - | Cryptographic Failures |
| 5 | Session | Data | SSL/TLS | - | Session Hijacking |
| 4 | Transport | Segments/Datagrams | TCP, UDP | - | IP Flooding, IP Spoofing, ARP Spoofing |
| 3 | Network | Packets | IP, ICMP, ARP, VPN | Router | IP Spoofing, ICMP Flooding |
| 2 | Data Link | Frames | RARP, PPP | Switch | MAC Flood, RARP Poisoning |
| 1 | Physical | Raw Bits (0 & 1) | Ethernet, Optical Fibre | Hub | Physical Theft/Damage |

---

## Layer 7 - Application Layer
- Provides interface between application and network
- **Features**: Web browsing, Messaging, Virtual Terminal, File Transfer, DNS
- **Protocols**: HTTP(80), HTTPS(443), SMTP(25), SMB(445), POP3(110), IMAP(143), RDP(3389), SSH(22), Telnet(23), FTP(20/21), DNS(53)

## Layer 6 - Presentation Layer
- Data formatting, encryption/decryption, data compression
- **Encryption**: Converting plaintext → ciphertext using algorithm + key
- **Decryption**: Reverse process, ciphertext → plaintext

## Layer 5 - Session Layer
- Manages sessions between sender and receiver
- **Features**: Session management, Authentication, Authorization

## Layer 4 - Transport Layer
- End-to-end communication without errors
- **Features**: Error Control, Data Flow Control, Segmentation
- **TCP 3-Way Handshake**: SYN → SYN+ACK → ACK (connection establishment)
- **TCP 2-Way Handshake**: FIN → ACK (connection termination)

### TCP vs UDP

| TCP | UDP |
|-----|-----|
| Connection-oriented | Connectionless |
| Reliable delivery | Best-effort delivery |
| Error checking | No error checking |
| Slower | Faster |
| Ex: Web browsing, file downloads | Ex: Zoom calls, DNS, streaming |

## Layer 3 - Network Layer
- Routing and logical addressing (IP)
- **Features**: Logical Address (IP), ICMP, ARP, VPN, Path Determination
- Device: **Router** (uses routing table: Router ID, Source IP, Destination IP)

## Layer 2 - Data Link Layer
- End-to-end communication between 2 nodes using frames
- **Features**: Encapsulation/Decapsulation, Error Control
- Device: **Switch** (uses MAC Address)
- Switch hierarchy: Access(2500) → Distributed(4500) → Core(6500)
- Sub-layers: **LLC** (Logical Link Control) | **MAC** (Media Access Control)

## Layer 1 - Physical Layer
- Physical transmission of raw bits through cables
- Device: **Hub**

---

## Ports & Protocols Quick Reference

| Protocol | Port | Purpose |
|----------|------|---------|
| FTP/SFTP | 20, 21 | File transfer |
| SSH/SCP | 22 | Secure shell / Secure copy |
| Telnet | 23 | Remote login (insecure) |
| SMTP | 25 | Email sending/receiving |
| DNS | 53 | Domain name resolution |
| DHCP | 67, 68 | Dynamic IP assignment |
| HTTP | 80 | Web browsing (insecure) |
| Kerberos | 88 | Mutual authentication |
| POP3 | 110 | Email delivery |
| NTP | 123 | Time synchronization |
| NetBIOS | 137-139 | Network booting |
| IMAP | 143 | Email delivery |
| SNMP | 161 | Network device management |
| LDAP | 389 | AD integration |
| HTTPS/SSL/TLS | 443 | Secure web browsing |
| SMB | 445 | Windows messaging (dangerous!) |
| IPSec | 500 | VPN |
| Syslog | 514 | System logging |
| LDAPS | 636 | Secure AD integration |
| MS SQL | 1433 | Database |
| RDP | 3389 | Remote Desktop |
| SIP | 5060, 5061 | Session initiation |

> **Total ports per system**: 0 - 65535 (65,536 ports)
> **Well-known ports**: 0 - 1023
> **Closed ports are always better** for security

---

### Router vs Switch

| Router (Layer 3) | Switch (Layer 2) |
|-------------------|-----------------|
| Uses IP Address | Uses MAC Address |
| Supports Internet | Does NOT support Internet |
| Supports VPN | Does NOT support VPN |
| Connects buildings/cities/countries | Connects devices within LAN only |

---

*Source: SOC Analyst Notes, Pages 21-42*
