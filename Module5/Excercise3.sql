USE AdventureWorks;


CREATE NONCLUSTERED INDEX NCI_PRINTMEDIAPLACEMENT 
ON Sales.PrintMediaPlacement (PublicationDate,PlacementCost)
INCLUDE (PrintMediaPlacementId,MediaOutletId,PlacementDate,RelatedProductId);
