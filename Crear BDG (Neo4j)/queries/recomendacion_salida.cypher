// Query para hacer las recomendaciones entre articulo 1 y articulo 2 de salidas

// Ejemplo de ejecucion en Neo4j
MATCH
(a1:Articulo)<-[:VENDE]-(sd1:Salida_Detalle)-[:DETALLA]->(s:Salida)<-[:DETALLA]-(sd2:Salida_Detalle)-[:VENDE]->(a2:Articulo)
WHERE a1 < a2 AND a1.ArticuloID = "100-1931Y"
RETURN
    a1.ArticuloID AS Articulo_Original,
    a2.ArticuloID AS Recomendacion,
    count(s) AS Frecuencia
ORDER BY Frecuencia DESC
LIMIT 10

// Query dentro de KNIME
CALL apoc.export.csv.query(
    'MATCH
    (a1:Articulo)<-[:VENDE]-(sd1:Salida_Detalle)-[:DETALLA]->(s:Salida)<-[:DETALLA]-(sd2:Salida_Detalle)-[:VENDE]->(a2:Articulo)
    WHERE a1 < a2
    RETURN
        a1.ArticuloID AS Articulo_Original,
        a2.ArticuloID AS Recomendacion,
        count(s) AS Frecuencia',
  "file:////recomendaciones_salidas.csv",
    { 
        batchSize: 10000, 
        parallel: false
    }
) 
YIELD file 
RETURN file