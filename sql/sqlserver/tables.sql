
SELECT s.name AS table_schema,
    t.name AS table_name,
    SUM(p.rows) AS row_count
FROM sys.tables AS t
    JOIN sys.schemas AS s ON s.schema_id = t.schema_id
    JOIN sys.partitions AS p ON p.object_id = t.object_id
WHERE 0 = 0
    AND
    (
        t.name LIKE '%AUD%'
        OR t.name LIKE '%LOG%'
        OR t.name LIKE '%ACT%'
    )
    AND p.index_id IN (0, 1)  -- Heap or clustered index
GROUP BY s.name
    , t.name
HAVING SUM(p.rows) > 50
ORDER BY row_count DESC
    , s.name ASC
    , t.name ASC
;
