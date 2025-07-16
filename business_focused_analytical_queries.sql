/*===========================================================
  Bank Customer Churn Analysis
  Business-Focused Analytical Queries
  Analysis Question:
  ── What attributes are more common among churners than non-churners?
  ── Is there a difference between German, French, and Spanish customers in terms of account behavior?
  Run date: 2025‑06‑17
===========================================================*/

/******************************************************
  A. CUSTOMER BASE OVERVIEW & CHURN BENCHMARKS
*******************************************************/

/****** 1. Overall Churn Rate (%) ******/
/*
~20 % of customers have exited → retention is a priority.
*/
SELECT
	CONCAT(ROUND(100.0 * AVG(CAST(Exited AS FLOAT)), 1), '%') AS ChurnPct,
	COUNT(CASE WHEN Exited = 0 THEN CustomerId END) AS ReatainCustomer,
	COUNT(CASE WHEN Exited = 1 THEN CustomerId END) AS ExistCustomer
FROM account_info;



/****** 2. Credit Score Overview ******/
-- Average credit score of the customer base
SELECT 
	AVG(CreditScore) AS AvgCreditScore,
	MIN(CreditScore) AS MinCreditScore,
	MAX(CreditScore) AS MaxCreditScore
FROM customer_info;

-- Median credit score of the customer base 
-- Slightly left-skew in the distribution. 
SELECT DISTINCT
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY CreditScore) OVER() AS MedianCreditScore
FROM customer_info;

-- Customer Distribution by Credit Score Band
-- The customer base is a strong middle-tier.
SELECT
	CreditScoreBand,
	COUNT(*) AS NumOfCustomer,
	ROUND(CAST(100.0 * COUNT(*) / SUM(COUNT(*)) OVER () AS FLOAT), 1) AS PercentOfTotal
FROM customer_info
GROUP BY CreditScoreBand
ORDER BY 100.0 * COUNT(*) / SUM(COUNT(*)) OVER () DESC

-- Average, min, max CreditScore of customers who have churned (Exited = 1) and who have not churned (Exited = 0)
-- The average CreditScore and min CreditScore of churner is lower than non-churner
SELECT 
	ROUND(AVG(CreditScore), 2) AS ChurnerAvgCreditScore,
	MIN(CreditScore) AS MinCreditScore,
	MAX(CreditScore) AS MaxCreditScore
FROM customer_info cus
JOIN account_info acc ON cus.CustomerId = acc.CustomerId
WHERE Exited = 1;

SELECT 
	ROUND(AVG(CreditScore), 2) AS NonchurnerCreditScore,
	MIN(CreditScore) AS MinCreditScore,
	MAX(CreditScore) AS MaxCreditScore
FROM customer_info cus
JOIN account_info acc ON cus.CustomerId = acc.CustomerId
WHERE Exited = 0;



/****** 3. Current Balance Overview ******/
-- Average balance of the customer base
SELECT 
	ROUND(AVG(Balance), 2) AS AvgBalance,
	MIN(Balance) AS MinBalance,
	MAX(Balance) AS MaxBalance
FROM account_info;

-- Median balance of the customer base
/*
Left-skew in the distribution
*/
SELECT DISTINCT
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Balance) OVER() AS MedianBalance
FROM account_info;

-- Customer distribution by current balance 
/*
Most customers are either in the highest or lowest tier — a bimodal pattern.
The middle-balance tiers are underrepresented, this may indicate a gap in offerings. 
*/
SELECT
	BalanceBucket,
	COUNT(*) AS NumOfCustomer,
	ROUND(CAST(100.0 * COUNT(*) / SUM(COUNT(*)) OVER () AS FLOAT), 1) AS PercentOfTotal
FROM account_info
GROUP BY BalanceBucket
ORDER BY 100.0 * COUNT(*) / SUM(COUNT(*)) OVER () DESC

-- Average, min, max balance of customers who have churned (Exited = 1) and who have not churned (Exited = 0)
-- The average balance and max balance of churner is higher than non-churner
SELECT 
	ROUND(AVG(Balance), 2) AS ChurnerAvgBalance,
	MIN(Balance) AS MinBalance,
	MAX(Balance) AS MaxBalance
FROM customer_info cus
JOIN account_info acc ON cus.CustomerId = acc.CustomerId
WHERE Exited = 1;

