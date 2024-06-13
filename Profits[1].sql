SELECT * FROM sales;

SET SQL_SAFE_UPDATES=0;

-- Year wise PROFIT amount

SELECT Year,SUM(Profit) AS Totalprofit,
CASE
    WHEN SUM(Profit) >= 1000000 THEN CONCAT(ROUND(SUM(Profit)/1000000,1),'M')
    WHEN SUM(Profit) >= 1000 THEN CONCAT(ROUND(SUM(Profit)/1000,1),'K') 
END AS Total_Formatted_profit
FROM Sales
GROUP BY Year
ORDER BY Year;
-- *****************************************************************************************
-- Year Filter

SELECT Year,SUM(Profit) AS Totalprofit,
CASE
    WHEN SUM(Profit) >= 1000000 THEN CONCAT(ROUND(SUM(Profit)/1000000,1),'M')
    WHEN SUM(Profit) >= 1000 THEN CONCAT(ROUND(SUM(Profit)/1000,1),'K') 
END AS Total_Formatted_profit
FROM Sales
WHERE Year = 2014   -- ,2011,2012,2013,2014
GROUP BY Year
ORDER BY Year;

-- *****************************************************************************************
-- Month wise PROFIT

SELECT Month_No,Month_Name,SUM(Profit) AS Totalprofit,
CASE 
    WHEN SUM(Profit) >= 1000000 THEN CONCAT(ROUND(SUM(Profit)/1000000,1),'M')
    WHEN SUM(Profit) >= 1000 THEN CONCAT(ROUND(SUM(Profit)/1000,1),'K')
END AS Total_Formatted_profit
FROM Sales
GROUP BY Month_Name,Month_No
ORDER BY Month_No;
-- *****************************************************************************************
-- Month FILTER

SELECT Month_No,Month_Name,SUM(Profit) AS Totalprofit,
CASE 
    WHEN SUM(Profit) >= 1000000 THEN CONCAT(ROUND(SUM(Profit)/1000000,1),'M')
    WHEN SUM(Profit) >= 1000 THEN CONCAT(ROUND(SUM(Profit)/1000,1),'K')
END AS Total_Formatted_profit
FROM Sales
WHERE  Month_No=2 
GROUP BY Month_Name,Month_No;

-- *****************************************************************************************
SELECT * FROM sales;
-- Quarter wise PROFIT

SELECT Quarter,SUM(Profit) AS Totalprofit,
CASE
    WHEN SUM(Profit) >= 1000000 THEN CONCAT(ROUND(SUM(Profit)/1000000,1),'M')
    WHEN SUM(Profit) >= 1000 THEN CONCAT(ROUND(SUM(Profit)/1000,1),'K') 
END AS Total_Formatted_profit
FROM Sales
GROUP BY Quarter
ORDER BY Quarter;
-- *****************************************************************************************
-- Day name wise PROFIT

SELECT Day_No,Day_Name,SUM(Profit) AS Totalprofit,
CASE
    WHEN SUM(Profit) >= 1000000 THEN CONCAT(ROUND(SUM(Profit)/1000000,1),'M')
    WHEN SUM(Profit) >= 1000 THEN CONCAT(ROUND(SUM(Profit)/1000,1),'K') 
END AS Total_Formatted_profit
FROM Sales
GROUP BY Day_Name,Day_No
ORDER BY Day_No;
-- *****************************************************************************************
-- When the year is a filter for monthwise PROFIT

SELECT year,Month_Name,Month_No,SUM(Profit) AS Totalprofit,
CASE 
    WHEN SUM(Profit) >= 1000000 THEN CONCAT(ROUND(SUM(Profit)/1000000,0),'M')
    WHEN SUM(Profit) >= 1000 THEN CONCAT(ROUND(SUM(Profit)/1000,0),'K')
END AS Total_Formatted_profit
FROM Sales
WHERE Year = '2012'      -- 2010,2011,2012,2013,2014
GROUP BY Year,Month_Name,Month_No
ORDER BY Month_No;

-- *****************************************************************************************
-- WEEKTYPE  PROFIT

SELECT Week_Type,SUM(Profit) AS Totalprofit,
CASE
    WHEN SUM(Profit) >= 1000000 THEN CONCAT(ROUND(SUM(Profit)/1000000,0),'M')
    WHEN SUM(Profit) >= 1000 THEN CONCAT(ROUND(SUM(Profit)/1000,0),'K') 
END AS Total_Formatted_profit
FROM Sales
GROUP BY Week_Type;
-- *****************************************************************************************
-- USING PARTITION FUNCTION BY Year

SELECT Year,Month_Name,Quarter,Day_Name,SUM(Profit) AS Totalprofit,
DENSE_RANK() OVER ( PARTITION BY Year ORDER BY SUM(Profit) DESC)
AS 'dense_rank' FROM Sales
GROUP BY YEAR,Month_Name,Quarter,Day_Name
ORDER BY Year;
-- *****************************************************************************************
-- YEAR FILTER FOR TOP 5 PROFITS

SELECT Year,Month_Name,Quarter,Day_Name,SUM(Profit) AS Totalprofit,
DENSE_RANK() OVER ( PARTITION BY Year ORDER BY SUM(Profit) DESC)
AS 'dense_rank' FROM Sales
WHERE Year = 2012
GROUP BY YEAR,Month_Name,Quarter,Day_Name
LIMIT 5;