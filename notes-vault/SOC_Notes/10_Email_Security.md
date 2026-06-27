# Email Security

> Protecting against email-based threats and investigating phishing incidents.

---

## SMTP Server (Simple Mail Transfer Protocol) - Port 25
Also known as:
- **UCS** (Unified Communication Server)
- **Exchange Server**
- **Email Server**
- **Outlook / Office 365**

---

## Email Authentication Mechanisms

### SPF (Sender Policy Framework)
- Email authentication to **prevent spoofing/spamming**
- Enabled in SMTP Server
- Status: **PASS** = genuine | **FAIL** = suspicious
- Validates that the sending server is authorized for the domain

### DKIM (Domain Key Identified Mail)
- Exchanges **public/private keys** between sender and receiver
- Creates encrypted channel for confidential emails
- Status: **PASS** = genuine key verified
- Prevents tampering of email content in transit

### DMARC (Domain Message Authentication Reporting & Conformance)
- **Combination of SPF + DKIM** policies
- Validates sender authenticity via digital certificate
- If SPF + DKIM both **PASS** → email is **genuine**
- If either **FAIL** → email is **suspicious (phishing)**

---

## Email Investigation Parameters

When investigating a suspicious email, check:

| Parameter | What to Look For |
|-----------|-----------------|
| **Message ID** | Unique identifier |
| **From** | Sender address (check for spoofing) |
| **To** | Recipient(s) |
| **Subject** | Social engineering indicators |
| **SPF** | PASS or FAIL |
| **DKIM** | PASS or FAIL |
| **DMARC** | PASS or FAIL |
| **Return Path** | Should match sender domain |
| **Header Analyzer** | HTML format, full email body |
| **DNS Record** | Domain verification |
| **Domain Keys** | Public/private key verification |

---

## Email Investigation Workflow

1. **Receive alert** from SIEM or email gateway
2. **Check SPF, DKIM, DMARC** status
3. **Analyze sender** domain and email address
4. **Check URL links** in the email (DO NOT click!)
5. **Check attachments** (hash analysis via VirusTotal)
6. **Verify domain reputation** using MXTool, VirusTotal
7. **Determine**: Phishing? Spam? Legitimate?
8. **Take action**: Block sender domain, quarantine email, alert users
9. **Document** in ticketing system

---

## DNS Records Related to Email

| Record | Purpose |
|--------|---------|
| **MX** (Mail Exchange) | Directs email to the correct mail server |
| **SPF** | TXT record listing authorized sending servers |
| **DKIM** | TXT record with public key for signature verification |
| **DMARC** | TXT record with policy for handling authentication failures |

---

## Email Threats

| Threat | Description |
|--------|-------------|
| **Phishing** | Fraudulent emails to steal credentials/data |
| **Spear Phishing** | Targeted phishing at specific individuals |
| **Whaling** | Phishing targeting executives |
| **BEC** (Business Email Compromise) | Impersonating business contacts |
| **Spam** | Unsolicited bulk emails |
| **Spoofing** | Faking sender address |

---

> **Tip**: Use [MXToolbox](https://mxtoolbox.com) to verify email configurations

---

*Source: SOC Analyst Notes, Pages 46-52*
