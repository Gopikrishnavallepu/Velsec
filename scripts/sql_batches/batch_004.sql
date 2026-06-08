-- Batch 4: 10 notes
BEGIN;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$PART_7A_EXECUTIVE_PAGE_DETAILED$VELSEC$, $VELSEC$Part 7A Executive Page Detailed$VELSEC$, $VELSEC$Data Analyst$VELSEC$, ARRAY['Data_Analytics']::TEXT[], $VELSEC$# 📊 PART 7A: Build Executive Summary Page — Detailed Step-by-Step

> **Time:** 20-30 minutes for complete Page 1
> **Order:** Build cards first (top), then chart (left), then table (bottom-right)
> **Save after each section** (Ctrl+S)

---

## SECTION 1: Add Title + 4 KPI Cards

### Step 1.1: Add Page Title

In Power BI, you should see:
- **Report canvas** (large blank area on right)
- **Ribbon** (top with Home, Insert, etc.)
- **Fields panel** (right side with table names)

1. Click **Insert** ribbon → **Text Box**
2. Click-drag a box at the very top (span full width)
3. Type: `Executive Security Dashboard`
4. Format:
   - Font size: 28
   - Bold: Yes
   - Color: Dark blue

✅ **Result:** Large title at top of page

---

### Step 1.2: Add Card 1 — Total Findings

1. Click **Insert** → **Card**
2. A blank card appears on canvas
3. Look at **Fields panel** (right) → expand **Measures** folder
4. **Drag** `Total Findings` measure onto the card
   - (Card should auto-populate with a number like "50")
5. Click on the card → **Format** (paintbrush icon in ribbon)
   - Title: turn **ON** → "Total Findings"
   - Font size: 14
   - Data: Number format to **Whole Number**
6. Resize card to ~250px wide × 150px tall
7. Position: top-left area below title

✅ **Result:** Card showing "50" or similar with title "Total Findings"

---

### Step 1.3: Add Card 2 — Open Findings

Repeat exactly like Step 1.2, but:
1. Click **Insert** → **Card**
2. Drag `Open Findings` (from Measures) onto this new card
3. Format title: "Open Findings"
4. Position: next to Card 1 (same row)

✅ **Result:** Card showing "40" or similar

---

### Step 1.4: Add Card 3 — Critical Open

Repeat:
1. Click **Insert** → **Card**
2. Drag `Critical Open` onto this card
3. Title: "Critical Open"
4. Position: row 1, third position

✅ **Result:** Card showing "8" or similar

---

### Step 1.5: Add Card 4 — SLA Compliance %

Repeat:
1. Click **Insert** → **Card**
2. Drag `SLA Compliance %` onto this card
3. Title: "SLA Compliance %"
4. Position: row 1, far right

✅ **Result:** Card showing percentage like "50%" or "48%"

---

### Expected Layout After Step 1:

```
┌─────────────────────────────────────────────────────────────┐
│            Executive Security Dashboard                      │
├─────────────┬──────────────┬──────────────┬──────────────────┤
│  Total      │    Open      │   Critical   │   SLA Compliance │
│ Findings    │  Findings    │    Open      │       %          │
│     50      │      40      │       8      │       50%        │
└─────────────┴──────────────┴──────────────┴──────────────────┘
```

---

## SECTION 2: Add Bar Chart (Findings by Severity)

### Step 2.1: Insert Bar Chart

1. Click **Insert** → **Bar Chart** (horizontal bars)
2. A blank chart appears on canvas below the cards
3. Position below the 4 cards, spanning **left half** of page

---

### Step 2.2: Configure the Chart

**On the CANVAS:** chart is blank — we need to add data

**In FIELDS PANEL (right side):**

1. Expand **Findings** table (click arrow)
2. Find column **severity**
   - Drag `severity` → drop it on **Axis** area (bottom-left of chart)
   - ✅ Chart shows 4 bars: CRITICAL, HIGH, MEDIUM, LOW
3. Expand **Measures** table
4. Find **Total Findings** measure
   - Drag `Total Findings` → drop it on **Value** area
   - ✅ Bars now show counts (e.g., CRITICAL = 11, HIGH = 16, etc.)

---

### Step 2.3: Format the Chart

1. Click on the chart → **Format** (paintbrush)
   - Title: **ON** → "Findings by Severity"
   - Title Font Size: 16
   - X-axis labels: turn **ON**, size 11
   - Y-axis labels: turn **ON**, size 11
2. Colors:
   - CRITICAL → Red
   - HIGH → Orange
   - MEDIUM → Yellow
   - LOW → Green
   - (Format → Data colors → set each)

✅ **Result:** Horizontal bar chart with labeled bars, title "Findings by Severity"

---

### Step 2.4: Resize and Position

- Drag edges to make it take **left half** (width ~400px)
- Height ~300px
- Position: below cards, left side

---

## SECTION 3: Add Table (Top Open Findings)

### Step 3.1: Insert Table

1. Click **Insert** → **Table**
2. A blank table appears on canvas
3. Position: **right side**, same row as the bar chart

---

### Step 3.2: Add Columns to Table

In **FIELDS PANEL:**

Expand **Findings** table, then drag these columns **one by one** onto the table:
1. `finding_id` (first column)
2. `severity` (second column)
3. `status` (third column, should show "Open")
4. `Days Open` (fourth column, should show age)

✅ **Result:** Table showing 4 columns with all Findings rows

---

### Step 3.3: Add Filters (Show Only Open Findings)

We want to show only `status = "Open"` and oldest first.

1. In the table, look for **Filters** area (above the table)
2. Expand **Findings** → drag `status` to **Filters on this visual**
3. Click the filter → select **"Open"** only → **Apply**
   - ✅ Table now shows only Open findings

4. Click column header **Days Open** → **Sort descending** (down arrow)
   - ✅ Oldest findings appear first

---

### Step 3.4: Format Table

1. Click on table → **Format**
   - Title: **ON** → "Top Open Findings"
   - Title Font Size: 14
   - Row height: 25px
   - Alternate row color: Light gray

---

### Step 3.5: Resize and Position

- Width: ~400px
- Height: ~300px
- Position: right side of page, same row as bar chart

---

## SECTION 4: Final Layout

### Expected page appearance:

```
┌─────────────────────────────────────────────────────────────────┐
│          Executive Security Dashboard                            │
├────────────┬──────────────┬──────────────┬─────────────────────┤
│  Total     │  Open        │  Critical    │  SLA Compliance     │
│ Findings   │ Findings     │  Open        │  %                  │
│    50      │     40       │      8       │      50%            │
├────────────────────────────────────┬──────────────────────────────┤
│                                    │                              │
│   Findings by Severity             │  Top Open Findings           │
│   ▓▓▓▓▓▓▓ CRITICAL (11)           │  ID  │ Severity │ Days Open │
│   ▓▓▓▓▓▓▓▓▓ HIGH (16)             │ W001 │ CRITICAL │    60     │
│   ▓▓▓▓▓▓ MEDIUM (14)              │ W002 │ CRITICAL │    45     │
│   ▓ LOW (5)                        │ W003 │   HIGH   │    38     │
│                                    │ ...  │   ...    │   ...     │
│                                    │                              │
└────────────────────────────────────┴──────────────────────────────┘
```

---

## ✅ CHECKLIST — Page 1 Complete

- [ ] Title added and formatted
- [ ] Card 1: Total Findings (shows ~50)
- [ ] Card 2: Open Findings (shows ~40)
- [ ] Card 3: Critical Open (shows ~8)
- [ ] Card 4: SLA Compliance % (shows ~50%)
- [ ] Bar chart: Findings by Severity (4 bars with colors)
- [ ] Table: Top Open Findings (filtered to Open, sorted by age)
- [ ] All visuals positioned and sized
- [ ] File saved (Ctrl+S)

---

## 🎯 TROUBLESHOOTING

### Problem: "Chart shows no data"
**Solution:**
- Right-click chart → **Reset visual**
- Re-drag fields from Fields panel

### Problem: "Table is empty"
**Solution:**
- Check if `status` filter is set correctly
- Expand Findings filter → check "Open" is selected

### Problem: "Measure shows error"
**Solution:**
- Go to Model view (left sidebar)
- Click Measures table → right-click measure → **Delete**
- Re-add it with exact formula from guide (Part 6)

### Problem: "Cards show 0 or blank"
**Solution:**
- Check your CSV files have data in `PowerBI_Project/data/` folder
- Verify Data view shows rows (not empty)

---

## 🚀 NEXT STEPS

Once Page 1 looks good:
1. **Save** (Ctrl+S)
2. **Add Page 2** (Operational) — click **+** icon at bottom
3. Follow Part 7B for chart + matrix + gauge
4. **Add Page 3** (Risk Analysis) — scatter plot

---

## 📌 Pro Tips

- **Use Format painter** (paintbrush) to copy formatting to other visuals
- **Align visuals** via ribbon: Format → Align → Left/Right/Center
- **Group visuals** together for easier moving
- **Test your slicers** by clicking values in table/chart (should auto-filter)

✅ Ready to build Page 1? Follow each step above and reply with any issues!$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$PART_7B_OPERATIONAL_PAGE_DETAILED$VELSEC$, $VELSEC$Part 7B Operational Page Detailed$VELSEC$, $VELSEC$Data Analyst$VELSEC$, ARRAY['Data_Analytics']::TEXT[], $VELSEC$# 📈 PART 7B: Build Operational Page — Detailed Step-by-Step

> **Time:** 20-30 minutes for complete Page 2
> **Order:** Trend line (top), matrix (bottom-left), gauge (bottom-right)
> **Save after each section** (Ctrl+S)

---

## SECTION 1: Create New Page 2

### Step 1.1: Add a New Page

1. At the bottom of Power BI (where it says "Page 1"), right-click in empty space
2. Click **Insert Page** → **Blank Page**
3. A new page appears → now you're on **Page 2**
4. Rename it: Right-click tab → **Rename** → type `Operational Health`

✅ **Result:** New page tab labeled "Operational Health"

---

### Step 1.2: Add Page Title

1. Click **Insert** → **Text Box**
2. Drag box at top (full width)
3. Type: `Operational Health — SLA & Remediation`
4. Format:
   - Font size: 24
   - Bold: Yes
   - Color: Dark green or teal

✅ **Result:** Title for Page 2

---

## SECTION 2: Add Trend Line Chart (Open vs Closed Findings)

### Step 2.1: Insert Line Chart

1. Click **Insert** → **Line Chart**
2. Position: **full width**, below title, **top half** of page

---

### Step 2.2: Configure Axis (Time)

In **FIELDS PANEL** (right side):

1. Expand **DateTable** folder
2. Drag `YearMonth` → drop on **Axis** area of chart
   - ✅ X-axis now shows months (e.g., 2024-12, 2025-01, etc.)

---

### Step 2.3: Add Two Lines (Open & Closed Trends)

1. Expand **Measures** table
2. Drag `Open Findings` → drop on **Values**
   - ✅ First line appears (blue, showing Open count over time)
3. Drag `Closed Findings` → drop on **Values**
   - ✅ Second line appears (orange, showing Closed count over time)
4. Optional: Drag `Total Findings` → drop on **Values**
   - ✅ Third line (gray, total)

---

### Step 2.4: Format Chart

1. Click chart → **Format** (paintbrush)
   - Title: **ON** → "Findings Opened vs Closed — Monthly Trend"
   - Title Font Size: 14
   - Legend: **ON** (bottom or right)
   - X-axis labels: turn **ON**
   - Y-axis labels: turn **ON**
   - Line style: Solid
   - Data labels: turn **OFF** (for clean look)

2. **Colors** (optional):
   - Open Findings line → Red
   - Closed Findings line → Green
   - Total Findings line → Gray

✅ **Result:** Line chart with 2-3 trends, clear legend, title

---

### Step 2.5: Resize and Position

- Width: **Full page width** (or 95%)
- Height: **250px**
- Position: Top of page, below title

---

## SECTION 3: Add Matrix (SLA Status by Team)

### Step 3.1: Insert Matrix

1. Click **Insert** → **Matrix**
2. Position: **bottom-left**, under the trend line
3. Width: ~45% of page
4. Height: ~250px

---

### Step 3.2: Configure Matrix (Rows & Columns)

**In FIELDS PANEL:**

1. Expand **Tickets** table
2. Drag `assignment_group` → drop on **Rows** area
   - ✅ Matrix shows rows: Infrastructure, Security, Platform, Networking, etc. (your teams)
3. Drag `sla_status` → drop on **Columns** area
   - ✅ Matrix shows columns: Met, Missed, On Track, Breached

---

### Step 3.3: Add Values (Count)

1. Expand **Measures** table
2. Drag `Total Findings` → drop on **Values**
   - ✅ Matrix cells now show counts (Team × SLA Status)

**Example output:**
```
                 Met    Missed  On Track  Breached
Infrastructure    5      2       8         1
Security          3      1       4         2
Platform          2      3       2         1
Networking        0      2       1         0
```

---

### Step 3.4: Format Matrix

1. Click matrix → **Format**
   - Title: **ON** → "SLA Performance by Team"
   - Title Font Size: 12
   - Row headers font size: 11
   - Column headers font size: 11

2. **Conditional formatting** (optional):
   - High values (Met, On Track) → Green background
   - Low values (Missed, Breached) → Red background
   - Format → Conditional Formatting → Background Color

✅ **Result:** Matrix showing team SLA performance

---

## SECTION 4: Add Gauge Chart (SLA Compliance Target)

### Step 4.1: Insert Gauge

1. Click **Insert** → **Gauge Chart**
2. Position: **bottom-right**, same row as matrix
3. Width: ~45% of page
4. Height: ~250px

---

### Step 4.2: Configure Gauge

In **FIELDS PANEL:**

1. Expand **Measures**
2. Drag `SLA Compliance %` → drop on **Value** area
   - ✅ Gauge needle appears pointing to current value

---

### Step 4.3: Set Target & Min/Max

1. Click gauge → **Format**
   - Title: **ON** → "SLA Compliance Goal: 90%"
   - Title Font Size: 12

2. **Gauge settings:**
   - Min: 0
   - Max: 100
   - Target value: 90 (your goal)
   - Current value: auto (from SLA Compliance % measure)

3. **Colors:**
   - Red zone: 0-50 (danger)
   - Yellow zone: 50-80 (caution)
   - Green zone: 80-100 (good)

4. **Data labels**: turn **ON**

✅ **Result:** Gauge showing current SLA % vs 90% target

---

## SECTION 5: Finalize Page 2

### Step 5.1: Add Slicers (Optional but Recommended)

Slicers let viewers filter by category, so they can see data for one team or severity level.

1. Click **Insert** → **Slicer** (dropdown/list)
2. Drag `Findings[severity]` onto it
   - ✅ Shows: CRITICAL, HIGH, MEDIUM, LOW (checkboxes)
   - Users can click to filter all visuals

3. Add another slicer: `Tickets[assignment_group]`
   - ✅ Users can filter by team

Position both slicers on the **right side** below the gauge.

---

### Expected Final Layout (Page 2):

```
┌──────────────────────────────────────────────────────────────┐
│    Operational Health — SLA & Remediation                    │
├──────────────────────────────────────────────────────────────┤
│                                                               │
│   Findings Opened vs Closed — Monthly Trend                  │
│   ┌────────────────────────────────────────────────────────┐ │
│   │  ╱╲       ╱╲        ╱╲      ╱╲                         │ │
│   │ ╱  ╲    ╱    ╲    ╱    ╲  ╱    ╲  (lines trending)    │ │
│   │ ─────────────────────────────────── (X: months)       │ │
│   └────────────────────────────────────────────────────────┘ │
├──────────────────────────────────────┬──────────────────────┤
│  SLA Performance by Team             │  SLA Compliance     │
│  Team│ Met│Missed│On Track│Breached │  Goal: 90%          │
│ Infra│ 5  │ 2   │ 8    │ 1       │    ╱─ ← 50% (needle) │
│ Sec  │ 3  │ 1   │ 4    │ 2       │   │ G │                │
│ Plat │ 2  │ 3   │ 2    │ 1       │   ╲─                   │
│ Net  │ 0  │ 2   │ 1    │ 0       │                        │
│                                    │   Red  Yellow Green  │
├──────────────────────────────────────┴──────────────────────┤
│ Severity: ☐ CRITICAL  ☐ HIGH  ☐ MEDIUM  ☐ LOW             │
│ Team:     ☐ Infra     ☐ Sec   ☐ Plat    ☐ Net             │
└──────────────────────────────────────────────────────────────┘
```

---

## ✅ CHECKLIST — Page 2 Complete

- [ ] Page 2 created and named "Operational Health"
- [ ] Title added and formatted
- [ ] Trend line chart (Open vs Closed, 2+ lines)
- [ ] Matrix (Teams × SLA Status)
- [ ] Gauge chart (SLA Compliance % vs 90% target)
- [ ] Slicers added (Severity, Team) optional
- [ ] All visuals positioned and sized
- [ ] File saved (Ctrl+S)

---

## 🎯 TROUBLESHOOTING

### Problem: "Trend line shows no data"
**Solution:**
- Check DateTable was created and marked as Date table
- Verify created_date column in Findings is Date type
- Right-click chart → **Reset visual** → re-add fields

### Problem: "Matrix is empty"
**Solution:**
- Drag `assignment_group` to Rows
- Drag `sla_status` to Columns
- Ensure you have a measure in Values (e.g., Total Findings)

### Problem: "Gauge shows 0%"
**Solution:**
- Check SLA Compliance % measure is correct
- Verify Tickets table has sla_status = "Met" values
- Re-create measure if needed (Part 6 of main guide)

### Problem: "Slicer not filtering other visuals"
**Solution:**
- Ensure all visuals use the same tables (Findings/Tickets)
- Check cross-filter settings: right-click slicer → Edit interactions

---

## 🚀 NEXT

Once Page 2 is built:
1. **Save** (Ctrl+S)
2. Go to **Part 7C** to build **Page 3: Risk Analysis**
3. Follow same step-by-step process

---

## 📌 Pro Tips

- **Sync slicers:** If you add same slicer on multiple pages, users can filter across all
- **Drill-through:** Right-click matrix cell → drill through to see detail
- **Mobile view:** Format → Mobile layout to optimize for phones
- **Export:** File → Export → PDF to share report as read-only

✅ Build Page 2 using this guide, then move to **Part 7C for final page!**$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$PART_7C_RISK_ANALYSIS_PAGE_DETAILED$VELSEC$, $VELSEC$Part 7C Risk Analysis Page Detailed$VELSEC$, $VELSEC$Data Analyst$VELSEC$, ARRAY['Data_Analytics']::TEXT[], $VELSEC$# 📊 PART 7C: Build Risk Analysis Page — Detailed Step-by-Step

> **Time:** 20-30 minutes for complete Page 3
> **Order:** Scatter plot (center), histogram (left), bar chart (right)
> **Save after each section** (Ctrl+S)

---

## SECTION 1: Create New Page 3

### Step 1.1: Add a New Page

1. At the bottom of Power BI, right-click next to "Page 2" tab
2. Click **Insert Page** → **Blank Page**
3. New page appears → you're now on **Page 3**
4. Rename it: Right-click tab → **Rename** → type `Risk Analysis`

✅ **Result:** New page tab labeled "Risk Analysis"

---

### Step 1.2: Add Page Title

