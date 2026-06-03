---
title: "T1003.001 - OS Credential Dumping: LSASS Memory"
category: "MITRE ATT&CK"
tags: ["MITRE", "T1003", "Credentials", "Windows"]
lastUpdated: "2026-06-03"
---

Adversaries may attempt to access credential material, passwords, or hashes from the Local Security Authority Subsystem Service (LSASS) process memory. Dumping LSASS memory is a common technique (T1003.001) used to gather cleartext credentials or NTLM hashes.

### Exploit Mechanics
Tools like Mimikatz or built-in utilities like `rundll32.exe` with `comsvcs.dll` can dump the LSASS process space:

```powershell
rundll32.exe C:\windows\System32\comsvcs.dll, MiniDump <lsass-pid> C:\windows\temp\lsass.dmp full
```

### Detection Strategy
* **Process Creation Audit:** Alert on process command lines executing `comsvcs.dll` alongside `MiniDump`.
* **Access Request Tracing:** Monitor handles requested to LSASS process (`ProcessAccess` mask `0x1010` or `0x1410` inside Sysmon Event ID 10 logs).
* **Credential Guard:** Ensure Windows Credential Guard is active to isolate LSASS inside virtualized containers.
