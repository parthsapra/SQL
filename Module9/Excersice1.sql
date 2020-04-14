USE MarketDev;
GO

CREATE PROCEDURE Reports.GetProductColors
AS
SET NOCOUNT ON;
BEGIN
	SELECT DISTINCT P.Color
	FROM Marketing.Product AS P
	WHERE P.Color IS NOT NULL
	ORDER BY P.Color;
END
GO

SELECT SCHEMA_NAME(schema_id) AS SchemaName,
       name AS ProcedureName
FROM sys.procedures;
GO

EXEC Reports.GetProductColors;
GO

CREATE PROCEDURE Reports.GetProductsAndModels
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

EXEC Reports.GetProductsAndModels;
GO