/************************************************************************
 * Step 1 - Only execute one step at a time								*
 *																		*
 * Use the sp_spaceused function and note the size of the current table.*
 *																		*
 * e.g. data = 45,552 KB												*
 *																		*
 ************************************************************************/
SET STATISTICS TIME OFF
GO
USE AdventureWorksDW
GO

sp_spaceused 'dbo.FactProductInventory';
GO

-------- end of Step 1 --------

/************************************************************************
 * Step 2 - Only execute one step at a time								*
 *																		*
 * Execute the script below. Have Include Actual Execution Plan On      *
 * Note the execution time.	                                            *
 *																		*
 * e.g. CPU time = 2436 ms,  elapsed time = 4414 ms.					*
 ************************************************************************/

SET STATISTICS TIME ON
GO

SELECT p.EnglishProductName
		,d.WeekNumberOfYear
		,d.CalendarYear
		,AVG(fpi.UnitCost) AvgCost
		,SUM(fpi.UnitsOut) TotalUnits
		,MAX(fpi.UnitCost) HighestPrice
FROM dbo.FactProductInventory as fpi
INNER JOIN dbo.DimProduct as p ON fpi.ProductKey = p.ProductKey
INNER JOIN dbo.DimDate as d ON fpi.DateKey = d.DateKey
GROUP BY p.EnglishProductName,
		d.WeekNumberOfYear,
		d.CalendarYear
ORDER BY p.EnglishProductName,
		d.CalendarYear,
		d.WeekNumberOfYear;
GO
 
 -- CREATE NONCLUSTERED COLUMNSTORE INDEX

SET STATISTICS TIME ON
GO

CREATE NONCLUSTERED COLUMNSTORE INDEX NCI_FactProductInventory_UnitCost_UnitsOut ON FactProductInventory
(
	PRODUCTKEY,DATEKEY,UNITCOST,UNITSOUT
)
GO

-- WITHOUT NON CLUSTERED  INDEX EXECUTION TIME
/* SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.
(93744 rows affected)
 SQL Server Execution Times:
   CPU time = 2000 ms,  elapsed time = 3063 ms.
Completion time: 2020-04-09T12:06:43.9047565+05:30 */

 /*=============================== WITH NON CLUSTERED  INDEX EXECUTION TIME================================*/

/*SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.
(93744 rows affected)
 SQL Server Execution Times:
   CPU time = 672 ms,  elapsed time = 1936 ms.
Completion time: 2020-04-09T12:12:04.4160187+05:30 */
/* =============================================================*/

SET STATISTICS TIME ON
GO

SELECT SalesTerritoryRegion
		,p.EnglishProductName
		,d.WeekNumberOfYear
		,d.CalendarYear
		,SUM(fi.SalesAmount) Revenue
		,AVG(OrderQuantity) AverageQuantity
		,STDEV(UnitPrice) PriceStandardDeviation
		,SUM(TaxAmt) TotalTaxPayable
FROM dbo.FactInternetSales as fi
INNER JOIN dbo.DimProduct as p ON fi.ProductKey = p.ProductKey
INNER JOIN dbo.DimDate as d ON fi.OrderDate = d.FullDateAlternateKey
INNER JOIN dbo.DimSalesTerritory as st on fi.SalesTerritoryKey = st.SalesTerritoryKey
	AND fi.OrderDate BETWEEN '1/1/2010' AND '12/31/2010'
GROUP BY SalesTerritoryRegion, d.CalendarYear, d.WeekNumberOfYear, p.EnglishProductName
ORDER BY SalesTerritoryRegion, SUM(fi.SalesAmount) desc;

-- REMOVING THE CLUSTEREDSTORE INDEXES AND RECREATE THE KEYS ON THE TABLE
DROP INDEX [IX_FactIneternetSales_ShipDateKey] ON [dbo].[FactInternetSales];
DROP INDEX [IX_FactInternetSales_CurrencyKey] ON [dbo].[FactInternetSales];
DROP INDEX [IX_FactInternetSales_CustomerKey] ON [dbo].[FactInternetSales];
DROP INDEX [IX_FactInternetSales_DueDateKey] ON [dbo].[FactInternetSales];
DROP INDEX [IX_FactInternetSales_OrderDateKey] ON [dbo].[FactInternetSales];
DROP INDEX [IX_FactInternetSales_ProductKey] ON [dbo].[FactInternetSales];
DROP INDEX [IX_FactInternetSales_PromotionKey] ON [dbo].[FactInternetSales];
GO

/****** All foreign keys need to be removed ******/
ALTER TABLE [dbo].[FactInternetSales] DROP CONSTRAINT [FK_FactInternetSales_DimCustomer];
ALTER TABLE [dbo].[FactInternetSales] DROP CONSTRAINT [FK_FactInternetSales_DimCurrency];
ALTER TABLE [dbo].[FactInternetSales] DROP CONSTRAINT [FK_FactInternetSales_DimDate];
ALTER TABLE [dbo].[FactInternetSales] DROP CONSTRAINT [FK_FactInternetSales_DimDate1];
ALTER TABLE [dbo].[FactInternetSales] DROP CONSTRAINT [FK_FactInternetSales_DimDate2];
ALTER TABLE [dbo].[FactInternetSales] DROP CONSTRAINT [FK_FactInternetSales_DimProduct];
ALTER TABLE [dbo].[FactInternetSales] DROP CONSTRAINT [FK_FactInternetSales_DimPromotion];
ALTER TABLE [dbo].[FactInternetSales] DROP CONSTRAINT [FK_FactInternetSales_DimSalesTerritory];
ALTER TABLE [dbo].[FactInternetSalesReason] DROP CONSTRAINT [FK_FactInternetSalesReason_FactInternetSales]
ALTER TABLE [dbo].[FactInternetSales] DROP CONSTRAINT [PK_FactInternetSales_SalesOrderNumber_SalesOrderLineNumber]
GO
© 2020 Git