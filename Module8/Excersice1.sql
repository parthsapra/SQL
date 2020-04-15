


create view Production.OnlineProducts as
select ProductID, Name, ProductNumber as [Product Number], coalesce(Color, 'N/A') as Color,
case DaysToManufacture
when 0 then 'In stock' 
when 1 then 'Overnight'
when 2 then '2 to 3 days delivery'
else 'Call us for a quote'
end as Availability,
Size, SizeUnitMeasureCode as [Unit of Measure],ListPrice as Price, Weight from Production.Product 
where SellEndDate is null and SellStartDate is not null;


create view Production.AvailableModels as
select p.ProductID as [Product ID], p.Name, pm.ProductModelID as [Product Model ID], pm.Name as [Product Model]
from Production.Product as p
inner join Production.ProductModel as pm
on p.ProductModelID = pm.ProductModelID
where p.SellEndDate is null and p.SellStartDate is not null;
