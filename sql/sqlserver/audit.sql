SELECT t.AuditTable
    , CASE t.AuditTable
        WHEN 'ASActLog' THEN 'Administrative Services - Activity Log'
        WHEN 'OEAudD' THEN 'Order Entry - Posting Journal Detail'
        WHEN 'OEAudH' THEN 'Order Entry - Posting Journal Header'
        WHEN 'OEAudHP' THEN 'Order Entry - Posting Journal History / Posted'
        WHEN 'SGAud' THEN 'Security Group Audit'
        WHEN 'TXAudD' THEN 'Tax Services - Posting Journal Detail'
        WHEN 'TXAudH' THEN 'Tax Services - Posting Journal Header'
    END AS AuditTableDescription
    , TRIM(t.AuditUser) AS AuditUser
    , MIN(t.AuditDate) AS MinAuditDate
    , MAX(t.AuditDate) AS MaxAuditDate
    , DATEDIFF(DAY, MIN(t.AuditDate), MAX(t.AuditDate)) AS Days
    , COUNT(1) AS Count
    , COUNT(1) / COALESCE(NULLIF(DATEDIFF(DAY, MIN(t.AuditDate), MAX(t.AuditDate)), 0), 1) AS AvgCountPerDay
FROM
(
    SELECT a.AuditTable
        , TRIM(a.AudtUser) AS AuditUser
        , CONVERT(DATE, CAST(AudtDate AS varchar(8)), 112) AS AuditDate
    FROM
    (
        SELECT 'ASActLog' AS AuditTable, AudtUser, AudtDate FROM ASActLog
        UNION SELECT 'OEAudD', AudtUser, AudtDate FROM OEAudD
        UNION SELECT 'OEAudH', AudtUser, AudtDate FROM OEAudH
        UNION SELECT 'OEAudHP', AudtUser, AudtDate FROM OEAudHP
        UNION SELECT 'TxAudD', AudtUser, AudtDate FROM TxAudD
        UNION SELECT 'TxAudH', AudtUser, AudtDate FROM TxAudH
        UNION SELECT 'SGAud', UserId, AuditDate FROM SGAud
    ) AS a
) AS t
WHERE 0 = 0
    AND t.AuditUser NOT LIKE 'B%'
    AND t.AuditUser NOT LIKE 'D%'
    AND t.AuditUser NOT LIKE 'K%'
    AND t.AuditDate >= '2025-06-26'
GROUP BY t.AuditTable
    , t.AuditUser
ORDER BY AvgCountPerDay DESC
    , Count DESC
    , TRIM(t.AuditUser) ASC
;
