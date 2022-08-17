-- create FullName and new_email column
SELECT 
	firstname,
    	lastname,
    	firstname || " " || lastname AS FullName,
    	LOWER(firstname) || '.' || LOWER(SUBSTR(lastname, 1,1)) || '@google.com' AS new_email
FROM customers;


-- 1 replace null value on Company column (COALESCE)
-- 2 create Segment column (CASE WHEN)
SELECT
	firstname,
	company,
	-- replace NULL 
	COALESCE(company, 'B2C') AS Clean_Company,
	-- create column using case when
	CASE
		WHEN company is NULL THEN 'End Customers'
		WHEN company is NOT NULL THEN 'Business/ Corporate'
	END AS Segment
FROM customers;


-- Top 5 genres by number of song (JOIN table, GROUP BY, ORDER BY, LIMIT, agg function)
SELECT 
	ger.name as genre_name,
	COUNT(ger.name) AS count_song,
	ROUND(SUM(milliseconds/60000.0),4) as sum_minute,
	ROUND(sum(bytes/(1024*1024.0)),4) as sum_mb
FROM artists as art
JOIN albums AS alb ON art.artistid = alb.artistid
JOIN tracks as tra on alb.albumid = tra.albumid
JOIN genres as ger ON tra.genreid = ger.genreid
GROUP BY ger.name
ORDER by 2 DESC 
LIMIT 5;


-- top 5 total sales of USA customers in 2009 (common table expression)
with usa_cus as (
	SELECT * FROM customers
  	where country = 'USA'
), inv_2009 as (
	SELECT * from invoices
  	WHERE STRFTIME('%Y', invoicedate) = '2009'
)

SELECT 
	cus.customerid,
    	cus.firstname,
    	SUM(inv.total) as total_sales
FROM usa_cus cus
JOIN inv_2009 inv ON cus.customerid = inv.customerid
GROUP BY 1
ORDER by 3 DESC
limit 5;


-- top 5 total sales of USA customers in 2009 (subqueries)
SELECT 
	cus.customerid,
	cus.firstname,
    	SUM(inv.total) as total_sales
FROM (
  	SELECT * FROM customers
  	where country = 'USA') AS cus
JOIN (
  	SELECT * from invoices
  	WHERE STRFTIME('%Y', invoicedate) = '2009') as inv 
ON cus.customerid = inv.customerid
GROUP BY 1
ORDER by 3 DESC
limit 5;


-- 1 union USA customer table and France customer table
-- 2 create customer_usa_france table
CREATE TABLE if not EXISTS customer_usa_france AS
	SELECT firstname, lastname, country
	FROM customers
	where country = 'USA'
		UNION
	SELECT firstname, lastname, country
	FROM customers
	where country = 'France';

-- delete table
drop TABLE customer_usa_france;


-- 1 find total revenue group by year_month
-- 2 create vitual table
-- 3 insert time series chart: revenue
CREATE view revenue_by_year_month as
  SELECT 
      STRFTIME('%Y-%m', invoicedate) as year_month,
      ROUND(SUM(total),4) AS revenue
  FROM invoices
  GROUP by 1

LINE-SELECT year_month as lable, revenue as y FROM revenue_by_year_month;


-- window function
-- create row number column that group by country
SELECT
    ROW_NUMBER() OVER(PARTITION by country) as row_num,
	firstname,
    lastname,
    country
FROM customers;
