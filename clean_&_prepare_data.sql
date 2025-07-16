/*===========================================================
  Bank Customer Churn Analysis
  Data Cleaning & Preparation
  Run date: 2025‑06‑16
===========================================================*/



/*******************************
  1. STANDARDISE GEOGRAPHY
*******************************/
/* 
Standardise Geography names
Replaces 'FRA' and 'French' with 'France'
*/
UPDATE customer_info
SET Geography = 'France'
WHERE Geography IN ('FRA', 'French')



/*******************************
  2. DEDUPLICATION
*******************************/
-- Remove duplicate CustomerId entries, keeping the first occurrence
DELETE cte_duplicate
FROM 
	(
	SELECT *,
	DupCustomer = ROW_NUMBER() OVER (
				PARTITION BY CustomerId ORDER BY (SELECT NULL))
	FROM customer_info
	) AS cte_duplicate
WHERE DupCustomer > 1;

DELETE cte_duplicate
FROM 
	(
	SELECT *,
	DupCustomer = ROW_NUMBER() OVER (
				PARTITION BY CustomerId ORDER BY (SELECT NULL))
	FROM account_info
	) AS cte_duplicate
WHERE DupCustomer > 1;


/*********************************************
  4. FIX MISSING OR INVALID VALUES
*********************************************/
/* 
Fix erroneous entries for CustomerIds 15728693, 15580203, and 15756954
Original values: Surname = NULL, Age = NULL, EstimatedSalary = -999999.00
Correct values (verified from 'Bank_Churn.xlsx'):
- 15728693 → Surname = 'McWilliams', Age = 43, EstimatedSalary = 100187.43
- 15580203 → Surname = 'Kennedy', Age = 39, EstimatedSalary = 100130.95
- 15756954 → Surname = 'Lombardo', Age = 32, EstimatedSalary = 80130.54
*/
UPDATE customer_info
SET Surname = 'McWilliams', Age = 43, EstimatedSalary = 100187.43
WHERE CustomerId = 15728693;
UPDATE customer_info
SET Surname = 'Kennedy', Age = 39, EstimatedSalary = 100130.95
WHERE CustomerId = 15580203;
UPDATE customer_info
SET Surname = 'Lombardo', Age = 32, EstimatedSalary = 80130.54
WHERE CustomerId = 15756954;



/*********************************************
  5. FEATURE ENGINEERING: AGE & CREDIT BANDS
*********************************************/
-- Show unique ages in the table
SELECT DISTINCT Age
FROM customer_info
ORDER BY Age;

-- Add new column to store age brackets
ALTER TABLE customer_info
ADD AgeBracket VARCHAR(10);

-- Update AgeBracket based on Age ranges
UPDATE customer_info
SET AgeBracket =
	CASE 
		WHEN Age < 26 THEN '18-25'
		WHEN Age BETWEEN 26 AND 35 THEN '26-35'
		WHEN Age BETWEEN 36 AND 45 THEN '36-45'
		WHEN Age BETWEEN 46 AND 55 THEN '46-55'
		ELSE '56+'
	END;

-- Add new column to store credit score ranges
ALTER TABLE customer_info
ADD CreditScoreBand VARCHAR(15);

-- Update CreditScoreBand based on credit score ranges
UPDATE customer_info
SET CreditScoreBand =
	CASE 
		WHEN CreditScore < 580 THEN 'Poor'
		WHEN CreditScore BETWEEN 580 AND 669 THEN 'Fair'
		WHEN CreditScore BETWEEN 670 AND 739 THEN 'Good'
		WHEN CreditScore BETWEEN 740 AND 799 THEN 'Very Good'
		ELSE 'Excellent'
		END;

-- Add new column to store tenure buckets
ALTER TABLE account_info
ADD TenureBucket VARCHAR(10);

-- Update TenureBucket based on Tenure ranges
UPDATE account_info
SET TenureBucket =
	CASE 
		WHEN Tenure < 3 THEN '0-2'
		WHEN Tenure BETWEEN 3 AND 5 THEN '3-5'
		ELSE '6+'
	END;

-- Add new column to store balance buckets
ALTER TABLE account_info
ADD BalanceBucket VARCHAR(20);

-- Update BalanceBucket based on balance ranges
UPDATE account_info
SET BalanceBucket = 
  CASE 
    WHEN Balance < 0 THEN '<0'
    WHEN Balance BETWEEN 0 AND 25000 THEN '0-25k'
    WHEN Balance BETWEEN 25001 AND 50000 THEN '25k-50k'
    WHEN Balance BETWEEN 50001 AND 75000 THEN '50k-75k'
    WHEN Balance BETWEEN 75001 AND 100000 THEN '75k-100k'
    WHEN Balance > 100000 THEN '100k+'
    ELSE 'Unknown'
  END;