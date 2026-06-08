# 🧠 SOC 15+ Year Expert Level: The Exhaustive Master Guide

*Every single node from the Threat Hunting, Endpoint Detection, Malware Analysis, Detection Engineering, and Phishing Analysis mind maps has been explicitly broken down from basic concepts to 15+ year expert methodologies.*

---

## 1. Threat Hunting

### Network Threat Hunting : Identifying ARP spoofing attacks
*   **Basic:** Attackers broadcast fake ARP messages to map their MAC address to the gateway's IP.
*   **Intermediate:** Checking the local ARP cache (`arp -a`) or analyzing Wireshark for multiple IP addresses resolving to a single MAC address.
*   **Advanced (Expert):** Bypassing legacy Dynamic ARP Inspection (DAI). Proactively hunting for gratuitous ARPs at scale using Zeek's `weird.log` and implementing automated MACsec (802.1AE) validation across switch fabrics.

### MAC flooding detection
*   **Basic:** Attackers send thousands of fake MAC addresses to a switch to overflow its CAM table.
*   **Intermediate:** When full, the switch acts like a hub, broadcasting all traffic. Detected via port security alerts.
*   **Advanced (Expert):** Attackers using tools like `macof`. Hunting involves analyzing SNMP trap data for interface drops and spanning-tree protocol (STP) topology changes indicating a compromised switch layer.

### Denial-of-Service (DoS) attacks
*   **Basic:** Overwhelming a target with traffic to render it unavailable.
*   **Intermediate:** Differentiating volumetric attacks (SYN floods) from application-layer attacks (Slowloris). Triaged via NetFlow spikes.
*   **Advanced (Expert):** Handling Distributed Reflection DoS (DRDoS) leveraging UDP protocols (NTP, Memcached). Mitigating dynamically by injecting BGP Flowspec routes to drop traffic at the ISP level.

### Identifying large ICMP traffic
*   **Basic:** Normal Ping (ICMP Echo Request/Reply) is typically 32 or 64 bytes.
*   **Intermediate:** Exceptionally large ICMP packets (> 100 bytes) indicate ICMP Tunneling (data exfiltration/C2).
*   **Advanced (Expert):** Identifying APT custom ICMP shells. Using ELK to perform Shannon entropy calculations on the ICMP data payloads; high entropy indicates encrypted exfiltration.

### Normal TCP traffic vs Nmap scanning traffic
*   **Basic:** Normal traffic completes the 3-way handshake (`SYN`, `SYN-ACK`, `ACK`).
*   **Intermediate:** Nmap stealth scans drop the connection (`SYN`, `SYN-ACK`, `RST`) to avoid OS logging.
*   **Advanced (Expert):** Detecting Nmap NSE scripts via JA3 TLS fingerprinting. Hunting for Decoy scans (`-D`) by correlating TTL values of incoming packets to separate the attacker from spoofed decoys.

### DHCP traffic monitoring
*   **Basic:** Rogue DHCP servers assign malicious DNS settings to clients.
*   **Intermediate:** Detecting unexpected `DHCPOFFER` packets originating from non-infrastructure MAC addresses.
*   **Advanced (Expert):** Detecting DHCP starvation attacks (`Yersinia`). Hunting using DHCP snooping enforcement logs and correlating lease exhaustion with rogue server deployments.

### DNS traffic monitoring
*   **Basic:** Attackers use DNS to find targets or use Fast-Flux to rapidly change IP addresses.
*   **Intermediate:** Identifying DNS Tunneling by looking for massive volumes of `TXT` queries or unusually long subdomains.
*   **Advanced (Expert):** Hunting for Domain Generation Algorithms (DGAs). Using machine learning in SIEMs to calculate lexical features of domains (vowel/consonant ratios) to detect DGA beacons automatically.

### Normal HTTP and HTTPS traffic vs suspicious traffic
*   **Basic:** Identifying traffic going to known bad URLs.
*   **Intermediate:** Spotting missing, hardcoded, or anomalous `User-Agent` strings. Detecting POST requests to endpoints with no Referrer.
*   **Advanced (Expert):** Detecting Domain Fronting (DNS request for a trusted CDN but HTTP Host header is routed to the attacker). Analyzing JA3/JA3S fingerprints.

### Identifying malware communication using Wireshark
*   **Basic:** Spotting cleartext HTTP GET requests downloading malicious binaries.
*   **Intermediate:** Identifying automated callbacks to C2. 
*   **Advanced (Expert):** Identifying custom XOR encryption over HTTP. Extracting pre-master secrets to decrypt TLS traffic in Wireshark for deep packet inspection.

### Identifying byte size patterns
*   **Basic:** Traffic returning exactly the same byte size repeatedly.
*   **Intermediate:** Beaconing signatures (e.g., 512 bytes out, 1024 bytes in).
*   **Advanced (Expert):** Attackers introduce "Jitter" (randomized delays). Using K-Means clustering on network flow data to find mathematical beaconing patterns despite the jitter.

### TCP streams in malware communication
*   **Basic:** Using Wireshark "Follow TCP Stream" to read payloads.
*   **Intermediate:** Identifying protocol mismatch (e.g., an HTTP payload traveling over port 4444).
*   **Advanced (Expert):** Carving out specific file types (PE files, DLLs) directly from the hex view of a TCP stream. 

### Hunting web shells
*   **Basic:** Malicious scripts (PHP, ASPX) allowing attackers to execute commands via a browser.
*   **Intermediate:** Detecting web server processes (`w3wp.exe`) spawning `cmd.exe`.
*   **Advanced (Expert):** Hunting for memory-resident web shells (China Chopper). Monitoring for HTTP POST requests where the entire payload body is highly obfuscated Base64.

