USE AdventureWorks2016;
GO

CREATE VIEW Sales.NewCustomer
AS
SELECT CustomerID, FirstName, LastName 
FROM Sales.CustomerPII;
GO

INSERT INTO Sales.NewCustomer
VALUES
(100,'Test', 'T'),
(101, 'Test2', 'T2');
GO


SELECT * FROM Sales.NewCustomer 
ORDER BY CustomerID
