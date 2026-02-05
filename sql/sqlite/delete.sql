SELECT LOWER(l.UserId) AS UserId
    , DATE(l.CreationDate) AS CreationDate
    , CASE STRFTIME('%w', l.CreationDate)
        WHEN '0' THEN 'Sunday'
        WHEN '1' THEN 'Monday'
        WHEN '2' THEN 'Tuesday'
        WHEN '3' THEN 'Wednesday'
        WHEN '4' THEN 'Thursday'
        WHEN '5' THEN 'Friday'
        WHEN '6' THEN 'Saturday'
    END AS DayOfWeek
    , l.AuditData_Workload
    , CASE l.RecordType
        WHEN   1  THEN 'Exchange Admin'
        WHEN   2  THEN 'Exchange Item'
        WHEN   3  THEN 'Exchange Item Group'
        WHEN   4  THEN 'SharePoint'
        WHEN   5  THEN 'OneDrive FileOperation'
        WHEN   6  THEN 'Sway'
        WHEN  11  THEN 'SharePoint DLP'
        WHEN  12  THEN 'Sway DLP'
        WHEN  20  THEN 'Power BI'
        WHEN  21  THEN 'Dynamics 365'
        WHEN  22  THEN 'Yammer'
        WHEN  23  THEN 'Skype for Business'
        WHEN  24  THEN 'eDiscovery'
        WHEN  25  THEN 'Microsoft Teams A'
        WHEN  26  THEN 'Microsoft Teams B'
        WHEN  27  THEN 'Microsoft Teams C'
        WHEN  28  THEN 'ThreatIntelligence (Defender/Malware)'
        WHEN  41  THEN 'ThreatIntelligence URL'
        WHEN  93  THEN 'Purview AIP Discover'
        WHEN  94  THEN 'Purview AIP SensitivityLabelAction'
        ELSE 'Other/Unknown'
    END AS RecordType
    , l.Operation
    , COUNT(1) AS Count
FROM audit_logs AS l
WHERE l.Operation LIKE '%Delete%'
    OR l.Operation LIKE '%Remove%'
GROUP BY LOWER(l.UserId)
    , DATE(l.CreationDate)
    , l.AuditData_Workload
    , l.RecordType
    , l.Operation
ORDER BY LOWER(l.UserId) ASC
    , DATE(l.CreationDate) ASC
    , Count DESC
    , l.AuditData_Workload ASC
    , l.RecordType ASC
    , l.Operation ASC
;