### Endpoint Threat Hunting
*   **Basic:** Differentiating between normal OS activity and malware execution.
*   **Intermediate:** Utilizing EDR to map process trees and identify anomalous execution paths.
*   **Advanced (Expert):** Hunting for living-off-the-land (LOLBins) abuse using native OS tools to evade EDR hooks.

### Understanding Windows processes
*   **Basic:** Knowing normal processes (`lsass.exe`, `wininit.exe`).
*   **Intermediate:** Understanding Parent-Child relationships. `svchost.exe` should only ever be spawned by `services.exe`. 
*   **Advanced (Expert):** Hunting for Process Hollowing and Process Doppelgänging. Comparing memory permissions (e.g., `PAGE_EXECUTE_READWRITE` on unbacked memory regions) across the enterprise via EDR.

### Using PowerShell for threat hunting
*   **Basic:** Using `Get-Process` or `Get-Service` to view running states locally.
*   **Intermediate:** Using `Get-WmiObject` or `Get-CimInstance` to pull system information remotely.
*   **Advanced (Expert):** Using PowerShell Remoting (`Invoke-Command`) to query WMI across hundreds of endpoints to find malicious command-line arguments and anomalous loaded DLLs natively without EDR.

### Investigating Windows processes using PowerShell
*   **Basic:** Stopping malicious processes using `Stop-Process`.
*   **Intermediate:** Correlating PIDs to network connections using `Get-NetTCPConnection`.
*   **Advanced (Expert):** Writing custom `.NET` hooks in PowerShell to dump process memory (MiniDumpWriteDump) or identify hidden rootkit processes bypassing traditional API calls.

---

## 2. End Point Detection

### Collecting Windows logs
*   **Basic:** Opening Event Viewer locally.
*   **Intermediate:** Configuring Windows Event Forwarding (WEF) to send logs centrally to a SIEM.
*   **Advanced (Expert):** Deploying custom XML WEF subscriptions to filter noise at the source, ensuring only high-fidelity events (like 4688 with command line auditing) hit the SIEM to save ingestion costs.

### File Integrity Monitoring (FIM) in Windows (Revised)
*   **Basic:** Tracking changes to critical files.
*   **Intermediate:** Setting up Wazuh FIM for `C:\Windows\System32\drivers\etc\hosts`.
*   **Advanced (Expert):** Utilizing FIM on memory spaces, not just disk, to detect DLL sideloading and fileless registry key manipulation.

### Detection and removal of malware using VirusTotal (Revised)
*   **Basic:** Manually uploading suspicious files to VirusTotal.
*   **Intermediate:** Using VT API for automated hash enrichment in SOAR.
*   **Advanced (Expert):** Understanding OPSEC: Never uploading proprietary payloads to VT (it leaks them). Searching exclusively by hash or custom YARA hunting via VT Enterprise.

### Detecting malware using YARA rules
*   **Basic:** String matching in files.
*   **Intermediate:** Deploying basic YARA rules to scan disks for hex signatures of known malware.
*   **Advanced (Expert):** Writing advanced YARA rules matching on specific PE sections, opcodes, and entry point characteristics to detect custom-packed, zero-day malware variants entirely in memory.

### Integrating Sysmon to detect fileless malware
*   **Basic:** Installing Sysmon for enhanced logging.
*   **Intermediate:** Looking for Event ID 1 (`ProcessCreate`) to catch malicious command lines.
*   **Advanced (Expert):** Fileless malware lives in RAM. Tuning Sysmon to monitor Event ID 8 (`CreateRemoteThread`) for Cobalt Strike process injection, and Event ID 10 (`ProcessAccess`) to catch Mimikatz.

### Threat hunting using Wazuh
*   **Basic:** Installing the Wazuh agent as a HIDS.
*   **Intermediate:** Writing custom Wazuh decoders to parse bespoke application logs.
*   **Advanced (Expert):** Using Wazuh's Active Response to automatically kill processes or block IPs based on complex correlation rules triggering across multiple endpoints simultaneously.

### Command monitoring
*   **Basic:** Logging bash history or cmd prompt execution.
*   **Intermediate:** Enabling Event ID 4688 with "Include command line in process creation events".
*   **Advanced (Expert):** Bypassing command line logging by directly invoking APIs. Detecting this requires API hooking or ETW (Event Tracing for Windows) Ti (Threat Intelligence) telemetry via EDR.

### Detecting PowerShell abuse techniques
*   **Basic:** Noticing `powershell.exe` running unexpectedly.
*   **Intermediate:** Flagging suspicious arguments: `-ExecutionPolicy Bypass`, `-WindowStyle Hidden`, `-EncodedCommand`.
*   **Advanced (Expert):** Attackers load `System.Management.Automation.dll` directly (PowerShell without PowerShell). Detected by enabling Script Block Logging (Event ID 4104) to log the de-obfuscated script content regardless of execution method.

### Integrating Wazuh with the YETI platform
*   **Basic:** Understanding threat intelligence feeds.
*   **Intermediate:** Pulling IOCs from YETI into Wazuh CDB lists for matching.
*   **Advanced (Expert):** Automating the pipeline: Wazuh sees an unknown IP -> sends to YETI via API -> YETI queries 50 intel feeds -> if malicious, YETI pushes an active response rule back to Wazuh to isolate the host.

