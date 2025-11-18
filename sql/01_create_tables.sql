-- =============================================
-- 1. RAW TABLES
-- =============================================
CREATE TABLE IF NOT EXISTS raw_sales (
    sale_id INTEGER PRIMARY KEY,
    order_id TEXT,
    product_id TEXT,
    date TEXT,
    quantity INTEGER,
    price FLOAT
);

CREATE TABLE IF NOT EXISTS raw_products (
    product_id TEXT PRIMARY KEY,
    product_name TEXT,
    category TEXT,
    cost FLOAT
);

CREATE TABLE IF NOT EXISTS raw_competitors (
    product_id TEXT,
    competitor TEXT,
    competitor_price FLOAT,
    date TEXT
);

CREATE TABLE IF NOT EXISTS raw_inventory (
    product_id TEXT,
    stock_on_hand INTEGER,
    replenishment_days INTEGER,
    recorded_at TEXT
);

-- =============================================
-- 2. STAGING TABLES
-- =============================================
CREATE TABLE IF NOT EXISTS stg_sales AS
SELECT * FROM raw_sales WHERE 1 = 0;

CREATE TABLE IF NOT EXISTS stg_products AS
SELECT * FROM raw_products WHERE 1 = 0;

CREATE TABLE IF NOT EXISTS stg_competitors AS
SELECT * FROM raw_competitors WHERE 1 = 0;

CREATE TABLE IF NOT EXISTS stg_inventory AS
SELECT * FROM raw_inventory WHERE 1 = 0;

-- =============================================
-- 3. ANALYTICS FACT TABLE
-- =============================================
CREATE TABLE IF NOT EXISTS fact_sales_enriched (
    sale_id INTEGER,
    product_id TEXT,
    date DATE,
    quantity INTEGER,
    price FLOAT,
    competitor_price FLOAT,
    cost FLOAT,
    margin FLOAT,
    stock_on_hand INTEGER,
    seasonality_score FLOAT,
    PRIMARY KEY (sale_id)
);
