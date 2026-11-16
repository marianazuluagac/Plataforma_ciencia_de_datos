
USE Plataforma_Ciencia_Datos;
GO

-- =============================================
-- 1. VALIDAR FECHAS DE LOS PROYECTOS
-- =============================================

ALTER TABLE Proyecto
ADD CONSTRAINT CK_Proyecto_Fechas
CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio);
GO

-- =============================================
-- 2. VALIDAR FECHAS DE PARTICIPACION
-- =============================================

ALTER TABLE Participacion
ADD CONSTRAINT CK_Participacion_Fechas
CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio);
GO

-- =============================================
-- 3. VALIDAR ESTADOS DE LOS EXPERIMENTOS
-- =============================================

ALTER TABLE Experimento
ADD CONSTRAINT CK_Experimento_Estado
CHECK (estado IN ('En curso', 'Finalizado', 'Cancelado'));
GO

-- =============================================
-- 4. VALIDAR EL TIPO DE USO DE LOS DATASETS
-- =============================================

ALTER TABLE Experimento_Dataset
ADD CONSTRAINT CK_ExperimentoDataset_TipoUso
CHECK (tipo_uso IN ('Entrenamiento', 'Validación', 'Prueba'));
GO

-- =============================================
-- 5. VALIDAR RANGOS DE LOS TIPOS DE METRICAS
-- =============================================

-- Esta restricción ya está creada en el script 01.
-- Garantiza que el rango minimo no sea mayor
-- que el rango maximo.

-- =============================================
-- 6. TRIGGER PARA VALIDAR LAS METRICAS
-- =============================================

CREATE OR ALTER TRIGGER TR_Validar_Rango_Metrica
ON Metrica
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted I
        INNER JOIN Tipo_Metrica TM
            ON I.id_tipo_metrica = TM.id_tipo_metrica
        WHERE
            (TM.rango_minimo IS NOT NULL
             AND I.valor < TM.rango_minimo)
            OR
            (TM.rango_maximo IS NOT NULL
             AND I.valor > TM.rango_maximo)
    )
    BEGIN
        THROW 50001,
        'Error: el valor de la metrica esta fuera del rango permitido.',
        1;
    END
END;
GO

-- =============================================
-- 7. CONSULTAR LAS RESTRICCIONES CREADAS
-- =============================================

SELECT
    name AS Nombre_Restriccion,
    type_desc AS Tipo
FROM sys.objects
WHERE type = 'C'
AND parent_object_id IN (
    OBJECT_ID('Proyecto'),
    OBJECT_ID('Participacion'),
    OBJECT_ID('Experimento'),
    OBJECT_ID('Experimento_Dataset')
)
ORDER BY name;
GO

-- Verificar el trigger

SELECT
    name AS Nombre_Trigger,
    is_disabled AS Deshabilitado
FROM sys.triggers
WHERE name = 'TR_Validar_Rango_Metrica';
GO