1. Click **Insert** → **Text Box**
2. Drag box at top (full width)
3. Type: `Risk Analysis — Exposure & Compliance`
4. Format:
   - Font size: 24
   - Bold: Yes
   - Color: Dark red or burgundy (risk theme)

✅ **Result:** Title for Page 3

---

## SECTION 2: Add Scatter Plot (Internet-Facing vs Age vs Severity)

### Step 2.1: Insert Scatter Chart

1. Click **Insert** → **Scatter Chart** (XY scatter)
2. Position: **bottom center**, spanning ~50% width
3. Height: ~350px

---

### Step 2.2: Configure Axes

**In FIELDS PANEL:**

1. Expand **Findings** table

**X-Axis (Horizontal):**
2. Drag `Days Open` → drop on **X Axis** area
   - ✅ X-axis shows age (0 days → 60+ days, left to right)

**Y-Axis (Vertical):**
3. Drag `Severity Order` → drop on **Y Axis** area
   - ✅ Y-axis shows severity (LOW=4 at bottom → CRITICAL=1 at top)

---

### Step 2.3: Add Size (Risk Score)

1. Expand **Findings** table
2. Drag `risk_score` → drop on **Size** area
   - ✅ Bubble size = risk score (bigger bubbles = higher risk)

---

### Step 2.4: Add Legend (Internet Facing)

1. Drag `internet_facing` → drop on **Legend** area
   - ✅ Legend shows "Yes" (red dots) and "No" (blue dots)
   - Internet-facing findings appear as red bubbles

**Result:** 
- **Left side:** Old, low-severity, low-risk (safe)
- **Right side:** New findings (short age)
- **Top area:** Critical findings (severity order = 1)
- **Top-right:** OLD + CRITICAL + INTERNET-FACING = HIGHEST RISK (red bubble, large)

---

### Step 2.5: Format Scatter Chart

1. Click chart → **Format**
   - Title: **ON** → "Risk Exposure Map: Age × Severity × Internet Facing"
   - Title Font Size: 13
   - X-axis label: "Days Open (Age)"
   - Y-axis label: "Severity (1=Critical)"
   - Legend: **ON** (right side)
   - Data labels: turn **OFF** (clean look)

