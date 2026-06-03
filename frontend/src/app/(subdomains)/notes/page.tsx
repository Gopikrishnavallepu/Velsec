'use client';

import { useState, useEffect, useCallback } from 'react';
import { createClient } from '@/utils/supabase/client';
import ParticleField from '@/components/ui/ParticleField';
import ReactMarkdown from 'react-markdown';

interface Note {
  id: string;
  title: string;
  category: string;
  tags: string[];
  last_updated: string;
  content: string;
}

const categories = [
  'ALL',
  'SIEM Queries',
  'Detection Rules',
  'MITRE ATT&CK',
  'Cheat Sheets',
  'Runbooks'
];

export default function NotesPage() {
  const supabase = createClient();
  const [notes, setNotes] = useState<Note[]>([]);
  const [selectedNote, setSelectedNote] = useState<Note | null>(null);
  const [searchQuery, setSearchQuery] = useState<string>('');
  const [activeCategory, setActiveCategory] = useState<string>('ALL');
  const [loading, setLoading] = useState<boolean>(true);
  const [errorMsg, setErrorMsg] = useState<string | null>(null);
  const [isAuthenticated, setIsAuthenticated] = useState<boolean>(true);

  // Fetch notes from FastAPI backend
  const fetchNotes = useCallback(async (category: string, search: string) => {
    setLoading(true);
    setErrorMsg(null);
    try {
      const { data: { session } } = await supabase.auth.getSession();
      const token = session?.access_token;

      if (!token) {
        setIsAuthenticated(false);
        setLoading(false);
        return;
      }

      setIsAuthenticated(true);
      const apiBase = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8000';
      const categoryParam = category !== 'ALL' ? encodeURIComponent(category) : 'all';
      const searchParam = search ? encodeURIComponent(search) : '';
      
      const res = await fetch(
        `${apiBase}/api/v1/notes/?category=${categoryParam}&search=${searchParam}`,
        {
          headers: {
            'Authorization': `Bearer ${token}`
          }
        }
      );

      if (res.status === 401) {
        setIsAuthenticated(false);
        setLoading(false);
        return;
      }

      if (!res.ok) {
        throw new Error(`API returned status code ${res.status}`);
      }

      const data = await res.json();
      setNotes(data);
      if (data.length > 0) {
        // Keep selected note if it still exists in the list, otherwise select first
        setSelectedNote((prev) => {
          if (prev && data.some((n: Note) => n.id === prev.id)) {
            return data.find((n: Note) => n.id === prev.id);
          }
          return data[0];
        });
      } else {
        setSelectedNote(null);
      }
    } catch (err: any) { // eslint-disable-line @typescript-eslint/no-explicit-any
      console.warn(`Backend connection failed: ${err.message}. Loading mock fallback notes.`);
      setErrorMsg('API offline. Decrypting offline cached records...');
      
      // Fallback local filtering logic
      const fallbackNotes = [
        {
          id: "cobalt-strike",
          title: "Detecting Cobalt Strike Beacons",
          category: "Detection Rules",
          tags: ["Cobalt Strike", "SIEM", "Windows", "EDR"],
          content: "Cobalt Strike is a popular threat emulation tool widely abused by malicious threat actors to maintain persistence and command-and-control (C2) channels. This detection rule aims to identify default Cobalt Strike beaconing patterns in network traffic.\n\n### Threat Details\nCobalt Strike beacons typically use HTTP/S GET requests to check for commands and POST requests to upload results. Standard configurations often have a recognizable jitter and sleep time.\n\n### Yara Rule for Memory Detection\n```yara\nrule CobaltStrike_Beacon_Memory {\n    meta:\n        description = \"Detects default Cobalt Strike beacons in memory\"\n        author = \"Velsec Security\"\n    strings:\n        $beacon_loader = { 55 8B EC 83 C4 ?? 53 56 57 8B 7D 08 8B 75 0C }\n        $user_agent = \"Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)\"\n    condition:\n        $beacon_loader or $user_agent\n}\n```\n\n### Mitigation Recommendations\n1. Block known default C2 domains at the DNS/Proxy level.\n2. Monitor host process injections targeting legitimate binaries like `svchost.exe` or `explorer.exe`.",
          last_updated: "2026-06-03"
        },
        {
          id: "nmap-cheatsheet",
          title: "Nmap Penetration Testing Cheat Sheet",
          category: "Cheat Sheets",
          tags: ["Recon", "Nmap", "Scanning", "Network"],
          content: "Nmap (\"Network Mapper\") is a free and open-source utility for network discovery and vulnerability auditing. This cheat sheet captures primary scanning switch commands for quick retrieval during engagements.\n\n### Critical Scan Commands\n\n#### Stealth / SYN Scan\nStandard stealth scanning option that doesn't trigger full TCP connections.\n```bash\nnmap -sS -T4 <target-ip>\n```\n\n#### Service Version Detection\nQueries target ports to determine service protocols, applications, and versions.\n```bash\nnmap -sV -p- <target-ip>\n```\n\n#### OS and Script Scanning\nEnables OS detection, version detection, script scanning, and traceroute.\n```bash\nnmap -A -v <target-ip>\n```\n\n#### Vuln Assessment Scripts\nRuns standard Nmap Scripting Engine (NSE) scripts focused on vulnerability discovery.\n```bash\nnmap --script vuln -p 80,443 <target-ip>\n```",
          last_updated: "2026-06-03"
        },
        {
          id: "sql-injection",
          title: "SIEM Rules: SQL Injection Detection",
          category: "SIEM Queries",
          tags: ["SQL Injection", "WAF", "SIEM", "KQL"],
          content: "SQL Injection (SQLi) is a code injection technique used to attack data-driven applications by inserting malicious SQL statements into entry fields. This note documents SIEM detection rules for tracing SQLi attempts in web access logs.\n\n### KQL Query (Microsoft Sentinel)\nUse the following Kusto Query Language (KQL) rule to detect typical SQL injection query signatures (like `' OR 1=1`) inside Web Application Firewall (WAF) requests:\n\n```kql\nAzureDiagnostics\n| where ResourceProvider == \"MICROSOFT.NETWORK\" and Category == \"ApplicationGatewayFirewallLog\"\n| where Message has \"SQL Injection\" or details_message_s has \"SQL Injection\"\n| extend clientIP = clientIp_s, requestUri = requestUri_s\n| summarize count() by clientIP, requestUri, bin(TimeGenerated, 5m)\n| filter count_ > 5\n```\n\n### Splunk Search Query\n```splunk\nindex=security sourcetype=access_combined (select OR union OR \"1=1\" OR \"1'1\")\n| stats count by clientip, uri\n| where count > 10\n```",
          last_updated: "2026-06-03"
        },
        {
          id: "active-directory",
          title: "Active Directory Compromise Incident Response Runbook",
          category: "Runbooks",
          tags: ["AD", "IR", "Windows", "Incident Response"],
          content: "This runbook guides responders through containment, eradication, and recovery steps after identifying an Active Directory (AD) domain compromise (e.g., Golden Ticket exploitation, Domain Controller access).\n\n### 1. Containment Phase\n* **Isolate Domain Controllers (DCs):** Immediately isolate compromised DCs at the network virtualization layer if possible. Avoid rebooting to preserve RAM artifact memory.\n* **Revoke KRBTGT Kerberos Key:** Perform the double-reset protocol for the `krbtgt` password to invalidate all existing Kerberos tickets.\n* **Block Internet Access:** Sever external routing paths from Domain Controllers.\n\n### 2. Eradication Phase\n* **Reset Privileged Credentials:** Reset passwords for all Domain Administrators, Enterprise Administrators, and service accounts.\n* **Audit Group Memberships:** Query `Domain Admins` and nested groups for unauthorized additions.\n\n### 3. Recovery Phase\n* Rebuild affected DCs from clean, known-secure backups or clean operating system installs.\n* Monitor directory change replication logs for replication errors.",
          last_updated: "2026-06-03"
        },
        {
          id: "t1003-lsass",
          title: "T1003.001 - OS Credential Dumping: LSASS Memory",
          category: "MITRE ATT&CK",
          tags: ["MITRE", "T1003", "Credentials", "Windows"],
          content: "Adversaries may attempt to access credential material, passwords, or hashes from the Local Security Authority Subsystem Service (LSASS) process memory. Dumping LSASS memory is a common technique (T1003.001) used to gather cleartext credentials or NTLM hashes.\n\n### Exploit Mechanics\nTools like Mimikatz or built-in utilities like `rundll32.exe` with `comsvcs.dll` can dump the LSASS process space:\n\n```powershell\nrundll32.exe C:\\windows\\System32\\comsvcs.dll, MiniDump <lsass-pid> C:\\windows\\temp\\lsass.dmp full\n```\n\n### Detection Strategy\n* **Process Creation Audit:** Alert on process command lines executing `comsvcs.dll` alongside `MiniDump`.\n* **Access Request Tracing:** Monitor handles requested to LSASS process (`ProcessAccess` mask `0x1010` or `0x1410` inside Sysmon Event ID 10 logs).\n* **Credential Guard:** Ensure Windows Credential Guard is active to isolate LSASS inside virtualized containers.",
          last_updated: "2026-06-03"
        }
      ];

      let filtered = fallbackNotes;
      if (category !== 'ALL') {
        filtered = filtered.filter(n => n.category.toLowerCase() === category.toLowerCase());
      }
      if (search) {
        const query = search.toLowerCase();
        filtered = filtered.filter(n => 
          n.title.toLowerCase().includes(query) || 
          n.content.toLowerCase().includes(query)
        );
      }

      setNotes(filtered);
      if (filtered.length > 0) {
        setSelectedNote((prev) => {
          if (prev && filtered.some(n => n.id === prev.id)) {
            return filtered.find(n => n.id === prev.id) || null;
          }
          return filtered[0];
        });
      } else {
        setSelectedNote(null);
      }
    } finally {
      setLoading(false);
    }
  }, [supabase.auth]);

  // Debounced search trigger
  useEffect(() => {
    const delayDebounceFn = setTimeout(() => {
      fetchNotes(activeCategory, searchQuery);
    }, 300);

    return () => clearTimeout(delayDebounceFn);
  }, [activeCategory, searchQuery, fetchNotes]);

  // Monitor auth state changes
  useEffect(() => {
    const { data: { subscription } } = supabase.auth.onAuthStateChange(() => {
      fetchNotes(activeCategory, searchQuery);
    });

    return () => subscription.unsubscribe();
  }, [supabase.auth, activeCategory, searchQuery, fetchNotes]);

  return (
    <main className="relative min-h-screen overflow-x-hidden pt-24 pb-16 px-4 md:px-8 bg-[#050a18]">
      <ParticleField />
      
      {/* Background vignette overlay */}
      <div className="fixed inset-0 -z-5 pointer-events-none bg-gradient-to-t from-[#050a18] via-transparent to-[#050a18]/40" />

      <div className="z-10 max-w-6xl mx-auto flex flex-col gap-8">
        
        {/* Page Header */}
        <div className="relative border border-[#0096ff]/20 bg-[#0a1432]/30 backdrop-blur-md p-6 rounded-2xl flex flex-col md:flex-row md:items-center md:justify-between gap-4">
          <div className="absolute top-0 left-0 w-2 h-2 border-t-2 border-l-2 border-[#0096ff]" />
          <div className="absolute top-0 right-0 w-2 h-2 border-t-2 border-r-2 border-[#0096ff]" />
          <div className="absolute bottom-0 left-0 w-2 h-2 border-b-2 border-l-2 border-[#0096ff]" />
          <div className="absolute bottom-0 right-0 w-2 h-2 border-b-2 border-r-2 border-[#0096ff]" />
          
          <div>
            <div className="flex items-center gap-2 mb-1">
              <span className="w-2 h-2 bg-[#0096ff] rounded-full animate-ping" />
              <span className="text-[10px] font-mono text-[#0096ff] tracking-[0.3em] font-bold">V_INTELLIGENCE</span>
            </div>
            <h1 className="text-3xl font-extrabold font-mono tracking-wider">
              NOTES<span className="text-[#0096ff]">.VELSEC</span>
            </h1>
            <p className="text-xs text-zinc-400 font-mono mt-1">
              SecOps Cheat Sheets, Penetration Testing Guides &amp; Vulnerability Writeups
            </p>
          </div>

          <div className="flex gap-4 border-l border-[#0096ff]/15 pl-0 md:pl-6 pt-4 md:pt-0">
            <div className="text-center font-mono">
              <p className="text-[10px] text-zinc-500 font-bold">WIKI_ENTRIES</p>
              <p className="text-lg font-extrabold text-[#0096ff]">{notes.length}</p>
            </div>
            <div className="text-center font-mono">
              <p className="text-[10px] text-zinc-500 font-bold">REVISION</p>
              <p className="text-lg font-extrabold text-[#0096ff]">v2.5</p>
            </div>
          </div>
        </div>

        {errorMsg && (
          <div className="p-3.5 border border-amber-500/30 bg-amber-500/10 rounded-xl text-xs font-mono text-amber-400 text-center shadow-[0_0_15px_rgba(245,158,11,0.05)]">
            ⚠️ {errorMsg}
          </div>
        )}

        {!isAuthenticated ? (
          /* Authentication Required Alert */
          <div className="relative border border-rose-500/25 bg-rose-500/5 backdrop-blur-md rounded-2xl p-12 text-center flex flex-col items-center justify-center gap-4 max-w-xl mx-auto my-8">
            <div className="absolute top-0 left-0 w-3 h-3 border-t-2 border-l-2 border-rose-500" />
            <div className="absolute top-0 right-0 w-3 h-3 border-t-2 border-r-2 border-rose-500" />
            <div className="absolute bottom-0 left-0 w-3 h-3 border-b-2 border-l-2 border-rose-500" />
            <div className="absolute bottom-0 right-0 w-3 h-3 border-b-2 border-r-2 border-rose-500" />

            <span className="text-4xl">🔒</span>
            <h2 className="text-xl font-bold font-mono text-rose-400 tracking-wider">ACCESS_DENIED_SECURE_GATEWAY</h2>
            <p className="text-xs text-zinc-400 font-mono max-w-md leading-relaxed">
              Velsec intelligence dossiers and SecOps playbooks are encrypted at rest. Please authorize your session credentials at the central security gateway.
            </p>
            <a
              href="http://velsec.com:3000/login"
              className="mt-2 px-6 py-2.5 bg-rose-500/10 hover:bg-rose-500/20 active:scale-98 text-xs font-mono font-bold tracking-widest text-rose-400 border border-rose-500/40 rounded-lg transition-all duration-300"
            >
              AUTHENTICATE_SESSION
            </a>
          </div>
        ) : (
          /* Main Wiki Layout */
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6 items-start">
            
            {/* Sidebar Navigation */}
            <div className="flex flex-col gap-4">
              {/* Search */}
              <input
                type="text"
                placeholder="SEARCH_NOTES..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="w-full bg-[#0a1432]/25 text-xs font-mono text-zinc-200 placeholder-zinc-500 border border-[#0096ff]/20 focus:border-[#0096ff]/50 focus:outline-none rounded-lg px-3 py-2 transition-all duration-300"
              />
              
              {/* Categories */}
              <div className="flex flex-wrap gap-1.5 p-2 bg-[#0a1432]/10 rounded-xl border border-[#0096ff]/10">
                {categories.map((cat) => (
                  <button
                    key={cat}
                    onClick={() => setActiveCategory(cat)}
                    className={`px-2.5 py-1 rounded text-[9px] font-mono font-bold uppercase transition-all duration-300 ${
                      activeCategory === cat
                        ? 'bg-[#0096ff]/20 text-[#0096ff] border border-[#0096ff]/40'
                        : 'text-zinc-500 border border-transparent hover:text-zinc-300'
                    }`}
                  >
                    {cat}
                  </button>
                ))}
              </div>
              
              {/* Notes List */}
              <div className="flex flex-col gap-2 max-h-[400px] overflow-y-auto pr-1">
                {loading ? (
                  <div className="text-center py-8 font-mono text-xs text-zinc-500">
                    SYNCHRONIZING_NOTES_LIST...
                  </div>
                ) : notes.map((n) => (
                  <button
                    key={n.id}
                    onClick={() => setSelectedNote(n)}
                    className={`p-3 rounded-lg border text-left cursor-pointer transition-all duration-300 w-full ${
                      selectedNote?.id === n.id
                        ? 'border-[#0096ff] bg-[#0a1432]/35 shadow-[0_0_12px_rgba(0,150,255,0.06)]'
                        : 'border-[#0a1a40] hover:border-[#0096ff]/20 bg-[#0a1432]/5'
                    }`}
                  >
                    <span className="text-[8px] font-mono text-zinc-500 font-bold uppercase tracking-wider block mb-1">
                      {n.category}
                    </span>
                    <span className="text-xs font-mono font-bold text-zinc-200 block truncate">
                      {n.title}
                    </span>
                  </button>
                ))}

                {!loading && notes.length === 0 && (
                  <div className="text-center py-6 border border-dashed border-[#0a1a40] rounded-lg text-zinc-600 font-mono text-xs">
                    NO_INDEXED_ENTRIES_FOUND
                  </div>
                )}
              </div>
            </div>

            {/* Reader Panel */}
            <div className="md:col-span-2 relative border border-[#0096ff]/15 bg-[#0a1432]/20 backdrop-blur-md rounded-xl p-6 min-h-[450px] flex flex-col">
              <div className="absolute top-0 right-0 w-2 h-2 border-t-2 border-r-2 border-[#0096ff]/40" />
              <div className="absolute bottom-0 left-0 w-2 h-2 border-b-2 border-l-2 border-[#0096ff]/40" />

              {loading ? (
                <div className="flex flex-col items-center justify-center flex-1 text-center font-mono text-xs text-zinc-400 gap-2">
                  <span className="animate-spin">⏳</span>
                  <span>DECRYPTING_NOTE_DOSSIER...</span>
                </div>
              ) : selectedNote ? (
                <div className="flex flex-col flex-1 font-mono">
                  <div className="flex flex-wrap gap-2 mb-3">
                    {selectedNote.tags.map((t) => (
                      <span
                        key={t}
                        className="px-2 py-0.5 rounded text-[8px] font-mono font-bold tracking-widest bg-[#0a1432] border border-[#0096ff]/20 text-[#0096ff]"
                      >
                        {t.toUpperCase()}
                      </span>
                    ))}
                  </div>

                  <h2 className="text-xl font-bold text-zinc-100 mb-2">{selectedNote.title}</h2>
                  <div className="flex justify-between items-center text-[9px] text-zinc-500 border-b border-[#0096ff]/10 pb-4 mb-4">
                    <span>SECURITY_MEMORANDUM // CATEGORY: {selectedNote.category.toUpperCase()}</span>
                    <span>LAST_UPDATED: {selectedNote.last_updated}</span>
                  </div>

                  {/* Markdown Renderer */}
                  <div className="text-xs text-zinc-300 leading-relaxed max-w-none mb-4 space-y-4">
                    <ReactMarkdown
                      components={{
                        h1: ({node: _, ...props}) => <h1 className="text-sm font-bold text-zinc-200 mt-4 mb-2 border-b border-[#0096ff]/10 pb-1" {...props} />,
                        h2: ({node: _, ...props}) => <h2 className="text-xs font-bold text-zinc-200 mt-4 mb-2" {...props} />,
                        h3: ({node: _, ...props}) => <h3 className="text-[11px] font-bold text-zinc-300 mt-3 mb-1" {...props} />,
                        p: ({node: _, ...props}) => <p className="mb-4 leading-relaxed text-zinc-400" {...props} />,
                        ul: ({node: _, ...props}) => <ul className="list-disc pl-4 mb-4 space-y-1" {...props} />,
                        ol: ({node: _, ...props}) => <ol className="list-decimal pl-4 mb-4 space-y-1" {...props} />,
                        li: ({node: _, ...props}) => <li className="text-zinc-400" {...props} />,
                        pre: ({node: _, ...props}) => <pre className="bg-[#050a18]/90 rounded-lg border border-[#0a1a40] p-4 text-[10px] text-[#00f0ff] overflow-x-auto my-4 whitespace-pre" {...props} />,
                        code: ({node: _, ...props}) => <code className="bg-[#050a18]/60 text-[#00f0ff] px-1 py-0.5 rounded border border-[#0a1a40] text-[10px]" {...props} />,
                        a: ({node: _, ...props}) => <a className="text-[#0096ff] hover:underline" target="_blank" rel="noreferrer" {...props} />,
                      }}
                    >
                      {selectedNote.content}
                    </ReactMarkdown>
                  </div>
                </div>
              ) : (
                <div className="flex flex-col items-center justify-center flex-1 text-center text-zinc-500 font-mono text-xs">
                  <span className="text-3xl mb-3">📖</span>
                  SELECT_A_DOSSIER_TO_VIEW_INTELLIGENCE
                </div>
              )}
            </div>

          </div>
        )}

        {/* Back Link */}
        <div className="text-center mt-4">
          <a
            href="http://velsec.com:3000"
            className="inline-flex items-center gap-2 text-xs font-mono font-bold text-zinc-500 hover:text-[#0096ff] transition-colors"
          >
            <span>&lt;--</span>
            <span>SYSTEM_CORE_HOME</span>
          </a>
        </div>
      </div>
    </main>
  );
}
