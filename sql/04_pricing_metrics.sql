-- =============================================
-- 1. ADD REVENUE & MARGIN %
-- =============================================
CREATE TABLE pricing_metrics AS
SELECT
    product_id,
    date,
    price,
    quantity,
    margin,
    competitor_price,
    revenue = price * quantity,
    margin_pct = (price - cost) / price
FROM pricing_features;

-- =============================================
-- 2. PRICE ELASTICITY (SQL VERSION)
-- =============================================
ALTER TABLE pricing_metrics
ADD COLUMN elasticity FLOAT;

UPDATE pricing_metrics
SET elasticity = pct_qty_change / pct_price_change;

-- =============================================
-- 3. ELASTIC / INELASTIC TAGS
-- =============================================
ALTER TABLE pricing_metrics
ADD COLUMN elasticity_category TEXT;

UPDATE pricing_metrics
SET elasticity_category =
    CASE
        WHEN elasticity <= -1 THEN 'Elastic'
        WHEN elasticity > -1 THEN 'Inelastic'
        ELSE 'Unknown'
    END;

-- =============================================
-- 4. CATEGORY-LEVEL SUMMARY
-- =============================================
CREATE TABLE category_pricing_summary AS
SELECT
    p.category,
    AVG(m.elasticity) AS avg_elasticity,
    AVG(m.revenue) AS avg_revenue,
    AVG(m.margin_pct) AS avg_margin_pct
FROM pricing_metrics m
JOIN stg_products p ON m.product_id = p.product_id
GROUP BY p.category;
