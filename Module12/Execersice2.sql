CREATE PROCEDURE dbo.AddItemToCart
@sessionID INT, 
@timeAdded DATETIME, 
@customerKey INT, 
@productKey INT, 
@quantity INT
	WITH NATIVE_COMPILATION, SCHEMABINDING, EXECUTE AS OWNER
AS
BEGIN 
	ATOMIC WITH (TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE = 'us_english')  
	INSERT INTO dbo.ShoppingCart 
	(SessionID, TimeAdded, CustomerKey, ProductKey, Quantity)
	VALUES (@sessionID, @timeAdded, @customerKey, @productKey, @quantity)
END


CREATE PROCEDURE dbo.DeleteItemFromCart
	@sessionID INT, 
	@productKey INT
	WITH NATIVE_COMPILATION, SCHEMABINDING, EXECUTE AS OWNER
AS
BEGIN 
	ATOMIC WITH (TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE = 'us_english')  
	DELETE FROM dbo.ShoppingCart WHERE SessionID = @sessionID  AND ProductKey = @productKey;
END


CREATE PROCEDURE dbo.EmptyCart
	@sessionID INT
	WITH NATIVE_COMPILATION, SCHEMABINDING, EXECUTE AS OWNER
AS
BEGIN 
	ATOMIC WITH (TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE = 'us_english')  
	DELETE FROM dbo.ShoppingCart   WHERE SessionID = @sessionID
END

DECLARE @now DATETIME = GETDATE();

EXEC dbo.AddItemToCart	@sessionID = 1,	@timeAdded = @now,	@customerKey = 2,	@productKey = 3,	@quantity = 1;

EXEC dbo.AddItemToCart  @sessionID = 1,	@timeAdded = @now,	@customerKey = 2,	@productKey = 4,	@quantity = 1;

EXEC dbo.AddItemToCart	@sessionID = 3,	@timeAdded = @now,	@customerKey = 2,	@productKey = 3,	@quantity = 1;

EXEC dbo.AddItemToCart  @sessionID = 3,	@timeAdded = @now,	@customerKey = 2,	@productKey = 4,	@quantity = 1;


EXEC dbo.DeleteItemFromCart @sessionID = 3,@productKey = 4;


EXEC dbo.EmptyCart @sessionID = 3;