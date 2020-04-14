Use MarketDev;
GO

CREATE PROCEDURE Marketing.GetProductsByColor
@Color nvarchar(16)
AS
SET NOCOUNT ON;
BEGIN
	SELECT P.ProductID,
	P.ProductName,
	P.ListPrice AS Price,
	P.Color,
	P.Size,
	P.SizeUnitMeasureCode AS UnitOfMeasure
	FROM Marketing.Product AS P
	WHERE (P.Color = @Color) OR (P.Color IS NULL AND @Color IS NULL)
	ORDER BY ProductName;
END
GO

EXEC Marketing.GetProductsByColor 'Blue';
GO

EXEC Marketing.GetProductsByColor NULL;
GO