-- =============================================
-- MAIN PRICING FACT VIEW
-- =============================================
CREATE VIEW vw_product_pricing_fact AS
SELECT
    m.product_id,
    p.product_name,
    p.category,
    m.date,
    m.price,
    m.quantity,
    m.revenue,
    m.margin_pct,
    m.elasticity,
    m.elasticity_category,
    m.competitor_price,
    m.price - m.competitor_price AS competitor_gap,
    m.pct_price_change,
    m.pct_qty_change,
    f.rolling_qty_7,
    f.rolling_price_7
FROM pricing_metrics m
JOIN stg_products p ON m.product_id = p.product_id
JOIN pricing_features f ON m.product_id = f.product_id AND m.date = f.date;

-- =============================================
-- CATEGORY SUMMARY FOR DASHBOARDS
-- =============================================
CREATE VIEW vw_category_summary AS
SELECT *
FROM category_pricing_summary;

-- =============================================
-- FORECASTING INPUT VIEW
-- =============================================
CREATE VIEW vw_forecasting_input AS
SELECT
    product_id,
    date,
    quantity,
    price,
    competitor_price,
    stock_on_hand
FROM pricing_features;

-- =============================================
-- PRICING RECOMMENDATIONS (WAITING FOR ML OUTPUT)
-- =============================================
CREATE VIEW vw_pricing_recommendations AS
SELECT
    product_id,
    current_price,
    optimal_price,
    expected_revenue
FROM optimized_prices;
