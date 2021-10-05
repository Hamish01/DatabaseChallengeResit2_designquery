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
