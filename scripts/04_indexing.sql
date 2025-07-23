-- ================================================
-- Script: 04_indexing.sql
-- Purpose: Create and test index for performance optimization
-- Author: Lana Mustafić
-- Description:
--   Creates a NONCLUSTERED index on the ProductName column 
--   in the Products table to improve search performance.
--   Includes a test query that benefits from the index.
-- ================================================

USE OrdersManagementDB
GO

-- Create a NONCLUSTERED index on ProductName column
-- Improves filtering and searching by product name
CREATE NONCLUSTERED INDEX IX_Products_ProductName
ON Products (ProductName)


-- Test query to verify index usage
-- Retrieves all products starting with letter 'A'
SELECT*
FROM Products AS P
WHERE P.ProductName LIKE 'A%'


