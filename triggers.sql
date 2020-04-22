--after insert
create trigger addStudent on Registration after insert
as begin
       set nocount on;
       declare @uname int
       select @uname = inserted.uname
       from inserted
       insert into Students(StudentName) values(@uname)
end

insert into Registration(uname,email,password) values("john","john@gmail.com","john");
select * from Students

--after update
create trigger updateTrigger on Students after update 
as begin
	set nocount on;
	declare @studentName varchar(50)
	declare @studentID int
	select @studentID=inserted.studentID from inserted
	if update(StudentName)
	begin 
		update Registration set uname=@studentName where id=@studentID;
	end
end

--after delete
create trigger deleteTrigger on Students after delete
as begin
	set nocount on;
	declare @studentid int
    select @studentid = deleted.Studentid from deleted
	delete from Registration where id=@studentid;
end

--instead of delete
create trigger insteadeOfDeleteTrigger on Registration instead of delete 
as begin
	set nocount on;
	declare @id int 
	select @id=deleted.id from deleted
	update Registration set uname="RecordDeleted",email="RecordDeleted",password="RecordDelete" where id=@id;
end


--instead of update
create trigger insteadOfUpdateTrigger on dbo.vStudentRegister instead of update 
as begin
	set nocount on;
	declare @id int,@StudentName varchar(50),@email varchar(50)
	select @id=inserted.id,@StudentName=inserted.StudentName,@email=inserted.email from inserted
	update vStudentRegister set StudentName=@StudentName,email=@email where id=@id;
end