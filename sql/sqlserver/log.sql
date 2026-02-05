SELECT v.*
FROM asactlog AS v
--WHERE TRIM(v.audtuser) != 'ADMIN'
WHERE v.audtdate >= '20260127'
ORDER BY v.audtdate DESC
;
