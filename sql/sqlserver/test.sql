SELECT TOP 5 CONVERT(DATE, CAST(AudtDate AS VARCHAR(8)), 112) AS ConvertedDate
FROM OEAudD AS t -- Order Entry Audit Details
;
