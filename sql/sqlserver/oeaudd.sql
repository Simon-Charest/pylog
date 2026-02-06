
SELECT TOP 5 a.AudtUser
    , a.AuditDate
FROM
(
    SELECT *
        , CONVERT(DATE, CAST(AudtDate AS varchar(8)), 112) AS AuditDate
    FROM OEAudD
) AS a
WHERE a.AuditDate >= '2026-02-01'
ORDER BY a.AuditDate DESC
;
