-- Create a trigger for automatically update the IsRents? status of a car to true when
-- inserting this car into a booking.
USE OP_CarRental;
GO

CREATE TRIGGER UpdateIsRentWhenStatusToBooking
    ON Booking
    AFTER INSERT
    AS
    IF EXISTS((SELECT *
               FROM Status,
                    inserted
               WHERE Name = 'Booked'
                 AND Status.ID = inserted.StatusID))
        BEGIN
            UPDATE Car
            SET IsRent = 1
            WHERE Number IN (SELECT CarNumber
                             FROM BookingCar
                                      JOIN Booking B on B.ID = BookingCar.BookingID,
                                  inserted
                             WHERE BookingID = inserted.ID);
        END;
GO






