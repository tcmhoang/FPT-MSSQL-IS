-- Create a stored procedure with booking number as an input parameter allowing to
-- display the general information of a booking including: booking number, customerID,
-- customerName, CartypeName, SeatCapacity, bookedQuantity, ExpectedPickupTime,
-- ExpectedReturnTime, PickupLocationName, PickupLocationAddress,
-- ReturnLocationName, ReturnLocationAddress; where CustomerName is the name of
-- the organization or the fullname (firstname + ‘ ‘ + lastname) of the individual customers.

USE OP_CarRental;
GO

CREATE PROC ShowBookingInformation(@ID INT)
AS

SELECT Booking.ID       as BookingNumber,
       CustomerID,
       CustomerName,
       CarTypeName,
       SeatCapacity,
       ExpectedPickupDateTime,
       ExpectedReturnDateTime,
       Count(*)         as BookedQuantity,
       L1.Name          as ReturnLocationName,
       L1.StreetAddress as ReturnLocationAddress,
       L2.Name          as PickupLocationName,
       L2.StreetAddress as PickupLocationAddress
FROM Booking
         JOIN
     (SELECT ID,
             CustomerName = CASE
                                WHEN Type = 'Individual' THEN (SELECT CONCAT(FirstName, ' ', LastName)
                                                               FROM Individual
                                                               WHERE Customer.ID = Individual.ID)
                                WHEN Type = 'Organization'
                                    THEN (SELECT Name FROM Organization WHERE Customer.ID = Organization.ID)
                                ELSE ''
                 END
      FROM Customer
     ) CustomerName ON CustomerID = CustomerName.ID
         JOIN
     (SELECT BookingID
           , CarNumber
           , CT.Name as CarTypeName
           , CT.SeatCapacity
      FROM BookingCar
               JOIN
           Car on CarNumber = Car.Number
               JOIN CarSubtype CS on Car.CarSubTypeID = CS.ID
               JOIN CarType CT on CT.ID = CS.CarTypeID
     ) TmpCar ON TmpCar.BookingID = Booking.ID,
     Location L1,
     Location L2
WHERE Booking.ID = @ID
  AND L1.ID = Booking.ReturnLocationID
  AND L2.ID = Booking.PickupLocationID
GROUP BY Booking.ID, CustomerID, CustomerName, CarTypeName, SeatCapacity, ExpectedPickupDateTime,
         ExpectedReturnDateTime, L1.StreetAddress, L1.Name, L2.Name, L2.StreetAddress;
GO

EXEC ShowBookingInformation 1;
