---
title: "Study Guide Part8 Cloud Security Azure"
category: "Security Engineer"
tags: ["SOC"]
lastUpdated: "2026-06-05"
---

# 📘 Part 8: Cloud Security & Azure

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
> 📌 **End of Study Guide.** Return to [Master Index](./Study_Guide_Master_Index.md)
