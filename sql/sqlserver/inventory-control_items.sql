SELECT CONVERT(DATE, CAST(i.AudtDate AS VARCHAR(8)), 112) AS AuditDate
    , i.AudtUser
    , i.PickingSeq
    , i.Category
    , i.ItemNo
    , i.[Desc]
    , CONVERT(DATE, CAST(i.DateLastMn AS VARCHAR(8)), 112) AS DateLastMovement
FROM ICItem AS i -- Inventory Control – Items
WHERE 0 = 0
    /*
    AND i.AudtUser NOT LIKE 'AD%'
    AND i.AudtUser NOT LIKE 'B%'
    AND i.AudtUser NOT LIKE 'D%'
    AND i.AudtUser NOT LIKE 'I%'
    AND i.AudtUser NOT LIKE 'J%'
    AND i.AudtUser NOT LIKE 'K%'
    AND i.AudtUser NOT LIKE 'LO%'
    AND i.AudtUser NOT LIKE 'MI%'
    AND i.AudtUser NOT LIKE 'Q%'
    */
    AND i.ItemNo IN (
        '1369'
        , '3137'
        , '3138'
        , '3145'
        , '3153'
        , '3156'
        , '3165'
    )
ORDER BY i.AudtDate ASC
    , i.ItemNo ASC
;
