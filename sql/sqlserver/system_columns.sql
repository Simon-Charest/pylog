SELECT c.table_name
    , c.ordinal_position
    , c.column_name
    , c.data_type
    , c.character_maximum_length
    , c.is_nullable
FROM information_schema.columns AS c
WHERE c.table_name = 'OEAudD' -- Order Entry – Audit Detail
ORDER BY c.ordinal_position ASC
;
