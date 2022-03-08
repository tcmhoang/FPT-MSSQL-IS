USE OP_CarRental;
GO

INSERT INTO District (District, City, Country)
VALUES (N'Wilson', 'NC', 'USA');
INSERT INTO District (District, City, Country)
VALUES ('Hoa Hai', N'Da Nang', 'Vietnam');
INSERT INTO District (District, City, Country)
VALUES ('Cambridge', 'MA', 'USA');

INSERT INTO Customer (Type, Phone, StreetAddress, DistrictsID)
VALUES ('Individual', '3214123213', '526 Brook Street', 1);
INSERT INTO Individual(ID, FirstName, LastName, Email)
VALUES (SCOPE_IDENTITY(), 'Conrad', 'Grimson', 'conradwg@gmail.com');
INSERT INTO Customer (Type, Phone, StreetAddress, DistrictsID)
VALUES ('Individual', '4212124901', '226 Willow Ave', 3);
INSERT INTO Individual(ID, FirstName, LastName, Email)
VALUES (SCOPE_IDENTITY(), 'Taimo', 'Travieso', 'taimot@gmail.com');
INSERT INTO Customer (Type, Phone, StreetAddress, DistrictsID)
VALUES ('Individual', '4038101366', '7521 Del Monte Dr', 1);
INSERT INTO Individual(ID, FirstName, LastName, Email)
VALUES (SCOPE_IDENTITY(), 'Marcel', 'Casale', 'marcelcs@gmail.com');


INSERT INTO Customer (Type, Phone, StreetAddress, DistrictsID)
VALUES ('Organization', '1648132299', 'Hoa Lac HighTech Park', 2);
INSERT INTO Organization (ID, Name, ContactName, ContactEmail)
VALUES (SCOPE_IDENTITY(), 'FPT University', 'Admin', 'daihocfpt@fpt.edu.vn');
INSERT INTO Customer (Type, Phone, StreetAddress, DistrictsID)
VALUES ('Organization', '4134401637', '2 Riverport St', 3);
INSERT INTO Organization (ID, Name, ContactName, ContactEmail)
VALUES (SCOPE_IDENTITY(), 'Monarch Solutions', 'Paul Serene', 'info@monarchsolutions.com');
INSERT INTO Customer (Type, Phone, StreetAddress, DistrictsID)
VALUES ('Organization', '7785849384', '733 Cherry Hill St', 3);
INSERT INTO Organization (ID, Name, ContactName, ContactEmail)
VALUES (SCOPE_IDENTITY(), 'JP Morgan', 'Lavonne Perez', 'admin@jpmor.com');

INSERT INTO Location (Name, StreetAddress, DistrictID)
VALUES ('Manuels', '617 Manor Station Dr', 1);
INSERT INTO Location (Name, StreetAddress, DistrictID)
VALUES ('Maisonneuve', '78 Shadow Brook St', 2);
INSERT INTO Location (Name, StreetAddress, DistrictID)
VALUES ('Marieville', '2 Wakehurst Lane', 3);

INSERT INTO Status (Name)
VALUES ('Booked');
INSERT INTO Status (Name)
VALUES ('Confirmed');
INSERT INTO Status (Name)
VALUES ('Deposited');
INSERT INTO Status (Name)
VALUES ('Paid');
INSERT INTO Status (Name)
VALUES ('Cancelled');

INSERT INTO Booking(CustomerID, ExpectedPickupDateTime, ExpectedReturnDateTime, PickupLocationID, ReturnLocationID,
                    BookingDatetime, StatusID)
VALUES (1, '20211230', '20220118', 1, 3, GETDATE(), 4);
INSERT INTO Booking(CustomerID, ExpectedPickupDateTime, ExpectedReturnDateTime, PickupLocationID, ReturnLocationID,
                    BookingDatetime, StatusID)
VALUES (3, GETDATE(), GETDATE(), 1, 3, GETDATE(), 4);
INSERT INTO Booking(CustomerID, ExpectedPickupDateTime, ExpectedReturnDateTime, PickupLocationID, ReturnLocationID,
                    BookingDatetime, StatusID)
VALUES (5, '20220101', '20220118', 1, 3, GETDATE(), 5);
INSERT INTO Booking(CustomerID, ExpectedPickupDateTime, ExpectedReturnDateTime, PickupLocationID, ReturnLocationID,
                    BookingDatetime, StatusID)
VALUES (5, '20220101', '20220118', 3, 3, GETDATE(), 5);

INSERT INTO CarType (Name, SeatCapacity)
VALUES ('SUV', 10);
INSERT INTO CarType (Name, SeatCapacity)
VALUES ('Coupe', 4);
INSERT INTO CarType (Name, SeatCapacity)
VALUES ('Truck', 2);


INSERT INTO Manufacturer (NAME)
VALUES ('Telsa');
INSERT INTO Manufacturer (NAME)
VALUES ('BMW');
INSERT INTO Manufacturer (NAME)
VALUES ('Ford');

INSERT INTO CarSubtype (CarTypeID, ManufacturerID, Model, YearOfMake, RentalPricePerDay, DepositAmount)
VALUES (1, 1, 'S', 2021, $500, $2000);
INSERT INTO CarSubtype (CarTypeID, ManufacturerID, Model, YearOfMake, RentalPricePerDay, DepositAmount)
VALUES (2, 2, 'X', 2020, $450, $1750);
INSERT INTO CarSubtype (CarTypeID, ManufacturerID, Model, YearOfMake, RentalPricePerDay, DepositAmount)
VALUES (1, 1, 'Y', 2022, $600, $1800);

INSERT INTO Color (NAME)
VALUES ('Iridium Silver');
INSERT INTO Color (NAME)
VALUES ('Onyx');
INSERT INTO Color (NAME)
VALUES ('Tasman Green');

INSERT INTO Car (CarSubTypeID, LocationID, ColorID)
VALUES (1, 1, 1);
INSERT INTO Car (CarSubTypeID, LocationID, ColorID, IsRent)
VALUES (2, 2, 2, 1);
INSERT INTO Car (CarSubTypeID, LocationID, ColorID)
VALUES (3, 3, 3);

INSERT INTO BookingCar (BookingID, CarNumber, RealPickupDatetime, RealReturnDatetime, RentalPricePerDay, DepositAmount,
                        RentalAmount)
VALUES (1, 1, '20211231', '20220117', $300, $2000, $5400);
INSERT INTO BookingCar (BookingID, CarNumber, RealPickupDatetime, RealReturnDatetime, RentalPricePerDay, DepositAmount,
                        RentalAmount)
VALUES (1, 2, '20211231', '20220117', $200, $2000, $3400);
INSERT INTO BookingCar (BookingID, CarNumber, RealPickupDatetime, RealReturnDatetime, RentalPricePerDay, DepositAmount,
                        RentalAmount)
VALUES (2, 2, GETDATE(), GETDATE(), $400, $2000, $400);
INSERT INTO BookingCar (BookingID, CarNumber, RealPickupDatetime, RealReturnDatetime, RentalPricePerDay, DepositAmount,
                        RentalAmount)
VALUES (3, 3, '20220101', '20220118', $300, $2000, $0);
INSERT INTO BookingCar (BookingID, CarNumber, RealPickupDatetime, RealReturnDatetime, RentalPricePerDay, DepositAmount,
                        RentalAmount)
VALUES (4, 3, '20220101', '20220118', $300, $2000, $0);



