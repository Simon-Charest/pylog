SELECT TRIM(o.AudtUser) AS AudtUser
    , CONVERT(VARCHAR(10), MIN(o.AudtDate), 23) AS MinAudtDate
    , CONVERT(VARCHAR(10), MAX(o.AudtDate), 23) AS MaxAudtDate
    , DATEDIFF
    (
        DAY
        , MIN(CONVERT(DATE, CONVERT(VARCHAR(8), AudtDate)))
        , MAX(CONVERT(DATE, CONVERT(VARCHAR(8), AudtDate)))
    ) AS Days
    , COUNT(1) AS Count
    , COUNT(1) / COALESCE
    (
        NULLIF
        (
            DATEDIFF
            (
                DAY
                , MIN(CONVERT(DATE, CONVERT(VARCHAR(8), AudtDate)))
                , MAX(CONVERT(DATE, CONVERT(VARCHAR(8), AudtDate)))
            )
            , 0
        )
        , 1
    ) AS AvgCountPerDay
FROM OEAudD AS o
GROUP BY o.AudtUser
ORDER BY AvgCountPerDay DESC
    , Count DESC
    , TRIM(o.AudtUser) ASC
;