2. **Colors:**
   - Internet-facing = "Yes" → Red (#FF0000)
   - Internet-facing = "No" → Blue (#0066CC)

---

### Step 2.6: Interpretation Guide (Add Text Box)

Below the scatter chart, add a small text box:

```
Red bubbles (top-right) = HIGHEST RISK: old, critical, internet-exposed
Blue bubbles (bottom-left) = LOWEST RISK: new, low-severity, internal only
Focus remediation on largest red bubbles.
```

✅ **Result:** Scatter plot showing risk landscape visually

---

## SECTION 3: Add Histogram (Finding Age Distribution)

### Step 3.1: Insert Histogram

1. Click **Insert** → **Histogram** (bin/distribution chart)
2. Position: **left side** of page, below title
3. Width: ~40%
4. Height: ~300px

---

### Step 3.2: Configure Histogram

In **FIELDS PANEL:**

1. Expand **Findings**
2. Drag `Days Open` → drop on **Axis** area
   - ✅ Histogram groups findings by age buckets (0-7, 8-30, 31-60, 60+ days)

**OR** if histogram auto-fails, use **Bar Chart** instead:

1. Click **Insert** → **Bar Chart** (horizontal)
2. Drag `Age Bucket` → Axis
3. Drag `Total Findings` → Value
   - Shows: 0-7 days, 8-30 days, 31-60 days, 60+ days

---

### Step 3.3: Format Histogram

1. Click chart → **Format**
   - Title: **ON** → "Finding Age Distribution"
   - Title Font Size: 12
   - X-axis label: "Age (Days)"
   - Y-axis label: "Count"
   - Bar color: Blue
   - Data labels: **ON** (show counts on bars)

---

### Step 3.4: Interpretation

- **Tall bar on left (0-7 days):** New findings = good (active scanning)
- **Tall bar on right (60+ days):** Old findings = BAD (backlog aging)

✅ **Result:** Shows how old your backlog is

---

## SECTION 4: Add Bar Chart (Risk by Business Unit)

### Step 4.1: Insert Bar Chart

1. Click **Insert** → **Bar Chart** (horizontal)
2. Position: **right side** of page, same row as histogram
3. Width: ~40%
4. Height: ~300px

---

### Step 4.2: Configure Chart

In **FIELDS PANEL:**

1. Expand **Assets** table
2. Drag `business_unit` → drop on **Axis** area
   - ✅ Chart shows: Finance, Engineering, Operations, Marketing, etc.

3. Expand **Measures**
4. Drag `Total Risk Score` → drop on **Value**
   - ✅ Bars show total risk per business unit

**Alternative** (if Total Risk Score unavailable):
- Drag `Total Findings` to Value instead

---

### Step 4.3: Format Chart

1. Click chart → **Format**
   - Title: **ON** → "Risk by Business Unit"
   - Title Font Size: 12
   - X-axis label: "Risk Score" (or "Finding Count")
   - Y-axis label: "Business Unit"
   - Sort: Descending (highest risk at top)
   - Bar color: Orange or red

2. **Data labels**: turn **ON** (show values)

---

### Step 4.4: Interpretation

- **Longest bar:** Business unit with most risk = needs attention
- **Shortest bar:** Least risky unit = good hygiene

✅ **Result:** Shows which teams/departments have worst security posture

---

## SECTION 5: Add Slicers to Filter All Visuals

### Step 5.1: Add Severity Slicer

1. Click **Insert** → **Slicer**
2. Drag `Findings[severity]` onto it
3. Position: **Top-right corner**
4. Format: Show checkboxes
5. Users can now filter to see only CRITICAL findings, or HIGH + CRITICAL, etc.

---

### Step 5.2: Add Environment Slicer

1. Click **Insert** → **Slicer**
2. Drag `Assets[environment]` onto it
3. Position: **Below severity slicer**
4. Shows: Prod, Staging, Dev
5. Users can now filter by environment

---

### Step 5.3: Add Category Slicer (Optional)

1. Click **Insert** → **Slicer**
2. Drag `Findings[category]` onto it (if available)
3. Position: **Below environment slicer**
4. Shows: Network, IAM, Storage, Compute, etc.

---

## SECTION 6: Final Page Layout

### Expected Final Layout (Page 3):

```
┌────────────────────────────────────────────────────────────────┐
│    Risk Analysis — Exposure & Compliance                       │
├──────────────────────────────────────────────┬─────────────────┤
│                                              │ ☐ CRITICAL     │
│   Risk Exposure Map (Scatter)                │ ☐ HIGH         │
│   ╱ (top-right = highest risk)              │ ☐ MEDIUM       │
│  ╱╱ ●●                                      │ ☐ LOW          │
│ ╱ ●●●                                      │                 │
│●  ●                                         │ ☐ Prod         │
│    Red = Internet-exposed, Blue = Internal │ ☐ Staging      │
│                                              │ ☐ Dev          │
├──────────────────────┬──────────────────────┤                 │
│ Finding Age          │ Risk by Business Unit│                 │
│ Distribution         │                      │ ☐ Network      │
│ ▓▓▓▓ (0-7 days)     │ ▓▓▓▓▓ Finance (45)  │ ☐ IAM          │
│ ▓▓▓ (8-30 days)     │ ▓▓▓▓ Eng (35)       │ ☐ Storage      │
│ ▓▓ (31-60 days)     │ ▓▓▓ Ops (22)        │                 │
│ ▓▓▓▓▓ (60+ days)    │ ▓ Mkt (8)          │                 │
│                      │                      │                 │
└──────────────────────┴──────────────────────┴─────────────────┘
```

---

## ✅ CHECKLIST — Page 3 Complete

- [ ] Page 3 created and named "Risk Analysis"
- [ ] Title added and formatted
- [ ] Scatter plot (Age × Severity × Internet-facing)
- [ ] Histogram or bar chart (Finding age distribution)
- [ ] Horizontal bar chart (Risk by business unit)
- [ ] Slicers added (Severity, Environment, Category)
- [ ] All visuals positioned and sized
- [ ] File saved (Ctrl+S)

---

## 🎯 TROUBLESHOOTING

### Problem: "Scatter chart shows error 'field invalid'"
**Solution:**
- Make sure `Severity Order` column exists in Findings
- If not, go to Model → Findings → add column via formula:
  ```
  Severity Order = IF([severity]="CRITICAL",1,IF([severity]="HIGH",2,IF([severity]="MEDIUM",3,4)))
  ```

### Problem: "Histogram shows wrong grouping"
**Solution:**
- Use **Bar Chart** instead with `Age Bucket` column
- Make sure Age Bucket exists (Part 4 of main guide)

### Problem: "Business unit chart shows wrong data"
**Solution:**
- Verify Assets table has `business_unit` column
- Check Data view → Assets → see values
- Refresh data if needed

### Problem: "Slicers not filtering all visuals"
**Solution:**
- Right-click slicer → **Edit interactions**
- Ensure "Apply to all visuals" is enabled
- Check all visuals use same tables (Findings, Assets)

---

## 🚀 ALL 3 PAGES COMPLETE!

Once Page 3 is done:
1. **Save** (Ctrl+S)
2. Go back to **Page 1** to verify title, cards, chart
3. Go to **Page 2** to verify trend line, matrix, gauge
4. Go to **Page 3** to verify scatter, histograms, slicers

---

## 📌 Pro Tips

- **Cross-page slicers:** Add same slicer on all 3 pages so users can filter globally
- **Bookmarks:** Create "snapshot" views (e.g., "Critical Findings Only")
- **Q&A visual:** Insert → Q&A to let users ask questions naturally
- **Export:** File → Export to save as PDF or PowerPoint

---

## 🎉 FINAL REPORT STRUCTURE

```
PAGE 1: Executive Summary
  ├─ 4 KPI cards (Total, Open, Critical, SLA%)
  ├─ Findings by Severity (bar chart)
  └─ Top Open Findings (table)

PAGE 2: Operational Health
  ├─ Trend line (Open vs Closed over time)
  ├─ Matrix (Team SLA performance)
  └─ Gauge (SLA Compliance %)

PAGE 3: Risk Analysis
  ├─ Scatter plot (Age × Severity × Internet-facing)
  ├─ Histogram (Age distribution)
  ├─ Bar chart (Risk by business unit)
  └─ Slicers (Severity, Environment, Category)
```

---

## 📋 Next: Publish & Share

Once all 3 pages are complete and look good:

**Option A: Save locally**
- File → Save → `CSPM_MCP_Report.pbix`

**Option B: Publish to Power BI Service**
- File → Publish
- Select workspace
- Set up scheduled refresh (daily at 6 AM)
- Share link with team

✅ **Your executive dashboard is ready to present!** 🚀$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Phase1_Foundations$VELSEC$, $VELSEC$Phase1 Foundations$VELSEC$, $VELSEC$Data Analyst$VELSEC$, ARRAY['Data_Analytics']::TEXT[], $VELSEC$# SQL Mastery — Phase 1: Foundations
## Database: SOC Security Operations Center

---

# 1. DATABASE DESIGN & SCHEMA

## The SOC Database

We're building a **Security Operations Center** database that tracks:
- Users & employees accessing systems
- Login events (success/failure)
- Security alerts & incidents
- Assets (servers, endpoints)
- Threat intelligence (malicious IPs)
- Vulnerability scan results

This is the SAME database used by SIEM tools like Splunk, QRadar, Sentinel.

---

## 1.1 Create the Database

```sql
CREATE DATABASE soc_db;
USE soc_db;
```

**What happens internally:**
- DB engine creates a directory on disk
- Creates system catalog tables (metadata)
- Allocates initial storage pages

---

## 1.2 Create Tables (Step-by-Step)

### Table 1: users (employees/accounts)

```sql
CREATE TABLE users (
    user_id       INT PRIMARY KEY AUTO_INCREMENT,
    username      VARCHAR(50) NOT NULL UNIQUE,
    full_name     VARCHAR(100) NOT NULL,
    email         VARCHAR(100) NOT NULL,
    department    VARCHAR(50),
    role          VARCHAR(30) DEFAULT 'analyst',
    is_active     BOOLEAN DEFAULT TRUE,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**Why each column:**
- `AUTO_INCREMENT` — DB generates unique ID automatically. No duplicates ever.
- `NOT NULL` — Column MUST have a value. Prevents garbage data.
- `UNIQUE` — No two rows can have same username.
- `DEFAULT` — If you don't provide value, DB uses this.
- `TIMESTAMP` — Stores date+time. Critical for SOC (when did this happen?).

### Table 2: assets (servers, endpoints, network devices)

```sql
CREATE TABLE assets (
    asset_id      INT PRIMARY KEY AUTO_INCREMENT,
    hostname      VARCHAR(100) NOT NULL,
    ip_address    VARCHAR(45) NOT NULL,
    asset_type    ENUM('server', 'workstation', 'firewall', 'switch', 'cloud_vm') NOT NULL,
    os            VARCHAR(50),
    environment   ENUM('production', 'staging', 'development', 'dmz') DEFAULT 'production',
    owner_id      INT,
    is_critical   BOOLEAN DEFAULT FALSE,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (owner_id) REFERENCES users(user_id)
);
```

**Why FOREIGN KEY:** Links `owner_id` to `users.user_id`. DB enforces this — you can't assign an owner that doesn't exist. This is **referential integrity**.

### Table 3: login_events (authentication logs)

```sql
CREATE TABLE login_events (
    event_id      BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id       INT,
    source_ip     VARCHAR(45) NOT NULL,
    destination_ip VARCHAR(45),
    event_time    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status        ENUM('success', 'failure') NOT NULL,
    auth_method   ENUM('password', 'mfa', 'sso', 'certificate', 'api_key') DEFAULT 'password',
    geo_location  VARCHAR(100),
    user_agent    VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
```

**Why BIGINT:** Login events can be millions/billions of rows. INT maxes at ~2.1 billion. BIGINT handles up to 9.2 quintillion.

### Table 4: security_alerts

```sql
CREATE TABLE security_alerts (
    alert_id      BIGINT PRIMARY KEY AUTO_INCREMENT,
    alert_name    VARCHAR(200) NOT NULL,
    severity      ENUM('critical', 'high', 'medium', 'low', 'info') NOT NULL,
    source        VARCHAR(100) NOT NULL,
    source_ip     VARCHAR(45),
    destination_ip VARCHAR(45),
    alert_time    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status        ENUM('new', 'investigating', 'resolved', 'false_positive', 'escalated') DEFAULT 'new',
    assigned_to   INT,
    description   TEXT,
    mitre_tactic  VARCHAR(100),
    mitre_technique VARCHAR(100),
    FOREIGN KEY (assigned_to) REFERENCES users(user_id)
);
```

### Table 5: incidents

```sql
CREATE TABLE incidents (
    incident_id   INT PRIMARY KEY AUTO_INCREMENT,
    title         VARCHAR(200) NOT NULL,
    severity      ENUM('critical', 'high', 'medium', 'low') NOT NULL,
    status        ENUM('open', 'investigating', 'contained', 'eradicated', 'recovered', 'closed') DEFAULT 'open',
    created_by    INT,
    assigned_to   INT,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolved_at   TIMESTAMP NULL,
    root_cause    TEXT,
    affected_assets TEXT,
    FOREIGN KEY (created_by) REFERENCES users(user_id),
    FOREIGN KEY (assigned_to) REFERENCES users(user_id)
);
```

### Table 6: threat_intel (known malicious IPs/domains)

```sql
CREATE TABLE threat_intel (
    intel_id      INT PRIMARY KEY AUTO_INCREMENT,
    indicator     VARCHAR(255) NOT NULL,
    indicator_type ENUM('ip', 'domain', 'hash', 'url', 'email') NOT NULL,
    threat_type   VARCHAR(100),
    confidence    INT CHECK (confidence BETWEEN 0 AND 100),
    source        VARCHAR(100),
    first_seen    TIMESTAMP,
    last_seen     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active     BOOLEAN DEFAULT TRUE
);
```

### Table 7: vulnerability_scans

```sql
CREATE TABLE vulnerability_scans (
    scan_id       BIGINT PRIMARY KEY AUTO_INCREMENT,
    asset_id      INT,
    cve_id        VARCHAR(20),
    vuln_name     VARCHAR(200),
    severity      ENUM('critical', 'high', 'medium', 'low', 'info') NOT NULL,
    cvss_score    DECIMAL(3,1),
    status        ENUM('open', 'patched', 'accepted_risk', 'mitigated') DEFAULT 'open',
    scan_date     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    patch_deadline DATE,
    FOREIGN KEY (asset_id) REFERENCES assets(asset_id)
);
```

---

## 1.3 Insert Sample Data

### Users

```sql
INSERT INTO users (username, full_name, email, department, role) VALUES
('jsmith',    'John Smith',      'john.smith@bank.com',     'SOC',          'senior_analyst'),
('agarcia',   'Ana Garcia',      'ana.garcia@bank.com',     'SOC',          'analyst'),
('mkumar',    'Manoj Kumar',     'manoj.kumar@bank.com',    'SOC',          'analyst'),
('pjones',    'Patricia Jones',  'patricia.jones@bank.com', 'SOC',          'soc_manager'),
('rwilson',   'Robert Wilson',   'robert.wilson@bank.com',  'IT_Infra',     'sysadmin'),
('lchen',     'Linda Chen',      'linda.chen@bank.com',     'IT_Infra',     'sysadmin'),
('dpark',     'David Park',      'david.park@bank.com',     'DevOps',       'engineer'),
('sjohnson',  'Sarah Johnson',   'sarah.johnson@bank.com',  'Security_Arch','architect'),
('tbrown',    'Tom Brown',       'tom.brown@bank.com',      'Compliance',   'auditor'),
('nwang',     'Nancy Wang',      'nancy.wang@bank.com',     'SOC',          'threat_hunter');
```

### Assets

```sql
INSERT INTO assets (hostname, ip_address, asset_type, os, environment, owner_id, is_critical) VALUES
('web-prod-01',    '10.0.1.10',  'server',      'Ubuntu 22.04',    'production',  5, TRUE),
('web-prod-02',    '10.0.1.11',  'server',      'Ubuntu 22.04',    'production',  5, TRUE),
('db-prod-01',     '10.0.2.10',  'server',      'RHEL 9',          'production',  6, TRUE),
('db-prod-02',     '10.0.2.11',  'server',      'RHEL 9',          'production',  6, TRUE),
('app-prod-01',    '10.0.3.10',  'server',      'Ubuntu 22.04',    'production',  7, TRUE),
('fw-edge-01',     '10.0.0.1',   'firewall',    'PAN-OS 11',       'dmz',         5, TRUE),
('ws-jsmith',      '10.10.1.50', 'workstation', 'Windows 11',      'production',  1, FALSE),
('ws-agarcia',     '10.10.1.51', 'workstation', 'Windows 11',      'production',  2, FALSE),
('dev-server-01',  '10.20.1.10', 'server',      'Ubuntu 22.04',    'development', 7, FALSE),
('cloud-vm-01',    '172.16.1.10','cloud_vm',    'Amazon Linux 2',  'production',  7, TRUE);
```

### Login Events (mix of normal and suspicious)

```sql
INSERT INTO login_events (user_id, source_ip, destination_ip, event_time, status, auth_method, geo_location) VALUES
-- Normal logins (business hours, expected locations)
(1, '10.10.1.50', '10.0.1.10', '2024-03-15 09:15:00', 'success', 'mfa',      'New York, US'),
(2, '10.10.1.51', '10.0.1.10', '2024-03-15 09:30:00', 'success', 'mfa',      'New York, US'),
(3, '10.10.1.52', '10.0.2.10', '2024-03-15 09:45:00', 'success', 'password', 'Mumbai, IN'),
(5, '10.10.2.10', '10.0.1.10', '2024-03-15 10:00:00', 'success', 'sso',      'New York, US'),
(1, '10.10.1.50', '10.0.2.10', '2024-03-15 11:00:00', 'success', 'mfa',      'New York, US'),

-- Suspicious: Failed logins (brute force attempt)
(1, '185.220.101.5', '10.0.1.10', '2024-03-15 02:10:00', 'failure', 'password', 'Moscow, RU'),
(1, '185.220.101.5', '10.0.1.10', '2024-03-15 02:10:05', 'failure', 'password', 'Moscow, RU'),
(1, '185.220.101.5', '10.0.1.10', '2024-03-15 02:10:10', 'failure', 'password', 'Moscow, RU'),
(1, '185.220.101.5', '10.0.1.10', '2024-03-15 02:10:15', 'failure', 'password', 'Moscow, RU'),
(1, '185.220.101.5', '10.0.1.10', '2024-03-15 02:10:20', 'failure', 'password', 'Moscow, RU'),

-- Suspicious: Login from unusual location (impossible travel)
(2, '10.10.1.51', '10.0.1.10', '2024-03-15 14:00:00', 'success', 'mfa',      'New York, US'),
(2, '91.234.56.78','10.0.1.10', '2024-03-15 14:30:00', 'success', 'password', 'Beijing, CN'),

-- Suspicious: After-hours access
(5, '10.10.2.10', '10.0.2.10', '2024-03-16 03:15:00', 'success', 'password', 'New York, US'),
(5, '10.10.2.10', '10.0.2.11', '2024-03-16 03:20:00', 'success', 'password', 'New York, US'),

-- Normal pattern continued
(4, '10.10.1.60', '10.0.1.10', '2024-03-15 08:00:00', 'success', 'sso',      'New York, US'),
(7, '10.10.3.10', '10.20.1.10','2024-03-15 10:30:00', 'success', 'sso',      'San Francisco, US'),
(6, '10.10.2.11', '10.0.2.10', '2024-03-15 09:00:00', 'success', 'mfa',      'New York, US'),

-- Service account login at odd time
(NULL, '10.0.3.10', '10.0.2.10', '2024-03-15 23:00:00', 'success', 'api_key', NULL),
(NULL, '10.0.3.10', '10.0.2.10', '2024-03-16 23:00:00', 'success', 'api_key', NULL);
```

### Security Alerts

```sql
INSERT INTO security_alerts (alert_name, severity, source, source_ip, destination_ip, alert_time, status, assigned_to, description, mitre_tactic, mitre_technique) VALUES
('Brute Force Login Attempt',        'high',     'IDS',       '185.220.101.5', '10.0.1.10', '2024-03-15 02:11:00', 'investigating', 1, '5 failed logins in 10 seconds from external IP', 'Credential Access', 'T1110'),
('Impossible Travel Detected',       'critical', 'UEBA',      '91.234.56.78',  '10.0.1.10', '2024-03-15 14:31:00', 'new',           NULL, 'User agarcia logged in from NY then Beijing in 30min', 'Initial Access', 'T1078'),
('Port Scan Detected',               'medium',   'Firewall',  '45.33.32.156',  '10.0.0.1',  '2024-03-15 04:00:00', 'resolved',      3, 'External IP scanned ports 1-1024', 'Reconnaissance', 'T1046'),
('Malware Hash Detected',            'critical', 'EDR',       '10.10.1.51',    NULL,         '2024-03-15 15:00:00', 'escalated',     1, 'Known ransomware hash detected on workstation', 'Execution', 'T1204'),
('Suspicious PowerShell Execution',  'high',     'EDR',       '10.10.1.50',    NULL,         '2024-03-15 16:00:00', 'investigating', 10,'Encoded PowerShell command executed', 'Execution', 'T1059.001'),
('Data Exfiltration Attempt',        'critical', 'DLP',       '10.0.2.10',     '198.51.100.5','2024-03-16 03:30:00','new',           NULL, 'Large data transfer from DB to external IP', 'Exfiltration', 'T1041'),
('SQL Injection Attempt',            'high',     'WAF',       '203.0.113.50',  '10.0.1.10', '2024-03-15 12:00:00', 'false_positive', 2, 'SQL injection pattern in HTTP request', 'Initial Access', 'T1190'),
('Unauthorized DNS Query',           'medium',   'DNS_Monitor','10.10.1.50',   NULL,         '2024-03-15 16:05:00', 'investigating', 10,'DNS query to known C2 domain', 'Command and Control', 'T1071.004'),
('Failed SSH to Production DB',      'low',      'SIEM',      '10.20.1.10',    '10.0.2.10', '2024-03-15 11:00:00', 'resolved',      3, 'Dev server attempted SSH to prod DB', 'Lateral Movement', 'T1021.004'),
('Privilege Escalation Attempt',     'high',     'EDR',       '10.10.1.52',    NULL,         '2024-03-15 17:00:00', 'new',           NULL, 'User attempted sudo on restricted command', 'Privilege Escalation', 'T1548');
```

### Threat Intel

```sql
INSERT INTO threat_intel (indicator, indicator_type, threat_type, confidence, source, first_seen) VALUES
('185.220.101.5',   'ip',     'Tor Exit Node / Brute Force',  95, 'AlienVault OTX',    '2024-01-15 00:00:00'),
('91.234.56.78',    'ip',     'APT28 Infrastructure',          90, 'CrowdStrike',       '2024-02-01 00:00:00'),
('45.33.32.156',    'ip',     'Scanner / Shodan',              60, 'AbuseIPDB',         '2024-03-01 00:00:00'),
('198.51.100.5',    'ip',     'Data Exfil C2',                 85, 'Mandiant',          '2024-03-10 00:00:00'),
('203.0.113.50',    'ip',     'Web Attack Source',             70, 'Internal Threat Intel','2024-03-05 00:00:00'),
('evil-domain.xyz', 'domain', 'Phishing',                      80, 'PhishTank',         '2024-02-20 00:00:00'),
('a1b2c3d4e5f6...', 'hash',  'Ransomware (LockBit)',          99, 'VirusTotal',        '2024-03-14 00:00:00'),
('bad-c2.example.net','domain','Command and Control',          88, 'CISA',              '2024-03-01 00:00:00');
```

### Vulnerability Scans

```sql
INSERT INTO vulnerability_scans (asset_id, cve_id, vuln_name, severity, cvss_score, status, scan_date, patch_deadline) VALUES
(1, 'CVE-2024-1234', 'OpenSSL Buffer Overflow',    'critical', 9.8, 'open',     '2024-03-14', '2024-03-21'),
(1, 'CVE-2024-5678', 'Apache Log4j RCE',           'critical', 10.0,'open',     '2024-03-14', '2024-03-16'),
(3, 'CVE-2024-2222', 'PostgreSQL Auth Bypass',      'high',     8.1, 'open',     '2024-03-14', '2024-03-28'),
(3, 'CVE-2024-3333', 'Kernel Privilege Escalation', 'high',     7.8, 'patched',  '2024-03-10', '2024-03-17'),
(5, 'CVE-2024-4444', 'Node.js Prototype Pollution', 'medium',   6.5, 'open',     '2024-03-14', '2024-04-14'),
(6, 'CVE-2024-5555', 'PAN-OS Command Injection',    'critical', 9.9, 'mitigated','2024-03-12', '2024-03-14'),
(9, 'CVE-2024-6666', 'SSH Weak Key Exchange',       'low',      3.7, 'accepted_risk','2024-03-14', NULL),
(10,'CVE-2024-7777', 'AWS SSM Agent RCE',           'high',     8.5, 'open',     '2024-03-14', '2024-03-21'),
(2, 'CVE-2024-1234', 'OpenSSL Buffer Overflow',     'critical', 9.8, 'open',     '2024-03-14', '2024-03-21'),
(4, 'CVE-2024-2222', 'PostgreSQL Auth Bypass',      'high',     8.1, 'open',     '2024-03-14', '2024-03-28');
```

---

# 2. SELECT — Reading Data

## 2.1 Basic SELECT

**What:** Retrieves data from a table.  
**Internally:** DB engine → parses SQL → creates execution plan → scans table/index → returns result set.

```sql
-- Select all columns, all rows
SELECT * FROM users;

-- Select specific columns only (ALWAYS do this in production — less data = faster)
SELECT username, full_name, department FROM users;

-- Select with alias (rename column in output)
SELECT username AS "User", department AS "Dept" FROM users;
```

**⚠️ Common Mistake:** Using `SELECT *` in production queries. It fetches ALL columns, including BLOBs and TEXT fields. Always specify needed columns.

---

## 2.2 WHERE — Filtering Rows

**What:** Filters rows based on conditions.  
**Internally:** DB checks each row against the condition. With index, it skips non-matching rows (fast). Without index, it scans every row (slow).

```sql
-- Find all SOC department users
SELECT * FROM users WHERE department = 'SOC';

-- Find active analysts
SELECT username, full_name FROM users WHERE role = 'analyst' AND is_active = TRUE;

-- Find non-SOC users
SELECT * FROM users WHERE department != 'SOC';
-- or
SELECT * FROM users WHERE department <> 'SOC';

-- Find users in SOC or DevOps
SELECT * FROM users WHERE department IN ('SOC', 'DevOps', 'IT_Infra');

-- Find users NOT in certain departments
SELECT * FROM users WHERE department NOT IN ('Compliance', 'Security_Arch');
```

### Comparison Operators

```sql
-- Numeric comparison
SELECT * FROM vulnerability_scans WHERE cvss_score >= 9.0;

-- Date comparison
SELECT * FROM login_events WHERE event_time > '2024-03-15 12:00:00';

-- Between (inclusive on both ends)
SELECT * FROM vulnerability_scans WHERE cvss_score BETWEEN 7.0 AND 9.0;

-- NULL checks (IS NULL, not = NULL)
SELECT * FROM login_events WHERE user_id IS NULL;     -- Service account logins
SELECT * FROM security_alerts WHERE assigned_to IS NOT NULL;  -- Assigned alerts

-- Pattern matching with LIKE
SELECT * FROM assets WHERE hostname LIKE 'web-%';       -- Starts with 'web-'
SELECT * FROM assets WHERE hostname LIKE '%-prod-%';    -- Contains 'prod'
SELECT * FROM users WHERE email LIKE '%@bank.com';      -- Ends with '@bank.com'
```

**⚠️ Common Mistake:** `WHERE status = NULL` returns nothing. NULL is not a value — it's absence of value. Always use `IS NULL` / `IS NOT NULL`.

---

## 2.3 ORDER BY — Sorting Results

```sql
-- Sort alerts by severity (alphabetical — not ideal, we fix this later)
SELECT alert_name, severity, alert_time 
FROM security_alerts 
ORDER BY alert_time DESC;  -- DESC = newest first, ASC = oldest first (default)

-- Sort by multiple columns
SELECT * FROM vulnerability_scans 
ORDER BY severity ASC, cvss_score DESC;

-- Sort by column position (not recommended but common in interviews)
SELECT username, department, role FROM users ORDER BY 2, 3;  -- 2=department, 3=role
```

---

## 2.4 LIMIT — Restricting Rows

```sql
-- Get top 5 most recent alerts
SELECT * FROM security_alerts ORDER BY alert_time DESC LIMIT 5;

-- Pagination: Get rows 11-20 (page 2, 10 per page)
SELECT * FROM login_events ORDER BY event_time DESC LIMIT 10 OFFSET 10;

-- Get the single most critical vulnerability
SELECT * FROM vulnerability_scans ORDER BY cvss_score DESC LIMIT 1;
```

**Performance:** LIMIT without ORDER BY returns arbitrary rows. Always ORDER BY first.

---

# 3. INSERT — Adding Data

```sql
-- Insert single row
INSERT INTO users (username, full_name, email, department, role)
VALUES ('mlee', 'Mike Lee', 'mike.lee@bank.com', 'SOC', 'analyst');

-- Insert multiple rows (batch insert — much faster than individual inserts)
INSERT INTO login_events (user_id, source_ip, destination_ip, event_time, status, auth_method, geo_location) VALUES
(1, '10.10.1.50', '10.0.1.10', '2024-03-16 09:00:00', 'success', 'mfa', 'New York, US'),
(2, '10.10.1.51', '10.0.1.10', '2024-03-16 09:15:00', 'success', 'mfa', 'New York, US');
```

**⚠️ Common Mistake:** Forgetting NOT NULL columns → INSERT fails. Always check table schema first.

---

# 4. UPDATE — Modifying Data

```sql
-- Assign an alert to an analyst
UPDATE security_alerts SET assigned_to = 10, status = 'investigating' 
WHERE alert_id = 2;

-- Close resolved alerts
UPDATE security_alerts SET status = 'resolved' 
WHERE alert_id = 3 AND status = 'resolved';

-- Mark vulnerability as patched
UPDATE vulnerability_scans SET status = 'patched' 
WHERE scan_id = 4;
```

**⚠️ CRITICAL Mistake:** Running UPDATE without WHERE → updates ALL rows!
```sql
-- ❌ NEVER DO THIS (updates every user)
UPDATE users SET is_active = FALSE;

-- ✅ ALWAYS include WHERE
UPDATE users SET is_active = FALSE WHERE user_id = 11;
```

**Production tip:** Always run a SELECT with the same WHERE first to verify which rows will be affected:
```sql
-- Step 1: Check what will be updated
SELECT * FROM users WHERE user_id = 11;
-- Step 2: If correct, run update
UPDATE users SET is_active = FALSE WHERE user_id = 11;
```

---

# 5. DELETE — Removing Data

```sql
-- Delete a specific record
DELETE FROM login_events WHERE event_id = 100;

-- Delete old events (data retention)
DELETE FROM login_events WHERE event_time < '2024-01-01';
```

**⚠️ CRITICAL:** Same as UPDATE — DELETE without WHERE deletes ALL rows. In production, use soft delete (set `is_active = FALSE`) instead of actual DELETE.

---

# 6. Practice Tasks — Phase 1

Try these yourself before looking at answers:

### Easy
1. List all users in the SOC department
2. Show all critical assets
3. Find all failed login events
4. List alerts sorted by newest first

### Medium
5. Find all login events from external IPs (not starting with '10.')
6. Show all open critical vulnerabilities with CVSS score >= 9.0
7. Find alerts that are not yet assigned to anyone
8. List assets in production environment sorted by hostname

### Hard
9. Find logins that happened between 12 AM and 6 AM (after-hours)
10. Find all login events from IPs that appear in the threat_intel table (hint: use a subquery or just think about it — we'll cover this in Phase 2)

---

### Answers

```sql
-- 1
SELECT * FROM users WHERE department = 'SOC';

-- 2
SELECT hostname, ip_address, os FROM assets WHERE is_critical = TRUE;

-- 3
SELECT * FROM login_events WHERE status = 'failure';

-- 4
SELECT alert_name, severity, alert_time, status 
FROM security_alerts ORDER BY alert_time DESC;

-- 5
SELECT * FROM login_events WHERE source_ip NOT LIKE '10.%';

-- 6
SELECT * FROM vulnerability_scans 
WHERE severity = 'critical' AND cvss_score >= 9.0 AND status = 'open';

-- 7
SELECT * FROM security_alerts WHERE assigned_to IS NULL;

-- 8
SELECT hostname, ip_address, asset_type, os 
FROM assets 
WHERE environment = 'production' 
ORDER BY hostname;

-- 9
SELECT * FROM login_events 
WHERE HOUR(event_time) BETWEEN 0 AND 5
ORDER BY event_time;

-- 10 (preview — subquery)
SELECT * FROM login_events 
WHERE source_ip IN (SELECT indicator FROM threat_intel WHERE indicator_type = 'ip');
```

---

# 7. Interview Questions — Phase 1

**Q1: What's the difference between DELETE, TRUNCATE, and DROP?**
| Command | What it does | Can rollback? | Resets AUTO_INCREMENT? |
|---------|-------------|---------------|----------------------|
| DELETE | Removes rows (with WHERE) | Yes (in transaction) | No |
| TRUNCATE | Removes ALL rows instantly | No | Yes |
| DROP | Removes entire table + schema | No | N/A (table gone) |

**Q2: What is NULL in SQL?**  
NULL = unknown/missing value. It's NOT zero, NOT empty string. Any comparison with NULL returns NULL (not TRUE/FALSE). Use IS NULL to check.

**Q3: What's the execution order of a SQL query?**
```
FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT
```
This is why you can't use a column alias (defined in SELECT) inside WHERE.

**Q4: What's the difference between WHERE and HAVING?**  
WHERE filters rows BEFORE grouping. HAVING filters AFTER grouping (on aggregated results).

**Q5: Why should you avoid SELECT * in production?**  
- Fetches unnecessary data (more I/O, more network transfer)
- Breaks applications if table schema changes (new columns added)
- Prevents covering index usage (index can't satisfy all columns)$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Phase2_Intermediate$VELSEC$, $VELSEC$Phase2 Intermediate$VELSEC$, $VELSEC$Data Analyst$VELSEC$, ARRAY['Data_Analytics']::TEXT[], $VELSEC$# SQL Mastery — Phase 2: Intermediate
## JOINS, GROUP BY, Aggregates, Subqueries

---

# 1. JOINS — Combining Tables

## Why JOINS exist
Data is normalized (split across tables to avoid duplication). To get meaningful answers, you must combine tables.

**Real-world:** "Show me which analyst is assigned to each alert" → needs `security_alerts` + `users`.

---

## 1.1 INNER JOIN

**What:** Returns only rows that have matching values in BOTH tables.  
**Internally:** DB builds hash table of smaller table, probes it with each row of larger table.

```sql
-- Show alerts with analyst names (only assigned alerts)
SELECT 
    a.alert_id,
    a.alert_name,
    a.severity,
    a.status,
    u.full_name AS assigned_analyst,
    u.department
FROM security_alerts a
INNER JOIN users u ON a.assigned_to = u.user_id;
```

**Result:** Only alerts WHERE `assigned_to` is NOT NULL and matches a `user_id`.

### Real SOC scenario: Login events with usernames

```sql
SELECT 
    le.event_id,
    u.username,
    u.full_name,
    le.source_ip,
    le.status,
    le.event_time,
    le.geo_location
FROM login_events le
INNER JOIN users u ON le.user_id = u.user_id
WHERE le.status = 'failure'
ORDER BY le.event_time DESC;
```

---

## 1.2 LEFT JOIN (LEFT OUTER JOIN)

**What:** Returns ALL rows from LEFT table + matching rows from RIGHT table. If no match, RIGHT columns = NULL.

```sql
-- All alerts, including unassigned ones (show analyst if assigned)
SELECT 
    a.alert_id,
    a.alert_name,
    a.severity,
    a.status,
    COALESCE(u.full_name, 'UNASSIGNED') AS assigned_analyst
FROM security_alerts a
LEFT JOIN users u ON a.assigned_to = u.user_id
ORDER BY a.alert_time DESC;
```

**COALESCE:** Returns first non-NULL value. If `u.full_name` is NULL → returns 'UNASSIGNED'.

### Real scenario: Find assets with no vulnerabilities (they're clean)

```sql
SELECT 
    a.hostname,
    a.ip_address,
    a.environment,
    v.cve_id
FROM assets a
LEFT JOIN vulnerability_scans v ON a.asset_id = v.asset_id
WHERE v.scan_id IS NULL;  -- No matching vulnerability = clean asset
```

**Interview tip:** LEFT JOIN + WHERE right_table.key IS NULL = "find rows in left that DON'T exist in right" (anti-join pattern).

---

## 1.3 RIGHT JOIN

**What:** Returns ALL rows from RIGHT table + matching from LEFT. Opposite of LEFT JOIN.

```sql
-- All users and their assigned alerts (even users with no alerts)
SELECT 
    u.full_name,
    u.department,
    a.alert_name,
    a.severity
FROM security_alerts a
RIGHT JOIN users u ON a.assigned_to = u.user_id;
```

**Production tip:** RIGHT JOIN is rarely used. Rewrite as LEFT JOIN by swapping table order.

---

## 1.4 FULL OUTER JOIN

**What:** Returns ALL rows from BOTH tables. NULL where no match.  
**MySQL note:** MySQL doesn't support FULL OUTER JOIN directly. Use UNION of LEFT + RIGHT JOIN.

```sql
-- MySQL workaround
SELECT a.hostname, v.cve_id, v.severity
FROM assets a
LEFT JOIN vulnerability_scans v ON a.asset_id = v.asset_id
UNION
SELECT a.hostname, v.cve_id, v.severity
FROM assets a
RIGHT JOIN vulnerability_scans v ON a.asset_id = v.asset_id;
```

---

## 1.5 Multi-table JOINs

### Real SOC Query: Correlate login events with threat intelligence

```sql
-- Find logins from known malicious IPs
SELECT 
    u.username,
    u.full_name,
    le.source_ip,
    le.event_time,
    le.status,
    le.geo_location,
    ti.threat_type,
    ti.confidence,
    ti.source AS intel_source
FROM login_events le
LEFT JOIN users u ON le.user_id = u.user_id
INNER JOIN threat_intel ti ON le.source_ip = ti.indicator
WHERE ti.indicator_type = 'ip'
ORDER BY ti.confidence DESC, le.event_time DESC;
```

### Correlation: Alerts → Assets → Vulnerabilities

```sql
-- Find alerts on assets that also have critical vulnerabilities
SELECT 
    sa.alert_name,
    sa.severity AS alert_severity,
    a.hostname,
    a.ip_address,
    vs.cve_id,
    vs.cvss_score,
    vs.status AS vuln_status
FROM security_alerts sa
INNER JOIN assets a ON sa.source_ip = a.ip_address OR sa.destination_ip = a.ip_address
INNER JOIN vulnerability_scans vs ON a.asset_id = vs.asset_id
WHERE vs.severity = 'critical' AND vs.status = 'open'
ORDER BY vs.cvss_score DESC;
```

---

## 1.6 SELF JOIN

**What:** Join a table with itself. Used for hierarchical data or comparisons within same table.

```sql
-- Find users who logged in from multiple locations on the same day (impossible travel)
SELECT 
    a.user_id,
    u.username,
    a.source_ip AS ip_1,
    a.geo_location AS location_1,
    a.event_time AS time_1,
    b.source_ip AS ip_2,
    b.geo_location AS location_2,
    b.event_time AS time_2
FROM login_events a
INNER JOIN login_events b ON a.user_id = b.user_id 
    AND a.event_id < b.event_id          -- Avoid duplicate pairs
    AND a.geo_location != b.geo_location -- Different locations
    AND TIMESTAMPDIFF(MINUTE, a.event_time, b.event_time) BETWEEN 0 AND 60  -- Within 1 hour
INNER JOIN users u ON a.user_id = u.user_id
WHERE a.status = 'success' AND b.status = 'success';
```

This is a real **impossible travel detection** query used by SIEM tools.

---

# 2. GROUP BY & Aggregate Functions

## 2.1 Aggregate Functions

```sql
-- COUNT: How many total alerts?
SELECT COUNT(*) AS total_alerts FROM security_alerts;

-- COUNT with condition
SELECT COUNT(*) AS critical_alerts 
FROM security_alerts WHERE severity = 'critical';

-- COUNT DISTINCT: How many unique users logged in?
SELECT COUNT(DISTINCT user_id) AS unique_users FROM login_events;

-- SUM: Total CVSS score of all open vulnerabilities
SELECT SUM(cvss_score) AS total_risk_score 
FROM vulnerability_scans WHERE status = 'open';

-- AVG: Average CVSS score
SELECT AVG(cvss_score) AS avg_cvss FROM vulnerability_scans;

-- MIN / MAX
SELECT MIN(cvss_score) AS lowest, MAX(cvss_score) AS highest FROM vulnerability_scans;
```

---

## 2.2 GROUP BY

**What:** Groups rows that share a value, then applies aggregate function per group.

```sql
-- Count alerts by severity
SELECT 
    severity,
    COUNT(*) AS alert_count
FROM security_alerts
GROUP BY severity
ORDER BY alert_count DESC;
```

**Result:**
| severity | alert_count |
|----------|-------------|
| critical | 3 |
| high | 3 |
| medium | 2 |
| low | 1 |
| info | 0 |

### SOC Dashboard Queries

```sql
-- Alerts per analyst (workload distribution)
SELECT 
    u.full_name,
    COUNT(sa.alert_id) AS assigned_alerts,
    SUM(CASE WHEN sa.severity = 'critical' THEN 1 ELSE 0 END) AS critical_count,
    SUM(CASE WHEN sa.severity = 'high' THEN 1 ELSE 0 END) AS high_count
FROM users u
LEFT JOIN security_alerts sa ON u.user_id = sa.assigned_to
WHERE u.department = 'SOC'
GROUP BY u.user_id, u.full_name
ORDER BY assigned_alerts DESC;
```

```sql
-- Login failure rate by user
SELECT 
    u.username,
    COUNT(*) AS total_logins,
    SUM(CASE WHEN le.status = 'failure' THEN 1 ELSE 0 END) AS failed_logins,
    ROUND(SUM(CASE WHEN le.status = 'failure' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS failure_rate_pct
FROM login_events le
INNER JOIN users u ON le.user_id = u.user_id
GROUP BY u.user_id, u.username
ORDER BY failure_rate_pct DESC;
```

```sql
-- Vulnerabilities by asset and severity
SELECT 
    a.hostname,
    a.environment,
    COUNT(*) AS total_vulns,
    SUM(CASE WHEN vs.severity = 'critical' THEN 1 ELSE 0 END) AS critical,
    SUM(CASE WHEN vs.severity = 'high' THEN 1 ELSE 0 END) AS high,
    SUM(CASE WHEN vs.status = 'open' THEN 1 ELSE 0 END) AS open_vulns
FROM vulnerability_scans vs
INNER JOIN assets a ON vs.asset_id = a.asset_id
GROUP BY a.asset_id, a.hostname, a.environment
ORDER BY critical DESC, high DESC;
```

---

## 2.3 HAVING — Filter After Grouping

**What:** WHERE filters rows BEFORE grouping. HAVING filters AFTER aggregation.

```sql
-- Find users with more than 3 failed logins (brute force targets)
SELECT 
    u.username,
    COUNT(*) AS failed_attempts
FROM login_events le
INNER JOIN users u ON le.user_id = u.user_id
WHERE le.status = 'failure'
GROUP BY u.user_id, u.username
HAVING COUNT(*) > 3
ORDER BY failed_attempts DESC;
```

```sql
-- Find assets with more than 1 critical vulnerability (priority patching)
SELECT 
    a.hostname,
    a.ip_address,
    COUNT(*) AS critical_vulns
FROM vulnerability_scans vs
INNER JOIN assets a ON vs.asset_id = a.asset_id
WHERE vs.severity = 'critical' AND vs.status = 'open'
GROUP BY a.asset_id, a.hostname, a.ip_address
HAVING COUNT(*) > 1;
```

```sql
-- IPs with heavy activity (potential scanning or DoS)
SELECT 
    source_ip,
    COUNT(*) AS event_count,
    SUM(CASE WHEN status = 'failure' THEN 1 ELSE 0 END) AS failures
FROM login_events
GROUP BY source_ip
HAVING event_count > 5
ORDER BY event_count DESC;
```

---

# 3. Subqueries

## 3.1 Subquery in WHERE

```sql
-- Find all logins from known threat IPs
SELECT 
    le.*
FROM login_events le
WHERE le.source_ip IN (
    SELECT indicator 
    FROM threat_intel 
    WHERE indicator_type = 'ip' AND confidence > 80
);
```

```sql
-- Find users who have never logged in
SELECT * FROM users 
WHERE user_id NOT IN (
    SELECT DISTINCT user_id FROM login_events WHERE user_id IS NOT NULL
);
```

```sql
-- Find assets with the highest CVSS score vulnerability
SELECT * FROM vulnerability_scans
WHERE cvss_score = (SELECT MAX(cvss_score) FROM vulnerability_scans);
```

## 3.2 Subquery in FROM (Derived Table)

```sql
-- Find average failures per user, then find users above average
SELECT * FROM (
    SELECT 
        u.username,
        COUNT(*) AS fail_count
    FROM login_events le
    INNER JOIN users u ON le.user_id = u.user_id
    WHERE le.status = 'failure'
    GROUP BY u.user_id, u.username
) AS user_failures
WHERE fail_count > (
    SELECT AVG(fc) FROM (
        SELECT COUNT(*) AS fc
        FROM login_events
        WHERE status = 'failure' AND user_id IS NOT NULL
        GROUP BY user_id
    ) AS avg_calc
);
```

## 3.3 Correlated Subquery

```sql
-- For each asset, get the most critical open vulnerability
SELECT 
    a.hostname,
    a.ip_address,
    (SELECT MAX(vs.cvss_score) 
     FROM vulnerability_scans vs 
     WHERE vs.asset_id = a.asset_id AND vs.status = 'open'
    ) AS max_cvss,
    (SELECT COUNT(*) 
     FROM vulnerability_scans vs 
     WHERE vs.asset_id = a.asset_id AND vs.status = 'open'
    ) AS open_vuln_count
FROM assets a
WHERE a.is_critical = TRUE;
```

**⚠️ Performance:** Correlated subqueries execute once per row of outer query. For large tables, use JOIN instead.

## 3.4 EXISTS (more efficient than IN for large datasets)

```sql
-- Find alerts where the source IP is a known threat
SELECT sa.* 
FROM security_alerts sa
WHERE EXISTS (
    SELECT 1 FROM threat_intel ti 
    WHERE ti.indicator = sa.source_ip 
    AND ti.confidence > 80
);
```

**Why EXISTS > IN:** EXISTS stops checking after first match. IN builds complete list first.

---

# 4. Practice Tasks — Phase 2

### JOINs
1. List all login events with user's full name and department
2. Show all alerts with the assigned analyst's name (include unassigned alerts showing 'UNASSIGNED')
3. Find assets that have BOTH alerts AND open vulnerabilities

### GROUP BY + HAVING
4. Count logins per geo_location, sorted by count descending
5. Find alert sources (IDS, EDR, etc.) with more than 2 alerts
6. Calculate average CVSS score per asset (only assets with avg > 7.0)

### Subqueries
7. Find all alerts where the source IP has a confidence > 80 in threat_intel
8. Find users who are assigned more alerts than the average
9. Find the asset with the most open critical vulnerabilities

---

# 5. Interview Questions — Phase 2

**Q1: Difference between INNER JOIN and LEFT JOIN?**
INNER returns only matching rows from both tables. LEFT returns all rows from left table, NULLs for non-matching right rows.

**Q2: Can you use WHERE to filter aggregated results?**
No. WHERE filters before GROUP BY. Use HAVING to filter after aggregation.

**Q3: What's the difference between IN and EXISTS?**
- IN: Evaluates the full subquery result, then checks membership. Better for small subquery results.
- EXISTS: Returns TRUE at first match, stops scanning. Better for large tables.

**Q4: What is a correlated subquery?**
A subquery that references a column from the outer query. It executes once per row of the outer query. Can be slow — rewrite as JOIN when possible.

**Q5: What does COALESCE do?**
Returns the first non-NULL value from a list of expressions. `COALESCE(col1, col2, 'default')` — if col1 is NULL, try col2; if also NULL, return 'default'.

**Q6: How to find duplicates in a table?**
```sql
SELECT column, COUNT(*) 
FROM table 
GROUP BY column 
HAVING COUNT(*) > 1;
```$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Phase3_Advanced$VELSEC$, $VELSEC$Phase3 Advanced$VELSEC$, $VELSEC$Data Analyst$VELSEC$, ARRAY['Data_Analytics']::TEXT[], $VELSEC$# SQL Mastery — Phase 3: Advanced
## Window Functions, CTEs, Indexes, Transactions

---

# 1. Window Functions

## What
Functions that perform calculations ACROSS a set of rows related to the current row — without collapsing rows (unlike GROUP BY).

## Why
GROUP BY gives you one row per group. Window functions give you the aggregate value NEXT TO each original row. Critical for rankings, running totals, comparisons.

---

## 1.1 ROW_NUMBER()

**Assigns a unique sequential number to each row within a partition.**

```sql
-- Number each login event per user (ordered by time)
SELECT 
    u.username,
    le.source_ip,
    le.event_time,
    le.status,
    ROW_NUMBER() OVER (
        PARTITION BY le.user_id 
        ORDER BY le.event_time
    ) AS login_sequence
FROM login_events le
INNER JOIN users u ON le.user_id = u.user_id;
```

### Real SOC use: Get the FIRST login per user each day

```sql
-- Using CTE + ROW_NUMBER (covered together here)
WITH ranked_logins AS (
    SELECT 
        user_id,
        source_ip,
        event_time,
        geo_location,
        ROW_NUMBER() OVER (
            PARTITION BY user_id, DATE(event_time) 
            ORDER BY event_time ASC
        ) AS rn
    FROM login_events
    WHERE user_id IS NOT NULL
)
SELECT * FROM ranked_logins WHERE rn = 1;
```

---

## 1.2 RANK() and DENSE_RANK()

```sql
-- Rank assets by vulnerability count
SELECT 
    a.hostname,
    COUNT(vs.scan_id) AS vuln_count,
    RANK() OVER (ORDER BY COUNT(vs.scan_id) DESC) AS rank_position,
    DENSE_RANK() OVER (ORDER BY COUNT(vs.scan_id) DESC) AS dense_rank_position
FROM assets a
LEFT JOIN vulnerability_scans vs ON a.asset_id = vs.asset_id
GROUP BY a.asset_id, a.hostname;
```

| Difference | RANK | DENSE_RANK | ROW_NUMBER |
|-----------|------|------------|------------|
| Ties | Same rank, skips next | Same rank, no skip | Always unique |
| Example (scores: 100,100,90) | 1,1,3 | 1,1,2 | 1,2,3 |

---

## 1.3 LAG() and LEAD()

**Access previous/next row's value. Essential for time-series analysis.**

```sql
-- Detect impossible travel: Compare each login with the previous one for same user
SELECT 
    u.username,
    le.source_ip,
    le.geo_location,
    le.event_time,
    LAG(le.geo_location) OVER (PARTITION BY le.user_id ORDER BY le.event_time) AS prev_location,
    LAG(le.event_time) OVER (PARTITION BY le.user_id ORDER BY le.event_time) AS prev_time,
    TIMESTAMPDIFF(
        MINUTE, 
        LAG(le.event_time) OVER (PARTITION BY le.user_id ORDER BY le.event_time),
        le.event_time
    ) AS minutes_since_last_login
FROM login_events le
INNER JOIN users u ON le.user_id = u.user_id
ORDER BY le.user_id, le.event_time;
```

### Detect rapid repeated failures (brute force)

```sql
SELECT * FROM (
    SELECT 
        source_ip,
        event_time,
        status,
        LAG(event_time) OVER (PARTITION BY source_ip ORDER BY event_time) AS prev_time,
        TIMESTAMPDIFF(
            SECOND,
            LAG(event_time) OVER (PARTITION BY source_ip ORDER BY event_time),
            event_time
        ) AS seconds_between
    FROM login_events
    WHERE status = 'failure'
) sub
WHERE seconds_between IS NOT NULL AND seconds_between <= 10;
```

---

## 1.4 Running Totals & Moving Averages

```sql
-- Running count of alerts per day
SELECT 
    DATE(alert_time) AS alert_date,
    COUNT(*) AS daily_alerts,
    SUM(COUNT(*)) OVER (ORDER BY DATE(alert_time)) AS running_total
FROM security_alerts
GROUP BY DATE(alert_time)
ORDER BY alert_date;
```

```sql
-- Running average CVSS score (as vulnerabilities are discovered)
SELECT 
    scan_id,
    cve_id,
    cvss_score,
    AVG(cvss_score) OVER (ORDER BY scan_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg_3
FROM vulnerability_scans
ORDER BY scan_date;
```

---

## 1.5 NTILE() — Bucket rows into groups

```sql
-- Divide vulnerabilities into 4 priority quartiles by CVSS score
SELECT 
    cve_id,
    vuln_name,
    cvss_score,
    NTILE(4) OVER (ORDER BY cvss_score DESC) AS priority_quartile
FROM vulnerability_scans
WHERE status = 'open';
-- quartile 1 = most critical, quartile 4 = least
```

---

# 2. CTEs (Common Table Expressions)

## What
Named temporary result set defined using `WITH`. Exists only for the duration of the query. Makes complex queries readable.

## Why
- Break complex queries into logical steps
- Avoid nested subqueries (readability)
- Reuse result within same query
- Recursive queries (hierarchical data)

```sql
-- Step-by-step alert analysis using CTE
WITH alert_summary AS (
    SELECT 
        assigned_to,
        severity,
        COUNT(*) AS alert_count
    FROM security_alerts
    WHERE status NOT IN ('resolved', 'false_positive')
    GROUP BY assigned_to, severity
),
analyst_workload AS (
    SELECT 
        u.full_name,
        COALESCE(SUM(als.alert_count), 0) AS total_open_alerts,
        COALESCE(SUM(CASE WHEN als.severity = 'critical' THEN als.alert_count ELSE 0 END), 0) AS critical_alerts
    FROM users u
    LEFT JOIN alert_summary als ON u.user_id = als.assigned_to
    WHERE u.department = 'SOC'
    GROUP BY u.user_id, u.full_name
)
SELECT 
    full_name,
    total_open_alerts,
    critical_alerts,
    CASE 
        WHEN critical_alerts > 2 THEN '🔴 OVERLOADED'
        WHEN total_open_alerts > 3 THEN '🟡 BUSY'
        ELSE '🟢 AVAILABLE'
    END AS workload_status
FROM analyst_workload
ORDER BY critical_alerts DESC, total_open_alerts DESC;
```

### Threat Correlation CTE

```sql
-- Correlate logins with threat intel and alerts in one clean query
WITH suspicious_logins AS (
    SELECT le.*, ti.threat_type, ti.confidence
    FROM login_events le
    INNER JOIN threat_intel ti ON le.source_ip = ti.indicator
    WHERE ti.indicator_type = 'ip' AND ti.confidence > 70
),
related_alerts AS (
    SELECT sa.*
    FROM security_alerts sa
    WHERE sa.source_ip IN (SELECT source_ip FROM suspicious_logins)
)
SELECT 
    sl.source_ip,
    sl.event_time AS login_time,
    sl.status AS login_status,
    sl.threat_type,
    sl.confidence,
    ra.alert_name,
    ra.severity AS alert_severity
FROM suspicious_logins sl
LEFT JOIN related_alerts ra ON sl.source_ip = ra.source_ip
ORDER BY sl.confidence DESC;
```

---

# 3. Indexes & Query Optimization

## 3.1 What is an Index?

Like a book's index. Instead of reading every page (full table scan), you look up the index to find the exact page.

**Without index:** DB scans every row (slow for large tables).  
**With index:** DB uses B-tree (or hash) structure to find rows in O(log n) time.

## 3.2 Creating Indexes

```sql
-- Index on columns used in WHERE clauses frequently
CREATE INDEX idx_login_events_source_ip ON login_events(source_ip);
CREATE INDEX idx_login_events_user_time ON login_events(user_id, event_time);
CREATE INDEX idx_login_events_status ON login_events(status);

CREATE INDEX idx_alerts_severity ON security_alerts(severity);
CREATE INDEX idx_alerts_status ON security_alerts(status);
CREATE INDEX idx_alerts_time ON security_alerts(alert_time);

CREATE INDEX idx_vulns_asset ON vulnerability_scans(asset_id);
CREATE INDEX idx_vulns_severity_status ON vulnerability_scans(severity, status);

CREATE INDEX idx_threat_intel_indicator ON threat_intel(indicator);
```

## 3.3 EXPLAIN — See How DB Executes Your Query

```sql
EXPLAIN SELECT * FROM login_events WHERE source_ip = '185.220.101.5';
```

**Key EXPLAIN columns:**
| Column | What to look for |
|--------|-----------------|
| **type** | `ALL` = full scan (bad). `ref` / `range` / `const` = index used (good) |
| **key** | Which index is being used (NULL = no index) |
| **rows** | Estimated rows to examine (lower = better) |
| **Extra** | `Using index` (covering index, best). `Using filesort` (needs optimization) |

## 3.4 Index Best Practices

```
✅ DO Index:
  - Columns in WHERE clauses
  - Columns in JOIN conditions
  - Columns in ORDER BY
  - Composite index for multi-column queries (leftmost prefix rule)

❌ DON'T Index:
  - Columns with very low cardinality (e.g., boolean with 50/50 distribution)
  - Tables with <1000 rows (full scan is faster)
  - Columns you rarely query on
  - Too many indexes (slows INSERT/UPDATE)
```

## 3.5 Query Optimization Techniques

```sql
-- ❌ BAD: Function on indexed column disables index
SELECT * FROM login_events WHERE YEAR(event_time) = 2024;

-- ✅ GOOD: Range query uses index
SELECT * FROM login_events 
WHERE event_time >= '2024-01-01' AND event_time < '2025-01-01';

-- ❌ BAD: Leading wildcard disables index
SELECT * FROM assets WHERE hostname LIKE '%prod%';

-- ✅ GOOD: Trailing wildcard uses index
SELECT * FROM assets WHERE hostname LIKE 'web-prod%';

-- ❌ BAD: OR conditions often cause full scan
SELECT * FROM login_events WHERE source_ip = '10.0.1.10' OR destination_ip = '10.0.1.10';

-- ✅ GOOD: UNION of two indexed queries
SELECT * FROM login_events WHERE source_ip = '10.0.1.10'
UNION ALL
SELECT * FROM login_events WHERE destination_ip = '10.0.1.10';
```

---

# 4. Transactions & ACID Properties

## 4.1 What Are Transactions?

A group of SQL operations that execute as ONE atomic unit. Either ALL succeed, or ALL rollback.

**Banking example:** Transfer $100 from Account A to Account B:
1. Debit A by $100
2. Credit B by $100  
If step 2 fails, step 1 must be undone. Otherwise money disappears.

## 4.2 ACID Properties

| Property | Meaning | Example |
|----------|---------|---------|
| **Atomicity** | All or nothing | Both debit and credit succeed, or neither happens |
| **Consistency** | DB moves from valid state to valid state | Total money before = total money after |
| **Isolation** | Concurrent transactions don't interfere | Two transfers happening simultaneously don't corrupt data |
| **Durability** | Once committed, data survives crashes | Power outage after commit → data is still there |

## 4.3 Transaction Syntax

```sql
-- SOC scenario: Create incident from alert (must be atomic)
START TRANSACTION;

-- Step 1: Create incident
INSERT INTO incidents (title, severity, status, created_by, assigned_to, affected_assets)
VALUES ('Ransomware Detected on ws-agarcia', 'critical', 'open', 4, 1, 'ws-agarcia (10.10.1.51)');

-- Step 2: Update related alert status
UPDATE security_alerts 
SET status = 'escalated' 
WHERE alert_id = 4;  -- Malware Hash Detected alert

-- Step 3: Verify both operations
-- If everything looks good:
COMMIT;

-- If something went wrong:
-- ROLLBACK;
```

```sql
-- Batch vulnerability patch update (all or nothing)
START TRANSACTION;

UPDATE vulnerability_scans SET status = 'patched' WHERE scan_id = 1;
UPDATE vulnerability_scans SET status = 'patched' WHERE scan_id = 2;
UPDATE vulnerability_scans SET status = 'patched' WHERE scan_id = 9;

-- Verify
SELECT * FROM vulnerability_scans WHERE scan_id IN (1, 2, 9);

COMMIT;
```

---

# 5. Practice Tasks — Phase 3

### Window Functions
1. Rank users by their total login count (use DENSE_RANK)
2. For each user, show the time difference between consecutive logins (use LAG)
3. Calculate a running total of alerts per day

### CTEs
4. Write a CTE that finds unassigned critical alerts and shows related threat intel
5. Use a multi-step CTE to calculate: alerts per analyst → identify overloaded analysts (>2 alerts)

### Indexes
6. Write an EXPLAIN for a query searching login_events by source_ip. Identify if an index is used.
7. Create appropriate indexes for: finding alerts by severity and status

### Transactions
8. Write a transaction that creates a new incident and updates 2 related alerts to 'escalated'

---

# 6. Interview Questions — Phase 3

**Q1: Difference between ROW_NUMBER, RANK, and DENSE_RANK?**
ROW_NUMBER: Always unique (1,2,3). RANK: Same for ties, skips (1,1,3). DENSE_RANK: Same for ties, no skip (1,1,2).

**Q2: What is a CTE? How is it different from a subquery?**
CTE is a named temporary result set (WITH clause). More readable than nested subqueries. Can be referenced multiple times in the same query. Subquery can only be used once where defined.

**Q3: When would you NOT use an index?**
Small tables (<1000 rows), columns with low cardinality, columns rarely queried, tables with heavy INSERT/UPDATE workload (indexes slow writes).

**Q4: What happens if a transaction fails midway?**
If ROLLBACK is executed (or error occurs), all changes within the transaction are undone. DB returns to state before START TRANSACTION.

**Q5: What is a covering index?**
An index that contains ALL columns needed by a query, so the DB never needs to access the actual table data. Fastest possible query. EXPLAIN shows "Using index".

**Q6: What is the leftmost prefix rule for composite indexes?**
For index on (A, B, C): queries filtering on A, or A+B, or A+B+C use the index. Queries filtering only on B or C do NOT use this index.$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Phase4_Expert$VELSEC$, $VELSEC$Phase4 Expert$VELSEC$, $VELSEC$Data Analyst$VELSEC$, ARRAY['Data_Analytics']::TEXT[], $VELSEC$# SQL Mastery — Phase 4: Expert / Real-World
## Performance Tuning, Partitioning, Data Modeling, Production Queries

---

# 1. Query Performance Tuning

## 1.1 The Performance Tuning Mindset

In production SOC environments with millions of log rows, a bad query can:
- Take 30 minutes instead of 30 seconds
- Lock tables, blocking other analysts
- Crash the SIEM dashboard
- Cause missed alerts during incident response

### Performance checklist (in order):

```
1. Check EXPLAIN output — is it doing a full table scan?
2. Add missing indexes
3. Rewrite the query (avoid functions on indexed columns)
4. Reduce data scanned (use date ranges, LIMIT)
5. Consider partitioning for huge tables
6. Use summary/aggregate tables for dashboards
```

## 1.2 Real Optimization Examples

### Scenario: Slow alert query (10M+ rows)

```sql
-- ❌ SLOW: Full table scan + function on column + SELECT *
SELECT * FROM login_events 
WHERE DATE(event_time) = '2024-03-15' 
AND status = 'failure';

-- ✅ FAST: Range scan on index + specific columns
SELECT event_id, user_id, source_ip, event_time, status
FROM login_events 
WHERE event_time >= '2024-03-15 00:00:00' 
  AND event_time < '2024-03-16 00:00:00'
  AND status = 'failure';
-- Composite index: CREATE INDEX idx_time_status ON login_events(event_time, status);
```

### Scenario: JOIN optimization

```sql
-- ❌ SLOW: Joining on non-indexed column
SELECT le.*, a.hostname
FROM login_events le
JOIN assets a ON le.destination_ip = a.ip_address;

-- ✅ FAST: Create index on join column
CREATE INDEX idx_assets_ip ON assets(ip_address);
-- Then same query uses index
```

### Scenario: Aggregate query optimization

```sql
-- ❌ SLOW: Counting entire table every time dashboard loads
SELECT severity, COUNT(*) FROM security_alerts GROUP BY severity;

-- ✅ FAST: Pre-aggregated summary table updated periodically
CREATE TABLE alert_summary_hourly (
    summary_id INT PRIMARY KEY AUTO_INCREMENT,
    hour_bucket DATETIME NOT NULL,
    severity VARCHAR(10) NOT NULL,
    alert_count INT NOT NULL,
    UNIQUE KEY (hour_bucket, severity)
);

-- Populate via scheduled job every hour
INSERT INTO alert_summary_hourly (hour_bucket, severity, alert_count)
SELECT 
    DATE_FORMAT(alert_time, '%Y-%m-%d %H:00:00') AS hour_bucket,
    severity,
    COUNT(*) AS alert_count
FROM security_alerts
WHERE alert_time >= NOW() - INTERVAL 1 HOUR
GROUP BY hour_bucket, severity
ON DUPLICATE KEY UPDATE alert_count = VALUES(alert_count);
```

---

# 2. Partitioning

## What
Split a large table into smaller physical pieces (partitions) based on a column value. DB knows which partition to scan, skipping irrelevant ones.

## Why
login_events table might have 100M+ rows. Querying by date should only scan 1 day's partition, not all 100M rows.

```sql
-- Partition login_events by month
CREATE TABLE login_events_partitioned (
    event_id      BIGINT NOT NULL AUTO_INCREMENT,
    user_id       INT,
    source_ip     VARCHAR(45) NOT NULL,
    destination_ip VARCHAR(45),
    event_time    TIMESTAMP NOT NULL,
    status        ENUM('success', 'failure') NOT NULL,
    auth_method   VARCHAR(20),
    geo_location  VARCHAR(100),
    user_agent    VARCHAR(255),
    PRIMARY KEY (event_id, event_time)  -- Partition key must be in PRIMARY KEY
) PARTITION BY RANGE (UNIX_TIMESTAMP(event_time)) (
    PARTITION p2024_01 VALUES LESS THAN (UNIX_TIMESTAMP('2024-02-01')),
    PARTITION p2024_02 VALUES LESS THAN (UNIX_TIMESTAMP('2024-03-01')),
    PARTITION p2024_03 VALUES LESS THAN (UNIX_TIMESTAMP('2024-04-01')),
    PARTITION p2024_04 VALUES LESS THAN (UNIX_TIMESTAMP('2024-05-01')),
    PARTITION p_future  VALUES LESS THAN MAXVALUE
);
```

**Partition pruning:** Query with `WHERE event_time >= '2024-03-01' AND event_time < '2024-04-01'` only scans partition `p2024_03`.

### Data retention with partitions

```sql
-- Drop old data instantly (instead of slow DELETE)
ALTER TABLE login_events_partitioned DROP PARTITION p2024_01;
-- This removes ALL data in Jan 2024 instantly (not row-by-row delete)

-- Add new partition for next month
ALTER TABLE login_events_partitioned ADD PARTITION (
    PARTITION p2024_05 VALUES LESS THAN (UNIX_TIMESTAMP('2024-06-01'))
);
```

---

# 3. Data Modeling Basics

## SOC Database — Entity Relationship

```
users ──1:N──→ login_events     (one user, many logins)
users ──1:N──→ security_alerts  (one analyst assigned to many alerts)
users ──1:N──→ incidents        (one analyst assigned to many incidents)
users ──1:N──→ assets           (one owner, many assets)
assets ──1:N──→ vulnerability_scans (one asset, many vulnerabilities)
```

## Normalization Rules (Production Relevance)

| Normal Form | Rule | SOC Example |
|-------------|------|-------------|
| **1NF** | No repeating groups; atomic values | Don't store "10.0.1.10, 10.0.1.11" in one column |
| **2NF** | No partial dependencies | Don't store `username` in login_events (it's in users table) |
| **3NF** | No transitive dependencies | Don't store `department_name` if you already store `department_id` → `departments` table |

## When to Denormalize

- **Dashboard queries:** Pre-join data into summary tables for fast reads
- **Log analysis:** Store flattened log entries (already denormalized from source)
- **SIEM ingest:** Ingest raw json/csv as-is, normalize later

---

# 4. Writing Production-Grade Queries

## Production query standards:

```sql
-- ✅ PRODUCTION QUALITY QUERY
-- Purpose: Daily SOC shift report — unresolved critical/high alerts with analyst assignment
-- Author: Security Engineering
-- Last updated: 2024-03-15
-- Performance: Uses idx_alerts_severity_status, runs < 500ms on 1M rows

SELECT 
    sa.alert_id,
    sa.alert_name,
    sa.severity,
    sa.source,
    sa.source_ip,
    sa.alert_time,
    sa.status,
    COALESCE(u.full_name, 'UNASSIGNED') AS analyst,
    sa.mitre_tactic,
    sa.mitre_technique,
    TIMESTAMPDIFF(HOUR, sa.alert_time, NOW()) AS hours_open,
    CASE 
        WHEN sa.severity = 'critical' AND TIMESTAMPDIFF(HOUR, sa.alert_time, NOW()) > 4 THEN 'SLA BREACH'
        WHEN sa.severity = 'high' AND TIMESTAMPDIFF(HOUR, sa.alert_time, NOW()) > 8 THEN 'SLA BREACH'
        ELSE 'WITHIN SLA'
    END AS sla_status
FROM security_alerts sa
LEFT JOIN users u ON sa.assigned_to = u.user_id
WHERE sa.status NOT IN ('resolved', 'false_positive')
  AND sa.severity IN ('critical', 'high')
  AND sa.alert_time >= NOW() - INTERVAL 7 DAY
ORDER BY 
    FIELD(sa.severity, 'critical', 'high') ASC,
    sa.alert_time ASC;
```

### Production rules:
1. **Comment your queries** — who wrote it, what it does, when updated
2. **Use explicit column names** — never SELECT *
3. **Use COALESCE for NULLs** — dashboards shouldn't show blanks
4. **Add SLA logic** — automate reporting
5. **Filter by date range** — never scan entire table history
6. **Order by business priority** — critical first

---

# 5. Debugging Slow Queries

## Step-by-step debugging process

```
Step 1: Run EXPLAIN on the slow query
Step 2: Check for "ALL" in type column (full table scan)
Step 3: Check if key column is NULL (no index used)
Step 4: Check rows column (too many rows being examined?)
Step 5: Look for "Using temporary" or "Using filesort" in Extra
Step 6: Identify missing indexes → create them
Step 7: Rewrite query if needed (avoid functions on indexed columns)
Step 8: Re-run EXPLAIN → verify improvement
Step 9: Test timing: SELECT ... (check actual execution time)
```

### Slow query log (MySQL)

```sql
-- Enable slow query logging
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 1;  -- Log queries taking > 1 second
SET GLOBAL slow_query_log_file = '/var/log/mysql/slow.log';

-- Check slow queries
SHOW GLOBAL STATUS LIKE 'Slow_queries';
```

---

# 6. Practice Tasks — Phase 4

1. Write EXPLAIN for a complex JOIN query and identify optimization opportunities
2. Design a partition strategy for the `vulnerability_scans` table by scan_date
3. Create a pre-aggregated summary table for the SOC dashboard showing alerts per hour per severity
4. Write a production-grade query for "Top 10 riskiest assets" (combine vulnerability count + alert count + criticality)
5. Optimize this query: `SELECT * FROM login_events WHERE MONTH(event_time) = 3 AND YEAR(event_time) = 2024`

---

# 7. Interview Questions — Phase 4

**Q1: How do you optimize a slow query?**
1. EXPLAIN to identify full scans
2. Add indexes on WHERE/JOIN/ORDER BY columns
3. Avoid functions on indexed columns
4. Use date ranges instead of date functions
5. Use covering indexes for frequently accessed columns
6. Consider partitioning for very large tables
7. Pre-aggregate for dashboard queries

**Q2: What is query execution order?**
`FROM → JOIN → WHERE → GROUP BY → HAVING → SELECT → DISTINCT → ORDER BY → LIMIT`

**Q3: What is database partitioning? Types?**
Splitting table into smaller pieces. Types: RANGE (by date), LIST (by category), HASH (by hash of column), KEY (by primary key hash).

**Q4: Difference between horizontal and vertical partitioning?**
Horizontal: Split rows (e.g., 2024 data in one partition, 2023 in another). Vertical: Split columns (frequently accessed columns in one table, rarely accessed in another).

**Q5: What is a covering index?**
Index that includes all columns the query needs. DB reads only the index, never touches table data. Fastest possible query.$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Phase5_Scenarios$VELSEC$, $VELSEC$Phase5 Scenarios$VELSEC$, $VELSEC$Data Analyst$VELSEC$, ARRAY['Data_Analytics']::TEXT[], $VELSEC$# SQL Mastery — Phase 5: Scenario-Based Learning
## Real SOC Workflows Built with SQL

---

# 1. Detect Suspicious Login Patterns

## 1.1 Brute Force Detection

```sql
-- Find IPs with > 5 failed logins in 10-minute windows
WITH failed_windows AS (
    SELECT 
        source_ip,
        DATE_FORMAT(event_time, '%Y-%m-%d %H:%i') AS minute_bucket,
        COUNT(*) AS fail_count,
        MIN(event_time) AS first_attempt,
        MAX(event_time) AS last_attempt,
        TIMESTAMPDIFF(SECOND, MIN(event_time), MAX(event_time)) AS duration_seconds
    FROM login_events
    WHERE status = 'failure'
    GROUP BY source_ip, DATE_FORMAT(event_time, '%Y-%m-%d %H:%i')
    HAVING COUNT(*) >= 5
)
SELECT 
    fw.*,
    COALESCE(ti.threat_type, 'Unknown') AS threat_classification,
    COALESCE(ti.confidence, 0) AS threat_confidence
FROM failed_windows fw
LEFT JOIN threat_intel ti ON fw.source_ip = ti.indicator AND ti.indicator_type = 'ip'
ORDER BY fw.fail_count DESC;
```

## 1.2 Impossible Travel Detection

```sql
-- Users who logged in from two different countries within 1 hour
WITH login_pairs AS (
    SELECT 
        le.user_id,
        u.username,
        le.source_ip AS current_ip,
        le.geo_location AS current_location,
        le.event_time AS current_time,
        LAG(le.source_ip) OVER (PARTITION BY le.user_id ORDER BY le.event_time) AS prev_ip,
        LAG(le.geo_location) OVER (PARTITION BY le.user_id ORDER BY le.event_time) AS prev_location,
        LAG(le.event_time) OVER (PARTITION BY le.user_id ORDER BY le.event_time) AS prev_time
    FROM login_events le
    INNER JOIN users u ON le.user_id = u.user_id
    WHERE le.status = 'success'
)
SELECT 
    username,
    prev_location,
    prev_time,
    current_location,
    current_time,
    TIMESTAMPDIFF(MINUTE, prev_time, current_time) AS minutes_between,
    prev_ip,
    current_ip
FROM login_pairs
WHERE prev_location IS NOT NULL
  AND prev_location != current_location
  AND TIMESTAMPDIFF(MINUTE, prev_time, current_time) <= 60
ORDER BY minutes_between ASC;
```

## 1.3 After-Hours Access Detection

```sql
-- Logins between 10 PM and 6 AM (non-business hours)
SELECT 
    u.username,
    u.department,
    le.source_ip,
    le.destination_ip,
    le.event_time,
    le.auth_method,
    le.geo_location,
    CASE 
        WHEN HOUR(le.event_time) BETWEEN 0 AND 5 THEN 'Late Night (12AM-6AM)'
        WHEN HOUR(le.event_time) BETWEEN 22 AND 23 THEN 'Evening (10PM-12AM)'
    END AS time_category,
    a.hostname AS target_system,
    a.is_critical AS target_is_critical
FROM login_events le
INNER JOIN users u ON le.user_id = u.user_id
LEFT JOIN assets a ON le.destination_ip = a.ip_address
WHERE le.status = 'success'
  AND (HOUR(le.event_time) >= 22 OR HOUR(le.event_time) <= 5)
ORDER BY le.event_time DESC;
```

## 1.4 Credential Compromise Detection

```sql
-- Users with both failed logins from external IPs AND successful login after (credential stuffing)
WITH external_failures AS (
    SELECT user_id, source_ip, event_time
    FROM login_events
    WHERE status = 'failure' AND source_ip NOT LIKE '10.%'
),
successful_after_failure AS (
    SELECT 
        le.user_id,
        u.username,
        ef.source_ip AS attack_ip,
        ef.event_time AS attack_time,
        le.source_ip AS success_ip,
        le.event_time AS success_time,
        TIMESTAMPDIFF(MINUTE, ef.event_time, le.event_time) AS minutes_after_attack
    FROM login_events le
    INNER JOIN external_failures ef ON le.user_id = ef.user_id
    INNER JOIN users u ON le.user_id = u.user_id
    WHERE le.status = 'success'
      AND le.event_time > ef.event_time
      AND TIMESTAMPDIFF(HOUR, ef.event_time, le.event_time) <= 24
)
SELECT * FROM successful_after_failure
ORDER BY minutes_after_attack ASC;
```

---

# 2. Fraud / Data Exfiltration Detection

## 2.1 Unusual Data Access Patterns

```sql
-- Users accessing production databases they don't normally access
WITH user_normal_targets AS (
    SELECT user_id, destination_ip, COUNT(*) AS access_count
    FROM login_events
    WHERE event_time < '2024-03-15'
      AND status = 'success'
    GROUP BY user_id, destination_ip
),
recent_access AS (
    SELECT user_id, destination_ip, event_time
    FROM login_events
    WHERE event_time >= '2024-03-15'
      AND status = 'success'
)
SELECT 
    u.username,
    ra.destination_ip,
    a.hostname,
    a.is_critical,
    ra.event_time,
    'FIRST TIME ACCESS' AS anomaly_type
FROM recent_access ra
INNER JOIN users u ON ra.user_id = u.user_id
LEFT JOIN assets a ON ra.destination_ip = a.ip_address
LEFT JOIN user_normal_targets unt ON ra.user_id = unt.user_id AND ra.destination_ip = unt.destination_ip
WHERE unt.access_count IS NULL  -- Never accessed this target before
  AND a.is_critical = TRUE      -- ... and it's a critical asset
ORDER BY ra.event_time DESC;
```

## 2.2 Alert-to-Threat Intel Correlation

```sql
-- Cross-reference all alerts with threat intelligence for enrichment
SELECT 
    sa.alert_id,
    sa.alert_name,
    sa.severity,
    sa.source_ip,
    sa.mitre_tactic,
    sa.mitre_technique,
    ti.threat_type,
    ti.confidence AS intel_confidence,
    ti.source AS intel_source,
    CASE 
        WHEN ti.confidence >= 90 THEN 'CONFIRMED THREAT'
        WHEN ti.confidence >= 70 THEN 'HIGH PROBABILITY'
        WHEN ti.confidence >= 50 THEN 'MODERATE - INVESTIGATE'
        ELSE 'LOW - MONITOR'
    END AS threat_assessment
FROM security_alerts sa
LEFT JOIN threat_intel ti ON sa.source_ip = ti.indicator AND ti.indicator_type = 'ip'
WHERE sa.status NOT IN ('resolved', 'false_positive')
ORDER BY ti.confidence DESC NULLS LAST, sa.severity;
```

---

# 3. SOC Dashboard Reports

## 3.1 Executive Summary Report

```sql
-- Security posture overview for CISO briefing
SELECT 
    'Alerts' AS category,
    COUNT(*) AS total,
    SUM(CASE WHEN severity = 'critical' THEN 1 ELSE 0 END) AS critical_count,
    SUM(CASE WHEN status NOT IN ('resolved', 'false_positive') THEN 1 ELSE 0 END) AS open_count
FROM security_alerts
WHERE alert_time >= NOW() - INTERVAL 7 DAY

UNION ALL

SELECT 
    'Vulnerabilities',
    COUNT(*),
    SUM(CASE WHEN severity = 'critical' THEN 1 ELSE 0 END),
    SUM(CASE WHEN status = 'open' THEN 1 ELSE 0 END)
FROM vulnerability_scans

UNION ALL

SELECT 
    'Incidents',
    COUNT(*),
    SUM(CASE WHEN severity = 'critical' THEN 1 ELSE 0 END),
    SUM(CASE WHEN status NOT IN ('closed', 'recovered') THEN 1 ELSE 0 END)
FROM incidents;
```

## 3.2 Vulnerability SLA Tracking

```sql
-- Which critical vulnerabilities are past their patch deadline?
SELECT 
    a.hostname,
    a.ip_address,
    a.environment,
    vs.cve_id,
    vs.vuln_name,
    vs.cvss_score,
    vs.patch_deadline,
    DATEDIFF(CURDATE(), vs.patch_deadline) AS days_overdue,
    CASE 
        WHEN vs.patch_deadline < CURDATE() THEN '🔴 OVERDUE'
        WHEN vs.patch_deadline <= CURDATE() + INTERVAL 3 DAY THEN '🟡 DUE SOON'
        ELSE '🟢 ON TRACK'
    END AS sla_status
FROM vulnerability_scans vs
INNER JOIN assets a ON vs.asset_id = a.asset_id
WHERE vs.status = 'open' AND vs.severity IN ('critical', 'high')
ORDER BY vs.patch_deadline ASC;
```

## 3.3 MITRE ATT&CK Coverage

```sql
-- Which ATT&CK tactics are we seeing? Where are the gaps?
SELECT 
    mitre_tactic,
    mitre_technique,
    COUNT(*) AS alert_count,
    SUM(CASE WHEN severity = 'critical' THEN 1 ELSE 0 END) AS critical,
    SUM(CASE WHEN status = 'resolved' THEN 1 ELSE 0 END) AS resolved,
    ROUND(SUM(CASE WHEN status = 'resolved' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS resolution_rate
FROM security_alerts
WHERE mitre_tactic IS NOT NULL
GROUP BY mitre_tactic, mitre_technique
ORDER BY alert_count DESC;
```

## 3.4 Analyst Performance Metrics

```sql
-- SOC analyst performance dashboard
SELECT 
    u.full_name AS analyst,
    COUNT(sa.alert_id) AS total_assigned,
    SUM(CASE WHEN sa.status = 'resolved' THEN 1 ELSE 0 END) AS resolved,
    SUM(CASE WHEN sa.status = 'false_positive' THEN 1 ELSE 0 END) AS false_positives,
    SUM(CASE WHEN sa.status NOT IN ('resolved', 'false_positive') THEN 1 ELSE 0 END) AS still_open,
    ROUND(
        SUM(CASE WHEN sa.status IN ('resolved', 'false_positive') THEN 1 ELSE 0 END) * 100.0 / 
        NULLIF(COUNT(sa.alert_id), 0), 1
    ) AS closure_rate_pct
FROM users u
LEFT JOIN security_alerts sa ON u.user_id = sa.assigned_to
WHERE u.department = 'SOC'
GROUP BY u.user_id, u.full_name
ORDER BY closure_rate_pct DESC;
```

---

# 4. Risk Scoring Model

```sql
-- Calculate risk score per asset (vulnerability + alert + criticality weighted)
WITH asset_vuln_score AS (
    SELECT 
        asset_id,
        SUM(CASE severity 
            WHEN 'critical' THEN 10
            WHEN 'high' THEN 7
            WHEN 'medium' THEN 4
            WHEN 'low' THEN 1
            ELSE 0
        END) AS vuln_risk_score,
        COUNT(*) AS vuln_count
    FROM vulnerability_scans
    WHERE status = 'open'
    GROUP BY asset_id
),
asset_alert_score AS (
    SELECT 
        a.asset_id,
        SUM(CASE sa.severity 
            WHEN 'critical' THEN 10
            WHEN 'high' THEN 7
            WHEN 'medium' THEN 4
            WHEN 'low' THEN 1
            ELSE 0
        END) AS alert_risk_score,
        COUNT(*) AS alert_count
    FROM security_alerts sa
    INNER JOIN assets a ON sa.source_ip = a.ip_address OR sa.destination_ip = a.ip_address
    WHERE sa.status NOT IN ('resolved', 'false_positive')
    GROUP BY a.asset_id
)
SELECT 
    a.hostname,
    a.ip_address,
    a.environment,
    a.is_critical,
    COALESCE(avs.vuln_count, 0) AS open_vulns,
    COALESCE(avs.vuln_risk_score, 0) AS vuln_score,
    COALESCE(aas.alert_count, 0) AS active_alerts,
    COALESCE(aas.alert_risk_score, 0) AS alert_score,
    (COALESCE(avs.vuln_risk_score, 0) + COALESCE(aas.alert_risk_score, 0)) 
        * CASE WHEN a.is_critical THEN 2 ELSE 1 END AS total_risk_score,
    CASE 
        WHEN (COALESCE(avs.vuln_risk_score, 0) + COALESCE(aas.alert_risk_score, 0)) 
             * CASE WHEN a.is_critical THEN 2 ELSE 1 END >= 30 THEN '🔴 CRITICAL RISK'
        WHEN (COALESCE(avs.vuln_risk_score, 0) + COALESCE(aas.alert_risk_score, 0)) 
             * CASE WHEN a.is_critical THEN 2 ELSE 1 END >= 15 THEN '🟡 HIGH RISK'
        ELSE '🟢 MODERATE'
    END AS risk_level
FROM assets a
LEFT JOIN asset_vuln_score avs ON a.asset_id = avs.asset_id
LEFT JOIN asset_alert_score aas ON a.asset_id = aas.asset_id
ORDER BY total_risk_score DESC;
```

---

# 5. Practice Scenarios

1. **Build a query** that identifies all users who logged in to production database servers from non-corporate IPs
2. **Create a report** showing the top 5 most targeted assets (by alert count) with their vulnerability status
3. **Write a threat hunting query** that finds login events from IPs in threat_intel that resulted in successful authentication
4. **Build an SLA dashboard** showing which incidents have been open longer than 24 hours
5. **Create a weekly report** query showing alert trends (this week vs last week by severity)$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$Phase6_SIEM_Project$VELSEC$, $VELSEC$Phase6 Siem Project$VELSEC$, $VELSEC$Data Analyst$VELSEC$, ARRAY['Data_Analytics']::TEXT[], $VELSEC$# SQL Mastery — Phase 6: DevSecOps / SOC Integration & SIEM
## SQL in Security Tools, Threat Hunting, Log Analysis

---

# 1. SQL in SIEM Tools

## How SIEMs Use SQL Internally

Most SIEM platforms use SQL or SQL-like query languages:

| SIEM | Query Language | SQL-like? |
|------|---------------|-----------|
| **Splunk** | SPL (Search Processing Language) | Similar concepts (search, stats, eval, join) |
| **Azure Sentinel** | KQL (Kusto Query Language) | Very SQL-like (where, project, summarize, join) |
| **QRadar** | AQL (Ariel Query Language) | Almost identical to SQL |
| **Elastic/OpenSearch** | EQL, ES|QL | Growing SQL support |
| **Google Chronicle** | YARA-L, UDM Search | Rule-based, SQL concepts |

## QRadar AQL Example (Nearly Pure SQL)

```sql
-- QRadar: Find brute force attempts (AQL is SQL-like)
SELECT 
    sourceIP, 
    destinationIP, 
    userName,
    COUNT(*) AS failCount
FROM events
WHERE category = 'Authentication' 
  AND eventName = 'Login Failed'
  AND LAST 1 HOURS
GROUP BY sourceIP, destinationIP, userName
HAVING COUNT(*) > 10
ORDER BY failCount DESC
```

## Azure Sentinel KQL (Maps to SQL)

```
// KQL version
SigninLogs
| where ResultType != 0  // Failed logins
| summarize FailCount = count() by IPAddress, UserPrincipalName
| where FailCount > 10
| order by FailCount desc
```

**SQL equivalent:**
```sql
SELECT IPAddress, UserPrincipalName, COUNT(*) AS FailCount
FROM SigninLogs
WHERE ResultType != 0
GROUP BY IPAddress, UserPrincipalName
HAVING COUNT(*) > 10
ORDER BY FailCount DESC;
```

## Splunk SPL (Maps to SQL)

```
// SPL version
index=auth sourcetype=linux_secure action=failure
| stats count by src_ip, user
| where count > 10
| sort - count
```

**SQL equivalent:**
```sql
SELECT src_ip, user, COUNT(*) AS count
FROM auth_events
WHERE action = 'failure'
GROUP BY src_ip, user
HAVING COUNT(*) > 10
ORDER BY count DESC;
```

**Key takeaway:** If you know SQL, you can learn ANY SIEM query language in days.

---

# 2. Log Analysis Using SQL

## 2.1 Firewall Log Analysis

```sql
-- Create table mimicking firewall logs
CREATE TABLE firewall_logs (
    log_id      BIGINT PRIMARY KEY AUTO_INCREMENT,
    timestamp   TIMESTAMP NOT NULL,
    action      ENUM('allow', 'deny', 'drop') NOT NULL,
    src_ip      VARCHAR(45) NOT NULL,
    dst_ip      VARCHAR(45) NOT NULL,
    src_port    INT,
    dst_port    INT,
    protocol    ENUM('TCP', 'UDP', 'ICMP') NOT NULL,
    bytes_sent  BIGINT DEFAULT 0,
    rule_name   VARCHAR(100)
);
```

### Port Scan Detection

```sql
-- IP scanning multiple ports in short time
SELECT 
    src_ip,
    COUNT(DISTINCT dst_port) AS ports_scanned,
    MIN(timestamp) AS scan_start,
    MAX(timestamp) AS scan_end,
    TIMESTAMPDIFF(SECOND, MIN(timestamp), MAX(timestamp)) AS duration_sec
FROM firewall_logs
WHERE action = 'deny'
  AND timestamp >= NOW() - INTERVAL 1 HOUR
GROUP BY src_ip
HAVING ports_scanned > 20
ORDER BY ports_scanned DESC;
```

### Data Exfiltration Detection

```sql
-- Unusual outbound data volume from internal servers
SELECT 
    src_ip,
    dst_ip,
    SUM(bytes_sent) / (1024*1024) AS mb_transferred,
    COUNT(*) AS connection_count,
    MIN(timestamp) AS first_seen,
    MAX(timestamp) AS last_seen
FROM firewall_logs
WHERE action = 'allow'
  AND src_ip LIKE '10.%'          -- Internal source
  AND dst_ip NOT LIKE '10.%'      -- External destination
  AND timestamp >= NOW() - INTERVAL 24 HOUR
GROUP BY src_ip, dst_ip
HAVING mb_transferred > 100       -- More than 100MB to single external IP
ORDER BY mb_transferred DESC;
```

## 2.2 DNS Log Analysis

```sql
-- Create DNS log table
CREATE TABLE dns_logs (
    log_id      BIGINT PRIMARY KEY AUTO_INCREMENT,
    timestamp   TIMESTAMP NOT NULL,
    client_ip   VARCHAR(45) NOT NULL,
    query_name  VARCHAR(255) NOT NULL,
    query_type  VARCHAR(10) NOT NULL,    -- A, AAAA, MX, TXT, CNAME
    response    VARCHAR(45),
    ttl         INT
);
```

### DNS Tunneling Detection

```sql
-- Detect DNS tunneling: high volume of queries to same domain
SELECT 
    client_ip,
    -- Extract base domain (last 2 parts)
    SUBSTRING_INDEX(query_name, '.', -2) AS base_domain,
    COUNT(*) AS query_count,
    COUNT(DISTINCT query_name) AS unique_subdomains,
    AVG(LENGTH(query_name)) AS avg_query_length
FROM dns_logs
WHERE timestamp >= NOW() - INTERVAL 1 HOUR
GROUP BY client_ip, SUBSTRING_INDEX(query_name, '.', -2)
HAVING query_count > 100 
   AND unique_subdomains > 50  -- Many unique subdomains = tunneling
   AND avg_query_length > 50   -- Long query names = encoded data
ORDER BY query_count DESC;
```

### C2 Domain Resolution

```sql
-- Cross-reference DNS queries with threat intelligence
SELECT 
    dl.client_ip,
    dl.query_name,
    dl.timestamp,
    ti.threat_type,
    ti.confidence,
    a.hostname AS affected_host
FROM dns_logs dl
INNER JOIN threat_intel ti ON dl.query_name = ti.indicator OR 
    SUBSTRING_INDEX(dl.query_name, '.', -2) = ti.indicator
LEFT JOIN assets a ON dl.client_ip = a.ip_address
WHERE ti.indicator_type = 'domain'
ORDER BY ti.confidence DESC;
```

---

# 3. Threat Hunting Queries

## 3.1 Hunt: Lateral Movement

```sql
-- Find internal-to-internal connections on sensitive ports
SELECT 
    fl.src_ip,
    a_src.hostname AS source_host,
    fl.dst_ip,
    a_dst.hostname AS dest_host,
    fl.dst_port,
    CASE fl.dst_port
        WHEN 22 THEN 'SSH'
        WHEN 3389 THEN 'RDP'
        WHEN 445 THEN 'SMB'
        WHEN 5985 THEN 'WinRM'
        WHEN 5986 THEN 'WinRM-SSL'
        WHEN 3306 THEN 'MySQL'
        WHEN 5432 THEN 'PostgreSQL'
    END AS service,
    COUNT(*) AS connection_count,
    fl.action
FROM firewall_logs fl
LEFT JOIN assets a_src ON fl.src_ip = a_src.ip_address
LEFT JOIN assets a_dst ON fl.dst_ip = a_dst.ip_address
WHERE fl.src_ip LIKE '10.%' AND fl.dst_ip LIKE '10.%'
  AND fl.dst_port IN (22, 3389, 445, 5985, 5986, 3306, 5432)
  AND fl.timestamp >= NOW() - INTERVAL 24 HOUR
GROUP BY fl.src_ip, a_src.hostname, fl.dst_ip, a_dst.hostname, fl.dst_port, fl.action
ORDER BY connection_count DESC;
```

## 3.2 Hunt: Privilege Escalation

```sql
-- Find users who accessed systems outside their normal scope
WITH user_baseline AS (
    SELECT user_id, destination_ip, COUNT(*) AS normal_count
    FROM login_events
    WHERE event_time < NOW() - INTERVAL 30 DAY
      AND status = 'success'
    GROUP BY user_id, destination_ip
),
recent_access AS (
    SELECT le.user_id, le.destination_ip, le.event_time, le.auth_method
    FROM login_events le
    WHERE le.event_time >= NOW() - INTERVAL 7 DAY
      AND le.status = 'success'
)
SELECT 
    u.username,
    u.department,
    ra.destination_ip,
    a.hostname,
    a.is_critical,
    ra.event_time,
    ra.auth_method,
    'ANOMALOUS ACCESS - NO BASELINE' AS finding
FROM recent_access ra
INNER JOIN users u ON ra.user_id = u.user_id
LEFT JOIN assets a ON ra.destination_ip = a.ip_address
LEFT JOIN user_baseline ub ON ra.user_id = ub.user_id AND ra.destination_ip = ub.destination_ip
WHERE ub.normal_count IS NULL  -- No prior access to this destination
  AND a.is_critical = TRUE
ORDER BY ra.event_time DESC;
```

## 3.3 Hunt: Compromised Service Accounts

```sql
-- Service account behavioral anomalies
SELECT 
    le.source_ip,
    le.destination_ip,
    le.event_time,
    le.auth_method,
    HOUR(le.event_time) AS login_hour,
    DAYNAME(le.event_time) AS login_day,
    CASE 
        WHEN le.auth_method != 'api_key' THEN 'ANOMALY: Non-API auth method'
        WHEN HOUR(le.event_time) NOT BETWEEN 22 AND 23 
             AND HOUR(le.event_time) NOT BETWEEN 0 AND 1 THEN 'ANOMALY: Unusual time'
        ELSE 'Normal'
    END AS anomaly_flag
FROM login_events le
WHERE le.user_id IS NULL  -- Service accounts (no user_id)
ORDER BY le.event_time DESC;
```

---

# 4. Real-World SOC Project

## Build a Complete Threat Investigation Workflow

**Scenario:** You receive an alert: "Data Exfiltration Attempt from db-prod-01 (10.0.2.10)"

**Step 1:** Check the alert details
```sql
SELECT * FROM security_alerts WHERE source_ip = '10.0.2.10' ORDER BY alert_time DESC;
```

**Step 2:** Who accessed this server recently?
```sql
SELECT u.username, le.source_ip, le.event_time, le.auth_method, le.status
FROM login_events le
LEFT JOIN users u ON le.user_id = u.user_id
WHERE le.destination_ip = '10.0.2.10'
  AND le.event_time >= '2024-03-15 00:00:00'
ORDER BY le.event_time DESC;
```

**Step 3:** Any vulnerabilities on this server?
```sql
SELECT vs.cve_id, vs.vuln_name, vs.cvss_score, vs.status
FROM vulnerability_scans vs
WHERE vs.asset_id = (SELECT asset_id FROM assets WHERE ip_address = '10.0.2.10')
ORDER BY vs.cvss_score DESC;
```

**Step 4:** Is the external destination IP in threat intel?
```sql
SELECT * FROM threat_intel WHERE indicator = '198.51.100.5';
```

**Step 5:** Build the full incident picture
```sql
-- Combined investigation query
WITH target_asset AS (
    SELECT * FROM assets WHERE ip_address = '10.0.2.10'
),
recent_logins AS (
    SELECT le.*, u.username, u.department
    FROM login_events le
    LEFT JOIN users u ON le.user_id = u.user_id
    WHERE le.destination_ip = '10.0.2.10'
      AND le.event_time >= NOW() - INTERVAL 48 HOUR
),
asset_vulns AS (
    SELECT vs.*
    FROM vulnerability_scans vs
    INNER JOIN target_asset ta ON vs.asset_id = ta.asset_id
    WHERE vs.status = 'open'
),
related_alerts AS (
    SELECT sa.*
    FROM security_alerts sa
    WHERE sa.source_ip = '10.0.2.10' OR sa.destination_ip = '10.0.2.10'
)
SELECT 
    'ASSET' AS section, ta.hostname, ta.ip_address, ta.os, ta.environment, NULL, NULL
FROM target_asset ta
UNION ALL
SELECT 'LOGIN', rl.username, rl.source_ip, CAST(rl.event_time AS CHAR), rl.status, rl.auth_method, rl.geo_location
FROM recent_logins rl
UNION ALL
SELECT 'VULN', av.cve_id, av.vuln_name, CAST(av.cvss_score AS CHAR), av.status, av.severity, NULL
FROM asset_vulns av
UNION ALL
SELECT 'ALERT', ra.alert_name, ra.source_ip, CAST(ra.alert_time AS CHAR), ra.status, ra.severity, ra.mitre_tactic
FROM related_alerts ra;
```

---

# 5. Mini Challenge Set

## Easy (1-5)
1. Count total login events per status (success/failure)
2. List all critical severity alerts that are still open
3. Find all assets running Ubuntu
4. Show users sorted by department
5. Count vulnerabilities per severity level

## Medium (6-12)
6. Find the top 3 most active source IPs (by login count)
7. Show each analyst's alert count (include those with 0 alerts)
8. List assets with open critical vulnerabilities and their hostnames
9. Find logins from IPs in the threat_intel table with confidence > 80
10. Calculate the average CVSS score per environment (production, staging, etc.)
11. Find users who logged in on weekends
12. Show the time difference between each consecutive alert

## Hard (13-20)
13. Detect impossible travel (same user, different locations, <60 min)
14. Rank assets by total risk score (vulnerability + alert weighted)
15. Find IPs that appear in BOTH login_events (as failures) AND threat_intel
16. Build a query showing alert trends: count per day for the last 7 days
17. Write a CTE that finds all unassigned critical alerts, enriches them with threat intel, and ranks them by confidence
18. Create a query to identify potential brute force attacks (>5 failures from same IP in <5 minutes)
19. Build a complete incident timeline combining logins + alerts + vulns for a specific asset
20. Calculate SOC analyst efficiency: closure rate, average time to resolve, alerts per analyst

---

# 6. Interview Questions — Complete (20+)

**Q1: What does EXPLAIN do?**  
Shows query execution plan: which indexes used, rows examined, join type. Essential for optimization.

**Q2: Difference between UNION and UNION ALL?**  
UNION removes duplicates (slower). UNION ALL keeps all rows (faster). Use UNION ALL unless you specifically need dedup.

**Q3: What is a deadlock?**  
Two transactions waiting on each other's locks. Neither can proceed. DB detects and kills one.

**Q4: How would you optimize a query on a 100M row table?**  
Add indexes on WHERE/JOIN columns. Use partitioning by date. Avoid functions on indexed columns. Use covering indexes. Pre-aggregate for dashboards.

**Q5: What is the difference between CHAR and VARCHAR?**  
CHAR is fixed-length (always uses defined space). VARCHAR is variable-length (uses only needed space). Use VARCHAR for most cases.

**Q6: What are isolation levels?**  
READ UNCOMMITTED → READ COMMITTED → REPEATABLE READ → SERIALIZABLE. Higher = more consistent, slower. Most production DBs use READ COMMITTED.

**Q7: What is a composite index? When to use it?**  
Index on multiple columns: `(col1, col2, col3)`. Follows leftmost prefix rule. Use when queries filter on multiple columns together.

**Q8: Explain window functions vs GROUP BY.**  
GROUP BY collapses rows (1 row per group). Window functions keep all rows and add computed column alongside.

**Q9: What are CTEs used for?**  
Readable temporary result sets within a query. Break complex logic into steps. Can be recursive for hierarchical data.

**Q10: How do you handle NULL values in calculations?**  
COALESCE to provide defaults. IFNULL for two-value check. NULLs propagate in arithmetic (NULL + 5 = NULL).

**Q11: What's the difference between DELETE and TRUNCATE?**  
DELETE: row-by-row, logged, can rollback, WHERE supported. TRUNCATE: drops all rows instantly, minimal logging, no WHERE.

**Q12: What is database normalization?**  
Organizing data to reduce redundancy. 1NF: atomic values. 2NF: no partial dependencies. 3NF: no transitive dependencies.

**Q13: How to find the Nth highest salary/score?**  
```sql
SELECT DISTINCT cvss_score FROM vulnerability_scans ORDER BY cvss_score DESC LIMIT 1 OFFSET N-1;
-- Or with window function:
SELECT * FROM (SELECT *, DENSE_RANK() OVER (ORDER BY cvss_score DESC) AS rnk FROM vulnerability_scans) t WHERE rnk = N;
```

**Q14: What is referential integrity?**  
FOREIGN KEY ensures that a value in one table exists in another table. Prevents orphan records.

**Q15: Difference between IN and EXISTS performance?**  
IN: evaluates full subquery first. EXISTS: stops at first match. EXISTS is faster for large subqueries.

**Q16: What is a stored procedure vs a view?**  
View: saved SELECT query (virtual table). Stored procedure: saved block of SQL logic with parameters, control flow, variables.

**Q17: What is an execution plan?**  
DB optimizer's strategy for executing a query: which indexes to use, join order, scan method. EXPLAIN shows this.

**Q18: How do you prevent SQL injection?**  
Parameterized queries (prepared statements). Never concatenate user input into SQL strings. Input validation. Least-privilege DB accounts.

**Q19: What are temp tables vs CTEs?**  
Temp tables: physical tables in tempdb, persist during session, indexed. CTEs: logical, exist only during query execution, not indexed.

**Q20: What is sharding?**  
Horizontal partitioning across multiple DB servers. Each shard holds a subset of data. Used for massive scale (billions of rows).

**Q21: How to detect slow queries in production?**  
Enable slow query log. Monitor query execution times. Use EXPLAIN on frequent queries. Set up alerts for queries exceeding thresholds.

**Q22: What is query caching?**  
DB caches query results. Same query returns cached result without re-execution. Invalidated when underlying data changes.$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

INSERT INTO public.notes (id, title, category, tags, content, last_updated)
VALUES ($VELSEC$PowerBI_Learning_Module$VELSEC$, $VELSEC$Powerbi Learning Module$VELSEC$, $VELSEC$Data Analyst$VELSEC$, ARRAY['Data_Analytics']::TEXT[], $VELSEC$# 📊 POWER BI LEARNING MODULE — Build, Maintain & Master Dashboards

> **JD Task:** Build and maintain Power BI dashboards and reports, including dataset
> connections, DAX development, Power Query (M-language) transformations for security
> and inventory data.
>
> **What You'll Learn:** Every concept explained → What it is → How it works in real-time
> → Hands-on example using security data.

---

# PART 1: WHAT IS POWER BI & HOW WELLS FARGO USES IT

## 1.1 What Power BI Actually Is

Power BI is a **business intelligence tool** that connects to data sources, transforms raw data into a clean model, and visualizes it as interactive dashboards. Think of it as:

```
Raw Data (messy CSVs, APIs, databases)
          ↓
  Power Query (clean & shape)        ← ETL layer
          ↓
  Data Model (relationships)         ← structure layer
          ↓
  DAX Measures (calculations)        ← intelligence layer
          ↓
  Visuals (charts, tables, KPIs)     ← presentation layer
          ↓
  Published Dashboard (shared)       ← consumption layer
```

## 1.2 Real-Time at Wells Fargo FM Team

```
YOUR DAILY POWER BI WORKFLOW:

MORNING (9 AM):
├── Open Power BI Service (browser) → check overnight refresh status
├── Review "Findings Management Dashboard" for new Critical findings
├── Export SLA breach list → email to team leads
└── Check data quality — are new findings flowing in?

WEEKLY (Monday):
├── Run SLA compliance report → share in weekly office hours meeting
├── Update team scorecard → send to VPs
├── Check month-over-month trend — improving or declining?
└── Identify top 5 teams with worst SLA

MONTHLY:
├── Build exec summary report for CISO
├── Refresh compliance dashboards for audit readiness
├── Add/update DAX measures for new KPIs leadership requested
└── Tune Power Query if Wiz export format changed

QUARTERLY (Audit Prep):
├── Export audit evidence from dashboard → PDF
├── Run compliance score trends for auditors
├── Validate data completeness (all accounts scanned?)
└── Present findings lifecycle metrics to governance team
```

---

# PART 2: DATASET CONNECTIONS — Connecting to Data Sources

## 2.1 What Are Dataset Connections?

A **dataset connection** is how Power BI reads your data. Wells Fargo FM team connects to:

| Source | What It Contains | Connection Type |
|--------|-----------------|----------------|
| **Wiz API** | Security findings, compliance results | Web/REST API |
| **SQL Database** | Historical findings, enriched with CMDB data | SQL Server |
| **CSV Exports** | Weekly Wiz exports, audit lists | File |
| **ServiceNow** | Tickets, SLA data, CMDB assets | REST API or ODBC |
| **SharePoint** | Team tracking sheets, exception lists | SharePoint Online |
| **Azure Resource Graph** | Live cloud resource inventory | Azure connector |

## 2.2 Connection Types Explained

### Import Mode (Most Common)

```
WHAT: Data is copied INTO Power BI's in-memory engine
WHEN USED: Daily/weekly refresh is sufficient
HOW: Scheduled to refresh 1-8 times per day

Example:
├── Connect to Wiz API → import all findings
├── Data stored in Power BI dataset (~200MB compressed)
├── Schedule refresh: 6 AM and 12 PM daily
├── Queries run against local copy → FAST (sub-second)
└── Dashboard always shows data as of last refresh

REAL-TIME USE:
"Every morning at 6 AM, our dataset refreshes from the Wiz API.
When I open the dashboard at 9 AM, I see all findings detected
overnight. If something urgent comes in at 2 PM, I click
'Refresh now' for an ad-hoc update."
```

### DirectQuery Mode (Less Common)

```
WHAT: Power BI queries the source database LIVE (no local copy)
WHEN USED: When you need real-time data and can accept slower queries
HOW: Every visual interaction sends a query to the source

Example:
├── Connect to SQL database with DirectQuery
├── No data stored in Power BI
├── Every filter click → SQL query sent to database
├── Results in 2-10 seconds (depends on DB performance)
└── Always shows latest data

REAL-TIME USE:
"We use DirectQuery for our operational dashboard that the SOC
monitors. They need to see findings the moment they're ingested
into our SQL database — can't wait for scheduled refresh."
```

### Composite Model (Advanced)

```
WHAT: Mix of Import + DirectQuery in one dataset
WHEN USED: Some tables need real-time, others don't
HOW: Mark each table as Import or DirectQuery

Example:
├── Findings table → DirectQuery (need latest)
├── CMDB table → Import (changes rarely, refresh daily)
├── Date table → Import (static)
└── Best of both: fast dimension lookups + real-time fact data
```

## 2.3 Connecting to Each Source — Step by Step

### Connect to CSV File

```
1. Home → Get Data → Text/CSV
2. Browse → select your file → Open
3. Preview window → check data types look correct
4. Click "Transform Data" to open Power Query (recommended)
   OR "Load" to import directly

REAL-TIME TIP: Use "From Folder" instead of single file.
Point to a folder where you drop weekly exports.
Power Query auto-combines all files on refresh.
```

### Connect to SQL Database

```
1. Home → Get Data → SQL Server
2. Enter:
   Server: your-sql-server.database.windows.net
   Database: SecurityFindings
3. Authentication: Microsoft Account or Windows
4. Navigator → check tables you want:
   ☑ dbo.wiz_findings
   ☑ dbo.cmdb_assets
   ☑ dbo.servicenow_tickets
5. Click "Transform Data"

REAL-TIME TIP:
Write SQL directly in the "Advanced options" box:
┌────────────────────────────────────────────┐
│ SELECT f.*, c.owner, c.assignment_group    │
│ FROM wiz_findings f                         │
│ LEFT JOIN cmdb_assets c                     │
│   ON f.resource_id = c.cloud_resource_id   │
│ WHERE f.created_date >= DATEADD(month,-6,  │
│   GETDATE())                                │
└────────────────────────────────────────────┘
This pushes the JOIN to the database (faster than doing it in PBI).
```

### Connect to REST API (Wiz API)

```
1. Home → Get Data → Web
2. URL: https://api.wiz.io/v2/issues?severity=CRITICAL&status=Open
3. Click "Advanced" → add Header:
   Name: Authorization
   Value: Bearer YOUR_TOKEN_HERE
4. Click OK → Power Query parses JSON response
5. Convert JSON to table (click "To Table" or expand records)

REAL-TIME TIP:
Use a Parameter for the API token:
├── Manage Parameters → New → Name: "WizToken"
├── In query: [Headers = [Authorization = "Bearer " & WizToken]]
├── When token rotates, update the parameter — no query rewrite
```

### Connect to SharePoint List

```
1. Home → Get Data → SharePoint Online List
2. Enter SharePoint site URL
3. Select list → Transform Data
4. Useful for: exception tracking, team assignments, audit logs
```

---

# PART 3: POWER QUERY (M-LANGUAGE) — The ETL Engine

## 3.1 What Is Power Query?

Power Query is the **data preparation layer** — it connects, cleans, merges, and shapes data BEFORE it reaches your data model. Every transformation is recorded as a "step" and replays automatically on refresh.

```
POWER QUERY WORKFLOW:

Source Data (messy)
     │
     ↓  ① Connect (Get Data)
     │
     ↓  ② Remove unnecessary columns
     │
     ↓  ③ Fix data types (text → date, text → number)
     │
     ↓  ④ Filter rows (remove test data, old records)
     │
     ↓  ⑤ Add calculated columns (Age, SLA Status, Risk Score)
     │
     ↓  ⑥ Merge with other tables (CMDB lookup for owners)
     │
     ↓  ⑦ Group/aggregate if needed
     │
     ↓  Close & Apply → Clean data loads into model
```

## 3.2 The Power Query Editor — Your Workspace

```
┌──────────────────────────────────────────────────────────────────┐
│ POWER QUERY EDITOR                                               │
│                                                                   │
│ ┌────────────────┐  ┌────────────────────────────┐ ┌───────────┐│
│ │ QUERIES PANEL  │  │ DATA PREVIEW               │ │ APPLIED   ││
│ │                │  │                            │ │ STEPS     ││
│ │ wiz_findings   │  │ ID | Title | Sev  | Cloud | │           ││
│ │ cmdb_assets    │  │ 01 | NSG.. | CRIT | Azure | │ Source    ││
│ │ snow_tickets   │  │ 02 | S3 .. | HIGH | GCP   | │ Changed   ││
│ │ merged_data    │  │ 03 | Key.. | MED  | Azure | │  Type     ││
│ │                │  │ 04 | IAM.. | CRIT | GCP   | │ Removed   ││
│ │                │  │                            │ │  Cols     ││
│ │                │  │                            │ │ Added     ││
│ │                │  │                            │ │  Custom   ││
│ │                │  │                            │ │ Merged    ││
│ └────────────────┘  └────────────────────────────┘ └───────────┘│
│                                                                   │
│ [Formula Bar]:  = Table.AddColumn(#"Changed Type", "Age", ...)   │
└──────────────────────────────────────────────────────────────────┘

APPLIED STEPS = Your transformation recipe
├── Each step is ONE operation (rename, filter, merge, etc.)
├── Steps execute TOP to BOTTOM on every refresh
├── Click any step to see data at that point
├── Right-click to delete/rename/insert steps
├── The FORMULA BAR shows the M-language code for each step
```

## 3.3 M-Language — The Code Behind Power Query

Every click in the Power Query UI generates M-language code. You can also write M directly for complex transformations.

### M-Language Structure

```m
// Every Power Query query is a "let...in" expression:

let
    // Step 1: Connect to source
    Source = Csv.Document(File.Contents("C:\data\findings.csv")),

    // Step 2: Promote headers (first row becomes column names)
    Headers = Table.PromoteHeaders(Source),

    // Step 3: Change data types
    ChangedTypes = Table.TransformColumnTypes(Headers, {
        {"created_date", type date},
        {"sla_hours", Int64.Type},
        {"severity", type text}
    }),

    // Step 4: Filter to open findings only
    FilteredOpen = Table.SelectRows(ChangedTypes,
        each [status] = "Open"),

    // Step 5: Add calculated column
    AddedAge = Table.AddColumn(FilteredOpen, "Age_Days",
        each Duration.Days(DateTime.LocalNow() - [created_date]),
        Int64.Type)
in
    // Return the final step
    AddedAge
```

### Real-Time M-Language Examples

#### Example 1: Add SLA Status Column

```m
// Click: Add Column → Custom Column → paste this formula:

let
    age = Duration.Days(DateTime.LocalNow() - [created_date]),
    sla = if [severity] = "CRITICAL" then 1
          else if [severity] = "HIGH" then 7
          else if [severity] = "MEDIUM" then 30
          else 90,
    pct = age / sla * 100
in
    if [status] = "Closed" then "Resolved"
    else if pct >= 100 then "Breached"
    else if pct >= 75 then "At Risk"
    else "On Track"
```

**Real-Time Use:** "I calculate SLA status in Power Query rather than DAX because it's computed once during refresh, not on every visual interaction. This makes the dashboard faster."

#### Example 2: Merge Findings with CMDB (JOIN)

```m
// Home → Merge Queries → Select tables and key columns
// M-language generated:

let
    Source = findings_table,
    MergedCMDB = Table.NestedJoin(
        Source,                          // left table
        {"resource_id"},                 // left key
        cmdb_assets,                     // right table
        {"cloud_resource_id"},           // right key
        "CMDB",                          // new column name
        JoinKind.LeftOuter               // keep all findings
    ),
    ExpandedCMDB = Table.ExpandTableColumn(
        MergedCMDB,
        "CMDB",
        {"owner", "assignment_group", "environment", "manager"}
    )
in
    ExpandedCMDB
```

**Real-Time Use:** "Every finding now has owner and team info from CMDB. When a finding has no CMDB match, the owner fields are null — I filter these as 'orphaned assets' and report them to asset management."

#### Example 3: Parse JSON from Wiz API

```m
let
    // Connect to Wiz API
    apiUrl = "https://api.wiz.io/v2/issues",
    token = "Bearer " & WizApiToken,
    response = Web.Contents(apiUrl, [
        Headers = [
            #"Authorization" = token,
            #"Content-Type" = "application/json"
        ],
        Query = [
            severity = "CRITICAL,HIGH",
            status = "Open",
            limit = "500"
        ]
    ]),

    // Parse JSON
    json = Json.Document(response),
    data = json[data],

    // Convert list of records to table
    toTable = Table.FromList(data, Splitter.SplitByNothing()),

    // Expand nested record fields
    expanded = Table.ExpandRecordColumn(toTable, "Column1", {
        "id", "title", "severity", "status",
        "resource", "createdAt", "remediation"
    }),

    // Expand nested resource object
    expandedResource = Table.ExpandRecordColumn(expanded, "resource", {
        "id", "type", "name", "cloudPlatform", "subscriptionId"
    }, {"resource_id", "resource_type", "resource_name", "cloud", "account"})
in
    expandedResource
```

**Real-Time Use:** "Instead of exporting CSVs from Wiz, I connect directly to the API. On scheduled refresh, Power Query pulls the latest findings, parses the JSON, flattens nested objects, and my dashboard auto-updates."

#### Example 4: Data from Folder (Auto-Combine Weekly CSVs)

```m
let
    // Connect to folder
    Source = Folder.Files("\\server\share\wiz_exports\"),

    // Filter to only CSV files
    Filtered = Table.SelectRows(Source,
        each Text.EndsWith([Name], ".csv")),

    // Parse each CSV
    AddContent = Table.AddColumn(Filtered, "ParsedCSV",
        each Csv.Document([Content], [Delimiter=",", Encoding=65001])),

    // Combine all into one table
    Combined = Table.Combine(AddContent[ParsedCSV]),

    // Promote first row of each CSV as headers
    Headers = Table.PromoteHeaders(Combined),

    // Remove duplicate rows (same finding in multiple exports)
    Deduped = Table.Distinct(Headers, {"finding_id"})
in
    Deduped
```

**Real-Time Use:** "We get a Wiz export every Monday. I drop the CSV into a network folder. Power BI auto-detects the new file, combines it with historical data, deduplicates by finding_id, and the dashboard shows the complete picture."

#### Example 5: Parameterized Query for Date Range

```m
let
    // Parameters (created via Manage Parameters)
    startDate = #date(2025, 1, 1),
    endDate = Date.From(DateTime.LocalNow()),

    // Connect and filter at source (pushes filter to database)
    Source = Sql.Database("server.database.windows.net", "SecurityDB", [
        Query = "SELECT * FROM wiz_findings WHERE created_date >= '"
                & Date.ToText(startDate, "yyyy-MM-dd") & "'"
                & " AND created_date <= '"
                & Date.ToText(endDate, "yyyy-MM-dd") & "'"
    ])
in
    Source
```

**Real-Time Use:** "For incremental refresh, I use date parameters so only recent data is pulled — this reduced refresh time from 20 minutes to 2 minutes."

## 3.4 Common Power Query Patterns — Quick Reference

| What You Want | UI Action | M-Language |
|--------------|-----------|-----------|
| Remove columns | Right-click column → Remove | `Table.RemoveColumns(t, {"col"})` |
| Rename column | Double-click header | `Table.RenameColumns(t, {{"old","new"}})` |
| Filter rows | Click dropdown → filter | `Table.SelectRows(t, each [col] = "value")` |
| Change type | Click type icon on header | `Table.TransformColumnTypes(t, {{"col", type date}})` |
| Add custom column | Add Column → Custom | `Table.AddColumn(t, "name", each [col1]+[col2])` |
| Replace values | Right-click → Replace | `Table.ReplaceValue(t, "old", "new", Replacer.ReplaceText, {"col"})` |
| Merge (JOIN) | Home → Merge Queries | `Table.NestedJoin(t1, "key", t2, "key", "name", JoinKind.LeftOuter)` |
| Append (UNION) | Home → Append Queries | `Table.Combine({t1, t2})` |
| Group by | Transform → Group By | `Table.Group(t, {"col"}, {{"Count", each Table.RowCount(_)}})` |
| Pivot column | Transform → Pivot | `Table.Pivot(t, values, "attr", "val")` |
| Unpivot | Transform → Unpivot | `Table.UnpivotOtherColumns(t, {"keep"}, "attr", "val")` |
| Sort | Right-click → Sort | `Table.Sort(t, {{"col", Order.Ascending}})` |
| Deduplicate | Home → Remove Rows → Duplicates | `Table.Distinct(t, {"key_col"})` |
| Handle errors | Right-click → Replace Errors | `Table.ReplaceErrorValues(t, {{"col", null}})` |
| Conditional column | Add Column → Conditional | `Table.AddColumn(t, "name", each if [col]>0 then "Yes" else "No")` |

---

# PART 4: DAX DEVELOPMENT — Dynamic Calculations

## 4.1 What Is DAX and When to Use It

DAX (Data Analysis Expressions) creates **dynamic calculations** that react to user interactions (clicks on slicers, filters, drill-downs). Unlike Power Query (runs once on refresh), DAX runs EVERY TIME a visual renders.

```
POWER QUERY vs DAX — WHEN TO USE WHICH:

Use POWER QUERY when:                    Use DAX when:
├── Cleaning data (remove nulls)          ├── Calculating KPIs (SLA %, MTTR)
├── Changing data types                   ├── Creating measures that react to filters
├── Merging/joining tables                ├── Time intelligence (MoM, YTD)
├── Static calculations (age at refresh)  ├── Comparisons (actual vs target)
├── Deduplication                         ├── Conditional aggregation
└── Data from external sources            └── Ranking and percentiles

RULE OF THUMB:
"If the value should be the SAME regardless of what the user
clicks → Power Query.
If the value should CHANGE when the user clicks a slicer → DAX."
```

## 4.2 DAX Measure Library for Findings Management

### Tier 1: Basic Measures (Always Needed)

```dax
// ===== COUNTS =====

Total Findings = COUNTROWS(wiz_findings)

Open Findings =
CALCULATE(COUNTROWS(wiz_findings), wiz_findings[status] = "Open")

Closed Findings =
CALCULATE(COUNTROWS(wiz_findings), wiz_findings[status] = "Closed")

// These react to ANY slicer on the page.
// If user clicks "Azure" slicer → shows only Azure findings
// If user clicks "CRITICAL" slicer → shows only Critical findings
// CALCULATE modifies the filter context.


// ===== BY SEVERITY (for KPI cards) =====

Critical Open =
CALCULATE([Open Findings], wiz_findings[severity] = "CRITICAL")

High Open =
CALCULATE([Open Findings], wiz_findings[severity] = "HIGH")


// ===== BY CLOUD =====

Azure Open =
CALCULATE([Open Findings], wiz_findings[cloud_provider] = "Azure")

GCP Open =
CALCULATE([Open Findings], wiz_findings[cloud_provider] = "GCP")
```

**Real-Time Use:** "These cards sit at the top of every dashboard page. When a VP filters to their team, the cards instantly update to show only their team's numbers."

### Tier 2: SLA & Performance Measures

```dax
// ===== SLA COMPLIANCE =====

SLA Compliance % =
VAR _total = [Open Findings]
VAR _compliant =
    CALCULATE([Open Findings], wiz_findings[SLA_Status] = "On Track")
RETURN
    DIVIDE(_compliant, _total, 0) * 100

// REAL-TIME USE: "This is THE number leadership looks at. If it drops
// below 85%, I drill into which teams are causing the dip."


// ===== SLA BY STATE =====

SLA Breached =
CALCULATE([Open Findings], wiz_findings[SLA_Status] = "Breached")

SLA At Risk =
CALCULATE([Open Findings], wiz_findings[SLA_Status] = "At Risk")


// ===== MTTR (Mean Time to Remediate) =====

MTTR Overall =
AVERAGEX(
    FILTER(wiz_findings, wiz_findings[status] = "Closed"),
    wiz_findings[Age_Days]
)
// Averages the Age_Days for all closed findings.
// Reacts to slicers: filter to CRITICAL → shows MTTR for Critical only.

// REAL-TIME USE: "I use this in a line chart by month — if MTTR is
// trending up, we need more resources or better tooling."


// ===== REMEDIATION RATE =====

Remediation Rate % =
DIVIDE([Closed Findings], [Total Findings], 0) * 100

// Shows what percentage of all findings have been remediated.
```

### Tier 3: Time Intelligence (Trends)

```dax
// ===== MONTH-OVER-MONTH CHANGE =====

New Findings This Month =
CALCULATE(
    COUNTROWS(wiz_findings),
    DATESMTD(DIM_Date[Date])
)

New Findings Last Month =
CALCULATE(
    COUNTROWS(wiz_findings),
    DATEADD(DIM_Date[Date], -1, MONTH)
)

MoM Change % =
VAR _current = [New Findings This Month]
VAR _previous = [New Findings Last Month]
RETURN DIVIDE(_current - _previous, _previous, 0) * 100

// REAL-TIME USE: "In my weekly report, I show MoM change. If findings
// increased 15% this month, I investigate: new cloud accounts onboarded?
// new Wiz rules enabled? or actual posture degradation?"


// ===== YEAR-TO-DATE =====

Findings Closed YTD =
CALCULATE(
    [Closed Findings],
    DATESYTD(DIM_Date[Date])
)

// REAL-TIME USE: "In Q4, leadership asks 'how many findings did we
// close this year?' This measure answers it dynamically."


// ===== RUNNING TOTAL =====

Running Total Open =
CALCULATE(
    [Open Findings],
    FILTER(
        ALL(DIM_Date),
        DIM_Date[Date] <= MAX(DIM_Date[Date])
    )
)

// Shows cumulative open findings over time — use with area chart
```

### Tier 4: Advanced Patterns

```dax
// ===== FINDING AGE DISTRIBUTION =====

Age 0-7 Days = CALCULATE([Open Findings], wiz_findings[Age_Days] <= 7)
Age 8-30 Days = CALCULATE([Open Findings], wiz_findings[Age_Days] > 7, wiz_findings[Age_Days] <= 30)
Age 31-60 Days = CALCULATE([Open Findings], wiz_findings[Age_Days] > 30, wiz_findings[Age_Days] <= 60)
Age 60+ Days = CALCULATE([Open Findings], wiz_findings[Age_Days] > 60)

// REAL-TIME USE: "Stacked bar chart shows age distribution. If the
// '60+ days' bucket is growing, we have a backlog problem."


// ===== TOP N TEAMS BY FINDINGS =====

Team Rank =
RANKX(
    ALL(cmdb_assets[assignment_group]),
    [Open Findings],
    ,
    DESC,
    Dense
)

// Use with a Table visual — shows rank 1, 2, 3... by finding count
// REAL-TIME USE: "In weekly meeting, I show the top 5 teams with most
// open findings. It creates healthy competition."


// ===== COVERAGE METRIC =====

Scanned Accounts =
DISTINCTCOUNT(wiz_findings[cloud_account])

Total Accounts = 42  // Or from a separate accounts table

Coverage % =
DIVIDE([Scanned Accounts], [Total Accounts], 0) * 100

// REAL-TIME USE: "If coverage drops below 100%, a new cloud account
// was created but not connected to Wiz. I flag it for onboarding."


// ===== INTERNET-FACING RISK =====

Internet Facing Critical =
CALCULATE(
    [Open Findings],
    wiz_findings[severity] = "CRITICAL",
    wiz_findings[internet_facing] = "Yes"
)

// REAL-TIME USE: "This is our highest-risk metric. Zero is the target.
// Any value > 0 triggers immediate escalation."
```

---

# PART 5: DASHBOARD MAINTENANCE — Real-Time Operations

## 5.1 Scheduled Refresh Setup

```
IN POWER BI SERVICE (app.powerbi.com):

1. Publish report from Desktop → My Workspace
2. Go to Dataset Settings:
   ├── Data source credentials → enter API keys / DB password
   ├── Scheduled refresh → ON
   ├── Refresh frequency: Daily
   ├── Time: 6:00 AM, 12:00 PM (2x per day)
   └── Send refresh failure notification to: your email

REAL-TIME USE: "I set 6 AM refresh so the dashboard has fresh data
when the team starts at 9 AM. The noon refresh catches any
findings detected during the morning."

TROUBLESHOOTING REFRESH FAILURES:
├── API token expired → update in Data source credentials
├── CSV file moved → update file path in Power Query
├── Database timeout → optimize SQL query or increase timeout
├── Exceeded dataset size limit → add filters in Power Query
└── Schema change (new column in Wiz) → update Power Query
```

## 5.2 Row-Level Security (RLS)

```
WHAT: Each team only sees THEIR OWN findings in the dashboard.

HOW TO SET UP:
1. In Power BI Desktop:
   ├── Modeling → Manage Roles → New → Name: "TeamFilter"
   ├── Add table filter on cmdb_assets:
   │   [assignment_group] = USERPRINCIPALNAME()
   └── Save

2. In Power BI Service:
   ├── Dataset → Security → TeamFilter role
   ├── Add members: AD groups for each team
   └── Platform-Engineering team → sees only their findings

REAL-TIME USE: "Platform Engineering's VP opens the dashboard and
sees 5 Critical findings — those are THEIR findings. They don't see
AppDev's findings. This creates ownership and accountability."
```

## 5.3 Alerts & Subscriptions

```
ALERTS (triggered by data):
├── Click on a KPI card (e.g., Internet Facing Critical)
├── ⋯ → Manage Alerts → New
├── Condition: Above → Threshold: 0
├── Check frequency: Hourly
├── When triggered: email notification
├── REAL-TIME USE: "If ANY internet-facing Critical finding appears,
│   I get an instant email. I don't need to watch the dashboard."

SUBSCRIPTIONS (scheduled delivery):
├── Open report in Service → Subscribe
├── Frequency: Daily at 8 AM
├── Deliver: email with snapshot of dashboard page
├── REAL-TIME USE: "Every Monday morning, VPs get an email with
│   their team's SLA snapshot — no need to log into Power BI."
```

## 5.4 Version Control & Change Management

```
BEST PRACTICE:

1. VERSION FILES:
   ├── WF_Dashboard_v1.0.pbix → original
   ├── WF_Dashboard_v1.1.pbix → added new KPI
   ├── WF_Dashboard_v2.0.pbix → major redesign
   └── Keep changelog in README or the file name

2. DEV → PROD PROMOTION:
   ├── Dev Workspace: test new measures and visuals
   ├── Prod Workspace: what users see
   ├── Test in Dev → validate data → copy to Prod
   └── Use Power BI Deployment Pipelines (premium feature)

3. DAX DOCUMENTATION:
   ├── For each measure, add a Description:
   │   Right-click measure → Properties → Description
   │   "SLA Compliance %: Percentage of open findings within
   │    SLA target. Calculated as On Track / Total Open * 100.
   │    Target: >85%. Refreshes daily."
   └── Future you (or your replacement) will thank you
```

---

# PART 6: HANDS-ON EXERCISE — Build Everything End to End

```
TIME: 2-3 hours
PREREQUISITE: Install Power BI Desktop, have the 3 CSV files from PowerBI_Project/data/

EXERCISE MAP:

Step 1 (15 min): Load 3 CSVs via Power Query
Step 2 (20 min): Apply Power Query transformations (all M-language examples above)
Step 3 (10 min): Build data model with relationships
Step 4 (30 min): Create all DAX measures from Tier 1-4
Step 5 (45 min): Build 3-page dashboard (follow PROJECT_GUIDE.md)
Step 6 (15 min): Add slicers, drill-through, conditional formatting
Step 7 (10 min): Save, export PDF, tell yourself the interview story

INTERVIEW STORY:
"I built a 3-page findings management dashboard in Power BI that
connects to Wiz API data, merges it with CMDB in Power Query for
ownership mapping, and calculates SLA compliance, MTTR, and risk
distribution using DAX measures. The dashboard refreshes twice
daily and uses Row-Level Security so each team only sees their
findings. It powers our weekly office hours and monthly exec reports."
```

---

> **Key Takeaway:** Power BI isn't just "making charts." It's an end-to-end data pipeline — connect → transform → model → calculate → visualize → share → maintain. Every step has a real-time purpose in the Findings Management workflow.$VELSEC$, '2026-06-05')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  tags = EXCLUDED.tags,
  content = EXCLUDED.content,
  last_updated = EXCLUDED.last_updated;

COMMIT;
