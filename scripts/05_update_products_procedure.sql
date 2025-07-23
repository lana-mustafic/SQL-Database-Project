-- ================================================
-- Script: 04_update_products_procedure.sql
-- Purpose: Create a stored procedure to update Products table
-- Author: Lana Mustafić
-- Description:
--   Updates product details in the Products table.
--   Only updates fields if parameters are not NULL.
-- ================================================

USE OrdersManagementDB
GO


CREATE PROCEDURE sp_update_products
(
    @ProductId INT,
    @ProductName NVARCHAR(40) = NULL,
    @SupplierCompanyName NVARCHAR(40) = NULL,
    @CategoryName NVARCHAR(15) = NULL
)
AS
BEGIN
    UPDATE dbo.Products
    SET
        ProductName = IIF(@ProductName IS NULL, ProductName, @ProductName),
        SupplierCompanyName = IIF(@SupplierCompanyName IS NULL, SupplierCompanyName, @SupplierCompanyName),
        CategoryName = IIF(@CategoryName IS NULL, CategoryName, @CategoryName)
    WHERE ProductId = @ProductId
END
GO

-- Example test of the procedure 
EXEC sp_update_products @ProductId = 1, @ProductName = 'Updated Product';
