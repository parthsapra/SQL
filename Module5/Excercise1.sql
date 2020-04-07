USE AdventureWorks;

CREATE TABLE Sales.MediaOutlet (
MediaOoutletId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
MediaOoutletName NVARCHAR(40),
PrimaryContact NVARCHAR (50),
City NVARCHAR (50)
);


CREATE TABLE Sales.PrintMediaPlacement( 
PrintMediaPlacementId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
MediaOoutletId INT,
PlacementDate DATETIME,
PublicationDate DATETIME,
RelatedProductId INT,
PlacementCost DECIMAL(18,2)
);