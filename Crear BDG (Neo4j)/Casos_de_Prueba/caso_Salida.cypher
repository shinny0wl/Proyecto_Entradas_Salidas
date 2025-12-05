// 3.2.1
MATCH (a1:Articulo), (a2:Articulo)
WHERE trim(a1.ArticuloID) = 'CVGO87'
  AND trim(a2.ArticuloID) = '333-1610L'

MATCH (a1)<-[:COMPRA]-(sd1:Salida_Detalle)-[:DETALLA]->(s:Salida)
MATCH (a2)<-[:COMPRA]-(sd2:Salida_Detalle)-[:DETALLA]->(s)

WITH DISTINCT s.Folio AS Folio
RETURN
  collect(Folio) AS Folios_en_comun,
  count(Folio)   AS NumFolios;

// 3.2.2
MATCH (a1:Articulo), (a2:Articulo)
WHERE trim(a1.ArticuloID) = 'PFES94'
  AND trim(a2.ArticuloID) = 'BTDGC93P'

MATCH (a1)<-[:COMPRA]-(sd1:Salida_Detalle)-[:DETALLA]->(s:Salida)
MATCH (a2)<-[:COMPRA]-(sd2:Salida_Detalle)-[:DETALLA]->(s)

WITH DISTINCT s.Folio AS Folio
RETURN
  collect(Folio) AS Folios_en_comun,
  count(Folio)   AS NumFolios;

// 3.2.3
MATCH (a1:Articulo), (a2:Articulo), (a3:Articulo)
WHERE trim(a1.ArticuloID) = 'CHCNPU94'
  AND trim(a2.ArticuloID) = 'CFRA83'
  AND trim(a3.ArticuloID) = 'AQUI_VA_LA_TERCERA_CLAVE'

MATCH (a1)<-[:COMPRA]-(sd1:Salida_Detalle)-[:DETALLA]->(s:Salida)
MATCH (a2)<-[:COMPRA]-(sd2:Salida_Detalle)-[:DETALLA]->(s)
MATCH (a3)<-[:COMPRA]-(sd3:Salida_Detalle)-[:DETALLA]->(s)

WITH DISTINCT s.Folio AS Folio
RETURN
  collect(Folio) AS Folios_en_comun,
  count(Folio)   AS NumFolios;

// 3.2.4
MATCH (a1:Articulo)
WHERE trim(a1.ArticuloID) = 'ELFRA83NL'

MATCH (a1)<-[:COMPRA]-(sd1:Salida_Detalle)-[:DETALLA]->(s:Salida)
MATCH (s)<-[:DETALLA]-(sd2:Salida_Detalle)-[:COMPRA]->(a2:Articulo)
WHERE a2 <> a1

WITH a1, a2, count(DISTINCT s) AS Frecuencia
ORDER BY Frecuencia DESC

WITH a1,
     collect({ArticuloRecomendado:a2.ArticuloID, Frecuencia:Frecuencia}) AS Recs
RETURN
  a1.ArticuloID AS Articulo_Original,
  size(Recs)    AS NumArticulosRecomendados,
  Recs          AS DetalleRecomendaciones;

// 3.2.5
MATCH (a1:Articulo)
WHERE trim(a1.ArticuloID) = 'ELVGO93CL'
MATCH (a1)-[:CLASE]->(clase:Articulo_Clase)

MATCH (a1)<-[:COMPRA]-(sd1:Salida_Detalle)-[:DETALLA]->(s:Salida)
MATCH (s)<-[:DETALLA]-(sd2:Salida_Detalle)-[:COMPRA]->(a2:Articulo)
MATCH (a2)-[:CLASE]->(clase)      // misma clase
WHERE a2 <> a1

WITH a1, a2, count(DISTINCT s) AS Frecuencia
ORDER BY Frecuencia DESC

WITH a1,
     collect({ArticuloRecomendado:a2.ArticuloID, Frecuencia:Frecuencia}) AS Recs
RETURN
  a1.ArticuloID AS Articulo_Original,
  size(Recs)    AS NumRecomendadosMismaClase,
  Recs          AS DetalleRecomendacionesMismaClase;

// 3.2.6
MATCH (a1:Articulo)
WHERE trim(a1.ArticuloID) = 'PDDK91P'
MATCH (a1)-[:TIPO]->(tipo:Articulo_Tipo)

MATCH (a1)<-[:COMPRA]-(sd1:Salida_Detalle)-[:DETALLA]->(s:Salida)
MATCH (s)<-[:DETALLA]-(sd2:Salida_Detalle)-[:COMPRA]->(a2:Articulo)
MATCH (a2)-[:TIPO]->(tipo)        // mismo tipo
WHERE a2 <> a1

WITH a1, a2, count(DISTINCT s) AS Frecuencia
ORDER BY Frecuencia DESC

WITH a1,
     collect({ArticuloRecomendado:a2.ArticuloID, Frecuencia:Frecuencia}) AS Recs
RETURN
  a1.ArticuloID AS Articulo_Original,
  size(Recs)    AS NumRecomendadosMismoTipo,
  Recs          AS DetalleRecomendacionesMismoTipo;

// 3.2.7
MATCH (a1:Articulo)
WHERE trim(a1.ArticuloID) = 'SVJE99L'
MATCH (a1)-[:GRUPO]->(grupo:Articulo_Grupo)

MATCH (a1)<-[:COMPRA]-(sd1:Salida_Detalle)-[:DETALLA]->(s:Salida)
MATCH (s)<-[:DETALLA]-(sd2:Salida_Detalle)-[:COMPRA]->(a2:Articulo)
MATCH (a2)-[:GRUPO]->(grupo)      // mismo grupo
WHERE a2 <> a1

WITH a1, a2, count(DISTINCT s) AS Frecuencia
ORDER BY Frecuencia DESC

WITH a1,
     collect({ArticuloRecomendado:a2.ArticuloID, Frecuencia:Frecuencia}) AS Recs
RETURN
  a1.ArticuloID AS Articulo_Original,
  size(Recs)    AS NumRecomendadosMismoGrupo,
  Recs          AS DetalleRecomendacionesMismoGrupo;

