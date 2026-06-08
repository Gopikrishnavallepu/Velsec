# SOC Interview Preparation Guide

This document aligns and enriches answers for common SOC interview questions, categorized by topic, based on industry best practices and internal knowledge base data.

---

## 1. Personal Background & Experience

### Q1. Briefly explain your SOC experience and current responsibilities.
**Answer:**
"I have [X] years of experience working in a Security Operations Center as a Tier [X] analyst. My primary responsibilities include continuously monitoring SIEM alerts (e.g., Splunk, Sentinel), triaging security events, and performing initial investigations. I handle the initial incident response lifecycle, validate true positives against false positives, and escalate complex incidents to Tier 3 or the Incident Response team. I also proactively hunt for threats using frameworks like MITRE ATT&CK, analyze endpoint telemetry via EDR tools (like CrowdStrike or Defender), and help tune detection rules to reduce alert fatigue."

### Q2. Describe a major security incident that you handled end-to-end.
**Answer:**
*(Here are two examples you can use depending on the interview context, using the STAR method)*

**Example 1: Fake CAPTCHA PowerShell Infostealer (MITRE ATT&CK Mapped)**
**Situation:** We received multiple EDR alerts for heavily obfuscated PowerShell execution originating directly from the Windows Run dialog (`explorer.exe`) on several marketing workstations.
**Task:** My task was to triage the alerts, determine the root cause of this unusual execution path, contain the affected hosts, and prevent wider infection.
**Action:** I isolated the endpoints via EDR and analyzed the process tree. The logs showed `powershell.exe -W Hidden -EncodedCommand ...` being executed. I decoded the payload using CyberChef, revealing a script designed to download an infostealer. I interviewed one of the users, who stated they were prompted by a "Verify you are human" CAPTCHA page to press Windows+R, CTRL+V, and Enter. This tricked them into executing the payload. I mapped this to the MITRE ATT&CK framework: **Execution (T1059.001 - PowerShell, T1204 - User Execution)**, **Defense Evasion (T1027 - Obfuscated Files or Information)**, and **Command and Control (T1105 - Ingress Tool Transfer)**. I then queried the SIEM for the malicious C2 IP to identify other impacted hosts.
**Result:** I identified and contained three compromised machines in total. I coordinated with IT to reimage the devices and forced a password reset for the affected users. Finally, we blocked the C2 infrastructure at the firewall and sent out an emergency security awareness bulletin detailing this novel fake CAPTCHA technique.

**Example 2: TFTP Server Compromise via Exposure Vulnerability (MITRE ATT&CK Mapped)**
**Situation:** A misconfigured perimeter firewall accidentally exposed a vulnerable legacy TFTP server (UDP port 69) to the internet. We received an IDS/IPS alert for a directory traversal attack targeting this exposed service, originating from an external IP.
**Task:** My task was to investigate the alert, identify what the attacker accessed via the vulnerability, contain the exposure, and determine if lateral movement occurred.
**Action:** I analyzed the firewall and network flow logs, discovering that the external attacker exploited the directory traversal vulnerability in the exposed TFTP service to bypass intended directories and download sensitive router and switch configuration files. I immediately contacted the network team to drop the firewall rule exposing the server. I mapped the attacker's activity to the MITRE ATT&CK framework: **Initial Access (T1190 - Exploit Public-Facing Application)**, **Discovery (T1016 - System Network Configuration Discovery)**, and **Exfiltration (T1048 - Exfiltration Over Alternative Protocol)**. Reviewing the SIEM, I confirmed no lateral movement or payload execution occurred internally.
**Result:** We successfully contained the incident within 30 minutes by blocking external access to the TFTP server. Because the exfiltrated router configs contained hashed passwords, we initiated an emergency enterprise-wide password rotation for all network infrastructure. We also permanently decommissioned the vulnerable TFTP server and implemented strict Access Control Lists (ACLs).

### Q9. What threat hunting activities have you performed?
**Answer:**
"I actively perform hypothesis-driven threat hunting based on the MITRE ATT&CK framework and recent threat intel. For example, I might form a hypothesis that attackers are using living-off-the-land (LOLBins) techniques. I would query our SIEM for abnormal usage of `certutil.exe` or `bitsadmin.exe` downloading files from external IPs. I also hunt for persistence mechanisms, like unexpected scheduled tasks, registry run key modifications, or newly created services, reviewing telemetry that might not have triggered a static alert."

