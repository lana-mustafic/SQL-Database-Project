-- ========================================================
-- Script: 11_top_products_excluded_rank_remaining.sql
-- Purpose: Show products *excluding* the top 10 best-sellers
--          from the last 11 years, ranked by total quantity sold
-- Author: Lana Mustafić
-- Description:
--   This query retrieves all products from the AdventureWorks2017 database
--   that are not among the top 10 best-selling products (by quantity sold)
--   in the past 11 years. It ranks the remaining products by their total
--   quantity sold in descending order.
--   Subquery identifies the top 10 products sold in the past 11 years.
-- ========================================================

SELECT
    sod.ProductID,
    SUM(sod.OrderQty) AS TotalQuantitySold
FROM AdventureWorks2017.Sales.SalesOrderDetail AS sod
WHERE sod.ProductID NOT IN (
    SELECT TOP 10
        sod1.ProductID
    FROM AdventureWorks2017.Sales.SalesOrderDetail AS sod1
    INNER JOIN AdventureWorks2017.Sales.SalesOrderHeader AS soh1
        ON sod1.SalesOrderID = soh1.SalesOrderID
    WHERE soh1.OrderDate >= DATEADD(YEAR, -11, GETDATE())  -- last 11 years
    GROUP BY sod1.ProductID
    ORDER BY SUM(sod1.OrderQty) DESC                        -- Top 10 by quantity
)
GROUP BY sod.ProductID
ORDER BY TotalQuantitySold DESC;                            -- Remaining top sellers
