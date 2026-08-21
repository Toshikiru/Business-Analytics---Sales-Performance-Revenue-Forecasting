-- ============================================================
-- BED 106 Business Analytics — Capstone Checkpoint 1
-- Project: Sales Performance & Revenue Forecasting
-- Dataset: Sample Superstore Sales Dataset (Kaggle)
-- ============================================================
-- HOW TO USE THIS FILE:
-- 1. Open MySQL Workbench
-- 2. Click File > Open SQL Script and select this file
--    OR just copy everything and paste into the query editor
-- 3. Click the lightning bolt button (Execute All) to run
-- ============================================================


-- ============================================================
-- STEP 1: CREATE THE DATABASE
-- ============================================================

CREATE DATABASE IF NOT EXISTS superstore_db;
USE superstore_db;


-- ============================================================
-- STEP 2: CREATE THE 3 TABLES
-- ============================================================

-- TABLE 1: customers
-- Stores all unique customer information
CREATE TABLE IF NOT EXISTS customers (
    customer_id   VARCHAR(20)  NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    segment       VARCHAR(30)  NOT NULL,   -- Consumer, Corporate, Home Office
    country       VARCHAR(50)  NOT NULL,
    city          VARCHAR(50)  NOT NULL,
    state         VARCHAR(50)  NOT NULL,
    postal_code   VARCHAR(20),
    region        VARCHAR(20)  NOT NULL,   -- East, West, Central, South
    PRIMARY KEY (customer_id)
);

-- TABLE 2: products
-- Stores all unique product information
CREATE TABLE IF NOT EXISTS products (
    product_id    VARCHAR(20)  NOT NULL,
    category      VARCHAR(30)  NOT NULL,   -- Furniture, Office Supplies, Technology
    sub_category  VARCHAR(30)  NOT NULL,   -- Chairs, Phones, Binders, etc.
    product_name  VARCHAR(255) NOT NULL,
    PRIMARY KEY (product_id)
);

-- TABLE 3: orders
-- Stores all order transactions, linked to customers and products
CREATE TABLE IF NOT EXISTS orders (
    order_id      VARCHAR(20)   NOT NULL,
    order_date    DATE          NOT NULL,
    ship_date     DATE          NOT NULL,
    ship_mode     VARCHAR(30)   NOT NULL,  -- First Class, Second Class, Standard Class, Same Day
    customer_id   VARCHAR(20)   NOT NULL,
    product_id    VARCHAR(20)   NOT NULL,
    sales         DECIMAL(10,2) NOT NULL,
    quantity      INT           NOT NULL,
    discount      DECIMAL(5,2)  NOT NULL,
    profit        DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, product_id),     -- composite key: one order can have multiple products
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id)  REFERENCES products(product_id)
);


-- ============================================================
-- STEP 3: VERIFY YOUR TABLES WERE CREATED
-- (Run this after Step 2 to confirm)
-- ============================================================

SHOW TABLES;
DESCRIBE customers;
DESCRIBE products;
DESCRIBE orders;


-- ============================================================
-- STEP 4: HOW TO IMPORT YOUR CSV DATA
-- ============================================================
-- After running this script, import your Superstore CSV like this:
--
-- 1. In MySQL Workbench, right-click your "superstore_db" database
--    in the left panel (Schemas tab)
-- 2. Click "Table Data Import Wizard"
-- 3. Browse to your "Sample - Superstore.csv" file and click Next
-- 4. Select "Use existing table" and pick "orders" first
-- 5. Match the CSV columns to the table columns
-- 6. Click Next > Next > Finish
--
-- IMPORTANT: The Superstore CSV is one flat file.
-- You need to import it 3 times — once per table.
-- MySQL will automatically skip rows with duplicate primary keys
-- so repeat customers and products won't cause errors.
--
-- Alternatively, use the LOAD DATA method below after placing
-- your CSV in the correct folder (see note on file path).
-- ============================================================


-- ============================================================
-- STEP 5: QUICK CHECK AFTER IMPORTING
-- Run these after your import to confirm data loaded correctly
-- ============================================================

-- How many rows in each table?
SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'products',                COUNT(*)               FROM products
UNION ALL
SELECT 'orders',                  COUNT(*)               FROM orders;

-- Preview first 5 rows of each table
SELECT * FROM customers LIMIT 5;
SELECT * FROM products  LIMIT 5;
SELECT * FROM orders    LIMIT 5;


-- ============================================================
-- STEP 6: YOUR 8 SQL QUERIES FOR CHECKPOINT 1
-- ============================================================

-- ── QUERY 1A: SELECT + WHERE + ORDER BY ─────────────────────
-- Business Question: Which orders had the highest sales amounts?
SELECT
    order_id,
    customer_id,
    order_date,
    sales,
    profit
FROM orders
WHERE sales > 500
ORDER BY sales DESC;

-- ── QUERY 1B: SELECT + WHERE + ORDER BY ─────────────────────
-- Business Question: What orders were placed in 2017?
SELECT
    order_id,
    order_date,
    ship_date,
    ship_mode,
    sales
FROM orders
WHERE YEAR(order_date) = 2017
ORDER BY order_date ASC;

-- ── QUERY 2A: GROUP BY + AGGREGATE ──────────────────────────
-- Business Question: Which product category earns the most?
SELECT
    p.category,
    SUM(o.sales)   AS total_sales,
    SUM(o.profit)  AS total_profit,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

-- ── QUERY 2B: GROUP BY + AGGREGATE ──────────────────────────
-- Business Question: Which region is the most profitable?
SELECT
    c.region,
    AVG(o.profit)     AS avg_profit_per_order,
    SUM(o.sales)      AS total_sales,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.region
ORDER BY avg_profit_per_order DESC;

-- ── QUERY 3A: JOIN (orders + customers) ─────────────────────
-- Business Question: Who are the top 10 highest-spending customers?
SELECT
    c.customer_name,
    c.segment,
    c.region,
    SUM(o.sales)      AS total_spent,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name, c.segment, c.region
ORDER BY total_spent DESC
LIMIT 10;

-- ── QUERY 3B: JOIN (orders + products) ──────────────────────
-- Business Question: Which sub-categories sell the most?
SELECT
    p.category,
    p.sub_category,
    SUM(o.sales)    AS total_revenue,
    SUM(o.quantity) AS units_sold,
    SUM(o.profit)   AS total_profit
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category, p.sub_category
ORDER BY total_revenue DESC;

-- ── QUERY 4A: BUSINESS INSIGHT — Monthly Sales Trend ────────
-- Business Question: What does the monthly sales trend look like over time?
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month_year,
    SUM(sales)                       AS monthly_sales,
    SUM(profit)                      AS monthly_profit,
    COUNT(order_id)                  AS orders_count
FROM orders
GROUP BY month_year
ORDER BY month_year ASC;

-- ── QUERY 4B: BUSINESS INSIGHT — Discount vs Profit ─────────
-- Business Question: Do higher discounts lead to lower profits?
SELECT
    p.category,
    p.sub_category,
    ROUND(AVG(o.discount) * 100, 1) AS avg_discount_pct,
    SUM(o.sales)                    AS total_sales,
    SUM(o.profit)                   AS total_profit
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category, p.sub_category
ORDER BY total_profit ASC
LIMIT 10;


-- ============================================================
-- END OF SCRIPT
-- ============================================================
