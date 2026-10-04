# Checkpoint 3 — Power BI Build Guide (Manta Ray)

Working checklist for building the dashboard from `Checkpoint3_Dashboard_Blueprint.docx`.
Not a submission file — just here to keep the build moving without waiting on step-by-step chat.

## 0. Apply the theme (do this first)

1. **View** tab → **Themes** → **Browse for themes...**
2. Select `MantaRay_PowerBI_Theme.json` (same folder as this guide).
3. Every new visual will now default to the blue/orange/green palette used in the
   blueprint and in `cluster_scatter.png`, so categories, regions, and clusters
   look consistent without manual recoloring.

## 1. Data check (should already be done)

- [x] `Orders` table loaded from `Sample - Superstore.csv`
- [x] `Customer_Clusters` table loaded from `Checkpoint3_Customer_Segmentation.xlsx`
- [x] Relationship drawn: `Orders[Customer ID]` → `Customer_Clusters[Customer ID]`
- [ ] Confirm `Order Date`/`Ship Date` are Date type, `Postal Code` is Text,
      `Sales`/`Profit`/`Discount` are Decimal — click each column header in
      **Data view** (grid icon, left rail) and check the **Column tools** ribbon.

## 2. Page 1 — Executive Summary

Rename the page tab "Executive Summary."

| Visual | Type | Field(s) | Notes |
|---|---|---|---|
| KPI 1 | Card | `Sales` (Sum) | Format → Data label → Display units: Millions, 2 decimals. Should read ≈ $2.30M |
| KPI 2 | Card | `Profit` (Sum) | Display units: Thousands. Should read ≈ $286.4K |
| KPI 3 | Card | `Order ID` (Count Distinct) | Should read 5,009 (unique orders) — or use order-line row count (9,994) if you'd rather match the blueprint literally; just be consistent in the report write-up |
| KPI 4 | Card | `Discount` (Average) | Format as Percentage, 1 decimal. Should read ≈ 15.6% |
| Category chart | Clustered column chart | Axis: `Category`; Values: `Sales`, `Profit` | Matches CP2 Pivot Table 1 |
| Region chart | Clustered column chart (or Map) | Axis/Location: `Region`; Values: `Sales` | Matches CP2 Pivot Table 2 |
| Slicers | Slicer (x4) | `Order Date` (set to Year), `Region`, `Category`, `Segment` | Place along the top or a left rail; see §5 |

Layout: 4 cards in a row across the top, the two charts side-by-side underneath, slicers above or beside everything.

## 3. Page 2 — Trend & Comparison Analysis

Rename the page tab "Trend & Comparison."

| Visual | Type | Field(s) | Notes |
|---|---|---|---|
| Trend chart | Line chart | Axis: `Order Date` (drill to Month); Values: `Sales` | This is your actual sales history. Power BI can't natively draw your CP2 forecast line from a static Excel formula — see note below. |
| Region profit | Clustered column chart | Axis: `Region`; Values: `Profit` (Average) | Should show East $32.14, West $33.85, South $28.86, Central $17.09 per order |
| Discount vs Profit | Scatter chart | X: `Discount`; Y: `Profit`; (optional) Size: `Sales` | Reproduces CP2 r = -0.219 relationship visually |
| Slicers | Slicer (x3) | `Order Date`, `Region`, `Category` | |

**Forecast note:** Power BI's line chart has a built-in **Analytics pane** (the icon that
looks like a magnifying glass with a graph, in Visualizations pane when a line chart is
selected) → **Forecast** → set to project forward — this can approximate your CP2
6-month linear forecast directly on the chart without re-importing numbers. Toggle it
on for the Trend chart once the base line chart is built.

## 4. Page 3 — Deep Dive / Segmentation

Rename the page tab "Segmentation."

All fields below come from the `Customer_Clusters` table (not `Orders`).

| Visual | Type | Field(s) | Notes |
|---|---|---|---|
| Cluster scatter | Scatter chart | X: `AvgDiscount`; Y: `TotalSales`; Legend: `SegmentName` | Matches `cluster_scatter.png` exactly — axis choice was tested, this pair separates the 3 clusters cleanly (Order Count did not) |
| Segment share | Donut or bar chart | Legend/Axis: `SegmentName`; Values: `TotalSales` | Should show ~62% / 24% / 14% split |
| Segment profile table | Table or Matrix | `SegmentName`, `AvgTotalSales`, `AvgDiscount`, `AvgOrderCount`... | Pull the pre-computed averages, or drag `Customer ID` (count) + your numeric fields and set aggregation to Average |
| Slicers | Slicer (x3) | `SegmentName`, `Region`, `Category` | `Region`/`Category` come from `Orders` — the relationship makes them filter `Customer_Clusters` too |

## 5. Slicers & cross-page interactivity

- Build slicers once on Page 1, then **copy-paste** them onto Pages 2/3 (Ctrl+C / Ctrl+V) —
  faster than rebuilding, and keeps identical formatting.
- To make a slicer apply across all 3 pages at once: select the slicer → **Format** pane
  → **Sync slicers** (or **View** tab → **Sync slicers** panel) → check the pages you
  want it synced to.
- Test each slicer by clicking a value and confirming the KPI cards/charts update.

## 6. Before you export

- [ ] Every visual has a title (Format pane → General → Title) and, where relevant,
      axis labels — required by the rubric ("all visuals must be properly titled,
      labeled, and sourced").
- [ ] Add a text box somewhere on each page citing the source: "Source: Sample
      Superstore Dataset (Kaggle); Checkpoint 2 Spreadsheet Analysis; Checkpoint 3
      K-Means Segmentation."
- [ ] **File → Export → Export to PDF** — this is your "Exported PDF version of all
      dashboard pages" submission requirement.
- [ ] Save the `.pbix` file into the project folder.

## 7. If something looks wrong

Send a screenshot and say what you expected vs. what you see — cheaper to fix live
than to guess from a description.
