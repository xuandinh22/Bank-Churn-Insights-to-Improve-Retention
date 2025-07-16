# Bank Churn: Insights to Improve Retention
## Background and Overview
Customer churn is a critical concern for banks, directly impacting revenue and long-term growth. This project investigates the drivers behind customer attrition at a European bank using SQL and Power BI. By analyzing demographic, geographic, behavioral and financial data from 10,000 customers from France, Germany, and Spain, the project uncovers key factors linked to churn.

Insights and recommendations are provided on the following key areas:
•	Demographics: Exploring how gender and age impact churn bevavior.
•	Geography: Comparing churn trends across customers from France, Spain, and Germany to identify geographic differences.
•	Engagement and Financial Profile: Analyzing how account tenure, product usage, and financial indicators like balance and salary relate to customer retention. This helps uncover patterns in churn among customers with varying levels of engagement and value to the bank.

<img width="20" height="20" alt="image" src="https://github.com/user-attachments/assets/ffcdcd03-ee94-44d5-9f40-5475a9a8c56a" />
Data Source: <a href="https://www.mavenanalytics.io/data-playground?order=date_added%2Cdesc&page=2">Maven Analytics: Bank Customer Churn</a>

Tools: SQL and Power BI

An Interactive Power BI dashboard can be downloaded <a href="https://app.powerbi.com/view?r=eyJrIjoiMGU0MjYzNDEtODgwMS00Yzg3LTk2NTItZGI5ZDhiMWY0MjRkIiwidCI6IjdkZTZiMWMxLWYzOTMtNGJhNS05NjVkLTU3YjNhMGJhYmEzZiJ9">(here)</a>

The SQL queries utilized to inspect and perform quality check can be found <a href="https://github.com/xuandinh22/Bank-Churn-Insights-to-Improve-Retention/blob/main/inspection_%26_data_quality_checks.sql">(here)</a>

The SQL queries utilized to clean, organize, and prepare data can be found <a href="https://github.com/xuandinh22/Bank-Churn-Insights-to-Improve-Retention/blob/main/clean_%26_prepare_data.sql">(here)</a>

Targeted SQL queries regarding business questions can be found <a href="https://github.com/xuandinh22/Bank-Churn-Insights-to-Improve-Retention/blob/main/business_focused_analytical_queries.sql">(here)</a>

## Data Structure Overview

The dataset contains data for 10,000 customers at a European bank. 
The analysis uses two main tables: customer_info and account_info.
<p align="center">
  <img width="556" height="291" alt="image" src="https://github.com/user-attachments/assets/0b980bf1-2321-4b1f-a6bd-d22cb1052154" />
</p>

## Executive Summary

### Overview of Findings
The analysis found that approximately 20% of the bank’s customers have churned, with churn rates are significantly higher among older customers, females, inactive account holders, and customers who use more than two products, with the Germany customers showing especially elevated attrition. These patterns suggest that beyond financial profile, customer engagement, satisfaction, and potentially unmet expectations are key drivers of churn. The following sections explore these trends in detail to uncover where customers are leaving, and what can be done to improve retention.
Below is the overview page from the PowerBI dashboard. The entire interactive dashboard can be downloaded <a href="https://app.powerbi.com/view?r=eyJrIjoiMGU0MjYzNDEtODgwMS00Yzg3LTk2NTItZGI5ZDhiMWY0MjRkIiwidCI6IjdkZTZiMWMxLWYzOTMtNGJhNS05NjVkLTU3YjNhMGJhYmEzZiJ9">(here)</a>

<p align="center">
<img width="915" height="506" alt="image" src="https://github.com/user-attachments/assets/baae268b-500a-4650-abfa-95098b7813bb" />
</p>

### Highest churn segments:
•	Older age groups: > 50% churn in 46–55 bracket

•	Female customers: 25.1% churn compared to 16.5% for males

•	German customers: Approximately 32% churn

•	Product Usage: 82.7% churn among customers using 3 products, and 100% churn for those using 4 products

•	Inactive members: Around 30% churn vs approximately 14% churn for active customers

### Stable segment
Although 2-product customers are not the most financially stable, as their account balances are the lowest among all groups, they have the highest number of active customers and the lowest churn rate at just 7.6%.

### <img width="30" height="30" alt="image" src="https://github.com/user-attachments/assets/93c186ba-9850-4f8d-9716-3313247e802d" /> Demographics

•	Age effect: Churn rate increases significantly with age — exceeding 50% for customers aged 46–55, and approximately 37% for those aged 56 and above. Both the 18–25 and 56+ age groups represent a small portion of the overall customer base. The majority of customers fall within the 26–45 age range.

•	Gender Gap: Female customers have a significantly higher churn rate (25.1%) than males (16.5%) and a lower average tenure (4 years vs. 5 years). This pattern holds consistently across all geographies and age groups, suggesting possible gender-based differences in product satisfaction, user experience, or expectations, and indicating that female customers may disengage earlier in the customer lifecycle.

<p align="center">
<img width="411" height="234" alt="image" src="https://github.com/user-attachments/assets/d28d3934-4b05-4dc4-9044-6e7691fb8b1a" />
</p>

### <img width="30" height="30" alt="image" src="https://github.com/user-attachments/assets/ca3ec08f-14fb-4425-82b0-d21d35a976e0" /> Geography

•	Germany: German customers tend to have stronger financial profiles, with no customers holding less than € 25,000 in account balance. Yet, they churn at a much higher rate (~32%) despite having a customer base nearly equal to Spain and significantly smaller than France. Additionally, German customers show the lowest activity rate among the three geographies, suggesting weaker engagement with the bank's services

•	France & Spain: Customers in France and Spain form more stable, loyal bases, maintaining higher retention despite having lower average balances and salaries.

<p align="center">
<img width="503" height="94" alt="image" src="https://github.com/user-attachments/assets/ff713c23-72cb-4775-8fb4-0bf2cdf9a780" />
</p>

### <img width="30" height="30" alt="image" src="https://github.com/user-attachments/assets/69bf3f08-e934-4981-8d94-928cafceb619" /> Engagement & Financial Profile

#### Product Usage

  o	Two Products: Customers using 2 products show the highest engagement (53.3% active rate) and lowest churn (7.6%). 
  
  o	Three or Four Products: Churn rises sharply among customers with 3 or 4 products, with 4-product users exhibiting a 100% churn rate. Although this group is small and may not fully represent the overall customer base, the complete loss of all 4-product users is a clear warning sign. It suggests potential issues with customer satisfaction or product integration for those highly engaged customers.
  
  o	Although fewer female customers use 1 or 2 products compared to males, a slightly higher proportion of them use 3 or more products. Since higher product usage is linked to greater churn risk, this pattern may help explain why female customers tend to churn more than males.

<p align="center">
<img width="773" height="76" alt="image" src="https://github.com/user-attachments/assets/483f5983-44ef-458f-8ae7-9d1aac883d9c" />
</p>

o	The higher concentration of 2-product users in France aligns with its lower churn rate, suggesting an optimal engagement level for retention.
