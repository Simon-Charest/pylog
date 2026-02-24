SELECT 'NFDC' AS DatabaseName
	, RTRIM(c1.IdCust) AS CustomerID
	, RTRIM(c1.IdNatAcct) AS NationalAccountID
	, RTRIM(c1.NameCust) AS CustomerName
	, CASE WHEN LEN(v1.Value) = 0 THEN NULL ELSE v1.Value END AS Sex
	, RTRIM(c1.TextStre1) AS StreetAddressLine1
	, RTRIM(c1.TextStre2) AS StreetAddressLine2
	, RTRIM(c1.TextStre3) AS StreetAddressLine3
	, RTRIM(c1.TextStre4) AS StreetAddressLine4
	, RTRIM(c1.NameCity) AS CityName
	, RTRIM(c1.CodeStte) AS StateProvinceCode
	, RTRIM(c1.CodePstl) AS PostalCode
	, RTRIM(l1.CodeCtry) AS CountryCode
	, RTRIM(c1.NameCtac) AS ContactName
	, RTRIM(c1.TextPhon1) AS TextPhon1
	, RTRIM(c1.TextPhon2) AS TextPhon2
	, RTRIM(c1.Email1) AS EmailAddresse1
	, RTRIM(c1.Email2) AS EmailAddresse2
	, RTRIM(c1.AudtUser) AS AuditUser -- User who made the last modification.
	, CASE WHEN c1.AudtDate = 0 THEN NULL ELSE FORMAT(CAST(CAST(c1.AudtDate AS VARCHAR) AS DATE), 'yyyy-MM-dd') END AS AuditDate -- Date of the last modification (audit date).
	, CASE WHEN c1.DateInac = 0 THEN NULL ELSE FORMAT(CAST(CAST(c1.DateInac AS VARCHAR) AS DATE), 'yyyy-MM-dd') END AS DateInactivated -- Date the record was inactivated.
	, CASE WHEN c1.DateLastMn = 0 THEN NULL ELSE FORMAT(CAST(CAST(c1.DateLastMn AS VARCHAR) AS DATE), 'yyyy-MM-dd') END AS DateOfLastModification -- Date of the last modification.
	, CASE WHEN c1.DateStart = 0 THEN NULL ELSE FORMAT(CAST(CAST(c1.DateStart AS VARCHAR) AS DATE), 'yyyy-MM-dd') END AS StartDate -- Start date of the record (e.g., contract, fiscal period, etc.).
	, CASE WHEN c1.DateLastAc = 0 THEN NULL ELSE FORMAT(CAST(CAST(c1.DateLastAc AS VARCHAR) AS DATE), 'yyyy-MM-dd') END AS LastAccountActivityDate -- Last account activity date.
FROM NFDDAT.dbo.ARCus AS c1 -- Accounts Receivable - Customers
	LEFT JOIN NFDDAT.dbo.ARCusO AS v1 ON v1.IdCust = c1.IdCust -- Accounts Receivable - Customer Optional Field Values
		AND v1.OptField = 'SEX'
	LEFT JOIN NFDDAT.dbo.ARCSp AS l1 ON l1.IdCust = c1.IdCust -- Accounts Receivable - Ship-To Locations
UNION
SELECT 'Paramed' AS DatabaseName
	, RTRIM(c2.IdCust) AS CustomerID
	, RTRIM(c2.IdNatAcct) AS NationalAccountID
	, RTRIM(c2.NameCust) AS CustomerName
	, CASE WHEN LEN(v2.Value) = 0 THEN NULL ELSE v2.Value END AS Sex
	, RTRIM(c2.TextStre1) AS StreetAddressLine1
	, RTRIM(c2.TextStre2) AS StreetAddressLine2
	, RTRIM(c2.TextStre3) AS StreetAddressLine3
	, RTRIM(c2.TextStre4) AS StreetAddressLine4
	, RTRIM(c2.NameCity) AS CityName
	, RTRIM(c2.CodeStte) AS StateProvinceCode
	, RTRIM(c2.CodePstl) AS PostalCode
	, RTRIM(l2.CodeCtry) AS CountryCode
	, RTRIM(c2.NameCtac) AS ContactName
	, RTRIM(c2.TextPhon1) AS TextPhon1
	, RTRIM(c2.TextPhon2) AS TextPhon2
	, RTRIM(c2.Email1) AS EmailAddresse1
	, RTRIM(c2.Email2) AS EmailAddresse2
	, RTRIM(c2.AudtUser) AS AuditUser -- User who made the last modification.
	, CASE WHEN c2.AudtDate = 0 THEN NULL ELSE FORMAT(CAST(CAST(c2.AudtDate AS VARCHAR) AS DATE), 'yyyy-MM-dd') END AS AuditDate -- Date of the last modification (audit date).
	, CASE WHEN c2.DateInac = 0 THEN NULL ELSE FORMAT(CAST(CAST(c2.DateInac AS VARCHAR) AS DATE), 'yyyy-MM-dd') END AS DateInactivated -- Date the record was inactivated.
	, CASE WHEN c2.DateLastMn = 0 THEN NULL ELSE FORMAT(CAST(CAST(c2.DateLastMn AS VARCHAR) AS DATE), 'yyyy-MM-dd') END AS DateOfLastModification -- Date of the last modification.
	, CASE WHEN c2.DateStart = 0 THEN NULL ELSE FORMAT(CAST(CAST(c2.DateStart AS VARCHAR) AS DATE), 'yyyy-MM-dd') END AS StartDate -- Start date of the record (e.g., contract, fiscal period, etc.).
	, CASE WHEN c2.DateLastAc = 0 THEN NULL ELSE FORMAT(CAST(CAST(c2.DateLastAc AS VARCHAR) AS DATE), 'yyyy-MM-dd') END AS LastAccountActivityDate -- Last account activity date.
FROM PARDAT.dbo.ARCus AS c2 -- Accounts Receivable - Customers
	LEFT JOIN PARDAT.dbo.ARCusO AS v2 ON v2.IdCust = c2.IdCust -- Accounts Receivable - Customer Optional Field Values
		AND v2.OptField = 'SEX'
	LEFT JOIN PARDAT.dbo.ARCSp AS l2 ON l2.IdCust = c2.IdCust -- Accounts Receivable - Ship-To Locations
ORDER BY CustomerID ASC
;
