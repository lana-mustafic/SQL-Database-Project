-- ================================================
-- Script: 07_smallest_card_order_europe.sql
-- Purpose: Find the smallest order paid by credit card
--          delivered to the Europe territory
-- Author: Lana Mustafić
-- Description:
--   Returns the SalesOrderID, customer's full name,
--   and city for the smallest order paid by credit card
--   in the Europe sales territory.
-- Notes:
--   - Filters orders paid by credit card only.
--   - Filters sales territory to Europe region.
--   - Orders results ascending by total order amount to find smallest order.
-- ================================================

USE AdventureWorks2017
GO

SELECT TOP 1
    sod.SalesOrderID,
    CONCAT(p.FirstName, ' ', p.LastName) AS ImePrezime,
    a.City
FROM AdventureWorks2017.Person.Person AS p
INNER JOIN AdventureWorks2017.Sales.Customer AS c
    ON p.BusinessEntityID = c.PersonID
INNER JOIN AdventureWorks2017.Sales.SalesOrderHeader AS sod
    ON sod.CustomerID = c.CustomerID
INNER JOIN AdventureWorks2017.Sales.SalesTerritory AS st
    ON sod.TerritoryID = st.TerritoryID
INNER JOIN AdventureWorks2017.Person.Address AS a
    ON sod.ShipToAddressID = a.AddressID
WHERE sod.CreditCardID IS NOT NULL
  AND st.[Group] = 'Europe'
ORDER BY sod.TotalDue ASC;