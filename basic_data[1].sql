CREATE DATABASE Adventure_works;
USE Adventure_works;

SELECT * FROM factinternetsales;
SELECT * FROM fact_internet_sales_new;
-- *****************************************************************************************
SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'factinternetsales'; 
-- *****************************************************************************************
SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'fact_internet_sales_new'; 
-- *****************************************************************************************
-- Checking the datatype of the each field

ALTER TABLE factinternetsales MODIFY COLUMN OrderDateKey DATE;
ALTER TABLE factinternetsales MODIFY COLUMN DueDateKey DATE;
ALTER TABLE factinternetsales MODIFY COLUMN ShipDateKey DATE;

-- *****************************************************************************************
-- Checking the datatype of the each field

ALTER TABLE fact_internet_sales_new MODIFY COLUMN OrderDateKey DATE;
ALTER TABLE fact_internet_sales_new MODIFY COLUMN DueDateKey DATE;
ALTER TABLE fact_internet_sales_new MODIFY COLUMN ShipDateKey DATE;

ALTER TABLE fact_internet_sales_new MODIFY COLUMN ShipDateKey INT;

-- *****************************************************************************************
-- JOIN TABLES FOR CRAETING FINAL SALES TABLE
 
CREATE TABLE Sales AS
SELECT * FROM factinternetsales
UNION ALL
SELECT * FROM fact_internet_sales_new;

SELECT * FROM sales;
-- *****************************************************************************************
-- Checking the datatype of the each field

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = "Sales";
-- *****************************************************************************************
ALTER TABLE Sales
DROP COLUMN PromotionKey,
DROP COLUMN SalesOrderLineNumber,
DROP COLUMN RevisionNumber,
DROP COLUMN CarrierTrackingNumber,
DROP COLUMN CustomerPONumber,
DROP COLUMN OrderDate,
DROP COLUMN DueDate,
DROP COLUMN ShipDate;
-- *****************************************************************************************
SELECT * FROM dimproduct;                               
SELECT * FROM dimproductcategory;  
SELECT * FROM dimproductsubcategory;                                        

-- *****************************************************************************************
-- MERGE TABLES FOR CREATING FINAL PRODUCT TABLE

CREATE TABLE  dimproductfinal AS   
SELECT dimproduct.*, EnglishProductCategoryName,ProductCategoryKey,EnglishProductSubcategoryName
FROM dimproduct
LEFT OUTER JOIN dimproductsubcategory USING(productsubcategoryKey)
LEFT OUTER JOIN dimproductcategory USING(ProductCategoryKey);

SELECT * FROM dimproductfinal;  

-- *****************************************************************************************
SELECT * FROM dimproductfinal;   
SELECT * FROM sales;
-- *****************************************************************************************
-- Question-1 
-- Lookup product names into sales table

SELECT Sales.*,dpf.EnglishProductName,EnglishProductCategoryName,EnglishProductSubcategoryName
FROM Sales
INNER JOIN dimproductfinal dpf ON Sales.ProductKey =dpf.ProductKey;

-- *****************************************************************************************
SELECT * FROM dimcustomer;
SELECT * FROM sales;

ALTER TABLE dimcustomer
ADD COLUMN Customerfullname TEXT AFTER LastName;

-- *****************************************************************************************
SET SQL_SAFE_UPDATES=0;

UPDATE dimcustomer
SET Customerfullname=
CONCAT(Title,FirstName," ",MiddleName," ",LastName); 

-- *****************************************************************************************
-- LOOKUP CUSTOMER FULL NAME FROM dimcustomer TO SALES TABLE

SELECT Sales.*,
CONCAT(Title,FirstName," ",MiddleName," ",LastName) AS Customerfullname
FROM Sales
LEFT OUTER JOIN dimcustomer USING(CustomerKey);

-- *****************************************************************************************
-- Question-3
SELECT * FROM sales;

ALTER TABLE Sales
ADD COLUMN Year INT AFTER OrderDateKey,
ADD COLUMN Month_No INT AFTER Year,
ADD COLUMN Month_Name TEXT AFTER Month_No,
ADD COLUMN Day_No INT AFTER Month_Name,
ADD COLUMN Day_Name TEXT AFTER Day_No,
ADD COLUMN Quarter TEXT AFTER Day_Name,
ADD COLUMN Week_Type TEXT AFTER Quarter;
-- *****************************************************************************************
ALTER TABLE Sales
DROP COLUMN Year,
DROP COLUMN OrderDateKey,
DROP COLUMN Month_No,
DROP COLUMN Month_Name,
DROP COLUMN Day_No,
DROP COLUMN Day_Name,
DROP COLUMN Quarter, 
DROP COLUMN Week_Type;

SELECT * FROM sales;
-- *****************************************************************************************
SET SQL_SAFE_UPDATES=0;

UPDATE Sales 
SET Year = YEAR(OrderDateKey);

UPDATE Sales 
SET Month_No = MONTH(OrderDateKey);

UPDATE Sales 
SET Month_Name = MONTHNAME(OrderDateKey);

UPDATE Sales 
SET Day_Name = DAYNAME(OrderDateKey);

UPDATE Sales 
SET Day_No = DAYOFWEEK(OrderDateKey);

UPDATE Sales 
SET Quarter = QUARTER(OrderDateKey);

UPDATE sales
SET Quarter = 
  CASE
       WHEN Quarter = 1 THEN 'Q1'
       WHEN Quarter = 2 THEN 'Q2'
       WHEN Quarter = 3 THEN 'Q3'
       ELSE  'Q4'
  END;    
-- *****************************************************************************************

UPDATE Sales
SET Week_Type = 
CASE 
WHEN Day_No = 1 OR Day_No  = 7 THEN "WEEKEND"                       -- OR IS AN OPERATOR
ELSE "WEEKDAY"
END;

-- *****************************************************************************************
UPDATE Sales
SET Week_Type = NULL;
-- *****************************************************************************************

ALTER TABLE Sales ADD COLUMN Financial_Month_No INT AFTER Week_Type;

SELECT * FROM sales;

UPDATE Sales
SET Financial_Month_No = 
CASE 
WHEN Month_No >=4 THEN (Month_No-3)
ELSE (Month_No + 9)
END;

-- *****************************************************************************************

ALTER TABLE Sales ADD COLUMN Financial_Quarter TEXT AFTER Financial_Month_No;

UPDATE Sales
SET Financial_Quarter =
CASE 
   WHEN Financial_Month_No <= 3 THEN "Q1"
   WHEN Financial_Month_No <= 6 THEN "Q2"
   WHEN Financial_Month_No <= 9 THEN "Q3"
   ELSE "Q4"
   END;   
-- *****************************************************************************************
ALTER TABLE Sales ADD COLUMN Total_Sales INT;

UPDATE Sales
SET Total_Sales = (UnitPrice * OrderQuantity)-(UnitPriceDiscountPct);

ALTER TABLE Sales ADD COLUMN Product_Cost INT;

UPDATE Sales
SET Product_Cost = TotalProductCost/OrderQuantity;

ALTER TABLE Sales ADD COLUMN Profit INT;

UPDATE Sales
SET Profit = Total_Sales - Product_Cost;

-- *****************************************************************************************






















































































































































































































































