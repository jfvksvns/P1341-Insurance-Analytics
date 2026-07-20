CREATE DATABASE sql_project;

USE sql_project;
show tables;


# KPI 1
# What is the total number of customers available in the policy database?

SELECT COUNT(*) AS Total_Customers
FROM `Customer Information`;



# KPI 2
# What is the total number of policies issued?

SELECT COUNT(*) AS Total_Policies
FROM `Policy Details`;



# KPI 3
# What is the total claim amount generated from all policies?

SELECT SUM(`Claim Amount`) AS Total_Claim_Amount
FROM `Claims`;



# KPI 4
# What is the average coverage amount per policy?

SELECT ROUND(AVG(`Coverage Amount`), 2) AS Average_Coverage_Amount
FROM `Policy Details`;


# KPI 5
# What is the average premium amount collected per policy?

SELECT ROUND(AVG(`Premium Amount`), 2) AS Average_Premium_Amount
FROM `Policy Details`;

DESCRIBE `Policy Details`;

# KPI 6
# What percentage of policies are currently active?

SELECT
ROUND(
(COUNT(CASE WHEN `Status`='Active' THEN 1 END)*100.0)
/COUNT(*),2
) AS Active_Policy_Percentage
FROM `Policy Details`;



# KPI 7
# How many policies are in active, lapsed, and terminated status?

SELECT
    `Status`,
    COUNT(*) AS Total_Policies
FROM `Policy Details`
GROUP BY `Status`;


# KPI 8
# Which policy status has the highest number of policies?

SELECT
    `Status`,
    COUNT(*) AS Total_Policies
FROM `Policy Details`
GROUP BY `Status`
ORDER BY Total_Policies DESC
LIMIT 1;



# KPI 9
# What is the ratio between active policies and inactive policies?

SELECT
CONCAT(
SUM(CASE WHEN `Status`='Active' THEN 1 ELSE 0 END),
':',
SUM(CASE WHEN `Status` IN ('Lapsed','Terminated') THEN 1 ELSE 0 END)
) AS Active_Inactive_Ratio
FROM `Policy Details`;


DESCRIBE `Customer Information`;


# KPI 10
# Which age group has the highest number of policies?

SELECT
`Age Group`,
COUNT(*) AS Total_Policies
FROM `Customer Information`
GROUP BY `Age Group`
ORDER BY Total_Policies DESC
LIMIT 1;


# KPI 11
# Identify the top three age groups by policy count.

SELECT
`Age Group`,
COUNT(*) AS Total_Policies
FROM `Customer Information`
GROUP BY `Age Group`
ORDER BY Total_Policies DESC
LIMIT 3;



# KPI 12
# Which gender has the highest policy participation?

SELECT
Gender,
COUNT(*) AS Total_Customers
FROM `Customer Information`
GROUP BY Gender
ORDER BY Total_Customers DESC
LIMIT 1;




# KPI 13
# What is the difference between male and female policy counts?

SELECT
ABS(
SUM(CASE WHEN Gender='Male' THEN 1 ELSE 0 END)
-
SUM(CASE WHEN Gender='Female' THEN 1 ELSE 0 END)
) AS Male_Female_Difference
FROM `Customer Information`;




DESCRIBE `Claims`;
DESCRIBE `Additional Fields`;


# KPI 14
# Which policy type has the maximum number of policies?

SELECT
`Policy Type`,
COUNT(*) AS Total_Policies
FROM `Policy Details`
GROUP BY `Policy Type`
ORDER BY Total_Policies DESC
LIMIT 1;



# KPI 15
# Which policy type has the minimum number of policies?

SELECT
`Policy Type`,
COUNT(*) AS Total_Policies
FROM `Policy Details`
GROUP BY `Policy Type`
ORDER BY Total_Policies ASC
LIMIT 1;




# KPI 16
# Compare Auto and Health policy counts.

SELECT
`Policy Type`,
COUNT(*) AS Total_Policies
FROM `Policy Details`
WHERE `Policy Type` IN ('Auto','Health')
GROUP BY `Policy Type`;



# KPI 17
# What is the total number of policies across all policy types?

SELECT
COUNT(`Policy ID`) AS Total_Policies
FROM `Policy Details`;



# KPI 18
# What is the average premium growth rate over all years?

SELECT
    YEAR(`Policy Start Date`) AS Policy_Year,
    ROUND(SUM(`Premium Amount`), 2) AS Total_Premium
FROM `Policy Details`
GROUP BY YEAR(`Policy Start Date`)
ORDER BY YEAR(`Policy Start Date`);



# KPI 19
# What is the average premium growth rate over all years?

SELECT
YEAR(STR_TO_DATE(`Policy Start Date`,'%Y-%m-%d')) AS Policy_Year,
ROUND(SUM(`Premium Amount`),2) AS Total_Premium
FROM `Policy Details`
GROUP BY Policy_Year
ORDER BY Policy_Year;




# KPI 20
# Is the premium growth trend increasing or decreasing over time?

SELECT
CASE WHEN MAX(`Premium Amount`) > MIN(`Premium Amount`)
THEN 'Increasing'
ELSE 'Decreasing'
END AS Premium_Trend
FROM `Policy Details`;


# KPI 21
# Calculate the difference between the highest and lowest premium growth rates.

SELECT
ROUND(MAX(`Premium Amount`) - MIN(`Premium Amount`),2) AS High_Low_Growth_Difference
FROM `Policy Details`;



# KPI 22
# What is the yearly trend of policies ending from 2016 to 2034?

SELECT
YEAR(STR_TO_DATE(`Policy End Date`,'%Y-%m-%d')) AS Policy_End_Year,
COUNT(`Policy ID`) AS Total_Policies
FROM `Policy Details`
GROUP BY Policy_End_Year
HAVING Policy_End_Year BETWEEN 2016 AND 2034
ORDER BY Policy_End_Year;