create database EventDB;
use EventDB;

CREATE TABLE UserTypes (
    UserType_ID INT PRIMARY KEY,
    UserType VARCHAR(255)
);

CREATE TABLE Users (
    User_Id INT IDENTITY(1,1) PRIMARY KEY,
    UserName NVARCHAR(255) NOT NULL,
    Email NVARCHAR(255) NOT NULL,
    Password NVARCHAR(255) NOT NULL,
    --UserType INT,  -- This assumes UserType is an INT, adjust the data type as needed
    
);

CREATE TABLE Vendor (
    Vendor_Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX) NOT NULL,
    ContactInformation NVARCHAR(MAX) NOT NULL
);


CREATE TABLE Events (
    Event_Id INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX) NOT NULL,
    Date DATETIME NOT NULL,
    Location NVARCHAR(255) NOT NULL,
    User_Id INT,
    FOREIGN KEY (User_Id) REFERENCES Users(User_Id) 
);

CREATE TABLE Review (
    Review_Id INT IDENTITY(1,1) PRIMARY KEY,
    Comment NVARCHAR(MAX) NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    User_Id INT,
    Event_Id INT,   
    FOREIGN KEY (User_Id) REFERENCES Users(User_Id),
    FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id), 
);


CREATE TABLE Ticket (
    Ticket_Id INT IDENTITY(1,1) PRIMARY KEY,
    User_Id INT,
    Event_Id INT,
    FOREIGN KEY (User_Id) REFERENCES Users(User_Id), 
    FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id) 
);


CREATE TABLE VendorEvent (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Vendor_Id INT,
    Event_Id INT,
    FOREIGN KEY (Vendor_Id) REFERENCES Vendor(Vendor_Id),
    FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id) 
);

CREATE PROCEDURE ReviewCrud
	@Review_Id int = 0,
	@Comment nvarchar(255) = null,
	@Rating nvarchar(255) = null,
	@User_Id int = 0,
	@Event_Id int = 0,
	@choice varchar(100)
	 
AS
BEGIN
	

	if @choice = 'Insert'
	begin 
		insert into Review (Comment,Rating,User_Id,Event_Id) values (@Comment, @Rating, @User_Id, @Event_Id)
	end

	if @choice = 'Update'
	begin
		Update Review set
		Comment = @Comment, Rating = @Rating, User_Id = @User_Id where Review_Id = @Review_Id
	end

	if @choice = 'Delete'
	begin
		Delete From Review where Review_Id = @Review_Id
	end

END
GO

Exec ReviewCrud @Comment = 'The Event was very well prepared', @Rating = 4, @User_Id = 2, @Event_Id = 2,
@choice = 'Insert'