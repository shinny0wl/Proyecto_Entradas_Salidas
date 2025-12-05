// 3.2.1
MATCH (a1:Articulo), (a2:Articulo)
WHERE trim(a1.ArticuloID) = 'CVGO87'
  AND trim(a2.ArticuloID) = '333-1610L'

MATCH (a1)<-[:VENDE]-(sd1:Salida_Detalle)-[:DETALLA]->(s:Salida)
MATCH (a2)<-[:VENDE]-(sd2:Salida_Detalle)-[:DETALLA]->(s)

WITH DISTINCT a1, a2, s.Folio AS Folio
RETURN
  a1.ArticuloID AS Articulo_Original,
  a2.ArticuloID AS Articulo_Recomendado,
  count(Folio) AS Num_Folios;

// 3.2.2
MATCH (a1:Articulo), (a2:Articulo)
WHERE trim(a1.ArticuloID) = 'PFES94'
  AND trim(a2.ArticuloID) = 'BTDGC93P'

MATCH (a1)<-[:VENDE]-(sd1:Salida_Detalle)-[:DETALLA]->(s:Salida)
MATCH (a2)<-[:VENDE]-(sd2:Salida_Detalle)-[:DETALLA]->(s)

WITH DISTINCT a1, a2, s.Folio AS Folio
RETURN
  a1.ArticuloID AS Articulo_Original,
  a2.ArticuloID AS Articulo_Recomendado,
  count(Folio) AS Num_Folios;

// 3.2.3
MATCH (a1:Articulo), (a2:Articulo), (a3:Articulo)
WHERE trim(a1.ArticuloID) = 'CHCNPU94'
  AND trim(a2.ArticuloID) = 'CFRA83'

MATCH (a1)<-[:VENDE]-(sd1:Salida_Detalle)-[:DETALLA]->(s:Salida)
MATCH (a2)<-[:VENDE]-(sd2:Salida_Detalle)-[:DETALLA]->(s)

WITH DISTINCT a1, a2, s.Folio AS Folio
RETURN
  a1.ArticuloID AS Articulo_Original,
  a2.ArticuloID AS Articulo_Recomendado,
  count(Folio) AS NumFolios;

// 3.2.4
MATCH (a1:Articulo)
WHERE trim(a1.ArticuloID) = 'ELFRA83NL'

MATCH (a1)<-[:VENDE]-(sd1:Salida_Detalle)-[:DETALLA]->(s:Salida)
MATCH (s)<-[:DETALLA]-(sd2:Salida_Detalle)-[:VENDE]->(a2:Articulo)
WHERE a2 <> a1

WITH a1, a2, count(DISTINCT s) AS Frecuencia
ORDER BY Frecuencia DESC

RETURN
  a1.ArticuloID AS Articulo_Original,
  a2.ArticuloID AS Articulo_Recomendado,
  count(Frecuencia) AS Num_Articulos_Recomendados;

// 3.2.5
MATCH (a1:Articulo)
WHERE trim(a1.ArticuloID) = 'ELVGO93CL'
MATCH (a1)-[:CLASE]->(clase:Articulo_Clase)

MATCH (a1)<-[:VENDE]-(sd1:Salida_Detalle)-[:DETALLA]->(s:Salida)
MATCH (s)<-[:DETALLA]-(sd2:Salida_Detalle)-[:VENDE]->(a2:Articulo)
MATCH (a2)-[:CLASE]->(clase)
WHERE a2 <> a1

WITH a1, a2, count(DISTINCT s) AS Frecuencia
ORDER BY Frecuencia DESC

RETURN
  a1.ArticuloID AS Articulo_Original,
  a1.Articulo_Clase AS Clase_Articulo_Original,
  a2.ArticuloID AS Articulo_Recomendado,
  a2.Articulo_Clase AS Clase_Articulo_Recomendado,
  Frecuencia;

// 3.2.6
MATCH (a1:Articulo)
WHERE trim(a1.ArticuloID) = 'PDDK91P'
MATCH (a1)-[:TIPO]->(tipo:Articulo_Tipo)

MATCH (a1)<-[:VENDE]-(sd1:Salida_Detalle)-[:DETALLA]->(s:Salida)
MATCH (s)<-[:DETALLA]-(sd2:Salida_Detalle)-[:VENDE]->(a2:Articulo)
MATCH (a2)-[:TIPO]->(tipo)
WHERE a2 <> a1

WITH a1, a2, count(DISTINCT s) AS Frecuencia
ORDER BY Frecuencia DESC

RETURN
  a1.ArticuloID AS Articulo_Original,
  a1.Articulo_Tipo AS Tipo_Articulo_Original,
  a2.ArticuloID AS Articulo_Recomendado,
  a2.Articulo_Tipo AS Tipo_Articulo_Recomendado,
  Frecuencia;

// 3.2.7
MATCH (a1:Articulo)
WHERE trim(a1.ArticuloID) = 'SVJE99L'
MATCH (a1)-[:GRUPO]->(grupo:Articulo_Grupo)

MATCH (a1)<-[:VENDE]-(sd1:Salida_Detalle)-[:DETALLA]->(s:Salida)
MATCH (s)<-[:DETALLA]-(sd2:Salida_Detalle)-[:VENDE]->(a2:Articulo)
MATCH (a2)-[:GRUPO]->(grupo)
WHERE a2 <> a1

WITH a1, a2, count(DISTINCT s) AS Frecuencia
ORDER BY Frecuencia DESC

RETURN
  a1.ArticuloID AS Articulo_Original,
  a1.Articulo_Grupo AS Grupo_Articulo_Original,
  a2.ArticuloID AS Articulo_Recomendado,
  a2.Articulo_Grupo AS Grupo_Articulo_Recomendado,
  Frecuencia;