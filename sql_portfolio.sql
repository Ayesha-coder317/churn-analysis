-- Question 1

use sql_portfolio;

SELECT
        *,
        CASE
            WHEN Age BETWEEN 18 AND 30 THEN '18-30'
            WHEN Age BETWEEN 31 AND 40 THEN '31-40'
            WHEN Age BETWEEN 41 AND 50 THEN '41-50'
            WHEN Age BETWEEN 51 AND 60 THEN '51-60'
            WHEN Age BETWEEN 61 AND 70 THEN '61-70'
            WHEN Age BETWEEN 71 AND 80 THEN '71-80'
            ELSE '81-100'
        END AS Age_Group
    FROM sql_portfolio
as AgeGroups;

SELECT
    Age,
    Gender,
    Offer,
    AVG(Total_Monthly_Charges) AS Total_Avg_Monthly_Charges
FROM (
    SELECT
        Age,
        Gender,
        Offer,
        (Avg_Monthly_Long_Distance_Charges + Avg_Monthly_GB_Download) AS Total_Monthly_Charges,
        Churn_Label
    FROM
        sql_portfolio
) AS Charges
WHERE
    Churn_Label = 'Yes'
GROUP BY
    Age, Gender, Offer
ORDER BY
    Total_Avg_Monthly_Charges DESC
LIMIT 5;

-- Question 2

SELECT
    Customer_ID,  -- Adjust the column name if needed
    Churn_Reason
FROM
    sql_portfolio
WHERE
    Churn_Label = 'Yes';
    
-- Question 3

SELECT
    Payment_Method,  
    COUNT(CASE WHEN Churn_Label = 'Yes' THEN 1 END) AS Churned_Customers,
    COUNT(CASE WHEN Churn_Label = 'No' THEN 1 END) AS Retained_Customers,
    COUNT(*) AS Total_Customers,
    ROUND(COUNT(CASE WHEN Churn_Label = 'Yes' THEN 1 END) / COUNT(*) * 100, 2) AS Churn_Rate_Percentage
FROM
    sql_portfolio
GROUP BY
    Payment_Method
ORDER BY
    Churn_Rate_Percentage DESC;



