---
title: "SIEM Rules: SQL Injection Detection"
category: "SIEM Queries"
tags: ["SQL Injection", "WAF", "SIEM", "KQL"]
lastUpdated: "2026-06-03"
---

SQL Injection (SQLi) is a code injection technique used to attack data-driven applications by inserting malicious SQL statements into entry fields. This note documents SIEM detection rules for tracing SQLi attempts in web access logs.

### KQL Query (Microsoft Sentinel)
Use the following Kusto Query Language (KQL) rule to detect typical SQL injection query signatures (like `' OR 1=1`) inside Web Application Firewall (WAF) requests:

```kql
AzureDiagnostics
| where ResourceProvider == "MICROSOFT.NETWORK" and Category == "ApplicationGatewayFirewallLog"
| where Message has "SQL Injection" or details_message_s has "SQL Injection"
| extend clientIP = clientIp_s, requestUri = requestUri_s
| summarize count() by clientIP, requestUri, bin(TimeGenerated, 5m)
| filter count_ > 5
```

### Splunk Search Query
```splunk
index=security sourcetype=access_combined (select OR union OR "1=1" OR "1'1")
| stats count by clientip, uri
| where count > 10
```
