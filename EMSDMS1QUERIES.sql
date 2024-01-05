create database EMSDBS1;
use EMSDBS1;

CREATE TABLE UserTypes (
    UserType_ID INT PRIMARY KEY,
    UserType VARCHAR(255)
);

CREATE TABLE Users (
    User_Id INT PRIMARY KEY,
    UserName NVARCHAR(255) NOT NULL,
    Email NVARCHAR(255) NOT NULL,
    Password NVARCHAR(255) NOT NULL,
    UserType INT,  -- This assumes UserType is an INT, adjust the data type as needed
    
);

CREATE TABLE Vendor (
    Vendor_Id INT PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX) NOT NULL,
    ContactInformation NVARCHAR(MAX) NOT NULL
);


CREATE TABLE Events (
    Event_Id INT PRIMARY KEY,
    Title NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX) NOT NULL,
    Date DATETIME NOT NULL,
    Location NVARCHAR(255) NOT NULL,
    User_Id INT,
    FOREIGN KEY (User_Id) REFERENCES Users(User_Id) 
);

CREATE TABLE Review (
    Review_Id INT PRIMARY KEY,
    Comment NVARCHAR(MAX) NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    User_Id INT,
    Event_Id INT,   
    FOREIGN KEY (User_Id) REFERENCES Users(User_Id),
    FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id), 
);


CREATE TABLE Ticket (
    Ticket_Id INT PRIMARY KEY,
    User_Id INT,
    Event_Id INT,
    FOREIGN KEY (User_Id) REFERENCES Users(User_Id), 
    FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id) 
);


CREATE TABLE VendorEvent (
    Id INT PRIMARY KEY,
    Vendor_Id INT,
    Event_Id INT,
    FOREIGN KEY (Vendor_Id) REFERENCES Vendor(Vendor_Id),
    FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id) 
);

-- Inserting Data into Tables
INSERT INTO Users ( User_Id, UserName,Email,Password,UserType)
VALUES (3,'Sobia Majeed','sobia@gmail.com','3d35',3);

INSERT INTO Events ( Event_Id, Title,Description,Date, Location,User_Id)
VALUES (2,'Cooking Show','Kids Support Event','11-2-2023 12:55:12','Islamabad',1);

INSERT INTO Ticket (Ticket_Id,User_Id,Event_Id)
VALUES (2,1,2);

INSERT INTO Review ( Review_Id,Comment,Rating,User_Id,Event_Id)
VALUES (2,'Awesome event!',5,2,2);

--  Retreiving all
SELECT * FROM Users;
SELECT * FROM Events;
SELECT * FROM Ticket;
SELECT * FROM Review;
SELECT * FROM Vendor;
SELECT * FROM VendorEvent; 

-- Performing Query Operations 

-- Aggregating & left join

-- Basic Queries 
SELECT UserName, Email FROM Users;
SELECT Comment, Rating FROM Review;

--filtering and sorting 
SELECT * FROM Users
WHERE UserType='2'

SELECT * FROM Users
WHERE Email Like '%gmail.com%';

SELECT * FROM Review WHERE Rating= 5;

SELECT * FROM Events WHERE Date > '2023-01-01';

SELECT * FROM Users WHERE UserType <> 1 AND UserName LIKE 'S%';

SELECT * FROM Review ORDER BY Rating desc;

SELECT * FROM Events ORDER BY Date desc;

SELECT * FROM Review WHERE Event_Id = 1 ORDER BY Rating DESC;

-- aggregation

SELECT COUNT(*) FROM Users;

SELECT AVG(Rating) From Review;

SELECT MAX(Rating) FROM Review;

SELECT MAX(Rating), MIN(Rating) FROM Review;

SELECT USER_ID, COUNT(*) AS EventCount FROM Events GROUP BY User_Id;


-- JOINS

-- Select all events with their organizers' usernames from the Events and Users tables:

SELECT Events.*, Users.UserName AS OrganizerNames
FROM Events
INNER JOIN Users ON Events.User_Id = Users.User_Id;

-- Retrieve all reviews, including the usernames of the users who posted them, for a specific event:

SELECT Review.*, Users.UserName AS ReviewerName
FROM Review
INNER JOIN Users ON Review.User_Id = Users.User_Id
WHERE Event_Id = 2;

-- Find all events that vendors are participating in, including the vendor names:
SELECT Events.*, Vendor.Name AS VendorName
FROM Events
INNER JOIN VendorEvent ON Events.Event_Id = VendorEvent.Event_Id
INNER JOIN Vendor ON  VendorEvent.Vendor_Id = Vendor.Vendor_Id;

-- List users and their associated events, even if they have not organized any, with proper NULL handling:
SELECT Users.UserName, Events.Title 
FROM Users
LEFT JOIN Events ON Users.User_Id = Events.Event_Id;

-- SUBQUERIES AND COMPLEX QUERIES
 

-- Find users who have not posted any reviews in the Review table:
SELECT Users.*, Review.Comment
FROM Users
LEFT JOIN Review ON Users.User_Id = Review.Review_Id
WHERE Review.Comment IS NULL;

-- Identify users who have purchased tickets for multiple events:
SELECT User_Id
FROM TICKET
GROUP BY USER_ID
HAVING COUNT(DISTINCT Event_Id) > 1;

