SELECT TOP 5 *
FROM GLPOST -- General Ledger – Postings
WHERE 0 = 0
    AND AudtUser LIKE 'P%'
    AND CONVERT(DATE, CAST(AudtDate AS VARCHAR(8)), 112) >= '2026-02-01'
;
