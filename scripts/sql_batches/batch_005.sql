-- Batch 5: 10 notes
BEGIN;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$PROJECT_GUIDE$VELSEC$, $VELSEC$Project Guide$VELSEC$, $VELSEC$Data Analyst$VELSEC$, ARRAY['Data_Analytics']::TEXT[], $VELSEC$# 🏗️ POWER BI DASHBOARD PROJECT — Security Findings Management

> **Complete, hands-on project to build a production-quality dashboard**
> **Mapped to Wells Fargo JD: CSPM/CWPP Findings Management + SLA Tracking**

---

# PROJECT OVERVIEW

```
WHAT YOU'LL BUILD:

A 3-page Power BI dashboard that answers:
1. "What is our current cloud security posture?" → Executive Summary
2. "Which teams need help?"                     → Team Performance
3. "What are the riskiest findings?"            → Finding Details

DATA SOURCES (included in /data/ folder):
├── wiz_findings.csv     → 50 security findings (Azure + GCP)
├── cmdb_assets.csv      → 30 CMDB configuration items with owners
└── servicenow_tickets.csv → 50 ServiceNow tickets with SLA data

TIME TO COMPLETE: 3-4 hours
SKILL LEVEL: Beginner → Intermediate
```

---

# STEP 1: INSTALL & SETUP

## 1.1 Install Power BI Desktop (Free)

```
1. Go to: https://powerbi.microsoft.com/en-us/desktop/
2. Click "Download free" → install
3. Sign in with Microsoft account (free — use any Outlook/Hotmail account)
4. Open Power BI Desktop
```

## 1.2 Download Project Files

```
All 3 CSV files are in the PowerBI_Project/data/ folder:
├── wiz_findings.csv
├── cmdb_assets.csv
└── servicenow_tickets.csv
```

---

# STEP 2: LOAD DATA (Get Data → Power Query)

## 2.1 Import the 3 CSV Files

```
1. Home → Get Data → Text/CSV
2. Browse to: PowerBI_Project/data/wiz_findings.csv → Open → Load
3. Repeat for cmdb_assets.csv
4. Repeat for servicenow_tickets.csv
```

## 2.2 Transform Data in Power Query

Click **"Transform Data"** on the Home tab to open Power Query Editor.

### Transform: wiz_findings table

```
Apply these steps IN ORDER:

1. CHANGE DATA TYPES (click column header → Change Type):
   ├── created_date → Date
   ├── closed_date → Date
   └── sla_hours → Whole Number

2. ADD CUSTOM COLUMN: Age_Days
   ├── Add Column → Custom Column
   ├── Name: Age_Days
   ├── Formula:
       if [status] = "Closed" then
           Duration.Days([closed_date] - [created_date])
       else
           Duration.Days(DateTime.LocalNow() - [created_date])

3. ADD CUSTOM COLUMN: SLA_Days
   ├── Add Column → Custom Column
   ├── Name: SLA_Days
   ├── Formula:
       [sla_hours] / 24

4. ADD CUSTOM COLUMN: SLA_Pct_Used
   ├── Add Column → Custom Column
   ├── Name: SLA_Pct_Used
   ├── Formula:
       if [SLA_Days] = 0 then 0
       else [Age_Days] / [SLA_Days] * 100

5. ADD CUSTOM COLUMN: SLA_Status
   ├── Add Column → Custom Column
   ├── Name: SLA_Status
   ├── Formula:
       if [status] = "Closed" then "Resolved"
       else if [SLA_Pct_Used] >= 100 then "Breached"
       else if [SLA_Pct_Used] >= 75 then "At Risk"
       else "On Track"

6. ADD CUSTOM COLUMN: Age_Bucket
   ├── Add Column → Custom Column
   ├── Name: Age_Bucket
   ├── Formula:
       if [Age_Days] <= 7 then "0-7 days"
       else if [Age_Days] <= 30 then "8-30 days"
       else if [Age_Days] <= 60 then "31-60 days"
       else "60+ days"

7. ADD CUSTOM COLUMN: Severity_Order (for sorting)
   ├── Add Column → Custom Column
   ├── Name: Severity_Order
   ├── Formula:
       if [severity] = "CRITICAL" then 1
       else if [severity] = "HIGH" then 2
       else if [severity] = "MEDIUM" then 3
       else 4
```

### Transform: cmdb_assets table

```
1. CHANGE DATA TYPES:
   └── All text columns should be Text type (should be auto-detected)

2. No additional transformations needed — this is a lookup table
```

### Transform: servicenow_tickets table

```
1. CHANGE DATA TYPES:
   ├── created_date → Date
   ├── resolved_date → Date
   └── sla_target_date → Date

2. ADD CUSTOM COLUMN: Resolution_Days
   ├── Add Column → Custom Column
   ├── Name: Resolution_Days
   ├── Formula:
       if [resolved_date] = null then null
       else Duration.Days([resolved_date] - [created_date])
```

### Close & Apply

```
Click "Close & Apply" in the top-left
→ Data loads into the Power BI data model
```

---

# STEP 3: BUILD DATA MODEL (Relationships)

## 3.1 Create Relationships

```
1. Click the "Model" view icon (3rd icon on the left sidebar)
2. Create these relationships by dragging fields:

   wiz_findings[resource_id]  ──→  cmdb_assets[cloud_resource_id]
   (Many-to-One, Single direction)

   wiz_findings[finding_id]   ──→  servicenow_tickets[finding_id]
   (One-to-One, Single direction)

RESULT:
┌───────────────┐        ┌──────────────┐        ┌────────────────────┐
│ cmdb_assets   │◄──────►│ wiz_findings │◄──────►│ servicenow_tickets │
│ (Dimension)   │  M:1   │ (Fact Table) │  1:1   │ (Fact Table)       │
└───────────────┘        └──────────────┘        └────────────────────┘
```

## 3.2 Create a Date Table (for Time Intelligence)

```
1. Go to "Report" view
2. Modeling → New Table
3. Paste this DAX:

DIM_Date =
ADDCOLUMNS(
    CALENDAR(DATE(2024,12,1), DATE(2025,12,31)),
    "Year", YEAR([Date]),
    "Month", FORMAT([Date], "MMM"),
    "MonthNumber", MONTH([Date]),
    "Quarter", "Q" & FORMAT(CEILING(MONTH([Date])/3, 1), "0"),
    "WeekNumber", WEEKNUM([Date]),
    "DayOfWeek", FORMAT([Date], "ddd"),
    "YearMonth", FORMAT([Date], "YYYY-MM")
)

4. Go to Model view → drag:
   DIM_Date[Date] → wiz_findings[created_date]
   (Many-to-One)
```

---

# STEP 4: CREATE DAX MEASURES

## 4.1 Create a Measures Table

```
1. Modeling → New Table → paste: Measures = ROW("x", 0)
2. This creates a dedicated table for all measures (best practice)
3. Right-click "Measures" table → select "Hide in report view"
   (hides the dummy column)
```

## 4.2 KPI Measures — Create Each One

```
Go to Modeling → New Measure for each:
```

### Core Counts

```dax
Total Findings = COUNTROWS(wiz_findings)

Open Findings =
CALCULATE(
    COUNTROWS(wiz_findings),
    wiz_findings[status] = "Open"
)

Closed Findings =
CALCULATE(
    COUNTROWS(wiz_findings),
    wiz_findings[status] = "Closed"
)

Critical Open =
CALCULATE(
    COUNTROWS(wiz_findings),
    wiz_findings[severity] = "CRITICAL",
    wiz_findings[status] = "Open"
)

High Open =
CALCULATE(
    COUNTROWS(wiz_findings),
    wiz_findings[severity] = "HIGH",
    wiz_findings[status] = "Open"
)

Medium Open =
CALCULATE(
    COUNTROWS(wiz_findings),
    wiz_findings[severity] = "MEDIUM",
    wiz_findings[status] = "Open"
)

Low Open =
CALCULATE(
    COUNTROWS(wiz_findings),
    wiz_findings[severity] = "LOW",
    wiz_findings[status] = "Open"
)
```

### SLA Measures

```dax
SLA Compliance Rate =
VAR _total = CALCULATE(COUNTROWS(wiz_findings), wiz_findings[status] = "Open")
VAR _ontrack = CALCULATE(
    COUNTROWS(wiz_findings),
    wiz_findings[status] = "Open",
    wiz_findings[SLA_Status] = "On Track"
)
RETURN DIVIDE(_ontrack, _total, 0) * 100

SLA Breached Count =
CALCULATE(
    COUNTROWS(wiz_findings),
    wiz_findings[status] = "Open",
    wiz_findings[SLA_Status] = "Breached"
)

SLA At Risk Count =
CALCULATE(
    COUNTROWS(wiz_findings),
    wiz_findings[status] = "Open",
    wiz_findings[SLA_Status] = "At Risk"
)
```

### MTTR Measures

```dax
MTTR Days =
AVERAGEX(
    FILTER(wiz_findings, wiz_findings[status] = "Closed"),
    wiz_findings[Age_Days]
)

MTTR Critical =
AVERAGEX(
    FILTER(wiz_findings,
        wiz_findings[status] = "Closed" &&
        wiz_findings[severity] = "CRITICAL"
    ),
    wiz_findings[Age_Days]
)

MTTR High =
AVERAGEX(
    FILTER(wiz_findings,
        wiz_findings[status] = "Closed" &&
        wiz_findings[severity] = "HIGH"
    ),
    wiz_findings[Age_Days]
)
```

### Trend Measures

```dax
Findings This Month =
CALCULATE(
    COUNTROWS(wiz_findings),
    DATESMTD(DIM_Date[Date])
)

Findings Last Month =
CALCULATE(
    [Total Findings],
    DATEADD(DIM_Date[Date], -1, MONTH)
)

MoM Change % =
VAR _current = [Open Findings]
VAR _previous = CALCULATE([Open Findings], DATEADD(DIM_Date[Date], -1, MONTH))
RETURN DIVIDE(_current - _previous, _previous, 0) * 100
```

### Compliance Measures

```dax
Azure Findings =
CALCULATE(COUNTROWS(wiz_findings), wiz_findings[cloud_provider] = "Azure")

GCP Findings =
CALCULATE(COUNTROWS(wiz_findings), wiz_findings[cloud_provider] = "GCP")

Internet Facing Critical =
CALCULATE(
    COUNTROWS(wiz_findings),
    wiz_findings[severity] = "CRITICAL",
    wiz_findings[internet_facing] = "Yes",
    wiz_findings[status] = "Open"
)
```

### Team Performance

```dax
Team SLA Compliance =
VAR _team_total =
    CALCULATE(COUNTROWS(servicenow_tickets), servicenow_tickets[status] <> "Closed")
VAR _team_met =
    CALCULATE(
        COUNTROWS(servicenow_tickets),
        servicenow_tickets[status] <> "Closed",
        servicenow_tickets[sla_status] = "On Track"
    )
RETURN DIVIDE(_team_met, _team_total, 0) * 100

Avg Resolution Days =
AVERAGEX(
    FILTER(servicenow_tickets, servicenow_tickets[Resolution_Days] <> BLANK()),
    servicenow_tickets[Resolution_Days]
)
```

---

# STEP 5: BUILD PAGE 1 — EXECUTIVE SUMMARY

## 5.1 Page Setup

```
1. Right-click "Page 1" tab at bottom → Rename to "Executive Summary"
2. Format → Page background → Color: #1a1a2e (dark navy)
3. Format → Canvas settings → Type: Custom, Width: 1920, Height: 1080
```

## 5.2 Add Header

```
1. Insert → Text Box
2. Text: "☁️ CLOUD SECURITY FINDINGS MANAGEMENT DASHBOARD"
3. Font: Segoe UI, Size: 24, Bold, Color: White
4. Position: top center, spanning full width
5. Background: transparent
```

## 5.3 Add KPI Cards (Top Row)

```
Create 6 Card visuals across the top:

CARD 1: Total Open
├── Fields: [Open Findings]
├── Format → Callout value: Font 36, Color: White
├── Format → Category label: "OPEN FINDINGS", Size 12, Color: #aaaaaa
├── Format → Background: #16213e
├── Format → Border: Left bar, Color: #3498db, Width: 4
└── Size: 200x120

CARD 2: Critical
├── Fields: [Critical Open]
├── Same format as Card 1
├── Border color: #e74c3c (red)
└── Category label: "CRITICAL"

CARD 3: High
├── Fields: [High Open]
├── Border color: #e67e22 (orange)
└── Category label: "HIGH"

CARD 4: SLA Compliance
├── Fields: [SLA Compliance Rate]
├── Format → Display units: None
├── Format → Value suffix: "%"
├── Border color: #2ecc71 (green)
└── Category label: "SLA COMPLIANCE"

CARD 5: SLA Breached
├── Fields: [SLA Breached Count]
├── Border color: #e74c3c (red)
└── Category label: "SLA BREACHED"

CARD 6: MTTR (Days)
├── Fields: [MTTR Days]
├── Format → Decimal places: 1
├── Border color: #9b59b6 (purple)
└── Category label: "AVG MTTR (DAYS)"
```

## 5.4 Add Charts (Middle Row)

```
CHART 1: Findings by Severity (Donut Chart) — Left
├── Legend: wiz_findings[severity]
├── Values: [Open Findings]
├── Format → Colors:
│   ├── CRITICAL: #e74c3c
│   ├── HIGH: #e67e22
│   ├── MEDIUM: #f1c40f
│   └── LOW: #2ecc71
├── Format → Detail labels: Show category + value
├── Size: 400x300
└── Position: Left side, below KPI cards

CHART 2: Findings by Category (Bar Chart) — Center
├── Y-axis: wiz_findings[category]
├── Values: [Open Findings]
├── Format → Data colors: #3498db
├── Format → Sort: Descending by value
├── Size: 500x300
└── Position: Center, below KPI cards

CHART 3: Findings by Cloud Provider (Donut Chart) — Right
├── Legend: wiz_findings[cloud_provider]
├── Values: [Total Findings]
├── Format → Colors:
│   ├── Azure: #0078d4
│   └── GCP: #4285f4
├── Size: 400x300
└── Position: Right side, below KPI cards
```

## 5.5 Add Charts (Bottom Row)

```
CHART 4: Findings Trend by Month (Stacked Area Chart)
├── X-axis: DIM_Date[YearMonth]
├── Legend: wiz_findings[severity]
├── Values: Count of finding_id
├── Format → Same severity colors as donut
├── Size: 600x250
└── Position: Left bottom

CHART 5: SLA Status Distribution (Stacked Bar)
├── X-axis: wiz_findings[SLA_Status]
├── Values: [Open Findings]
├── Format → Colors:
│   ├── On Track: #2ecc71
│   ├── At Risk: #f1c40f
│   ├── Breached: #e74c3c
│   └── Resolved: #95a5a6
├── Size: 400x250
└── Position: Center bottom

CHART 6: Internet-Facing Critical (KPI Visual)
├── Value: [Internet Facing Critical]
├── Target: 0 (goal is zero)
├── Format → Direction: Low is good
├── Size: 300x250
└── Position: Right bottom
```

## 5.6 Add Slicers

```
SLICER 1: Cloud Provider
├── Field: wiz_findings[cloud_provider]
├── Style: Tile (horizontal buttons)
├── Position: Below header, left

SLICER 2: Severity
├── Field: wiz_findings[severity]
├── Style: Tile
├── Position: Below header, center

SLICER 3: Category
├── Field: wiz_findings[category]
├── Style: Dropdown
├── Position: Below header, right
```

---

# STEP 6: BUILD PAGE 2 — TEAM PERFORMANCE

```
1. Click "+" at bottom to add new page → Rename to "Team Performance"
2. Same dark background: #1a1a2e
```

## 6.1 Visuals to Add

```
VISUAL 1: SLA Compliance by Team (Horizontal Bar Chart)
├── Y-axis: cmdb_assets[assignment_group]
├── Values: [Team SLA Compliance]
├── Format → Data colors: Conditional formatting
│   ├── Rules:
│   │   ├── >=90: #2ecc71 (green)
│   │   ├── >=70: #f1c40f (yellow)
│   │   └── <70: #e74c3c (red)
├── Format → Data labels: ON, show percentage
├── Size: 600x400
└── Position: Left side

VISUAL 2: Open Findings by Team (Stacked Bar)
├── Y-axis: cmdb_assets[assignment_group]
├── Legend: wiz_findings[severity]
├── Values: [Open Findings]
├── Format → Same severity colors
├── Size: 600x400
└── Position: Right side

VISUAL 3: Team Detail Table (Table Visual)
├── Columns:
│   ├── cmdb_assets[assignment_group]
│   ├── cmdb_assets[manager]
│   ├── [Open Findings]
│   ├── [Critical Open]
│   ├── [SLA Breached Count]
│   ├── [Team SLA Compliance]
│   └── [Avg Resolution Days]
├── Format → Conditional formatting on SLA Breached Count (red scale)
├── Format → Style: Alternating rows
├── Size: full width, 300 height
└── Position: Bottom

VISUAL 4: MTTR by Severity (Clustered Column)
├── X-axis: wiz_findings[severity]
├── Values: [MTTR Days]
├── Format → Data labels: ON
├── Size: 400x250
└── Position: Bottom right
```

---

# STEP 7: BUILD PAGE 3 — FINDING DETAILS

```
1. Add new page → Rename to "Finding Details"
2. Same dark background
```

## 7.1 Visuals

```
VISUAL 1: Findings Detail Table
├── Columns:
│   ├── wiz_findings[finding_id]
│   ├── wiz_findings[severity]
│   ├── wiz_findings[title]
│   ├── wiz_findings[cloud_provider]
│   ├── wiz_findings[status]
│   ├── wiz_findings[Age_Days]
│   ├── wiz_findings[SLA_Status]
│   ├── cmdb_assets[owner]
│   ├── cmdb_assets[assignment_group]
│   └── servicenow_tickets[ticket_id]
├── Format → Conditional formatting:
│   ├── Severity: colors (CRITICAL=red, HIGH=orange, etc.)
│   ├── SLA_Status: colors (Breached=red, At Risk=yellow, On Track=green)
│   └── Age_Days: color scale (low=green, high=red)
├── Sort: by Severity_Order ASC, then Age_Days DESC
└── Size: Full page width, 500 height

VISUAL 2: Top 10 Oldest Open Findings (Table)
├── Filter: status = "Open"
├── Top N: 10, by Age_Days
├── Columns: finding_id, title, severity, Age_Days, owner, SLA_Status
└── Position: Bottom

VISUAL 3: Findings by CIS Control (Treemap)
├── Group: wiz_findings[cis_control]
├── Values: Count of finding_id
├── Format → Data colors: by severity
└── Position: Bottom right
```

---

# STEP 8: ADD DRILL-THROUGH

```
1. On "Finding Details" page:
   ├── Drag wiz_findings[severity] to Drill-Through field well
   ├── Drag cmdb_assets[assignment_group] to Drill-Through field well
   └── Add a "Back" button: Insert → Buttons → Back

2. Now from Executive Summary or Team Performance:
   ├── Right-click any CRITICAL bar → Drill Through → Finding Details
   └── Shows only Critical findings on the detail page

3. Click the Back button to return to the summary page
```

---

# STEP 9: FORMAT & POLISH

## 9.1 Theme

```
1. View → Themes → Browse for themes
2. Or customize:
   ├── Background: #1a1a2e
   ├── Card background: #16213e
   ├── Text: White (#ffffff)
   ├── Secondary text: #aaaaaa
   ├── Accent 1: #3498db (blue)
   ├── Accent 2: #e74c3c (red)
   ├── Accent 3: #2ecc71 (green)
   ├── Accent 4: #f1c40f (yellow)
   └── Font: Segoe UI
```

## 9.2 Add Page Navigation

```
1. Insert → Buttons → Navigator → Page Navigator
2. Style: Fill with dark color, text white
3. Position: Top right corner
4. Users can click to switch between pages
```

## 9.3 Add Last Refresh Date

```
1. Insert → Text Box
2. Type: "Last Refresh: "
3. Or create a Measure:

Last Refresh = "Data as of: " & FORMAT(NOW(), "DD-MMM-YYYY HH:MM")

4. Add a Card with this measure at the top right
```

---

# STEP 10: PUBLISH & SHARE

```
1. Save: File → Save As → "WF_Findings_Dashboard.pbix"

2. Publish to Power BI Service (optional):
   ├── Home → Publish → My Workspace
   ├── Opens in browser
   └── Can share with others via link

3. Export: File → Export → PDF
   → Great for emailing to stakeholders or bringing to interviews
```

---

# 📋 CHECKLIST — Did You Build Everything?

```
DATA LAYER:
☐ Imported wiz_findings.csv
☐ Imported cmdb_assets.csv
☐ Imported servicenow_tickets.csv
☐ Applied Power Query transformations (Age_Days, SLA_Status, etc.)
☐ Created DIM_Date table
☐ Created relationships between tables

DAX MEASURES:
☐ Total / Open / Closed Findings
☐ Critical / High / Medium / Low Open
☐ SLA Compliance Rate
☐ SLA Breached Count
☐ MTTR Days + MTTR by severity
☐ MoM Change %
☐ Azure / GCP Findings
☐ Internet Facing Critical
☐ Team SLA Compliance
☐ Avg Resolution Days

PAGE 1 — EXECUTIVE SUMMARY:
☐ 6 KPI cards
☐ Severity donut chart
☐ Category bar chart
☐ Cloud provider donut
☐ Trend area chart
☐ SLA status bar
☐ 3 slicers (cloud, severity, category)

PAGE 2 — TEAM PERFORMANCE:
☐ SLA compliance by team (conditional colors)
☐ Open findings by team (stacked by severity)
☐ Team detail table
☐ MTTR by severity column chart

PAGE 3 — FINDING DETAILS:
☐ Full findings table with conditional formatting
☐ Top 10 oldest findings
☐ CIS control treemap
☐ Drill-through configured

POLISH:
☐ Dark theme applied
☐ Page navigation added
☐ Last refresh date
☐ All visuals labeled clearly
☐ Exported to PDF for interview portfolio
```

---

# 🎤 INTERVIEW TALKING POINTS FOR THIS DASHBOARD

> "I built a 3-page Power BI dashboard for findings management. Page 1 is the executive summary — KPI cards show open findings, SLA compliance rate, and MTTR. Page 2 drills into team performance, showing SLA compliance by assignment group with conditional formatting — red means they're behind, green means on track. Page 3 is the detail drill-through for investigation."

> "Under the hood, I use Power Query for ETL — merging Wiz findings with CMDB data to get owners, and calculating SLA status dynamically based on severity-specific SLA targets. I created DAX measures for everything — using CALCULATE for context-aware KPIs, AVERAGEX for MTTR calculation, and time intelligence functions for month-over-month trend analysis."

> "The data model follows a star schema — wiz_findings is the fact table, linked to CMDB dimension table for owners and ServiceNow tickets for tracking. I also created a date dimension table for time intelligence. This is the same architecture I'd use in production at Wells Fargo."$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Role_Validation_Workflow_Guide$VELSEC$, $VELSEC$Role Validation Workflow Guide$VELSEC$, $VELSEC$Data Analyst$VELSEC$, ARRAY['Data_Analytics']::TEXT[], $VELSEC$# 🔐 PowerBI Project — Role Validation & Alignment

> **Purpose:** Validate every existing PowerBI_Project deliverable against the 10 job
> responsibilities, show exactly which files prove which skill, and identify how
> the full workflow maps to a day-to-day in this role.

---

# PART 1: RESPONSIBILITY → EVIDENCE MAPPING

## How Each Job Responsibility is Proven by the PowerBI Project

| # | Job Responsibility | Evidence in PowerBI_Project | File(s) |
|---|-------------------|---------------------------|---------|
| **1** | Manage security findings, alerts, and exceptions across CSPM, CWPP, vulnerability management platforms, Splunk, and Wiz (attack paths, compliance, CCR) — ensuring accurate triage, routing, and follow-up | ✅ **Fully covered.** The entire project revolves around ingesting Wiz findings (50 records: CRITICAL/HIGH/MEDIUM/LOW), calculating SLA status (Breached/At-Risk/On-Track), and routing to assignment groups via CMDB join. The `Executive_Dashboard_Guide.md` has a Security Score formula (37/100), SLA compliance tracking (48%), and an Owner Accountability Matrix showing who is behind. The severity-based triage logic (CRITICAL=24h SLA, HIGH=168h, MEDIUM=720h, LOW=2160h) mirrors real CSPM triage workflows. | `PROJECT_GUIDE.md` (DAX measures L226-362), `Executive_Dashboard_Guide.md` (Pages 1-3), `wiz_findings.csv` |
| **2** | Perform advanced data analysis for deduplication, correlation, and bulk updates — working with large datasets from CSVs, APIs, and cloud logs | ✅ **Fully covered.** Power Query transformations deduplicate and correlate data across 3 sources. `Live_Data_Pipeline_Guide.md` shows Python ETL pulling from Wiz GraphQL API (paginated, 500/page), SQL CMDB (direct query), and ServiceNow REST API (paginated, 10K/page). Data is joined on `resource_id` and `finding_id` keys. Bulk updates via TRUNCATE+INSERT pattern. | `Live_Data_Pipeline_Guide.md` (Parts 4-5), `PROJECT_GUIDE.md` (Power Query L66-156) |
| **3** | Build and maintain Power BI dashboards and reports — dataset connections, DAX development, and Power Query (M-language) transformations for security and inventory data | ✅ **Core deliverable.** PROJECT_GUIDE has 20+ DAX measures (CALCULATE, AVERAGEX, DATESMTD, DIVIDE, SUMX, FILTER). Power Query M-language shown with 7 custom columns (Age_Days, SLA_Days, SLA_Pct_Used, SLA_Status, Age_Bucket, Severity_Order). Executive Dashboard Guide adds 20 more DAX measures including Security Score, Net Change, Risk Score, MTTR Critical/High. 3-page dashboard with dark theme, conditional formatting, drill-through. | `PROJECT_GUIDE.md` (L207-383), `Executive_Dashboard_Guide.md` (L231-387) |
| **4** | Extract, clean, and shape data using Excel (VLOOKUP/XLOOKUP, PivotTables, Power Query, Index-Match, conditional formatting) for analysis, reporting, and audit preparation | ✅ **Partially covered via Power BI equivalent** + **Fully covered in separate Excel tutorial.** The Power Query transformations in the project mirror Excel Power Query exactly. The Excel_Data_Analysis_Complete_Tutorial.md covers VLOOKUP, XLOOKUP, INDEX MATCH, PivotTables, conditional formatting, and audit-style reports. For the PowerBI project specifically, conditional formatting is used on all 3 dashboard pages (severity colors, SLA status colors, age color scales). | `PROJECT_GUIDE.md` (Power Query section), `Excel_Data_Analysis_Complete_Tutorial.md` |
| **5** | Integrate data from databases into Power BI — SQL queries, building relationships, applying incremental refresh, and modeling data for cloud security KPIs and dashboards | ✅ **Fully covered.** `Live_Data_Pipeline_Guide.md` has complete SQL DDL (CREATE TABLE) for 4 tables + Python SQL queries for CMDB extraction. `PROJECT_GUIDE.md` shows data model relationships (wiz_findings ↔ cmdb_assets M:1, wiz_findings ↔ servicenow_tickets 1:1) plus a DAX-generated Date Table with time intelligence functions (DATESMTD, DATEADD). Star schema architecture documented. | `Live_Data_Pipeline_Guide.md` (Part 3), `PROJECT_GUIDE.md` (L160-203) |
| **6** | Manage workflow and ownership mapping in ServiceNow — CMDB validation, ticket routing logic, change request processing, and inventory verification across Azure, GCP | ✅ **Fully covered.** `cmdb_assets.csv` has 30 assets with owner, assignment_group, business_unit, environment, and cloud_provider fields across Azure and GCP. `servicenow_tickets.csv` has 50 tickets with assignment_group, ticket routing to 6 teams, change_request_id field, and SLA tracking. The Owner Accountability Matrix on Page 3 shows CMDB validation by cross-referencing owners with finding counts and SLA performance. | `cmdb_assets.csv`, `servicenow_tickets.csv`, `Executive_Dashboard_Guide.md` (L693-702) |
| **7** | Lead recurring customer engagement — weekly office hours, remediation meetings, SLA tracking reviews, and escalations with application teams and engineering partners | ✅ **Covered by dashboard outputs.** The 3-page dashboard IS the artifact you present in weekly/monthly reviews. Page 1 (Executive Risk Overview) = CISO monthly review. Page 2 (SLA & Remediation Operations) = weekly remediation meeting with teams. Page 3 (Owner Accountability Matrix) = escalation tracking. The 30-60-90 day improvement roadmap in `Executive_Dashboard_Guide.md` maps to recurring engagement cadence. | `Executive_Dashboard_Guide.md` (Parts 4-5, L840-910) |
| **8** | Create and maintain documentation, SOPs, KB articles, and remediation guides for governance, onboarding, and repeatable operational processes | ✅ **Fully covered.** The 3 guides ARE operational documentation: `PROJECT_GUIDE.md` = SOP for dashboard build (step-by-step, reproducible). `Executive_Dashboard_Guide.md` = governance reporting SOP. `Live_Data_Pipeline_Guide.md` = data pipeline KB article with troubleshooting, security checklist, and interview Q&A. All include checklists for completeness verification. | All 3 `.md` files |
| **9** | Review and validate cloud security misconfigurations across Azure and GCP — IAM, network, storage, VM hardening, and compliance controls | ✅ **Fully covered by data.** `wiz_findings.csv` contains findings across 7 categories: Network (NSG SSH 0.0.0.0/0, NSG All Inbound), IAM (MFA Not Enforced, Service Account Owner Role), Storage (Blob Public Access, GCS Uniform Access), Container (AKS Privileged Pods, GKE Legacy ABAC), Compute (VM Disk Encryption), Encryption (Key Vault Soft Delete), Database (SQL TDE). Both Azure and GCP findings with CIS benchmark mapping. | `wiz_findings.csv`, `Executive_Dashboard_Guide.md` (Page 3 CIS Benchmark Gaps) |
| **10** | Collaborate with cross-functional teams (SecOps, Cloud Engineering, Platform Owners) to track remediation progress, clarify ownership boundaries, and ensure accurate closure of exceptions | ✅ **Fully covered.** The dashboard's Team Performance page (Page 2) shows SLA compliance BY assignment group (Container-Platform, Platform-Eng, Network-Ops, Data-Engineering, AppDev-Team, Identity-Security). The Owner Accountability Matrix assigns findings to specific individuals. The drill-through feature lets you click a team → see their specific findings → track closure. | `PROJECT_GUIDE.md` (Page 2, L534-584), `Executive_Dashboard_Guide.md` (L548-581) |

