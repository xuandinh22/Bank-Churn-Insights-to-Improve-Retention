/*===========================================================
  Bank Customer Churn Analysis
  Inspection & Data Quality Checks
  Run date: 2025‑06‑16
===========================================================*/



/*******************************
  1. INITIAL INSPECTION
********************************/
-- Check the data type of the two tables
exec sp_help customer_info;

exec sp_help account_info; 

-- See all data from account_info table
SELECT *
FROM account_info;

-- See all data from customer_info table
SELECT *
FROM customer_info;

-- Total customer
SELECT COUNT (CustomerId) AS Total_Customer
FROM customer_info;




/*****************************
  2. DATA QUALITY CHECKS
******************************/
/* 
Check for inconsistent geography entries
Found inconsistent entries for 'France' such as 'FRA' and 'French'
*/
SELECT DISTINCT (Geography) 
FROM customer_info;

/*
Identify duplicate CustomerId values in the customer_info table
1 duplicate found for CustomerId: 15628319
*/
SELECT CustomerId, 
	   COUNT(*) AS Duplicates
FROM customer_info
GROUP BY CustomerId
HAVING COUNT(*) > 1

/*
Identify duplicate CustomerId values in the account_info table
1 duplicate found for CustomerId: 15634602
*/
SELECT CustomerId, 
	   COUNT(*) AS Duplicates
FROM account_info
GROUP BY CustomerId
HAVING COUNT(*) > 1

-- Identify rows with missing surname or salary placeholder (-999999.00)
SELECT *
FROM customer_info
WHERE Surname IS NULL OR EstimatedSalary = -999999.00;