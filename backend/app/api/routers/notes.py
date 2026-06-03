from fastapi import APIRouter, Depends, HTTPException, Header, status
from typing import List, Optional
from pydantic import BaseModel
import os
import logging
from app.api.deps import get_current_user, TokenData
from app.core.config import settings
from app.core.cache import cache_service
import json

logger = logging.getLogger(__name__)

router = APIRouter()

class NoteSchema(BaseModel):
    id: str
    title: str
    category: str
    tags: List[str]
    content: str
    last_updated: str

# Local mock data fallback
MOCK_NOTES = [
    {
        "id": "cobalt-strike",
        "title": "Detecting Cobalt Strike Beacons",
        "category": "Detection Rules",
        "tags": ["Cobalt Strike", "SIEM", "Windows", "EDR"],
        "content": "Cobalt Strike is a popular threat emulation tool widely abused by malicious threat actors to maintain persistence and command-and-control (C2) channels. This detection rule aims to identify default Cobalt Strike beaconing patterns in network traffic.\n\n### Threat Details\nCobalt Strike beacons typically use HTTP/S GET requests to check for commands and POST requests to upload results. Standard configurations often have a recognizable jitter and sleep time.\n\n### Yara Rule for Memory Detection\n```yara\nrule CobaltStrike_Beacon_Memory {\n    meta:\n        description = \"Detects default Cobalt Strike beacons in memory\"\n        author = \"Velsec Security\"\n    strings:\n        $beacon_loader = { 55 8B EC 83 C4 ?? 53 56 57 8B 7D 08 8B 75 0C }\n        $user_agent = \"Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)\"\n    condition:\n        $beacon_loader or $user_agent\n}\n```\n\n### Mitigation Recommendations\n1. Block known default C2 domains at the DNS/Proxy level.\n2. Monitor host process injections targeting legitimate binaries like `svchost.exe` or `explorer.exe`.",
        "last_updated": "2026-06-03"
    },
    {
        "id": "nmap-cheatsheet",
        "title": "Nmap Penetration Testing Cheat Sheet",
        "category": "Cheat Sheets",
        "tags": ["Recon", "Nmap", "Scanning", "Network"],
        "content": "Nmap (\"Network Mapper\") is a free and open-source utility for network discovery and vulnerability auditing. This cheat sheet captures primary scanning switch commands for quick retrieval during engagements.\n\n### Critical Scan Commands\n\n#### Stealth / SYN Scan\nStandard stealth scanning option that doesn't trigger full TCP connections.\n```bash\nnmap -sS -T4 <target-ip>\n```\n\n#### Service Version Detection\nQueries target ports to determine service protocols, applications, and versions.\n```bash\nnmap -sV -p- <target-ip>\n```\n\n#### OS and Script Scanning\nEnables OS detection, version detection, script scanning, and traceroute.\n```bash\nnmap -A -v <target-ip>\n```\n\n#### Vuln Assessment Scripts\nRuns standard Nmap Scripting Engine (NSE) scripts focused on vulnerability discovery.\n```bash\nnmap --script vuln -p 80,443 <target-ip>\n```",
        "last_updated": "2026-06-03"
    },
    {
        "id": "sql-injection",
        "title": "SIEM Rules: SQL Injection Detection",
        "category": "SIEM Queries",
        "tags": ["SQL Injection", "WAF", "SIEM", "KQL"],
        "content": "SQL Injection (SQLi) is a code injection technique used to attack data-driven applications by inserting malicious SQL statements into entry fields. This note documents SIEM detection rules for tracing SQLi attempts in web access logs.\n\n### KQL Query (Microsoft Sentinel)\nUse the following Kusto Query Language (KQL) rule to detect typical SQL injection query signatures (like `' OR 1=1`) inside Web Application Firewall (WAF) requests:\n\n```kql\nAzureDiagnostics\n| where ResourceProvider == \"MICROSOFT.NETWORK\" and Category == \"ApplicationGatewayFirewallLog\"\n| where Message has \"SQL Injection\" or details_message_s has \"SQL Injection\"\n| extend clientIP = clientIp_s, requestUri = requestUri_s\n| summarize count() by clientIP, requestUri, bin(TimeGenerated, 5m)\n| filter count_ > 5\n```\n\n### Splunk Search Query\n```splunk\nindex=security sourcetype=access_combined (select OR union OR \"1=1\" OR \"1'1\")\n| stats count by clientip, uri\n| where count > 10\n```",
        "last_updated": "2026-06-03"
    },
    {
        "id": "active-directory",
        "title": "Active Directory Compromise Incident Response Runbook",
        "category": "Runbooks",
        "tags": ["AD", "IR", "Windows", "Incident Response"],
        "content": "This runbook guides responders through containment, eradication, and recovery steps after identifying an Active Directory (AD) domain compromise (e.g., Golden Ticket exploitation, Domain Controller access).\n\n### 1. Containment Phase\n* **Isolate Domain Controllers (DCs):** Immediately isolate compromised DCs at the network virtualization layer if possible. Avoid rebooting to preserve RAM artifact memory.\n* **Revoke KRBTGT Kerberos Key:** Perform the double-reset protocol for the `krbtgt` password to invalidate all existing Kerberos tickets.\n* **Block Internet Access:** Sever external routing paths from Domain Controllers.\n\n### 2. Eradication Phase\n* **Reset Privileged Credentials:** Reset passwords for all Domain Administrators, Enterprise Administrators, and service accounts.\n* **Audit Group Memberships:** Query `Domain Admins` and nested groups for unauthorized additions.\n\n### 3. Recovery Phase\n* Rebuild affected DCs from clean, known-secure backups or clean operating system installs.\n* Monitor directory change replication logs for replication errors.",
        "last_updated": "2026-06-03"
    },
    {
        "id": "t1003-lsass",
        "title": "T1003.001 - OS Credential Dumping: LSASS Memory",
        "category": "MITRE ATT&CK",
        "tags": ["MITRE", "T1003", "Credentials", "Windows"],
        "content": "Adversaries may attempt to access credential material, passwords, or hashes from the Local Security Authority Subsystem Service (LSASS) process memory. Dumping LSASS memory is a common technique (T1003.001) used to gather cleartext credentials or NTLM hashes.\n\n### Exploit Mechanics\nTools like Mimikatz or built-in utilities like `rundll32.exe` with `comsvcs.dll` can dump the LSASS process space:\n\n```powershell\nrundll32.exe C:\\windows\\System32\\comsvcs.dll, MiniDump <lsass-pid> C:\\windows\\temp\\lsass.dmp full\n```\n\n### Detection Strategy\n* **Process Creation Audit:** Alert on process command lines executing `comsvcs.dll` alongside `MiniDump`.\n* **Access Request Tracing:** Monitor handles requested to LSASS process (`ProcessAccess` mask `0x1010` or `0x1410` inside Sysmon Event ID 10 logs).\n* **Credential Guard:** Ensure Windows Credential Guard is active to isolate LSASS inside virtualized containers.",
        "last_updated": "2026-06-03"
    }
]

