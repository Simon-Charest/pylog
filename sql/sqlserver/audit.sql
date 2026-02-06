SELECT AuditTable
    , CASE AuditTable
        WHEN 'ASActLog' THEN 'Administrative Services - Activity Log'
        WHEN 'OEAudD' THEN 'Order Entry - Posting Journal Detail'
        WHEN 'OEAudH' THEN 'Order Entry - Posting Journal Header'
        WHEN 'OEAudHP' THEN 'Order Entry - Posting Journal History / Posted'
        WHEN 'SGAud' THEN 'Security Group Audit'
        WHEN 'TXAudD' THEN 'Tax Services - Posting Journal Detail'
        WHEN 'TXAudH' THEN 'Tax Services - Posting Journal Header'
    END AS AuditTableDescription
    , TRIM(t.AuditUser) AS AuditUser
    , CONVERT(VARCHAR(10), MIN(t.AuditDate), 23) AS MinAuditDate
    , CONVERT(VARCHAR(10), MAX(t.AuditDate), 23) AS MaxAuditDate
    , DATEDIFF
    (
        DAY
        , MIN(CONVERT(DATE, CONVERT(VARCHAR(10), t.AuditDate)))
        , MAX(CONVERT(DATE, CONVERT(VARCHAR(10), t.AuditDate)))
    ) AS Days
    , COUNT(1) AS Count
    , COUNT(1) / COALESCE
    (
        NULLIF
        (
            DATEDIFF
            (
                DAY
                , MIN(CONVERT(DATE, CONVERT(VARCHAR(10), t.AuditDate)))
                , MAX(CONVERT(DATE, CONVERT(VARCHAR(10), t.AuditDate)))
            )
            , 0
        )
        , 1
    ) AS AvgCountPerDay
FROM
(
    SELECT 'ASActLog' AS AuditTable
        , AudtUser AS AuditUser
        , AudtDate AS AuditDate
    FROM ASActLog
    UNION
    SELECT 'OEAudD'
        , AudtUser
        , AudtDate
    FROM OEAudD
    UNION
    SELECT 'OEAudH'
        , AudtUser
        , AudtDate
    FROM OEAudH
    UNION
    SELECT 'OEAudHP'
        , AudtUser
        , AudtDate
    FROM OEAudHP
    UNION
    SELECT 'TxAudD'
        , AudtUser
        , AudtDate
    FROM TxAudD
    UNION
    SELECT 'TxAudH'
        , AudtUser
        , AudtDate
    FROM TxAudH
    UNION
    SELECT 'SGAud'
        , UserId
        , AuditDate
    FROM SGAud
) AS t
WHERE 0 = 0
    AND t.AuditUser NOT LIKE 'B%'
    AND t.AuditUser NOT LIKE 'D%'
    AND t.AuditUser NOT LIKE 'K%'
    AND t.AuditDate >= '20250626'
GROUP BY t.AuditTable
    , t.AuditUser
ORDER BY AvgCountPerDay DESC
    , Count DESC
    , TRIM(t.AuditUser) ASC
;
