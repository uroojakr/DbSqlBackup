create database EMSDB;

use EMSDB;

create table Users (
	ID int primary key,
	UserName varchar(255),
	User_Email varchar(255),
	User_Password varchar(255),
	Usertype_ID int,
	foreign key (UserType_ID) references UserTypes(ID)
);

drop table Events;

create table Events (
	ID int primary key,
	Event_Title varchar(255),
	Event_Description varchar(255),
	Event_Date DATE,
	Event_Location varchar(255),
	OrganizerID int
);
create table Events(
	Event_Id int Identity(1,1) Primary Key,
	Title nvarchar(255),
	Description nvarchar(max),
	Date Datetime,
	Location nvarchar(255),
	User_Id int
);

create table Reviews (
	ID int primary key,
	Review_Comment nvarchar(255),
	Review_Rating int check (Review_Rating >=1 and Review_Rating <=5),
	UserID int,
	EventID int,
	VendorID int
);
select * from reviews;

-- Drop the existing primary key constraint
ALTER TABLE Users
DROP CONSTRAINT PK_Users_ID;


CREATE TABLE UserTypes (
    UserType_ID INT PRIMARY KEY,
    UserType VARCHAR(255)
);

ALTER TABLE UserTypes
MODIFY UserType_ID INT AUTO_INCREMENT PRIMARY KEY;

-- Insert data into the "UserTypes" table without specifying UserType_ID
INSERT INTO UserTypes (UserType)
VALUES ('Admin');

INSERT INTO UserTypes (UserType)
VALUES ('Regular');

INSERT INTO UserTypes (UserType)
VALUES ('Guest');

insert into Reviews()

alter table users
alter column UserType int;

-- Add a new column for the foreign key
ALTER TABLE Users
ADD UserType_ID INT;


select * from users;

-- Remove the old "UserType" column
ALTER TABLE Users
DROP COLUMN UserType;

-- Rename the "UserType_ID" column to "UserType"
ALTER TABLE Users
CHANGE COLUMN UserType_ID UserTypeID INT;

-- Add the foreign key constraint
ALTER TABLE Users
ADD FOREIGN KEY (UserTypeID) REFERENCES UserTypes(UserType_ID);





insert into Users(ID,UserName, User_Email, User_Password, UserType)
values('1','Urooj Akram','urooj@email.com','df3ds','1');

insert into Events(ID, Event_Title, Event_Description, Event_Date, Event_Location, OrganizerID)
values ('1', 'Cooking Show', 'cooking show for beginners', '10-19-2023 12:55:1', 'LHR', '2');

select * from Events;

select * from users;
select ID, UserName, UserType from users;


--delete
delete from users
where ID = 1;

-- fetching distinct commands
select distinct UserName from users;

--where clause 
select UserName,UserType 
from users
where UserType = 1;

select *
from users
where UserName = 'Urooj Akram';

select *
from users
order by UserType desc;

select * from users
where UserType='1' and UserName like 'S%';

select * from users
where UserType='1' or UserType='2'; 

select * from users
where  not UserType='0';


create table UserTypes(
ID int Identity(1,1) primary key,
UserType varchar(255) not null
);
insert into UserTypes(UserType)
values ('Admin')
insert into UserTypes(UserType)
values ('Organizer')
insert into UserTypes(UserType)
values ('Attendee')
select * from UserTypes;


select * from users
select * from userTypes;
select * from events;
select * from reviews;

drop table Users;


INSERT INTO Users (ID, UserName, User_Email, User_Password, Usertype_ID)
VALUES (3, 'Sobia Majeed', 'sobia@email.com', '3sas', 3);


insert into Reviews (ID,
	Review_Comment,
	Review_Rating,
	UserID,
	EventID,
	VendorID)
values ('2','Awesome event!','5','3','2','1');

CREATE TABLE Ticket (
    Id INT PRIMARY KEY,
    User_Id INT,
    Event_Id INT,
    CONSTRAINT FK_Ticket_Event FOREIGN KEY (Event_Id) REFERENCES Events(ID)
);

insert into Ticket (   Id,
    User_Id,
    Event_Id
)
values ('2','2','1');


create table vendor(
Id int primary key,
Vendor_Name varchar(255) not null,
Vendor_Description varchar(255) not null,
Vendor_ContactInformation varchar(255) not null
);

insert into vendor
(
Id,
Vendor_Name ,
Vendor_Description,
Vendor_ContactInformation
)
values ('2','Photography','Photography essentials for the events by professional cameraman','339-22844');


create table Vendor_Event(
Id int identity(1,1) primary key,
Vendor_Id int,
Event_Id int
foreign key (Vendor_Id) references vendor(Id),
foreign key (Event_Id) references Events(ID)
);

insert into Vendor_Event
(
Vendor_Id,
Event_Id
)
values (2,1)


select * from vendor
select * from Vendor_Event

CREATE PROCEDURE CRUD 
  @Event_Id int=NULL,
  @Title nvarchar(255)= null,
  @Description nvarchar(max)= null,
  @Date datetime = null,
  @Location nvarchar(255) = null,
  @User_Id int = 0,
  @choice varchar(100)
AS
BEGIN
	if @choice = 'Insert'
	begin 
		insert into Events ( Title, Description, Date, Location, User_Id)
		values (@Title, @Description, @Date, @Location, @User_Id)
	end
	if @choice = 'Update'
	begin 
		update Events set
		Title = @Title,
		Description = @Description,
		Date = @Date,
		Location = @Location,
		User_Id = @User_Id
	end
	if @choice = 'Delete'
	begin
		Delete FROM Events where Event_Id = @Event_Id
	end
END
GO

EXEC crud @Event_Id =5, @Title = 'Meena Bazaar', @Description = 'College Meena Bazaar with many
exciting fun games', @Date = '10-22-2023 11:22:23', @Location = 'Islamabad', @User_Id = 2, @choice = 'Update'

