// Creacion de las relaciones entre nodos de Entrada

// Entrada -> Moneda (SE_PAGA_EN)
MATCH (e:Entrada)
MATCH (m:Moneda)
WHERE e.Moneda = m.Moneda
MERGE (e)-[:SE_PAGA_EN]->(m)

// Entrada -> Cliente (SE_VENDE_A)
MATCH (e:Entrada)
MATCH (c:Cliente)
WHERE e.ClienteID = c.ClienteID
MERGE (e)-[:SE_VENDE_A]->(c)

// Entrada_Detalle -> Entrada (DETALLA)
CALL apoc.periodic.iterate(
'MATCH (ed:Entrada_Detalle)
MATCH (e:Entrada)
WHERE ed.Folio = e.Folio
RETURN ed, e',
'MERGE (ed)-[:DETALLA]->(e)',
{ batchSize:10000, parallel:false }
)

// Entrada_Detalle -> Articulo (COMPRA)
MATCH (ed:Entrada_Detalle)
MATCH (a:Articulo)
WHERE ed.Articulo = a.ArticuloID
MERGE (ed)-[:COMPRA]->(a)

// Articulo -> Articulo_Tipo (TIPO)
MATCH (a:Articulo)
MATCH (at:Articulo_Tipo)
WHERE a.Articulo_Tipo = at.Articulo_Tipo
MERGE (a)-[:TIPO]->(at)

// Articulo -> Articulo_Grupo (GRUPO)
MATCH (a:Articulo)
MATCH (ag:Articulo_Grupo)
WHERE a.Articulo_Grupo = ag.Articulo_Grupo
MERGE (a)-[:GRUPO]->(ag)

// Articulo -> Articulo_Clase (CLASE)
MATCH (a:Articulo)
MATCH (ac:Articulo_Clase)
WHERE a.Articulo_Clase = ac.Articulo_Clase
MERGE (a)-[:CLASE]->(ac)

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