// 3.1.1
MATCH (a1:Articulo), (a2:Articulo)
WHERE trim(a1.ArticuloID) = '3241-5351A'
  AND trim(a2.ArticuloID) = '442-1116R'

MATCH (a1)<-[:COMPRA]-(ed1:Entrada_Detalle)-[:DETALLA]->(e:Entrada)
MATCH (a2)<-[:COMPRA]-(ed2:Entrada_Detalle)-[:DETALLA]->(e)

WITH DISTINCT e.Folio AS Folio, a1, a2
RETURN
  a1.ArticuloID AS Articulo1,
  a2.ArticuloID AS Articulo2,
  collect(Folio) AS Folios_en_comun,
  count(Folio)   AS NumFolios;

// 3.1.2
MATCH (a1:Articulo), (a2:Articulo)
WHERE trim(a1.ArticuloID) = 'SFSD99R'
  AND trim(a2.ArticuloID) = '5624'

MATCH (a1)<-[:COMPRA]-(ed1:Entrada_Detalle)-[:DETALLA]->(e:Entrada)
MATCH (a2)<-[:COMPRA]-(ed2:Entrada_Detalle)-[:DETALLA]->(e)

WITH DISTINCT e.Folio AS Folio, a1, a2
RETURN
  a1.ArticuloID AS Articulo1,
  a2.ArticuloID AS Articulo2,
  collect(Folio) AS Folios_en_comun,
  count(Folio)   AS NumFolios;

// 3.1.3
MATCH (a1:Articulo), (a2:Articulo), (a3:Articulo)
WHERE trim(a1.ArticuloID) = 'BFNPU94L'
  AND trim(a2.ArticuloID) = 'SNSE01L'

MATCH (a1)<-[:COMPRA]-(ed1:Entrada_Detalle)-[:DETALLA]->(e:Entrada)
MATCH (a2)<-[:COMPRA]-(ed2:Entrada_Detalle)-[:DETALLA]->(e)

WITH DISTINCT e.Folio AS Folio, a1, a2
RETURN
  a1.ArticuloID AS Articulo1,
  a2.ArticuloID AS Articulo2,
  collect(Folio) AS Folios_en_comun,
  count(Folio)   AS NumFolios;

// 3.1.4
MATCH (a1:Articulo)
WHERE trim(a1.ArticuloID) = '3176-5388'

MATCH (a1)<-[:COMPRA]-(ed1:Entrada_Detalle)-[:DETALLA]->(e:Entrada)
MATCH (e)<-[:DETALLA]-(ed2:Entrada_Detalle)-[:COMPRA]->(a2:Articulo)
WHERE a2 <> a1

WITH a1, a2, count(DISTINCT e) AS Frecuencia
ORDER BY Frecuencia DESC

RETURN
  a1.ArticuloID AS Articulo_Original,
  a2.ArticuloID AS Articulo_Recomendado,
  Frecuencia    AS Num_Articulos_Recomendados;

// 3.1.5
MATCH (a1:Articulo)
WHERE trim(a1.ArticuloID) = '333-1104L'
MATCH (a1)-[:CLASE]->(clase:Articulo_Clase)

MATCH (a1)<-[:COMPRA]-(ed1:Entrada_Detalle)-[:DETALLA]->(e:Entrada)
MATCH (e)<-[:DETALLA]-(ed2:Entrada_Detalle)-[:COMPRA]->(a2:Articulo)
MATCH (a2)-[:CLASE]->(clase)
WHERE a2 <> a1

WITH a1, a2, count(DISTINCT e) AS Frecuencia
ORDER BY Frecuencia DESC

RETURN
  a1.ArticuloID AS Articulo_Original,
  a1.Articulo_Clase AS Clase_Articulo_Original,
  a2.ArticuloID AS Articulo_Recomendado,
  a2.Articulo_Clase AS Clase_Articulo_Recomendado,
  Frecuencia

// 3.1.6
MATCH (a1:Articulo)
WHERE trim(a1.ArticuloID) = '460267'
MATCH (a1)-[:TIPO]->(tipo:Articulo_Tipo)

MATCH (a1)<-[:COMPRA]-(ed1:Entrada_Detalle)-[:DETALLA]->(e:Entrada)
MATCH (e)<-[:DETALLA]-(ed2:Entrada_Detalle)-[:COMPRA]->(a2:Articulo)
MATCH (a2)-[:TIPO]->(tipo)
WHERE a2 <> a1

WITH a1, a2, count(DISTINCT e) AS Frecuencia
ORDER BY Frecuencia DESC

RETURN
  a1.ArticuloID AS Articulo_Original,
  a1.Articulo_Tipo AS Tipo_Articulo_Original,
  a2.ArticuloID AS Articulo_Recomendado,
  a2.Articulo_Tipo AS Tipo_Articulo_Recomendado, 
  Frecuencia

// 3.1.7
MATCH (a1:Articulo)
WHERE trim(a1.ArticuloID) = 'PPCPU92'
MATCH (a1)-[:GRUPO]->(grupo:Articulo_Grupo)

MATCH (a1)<-[:COMPRA]-(ed1:Entrada_Detalle)-[:DETALLA]->(e:Entrada)
MATCH (e)<-[:DETALLA]-(ed2:Entrada_Detalle)-[:COMPRA]->(a2:Articulo)
MATCH (a2)-[:GRUPO]->(grupo)
WHERE a2 <> a1

WITH a1, a2, count(DISTINCT e) AS Frecuencia
ORDER BY Frecuencia DESC

RETURN
  a1.ArticuloID AS Articulo_Original,
  a1.Articulo_Grupo AS Grupo_Articulo_Original,
  a2.ArticuloID AS Articulo_Recomendado,
  a2.Articulo_Grupo AS Grupo_Articulo_Recomendado,
  Frecuencia