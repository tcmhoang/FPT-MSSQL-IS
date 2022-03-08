-- Create a database named OP_CarRental and tables corresponding to the schema of the
-- operational database that you’ve given in Lab 1 by using CREATE DATABASE and
-- CREATE TABLE commands in SQL Server so that:
-- - All ID has data type INT and are auto incremented.
-- - Using NVARCHAR for string attributes, Datetime for pickup datetime and return
-- datetime.
-- For the other questions in this lab, please add the RentalAmount attribute into the
-- corresponding table for storing the rental amount of each car in each booking

USE master;
DROP DATABASE IF EXISTS OP_CarRental;
CREATE DATABASE OP_CarRental;
USE OP_CarRental;
GO

DROP SCHEMA IF EXISTS [Function];
GO
CREATE SCHEMA [Function];
GO

CREATE FUNCTION [Function].IsValidDate(
    @date DATETIME
)
    RETURNS BIT
AS
BEGIN
    DECLARE @year INT;
    SET @year = YEAR(@date)
    IF (@year BETWEEN 1800 AND (YEAR(GETDATE()) + 1))
        RETURN 1;
    RETURN 0;
END;
GO



CREATE TABLE District
(
    ID       INT           NOT NULL IDENTITY (1,1) PRIMARY KEY,
    District NVARCHAR(255) NOT NULL,
    City     NVARCHAR(127) NOT NULL,
    Country  NVARCHAR(127) NOT NULL,
);



CREATE TABLE Customer
(
    ID            INT           NOT NULL IDENTITY (1,1) PRIMARY KEY,
    Type          VARCHAR(127)  NOT NULL,
    Phone         VARCHAR(10)   NOT NULL UNIQUE CHECK (Phone LIKE '%[0-9]%'),
    StreetAddress NVARCHAR(511) NOT NULL,
    DistrictsID   INT           NOT NULL FOREIGN KEY REFERENCES District (ID),
);



CREATE TABLE Individual
(
    ID        INT           NOT NULL PRIMARY KEY REFERENCES Customer (ID),
    FirstName NVARCHAR(127) NOT NULL,
    LastName  NVARCHAR(127) NOT NULL,
    Email     VARCHAR(255)  NOT NULL UNIQUE CHECK (Email LIKE '%_@__%.__%'),
    Gender    VARCHAR(1)    NOT NULL DEFAULT 'M' CHECK (Gender = 'M' OR Gender = 'F'),
);

CREATE TABLE Organization
(
    ID           INT           NOT NULL PRIMARY KEY REFERENCES Customer (ID),
    Name         NVARCHAR(255) NOT NULL,
    ContactName  NVARCHAR(255) NOT NULL,
    ContactEmail VARCHAR(255)  NOT NULL UNIQUE CHECK (ContactEmail LIKE '%_@__%.__%'),
);

CREATE TABLE Location
(
    ID            INT           NOT NULL IDENTITY (1,1) PRIMARY KEY,
    Name          NVARCHAR(255) NOT NULL,
    StreetAddress NVARCHAR(255) NOT NULL,
    DistrictID    INT           NOT NULL FOREIGN KEY REFERENCES District (ID),
);

CREATE TABLE Status
(
    ID   INT           NOT NULL IDENTITY (1,1) PRIMARY KEY,
    Name NVARCHAR(127) NOT NULL,
);



CREATE TABLE Booking
(
    ID                     INT      NOT NULL IDENTITY (1,1) PRIMARY KEY,
    CustomerID             INT      NOT NULL FOREIGN KEY REFERENCES Customer (ID),
    ExpectedPickupDateTime DATETIME NOT NULL CHECK ([Function].IsValidDate(ExpectedPickupDateTime) = 1),
    ExpectedReturnDateTime DATETIME NOT NULL CHECK ([Function].IsValidDate(ExpectedReturnDateTime) = 1),
    PickupLocationID       INT      NOT NULL FOREIGN KEY REFERENCES Location (ID),
    ReturnLocationID       INT      NOT NULL FOREIGN KEY REFERENCES Location (ID),
    BookingDatetime        DATETIME NOT NULL DEFAULT GETDATE(),
    StatusID               INT      NOT NULL FOREIGN KEY REFERENCES Status (ID),
    CONSTRAINT CK_ReturnDate CHECK (ExpectedPickupDateTime <= ExpectedReturnDateTime),

);

CREATE TABLE CarType
(
    ID           INT           NOT NULL IDENTITY (1,1) PRIMARY KEY,
    Name         NVARCHAR(255) NOT NULL,
    SeatCapacity NUMERIC(2, 0) NOT NULL CHECK (SeatCapacity >= 0 AND SeatCapacity <= 100),
);



CREATE TABLE Manufacturer
(
    ID   INT           NOT NULL IDENTITY (1,1) PRIMARY KEY,
    NAME NVARCHAR(127) NOT NULL,
);

CREATE TABLE CarSubtype
(
    ID                INT           NOT NULL IDENTITY (1,1) PRIMARY KEY,
    CarTypeID         INT           NOT NULL FOREIGN KEY REFERENCES CarType (ID),
    ManufacturerID    INT           NOT NULL FOREIGN KEY REFERENCES Manufacturer (ID),
    Model             NVARCHAR(127) NOT NULL,
    YearOfMake        NUMERIC(4, 0) NOT NULL CHECK (YearOfMake >= 1800 AND YearOfMake <= YEAR(GETDATE())),
    RentalPricePerDay SMALLMONEY    NOT NULL,
    DepositAmount     MONEY         NOT NULL,
);

CREATE TABLE Color
(
    ID   INT           NOT NULL IDENTITY (1,1) PRIMARY KEY,
    NAME NVARCHAR(255) NOT NULL UNIQUE,
);

CREATE TABLE Car
(
    Number       INT NOT NULL IDENTITY (1,1) PRIMARY KEY,
    CarSubTypeID INT NOT NULL FOREIGN KEY REFERENCES CarSubtype (ID),
    LocationID   INT NOT NULL FOREIGN KEY REFERENCES Location (ID),
    ColorID      INT NOT NULL FOREIGN KEY REFERENCES Color (ID),
    IsRent       BIT NOT NULL DEFAULT 0,
);


CREATE TABLE BookingCar
(
    BookingID          INT          NOT NULL FOREIGN KEY REFERENCES Booking (ID),
    CarNumber          INT          NOT NULL FOREIGN KEY REFERENCES Car (Number),
    RealPickupDatetime DATETIME SPARSE CHECK ([Function].IsValidDate(RealPickupDatetime) = 1),
    RealReturnDatetime DATETIME SPARSE CHECK ([Function].IsValidDate(RealReturnDatetime) = 1),
    RentalPricePerDay  SMALLMONEY   NOT NULL,
    DepositAmount      MONEY        NOT NULL,
    RentalAmount       MONEY SPARSE NULL,
    PRIMARY KEY (BookingID, CarNumber),
    CONSTRAINT CK_RealReturn CHECK (RealPickupDatetime <= BookingCar.RealReturnDatetime),
);
GO