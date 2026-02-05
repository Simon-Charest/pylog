SELECT DISTINCT l.ClientIPAddress
FROM audit_logs AS l
WHERE l.ClientIPAddress IS NOT NULL
AND l.ClientIPAddress != '0.0.0.0' -- Unspecified

/* IPv4 private / special */
AND l.ClientIPAddress NOT LIKE '10.%'
AND l.ClientIPAddress NOT LIKE '127.%' -- Loopback
AND l.ClientIPAddress NOT LIKE '169.254.%' -- Link-local

-- RFC1918
AND l.ClientIPAddress NOT LIKE '172.16.%'
AND l.ClientIPAddress NOT LIKE '172.17.%'
AND l.ClientIPAddress NOT LIKE '172.18.%'
AND l.ClientIPAddress NOT LIKE '172.19.%'
AND l.ClientIPAddress NOT LIKE '172.2?.%'
AND l.ClientIPAddress NOT LIKE '172.30.%'
AND l.ClientIPAddress NOT LIKE '172.31.%'

AND l.ClientIPAddress NOT LIKE '192.168.%'

/* IPv6 private / special */
AND l.ClientIPAddress != '::1' -- Loopback
AND l.ClientIPAddress NOT LIKE 'fc00:%' -- ULA
AND l.ClientIPAddress NOT LIKE 'fd00:%' -- ULA
AND l.ClientIPAddress NOT LIKE 'fe80:%' -- Link-local

/* Microsoft-owned */
AND l.ClientIPAddress NOT LIKE '20.%'
AND l.ClientIPAddress NOT LIKE '40.%'
AND l.ClientIPAddress NOT LIKE '52.%'
AND l.ClientIPAddress NOT LIKE '2603:%' -- Azure / M365 IPv6
;
