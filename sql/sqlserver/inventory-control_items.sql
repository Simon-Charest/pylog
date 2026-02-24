SELECT 'Paramed' AS DatabaseName
    , i1.AudtUser
    , i1.PickingSeq
    , i1.Category
    , i1.ItemNo
    , i1.[Desc]
    , l1.Location
    , l1.QtyOnHand
    , l1.QtyOnOrder
    , m1.VendItem
    , CASE WHEN i1.DateLastMn = 0 THEN NULL ELSE FORMAT(CAST(CAST(i1.DateLastMn AS VARCHAR) AS DATE), 'yyyy-MM-dd') END AS DateLastMn
    , CASE WHEN i1.AudtDate = 0 THEN NULL ELSE FORMAT(CAST(CAST(i1.AudtDate AS VARCHAR) AS DATE), 'yyyy-MM-dd') END AS AudtDate
	, CASE WHEN l1.LastRcptDt = 0 THEN NULL ELSE FORMAT(CAST(CAST(l1.LastRcptDt AS VARCHAR) AS DATE), 'yyyy-MM-dd') END AS LastRcptDt
	, CASE WHEN l1.LastShipDt = 0 THEN NULL ELSE FORMAT(CAST(CAST(l1.LastShipDt AS VARCHAR) AS DATE), 'yyyy-MM-dd') END AS LastShipDt
	, CASE WHEN l1.LastUsed = 0 THEN NULL ELSE FORMAT(CAST(CAST(l1.LastUsed AS VARCHAR) AS DATE), 'yyyy-MM-dd') END AS LastUsed 
    , l1.TotalCost
    , l1.CostOffset
    , l1.RecentCost
    , l1.Cost1
    , l1.Cost2
    , l1.LastCost
    , d1.PriceList
    , d1.UnitPrice
    FROM PARDAT.dbo.ICItem AS i1 -- Inventory Control - Item
		LEFT JOIN PARDAT.dbo.ICPricP AS d1 ON d1.ItemNo = i1.ItemNo -- Inventory Control - Pricing Policy
		LEFT JOIN PARDAT.dbo.ICILoc AS l1 ON l1.ItemNo = d1.ItemNo AND l1.Active = 1 -- Inventory Control - Item Location
		LEFT JOIN PARDAT.dbo.ICItMv AS m1 ON m1.ItemNo = d1.ItemNo -- Inventory Control - Item Movement Transactions
UNION
SELECT 'NFDDAT' AS DatabaseName
    , i2.AudtUser
    , i2.PickingSeq
    , i2.Category
    , i2.ItemNo
    , i2.[Desc]
    , l2.Location
    , l2.QtyOnHand
    , l2.QtyOnOrder
    , m2.VendItem
    , CASE WHEN i2.DateLastMn = 0 THEN NULL ELSE FORMAT(CAST(CAST(i2.DateLastMn AS VARCHAR) AS DATE), 'yyyy-MM-dd') END AS DateLastMn
    , CASE WHEN i2.AudtDate = 0 THEN NULL ELSE FORMAT(CAST(CAST(i2.AudtDate AS VARCHAR) AS DATE), 'yyyy-MM-dd') END AS AudtDate
	, CASE WHEN l2.LastRcptDt = 0 THEN NULL ELSE FORMAT(CAST(CAST(l2.LastRcptDt AS VARCHAR) AS DATE), 'yyyy-MM-dd') END AS LastRcptDt
	, CASE WHEN l2.LastShipDt = 0 THEN NULL ELSE FORMAT(CAST(CAST(l2.LastShipDt AS VARCHAR) AS DATE), 'yyyy-MM-dd') END AS LastShipDt
	, CASE WHEN l2.LastUsed = 0 THEN NULL ELSE FORMAT(CAST(CAST(l2.LastUsed AS VARCHAR) AS DATE), 'yyyy-MM-dd') END AS LastUsed 
    , l2.TotalCost
    , l2.CostOffset
    , l2.RecentCost
    , l2.Cost1
    , l2.Cost2
    , l2.LastCost
    , d2.PriceList
    , d2.UnitPrice
    FROM NFDDAT.dbo.ICItem AS i2 -- Inventory Control - Item
		LEFT JOIN NFDDAT.dbo.ICPricP AS d2 ON d2.ItemNo = i2.ItemNo -- Inventory Control - Pricing Policy
		LEFT JOIN NFDDAT.dbo.ICILoc AS l2 ON l2.ItemNo = d2.ItemNo AND l2.Active = 1 -- Inventory Control - Item Location
		LEFT JOIN NFDDAT.dbo.ICItMv AS m2 ON m2.ItemNo = d2.ItemNo -- Inventory Control - Item Movement Transactions
/*
WHERE 0 = 0
*/
/*
    AND i1.AudtUser NOT LIKE 'AD%'
    AND i1.AudtUser NOT LIKE 'B%'
    AND i1.AudtUser NOT LIKE 'D%'
    AND i1.AudtUser NOT LIKE 'I%'
    AND i1.AudtUser NOT LIKE 'J%'
    AND i1.AudtUser NOT LIKE 'K%'
    AND i1.AudtUser NOT LIKE 'LO%'
    AND i1.AudtUser NOT LIKE 'MI%'
    AND i1.AudtUser NOT LIKE 'Q%'
*/
/*
    AND i1.ItemNo IN (
        '1369'
        , '3137'
        , '3138'
        , '3145'
        , '3153'
        , '3156'
        , '3165'
    )
*/
ORDER BY AudtDate ASC
    , ItemNo ASC
;
