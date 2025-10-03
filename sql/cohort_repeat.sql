WITH first_order AS (
  SELECT user_id, MIN(date_key) as first_date
  FROM fact_sales
  GROUP BY user_id
),
joined AS (
  SELECT f.user_id, f.date_key, fo.first_date,
    (strftime('%Y', f.date_key) || '-' || strftime('%m', f.date_key)) as order_month,
    ( (strftime('%Y', f.date_key) - strftime('%Y', fo.first_date))*12 + (strftime('%m', f.date_key) - strftime('%m', fo.first_date)) ) as months_since_first
  FROM fact_sales f
  JOIN first_order fo ON f.user_id = fo.user_id
)
SELECT first_date as cohort_month, months_since_first, COUNT(DISTINCT user_id) AS users
FROM joined
GROUP BY cohort_month, months_since_first
ORDER BY cohort_month, months_since_first;