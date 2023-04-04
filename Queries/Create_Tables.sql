CREATE DATABASE GROUP14_DMDD_TEST;
USE GROUP14_DMDD_TEST;

--DeliveryBoyRatings
DROP TABLE DeliveryBoyRatings;

--Order Table
DROP TABLE OrderTable;

--Bill Table
DROP TABLE Bill;

--CartItem Table
DROP TABLE CartItem;

--BranchProduct Table
DROP TABLE BranchProduct;

--Product Table
DROP TABLE Product;

--ProductCategory Table
DROP TABLE ProductCategory;

--BranchPromo Table
DROP TABLE BranchPromo;

--Promotion Table
DROP TABLE Promotion;

--Cart Table
DROP TABLE Cart;

--DeliveryBoy Table
DROP TABLE DeliveryBoy;

--Customer Table
DROP TABLE Customer;

--PaymentCard Table
DROP TABLE PaymentCard;

--Branch Table
DROP TABLE Branch;

--Manager Table
DROP TABLE Manager;

--Address Table
DROP TABLE Address;

--Person Table
DROP TABLE Person;



--Person Table
CREATE TABLE Person (
    PersonID int identity PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Phone VARCHAR(10),
    Email VARCHAR(255),
    Gender VARCHAR(20),
    CONSTRAINT chk_PhoneLength CHECK (LEN(Phone) = 10),
    CONSTRAINT chk_EmailFormat CHECK (Email LIKE '%@%.%'),
    CONSTRAINT chk_GenderValues CHECK (Gender IN ('Male', 'Female', 'Other'))
);




--Address Table
CREATE TABLE Address (
    AddressID INT NOT NULL identity PRIMARY KEY,
    AptNo INT,
    Street VARCHAR(255) NOT NULL,
    City VARCHAR(255) NOT NULL,
    State VARCHAR(255) NOT NULL,
    Country VARCHAR(255) NOT NULL,
    Zip INT NOT NULL,
    CONSTRAINT chk_AptNo CHECK (AptNo > 0 OR AptNo IS NULL)
);


--Manager Table
CREATE TABLE Manager (
ManagerID INT NOT NULL identity,
PersonID INT NOT NULL,
PRIMARY KEY (ManagerID),
FOREIGN KEY (PersonID) REFERENCES Person(PersonID),
CONSTRAINT CK_Manager_ID CHECK (ManagerID >= 0)
);




--Branch Table
CREATE TABLE Branch (
BranchID INT NOT NULL identity,
BranchName VARCHAR(255) NOT NULL,
ManagerID INT NOT NULL,
AddressID INT NOT NULL,
PRIMARY KEY (BranchID),
FOREIGN KEY (ManagerID) REFERENCES Manager(ManagerID),
FOREIGN KEY (AddressID) REFERENCES Address(AddressID),
);


--PaymentCard Table
CREATE TABLE PaymentCard (
PaymentCardID INT NOT NULL identity,
CardDetails char(16) NOT NULL,
PRIMARY KEY (PaymentCardID)
);


--Customer Table
CREATE TABLE Customer (
CustomerID INT NOT NULL identity,
PersonID INT NOT NULL,
AddressID INT NOT NULL,
PaymentCardID INT,
PRIMARY KEY (CustomerID),
FOREIGN KEY (PersonID) REFERENCES Person(PersonID),
FOREIGN KEY (AddressID) REFERENCES Address(AddressID),
FOREIGN KEY (PaymentCardID) REFERENCES PaymentCard(PaymentCardID)
);


--DeliveryBoy Table
CREATE TABLE DeliveryBoy (
DeliveryboyID INT NOT NULL identity,
PersonID INT NOT NULL,
BranchID INT NOT NULL,
PRIMARY KEY (DeliveryboyID),
FOREIGN KEY (PersonID) REFERENCES Person(PersonID),
FOREIGN KEY (BranchID) REFERENCES Branch(BranchID),
CONSTRAINT CK_DeliveryBoy_ID CHECK (DeliveryboyID >= 0)
);








--Cart Table
CREATE TABLE Cart (
CartID INT NOT NULL identity,
CartValue DECIMAL(10,2) NOT NULL,
PRIMARY KEY (CartID),
CONSTRAINT CK_Cart_Value CHECK (CartValue >= 0)
);






