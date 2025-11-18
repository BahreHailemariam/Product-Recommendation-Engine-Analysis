-- =============================================
-- CLEAN & TRANSFORM RAW → STAGING
-- =============================================

-- Clean sales
INSERT INTO stg_sales
SELECT
    sale_id,
    order_id,
    product_id,
    date(date) AS date,
    CASE WHEN quantity < 0 THEN 0 ELSE quantity END AS quantity,
    CASE WHEN price < 0 THEN NULL ELSE price END AS price
FROM raw_sales
WHERE price IS NOT NULL AND product_id IS NOT NULL;

-- Clean products
INSERT INTO stg_products
SELECT
    product_id,
    TRIM(product_name),
    LOWER(category) AS category,
    CASE WHEN cost < 0 THEN NULL ELSE cost END AS cost
FROM raw_products;

-- Clean competitor prices
INSERT INTO stg_competitors
SELECT
    product_id,
    competitor,
    CASE WHEN competitor_price < 0 THEN NULL ELSE competitor_price END,
    date(date)
FROM raw_competitors;

-- Clean inventory
INSERT INTO stg_inventory
SELECT
    product_id,
    CASE WHEN stock_on_hand < 0 THEN 0 ELSE stock_on_hand END,
    replenishment_days,
    date(recorded_at)
FROM raw_inventory;

-- =============================================
-- POPULATE FACT TABLE WITH CLEANED DATA
-- =============================================
INSERT INTO fact_sales_enriched
SELECT
    s.sale_id,
    s.product_id,
    s.date,
    s.quantity,
    s.price,
    c.competitor_price,
    p.cost,
    (s.price - p.cost) AS margin,
    i.stock_on_hand,
    NULL AS seasonality_score
FROM stg_sales s
LEFT JOIN stg_products p ON s.product_id = p.product_id
LEFT JOIN stg_inventory i ON s.product_id = i.product_id
LEFT JOIN stg_competitors c 
    ON s.product_id = c.product_id
    AND s.date = c.date;