# Initialize Supabase client if possible
supabase = None
try:
    if (settings.SUPABASE_URL and settings.SUPABASE_KEY and
        "your-project" not in settings.SUPABASE_URL and
        "placeholder" not in settings.SUPABASE_URL):
        from supabase import create_client
        supabase = create_client(settings.SUPABASE_URL, settings.SUPABASE_KEY)
except Exception as e:
    logger.warning(f"Could not connect to Supabase: {e}. Falling back to in-memory local state.")

@router.get("/", response_model=List[NoteSchema])
async def get_notes(
    category: Optional[str] = None,
    search: Optional[str] = None,
    current_user: TokenData = Depends(get_current_user)
):
    """Retrieve pentest and SecOps notes, supporting search and filters."""
    cache_key = f"notes:cat:{category or 'all'}:q:{search or ''}"
    if cache_service.redis_client:
        try:
            cached_data = await cache_service.redis_client.get(cache_key)
            if cached_data:
                notes_data = json.loads(cached_data)
                return [NoteSchema(**n) for n in notes_data]
        except Exception as e:
            logger.warning(f"Cache read error: {e}")

    notes_list = None
    if supabase:
        try:
            query_builder = supabase.table("notes").select("*")
            if category and category.lower() != 'all':
                query_builder = query_builder.eq("category", category)
            if search:
                query_builder = query_builder.text_search("fts", search)
            
            res = query_builder.execute()
            notes_list = []
            for item in res.data:
                notes_list.append(NoteSchema(
                    id=item.get("id"),
                    title=item.get("title"),
                    category=item.get("category"),
                    tags=item.get("tags", []),
                    content=item.get("content"),
                    last_updated=item.get("last_updated") or item.get("lastUpdated") or "2026-06-03"
                ))
        except Exception as e:
            logger.error(f"Supabase query error: {e}. Falling back to mock notes.")
    
    if notes_list is None:
        # Fallback to mock notes
        filtered_notes = MOCK_NOTES
        if category and category.lower() != 'all':
            filtered_notes = [n for n in filtered_notes if n["category"].lower() == category.lower()]
        if search:
            search_lower = search.lower()
            filtered_notes = [
                n for n in filtered_notes 
                if search_lower in n["title"].lower() or search_lower in n["content"].lower()
            ]
        notes_list = [NoteSchema(**n) for n in filtered_notes]

    if cache_service.redis_client:
        try:
            notes_dicts = [n.model_dump() for n in notes_list]
            await cache_service.redis_client.set(cache_key, json.dumps(notes_dicts), ex=300)
        except Exception as e:
            logger.warning(f"Cache write error: {e}")

    return notes_list

