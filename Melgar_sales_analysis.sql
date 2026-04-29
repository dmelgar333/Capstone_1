-- CAPSTONE 1: SALES TERRITORY ANALYSIS
-- Sales Manager: Erbayne Middleton
-- Territory: Maine
-- Region: Northeast
-- This analysis is answering the questions for the Maine territory. 

USE sample_sales;

-- Question 1: What is total revenue overall for sales in the assigned territory, plus the start date and end date that tell you what period the data covers?

SELECT 
MIN(Transaction_Date) AS Start_Date,
MAX(Transaction_Date) AS End_Date,
ROUND(SUM(Sale_Amount), 2) AS Total_Revenue
FROM store_sales ss
JOIN store_locations sl ON ss.Store_ID = sl.StoreId
WHERE sl.state = 'Maine';

-- Results: In the Maine territory, the data timeframe is from January 1st, 2022 to Decemeber 31st, 2025. Total revenue during this time was $1,877,249.75

-- Question 2: What is the month by month revenue breakdown for the sales territory?

SELECT
 MONTH(Transaction_Date) AS Month_Num,
 MONTHNAME(Transaction_Date) AS Month_Name,
 YEAR(Transaction_Date) AS Year,
 ROUND(SUM(Sale_Amount), 2) AS Monthly_Revenue
FROM store_sales ss
JOIN store_locations sl ON ss.Store_ID = sl.StoreId
WHERE sl.State = 'Maine'
GROUP BY YEAR(Transaction_Date), MONTH(Transaction_Date), MONTHNAME(Transaction_Date)
ORDER BY YEAR(Transaction_Date), MONTH(Transaction_Date);