### Q12. What dashboards, use cases or detection rules have you created or tuned?
**Answer:**
"I have developed several use cases focusing on credential theft and lateral movement. For instance, I created a Splunk dashboard tracking multiple failed login attempts followed by a successful login, specifically focusing on service accounts. I also tuned a noisy detection rule for 'Impossible Travel' by whitelisting known corporate VPN IP ranges and focusing the alert only on successful authentications to reduce false positives by 40%."

### Q13. Describe a challenging security incident and how you resolved it.
**Answer:**
*(Focus on complexity or ambiguity)*
"A challenging incident involved a slow-and-low data exfiltration attempt. We observed a slight but consistent spike in outbound HTTPS traffic from a database server during off-hours. Standard EDR didn't flag any malicious processes. I resolved it by correlating network flow logs with process execution logs, discovering a legitimate administrative tool was being misused by a compromised service account to send data to a cloud storage provider. I isolated the server, disabled the service account, and we implemented stricter egress filtering rules for critical servers."

---

## 2. Core Security Concepts

### Q3. What is the difference between IOC and IOA? Provide practical example.
**Answer:**
*   **IOC (Indicator of Compromise):** A piece of forensic data showing that an intrusion *has already occurred*. It is signature-based and reactive.
    *   *Example:* Known malicious IP addresses, malware file hashes (MD5/SHA256), or specific malicious domain names found in logs.
*   **IOA (Indicator of Attack):** Focuses on the *intent and behavior* of an attacker, regardless of the tools used. It identifies active attacks in progress, catching zero-days.
    *   *Example:* A sequence of behaviors, such as a user opening a Word document (winword.exe), which spawns a command shell (cmd.exe), which then runs PowerShell (powershell.exe) to connect to an external IP. Even if the IP or script is unknown, the *behavior* is highly suspicious.

### Q5. What is Mimikatz?
**Answer:**
"Mimikatz is a prominent open-source post-exploitation tool primarily used by attackers for credential theft. It extracts plaintext passwords, hash, PIN code, and Kerberos tickets from memory (specifically the LSASS process in Windows). Attackers use it to perform techniques like Pass-the-Hash, Pass-the-Ticket, or to build Golden/Silver tickets for lateral movement and privilege escalation."

### Q6. Explain the MITRE ATT&CK framework and how you use it during investigations.
**Answer:**
"The MITRE ATT&CK framework is a globally accessible knowledge base of adversary tactics (the 'why' or the goal) and techniques (the 'how'). I use it extensively across the SOC:
1.  **Investigations:** To understand where an attacker might go next (e.g., if I see Initial Access, I look for Persistence or Privilege Escalation techniques).
2.  **Threat Hunting:** To structure my hunts. I select a specific technique (like T1003 - OS Credential Dumping) and actively search for it in our environment.
3.  **Detection Engineering:** To map our current SIEM rules against the matrix to identify visibility gaps and prioritize new rule creation."

### Q11. Explain the incident response lifecycle with examples from your experience.
**Answer:**
"I follow the NIST/SANS 6-step lifecycle:
1.  **Preparation:** Ensuring tools (SIEM/EDR) are tuned, runbooks are updated, and logging is enabled.
2.  **Identification:** Triaging an alert. *Example:* Identifying a true positive alert for Mimikatz execution via EDR telemetry.
3.  **Containment:** Stopping the bleeding. *Example:* Network-isolating the infected host via the EDR console to prevent lateral movement.
4.  **Eradication:** Removing the threat. *Example:* Deleting the malicious binary and removing the registry keys it created for persistence.
5.  **Recovery:** Restoring normal operations. *Example:* Having IT reimage the machine and having the user reset their credentials before returning it to the network.
6.  **Lessons Learned:** Conducting a post-incident review to improve future response, like implementing a new detection rule for the specific attack vector used."

---

## 3. Triage & Operations

### Q7. How do you perform triage and prioritize security alerts?
**Answer:**
"I prioritize alerts based on three main factors: **Severity, Asset Criticality, and Confidence**.
1.  **Severity/Impact:** Alerts related to credential dumping, ransomware behavior, or lateral movement are P1s.
2.  **Asset Criticality:** An alert on a Domain Controller or a VIP's laptop takes precedence over a guest Wi-Fi device.
3.  **Context/Confidence:** I check if the alert maps to known threat intel or if it's a known noisy rule.
My workflow involves acknowledging the alert, analyzing the raw logs/EDR telemetry to validate if it's a True Positive or False Positive, checking the scope (is it one host or many?), and then escalating or containing based on our SOPs."

