-- ========================================================
-- Script: 10_products_below_category_avg_price.sql
-- Purpose: Display products with a price below the average
--          for their product category
-- Author: Lana Mustafić
-- Description:
--   This query selects products from the AdventureWorks2017 database
--   whose list price is lower than the average list price
--   of all products in the same product category.
--   It joins products with their subcategories and categories,
--   and compares each product's price to the category's average.
-- ========================================================

SELECT
    p.Name,
    p.ListPrice
FROM AdventureWorks2017.Production.Product AS p
INNER JOIN AdventureWorks2017.Production.ProductSubcategory AS psc
    ON p.ProductSubcategoryID = psc.ProductSubcategoryID
INNER JOIN AdventureWorks2017.Production.ProductCategory AS pc
    ON psc.ProductCategoryID = pc.ProductCategoryID
WHERE p.ListPrice < (
    SELECT AVG(p2.ListPrice)
    FROM AdventureWorks2017.Production.Product AS p2
    INNER JOIN AdventureWorks2017.Production.ProductSubcategory AS psc2
        ON p2.ProductSubcategoryID = psc2.ProductSubcategoryID
    INNER JOIN AdventureWorks2017.Production.ProductCategory AS pc2
        ON psc2.ProductCategoryID = pc2.ProductCategoryID
    WHERE pc2.ProductCategoryID = pc.ProductCategoryID
)
