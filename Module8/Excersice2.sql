
create view Sales.NewCustomer as
select CustomerID, FirstName, LastName 
from Sales.CustomerPII;


insert into Sales.NewCustomer
values
(100,'Test', 'T'),
(101, 'Test2', 'T2');



select * from Sales.NewCustomer order by CustomerID
