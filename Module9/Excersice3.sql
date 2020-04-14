USE MarketDev;
Go

ALTER PROCEDURE Reports.GetProductColors
WITH EXECUTE AS OWNER
AS
SET NOCOUNT ON;
BEGIN
	SELECT DISTINCT P.Color
	FROM Marketing.Product AS P
	WHERE P.Color IS NOT NULL
	ORDER BY P.Color;
END
GO

ALTER PROCEDURE Reports.GetProductsAndModels
WITH EXECUTE AS OWNER
AS
SET NOCOUNT ON;
BEGIN
	SELECT P.ProductID,
		   P.ProductName,
		   P.ProductNumber,
		   P.SellStartDate,
		   P.SellEndDate,
		   P.Color,
		   PM.ProductModelID,
		   COALESCE(ED.Description,ID.Description,P.ProductName) AS EnglishDescription,
		   COALESCE(FD.Description,ID.Description,P.ProductName) AS FrenchDescription,
		   COALESCE(CD.Description,ID.Description,P.ProductName) AS ChineseDescription
	FROM Marketing.Product AS P
	LEFT OUTER JOIN Marketing.ProductModel AS PM
	ON P.ProductModelID = PM.ProductModelID
	LEFT OUTER JOIN Marketing.ProductDescription AS ED
	ON PM.ProductModelID = ED.ProductModelID 
	AND ED.LanguageID = 'en'
	LEFT OUTER JOIN Marketing.ProductDescription AS FD
	ON PM.ProductModelID = FD.ProductModelID 
	AND FD.LanguageID = 'fr'
	LEFT OUTER JOIN Marketing.ProductDescription AS CD
	ON PM.ProductModelID = CD.ProductModelID 
	AND CD.LanguageID = 'zh-cht'
	LEFT OUTER JOIN Marketing.ProductDescription AS ID
	ON PM.ProductModelID = ID.ProductModelID 
	AND ID.LanguageID = ''
	ORDER BY P.ProductID,PM.ProductModelID;
END
GO


ALTER PROCEDURE Marketing.GetProductsByColor
@Color nvarchar(16)
WITH EXECUTE AS OWNER
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