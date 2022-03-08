USE OP_CarRental;
GO

-- Create a function for calculating the total rental amount of
-- a booking where bookingID
-- is input parameter of the function.

CREATE FUNCTION [Function].CalculateTotalRentAmount(@BookingID INT)
    RETURNS MONEY
AS
BEGIN
    RETURN (SELECT SUM(RentalAmount)
            FROM Booking
                     JOIN BookingCar BC on Booking.ID = BC.BookingID
            WHERE BookingID = @BookingID)
END;
GO

SELECT  [Function].CalculateTotalRentAmount(1);
