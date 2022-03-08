-- Create a trigger for automatically update the RentalAmount of a car in a booking when
-- the customer returns a car (i.e. when we update the ReturnDatetime of the car in the
-- booking). The trigger must update also the LocationID of the car as the
-- returnLocationID and the IsRent? status of the corresponding car as false.

USE OP_CarRental;
GO

CREATE TRIGGER UpdateRentalAmount
    ON BookingCar
    AFTER UPDATE
    AS
    IF (UPDATE(RealReturnDatetime))
        BEGIN
            UPDATE Car
            SET LocationID = (SELECT ReturnLocationID
                              from inserted,
                                   Booking
                              WHERE inserted.BookingID = Booking.ID),
                IsRent     = 0
            WHERE Car.Number IN (SELECT CarNumber FROM inserted)
        END;

GO