### Detecting malware persistence techniques in Windows
*   **Basic:** Checking the startup folder (`shell:startup`).
*   **Intermediate:** Monitoring Registry Run Keys and Scheduled Tasks.
*   **Advanced (Expert):** Hunting for WMI Event Subscriptions (malware executing purely based on an OS event trigger in the WMI repository), COM Hijacking, and Image File Execution Options (IFEO) debugger hijacking.

### Installing and testing Suricata
*   **Basic:** Running Suricata as an IDS.
*   **Intermediate:** Downloading Emerging Threats (ET) open rulesets and analyzing the `fast.log`.
*   **Advanced (Expert):** Deploying Suricata in IPS (Inline) mode. Utilizing Lua scripting within Suricata to perform complex, stateful protocol parsing and TLS decryption/inspection.

### Testing web-based attacks using DVWA
*   **Basic:** Clicking through DVWA to understand web vulnerabilities.
*   **Intermediate:** Generating PCAPs while exploiting DVWA SQLi/XSS to understand network signatures.
*   **Advanced (Expert):** Using the DVWA traffic to tune WAF (Web Application Firewall) rules and Suricata signatures to ensure zero false positives on legitimate traffic while blocking the exploit payloads.

### Alerts and Notifications
*   **Basic:** Getting an alert in a web console.
*   **Intermediate:** Classifying alerts by severity (P1, P2, P3).
*   **Advanced (Expert):** Implementing Risk-Based Alerting (RBA). Instead of firing an alert per event, assigning risk scores to users/hosts over 7 days to detect low-and-slow APTs and reduce alert fatigue.

### Sending alert notifications via email
*   **Basic:** SMTP email triggers on every alert.
*   **Intermediate:** Aggregating alerts to send digest emails to avoid spamming the SOC.
*   **Advanced (Expert):** Integrating with SOAR (e.g., Demisto/Cortex XSOAR) to send interactive emails where analysts can click a button inside the email to isolate a host or block an IP directly via API.

### Dashboards and Graphs
*   **Basic:** Viewing pie charts of top blocked IPs.
*   **Intermediate:** Building time-series graphs showing authentication failures versus successes.
*   **Advanced (Expert):** Creating dynamic, drill-down dashboards that correlate MITRE ATT&CK coverage maps with live alerting data to visually identify gaps in detection engineering in real-time.

### Creating charts and dashboards
*   **Basic:** Using default SIEM widgets.
*   **Intermediate:** Writing custom KQL (Kibana Query Language) to visualize specific event IDs.
*   **Advanced (Expert):** Using Canvas (in ELK) to create pixel-perfect, live-updating executive reports that translate raw security telemetry into business risk metrics.

### Installing Grafana
*   **Basic:** Setting up Grafana locally.
*   **Intermediate:** Connecting Grafana to Prometheus or Elasticsearch data sources.
*   **Advanced (Expert):** Deploying Grafana in a highly available Kubernetes cluster, using Terraform to provision standard dashboards across multiple SOC environments as infrastructure-as-code.

### Creating dashboards in Grafana
*   **Basic:** Importing pre-made community dashboards.
*   **Intermediate:** Building specific NOC/SOC views (e.g., tracking firewall bandwidth utilization).
*   **Advanced (Expert):** Integrating Grafana with custom Python scripts that pull EDR API data, SIEM logs, and Threat Intel feeds into a single unified "Single Pane of Glass" for Tier 3 incident response.

---

## 3. Malware Analysis

### An initial overview of malware analysis
*   **Basic:** Understanding the difference between a virus, worm, trojan, and ransomware.
*   **Intermediate:** Knowing when to use static vs dynamic analysis. Setting up a safe VM environment.
*   **Advanced (Expert):** Building automated malware analysis pipelines leveraging Cuckoo Sandbox APIs integrated directly into the SOC's SOAR platform.

### Basic static analysis techniques
*   **Basic:** Running `strings` on a binary. Checking the MD5/SHA256 hash.
*   **Intermediate:** Using `PEStudio` to examine PE headers, imported DLLs, and checking for packers (UPX).
*   **Advanced (Expert):** Calculating and clustering malware based on `imphash` (Import Hash) and `ssdeep` (Fuzzy Hashing) to attribute new, unknown binaries to known APT groups based on compiler similarities.

### Basic dynamic analysis techniques
*   **Basic:** Clicking the malware in a basic VM and watching what pops up.
*   **Intermediate:** Using Process Monitor (`ProcMon`), `RegShot`, and `Wireshark` to track registry keys created, files dropped, and network callouts.
*   **Advanced (Expert):** Utilizing INetSim to fake internet services (DNS, HTTP) so the malware fully detonates and reveals its secondary payloads, while capturing all traffic in a controlled, isolated lab.

### Challenge - 1. practical - putty
*   **Basic:** Identifying that a downloaded Putty executable is acting strangely.
*   **Intermediate:** Comparing the hash against the official Putty hash. Looking for invalid digital signatures.
*   **Advanced (Expert):** Reversing the binary to locate the exact hook where the legitimate Putty execution flow is redirected to the malicious shellcode (often via `.text` section modification or DLL side-loading).

### Advanced static analysis
*   **Basic:** Viewing hexadecimal data.
*   **Intermediate:** Unpacking standard packers like UPX manually using Linux command-line tools.
*   **Advanced (Expert):** Defeating custom obfuscators and encryptors written by state-sponsored actors by statically analyzing the decryption loops.

