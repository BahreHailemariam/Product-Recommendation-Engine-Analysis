-- =============================================
-- 1. ADD BASIC TIME FEATURES
-- =============================================
ALTER TABLE fact_sales_enriched
ADD COLUMN price_change FLOAT;

ALTER TABLE fact_sales_enriched
ADD COLUMN qty_change FLOAT;

UPDATE fact_sales_enriched
SET price_change = price - LAG(price) OVER (PARTITION BY product_id ORDER BY date);

UPDATE fact_sales_enriched
SET qty_change = quantity - LAG(quantity) OVER (PARTITION BY product_id ORDER BY date);

-- =============================================
-- 2. COMPETITOR PRICE GAP
-- =============================================
ALTER TABLE fact_sales_enriched
ADD COLUMN competitor_gap FLOAT;

UPDATE fact_sales_enriched
SET competitor_gap = price - competitor_price;

-- =============================================
-- 3. ROLLING 7-DAY FEATURES
-- =============================================
CREATE TABLE IF NOT EXISTS pricing_features AS
SELECT
    *,
    AVG(quantity) OVER (PARTITION BY product_id ORDER BY date ROWS 6 PRECEDING)
        AS rolling_qty_7,
    AVG(price) OVER (PARTITION BY product_id ORDER BY date ROWS 6 PRECEDING)
        AS rolling_price_7
FROM fact_sales_enriched;

-- =============================================
-- 4. ELASTICITY BASE FEATURES
-- =============================================
ALTER TABLE pricing_features
ADD COLUMN pct_price_change FLOAT;

ALTER TABLE pricing_features
ADD COLUMN pct_qty_change FLOAT;

UPDATE pricing_features
SET pct_price_change = price_change / LAG(price) OVER (PARTITION BY product_id ORDER BY date);

UPDATE pricing_features
SET pct_qty_change = qty_change / LAG(quantity) OVER (PARTITION BY product_id ORDER BY date);
