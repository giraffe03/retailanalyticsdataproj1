SELECT substr(date_key, 1, 7) AS year_month, SUM(price) as total_sales
FROM fact_sales
GROUP BY year_month
ORDER BY year_month;
