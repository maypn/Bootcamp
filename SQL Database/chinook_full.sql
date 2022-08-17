-- select column
SELECT 
	firstname,
    	lastname,
    	-- create FullName collumn
    	firstname || " " || lastname AS FullName,
    	-- creare email column
    	LOWER(firstname) || '.' || LOWER(SUBSTR(lastname, 1,1)) || '@datarockie.com' AS new_email
FROM customers;


-- select by condition
SELECT 
	invoicedate,
   	CAST(STRFTIME("%Y", invoicedate) AS INT) AS Year,
   	CAST(STRFTIME("%m", invoicedate) AS INT) AS Month,
   	CAST(STRFTIME("%d", invoicedate) AS INT) AS Day,
    	STRFTIME("%Y-%m", invoicedate) AS month_id,
   	billingcity,
    	total,
   	ROUND(total * 0.07, 2) as vat
FROM invoices
-- filter by condition
WHERE STRFTIME("%Y-%m", invoicedate) = "2009-09";


SELECT
	customerid,
	firstname,
    	lastname,
    	country,
    	company
FROM customers
WHERE customerid BETWEEN 1 AND 10;

/*WHERE (country = 'USA' AND company is NOT NULL)
	OR country in('Belgium', 'Germany', 'France');*/
  
  
-- case when
SELECT 
	country,
    	CASE
    		WHEN country IN('USA', 'CANADA') THEN 'USA/CND'
        	WHEN country IN('France', 'Belgium', 'Germany') THEN 'European'
        	WHEN country = 'Brazil' THEN 'Sount America'
    		ELSE 'other'
    	END AS region
FROM customers;


-- coalesce
SELECT
	firstname,
    	company,
    	-- create column using case when
    	CASE
    		WHEN company is NULL THEN 'End Customers'
        	WHEN company is NOT NULL THEN 'Business/ Corporate'
    	END AS Segment,
    	-- replace NULL 
    	COALESCE(company, 'B2C') AS Clean_Company
FROM customers;


-- count number of each degment
SELECT segment, COUNT(segment) AS N
FROM
-- Table (inner query)
(SELECT
	firstname,
    CASE
    	WHEN company is NULL THEN 'End Customers'
        WHEN company is NOT NULL THEN 'Business/ Corporate'
    END AS Segment
FROM customers)
GROUP BY segment;


-- Join table
SELECT * FROM artists, albums
WHERE artists.artistid = albums.artistid;


-- inner join
SELECT 
	art.*,
   	alb.title
FROM artists as art
JOIN albums AS alb
ON art.artistid = alb.artistid;


-- join multiple tables
SELECT 
	art.*,
	gen.Name as genre_name,
    	alb.title,
    	tra.name,
    	tra.composer,
    	ROUND(tra.milliseconds/60000.0,4) as minute,
    	ROUND(tra.bytes/(1024*1024.0), 4) AS mb,
    	tra.unitprice
FROM artists as art
JOIN albums AS alb ON art.artistid = alb.artistid
JOIN tracks as tra on alb.albumid = tra.albumid
JOIN genres as gen ON tra.genreid = gen.genreid;


-- total sales by year
SELECT
	STRFTIME('%Y', InvoiceDate) as year,
    SUM(item.unitprice * item.Quantity) as sum_total
FROM invoices as inv
JOIN invoice_items as item on inv.InvoiceId = item.invoiceid
GROUP by 1;


-- Top 5 genres
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


-- subqueries == select(select)
SELECT firstname, lastname, email 
FROM (
	SELECT * FROM customers
	WHERE country = 'USA'
	) AS sub
ORDER by firstname;


-- common table expression // with
WITH sub AS (
	SELECT * FROM customers
	WHERE country = 'USA'
)

SELECT firstname, lastname, email
FROM sub
ORDER by firstname;


-- sub advance
-- top 5 total sales of USA customers in 2009
with usa_cus as (
	SELECT * FROM customers
  	where country = 'USA'
), inv_2009 as (
	SELECT * from invoices
  	WHERE STRFTIME('%Y', invoicedate) = '2009'
)

SELECT 
	cus.firstname,
    	SUM(inv.total) as sum_inv
