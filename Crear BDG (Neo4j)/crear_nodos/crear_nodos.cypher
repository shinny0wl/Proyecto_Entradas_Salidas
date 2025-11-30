// Creacion de los nodos e indices

// Entrada
CALL apoc.periodic.iterate(
    'LOAD CSV WITH HEADERS FROM "file:///EntradaEncabezado.csv" AS row RETURN row',
    'CREATE (n: Entrada) SET n = row',
    {batchSize:10000, parallel:false}
)
CREATE INDEX Index_Entrada FOR (n: Entrada) ON (n.Folio)


// Entrada_Detalle
CALL apoc.periodic.iterate(
    'LOAD CSV WITH HEADERS FROM "file:///EntradaDetalle.csv" AS row RETURN row',
    'CREATE (n: Entrada_Detalle) SET n = row',
    {batchSize:10000, parallel:false}
)
CREATE INDEX Index_Entrada_Detalle FOR (n: Entrada_Detalle) ON (n.Folio)

// Salida
CALL apoc.periodic.iterate(
    'LOAD CSV WITH HEADERS FROM "file:///SalidaEncabezado.csv" AS row RETURN row',
    'CREATE (n: Salida) SET n = row',
    {batchSize:10000, parallel:false}
)
CREATE INDEX Index_Salida FOR (n: Salida) ON (n.Folio)

// Salida_Detalle
CALL apoc.periodic.iterate(
    'LOAD CSV WITH HEADERS FROM "file:///SalidaDetalle.csv" AS row RETURN row',
    'CREATE (n: Salida_Detalle) SET n = row',
    {batchSize:10000, parallel:false}
)
CREATE INDEX Index_Salida_Detalle FOR (n: Salida_Detalle) ON (n.Folio)

// Articulo
LOAD CSV WITH HEADERS FROM "file:///Articulo(ES).csv" AS row
CREATE (n: Articulo)
SET n = row;
CREATE INDEX Index_Articulo FOR (n: Articulo) ON (n.ArticuloID)

// Articulo_Tipo
LOAD CSV WITH HEADERS FROM "file:///ArticuloTipo.csv" AS row
CREATE (n: Articulo_Tipo)
SET n = row;
CREATE INDEX Index_Articulo_Tipo FOR (n: Articulo_Tipo) ON (n.Articulo_Tipo)

// Articulo_Grupo
LOAD CSV WITH HEADERS FROM "file:///ArticuloGrupo.csv" AS row
CREATE (n: Articulo_Grupo)
SET n = row;
CREATE INDEX Index_Articulo_Grupo FOR (n: Articulo_Grupo) ON (n.Articulo_Grupo)

// Articulo_Clase
LOAD CSV WITH HEADERS FROM "file:///ArticuloClase.csv" AS row
CREATE (n: Articulo_Clase)
SET n = row;
CREATE INDEX Index_Articulo_Clase FOR (n: Articulo_Clase) ON (n.Articulo_Clase)

// Cliente
LOAD CSV WITH HEADERS FROM "file:///Cliente(ES).csv" AS row
CREATE (n: Cliente)
SET n = row;
CREATE INDEX Index_Cliente FOR (n: Cliente) ON (n.Cliente)

// Vendedor
LOAD CSV WITH HEADERS FROM "file:///Vendedor(ES).csv" AS row
CREATE (n: Vendedor)
SET n = row;
CREATE INDEX Index_Vendedor FOR (n: Vendedor) ON (n.VendedorID)

// Moneda
LOAD CSV WITH HEADERS FROM "file:///Moneda(ES).csv" AS row
CREATE (n: Moneda)
SET n = row;
CREATE INDEX Index_Moneda FOR (n: Moneda) ON (n.Moneda)

// Embarque
LOAD CSV WITH HEADERS FROM "file:///MedioEmbarque.csv" AS row
CREATE (n: Embarque)
SET n = row;
CREATE INDEX Index_Embarque FOR (n: Embarque) ON (n.Embarque)

// Condicion_Pago
LOAD CSV WITH HEADERS FROM "file:///CondicionPago.csv" AS row
CREATE (n: Condicion_Pago)
SET n = row;
CREATE INDEX Index_Condicion_Pago FOR (n: Condicion_Pago) ON (n.Condicion_Pago)