### assembly language
*   **Basic:** Understanding basic x86 assembly (`PUSH`, `POP`, `MOV`, `JMP`).
*   **Intermediate:** Recognizing common structures like loops, function prologues/epilogues, and stack frames.
*   **Advanced (Expert):** Identifying compiler-specific optimizations. Rewriting assembly code directly in a hex editor to defang the malware or bypass its anti-analysis checks.

### decompiling & disassembling malware
*   **Basic:** Using standard decompilers to get pseudocode.
*   **Intermediate:** Loading the binary into Ghidra or IDA Pro to trace the execution flow and identify specific Windows API calls.
*   **Advanced (Expert):** Creating custom Python scripts for IDA Pro/Ghidra to automatically rename obfuscated functions, decrypt strings statically, and map out the entire control flow graph of an APT backdoor.

### Advanced dynamic analysis
*   **Basic:** Watching the malware run in a debugger.
*   **Intermediate:** Understanding memory mapping and thread creation during execution.
*   **Advanced (Expert):** Defeating Rootkits. Using kernel-level debuggers (like WinDbg) attached to a hypervisor to analyze malware that modifies the System Service Descriptor Table (SSDT) to hide itself from the OS.

### including debugging malware
*   **Basic:** Stepping through code line-by-line.
*   **Intermediate:** Using `x64dbg` to set breakpoints on APIs like `VirtualAlloc` (memory allocation) and `CreateProcess` to catch the malware before it executes its payload.
*   **Advanced (Expert):** Bypassing advanced anti-debugging techniques (like checking `IsDebuggerPresent` or leveraging SEH - Structured Exception Handling). Stepping through memory to extract raw AES/RSA keys used by ransomware before files are encrypted.

### Challenge - 2. practical
*   **Basic:** Analyzing a multi-stage dropper.
*   **Intermediate:** Extracting the embedded payload from the resource section of the primary executable.
*   **Advanced (Expert):** Fully reverse-engineering the custom C2 protocol used by the extracted payload, writing a custom Python script to emulate the C2 server, and tricking the malware into revealing its full capability set.

### Phishing malware analysis
*   **Basic:** Recognizing that an attachment is malicious.
*   **Intermediate:** Sandboxing the attachment and observing the dropped `.exe` file.
*   **Advanced (Expert):** Analyzing HTML Smuggling attacks where malicious JavaScript inside an HTML attachment dynamically constructs a ZIP file or ISO locally on the victim's machine to bypass network email gateways.

### Analyzing Excel docs and word codecs
*   **Basic:** Noting that a Word doc asks to "Enable Macros".
*   **Intermediate:** Using the OleTools suite (`olevba`) to safely extract the VBA macros without opening Microsoft Office.
*   **Advanced (Expert):** Analyzing malicious payloads embedded not in macros, but in remote template injections (loading external `.dotm` files) or exploiting Office equation editor vulnerabilities (CVE-2017-11882) which bypass macro restrictions entirely.

### Shellcode analysis.
*   **Basic:** Identifying a blob of hex data as shellcode.
*   **Intermediate:** Converting the hex to assembly to read the instructions.
*   **Advanced (Expert):** Dealing with position-independent shellcode that manually parses the PEB (Process Environment Block) to find `kernel32.dll` dynamically, bypassing ASLR (Address Space Layout Randomization).

### Analyzing & Carving shellcode using SCDBG
*   **Basic:** Extracting the raw shellcode bytes.
*   **Intermediate:** Using SCDBG (Shellcode Debugger) to emulate the execution of the shellcode. This safely reveals what APIs the shellcode is trying to resolve (`URLDownloadToFileA`) without detonating it.
*   **Advanced (Expert):** Using custom hooks in SCDBG to dump the memory regions after the shellcode decrypts its secondary payload, allowing for the extraction of deeply embedded final-stage RATs (Remote Access Trojans).

### Scripted malware delivery mechanisms
*   **Basic:** Identifying a script used to download malware.
*   **Intermediate:** Understanding the execution flow: Script -> WScript/CScript -> PowerShell -> Download -> Execute.
*   **Advanced (Expert):** Analyzing fileless delivery mechanisms where the script uses "Living off the Land" techniques (like `MSBuild.exe` or `Regsvr32.exe`) to compile and execute C# code dynamically in memory.

### Analyzing obfuscated PowerShell scripts
*   **Basic:** Identifying Base64 encoded PowerShell (`-enc`).
*   **Intermediate:** Using CyberChef to decode Base64, Hex, and URL encoding.
*   **Advanced (Expert):** Attackers use complex string manipulation (Tick marks `B\`y\`P\`a\`s\`s`), secure string conversions, and XOR encryption. Experts dynamically de-obfuscate by replacing execution commands (`Invoke-Expression`) with `Write-Output` to safely dump the next stage URL to the console.

### Analyzing a multi-staged obfuscated VBScript dropper malware
*   **Basic:** Identifying a `.vbs` file attached to an email.
*   **Intermediate:** Opening the script in a text editor and tracing the variable assignments.
*   **Advanced (Expert):** Analyzing VBScripts that utilize WMI (Windows Management Instrumentation) to execute commands invisibly. Debugging the script using `cscript.exe //x` to attach a Visual Studio debugger and step through the obfuscated loops in real-time.

### Final - Analyzing the boss malware: WannaCry.
*   **Basic:** Knowing WannaCry is ransomware that hit globally in 2017.
*   **Intermediate:** Understanding it used the EternalBlue (SMBv1) exploit to spread laterally without user interaction.
*   **Advanced (Expert):** Deep analysis involves reverse-engineering its worm component, analyzing the mutex creation (`MsWinZonesCacheCounterMutexA`) to prevent double-infection, identifying the hardcoded killswitch domain, and understanding its robust cryptographic implementation (asymmetric RSA used to encrypt symmetric AES keys).

