-- Assume that the manager wants to analyze the total quantity of each car type rented
-- from each city by year. Write a query which allows to analyze this information.

USE OP_CarRental;
GO

SELECT CarTypeID
     , D.City
     , COUNT(CarTypeID) AS Times
FROM Booking B,
     Location L,
     District D,
     BookingCar BC
        ,
     Car C
        ,
     CarSubtype CS
WHERE YEAR(BookingDatetime) = 2022
  AND B.PickupLocationID = L.ID
  AND L.DistrictID = D.ID
  AND B.ID = BC.BookingID
  AND BC.CarNumber = C.Number
  AND C.CarSubTypeID = CS.ID
GROUP BY CarTypeID, D.City;