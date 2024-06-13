SELECT * FROM sales;

SET SQL_SAFE_UPDATES=0;
-- *****************************************************************************************
-- Year wise Sales amount

SELECT Year,SUM(Total_Sales) AS Totalsales,
CASE
    WHEN SUM(Total_Sales) >= 1000000 THEN CONCAT(ROUND(SUM(Total_Sales)/1000000,1),'M')
    WHEN SUM(Total_Sales) >= 1000 THEN CONCAT(ROUND(SUM(Total_Sales)/1000,1),'K') 
END AS Total_Formatted_sales
FROM Sales
GROUP BY Year
ORDER BY Year;
-- *****************************************************************************************
-- Year Filter

SELECT Year,SUM(Total_Sales) AS Totalsales,
CASE
    WHEN SUM(Total_Sales) >= 1000000 THEN CONCAT(ROUND(SUM(Total_Sales)/1000000,1),'M')
    WHEN SUM(Total_Sales) >= 1000 THEN CONCAT(ROUND(SUM(Total_Sales)/1000,1),'K') 
END AS Total_Formatted_sales
FROM Sales
WHERE Year = 2013   -- ,2011,2012,2013,2014
GROUP BY Year
ORDER BY Year;

-- *****************************************************************************************
-- Month wise SALES

SELECT Month_No,Month_Name,SUM(Total_Sales) AS Totalsales,
CASE 
    WHEN SUM(Total_Sales) >= 1000000 THEN CONCAT(ROUND(SUM(Total_Sales)/1000000,1),'M')
    WHEN SUM(Total_Sales) >= 1000 THEN CONCAT(ROUND(SUM(Total_Sales)/1000,1),'K')
END AS Total_Formatted_sales
FROM Sales
GROUP BY Month_Name,Month_No
ORDER BY Month_No;
-- *****************************************************************************************
-- Month FILTER

SELECT Month_No,Month_Name,SUM(Total_Sales) AS Totalsales,
CASE 
    WHEN SUM(Total_Sales) >= 1000000 THEN CONCAT(ROUND(SUM(Total_Sales)/1000000,1),'M')
    WHEN SUM(Total_Sales) >= 1000 THEN CONCAT(ROUND(SUM(Total_Sales)/1000,1),'K')
END AS Total_Formatted_sales
FROM Sales
WHERE  Month_No=2 
GROUP BY Month_Name,Month_No;

-- *****************************************************************************************
SELECT * FROM sales;
-- Quarter wise sales

SELECT Quarter,SUM(Total_Sales) AS Totalsales,
CASE
    WHEN SUM(Total_Sales) >= 1000000 THEN CONCAT(ROUND(SUM(Total_Sales)/1000000,1),'M')
    WHEN SUM(Total_Sales) >= 1000 THEN CONCAT(ROUND(SUM(Total_Sales)/1000,1),'K') 
END AS Total_Formatted_sales
FROM Sales
GROUP BY Quarter
ORDER BY Quarter;
-- *****************************************************************************************
-- Day name wise sales 

SELECT Day_No,Day_Name,SUM(Total_Sales) AS Totalsales,
CASE
    WHEN SUM(Total_Sales) >= 1000000 THEN CONCAT(ROUND(SUM(Total_Sales)/1000000,1),'M')
    WHEN SUM(Total_Sales) >= 1000 THEN CONCAT(ROUND(SUM(Total_Sales)/1000,1),'K') 
END AS Total_Formatted_sales
FROM Sales
GROUP BY Day_Name,Day_No
ORDER BY Day_No;
-- *****************************************************************************************
-- When the year is a filter for monthwise sales

SELECT year,Month_Name,Month_No,SUM(Total_Sales) AS Totalsales,
CASE 
    WHEN SUM(Total_Sales) >= 1000000 THEN CONCAT(ROUND(SUM(Total_Sales)/1000000,0),'M')
    WHEN SUM(Total_Sales) >= 1000 THEN CONCAT(ROUND(SUM(Total_Sales)/1000,0),'K')
END AS Total_Formatted_sales
FROM Sales
WHERE Year = '2013'      -- 2010,2011,2012,2013,2014
GROUP BY Year,Month_Name,Month_No
ORDER BY Month_No;

-- *****************************************************************************************
-- WEEKTYPE  SALES
SELECT Week_Type,SUM(Total_Sales) AS Totalsales,
CASE
    WHEN SUM(Total_Sales) >= 1000000 THEN CONCAT(ROUND(SUM(Total_Sales)/1000000,0),'M')
    WHEN SUM(Total_Sales) >= 1000 THEN CONCAT(ROUND(SUM(Total_Sales)/1000,0),'K') 
END AS Total_Formatted_sales
FROM Sales
GROUP BY Week_Type;
-- *****************************************************************************************
-- USING PARTITION FUNCTION BY Year

SELECT Year,Month_Name,Quarter,Day_Name,SUM(Total_Sales) AS Totalsales,
DENSE_RANK() OVER ( PARTITION BY Year ORDER BY SUM(Total_Sales) DESC)
AS 'dense_rank' FROM Sales
GROUP BY YEAR,Month_Name,Quarter,Day_Name
ORDER BY Year;
-- *****************************************************************************************
-- YEAR FILTER FOR TOP 5 SALES

SELECT Year,Month_Name,Quarter,Day_Name,SUM(Total_Sales) AS Totalsales,
DENSE_RANK() OVER ( PARTITION BY Year ORDER BY SUM(Total_Sales) DESC)
AS 'dense_rank' FROM Sales
WHERE Year = 2012
GROUP BY YEAR,Month_Name,Quarter,Day_Name
LIMIT 5;




















