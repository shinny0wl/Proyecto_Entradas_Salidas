-- LECTURA DE LOS DATOS DE CADA TABLA PARA LA CREACION DE LOS CSV

-- Tabla EntradaEncabezado
SELECT
    UPPER(TRIM(ee.[Empresa])) AS Empresa,
    UPPER(TRIM(ee.[Folio])) AS Folio,
    ee.[Fecha] AS Fecha,
    UPPER(TRIM(ee.[Cliente])) AS ClienteID,
    UPPER(TRIM(ee.[Moneda])) AS Moneda,
    UPPER(TRIM(ee.[Vendedor])) AS VendedorID,
    ee.[pctDescuentoGlobal],
    ee.[TotalImporte],
    ee.[TotalDescuento],
    ee.[TotalImpuesto],
    ee.[Total]
FROM [AutopartesO2025].[dbo].[EntradaEncabezado] ee

-- Tabla EntradaDetalle
SELECT
    UPPER(TRIM(ed.[Empresa])) AS Empresa,
    UPPER(TRIM(ed.[Folio])) AS Folio,
    ed.[Partida],
    UPPER(TRIM(ed.[Articulo])) AS Articulo,
    UPPER(TRIM(ed.[Almacen])) AS Almacen,
    UPPER(TRIM(ed.[Ubicacion])) AS Ubicacion,
    UPPER(TRIM(ed.[DescripcionArticulo])) AS Descripcion_Articulo,
    UPPER(TRIM(ed.[CodigoAlternoArticulo])) AS Codigo_Articulo,
    ed.[Cantidad],
    UPPER(TRIM(ed.[UMedPartida])) AS Unidad,
    ed.[CantidadUMedInv],
    ed.[Precio],
    ed.[pctDescuento],
    ed.[pctImpuesto],
    ed.[TotalImporte],
    ed.[TotalDescuento],
    ed.[TotalImpuesto],
    ed.[Total]
FROM [AutopartesO2025].[dbo].[EntradaDetalle] ed

-- Tabla SalidaEncabezado
SELECT
    UPPER(TRIM(se.[Empresa])) AS Empresa,
    UPPER(TRIM(se.[Folio])) AS Folio,
    se.[Fecha],
    UPPER(TRIM(se.[Cliente])) AS ClienteID,
    UPPER(TRIM(se.[Moneda])) AS Moneda,
    UPPER(TRIM(se.[CondicionPago])) AS Condicion_Pago,
    UPPER(TRIM(se.[MedioEmbarque])) AS Embarque,
    UPPER(TRIM(se.[Vendedor])) AS Vendedor,
    se.[pctDescuentoGlobal],
    se.[TotalImporte],
    se.[TotalDescuento],
    se.[TotalImpuesto],
    se.[Total]
FROM [AutopartesO2025].[dbo].[SalidaEncabezado] se

-- Tabla SalidaDetalle
SELECT
    UPPER(TRIM(sd.[Empresa])) AS Empresa,
    UPPER(TRIM(sd.[Folio])) AS Folio,
    sd.[Partida],
    UPPER(TRIM(sd.[Articulo])) AS ArticuloID,
    UPPER(TRIM(sd.[Almacen])) AS Almacen,
    UPPER(TRIM(sd.[Ubicacion])) AS Ubicacion,
    UPPER(TRIM(sd.[DescripcionArticulo])) AS Descripcion_Articulo,
    sd.[Cantidad],
    UPPER(TRIM(sd.[UMedPartida])) AS Unidad,
    sd.[CantidadUMedInv],
    sd.[Precio],
    sd.[pctDescuento],
    sd.[pctImpuesto],
    sd.[TotalImporte],
    sd.[TotalDescuento],
    sd.[TotalImpuesto],
    sd.[Total]
  FROM [AutopartesO2025].[dbo].[SalidaDetalle] sd

-- Tabla Articulo
SELECT
    UPPER(TRIM(a.[clave])) AS ArticuloID,
    UPPER(TRIM(a.[Descripcion])) AS Descripcion_Articulo,
    UPPER(TRIM(a.[ArticuloTipo])) AS Articulo_Tipo,
    UPPER(TRIM(a.[ArticuloGrupo])) AS Articulo_Grupo,
    UPPER(TRIM(a.[ArticuloClase])) AS Articulo_Clase,
    UPPER(TRIM(a.[Moneda])) AS Moneda,
    a.[Precio]
FROM [AutopartesO2025].[dbo].[Articulo] a

-- Tabla ArticuloTipo
SELECT
    UPPER(TRIM(at.[Clave])) AS Articulo_Tipo,
    UPPER(TRIM(at.[Descripcion])) AS Descripcion_Tipo
FROM [AutopartesO2025].[dbo].[ArticuloTipo] at

-- Tabla ArticuloGrupo
SELECT
    UPPER(TRIM(ag.[Clave])) AS Articulo_Grupo,
    UPPER(TRIM(ag.[Descripcion])) AS Descripcion_Grupo
FROM [AutopartesO2025].[dbo].[ArticuloGrupo] ag

-- Tabla ArticuloClase
SELECT
    UPPER(TRIM(ac.[Clave])) AS Articulo_Clase,
    UPPER(TRIM(ac.[Descripcion])) AS Descripcion_Clase
FROM [AutopartesO2025].[dbo].[ArticuloClase] ac

-- Tabla Cliente
SELECT
    UPPER(TRIM(c.[Clave])) AS ClienteID,
    UPPER(TRIM(c.[Ciudad])) AS Ciudad,
    UPPER(TRIM(c.[Estado]))AS Estado,
    UPPER(TRIM(c.[Pais])) AS Pais,
    UPPER(TRIM(c.[Vendedor])) AS VendedorID,
    UPPER(TRIM(c.[Moneda])) AS Moneda,
    UPPER(TRIM(c.[CondicionPago])) AS Condicion_Pago
FROM [AutopartesO2025].[dbo].[Cliente] c

-- Tabla Vendedor
SELECT
    UPPER(TRIM(v.[Clave])) AS VendedorID,
    UPPER(TRIM(v.[Nombre])) AS Nombre
FROM [AutopartesO2025].[dbo].[Vendedor] v

-- Tabla Moneda
SELECT
    UPPER(TRIM(m.[Clave])) AS Moneda,
    UPPER(TRIM(m.[Descripcion])) AS Descripcion_Moneda
FROM [AutopartesO2025].[dbo].[Moneda] m

-- Tabla MedioEmbarque
SELECT
    UPPER(TRIM(e.[Clave])) AS Embarque,
    UPPER(TRIM(e.[Descripcion])) AS Descripcion_Embarque 
FROM [AutopartesO2025].[dbo].[MedioEmbarque] e

-- Tabla CondicionPago
SELECT
    UPPER(TRIM(cp.[Clave])) AS Condicion_Pago,
    UPPER(TRIM(cp.[Descripcion])) AS Descripcion_Pago
FROM [AutopartesO2025].[dbo].[CondicionPago] cp