---

## Coverage Score

```
┌─────────────────────────────────────────────────────────────────┐
│  RESPONSIBILITY COVERAGE SCORECARD                               │
│                                                                  │
│  ✅ Fully Covered:   9 / 10  (90%)                              │
│  ⚠️ Partially:       1 / 10  (10%) — Excel skills in separate  │
│                                       tutorial, not in project  │
│  ❌ Missing:          0 / 10  (0%)                              │
│                                                                  │
│  VERDICT: The PowerBI_Project portfolio comprehensively          │
│           demonstrates ALL 10 job responsibilities.              │
└─────────────────────────────────────────────────────────────────┘
```

---

# PART 2: TECHNICAL SKILL VALIDATION

## Skills Demonstrated Across All Files

### Power BI & DAX

| Skill | Where Demonstrated | Complexity |
|-------|-------------------|-----------|
| DAX: `CALCULATE` with multi-filter context | Critical Open, High Open, Internet Exposure | ★★★★☆ |
| DAX: `AVERAGEX` + `FILTER` | MTTR Days, MTTR Critical/High | ★★★★★ |
| DAX: `DATESMTD`, `DATEADD` | Opened This Month, MoM Change % | ★★★★☆ |
| DAX: `DIVIDE` (safe division) | SLA Compliance %, Closure Rate | ★★★☆☆ |
| DAX: `SUMX` with filter | Total Risk Score per BU | ★★★★☆ |
| DAX: `VAR` + `RETURN` pattern | Security Score, SLA Compliance | ★★★★★ |
| DAX: `COUNTROWS` vs `COUNT` | Total/Open/Closed Findings | ★★☆☆☆ |
| DAX: `IN {}` operator | Internet Exposure (CRITICAL/HIGH) | ★★★☆☆ |
| Data Model: Star schema | Fact table + 2 dimension tables | ★★★★☆ |
| Data Model: Date table | DAX CALENDAR + ADDCOLUMNS | ★★★★☆ |
| Relationships: M:1 + 1:1 | wiz_findings ↔ cmdb ↔ tickets | ★★★☆☆ |
| Conditional formatting | Severity colors, SLA RAG status | ★★★☆☆ |
| Drill-through pages | Executive → Team → Finding Detail | ★★★★☆ |
| Slicers | Cloud, Severity, Category filters | ★★☆☆☆ |

### Power Query (M Language)

| Transformation | Code Pattern | Purpose |
|---------------|-------------|---------|
| Custom column: `Duration.Days()` | `Duration.Days(DateTime.LocalNow() - [created_date])` | Age of finding |
| Conditional column | `if [status] = "Closed" then "Resolved" else if [SLA_Pct_Used] >= 100 then "Breached"` | SLA status bucketing |
| Type conversion | `Change Type → Date`, `Whole Number` | Data integrity |
| Column rename | `Right-click → Rename` | Standardize join keys |
| Fill down | `Transform → Fill → Down` | Fix merged cells |
| Trim | `Transform → Format → Trim` | Remove whitespace |
| Replace values | `Right-click → Replace Values` | Data cleaning |
| Split column | `Transform → Split Column → By Delimiter` | Name splitting |
| Filtered rows | `Click column ▼ → uncheck values` | Remove nulls/zeros |

### Python ETL

| Script | API Type | Authentication | Pagination | Data Volume |
|--------|---------|---------------|-----------|-------------|
| `extract_wiz.py` | GraphQL | OAuth2 (client_credentials) | Cursor-based (500/page) | Thousands of findings |
| `extract_cmdb.py` | SQL SELECT | SQL auth (pyodbc) | N/A (single query) | Thousands of assets |
| `extract_snow.py` | REST Table API | Basic Auth or OAuth2 | Offset-based (10K/page) | Thousands of tickets |
| `run_pipeline.py` | Orchestrator | N/A | N/A | Runs all 3 + logs |

### SQL

| Skill | Where Used |
|-------|-----------|
| DDL: `CREATE TABLE`, `CREATE SCHEMA` | `db_setup.py` — 4 tables |
| DML: `TRUNCATE TABLE` | Full refresh pattern in all extractors |
| Joins: `SELECT ... FROM ... WHERE` | CMDB extraction query |
| Data types: `NVARCHAR`, `DATE`, `INT`, `DATETIME` | Table definitions |
| Constraints: `PRIMARY KEY`, `DEFAULT GETDATE()` | Schema design |
| Index design concept | Discussed in Interview Q&A |

---

# PART 3: DAY-TO-DAY WORKFLOW — Detailed Breakdown

## Daily Workflow (Mon-Fri)

### ⏰ 6:00 AM — Automated Pipeline Runs

```
┌─────────────────────────────────────────────────────────────────┐
│  AUTOMATED (no human intervention)                               │
│                                                                  │
│  6:00 AM → Windows Task Scheduler / Azure Function triggers     │
│            run_pipeline.py (orchestrator)                        │
│                                                                  │
│  6:01 → extract_wiz.py runs:                                    │
│         1. OAuth2 token from Wiz auth endpoint                  │
│         2. GraphQL query → paginate all findings                │
│         3. Transform nested JSON → flat DataFrame               │
│         4. TRUNCATE + INSERT into dashboard.wiz_findings        │
│                                                                  │
│  6:05 → extract_cmdb.py runs:                                   │
│         1. SQL query against CMDB production                    │
│         2. Copy active cloud assets to dashboard.cmdb_assets    │
│                                                                  │
│  6:08 → extract_snow.py runs:                                   │
│         1. REST API call to ServiceNow Table API                │
│         2. Paginate all security tickets                        │
│         3. Map priority/state values → human-readable           │
│         4. Load into dashboard.servicenow_tickets               │
│                                                                  │
│  6:10 → Orchestrator logs results to dashboard.refresh_log      │
│         If any extraction fails → Teams webhook alert fires     │
│                                                                  │
│  7:00 AM → Power BI Service scheduled refresh triggers          │
│            Dashboard pulls fresh data from SQL warehouse        │
│                                                                  │
│  STATUS: Dashboard is FRESH by 7:15 AM daily                    │
└─────────────────────────────────────────────────────────────────┘
```

### ⏰ 8:30 AM — Morning Triage & Review

```
WHAT YOU DO:

1. OPEN Power BI Dashboard → Executive Risk Overview (Page 1)
   → Check Security Score (target: >75, critical if <40)
   → Check SLA Compliance % (target: >85%)
   → Note any NEW Critical findings (compare to yesterday)

2. CHECK Page 2 — SLA & Remediation Operations
   → Identify newly BREACHED tickets (SLA crossed 100%)
   → Identify AT-RISK tickets (SLA at 75-99% — about to breach)
   → Note which assignment_groups have breaches

3. CROSS-REFERENCE with Wiz Console
   → Open Wiz → Issues → filter CRITICAL + Open
   → Verify dashboard numbers match Wiz (data quality check)
   → Check attack paths for any new CRITICAL (graph context)

4. TRIAGE NEW FINDINGS
   → For each new CRITICAL/HIGH finding:
     a. Identify the resource in CMDB → who owns it?
     b. Check if ServiceNow ticket exists → if not, create one
     c. Determine priority: P1 (CRITICAL internet-facing),
        P2 (CRITICAL internal), P3 (HIGH), P4 (MEDIUM/LOW)
     d. Route to correct assignment_group based on CMDB owner
     e. Set SLA target based on severity:
        CRITICAL = 24 hours
        HIGH = 7 days
        MEDIUM = 30 days
        LOW = 90 days

TOOLS USED: Power BI, Wiz Console, ServiceNow, CMDB
TIME: ~45 minutes
```

### ⏰ 9:30 AM — ServiceNow Ticket Management

```
WHAT YOU DO:

1. REVIEW OPEN TICKETS in ServiceNow
   → Filter: Assignment Group = Cloud Security teams
   → Sort by: SLA breach date (soonest first)
   → For BREACHED tickets:
     a. Add work note: "SLA breached — escalating to manager"
     b. Update priority if needed
     c. Send escalation email to team lead

2. CMDB VALIDATION
   → For tickets with missing/wrong owner:
     a. Query CMDB by resource_id
     b. Verify owner, assignment_group, business_unit
     c. Update ticket routing if CMDB shows different owner
     d. Flag any CMDB gaps to the CMDB team

3. PROCESS CHANGE REQUESTS
   → For findings that need infrastructure changes:
     a. Create Change Request (CR) in ServiceNow
     b. Link CR to incident/finding ticket
     c. Add to change_request_id field
     d. Track through CAB approval process

4. BULK UPDATES (when needed)
   → Export ServiceNow data to CSV
   → Use Excel + VLOOKUP/INDEX-MATCH to reconcile
   → Identify bulk updates (e.g., reassign 20 tickets from
     disbanded team to new team)
   → Import updated CSV back to ServiceNow

TOOLS USED: ServiceNow, Excel (VLOOKUP/XLOOKUP), CMDB
TIME: ~60 minutes
```

### ⏰ 10:30 AM — Deduplication & Correlation Analysis

```
WHAT YOU DO:

1. DEDUPLICATION CHECK
   → Export Wiz findings to CSV
   → Cross-reference with existing ServiceNow tickets
   → Identify duplicate findings (same resource + same rule)
   → Close duplicates in Wiz with note "Duplicate of WIZ-XXX"

2. CORRELATION ANALYSIS
   → Look for patterns:
     a. Same resource with multiple findings → "noisy resource"
     b. Same owner with multiple breaches → "overloaded owner"
     c. Same category trending up → "systemic gap"
   → Update Power BI dashboard recommendations (Page 3)

3. EXCEPTION MANAGEMENT
   → Review exception requests from teams
   → Validate: Is this a true exception or a lazy request?
   → If approved: Mark finding as "Exception" in Wiz
     Add expiry date and review cadence
   → If denied: Send explanation with remediation steps
   → Document all exceptions in exceptions tracker

TOOLS USED: Excel (PivotTables, conditional formatting), Wiz, Power BI
TIME: ~45 minutes
```

### ⏰ 11:30 AM — Azure & GCP Misconfiguration Review

```
WHAT YOU DO:

1. REVIEW AZURE FINDINGS
   → NSG/Firewall rules: Any 0.0.0.0/0 inbound rules?
   → IAM: Any users with Owner/Contributor without MFA?
   → Storage: Any Storage Accounts with public blob access?
   → Compute: Any VMs without disk encryption?
   → AKS: Any clusters with privileged pods or legacy ABAC?

2. REVIEW GCP FINDINGS
   → Firewall: Any ingress allow-all rules?
   → IAM: Any Service Accounts with Owner role?
   → Storage: Any GCS buckets without uniform access?
   → GKE: Any pods running as root?
   → KMS: Any keys without rotation?

3. VALIDATE COMPLIANCE CONTROLS
   → Check CIS Azure Benchmark gaps (from Page 3)
   → Check CIS GCP Benchmark gaps
   → Update compliance tracker spreadsheet

TOOLS USED: Wiz Console, Azure Portal, GCP Console, Excel
TIME: ~60 minutes
```

### ⏰ 1:00 PM — Cross-Functional Collaboration

```
WHAT YOU DO:

1. ATTEND / LEAD REMEDIATION MEETINGS
   → Share screen → Power BI Page 2 (Team Performance)
   → Walk through each team's SLA compliance
   → Highlight breached/at-risk findings
   → Assign action items with deadlines

2. CLARIFY OWNERSHIP BOUNDARIES
   → For disputed resources (which team owns it?)
   → Cross-reference CMDB owner vs. Azure/GCP actual tag
   → Update CMDB if tags are more current
   → Email decision to both teams for record

3. TRACK REMEDIATION PROGRESS
   → Update ServiceNow tickets with latest status
   → If team says "fixed" → verify in Wiz (is finding resolved?)
   → If Wiz shows resolved → close ServiceNow ticket
   → If still open → send back to team with evidence

TOOLS USED: Power BI (screen share), ServiceNow, Teams/Outlook
TIME: ~90 minutes
```

### ⏰ 3:00 PM — Documentation & SOPs

```
WHAT YOU DO:

1. UPDATE KB ARTICLES
   → If a new remediation pattern emerged today, document it
   → Format: Problem → Impact → Steps to Fix → Verification
   → File in Confluence/SharePoint KB

2. MAINTAIN REMEDIATION GUIDES
   → Per-category guides (Network, IAM, Storage, Container)
   → Include Azure AND GCP steps
   → Link to CIS benchmark control numbers

3. UPDATE DASHBOARD
   → If new findings category emerged → add to Power BI
   → If DAX measure needs adjustment → update and test
   → If Power Query transformation broke → debug M code
   → Commit changes to version control

TOOLS USED: Confluence/SharePoint, Power BI Desktop, Git
TIME: ~45 minutes
```

### ⏰ 4:00 PM — End-of-Day Wrap-Up

```
1. Check pipeline logs → confirm tomorrow's 6 AM run is scheduled
2. Review any failed refresh alerts from Teams webhook
3. Update personal task tracker (what's pending for tomorrow?)
4. Respond to any Slack/Teams messages from app teams
5. If Friday → prepare weekly summary email for manager
```

---

## Weekly Cadence

| Day | Recurring Activity | Dashboard Page Used |
|-----|-------------------|-------------------|
| **Monday** | Weekly triage of new findings from weekend scans. Prioritize Critical/High | Page 1: Risk Overview |
| **Tuesday** | SLA review meeting with team leads. Review breached tickets | Page 2: SLA Operations |
| **Wednesday** | CMDB validation — verify ownership accuracy on random sample of 20 assets | Page 3: Owner Accountability |
| **Thursday** | Office hours — app teams ask questions, request exceptions, get remediation help | All pages (screen share) |
| **Friday** | Weekly report email to CISO. Update security score trend. Prepare slide for monthly review | Page 1 + exported PDF |

## Monthly Cadence

| Activity | Deliverable |
|---------|------------|
| **CISO Monthly Review** | Present Page 1 (Security Score, risk trend, cloud split). Export PDF snapshot |
| **SLA Performance Report** | Page 2 data → export to Excel → add commentary → email to all team leads |
| **Compliance Status** | Page 3 CIS benchmark gaps → map to remediation plan → track % closure |
| **Dashboard Enhancement** | Review DAX measures, add new KPIs if requested, update Power Query for schema changes |
| **Pipeline Health Check** | Review `refresh_log` table — any failures? Validate row counts against source systems |

---

# PART 4: PROFESSIONAL SUMMARY

## Interview-Ready Professional Summary

### Version 1 — For Resume / LinkedIn (3 sentences)

> Cloud Security Analyst with hands-on experience managing security findings and compliance
> across Azure and GCP using Wiz (CSPM/CWPP), ServiceNow, and CMDB platforms. I build
> automated data pipelines (Python, SQL, Power Query) that connect Wiz findings with CMDB
> ownership data and ServiceNow ticket SLA tracking, refreshing daily into Power BI
> dashboards with 20+ DAX measures for executive reporting. My end-to-end workflow covers
> triage and remediation routing, SLA governance with cross-functional team engagement,
> CIS benchmark compliance tracking, and data-driven posture improvement presented monthly
> to CISO-level leadership.

### Version 2 — For Interview Self-Introduction (60 seconds)

> "In my current role, I manage end-to-end cloud security findings across Azure and GCP
> environments. My day starts with an automated pipeline I built — Python scripts pull
> data from the Wiz API, our SQL CMDB, and ServiceNow at 6 AM daily, and Power BI
> refreshes at 7 AM so the dashboard is fresh before I even sit down.
>
> I triage new findings by severity — CRITICALs get a 24-hour SLA with P1 tickets,
> HIGHs get 7 days — and I route them to the correct assignment group using CMDB ownership
> data. I track everything through ServiceNow, validate CMDB accuracy, and handle
> exceptions with documented expiry dates.
>
> On the analytics side, I built a 3-page Power BI dashboard with 20+ DAX measures —
> Security Score, SLA Compliance Rate, MTTR by severity, and an Owner Accountability
> Matrix. I present this monthly to our CISO and run weekly office hours where app teams
> get remediation guidance.
>
> I also maintain the SOPs and remediation guides — per-category playbooks for network,
> IAM, storage, and container misconfigurations across both Azure and GCP."

### Version 3 — For Cover Letter Opening Paragraph

> I am a Cloud Security Analyst with a proven track record of building automated
> security reporting pipelines and managing findings remediation across multi-cloud
> environments. In my current role, I designed and maintain a Python-based ETL pipeline
> that connects Wiz CSPM/CWPP findings with ServiceNow SLA tracking and SQL CMDB
> ownership data, feeding a 3-page Power BI executive dashboard that reduced our SLA
> breach rate by enabling proactive escalation. I collaborate daily with SecOps, Platform
> Engineering, and Application teams to ensure accurate triage, timely remediation, and
> audit-ready compliance documentation.

---

# PART 5: INTERVIEW Q&A — Role-Specific

### Q1: "Walk me through how you manage security findings day-to-day."

> **A:** "My workflow starts before I arrive — I have an automated Python pipeline that
> runs at 6 AM, pulling findings from Wiz via GraphQL API, enriching them with CMDB
> ownership data from our SQL database, and pulling ServiceNow ticket status via REST API.
> All of this lands in a SQL warehouse, and Power BI does a scheduled refresh at 7 AM.
>
> When I sit down, I open the dashboard and immediately see the Security Score, open
> CRITICALs, and SLA compliance rate. If there's a new CRITICAL, I triage it immediately —
> I look up the resource in CMDB to find the owner, create a P1 ServiceNow ticket with a
> 24-hour SLA, and route it to the correct assignment group. For findings approaching SLA
> breach (75%+ of SLA consumed), I proactively escalate via email to the team lead.
>
> Through the day, I validate CMDB accuracy, process exception requests, run deduplication
> checks, and lead remediation meetings where I screen-share the dashboard to show teams
> their specific SLA performance. At the end of the week, I send a summary to the CISO."

### Q2: "How do you build and maintain your Power BI dashboards?"

> **A:** "I follow a structured approach. First, I design the data model — I have a fact
> table (wiz_findings) connected to two dimension tables (cmdb_assets and servicenow_tickets)
> via Many-to-One and One-to-One relationships. I also create a DAX date table for time
> intelligence.
>
> For the ETL layer, I use Power Query's M language to add calculated columns — things like
> `Age_Days` (how long a finding has been open), `SLA_Status` (Breached/At-Risk/On-Track),
> and `Severity_Order` (for proper sorting). Each transformation is a recorded step, so
> when the data refreshes, Power Query replays all steps automatically.
>
> For analytics, I use DAX measures — `CALCULATE` with multiple filter contexts for severity
> breakdowns, `AVERAGEX` with `FILTER` for MTTR calculations, `DATESMTD` and `DATEADD` for
> month-over-month trend analysis, and a custom `Security Score` formula that starts at 100
> and deducts points weighted by severity. I have 20+ measures in a dedicated Measures table.
>
> The dashboard has 3 pages: Executive Risk Overview for the CISO, SLA & Remediation
> Operations for weekly team meetings, and Posture Improvement for compliance tracking.
> I use conditional formatting (RAG colors), drill-through navigation, and slicers for
> cloud provider, severity, and category filtering."

### Q3: "How do you handle data quality issues — duplicates, missing owners, stale CMDB records?"

> **A:** "Data quality is one of my daily responsibilities. For deduplication, I export Wiz
> findings and cross-reference with ServiceNow tickets using Excel INDEX-MATCH on the
> `resource_id` field. If I find duplicate findings for the same resource and same rule,
> I close the duplicate in Wiz with a note referencing the original.
>
> For missing owners, my dashboard has an Owner Accountability Matrix on Page 3 — any
> finding without a CMDB owner shows up with 'Unassigned' in the matrix. I flag these
> weekly to the CMDB team for verification. When I find mismatches between CMDB owner and
> Azure/GCP resource tags, I update CMDB and email both the old and new owners.
>
> For stale CMDB records, I do a random sample of 20 assets every Wednesday — I check if
> the `cloud_resource_id` in CMDB actually exists in Azure/GCP. If the resource has been
> decommissioned but CMDB still shows it as Active, I submit a CMDB update request and
> verify it's processed. My pipeline only pulls Active assets, so once CMDB is updated,
> the dashboard automatically reflects the change on the next refresh."

### Q4: "Describe your experience with ServiceNow workflow management."

> **A:** "I use ServiceNow for the entire remediation lifecycle. When a new finding comes
> in from Wiz, I create an incident ticket with the correct priority (P1-P4 based on
> severity), route it to the assignment group based on CMDB ownership, and set the SLA
> target date based on our severity-specific SLA policy.
>
> I validate ticket routing by checking CMDB — if ServiceNow has a different assignment
> group than what CMDB shows, I correct it. For findings that require infrastructure
> changes, I create linked Change Requests (CRs) through the CAB process and track the
> `change_request_id` in the incident ticket.
>
> For bulk operations — like when a team reorganizes and 30 tickets need reassignment — I
> export from ServiceNow, use Excel XLOOKUP to map old assignment groups to new ones, and
> import the CSV back. My Power BI dashboard tracks all of this through SLA compliance
> metrics: if a team's SLA drops below 70%, it shows up red on the Team Performance page,
> and I escalate in our weekly remediation meeting."

### Q5: "How do you present security posture to leadership?"

> **A:** "I present a monthly executive dashboard to the CISO. The first page opens with
> the Security Score — a single 0-100 number that weights open findings by severity. Last
> month we were at 37, which I flagged as unacceptable for a financial institution.
>
> I walk through the trend — are we getting better or worse? I show Critical findings
> count, SLA compliance rate (we were at 48%, target is 85%+), and internet-facing
> exposure. Then I switch to the SLA page to highlight which teams are behind, and why.
>
> The third page has my improvement recommendations — I identify the top 5 actions that
> would have the highest impact on the Security Score. For example, 'Closing the 8 open
> CRITICALs would improve our score from 37 to 69.' This gives leadership concrete,
> measurable action items rather than vague statements.
>
> Everything is interactive — the CISO can click slicers to filter by Azure vs GCP,
> or drill-through from a team's bar chart to see their specific findings. I export a
> PDF snapshot for the board report and share the live dashboard link with the CISO's
> direct reports."$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$SQL_Masterclass_Part1_Foundations$VELSEC$, $VELSEC$Sql Masterclass Part1 Foundations$VELSEC$, $VELSEC$Data Analyst$VELSEC$, ARRAY['Data_Analytics']::TEXT[], $VELSEC$# SQL Masterclass: From Beginner to Expert
## Real-World SOC Database System (Practical, Hands-On)

**Experience Level:** Senior Data Engineer / Database Architect  
**Teaching Style:** Zero Theory, 100% Practical Application  
**Real-world Context:** Security Operations Center (SOC) System  

---

## PART 0: DATABASE DESIGN & SETUP

### Our Playground: A Security Operations Center (SOC) Database

You work at Wells Fargo's Security Operations Center. Your database tracks:
- **Users:** Employees, contractors, external admins
- **Devices:** Company laptops, servers, mobile devices
- **IPs:** Internal IPs, external IPs, VPN addresses
- **Logs:** Authentication attempts, network flows, system events
- **Alerts:** Security alerts triggered by SIEM
- **Incidents:** Formal security incidents created from alerts
- **Vulnerabilities:** CVEs discovered and their remediation status

This is how **real SOC systems work**—you query this data 100 times per day to investigate threats.

---

### Database Schema (Production-Grade)

```sql
-- Create database
CREATE DATABASE IF NOT EXISTS soc_db;
USE soc_db;

-- Table 1: Users (employees, contractors)
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department VARCHAR(50),           -- Finance, IT, Sales, etc.
    role VARCHAR(50),                  -- Employee, Contractor, Admin
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    risk_score INT DEFAULT 0           -- 0-100, higher = more suspicious
);

-- Table 2: Devices (laptops, servers, mobile)
CREATE TABLE devices (
    device_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    device_name VARCHAR(100),          -- LAPTOP-JOHN, SERVER-01, etc.
    device_type VARCHAR(50),           -- Laptop, Server, Mobile
    os VARCHAR(50),                    -- Windows, Linux, macOS, iOS
    os_version VARCHAR(50),
    antivirus_installed BOOLEAN,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_compromised BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Table 3: IP Addresses (internal & external)
CREATE TABLE ip_addresses (
    ip_id INT PRIMARY KEY AUTO_INCREMENT,
    ip_address VARCHAR(15) UNIQUE NOT NULL,
    is_internal BOOLEAN,              -- TRUE = company network, FALSE = external
    location VARCHAR(100),            -- City, country
    organization VARCHAR(100),        -- ISP or company name
    threat_level VARCHAR(20),         -- Low, Medium, High, Critical
    last_seen TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table 4: Authentication Logs (login attempts, VPN connections)
CREATE TABLE auth_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    ip_id INT NOT NULL,
    device_id INT NULL,
    auth_type VARCHAR(50),            -- Password, MFA, Certificate, SSO
    auth_status VARCHAR(20),          -- Success, Failed, MFA_Denied
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    session_duration_minutes INT NULL, -- How long user stayed logged in
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (ip_id) REFERENCES ip_addresses(ip_id),
    FOREIGN KEY (device_id) REFERENCES devices(device_id)
);

-- Table 5: Alerts (triggered by SIEM rules)
CREATE TABLE alerts (
    alert_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NULL,
    ip_id INT NULL,
    alert_type VARCHAR(100),          -- Brute Force, Malware, Data Exfiltration, etc.
    alert_severity VARCHAR(20),       -- Low, Medium, High, Critical
    description TEXT,
    is_resolved BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolved_at TIMESTAMP NULL,
    resolution_notes TEXT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (ip_id) REFERENCES ip_addresses(ip_id)
);

-- Table 6: Incidents (formal security incidents)
CREATE TABLE incidents (
    incident_id INT PRIMARY KEY AUTO_INCREMENT,
    incident_name VARCHAR(100),
    severity VARCHAR(20),             -- Low, Medium, High, Critical
    status VARCHAR(50),               -- Open, In Progress, Resolved, Closed
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolved_at TIMESTAMP NULL,
    description TEXT,
    num_users_affected INT DEFAULT 0,
    data_lost BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (incident_id) REFERENCES incidents(incident_id)
);

-- Table 7: Incident-Alert Mapping (many alerts can relate to 1 incident)
CREATE TABLE incident_alerts (
    incident_id INT NOT NULL,
    alert_id INT NOT NULL,
    PRIMARY KEY (incident_id, alert_id),
    FOREIGN KEY (incident_id) REFERENCES incidents(incident_id),
    FOREIGN KEY (alert_id) REFERENCES alerts(alert_id)
);

-- Table 8: Vulnerabilities (CVEs, tracked remediation)
CREATE TABLE vulnerabilities (
    vuln_id INT PRIMARY KEY AUTO_INCREMENT,
    cve_id VARCHAR(20) UNIQUE,        -- CVE-2023-1234
    severity VARCHAR(20),            -- Low, Medium, High, Critical
    affected_systems INT,            -- How many systems have this CVE?
    is_patched BOOLEAN DEFAULT FALSE,
    discovered_date TIMESTAMP,
    patch_deadline TIMESTAMP,
    patch_date TIMESTAMP NULL,
    CVSS_score DECIMAL(3, 1)         -- 0.0 - 10.0
);

-- Table 9: Network Flows (connection data)
CREATE TABLE network_flows (
    flow_id INT PRIMARY KEY AUTO_INCREMENT,
    source_ip_id INT NOT NULL,
    dest_ip_id INT NOT NULL,
    protocol VARCHAR(20),            -- TCP, UDP, ICMP
    source_port INT,
    dest_port INT,
    bytes_sent BIGINT,               -- Data transferred
    bytes_received BIGINT,
    flow_start TIMESTAMP,
    flow_end TIMESTAMP,
    is_suspicious BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (source_ip_id) REFERENCES ip_addresses(ip_id),
    FOREIGN KEY (dest_ip_id) REFERENCES ip_addresses(ip_id)
);
```

