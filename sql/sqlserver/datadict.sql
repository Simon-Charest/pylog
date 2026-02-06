WITH Blobs AS
(
    SELECT d.TableName
        , CAST(d.TableData AS VARBINARY(MAX)) AS Blob
        , DATALENGTH(d.TableData) AS BlobLength
    FROM DataDict AS d
)
, Numbers AS
(
    SELECT b.TableName
        , v.Number AS Position
        , b.Blob
    FROM Blobs AS b
        JOIN Master..SPT_Values AS v ON v.type = 'P' AND v.number < b.BlobLength
)
, Characters AS
(
    SELECT n.TableName
        , n.Position
        , ASCII(SUBSTRING(n.Blob, n.Position + 1, 1)) AS c
    FROM Numbers AS n
)
, Groups AS
(
    SELECT c.*
        , c.Position - ROW_NUMBER() OVER (PARTITION BY TableName ORDER BY Position) AS [Group]
    FROM Characters AS c
    WHERE c BETWEEN 32 AND 126
)
SELECT
    g.TableName
    , STRING_AGG(CHAR(g.c), '') AS DecodedString
FROM Groups AS g
WHERE g.TableName = 'VIWLOG'
GROUP BY g.TableName
    , g.[Group]
HAVING LEN(STRING_AGG(CHAR(g.c), '')) >= 3
ORDER BY g.TableName ASC
;
