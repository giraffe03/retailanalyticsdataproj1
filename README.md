Retail Sales Analytics Project


Project Purpose:
The purpose of this project is to demonstrate a full data analytics pipeline: from raw data ingestion to ETL, SQL validation, and visualization in Power BI. The end goal is to provide business insights on sales performance, customer behavior, and brand performance.

Dataset Source & Size -- 

Source: Kaggle e-commerce transactions dataset
Size: 2.6M+ rows of transactional data
Fields include: event time, order ID, product ID, category_id, category_code, brand, price, and user ID.

Tools Used -- 

Python (Pandas): Data cleaning, preprocessing, and ETL script (etl.py)
SQLite: Relational database for storing fact & dimension tables
SQL: Data validation and business queries (sql/validation.sql, sql/top_sales_by_brand.sql, etc.)
Power BI: Interactive dashboards and data visualization
DAX: Custom measures for sales and KPI calculations

How to Run the ETL -- 

Place the raw dataset in the raw_data/ folder.
Example: raw_data/online_retail.csv

Run the ETL script: python etl.py

This will:

1) Clean the raw dataset
2) Create a star schema with fact_sales and dimension tables (dim_product, dim_customer, dim_date)
3) Store results in db/analytics.db

How to Open Dashboards -- 

1) Open the RetailAnalytics.pbix Power BI file.
2) Connect to the SQLite database (db/analytics.db) if prompted.
3) Explore the following dashboards:
- Total Sales Overview
- Top Brands by Sales
- Year over Year Growth

Key Findings & Business Recommendations--

Top Brands: Apple and Samsung lead sales, but Huawei shows strong growth in audio accessories.
Category Trends: Electronics dominate sales revenue, while furniture shows seasonal peaks.
Customer Insights: A small % of repeat customers drive a disproportionate share of revenue → potential loyalty program opportunity.
Price Optimization: Products with higher-than-average unit prices but steady sales (e.g., Apple smartphones) suggest brand-driven demand; discounting may not be necessary.

Recommendations:

Invest in top brands (Apple, Samsung) while promoting growth categories (audio, furniture).
Launch customer loyalty initiatives to retain repeat buyers.
Expand accessory categories