SELECT 
	ROUND(AVG(Balance), 2) AS NonchurnerBalance,
	MIN(Balance) AS MinBalance,
	MAX(Balance) AS MaxBalance
FROM customer_info cus
JOIN account_info acc ON cus.CustomerId = acc.CustomerId
WHERE Exited = 0;



/****** 4. Estimated Salary Overview ******/
-- Average estimated salary of the customer base
SELECT 
	ROUND(AVG(EstimatedSalary), 2) AS AvgEstimatedSalary,
	MIN(EstimatedSalary) AS MinEstimatedSalary,
	MAX(EstimatedSalary) AS MaxEstimatedSalary
FROM customer_info
;

-- Median estimated salary of the customer base
/*
Estimated salary is fairly normally distributed
*/
SELECT DISTINCT
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY EstimatedSalary) OVER() AS MedianEstimatedSalary
FROM customer_info;

-- Average estimated salary of customers who have churned (Exited = 1) and who have not churned (Exited = 0)
-- The average estimated salary of churner is higher than non-churner, but min and max estimated salary is lower.
SELECT 
	ROUND(AVG(EstimatedSalary), 2) AS ChurnerEstimatedSalary,
	MIN(EstimatedSalary) AS MinSalary,
	MAX(EstimatedSalary) AS MaxSalary
FROM customer_info cus
JOIN account_info acc ON cus.CustomerId = acc.CustomerId
WHERE Exited = 1;

SELECT 
	ROUND(AVG(EstimatedSalary), 2) AS NonchurnerEstimatedSalary,
	MIN(EstimatedSalary) AS MinSalary,
	MAX(EstimatedSalary) AS MaxSalary
FROM customer_info cus
JOIN account_info acc ON cus.CustomerId = acc.CustomerId
WHERE Exited = 0;



/****** 5. Tenure ******/
-- Average tenure of the customer base
SELECT 
	AVG(Tenure) AS AvgTenure,
	MIN(Tenure) AS MinTenure,
	Max(Tenure) AS MaxTenure
FROM customer_info;

-- Median tenure of the customer base
/*
Tenure is normally distributed
*/
SELECT DISTINCT
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Tenure) OVER() AS MedianTenure
FROM customer_info;

-- Average, min, max tenure of customers who have churned (Exited = 1) who have not churned (Exited = 0)
-- Average tenure of churner is one year less than non-churner
SELECT 
	AVG(CAST(Tenure AS FLOAT)) AS ChurnerTenure,
	MIN(Tenure) AS MinTenure,
	Max(Tenure) AS MaxTenure
FROM account_info acc
WHERE Exited = 1;

SELECT 
	AVG(CAST(Tenure AS FLOAT)) AS NonChurnerTenure,
	MIN(Tenure) AS MinTenure,
	Max(Tenure) AS MaxTenure
FROM account_info acc
WHERE Exited = 0;



/****** 6. Percentage of Active Members ******/
SELECT 
	CONCAT(ROUND(100 * AVG(CAST(IsActiveMember AS FLOAT)), 1), '%') AS PctActive,
	COUNT(CASE WHEN IsActiveMember = 1 THEN CustomerId END) AS ActiveCustomerCount,
	COUNT(CASE WHEN IsActiveMember = 0 THEN CustomerId END) AS InactiveCustomerCount
FROM account_info;



/****** 7. Percentage with Credit Card ******/
SELECT 
	CONCAT(ROUND(100 * AVG(CAST (HasCrCard AS FLOAT)), 2),'%') AS PctWithCard,
	COUNT(CASE WHEN HasCrCard = 1 THEN CustomerId END) AS CardHolderCount,
	COUNT(CASE WHEN HasCrCard = 0 THEN CustomerId END) AS NoCardCount
FROM account_info;



/****** 8. Age ******/
-- Average Age of the customer base
SELECT 
	AVG(Age) AS AvgAge,
	MIN(Age) AS MinAge,
	Max(Age) AS MaxAge
FROM customer_info;

-- Median age of the customer base 
-- Slightly right-skew in the distribution. 
SELECT DISTINCT
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Age) OVER() AS MedianAge
FROM customer_info;

-- Average age of customers who have churned (Exited = 1)
SELECT AVG(Age) AS ChurnerScore
FROM customer_info cus
JOIN account_info acc ON cus.CustomerId = acc.CustomerId
WHERE Exited = 1;