---

### Sample Data (Realistic SOC Dataset)

```sql
-- Insert 5 employees
INSERT INTO users (username, email, department, role, is_active, risk_score) VALUES
('john_smith', 'john.smith@wf.com', 'Finance', 'Employee', TRUE, 5),
('sarah_jones', 'sarah.jones@wf.com', 'IT', 'Admin', TRUE, 10),
('mike_chen', 'mike.chen@wf.com', 'Sales', 'Employee', TRUE, 15),
('alex_contractor', 'alex@external.com', 'Consulting', 'Contractor', TRUE, 45),
('admin_user', 'admin@wf.com', 'IT', 'Admin', TRUE, 8);

-- Insert devices
INSERT INTO devices (user_id, device_name, device_type, os, os_version, antivirus_installed, is_compromised) VALUES
(1, 'LAPTOP-JOHN', 'Laptop', 'Windows', '11', TRUE, FALSE),
(1, 'PHONE-JOHN', 'Mobile', 'iOS', '17.3', TRUE, FALSE),
(2, 'SERVER-AD', 'Server', 'Windows', 'Server 2022', TRUE, FALSE),
(3, 'LAPTOP-MIKE', 'Laptop', 'Windows', '11', FALSE, FALSE),  -- No AV!
(4, 'LAPTOP-ALEX', 'Laptop', 'macOS', 'Sonoma', TRUE, FALSE),
(5, 'SERVER-PROD', 'Server', 'Linux', 'Ubuntu 22.04', TRUE, FALSE);

-- Insert IP addresses
INSERT INTO ip_addresses (ip_address, is_internal, location, organization, threat_level, last_seen) VALUES
('10.0.1.10', TRUE, 'HQ-Floor1', 'Wells Fargo Internal', 'Low', NOW()),
('10.0.2.50', TRUE, 'HQ-Floor2', 'Wells Fargo Internal', 'Low', NOW()),
('10.0.3.100', TRUE, 'DataCenter', 'Wells Fargo Internal', 'Low', NOW()),
('192.168.1.1', TRUE, 'VPN-Gateway', 'Wells Fargo VPN', 'Low', NOW()),
('203.45.67.89', FALSE, 'Moscow', 'Unknown ISP', 'Critical', NOW()),  -- Suspicious!
('8.8.8.8', FALSE, 'USA', 'Google DNS', 'Low', NOW()),
('45.142.212.15', FALSE, 'Romania', 'DataCenter Pro', 'High', NOW());  -- Threat IP

-- Insert authentication logs (realistic scenarios)
INSERT INTO auth_logs (user_id, ip_id, device_id, auth_type, auth_status, session_duration_minutes) VALUES
(1, 1, 1, 'Password+MFA', 'Success', 480),      -- 8 hours, normal
(1, 1, 1, 'Password+MFA', 'Success', 380),      -- Next day
(3, 2, 4, 'Password', 'Success', 60),           -- Mike, shorter session
(3, 2, 4, 'Password', 'Failed', NULL),          -- Failed attempt
(3, 2, 4, 'Password', 'Failed', NULL),          -- Another failed attempt
(3, 2, 4, 'Password', 'Failed', NULL),          -- And another
(4, 3, 5, 'Certificate', 'Success', 120),       -- Contractor VPN
(1, 5, 1, 'Password', 'Failed', NULL),          -- John's IP from critical threat IP?
(1, 5, 1, 'Password', 'Failed', NULL),          -- Brute force alert!
(2, 1, 2, 'SSO', 'Success', 600),               -- Admin login, long session
(5, 3, 6, 'Certificate', 'Success', 1440);     -- Prod admin, all day

-- Insert alerts (triggered by SIEM rules)
INSERT INTO alerts (user_id, ip_id, alert_type, alert_severity, description, is_resolved) VALUES
(3, 2, 'Brute Force', 'High', 'User mike_chen had 3 failed login attempts in 5 min', FALSE),
(1, 5, 'Impossible Travel', 'Critical', 'User john_smith login from critical threat IP (Moscow)', FALSE),
(NULL, 7, 'Malware IP Communication', 'Critical', 'Detected connection to known malware IP 45.142.212.15', FALSE),
(3, 2, 'Anomalous Behavior', 'Medium', 'User accessing more files than usual', TRUE),
(4, 3, 'VPN Anomaly', 'High', 'Contractor accessed restricted database via VPN', FALSE),
(2, 1, 'Admin Access', 'Low', 'Admin user_id=2 accessed security logs', TRUE);

-- Insert incidents
INSERT INTO incidents (incident_name, severity, status, num_users_affected, data_lost) VALUES
('Brute Force Attack on Sales Department', 'High', 'In Progress', 1, FALSE),
('Possible Account Compromise - Finance', 'Critical', 'Open', 1, FALSE),
('Malware Detection Network Segment', 'Critical', 'Open', 3, TRUE),
('Unauthorized VPN Access', 'High', 'Resolved', 1, FALSE);

-- Map alerts to incidents
INSERT INTO incident_alerts (incident_id, alert_id) VALUES
(1, 1),  -- Brute force alert → incident 1
(2, 2),  -- Impossible travel → incident 2
(3, 3),  -- Malware → incident 3
(4, 5);  -- VPN anomaly → incident 4

-- Insert vulnerabilities
INSERT INTO vulnerabilities (cve_id, severity, affected_systems, discovered_date, patch_deadline, CVSS_score) VALUES
('CVE-2023-44487', 'Critical', 50, '2023-10-01', '2023-10-15', 10.0),
('CVE-2024-1234', 'High', 120, '2024-01-10', '2024-02-10', 8.5),
('CVE-2024-5678', 'Medium', 30, '2024-02-01', '2024-03-15', 6.2),
('CVE-2024-9999', 'Low', 5, '2024-03-01', '2024-04-01', 3.5);

-- Add a few patches
UPDATE vulnerabilities SET is_patched = TRUE, patch_date = '2023-10-14' WHERE cve_id = 'CVE-2023-44487';
UPDATE vulnerabilities SET is_patched = TRUE, patch_date = '2024-02-08' WHERE cve_id = 'CVE-2024-1234';

-- Insert network flows
INSERT INTO network_flows (source_ip_id, dest_ip_id, protocol, source_port, dest_port, bytes_sent, bytes_received, flow_start, flow_end, is_suspicious) VALUES
(1, 3, 'TCP', 54321, 443, 1024, 2048, NOW() - INTERVAL 2 HOUR, NOW() - INTERVAL 1 HOUR, FALSE),
(2, 3, 'TCP', 54322, 3306, 512, 50000, NOW() - INTERVAL 1 HOUR, NOW() - INTERVAL 50 MINUTE, TRUE),  -- Large data transfer
(1, 6, 'TCP', 54323, 53, 256, 256, NOW() - INTERVAL 30 MINUTE, NOW() - INTERVAL 25 MINUTE, FALSE),
(5, 3, 'TCP', 54324, 22, 128, 1024, NOW() - INTERVAL 15 MINUTE, NOW() - INTERVAL 10 MINUTE, TRUE); -- Suspicious SSH
```

---

### Verify Your Setup

Run this to confirm everything is created:

```sql
-- Show all tables
SHOW TABLES;

-- Count rows in each table
SELECT 'users' as table_name, COUNT(*) as count FROM users
UNION ALL
SELECT 'devices', COUNT(*) FROM devices
UNION ALL
SELECT 'ip_addresses', COUNT(*) FROM ip_addresses
UNION ALL
SELECT 'auth_logs', COUNT(*) FROM auth_logs
UNION ALL
SELECT 'alerts', COUNT(*) FROM alerts
UNION ALL
SELECT 'incidents', COUNT(*) FROM incidents
UNION ALL
SELECT 'vulnerabilities', COUNT(*) FROM vulnerabilities
UNION ALL
SELECT 'network_flows', COUNT(*) FROM network_flows;
```

**Expected output:**
```
users: 5
devices: 6
ip_addresses: 7
auth_logs: 11
alerts: 6
incidents: 4
vulnerabilities: 4
network_flows: 4
```

---

---

## PHASE 1: FOUNDATIONS
### SELECT, WHERE, ORDER BY, LIMIT, INSERT, UPDATE, DELETE

---

### 1.1 SELECT Basics

**What it is:** Retrieve data from a table.

**Why it's used:** This is 80% of what you'll do in production. You read WAY more often than you write.

**How it works internally:**
1. Database scans the table (or index, for optimization).
2. Finds matching rows based on conditions (if any).
3. Returns columns you asked for.
4. If very large, returns in chunks to avoid memory overload.

**Syntax:**
```sql
SELECT column1, column2, ... FROM table_name;
SELECT * FROM table_name;  -- All columns
```

---

### **Real-World Scenario:** Your SOC manager asks: "Who are our users?"

```sql
-- Get all users with their details
SELECT user_id, username, email, department, role, risk_score 
FROM users;

-- Result:
-- user_id | username        | email                  | department | role       | risk_score
-- 1       | john_smith      | john.smith@wf.com      | Finance    | Employee   | 5
-- 2       | sarah_jones     | sarah.jones@wf.com     | IT         | Admin      | 10
-- 3       | mike_chen       | mike.chen@wf.com       | Sales      | Employee   | 15
-- 4       | alex_contractor | alex@external.com      | Consulting | Contractor | 45
-- 5       | admin_user      | admin@wf.com           | IT         | Admin      | 8
```

---

### **Hands-On Examples:**

```sql
-- 1. Get usernames and emails only (subset of columns)
SELECT username, email FROM users;

-- 2. Get all device information
SELECT * FROM devices;

-- 3. Get IP addresses (external only)
SELECT ip_address, location, organization FROM ip_addresses;

-- 4. Check all alerts in the system
SELECT alert_id, alert_type, alert_severity, description FROM alerts;
```

---

### **Common Mistakes:**

❌ **Mistake 1:** Selecting too much data unnecessarily
```sql
-- BAD: Always returning 1000s of rows
SELECT * FROM network_flows;  -- What if you have 1M flows?
```

✅ **GOOD:** Be specific
```sql
SELECT flow_id, source_ip_id, dest_ip_id, is_suspicious FROM network_flows WHERE is_suspicious = TRUE;
```

❌ **Mistake 2:** Forgetting table names in ambiguous queries
```sql
-- Will fail if multiple tables have 'user_id'
SELECT user_id FROM devices, auth_logs;
```

✅ **GOOD:** Specify the table
```sql
SELECT devices.device_id, devices.user_id FROM devices;
```

---

### **Performance Considerations:**

- **Columns matter:** `SELECT *` is lazy. In production, always specify columns you need.
  - If you have 50 columns but only need 3, selecting * loads 50 into memory.
  - Explicit columns = less I/O = faster query.

- **Later, we'll add indexes** to make SELECT fast (Phase 3).

---

### **Interview Questions:**

**Q1:** What's the difference between `SELECT *` and `SELECT column1, column2`?  
**A:** SELECT * returns all columns; slower if you don't need all data. SELECT specific columns = faster.

**Q2:** If you have a table with 100M rows and run `SELECT * FROM table`, what happens?  
**A:** The database returns rows in chunks (depends on fetch size, default ~1000), but loading all 100M rows into memory is bad practice. You'd use LIMIT or WHERE to reduce results.

---

### **Practice Task 1:**

```
Task: Write a query to get the username and risk_score for all users.
Expected output: 5 rows with username and risk_score columns
```

**Solution:**
```sql
SELECT username, risk_score FROM users;
```

---

---

### 1.2 WHERE Clause (Filtering)

**What it is:** Filter rows based on conditions.

**Why it's used:** 99% of queries have WHERE. You rarely want ALL data.

**How it works internally:**
1. Database reads table (or index).
2. For each row, evaluates the condition (e.g., `department = 'Finance'`).
3. Includes only rows where condition = TRUE.
4. Returns filtered results.

**Syntax:**
```sql
SELECT columns FROM table WHERE condition;

-- Conditions:
-- = (equal), != or <> (not equal)
-- > (greater), < (less), >= (greater equal), <= (less equal)
-- AND, OR, NOT
-- IN, NOT IN
-- BETWEEN, NOT BETWEEN
-- IS NULL, IS NOT NULL
-- LIKE (pattern matching)
```

---

### **Real-World Scenario:** "Show me all failed login attempts."

```sql
SELECT log_id, user_id, ip_id, auth_type, auth_status, timestamp
FROM auth_logs
WHERE auth_status = 'Failed';

-- Result:
-- log_id | user_id | ip_id | auth_type      | auth_status | timestamp
-- 4      | 3       | 2     | Password       | Failed      | 2024-03-28 10:15:00
-- 5      | 3       | 2     | Password       | Failed      | 2024-03-28 10:16:00
-- 6      | 3       | 2     | Password       | Failed      | 2024-03-28 10:17:00
-- 8      | 1       | 5     | Password       | Failed      | 2024-03-28 11:00:00
-- 9      | 1       | 5     | Password       | Failed      | 2024-03-28 11:01:00
```

**Action:** This looks like a brute force attack! Both user 3 and user 1 had multiple failed attempts. Alert on this.

---

### **Hands-On Examples:**

```sql
-- 1. Find all Critical threat IPs
SELECT ip_address, location, threat_level FROM ip_addresses WHERE threat_level = 'Critical';

-- 2. Find devices without antivirus
SELECT device_id, user_id, device_name FROM devices WHERE antivirus_installed = FALSE;

-- 3. Find admins
SELECT username, email, role FROM users WHERE role = 'Admin';

-- 4. Find active users
SELECT username, department FROM users WHERE is_active = TRUE;

-- 5. Find unresolved alerts
SELECT alert_id, alert_type, alert_severity FROM alerts WHERE is_resolved = FALSE;

-- 6. Find incidents that resulted in data loss
SELECT incident_id, incident_name, severity FROM incidents WHERE data_lost = TRUE;

-- 7. Find Critical or High severity vulnerabilities
SELECT cve_id, severity, CVSS_score FROM vulnerabilities 
WHERE severity = 'Critical' OR severity = 'High';

-- 8. Combined: Find Critical alerts that are unresolved
SELECT alert_id, alert_type, description FROM alerts 
WHERE alert_severity = 'Critical' AND is_resolved = FALSE;

-- 9. Find users NOT in IT department
SELECT username, department FROM users WHERE department != 'IT';

-- 10. Find suspicious network flows
SELECT flow_id, source_ip_id, dest_ip_id FROM network_flows WHERE is_suspicious = TRUE;
```

---

### **Advanced WHERE (Operators):**

```sql
-- IN: Check multiple values
SELECT username FROM users WHERE role IN ('Admin', 'Employee');  -- 4 rows

-- BETWEEN: Range check
SELECT * FROM auth_logs WHERE session_duration_minutes BETWEEN 100 AND 500;

-- LIKE: Pattern matching
SELECT username FROM users WHERE username LIKE '%contractor%';  -- alex_contractor

-- IS NULL: Check for missing values
SELECT device_id FROM devices WHERE is_compromised IS NULL;  -- None in our data

-- Combine multiple conditions
SELECT username, risk_score FROM users 
WHERE department = 'IT' AND is_active = TRUE AND risk_score > 7;
-- Result: sarah_jones (risk=10), admin_user (risk=8)
```

---

### **Common Mistakes:**

❌ **Mistake 1:** String comparisons are case-sensitive (in most databases)
```sql
-- This might return nothing if data is stored differently
SELECT * FROM users WHERE department = 'finance';  -- Case matters!
```

✅ **GOOD:** Use LOWER() or UPPER() if unsure
```sql
SELECT * FROM users WHERE LOWER(department) = 'finance';
```

❌ **Mistake 2:** NULL comparisons with `=`
```sql
-- This returns NOTHING (NULL != anything, including NULL)
SELECT * FROM devices WHERE is_compromised = NULL;
```

✅ **GOOD:** Use IS NULL
```sql
SELECT * FROM devices WHERE is_compromised IS NULL;
```

❌ **Mistake 3:** Logic error (AND vs OR)
```sql
-- BAD: Finds users who are BOTH admin AND employee (impossible)
SELECT * FROM users WHERE role = 'Admin' AND role = 'Employee';  -- 0 rows
```

✅ **GOOD:** Use OR if you want either
```sql
SELECT * FROM users WHERE role = 'Admin' OR role = 'Employee';  -- 4 rows
```

---

### **Interview Questions:**

**Q1:** What's the difference between `= NULL` and `IS NULL`?  
**A:** In SQL, `= NULL` always returns NULL (never TRUE). Use `IS NULL` to check for missing values. This is because NULL represents "unknown," so "unknown = something" is also unknown.

**Q2:** If you have 10M rows and need to filter to 100 rows, is WHERE slow?  
**A:** Not if there's an index on the filtered column. We'll cover indexes in Phase 3. Without index, yes, it scans all 10M rows.

---

### **Practice Task 2:**

```
Task 1: Get all contractors (role = 'Contractor')
Expected: 1 row (alex_contractor)

Task 2: Get all users with risk_score > 10
Expected: 2 rows (mike_chen, alex_contractor)

Task 3: Get all failed authentications from user_id = 3
Expected: 3 rows
```

**Solutions:**
```sql
-- Task 1
SELECT username, email FROM users WHERE role = 'Contractor';

-- Task 2
SELECT username, risk_score FROM users WHERE risk_score > 10;

-- Task 3
SELECT log_id, auth_status FROM auth_logs WHERE user_id = 3 AND auth_status = 'Failed';
```

---

---

### 1.3 ORDER BY (Sorting)

**What it is:** Sort results in ascending (ASC) or descending (DESC) order.

**Why it's used:** Reports need to be sorted (highest risk first, oldest alerts first, etc.).

**How it works internally:**
1. Database executes WHERE to get matching rows.
2. Loads them into memory and uses a sorting algorithm (QuickSort, MergeSort).
3. Returns sorted results.
4. **Performance note:** Large sorts can be slow; databases try to avoid disk-based sorts.

**Syntax:**
```sql
SELECT columns FROM table 
ORDER BY column1 ASC, column2 DESC;  -- Can sort by multiple columns
-- ASC = ascending (default), DESC = descending
```

---

### **Real-World Scenario:** "Show me users sorted by risk score (highest first)."

```sql
SELECT username, department, risk_score FROM users 
ORDER BY risk_score DESC;

-- Result:
-- username        | department  | risk_score
-- alex_contractor | Consulting  | 45         <- Highest risk
-- mike_chen       | Sales       | 15
-- sarah_jones     | IT          | 10
-- admin_user      | IT          | 8
-- john_smith      | Finance     | 5          <- Lowest risk
```

**Action:** Contractor has highest risk score. Investigate why.

---

### **Hands-On Examples:**

```sql
-- 1. Get incidents sorted by severity (Critical first)
SELECT incident_name, severity FROM incidents 
ORDER BY severity DESC;  -- Critical, High, Medium, Low

-- 2. Get oldest unresolved alerts
SELECT alert_id, alert_type, created_at FROM alerts 
WHERE is_resolved = FALSE
ORDER BY created_at ASC;

-- 3. Get devices by user, then by device type
SELECT user_id, device_name, device_type FROM devices 
ORDER BY user_id ASC, device_type DESC;

-- 4. Get vulnerabilities sorted by CVSS (highest risk first)
SELECT cve_id, severity, CVSS_score FROM vulnerabilities 
ORDER BY CVSS_score DESC;

-- 5. Get authentication logs sorted by timestamp (newest first)
SELECT user_id, auth_status, timestamp FROM auth_logs 
ORDER BY timestamp DESC;
LIMIT 5;  -- Show only the 5 most recent (we'll cover LIMIT next)
```

---

### **Multiple Sort Columns (Priority sorting):**

```sql
-- Sort by severity first (Critical, High, Medium, Low)
-- Then by created_at (oldest first)
SELECT alert_id, alert_type, alert_severity, created_at FROM alerts
ORDER BY alert_severity DESC, created_at ASC;

-- Result (if we had more data):
-- alert_id | alert_type                | alert_severity | created_at
-- 2        | Impossible Travel         | Critical       | 2024-03-28 08:00:00
-- 3        | Malware IP Communication  | Critical       | 2024-03-28 09:00:00
-- 1        | Brute Force               | High           | 2024-03-28 10:00:00
-- 5        | VPN Anomaly               | High           | 2024-03-28 11:00:00
```

---

### **Performance Considerations:**

- **Sorting is expensive:** Sorting 1M rows takes time & memory. Minimize sorts on large tables.
- **Sort on indexed columns when possible:** If you sort frequently on a column, add an index (Phase 3).
- **Limit sorts:** Use LIMIT (next) to reduce rows before sorting.
  ```sql
  -- Instead of sorting all 1M rows then limiting:
  SELECT * FROM big_table ORDER BY created_at DESC LIMIT 10;
  
  -- Database can be smart: stop after finding 10 rows.
  ```

---

### **Interview Questions:**

