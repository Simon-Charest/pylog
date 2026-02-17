
SELECT TOP 5 a.AudtUser
    , a.AuditDate
FROM
(
    SELECT *
        , CONVERT(DATE, CAST(AudtDate AS VARCHAR(8)), 112) AS AuditDate
    FROM OEAudD -- Order Entry Audit Detail
) AS a
WHERE a.AuditDate >= '2026-02-01'
ORDER BY a.AuditDate DESC
;
