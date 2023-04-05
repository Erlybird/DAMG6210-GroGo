CREATE DATABASE GROUP14_DMDD_TEST;
USE GROUP14_DMDD_TEST;

--PERSON
CREATE PROCEDURE sp_InsertPerson
    @FirstName nvarchar(255),
    @LastName nvarchar(255),
    @Phone nvarchar(10),
    @Email nvarchar(255),
    @Gender nvarchar(20)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Person (FirstName, LastName, Phone, Email, Gender)
    VALUES (@FirstName, @LastName, @Phone, @Email, @Gender);
END

EXEC sp_InsertPerson 'Akhil3', 'Malladi', '1234567890', 'gfh@gmail.com', 'Male';

--ADDRESS
CREATE PROCEDURE sp_InsertAddress
    @AptNo INT,
    @Street nvarchar(255),
    @City nvarchar(255),
    @State nvarchar(255),
    @Country nvarchar(255),
    @Zip INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Address (AptNo, Street, City, State, Country, Zip) 
    VALUES (@AptNo, @Street, @City, @State, @Country, @Zip);
END

EXEC sp_InsertAddress '3614', 'Riverway', 'Boston', 'MA', 'US',02115;

--MANAGER
CREATE PROCEDURE sp_InsertManager
    @PersonID int
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Manager (PersonID)
    VALUES (@PersonID);
END


EXEC sp_InsertManager 9;

--BRANCH
CREATE PROCEDURE sp_InsertBranch
    @BranchName nvarchar(255),
    @ManagerID int,
    @AddressID int
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Branch (BranchName, ManagerID, AddressID)
    VALUES (@BranchName, @ManagerID, @AddressID);
END

EXEC sp_InsertBranch 'SPIRIT',3,7;

--PAYMENTCARD
CREATE PROCEDURE sp_InsertPaymentCard
    @CardDetails char(16)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO PaymentCard (CardDetails)
    VALUES (@CardDetails);
END

EXEC sp_InsertPaymentCard 1357975335797315
--CUSTOMER
CREATE PROCEDURE sp_InsertCustomer
    @PersonID int,
    @AddressID int,
    @PaymentCardID int
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Customer (PersonID, AddressID, PaymentCardID)
    VALUES (@PersonID, @AddressID, @PaymentCardID);
END

EXEC sp_InsertCustomer 10,8,5;

--DELIVERYBOY
CREATE PROCEDURE sp_InsertDeliveryBoy
    @PersonID int,
    @BranchID int
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO DeliveryBoy (PersonID, BranchID)
    VALUES (@PersonID, @BranchID);
END

EXEC sp_InsertDeliveryBoy 11,3;

--CART
DROP PROCEDURE sp_InsertCart;

CREATE PROCEDURE sp_InsertCart
    @CartID INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CartValue DECIMAL(10, 2)

    SELECT @CartValue = ISNULL(SUM(ItemsValue), 0) 
    FROM CartItem 
    WHERE CartID = @CartID

    UPDATE Cart 
    SET CartValue = @CartValue
    WHERE CartID = @CartID;
END

EXEC sp_InsertCart @CartID = 2;

SELECT * FROM CARTITEM

SELECT * FROM CART

/*

CREATE PROCEDURE sp_InsertCart
    @CartID INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CartValue DECIMAL(10, 2)

    SELECT @CartValue = ISNULL(SUM(ItemsValue), 0) 
    FROM CartItem 
    WHERE CartID = @CartID

    IF NOT EXISTS (SELECT 1 FROM Cart WHERE CartID = @CartID)
    BEGIN
        INSERT INTO Cart (CartID, CartValue)
        VALUES (@CartID, 0)
    END

    UPDATE Cart
    SET CartValue = @CartValue
    WHERE CartID = @CartID;
END

EXEC sp_InsertCart @CartID = 3

*/

--Promotion
CREATE PROCEDURE sp_InsertPromotion
    @PromoCode nvarchar(20),
    @Discount decimal(2,2)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Promotion (PromoCode, Discount)
    VALUES (@PromoCode, @Discount);
END

EXEC sp_InsertPromotion '3',0.33;

--BranchPromo
CREATE PROCEDURE sp_InsertBranchPromo
    @BranchID INT,
    @PromoCode VARCHAR(20)
AS
BEGIN
    INSERT INTO BranchPromo (BranchID, PromoCode)
    VALUES (@BranchID, @PromoCode)
END

EXEC sp_InsertBranchPromo 3,'3';

--ProductCategory
CREATE PROCEDURE sp_InsertProductCategory
    @CategoryName VARCHAR(255)
AS
BEGIN
    INSERT INTO ProductCategory (CategoryName)
    VALUES (@CategoryName)
END

EXEC sp_InsertProductCategory 'Baby Care';

SELECT * FROM ProductCategory

--Product
CREATE PROCEDURE sp_InsertProduct
    @ProductName VARCHAR(255),
    @ProductPrice DECIMAL(10, 2),
    @CategoryID INT
AS
BEGIN
    INSERT INTO Product (ProductName, ProductPrice, CategoryID)
    VALUES (@ProductName, @ProductPrice, @CategoryID)
END

EXEC sp_InsertProduct 'JOHNSON & JOHNSON', 0.50, 3;


--BranchProduct
CREATE PROCEDURE sp_InsertBranchProduct
    @BranchID INT,
    @ProductID INT,
    @ProductQuantityStock INT
AS
BEGIN
    INSERT INTO BranchProduct (BranchID, ProductID, ProductQuantityStock)
    VALUES (@BranchID, @ProductID, @ProductQuantityStock)
END

EXEC sp_InsertBranchProduct 3,3,10;


--CartItem

CREATE PROCEDURE sp_InsertCartItem
    @CartID INT,
    @ProductID INT,
    @ItemQuantity INT
AS
BEGIN
    DECLARE @ProductPrice DECIMAL(10, 2)
    SELECT @ProductPrice = ProductPrice FROM Product WHERE ProductID = @ProductID
    
    DECLARE @ItemsValue DECIMAL(10, 2)
    SET @ItemsValue = @ItemQuantity * @ProductPrice
    
    INSERT INTO CartItem (CartID, ProductID, ItemQuantity, ItemsValue)
    VALUES (@CartID, @ProductID, @ItemQuantity, @ItemsValue)
END

EXEC sp_InsertCartItem 2, 3, 3;


--Bill

DROP PROCEDURE sp_InsertBill;
CREATE PROCEDURE sp_InsertBill
    @CartID INT,
    @DeliveryFee FLOAT,
    @PromoCode VARCHAR(20)
AS
BEGIN
    DECLARE @CartValue DECIMAL(10, 2), @Discount FLOAT, @TotalAmount DECIMAL(10, 2)

    SELECT @CartValue = ISNULL(CartValue, 0) 
    FROM Cart 
    WHERE CartID = @CartID

    SELECT @Discount = ISNULL(Discount, 0) 
    FROM Promotion 
    WHERE PromoCode = @PromoCode

    SET @TotalAmount = (@CartValue - (@CartValue * @Discount)) + @DeliveryFee

    INSERT INTO Bill (CartID, DeliveryFee, PromoCode, TotalAmount)
    VALUES (@CartID, @DeliveryFee, @PromoCode, @TotalAmount)
END;

EXEC sp_InsertBill 2,1,'3';

SELECT * FROM BILL;
SELECT * FROM CART;
SELECT * FROM CARTITEM;
SELECT * FROM PROMOTION;
--






