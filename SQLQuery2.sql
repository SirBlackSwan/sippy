set ansi_padding on
go
set quoted_identifier on
go
set ansi_nulls on
go

create database [Pool2]
go

use [Pool2]
go

create table [dbo].[Users]
(
	[ID_User] [int] not null identity(1,1),
	[Login] [varchar] (20) not null,
	[Password] [varchar] (20) not null,
	[Access_rights] [int] not null
	constraint [PK_User] primary key clustered
	([ID_User] ASC) on [PRIMARY] 
)
go

create table [dbo].[Positions]
(
	[ID_Position] [int] not null identity(1,1),
	[Position_name] [varchar] (20) not null,
	[Salary] [int] not null
	constraint [PK_Position] primary key clustered
	([ID_Position] ASC) on [PRIMARY] 
)
go


create table [dbo].[Regular_clients]
(
	[ID_Regular_client] [int] not null identity(1,1),
	[Discount] [int] not null
	constraint [PK_Regular_client] primary key clustered
	([ID_Regular_client] ASC) on [PRIMARY] 
)
go

create table [dbo].[Visit_statuses]
(
	[ID_Visit_status] [int] not null identity(1,1),
	[Status] [varchar] (20) not null
	constraint [PK_Visit_status] primary key clustered
	([ID_Visit_status] ASC) on [PRIMARY]
)
go

create table [dbo].[Data]
(
	[ID_Data] [int] not null identity(1,1),
	[Last_name] [varchar] (30) not null,
	[First_name] [varchar] (30) not null,
	[Middle_name] [varchar] (30) not null,
	[Address] [varchar] (60) not null,
	[Phone_num] [varchar] (12) not null
	constraint [PK_Data] primary key clustered
	([ID_Data] ASC) on [PRIMARY]
)
go

create table [dbo].[Employees]
(
	[ID_Employee] [int] not null identity(1,1),
	[Data_ID] [int] not null,
	[Position_ID] [int] not null,
	[User_ID] [int] not null
	constraint [PK_Employee] primary key clustered
	([ID_Employee] ASC) on [PRIMARY],
	constraint [FK_Data_Employee] foreign key ([Data_ID])
	references [dbo].[Data] ([ID_Data]),
	constraint [FK_Position_Employee] foreign key ([Position_ID])
	references [dbo].[Positions] ([ID_Position]),
	constraint [FK_User_Employee] foreign key ([User_ID])
	references [dbo].[Users] ([ID_User])
)
go

create table [dbo].[Pretenders]
(
	[ID_Pretender] [int] not null identity(1,1),
	[Data_ID] [int] not null
	constraint [PK_Pretender] primary key clustered
	([ID_Pretender] ASC) on [PRIMARY],
	constraint [FK_Data_Pretender] foreign key ([Data_ID])
	references [dbo].[Data] ([ID_Data])
)
go

create table [dbo].[Clients]
(
	[ID_Client] [int] not null identity(1,1),
	[Data_ID] [int] not null,
	[Client_gender] [varchar] (1) not null,
	[Client_visitnum] [int] not null,
	[Regular_client_ID] [int] not null,
	[User_ID] [int] not null
	constraint [PK_Client] primary key clustered
	([ID_Client] ASC) on [PRIMARY],
	constraint [FK_Data_Client] foreign key ([Data_ID])
	references [dbo].[Data] ([ID_Data]),
	constraint [FK_Regular_client_Client] foreign key ([Regular_client_ID])
	references [dbo].[Regular_clients] ([ID_Regular_client]),
	constraint [FK_User_Client] foreign key ([User_ID])
	references [dbo].[Users] ([ID_User])
)
go

create table [dbo].[Visits]
(
	[ID_Visit] [int] not null identity(1,1),
	[Visit_date] [varchar] (10) not null,
	[Visit_price] [int] not null,
	[Visit_time] [int] not null,
	[Visit_status_ID] [int] not null,
	[Client_ID] [int] not null
	constraint [PK_Visits] primary key clustered
	([ID_Visit] ASC) on [PRIMARY],
	constraint [FK_Visit_status_Visit] foreign key ([Visit_status_ID])
	references [dbo].[Visit_statuses] ([ID_Visit_status]),
	constraint [FK_Clients_Visit] foreign key ([Client_ID])
	references [dbo].[Clients] ([ID_Client])
)
go

