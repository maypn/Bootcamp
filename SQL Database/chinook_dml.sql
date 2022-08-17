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
