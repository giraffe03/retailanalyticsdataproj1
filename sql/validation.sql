-- row counts
SELECT 'staging_rows' AS metric, COUNT(*) AS value FROM fact_sales;
SELECT 'dim_product_rows' AS metric, COUNT(*) AS value FROM dim_product;
SELECT 'dim_customer_rows' AS metric, COUNT(*) AS value FROM dim_customer;
SELECT 'dim_date_rows' AS metric, COUNT(*) AS value FROM dim_date;

-- null key check
SELECT COUNT(*) AS null_keys FROM fact_sales WHERE user_id IS NULL OR product_id IS NULL OR date_key IS NULL;

-- foreign key integrity (customers)
SELECT COUNT(*) AS missing_customers
FROM fact_sales f LEFT JOIN dim_customer c ON f.user_id = c.user_id
WHERE c.user_id IS NULL;

-- sample top customers
SELECT user_id, SUM(price) AS lifetime_value, COUNT(DISTINCT order_id) as orders
FROM fact_sales GROUP BY user_id ORDER BY lifetime_value DESC LIMIT 10;