**Q1:** Which is faster: `ORDER BY column1` then `ORDER BY column1, column2`, assuming column1 has index?  
**A:** If column1 is indexed, sorting by just column1 is faster. Adding column2 requires full sort (can't use index fully).

**Q2:** What happens if you `ORDER BY` a column that's not in SELECT?  
**A:** It's allowed. The database fetches the column, sorts by it, but doesn't return it. The SELECT determines what's shown, ORDER BY is applied before SELECT.

---

### **Practice Task 3:**

```
Task 1: Get all users sorted by department alphabetically
Expected: Alphabetical order by department

Task 2: Get unresolved alerts sorted by severity (Critical first)
Expected: 4 unresolved alerts, sorted by severity and then by creation date

Task 3: Get vulnerabilities sorted by CVSS score (highest first)
Expected: 4 vulnerabilities, highest CVSS first
```

**Solutions:**
```sql
-- Task 1
SELECT username, department FROM users ORDER BY department ASC;

-- Task 2
SELECT alert_id, alert_type, alert_severity FROM alerts 
WHERE is_resolved = FALSE
ORDER BY alert_severity DESC, created_at ASC;

-- Task 3
SELECT cve_id, CVSS_score FROM vulnerabilities ORDER BY CVSS_score DESC;
```

---

---

### 1.4 LIMIT (Pagination & Limiting Results)

**What it is:** Limit number of rows returned.

**Why it's used:** 
- Pagination (show 10 results per page).
- Performance (don't load 1M rows when you only need 10).
- Sampling (get first N rows for preview).

**How it works internally:**
1. Database executes SELECT with WHERE and ORDER BY.
2. Returns only the first N rows (specified in LIMIT).
3. In optimized databases, can stop processing after reaching limit.

**Syntax:**
```sql
SELECT columns FROM table LIMIT count;          -- First N rows
SELECT columns FROM table LIMIT offset, count;  -- Skip offset rows, then return count rows
-- MySQL: LIMIT offset, count
-- PostgreSQL: LIMIT count OFFSET offset (same result, different syntax)
```

---

### **Real-World Scenario:** "Show me the 5 newest alerts."

```sql
SELECT alert_id, alert_type, alert_severity, created_at FROM alerts 
ORDER BY created_at DESC
LIMIT 5;

-- Result:
-- alert_id | alert_type                | alert_severity | created_at
-- 5        | VPN Anomaly               | High           | <newest>
-- 3        | Malware IP Communication  | Critical       | 
-- 2        | Impossible Travel         | Critical       |
-- 1        | Brute Force               | High           |
-- 4        | Anomalous Behavior        | Medium         | <5th newest>
```

**Action:** Show recent alerts to the SOC team on the dashboard.

---

### **Hands-On Examples:**

```sql
-- 1. Get top 3 highest risk users
SELECT username, risk_score FROM users 
ORDER BY risk_score DESC 
LIMIT 3;

-- 2. Pagination: Show 10 results per page
-- Page 1 (results 1-10)
SELECT * FROM auth_logs ORDER BY timestamp DESC LIMIT 10;

-- Page 2 (results 11-20)
SELECT * FROM auth_logs ORDER BY timestamp DESC LIMIT 10 OFFSET 10;

-- Page 3 (results 21-30)
SELECT * FROM auth_logs ORDER BY timestamp DESC LIMIT 20, 10;  -- Same as LIMIT 10 OFFSET 20

-- 3. Get first device for each user (using LIMIT per user - we'll do this properly later with GROUP BY)
SELECT device_id, user_id, device_name FROM devices LIMIT 1;  -- Just first row

-- 4. Get the newest critical incident
SELECT incident_id, incident_name, created_at FROM incidents 
WHERE severity = 'Critical'
ORDER BY created_at DESC
LIMIT 1;

-- 5. Traffic analysis: Show top 5 suspicious network flows
SELECT flow_id, source_ip_id, dest_ip_id, bytes_sent FROM network_flows 
WHERE is_suspicious = TRUE
ORDER BY bytes_sent DESC
LIMIT 5;
```

---

### **Common Mistakes:**

❌ **Mistake 1:** Forgetting LIMIT with large queries
```sql
-- In production with 100M rows, this hangs
SELECT * FROM auth_logs;  -- Always add LIMIT or WHERE for safety!
```

✅ **GOOD:** Always bound your results
```sql
SELECT * FROM auth_logs LIMIT 100;
-- Or use WHERE to filter first
SELECT * FROM auth_logs WHERE timestamp > NOW() - INTERVAL 1 DAY;
```

❌ **Mistake 2:** OFFSET with large numbers is slow
```sql
-- Slow: Skip 500K rows, then get 10
SELECT * FROM big_table LIMIT 500000, 10;  -- Scans 500K rows then returns 10
```

✅ **GOOD:** It's fine for small offsets, but for large pagination, use keyset pagination
```sql
-- Better: Use the ID of the last row you saw
SELECT * FROM auth_logs WHERE log_id > 500000 LIMIT 10;
```

---

### **Performance Considerations:**

- **LIMIT is fast:** Databases optimize for LIMIT (stop processing when limit reached).
- **OFFSET is slow:** OFFSET still scans skipped rows. Large offsets (e.g., OFFSET 1000000) are slow.
- **Production tip:** For large result sets, use keyset pagination (track last ID, query next batch using WHERE).

---

### **Interview Questions:**

**Q1:** How does `LIMIT 10 OFFSET 100` work differently from `LIMIT 100, 10`?  
**A:** Same result. LIMIT offset, count (MySQL style) vs LIMIT count OFFSET offset (PostgreSQL style). Both skip 100 rows then return 10.

**Q2:** If you have 1B rows and do `LIMIT 1000000, 10`, why is it slow?  
**A:** The database scans past the first 1M rows (even though it doesn't return them). Use WHERE with indexed column or keyset pagination instead.

---

### **Practice Task 4:**

```
Task 1: Get the 3 newest alerts (ordered by creation date, newest first, limit to 3)
Expected: 3 alerts with newest timestamps

Task 2: Get users, skip first 2, get next 3 (pagination)
Expected: 3 users (rows 3-5 when ordered by user_id)

Task 3: Get top 5 vulnerabilities by CVSS score
Expected: Top 5 vulnerabilities with highest CVSS scores
```

**Solutions:**
```sql
-- Task 1
SELECT alert_id, alert_type, created_at FROM alerts 
ORDER BY created_at DESC 
LIMIT 3;

-- Task 2
SELECT user_id, username FROM users 
ORDER BY user_id ASC
LIMIT 3 OFFSET 2;

-- Task 3
SELECT cve_id, CVSS_score FROM vulnerabilities 
ORDER BY CVSS_score DESC
LIMIT 5;
```

---

---

## [CONTINUING WITH REMAINING PHASES...]

*Due to token limits, I'll create a compressed version of the remaining phases and save it. Let me create Part 2-6 in a condensed but comprehensive format.*$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$SQL_Masterclass_Part2_Intermediate$VELSEC$, $VELSEC$Sql Masterclass Part2 Intermediate$VELSEC$, $VELSEC$Data Analyst$VELSEC$, ARRAY['Data_Analytics']::TEXT[], $VELSEC$# SQL Masterclass Part 2: Intermediate Level
## JOINS, GROUP BY, HAVING, Aggregate Functions, Subqueries

---

## PHASE 2: INTERMEDIATE

---

### 2.1 INSERT (Adding Data)

**What it is:** Add new rows to a table.

**Why it's used:** Main way to populate database. Daily operations: new users, new alerts, new logs.

**How it works internally:**
1. Validates data (type checking, constraints, foreign keys).
2. Allocates space in table.
3. Adds row and updates indexes.
4. If error (duplicate key, foreign key violation), entire INSERT is rolled back (ACID property).

**Syntax:**
```sql
-- Single row insert
INSERT INTO table_name (column1, column2, column3) 
VALUES (value1, value2, value3);

-- Multiple rows insert (more efficient)
INSERT INTO table_name (column1, column2, column3) 
VALUES 
  (value1, value2, value3),
  (value4, value5, value6);

-- Insert with SELECT (from another table)
INSERT INTO table_name (column1, column2)
SELECT col_a, col_b FROM another_table WHERE condition;
```

---

### **Real-World Scenario:** "New security alert detected. Add it to the database."

```sql
-- New brute force attempt detected by SIEM
INSERT INTO alerts (user_id, ip_id, alert_type, alert_severity, description) 
VALUES (3, 2, 'Brute Force', 'High', 'User mike_chen had 5 failed attempts in 2 minutes');

-- Query to verify
SELECT alert_id, alert_type, alert_severity, created_at 
FROM alerts 
WHERE user_id = 3 AND alert_type = 'Brute Force'
ORDER BY created_at DESC
LIMIT 1;
```

---

### **Hands-On Examples:**

```sql
-- 1. Add a new user
INSERT INTO users (username, email, department, role, is_active, risk_score) 
VALUES ('bob_miller', 'bob.miller@wf.com', 'Operations', 'Employee', TRUE, 20);

-- 2. Add new IP (external threat)
INSERT INTO ip_addresses (ip_address, is_internal, location, organization, threat_level) 
VALUES ('91.199.77.50', FALSE, 'Ukraine', 'Hosting Provider X', 'Critical');

-- 3. Add multiple failed login attempts at once
INSERT INTO auth_logs (user_id, ip_id, auth_type, auth_status) 
VALUES 
  (3, 2, 'Password', 'Failed'),
  (3, 2, 'Password', 'Failed'),
  (3, 2, 'Password', 'Failed');

-- 4. Batch insert: Copy recent incidents that are Critical to an archive table
-- (Assuming we had an archive_incidents table)
-- INSERT INTO archive_incidents (incident_name, severity, created_at)
-- SELECT incident_name, severity, created_at FROM incidents WHERE severity = 'Critical';

-- 5. Insert with default values (some columns get default)
INSERT INTO devices (user_id, device_name, device_type, os) 
VALUES (1, 'DESKTOP-NEW', 'Server', 'Linux');
-- Note: antivirus_installed defaults to FALSE, is_compromised to FALSE, last_updated to NOW()
```

---

### **Common Mistakes:**

❌ **Mistake 1:** Not specifying columns
```sql
-- Risky: If column order changes, data goes to wrong columns
INSERT INTO users VALUES ('user1', 'user1@test.com', 'IT', 'Admin', TRUE, 5);
```

✅ **GOOD:** Always specify column names
```sql
INSERT INTO users (username, email, department, role, is_active, risk_score) 
VALUES ('user1', 'user1@test.com', 'IT', 'Admin', TRUE, 5);
```

❌ **Mistake 2:** Violating FOREIGN KEY constraints
```sql
-- This fails if user_id 999 doesn't exist
INSERT INTO devices (user_id, device_name, device_type, os) 
VALUES (999, 'DEVICE1', 'Laptop', 'Windows');
-- Error: Foreign key constraint violated
```

✅ **GOOD:** Ensure referenced records exist
```sql
-- First confirm user exists
SELECT * FROM users WHERE user_id = 999;  -- Make sure it exists
INSERT INTO devices (user_id, device_name, device_type, os) 
VALUES (999, 'DEVICE1', 'Laptop', 'Windows');
```

❌ **Mistake 3:** Duplicate key violation
```sql
-- email is UNIQUE; can't insert same email twice
INSERT INTO users (username, email, department, role) 
VALUES ('user_new', 'john.smith@wf.com', 'Finance', 'Employee');
-- Error: Duplicate entry 'john.smith@wf.com' for key 'email'
```

✅ **GOOD:** Use unique emails
```sql
INSERT INTO users (username, email, department, role) 
VALUES ('user_new', 'user_new@wf.com', 'Finance', 'Employee');
```

---

### **Performance Considerations:**

- **Batch inserts are faster:** `INSERT INTO ... VALUES (row1), (row2), (row3)` is faster than 3 separate INSERT statements.
- **Transaction overhead:** Each INSERT is a transaction. Batching reduces transaction overhead.
- **Indexes slow down inserts:** Each new row updates all indexes. Large indexes = slower inserts. This is the trade-off with optimization.

---

### **Interview Questions:**

**Q1:** What's faster: 100 separate INSERT statements or 1 INSERT with 100 VALUES?  
**A:** One INSERT with 100 VALUES (or using batching). Less network round-trips, one transaction overhead.

**Q2:** If email is UNIQUE and you try to INSERT a duplicate email, what happens?  
**A:** Error immediately. The entire INSERT is rolled back (ACID). The table remains unchanged.

---

---

### 2.2 UPDATE (Modifying Data)

**What it is:** Change existing rows.

**Why it's used:** Every day in production: mark alerts as resolved, update user risk scores, update device compliance status.

**How it works internally:**
1. Finds rows matching WHERE clause.
2. Updates specified columns.
3. Updates indexes.
4. Returns count of rows affected.

**Syntax:**
```sql
UPDATE table_name 
SET column1 = value1, column2 = value2, ...
WHERE condition;

-- CRITICAL: Always include WHERE
-- Without WHERE, ALL rows are updated!
```

---

### **Real-World Scenario:** "Alert is resolved. Update it."

```sql
-- Incident handler resolved the brute force alert
UPDATE alerts 
SET is_resolved = TRUE, resolved_at = NOW(),
    resolution_notes = 'False positive - user forgot password, tried multiple combinations'
WHERE alert_id = 1;

-- Verify
SELECT * FROM alerts WHERE alert_id = 1;
-- is_resolved: TRUE, resolved_at: 2024-03-28 14:32:00
```

---

### **Hands-On Examples:**

```sql
-- 1. Mark all unresolved Critical alerts as resolved (SOC cleared them)
UPDATE alerts 
SET is_resolved = TRUE, resolved_at = NOW()
WHERE alert_severity = 'Critical' AND is_resolved = FALSE;

-- 2. Increase risk score of contractors (higher risk profile)
UPDATE users 
SET risk_score = risk_score + 10
WHERE role = 'Contractor';

-- 3. Mark device as compromised after confirming malware
UPDATE devices 
SET is_compromised = TRUE
WHERE device_id = 5;

-- 4. Update vulnerability as patched
UPDATE vulnerabilities 
SET is_patched = TRUE, patch_date = NOW()
WHERE cve_id = 'CVE-2024-5678';

-- 5. Close all non-Critical incidents
UPDATE incidents 
SET status = 'Closed'
WHERE severity != 'Critical' AND status != 'Closed';

-- 6. Update incident after investigation
UPDATE incidents 
SET status = 'Resolved', resolved_at = NOW(), num_users_affected = 1
WHERE incident_id = 1;
```

---

### **Common Mistakes:**

❌ **Mistake 1:** Forgot WHERE clause (UPDATE ALL ROWS!)
```sql
-- DISASTER: Updates ALL users' emails to the same value
UPDATE users SET email = 'admin@wf.com';  -- Every user now has same email!
```

✅ **GOOD:** Always use WHERE
```sql
UPDATE users SET email = 'admin@wf.com' 
WHERE user_id = 5;  -- Only update user_id 5
```

❌ **Mistake 2:** Type mismatch
```sql
-- Fails: risk_score is INT, you're setting to a string
UPDATE users SET risk_score = 'very high' WHERE user_id = 1;
```

✅ **GOOD:** Match data types
```sql
UPDATE users SET risk_score = 95 WHERE user_id = 1;
```

❌ **Mistake 3:** Updating with wrong relationships
```sql
-- If you're updating based on a JOIN, be careful with multiple matches
UPDATE devices 
SET is_compromised = TRUE
WHERE user_id IN (SELECT user_id FROM users WHERE department = 'Finance');
-- This updates ALL devices of Finance users!
```

✅ **GOOD:** Be specific
```sql
UPDATE devices 
SET is_compromised = TRUE
WHERE device_id = 3;  -- Or use very specific WHERE
```

---

### **Performance Considerations:**

- **WhereIndex matters:** If you UPDATE rows based on a non-indexed column, database scans all rows. Slow on large tables.
- **Indexes are updated:** Each UPDATE modifies all indexes. Many indexes = slower updates.
- **Transaction locks:** UPDATE locks the rows being changed. Other transactions wait. Can cause bottlenecks.

---

---

### 2.3 DELETE (Removing Data)

**What it is:** Remove rows.

**Why it's used:** Clean up old data (logs older than 90 days), remove test records, archive resolved incidents.

**How it works internally:**
1. Finds rows matching WHERE.
2. Marks them for deletion (doesn't immediately free disk space, depends on database).
3. Updates indexes.
4. Logs deletion for audit trails (in production systems).

**Syntax:**
```sql
DELETE FROM table_name WHERE condition;

-- CRITICAL: Always WHERE
-- Without WHERE, table is completely emptied!
```

---

### **Real-World Scenario:** "Delete old logs (older than 90 days) for compliance."

```sql
-- Clean up old auth logs (keep 90 days)
DELETE FROM auth_logs 
WHERE timestamp < NOW() - INTERVAL 90 DAY;

-- Verify
SELECT COUNT(*) FROM auth_logs;
```

---

### **Hands-On Examples:**

```sql
-- 1. Delete records for a specific user (user deactivated)
DELETE FROM auth_logs WHERE user_id = 1;
-- Note: Only deletes auth_logs. If you have foreign keys, might fail.

-- 2. Delete closed incidents older than 1 year
DELETE FROM incidents 
WHERE status = 'Closed' AND created_at < NOW() - INTERVAL 1 YEAR;

-- 3. Delete resolved alerts older than 30 days
DELETE FROM alerts 
WHERE is_resolved = TRUE AND resolved_at < NOW() - INTERVAL 30 DAY;

-- 4. Delete low-severity vulnerabilities that are already patched
DELETE FROM vulnerabilities 
WHERE severity = 'Low' AND is_patched = TRUE;
```

---

### **Common Mistakes:**

❌ **Mistake 1:** DELETE without WHERE (DELETE EVERYTHING!)
```sql
-- DISASTER: Deletes entire users table!
DELETE FROM users;
```

✅ **GOOD:** Always use WHERE
```sql
DELETE FROM users WHERE user_id = 999;
```

❌ **Mistake 2:** Foreign key constraints block delete
```sql
-- If a user has auth_logs, you can't delete the user
DELETE FROM users WHERE user_id = 1;
-- Error: Cannot delete or update a parent row (foreign key constraint fails)
```

✅ **GOOD:** Options:
```sql
-- Option 1: Delete dependent rows first
DELETE FROM auth_logs WHERE user_id = 1;
DELETE FROM users WHERE user_id = 1;

-- Option 2: Set FK to ON DELETE CASCADE (design-time choice)
-- This automatically deletes dependent rows when parent deleted
```

❌ **Mistake 3:** Deleting data you might need later
```sql
-- Deletes all incidents without keeping a backup
DELETE FROM incidents;
```

✅ **GOOD:** Archive before deleting
```sql
-- If you have archive table, copy first
INSERT INTO incidents_archive SELECT * FROM incidents WHERE status = 'Closed';
-- Then delete
DELETE FROM incidents WHERE status = 'Closed';
```

---

### **Performance Considerations:**

- **DELETE is expensive:** Scans all rows matching WHERE, updates indexes, logs changes.
- **Disk space not freed immediately:** Depends on database. Some databases need VACUUM/OPTIMIZE to reclaim space.
- **Large deletes should be batched:** DELETE up to 10K rows, commit, repeat. Prevents long locks.

---

---

### 2.4 JOINS (Combining Data)

**What it is:** Combine rows from multiple tables based on a condition (usually matching IDs).

**Why it's used:** Data is normalized (spread across tables). Joins reassemble it.
- Example: auth_logs has user_id, but username is in users table. Use JOIN to get both.

**How it works internally:**
1. Database has two or more result sets (one from each table).
2. Matches rows based on ON condition (e.g., auth_logs.user_id = users.user_id).
3. Combines matching rows.
4. Returns combined result.

**Syntax:**

```sql
-- INNER JOIN (only matching rows)
SELECT a.col, b.col FROM table_a a
INNER JOIN table_b b ON a.id = b.id;

-- LEFT JOIN (all rows from left table, matching from right)
SELECT a.col, b.col FROM table_a a
LEFT JOIN table_b b ON a.id = b.id;

-- RIGHT JOIN (all rows from right table, matching from left)
SELECT a.col, b.col FROM table_a a
RIGHT JOIN table_b b ON a.id = b.id;

-- FULL OUTER JOIN (all rows from both tables)
SELECT a.col, b.col FROM table_a a
FULL OUTER JOIN table_b b ON a.id = b.id;
```

---

### **2.4.1 INNER JOIN (Only Matching Rows)**

```sql
-- Get authentication logs with usernames
SELECT 
  al.log_id,
  u.username,
  al.auth_status,
  al.timestamp
FROM auth_logs al
INNER JOIN users u ON al.user_id = u.user_id
WHERE al.auth_status = 'Failed';

-- Result:
-- log_id | username  | auth_status | timestamp
-- 4      | mike_chen | Failed      | 2024-03-28 10:15:00
-- 5      | mike_chen | Failed      | 2024-03-28 10:16:00
-- ...

-- Interpretation: 
-- For each auth_log row, find the matching user row (by user_id)
-- Return columns from both tables
-- INNER JOIN means: only rows where user_id exists in both tables
```

---

### **2.4.2 LEFT JOIN (All Left Rows, Matching Right Rows)**

```sql
-- Get all users and their devices (even if no devices)
SELECT 
  u.user_id,
  u.username,
  d.device_id,
  d.device_name,
  d.device_type
FROM users u
LEFT JOIN devices d ON u.user_id = d.user_id
ORDER BY u.user_id;

-- Result:
-- user_id | username        | device_id | device_name  | device_type
-- 1       | john_smith      | 1         | LAPTOP-JOHN  | Laptop
-- 1       | john_smith      | 2         | PHONE-JOHN   | Mobile
-- 2       | sarah_jones     | 3         | SERVER-AD    | Server
-- 3       | mike_chen       | 4         | LAPTOP-MIKE  | Laptop
-- 4       | alex_contractor | 5         | LAPTOP-ALEX  | Laptop
-- 5       | admin_user      | 6         | SERVER-PROD  | Server

-- If a user had no devices, still shown (with device columns as NULL):
-- 999     | new_user        | NULL      | NULL         | NULL
```

---

### **2.4.3 RIGHT JOIN**

```sql
-- Get all devices and their users (reverse of LEFT JOIN)
SELECT 
  d.device_id,
  d.device_name,
  u.username,
  u.department
FROM devices d
RIGHT JOIN users u ON d.user_id = u.user_id;

-- Usually, you'd just do LEFT JOIN with tables reversed:
SELECT 
  u.user_id,
  u.username,
  d.device_id,
  d.device_name
FROM users u
LEFT JOIN devices d ON u.user_id = d.user_id;
-- Same result as the RIGHT JOIN above
```

---

### **Real-World Scenario:** "Alert triggered. Show user, device, and IP details."

```sql
SELECT 
  a.alert_id,
  a.alert_type,
  a.alert_severity,
  u.username,
  u.email,
  u.department,
  i.ip_address,
  i.location,
  i.threat_level,
  a.created_at
FROM alerts a
LEFT JOIN users u ON a.user_id = u.user_id
LEFT JOIN ip_addresses i ON a.ip_id = i.ip_id
WHERE a.alert_id = 2;

-- Result:
-- alert_id | alert_type           | alert_severity | username   | email              | department | ip_address      | location | threat_level | created_at
-- 2        | Impossible Travel    | Critical       | john_smith | john.smith@wf.com  | Finance    | 203.45.67.89    | Moscow   | Critical     | 2024-03-28 08:00:00
```

**Action:** User john_smith from Moscow (impossible travel from company location). Critical threat!

---

### **Hands-On Examples:**

```sql
-- 1. Get alerts with username and IP address
SELECT 
  a.alert_id,
  a.alert_type,
  u.username,
  i.ip_address,
  i.threat_level
FROM alerts a
LEFT JOIN users u ON a.user_id = u.user_id
LEFT JOIN ip_addresses i ON a.ip_id = i.ip_id
ORDER BY a.alert_severity DESC;

-- 2. Find incidents with alert details
SELECT 
  inc.incident_id,
  inc.incident_name,
  inc.severity,
  COUNT(ia.alert_id) as num_alerts
FROM incidents inc
LEFT JOIN incident_alerts ia ON inc.incident_id = ia.incident_id
GROUP BY inc.incident_id;

-- 3. Get users and their last login time
SELECT 
  u.user_id,
  u.username,
  u.department,
  MAX(al.timestamp) as last_login
FROM users u
LEFT JOIN auth_logs al ON u.user_id = al.user_id
GROUP BY u.user_id
ORDER BY last_login DESC;

-- 4. Get devices with their users and compromised status
SELECT 
  u.username,
  d.device_name,
  d.device_type,
  d.is_compromised,
  d.antivirus_installed
FROM users u
INNER JOIN devices d ON u.user_id = d.user_id
WHERE d.is_compromised = TRUE;

-- 5. Find network flows with source and destination IPs
SELECT 
  nf.flow_id,
  src.ip_address as source_ip,
  dst.ip_address as dest_ip,
  nf.protocol,
  nf.bytes_sent,
  nf.is_suspicious
FROM network_flows nf
INNER JOIN ip_addresses src ON nf.source_ip_id = src.ip_id
INNER JOIN ip_addresses dst ON nf.dest_ip_id = dst.ip_id
WHERE nf.is_suspicious = TRUE;
```

---

### **Common Mistakes:**

❌ **Mistake 1:** Ambiguous column names (column exists in both tables)
```sql
-- Fails: Which table_id?
SELECT table_id FROM users u
JOIN devices d ON u.user_id = d.user_id;
```

✅ **GOOD:** Specify table
```sql
SELECT u.user_id, d.device_id FROM users u
JOIN devices d ON u.user_id = d.user_id;
```

❌ **Mistake 2:** Wrong JOIN type (losing data)
```sql
-- If you use INNER JOIN but some users have no devices, those users disappear!
SELECT u.username, d.device_name FROM users u
INNER JOIN devices d ON u.user_id = d.user_id;
-- Missing users with no devices
```

✅ **GOOD:** Use LEFT JOIN to keep all users
```sql
SELECT u.username, d.device_name FROM users u
LEFT JOIN devices d ON u.user_id = d.user_id;
```

❌ **Mistake 3:** Dangling join condition
```sql
-- Confusing: Orders and Customers not related somehow
SELECT * FROM auth_logs JOIN ip_addresses;
-- ERROR: No ON clause specified
```

✅ **GOOD:** Always specify ON condition
```sql
SELECT * FROM auth_logs a
JOIN ip_addresses i ON a.ip_id = i.ip_id;
```

---

### **Performance Considerations:**

- **Join is expensive:** Requires scanning both tables, matching rows.
- **Indexes on join columns matter:** If user_id is indexed in both tables, JOIN is fast.
- **Avoid unnecessary joins:** Only join tables you actually need.
- **Join order matters:** Database optimizer reorders JOINs for performance. Trust it, but be aware.

---

---

### 2.5 GROUP BY (Aggregating Data)

**What it is:** Group rows by column value, then apply aggregate functions.

**Why it's used:** Reporting: "How many failed logins per user?", "How many alerts per severity?", "Total bytes sent per IP?"

**How it works internally:**
1. Groups rows by specified column (e.g., all rows with user_id=1, then all with user_id=2, etc.).
2. For each group, applies aggregate function (COUNT, SUM, AVG, etc.).
3. Returns one row per group with aggregate result.

**Syntax:**

```sql
SELECT column_to_group, aggregate_function(column_to_aggregate)
FROM table
GROUP BY column_to_group
ORDER BY aggregate_result DESC;
```

---

### **Hands-On Examples:**

```sql
-- 1. Count failed logins per user
SELECT 
  u.username,
  COUNT(*) as failed_attempts
FROM auth_logs al
JOIN users u ON al.user_id = u.user_id
WHERE al.auth_status = 'Failed'
GROUP BY al.user_id, u.username
ORDER BY failed_attempts DESC;

-- Result:
-- username   | failed_attempts
-- mike_chen  | 3
-- john_smith | 2

-- 2. Count alerts per severity
SELECT 
  alert_severity,
  COUNT(*) as count
FROM alerts
GROUP BY alert_severity
ORDER BY count DESC;

-- Result:
-- alert_severity | count
-- High           | 3
-- Critical       | 2
-- Medium         | 1

-- 3. Count devices per user
SELECT 
  u.username,
  COUNT(d.device_id) as device_count
FROM users u
LEFT JOIN devices d ON u.user_id = d.user_id
GROUP BY u.user_id, u.username
ORDER BY device_count DESC;

-- 4. Total bytes sent per source IP
SELECT 
  src.ip_address as source_ip,
  SUM(nf.bytes_sent) as total_bytes_sent
FROM network_flows nf
JOIN ip_addresses src ON nf.source_ip_id = src.ip_id
GROUP BY nf.source_ip_id, src.ip_address
ORDER BY total_bytes_sent DESC;

-- 5. Average CVSS score per severity level
SELECT 
  severity,
  AVG(CVSS_score) as avg_cvss,
  COUNT(*) as vuln_count
FROM vulnerabilities
GROUP BY severity
ORDER BY avg_cvss DESC;
```

---

### **2.5.1 HAVING Clause (Filter Groups)**

Sometimes you want to filter groups (not individual rows). Use HAVING.

```sql
-- Get users with MORE THAN 2 failed logins
SELECT 
  u.username,
  COUNT(*) as failed_attempts
FROM auth_logs al
JOIN users u ON al.user_id = u.user_id
WHERE al.auth_status = 'Failed'
GROUP BY al.user_id, u.username
HAVING COUNT(*) > 2  -- Filter after GROUP BY
ORDER BY failed_attempts DESC;

-- Result:
-- username  | failed_attempts
-- mike_chen | 3           <- Only mike_chen has >2 failures

-- Difference:
-- WHERE filters BEFORE grouping (on individual rows)
-- HAVING filters AFTER grouping (on aggregates)
```

---

### **More GROUP BY Examples:**

```sql
-- 1. Incidents with more than 1 alert
SELECT 
  inc.incident_id,
  inc.incident_name,
  COUNT(ia.alert_id) as alert_count
FROM incidents inc
LEFT JOIN incident_alerts ia ON inc.incident_id = ia.incident_id
GROUP BY inc.incident_id
HAVING COUNT(ia.alert_id) > 1
ORDER BY alert_count DESC;

-- 2. Devices with NO antivirus and their user count
SELECT 
  COUNT(DISTINCT d.user_id) as users_with_unprotected_devices,
  COUNT(d.device_id) as device_count
FROM devices d
WHERE d.antivirus_installed = FALSE;

-- 3. Authors who contributed more than 10 vulnerabilities (if we had author column)
-- SELECT author, COUNT(*) as vuln_count FROM vulnerabilities
-- GROUP BY author HAVING COUNT(*) > 10;

-- 4. Most recent timestamp per user
SELECT 
  u.username,
  MAX(al.timestamp) as last_auth,
  COUNT(*) as total_logins
FROM auth_logs al
JOIN users u ON al.user_id = u.user_id
GROUP BY al.user_id, u.username
ORDER BY last_auth DESC;
```

---

### **Common Mistakes:**

❌ **Mistake 1:** Non-aggregated column in SELECT not in GROUP BY
```sql
-- Fails: alert_type not aggregated and not in GROUP BY
SELECT alert_type, COUNT(*) FROM alerts GROUP BY alert_severity;
-- Error: alert_type not in GROUP BY clause
```

✅ **GOOD:** All non-aggregated columns must be in GROUP BY
```sql
SELECT alert_type, alert_severity, COUNT(*) FROM alerts 
GROUP BY alert_type, alert_severity;
```

❌ **Mistake 2:** Using WHERE instead of HAVING to filter aggregates
```sql
-- Fails: Can't use WHERE on aggregate
SELECT alert_severity, COUNT(*) FROM alerts WHERE COUNT(*) > 2 GROUP BY alert_severity;
```

✅ **GOOD:** Use HAVING
```sql
SELECT alert_severity, COUNT(*) FROM alerts 
GROUP BY alert_severity 
HAVING COUNT(*) > 2;
```

---

---

### 2.6 Aggregate Functions

**What they are:** Functions that operate on groups of rows and return single value.

**Common aggregate functions:**

```sql
COUNT(column)     -- Count non-NULL values
SUM(column)       -- Sum of values
AVG(column)       -- Average of values
MIN(column)       -- Minimum value
MAX(column)       -- Maximum value
COUNT(DISTINCT c) -- Count unique values
```

---

### **Examples:**

```sql
-- Count total rows
SELECT COUNT(*) FROM users;  -- 5

-- Count failed logins
SELECT COUNT(*) FROM auth_logs WHERE auth_status = 'Failed';  -- 5

-- Count distinct users who had alerts
SELECT COUNT(DISTINCT user_id) FROM alerts;  -- 3 (multiple users)

-- Sum bytes in network flows
SELECT SUM(bytes_sent) as total_bytes_sent FROM network_flows;  -- Large number

-- Average CVSS score
SELECT AVG(CVSS_score) FROM vulnerabilities;  -- 6.7 or similar

-- Min and Max CVSS
SELECT MIN(CVSS_score), MAX(CVSS_score) FROM vulnerabilities;
-- MIN: 3.5, MAX: 10.0

-- Count devices per alert (complex)
SELECT 
  alert_severity,
  COUNT(DISTINCT device_id) as affected_devices
FROM alerts a
LEFT JOIN devices d ON a.user_id = d.user_id
GROUP BY alert_severity;
```

---

---

### 2.7 Subqueries (Queries Within Queries)

**What it is:** A query inside another query. Inner query runs first, result used by outer query.

**Why it's used:** Complex logic, finding rows matching criteria from another query.

**How it works internally:**
1. Inner query executes first.
2. Result stored in temporary result set.
3. Outer query uses that result set.

**Syntax:**

```sql
SELECT * FROM table1 WHERE column IN (SELECT column FROM table2 WHERE condition);

-- Or with SELECT subquery:
SELECT (SELECT COUNT(*) FROM table2) FROM table1;
```

---

### **Examples:**

```sql
-- 1. Find users who had alerts
SELECT username, email FROM users 
WHERE user_id IN (SELECT DISTINCT user_id FROM alerts WHERE user_id IS NOT NULL);

-- 2. Find alerts from high-risk IPs
SELECT alert_id, alert_type FROM alerts 
WHERE ip_id IN (SELECT ip_id FROM ip_addresses WHERE threat_level = 'Critical');

-- 3. Get incidents that affected more than 1 user
SELECT incident_id, incident_name, num_users_affected FROM incidents 
WHERE num_users_affected > (SELECT AVG(num_users_affected) FROM incidents);

-- 4. Complex: Find devices from users with risk score > 20
SELECT device_name, device_type FROM devices 
WHERE user_id IN (
  SELECT user_id FROM users WHERE risk_score > 20
);

-- 5. With Exists:
SELECT username FROM users u WHERE EXISTS (
  SELECT 1 FROM auth_logs al WHERE al.user_id = u.user_id AND al.auth_status = 'Failed'
);
-- More efficient for checking existence
```

---

### **Common Mistakes:**

❌ **Mistake 1:** Subquery returns multiple rows, used with = (expects single value)
```sql
-- Fails: subquery returns multiple values
SELECT * FROM users WHERE user_id = (SELECT user_id FROM auth_logs);
-- Error: Subquery returned more than 1 row
```

✅ **GOOD:** Use IN for multiple values
```sql
SELECT * FROM users WHERE user_id IN (SELECT user_id FROM auth_logs);
```

---

### **Practice Task 5:**

```
Task 1: Count how many alerts are attributed to each severity level
Expected: 6 alerts grouped by severity

Task 2: Get all users with their device count (use LEFT JOIN + GROUP BY)
Expected: 5 users with device counts

Task 3: Find users with more than 1 device
Expected: 1 user (john_smith with 2 devices)

Task 4: Get incidents with count of related alerts
Expected: 4 incidents with alert counts
```

**Solutions:**
```sql
-- Task 1
SELECT alert_severity, COUNT(*) as count FROM alerts GROUP BY alert_severity;

-- Task 2
SELECT u.username, COUNT(d.device_id) as device_count 
FROM users u 
LEFT JOIN devices d ON u.user_id = d.user_id 
GROUP BY u.user_id, u.username;

-- Task 3
SELECT u.username, COUNT(d.device_id) as device_count 
FROM users u 
LEFT JOIN devices d ON u.user_id = d.user_id 
GROUP BY u.user_id, u.username 
HAVING COUNT(d.device_id) > 1;

-- Task 4
SELECT inc.incident_id, inc.incident_name, COUNT(ia.alert_id) as alert_count 
FROM incidents inc 
LEFT JOIN incident_alerts ia ON inc.incident_id = ia.incident_id 
GROUP BY inc.incident_id;
```

---

**[Document continues in files: SQL_Masterclass_Part3_Advanced.md, SQL_Masterclass_Part4_Expert.md, etc.]**

---

**End of Part 2: Intermediate Level**

Next level focuses on:
- Window functions (ROW_NUMBER, RANK, LAG, LEAD)
- CTEs (WITH clause)
- Advanced indexing strategies
- Query optimization
- Production performance tuning$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$SQL_Masterclass_Part3_Advanced$VELSEC$, $VELSEC$Sql Masterclass Part3 Advanced$VELSEC$, $VELSEC$Data Analyst$VELSEC$, ARRAY['Data_Analytics']::TEXT[], $VELSEC$# SQL Masterclass Part 3: Advanced + Expert Level
## Window Functions, CTEs, Indexes, Optimization, Real-World Scenarios

---

## PHASE 3: ADVANCED

---

### 3.1 Window Functions (Advanced Analytical Queries)

**What it is:** Functions that operate over a "window" of rows (a subset) without reducing rows to one like GROUP BY.

**Why it's used:** Complex analytics: ranking, running totals, comparing row to average, detecting trends.

**Key difference from GROUP BY:**
- GROUP BY: Collapses rows (5 rows → 1 row)
- Window functions: Keeps all rows, adds analytical column

**How it works internally:**
1. Partitions rows into windows based on PARTITION BY.
2. Orders rows within partition based on ORDER BY.
3. For each row, applies function over its window.
4. Returns original rows + new window function column.

---

### **Common Window Functions:**

```sql
ROW_NUMBER()      -- 1, 2, 3, ... (unique rank even for ties)
RANK()            -- 1, 1, 3, ... (repeats for ties)
DENSE_RANK()      -- 1, 1, 2, ... (no gaps after ties)
LAG(col, offset)  -- Previous row's value
LEAD(col, offset) -- Next row's value
SUM() OVER        -- Running total
AVG() OVER        -- Running average
FIRST_VALUE()     -- First row in window
LAST_VALUE()      -- Last row in window
```

---

### **Syntax:**

```sql
SELECT 
  column1,
  column2,
  ROW_NUMBER() OVER (PARTITION BY partition_col ORDER BY order_col) as row_num,
  SUM(numeric_col) OVER (PARTITION BY partition_col ORDER BY order_col) as running_total
FROM table;

-- PARTITION BY: Divides data into groups (like GROUP BY, but keeps rows)
-- ORDER BY: Determines order within partition
```

---

### **Real-World Scenario: "Rank users by failed login attempts (detect brute force attacks)"**

```sql
SELECT 
  u.username,
  al.timestamp,
  al.auth_status,
  ROW_NUMBER() OVER (PARTITION BY al.user_id ORDER BY al.timestamp DESC) as attempt_number,
  RANK() OVER (PARTITION BY al.user_id ORDER BY COUNT(*) DESC) as brute_force_rank
FROM auth_logs al
JOIN users u ON al.user_id = u.user_id
WHERE al.auth_status = 'Failed'
GROUP BY al.user_id, u.username, al.timestamp, al.auth_status;

-- For user mike_chen (user_id=3):
-- username   | timestamp           | auth_status | attempt_number | brute_force_rank
-- mike_chen  | 2024-03-28 10:17:00 | Failed      | 1              | 1
-- mike_chen  | 2024-03-28 10:16:00 | Failed      | 2              | 1
-- mike_chen  | 2024-03-28 10:15:00 | Failed      | 3              | 1

-- Action: User attempted 3 times in short period. Brute force! Block.
```

---

### **More Window Function Examples:**

```sql
-- 1. Rank alerts by severity (within each user's alerts)
SELECT 
  u.username,
  a.alert_type,
  a.alert_severity,
  ROW_NUMBER() OVER (PARTITION BY a.user_id ORDER BY a.created_at DESC) as alert_rank
FROM alerts a
LEFT JOIN users u ON a.user_id = u.user_id
WHERE a.user_id IS NOT NULL;

-- 2. Running sum of bytes sent (network flow analysis)
SELECT 
  src.ip_address,
  nf.flow_start,
  nf.bytes_sent,
  SUM(nf.bytes_sent) OVER (PARTITION BY nf.source_ip_id ORDER BY nf.flow_start) as running_total_bytes
FROM network_flows nf
JOIN ip_addresses src ON nf.source_ip_id = src.ip_id
ORDER BY nf.source_ip_id, nf.flow_start;

-- Result scenario:
-- ip_address     | flow_start          | bytes_sent | running_total_bytes
-- 10.0.1.10      | 2024-03-28 10:00:00 | 1024       | 1024
-- 10.0.1.10      | 2024-03-28 11:00:00 | 512        | 1536        <- Running total
-- 10.0.1.10      | 2024-03-28 12:00:00 | 2048       | 3584        <- Running total

-- 3. Compare each user's risk score to average
SELECT 
  username,
  risk_score,
  AVG(risk_score) OVER () as avg_risk,
  risk_score - AVG(risk_score) OVER () as risk_diff
FROM users
ORDER BY risk_score DESC;

-- Result:
-- username        | risk_score | avg_risk | risk_diff
-- alex_contractor | 45         | 15.6     | 29.4       <- Much higher than average
-- mike_chen       | 15         | 15.6     | -0.6
-- sarah_jones     | 10         | 15.6     | -5.6
-- john_smith      | 5          | 15.6     | -10.6

-- 4. Detect anomalies: When did risk score last change?
SELECT 
  username,
  risk_score,
  LAG(risk_score) OVER (PARTITION BY user_id ORDER BY user_id) as prev_risk_score,
  CASE 
    WHEN LAG(risk_score) OVER (PARTITION BY user_id ORDER BY user_id) IS NULL THEN 'Initial'
    WHEN risk_score > LAG(risk_score) OVER (PARTITION BY user_id ORDER BY user_id) THEN 'Increased'
    WHEN risk_score < LAG(risk_score) OVER (PARTITION BY user_id ORDER BY user_id) THEN 'Decreased'
    ELSE 'Same'
  END as risk_change
FROM users;

-- 5. DENSE_RANK: Rank incidents by severity
SELECT 
  incident_name,
  severity,
  DENSE_RANK() OVER (ORDER BY severity DESC) as severity_rank
FROM incidents;

-- With DENSE_RANK: 1, 1, 2, 2, 3 (no gaps)
-- With RANK: 1, 1, 3, 3, 5 (gaps after ties)
```

---

### **Common Mistakes:**

❌ **Mistake 1:** Forgetting PARTITION BY (assumes all data is one window)
```sql
-- This creates a MASSIVE window across all data
SELECT username, risk_score, 
  ROW_NUMBER() OVER (ORDER BY user_id) as row_num
FROM users;
-- Works but probably not what you intended
```

✅ **GOOD:** Be explicit
```sql
SELECT username, risk_score, 
  ROW_NUMBER() OVER (PARTITION BY department ORDER BY user_id) as row_num_by_dept
FROM users;
```

❌ **Mistake 2:** Using window function in WHERE clause
```sql
-- Fails: Can't use window functions in WHERE
SELECT * FROM users WHERE ROW_NUMBER() OVER (ORDER BY user_id) = 1;
```

✅ **GOOD:** Use CTE or subquery
```sql
WITH ranked_users AS (
  SELECT *, ROW_NUMBER() OVER (ORDER BY user_id) as row_num FROM users
)
SELECT * FROM ranked_users WHERE row_num = 1;
```

---

---

### 3.2 CTEs (Common Table Expressions - WITH clause)

**What it is:** Named temporary result set that exists for the duration of one query.

**Why it's used:** Break complex queries into readable steps. Reuse subqueries.

**How it works internally:**
1. CTE executes first, creates temporary named table.
2. Main query uses the CTE like normal table.
3. CTE is discarded after query completes.

**Syntax:**

```sql
WITH cte_name AS (
  SELECT ... FROM ...
),
cte_name2 AS (
  SELECT ... FROM ...
)
SELECT * FROM cte_name JOIN cte_name2;
```

---

### **Real-World Scenario: "Find users with unusually high alert count."**

```sql
-- Complex query broken down with CTEs
WITH user_alert_counts AS (
  SELECT 
    u.user_id,
    u.username,
    COUNT(a.alert_id) as alert_count
  FROM users u
  LEFT JOIN alerts a ON u.user_id = a.user_id
  GROUP BY u.user_id, u.username
),
stats AS (
  SELECT 
    AVG(alert_count) as avg_alerts,
    STDDEV(alert_count) as std_alerts
  FROM user_alert_counts
),
anomalies AS (
  SELECT 
    uac.username,
    uac.alert_count,
    s.avg_alerts,
    s.std_alerts,
    CASE 
      WHEN uac.alert_count > s.avg_alerts + (2 * s.std_alerts) THEN 'Critical Anomaly'
      WHEN uac.alert_count > s.avg_alerts + s.std_alerts THEN 'High Anomaly'
      ELSE 'Normal'
    END as anomaly_level
  FROM user_alert_counts uac
  CROSS JOIN stats s
  WHERE uac.alert_count > s.avg_alerts
)
SELECT * FROM anomalies ORDER BY alert_count DESC;

-- Result:
-- username        | alert_count | avg_alerts | anomaly_level
-- john_smith      | 3           | 1.1        | High Anomaly       <- More alerts than normal
```

---

### **More CTE Examples:**

```sql
-- 1. Incident timeline (recursive - shows alert progression)
WITH incident_events AS (
  SELECT 
    ia.incident_id,
    i.incident_name,
    a.alert_type,
    a.created_at as event_time
  FROM incident_alerts ia
  JOIN incidents i ON ia.incident_id = i.incident_id
  JOIN alerts a ON ia.alert_id = a.alert_id
),
event_sequence AS (
  SELECT 
    incident_id,
    incident_name,
    alert_type,
    event_time,
    ROW_NUMBER() OVER (PARTITION BY incident_id ORDER BY event_time) as sequence
  FROM incident_events
)
SELECT * FROM event_sequence ORDER BY incident_id, sequence;

-- 2. Vulnerability remediation status (tracked over time)
WITH vuln_status AS (
  SELECT 
    cve_id,
    severity,
    is_patched,
    affected_systems,
    CASE 
      WHEN is_patched = TRUE THEN 'Patched'
      WHEN discovered_date < NOW() - INTERVAL 30 DAY AND is_patched = FALSE THEN 'Overdue'
      WHEN discovered_date < NOW() - INTERVAL 7 DAY AND is_patched = FALSE THEN 'Due Soon'
      ELSE 'On Track'
    END as status
  FROM vulnerabilities
)
SELECT 
  status,
  COUNT(*) as count,
  SUM(affected_systems) as total_systems_affected
FROM vuln_status
GROUP BY status;

-- 3. Multi-step investigative query
WITH suspicious_users AS (
  SELECT DISTINCT user_id FROM auth_logs WHERE auth_status = 'Failed' GROUP BY user_id HAVING COUNT(*) > 2
),
suspicious_devices AS (
  SELECT DISTINCT device_id FROM devices WHERE is_compromised = TRUE
),
suspicious_ips AS (
  SELECT DISTINCT ip_id FROM ip_addresses WHERE threat_level IN ('Critical', 'High')
),
user_details AS (
  SELECT 
    u.user_id,
    u.username,
    u.department,
    u.risk_score,
    (SELECT COUNT(*) FROM auth_logs al WHERE al.user_id = u.user_id) as total_logins,
    (SELECT COUNT(*) FROM alerts a WHERE a.user_id = u.user_id) as alert_count
  FROM users u
  WHERE u.user_id IN (SELECT user_id FROM suspicious_users)
)
SELECT * FROM user_details WHERE alert_count > 0 ORDER BY alert_count DESC;
```

---

### **Common Mistakes:**

❌ **Mistake 1:** Redefining CTE in another query (each query has its own scope)
```sql
-- This fails: cte1 not available in second query
WITH cte1 AS (SELECT ... FROM users)
SELECT * FROM cte1;
SELECT * FROM cte1;  -- Error: cte1 not defined
```

✅ **GOOD:** Define CTE within each query
```sql
WITH cte1 AS (SELECT ... FROM users)
SELECT * FROM cte1;

WITH cte1 AS (SELECT ... FROM users)
SELECT * FROM cte1;  -- Separate query, redefine CTE
```

❌ **Mistake 2:** Circular CTE references
```sql
-- Can't reference cte1 while defining cte1
WITH cte1 AS (SELECT * FROM cte1)  -- Error
SELECT * FROM cte1;
```

---

---

### 3.3 Indexes (Making Queries Fast)

**What it is:** Data structure (usually B-tree) that helps find rows quickly.

**Why it's used:** Without indexes, queries scan entire table. With 1B rows, that's slow.

**How it works internally:**
1. Index is like a book index: "topic X appears on pages Y, Z"
2. Instead of reading entire book, jump to pages directly.
3. Database maintains index as data changes (automatic).
4. Trade-off: Indexes speed up SELECT but slow down UPDATE/INSERT/DELETE.

**Syntax:**

```sql
-- Create index on single column
CREATE INDEX idx_name ON table_name (column_name);

-- Create composite index (multiple columns)
CREATE INDEX idx_name ON table_name (col1, col2);

-- Create unique index (bonus: enforces uniqueness)
CREATE UNIQUE INDEX idx_name ON table_name (column_name);

-- Drop index
DROP INDEX idx_name ON table_name;

-- Show indexes
SHOW INDEXES FROM table_name;
```

---

### **When to Index:**

✅ **Index these columns:**
- Foreign keys (used in JOINs)
- Frequently used in WHERE clauses
- Columns used in ORDER BY and GROUP BY
- Columns in frequent subqueries

❌ **Don't index:**
- Columns rarely queried
- Small lookup tables (< 1000 rows)
- Columns with many NULL values
- Boolean columns with few values (high cardinality needed)

---

### **Real-World Scenario: "Query is slow. Let's optimize with indexes."**

```sql
-- SLOW query without index
SELECT username, email FROM users WHERE department = 'IT' AND risk_score > 10;
-- Scans all 5 rows (OK for 5, terrible for 1M rows)

-- Add index on department and risk_score
CREATE INDEX idx_dept_risk ON users (department, risk_score);

-- Now FAST query (uses index to find rows directly)
SELECT username, email FROM users WHERE department = 'IT' AND risk_score > 10;
-- Finds 1-2 rows in milliseconds instead of scanning all
```

---

### **Hands-On Indexing Examples:**

```sql
-- Create index on frequently queried columns
CREATE INDEX idx_user_id ON auth_logs (user_id);
CREATE INDEX idx_alert_severity ON alerts (alert_severity);
CREATE INDEX idx_vuln_severity ON vulnerabilities (severity);
CREATE INDEX idx_device_compromised ON devices (is_compromised);
CREATE INDEX idx_incident_status ON incidents (status);

-- Composite index for common filter + order combinations
CREATE INDEX idx_alert_timestamp ON alerts (alert_severity, created_at);

-- Check index was created
SHOW INDEXES FROM users;
-- Result shows: idx_dept_risk on (department, risk_score)
```

---

### **Index Performance Tips:**

```sql
-- Before optimization: Check query performance
-- (This is database-specific; MySQL uses EXPLAIN)
EXPLAIN SELECT username FROM users WHERE risk_score > 10;
-- Shows: Full table scan, rows examined: 5

--After adding index:
CREATE INDEX idx_risk_score ON users (risk_score);
EXPLAIN SELECT username FROM users WHERE risk_score > 10;
-- Shows: Index scan, rows examined: 1 (much faster!)
```

---

---

### 3.4 Transactions and ACID Properties

**What it is:** Grouping multiple operations as single atomic unit. All-or-nothing guarantee.

**Why it's used:** Consistency. If system crashes mid-operation, data remains valid.

**ACID properties:**
- **Atomic:** All or nothing. If 1 operation fails, all rollback.
- **Consistent:** Database always in valid state.
- **Isolated:** Concurrent transactions don't interfere.
- **Durable:** Once committed, data persists.

**Syntax:**

```sql
START TRANSACTION;  -- or BEGIN

UPDATE users SET risk_score = 50 WHERE user_id = 1;
UPDATE users SET risk_score = 50 WHERE user_id = 2;
INSERT INTO audit_log VALUES ('updated risk scores');

COMMIT;     -- Saves all changes
-- OR
ROLLBACK;   -- Undoes all changes
```

---

### **Real-World Scenario: "Update multiple tables consistently."**

```sql
-- Incident resolution: Update incident + all related alerts + log action
START TRANSACTION;

UPDATE incidents 
SET status = 'Resolved', resolved_at = NOW()
WHERE incident_id = 2;

UPDATE alerts 
SET is_resolved = TRUE, resolved_at = NOW()
WHERE alert_id IN (SELECT alert_id FROM incident_alerts WHERE incident_id = 2);

INSERT INTO audit_log (action, timestamp) 
VALUES ('Incident 2 resolved', NOW());

COMMIT;  -- All three operations succeed together

-- If INSERT fails, entire transaction rolls back
-- Update + Update + Insert are atomic unit
```

---

### **Example: Money Transfer (Bank Context)**

```sql
-- Transfer $1000 from account A to account B
START TRANSACTION;

-- Deduct from account A
UPDATE accounts SET balance = balance - 1000 WHERE account_id = 'A';

-- Add to account B
UPDATE accounts SET balance = balance + 1000 WHERE account_id = 'B';

-- Log transaction
INSERT INTO transaction_log (from_account, to_account, amount) 
VALUES ('A', 'B', 1000);

COMMIT;

-- If step 2 fails (account B doesn't exist), step 1 also rolls back
-- Money not lost!
```

---

#### **3.4.1 Isolation Levels**

Different isolation levels allow trade-offs between consistency and performance:

```sql
-- Set isolation level
SET SESSION TRANSACTION ISOLATION LEVEL serializable;

-- Levels (most to least restrictive):
-- SERIALIZABLE      -- Most isolated, slowest (no concurrency)
-- REPEATABLE READ   -- Default in MySQL, good balance
-- READ COMMITTED    -- Less isolation, faster
-- READ UNCOMMITTED  -- Least isolated, fastest (rarely used)
```

---

---

### 3.5 Query Optimization Techniques

**When to optimize:**
- Query takes >1 second (in production, >100ms is slow)
- Queries run frequently (slow query that runs once/month matters less)
- Large tables (1B+ rows)

**Optimization steps:**

```
1. EXPLAIN the query (understand execution plan)
2. Look for table scans (no indexes)
3. Add indexes (if scanning large tables)
4. Rewrite query logic (if possible)
5. Archive old data (reduces table size)
6. Partition large tables
7. Consider caching
```

---

### **EXPLAIN Example:**

```sql
-- Slow query
SELECT u.username, COUNT(a.alert_id) as alert_count 
FROM users u
LEFT JOIN alerts a ON u.user_id = a.user_id
GROUP BY u.user_id
ORDER BY alert_count DESC;

-- Analyze execution plan
EXPLAIN SELECT u.username, COUNT(a.alert_id) as alert_count 
FROM users u
LEFT JOIN alerts a ON u.user_id = a.user_id
GROUP BY u.user_id
ORDER BY alert_count DESC;

-- Output (MySQL format):
-- id | select_type | table | type  | key  | rows | Extra
-- 1  | SIMPLE      | u     | ALL   | NULL | 5    | (full scan)
-- 1  | SIMPLE      | a     | ref   | idx_user_id | 1 | (uses index)

-- The first row shows "ALL" type = full table scan
-- Add index on users primary key or user_id
```

---

### **Real-World Optimization Example:**

```sql
-- BEFORE (slow):
SELECT alert_id, alert_type, alert_severity 
FROM alerts 
WHERE alert_severity = 'Critical' 
  AND created_at > NOW() - INTERVAL 7 DAY;
-- Scans all 1B alerts (if that's size)

-- AFTER (add index):
CREATE INDEX idx_severity_timestamp ON alerts (alert_severity, created_at);

-- Now same query uses index, returns in milliseconds
```

---

---

## PHASE 4: EXPERT / REAL-WORLD

### 4.1 Data Modeling Basics

**Good schema design = faster, more maintainable queries.**

**Principles:**
1. **Normalization:** Avoid data duplication.
2. **Foreign keys:** Maintain referential integrity.
3. **Appropriate data types:** Use INT for IDs, VARCHAR for strings, TIMESTAMP for dates.
4. **Indexes:** Index foreign keys and frequently queried columns.

---

### **Example Bad Design vs. Good Design:**

```sql
-- BAD: Username stored in every auth_log row (duplication)
CREATE TABLE auth_logs_bad (
  log_id INT,
  username VARCHAR(50),  -- Duplicated in many rows
  ip_address VARCHAR(15),  -- Duplicated
  auth_status VARCHAR(20),
  timestamp TIMESTAMP
);

-- GOOD: Store IDs, join to get names (normalization)
CREATE TABLE users (user_id INT, username VARCHAR(50));
CREATE TABLE ip_addresses (ip_id INT, ip_address VARCHAR(15));
CREATE TABLE auth_logs_good (
  log_id INT,
  user_id INT,  -- Foreign key, not duplicated
  ip_id INT,    -- Foreign key, not duplicated
  auth_status VARCHAR(20),
  timestamp TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (ip_id) REFERENCES ip_addresses(ip_id)
);

-- Good design:
-- - No duplication (reduces storage)
-- - Easier to update (one username = one update)
-- - Supports joins (connects related data)
```

---

---

### 4.2 Production-Grade Query Patterns

#### **Pattern 1: Safely Delete Old Data (Archiving)**

```sql
-- Don't delete directly (risky, locks table)

-- Step 1: Archive to backup table
INSERT INTO alerts_archive 
SELECT * FROM alerts 
WHERE created_at < NOW() - INTERVAL 90 DAY;

-- Step 2: Verify archive (spot check)
SELECT COUNT(*) FROM alerts_archive WHERE created_at < NOW() - INTERVAL 90 DAY LIMIT 10;

-- Step 3: Delete original
DELETE FROM alerts 
WHERE created_at < NOW() - INTERVAL 90 DAY;

-- Step 4: Optimize table (reclaim space)
OPTIMIZE TABLE alerts;
```

---

#### **Pattern 2: Bulk Update with Conditions (Batching)**

```sql
-- Risky: Updates 1B rows at once, locks table for long
UPDATE devices SET is_compromised = TRUE WHERE antivirus_installed = FALSE;

-- Better: Batch updates (1000 rows at a time)
UPDATE devices 
SET is_compromised = TRUE 
WHERE antivirus_installed = FALSE 
LIMIT 1000;
-- Run this query multiple times until 0 rows updated (all done)
```

---

#### **Pattern 3: Efficient Pagination**

```sql
-- Inefficient: OFFSET is slow for large offsets
SELECT * FROM alerts ORDER BY created_at DESC LIMIT 10 OFFSET 1000000;
-- Scans past 1M rows even though doesn't return them

-- Efficient: Keyset pagination (use last row's ID)
-- First page
SELECT * FROM alerts ORDER BY created_at DESC LIMIT 10;
-- Get last_id = 500

-- Next page
SELECT * FROM alerts WHERE alert_id < 500 ORDER BY created_at DESC LIMIT 10;
-- Much faster (uses index to skip directly to alert_id < 500)
```

---

#### **Pattern 4: Conditional Aggregation**

```sql
-- Count alerts by severity in one query
SELECT 
  SUM(CASE WHEN alert_severity = 'Critical' THEN 1 ELSE 0 END) as critical_count,
  SUM(CASE WHEN alert_severity = 'High' THEN 1 ELSE 0 END) as high_count,
  SUM(CASE WHEN alert_severity = 'Medium' THEN 1 ELSE 0 END) as medium_count,
  SUM(CASE WHEN alert_severity = 'Low' THEN 1 ELSE 0 END) as low_count
FROM alerts;

-- Result:
-- critical_count | high_count | medium_count | low_count
-- 2              | 3          | 1            | 0
```

---

---

### 4.3 Real-World Scenario Queries (SOC/Security Context)

#### **Scenario 1: Threat Hunting - Detect Lateral Movement**

```sql
-- Find users who accessed multiple sensitive systems in short time window
WITH user_access AS (
  SELECT 
    al.user_id,
    u.username,
    u.department,
    i.ip_address,
    i.location,
    COUNT(DISTINCT al.log_id) as access_count,
    MIN(al.timestamp) as first_access,
    MAX(al.timestamp) as last_access,
    TIMESTAMPDIFF(MINUTE, MIN(al.timestamp), MAX(al.timestamp)) as time_window_minutes
  FROM auth_logs al
  JOIN users u ON al.user_id = u.user_id
  JOIN ip_addresses i ON al.ip_id = i.ip_id
  WHERE al.auth_status = 'Success'
    AND al.timestamp > NOW() - INTERVAL 1 HOUR
  GROUP BY al.user_id, u.username, u.department, i.ip_address, i.location
)
SELECT * FROM user_access 
WHERE time_window_minutes < 30 AND access_count > 5
ORDER BY access_count DESC;

-- Result: If user accessed 10 systems in 15 minutes = suspicious lateral movement
```

---

#### **Scenario 2: Anomaly Detection - High-Volume Data Transfer**

```sql
-- Detect unusual data exfiltration (baseline + threshold)
WITH flow_stats AS (
  SELECT 
    nf.source_ip_id,
    src.ip_address,
    SUM(nf.bytes_sent) as total_bytes,
    AVG(nf.bytes_sent) as avg_bytes,
    COUNT(*) as flow_count
  FROM network_flows nf
  JOIN ip_addresses src ON nf.source_ip_id = src.ip_id
  WHERE nf.flow_start > NOW() - INTERVAL 1 DAY
  GROUP BY nf.source_ip_id, src.ip_address
),
monthly_baseline AS (
  SELECT 
    nf.source_ip_id,
    SUM(nf.bytes_sent) / COUNT(*) as baseline_avg_bytes
  FROM network_flows nf
  WHERE nf.flow_start > NOW() - INTERVAL 30 DAY
  GROUP BY nf.source_ip_id
)
SELECT 
  fs.ip_address,
  fs.total_bytes,
  fs.avg_bytes,
  mb.baseline_avg_bytes,
  (fs.avg_bytes / mb.baseline_avg_bytes) as anomaly_ratio
FROM flow_stats fs
LEFT JOIN monthly_baseline mb ON fs.source_ip_id = mb.source_ip_id
WHERE fs.avg_bytes > mb.baseline_avg_bytes * 3  -- 3x baseline = anomaly
ORDER BY anomaly_ratio DESC;

-- Result: IP with 3x normal traffic = possible data exfiltration
```

---

#### **Scenario 3: Compliance Reporting - Audit Trail**

```sql
-- Generate audit report for compliance (shows who accessed what when)
SELECT 
  u.user_id,
  u.username,
  u.department,
  u.role,
  COUNT(al.log_id) as total_logins,
  SUM(CASE WHEN al.auth_status = 'Success' THEN 1 ELSE 0 END) as successful_logins,
  SUM(CASE WHEN al.auth_status = 'Failed' THEN 1 ELSE 0 END) as failed_logins,
  MAX(al.timestamp) as last_login,
  STRING_AGG(DISTINCT al.auth_type, ', ') as auth_methods_used
FROM users u
LEFT JOIN auth_logs al ON u.user_id = al.user_id 
  AND al.timestamp > NOW() - INTERVAL 30 DAY
WHERE u.is_active = TRUE
GROUP BY u.user_id, u.username, u.department, u.role
ORDER BY total_logins DESC;

-- Note: STRING_AGG may vary (GROUP_CONCAT in MySQL, STRING_AGG in PostgreSQL, etc.)
```

---

#### **Scenario 4: Risk Prioritization - CVSS + Context**

```sql
-- Prioritize vulnerabilities by CVSS + affected systems + patch status
WITH vuln_risk AS (
  SELECT 
    cve_id,
    severity,
    CVSS_score,
    affected_systems,
    is_patched,
    discovered_date,
    patch_deadline,
    -- Risk score: CVSS + days overdue + affected systems
    (CVSS_score * 10) +  -- CVSS weight
    (CASE WHEN is_patched = FALSE AND patch_deadline < NOW() THEN 100 ELSE 0 END) +  -- Overdue penalty
    (affected_systems / 10) as risk_priority
  FROM vulnerabilities
),
remediation_plan AS (
  SELECT 
    cve_id,
    risk_priority,
    CASE 
      WHEN risk_priority > 500 THEN 'Immediate (next 24h)'
      WHEN risk_priority > 300 THEN 'Urgent (next 7d)'
      WHEN risk_priority > 100 THEN 'High (next 30d)'
      ELSE 'Standard (ok)'
    END as remediation_sla
  FROM vuln_risk
  WHERE is_patched = FALSE
)
SELECT * FROM remediation_plan ORDER BY risk_priority DESC;

-- Result: CVE priority list with SLA
```

---

---

### 4.4 Debugging Slow Queries

**Checklist when query is slow:**

```
1. Run EXPLAIN to see execution plan
2. Check for full table scans (type = ALL)
3. Add indexes on filtered columns
4. Check query logic (unnecessary JOINs? subqueries?)
5. Use ANALYZE to update index statistics
6. Consider query rewrite
7. Check server load (might be resource contention)
```

---

### **Example: Slow Query Debugging**

```sql
-- Slow query reported
SELECT a.alert_id, a.alert_type, u.username
FROM alerts a
JOIN users u ON a.user_id = u.user_id
WHERE a.alert_severity = 'Critical';

-- Step 1: EXPLAIN
EXPLAIN SELECT a.alert_id, a.alert_type, u.username
FROM alerts a
JOIN users u ON a.user_id = u.user_id
WHERE a.alert_severity = 'Critical';

-- Output: Full table scan on alerts (slow!)
-- id | select_type | table | type  | possible_keys | key  | rows
-- 1  | SIMPLE      | a     | ALL   | NULL          | NULL | 1000000  <- ALL means full scan!
-- 1  | SIMPLE      | u     | eq_ref| PRIMARY       | pk   | 1

-- Step 2: Add index on alert_severity
CREATE INDEX idx_alert_severity ON alerts (alert_severity);

-- Step 3: Re-run EXPLAIN
EXPLAIN SELECT a.alert_id, a.alert_type, u.username
FROM alerts a
JOIN users u ON a.user_id = u.user_id
WHERE a.alert_severity = 'Critical';

-- Output: Now uses index!
-- id | select_type | table | type  | possible_keys | key               | rows
-- 1  | SIMPLE      | a     | ref   | idx_alert_sev | idx_alert_sev     | 100   <- Only 100 rows!
-- 1  | SIMPLE      | u     | eq_ref| PRIMARY       | pk                | 1

-- Query now 10x faster (scans 100 rows instead of 1M)
```

---

---

## PHASE 5 & 6: COMPLETE REAL-WORLD PROJECT + INTERVIEW Q&A

### 5.1 End-to-End Project: SOC Incident Analysis

**Scenario:** You're a SOC analyst. Investigate a security incident using SQL.

**Task:** Incident #3 "Malware Detection Network Segment" was created. Your job:
1. Find which alert triggered the incident
2. Identify affected users and devices
3. Analyze network flows from those devices
4. Check device security posture
5. Recommend containment actions

---

### **Solution:**

```sql
-- Step 1: Get incident details
SELECT * FROM incidents WHERE incident_id = 3;
-- Result: Incident 3, Malware Detection, Status: Open, Data Lost: TRUE

-- Step 2: Find related alerts
SELECT 
  ia.alert_id,
  a.alert_type,
  a.alert_severity,
  a.description,
  a.created_at
FROM incident_alerts ia
JOIN alerts a ON ia.alert_id = a.alert_id
WHERE ia.incident_id = 3;
-- Result: Alert 3, Malware IP Communication, Critical

-- Step 3: Find affected IPs and users
SELECT 
  DISTINCT a.user_id,
  u.username,
  u.department,
  u.risk_score,
  i.ip_address,
  i.location,
  i.threat_level
FROM alerts a
LEFT JOIN users u ON a.user_id = u.user_id
LEFT JOIN ip_addresses i ON a.ip_id = i.ip_id
JOIN incident_alerts ia ON a.alert_id = ia.alert_id
WHERE ia.incident_id = 3;
-- Result: Possibly no specific user (network-level malware signal)

-- Step 4: Check devices with suspicious network flows to malware IP
SELECT 
  d.device_id,
  d.device_name,
  d.user_id,
  u.username,
  d.device_type,
  d.is_compromised,
  d.antivirus_installed,
  COUNT(nf.flow_id) as suspicious_flows
FROM network_flows nf
JOIN ip_addresses malware_ip ON nf.dest_ip_id = malware_ip.ip_id
JOIN ip_addresses source_ip ON nf.source_ip_id = source_ip.ip_id
LEFT JOIN devices d ON ... -- Hard to join without device_ip table
LEFT JOIN users u ON d.user_id = u.user_id
WHERE malware_ip.ip_address = '45.142.212.15'  -- Malware IP from alerts
  AND nf.is_suspicious = TRUE
GROUP BY d.device_id, d.device_name;

-- Step 5: Security posture of devices
SELECT 
  u.username,
  COUNT(d.device_id) as total_devices,
  SUM(CASE WHEN d.antivirus_installed = TRUE THEN 1 ELSE 0 END) as av_installed,
  SUM(CASE WHEN d.is_compromised = TRUE THEN 1 ELSE 0 END) as compromised_devices,
  u.risk_score
FROM users u
LEFT JOIN devices d ON u.user_id = d.user_id
GROUP BY u.user_id, u.username, u.risk_score
HAVING compromised_devices > 0;

-- Step 6: Recommended actions
-- Based on findings, recommend:
-- - Isolate compromised devices
-- - Block malware IP at firewall
-- - Require password reset for affected users
-- - Run malware scan on all devices in segment
```

---

---

### 5.2 Interview Questions & Answers (20+ questions)

#### **Junior Questions:**

**Q1: What's the difference between WHERE and HAVING?**
```
A: WHERE filters rows before grouping (on individual rows).
   HAVING filters groups after aggregation.
   
Example:
WHERE status = 'Active'          -- Filters before GROUP BY
HAVING COUNT(*) > 5             -- Filters after GROUP BY
```

**Q2: Write a query to count distinct users.**
```sql
SELECT COUNT(DISTINCT user_id) as unique_users FROM auth_logs;
```

**Q3: How do you find duplicate emails in users table?**
```sql
SELECT email, COUNT(*) FROM users GROUP BY email HAVING COUNT(*) > 1;
```

---

#### **Intermediate Questions:**

**Q4: Explain INNER vs LEFT JOIN with an example.**
```
A: INNER JOIN returns only matching rows.
   LEFT JOIN returns all rows from left table + matching from right.
   
Example:
SELECT u.username, d.device_name
FROM users u
INNER JOIN devices d ON u.user_id = d.user_id;
-- Only users WITH devices

SELECT u.username, d.device_name
FROM users u
LEFT JOIN devices d ON u.user_id = d.user_id;
-- All users, even those without devices (device columns = NULL)
```

**Q5: Write a query to find users with more than 3 failed logins.**
```sql
SELECT u.username, COUNT(*) as failed_count
FROM auth_logs al
JOIN users u ON al.user_id = u.user_id
WHERE al.auth_status = 'Failed'
GROUP BY al.user_id, u.username
HAVING COUNT(*) > 3;
```

**Q6: What's a subquery? When do you use it?**
```
A: Query inside another query. Used when:
- Need result from one query to filter another
- Complex logic easier to read with subqueries
- Window functions unavailable in older databases

Example: Find users with above-average risk score
SELECT username FROM users 
WHERE risk_score > (SELECT AVG(risk_score) FROM users);
```

---

#### **Advanced Questions:**

**Q7: Optimize this query:**
```sql
SELECT DISTINCT u.username 
FROM users u 
JOIN auth_logs al ON u.user_id = al.user_id 
WHERE al.timestamp > NOW() - INTERVAL 7 DAY;
--If this is slow:
-- 1. Add index: CREATE INDEX idx_timestamp ON auth_logs (timestamp);
-- 2. Or change logic: 
SELECT username FROM users 
WHERE user_id IN (SELECT DISTINCT user_id FROM auth_logs WHERE timestamp > NOW() - INTERVAL 7 DAY);
```

**Q8: Write a window function query to rank alerts by severity.**
```sql
SELECT 
  username,
  alert_type,
  alert_severity,
  RANK() OVER (PARTITION BY user_id ORDER BY alert_severity DESC) as severity_rank
FROM alerts a
JOIN users u ON a.user_id = u.user_id;
```

**Q9: What are CTEs and why use them?**
```
A: Common Table Expressions (WITH clause) create named temporary result sets.
   Benefits:
   - Readability (break complex query into steps)
   - Reusability (reference CTE multiple times)
   - Recursion (certain databases support recursive CTEs)
   
Example:
WITH high_risk_users AS (
  SELECT user_id FROM users WHERE risk_score > 50
)
SELECT * FROM high_risk_users;
```

---

#### **Expert Questions:**

**Q10: Design a scalable schema for a logging system with 100B records/day.**
```
A: Partition by date: logs_2024_03, logs_2024_04, etc.
   Indexes: (timestamp, user_id, severity)
   Retention: Keep 90 days hot, archive older
   Schema:
   CREATE TABLE logs_2024_03 (
     log_id BIGINT AUTO_INCREMENT,
     timestamp TIMESTAMP,
     user_id INT,
     severity VARCHAR(10),
     message TEXT,
     PRIMARY KEY (log_id),
     INDEX idx_timestamp (timestamp),
     INDEX idx_user (user_id),
     INDEX idx_severity (severity)
   );
```

**Q11: Explain transaction ACID properties with an example.**
```
A: ACID = Atomic, Consistent, Isolated, Durable

Atomic: All-or-nothing. If 1 operation fails, all rollback.
Consistent: DB always valid state.
Isolated: Concurrent transactions don't interfere.
Durable: Committed data persists even if crash.

Example: Money transfer
START TRANSACTION;
UPDATE accounts SET balance = balance - 1000 WHERE id = 'A';
UPDATE accounts SET balance = balance + 1000 WHERE id = 'B';
COMMIT;
-- If step 2 fails, step 1 rolls back (Atomic)
-- Both succeed together or not at all (Consistent)
-- Other users don't see partial state (Isolated)
-- Once COMMIT, survives crash (Durable)
```

**Q12: How do you detect slow queries in production?**
```
A: Check MySQL slow query log:
   SET GLOBAL slow_query_log = 'ON';
   SET GLOBAL long_query_time = 1;  -- Queries > 1 second logged
   
   Then analyze with:
   mysql -u root -p -e "SELECT query_time, query FROM mysql.slow_log ORDER BY query_time DESC LIMIT 10;"
   
   Or use EXPLAIN to understand execution plan:
   EXPLAIN SELECT ...;  -- Check for full table scans (type=ALL)
```

---

#### **Scenario Questions (Real SOC Context):**

**Q13: Find all users who accessed production servers in the last 24 hours.**
```sql
SELECT DISTINCT u.username, u.department, MAX(al.timestamp) as last_access
FROM auth_logs al
JOIN users u ON al.user_id = u.user_id
JOIN devices d ON al.device_id = d.device_id
WHERE d.device_type = 'Server' 
  AND al.timestamp > NOW() - INTERVAL 1 DAY
  AND al.auth_status = 'Success'
GROUP BY u.user_id, u.username, u.department
ORDER BY last_access DESC;
```

**Q14: Detect potential data exfiltration (large data transfer to external IP).**
```sql
SELECT 
  src.ip_address as internal_ip,
  dst.ip_address as external_ip,
  dst.location,
  SUM(nf.bytes_sent) as bytes_sent,
  COUNT(*) as flow_count
FROM network_flows nf
JOIN ip_addresses src ON nf.source_ip_id = src.ip_id
JOIN ip_addresses dst ON nf.dest_ip_id = dst.ip_id
WHERE src.is_internal = TRUE 
  AND dst.is_internal = FALSE
  AND nf.flow_start > NOW() - INTERVAL 1 DAY
GROUP BY nf.source_ip_id, nf.dest_ip_id, src.ip_address, dst.ip_address, dst.location
HAVING SUM(nf.bytes_sent) > 1000000000  -- > 1 GB = suspicious
ORDER BY bytes_sent DESC;
```

**Q15: Incident response: Find all systems affected by CVE-2023-44487.**
```sql
SELECT DISTINCT
  d.device_id,
  d.device_name,
  d.user_id,
  u.username,
  d.device_type,
  d.os,
  d.os_version
FROM devices d
LEFT JOIN users u ON d.user_id = u.user_id
WHERE d.os_version NOT LIKE '%patched%'  -- Assuming unpatched version indicator
  AND (d.os LIKE '%Windows%' OR d.os LIKE '%Linux%')  -- Assuming vulnerability affects these
ORDER BY d.device_id;
-- Then manually verify or use vulnerability tracking DB
```

---

#### **Trick Questions:**

**Q16: What happens if you run `DELETE FROM users;` without WHERE?**
```
A: DISASTER! All users deleted permanently.
   Prevention: Always use WHERE. Many companies have safeguards:
   - Require LIMIT in DELETE
   - Disable direct delete, use soft delete (update is_active = FALSE)
   - Audit logs capture deletes
   - Backup strategy allows recovery
```

**Q17: If table has 1M rows and you `ORDER BY random_column`, what happens?**
```
A: Database loads all 1M rows into memory, sorts them (slow & expensive).
   Better: Use LIMIT to reduce rows first, or use indexed column.
   
   SLOW:
   SELECT * FROM big_table ORDER BY random_column LIMIT 10;
   
   BETTER:
   SELECT * FROM big_table WHERE indexed_column = 'value' ORDER BY created_at LIMIT 10;
```

---

### 5.3 Mini Challenge Set (Easy → Hard)

**Easy:**
```
1. Get all Critical alerts (3 rows expected)
2. Count total failed authentications
3. List all users in IT department
4. Find device with ID 5
5. Get most recent alert
```

**Medium:**
```
6. Show users and number of devices each has
7. Find incidents with more than 1 alert
8. Detect users with multiple failed logins on different IPs (possible account compromise)
9. List top 3 threat IPs by number of connection attempts
10. Get vulnerabilities overdue for patching (patch_deadline passed)
```

**Hard:**
```
11. Write a query to rank users by alert frequency (using window functions)
12. Create a query that shows percentage of alerts resolved per severity
13. Detect lateral movement (same user accessing multiple systems in <30 minutes)
14. Show incident severity distribution and average resolution time
15. Build a query that gives daily threat metrics (alerts, failed logins, data transfers)
```

---

**End of SQL Masterclass**

---

## Summary Files Created:

1. **SQL_Masterclass_Part1_Foundations.md** → SELECT, WHERE, ORDER BY, LIMIT, INSERT, UPDATE, DELETE
2. **SQL_Masterclass_Part2_Intermediate.md** → JOINS, GROUP BY, AGGREGATE, Subqueries
3. **SQL_Masterclass_Part3_Advanced.md** → Window Functions, CTEs, Indexes, Transactions

Each file is progressive, practical, SOC-focused, and designed for hands-on learning.$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$t1003-lsass$VELSEC$, $VELSEC$T1003.001 - OS Credential Dumping: LSASS Memory$VELSEC$, $VELSEC$MITRE ATT&CK$VELSEC$, ARRAY['MITRE', 'T1003', 'Credentials', 'Windows']::TEXT[], $VELSEC$Adversaries may attempt to access credential material, passwords, or hashes from the Local Security Authority Subsystem Service (LSASS) process memory. Dumping LSASS memory is a common technique (T1003.001) used to gather cleartext credentials or NTLM hashes.

### Exploit Mechanics
Tools like Mimikatz or built-in utilities like `rundll32.exe` with `comsvcs.dll` can dump the LSASS process space:

```powershell
rundll32.exe C:\windows\System32\comsvcs.dll, MiniDump <lsass-pid> C:\windows\temp\lsass.dmp full
```

### Detection Strategy
* **Process Creation Audit:** Alert on process command lines executing `comsvcs.dll` alongside `MiniDump`.
* **Access Request Tracing:** Monitor handles requested to LSASS process (`ProcessAccess` mask `0x1010` or `0x1410` inside Sysmon Event ID 10 logs).
* **Credential Guard:** Ensure Windows Credential Guard is active to isolate LSASS inside virtualized containers.$VELSEC$, '2026-06-03')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$active-directory$VELSEC$, $VELSEC$Active Directory Compromise Incident Response Runbook$VELSEC$, $VELSEC$Runbooks$VELSEC$, ARRAY['AD', 'IR', 'Windows', 'Incident Response']::TEXT[], $VELSEC$This runbook guides responders through containment, eradication, and recovery steps after identifying an Active Directory (AD) domain compromise (e.g., Golden Ticket exploitation, Domain Controller access).

### 1. Containment Phase
* **Isolate Domain Controllers (DCs):** Immediately isolate compromised DCs at the network virtualization layer if possible. Avoid rebooting to preserve RAM artifact memory.
* **Revoke KRBTGT Kerberos Key:** Perform the double-reset protocol for the `krbtgt` password to invalidate all existing Kerberos tickets.
* **Block Internet Access:** Sever external routing paths from Domain Controllers.

### 2. Eradication Phase
* **Reset Privileged Credentials:** Reset passwords for all Domain Administrators, Enterprise Administrators, and service accounts.
* **Audit Group Memberships:** Query `Domain Admins` and nested groups for unauthorized additions.

### 3. Recovery Phase
* Rebuild affected DCs from clean, known-secure backups or clean operating system installs.
* Monitor directory change replication logs for replication errors.$VELSEC$, '2026-06-03')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Answers_Section1_IAM$VELSEC$, $VELSEC$Answers Section1 Iam$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['Cloud_Security']::TEXT[], $VELSEC$# Section 1 — IAM & Permission Controls (Q1–Q10) — Answers

---

## Q1. Cross-Account S3 Access Gone Wrong

**Scenario:** A developer from Account-A needs read-only access to an S3 bucket in Account-B that stores PHI. They propose adding a bucket policy with `"Principal": "*"` and restricting by source IP.

**Answer:**

**Why this is dangerous:**
- `"Principal": "*"` means **any AWS principal in the world** can access the bucket — it's essentially public. IP-based restriction is a weak compensating control because:
  - IPs can be spoofed or change (especially in cloud environments).
  - If the IP condition is misconfigured even slightly, PHI is exposed.
  - It violates the principle of least privilege and HIPAA access controls.

**Secure cross-account pattern:**
1. **In Account-B**, create an IAM role (`CrossAccountS3ReadRole`) with a trust policy allowing only Account-A's specific role/principal to assume it:
```json
{
  "Effect": "Allow",
  "Principal": { "AWS": "arn:aws:iam::ACCOUNT-A-ID:role/DevRole" },
  "Action": "sts:AssumeRole",
  "Condition": { "StringEquals": { "sts:ExternalId": "unique-external-id" } }
}
```
2. Attach a **permission policy** granting only `s3:GetObject` on the specific bucket/prefix.
3. In Account-A, grant the developer's role permission to `sts:AssumeRole` on the Account-B role.
4. Use **S3 bucket policy** to restrict access to the specific role ARN, not `*`.

**Auditability for HIPAA:**
- Enable **CloudTrail data events** on the S3 bucket to log every `GetObject` call.
- Enable **S3 server access logging** as a secondary log source.
- Use **CloudWatch/EventBridge** to alert on unusual access patterns.
- Store all logs in a **separate, locked-down logging account** with Object Lock.

---

## Q2. Over-Permissioned Lambda Execution Role

**Scenario:** A Lambda function has `AdministratorAccess` but only needs DynamoDB read and CloudWatch log write.

**Answer:**

**Risk:** If the Lambda function is compromised (e.g., via event injection, dependency vulnerability), the attacker gains **full admin access** to the entire AWS account — they can create IAM users, exfiltrate data, delete resources, or pivot to other accounts.

**Minimal IAM policy:**
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:GetItem",
        "dynamodb:Query",
        "dynamodb:Scan"
      ],
      "Resource": "arn:aws:dynamodb:us-east-1:123456789012:table/MyTable"
    },
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:us-east-1:123456789012:log-group:/aws/lambda/MyFunction:*"
    }
  ]
}
```

**Detecting over-permissioned roles at scale:**
- **IAM Access Analyzer** — use the "policy generation" feature that analyzes CloudTrail to generate least-privilege policies based on **actual usage** over 90 days.
- **AWS Config rule** `iam-policy-no-statements-with-admin-access` flags any role with `*:*` permissions.
- **Custom Config/Lambda rule** that scans all Lambda execution roles and compares attached policies against a baseline.
- **Third-party tools** like Prowler, CloudSploit, or Prisma Cloud can audit this continuously.

---

## Q3. Leaked IAM Access Keys

**Scenario:** GuardDuty alerts that IAM access keys are being used from an unfamiliar IP in a different geography.

**Answer:**

**Immediate incident response steps (in order):**
1. **Don't delete the keys yet** — first, identify the key and associated user/role.
2. **Disable the access keys** via IAM console/CLI: `aws iam update-access-key --status Inactive`
3. **Check CloudTrail** for all API calls made by those keys in the last 24-72 hours:
   - Filter by `userIdentity.accessKeyId`
   - Look for: new IAM users created, S3 data exfiltration, EC2 instances launched, security group changes.
4. **Revoke any active sessions** by adding an inline deny policy with a date condition: deny all actions where `aws:TokenIssueTime` is before the current time.
5. **Rotate the credentials** — generate new keys if the service account still needs them.

**Determining blast radius:**
- Query CloudTrail for all actions taken by the compromised credentials.
- Check if new resources were created (EC2 instances, IAM users, access keys).
- Check S3 data access logs for any data downloads.
- Review any IAM policy changes or privilege escalation attempts.
- Check for Lambda functions or CloudFormation stacks created (persistence mechanisms).

**Preventive controls:**
- **Eliminate long-lived access keys** — use IAM roles with temporary credentials (STS) everywhere possible.
- **Enable GuardDuty** across all accounts (it detected this!).
- **SCPs** to deny `iam:CreateAccessKey` except for authorized automation roles.
- **AWS Config rule** `access-keys-rotated` to enforce maximum key age (90 days).
- **IAM credential report** automated review for unused/old keys.
- **Set up automated response** via EventBridge → Lambda to auto-disable keys when GuardDuty raises this finding type.

**SCPs for containment:** SCPs can restrict what actions can be performed in member accounts. During an incident, you can apply a **"quarantine SCP"** that denies all actions except read-only security investigation APIs, effectively locking down the compromised account.

---

## Q4. SCP vs IAM Policy Conflict

**Scenario:** Developer has `ec2:*` in IAM policy, but SCP at OU level denies `ec2:RunInstances` for instances larger than `m5.xlarge`.

**Answer:**

**What happens:** The launch of `m5.4xlarge` is **DENIED**. The request fails with an "Access Denied" error.

**IAM policy evaluation logic (full chain):**

1. **SCPs (Organization level)** — evaluated first as a **guardrail**. SCPs don't grant permissions; they define the **maximum** permissions available. If the SCP denies it, the evaluation stops — **DENY**.
2. **Resource-based policies** — checked for cross-account access or direct resource grants.
3. **Permission boundaries** — if set on the IAM entity, they cap the maximum permissions the identity policy can grant.
4. **Identity-based policies** (IAM user/role policies) — the actual permissions granted.
5. **Session policies** — if using `AssumeRole` with a session policy, further restricts permissions.

**Key principle:** For an action to be allowed, it must be permitted at **every level**. An explicit deny at any level overrides allows at all other levels.

**Permission boundaries for defense-in-depth:**
- Even if an admin accidentally grants `AdministratorAccess`, the permission boundary limits what the user can actually do.
- Example: Set a permission boundary on all developer roles allowing only `ec2:*`, `s3:*`, `rds:*` on specific resources — even if someone attaches `AdministratorAccess`, they can't touch IAM, Organizations, or billing.

---

## Q5. Break-Glass Access Pattern

**Scenario:** On-call engineer needs elevated access at 2 AM for an RDS issue, but normal role is read-only.

**Answer:**

**Secure break-glass design:**

1. **Create an elevated IAM role** (`BreakGlassRDSAdmin`) with the necessary RDS troubleshooting permissions.
2. **Trust policy** allows only authorized on-call engineers to assume it, with MFA required:
```json
{
  "Condition": {
    "Bool": { "aws:MultiFactorAuthPresent": "true" },
    "NumericLessThan": { "aws:MultiFactorAuthAge": "3600" }
  }
}
```
3. **Set maximum session duration** to 1 hour (`--duration-seconds 3600`) so access auto-expires.
4. **Use STS AssumeRole** — the engineer assumes the break-glass role, gets temporary credentials valid for 1 hour.
5. **Approval workflow (optional):**
   - Integrate with a ticketing system (PagerDuty/ServiceNow) — the break-glass Lambda verifies an open incident ticket before granting access.
   - Use **AWS Step Functions** for a multi-step approval: request → manager approval (SNS) → credential vending → auto-expiry.

**Auditing:**
- Every `AssumeRole` call is logged in **CloudTrail** with the source identity, time, and session name.
- Set up a **CloudWatch alarm** on break-glass role assumption events.
- Require the engineer to include a **session tag** with the incident ticket number.

**Auto-revocation:** STS temporary credentials expire automatically. No manual cleanup needed. If you need to revoke earlier, apply an inline deny policy on the role with a time condition.

---

## Q6. Federated Identity & MFA Enforcement

**Scenario:** Okta SAML federation into AWS — enforce MFA for all federated users.

**Answer:**

**MFA at SAML federation level:**
- Configure Okta to **require MFA** before issuing the SAML assertion.
- In the SAML assertion, include the `https://aws.amazon.com/SAML/Attributes/SessionDuration` and crucially, set the MFA-related claim.

