# Video Presentation Script — Checkpoint 1 & 2
**Project:** Sales Performance & Revenue Forecasting (Retail & Sales Analytics)
**Group:** Manta Ray | BED 106 – Business Analytics
**Format:** Screen recording + voiceover, ~15–16 minutes total

**Cast & split:**
- **Sugar-Rey** (Project Lead / Analyst, **you**) — hosts the intro **and all of Checkpoint 1**
- **Rudelyn** (Data Engineer) — hosts the Checkpoint 2 spreadsheet/Excel section
- **Joel** (Statistician / Modeler) — hosts the Checkpoint 2 statistics section
- **Sugar-Rey** returns for the conclusion

Each block tells you: **who talks**, **what to have on screen**, and **what to say** (in plain language, not the report's formal wording). Treat the "SAY" lines as a guide, not something to read verbatim — talk like you're explaining it to a manager, not reading a paper.

---

## 0. Cold Open / Title Card (0:00–0:20)
**Speaker:** Sugar-Rey
**On screen:** A title slide or the project's cover page — "Sales Performance & Revenue Forecasting — Manta Ray".

**SAY:**
> "Hi, we're Manta Ray. I'm Sugar-Rey, and in this video I'll walk you through Checkpoint 1 of our Business Analytics capstone — the business problem, the database, and the SQL work. Then Rudelyn and Joel will take over for Checkpoint 2, covering the spreadsheet analysis and the statistics."

---

# CHECKPOINT 1 — presented entirely by Sugar-Rey

## 1. The Business Problem (0:20–1:30)
**On screen:** Checkpoint 1, Task 1.1 (the "Business Problem Statement" page).

**SAY:**
> "Every retail business generates tons of transaction data, but the real question is: what do you *do* with it? Our project looks at a superstore's sales history to figure out which products, regions, and time periods actually make the company money, and whether we can predict what's coming next.
>
> We picked five business questions to guide everything:
> 1. Which product categories and regions bring in the most sales and profit?
> 2. Do bigger discounts actually hurt profit?
> 3. What do monthly and seasonal sales trends look like?
> 4. Which customer segments matter most?
> 5. Can we forecast next quarter's sales from the historical pattern?
>
> Everything you'll see in this video — the database, the SQL, and later the spreadsheet and statistics work — comes back to answering these five questions."

## 2. The Dataset (1:30–2:30)
**On screen:** The Kaggle dataset page or the raw CSV open in Excel (Checkpoint 1, "Raw Dataset Preview" screenshots).

**SAY:**
> "The data is the Sample Superstore dataset from Kaggle — public domain, so no licensing issues. It's about 9,994 order-line records across 21 columns: order date, customer info, region, product category, sales, discount, and profit.
>
> Before using it, we checked it for problems: no missing values, no true duplicate rows — though the same Order ID can repeat because one order can contain multiple products, which is normal. We did clean a few things: dates were in MM/DD/YYYY and needed reformatting for the database, postal codes had to be stored as text instead of numbers, and there were some negative profit values — which we kept, because those are real loss-making orders, not errors."

## 3. Database Design (2:30–3:45)
**On screen:** The ERD diagram (`ERD_superstore.drawio.png`), then phpMyAdmin showing the three tables.

**SAY:**
> "Since a spreadsheet isn't a real database, we normalized the flat CSV into three related tables: **customers**, **products**, and **orders**. Customers and products each have their own unique ID as a primary key, and the orders table links to both with foreign keys, plus it holds the actual numbers — sales, quantity, discount, and profit.
>
> [switch to phpMyAdmin] Here's the schema built in MySQL — you can see the three tables: customers, orders, and products, connected exactly the way the ERD shows."

*(Screen-record: open phpMyAdmin → superstore_db → Structure tab showing the 3 tables → briefly click into each to show a few rows.)*

## 4. SQL Queries Walkthrough (3:45–7:00)
**On screen:** phpMyAdmin SQL tab — run each query live, or show the saved screenshots from the report.

> Tip: you don't have to read every line of SQL aloud. Say what the query is *for*, run it, then point at the interesting number in the result.

**4a. Basic retrieval (3:45–4:30)**
**SAY:**
> "First, some basic filtering. This query pulls every order over $500 in sales, sorted highest to lowest — that shows which individual transactions are the biggest revenue drivers. This second one filters all orders placed in 2017, so we can look at one year's activity in order."

**4b. Aggregates — category & region (4:30–5:30)**
**On screen:** Query 2A and 2B results.
**SAY:**
> "Next we grouped the data to get totals. By category: Technology brought in about $63,800 in total sales and roughly $6,776 profit — the highest of the three in our SQL sample — followed by Office Supplies, then Furniture, which actually posted a loss overall.
>
> By region, we looked at average profit per order instead of just totals, because a region with tons of orders isn't automatically the most profitable one. The South region had the highest average profit per order, even with the fewest total orders — a leaner, more efficient market, not just a bigger one."

**4c. Joins — top customers & sub-categories (5:30–6:30)**
**On screen:** Query 3A and 3B results.
**SAY:**
> "To answer 'who matters most,' we joined orders with customers to find our top 10 highest-spending customers — useful for loyalty programs or account management. Then we joined orders with products to rank every sub-category, like Phones, Chairs, or Binders, by revenue and profit — this already shows some categories, like Tables and Bookcases, selling but actually losing money."

**4d. Business insight queries — trend & discount (6:30–7:00)**
**On screen:** Query 4A (monthly trend) and 4B (discount vs profit) results.
**SAY:**
> "These last two go straight at our business questions. One groups sales by month to show seasonal peaks — sales spike around the holidays. The other lists the least profitable sub-categories next to their average discount rate, and the pattern is clear: the categories getting discounted hardest are the ones losing money. That's exactly what Joel is going to dig into statistically later."

## 5. Checkpoint 1 Wrap-Up & Handoff (7:00–7:20)
**SAY:**
> "So that covers Checkpoint 1 — the business problem, the dataset, the database design, and the SQL queries. Now I'll hand it over to Rudelyn and Joel, who'll walk you through Checkpoint 2: the spreadsheet analysis and the statistics behind it."

---

# CHECKPOINT 2 — presented by Rudelyn and Joel

## 6. Spreadsheet Analytics — Excel Workbook (7:20–9:20)
**Speaker:** Rudelyn
**On screen:** `Checkpoint2_Spreadsheet_Analysis.xlsx` — walk through the sheet tabs.

**SAY:**
> "Thanks, Sugar-Rey. For Checkpoint 2, we moved the same cleaned dataset into Excel to build pivot-style summaries and dashboards using live formulas — SUMIF, AVERAGEIF, COUNTIF — instead of static numbers, so everything updates if the data changes.
>
> [switch to Sheet 2/3] We built three summary tables with charts:
> - By **category**: Technology leads with about $836,000 in total sales and roughly $145,000 profit, but Furniture — despite $742,000 in sales — only nets about $18,000 profit, and it also carries the highest average discount at 17.4%.
> - By **region**: the West region has both the highest total sales, around $725,000, and the highest average profit per order at $33.85 — our strongest all-around region.
> - By **customer segment**: Consumers make up just over half of all revenue at 50.6%, with Corporate at about 31% and Home Office at 19%.
>
> [switch to Sheet 4] We also built a small showcase of Excel functions tied to real business questions — SUMIF for total Technology sales, COUNTIF for orders shipped to the West, AVERAGEIF for average Corporate profit, an IF flag for whether our average discount counts as 'high,' XLOOKUP to pull up the sales value for any Order ID, and TEXT to format the report date."

**Bridge (9:20–9:30):**
**SAY:**
> "Now Joel is going to show the statistics behind these numbers — how consistent sales and profit really are, whether discounts are really the culprit, and what we can actually forecast."

## 7. Descriptive Statistics (9:30–11:00)
**Speaker:** Joel
**On screen:** Task 2.2 table (Sales/Profit/Discount: mean, median, mode, std dev, min/max) and the frequency distribution chart (Figure 2.4).

**SAY:**
> "Thanks, Rudelyn. We ran descriptive statistics on Sales, Profit, and Discount across all 9,994 order lines.
>
> For **Sales**, the average order is about $230, but the median — the true middle value — is only $54.49. That gap means the data is heavily skewed: most purchases are small, everyday orders, and a handful of huge orders, up to $22,638, drag the average way up. So 'the average sale is $230' is technically true but misleading for planning purposes.
>
> For **Profit**, average profit per order line is $28.66, but the median is only $8.67 — and the minimum is actually negative, almost $6,600 in the red on one order. A mode of exactly $0 profit shows a lot of orders barely break even. This is the first hard evidence that profit is inconsistent order by order, not just at the category level.
>
> For **Discount**, the average is 15.6%, but the most common discount given — the mode — is 0%. A lot of orders get no discount at all, while a separate cluster gets discounted heavily, up to 80%. It's not one uniform pricing policy — it looks more like ad hoc or clearance-style discounting."

## 8. Correlation Analysis (11:00–12:15)
**Speaker:** Joel
**On screen:** Figure 2.5 (Sales vs Profit scatter) and Figure 2.6 (Discount vs Profit scatter).

**SAY:**
> "Next we tested two relationships directly.
>
> [Figure 2.5] Sales versus Profit: the correlation is **r = 0.48** — positive, but only moderate. Bigger sales tend to mean more profit, which makes sense, but it's far from a guarantee — a big-ticket order can still lose money.
>
> [Figure 2.6] Discount versus Profit: the correlation is **r = -0.22** — negative, but weak-to-moderate. As discount goes up, profit tends to go down, confirming what we suspected in Checkpoint 1's business question about discounting. But because it's not a *strong* negative correlation, discount isn't the only thing killing profit — category and product margin matter too. That's why we went one step further into regression."

## 9. Regression & Forecast at the Order Level (12:15–13:45)
**Speaker:** Joel
**On screen:** Figure 2.7 (regression line) and the regression statistics table.

**SAY:**
> "We built a simple linear regression predicting **Profit from Sales**. The equation came out to:
>
> Profit = -12.73 + (0.18 × Sales)
>
> In plain terms: for every extra dollar in sales, we'd expect about 18 cents more profit, but there's a baseline of about -$12.73 built in — meaning very small orders are expected to lose money before that scales up.
>
> The R-squared is about 0.23, meaning Sales alone explains roughly 23% of what drives Profit — real, but far from the whole story. The relationship is statistically significant, with a p-value under 0.001, so it's not random noise.
>
> Using this equation we can sanity-check some scenarios: a $500 sale is predicted to earn about $77 profit; a $5,000 sale, about $888; a $10,000 sale, about $1,788. But this is a single-variable model — it doesn't factor in discount or category — so we treat it as a directional estimate, not a precise prediction for any one order. A fuller model with discount and category is planned for Checkpoint 4."

## 10. Trend & Seasonality — the Forecast (13:45–15:00)
**Speaker:** Joel
**On screen:** Figure 2.8 (monthly sales trend with 6-month forecast line).

**SAY:**
> "Finally, this answers our fifth business question directly: what will next quarter look like? We have 48 months of order data, January 2014 through December 2017. Fitting a linear trend line to monthly sales gives a slope of about **$902 in additional sales per month**, with an R-squared around 0.25.
>
> That R-squared is moderate, not high — expected, because sales are seasonal. There are visible spikes every year around Q4 — September and especially November–December — that a straight line can't capture on its own. So our 6-month forecast, projecting into early-to-mid 2018 from about $70,000 up to roughly $74,500 a month, should be read as a general upward trajectory, not a guarantee for any single month. A seasonal model would do better for actual inventory planning — a natural next step for this project."

---

## 11. Conclusion & Recommendations (15:00–16:00)
**Speaker:** Sugar-Rey (returns to close it out)

**SAY:**
> "Thanks, Joel and Rudelyn. Pulling it all together and answering our original five questions:
> - Technology and the West region are our strongest performers on both revenue and profit.
> - Discounting is correlated with lower profit, but it's not acting alone — category and product economics matter just as much, which is why some deeply discounted sub-categories, like Tables and Bookcases, are actually losing money.
> - Sales are seasonal, with a real but modest upward trend of about $900 a month, and a clear holiday-season spike.
> - Consumer is our largest customer segment by revenue share, at just over 50%.
> - And we now have a working, if simple, way to forecast future sales and estimate profit from sales volume — something we'll refine with a multi-variable model in the next checkpoint.
>
> Thanks for watching — this has been Manta Ray's Checkpoint 1 and 2 walkthrough for Sales Performance and Revenue Forecasting."

---

## Recording Notes

**Split of labor:**
| Section | Speaker | Runtime |
|---|---|---|
| Intro | Sugar-Rey | 0:20 |
| **Checkpoint 1 (all sections)** | **Sugar-Rey** | **6:40** |
| — Business problem | | 1:10 |
| — Dataset | | 1:00 |
| — Database design (ERD + phpMyAdmin) | | 1:15 |
| — SQL queries (all 8) | | 3:15 |
| Handoff | Sugar-Rey | 0:20 |
| **Checkpoint 2 — spreadsheet** | **Rudelyn** | **2:10** |
| Bridge | Rudelyn → Joel | 0:10 |
| **Checkpoint 2 — statistics** | **Joel** | **5:30** |
| — Descriptive statistics | | 1:30 |
| — Correlation | | 1:15 |
| — Regression | | 1:30 |
| — Trend/forecast | | 1:15 |
| Conclusion | Sugar-Rey | 1:00 |
| **Total** | | **~16:00** |

If that's too long for your assignment's time limit, the easiest cuts are: show only 4 of the 8 SQL queries live in Checkpoint 1 (mention the rest briefly over a screenshot), and shorten Rudelyn's Excel section to just the three pivot tables without the formula showcase.

**Practical tips:**
- Since Checkpoint 1 is one continuous speaker (you), you can record it in one sitting — just pause a beat between sections 1–5 so it's easy to trim in editing if needed.
- Record Rudelyn's and Joel's Checkpoint 2 sections as **separate clips**, then stitch all three people's parts together in one edit — much easier than a single continuous take with three people.
- Whoever is talking about a screen should have that window **already open and zoomed in** before hitting record — no dead air opening phpMyAdmin or Excel.
- Move the mouse cursor to point at the actual number being discussed (e.g., hover over the $902 slope, the r = -0.22 cell) — it keeps the viewer's eye anchored.
- Say numbers naturally ("about two hundred thirty dollars"), don't read out every decimal.
- A short title card at the start and a "Thanks for watching" card at the end make it feel finished with almost no extra effort.
