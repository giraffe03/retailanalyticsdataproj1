SELECT substr(date_key, 1, 10) AS year_day, SUM(price) as total_sales
FROM fact_sales
GROUP BY year_day
ORDER BY year_day;
