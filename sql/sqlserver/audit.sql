WITH AuditData AS (
    SELECT a.DatabaseName
        , LEFT(a.TableName, 2) AS ModuleName
        , a.TableName
        , a.TableDescription
        , a.AudtUser AS AuditUser
        , CONVERT(DATE, CAST(a.AudtDate AS VARCHAR(8)), 112) AS AuditDate
    FROM (
        SELECT AudtUser, AudtDate, 'NFDDAT' AS DatabaseName, 'APOBL' AS TableName, 'Documents' AS TableDescription FROM NFDDAT.dbo.APOBL
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'APOBP', 'Document Payments' FROM NFDDAT.dbo.APOBP
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'APOBS', 'Document Sched. Payments' FROM NFDDAT.dbo.APOBS
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'APPJD', 'Posting Journal Details' FROM NFDDAT.dbo.APPJD
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'APPJH', 'Posting Journal Entries' FROM NFDDAT.dbo.APPJH
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'APPJS', 'Posting Journals' FROM NFDDAT.dbo.APPJS
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'APPYM', 'Posted Payments' FROM NFDDAT.dbo.APPYM
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'AROBL', 'Documents' FROM NFDDAT.dbo.AROBL
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'AROBP', 'Document Payments' FROM NFDDAT.dbo.AROBP
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'AROBS', 'Document Schedule Payments' FROM NFDDAT.dbo.AROBS
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'ARPJD', 'Posting Journal Details' FROM NFDDAT.dbo.ARPJD
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'ARPJH', 'Posting Journal Entries' FROM NFDDAT.dbo.ARPJH
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'ARPJS', 'Posting Journals' FROM NFDDAT.dbo.ARPJS
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'ARPYM', 'Posted Payments' FROM NFDDAT.dbo.ARPYM
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'ASACTLOG', 'Activity Log' FROM NFDDAT.dbo.ASACTLOG
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'BKJRNL', 'Bank Posting Journal' FROM NFDDAT.dbo.BKJRNL
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'BKJTRANH', 'Bank Journal Transaction Header' FROM NFDDAT.dbo.BKJTRANH
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'BKJTRAND', 'Bank Journal Transaction Details' FROM NFDDAT.dbo.BKJTRAND
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'BKJZGL', 'G/L Audit Summary' FROM NFDDAT.dbo.BKJZGL
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'GLPOST', 'Posted Transactions' FROM NFDDAT.dbo.GLPOST
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'GLPJD', 'Posting Journal Details' FROM NFDDAT.dbo.GLPJD
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'ICADJD', 'Adjustment Audit List Details' FROM NFDDAT.dbo.ICADJD
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'ICADJH', 'Adjustment Audit List Headers' FROM NFDDAT.dbo.ICADJH
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'ICASSMD', 'Assembly Audit List Details' FROM NFDDAT.dbo.ICASSMD
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'ICASSMH', 'Assembly Audit List Headers' FROM NFDDAT.dbo.ICASSMH
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'ICHIST', 'Transaction History' FROM NFDDAT.dbo.ICHIST
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'ICINCAD', 'Internal Usage Audit List Details' FROM NFDDAT.dbo.ICINCAD
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'ICINCAH', 'Internal Usage Audit List Headers' FROM NFDDAT.dbo.ICINCAH
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'ICRECPD', 'Receipt Audit List Details' FROM NFDDAT.dbo.ICRECPD
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'ICRECPH', 'Receipt Audit List Headers' FROM NFDDAT.dbo.ICRECPH
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'ICSHIPD', 'Shipment Audit List Details' FROM NFDDAT.dbo.ICSHIPD
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'ICSHIPH', 'Shipment Audit List Headers' FROM NFDDAT.dbo.ICSHIPH
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'ICTRAND', 'Transfer Audit List Details' FROM NFDDAT.dbo.ICTRAND
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'ICTRANH', 'Transfer Audit List Headers' FROM NFDDAT.dbo.ICTRANH
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'OEAUDD', 'Posting Journals - Details' FROM NFDDAT.dbo.OEAUDD
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'OEAUDH', 'Posting Journals' FROM NFDDAT.dbo.OEAUDH
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'OEAUDHP', 'Posting Journal History / Posted' FROM NFDDAT.dbo.OEAUDHP
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'OESHDT', 'Sales History Details' FROM NFDDAT.dbo.OESHDT
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'POAAPC', 'Payables Clearing Audit' FROM NFDDAT.dbo.POAAPC
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'POCOCA', 'Committed Costs Audit' FROM NFDDAT.dbo.POCOCA
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'POCRNAH', 'Credit/Debit Note Audit Headers' FROM NFDDAT.dbo.POCRNAH
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'POCRNAL', 'Credit/Debit Note Audit Lines' FROM NFDDAT.dbo.POCRNAL
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'POCRNAQ', 'CR/DR Note Audit Prorate Lines' FROM NFDDAT.dbo.POCRNAQ
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'POCRNAS', 'CR/DR Note Audit Costs' FROM NFDDAT.dbo.POCRNAS
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'POHSTH', 'Purchase History' FROM NFDDAT.dbo.POHSTH
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'POHSTL', 'Purchase History Detail' FROM NFDDAT.dbo.POHSTL
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'POINVAH', 'Invoice Audit Headers' FROM NFDDAT.dbo.POINVAH
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'POINVAL', 'Invoice Audit Lines' FROM NFDDAT.dbo.POINVAL
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'POINVAQ', 'Invoice Audit Prorate Lines' FROM NFDDAT.dbo.POINVAQ
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'POINVAS', 'Invoice Audit Costs' FROM NFDDAT.dbo.POINVAS
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'POPORAH', 'Purchase Order Audit Headers' FROM NFDDAT.dbo.POPORAH
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'POPORAL', 'Purchase Order Audit Lines' FROM NFDDAT.dbo.POPORAL
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'PORCPAH', 'Receipt Audit Headers' FROM NFDDAT.dbo.PORCPAH
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'PORCPAL', 'Receipt Audit Lines' FROM NFDDAT.dbo.PORCPAL
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'PORCPAQ', 'Receipt Audit Prorate Lines' FROM NFDDAT.dbo.PORCPAQ
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'PORCPAS', 'Receipt Audit Costs' FROM NFDDAT.dbo.PORCPAS
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'PORETAH', 'Return Audit Headers' FROM NFDDAT.dbo.PORETAH
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'PORETAL', 'Return Audit Lines' FROM NFDDAT.dbo.PORETAL
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'PORETAQ', 'Return Audit Prorate Lines' FROM NFDDAT.dbo.PORETAQ
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'PORETAS', 'Return Audit Costs' FROM NFDDAT.dbo.PORETAS
        UNION ALL SELECT UserId, AuditDate, 'NFDDAT', 'SGAUD', 'Audit' FROM NFDDAT.dbo.SGAUD
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'TXAUDD', 'Tax Tracking Item Class' FROM NFDDAT.dbo.TXAUDD
        UNION ALL SELECT AudtUser, AudtDate, 'NFDDAT', 'TXAUDH', 'Tax Tracking Headers' FROM NFDDAT.dbo.TXAUDH
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT' AS DatabaseName, 'APOBL' AS TableName, 'Documents' AS TableDescription FROM PARDAT.dbo.APOBL
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'APOBP', 'Document Payments' FROM PARDAT.dbo.APOBP
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'APOBS', 'Document Sched. Payments' FROM PARDAT.dbo.APOBS
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'APPJD', 'Posting Journal Details' FROM PARDAT.dbo.APPJD
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'APPJH', 'Posting Journal Entries' FROM PARDAT.dbo.APPJH
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'APPJS', 'Posting Journals' FROM PARDAT.dbo.APPJS
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'APPYM', 'Posted Payments' FROM PARDAT.dbo.APPYM
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'AROBL', 'Documents' FROM PARDAT.dbo.AROBL
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'AROBP', 'Document Payments' FROM PARDAT.dbo.AROBP
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'AROBS', 'Document Sched. Payments' FROM PARDAT.dbo.AROBS
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'ARPJD', 'Posting Journal Details' FROM PARDAT.dbo.ARPJD
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'ARPJH', 'Posting Journal Entries' FROM PARDAT.dbo.ARPJH
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'ARPJS', 'Posting Journals' FROM PARDAT.dbo.ARPJS
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'ARPYM', 'Posted Payments' FROM PARDAT.dbo.ARPYM
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'ASACTLOG', 'Activity Log' FROM PARDAT.dbo.ASACTLOG
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'BKJRNL', 'Bank Posting Journal' FROM PARDAT.dbo.BKJRNL
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'BKJTRANH', 'Bank Journal Transaction Header' FROM PARDAT.dbo.BKJTRANH
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'BKJTRAND', 'Bank Journal Transaction Details' FROM PARDAT.dbo.BKJTRAND
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'BKJZGL', 'G/L Audit Summary' FROM PARDAT.dbo.BKJZGL
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'GLPOST', 'Posted Transactions' FROM PARDAT.dbo.GLPOST
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'GLPJD', 'Posting Journal Details' FROM PARDAT.dbo.GLPJD
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'ICADJD', 'Adjustment Audit List Details' FROM PARDAT.dbo.ICADJD
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'ICADJH', 'Adjustment Audit List Headers' FROM PARDAT.dbo.ICADJH
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'ICASSMD', 'Assembly Audit List Details' FROM PARDAT.dbo.ICASSMD
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'ICASSMH', 'Assembly Audit List Headers' FROM PARDAT.dbo.ICASSMH
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'ICHIST', 'Transaction History' FROM PARDAT.dbo.ICHIST
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'ICINCAD', 'Internal Usage Audit List Details' FROM PARDAT.dbo.ICINCAD
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'ICINCAH', 'Internal Usage Audit List Headers' FROM PARDAT.dbo.ICINCAH
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'ICRECPD', 'Receipt Audit List Details' FROM PARDAT.dbo.ICRECPD
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'ICRECPH', 'Receipt Audit List Headers' FROM PARDAT.dbo.ICRECPH
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'ICSHIPD', 'Shipment Audit List Details' FROM PARDAT.dbo.ICSHIPD
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'ICSHIPH', 'Shipment Audit List Headers' FROM PARDAT.dbo.ICSHIPH
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'ICTRAND', 'Transfer Audit List Details' FROM PARDAT.dbo.ICTRAND
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'ICTRANH', 'Transfer Audit List Headers' FROM PARDAT.dbo.ICTRANH
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'OEAUDD', 'Posting Journals - Details' FROM PARDAT.dbo.OEAUDD
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'OEAUDH', 'Posting Journals' FROM PARDAT.dbo.OEAUDH
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'OEAUDHP', 'Posting Journal History / Posted' FROM PARDAT.dbo.OEAUDHP
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'OESHDT', 'Sales History Details' FROM PARDAT.dbo.OESHDT
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'POAAPC', 'Payables Clearing Audit' FROM PARDAT.dbo.POAAPC
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'POCOCA', 'Committed Costs Audit' FROM PARDAT.dbo.POCOCA
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'POCRNAH', 'Credit/Debit Note Audit Headers' FROM PARDAT.dbo.POCRNAH
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'POCRNAL', 'Credit/Debit Note Audit Lines' FROM PARDAT.dbo.POCRNAL
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'POCRNAQ', 'CR/DR Note Audit Prorate Lines' FROM PARDAT.dbo.POCRNAQ
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'POCRNAS', 'CR/DR Note Audit Costs' FROM PARDAT.dbo.POCRNAS
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'POHSTH', 'Purchase History' FROM PARDAT.dbo.POHSTH
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'POHSTL', 'Purchase History Detail' FROM PARDAT.dbo.POHSTL
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'POINVAH', 'Invoice Audit Headers' FROM PARDAT.dbo.POINVAH
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'POINVAL', 'Invoice Audit Lines' FROM PARDAT.dbo.POINVAL
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'POINVAQ', 'Invoice Audit Prorate Lines' FROM PARDAT.dbo.POINVAQ
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'POINVAS', 'Invoice Audit Costs' FROM PARDAT.dbo.POINVAS
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'POPORAH', 'Purchase Order Audit Headers' FROM PARDAT.dbo.POPORAH
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'POPORAL', 'Purchase Order Audit Lines' FROM PARDAT.dbo.POPORAL
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'PORCPAH', 'Receipt Audit Headers' FROM PARDAT.dbo.PORCPAH
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'PORCPAL', 'Receipt Audit Lines' FROM PARDAT.dbo.PORCPAL
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'PORCPAQ', 'Receipt Audit Prorate Lines' FROM PARDAT.dbo.PORCPAQ
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'PORCPAS', 'Receipt Audit Costs' FROM PARDAT.dbo.PORCPAS
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'PORETAH', 'Return Audit Headers' FROM PARDAT.dbo.PORETAH
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'PORETAL', 'Return Audit Lines' FROM PARDAT.dbo.PORETAL
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'PORETAQ', 'Return Audit Prorate Lines' FROM PARDAT.dbo.PORETAQ
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'PORETAS', 'Return Audit Costs' FROM PARDAT.dbo.PORETAS
        UNION ALL SELECT UserId, AuditDate, 'PARDAT', 'SGAUD', 'Audit' FROM PARDAT.dbo.SGAUD
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'TXAUDD', 'Tax Tracking Item Class' FROM PARDAT.dbo.TXAUDD
        UNION ALL SELECT AudtUser, AudtDate, 'PARDAT', 'TXAUDH', 'Tax Tracking Headers' FROM PARDAT.dbo.TXAUDH
    ) AS a
)
SELECT b.DatabaseName
    , b.ModuleName
    , CASE b.ModuleName
        WHEN 'AP' THEN 'Accounts Payable'
        WHEN 'AR' THEN 'Accounts Receivable'
        WHEN 'BK' THEN 'Banking'
        WHEN 'GL' THEN 'General Ledger'
        WHEN 'IC' THEN 'Inventory Control'
        WHEN 'OE' THEN 'Order Entry'
        WHEN 'PO' THEN 'Purchase Orders'
        WHEN 'SG' THEN 'Security Group'
        WHEN 'TX' THEN 'Tax Services'
        ELSE 'Other'
    END AS ModuleDescription
    , b.TableName
    , b.TableDescription
    , b.AuditUser
    , MIN(b.AuditDate) AS MinAuditDate
    , MAX(b.AuditDate) AS MaxAuditDate
    , DATEDIFF(DAY, MIN(b.AuditDate), MAX(b.AuditDate)) AS DayCount
    , COUNT(1) AS Count
    , ROUND(1.0 * COUNT(1) / CASE DATEDIFF(DAY, MIN(b.AuditDate), MAX(b.AuditDate))
        WHEN 0 THEN 1
        ELSE DATEDIFF(DAY, MIN(b.AuditDate), MAX(b.AuditDate))
        END, 1) AS Average
FROM AuditData AS b
WHERE 0 = 0
    AND b.AuditUser NOT LIKE 'AD%'
    AND b.AuditUser NOT LIKE 'B%'
    AND b.AuditUser NOT LIKE 'D%'
    AND b.AuditUser NOT LIKE 'I%'
    AND b.AuditUser NOT LIKE 'J%'
    AND b.AuditUser NOT LIKE 'K%'
    AND b.AuditUser NOT LIKE 'LO%'
    AND b.AuditUser NOT LIKE 'MI%'
    AND b.AuditUser NOT LIKE 'Q%'
    --AND b.AuditUser LIKE 'P%'
    AND b.AuditDate >= '2026-02-01'
GROUP BY b.DatabaseName
    , b.ModuleName
    , b.TableName
    , b.TableDescription
    , b.AuditUser
ORDER BY Count DESC
    , Average DESC
;
