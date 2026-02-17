SELECT g.AudtOrg
    , CONVERT(DATE, CAST(g.AudtDate AS VARCHAR(8)), 112) AS AuditDate
    , g.AudtUser
    , g.AcctId
    , g.FiscalYr
    , g.FiscalPerd
    , g.BatchNbr
    , g.EntryNbr
    , g.SrceCurn
    , CASE g.SrceLedger
        WHEN 'AP' THEN 'Accounts Payable'
        WHEN 'AR' THEN 'Accounts Receivable'
        WHEN 'BK' THEN 'Banking'
        WHEN 'GL' THEN 'General Ledger'
        WHEN 'IC' THEN 'Inventory Control'
        WHEN 'OE' THEN 'Order Entry'
        WHEN 'PO' THEN 'Purchase Orders'
        WHEN 'SG' THEN 'Security Group'
        WHEN 'TX' THEN 'Tax Services'
        ELSE NULL
    END AS SourceLedgerDescription
    , CASE g.SrceType
        WHEN 'AD' THEN 'Adjustment'
        WHEN 'CN' THEN 'Credit Note'
        WHEN 'CR' THEN 'Credit'
        WHEN 'DB' THEN 'Debit'
        WHEN 'DN' THEN 'Debit Note'
        WHEN 'EN' THEN 'Ending'
        WHEN 'IN' THEN 'Invoice'
        WHEN 'PY' THEN 'Payment'
        WHEN 'RA' THEN 'Receivables Adjustment'
        WHEN 'RC' THEN 'Receipt'
        WHEN 'RT' THEN 'Return'
        WHEN 'SH' THEN 'Shipment'
        WHEN 'TF' THEN 'Transfer'
        ELSE NULL
    END AS SourceTypeDescription
    , g.CntDetail
    , CONVERT(DATE, CAST(g.JrnlDate AS VARCHAR(8)), 112) AS JournalDate
    , g.TransNbr
    , g.JnlDtlDesc
    , g.JnlDtlRef
    , g.ScurnAmt
    , g.HCurnCode
    , g.RateType
    , g.SCurnCode
    , CONVERT(DATE, CAST(g.RateDate AS VARCHAR(8)), 112) AS RateDate
    , CONVERT(BIGINT, g.DrillDwnLk) AS DrillDownLink
    , CONVERT(DATE, CAST(g.DocDate AS VARCHAR(8)), 112) AS DocDate
FROM GLPost AS g -- General Ledger – Postings
WHERE 0 = 0
    AND g.AudtUser NOT LIKE 'AD%'
    AND g.AudtUser NOT LIKE 'B%'
    AND g.AudtUser NOT LIKE 'D%'
    AND g.AudtUser NOT LIKE 'I%'
    AND g.AudtUser NOT LIKE 'J%'
    AND g.AudtUser NOT LIKE 'K%'
    AND g.AudtUser NOT LIKE 'LO%'
    AND g.AudtUser NOT LIKE 'MI%'
    AND g.AudtUser NOT LIKE 'Q%'
    AND CONVERT(DATE, CAST(g.AudtDate AS VARCHAR(8)), 112) >= '2026-02-01'
ORDER BY g.AudtOrg ASC
    , g.AudtDate ASC
    , g.AudtUser ASC
    , g.AcctId ASC
    , g.FiscalYr ASC
    , g.FiscalPerd ASC
    , g.BatchNbr ASC
    , g.EntryNbr ASC
;
