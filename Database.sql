/*
Organisation(OrgID, OrganisationName)
PrimaryKey(OrgID)
MenuItem(ItemId, Description, ServesPerUnit, UnitPrice)
PrimaryKey(ItemId)
Client(ClientID, Name, Phone)
PrimaryKey(ClientID)
Order(ClientID, DateTimePlaced, DeliveryAddress)
PrimaryKey(DateTimePlaced)
ForeignKey(ClientID)
OrderLine(ItemId, ClientID, DateTimePlaced, Qty)
ForeignKey(ItemId, ClientID, DateTimePlaced)
*/
USE s103599187
IF OBJECT_ID('OrderLine') IS NOT NULL
    DROP TABLE OrderLine;
IF OBJECT_ID('Order') IS NOT NULL
    DROP TABLE "Order";
IF OBJECT_ID('MenuItem') IS NOT NULL
    DROP TABLE MenuItem;
IF OBJECT_ID('Client') IS NOT NULL
    DROP TABLE Client;
IF OBJECT_ID('Organisation') IS NOT NULL
    DROP TABLE Organisation;
GO

CREATE TABLE Organisation(
    OrgID NVARCHAR(4) PRIMARY KEY,
    OrganisationName NVARCHAR(200) NOT NULL UNIQUE
);
CREATE TABLE Client(
    ClientID INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL, 
    Phone NVARCHAR(15) NOT NULL UNIQUE,
    OrgID NVARCHAR(4) FOREIGN KEY REFERENCES Organisation,
);
CREATE TABLE MenuItem(
    ItemID int PRIMARY KEY,
    Description NVARCHAR(100) NOT NULL UNIQUE, 
    ServesPerUnit INT Not NULL CHECK(len(ServesPerUnit)>0),
    UnitPrice MONEY Not NULL
);
CREATE TABLE "Order"(              
    ClientID INT FOREIGN KEY REFERENCES Client,
    OrderDate Date ,
    DeliveryAddress NVARCHAR(MAX) Not Null,
    PRIMARY KEY(ClientID, OrderDate)
);
CREATE TABLE OrderLine(
    ItemID INT FOREIGN KEY REFERENCES MenuItem,
    ClientID INT,
    OrderDate DATE,
    Qty Int NOT Null CHECK(len(Qty)>0)
    Foreign Key (ClientID, OrderDate) REFERENCES "Order"

);
GO

Insert into Organisation(OrgID, OrganisationName) values ('DODG', 'Dod & Gy Widget Importers');
Insert into Organisation(OrgID, OrganisationName) values ('SWUT', 'Swinburne University of Technology');

Insert into Client(ClientID, Name, Phone, OrgID) values ('12','James Hallinan','(03)5555-1234','SWUT');
Insert into Client(ClientID, Name, Phone, OrgID) values ('15','Any Nguyen','(03)5555-2345','DODG');
Insert into Client(ClientID, Name, Phone, OrgID) values ('18','Karen Mok','(03)5555-3456','SWUT');
Insert into Client(ClientID, Name, Phone, OrgID) values ('21','Tim Baird','(03)5555-4567','DODG');
Insert into Client(ClientID, Name, Phone, OrgID) values ('71','Hamish Sansom','(03)5555-9999','DODG');

Insert into MenuItem(ItemId, Description, ServesPerUnit, UnitPrice) values ('3214','Tropical Pizza - Large','2','16');
Insert into MenuItem(ItemId, Description, ServesPerUnit, UnitPrice) values ('3216','Tropical Pizza - Small','1','12');
Insert into MenuItem(ItemId, Description, ServesPerUnit, UnitPrice) values ('3218','Tropical Pizza - Family','4','23');
Insert into MenuItem(ItemId, Description, ServesPerUnit, UnitPrice) values ('4325','Can - Coke Zero','1','2.5');
Insert into MenuItem(ItemId, Description, ServesPerUnit, UnitPrice) values ('4326','Can - Lemonade','1','2.5');
Insert into MenuItem(ItemId, Description, ServesPerUnit, UnitPrice) values ('4327','Can - Harden Up','1','7.5');

Insert into "Order"(ClientID, OrderDate, DeliveryAddress) values ('12', '2021-09-20', 'Room TB225 - SUT - 1 John Street, Hawthorn, 3122');
Insert into "Order"(ClientID, OrderDate, DeliveryAddress) values ('21', '2021-09-14', 'Room ATC009 - SUT - 1 John Street, Hawthorn, 3122');
Insert into "Order"(ClientID, OrderDate, DeliveryAddress) values ('21', '2021-09-27', 'Room TB225 - SUT - 1 John Street, Hawthorn, 3122');
Insert into "Order"(ClientID, OrderDate, DeliveryAddress) values ('15', '2021-09-20', 'The George - 1 John Street, Hawthorn, 3122');
Insert into "Order"(ClientID, OrderDate, DeliveryAddress) values ('18', '2021-09-30', 'Room TB225 - SUT - 1 John Street, Hawthorn, 3122');

INSERT INTO OrderLine(ItemId, ClientID, OrderDate, Qty) values ('3216', '12', '2021-09-20', '2')
INSERT INTO OrderLine(ItemId, ClientID, OrderDate, Qty) values ('4326', '12', '2021-09-20', '1')
INSERT INTO OrderLine(ItemId, ClientID, OrderDate, Qty) values ('3218', '21', '2021-09-14', '1')
INSERT INTO OrderLine(ItemId, ClientID, OrderDate, Qty) values ('3214', '21', '2021-09-14', '1')
INSERT INTO OrderLine(ItemId, ClientID, OrderDate, Qty) values ('4325', '21', '2021-09-14', '4')
INSERT INTO OrderLine(ItemId, ClientID, OrderDate, Qty) values ('4327', '21', '2021-09-14', '2')
INSERT INTO OrderLine(ItemId, ClientID, OrderDate, Qty) values ('3216', '21', '2021-09-27', '1')
INSERT INTO OrderLine(ItemId, ClientID, OrderDate, Qty) values ('4327', '21', '2021-09-27', '1')
INSERT INTO OrderLine(ItemId, ClientID, OrderDate, Qty) values ('3218', '21', '2021-09-27', '2')
INSERT INTO OrderLine(ItemId, ClientID, OrderDate, Qty) values ('3216', '15', '2021-09-20', '2')
INSERT INTO OrderLine(ItemId, ClientID, OrderDate, Qty) values ('4326', '15', '2021-09-20', '1')
INSERT INTO OrderLine(ItemId, ClientID, OrderDate, Qty) values ('3216', '18', '2021-09-30', '1')
INSERT INTO OrderLine(ItemId, ClientID, OrderDate, Qty) values ('4327', '18', '2021-09-30', '1')

--task 4 - incomplete
SELECT Name, OrderDate
FROM OrderLine
LEFT JOIN Client
ON OrderLine.ClientID = Client.ClientID

