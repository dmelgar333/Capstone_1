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

-- Results: Overall, the results show steady growth within these years, consistent and then jumping to more growth towards the end of 2025, the revenue shows positve growth. 

-- Question 3: Provide a comparison of total revenue for the Maine sales territory and the Northeast region (Maryland, Mass, New Jersey) it belongs to

SELECT
    sl.State,
    ROUND(SUM(ss.Sale_Amount), 2)  AS Total_Revenue
FROM Store_Sales ss
JOIN Store_Locations sl ON ss.Store_ID = sl.StoreId
JOIN Management m ON sl.State = m.State
WHERE m.Region = 'Northeast'
GROUP BY sl.State
ORDER BY Total_Revenue DESC;

-- Results: Maine had the lowest total revenue and Maryland leads with the highest, Maine does have less stores than the other states which could be a main factor in the results

-- Question 4: What is the number of transactions per month and average transaction size by product category for the Maine territory?

SELECT
    MONTH(Transaction_Date)        AS Month,
    YEAR(Transaction_Date)         AS Year,
    ic.Category                    AS Category,
    COUNT(*)                       AS Num_Transactions,
    ROUND(AVG(ss.Sale_Amount), 2)  AS Avg_Transaction_Size
FROM Store_Sales ss
JOIN Store_Locations sl      ON ss.Store_ID   = sl.StoreId
JOIN Products p              ON ss.Prod_Num   = p.ProdNum
JOIN Inventory_Categories ic ON p.Categoryid  = ic.CategoryId
WHERE sl.State = 'Maine'
GROUP BY YEAR(Transaction_Date), MONTH(Transaction_Date), ic.Category
ORDER BY YEAR(Transaction_Date), MONTH(Transaction_Date);

-- Results: Overall, Technology & Accessories have the highest revenue steadily, compared to the other categories. I would say if you want the revenue to grow focus on the Tech & Accessories Category.

-- Question 5: Store performance ranking by each store in the sales territory 

SELECT
    sl.StoreLocation            AS Store,
    COUNT(*)                    AS Num_Transactions,
    ROUND(SUM(ss.Sale_Amount), 2)   AS Total_Revenue,
    ROUND(AVG(ss.Sale_Amount), 2)   AS Avg_Transaction_Size,
    RANK() OVER (ORDER BY SUM(ss.Sale_Amount) DESC) AS Revenue_Rank
FROM Store_Sales ss
JOIN Store_Locations sl ON ss.Store_ID = sl.StoreId
WHERE sl.State = 'Maine'
GROUP BY sl.StoreLocation
ORDER BY Revenue_Rank;

-- Results: Bar Harbor is ranked last, the focus should be there to raise the revenue and Bangor as well which isn't too far ahead. 