-- Average age of customers who have not churned (Exited = 0)
SELECT AVG(Age) AS NonchurnerScore
FROM customer_info cus
JOIN account_info acc ON cus.CustomerId = acc.CustomerId
WHERE Exited = 0;

-- Customer Distribution by Age Bracket
-- Customer base is heavily concentrated among individuals 26-45.
SELECT
	AgeBracket,
	CONCAT(ROUND(CAST(100.0 * COUNT(*) / SUM(COUNT(*)) OVER () AS FLOAT), 1), '%') AS PercentOfTotal
FROM customer_info
GROUP BY AgeBracket
ORDER BY 100.0 * COUNT(*) / SUM(COUNT(*)) OVER () DESC










/******************************************
  B. GRANULAR / DEEP ANALYSIS
*******************************************/

/*********** 1. DEMOGRAPHIC DRIVERS OF CUSTOMER CHURN ***********/

/****** 1b. Churn by age bracket ******/
/*
Churn rises sharply with age: >50 % for 46‑55, ~37 % for 56+) 
Older customers may be less satisfied or finding better alternatives.
Across all age groups, average tenure at the time of churn clusters around 4 to 5 years
*/

SELECT
	AgeBracket,
	CONCAT(ROUND(100.0 * AVG(CAST(acc.Exited AS FLOAT)), 1), '%') AS ChurnPct,
	COUNT(cus.CustomerId) AS NumOfCustomers
FROM customer_info cus
JOIN account_info acc ON cus.CustomerId = acc.CustomerId
GROUP BY AgeBracket
ORDER BY ROUND(100*AVG(CAST(acc.Exited AS FLOAT)), 1) DESC;



/****** 1b. Churn by Gender ******/
/*
Female customers have a significantly higher churn rate (25.1%) than males (16.5%).
This may point to gender-based differences in product satisfaction, experience, or expectations.
Worth deeper review from product and marketing teams.
*/
SELECT
	cus.Gender,
	AVG(cus.tenure) AvgTenure,
	CONCAT(ROUND(100.0 * AVG(CAST(acc.Exited AS FLOAT)), 1), '%') AS ChurnPct
FROM customer_info cus
JOIN account_info acc ON cus.CustomerId = acc.CustomerId
GROUP BY cus.Gender;

-- Male and female customers' churn rate by age brackets
-- Female customers have a higher churn rate than males across every age groups
WITH ChurnData AS (
	SELECT
	  Gender,
	  AgeBracket,
	  CAST(Exited AS FLOAT) AS Exited
	FROM customer_info cus
	JOIN account_info acc ON cus.CustomerId = acc.CustomerId
)
SELECT
	Gender,
	CONCAT(ROUND([18-25] * 100.0, 1), '%') AS '18-25',
	CONCAT(ROUND([26-35] * 100.0, 1), '%') AS '26-35',
	CONCAT(ROUND([36-45] * 100.0, 1), '%') AS '36-45',
	CONCAT(ROUND([46-55] * 100.0, 1), '%') AS '46-55',
	CONCAT(ROUND([56+] * 100.0, 1), '%') AS '55+'
FROM (
	SELECT Gender, AgeBracket, Exited
	FROM ChurnData
) AS SourceTable
PIVOT(
	AVG(Exited)
	FOR AgeBracket IN ([18-25], [26-35], [36-45], [46-55], [56+])
) AS PivotTable;





/*********** 2. GEOGRAPHIC DRIVERS OF CUSTOMER CHURN ***********/

/****** 2a. Churn by Geography ******/
-- Germany churns highest (~32 %)
SELECT
	cus.Geography,
	CONCAT(ROUND(100.0 * AVG(CAST(acc.Exited AS FLOAT)), 1), '%') AS ChurnPct,
	COUNT(CASE WHEN acc.Exited = 1 THEN acc.CustomerId END) AS NumOfChurner,
	COUNT(cus.CustomerId) AS TotalCustomer
FROM customer_info cus
JOIN account_info acc
	ON cus.CustomerId = acc.CustomerId
GROUP BY cus.Geography
ORDER BY ROUND(100.0 * AVG(CAST(acc.Exited AS FLOAT)), 1) DESC;

