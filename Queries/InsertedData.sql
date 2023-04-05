--Insert Queries


--CREATE DATABASE GROUP14_DMDD_TEST;
USE GROUP14_DMDD_TEST;


--person
INSERT INTO Person (FirstName, LastName, Phone, Email, Gender)
VALUES
    ('John', 'Doe', '1234567890', 'john.doe@example.com', 'Male'),
    ('Jane', 'Doe', '2345678901', 'jane.doe@example.com', 'Female'),
    ('Bob', 'Smith', '3456789012', 'bob.smith@example.com', 'Male'),
    ('Sally', 'Jones', '4567890123', 'sally.jones@example.com', 'Female'),
    ('David', 'Lee', '5678901234', 'david.lee@example.com', 'Male'),
    ('Emily', 'Kim', '6789012345', 'emily.kim@example.com', 'Female'),
    ('Chris', 'Nguyen', '7890123456', 'chris.nguyen@example.com', 'Other'),
    ('Jamie', 'Garcia', '8901234567', 'jamie.garcia@example.com', 'Other');






--Address
INSERT INTO Address (AptNo, Street, City, State, Country, Zip) 
VALUES ('14', 'Riverway', 'Boston', 'Massachusetts', 'United States', '02115'),
       ('01', 'Roxbury', 'Boston', 'Massachusetts', 'United States', '02116'),
      ('36', 'South Huntington', 'Boston', 'Massachusetts', 'United States', '02115'),
       ('10', 'Brigham', 'Boston', 'Massachusetts', 'United States', '02115'),
      ('364', 'Longwood', 'Boston', 'Massachusetts', 'United States', '02115'),
       ('12', 'Nubian station', 'Boston', 'Massachusetts', 'United States', '02116');
      
      
--Manager
INSERT INTO Manager (PersonID)
VALUES
    (1),
    (2);
   


--Branch
INSERT INTO Branch (BranchName, ManagerID, AddressID)
VALUES 
('Huntington', 1, 1),
('Nubian', 2, 2);




--PaymentCard
insert into PaymentCard (CardDetails) values ('5048377028091382');
insert into PaymentCard (CardDetails) values ('5048378427383115');
insert into PaymentCard (CardDetails) values ('5049377028091382');
insert into PaymentCard (CardDetails) values ('5048378427383215');








-- Customer
INSERT INTO Customer( PersonID,AddressID,PaymentCardID) 
VALUES
 (5,3,1),
(6,4,2),
(7,5,3),
(8,6,4);


-- DeliveryBoy
INSERT INTO DeliveryBoy (PersonID,BranchID)
VALUES 
(3,1),
(4,2);


-- Cart
INSERT INTO Cart ( CartValue) 
Values
 (1.24),
(1.24);


-- Promotion
INSERT INTO Promotion (PromoCode,Discount)
VALUES 
('1',0.1),
('2',0.2);


/*Branch Promo*/   
INSERT INTO BranchPromo (BranchID, PromoCode)
VALUES (1, '1'), (2, '2');
/*Product Category*/
INSERT INTO ProductCategory (CategoryName)
VALUES ('Fruits'), ('Beverages');
/*Product*/
INSERT INTO Product (ProductName, ProductPrice, CategoryID) VALUES ('Apple', 0.99, 1), 
('Sprite', 0.25, 2);
/*BranchProduct*/
INSERT INTO BranchProduct (BranchID, ProductID, ProductQuantityStock)
VALUES (2, 1, 50),
(1, 2, 100);



--INSERT CartItem

INSERT INTO CartItem (CartID, ProductID, ItemQuantity, ItemsValue)
VALUES
 (1, 1, 3, 0.75),
 (1, 2, 2, 1.98),
 (2, 1, 4, 1.00),
 (2, 2, 3, 2.97);




--INSERT Bill


INSERT INTO Bill (CartID, DeliveryFee, PromoCode, TotalAmount)
VALUES
(1, 5.99, '1', 42.75),
(2, 0, '2', 14.99);




--INSERT Order


INSERT INTO OrderTable (OrderDate, BillID, Time, DeliveryBoyID, CustomerID)
VALUES
('2022-04-01', 1, '12:30:00', 1, 1),
('2022-04-02', 2, '19:45:00', 2, 2);




--INSERT DeliveryBoyRatings


INSERT INTO DeliveryBoyRatings (OrderID, DeliveryboyID, Rating)
VALUES
(1, 1, 4),
(2, 2, 5);


      
SELECT * FROM CartItem


