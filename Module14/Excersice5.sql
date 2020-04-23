CREATE PROCEDURE Production.GetAvailableModelsAsXML
AS BEGIN
  SELECT p.ProductID,p.Name as ProductName,p.ListPrice,p.Color,p.SellStartDate,pm.ProductModelID,pm.Name as ProductModel
  FROM Production.Product AS p
  INNER JOIN Production.ProductModel AS pm ON p.ProductModelID = pm.ProductModelID 
  WHERE p.SellStartDate IS NOT NULL AND p.SellEndDate IS NULL
  ORDER BY p.SellStartDate, p.Name DESC FOR XML RAW('AvailableModel'), ROOT('AvailableModels');
END;



EXEC Production.GetAvailableModelsAsXML;



CREATE PROCEDURE Sales.UpdateSalesTerritoriesByXML (@SalespersonMods as xml)
AS BEGIN
	UPDATE  Sales.SalesPerson SET TerritoryID = updates.SalesTerritoryID
	FROM    Sales.SalesPerson as sp
	INNER JOIN (
		SELECT SalespersonMod.value('@BusinessEntityID','int') AS BusinessEntityID,
		SalespersonMod.value('(Mods/Mod/@SalesTerritoryID)[1]','int') AS SalesTerritoryID
		FROM @SalespersonMods.nodes('/SalespersonMods/SalespersonMod') as SalespersonMods(SalespersonMod)
	) AS updates ON sp.BusinessEntityID = updates.BusinessEntityID;
END;


DECLARE @xmlString nvarchar(2000);
SET @xmlString ='
<SalespersonMods>
     <SalespersonMod BusinessEntityID="311">
           <Mods>
               <Mod SalesTerritoryID="2"/>
           </Mods>
     </SalespersonMod>
      <SalespersonMod BusinessEntityID="215">
           <Mods>
                <Mod SalesTerritoryID="4"/>
           </Mods>
     </SalespersonMod>
</SalespersonMods>
)';
DECLARE @xmlDoc xml;
SET @xmlDoc = @xmlString;

EXEC Sales.UpdateSalesTerritoriesByXML @xmlDoc;
GO