-- Churn by Geography and Age Bracket
-- Older customers (46+) consistently show higher churn across all Geography
WITH ChurnData AS (
	SELECT
	  Geography,
	  AgeBracket,
	  CAST(Exited AS FLOAT) AS Exited
	FROM customer_info cus
	JOIN account_info acc ON cus.CustomerId = acc.CustomerId
)
SELECT
	Geography,
	CONCAT(ROUND([18-25] * 100.0, 1), '%') AS '18-25',
	CONCAT(ROUND([26-35] * 100.0, 1), '%') AS '26-35',
	CONCAT(ROUND([36-45] * 100.0, 1), '%') AS '36-45',
	CONCAT(ROUND([46-55] * 100.0, 1), '%') AS '46-55',
	CONCAT(ROUND([56+] * 100.0, 1), '%') AS '55+'
FROM (
	SELECT Geography, AgeBracket, Exited
	FROM ChurnData
) AS SourceTable
PIVOT(
	AVG(Exited)
	FOR AgeBracket IN ([18-25], [26-35], [36-45], [46-55], [56+])
) AS PivotTable;

/****** 2b. Churn by Product Count Across Geographies ******/
-- Germany has the highest churn rate across all product count segments compared to France and Spain.
WITH ChurnByGeoProduct AS (
  SELECT
    cus.Geography,
    acc.NumOfProducts,
    CAST(acc.Exited AS FLOAT) AS Exited
  FROM customer_info cus
  JOIN account_info acc ON cus.CustomerId = acc.CustomerId
)
SELECT 
  Geography,
  ROUND([1] * 100.0, 1) AS Churn_1_Product,
  ROUND([2] * 100.0, 1) AS Churn_2_Products,
  ROUND([3] * 100.0, 1) AS Churn_3_Products,
  ROUND([4] * 100.0, 1) AS Churn_4_Products
FROM (
  SELECT 
    Geography,
    NumOfProducts,
    Exited
  FROM ChurnByGeoProduct
) AS SourceTable
PIVOT (
  AVG(Exited)
  FOR NumOfProducts IN ([1], [2], [3], [4])
) AS PivotTable;

-- Total Customers by Geography
SELECT
	Geography,
	COUNT(CustomerId) AS TotalCustomers
FROM customer_info
GROUP BY Geography;



/****** 2c. Average Balance, Salary and Customer Activity by Geography ******/
/*
German customers higher earners but less loyal. 
German customers are the least active, which aligns with their highest churn rate. Lower activity may suggest disengagement 
Spanish and French customers lower-balance but more stable.
Average tenure and age are similar across all geographies -> Tenure is not a differentiating factor in account behavior or loyalty.
*/
SELECT 
	Geography,
	AVG(acc.Tenure) AS AvgTenure,
	AVG(Age) AS AvgAge,
    CAST(AVG(Balance) AS INT) AS AvgBalance,
    CAST(AVG(EstimatedSalary) AS INT) AS AvgSalary,
	CONCAT(ROUND(100.0 * AVG(CAST(acc.IsActiveMember AS FLOAT)), 1), '%') AS ActivePct,
	CONCAT(ROUND(100.0 * AVG(CAST(acc.Exited AS FLOAT)), 1), '%') AS ChurnPc
FROM customer_info cus
JOIN account_info acc ON cus.CustomerId = acc.CustomerId
GROUP BY cus.Geography;



/****** 2d. Credit Score by Geography (Creditworthiness) ******/
-- Credit Score Insights by Geography
/*
Customers across Spain, France, and Germany have similar financial trustworthiness based on credit scores.
Credit score does not explain why German customers have higher churn or different engagement patterns compared to Spain and France.
This highlights the need to explore non-financial factors to understand geographic differences in behavior.
*/
SELECT 
	Geography,
	AVG(CreditScore) AS AvgCreditScore
FROM customer_info
GROUP BY Geography;

SELECT 
	CreditScoreBand,
	SUM(CASE WHEN Geography = 'France' THEN 1 ELSE 0 END) AS FranceCustomers,
	SUM(CASE WHEN Geography = 'Germany' THEN 1 ELSE 0 END) AS GermanyCustomers,
	SUM(CASE WHEN Geography = 'Spain' THEN 1 ELSE 0 END) AS SpainCustomers
FROM customer_info
GROUP BY CreditScoreBand;



