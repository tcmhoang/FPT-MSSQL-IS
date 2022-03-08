USE OP_CarRental;
GO

-- Create a stored procedure with corresponding booking number as input parameter
-- allowing to display the details of a booking including: the booking number, CarNumber,
-- CarManufacturer, CarModel, CarType. YearOfMake, PickupDateTime,
-- ReturnDateTime, RentalDurationByDay, RentalAmount. Note that the
-- ReturnDateTime is NULL if the car has not been returned.


CREATE FUNCTION [Function].GetDateRented(
    @From DATETIME,
    @To DATETIME
)
    RETURNS INT
AS
BEGIN
    DECLARE @Temp DATETIME;
    SET @Temp = DATEDIFF(DAY, @From, @To)
    IF (@Temp = 0)
        RETURN 1
    ELSE
        IF (@Temp < 0 OR @Temp = NULL) RETURN NULL
    RETURN (CONVERT(INT, @Temp));
END;
GO

CREATE PROC DisplayBookingDetails(
    @BookingNumber INT
)
AS
SELECT Booking.ID                                                       as BookingNumber,
       CarNumber,
       M.NAME                                                           as CarManufacture,
       CS.Model                                                         as CarModel,
       CT.Name                                                          as CarType,
       YearOfMake,
       RealPickupDatetime                                               as PickupDateTime,
       RealReturnDatetime                                               as ReturnDateTime,
       [Function].GetDateRented(RealPickupDatetime, RealReturnDatetime) as RentalDurationByDate,
       RentalAmount
FROM Booking
         JOIN BookingCar BC on Booking.ID = BC.BookingID
         JOIN Car C on BC.CarNumber = C.Number
         JOIN CarSubtype CS on C.CarSubTypeID = CS.ID
         JOIN CarType CT ON CS.CarTypeID = CT.ID
         JOIN Manufacturer M on CS.ManufacturerID = M.ID
WHERE Booking.ID = @BookingNumber;
GO

EXEC DisplayBookingDetails 2;

SELECT [Function].GetDateRented(GETDATE(), NULL);

