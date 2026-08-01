-- Task2_SQL_Queries.sql
CREATE DATABASE SuperstoreDB;
GO

USE SuperstoreDB;
GO

CREATE TABLE Orders (
    Row_ID INT,
    Order_ID VARCHAR(50),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(50),
    Customer_ID VARCHAR(50),
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50),
    Country VARCHAR(50),
    City VARCHAR(100),
    State VARCHAR(100),
    Postal_Code INT,
    Region VARCHAR(50),
    Product_ID VARCHAR(50),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name VARCHAR(255),
    Sales FLOAT,
    Quantity INT,
    Discount FLOAT,
    Profit FLOAT
);

-- View Data
SELECT * FROM Orders;

-- Top 10 Rows
SELECT TOP 10 * FROM Orders;

-- Sales > 500
SELECT * FROM Orders WHERE Sales > 500;

-- Furniture Products
SELECT * FROM Orders WHERE Category='Furniture';

-- Order by Sales
SELECT Product_Name, Sales
FROM Orders
ORDER BY Sales DESC;

-- Total Sales
SELECT SUM(Sales) AS TotalSales
FROM Orders;

-- Average Profit
SELECT AVG(Profit) AS AvgProfit
FROM Orders;

-- Count Orders
SELECT COUNT(*) AS TotalOrders
FROM Orders;

-- Category-wise Sales
SELECT Category, SUM(Sales) AS TotalSales
FROM Orders
GROUP BY Category;

-- Region-wise Profit
SELECT Region, SUM(Profit) AS TotalProfit
FROM Orders
GROUP BY Region;

-- HAVING
SELECT Category, SUM(Sales) AS TotalSales
FROM Orders
GROUP BY Category
HAVING SUM(Sales) > 100000;

-- Top 5 Products
SELECT TOP 5 Product_Name, SUM(Sales) AS TotalSales
FROM Orders
GROUP BY Product_Name
ORDER BY TotalSales DESC;

-- Window Functions
SELECT Product_Name, Sales,
RANK() OVER(ORDER BY Sales DESC) AS SalesRank
FROM Orders;

SELECT Product_Name, Sales,
DENSE_RANK() OVER(ORDER BY Sales DESC) AS DenseRank
FROM Orders;

SELECT Product_Name, Sales,
ROW_NUMBER() OVER(ORDER BY Sales DESC) AS RowNum
FROM Orders;

SELECT Order_ID, Sales,
LAG(Sales) OVER(ORDER BY Order_Date) AS PreviousSale
FROM Orders;

SELECT Order_ID, Sales,
LEAD(Sales) OVER(ORDER BY Order_Date) AS NextSale
FROM Orders;

-- Monthly Sales Trend
SELECT YEAR(Order_Date) AS Year,
MONTH(Order_Date) AS Month,
SUM(Sales) AS TotalSales
FROM Orders
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Year, Month;

-- Customer Spending
SELECT TOP 10 Customer_Name,
SUM(Sales) AS TotalSpent
FROM Orders
GROUP BY Customer_Name
ORDER BY TotalSpent DESC;

-- Segment Sales
SELECT Segment, SUM(Sales) AS Sales
FROM Orders
GROUP BY Segment;

-- Category Profit
SELECT Category, SUM(Profit) AS Profit
FROM Orders
GROUP BY Category;

-- Region Sales
SELECT Region, SUM(Sales) AS Sales
FROM Orders
GROUP BY Region;

-- Most Sold Sub-Category
SELECT Sub_Category,
SUM(Quantity) AS QuantitySold
FROM Orders
GROUP BY Sub_Category
ORDER BY QuantitySold DESC;

-- Discount Impact
SELECT Discount,
AVG(Profit) AS AvgProfit
FROM Orders
GROUP BY Discount
ORDER BY Discount;
