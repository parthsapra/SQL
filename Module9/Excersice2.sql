Use MarketDev;
GO

create procedure Marketing.GetProductsByColor 
@color nvarchar(16)
as set nocount on;
begin
select p.ProductID,p.ProductName,p.ListPrice as Price, p.Color,p.Size,p.SizeUnitMeasureCode as UnitOfMeasure 
from Marketing.Product as p
where (p.Color=@color) or (p.Color is null and @color is null)
order by ProductName;
end

EXEC Marketing.GetProductsByColor 'Blue';


EXEC Marketing.GetProductsByColor NULL;