-- Calculate the total number of tickets sold for each event in the Events table:
SELECT Events.Event_Id, Events.Title,Count(Ticket.Ticket_Id) AS TicketsSold
FROM Events
LEFT JOIN Ticket ON Events.Event_Id = Ticket.Event_Id
GROUP BY Events.Event_Id, Events.Title; --grouping unique data together


-- Find the average number of tickets purchased per event.
SELECT Events.Event_Id ,AVG(Ticket.Ticket_Id) as AVGNoOfTickets
FROM Events
LEFT JOIN Ticket ON Events.Event_Id = Ticket.Event_Id
GROUP BY Events.Event_Id;

SELECT AVG(TicketCount) AS AvgTicketsPerEvent
FROM(
	SELECT Event_Id, COUNT(Ticket_Id) as TicketCount
	FROM Ticket
	GROUP BY Event_Id
) AS TicketsCounts;
--avg by ticket id

-- Calculate the total number of reviews for each event and order them from highest to lowest.
SELECT Event_ID,COUNT(Review_Id) AS ReviewsCount
FROM Review
GROUP BY Event_Id
ORDER BY ReviewsCount DESC;

-- Determine the event with the highest average review rating.
SELECT TOP 1 Event_Id, AVG(Rating) AS AvgRating
FROM Review
GROUP BY Event_Id
ORDER BY AvgRating DESC;

-- IMPORTANT QUERIES

-- Find events organized by users with the username 'something
SELECT Events.*
FROM Events
INNER JOIN Users ON Events.Event_Id = Users.User_Id
WHERE Users.UserName ='Urooj Akram';
 

--List users who have purchased tickets for an event with a specific title.
SELECT Users.*
FROM Users
INNER JOIN Ticket ON Users.User_Id = Ticket.User_Id
INNER JOIN Events ON Ticket.Event_Id = Events.Event_Id
WHERE Events.Title ='Cooking Show';

-- Identify events with no reviews.
SELECT Events.*
FROM Events
LEFT JOIN Review ON Events.Event_Id = Review.Review_Id
WHERE Review.Comment IS NULL; 

-- List vendors who have participated in more than one event.
SELECT Vendor.Name
FROM Vendor
INNER JOIN VendorEvent ON Vendor.Vendor_Id = VendorEvent.Vendor_Id
GROUP BY Vendor.Name
HAVING COUNT(VendorEvent.Event_Id) > 1;


-- Retrieve the usernames of users who have reviewed an event with a specific title.
SELECT Users.UserName, Review.Comment
FROM Users
INNER JOIN Review ON Users.User_Id = Review.Review_Id
INNER JOIN Events ON  Review.Event_Id = Events.Event_Id
WHERE Events.Title = 'Sports Event';

-- Calculate the total number of tickets purchased by each user.
SELECT Users.UserName, COUNT(Ticket.Ticket_Id) AS TicketCount
FROM Users
LEFT JOIN Ticket ON Users.User_Id = Ticket.User_Id
GROUP BY Users.UserName;

-- Find the event with the highest number of reviews.
SELECT Top 1 Events.Title, COUNT(Review.Review_Id) AS ReviewCount
FROM Events
LEFT JOIN Review ON Events.Event_Id = Review.Event_Id
GROUP BY Events.Title --can have more than 1 
ORDER BY ReviewCount DESC;

-- USING BETWEEN
SELECT Comment,Rating
FROM Review
WHERE Rating BETWEEN 4 and 5;

-- ALTER TABLE
ALTER TABLE TABLENAME
ADD COLUMNNAME DATATYPE;

ALTER TABLE TABLENAME
DROP COLUMN COLUMNNAME;

-- UPDATE, EDIT EXISTING TABLE
UPDATE TABLENAME
SET COLUMNNAME = 'SOMETHING', COLUMNNAME2 = 'SOMETHING'
WHERE ID= SOMETHING;

-- STORED PROCEDURES : Prepared SQL code that we can create and save so we can create again and again, acts as a function
SELECT * FROM Users;

create procedure AllUsers
AS
SELECT * FROM Users
GO;

exec AllUsers;

-- STORED PROCEDURE WITH SINGLE PARAMETER
create procedure AllUsers2 @UserName NVARCHAR(20)
AS
BEGIN
	SELECT * FROM Users WHERE UserName = @Username;
END;

EXEC AllUsers2 @UserName = 'Urooj Akram'

-- STORED PROCEDURE WITH DOUBLE PARAMETER
create procedure AllUsers3 @UserName NVARCHAR(20), @Email NVARCHAR(20)
AS
BEGIN
	SELECT * FROM Users WHERE UserName = @UserName AND Email = @Email;
END;

EXEC AllUsers3 @UserName = 'Urooj Akram', @Email = 'urooj@gmail.com';

BACKUP DATABASE EMSDBS1
TO DISK = 'D:\DATABSESQLEMSDBS1.bak';

-- CREATING VIEW
CREATE VIEW [Users Urooj] AS
SELECT UserName, Email
FROM Users
WHERE UserName='Urooj Akram';

SELECT * FROM [Users Urooj];

DROP VIEW [Users Urooj];