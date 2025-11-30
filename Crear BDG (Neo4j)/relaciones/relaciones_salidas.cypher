// Creacion de las relaciones entre nodos de Salida

// Salida -> Cliente (SATISFACE)
MATCH (s:Salida)
MATCH (c:Cliente)
WHERE s.ClienteID = c.ClienteID
MERGE (s)-[:SATISFACE]->(c)

// Salida -> Vendedor (ASIGNA)
MATCH (s:Salida)
MATCH (v:Vendedor)
WHERE s.Vendedor = v.VendedorID
MERGE (s)-[:ASIGNA]->(v)

// Salida -> Embarque (SE_ENVIA_POR)
MATCH (s:Salida)
MATCH (e:Embarque)
WHERE s.Embarque = e.Embarque
MERGE (s)-[:SE_ENVIA_POR]->(e)

// Salida -> Moneda (SE_PAGA_EN)
MATCH (s:Salida)
MATCH (m:Moneda)
WHERE s.Moneda = m.Moneda
MERGE (s)-[:SE_PAGA_EN]->(m)

// Salida -> Condicion_Pago (SE_PAGA_COMO)
MATCH (s:Salida)
MATCH (cp:Condicion_Pago)
WHERE s.Condicion_Pago = cp.Condicion_Pago
MERGE (s)-[:SE_PAGA_COMO]->(cp)

// Salida_Detalle -> Salida (DETALLA)
CALL apoc.periodic.iterate(
'MATCH (sd:Salida_Detalle)
MATCH (s:Salida)
WHERE sd.Folio = s.Folio
RETURN sd, s',
'MERGE (sd)-[:DETALLA]->(s)',
{ batchSize:10000, parallel:false }
)

// Salida_Detalle -> Articulo (VENDE)
MATCH (sd:Salida_Detalle)
MATCH (a:Articulo)
WHERE sd.ArticuloID = a.ArticuloID
MERGE (sd)-[:VENDE]->(a)

// Articulo -> Moneda (TIPO_MONEDA)
MATCH (a:Articulo)
MATCH (m:Moneda)
WHERE a.Moneda = m.Moneda
MERGE (a)-[:TIPO_MONEDA]->(m)

// Cliente -> Vendedor (ES_ATENDIDO)
MATCH (c:Cliente)
MATCH (v:Vendedor)
WHERE c.VendedorID = v.VendedorID
MERGE (c)-[:ES_ATENDIDO]->(v)

// Cliente -> Moneda (PAGA_EN)
MATCH (c:Cliente)
MATCH (m:Moneda)
WHERE c.Moneda = m.Moneda
MERGE (c)-[:PAGA_EN]->(m)

// Cliente -> Condicion_Pago (ACUERDA)
MATCH (c:Cliente)
MATCH (cp:Condicion_Pago)
WHERE c.Condicion_Pago = cp.Condicion_Pago
MERGE (c)-[:ACUERDA]->(cp)