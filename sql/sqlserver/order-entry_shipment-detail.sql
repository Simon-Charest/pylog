SELECT 'Paramed' AS DatabaseName
  -- Customer
  , RTRIM(s1.Customer) AS Customer
  -- Order
  , RTRIM(d1.OrdNumber) AS OrderNumber
  , CASE WHEN s1.OrdDate IS NULL THEN NULL ELSE TRY_CONVERT(DATE, CAST(CAST(s1.OrdDate AS INT) AS VARCHAR(8)), 112) END AS OrderDate
  -- Items
  , RTRIM(s1.Category) AS Category
  , RTRIM(s1.Item) AS Item
  , s1.QtySold AS QuantitySold
  , RTRIM(s1.PONumber) AS PurchaseOrderNumber
  , s1.FcstSales AS ForecastedSales
  , s1.FAmtSales AS ForecastedSalesAmount
  , s1.FAmtTran AS ForecastedTransactionAmount
  , d1.UnitPrice AS SalesPrice
  , d1.UnitCost
  , d1.MostRec AS MostRecentCost
  , d1.AvgCost AS AverageCost
  , d1.LastCost
  , d1.PriUntPrc AS PrimaryUnitPrice
  , d1.PriBasPrc AS PrimaryBasePrice
  , d1.QtyOrdered AS QuantityOrdered
  , d1.QtyShipped AS QuantityShipped
  , d1.QtyBackOrd AS QuantityBackOrdered
  -- Transaction
  , RTRIM(s1.TranNum) AS TransactionNumber
  , s1.TransSeq AS TransactionSequence
  , s1.[LineNo] AS LineNumber
  , CASE WHEN s1.TranDate IS NULL THEN NULL ELSE TRY_CONVERT(DATE, CAST(CAST(s1.TranDate AS INT) AS VARCHAR(8)), 112) END AS TransactionDate
  -- Shipment
  , RTRIM(s1.ShiNumber) AS ShipmentNumber
  , CASE WHEN s1.ShipDate IS NULL THEN NULL ELSE TRY_CONVERT(DATE, CAST(CAST(s1.ShipDate AS INT) AS VARCHAR(8)), 112) END AS ShipmentDate
FROM PARDAT.dbo.OEShDt AS s1 -- Order Entry - Shipment Detail
  LEFT JOIN PARDAT.dbo.OEShiD AS d1 ON d1.OrdNumber = s1.OrdNumber AND d1.Item = s1.Item -- Order Entry - Shipment Details
UNION
SELECT 'NFDC' AS DatabaseName
  -- Customer
  , RTRIM(s2.Customer) AS Customer
  -- Order
  , RTRIM(d2.OrdNumber) AS OrderNumber
  , CASE WHEN s2.OrdDate IS NULL THEN NULL ELSE TRY_CONVERT(DATE, CAST(CAST(s2.OrdDate AS INT) AS VARCHAR(8)), 112) END AS OrderDate
  -- Items
  , RTRIM(s2.Category) AS Category
  , RTRIM(s2.Item) AS Item
  , s2.QtySold AS QuantitySold
  , RTRIM(s2.PONumber) AS PurchaseOrderNumber
  , s2.FcstSales AS ForecastedSales
  , s2.FAmtSales AS ForecastedSalesAmount
  , s2.FAmtTran AS ForecastedTransactionAmount
  , d2.UnitPrice AS SalesPrice
  , d2.UnitCost
  , d2.MostRec AS MostRecentCost
  , d2.AvgCost AS AverageCost
  , d2.LastCost
  , d2.PriUntPrc AS PrimaryUnitPrice
  , d2.PriBasPrc AS PrimaryBasePrice
  , d2.QtyOrdered AS QuantityOrdered
  , d2.QtyShipped AS QuantityShipped
  , d2.QtyBackOrd AS QuantityBackOrdered
  -- Transaction
  , RTRIM(s2.TranNum) AS TransactionNumber
  , s2.TransSeq AS TransactionSequence
  , s2.[LineNo] AS LineNumber
  , CASE WHEN s2.TranDate IS NULL THEN NULL ELSE TRY_CONVERT(DATE, CAST(CAST(s2.TranDate AS INT) AS VARCHAR(8)), 112) END AS TransactionDate
  -- Shipment
  , RTRIM(s2.ShiNumber) AS ShipmentNumber
  , CASE WHEN s2.ShipDate IS NULL THEN NULL ELSE TRY_CONVERT(DATE, CAST(CAST(s2.ShipDate AS INT) AS VARCHAR(8)), 112) END AS ShipmentDate
FROM NFDDAT.dbo.OEShDt AS s2 -- Order Entry - Shipment Detail
  LEFT JOIN NFDDAT.dbo.OEShiD AS d2 ON d2.OrdNumber = s2.OrdNumber AND d2.Item = s2.Item -- Order Entry - Shipment Details
ORDER BY TransactionDate ASC
	, TransactionSequence ASC
	, LineNumber ASC
;