---

## 4. Detection Engineering

### Overview of Detection Engineering
*   **Basic:** Creating simple IF/THEN rules in a SIEM.
*   **Intermediate:** Translating Threat Intelligence and MITRE ATT&CK techniques into Sigma rules, compiled into ELK or Splunk queries.
*   **Advanced (Expert):** Implementing "Detection as Code" (DaC). Treating SIEM rules like software engineering—using Git for version control, CI/CD pipelines to automatically test rules against sample logs, and pushing them to production.

### Elastic Stack (ELK) overview
*   **Basic:** Elasticsearch (storage), Logstash (parsing), Kibana (visualization).
*   **Intermediate:** Configuring Beats (Filebeat, Winlogbeat) to ship logs to Logstash.
*   **Advanced (Expert):** Designing index lifecycle management (ILM) policies, configuring Elasticsearch clusters for high availability, and writing complex Logstash Grok filters to parse proprietary, unstructured application logs.

### Zeek logging with Nmap scans
*   **Basic:** Nmap scan occurs, firewall blocks it.
*   **Intermediate:** Zeek parses the traffic into `conn.log`. Writing an ELK query looking for a single source IP connecting to > 50 distinct destination ports in under 10 seconds.
*   **Advanced (Expert):** Detecting slow, distributed scans leveraging thousands of proxies. Creating complex aggregate queries in ELK utilizing sliding windows and standard deviation to detect baseline deviations over 24 hours.

### Windows Elastic Agent logging using the EICAR file
*   **Basic:** Installing the Elastic Agent on a Windows machine.
*   **Intermediate:** Downloading EICAR to ensure the Agent successfully captures the Defender block event and ships it to Elasticsearch.
*   **Advanced (Expert):** Using the Elastic Agent's Fleet management to push dynamic policy updates (like modifying osquery schedules) to thousands of endpoints instantly based on changing threat landscapes.

### Sysmon configuration
*   **Basic:** Installing Sysmon with default settings.
*   **Intermediate:** Applying a community configuration (like SwiftOnSecurity) to filter out known good noise.
*   **Advanced (Expert):** Customizing the Sysmon XML to aggressively log specific API calls and network connections related to custom internal applications, and tuning it continuously to ensure CPU overhead remains < 1%.

### Testing Sysmon logging using the EICAR file
*   **Basic:** Dropping EICAR to see if Sysmon logs a file creation event (Event ID 11).
*   **Intermediate:** Ensuring the Sysmon event makes it all the way to the Kibana dashboard and triggers a test alert.
*   **Advanced (Expert):** Simulating actual adversary techniques (e.g., using Atomic Red Team) instead of EICAR, to ensure behavioral detections (like suspicious process injection) are effectively firing in the SIEM.

### Attack Scenario 1: Detection of web scanners such as Nikto and ZAP.
*   **performing the attack**
    *   *Basic:* Running Nikto from Kali Linux against a target IP.
    *   *Intermediate:* Using ZAP to perform an authenticated, deep spidering scan.
    *   *Advanced (Expert):* Evading standard WAFs by throttling the scan speed, randomizing User-Agents, and using rotating residential proxies.
*   **creating query alert**
    *   *Basic:* Alerting on the literal string `User-Agent: Nikto`.
    *   *Intermediate:* Building an ELK watcher that triggers when > 100 `HTTP 404` errors are generated by a single IP in 60 seconds.
    *   *Advanced (Expert):* Utilizing machine learning anomaly detection jobs in Elastic to identify statistically significant spikes in HTTP 400/403/404 response codes independent of static thresholds.
*   **confirming the alert**
    *   *Basic:* Seeing the alert in the Kibana dashboard.
    *   *Intermediate:* Verifying the source IP and the targeted URIs to confirm if it was a generic scan or targeted attack.
    *   *Advanced (Expert):* Automating the response: The alert triggers a webhook to a SOAR platform, which automatically blocks the IP at the AWS WAF level and closes the ticket.

### Attack Scenario 2: Detection of malware.
*   **Creating execution events**
    *   *Basic:* Double-clicking a malicious executable.
    *   *Intermediate:* Using an Office macro to spawn PowerShell, which downloads and executes the malware.
    *   *Advanced (Expert):* Executing the malware via a hijacked COM object to evade parent-child process detection rules.
*   **building alerts**
    *   *Basic:* Alerting on the hash of the malware.
    *   *Intermediate:* Alerting on `winword.exe` spawning `powershell.exe`.
    *   *Advanced (Expert):* Building EQL (Event Query Language) sequences in Elastic that look for a specific chain: Document opened -> Network connection made -> Executable dropped -> Executable run, all within a tight time window.
*   **confirming detections**
    *   *Basic:* Acknowledging the alert.
    *   *Intermediate:* Reviewing the process tree in the SIEM to confirm the malicious execution path.
    *   *Advanced (Expert):* Hunting for the same behavioral pattern across the entire enterprise to identify lateral movement or a wider campaign.

### Attack Scenario 3: Detection of a keylogger
*   **Creating execution events**
    *   *Basic:* Running a `.exe` keylogger.
    *   *Intermediate:* Running a Python-based keylogger that hooks the keyboard APIs.
    *   *Advanced (Expert):* Loading a malicious kernel-level filter driver that intercepts keystrokes before they reach the userland OS.
