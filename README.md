# Bank Churn: Insights to Improve Retention
## Background and Overview
Customer churn is a critical concern for banks, directly impacting revenue and long-term growth. This project investigates the drivers behind customer attrition at a European bank using SQL and Power BI. By analyzing demographic, geographic, behavioral and financial data from 10,000 customers from France, Germany, and Spain, the project uncovers key factors linked to churn.

Insights and recommendations are provided on the following key areas:

•	Demographics: Exploring how gender and age impact churn bevavior.

•	Geography: Comparing churn trends across customers from France, Spain, and Germany to identify geographic differences.

•	Engagement and Financial Profile: Analyzing how account tenure, product usage, and financial indicators like balance and salary relate to customer retention. This helps uncover patterns in churn among customers with varying levels of engagement and value to the bank.

<img width="20" height="20" alt="image" src="https://github.com/user-attachments/assets/ffcdcd03-ee94-44d5-9f40-5475a9a8c56a" /> Data Source: <a href="https://www.mavenanalytics.io/data-playground?order=date_added%2Cdesc&page=2">Maven Analytics: Bank Customer Churn</a>

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

•	Two Products: Customers using 2 products show the highest engagement (53.3% active rate) and lowest churn (7.6%). 
  
•	Three or Four Products: Churn rises sharply among customers with 3 or 4 products, with 4-product users exhibiting a 100% churn rate. Although this group is small and may not fully represent the overall customer base, the complete loss of all 4-product users is a clear warning sign. It suggests potential issues with customer satisfaction or product integration for those highly engaged customers

•	Although fewer female customers use 1 or 2 products compared to males, a slightly higher proportion of them use 3 or more products. Since higher product usage is linked to greater churn risk, this pattern may help explain why female customers tend to churn more than males.

<p align="center">
<img width="773" height="76" alt="image" src="https://github.com/user-attachments/assets/483f5983-44ef-458f-8ae7-9d1aac883d9c" />
</p>

•	Customers from France have the lowest churn rate among all geographies (16.2%), and their higher concentration of 2-product users suggests this engagement level may contribute to stronger retention.

<p align="center">
<img width="349" height="115" alt="image" src="https://github.com/user-attachments/assets/bd0776ed-2bc7-43c3-a8ea-c162325084d4" />
</p>

#### Active Status
•	Customers who are actively engaged with their accounts churn at less than half the rate of inactive members. This pattern is consistent with geographic trends: Germany has both the lowest activity rate and the highest churn rate among the three countries. This reinforces the importance of encouraging account activity to improve retention.

#### Tenure
• Customers with longer tenure show only slightly better retention, with churn rates declining from 21.2% for those with 0-2 years to 19.7% for those with 6+ years. The difference is modest and not significant enough to suggest strong loyalty over time. Additionally, the average tenure of churned customers is around 5 years, indicating that many still choose to leave after a relatively long relationship. This highlights the 5-year mark as a critical point of disengagement.

#### Financial Profile
• Churn rates are nearly identical between customers with and without a credit card, indicating that owning a credit card does not significantly reduce or increase churn risk.

<p align="center">
<img width="519" height="78" alt="image" src="https://github.com/user-attachments/assets/0fe14d28-f296-4754-8490-8fabbc682880" />
</p>

• Balance distribution is bimodal: Customer balances show a bimodal distribution. Most customers fall into either the very low or the very high balance range, with fewer in the middle. The € 25,000 - € 50,000 balance group is both the smallest and the highest-churning segment. This dual pattern may suggest that these customers either aren’t finding value in the bank’s offerings or are being underserved. Their small presence and high exit rate make them a segment worth further attention.

## Recommendations

Based on the uncovered insights, the following recommendations have been provided:
1.	Target At-Risk Segments: Older customers (46+) and female customers consistently show higher churn across all age groups and geography. To improve retention, the bank should consider tailored loyalty programs or retirement-focused offerings for older clients and conduct further analysis to identify service or satisfaction gaps that may disproportionately impact female customers.
   
2.	Strengthen Engagement at Key Lifecycle Milestones: Since many customers churn around the 5-year mark, proactive intervention should begin by the 4th year to reinforce value and loyalty before disengagement sets in. Early-stage engagement is equally important because churn risk is highest in the first two years. Encouraging account activity from the beginning is essential, as inactive customers churn at nearly twice the rate of active ones.
   
3.	Optimized Product Offerings: Two-product users show the highest retention and activity, making them an ideal benchmark for effective engagement. The sharp churn among 3 and 4 product users, who are likely highly engaged, suggests potential issues with product fitness, pricing, or service fatigue. This pattern is worth deeper review from product and marketing teams.
   
4.	Research and Address Mid-Tier Customer Needs: Customers in the € 25,000 - € 50,000k account balance group are few but show the highest churn rate. This suggests a need to research why this segment is both small and prone to leaving, possibly because they feel underserved or lack suitable products. Exploring personalized financial advice or targeted offers could help improve their retention.
  
5.	Boost Engagement in German Market: Germany has the highest churn and lowest activity rates despite a financially strong customer base. Focus on enhancing customer engagement through targeted communication, and improved service experiences to reduce attrition.

## Future Analysis and Next Steps

Future analysis will focus on a deeper analysis of high-value customers to identify which geographies attract the most valuable clients and uncover the reasons behind this. These insights could reveal successful strategies that might be adapted and applied to other markets to help reduce churn. Additionally, I would explore the typical product usage patterns among these high-value customers to determine the optimal number of products that drive higher retention. I would also develop predictive models to identify at-risk customers earlier in their lifecycle, enabling proactive and targeted intervention programs. Together, these efforts will allow the bank to tailor its offerings and marketing strategies more effectively, enhancing both the acquisition and retention of high-value clients across different geographies.
