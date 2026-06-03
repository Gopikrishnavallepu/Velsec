---
title: "Active Directory Compromise Incident Response Runbook"
category: "Runbooks"
tags: ["AD", "IR", "Windows", "Incident Response"]
lastUpdated: "2026-06-03"
---

This runbook guides responders through containment, eradication, and recovery steps after identifying an Active Directory (AD) domain compromise (e.g., Golden Ticket exploitation, Domain Controller access).

### 1. Containment Phase
* **Isolate Domain Controllers (DCs):** Immediately isolate compromised DCs at the network virtualization layer if possible. Avoid rebooting to preserve RAM artifact memory.
* **Revoke KRBTGT Kerberos Key:** Perform the double-reset protocol for the `krbtgt` password to invalidate all existing Kerberos tickets.
* **Block Internet Access:** Sever external routing paths from Domain Controllers.

### 2. Eradication Phase
* **Reset Privileged Credentials:** Reset passwords for all Domain Administrators, Enterprise Administrators, and service accounts.
* **Audit Group Memberships:** Query `Domain Admins` and nested groups for unauthorized additions.

### 3. Recovery Phase
* Rebuild affected DCs from clean, known-secure backups or clean operating system installs.
* Monitor directory change replication logs for replication errors.