/****** 2e. Churn Rate By Gender Across Geography ******/
/*
Female customers have a higher churn rate than males across three geographies.
Indicates gender-specific dissatisfaction.
*/
WITH ChurnData AS (
  SELECT
    cus.Gender,
    cus.Geography,
    CAST(acc.Exited AS FLOAT) AS Exited
  FROM customer_info cus
  JOIN account_info acc ON cus.CustomerId = acc.CustomerId
)
SELECT 
  Gender,
  CONCAT(ROUND([France] * 100, 1), '%') AS France_ChurnPct,
  CONCAT(ROUND([Germany] * 100, 1), '%') AS Germany_ChurnPct,
  CONCAT(ROUND([Spain] * 100, 1), '%') AS Spain_ChurnPct
FROM (
  SELECT Gender, Geography, Exited
  FROM ChurnData
) AS SourceTable
PIVOT (
  AVG(Exited)
  FOR Geography IN ([France], [Germany], [Spain])
) AS PivotTable;
 




/*********** 3. ENGAGEMENT AND FINANCIAL PROFILE DRIVERS OF CUSTOMER CHURN ***********/

/****** 3a. Churn by Balance Bucket******/
/* 
High-balance customers show much higher churn, which may signal unmet needs or weak retention efforts.
Important to investigate and address — this group holds significant value.
*/
SELECT
	BalanceBucket,
	AVG(tenure) AvgTenure,
	CONCAT(ROUND(100*AVG(CAST(acc.Exited AS FLOAT)), 1), '%') AS ChurnPct
FROM account_info acc
GROUP BY BalanceBucket;



/****** 3b. Churn by Credit Score Band ******/
/*
Only minor differences → weak standalone predictor
*/
SELECT
	cus.CreditScoreBand,
	CONCAT(ROUND(100*AVG(CAST(acc.Exited AS FLOAT)), 1), '%') AS ChurnPct
FROM customer_info cus
JOIN account_info acc ON cus.CustomerId = acc.CustomerId
GROUP BY cus.CreditScoreBand
ORDER BY ROUND(100*AVG(CAST(acc.Exited AS FLOAT)), 1) DESC;



/****** 3c. Churn by Tenure Bucket ******/
/*
Churn falls modestly as tenure increases (0–2 yrs > 3–5 yrs > 6+ yrs)
*/
SELECT
	TenureBucket,
	COUNT(CustomerId) AS TotalCustomers,
	CONCAT(ROUND(100*AVG(CAST(Exited AS FLOAT)), 1), '%') AS ChurnPct
FROM account_info acc
GROUP BY TenureBucket
ORDER BY ROUND(100*AVG(CAST(Exited AS FLOAT)), 1) DESC;



/****** 3d. Churn by Active Status ******/
/* 
Active members churn almost half as much as inactive ones
Boosting customer engagement through loyalty programs, regular communication, 
or personalized services could help reduce churn significantly.
*/
SELECT
	IsActiveMember,
	CONCAT(ROUND(100*AVG(CAST(Exited AS FLOAT)), 1), '%') AS ChurnPct,
	COUNT(CASE WHEN acc.Exited = 1 THEN acc.CustomerId END) AS NumOfChurner,
	COUNT(CustomerId) AS TotalCustomer
FROM account_info acc
GROUP BY IsActiveMember
ORDER BY ROUND(100*AVG(CAST(Exited AS FLOAT)), 1) DESC;




/****** 3e. Churn by Credi Card Status ******/
/* 
Churn rates are almost the same for customers with and without a credit card.
-> Owning a credit card does not significantly reduce or increase churn risk
*/
SELECT
	HasCrCard,
	CONCAT(ROUND(100*AVG(CAST(Exited AS FLOAT)), 1), '%') AS ChurnPct,
	COUNT(CASE WHEN acc.Exited = 1 THEN acc.CustomerId END) AS NumOfChurner,
	COUNT(CustomerId) AS TotalCustomer
FROM account_info acc
GROUP BY HasCrCard
ORDER BY ROUND(100*AVG(CAST(Exited AS FLOAT)), 1) DESC;



/****** 3f. Churn by Number of Product ******/
/*
Customers with 3–4 products show very high churn (82.7%–100%), likely due to small sample sizes → flag for review
2-product customers have the lowest churn (7.6%) (suggesting higher satisfaction or financial stability.
1-product customers churn more (27.7%), possibly reflecting lower engagement.
*/
SELECT
	NumOfProducts,
	CONCAT(ROUND(100.0 * AVG(CAST(acc.Exited AS FLOAT)), 1), '%') AS ChurnPct,
	COUNT(CustomerId) AS NumOfCustomer
