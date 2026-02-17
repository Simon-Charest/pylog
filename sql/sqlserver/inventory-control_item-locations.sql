SELECT CONVERT(DATE, CAST(l.AudtDate AS VARCHAR(8)), 112) AS AuditDate
    , l.AudtUser
    , l.PickingSeq
    , i.Category
    , l.ItemNo
    , i.[Desc]
    , l.Location
    , CONVERT(DATE, CAST(l.LastRcptDt AS VARCHAR(8)), 112) AS LastReceiptDate
    , l.QtyOnHand
    , l.Cost1
    , l.RecentCost
    , l.TotalCost
FROM ICILoc AS l -- Inventory Control – Item Locations
    LEFT JOIN ICItem AS i ON i.ItemNo = l.ItemNo -- Inventory Control – Items
WHERE 0 = 0
    --AND CONVERT(DATE, CAST(l.AudtDate AS VARCHAR(8)), 112) BETWEEN '2025-01-01' AND '2025-12-31'
    /*
    AND l.AudtUser NOT LIKE 'AD%'
    AND l.AudtUser NOT LIKE 'B%'
    AND l.AudtUser NOT LIKE 'D%'
    AND l.AudtUser NOT LIKE 'I%'
    AND l.AudtUser NOT LIKE 'J%'
    AND l.AudtUser NOT LIKE 'K%'
    AND l.AudtUser NOT LIKE 'LO%'
    AND l.AudtUser NOT LIKE 'MI%'
    AND l.AudtUser NOT LIKE 'Q%'
    */
    AND l.ItemNo = '3153'
    AND l.Location = 3
ORDER BY l.AudtDate ASC
    , l.ItemNo ASC
;
