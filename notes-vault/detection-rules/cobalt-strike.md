---
title: "Detecting Cobalt Strike Beacons"
category: "Detection Rules"
tags: ["Cobalt Strike", "SIEM", "Windows", "EDR"]
lastUpdated: "2026-06-03"
---

Cobalt Strike is a popular threat emulation tool widely abused by malicious threat actors to maintain persistence and command-and-control (C2) channels. This detection rule aims to identify default Cobalt Strike beaconing patterns in network traffic.

### Threat Details
Cobalt Strike beacons typically use HTTP/S GET requests to check for commands and POST requests to upload results. Standard configurations often have a recognizable jitter and sleep time.

### Yara Rule for Memory Detection
```yara
rule CobaltStrike_Beacon_Memory {
    meta:
        description = "Detects default Cobalt Strike beacons in memory"
        author = "Velsec Security"
    strings:
        $beacon_loader = { 55 8B EC 83 C4 ?? 53 56 57 8B 7D 08 8B 75 0C }
        $user_agent = "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)"
    condition:
        $beacon_loader or $user_agent
}
```

### Mitigation Recommendations
1. Block known default C2 domains at the DNS/Proxy level.
2. Monitor host process injections targeting legitimate binaries like `svchost.exe` or `explorer.exe`.