FROM account_info acc
GROUP BY NumOfProducts
ORDER BY ROUND(100*AVG(CAST(acc.Exited AS FLOAT)), 1) DESC;



/****** 3g. Stability Analysis by Number of Product (Are 2-product customers more financially stable and engaged?) ******/
-- Total customers by gender
-- Although fewer female customers use 1 or 2 products compared to males, a slightly higher proportion of them use 3 or 4 products. 

SELECT
    customer_info.Gender,
    COUNT(CASE WHEN account_info.NumOfProducts = 1 THEN 1 END) AS Customer_1_Product,
    COUNT(CASE WHEN account_info.NumOfProducts = 2 THEN 1 END) AS Customer_2_Product,
    COUNT(CASE WHEN account_info.NumOfProducts = 3 THEN 1 END) AS Customer_3_Product,
    COUNT(CASE WHEN account_info.NumOfProducts = 4 THEN 1 END) AS Customer4_Product
FROM customer_info
JOIN account_info ON customer_info.CustomerId = account_info.CustomerId
GROUP BY customer_info.Gender
ORDER BY customer_info.Gender;


-- Total customers by Demographic and Geography (2-product customers)
-- More customers from France use 2 products, which aligns with France having the lowest churn rate

SELECT 
	Gender,
	COUNT(account_info.CustomerId) AS TotalCustomers
FROM customer_info
JOIN account_info ON customer_info.CustomerId = account_info.CustomerId
WHERE NumOfProducts = 2
GROUP BY Gender;

SELECT 
	AgeBracket,
	COUNT(account_info.CustomerId) AS TotalCustomers
FROM customer_info
JOIN account_info ON customer_info.CustomerId = account_info.CustomerId
WHERE NumOfProducts = 2
GROUP BY AgeBracket;

SELECT 
	Geography,
	COUNT(account_info.CustomerId) AS TotalCustomers
FROM customer_info
JOIN account_info ON customer_info.CustomerId = account_info.CustomerId
WHERE NumOfProducts = 2
GROUP BY Geography;

-- Average Credit Score
/* 
2-product customers (652) have the second highest. This suggests relatively good financial trustworthiness.
*/
SELECT
	acc.NumOfProducts,
	ROUND(AVG(cus.CreditScore), 2) AS AvgCreditScore
FROM customer_info cus
JOIN account_info acc
	ON cus.CustomerId = acc.CustomerId
GROUP BY acc.NumOfProducts
ORDER BY NumOfProducts;

-- Average Balance
/* 
2-product customers have the lowest average balance.
*/
SELECT 
	NumOfProducts,
	ROUND(AVG(Balance), 2) AS AvgBalance
FROM account_info acc
GROUP BY NumOfProducts
ORDER BY NumOfProducts;

-- Average Estimated Salary
/* 
2-product customers earn slightly more than 1-product customers and slightly less than 3–4 product customers.
*/
SELECT 
	acc.NumOfProducts,
	ROUND(AVG(cus.EstimatedSalary), 2) AS AvgSalary
FROM customer_info cus
JOIN account_info acc
	ON cus.CustomerId = acc.CustomerId
GROUP BY acc.NumOfProducts
ORDER BY NumOfProducts;

-- Average Tenure
SELECT 
	NumOfProducts,
	ROUND(AVG(Tenure), 2) AS AvgTenure
FROM account_info acc8
GROUP BY NumOfProducts
ORDER BY NumOfProducts;

-- % Active Members
/*
2-product customers have highest % active member among all groups.
This supports the idea that 2-product users are more engaged, not just passive account holders.
*/
SELECT
	NumOfProducts,
	ROUND(100.0 * AVG(CAST(IsActiveMember AS FLOAT)), 1) AS ActivePct
FROM account_info
GROUP BY NumOfProducts
ORDER BY NumOfProducts;

-- % Customers have credit card
SELECT
	NumOfProducts,
	ROUND(100.0 * AVG(CAST(HasCrCard AS FLOAT)), 1) AS CrCardPct
FROM account_info
GROUP BY NumOfProducts
ORDER BY NumOfProducts;