**IAM condition keys for MFA enforcement:**
- The SAML federation passes `aws:MultiFactorAuthPresent` as a condition key.
- Apply a **deny policy** on the federated role:
```json
{
  "Effect": "Deny",
  "Action": "*",
  "Resource": "*",
  "Condition": {
    "BoolIfExists": { "aws:MultiFactorAuthPresent": "false" }
  }
}
```
- **Important:** Use `BoolIfExists` instead of `Bool` because for some API calls the key may not exist.

**Troubleshooting MFA claim issue:**
1. Check the **SAML assertion** (Okta provides a SAML tracer) — verify `aws:MultiFactorAuthPresent` is set to `true`.
2. Check if Okta is sending the MFA attribute correctly — AWS expects it in the `https://aws.amazon.com/SAML/Attributes/` namespace.
3. Check **CloudTrail** `AssumeRoleWithSAML` event — look at the `additionalEventData` field for MFA details.
4. If the user authenticated with MFA in Okta but the assertion doesn't include the flag, it's an Okta SAML assertion configuration issue — the MFA claim must be mapped explicitly.

---

## Q7. IAM Policy Conditions for IP + VPC Endpoint Restrictions

**Scenario:** Restrict IAM actions to only corporate VPN CIDR and VPC endpoints, while allowing Lambda in VPC.

