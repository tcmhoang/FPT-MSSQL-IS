-- Assume that the manager wants to analyze the total quantity of each car type rented by
-- customer type by year. Write a query which allows to analyze this information.

USE OP_CarRental;
GO

SELECT CarTypeID, COUNT(CarTypeID) AS Times
FROM Booking B,
     BookingCar BC,
     Car C,
     CarSubtype CS
WHERE YEAR(BookingDatetime) = 2022
  AND B.ID = BC.BookingID
  AND BC.CarNumber = C.Number
  AND C.CarSubTypeID = CS.CarTypeID
GROUP BY CarTypeID;