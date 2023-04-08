USE GROUP14_DMDD_TEST;


--Table-level CHECK Constraints based on a function FOR ZIPCODE 
DROP FUNCTION [dbo].[fn_IsValidZipCode];

GO
CREATE FUNCTION [dbo].[fn_IsValidZipCode] (@Zip INT)
RETURNS BIT
AS 
BEGIN
    RETURN CASE WHEN @Zip BETWEEN 1000 AND 9999 THEN 1 ELSE 0 END
END









