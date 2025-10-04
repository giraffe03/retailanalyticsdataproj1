-- Top 10 brands by total sales
SELECT 
    p.brand,
    ROUND(SUM(f.price), 2) AS total_sales
FROM fact_sales f
JOIN dim_product p 
    ON f.product_id = p.product_id
WHERE p.brand IS NOT NULL AND p.brand <> ''
GROUP BY p.brand
ORDER BY total_sales DESC
LIMIT 10;