📦 Proyecto: Recomendación de Artículos en Entradas y Salidas de Almacén
Data Warehouse · Neo4j · KNIME · Tableau
📘 Descripción General

Este proyecto implementa un sistema completo de recomendación de artículos basado en:

Bases de datos de grafos (Neo4j)

Cálculo de co-ocurrencias entre artículos en movimientos de entrada y salida de almacén

Procesos ETL con KNIME

Integración al Data Warehouse en modelo de constelación

Visualización dinámica en Tableau

El objetivo es identificar artículos que aparecen juntos en el mismo folio y, con base en su frecuencia, generar recomendaciones inteligentes que permitan sugerir productos relacionados durante el proceso de compra o inventario.

🏗️ 1. Modelo en Neo4j
🔹 1.1 Carga de nodos

Se importaron las tablas del sistema transaccional mediante APOC y LOAD CSV, creando nodos como:

Entrada, Entrada_Detalle

Salida, Salida_Detalle

Articulo

Catálogos: Articulo_Tipo, Articulo_Grupo, Articulo_Clase

Cliente, Vendedor, Moneda, Embarque, Condicion_Pago

Ejemplo general:

CALL apoc.periodic.iterate(
  'LOAD CSV WITH HEADERS FROM "file:///EntradaEncabezado.csv" AS row RETURN row',
  'CREATE (n:Entrada) SET n = row',
  {batchSize:10000}
);

✔ Se crearon índices en todas las claves principales

Esto acelera las búsquedas y la creación de relaciones.

🔹 1.2 Creación de relaciones

Se modelaron las relaciones que representan la lógica de negocio:

Entrada —SE_PAGA_EN→ Moneda

Entrada —SE_VENDE_A→ Cliente

Entrada_Detalle —DETALLA→ Entrada

Entrada_Detalle —COMPRA→ Articulo

Articulo —TIPO→ Articulo_Tipo

Articulo —GRUPO→ Articulo_Grupo

Articulo —CLASE→ Articulo_Clase

Ejemplo:

MATCH (ed:Entrada_Detalle), (e:Entrada)
WHERE ed.Folio = e.Folio
MERGE (ed)-[:DETALLA]->(e);


Este modelo permite navegar fácilmente desde un movimiento hasta sus artículos, tipo, clase, cliente, etc.

🔎 2. Generación de Recomendaciones

La lógica de recomendación se basa en encontrar pares de artículos que co-ocurren en el mismo folio.

🔹 2.1 Recomendaciones para Entradas

Patrón principal:

MATCH
(a1:Articulo)<-[:COMPRA]-(ed1:Entrada_Detalle)-[:DETALLA]->(e:Entrada)
<-[:DETALLA]-(ed2:Entrada_Detalle)-[:COMPRA]->(a2:Articulo)
WHERE a1 < a2   // evita duplicados A-B y B-A
RETURN
  a1.ArticuloID AS Articulo_Original,
  a2.ArticuloID AS Recomendacion,
  count(e) AS Frecuencia;

🔹 2.2 Recomendaciones para Salidas

La misma lógica se aplica reemplazando Entrada por Salida.

🔹 2.3 Exportación a CSV desde Neo4j (usado en KNIME)
CALL apoc.export.csv.query(
  'MATCH ... RETURN ...',
  "file:////recomendaciones_entradas.csv",
  {batchSize:10000}
);


Se generaron dos archivos:

dim_articulo_recomendaciones_entradas.csv

dim_articulo_recomendaciones_salidas.csv

🛠️ 3. Integración al Data Warehouse

El DW sigue un modelo de constelación con dos estrellas principales:

⭐ FactEntradasRecomendacion
⭐ FactSalidasRecomendacion

Cada una contiene:

Artículo base

Artículo recomendado

Frecuencia

Relación a dimensiones duplicadas:

DimArticulo

DimArticuloRecomendado

✔ Dimensiones enriquecidas

Las dimensiones de artículo incluyen:

Tipo

Grupo

Clase

Descripción

Claves de catálogo

De esta forma, Tableau puede filtrar recomendaciones por:

🟦 Misma clase

🟩 Mismo grupo

🟧 Mismo tipo

📊 4. Dashboards en Tableau

Se construyeron dos tableros interactivos:

🔹 Tablero de Recomendaciones de Entradas
🔹 Tablero de Recomendaciones de Salidas

Cada tablero permite:

Seleccionar un artículo por nombre o descripción

Ver las siguientes recomendaciones:

Top 5 generales

Top 5 por misma clase

Top 5 por mismo grupo

Top 5 por mismo tipo

Cada recomendación muestra:

Artículo recomendado

Frecuencia de co-ocurrencia histórica

Clasificación del artículo recomendado

Además, se presentan 15 casos de prueba donde se seleccionan distintos artículos y se valida la consistencia de las recomendaciones.

🧪 5. Casos de Prueba

Los casos de prueba consisten en validar con Cypher que el tablero refleja fielmente el histórico en Neo4j.

Ejemplos:

✔ Encontrar folios donde dos artículos aparecen juntos
MATCH (a1:Articulo), (a2:Articulo)
WHERE trim(a1.ArticuloID)='3241-5351A'
  AND trim(a2.ArticuloID)='442-1116R'
MATCH (a1)<-[:COMPRA]-(ed1)-[:DETALLA]->(e:Entrada)
MATCH (a2)<-[:COMPRA]-(ed2)-[:DETALLA]->(e)
RETURN collect(e.Folio), count(e.Folio);

✔ Ver artículos recomendados de la misma clase
MATCH (a1:Articulo {ArticuloID:'333-1104L'})-[:CLASE]->(cl)
MATCH (a1)<-[:COMPRA]-(ed1)-[:DETALLA]->(e:Entrada)
MATCH (e)<-[:DETALLA]-(ed2)-[:COMPRA]->(a2:Articulo)-[:CLASE]->(cl)
RETURN a2.ArticuloID, count(e) AS Frecuencia;


Se realizaron los 14 casos (7 de entradas, 7 de salidas) para validar el modelo.

📝 6. Conclusiones

Neo4j permitió identificar relaciones no evidentes entre artículos que frecuentemente se compran o se venden juntos.

KNIME automatizó la extracción y transformación de datos hacia el DW.

Tableau facilitó la creación de un tablero dinámico que ayuda a la toma de decisiones.

El modelo permite extenderse a nuevas formas de recomendación (por temporada, cliente, sucursal, etc.).

👥 Autores

	
Alan Daniel Ríos López | 734869
Paulina Flores Sánchez | 745570 
Sergio David Elizondo Silva | 745602

Equipo de proyecto de Almacenes de Datos

Profesor: Dr. Víctor Ortega

📂 Estructura del repositorio
├── neo4j/
│   ├── carga_nodos.cypher
│   ├── carga_relaciones.cypher
│   ├── recomendaciones_entradas.cypher
│   ├── recomendaciones_salidas.cypher
│
├── csv/
│   ├── EntradaEncabezado.csv
│   ├── EntradaDetalle.csv
│   ├── SalidaEncabezado.csv
│   ├── SalidaDetalle.csv
│   ├── Articulo.csv
│   ├── recomendaciones_entradas.csv
│   ├── recomendaciones_salidas.csv
│
├── dw/
│   ├── DimArticulo.sql
│   ├── FactRecomendacionesEntradas.sql
│   ├── FactRecomendacionesSalidas.sql
│
├── tableau/
│   ├── Dashboard Entradas.twbx
│   ├── Dashboard Salidas.twbx
│
└── README.md   ← (este archivo)