### Q15. You notice that an endpoint protection agent has been disabled on system, what are your next steps?
**Answer:**
1.  **Verify the alert:** Check the host's status in the centralized EDR console. Check Windows Event Logs (System/Security) to see who or what disabled the service.
2.  **Determine Intent:** Was it an IT admin performing troubleshooting (check ticketing systems/change management), or was it unauthorized?
3.  **Investigate the Host:** Query the SIEM for activity on that host immediately *prior* to the agent being disabled. Look for suspicious process executions, new logons, or malware staging.
4.  **Containment:** If unauthorized, I would immediately isolate the host at the network level (switch port/firewall) since EDR containment might not work, and initiate the IR process for a potentially compromised machine.

---

## 4. Investigation Scenarios

### Q4. How do you investigate a phishing incident from alert generation to closure?
**Answer:**
1.  **Identification:** Extract indicators from the reported email (Sender IP, Domain, Reply-To, URLs, Attachments). Analyze headers for SPF/DKIM/DMARC failures. Use sandboxing tools to analyze attachments or URLs.
2.  **Scoping:** Search the email gateway/SIEM to see who else received the email and who clicked the link or downloaded the attachment.
3.  **Containment:** Purge the email from user inboxes. Block the malicious domains/IPs at the firewall/proxy, and block sender domains in the email gateway.
4.  **Endpoint Investigation:** For users who clicked, check EDR and proxy logs for successful connections, credential submissions, or subsequent payload execution. Reset credentials for compromised users and isolate infected endpoints.
5.  **Eradication/Recovery:** Reimage compromised endpoints, confirm blocklists are active.
6.  **Closure:** Document the incident, update the threat intel platform, and close the ticket.

### Q8. What steps would you take if a host is suspected to be compromised?
**Answer:**
1.  **Containment First:** Immediately isolate the host from the network using EDR to prevent lateral movement or data exfiltration, while leaving it powered on to preserve RAM for forensics.
2.  **Triage & Scoping:** Review EDR telemetry and SIEM logs for the host to identify the root cause (Initial Access vector).
3.  **Identify IOCs:** Extract malicious IPs, hashes, and domains involved in the compromise.
4.  **Enterprise Search:** Query the SIEM/EDR across the entire environment using those IOCs to ensure no other hosts are infected.
5.  **Eradication:** Coordinate with IT to reimage the machine.
6.  **Recovery:** Have the user reset all credentials. Monitor the host post-reimaging.

### Q10. How do you investigate suspicious PowerShell activity?
**Answer:**
1.  **Analyze the Command Line:** Look for obfuscation techniques (e.g., base64 encoding `-enc`, mixed casing, tick marks).
2.  **Decode:** If encoded, decode the payload using tools like CyberChef to reveal the true script.
3.  **Process Tree:** Examine the parent process. PowerShell spawned by `winword.exe`, `excel.exe`, or `w3wp.exe` (IIS) is highly suspicious.
4.  **Execution Policy:** Check if execution policies were bypassed (e.g., `-ExecutionPolicy Bypass` or `-ep bypass`).
5.  **Network Activity:** Check if the PowerShell process initiated any outbound network connections to download secondary payloads (e.g., using `Net.WebClient`).
6.  **Script Block Logging:** If Event ID 4104 is enabled, review the actual script blocks executed for malicious intent.

### Q14. How would you investigate a newly created administrator account using logs?
**Answer:**
1.  **Identify the Event:** Look for Windows Event ID 4720 (A user account was created) followed by 4732/4728 (A member was added to a security-enabled local/global group).
2.  **Identify the Actor:** Determine *who* created the account (the Subject user in the logs) and from which host.
3.  **Validate Authorization:** Check Change Management systems (Jira/ServiceNow) to see if this was a scheduled administrative task. Contact the administrator who created it for verification.
4.  **Look for Suspicious Context:** Did this happen at 3 AM on a Sunday? Was the account created by a generic service account or an account that shouldn't have admin rights? Did the creation follow suspicious lateral movement or a brute-force attack (Event ID 4625)?
5.  **Action:** If unauthorized, immediately disable the new account, disable the compromised account that created it, and initiate an incident response.

