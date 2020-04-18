CREATE TABLE Production.ProductAudit(
ProductID int NOT NULL,
UpdateTime datetime2(7) NOT NULL,
ModifyingUser nvarchar(100) NOT NULL,
OriginalListPrice money NULL,
NewListPrice money NULL
)


CREATE TRIGGER Production.TR_ProductListPrice_Update
ON Production.Product
AFTER UPDATE
AS BEGIN
	SET NOCOUNT ON;
	INSERT Production.ProductAudit(ProductID, UpdateTime, ModifyingUser, OriginalListPrice,NewListPrice)
	SELECT Inserted.ProductID,SYSDATETIME(),ORIGINAL_LOGIN(),deleted.ListPrice, inserted.ListPrice
	FROM deleted
	INNER JOIN inserted
	ON deleted.ProductID = inserted.ProductID
	WHERE deleted.ListPrice > 1000 OR inserted.ListPrice > 1000;
END;

SELECT * FROM Marketing.CampaignBalance;

EXEC Marketing.MoveCampaignBalance 2,3,20100;

EXEC Marketing.MoveCampaignBalance 5,3,2020;

SELECT * FROM Marketing.CampaignAudit;