**Answer:**

**Policy combining VPN IPs and VPC endpoints:**
```json
{
  "Effect": "Deny",
  "Action": "*",
  "Resource": "*",
  "Condition": {
    "StringNotEqualsIfExists": {
      "aws:SourceVpce": ["vpce-abc123", "vpce-def456"]
    },
    "NotIpAddressIfExists": {
      "aws:SourceIp": ["10.0.0.0/8", "172.16.0.0/12"]
    },
    "Bool": {
      "aws:ViaAWSService": "false"
    }
  }
}
```

**`aws:SourceIp` vs `aws:SourceVpce`:**
- `aws:SourceIp` — the IP making the API call. Applies when traffic goes via the **internet** (console, CLI from laptop, NAT Gateway).
- `aws:SourceVpce` — the VPC endpoint ID. Applies when traffic goes via a **VPC endpoint** (interface or gateway). In this case, `aws:SourceIp` is **not present** in the request context.
- This is why you must use `IfExists` variants — the key may or may not be present depending on the traffic path.

**Lambda in VPC without NAT:** A Lambda in a VPC without a NAT gateway and without a VPC endpoint **cannot call AWS APIs at all** — it has no route to the internet or to AWS services. You must create **VPC interface endpoints** for every AWS service the Lambda needs to call (STS, DynamoDB, S3, etc.). The `aws:SourceVpce` condition then enforces access through those endpoints.

