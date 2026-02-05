SELECT LOWER(l.UserId) AS UserId
    , DATE(MIN(l.CreationDate)) AS MinCreationDate
    , CASE STRFTIME('%w', MIN(l.CreationDate))
        WHEN '0' THEN 'Sunday'
        WHEN '1' THEN 'Monday'
        WHEN '2' THEN 'Tuesday'
        WHEN '3' THEN 'Wednesday'
        WHEN '4' THEN 'Thursday'
        WHEN '5' THEN 'Friday'
        WHEN '6' THEN 'Saturday'
    END AS MinDayOfWeek
    , DATE(MAX(l.CreationDate)) AS MaxCreationDate
    , CASE STRFTIME('%w', MAX(l.CreationDate))
        WHEN '0' THEN 'Sunday'
        WHEN '1' THEN 'Monday'
        WHEN '2' THEN 'Tuesday'
        WHEN '3' THEN 'Wednesday'
        WHEN '4' THEN 'Thursday'
        WHEN '5' THEN 'Friday'
        WHEN '6' THEN 'Saturday'
    END AS MaxDayOfWeek
    , CAST(MAX(JULIANDAY(l.CreationDate)) - MIN(JULIANDAY(l.CreationDate)) AS INT) AS Days
    , COUNT(1) AS Count
    , ROUND(COUNT(1) / CAST(MAX(JULIANDAY(l.CreationDate)) - MIN(JULIANDAY(l.CreationDate)) AS FLOAT), 1) AS AvgCountPerDay
    , (
        SELECT COUNT(1)
        FROM Audit_Logs AS l2
        WHERE LOWER(l2.UserId) = LOWER(l.UserId)
            AND (l2.Operation LIKE '%Delete%' OR l2.Operation LIKE '%Remove%')
    ) AS Deletes
    , ROUND
    (
        (
            SELECT COUNT(1)
            FROM Audit_Logs AS l2
            WHERE LOWER(l2.UserId) = LOWER(l.UserId)
                AND (l2.Operation LIKE '%Delete%' OR l2.Operation LIKE '%Remove%')
        )
        / CAST(MAX(JULIANDAY(l.CreationDate)) - MIN(JULIANDAY(l.CreationDate)) AS FLOAT)
        , 1
    ) AS AvgDeletePerDay
FROM Audit_Logs AS l
GROUP BY LOWER(l.UserId)
ORDER BY LOWER(l.UserId) ASC
;
