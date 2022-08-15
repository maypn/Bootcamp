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
