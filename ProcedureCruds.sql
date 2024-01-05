CREATE Procedure UserCrud
    @User_Id int = 0,
	@UserName nvarchar(255) = null,
	@Email nvarchar(255) = null,
	@Password nvarchar(255) = null,
	@choice varchar(100)= null

AS
BEGIN
	if @choice = 'Insert'
	begin
		insert into Users(UserName, Email, Password) values (@UserName , @Email, @Password)
	end

	if @choice = 'Update'
	begin
		update Users set
		UserName= @UserName, Email = @Email, Password = @Password where User_Id = @User_Id
	end

	if @choice = 'Delete'
	begin 
		delete From Users where User_Id = @User_Id
	end
END
Go

Exec UserCrud @UserName = 'Hina Khan', @Email = 'hina@gmail.com', @Password='4343', @choice = 'Insert'


CREATE PROCEDURE TicketCrud
	@Ticket_Id int =0,
	@User_Id int = 0,
	@Event_Id int = 0,
	@choice varchar(100) = null
AS
BEGIN
	if @choice = 'Insert'
		Begin
			insert into Ticket (User_Id, Event_Id) values (@User_Id, @Event_Id)
		end
	if @choice = 'Update'
		Begin
			update Ticket set
			User_Id = @User_Id, Event_Id = @Event_Id where Ticket_Id=@Ticket_Id
		end
	if @choice = 'delete'
		Begin
			Delete from Ticket where Ticket_Id = @Ticket_Id
		end
END
GO
Exec TicketCrud @User_Id = 3, @Event_Id = 3, @choice = 'Insert'

CREATE PROCEDURE VendorCrud
	@Vendor_Id int=0,
	@Name nvarchar(255)= null,
	@Description nvarchar(max) = null,
	@ContactInformation nvarchar(max) = null,
	@choice varchar(100) = null
AS
BEGIN
	if @choice = 'Insert'
		Begin
			insert into Vendor (Name, Description, ContactInformation) values (@Name, @Description, @ContactInformation)
		end
	if @choice = 'Update'
		Begin
			update Vendor set
			Name = @Name, Description = @Description, ContactInformation = @ContactInformation where Vendor_Id=@Vendor_Id
		end
	if @choice = 'delete'
		Begin
			Delete from Vendor where Vendor_Id = @Vendor_Id
		end
END
GO
Exec VendorCrud @Name = 'Jumbozilla', @Description ='Pizza Deliveries', @ContactInformation= '323-3232',@choice = 'Insert'


CREATE PROCEDURE VendorEventCrud
	@VendorEvent_Id int = 0,
	@Vendor_Id int = 0,
	@Event_Id int = 0,
	@choice varchar(100) = null
As
Begin
	if @choice = 'Insert'
		Begin
			insert into VendorEvent(Vendor_Id, Event_Id) values (@Vendor_Id, @Event_Id)
		end
	if @choice = 'Update'
		Begin
			Update VendorEvent set
			Vendor_Id = @Vendor_Id, Event_Id = @Event_Id where Id  = @VendorEvent_Id
		end
	if @choice = 'Delete'
		begin
			Delete from VendorEvent where Id = @VendorEvent_Id
		end
End
Go

Exec VendorEventCrud @Vendor_Id = '2', @Event_Id = '3', @choice = 'Insert'