*   **developing detections**
    *   *Basic:* Detecting the known hash of the keylogger tool.
    *   *Intermediate:* Alerting on the `SetWindowsHookEx` API call (if logged by EDR).
    *   *Advanced (Expert):* Detecting processes writing continuously to a hidden file in `AppData` while the user is actively typing, or hunting for unsigned kernel drivers.
*   **confirming alerts**
    *   *Basic:* Finding the log file generated by the keylogger.
    *   *Intermediate:* Using Sysinternals `Autoruns` to find how the keylogger persists.
    *   *Advanced (Expert):* Performing live memory forensics (Volatility) to extract the hooked functions and the captured keystrokes currently residing in RAM.

---

## 5. Phishing Analysis

### Network Security : Wireless threats
*   **Wi-Fi deauthentication attacks and securing networks using WPA3**
    *   *Basic:* Attackers send spoofed frames to kick users off the Wi-Fi.
    *   *Intermediate:* Attackers use `aireplay-ng` to force disconnections to capture the WPA2 4-way handshake when the user reconnects.
    *   *Advanced (Expert):* Securing the network via WPA3, which introduces Protected Management Frames (PMF) to prevent deauth attacks, and SAE (Simultaneous Authentication of Equals) to prevent offline dictionary attacks on captured handshakes.
*   **Evil Twin attacks and detection of Man-in-the-Middle attacks**
    *   *Basic:* Attacker creates a fake Wi-Fi network with the same name as the real one.
    *   *Intermediate:* Used to capture handshakes or serve captive portal phishing pages to steal credentials.
    *   *Advanced (Expert):* Detection involves Wireless Intrusion Prevention Systems (WIPS) analyzing BSSID (MAC address) changes for known SSIDs, tracking anomalous OUI vendor codes, and monitoring for abnormal DHCP gateways.

### Phishing Analysis : Types of phishing attacks
*   **Basic:** Phishing (mass blast emails).
*   **Intermediate:** Spear Phishing (targeted against specific roles), Whaling (targeted at CEOs/CFOs), Vishing (Voice/Deepfakes).
*   **Advanced (Expert):** Business Email Compromise (BEC) and Vendor Email Compromise (VEC), where attackers compromise a trusted third-party vendor to send legitimate-looking invoices with altered payment details, bypassing all technical filters.

### Email analysis
*   **Basic:** Reading the email to see if it looks suspicious.
*   **Intermediate:** Looking for urgency, poor grammar, and spoofed branding.
*   **Advanced (Expert):** Analyzing the raw MIME structure of the email to uncover hidden tracking pixels and obfuscated HTML designed to evade secure email gateways.

### Email header and sender analysis
*   **Basic:** Checking the "From" address visually.
*   **Intermediate:** Analyzing the `Return-Path`, `Reply-To`, and tracing the `Received` headers from bottom to top to identify the true originating IP address.
*   **Advanced (Expert):** Analyzing the `X-Originating-IP` and tracking malicious infrastructure across ASNs (Autonomous System Numbers). Correlating headers with Threat Intel to identify specific APT campaign actors.

### Email authentication methods
*   **Basic:** Using protocols to stop spoofing.
*   **Intermediate:** 
    *   **SPF:** Verifies the sending IP is authorized.
    *   **DKIM:** Cryptographically signs the email to prove it hasn't been altered.
    *   **DMARC:** Ties SPF and DKIM together.
*   **Advanced (Expert):** Analyzing DMARC XML failure reports. Investigating DKIM signature replay attacks where attackers forward legitimately signed emails containing malicious content to bypass filters.

### Email content analysis
*   **Basic:** Reading the text for scams.
*   **Intermediate:** Checking for malicious links and attachments.
*   **Advanced (Expert):** De-obfuscating Zero-Font attacks (where hidden, tiny text is inserted to break up keyword matching rules in spam filters) and analyzing embedded QR codes (Quishing) designed to move the attack to the user's unmanaged mobile device.

### Understanding the anatomy of a URL
*   **Basic:** Knowing the difference between the domain and the path.
*   **Intermediate:** Identifying subdomains used to spoof real domains (e.g., `paypal.com.secure-login.net`).
*   **Advanced (Expert):** Identifying Punycode/Homograph attacks (e.g., utilizing Cyrillic characters that look exactly like Latin characters).

### Email URL analysis
*   **Basic:** Hovering over a link to see where it goes.
*   **Intermediate:** Un-shortening `bit.ly` links safely in a sandbox.
*   **Advanced (Expert):** Exploiting "Open Redirect" vulnerabilities in legitimate domains to bypass security filters (e.g., `https://trusted-site.com/login?redirectUrl=http://evil.com`). Analyzing dynamic redirects that only deliver payloads based on the victim's User-Agent or IP geolocation.

### Email attachment analysis
*   **Basic:** Checking the extension (blocking `.exe`).
*   **Intermediate:** Extracting hashes, checking VirusTotal. Watching for double extensions (`invoice.pdf.exe`).
*   **Advanced (Expert):** Analyzing deeply embedded OLE objects in RTF documents. Safely extracting heavily obfuscated malicious Javascript from HTML attachments (HTML Smuggling) designed to build malware locally.

### Automated email analysis using phishing tools
*   **Basic:** Using a free online tool to analyze headers.
*   **Intermediate:** Utilizing platforms like PhishTool to automate header parsing and IOC extraction.
*   **Advanced (Expert):** Configuring SOAR playbooks (e.g., Cortex XSOAR) to automatically rip IOCs from user-reported phishing emails, detonate attachments in a sandbox, query threat intel, and auto-purge matching emails from all user inboxes enterprise-wide within seconds.

