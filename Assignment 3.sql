select * from Jomato
--1. Create a stored procedure to display the restaurant name, type and cuisinewhere the table booking is not zero.
CREATE PROCEDURE GetRestaurantsWithBooking 
AS 
BEGIN 
	SELECT RestaurantName,
	RestaurantType, 
	CuisinesType 
	FROM Jomato 
	WHERE TableBooking > 0;
	END;
	
	EXEC GetRestaurantsWithBooking;

--2. Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’. Check the result
and rollback it
BEGIN TRANSACTION;
UPDATE Jomato
SET CuisinesType = 'Cafeteria'
WHERE CuisinesType = 'Cafe';

--To check 
SELECT * FROM Jomato 
WHERE CuisinesType = 'Cafeteria';

-- Rollback the transaction to undo the update
ROLLBACK TRANSACTION;

--3. Generate a row number column and find the top 5 areas with the highest ratingof restaurants.

select area, top 5 DENSE_RANK ()over (order by rating desc) as Row_Number
from Jomato;
--or
WITH cte AS (
    SELECT area, AVG(rating) AS avg_rating,
           ROW_NUMBER() OVER (ORDER BY AVG(rating) DESC) AS Row_Num
    FROM Jomato
    GROUP BY area
)
SELECT area, avg_rating
FROM cte
WHERE Row_Num <= 5;

--4. Use the while loop to display the 1 to 50.

Declare @Count INT
set @Count = 1
while (@Count<=50)
begin
	print @Count
	set @Count = @count+1
	end;

--5. Write a query to Create a Top rating view to store the generated top 5 highestrating of restaurants.

create view top_rating as
select top(5)DENSE_RANK ()over (order by rating desc) as Ranking,*
from Jomato; 
select * from top_rating

--or

CREATE VIEW Top_Rating AS
WITH cte AS (
    SELECT restaurantname, rating,
           ROW_NUMBER() OVER (ORDER BY rating DESC) AS RowNum
    FROM Jomato
)
SELECT restaurantname, rating
FROM cte
WHERE RowNum <= 5;

select*from top_rating

--6. Write a trigger that sends an email notification to the restaurant ownerwhenever a new record is inserted.

CREATE TRIGGER Email_Notification
ON Jomato
AFTER INSERT
AS
BEGIN
    DECLARE @restaurant_name NVARCHAR(255), @owner_email NVARCHAR(255);
    
    -- Get the restaurant name and owner's email from the inserted record
    SELECT @restaurant_name = RestaurantName, @owner_email = OwnerEmail
    FROM INSERTED;

    -- Send an email to the restaurant owner
    EXEC msdb.dbo.sp_send_dbmail
	@profile_name = 'dhanush',
	@recipients = 'dhanushriya123@gmail.com',
	@subject = 'New Record Inserted.',
	@body = 'A new record has been inserted.',
	@importance ='HIGH'
	end;
