

CREATE FUNCTION dbo.FormatPhoneNumber
( @PhoneNumber varchar(16))
RETURNS varchar(16) AS
BEGIN
	--DECLARE @digits nvarchar(16) = '';
	DECLARE @digits char(16) = @PhoneNumber;
	--DECLARE @character nchar(1);
	WHILE PATINDEX('%[^0-9]%',@PhoneNumber)>0
		SET @PhoneNumber=REPLACE(@PhoneNumber,SUBSTRING(@PhoneNumber,PATINDEX('%[^0-9]%',@PhoneNumber),1),'')


	SET @digits=@PhoneNumber;
	SET @PhoneNumber='('+SUBSTRING(@PhoneNumber,1,3)+')'+SUBSTRING(@PhoneNumber,4,3)+'-'+SUBSTRING(@PhoneNumber,7,4);
	RETURN @PhoneNumber;
END;


SELECT dbo.FormatPhoneNumber('948645138') as 'PhoneNumber';
SELECT dbo.FormatPhoneNumber('75-68432') as 'PhoneNumber';