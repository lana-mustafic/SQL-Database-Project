-- ================================================
-- Script: 09_customers_with_orders_in_5_months.sql
-- Purpose: Retrieve customers with orders in at least 5 different months of 2012
-- Author: Lana Mustafić
-- Description:
--   This query selects customers from the AdventureWorks2017 database
--   who have placed orders in five or more distinct months during the year 2012.
--   It uses grouping and filtering by year and month.
-- ================================================

SELECT
    soh.CustomerID,
    COUNT(DISTINCT MONTH(soh.OrderDate)) AS NumberOfMonths
FROM AdventureWorks2017.Sales.SalesOrderHeader AS soh
WHERE YEAR(soh.OrderDate) = 2012
GROUP BY soh.CustomerID
HAVING COUNT(DISTINCT MONTH(soh.OrderDate)) >= 5
