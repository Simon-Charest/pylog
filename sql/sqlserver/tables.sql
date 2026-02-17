
SELECT s.name AS table_schema
    , t.name AS table_name
    --, y.name AS data_type
    --, c.max_length
    , SUM(p.rows) AS row_count
FROM sys.tables AS t
    JOIN sys.schemas AS s ON s.schema_id = t.schema_id
    JOIN sys.partitions AS p ON p.object_id = t.object_id
    --JOIN sys.columns c ON c.object_id = t.object_id
    --JOIN sys.types y ON c.user_type_id = y.user_type_id
WHERE 0 = 0
    AND
    (
        0 = 1
        --OR t.name LIKE '%ACT%' -- Activity
        --OR t.name LIKE '%AUD%' -- Audit
        --OR t.name LIKE '%HIS%' -- History
        OR t.name LIKE 'IC%' -- Inventory Control
        --OR t.name LIKE '%LOG%' -- Log
    )
    AND p.index_id IN (0, 1)  -- Heap or clustered index
GROUP BY s.name
    , t.name
    --, c.max_length
    --, y.name
HAVING SUM(p.rows) > 50
ORDER BY s.name ASC
    , t.name ASC
    --, y.name ASC
    , row_count DESC
;
