-- ========================================================
-- Script: 12_customers_with_orders_in_all_categories.sql
-- Purpose: List customers who have placed an order that includes
--          products from all product categories.
-- Author: Lana Mustafić
-- Description:
--   This query selects customers and their sales orders
--   where the order contains products from all available
--   product categories. It calculates the total discounted
--   value of each order and counts the distinct categories
--   included in that order.
-- ========================================================

SELECT 
    pp.FirstName,
    pp.LastName, 
    soh.SalesOrderID,
    ROUND(SUM(sod.UnitPrice * sod.OrderQty * (1 - sod.UnitPriceDiscount)), 2) AS DiscountedOrderTotal, 
    COUNT(DISTINCT pc.ProductCategoryID) AS CategoryCount
FROM AdventureWorks2017.Person.Person AS pp
INNER JOIN AdventureWorks2017.Sales.Customer AS c 
    ON pp.BusinessEntityID = c.PersonID
INNER JOIN AdventureWorks2017.Sales.SalesOrderHeader AS soh 
    ON c.CustomerID = soh.CustomerID
INNER JOIN AdventureWorks2017.Sales.SalesOrderDetail AS sod 
    ON soh.SalesOrderID = sod.SalesOrderID
INNER JOIN AdventureWorks2017.Production.Product AS p 
    ON sod.ProductID = p.ProductID
INNER JOIN AdventureWorks2017.Production.ProductSubcategory AS psc 
    ON p.ProductSubcategoryID = psc.ProductSubcategoryID
INNER JOIN AdventureWorks2017.Production.ProductCategory AS pc 
    ON psc.ProductCategoryID = pc.ProductCategoryID
GROUP BY pp.FirstName, pp.LastName, soh.SalesOrderID
HAVING COUNT(DISTINCT pc.ProductCategoryID) = (
    SELECT COUNT(DISTINCT pc1.ProductCategoryID)
    FROM AdventureWorks2017.Production.ProductCategory AS pc1
);
