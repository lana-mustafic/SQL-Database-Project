-- ================================================
-- Script: 03_insert_data.sql
-- Purpose: Insert data into OrdersManagementDB from Northwind
-- Author: Lana Mustafić
-- Description:
--   Populates Employees, Orders, Products, and OrderItems tables
--   using relevant data from the Northwind sample database.
--   Includes joins for related data like territories and suppliers.
-- ================================================


USE OrdersManagementDB
GO

-- Insert data into Employees table from Northwind
-- Joins with EmployeeTerritories to calculate TotalTerritories
SET IDENTITY_INSERT Employees ON
INSERT INTO dbo.Employees(EmployeeID,FirstName,LastName,BirthDate,TotalTerritories)
SELECT
E.EmployeeID,
E.FirstName,
E.LastName,
E.BirthDate,
COUNT(ET.TerritoryID) AS TotalTerritories
FROM Northwind.dbo.Employees AS E
INNER JOIN Northwind.dbo.EmployeeTerritories AS ET ON E.EmployeeID=ET.EmployeeID
GROUP BY E.EmployeeID,E.FirstName,LastName,E.BirthDate
SET IDENTITY_INSERT Employees OFF


-- Insert data into Orders table from Northwind
-- Joins with Customers to get customer details
SET IDENTITY_INSERT Orders ON
INSERT INTO dbo.Orders(OrderID,EmployeeID,OrderDate,CustomerCompanyName,CustomerAddress,TotalOrderItems)
SELECT
O.OrderID,
O.EmployeeID,
O.OrderDate,
C.CompanyName,
C.Address,
COUNT(O.OrderID) AS TotalOrderItems
FROM Northwind.dbo.Orders AS O
INNER JOIN Northwind.dbo.Customers AS C ON O.CustomerID=C.CustomerID
GROUP BY O.OrderID,O.EmployeeID,O.OrderDate,C.CompanyName,C.Address
SET IDENTITY_INSERT Orders OFF


-- Insert data into Products table from Northwind
-- Joins with Suppliers and Categories for related names
SET IDENTITY_INSERT Products ON
INSERT INTO dbo.Products(ProductID,ProductName,SupplierCompanyName,CategoryName)
SELECT
P.ProductID,
P.ProductName,
S.CompanyName,
C.CategoryName
FROM Northwind.dbo.Products AS P
INNER JOIN Northwind.dbo.Suppliers AS S ON P.SupplierID=S.SupplierID
INNER JOIN Northwind.dbo.Categories AS C ON P.CategoryID=C.CategoryID
SET IDENTITY_INSERT Products OFF


-- Insert data into OrderItems table from Northwind
INSERT INTO dbo.OrderItems(OrderID,ProductID,Price,Quantity,Discount)
SELECT
OD.OrderID,
OD.ProductID,
OD.UnitPrice,
OD.Quantity,
OD.Discount
FROM Northwind.dbo.[Order Details] AS OD