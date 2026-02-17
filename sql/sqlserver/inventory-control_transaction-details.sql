SELECT CONVERT(DATE, CAST(t.AudtDate AS VARCHAR(8)), 112) AS AuditDate
    , t.AudtUser
    , t.Category
    , t.FmtItemNo
    , t.ItemDesc
    , t.FromLoc
    , t.ToLoc
    , t.Qty
    , t.Unit
    , t.Cost
FROM ICTranD AS t -- Inventory Control – Transaction Details
WHERE 0 = 0
    AND CONVERT(DATE, CAST(t.AudtDate AS VARCHAR(8)), 112) BETWEEN '2025-12-01' AND '2025-12-31'
    --AND t.AudtUser LIKE 'MA%'
ORDER BY t.AudtDate ASC
    , t.Category ASC
    , t.FmtItemNo ASC
;
