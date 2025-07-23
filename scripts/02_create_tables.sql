-- ================================================
-- Script: 02_create_tables.sql
-- Purpose: Create core tables for OrdersManagementDB
-- Author: Lana Mustafić
-- Description:
--   Defines Employees, Orders, Products, and OrderItems tables
--   with keys, constraints, and appropriate data types.
-- ================================================

USE OrdersManagementDB
GO

-- Employees table stores employee personal data and territory count
CREATE TABLE Employees (
EmployeeID INT IDENTITY(1,1) PRIMARY KEY,               -- Unique Employee identifier
FirstName NVARCHAR(10) NOT NULL,                        -- Employee's first name
LastName NVARCHAR(20) NOT NULL,                         -- Employee's last name
BirthDate DATETIME2 NOT NULL,                           -- Employee's birth date
TotalTerritories INT                                    -- Total territories assigned to employee
)
GO

-- Orders table stores customer orders linked to employees
CREATE TABLE Orders (
OrderID INT IDENTITY(1,1) PRIMARY KEY,                  -- Unique Order identifier
EmployeeID INT NOT NULL,                                -- Reference to employee who took order
OrderDate DATETIME2,                                    -- Date when order was made
CustomerCompanyName NVARCHAR(40),                       -- Customer's company name
CustomerAddress NVARCHAR(60),                           -- Customer's address
TotalOrderItems INT,                                    -- Total number of items in order
CONSTRAINT FK_Orders_Employees FOREIGN KEY (EmployeeID) 
     REFERENCES Employees(EmployeeID)                   -- Foreign key constraint linking to Employees
)
GO

-- Products table stores product details
CREATE TABLE Products (
ProductID INT IDENTITY(1,1) PRIMARY KEY,                -- Unique Product identifier
ProductName NVARCHAR(40) NOT NULL,                      -- Name of the product
SupplierCompanyName NVARCHAR(40),                       -- Supplier's company name
CategoryName NVARCHAR(15)                               -- Product category
)
GO

-- OrderItems table stores details of products within orders
CREATE TABLE OrderItems (
OrderID INT NOT NULL,                                    -- Reference to the order
ProductID INT NOT NULL,                                  -- Reference to the product
Price MONEY NOT NULL,                                    -- Price per product unit
Quantity SMALLINT NOT NULL,                              -- Quantity ordered
Discount REAL NOT NULL,                                  -- Discount applied to this product in order
CONSTRAINT PK_OrderItems PRIMARY KEY (OrderID, ProductID),    -- Composite primary key for order-product pairs
CONSTRAINT FK_OrderItems_Orders FOREIGN KEY (OrderID) 
   REFERENCES Orders(OrderID),                                -- Foreign key linking to Orders
CONSTRAINT FK_OrderItems_Products FOREIGN KEY (ProductID) 
   REFERENCES Products(ProductID)                             -- Foreign key linking to Products
)
GO
