  
use InternetSales

alter database InternetSales
add filegroup SalesFileGroup contains MEMORY_OPTIMIZED_DATA;

alter database InternetSales   
add file(  
    NAME =N'Data',  
    FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Data.ndf' 
)  
to filegroup SalesFileGroup;  


create table dbo.ShoppingCart
(SessionID int not null ,
TimeAdded datetime not null ,
CustomerKey int not null ,
ProductKey int not null ,
Quantity int not null 
primary key nonclustered (SessionID, ProductKey)) 
with (MEMORY_OPTIMIZED = ON,  DURABILITY = SCHEMA_AND_DATA);


INSERT INTO ShoppingCart(SessionID,TimeAdded,CustomerKey,ProductKey,Quantity)VALUES (1,GETDATE(),2,3,1);
INSERT INTO ShoppingCart(SessionID,TimeAdded,CustomerKey,ProductKey,Quantity)VALUES (2,GETDATE(),2,4,3);