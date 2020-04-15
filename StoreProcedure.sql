create proc spInsertStudent @json nvarchar(max)as begininsert into Students(StudentId,StudentName) select StudentId,StudentName from openjson(@json) with (StudentId int,StudentName varchar(40)) as json;endexec spInsertStudent [{"StudentId":1,"StudentName":"Bob"}];select * from Studentscreate proc spViewStudent @json nvarchar(max) output
as begin
set @json=(select * from students for json path)
end

declare @jsonoutput as nvarchar(max)
exec spViewStudent @json=@jsonoutput output
select @jsonoutput