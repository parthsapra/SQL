

alter proc Reports.GetProductColors with execute as owner
as set nocount on;
begin
select distinct Color from
Marketing.Product where Color is not null
end


alter procedure Reports.GetProductsAndModels with execute as owner
as set nocount on;
begin
select p.ProductID,p.ProductName,p.ProductNumber,p.SellStartDate,p.SellEndDate,p.Color,pm.ProductModelID,
coalesce(ed.Description,id.Description,p.ProductName) as EnglishDescription,
coalesce(fd.Description,id.Description,p.ProductName) as FrenchDescription,
coalesce(cd.Description,id.Description,p.ProductName) as ChineseDescription
from Marketing.Product as p
left outer join Marketing.ProductModel as pm on p.ProductModelID=pm.ProductModelID 
left outer join Marketing.ProductDescription as ed on pm.ProductModelID=ed.ProductModelID and ed.LanguageID='en'
left outer join Marketing.ProductDescription as fd on pm.ProductModelID=fd.ProductModelID and fd.LanguageID='fr'
left outer join Marketing.ProductDescription as cd on pm.ProductModelID=cd.ProductModelID and cd.LanguageID='zh-cht'
left outer join Marketing.ProductDescription as id on pm.ProductModelID=id.ProductModelID and id.LanguageID=''
order by p.ProductID,pm.ProductModelID;
end

alter procedure Marketing.GetProductsByColor 
@color nvarchar(16) with execute as owner
as set nocount on;
begin
select p.ProductID,p.ProductName,p.ListPrice as Price, p.Color,p.Size,p.SizeUnitMeasureCode as UnitOfMeasure 
from Marketing.Product as p
where (p.Color=@color) or (p.Color is null and @color is null)
order by ProductName;
end
