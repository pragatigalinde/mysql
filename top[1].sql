SELECT * FROM Sales;
SELECT * FROM dimproductfinal;
-- ********************************************************************************************************************
DROP TABLE Lookup;
CREATE TABLE Lookup
SELECT Sales.*,dpf.EnglishProductName,EnglishProductCategoryName,EnglishProductSubcategoryName,Color
FROM Sales
INNER JOIN dimproductfinal dpf ON Sales.ProductKey =dpf.ProductKey;
-- ********************************************************************************************************************
SELECT * FROM Lookup;
-- Available  products

SELECT COUNT(EnglishProductName) AS Total_Products
FROM dimproductfinal;
-- ******************************************************************************************************************** 
-- Sold products

SELECT COUNT(DISTINCT(ProductKey)) AS Sold_products
FROM Lookup;
-- ********************************************************************************************************************
-- Unslod products

SELECT Total_Products - Sold_Products AS UnsoldProducts
FROM (
SELECT COUNT(EnglishProductName) AS Total_Products
FROM dimproductfinal
    ) Total,
(
    SELECT COUNT(DISTINCT ProductKey) AS Sold_Products
    FROM Lookup
) Sold;
-- ********************************************************************************************************************
SELECT * FROM Lookup;

-- TOP 5 HIGHEST SALES BY PRODUCT COLOR

SELECT Color, SUM(Total_Sales),
ROW_NUMBER() OVER (ORDER BY SUM(Total_Sales) DESC) 
AS "Row_number"
FROM Lookup
group by Color
LIMIT 5;

-- ********************************************************************************************************************
-- Total number of customers
SELECT COUNT(*) Gender 
FROM dimcustomer;
-- ********************************************************************************************************************
-- Number of Male customers
SELECT COUNT(*) 
FROM dimcustomer
WHERE Gender = "M";
-- ********************************************************************************************************************
-- Number of Fe Male customers
SELECT COUNT(*) 
FROM dimcustomer
WHERE Gender = "F";

-- ********************************************************************************************************************  
SELECT * FROM dimcustomer;
SELECT * FROM Sales;

-- Top 5 customers sales from 2010 to 2014

DROP view vw_topcustomers;

CREATE VIEW vw_topcustomers
AS 
SELECT c.Customerfullname,SUM(s.Total_Sales) AS Totalsales
FROM dimcustomer c
JOIN Sales s USING (CustomerKey)
GROUP BY c.Customerfullname
ORDER BY SUM(s.Total_Sales) DESC
LIMIT 5;

SELECT * FROM vw_topcustomers;
-- ******************************************************************************************************************** 
-- Gender wise sales

 DROP  VIEW vw_Gender;
CREATE VIEW vw_Gender
AS
SELECT c.Gender,SUM(s.Total_Sales) AS Totalsales
FROM dimcustomer c
JOIN Sales s USING (CustomerKey)
GROUP BY Gender 
ORDER BY SUM(s.Total_Sales) DESC;

SELECT * FROM vw_Gender;
-- ******************************************************************************************************************** 
-- Country wise sales

SELECT * FROM dimsalesterritory;
SELECT * FROM Sales;

DROP VIEW vw_country;

CREATE VIEW vw_country
AS
SELECT SalesTerritoryCountry,SUM(Total_Sales) AS Totalsales
FROM dimsalesterritory
JOIN Sales USING (SalesTerritoryKey)
GROUP BY SalesTerritoryCountry
ORDER BY SUM(Total_Sales) DESC;

SELECT * FROM vw_country;
-- ******************************************************************************************************************** 
DROP VIEW vw_Group;

CREATE VIEW vw_Group 
AS
SELECT SalesTerritoryGroup,SalesTerritoryCountry,SUM(Total_Sales) AS Totalsales,
dense_rank() OVER (PARTITION BY SalesTerritoryGroup ORDER BY SUM(Total_Sales) DESC) 
AS "Dense_rank"
FROM dimsalesterritory
JOIN Sales USING (SalesTerritoryKey)
GROUP BY SalesTerritoryGroup,SalesTerritoryCountry
ORDER BY SUM(Total_Sales) DESC;

SELECT * FROM vw_Group;





































































































