--опнжедспш

create procedure [dbo].[Users_Insert]
@Login [varchar] (20), @Password [varchar] (20), @Access_rights [int]
as
	insert into [dbo].[Users] (Login, Password, Access_rights)
	values (@Login, @Password, @Access_rights)
go

create procedure [dbo].[Users_Update]
@ID_User [int], @Login [varchar] (20), @Password [varchar] (20), @Access_rights [int]
as
	update [dbo].[Users] set 
	Login=@Login,
	Password=@Password,
	Access_rights=@Access_rights
	where
	ID_User=@ID_User
go

create procedure [dbo].[Users_Delete]
@ID_User [int]
as
	delete from [dbo].[Users]
	where
	ID_User=@ID_User
go

create procedure [dbo].[Positions_Insert]
@Position_name [varchar] (20), @Salary [int]
as
	insert into [dbo].[Positions] (Position_name, Salary)
	values (@Position_name, @Salary)
go

create procedure [dbo].[Positions_Update]
@ID_Position [int], @Position_name [varchar] (20), @Salary [int]
as
	update [dbo].[Positions] set 
	Position_name=@Position_name,
	Salary=@Salary
	where
	ID_Position=@ID_Position
go

create procedure [dbo].[Positions_Delete]
@ID_Position [int]
as
	delete from [dbo].[Positions]
	where
	ID_Position=@ID_Position
go

create procedure [dbo].[Regular_clients_Insert]
@Discount [int]
as
	insert into [dbo].[Regular_clients] (Discount)
	values (@Discount)
go

create procedure [dbo].[Regular_clients_Update]
@ID_Regular_client [int], @Discount [int]
as
	update [dbo].[Regular_clients] set 
	Discount=@Discount
	where
	ID_Regular_client=@ID_Regular_client
go

create procedure [dbo].[Regular_clients_Delete]
@ID_Regular_client [int]
as
	delete from [dbo].[Regular_clients]
	where
	ID_Regular_client=@ID_Regular_client
go

create procedure [dbo].[Data_Insert]
@Last_name [varchar] (30), @First_name [varchar] (30), @Middle_name [varchar] (30), 
@Address [varchar] (60), @Phone_num [varchar] (12)
as
	insert into [dbo].[Data] (Last_name, First_name, Middle_name, Address, Phone_num)
	values (@Last_name, @First_name, @Middle_name, @Address, @Phone_num)
go

create procedure [dbo].[Data_Update]
@ID_Data [int], @Last_name [varchar] (30), @First_name [varchar] (30), @Middle_name [varchar] (30), 
@Address [varchar] (60), @Phone_num [varchar] (12)
as
	update [dbo].[Data] set 
	Last_name=@Last_name, 
	First_name=@First_name, 
	Middle_name=@Middle_name, 
	Address=@Address,
	Phone_num=@Phone_num
	where
	ID_Data=@ID_Data
go

create procedure [dbo].[Data_Delete]
@ID_Data [int]
as
	delete from [dbo].[Data]
	where
	ID_Data=@ID_Data
go

create procedure [dbo].[Visit_statuses_Insert]
@Status [varchar] (20)
as
	insert into [dbo].[Visit_statuses] (Status)
	values (@Status)
go

create procedure [dbo].[Visit_statuses_Update]
@ID_Visit_status [int], @Status [varchar] (20)
as
	update [dbo].[Visit_statuses] set 
	Status=@Status
	where
	ID_Visit_status=@ID_Visit_status
go

create procedure [dbo].[Visit_stasuses_Delete]
@ID_Visit_status [int]
as
	delete from [dbo].[Visit_statuses]
	where
	ID_Visit_status=@ID_Visit_status
go

create procedure [dbo].[Employees_Insert]
@Data_ID [int], @Position_ID [int], @User_ID [int]
as
	insert into [dbo].[Employees] (Data_ID, Position_ID, User_ID)
	values (@Data_ID, @Position_ID, @User_ID)
