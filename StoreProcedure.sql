create proc spInsertStudent @json nvarchar(max)
as begin
set @json=(select * from students for json path)
end

declare @jsonoutput as nvarchar(max)
exec spViewStudent @json=@jsonoutput output
select @jsonoutput