### IP reputation checks
*   **Basic:** Searching an IP on Google.
*   **Intermediate:** Querying VirusTotal, AbuseIPDB, or Cisco Talos to see if the IP is known for spam or malware.
*   **Advanced (Expert):** Proactively analyzing newly registered domains (NRDs). Utilizing tools like `Censys` or `Shodan` to pivot off the malicious IP, discovering the attacker's broader C2 infrastructure based on specific open ports or SSL certificate JARM signatures.

---

## 6. Top 5 MITRE ATT&CK Use Cases

| Use Case | Description | MITRE Tactics | MITRE Techniques |
| :--- | :--- | :--- | :--- |
| **1: Ransomware Deployment via Phishing** | An attacker gains initial access via a malicious email attachment, escalates privileges, disables backups, and encrypts the host. | Initial Access (TA0001)<br>Execution (TA0002)<br>Defense Evasion (TA0005)<br>Impact (TA0040) | Phishing: Spearphishing Attachment (T1566.001)<br>Command and Scripting Interpreter: PowerShell (T1059.001)<br>Impair Defenses (T1562.001)<br>Inhibit System Recovery (T1490)<br>Data Encrypted for Impact (T1486) |
| **2: Credential Dumping and Lateral Movement via SMB** | An attacker compromises a single endpoint, dumps credentials from memory, and moves laterally to the Domain Controller using stolen admin hashes. | Credential Access (TA0006)<br>Lateral Movement (TA0008) | OS Credential Dumping: LSASS Memory (T1003.001)<br>Remote Services: SMB/Windows Admin Shares (T1021.002)<br>Use Alternate Authentication Material: Pass the Hash (T1550.002) |
| **3: Data Exfiltration via DNS Tunneling** | A compromised host inside a highly restricted network segment bypasses firewall egress rules by encoding stolen data into DNS queries. | Command and Control (TA0011)<br>Exfiltration (TA0010) | Application Layer Protocol: DNS (T1071.004)<br>Exfiltration Over Alternative Protocol (T1048) |
| **4: Persistence via Scheduled Tasks** | To survive a reboot, an attacker establishes persistence by creating a scheduled task that executes a malicious payload every time the user logs in. | Persistence (TA0003)<br>Privilege Escalation (TA0004) | Scheduled Task/Job (T1053.005)<br>Hide Artifacts: Hidden Window (T1564.003) |
| **5: Fileless Malware / Memory Injection** | An attacker uses a "Living off the Land" binary (LOLBin) to download a payload and inject it directly into the memory of a legitimate process. | Defense Evasion (TA0005)<br>Execution (TA0002) | Process Injection: Process Hollowing (T1055.012)<br>Signed Binary Proxy Execution: Regsvr32 (T1218.010) |

---

## 7. Incident Response Workflows (Alert to Deep Investigation)

### Workflow 1: High-Severity Ransomware Alert (EDR)
1.  **Alert Triage:** EDR fires a critical alert for "Known Ransomware Extension Dropped" or "Mass File Modification."
2.  **Initial Investigation:** Verify the host. Check EDR telemetry for the parent process (e.g., did `winword.exe` spawn `cmd.exe` -> `vssadmin.exe delete shadows`?).
3.  **Containment:** Immediately utilize the EDR "Network Isolate" feature to cut the host off from the domain, while leaving the EDR channel open for forensics.
4.  **Deep Forensic Investigation:** Pull the MFT (Master File Table) to see exactly which files were encrypted. Dump RAM (Volatility) to attempt to extract the symmetric encryption keys from memory before the system reboots. 
5.  **Eradication & Recovery:** Reimage the machine from a known good baseline. Force a password reset for the compromised user.

### Workflow 2: Impossible Travel / Account Takeover (IdP/Azure AD)
1.  **Alert Triage:** SIEM flags a successful login from Nigeria followed by a successful login from New York within 10 minutes for the same user.
2.  **Initial Investigation:** Check the IP reputations. Was the NY IP a known corporate VPN? Did the Nigerian IP successfully pass MFA, or was MFA bypassed/fatigued?
3.  **Containment:** Disable the user account in Active Directory/Azure AD. Revoke all active session tokens immediately.
4.  **Deep Forensic Investigation:** Query Office 365 / Azure AD audit logs. Did the attacker create any new Inbox Forwarding Rules (e.g., forwarding all emails containing "invoice" to an external address)? Did they register a new MFA device?
5.  **Eradication & Recovery:** Remove malicious inbox rules. Require the user to re-register MFA from a trusted corporate device and change their password.

### Workflow 3: Malicious PowerShell / Living off the Land (SIEM)
1.  **Alert Triage:** Alert triggers for `powershell.exe -enc <base64 string>`.
2.  **Initial Investigation:** Decode the Base64 string using CyberChef. Identify what the script was trying to do (e.g., downloading a payload from an external URL).
3.  **Containment:** Block the identified external URL/IP at the perimeter firewall to prevent further downloads. Isolate the endpoint via EDR.
4.  **Deep Forensic Investigation:** Check Sysmon Event ID 4104 (Script Block Logging) to see if the script executed secondary payloads not captured in the initial command line. Review Event ID 3 (Network Connect) to see if the C2 connection succeeded.
5.  **Eradication & Recovery:** Run an enterprise-wide IOC sweep for the downloaded payload hash. Reimage the affected host and hunt for lateral movement.

