SELECT 
    -- Order Entry - Invoice Header
    i.InvNumber     -- Invoice Number
    , i.Customer    -- Customer Id
    , c.NameCust    -- Customer Name
    , CONVERT(DATE, CAST(i.InvDate AS VARCHAR(8)), 112) AS InvDate -- Invoice Date
    , i.OrdNumber   -- Original Order Number
    , i.PONumber    -- Customer Purchase Order Number
    , i.Location
    , i.InvSubTot   -- Subtotal
    , i.InvNet      -- Invoice Net Total
    , i.ShiNumber   -- Shipment Number
    , i.AudtDate
    , i.AudtTime
    , i.AudtOrg
    , i.AudtUser

    -- Order Entry - Invoice Detail
    , d.LineNum     -- Line Number
    , d.Category    -- Item Category
    , d.Item        -- Item Number
    , d.[Desc]      -- Description
    , d.Location    -- Location/Warehouse Id
    , l.[Desc]      -- Location/Warehouse Name
    , t.QtyOnHand   -- Quantity on Hand
    , t.QtyOnHand - t.QtyCommit AS QuantityAvailable -- Quantity Available
    , d.QtyShipped  -- Quantity Shipped
    , d.InvUnit     -- Unit of Measure
    , d.UnitPrice   -- Unit Price
    , d.AudtDate
    , d.AudtTime
    , d.AudtOrg
    , d.AudtUser

    -- Inventory Control - History
    , h.TransType   -- Transaction Type (16 = Order Entry - Invoice)
    , h.DayEndSeq   -- Day End Sequence
    , h.Quantity    -- Inventory Control - Quantity
    , h.SrcExtCst   -- Cost in Source Currency
    , h.HomeExtCst  -- Cost in Home Currency
    , h.Location    -- Inventory Control - Location/Warehouse
    , h.AudtDate
    , h.AudtTime
    , h.AudtOrg
    , h.AudtUser

    -- Order Entry - Shipment Header
    , s.BilName
    , s.BilAddr1
    , s.BilAddr2
    , s.BilAddr3
    , s.BilAddr4
    , s.BilCity
    , s.BilState
    , s.BilZip
    , s.BilCountry
    , s.BilContact
    , s.ShipTo
    , s.ShpName
    , s.ShpAddr1
    , s.ShpAddr2
    , s.ShpAddr3
    , s.ShpAddr4
    , s.ShpCity
    , s.ShpState
    , s.ShpZip
    , s.ShpCountry
    , s.ShpPhone
    , s.ShpFax
    , s.ShpContact
    , s.ShpEmail
    , s.ShiDate
    , s.ExpDate
    , s.ShipVia
    , s.ViaDesc
    , s.ShiFiscYr
    , s.ShiDiscPer
    , s.ShiTotal
    , s.AudtDate
    , s.AudtTime
    , s.AudtOrg
    , s.AudtUser
FROM OEInvH AS i -- Order Entry - Invoice Header
    LEFT JOIN OEInvD AS d ON d.InvUniq = i.InvUniq  -- Order Entry - Invoice Detail
    LEFT JOIN OEShiH AS s ON s.ShiUniq = i.ShiUniq  -- Order Entry - Shipment Header
    LEFT JOIN ARCus AS c ON c.IdCust = i.Customer   -- Accounts Receivable - Customer
    LEFT JOIN ICHist AS h ON h.DocNum = i.InvNumber AND h.ItemNo = d.Item   -- Inventory Control - History
    LEFT JOIN ICILoc AS t ON t.ItemNo = d.Item AND t.Location = d.Location  -- Inventory Control - Item Location
    LEFT JOIN ICLoc AS l ON l.Location = d.Location -- Inventory Control - Location
WHERE 0 = 0
    AND i.InvNumber = 'INV196481'
    --AND CONVERT(DATE, CAST(i.INVDATE AS VARCHAR(8)), 112) BETWEEN '2025-12-01' AND '2025-12-31'
    --AND i.AudtUser LIKE 'MA%'
ORDER BY i.InvNumber ASC
    , d.LineNum ASC
;
