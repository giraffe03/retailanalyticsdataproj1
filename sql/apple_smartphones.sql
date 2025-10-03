SELECT 
    substr(date_key, 1, 7) AS month,
    COUNT(*) as occurrences
FROM fact_sales
WHERE category_code = 'electronics.smartphone'
AND brand = 'apple'
GROUP BY month
ORDER BY month;