import pandas as pd
import sqlite3
from pathlib import Path

RAW = Path('./raw_data/online_retail.csv')
DB = Path('./db/analytics.db')

print("RUN ME!")
# Read the CSV file with date parsing
df = pd.read_csv(RAW, parse_dates=['event_time'], dayfirst=True, encoding='ISO-8859-1')

# Rename to safe column names
df.columns = [c.strip() for c in df.columns]

# Cleaning
df = df.dropna(subset=['user_id'])
df['user_id'] = df['user_id'].astype(str)
df['event_time'] = pd.to_datetime(df['event_time'], errors='coerce')


# dim_product
df['product_id'] = df['product_id'].astype(str).str.strip()
df = df[df['price'] > 0]  # remove invalid prices

# Create dim_product
dim_product = (
    df.groupby(['product_id'], as_index=False)
      .agg(
          unit_price=('price','mean'),
          category_code=('category_code','first'),
          category_id=('category_id','first'),
          brand=('brand','first')
      )
)

# dim_customer

dim_customer = (df.groupby('user_id', as_index=False)
                .agg(
                    first_order_date=('event_time','min'),
                    price=('price','sum')
                    )
                )

# dim_date
dates = pd.DataFrame({'date_key': df['event_time'].dt.date.unique()})
dates['year'] = pd.DatetimeIndex(dates['date_key']).year
dates['month'] = pd.DatetimeIndex(dates['date_key']).month
dates['day'] = pd.DatetimeIndex(dates['date_key']).day
dates['quarter'] = pd.DatetimeIndex(dates['date_key']).quarter
dates['weekday'] = pd.DatetimeIndex(dates['date_key']).weekday

# fact_sales
fact_sales = df[['order_id', 'event_time','product_id', 'category_id', 'category_code', 'brand', 'price', 'user_id']].copy()
fact_sales.columns = ['order_id', 'event_time','product_id', 'category_id', 'category_code', 'brand', 'price', 'user_id']
fact_sales['date_key'] = fact_sales['event_time'].dt.date.astype(str)
fact_sales['event_time'] = fact_sales['event_time'].astype(str)
fact_sales['user_id'] = fact_sales['user_id'].astype(str)
fact_sales['product_id'] = fact_sales['product_id'].astype(str)

# Write to SQLite

conn = sqlite3.connect(DB)
dim_product.to_sql('dim_product', conn, if_exists='replace', index=False)
dim_customer.to_sql('dim_customer', conn, if_exists='replace', index=False)
dates.to_sql('dim_date', conn, if_exists='replace', index=False)
fact_sales.to_sql('fact_sales', conn, if_exists='replace', index=False)
conn.close()

print("ETL complete: wrote dim_product, dim_customer, dim_date, fact_sales to", DB)
