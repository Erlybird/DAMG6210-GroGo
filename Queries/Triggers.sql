CREATE DATABASE GROUP14_DMDD_TEST;
USE GROUP14_DMDD_TEST;


--Trigger to update the ProductQuantityStock in the BranchProduct table when a new Order is placed

drop TRIGGER trg_UpdateProductQuantityStock;

CREATE TRIGGER trg_UpdateProductQuantityStock
ON OrderTable
AFTER INSERT
AS
BEGIN
    UPDATE BranchProduct
    SET ProductQuantityStock = ProductQuantityStock - CI.ItemQuantity
    FROM CartItem CI
    INNER JOIN BILL B ON B.CARTID = CI.CartID
    INNER JOIN ORDERTABLE OT ON B.BILLID = OT.BILLID
    INNER JOIN DELIVERYBOY DB ON DB.DELIVERYBOYID = OT.DELIVERYBOYID
    INNER JOIN BranchProduct BP ON BP.BranchID = DB.BranchID AND BP.ProductID = CI.ProductID;
END;

SELECT * FROM OrderTable;
SELECT * FROM CartItem;
SELECT * FROM BRANCHPRODUCT;
SELECT * FROM BILL;
SELECT * FROM DELIVERYBOY;


--Trigger to prevent deletion of a Customer if there are orders associated with the Customer
CREATE TRIGGER trg_PreventDeleteCustomer
ON Customer
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM OrderTable WHERE CustomerID IN (SELECT CustomerID FROM deleted))
    BEGIN
        RAISERROR ('Cannot delete Customer because there are associated Orders.', 16, 1);
    END
    ELSE
    BEGIN
        DELETE FROM Customer WHERE CustomerID IN (SELECT CustomerID FROM deleted);
    END;
END;

SELECT * FROM Customer;

DELETE FROM Customer WHERE CustomerID = 1

SELECT * FROM ORDERTABLE



--trigger for storing cardetails by encrpting them 

-- Create certificate to protect symmetric key
CREATE CERTIFICATE PaymentCardEncryptionCert
    WITH SUBJECT = 'PaymentCard Encryption Certificate',
    EXPIRY_DATE = '2026-10-31';

-- Create symmetric key to encrypt data
CREATE SYMMETRIC KEY PaymentCardEncryptionKey
    WITH ALGORITHM = AES_128
    ENCRYPTION BY CERTIFICATE PaymentCardEncryptionCert;
   
   
DROP TRIGGER tr_PaymentCard_EncryptCardDetails   

CREATE TRIGGER tr_PaymentCard_EncryptCardDetails
ON PaymentCard
AFTER INSERT
AS
BEGIN
    OPEN SYMMETRIC KEY PaymentCardEncryptionKey
    DECRYPTION BY CERTIFICATE PaymentCardEncryptionCert;

    UPDATE PaymentCard
    SET CardDetails = ENCRYPTBYKEY(KEY_GUID('PaymentCardEncryptionKey'), i.CardDetails)
    FROM inserted i
    WHERE PaymentCard.PaymentCardID = i.PaymentCardID;

    CLOSE SYMMETRIC KEY PaymentCardEncryptionKey;
END;


EXEC sp_InsertPaymentCard 1357975335797312

SELECT * FROM PaymentCard



--procedure to decrypt the carddeatils while retriving them
CREATE PROCEDURE sp_DecryptPaymentCard
    @PaymentCardID int
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @CardDetails varchar(255);
    
    SELECT @CardDetails = CardDetails
    FROM PaymentCard
    WHERE PaymentCardID = @PaymentCardID;

    OPEN SYMMETRIC KEY PaymentCardEncryptionKey
    DECRYPTION BY CERTIFICATE PaymentCardEncryptionCert;

    SELECT CONVERT(varchar(MAX), DECRYPTBYKEY(@CardDetails)) AS DecryptedCardDetails;

    CLOSE SYMMETRIC KEY PaymentCardEncryptionKey;
END;

exec sp_DecryptPaymentCard 1