---

## Q8. Confused Deputy Problem

**Scenario:** Third-party SaaS vendor wants a cross-account role for backup management.

**Answer:**

**Confused deputy problem:** An attacker could use the same third-party service to access **your** AWS account. If the vendor's role trust policy only checks `"Principal": {"AWS": "arn:aws:iam::VENDOR-ACCOUNT:root"}`, any customer of that vendor who knows your role ARN could trick the vendor into assuming your role.

**ExternalId mitigation:**
```json
{
  "Effect": "Allow",
  "Principal": { "AWS": "arn:aws:iam::VENDOR-ACCOUNT:root" },
  "Action": "sts:AssumeRole",
  "Condition": {
    "StringEquals": { "sts:ExternalId": "your-unique-external-id-12345" }
  }
}
```
- The `ExternalId` is a **shared secret** between you and the vendor — unique to your account.
- Other customers of the vendor don't know your ExternalId, so they can't impersonate you.
- The ExternalId should be **generated by you**, not the vendor.

**Additional controls:**
- **Permission boundary** on the role to cap what the vendor can do (e.g., only `backup:*` and `s3:GetObject`).
- **CloudTrail** monitoring for all `AssumeRole` events on this role.
- **SCP** preventing the role from performing sensitive actions like IAM changes.
- **Time-based conditions** — restrict role usage to specific hours if the vendor operates in consistent windows.
- **Regularly rotate** the ExternalId and re-synchronize with the vendor.

---

## Q9. Access Analyzer Findings Triage

**Scenario:** 150+ findings from IAM Access Analyzer showing externally shared resources.

**Answer:**

**Prioritization in healthcare/payments:**
1. **Critical (fix immediately):**
   - S3 buckets with PHI/PCI data shared externally
   - KMS keys accessible by external accounts (they could decrypt your data)
   - Lambda functions invokable by external accounts
2. **High (fix within 24 hours):**
   - SQS/SNS topics with external access (potential data leakage channel)
   - IAM roles assumable by external accounts without ExternalId
3. **Medium (fix within 1 week):**
   - S3 buckets with non-sensitive data shared externally
   - Resources shared with known partner accounts (verify if intentional)

**Triage workflow:**
1. **Export all findings** and categorize by resource type and data sensitivity.
2. **Cross-reference** with your data classification — which resources contain PHI/PCI data?
3. **Verify intent** — some external sharing is legitimate (cross-account access in your org). Mark these as **archived** with justification.
4. **Remediate** — remove unintended external access by updating resource policies.
5. **Set up automated monitoring** — EventBridge rule on new Access Analyzer findings → SNS → security team.

**Access Analyzer vs Config:**
- **Access Analyzer** uses **automated reasoning** (Zelkova) to mathematically prove whether a resource is accessible externally. It catches subtle policy combinations that rules-based checks miss.
- **Config rules** like `s3-bucket-public-read-prohibited` are **pattern-based** — they check specific known-bad configurations but may miss complex policy interactions.
- Use **both**: Config for fast detection of common misconfigs, Access Analyzer for deep policy analysis.

---

## Q10. Root Account Security

**Scenario:** Root user has active access keys, no MFA, and was used 3 days ago.

**Answer:**

**Immediate steps:**
1. **Enable MFA on root** immediately — use a **hardware MFA** device (YubiKey), not a virtual one, for the root account.
2. **Delete the root access keys** — `aws iam delete-access-key --user-name root --access-key-id AKIA...`. Root should **never** have access keys.
3. **Check CloudTrail** for all actions performed by root in the last 30 days — look for unauthorized changes.
4. **Change the root password** to a strong, unique password stored in a physical safe or hardware vault.
5. **Set the root account email** to a **distribution list** (e.g., `aws-root@company.com`), not a personal email.
6. **Enable alternate contacts** for billing and security.

**Why root is dangerous in multi-account:**
- Root can bypass **all SCPs** — it's the only principal that SCPs don't affect.
- Root can close the AWS account entirely.
- Root can change the support plan, billing info, and account email.
- In an organization, if the **management account root** is compromised, the attacker controls everything.

**Monitoring root usage:**
- **CloudWatch metric filter** on CloudTrail for `"userIdentity.type": "Root"` → CloudWatch Alarm → SNS notification.
- **GuardDuty** flags root usage with `Policy:IAMUser/RootCredentialUsage`.
- **AWS Config rule** `root-account-mfa-enabled` for MFA compliance.

**SCPs and root:** SCPs **do not apply to the root user** of any account. You cannot prevent root actions via SCPs. The only mitigation is to secure the root credentials and monitor for usage. However, SCPs DO apply to the management account's root for certain actions in newer Organizations features.$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Answers_Section2_Network_Section3_S3$VELSEC$, $VELSEC$Answers Section2 Network Section3 S3$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['Cloud_Security']::TEXT[], $VELSEC$# Section 2 — Network Security: VPC, SGs, NACLs, Firewalls (Q11–Q20) — Answers

---

## Q11. VPC Design for a Multi-Tier Payment Application

**Answer:**

**Subnet layout (PCI DSS compliant):**
- **Public subnets** (2 AZs): ALB/NLB only. No application servers directly here.
- **Private subnets - App tier** (2 AZs): ECS Fargate tasks / EC2 instances running application code.
- **Private subnets - Database tier** (2 AZs): RDS Aurora (Multi-AZ), ElastiCache. No NAT route — fully isolated.
- **Isolated subnets** (2 AZs): For any components that must have zero internet access (HSM, internal APIs).

**Component placement:**
- **ALB** → public subnets, with WAF attached.
- **NAT Gateway** → public subnets (for app tier to pull patches/updates), one per AZ for HA.
- **Bastion Host** → **eliminate entirely**, use SSM Session Manager instead.
- **VPC endpoints** → S3 (Gateway), DynamoDB (Gateway), STS/CloudWatch/ECR (Interface) in private subnets.

**Security Groups (stateful) — layered approach:**
| SG | Inbound | Outbound |
|---|---|---|
| ALB-SG | 443 from `0.0.0.0/0` | App-tier SG on app port |
| App-SG | App port from ALB-SG **only** | DB-SG on 3306/5432, HTTPS to VPC endpoints |
| DB-SG | 3306/5432 from App-SG **only** | None (deny all) |

**NACLs (stateless) — extra defense:**
- DB subnet NACL: allow inbound only from app subnet CIDR on DB port; explicitly deny all other inbound.
- NACLs require ephemeral port rules (1024-65535) for return traffic since they're stateless.

**CDE boundary:** The Cardholder Data Environment is defined as any system that stores, processes, or transmits cardholder data. In this design, the CDE boundary is the App + DB subnets. The CDE is segmented from non-CDE via separate subnets, SGs, NACLs, and potentially separate VPCs. All traffic crossing the CDE boundary must be logged and monitored. **VPC Flow Logs** must be enabled on all CDE subnets.

---

## Q12. Security Group vs NACL Troubleshooting

**Answer:**

**Systematic troubleshooting:**

1. **Security Groups (stateful):** Check the EC2 instance's SG — does it allow inbound from the on-prem CIDR on the required port? Since SGs are stateful, if inbound is allowed, return traffic is automatic.

2. **NACLs (stateless):** This is the most common culprit. Check the **subnet's NACL**:
   - Inbound rule: Allow traffic from on-prem CIDR on the required port.
   - **Outbound rule:** Allow ephemeral ports (1024-65535) back to on-prem CIDR. Since NACLs are **stateless**, return traffic is NOT automatic — you need an explicit outbound rule.

3. **Route Tables:** Check that the private subnet's route table has a route to the on-prem CIDR via the Virtual Private Gateway (VGW) or Transit Gateway.

4. **VPN config:** Check IPsec tunnel status, BGP routes (if using dynamic routing), and that the on-prem firewall allows return traffic.

**Using VPC Flow Logs:**
- Enable Flow Logs on the ENI of the EC2 instance.
- Filter for the on-prem source IP and look at the `action` field:
  - `ACCEPT` then `REJECT` = traffic reaches the instance but return traffic is blocked (likely NACL outbound rule missing).
  - `REJECT` on inbound = SG or NACL inbound rule blocking it.
- Flow Log fields: `srcaddr dstaddr srcport dstport protocol packets bytes start end action log-status`

---

## Q13. VPC Peering vs Transit Gateway vs PrivateLink

**Answer:**

| Feature | VPC Peering | Transit Gateway | PrivateLink |
|---|---|---|---|
| **Connectivity** | 1-to-1 between two VPCs | Hub-and-spoke, many-to-many | Expose specific services to consumers |
| **Transitive routing** | ❌ No | ✅ Yes | N/A (service-level, not network-level) |
| **Cross-account** | ✅ Yes | ✅ Yes | ✅ Yes |
| **Cross-region** | ✅ Yes | ✅ Yes (inter-region peering) | ✅ Yes |
| **Scale** | Limit of 125 peering connections per VPC | Thousands of VPCs | Unlimited endpoints |
| **Cost** | Data transfer only | Per attachment + data transfer | Per endpoint-hour + data transfer |
| **Security inspection** | ❌ No centralized point | ✅ AWS Network Firewall | N/A |

**Best choice for 15-account shared services:** **Transit Gateway** — it provides a centralized hub, supports transitive routing, and you can insert **AWS Network Firewall** for centralized traffic inspection.

**Preventing transitive routing in peering:** VPC peering is non-transitive by design. If A↔B and B↔C are peered, A cannot reach C through B. This is a security feature. But it doesn't scale — with 15 accounts you'd need 105 peering connections (n(n-1)/2).

**TGW + Network Firewall:** Deploy Network Firewall in a dedicated "inspection VPC" attached to the Transit Gateway. Configure TGW route tables to send inter-VPC traffic through the firewall VPC for IDS/IPS inspection before forwarding.

---

## Q14. AWS Network Firewall Deployment

**Answer:**

**Architecture placement:**
- Deploy in a **dedicated firewall subnet** within each VPC (or a centralized inspection VPC attached to Transit Gateway).
- **Ingress pattern:** Internet → IGW → Firewall subnet → ALB subnet → App subnet.
- **Egress pattern:** App subnet → Firewall subnet → NAT Gateway → Internet.

**Domain-based filtering (Suricata rules):**
```
# Allow only specific domains
pass tls any any -> any any (tls.sni; content:"amazonaws.com"; endswith; nocase; sid:1; rev:1;)
pass tls any any -> any any (tls.sni; content:"github.com"; endswith; nocase; sid:2; rev:1;)
# Drop everything else
drop tls any any -> any any (msg:"Blocked TLS to unauthorized domain"; sid:100; rev:1;)
```
- Use **stateful rule groups** with `domain-list` for HTTP/HTTPS domain filtering (built-in feature, simpler than raw Suricata).
- Use Custom Suricata rules for advanced IDS/IPS signatures.

**Route table integration:**
- Modify the **IGW route table** (ingress routing) to send traffic to the firewall endpoint.
- Modify **private subnet route tables** to send `0.0.0.0/0` traffic through the firewall endpoint instead of directly to the NAT Gateway.
- This requires **VPC routing enhancements** (appliance routing).

**Cost justification:** Network Firewall costs ~$0.395/hr per endpoint + $0.065/GB processed. For a healthcare/payments company, justify by: (1) regulatory compliance requirement for IDS/IPS, (2) data exfiltration prevention, (3) cost of a breach ($10M+ in healthcare) vastly exceeds firewall cost.

---

## Q15. DDoS Attack on Public ALB

**Answer:**

**Shield Standard vs Advanced:**
| | Shield Standard | Shield Advanced |
|---|---|---|
| **Cost** | Free (included) | $3,000/month + data transfer |
| **Protection** | Layer 3/4 automatic | Layer 3/4/7 advanced |
| **DRT** | ❌ | ✅ AWS DDoS Response Team 24/7 |
| **Cost protection** | ❌ | ✅ Credits for DDoS scaling costs |
| **WAF integration** | ❌ | ✅ Free WAF for protected resources |
| **Visibility** | Basic | Real-time metrics, attack forensics |

**WAF rate-based rules:**
```json
{
  "Name": "RateLimitRule",
  "Priority": 1,
  "Action": { "Block": {} },
  "Statement": {
    "RateBasedStatement": {
      "Limit": 2000,
      "AggregateKeyType": "IP"
    }
  }
}
```
- Set rate limit per IP (e.g., 2000 requests per 5 minutes).
- Add **geographic-based blocking** for traffic from unexpected countries.
- Add **IP reputation rules** using AWS Managed Rule Groups (`AWSManagedRulesAmazonIpReputationList`).

**Incident response:**
1. **Detection:** Shield/GuardDuty/CloudWatch alarms fire → PagerDuty alert.
2. **Mitigation:** Enable WAF rate-based rules, geo-blocking. If Shield Advanced, engage DRT.
3. **Scaling:** ALB auto-scales, CloudFront absorbs volumetric traffic at edge.
4. **Monitoring:** Watch metrics — `RequestCount`, `HTTPCode_ELB_5XX`, `HealthyHostCount`.
5. **Post-mortem:** Analyze attack vectors, update WAF rules, review if Shield Advanced is needed.

**CloudFront for DDoS:** Putting CloudFront in front of ALB absorbs volumetric attacks at 400+ global edge locations. Shield Standard protects CloudFront automatically. Attackers can't reach the origin ALB directly if you restrict the ALB SG to only CloudFront IPs (use AWS-managed prefix list `com.amazonaws.global.cloudfront.origin-facing`).

---

## Q16. Unintended Public Exposure of an EC2 Instance

**Answer:**

**Does a public IP = publicly reachable?** **No.** Multiple conditions must align:
1. ✅ Public IP or Elastic IP attached — **yes, it's attached**.
2. ❓ **Internet Gateway** attached to the VPC — if the VPC has an IGW, this is met.
3. ❓ **Route table** of the subnet has a route `0.0.0.0/0 → IGW` — private subnets typically route to NAT, not IGW.
4. ❓ **Security Group** allows inbound traffic from `0.0.0.0/0` — if SG only allows internal CIDRs, external traffic is blocked.
5. ❓ **NACL** allows inbound traffic — if the NACL denies public IPs, traffic is blocked.

In a properly designed private subnet, step 3 fails — the route table sends `0.0.0.0/0` to NAT, not IGW. So the instance has a public IP but is **not reachable** from the internet. However, this is still a misconfiguration that should be remediated.

**Proactive detection:**
- **AWS Config rule:** `ec2-instance-no-public-ip` — flags any EC2 instance with a public IP.
- **Security Hub:** CIS Benchmark control flags EC2 instances in public subnets.
- **Custom EventBridge rule:** Trigger on `RunInstances` API call → Lambda checks if public IP was assigned → auto-remediate or alert.

**Preventive guardrails:**
- **SCP:** Deny `ec2:RunInstances` unless `ec2:AssociatePublicIpAddress` is `false`.
- **VPC subnet setting:** Disable "auto-assign public IP" on all private subnets — this is a subnet-level setting.
- **AWS Config remediation:** Auto-dissociate public IPs from instances in tagged "private" subnets.

---

## Q17. VPC Endpoint Security for S3

**Answer:**

**Enforcement architecture:**

1. **S3 Bucket Policy** — deny all access NOT from the VPC endpoint:
```json
{
  "Effect": "Deny",
  "Principal": "*",
  "Action": "s3:*",
  "Resource": ["arn:aws:s3:::my-bucket", "arn:aws:s3:::my-bucket/*"],
  "Condition": {
    "StringNotEquals": {
      "aws:sourceVpce": "vpce-abc123"
    }
  }
}
```

2. **VPC Endpoint Policy** — restrict which buckets can be accessed through the endpoint:
```json
{
  "Effect": "Allow",
  "Principal": "*",
  "Action": ["s3:GetObject", "s3:PutObject"],
  "Resource": "arn:aws:s3:::my-bucket/*"
}
```

3. **Route Table:** Ensure the S3 Gateway Endpoint is in the route table for the private subnets. AWS automatically adds a route for S3 prefixes via the endpoint.

**Verification (no traffic via NAT):**
- **VPC Flow Logs** — check for traffic to S3 public IP ranges (available from `ip-ranges.json`) from the NAT Gateway ENI. If you see traffic to S3 IPs through NAT, the endpoint isn't being used.
- **CloudTrail S3 data events** — the `vpcEndpointId` field in CloudTrail shows which VPC endpoint was used. If this field is absent, the request went over the internet.
- **S3 server access logs** — check the `Remote IP` field.

---

## Q18. Micro-Segmentation with Security Groups for Pods

**Answer:**

**Security Groups for Pods (SGP):**
- Available on **EKS with Nitro-based instances** (not Fargate).
- Assign specific SGs to pods based on a `SecurityGroupPolicy` CRD:
```yaml
apiVersion: vpcresources.k8s.aws/v1beta1
kind: SecurityGroupPolicy
metadata:
  name: payments-sg-policy
  namespace: payments
spec:
  podSelector:
    matchLabels:
      app: payments
  securityGroups:
    groupIds:
      - sg-payments-pods
```
- Create `sg-payments-pods` that only allows traffic to/from `sg-database-pods` on the DB port.

**SGP vs Kubernetes Network Policies:**
| Feature | Security Groups for Pods | K8s Network Policies |
|---|---|---|
| **Enforcement** | AWS VPC level (ENI) | CNI plugin level (iptables/eBPF) |
| **Scope** | AWS-native, works with non-K8s AWS resources | K8s-only, within cluster |
| **RDS integration** | ✅ SG can reference RDS SGs directly | ❌ Can't reference AWS resources |
| **Logging** | VPC Flow Logs | CNI-specific logging |

**Limitations of SGP:**
- Only works on Nitro instances (not t2, m4, etc.).
- Maximum 5 SGs per ENI (pod limit).
- Trunk ENI capacity limits the number of pods with SGs per node.
- Doesn't support IPv6 in all configurations.
- **Best practice:** Use SGP for AWS resource access (RDS, ElastiCache) and K8s Network Policies for pod-to-pod traffic.

---

## Q19. DNS-Based Exfiltration Detection

**Answer:**

**Route 53 Resolver DNS Firewall:**
- Create **domain lists** of known-good domains (allow list) and known-bad domains (block list).
- Associate firewall rules with VPCs.
- Block DNS queries to newly registered domains (common in DNS tunneling).
- Use **AWS Managed Domain Lists** for known malware/botnet domains.
- Set action to `BLOCK` with response type `NXDOMAIN` or `OVERRIDE` (redirect to a sinkhole).

**GuardDuty DNS detection:**
- GuardDuty monitors VPC DNS logs (Route 53 Resolver query logs) automatically.
- Detects `Trojan:EC2/DNSDataExfiltration` — identifies DNS queries with unusually long or high-entropy subdomains (e.g., `base64encodeddata.malicious.com`).
- Detects `Backdoor:EC2/DenialOfService.Dns` — DNS amplification attacks.

**VPC Flow Log patterns for DNS tunneling:**
- Unusual volume of DNS traffic (UDP 53) from a single instance.
- Large DNS response sizes (normal DNS responses < 512 bytes; tunneling often > 1000 bytes).
- High frequency of DNS queries to a single domain with varying subdomains.
- To capture DNS: enable **Route 53 Resolver Query Logging** — this gives you the actual domain names, which Flow Logs don't capture (Flow Logs only show IPs and ports).

---

## Q20. Hybrid Network Security (VPN + Direct Connect)

**Answer:**

**Encrypting traffic over Direct Connect:**
- Direct Connect provides a **private, dedicated connection** but is **NOT encrypted** by default — traffic traverses AWS's network, not the public internet, but it's still unencrypted on the wire.
- **Option 1:** Create a **Site-to-Site VPN over Direct Connect** — run an IPsec VPN tunnel over the DX connection using a Direct Connect public VIF. This gives you encryption + private connectivity.
- **Option 2:** Use **MACsec** (IEEE 802.1AE) — available on 10 Gbps and 100 Gbps dedicated connections. Provides Layer 2 encryption directly on the DX port. This is the highest-performance option.
- **Option 3:** Application-level encryption (TLS) — encrypt at the application layer regardless of the transport.

**Direct Connect Gateway with Transit VIF:**
- Create a **Direct Connect Gateway** and associate it with your **Transit Gateway**.
- Create a **Transit Virtual Interface (VIF)** on the DX connection.
- This allows your on-premises network to reach **multiple VPCs across multiple regions** through a single DX connection → DX Gateway → Transit Gateway.
- Attach VPCs to the Transit Gateway to give them on-prem connectivity.

**Monitoring VPN failover:**
- **CloudWatch metrics** for VPN: `TunnelState` (UP/DOWN), `TunnelDataIn`, `TunnelDataOut`.
- Set **CloudWatch Alarm** on `TunnelState = 0` (down) → SNS notification.
- When DX fails and traffic fails over to VPN:
  - Latency increases (VPN over internet vs DX).
  - Throughput drops (VPN ~1.25 Gbps vs DX 10+ Gbps).
  - **Security implication:** Traffic now traverses the public internet — ensure IPsec is properly configured with strong ciphers (AES-256, SHA-256, DH group 20+).
- Monitor **BGP route changes** in Transit Gateway route tables to detect failover events.

---

# Section 3 — S3 & Data Security (Q21–Q27) — Answers

---

## Q21. S3 Bucket Containing PHI Exposed Publicly

**Answer:**

**Immediate remediation:**
1. **Block public access** — apply `S3 Block Public Access` at the **bucket level** immediately:
   - `BlockPublicAcls: true`, `IgnorePublicAcls: true`, `BlockPublicPolicy: true`, `RestrictPublicBuckets: true`.
2. **Remove the offending ACL** — reset bucket ACL to `private`.
3. **Verify** — use `aws s3api get-bucket-acl` and `get-bucket-policy-status` to confirm it's no longer public.

**Determining if data was accessed:**
- **CloudTrail S3 data events** (must be enabled): Query for `GetObject` calls on the bucket. Filter by:
  - `sourceIPAddress` — any external IPs?
  - `userIdentity` — any anonymous (`Principal: *`) access?
  - Time range — from when the ACL was changed to when you remediated.
- **S3 server access logs** (if enabled): Show all requests including anonymous ones.
- If data events weren't enabled, you may not have evidence — this is a gap. **Lesson:** Always enable CloudTrail data events for PHI buckets.

**S3 Block Public Access — account vs bucket:**
- **Account-level** BPA: Overrides all bucket-level settings. If enabled at account level, NO bucket in the account can be public — even if a bucket policy says otherwise.
- **Bucket-level** BPA: Applies only to that specific bucket.
- **Best practice:** Enable BPA at the **account level** (or via SCP) and only create exceptions for known-public buckets (like static website hosting).

**HIPAA breach notification:**
- If PHI was accessed by unauthorized parties, this is a **reportable breach** under HIPAA.
- **60-day notification window** to affected individuals.
- If >500 individuals affected, must also notify **HHS (Dept. of Health and Human Services)** and **prominent media outlets**.
- Document the breach, cause, data involved, and remediation in a formal report.

---

## Q22. S3 Cross-Region Replication Security

**Answer:**

**Encryption during replication:**
- **SSE-S3 (AES-256):** Replication works seamlessly. AWS automatically re-encrypts with SSE-S3 in the destination region.
- **SSE-KMS:** More complex. You must specify a **destination KMS key** in the replication configuration because KMS keys are region-specific.
  - The replication role needs `kms:Decrypt` on the source key and `kms:Encrypt` on the destination key.
  - You can use an **AWS-managed KMS key** in the destination region, or create a **customer-managed key** for more control.
```json
{
  "ReplicaKmsKeyID": "arn:aws:kms:eu-west-1:123456789012:key/dest-key-id"
}
```

**KMS cross-region implications:**
- KMS keys cannot be replicated across regions. You need **separate keys per region**.
- This means the key policy, grants, and IAM permissions must be configured **separately in each region**.
- If using **AWS-managed keys** (`aws/s3`), you cannot control the key policy — use customer-managed CMKs for fine-grained access control.

**Data residency / PCI jurisdictional issues:**
- PCI DSS doesn't explicitly restrict data geography, but your **PCI QSA (Qualified Security Assessor)** may have opinions on where cardholder data can reside.
- **GDPR:** Replicating to EU is fine from a US compliance perspective, but replicating EU data to certain countries may violate GDPR.
- **Recommendation:** Get legal/compliance approval before configuring cross-region replication for PCI-scoped data. Document the business justification (BCDR requirement) and ensure both regions have equivalent security controls.

---

## Q23. S3 Object Lock for Compliance

**Answer:**

**S3 Object Lock configuration:**
- **Governance mode:** Objects can't be deleted or overwritten by *most* users, but users with `s3:BypassGovernanceRetention` permission can override. Good for testing or when you need administrative flexibility.
- **Compliance mode:** NO ONE can delete or overwrite the object during the retention period — not even the root user. Object is truly immutable. Once set, the retention period **cannot be shortened**, only extended.

**For CloudTrail audit logs → use Compliance mode:**
- Set retention period to **7 years (2555 days)**.
- Once applied, the logs are WORM (Write Once Read Many).

**Can root delete in Compliance mode?** **NO.** Not even the root user, not even AWS Support. The only way to remove the objects is to wait for the retention period to expire. You can also delete the entire AWS account, but the objects remain for 90 days even after account closure.

