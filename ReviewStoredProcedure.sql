CREATE PROCEDURE ReviewCrud
	@Review_Id int = 0,
	@Comment nvarchar(255) = null,
	@Rating nvarchar(255) = null,
	@User_Id int = 0,
	@Event_Id int = 0,
	@choice varchar(100)

AS
BEGIN
	-- nocount on to prevent extra result sets from interefering with select statements

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

Exec ReviewCrud @Comment = 'The Event was very well prepared', @Rating = 4, @User_Id = 3, @Event_Id = 4,
@choice = 'Insert'