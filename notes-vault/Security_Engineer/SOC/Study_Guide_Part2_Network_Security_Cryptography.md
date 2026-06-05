---
title: "Study Guide Part2 Network Security Cryptography"
category: "Security Engineer"
tags: ["SOC"]
lastUpdated: "2026-06-05"
---

# 📘 Part 2: Network Security & Cryptography

> **Comprehensive Interview Study Guide** — Based on real cybersecurity course transcripts  
> Covers: OSI Model, TCP/IP, DNS, DHCP, Symmetric/Asymmetric Encryption, Hashing, Digital Signatures, PKI, IPSec, Firewalls

---

## Table of Contents

1. [Networking Fundamentals](#1-networking-fundamentals)
2. [Cryptography — Symmetric Encryption](#2-cryptography--symmetric-encryption)
3. [Cryptography — Asymmetric Encryption](#3-cryptography--asymmetric-encryption)
4. [Hashing](#4-hashing)
5. [Digital Signatures](#5-digital-signatures)
6. [Digital Certificates & PKI](#6-digital-certificates--pki)
7. [IPSec — Internet Protocol Security](#7-ipsec--internet-protocol-security)
8. [Firewall Types](#8-firewall-types)
9. [Interview Questions & Answers](#9-interview-questions--answers)
10. [Quick Reference Tables](#10-quick-reference-tables)
11. [Key Takeaways](#11-key-takeaways)

---

## 1. Networking Fundamentals

### The OSI Model (7 Layers)

| Layer | Name | Function | Protocols/Devices | Data Unit |
|-------|------|----------|-------------------|-----------|
| 7 | **Application** | User interface & network services | HTTP, FTP, SMTP, DNS | Data |
| 6 | **Presentation** | Data formatting, encryption, compression | SSL/TLS, JPEG, ASCII | Data |
| 5 | **Session** | Session management & synchronization | NetBIOS, PPTP | Data |
| 4 | **Transport** | End-to-end delivery, flow control | TCP, UDP | Segment |
| 3 | **Network** | Logical addressing & routing | IP, ICMP, ARP | Packet |
| 2 | **Data Link** | Physical addressing & framing | Ethernet, MAC, switches | Frame |
| 1 | **Physical** | Physical transmission of bits | Cables, hubs, repeaters | Bits |

> **Mnemonic (Top-Down):** All People Seem To Need Data Processing  
> **Mnemonic (Bottom-Up):** Please Do Not Throw Sausage Pizza Away

### TCP vs UDP

| Feature | TCP | UDP |
|---------|-----|-----|
| **Connection** | Connection-oriented (3-way handshake) | Connectionless |
| **Reliability** | Reliable — guaranteed delivery | Unreliable — no guarantee |
| **Speed** | Slower (overhead for reliability) | Faster (minimal overhead) |
| **Order** | Maintains order of packets | No ordering guarantee |
| **Use Cases** | Web browsing, email, file transfer | Streaming, DNS, VoIP, gaming |
| **Header Size** | 20 bytes | 8 bytes |
| **Error Checking** | Yes — retransmission on error | Basic checksum only |

### TCP Three-Way Handshake
```
Client ──SYN──────────> Server
Client <──SYN-ACK────── Server
Client ──ACK──────────> Server
        Connection Established!
```

### Hub vs Switch vs Router

| Device | OSI Layer | Function | Broadcast Domain | Collision Domain |
|--------|-----------|----------|------------------|------------------|
| **Hub** | Layer 1 | Broadcasts data to all ports; inefficient and outdated | 1 | 1 (shared) |
| **Switch** | Layer 2 | Uses MAC addresses to forward data to specific ports | 1 | Per port |
| **Router** | Layer 3 | Routes packets between different networks using IP | Per port | Per port |

### Core Networking Concepts

- **MAC Address (Media Access Control):** A unique 48-bit (6-byte) hardware address assigned to a network interface (e.g., `00:1A:2B:3C:4D:5E`). The first 24 bits represent the manufacturer (OUI). Operates at Layer 2.
- **ARP (Address Resolution Protocol):** Resolves an IP address (Layer 3) to a MAC address (Layer 2) on a local network using broadcast requests.
- **ICMP (Internet Control Message Protocol):** Used for error reporting and network diagnostics (e.g., Ping uses ICMP Echo Request/Reply, TTL). Operates at Layer 3.
- **NAT (Network Address Translation):** Modifies IP address information in packet headers. Allows multiple devices on a private network to share a single public IP address, conserving IPv4 addresses and adding a layer of security. **PAT (Port Address Translation)** uses different source ports to map multiple internal devices to one external IP.

### Key Networking Protocols

| Protocol | Port | Purpose |
|----------|------|---------|
| **HTTP** | 80 | Web browsing (unencrypted) |
| **HTTPS** | 443 | Web browsing (encrypted with TLS) |
| **DNS** | 53 | Domain name to IP resolution |
| **DHCP** | 67/68 | Automatic IP address assignment |
| **FTP** | 20/21 | File transfer |
| **SSH** | 22 | Secure remote access |
| **Telnet** | 23 | Remote access (unencrypted — insecure) |
| **SMTP** | 25 | Sending email |
| **RDP** | 3389 | Remote desktop |
| **SNMP** | 161/162 | Network management |

### DNS (Domain Name System)
- Translates **domain names** (e.g., google.com) into **IP addresses** (e.g., 1.2.3.4)
- Acts like the **phone book of the internet**
- DNS Resolution Process: Query → Recursive Resolver → Root Server → TLD Server → Authoritative Server

### DHCP (Dynamic Host Configuration Protocol)
- Automatically assigns **IP addresses** and network configuration to devices
- Process: **DORA** — Discover → Offer → Request → Acknowledge

---

## 2. Cryptography — Symmetric Encryption

### What is Symmetric Encryption?
- Uses **one single key** for both encryption and decryption
- The same key must be shared between sender and receiver
- Also called **shared key** or **secret key** encryption

### How it Works
```
Plaintext ──[Encrypt with Key A]──> Ciphertext ──[Decrypt with Key A]──> Plaintext
```

### Common Symmetric Algorithms

| Algorithm | Key Size | Block Size | Status |
|-----------|----------|------------|--------|
| **AES** (Advanced Encryption Standard) | 128, 192, 256 bits | 128 bits | ✅ Current standard — most widely used |
| **DES** (Data Encryption Standard) | 56 bits | 64 bits | ❌ Deprecated — too weak |
| **3DES** (Triple DES) | 168 bits (effective 112) | 64 bits | ⚠️ Legacy — being phased out |
| **Blowfish** | 32-448 bits | 64 bits | ⚠️ Older, replaced by Twofish |
| **RC4** | 40-2048 bits | Stream cipher | ❌ Insecure — deprecated |

### Advantages & Disadvantages

| Advantages | Disadvantages |
|-----------|---------------|
| ✅ Very fast performance | ❌ Key distribution problem |
| ✅ Efficient for large data | ❌ Does NOT provide non-repudiation |
| ✅ Less computational overhead | ❌ Key management scales poorly (n users = n(n-1)/2 keys) |

---

## 3. Cryptography — Asymmetric Encryption

### What is Asymmetric Encryption?
- Uses a **key pair**: one **public key** (shared with everyone) and one **private key** (kept secret)
- Also called **public key cryptography**
- If you encrypt with the public key, only the private key can decrypt (and vice versa)

### How it Works
```
Encryption for Confidentiality:
Plaintext ──[Encrypt with Receiver's PUBLIC key]──> Ciphertext ──[Decrypt with Receiver's PRIVATE key]──> Plaintext

Digital Signature for Authentication:
Message ──[Sign with Sender's PRIVATE key]──> Signed Message ──[Verify with Sender's PUBLIC key]──> Verified
```

### Common Asymmetric Algorithms

| Algorithm | Use Case | Key Size | Notes |
|-----------|----------|----------|-------|
| **RSA** | Encryption, digital signatures | 1024-4096 bits | Most widely used |
| **Diffie-Hellman** | Key exchange | Variable | Used to securely exchange keys |
| **ECC** (Elliptic Curve) | Encryption, signatures | 256-384 bits | Stronger security with smaller keys |
| **DSA** (Digital Signature Algorithm) | Digital signatures only | 1024-3072 bits | Cannot encrypt data |
| **ElGamal** | Encryption, signatures | Variable | Based on Diffie-Hellman |

### Advantages & Disadvantages

| Advantages | Disadvantages |
|-----------|---------------|
| ✅ No key distribution problem | ❌ Much slower than symmetric |
| ✅ Provides non-repudiation | ❌ Computationally expensive |
| ✅ Enables digital signatures | ❌ Not practical for large data |
| ✅ Key management scales well | ❌ Requires PKI infrastructure |

### Symmetric vs Asymmetric — Comparison

| Feature | Symmetric | Asymmetric |
|---------|-----------|------------|
| Keys | One shared key | Key pair (public + private) |
| Speed | Fast | Slow |
| Key distribution | Difficult (must share securely) | Easy (public key is public) |
| Use case | Bulk data encryption | Key exchange, digital signatures |
| Non-repudiation | No | Yes |
| Scalability | Poor (many keys needed) | Good (2 keys per user) |
| Examples | AES, DES, 3DES | RSA, ECC, Diffie-Hellman |

> **Real-World Usage:** Most systems use BOTH — asymmetric to exchange a symmetric key, then symmetric for fast data encryption. This is called a **hybrid approach** (used in TLS/HTTPS).

---

## 4. Hashing

### What is Hashing?
- A **one-way function** that converts data into a **fixed-length string** (hash/digest)
- **Cannot be reversed** — you cannot derive the original data from the hash
- Used for **integrity verification**, NOT encryption

### Properties of Good Hash Functions
1. **Deterministic** — Same input always produces same output
2. **Fixed output length** — Regardless of input size
3. **Avalanche effect** — Small input change = drastically different hash
4. **Collision resistant** — Different inputs should not produce same hash
5. **Pre-image resistant** — Cannot derive input from hash
6. **Fast computation** — Quick to calculate

### Common Hashing Algorithms

| Algorithm | Output Size | Status |
|-----------|------------|--------|
| **MD5** | 128 bits | ❌ Broken — collision vulnerabilities |
| **SHA-1** | 160 bits | ❌ Deprecated — collision attacks found |
| **SHA-256** | 256 bits | ✅ Widely used — part of SHA-2 family |
| **SHA-512** | 512 bits | ✅ Stronger SHA-2 variant |
| **SHA-3** | Variable | ✅ Newest standard (Keccak) |
| **bcrypt** | 184 bits | ✅ Designed for password hashing |

### Hash Use Cases
- **Password storage** — Store hash of password, not the password itself
- **File integrity** — Verify downloads haven't been tampered with
- **Digital signatures** — Hash the message before signing
- **Forensics** — Verify evidence hasn't been altered

### Salting
- **Salt** = A random value added to data before hashing
- Prevents rainbow table attacks and pre-computed hash attacks
- Each user gets a **unique salt**, so identical passwords produce different hashes

```
Without Salt: hash("password123") = abc123 (same for all users)
With Salt:    hash("password123" + "x7kP9") = def456 (unique per user)
```

---

## 5. Digital Signatures

### What is a Digital Signature?
- An electronic signature that uses **asymmetric cryptography** to verify:
  - **Authentication** — Confirms the sender's identity
  - **Integrity** — Confirms the message wasn't altered
  - **Non-repudiation** — Sender cannot deny sending the message

### How Digital Signatures Work

```
Signing Process:
1. Sender creates a HASH of the message
2. Sender ENCRYPTS the hash with their PRIVATE key → Digital Signature
3. Sender attaches the Digital Signature to the message
4. Sends message + digital signature to receiver

Verification Process:
1. Receiver DECRYPTS the signature with sender's PUBLIC key → Original Hash
2. Receiver independently HASHES the received message → New Hash
3. If Original Hash == New Hash → Signature is VALID ✅
4. If they don't match → Message was TAMPERED ❌
```

### Key Points
- **Private key** = Used to SIGN (create signature)
- **Public key** = Used to VERIFY (validate signature)
- Provides **non-repudiation** because only the sender has the private key
- Used in: Software distribution, financial transactions, legal documents, email (S/MIME)

---

## 6. Digital Certificates & PKI

### What is PKI (Public Key Infrastructure)?
- The **underlying framework** that enables entities to securely exchange information using **digital certificates**
- Establishes trust between parties that are previously unknown to each other
- Analogous to **passports/driver's licenses** — a trusted third party vouches for your identity

### Key Components of PKI

| Component | Role |
|-----------|------|
| **CA (Certificate Authority)** | Verifies identities, issues and revokes digital certificates (like a government issuing passports) |
| **RA (Registration Authority)** | Assists CA in verifying identity; does NOT issue certificates |
| **Digital Certificate** | Contains entity's public key + identity info, signed by CA |
| **CRL (Certificate Revocation List)** | List of revoked certificate serial numbers |
| **OCSP (Online Certificate Status Protocol)** | Real-time certificate status checking |

### Digital Certificate Contents
- Entity's **public key**
- Entity's **identifying information** (name, server name, email)
- **CA's digital signature** (signed with CA's private key)
- **Expiry date**
- Uses **X.509 standard**

### Certificate Issuance Process
```
1. Requester creates a CSR (Certificate Signing Request)
   - Contains: requester's details + requester's public key
2. Requester sends CSR to Certificate Authority (CA)
3. CA verifies the requester's identity
4. CA creates the digital certificate:
   - Takes requester's public key + identity info
   - Puts it in X.509 format
   - Signs it with CA's PRIVATE key
5. CA gives the signed certificate to the requester
6. Requester distributes the certificate to users
```

### Certificate Revocation Methods

| Method | Description | Pros | Cons |
|--------|-------------|------|------|
| **CRL** | List of revoked certificate serial numbers | Simple | Time delay, bandwidth heavy |
| **OCSP** | Real-time status query (valid/invalid/unknown) | Real-time | More complex |

### Examples of Certificate Authorities
- DigiCert, GoDaddy, Let's Encrypt, Comodo, GlobalSign

---

## 7. IPSec — Internet Protocol Security

### What is IPSec?
- A comprehensive **suite of protocols** to secure communication over IP networks
- Provides: **Confidentiality** (encryption), **Integrity** (tamper detection), **Authenticity** (identity verification)
- Operates at **Layer 3 (Network Layer)** of the OSI model

### IPSec Components

| Component | Function |
|-----------|----------|
| **AH (Authentication Header)** | Provides integrity and authentication; does NOT encrypt data |
| **ESP (Encapsulating Security Payload)** | Provides confidentiality, integrity, AND authentication; encrypts data |
| **SA (Security Association)** | Defines security parameters (algorithms, keys) for a connection |
| **IKE (Internet Key Exchange)** | Negotiates and establishes SAs; handles key management |
| **SPD (Security Policy Database)** | Defines which traffic should be protected and how |
| **SAD (Security Association Database)** | Stores active SAs and their parameters |

### IPSec Modes

| Feature | Transport Mode | Tunnel Mode |
|---------|---------------|-------------|
| **What's encrypted** | Only the payload (data) | Entire original IP packet |
| **IP Header** | Original IP header preserved | New IP header added |
| **Use Case** | Host-to-host communication | Network-to-network (VPN) |
| **Typical Scenario** | Direct communication between two endpoints | Site-to-site VPN, remote access VPN |
| **Security Level** | Moderate | Higher (entire packet encrypted) |

### IPSec Use Cases
- **Remote Access VPNs** — Employees connecting securely from remote locations
- **Site-to-Site VPNs** — Branch offices connected to corporate network
- **Data Protection** — Encrypting sensitive data in transit (healthcare, finance)
- **Secure VoIP** — Protecting voice communications
- **Data Center Security** — Securing inter-server communication
- **IoT Security** — Securing IoT device communications
- **Cloud Connectivity** — Secure link between on-premise and cloud

### AH vs ESP Comparison

| Feature | AH | ESP |
|---------|-----|-----|
| Confidentiality (Encryption) | ❌ No | ✅ Yes |
| Integrity | ✅ Yes | ✅ Yes |
| Authentication | ✅ Yes | ✅ Yes |
| Anti-replay | ✅ Yes | ✅ Yes |
| IP Header protection | ✅ Yes (entire packet) | ❌ No (only payload) |

---

## 8. Firewall Types

### What is a Firewall?
A network security device or software that **monitors, filters, and controls** incoming and outgoing network traffic based on predefined security rules. Acts as a barrier between **trusted internal** and **untrusted external** networks.

### Types of Firewalls

#### 1. Packet Filtering Firewall
- Operates at **Layer 3 (Network)**
- Inspects **packet headers** (source/destination IP, ports, protocol)
- Uses **ACLs (Access Control Lists)** to allow/block traffic
- **Most basic** type; fast but limited
- **Stateless** — doesn't track connection state
- ⚠️ Vulnerable to IP spoofing

#### 2. Stateful Inspection Firewall
- Operates at **Layer 3 & 4 (Network + Transport)**
- Maintains a **state table** tracking active connections
- Makes **context-aware** decisions based on connection state
- More secure than packet filtering — can prevent IP spoofing
- Dynamically adapts rules based on connection state
- ⚠️ Slightly slower due to state tracking overhead

#### 3. Proxy Firewall (Application Layer Firewall)
- Operates at **Layer 7 (Application)**
- Acts as an **intermediary** between client and server
- Performs **deep packet inspection** at the application level
- Can inspect content, not just headers
- Provides content filtering, URL filtering, caching
- ⚠️ Significant performance overhead; can be a bottleneck

#### 4. Next-Generation Firewall (NGFW)
- Combines **stateful inspection + deep packet inspection + additional features**
- Includes: Application awareness, IPS, threat intelligence, SSL inspection
- Can identify and control applications regardless of port
- Advanced threat protection with sandboxing
- **Most comprehensive** firewall type

#### 5. Web Application Firewall (WAF)
- Specifically protects **web applications**
- Operates at **Layer 7** — focuses on HTTP/HTTPS traffic
- Protects against: SQL injection, XSS, CSRF, and other web attacks
- Can be deployed in front of web servers

### Firewall Types Comparison

| Type | OSI Layer | State Awareness | Content Inspection | Speed | Security Level |
|------|-----------|----------------|-------------------|-------|----------------|
| Packet Filtering | Layer 3 | Stateless | Headers only | Fastest | Basic |
| Stateful Inspection | Layer 3-4 | Stateful | Headers + state | Fast | Moderate |
| Proxy | Layer 7 | Stateful | Full content | Slowest | High |
| NGFW | Layer 3-7 | Stateful | Full + app-aware | Moderate | Highest |
| WAF | Layer 7 | Stateful | HTTP/HTTPS content | Moderate | High (web only) |

---

## 9. Interview Questions & Answers

### Q1: What is the difference between symmetric and asymmetric encryption?
**A:** Symmetric encryption uses ONE shared key for both encryption and decryption — it's fast but has a key distribution problem. Asymmetric uses a key PAIR (public + private) — it's slower but solves key distribution. In practice, both are used together: asymmetric for key exchange, symmetric for data encryption (hybrid approach used in TLS).

### Q2: What is hashing and how is it different from encryption?
**A:** Hashing is a one-way function that converts data into a fixed-length string and CANNOT be reversed. Encryption is a two-way process where data can be encrypted and then decrypted back. Hashing is used for integrity verification (e.g., password storage), while encryption is used for confidentiality (e.g., securing data in transit).

### Q3: What is PKI?
**A:** PKI (Public Key Infrastructure) is a framework that enables secure communication using digital certificates. A Certificate Authority (CA) verifies identities and issues digital certificates containing the entity's public key. The certificates are signed by the CA using its private key, establishing trust. PKI enables secure web browsing (HTTPS), email signing, and code signing.

### Q4: Explain the TCP three-way handshake.
**A:** The TCP handshake establishes a reliable connection: (1) Client sends SYN to server, (2) Server responds with SYN-ACK, (3) Client sends ACK. After this three-step process, the connection is established and data transfer begins. This ensures both sides are ready to communicate.

### Q4.5: What is the difference between a Hub, Switch, and Router?
**A:** A **Hub** (Layer 1) is a dumb device that broadcasts received data to all connected ports, causing collisions and inefficiency. A **Switch** (Layer 2) is smarter; it learns MAC addresses and forwards data only to the specific destination port, creating separate collision domains. A **Router** (Layer 3) connects completely different networks together (e.g., your LAN to the internet) and makes routing decisions based on IP addresses.

### Q4.6: What is the purpose of ARP and NAT?
**A:** **ARP (Address Resolution Protocol)** translates a known IP address to an unknown MAC address on a local network, enabling Layer 2 communication. **NAT (Network Address Translation)** translates private, internal IP addresses to a public IP address for internet access, conserving the limited pool of IPv4 addresses and hiding the internal network structure.

### Q5: What are the differences between the IPSec Transport and Tunnel modes?
**A:** Transport mode encrypts only the data payload while keeping the original IP header intact — used for host-to-host communication. Tunnel mode encrypts the ENTIRE original IP packet and wraps it in a new IP header — used for site-to-site VPNs and remote access VPNs. Tunnel mode provides higher security.

### Q6: What is the difference between AH and ESP in IPSec?
**A:** AH (Authentication Header) provides integrity and authentication but does NOT encrypt data. ESP (Encapsulating Security Payload) provides confidentiality through encryption PLUS integrity and authentication. ESP is more commonly used because it provides encryption.

### Q7: What are the different types of firewalls?
**A:** Packet Filtering (Layer 3, stateless, basic header inspection), Stateful Inspection (Layer 3-4, tracks connection state), Proxy/Application Layer (Layer 7, deep inspection, acts as intermediary), Next-Generation (combines all features with application awareness, IPS, threat intel), and WAF (Layer 7, specifically protects web applications from SQL injection, XSS, etc.).

### Q8: Why is MD5 considered insecure?
**A:** MD5 is insecure because it has known collision vulnerabilities — different inputs can produce the same hash. This means an attacker could create a malicious file with the same MD5 hash as a legitimate file. SHA-256 or SHA-3 should be used instead.

### Q9: What is the role of a digital signature?
**A:** A digital signature provides three security services: Authentication (confirms sender identity), Integrity (confirms message wasn't altered), and Non-repudiation (sender can't deny sending). The sender hashes the message and encrypts the hash with their private key. The receiver decrypts with the sender's public key and compares hashes.

### Q10: What is salting in the context of password storage?
**A:** Salting adds a unique random value to each password before hashing. This prevents rainbow table attacks because identical passwords produce different hashes when different salts are used. Each user gets a unique salt stored alongside their hash.

---

## 10. Quick Reference Tables

### Encryption Algorithms Summary

| Algorithm | Type | Key Size | Status | Use Case |
|-----------|------|----------|--------|----------|
| AES | Symmetric | 128/192/256 | ✅ Standard | Bulk data encryption |
| DES | Symmetric | 56 | ❌ Deprecated | Legacy only |
| 3DES | Symmetric | 168 | ⚠️ Phase-out | Legacy compatibility |
| RSA | Asymmetric | 1024-4096 | ✅ Widely used | Key exchange, signatures |
| ECC | Asymmetric | 256-384 | ✅ Modern | Mobile, IoT (smaller keys) |
| Diffie-Hellman | Asymmetric | Variable | ✅ Used | Key exchange only |

### Hash Algorithm Status

| Algorithm | Bits | Secure? | Use |
|-----------|------|---------|-----|
| MD5 | 128 | ❌ | Checksum only (not security) |
| SHA-1 | 160 | ❌ | Legacy only |
| SHA-256 | 256 | ✅ | General purpose |
| SHA-3 | Variable | ✅ | Latest standard |
| bcrypt | 184 | ✅ | Password hashing |

### Common Port Numbers

| Port | Protocol | Service |
|------|----------|---------|
| 20/21 | TCP | FTP |
| 22 | TCP | SSH |
| 23 | TCP | Telnet |
| 25 | TCP | SMTP |
| 53 | TCP/UDP | DNS |
| 67/68 | UDP | DHCP |
| 80 | TCP | HTTP |
| 443 | TCP | HTTPS |
| 3389 | TCP | RDP |

---

## 11. Key Takeaways

1. ✅ **OSI Model** has 7 layers — know each layer, its function, and example protocols
2. ✅ **TCP** = reliable, connection-oriented; **UDP** = fast, connectionless
3. ✅ **Hub** = Layer 1 (Broadcasts), **Switch** = Layer 2 (MAC), **Router** = Layer 3 (IP/Routing)
4. ✅ **ARP** resolves IP to MAC; **NAT** maps private IPs to public IPs
5. ✅ **Symmetric** = one key, fast; **Asymmetric** = key pair, slow but more secure
4. ✅ **Hashing** is one-way (irreversible); **Encryption** is two-way (reversible)
5. ✅ **Digital Signatures** provide authentication, integrity, and non-repudiation
6. ✅ **PKI** uses CAs to issue digital certificates establishing trust
7. ✅ **IPSec** operates at Layer 3; Transport mode = host-to-host; Tunnel mode = network VPN
8. ✅ **AH** = integrity only; **ESP** = encryption + integrity
9. ✅ **Packet Filter** → **Stateful** → **Proxy** → **NGFW** (increasing sophistication)
10. ✅ Always use **AES** for symmetric, **SHA-256+** for hashing, avoid MD5/DES

---

> 📌 **Previous:** [Part 1: Cybersecurity Fundamentals](./Study_Guide_Part1_Cybersecurity_Fundamentals.md)  
> 📌 **Next:** [Part 3: Attacks, Threats & Countermeasures](./Study_Guide_Part3_Attacks_Threats_Countermeasures.md)