**Configuration steps:**
1. Create the bucket with Object Lock enabled (can only be set at bucket creation time).
2. Set a **default retention** configuration: Compliance mode, 2555 days.
3. Enable **versioning** (required for Object Lock).
4. Set the bucket as the **CloudTrail destination** in the Organization Trail.
5. Add a **bucket policy** denying `s3:DeleteObject`, `s3:PutBucketPolicy`, and `s3:DeleteBucket` for extra protection.
6. Apply **S3 Block Public Access** at account level.

---

## Q24. Macie for Sensitive Data Discovery

**Answer:**

**Multi-account Macie setup:**
- Designate a **delegated administrator account** (typically the security/audit account) in AWS Organizations.
- From the admin account, enable Macie on all member accounts.
- Create **classification jobs** that scan S3 buckets across all 10 accounts.
- Findings are aggregated in the admin account.

**How Macie classifies data:**
- **Managed data identifiers:** Built-in ML models and pattern matching for ~100+ data types: SSN, credit card numbers, AWS keys, email addresses, medical record numbers, etc.
- **Custom data identifiers:** Regex + keyword combinations for domain-specific data:
  - Healthcare payment data examples:
    - `NPI (National Provider Identifier)`: regex `\b\d{10}\b` with keyword proximity to "NPI", "provider"
    - `CPT codes`: regex `\b\d{5}\b` near "CPT", "procedure"
    - `ICD-10 codes`: regex `\b[A-Z]\d{2}\.?\d{0,4}\b` near "diagnosis", "ICD"
    - `Member ID`: your organization's specific format

**Handling false positives:**
- **Suppression rules:** Create rules to automatically archive findings matching specific criteria (e.g., test data buckets, known non-sensitive data patterns).
- **Severity thresholds:** Only alert on Medium/High severity findings.
- **Allow lists:** Provide Macie with known-safe text (e.g., test credit card numbers `4111-1111-1111-1111`) to suppress matching.
- **Review and refine** custom data identifiers' regex patterns and keyword lists to improve accuracy.

---

## Q25. Presigned URL Abuse

**Answer:**

**How presigned URLs work:**
- The application (using IAM credentials or role) calls `s3.generate_presigned_url()` with: bucket, key, expiration time, and HTTP method (PUT for upload, GET for download).
- The URL contains a **signature** derived from the IAM credential — anyone with the URL can perform the action without AWS credentials.
- Validity is controlled by `ExpiresIn` parameter (default 3600 seconds) AND the validity of the signing credential.

**Limiting blast radius:**
- **Short expiration:** Set `ExpiresIn` to the minimum viable time (e.g., 300 seconds / 5 minutes for upload).
- **Unique object keys:** Generate unique S3 keys per upload (e.g., `uploads/{user-id}/{uuid}.pdf`) so URLs can't be reused for different objects.
- **IP restriction in bucket policy:**
```json
{
  "Effect": "Deny",
  "Principal": "*",
  "Action": "s3:PutObject",
  "Resource": "arn:aws:s3:::my-bucket/uploads/*",
  "Condition": {
    "NotIpAddress": { "aws:SourceIp": ["mobile-client-cidr"] }
  }
}
```
- **Content-type and size limits:** Use presigned POST policies (not presigned URLs) which support conditions like `content-length-range` and `Content-Type`.
- **One-time use pattern:** After successful upload, trigger a Lambda to move the object to a permanent location and make the original presigned key invalid.

**Auditing via CloudTrail:**
- Enable **S3 data events** in CloudTrail.
- Presigned URL requests appear as normal S3 API calls but with the **signing IAM identity** as the principal.
- Filter by `sourceIPAddress` to detect access from unexpected locations.

---

## Q26. S3 Bucket Policy vs IAM Policy vs ACL

**Answer:**

**When to use what:**
| Mechanism | Best For | Scope |
|---|---|---|
| **IAM Policy** | Granting permissions to AWS principals you control | Per identity (user/role) |
| **Bucket Policy** | Resource-based access, cross-account, public access, VPC restrictions | Per bucket |
| **ACL** | **Legacy — avoid.** Only for S3 log delivery pre-2023 | Per object or bucket |

**For the partner scenario:** Use a **bucket policy** with cross-account trust:
```json
{
  "Effect": "Allow",
  "Principal": { "AWS": "arn:aws:iam::PARTNER-ACCOUNT:role/DropRole" },
  "Action": "s3:PutObject",
  "Resource": "arn:aws:s3:::my-bucket/partner-drops/*",
  "Condition": {
    "StringEquals": { "s3:x-amz-acl": "bucket-owner-full-control" }
  }
}
```

**Bucket Owner Enforced (Object Ownership):**
- With **"Bucket owner enforced"**, ACLs are disabled entirely. All objects in the bucket are automatically owned by the bucket owner, regardless of who uploaded them.
- This is the **recommended setting** as of 2023. It eliminates the "object ownership" problem where cross-account uploads resulted in the uploader owning the object.
- Before this setting, you had to require uploaders to set `bucket-owner-full-control` ACL on every put — fragile and often forgotten.

---

## Q27. Versioning and MFA Delete

**Answer:**

**S3 versioning protection:**
- With versioning enabled, a `DeleteObject` call doesn't actually delete the data — it places a **delete marker** on top. The previous versions are preserved.
- To permanently delete a version, you must call `DeleteObject` with the specific `versionId`.

**MFA Delete:**
- An additional protection that requires **MFA authentication** to: (1) permanently delete an object version, or (2) change the versioning state of the bucket.
- Can only be enabled by the **root account** using the AWS CLI (not Console):
```bash
aws s3api put-bucket-versioning --bucket my-bucket \
  --versioning-configuration Status=Enabled,MFADelete=Enabled \
  --mfa "arn:aws:iam::123456789012:mfa/root-mfa 123456"
```

**Recovery from insider deletion:**
- If delete markers were placed: Simply delete the delete marker to restore the objects.
- If versions were permanently deleted: Not recoverable from S3 alone — restore from cross-region replica or backup.
- **List versions:** `aws s3api list-object-versions --bucket my-bucket` to see all versions including delete markers.

**Additional controls against insider threats:**
- **SCP** denying `s3:DeleteObject` and `s3:PutBucketVersioning` for all non-admin roles.
- **S3 Object Lock (Compliance mode)** — even admins can't delete during retention period.
- **Cross-region replication** to a different account — insider in one account can't access the other.
- **CloudTrail alerting** on `DeleteObject` API calls on critical buckets.$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Answers_Section4_Encryption_Section5_Logging$VELSEC$, $VELSEC$Answers Section4 Encryption Section5 Logging$VELSEC$, $VELSEC$Security Engineer$VELSEC$, ARRAY['Cloud_Security']::TEXT[], $VELSEC$# Section 4 — Encryption & KMS (Q28–Q33) — Answers

---

## Q28. KMS Key Policy vs IAM Policy

**Answer:**

**Key policy + IAM policy interaction:**
- KMS is unique: the **key policy is the primary access control**. Unlike most AWS services, IAM policies alone are NOT sufficient — the key policy must explicitly allow the account to use IAM policies for the key (via the "root" statement).
- For **cross-account access**, you need BOTH:
  1. **Key policy** in Account-B: Allow Account-A's role to use the key.
  2. **IAM policy** in Account-A: Allow the developer's role to call KMS actions on the key ARN in Account-B.

**KMS Grants vs Key Policies:**
| Feature | Key Policy | Grant |
|---|---|---|
| **Scope** | Attached directly to the key | Programmatically issued token |
| **Use case** | Long-term, static permissions | Temporary, delegated access |
| **Example** | Account-level or role-level access | AWS services creating encrypted resources (EBS, RDS) |
| **Revocation** | Edit the key policy | `RetireGrant` or `RevokeGrant` |
- AWS services (like EBS, RDS) use **grants** under the hood when they need to use a CMK — you'll see `CreateGrant` calls in CloudTrail.

**Key KMS actions explained:**
| Action | Purpose |
|---|---|
| `kms:Encrypt` | Encrypt data directly (up to 4 KB) |
| `kms:Decrypt` | Decrypt ciphertext |
| `kms:GenerateDataKey` | Generate a unique data key for envelope encryption — returns both plaintext and encrypted copies |
| `kms:GenerateDataKeyWithoutPlaintext` | Same but without the plaintext copy (for later use) |
| `kms:CreateGrant` | Delegate key usage to an AWS service or principal |
| `kms:ReEncryptFrom/To` | Re-encrypt data under a different key without exposing plaintext |

---

## Q29. Encryption at Rest & In Transit (HIPAA-Compliant)

**Answer:**

**Encryption at rest:**

| Component | Encryption Method | Details |
|---|---|---|
| **ECS Fargate (ephemeral storage)** | AES-256 by default (since 2020), or specify KMS CMK for platform version 1.4.0+ | Managed by AWS, no config needed, but use CMK for audit/control |
| **EFS (if used by Fargate)** | SSE-KMS or SSE-EFS | Enable encryption at file system creation, specify CMK |
| **RDS Aurora** | SSE-KMS | Enable at cluster creation, specify CMK. Cannot enable after creation on existing instances |
| **S3** | SSE-KMS (recommended) or SSE-S3 | Set default bucket encryption to SSE-KMS with your CMK |
| **EBS** | AES-256 via KMS | Account-level setting: enable "EBS encryption by default" so all new volumes are encrypted |

**Encryption in transit:**

| Path | Enforcement |
|---|---|
| **Client → ALB** | ACM-issued TLS certificate on ALB. Set TLS 1.2 minimum via security policy (`ELBSecurityPolicy-TLS-1-2-2017-01`) |
| **ALB → ECS** | Configure ALB target group for HTTPS (port 443). ECS task uses a self-signed cert or ACM Private CA cert |
| **ECS → RDS** | RDS Aurora enforces SSL: set `rds.force_ssl = 1` parameter. Application connection string must include `sslmode=verify-full` with the RDS CA certificate |
| **ECS → S3** | Use HTTPS endpoint (default). Add bucket policy condition: `"aws:SecureTransport": "true"` to deny HTTP |

**TLS certificate management:**
- **Public-facing (ALB):** AWS Certificate Manager (ACM) — free, auto-renewal.
- **Internal (ECS ↔ RDS, service-to-service):** **ACM Private CA** — create a private CA, issue internal certificates. Costs $400/month per CA but essential for mTLS in healthcare.

**KMS key accidental deletion:**
- KMS keys have a **mandatory waiting period** of 7-30 days (you choose) before deletion.
- During the waiting period, the key is in "Pending deletion" state — **all encrypt/decrypt operations fail**.
- **Recovery:** Cancel the scheduled deletion within the waiting period: `aws kms cancel-key-deletion --key-id <key-id>`.
- **After deletion:** The key is gone forever. You **cannot recover** the key or any data encrypted with it. EBS volumes, RDS databases, S3 objects — all become permanently inaccessible.
- **Prevention:** SCP denying `kms:ScheduleKeyDeletion` for all non-admin roles. CloudWatch alarm on the API call.

---

## Q30. KMS Key Rotation

**Answer:**

**Automatic rotation:**
- AWS creates new cryptographic material **annually** (365 days).
- The key ID, key ARN, and alias **don't change** — completely transparent to applications.
- **Old key material is preserved indefinitely** so existing ciphertext can still be decrypted.
- Newly encrypted data uses the **new key material**. Existing data is NOT re-encrypted — this is important.
- Automatic rotation only works for **symmetric CMKs**, not asymmetric or HMAC keys.

**Automatic vs Manual rotation:**
| | Automatic | Manual |
|---|---|---|
| **Frequency** | Annual (fixed) | Any schedule |
| **Key ID changes** | No | Yes (new key, new ARN) |
| **Old data** | Auto-decrypted (old material preserved) | Must update references or use aliases |
| **Effort** | Zero | High (update all references) |
| **Compliance** | May not satisfy "rotate annually" literal requirement | Full control |

**Rotating keys without downtime:**
- **EBS:** Automatic rotation is transparent — existing volumes continue to work. New volumes use new material. To re-encrypt existing volumes: create a snapshot → copy with new key → create new volume.
- **RDS:** Cannot change the KMS key on an existing instance. To rotate: create an encrypted snapshot → restore the snapshot specifying the new key → switch traffic to the new instance.
- **S3:** Automatic rotation handles new `PutObject` calls. For existing objects, use **S3 Batch Operations** to copy objects in-place, which re-encrypts with the new key material.

---

## Q31. Envelope Encryption Deep Dive

**Answer:**

**Step-by-step for a 10 GB S3 file (SSE-KMS):**

1. S3 calls KMS `GenerateDataKey` with your CMK → KMS returns TWO copies of a **unique data key**:
   - **Plaintext data key** (256-bit symmetric key)
   - **Encrypted data key** (the same key, encrypted under your CMK)

2. S3 uses the **plaintext data key** to encrypt the 10 GB file using AES-256-GCM.

3. S3 **discards the plaintext data key from memory** immediately after encryption.

4. S3 **stores the encrypted data key alongside the encrypted file** as object metadata.

5. **Decryption:** S3 retrieves the encrypted data key from metadata → calls KMS `Decrypt` → gets the plaintext data key → decrypts the file → discards the plaintext key.

**Why not encrypt directly with the CMK?**
- KMS `Encrypt` API has a **4 KB limit** — you physically cannot send 10 GB to KMS for encryption.
- KMS operations are **network calls** to the KMS service — encrypting 10 GB directly would be incredibly slow.
- Data encryption happens **locally** (within S3's infrastructure) using the data key, which is fast (AES hardware acceleration).
- KMS only handles the small **key encryption/decryption** operations.

**How envelope encryption solves the 4 KB limit:**
- The data key IS less than 4 KB (256 bits = 32 bytes), so it fits within the KMS `Encrypt`/`Decrypt` size limit.
- The actual data (10 GB) is encrypted locally using that data key with efficient symmetric encryption (AES).
- This is called "envelope" encryption because the data key is "enveloped" (wrapped) by the CMK.

---

## Q32. CloudHSM vs KMS

**Answer:**

**FIPS 140-2 Levels:**
| Service | FIPS 140-2 Level | Details |
|---|---|---|
| **KMS** | Level 2 (standard) / Level 3 (some regions) | AWS manages the HSMs. Most regions are Level 3 as of 2023 |
| **CloudHSM** | Level 3 (always) | Customer-managed, dedicated HSMs |

**PCI DSS answer:** Modern KMS IS validated to FIPS 140-2 Level 3 in most regions. However, if your compliance team or QSA specifically requires **customer-controlled, dedicated HSMs**, then CloudHSM is the answer.

**When to use CloudHSM:**
- Regulatory requirement for **dedicated, single-tenant HSMs** (not shared infrastructure).
- Need for **custom key store** — full control over key generation, storage, and lifecycle.
- Require **PKCS#11, JCE, or CNG** interfaces for application-level crypto.
- Need to perform non-AWS crypto operations (code signing, custom TLS offloading, Oracle TDE).
- Requirements to generate keys in a way that AWS never has access to the plaintext key material.

**CloudHSM + KMS integration (Custom Key Store):**
- Create a **KMS Custom Key Store** backed by a CloudHSM cluster.
- KMS CMKs are stored in YOUR CloudHSM cluster instead of AWS-managed HSMs.
- Applications use standard KMS APIs, but the actual cryptographic operations happen in your CloudHSM.
- **Best of both worlds:** KMS API simplicity + CloudHSM security assurance.
- **Trade-off:** Higher cost ($1.60/hr per HSM, minimum 2 for HA = ~$2,300/month), higher operational complexity.

---

## Q33. Data Key Caching & Performance

**Answer:**

**KMS request quotas:**
- Default: **5,500 requests/second** for symmetric CMKs per region (shared across `Encrypt`, `Decrypt`, `GenerateDataKey`).
- Can be increased via service quota request, but there are practical limits.
- Each Lambda invocation calling `kms:Decrypt` = 1 KMS API call. 1,000 concurrent Lambdas = 1,000 requests/second.

**AWS Encryption SDK data key caching:**
```python
import aws_encryption_sdk
from aws_encryption_sdk.caches import LocalCryptoMaterialsCache

cache = LocalCryptoMaterialsCache(capacity=100)
caching_cmm = CachingCryptoMaterialsManager(
    master_key_provider=kms_key_provider,
    cache=cache,
    max_age=300.0,          # Cache keys for 5 minutes
    max_messages_encrypted=1000,  # Re-use key for up to 1000 messages
    max_bytes_encrypted=10000000  # Re-use key for up to 10 MB
)
```
- Instead of calling KMS `GenerateDataKey` for every encrypt operation, the SDK **caches the data key** locally and reuses it for multiple operations.
- Dramatically reduces KMS API calls — from 1000/sec to perhaps 10/sec.

**Security trade-offs:**
| Pro | Con |
|---|---|
| Reduces KMS API calls and latency | Same data key encrypts multiple messages — if compromised, more data is exposed |
| Avoids throttling errors | Cached plaintext key in memory — memory dump attack vector |
| Lower cost (fewer KMS calls) | Stale key if CMK is rotated or revoked — cached key still works |

**Mitigations:**
- Set aggressive `max_age` (short cache duration, e.g., 5 minutes).
- Set `max_messages_encrypted` to limit blast radius.
- Set `max_bytes_encrypted` to limit total data exposure.
- Use **Lambda reserved concurrency** to limit the number of concurrent caches.

---

# Section 5 — Logging, Monitoring & Detection (Q34–Q40) — Answers

---

## Q34. CloudTrail Multi-Account Configuration

**Answer:**

**Organization Trail setup:**
1. In the **management account**, create a trail with "Enable for all accounts in my organization" = Yes.
2. Specify an S3 bucket in a dedicated **logging account** (not the management account).
3. Enable **multi-region trail** to capture API calls in all regions.
4. Enable **CloudTrail Insights** for anomaly detection on write APIs.

**Protecting the logging bucket:**
- Logging bucket is in a **separate, locked-down account** with no general access.
- **S3 bucket policy:** Only CloudTrail service principal can write. Deny delete for all principals.
- **S3 Object Lock (Compliance mode):** 7-year retention — nobody can delete.
- **MFA Delete** enabled on the bucket.
- **S3 Block Public Access** at account level.
- **Cross-region replication** to a third account for redundancy.

**Preventing CloudTrail disable:**
- **SCP at Organization level:**
```json
{
  "Effect": "Deny",
  "Action": [
    "cloudtrail:StopLogging",
    "cloudtrail:DeleteTrail",
    "cloudtrail:UpdateTrail",
    "cloudtrail:PutEventSelectors"
  ],
  "Resource": "*"
}
```
- This prevents anyone in any member account from stopping or modifying CloudTrail.

**Management vs Data events:**
| Type | Examples | Cost |
|---|---|---|
| **Management events** | `RunInstances`, `CreateBucket`, `AttachRolePolicy` | Free (first trail) |
| **Data events** | `s3:GetObject`, `s3:PutObject`, `lambda:Invoke` | ~$0.10 per 100,000 events |
- Data events are critical for PHI/PCI audit trails but can be expensive. Enable selectively on sensitive buckets/functions.

---

## Q35. GuardDuty Finding Triage

**Answer:**

**`UnauthorizedAccess:IAMUser/InstanceCredentialExfiltration.OutsideAWS` meaning:**
- EC2 instance credentials (from the instance metadata service) are being used from an **IP address outside AWS**. This means someone copied the temporary credentials from the instance and is using them from a non-AWS location — strong indicator of compromise.

**Triage process:**
1. **Identify the instance:** Finding includes the instance ID, IAM role ARN, and the external IP using the credentials.
2. **Check CloudTrail:** Search for all API calls using the session credential (look for `userIdentity.type: AssumedRole` matching the instance role, from the external IP).
3. **Assess damage:** What actions were performed? Data access, IAM changes, resource creation?
4. **Isolate the instance:**
   - Replace the instance's Security Group with a **quarantine SG** (deny all inbound/outbound except forensic access).
   - **Do NOT terminate** — preserve for forensics.
5. **Revoke the credential:** Modify the IAM role to add a deny-all policy with a `DateLessThan` condition on `aws:TokenIssueTime` to invalidate all current sessions.
6. **Investigate how credentials were exfiltrated:** Was IMDS v1 used (SSRF attack)? Was there a vulnerability in the application?

**Automated response with EventBridge → Lambda:**
```
EventBridge Rule:
  Source: "aws.guardduty"
  Detail-type: "GuardDuty Finding"
  Detail:
    type: ["UnauthorizedAccess:IAMUser/InstanceCredentialExfiltration.OutsideAWS"]

→ Lambda function:
  1. Extract instance ID from finding
  2. Swap SG to quarantine SG
  3. Snapshot EBS volumes for forensics
  4. Notify security team via SNS
  5. Create JIRA/ServiceNow incident ticket
```

---

## Q36. Security Hub & Custom Standards

**Answer:**

**Setup with multiple standards:**
- Enable Security Hub in the delegated admin account.
- Turn on compliance standards: **CIS AWS Foundations Benchmark v1.4**, **AWS Foundational Security Best Practices**, **PCI DSS**, **NIST 800-53**.
- Each standard generates findings mapped to specific controls. A single resource can have findings across multiple standards.

**Custom insights:**
- Security Hub **insights** are saved filters for findings. Create custom insights:
  - "All CRITICAL findings in production accounts"
  - "All failed PCI DSS controls in the payments OU"
  - "Resources with most failed controls (top 10)"

**Custom controls:**
- Use **AWS Config custom rules** (Lambda-backed) for organization-specific checks.
- Security Hub automatically imports Config rule evaluation results as findings.
- Example custom rule: "All RDS instances must have `deletion_protection` enabled in production."

**Multi-account, multi-region aggregation:**
- Designate an **aggregation region** (e.g., `us-east-1`).
- Enable **cross-region aggregation** — findings from all regions flow to the aggregation region.
- Use **delegated admin** to aggregate findings from all member accounts.
- Result: Single-pane-of-glass view across all accounts and regions.

---

## Q37. CloudWatch Alarms for Security Events

**Answer:**

**Metric filters for each event (on the CloudTrail log group):**

**1. Root account usage:**
```
{ $.userIdentity.type = "Root" && $.userIdentity.invokedBy NOT EXISTS && $.eventType != "AwsServiceEvent" }
```

**2. Unauthorized API calls:**
```
{ ($.errorCode = "*UnauthorizedAccess") || ($.errorCode = "AccessDenied*") }
```

**3. Security Group changes:**
```
{ ($.eventName = AuthorizeSecurityGroupIngress) || ($.eventName = AuthorizeSecurityGroupEgress) || ($.eventName = RevokeSecurityGroupIngress) || ($.eventName = RevokeSecurityGroupEgress) || ($.eventName = CreateSecurityGroup) || ($.eventName = DeleteSecurityGroup) }
```

**4. S3 bucket policy changes:**
```
{ ($.eventName = PutBucketPolicy) || ($.eventName = PutBucketAcl) || ($.eventName = PutBucketCors) || ($.eventName = PutBucketLifecycle) || ($.eventName = PutBucketReplication) || ($.eventName = DeleteBucketPolicy) }
```

**SNS notification workflow:**
- Each metric filter → CloudWatch Alarm (threshold ≥ 1 in 5 minutes) → SNS Topic → Security team email + PagerDuty + Slack.
- For critical alerts (root usage, SG changes): immediate PagerDuty page.
- For informational (unauthorized API calls): batch into daily digest.

**CIS Benchmark alignment:** These filters directly map to CIS AWS Foundations Benchmark v1.4 controls 4.1-4.15. Implementing all CIS-recommended metric filters is a common Security Hub compliance requirement.

---

## Q38. SIEM Integration (Splunk)

**Answer:**

**Architecture per log source:**

| Log Source | Delivery Path | Details |
|---|---|---|
| **CloudTrail** | S3 → SQS → Splunk Add-on for AWS | CloudTrail delivers JSON to S3; Splunk polls SQS notifications |
| **VPC Flow Logs** | CloudWatch Logs → Kinesis Firehose → Splunk HEC | Near real-time; Firehose handles buffering/batching |
| **GuardDuty** | EventBridge → Kinesis Firehose → Splunk HEC | Event-driven, low latency |
| **WAF Logs** | Kinesis Firehose → Splunk HEC | WAF natively supports Firehose delivery |
| **Config** | SNS → SQS → Splunk Add-on | Config change notifications |

**Push (Firehose → HEC) vs Pull (SQS → Add-on):**
| | Push (Firehose → HEC) | Pull (Splunk Add-on → SQS/S3) |
|---|---|---|
| **Latency** | Near real-time (60 sec buffer) | 5-10 minute polling intervals |
| **Reliability** | Firehose handles retries, backup to S3 | Splunk manages polling |
| **Cost** | Firehose data processing fees | SQS (cheap) + S3 GET requests |
| **Best for** | High-volume, real-time (Flow Logs, WAF) | Lower-volume, batch OK (CloudTrail, Config) |

**Cost at scale:**
- VPC Flow Logs are the highest volume — enable selectively (reject-only, or specific ENIs).
- Use **Firehose data transformation** Lambda to filter/enrich before delivery — reduce Splunk ingestion volume.
- Apply **Splunk index-time filters** to drop noise.
- Consider **S3-based ingestion** for historical/cold data (cheaper than real-time).

---

## Q39. Detecting Cryptomining

**Answer:**

**GuardDuty detection:**
- GuardDuty monitors **DNS queries** from EC2 instances. It maintains a database of known cryptocurrency mining pool domains.
- `CryptoCurrency:EC2/BitcoinTool.B!DNS` = the instance is making DNS queries to known Bitcoin mining pool domains.
- GuardDuty also detects via **VPC Flow Logs** — unusual outbound traffic patterns to mining pool IPs.

**Immediate containment:**
1. **Identify the instance** from the GuardDuty finding.
2. **Isolate** — swap Security Group to quarantine SG (block all outbound).
3. **Snapshot the EBS volume** for forensic analysis.
4. **Stop the instance** (not terminate — preserve evidence).
5. **Investigate:**
   - How was the instance compromised? (Check for exposed SSH keys, vulnerable applications, SSRF).
   - Was it a compromised application or a malicious insider who launched mining software?
   - Check CloudTrail for `RunInstances` — was this an unauthorized instance?

**Prevention:**
- **SCP restricting instance types:** Deny `ec2:RunInstances` for GPU instances (p3, p4, g4 families) and large compute instances unless approved.
- **AWS Config rule** for approved instance types in each account.
- **Cost anomaly detection** (AWS Cost Anomaly Detection) with tight thresholds.
- **Spot Instance limits** — set account-level limits on spot instances.
- **IMDSv2 enforcement** — prevents SSRF-based credential theft that often leads to cryptomining.
- **Inspector** for vulnerability scanning to catch the entry point.

---

## Q40. Config Rules for Continuous Compliance

**Answer:**

**AWS Config managed rules for each requirement:**

| Requirement | Config Rule | Rule Identifier |
|---|---|---|
| All EBS encrypted | `encrypted-volumes` | ENCRYPTED_VOLUMES |
| All S3 versioned | `s3-bucket-versioning-enabled` | S3_BUCKET_VERSIONING_ENABLED |
| All RDS Multi-AZ | `rds-multi-az-support` | RDS_MULTI_AZ_SUPPORT |
| No SG `0.0.0.0/0` on port 22 | `restricted-ssh` | INCOMING_SSH_DISABLED |

**Auto-remediation with SSM:**
1. **Config Rule** detects non-compliant resource.
2. Config triggers a **remediation action** — an **SSM Automation document**.
3. Example for unencrypted EBS: SSM document creates an encrypted snapshot, creates a new encrypted volume, detaches old volume, attaches new encrypted volume.
4. Example for open SSH SG: SSM document calls `ec2:RevokeSecurityGroupIngress` to remove the `0.0.0.0/0:22` rule.

**Conformance packs vs individual rules:**
| | Individual Rules | Conformance Packs |
|---|---|---|
| **Scope** | Single rule | Bundle of rules (10-100+) |
| **Deployment** | One at a time | Deploy all at once via YAML template |
| **Use case** | Custom, specific checks | Compliance frameworks (CIS, PCI, HIPAA) |
| **Cross-account** | Manual per account | Deploy via Organizations (delegated admin) |
| **Example** | `restricted-ssh` | `Operational-Best-Practices-for-HIPAA-Security` |

**Best practice:** Use **conformance packs** for baseline compliance (HIPAA, PCI), then add **individual custom rules** for organization-specific requirements.$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

COMMIT;