### Q16. A user reports a suspicious email after clicking the link and entering credentials. How would you investigate and respond?
**Answer:**
1.  **Immediate Containment:** Immediately reset the user's AD/SSO password and revoke all active session tokens to kill the attacker's access.
2.  **Analyze the Email:** Extract the URL and sender details. Purge the email from the environment.
3.  **Check Access Logs:** Review Identity Provider (Okta/Azure AD) logs for successful authentications originating from unusual IPs, locations, or devices using the compromised account.
4.  **Review Post-Compromise Activity:** If the attacker logged in, check what they accessed (e.g., mail forwarding rules created, accessing sensitive SharePoint files).
5.  **Implement Defenses:** Add the malicious URL/IP to proxy blocklists.
6.  **Follow up:** Ensure MFA is enforced for the user and educate the user on phishing awareness.

### Q17. You observed a spike in outbound traffic from a workstation during non-business hours. How would you determine whether it is malicious?
**Answer:**
1.  **Identify the Process:** Use EDR or Sysmon network connection logs (Event ID 3) to identify the exact process (e.g., `powershell.exe`, `chrome.exe`, `svchost.exe`) initiating the traffic.
2.  **Identify the Destination:** Check the destination IP/Domain against Threat Intelligence platforms (VirusTotal, AlienVault OTX). Check the ASN and geolocation.
3.  **Analyze Volume & Frequency:** Is it a continuous stream (data exfiltration) or periodic beacons (C2 communication)?
4.  **Check User Context:** Was a user physically logged in? Did they leave a massive file upload running, or is the system idle?
5.  **Correlate:** Look for other alerts on the host (e.g., an alert for a downloaded malicious file earlier in the day).
6.  **Action:** If it's a suspicious process communicating with an unknown/malicious IP, isolate the host and investigate for malware.

### Q18. An endpoint is communicating with a known malicious IP address, what information would you gather before taking containment actions?
**Answer:**
"Ideally, containment should be rapid, but to avoid business disruption, I would quickly gather:
1.  **The Process:** What executable is making the connection? If it's a known signed business application, it could be an IP reuse issue or a false positive. If it's an unknown binary or PowerShell, it's highly critical.
2.  **Direction and State:** Was the connection successful or blocked by the firewall? Is data actually being transferred (bytes in/out)?
3.  **Host Criticality:** Is it a critical production server where isolation causes an outage, or a user workstation?
4.  **Context:** Did the host exhibit other suspicious behaviors prior to the connection (e.g., suspicious child processes)?
Once I confirm the process is suspicious and the connection is successful, I will isolate the host."

### Q19. A threat actor creates a new local admin account on an endpoint. How would you detect and investigate this activity?
**Answer:**
1.  **Detection:** Trigger on Windows Event ID 4720 (User creation) and 4732 (Added to Local Administrators group).
2.  **Investigation:** Identify the parent process that executed the creation (e.g., `cmd.exe` running `net user newadmin password /add`).
3.  **Trace Backwards (Root Cause):** How did the attacker get shell access to run that command? Did they exploit a vulnerability (e.g., an exposed RDP port), use compromised credentials, or drop a webshell? Look for Initial Access vectors.
4.  **Trace Forwards:** Did the newly created account log in (Event 4624)? What did it do next?
5.  **Response:** Disable the account, isolate the endpoint, and block the attacker's ingress point.

### Q20. You identify a true positive incident affecting multiple endpoints. How would you coordinate containment, eradication, and recovery activities?
**Answer:**
1.  **Escalation & Communication:** Declare a major incident. Establish a war room/bridge with stakeholders (IT, Network, Legal, PR).
2.  **Coordinated Containment:** Rather than isolating endpoints one by one, I'd coordinate with Network/IT to segment the affected VLANs, or use EDR mass-action capabilities to isolate all compromised hosts simultaneously to prevent lateral movement.
3.  **Enterprise Search & Eradication:** Extract all IOCs from the initial findings. Run a sweeping query across the entire EDR estate to find every infected machine. Push a script or use EDR response capabilities to kill the malicious processes and delete files en masse.
4.  **Recovery:** Work with IT to prioritize reimaging of critical assets first. Mandate a global or targeted credential reset.
5.  **Post-Incident:** Ensure patches or misconfigurations that led to the breach are fixed before returning machines to production.