FROM usa_cus cus
JOIN inv_2009 inv ON cus.customerid = inv.customerid
GROUP BY 1
ORDER by 2 DESC
limit 5;

-- or

SELECT 
	cus.firstname,
    	SUM(inv.total) as sum_inv
FROM (
  	SELECT * FROM customers
  	where country = 'USA') AS cus
JOIN (
  	SELECT * from invoices
  	WHERE STRFTIME('%Y', invoicedate) = '2009') as inv 
ON cus.customerid = inv.customerid
GROUP BY 1
ORDER by 2 DESC
limit 5;


-- subqueries with agg
select 
	Name,
    	bytes
from tracks
where bytes > (SELECT AVG(bytes) FROM tracks);


--
SELECT
	country,
    	state,
	count(country) as number_of_customers
FROM customers
GROUP by 1, 2
ORDER BY 3 DESC; -- coulumn index


--
SELECT 
	count(*),
    	count(company),
    	count(country),
    	-- count unique
    	COUNT(DISTINCT country)
FROM customers;


-- union
SELECT * FROM(
	SELECT firstname, lastname, country
	FROM customers
	where country = 'USA'
		UNION -- number of column is equal and same data type
	SELECT firstname, lastname, country
	FROM customers
	where country = 'France'
)
order by country;


-- union all (keep duplicate)
SELECT * FROM(
	SELECT firstname, lastname, country
	FROM customers
	where country = 'USA'
		UNION ALL 
	SELECT firstname, lastname, country
	FROM customers
	where country = 'France'
)
order by country;


-- crate new table (physical table)
CREATE TABLE if not EXISTS customer_use_france AS
	SELECT firstname, lastname, country
	FROM customers
	where country = 'USA'
		UNION
	SELECT firstname, lastname, country
	FROM customers
	where country = 'France';

-- delete table
drop TABLE customer_use_france;


-- virsual table (view) == stored query
-- to avoid drop table missing
CREATE view custome_inv_summary AS
    SELECT
        cus.firstname,
        cus.lastname,
        cus.country,
        SUM(inv.total) as total_invoice
    FROM customers cus
    join invoices inv on cus.CustomerId = inv.customerid
    GROUP by 1, 2
    ORDER by 4 DESC;
    
-- automatically update data following main data 
CREATE view top_ten_cus AS
	SELECT * FROM custome_inv_summary LIMIT 10;
	
-- Bar chart
BAR-SELECT lastname as label, total_invoice as y FROM top_ten_cus;

-- total revenue group by year
CREATE view revenue_by_year as
  SELECT 
      STRFTIME('%Y-%m', invoicedate) as month_id,
      ROUND(SUM(total),4) AS revenue
  FROM invoices
  GROUP by 1;

-- Line chart
LINE-SELECT month_id as lable, revenue as y FROM revenue_by_year;
	

-- window function
-- create new analytic column

/*SELECT
	-- create no. column 
    -- OVER() => over the whole dataset
    -- OVER(PARTITION by country) run no. group by country
    ROW_NUMBER() OVER(PARTITION by country) as row_num,
	firstname,
    lastname,
    country
FROM customers;*/

-- create 5 groups of song by Bytes
SELECT segment, COUNT(*) FROM(
  SELECT
      name,
      bytes,
      -- NTILE(5) => divided data into 5 groups
      -- OVER(ORDER by bytes) => Sort data by bytes
      NTILE(5) OVER(ORder by bytes) as segment
  FROM tracks
  )
GROUP by segment;

-- find segment 4
SELECT * FROM(
  SELECT
      name,
      bytes,
      -- NTILE(5) => divided data into 5 groups
      -- OVER(ORDER by bytes) => Sort data by bytes
      NTILE(5) OVER(ORder by bytes) as segment
  FROM tracks
  )
where segment = 4;


--
Drop view revenue_by_year;

CREATE view revenue_by_year as
  SELECT 
      STRFTIME('%Y', invoicedate) as year,
      ROUND(SUM(total),4) AS revenue
  FROM invoices
  GROUP by 1;


-- create cummulative column
SELECT 
	*,
    SUM(revenue) OVER(order by year) as running_total,
    ROUND(revenue/ (SELECT SUM(revenue) FROM revenue_by_year) * 100, 4) AS percent
FROM revenue_by_year;