--Promotion Table
CREATE TABLE Promotion (
PromoCode VARCHAR(20) NOT NULL,
Discount DECIMAL(2,2) NOT NULL,
PRIMARY KEY (PromoCode),
CONSTRAINT CK_Discount CHECK (Discount >= 0)
);


--BranchPromo Table
CREATE TABLE BranchPromo (
BranchID INT NOT NULL,
PromoCode VARCHAR(20) NOT NULL,
PRIMARY KEY (BranchID, PromoCode),
FOREIGN KEY (BranchID) REFERENCES Branch(BranchID),
FOREIGN KEY (PromoCode) REFERENCES Promotion(PromoCode)
);


--ProductCategory
CREATE TABLE ProductCategory (
CategoryID INT NOT NULL identity,
CategoryName VARCHAR(255) NOT NULL,
PRIMARY KEY (CategoryID)
);


--Product Table
CREATE TABLE Product (
ProductID INT NOT NULL identity,
ProductName VARCHAR(255) NOT NULL,
ProductPrice DECIMAL(10,2) NOT NULL,
CategoryID INT NOT NULL,
PRIMARY KEY (ProductID),
FOREIGN KEY (CategoryID) REFERENCES ProductCategory(CategoryID),
CONSTRAINT CK_Product_Price CHECK (ProductPrice >= 0)
);




--BranchProduct Table
CREATE TABLE BranchProduct (
BranchID INT NOT NULL,
ProductID INT NOT NULL,
ProductQuantityStock INT NOT NULL,
PRIMARY KEY (BranchID, ProductID),
FOREIGN KEY (BranchID) REFERENCES Branch(BranchID),
FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
CONSTRAINT CK_BranchProduct_ProductQuantityStock CHECK (ProductQuantityStock >= 0)
);




--CartItem Table
CREATE TABLE CartItem (
CartID INT NOT NULL,
ProductID INT NOT NULL,
ItemQuantity INT NOT NULL,
ItemsValue INT NOT NULL,
PRIMARY KEY (CartID, ProductID),
FOREIGN KEY (CartID) REFERENCES Cart(CartID),
FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
CONSTRAINT CK_CartItem_ItemQuantity CHECK (ItemQuantity > 0),
CONSTRAINT CK_CartItem_ItemsValue CHECK (ItemsValue > 0)
);




--Bill Table
CREATE TABLE Bill (
BillID INT NOT NULL identity,
CartID INT NOT NULL,
DeliveryFee FLOAT NOT NULL,
PromoCode VARCHAR(20) NOT NULL,
TotalAmount FLOAT NOT NULL,
PRIMARY KEY (BillID),
FOREIGN KEY (CartID) REFERENCES Cart(CartID),
FOREIGN KEY (PromoCode) REFERENCES Promotion(PromoCode),
CONSTRAINT CK_Bill_DeliveryFee CHECK (DeliveryFee >= 0),
CONSTRAINT CK_Bill_TotalAmount CHECK (TotalAmount >= 0)
);






--Order Table
CREATE TABLE OrderTable (
OrderID INT NOT NULL identity,
OrderDate DATE NOT NULL,
BillID INT NOT NULL,
Time TIME NOT NULL,
DeliveryBoyID INT NOT NULL,
CustomerID INT NOT NULL,
PRIMARY KEY (OrderID),
FOREIGN KEY (BillID) REFERENCES Bill(BillID),
FOREIGN KEY (DeliveryBoyID) REFERENCES DeliveryBoy(DeliveryboyID),
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
CONSTRAINT CK_OrderTable_Time CHECK (Time BETWEEN '00:00:00' AND '23:59:59'),
CONSTRAINT CK_OrderTable_OrderDate CHECK (OrderDate <= GETDATE())
);




--DeliveryBoyRatings
CREATE TABLE DeliveryBoyRatings (
RatingID INT NOT NULL identity,
OrderID INT NOT NULL,
DeliveryboyID INT NOT NULL,
Rating INT NOT NULL,
PRIMARY KEY (RatingID),
FOREIGN KEY (OrderID) REFERENCES OrderTable(OrderID),
FOREIGN KEY (DeliveryboyID) REFERENCES DeliveryBoy(DeliveryboyID),
CONSTRAINT CK_DeliveryBoyRatings_Rating
  CHECK (Rating >= 1 AND Rating <= 5)
);
