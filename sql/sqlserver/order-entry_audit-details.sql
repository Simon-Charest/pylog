
SELECT a.AudtOrg
    , CONVERT(DATE, CAST(a.AudtDate AS VARCHAR(8)), 112) AS AuditDate
    , a.AudtUser
    , a.Category
    , a.Item
    , a.[Desc]
    , a.PriceList
    , a.Location
    , CONVERT(INT, a.QtyShipped) AS QtyShipped
    , ROUND(a.UnitCost, 2) AS UnitCost
    , ROUND(a.UnitPrice, 2) AS UnitPrice
    , ROUND(a.UnitPrice - a.UnitCost, 2) AS Profit
    , ROUND(a.QtyShipped * a.UnitCost, 2) AS TotalCost
    , ROUND(a.QtyShipped * a.UnitPrice, 2) AS TotalPrice
    , ROUND(a.QtyShipped * (a.UnitPrice - a.UnitCost), 2) AS TotalProfit
    , CASE WHEN a.UnitCost > 0.0 THEN ROUND((a.UnitPrice / a.UnitCost - 1) * 100, 1) END AS ProfitRatio
    , a.FromDoc
    , CASE WHEN a.RtgDateDue != 0.0 THEN CONVERT(DATE, CAST(a.RtgDateDue AS VARCHAR(8)), 112) END AS RetainageDateDue
FROM OEAudD AS a -- Order Entry - Audit Details
WHERE 0 = 0
    AND CONVERT(DATE, CAST(a.AudtDate AS VARCHAR(8)), 112) >= '2025-12-21'
    AND a.AudtUser NOT LIKE 'AD%'
    AND a.AudtUser NOT LIKE 'B%'
    AND a.AudtUser NOT LIKE 'D%'
    AND a.AudtUser NOT LIKE 'I%'
    AND a.AudtUser NOT LIKE 'J%'
    AND a.AudtUser NOT LIKE 'K%'
    AND a.AudtUser NOT LIKE 'LO%'
    AND a.AudtUser NOT LIKE 'MI%'
    AND a.AudtUser NOT LIKE 'Q%'
    --AND a.AudtUser LIKE 'MA%'
ORDER BY TotalProfit DESC
    , a.AudtDate ASC
    , a.Category ASC
    , a.Item ASC
;