### Workflow 4: Massive Outbound Data Transfer (DLP/Firewall)
1.  **Alert Triage:** Firewall/NetFlow alerts on a host transferring 50GB of data over HTTPS to an uncategorized cloud storage IP address at 3:00 AM.
2.  **Initial Investigation:** Identify the user and the host. Is this a database admin doing a legitimate backup, or an unauthorized transfer from an executive's laptop?
3.  **Containment:** Block the destination IP at the firewall immediately to halt the ongoing exfiltration.
4.  **Deep Forensic Investigation:** Check EDR telemetry on the endpoint to identify *which* process initiated the connection (e.g., was it `chrome.exe` or `rclone.exe`?). Analyze file access logs to determine exactly which directories were staged and compressed prior to exfiltration.
5.  **Eradication & Recovery:** Initiate legal/compliance review based on the data classified as exfiltrated (PII/PCI). Conduct a full compromise assessment on the host to determine how the attacker initially gained access.

### Workflow 5: Phishing Campaign Leading to Malware Dropper (Email Gateway)
1.  **Alert Triage:** Multiple users report a suspicious email claiming to be "HR - Salary Updates.xlsx".
2.  **Initial Investigation:** Pull the email from the gateway. Sandbox the `.xlsx` attachment to observe its behavior. Identify the dropped executable and the C2 IP address.
3.  **Containment:** Use SOAR or Exchange Admin to perform a "Search and Destroy" (Soft Delete) of the malicious email across all enterprise inboxes.
4.  **Deep Forensic Investigation:** Query the SIEM for the C2 IP and the dropper hash to see if any users actually clicked and executed the payload before the email was purged. Check proxy logs for successful outbound connections to the C2.
5.  **Eradication & Recovery:** For users who clicked: Isolate their machines, rotate their credentials, and reimage. Send a company-wide security awareness notification regarding the specific lure.

---

## 8. Active Directory (AD) Attacks & Interview Quick Prep

### NTLM Relay Attacks
*   **Concept:** Attacker intercepts an NTLM authentication request (often via LLMNR/NBT-NS spoofing using tools like Responder) and relays it to another server to gain access or execute code.
*   **Detection:** Event ID 4624 (Logon) where the source IP is the attacker's machine but the authentication was intended for another machine.
*   **Interview Prep:** Be able to clearly explain the difference between Pass-the-Hash (requires obtaining the hash from memory/disk) and NTLM Relay (relaying a live authentication session over the network without ever knowing the hash). Mitigation: Enforce SMB Signing and disable LLMNR/NBT-NS.

### Pass-the-Hash (PtH)
*   **Concept:** Extracting an NTLM hash from memory (e.g., via Mimikatz from LSASS) and using it to authenticate and move laterally without knowing the plaintext password.
*   **Detection:** Event ID 4624 Logon Type 9 (NewCredentials) combined with abnormal processes (like `cmd.exe` or `powershell.exe`) initiating the logon.
*   **Interview Prep:** Emphasize that restricting Tier 0/Tier 1 administrator accounts from logging into Tier 2 workstations is the primary defense. Mention Microsoft LAPS (Local Administrator Password Solution) to prevent lateral movement using local admin hashes.

### Kerberoasting
*   **Concept:** Any valid domain user can request a Kerberos Service Ticket (TGS) for a Service Principal Name (SPN). The attacker requests the ticket, extracts it from memory, and cracks the hash offline to get the service account's plaintext password.
*   **Detection:** Event ID 4769 (A Kerberos service ticket was requested) with a weak encryption type (e.g., `0x17` RC4) requested by a normal user account for high-privileged SPNs.
*   **Interview Prep:** Distinguish this from **AS-REP Roasting** (which targets user accounts that do not have Kerberos pre-authentication enabled). Mitigation for Kerberoasting involves using complex, 25+ character passwords for all Service Accounts.

### Golden Ticket (Forged TGT)
*   **Concept:** Forging a valid Ticket Granting Ticket (TGT) after stealing the `krbtgt` account hash from the Domain Controller. This grants the attacker persistent, unhindered domain admin access even if they lose their initial foothold.
*   **Detection:** Extremely difficult. Look for Event ID 4769 where the account domain does not match the actual domain, or tickets with a lifespan greater than the default 10 hours.
*   **Interview Prep:** If an interviewer asks how to recover from a Golden Ticket, the *only* correct answer is to reset the `krbtgt` password **twice** (to invalidate the current password and the N-1 history password, rendering old forged tickets useless).

### Silver Ticket (Forged TGS)
*   **Concept:** Forging a Service Ticket (TGS) for a specific service on a specific host by stealing that computer/service account's hash.
*   **Detection:** Harder than Golden Tickets because there is no communication with the Domain Controller (the TGT step is skipped). Look for Event ID 4624 on the target server with anomalous logon times or missing TGT requests prior to the TGS presentation.
*   **Interview Prep:** Explain that a Golden Ticket gives you access to the whole domain, while a Silver Ticket only gives you access to the specific service you forged the ticket for.

### DCSync Attack
*   **Concept:** Impersonating a Domain Controller to request password hashes via the Directory Replication Service (DRS) protocol using the `GetNCChanges` request.
*   **Detection:** Event ID 4662 (An operation was performed on an object) filtering for the properties `DS-Replication-Get-Changes-All` originating from an IP that is not a known Domain Controller.
*   **Interview Prep:** Emphasize that DCSync does not require code execution on a Domain Controller; it just requires a user with high privileges (Domain Admin or specific replication ACLs) to ask the DC for data legitimately.
