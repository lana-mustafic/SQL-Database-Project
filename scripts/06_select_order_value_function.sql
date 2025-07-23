-- ================================================
-- Script: 04c_select_order_value_function.sql
-- Purpose: Create a table-valued function to return order info
-- Author: Lana Mustafić
-- Description:
--   Returns the OrderID and total value (Price * Quantity)
--   for the specified OrderID, without applying any discount.
-- ================================================

-- ================================================
-- Script: 06_select_order_value_function.sql
-- Purpose: Create a table-valued function to return order info
-- Author: Lana Mustafić
-- Description:
--   Returns the OrderID and total value (Price * Quantity)
--   for the specified OrderID, without applying any discount.
-- ================================================


USE OrdersManagementDB
GO

CREATE FUNCTION f_4c
(
    @OrderID INT  -- ID of the order to retrieve
)
RETURNS TABLE
AS
RETURN
    SELECT 
        OI.OrderID,  -- Order identifier
        SUM(OI.Price * OI.Quantity) AS ValueWithoutDiscount  -- Total value before discount
    FROM dbo.OrderItems AS OI
    WHERE OI.OrderID = @OrderID
    GROUP BY OI.OrderID;
GO

-- Example test of the function 
 SELECT * FROM f_4c(10248);