@router.post("/sync")
async def sync_notes(
    notes: List[NoteSchema],
    x_sync_key: Optional[str] = Header(None, alias="X-Sync-Key")
):
    """Sync notes from GitHub/Obsidian vault into the database."""
    expected_key = settings.SYNC_API_KEY
    if expected_key == "default-sync-key" and not os.environ.get("PYTEST_CURRENT_TEST"):
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="SYNC_API_KEY is configured with an insecure fallback key in production."
        )

    if not x_sync_key or x_sync_key != expected_key:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid or missing sync authorization key."
        )

    # Clear notes cache
    if cache_service.redis_client:
        try:
            keys = await cache_service.redis_client.keys("notes:cat:*")
            if keys:
                await cache_service.redis_client.delete(*keys)
        except Exception as e:
            logger.warning(f"Cache clear error: {e}")

    if supabase:
        try:
            records = []
            for n in notes:
                records.append({
                    "id": n.id,
                    "title": n.title,
                    "category": n.category,
                    "tags": n.tags,
                    "content": n.content,
                    "last_updated": n.last_updated
                })
            
            res = supabase.table("notes").upsert(records, on_conflict="id").execute()
            return {"status": "success", "count": len(res.data)}
        except Exception as e:
            logger.error(f"Failed to upsert notes into Supabase: {e}")
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail=f"Database synchronization failed: {str(e)}"
            )

    # In-memory fallback
    global MOCK_NOTES
    updated_count = 0
    for new_note in notes:
        existing_idx = next((i for i, n in enumerate(MOCK_NOTES) if n["id"] == new_note.id), None)
        note_dict = new_note.model_dump()
        if existing_idx is not None:
            MOCK_NOTES[existing_idx] = note_dict
        else:
            MOCK_NOTES.append(note_dict)
        updated_count += 1

    return {
        "status": "fallback_success",
        "message": "Saved to local in-memory store (Supabase is not configured).",
        "count": updated_count
    }