go

create procedure [dbo].[Employees_Update]
@ID_Employee [int], @Data_ID [int], @Position_ID [int], @User_ID [int]
as
	update [dbo].[Employees] set 
	Data_ID=@Data_ID,
	Position_ID=@Position_ID,
	User_ID=@User_ID
	where
	ID_Employee=@ID_Employee
go

create procedure [dbo].[Employees_Delete]
@ID_Employee [int]
as
	delete from [dbo].[Employees]
	where
	ID_Employee=@ID_Employee
go

create procedure [dbo].[Pretenders_Insert]
@Data_ID [int]
as
	insert into [dbo].[Pretenders] (Data_ID) values (@Data_ID)
go

create procedure [dbo].[Pretenders_Update]
@ID_Pretender [int], @Data_ID [int]
as
	update [dbo].[Pretenders] set 
	Data_ID=@Data_ID
	where
	ID_Pretender=@ID_Pretender
go

create procedure [dbo].[Pretenders_Delete]
@ID_Pretender [int]
as
	delete from [dbo].[Pretenders]
	where
	ID_Pretender=@ID_Pretender
go

create procedure [dbo].[Clients_Insert]
@Data_ID [int], @Client_gender [varchar] (1), @Client_visitnum [int], @Regular_client_ID [int], 
@User_ID [int]
as
	insert into [dbo].[Clients] (Data_ID, 
	Client_gender, Client_visitnum, Regular_client_ID, User_ID)
	values (@Data_ID, @Client_gender, @Client_visitnum, 
	@Regular_client_ID, @User_ID)
go

create procedure [dbo].[Clients_Update]
@ID_Client [int], @Data_ID [int], @Client_gender [varchar] (1), @Client_visitnum [int], 
@Regular_client_ID [int], @User_ID [int]
as
	update [dbo].[Clients] set 
	Data_ID=@Data_ID,
	Client_gender=@Client_gender,
	Client_visitnum=@Client_visitnum,
	Regular_client_ID=@Regular_client_ID,
	User_ID=@User_ID
	where
	ID_Client=@ID_Client
go

create procedure [dbo].[Clients_Delete]
@ID_Client [int]
as
	delete from [dbo].[Clients]
	where
	ID_Client=@ID_Client
go

create procedure [dbo].[Visits_Insert]
@Visit_date [varchar] (10), @Visit_price [int], @Visit_time [int], @Client_ID [int], @Visit_status_ID [int]
as
	insert into [dbo].[Visits] (Visit_date, Visit_price, Visit_time,Client_ID, Visit_status_ID)
	values (@Visit_date, @Visit_price, @Visit_time, @Client_ID, @Visit_status_ID)
go

create procedure [dbo].[Visits_Update]
@ID_Visit [int], @Visit_date [varchar] (10), @Visit_price [int], @Visit_time [int], 
@Client_ID [int], @Visit_status_ID [int]
as
	update [dbo].[Visits] set 
	Visit_date=@Visit_date,
	Visit_price=@Visit_price,
	Visit_time=@Visit_time,
	Client_ID=@Client_ID,
	Visit_status_ID=@Visit_status_ID
	where
	ID_Visit=@ID_Visit
go

create procedure [dbo].[Visits_Delete]
@ID_Visit [int]
as
	delete from [dbo].[Visits]
	where
	ID_Visit=@ID_Visit
go

create procedure [dbo].[Registration] (@Login [varchar] (20), @Password [varchar] (20), 
@Access_rights [int]) 
as 
begin 
if ((select count([Login]) from [dbo].[Users] where [Login] = @Login) > 0) 
select 0 
else 
begin 
insert into [dbo].[Users] ([Login],[Password],[Access_rights]) 
values(@Login, @Password, @Access_rights) 
select 1 
end 
end

create function [dbo].[Authorization](@Login varchar(20), @Password varchar(20)) returns int 
as 
begin 
	declare @index int = 
	(select [ID_User] from [dbo].[Users] where [Login] = @Login and [Password] = @Password) 
	return @index 
end
go