# import data
import pandas as pd 
df = pd.read_csv("sample-store.csv")

# preview top 5 rows
df.head()

# shape of dataframe
df.shape

# see data frame information
df.info()


## TODO - convert order date and ship date to datetime in the original dataframe
# pd.to_datetime() => convert to datetime
order_date = pd.to_datetime(df['Order Date'], format='%m%d%Y')
df['Order Date'] = order_date

ship_date = pd.to_datetime(df['Ship Date'], format='%m/%d/%Y')
df['Ship Date'] = ship_date

df.head()


## TODO - filter rows with missing values
df[ df['Postal Code'].isna() ]


## TODO - Explore this dataset on your owns, ask your own questions
# find Total Sales group by Category for each Region
df.head()
df.groupby(['Category', 'Region'])['Sales'].sum().reset_index()\
    .sort_values(['Category','Sales'], ascending=False)


## TODO 01 - how many columns, rows in this dataset
df.shape 


## TODO 02 - is there any missing values?, if there is, which colunm? how many nan values?
df.isna().sum() 


## TODO 03 - your friend ask for `California` data, filter it and export csv for him
# filter California data
df_california = df[df['State'] == 'California']
df_california

# export to csv file
df_california.to_csv('california.csv')


## TODO 04 - your friend ask for all order data in `California` and `Texas` in 2017 (look at Order Date), send him csv file
# filter state == California or Texas
df_filter1 = df[ (df['State'] == 'California') | (df['State'] == 'Texas') ]

# filter California or Texas in 2017
df_filter = df_filter1[ (df_filter1['Order Date'] >= '2017-01-01') & (df_filter1['Order Date'] <= '2017-12-31') ]

df_filter.head()

# export to csv file
df_filter.to_csv('df_filter.csv')


## TODO 05 - how much total sales, average sales, and standard deviation of sales your company make in 2017
df['Sales'][ (df['Order Date'] >= '2017-01-01') & (df['Order Date'] <= '2017-12-31') ]\
    .agg(['sum', 'mean', 'std'])


## TODO 06 - which Segment has the highest profit in 2018
df.head()
df[ (df['Order Date'] >= '2018-01-01') & (df['Order Date'] <= '2018-12-31') ]\
.groupby('Segment')['Profit'].sum()


## TODO 07 - which top 5 States have the least total sales between 15 April 2019 - 31 December 2019
df[ (df['Order Date'] >= '2019-04-15') & (df['Order Date'] <= '2019-12-31') ]\
    .groupby('State')['Sales'].sum()\
    .sort_values().reset_index().head()


## TODO 08 - what is the proportion of total sales (%) in West + Central in 2019 e.g. 25%
# filter Order Date in 2019
order_2019 = df[ (df['Order Date'] >= '2019-01-01') & (df['Order Date'] <= '2019-12-31') ]

# total Sales group by Region in 2019
sum_sales_region = order_2019.groupby('Region')['Sales'].sum()

# propotion of total sales = ( (West + Central) / Total ) * 100
sales_proportion_west_central_2019 = ((sum_sales_region['West'] + sum_sales_region['Central']) / sum_sales_region.sum())*100

print(f"Total Sales proportion in West + Central in 2019 is {sales_proportion_west_central_2019}")


## TODO 09 - find top 10 popular products in terms of number of orders vs. total sales during 2019-2020
df.head()

# filter Order Date during 2019-2020
year_2019_2020 = df[ (df['Order Date'] >= '2019-01-01') & (df['Order Date'] <= '2020-12-31') ]

# 10 popular products in terms of number of order
year_2019_2020.value_counts('Product Name')\
    .sort_values(ascending=False).reset_index()

# 10 popular products in terms of total sales
year_2019_2020.groupby('Product Name')['Sales'].sum()\
    .sort_values(ascending=False).reset_index()


## TODO 10 - plot at least 2 plots, any plot you think interesting :)
df.head()

# Scatter plot: Profit and Sales
df[ [ 'Profit', 'Sales' ] ].plot(x='Sales', y='Profit', kind='scatter', color='purple');

# Barh chart: Total Sales group by Category
cat_sales = df.groupby('Category')['Sales'].sum().reset_index()
cat_sales.plot(x='Category',y='Sales',kind='barh');

# Bar chart: Total Sales group by Region
cat_region = df.groupby('Region')['Sales'].sum().reset_index()
cat_region.plot(x='Region',y='Sales',kind='bar', color='orange');

# Barh chart: number of each Segment
df.value_counts('Segment').plot(kind='barh')


## TODO Bonus - use np.where() to create new column in dataframe to help you answer your own questions
# create is_profit column
df.head()

import numpy as np

df['is_profit'] = np.where( df['Profit'] > 0, "yep", "nope" )

df.head()
