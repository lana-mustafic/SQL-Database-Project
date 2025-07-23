-- ================================================
-- Script: 08_count_products_by_special_offer.sql
-- Purpose: Count products per special offer
--          filtering products that belong to Clothing category
--          or have a recorded product model.
-- Author: Lana Mustafić
-- Description:
--   Returns the SpecialOfferID and the count of products
--   that either belong to the Clothing category
--   or have a ProductModelID assigned.
-- Notes:
--   - Uses OR condition to include products meeting either criteria.
--   - Joins Product with SpecialOfferProduct, Subcategory, and Category tables.
-- ================================================

USE AdventureWorks2017
GO

SELECT 
    sop.SpecialOfferID,
    COUNT(p.ProductID) AS ProductCount
FROM AdventureWorks2017.Production.Product AS p
INNER JOIN AdventureWorks2017.Sales.SpecialOfferProduct AS sop
    ON p.ProductID = sop.ProductID
INNER JOIN AdventureWorks2017.Production.ProductSubcategory AS psc
    ON p.ProductSubcategoryID = psc.ProductSubcategoryID
INNER JOIN AdventureWorks2017.Production.ProductCategory AS pc
    ON psc.ProductCategoryID = pc.ProductCategoryID
WHERE pc.Name = 'Clothing' OR p.ProductModelID IS NOT NULL
GROUP BY sop.SpecialOfferID;
