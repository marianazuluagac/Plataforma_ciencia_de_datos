
/*
CASO 11 - PLATAFORMA DE SEGUIMIENTO DE PROYECTOS DE CIENCIA DE DATOS E IA
ARCHIVO: 06_pruebas_integridad.sql

OBJETIVO:
Comprobar que las restricciones y reglas de la base de datos funcionen.
Las pruebas utilizan transacciones para evitar guardar datos de prueba.
*/

USE Plataforma_Ciencia_Datos;
GO

PRINT '============================================';
PRINT 'INICIO DE PRUEBAS DE INTEGRIDAD';
PRINT '============================================';


-- ============================================
-- PRUEBA 1. CORREO DUPLICADO
-- ============================================

PRINT 'PRUEBA 1: correo duplicado';

BEGIN TRY
    BEGIN TRANSACTION;

    INSERT INTO Cientifico (nombre, correo, especialidad)
    SELECT TOP 1
        'Cientifico de prueba',
        correo,
        'Prueba'
    FROM Cientifico;

    ROLLBACK TRANSACTION;

    PRINT 'ERROR: se permitio registrar un correo duplicado.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    PRINT 'CORRECTO: se rechazo el correo duplicado.';
    PRINT ERROR_MESSAGE();
END CATCH;
GO


-- ============================================
-- PRUEBA 2. CLAVE FORANEA INEXISTENTE
-- ============================================

PRINT 'PRUEBA 2: clave foranea inexistente';

BEGIN TRY
    BEGIN TRANSACTION;

    INSERT INTO Participacion
        (id_cientifico, id_proyecto, rol, fecha_inicio, fecha_fin)
    SELECT TOP 1
        id_cientifico,
        999999,
        'Investigador',
        '2026-01-01',
        NULL
    FROM Cientifico;

    ROLLBACK TRANSACTION;

    PRINT 'ERROR: se permitio una referencia inexistente.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    PRINT 'CORRECTO: se rechazo la clave foranea inexistente.';
    PRINT ERROR_MESSAGE();
END CATCH;
GO


-- ============================================
-- PRUEBA 3. TAMANO NEGATIVO EN DATASET
-- ============================================

PRINT 'PRUEBA 3: tamano negativo de dataset';

BEGIN TRY
    BEGIN TRANSACTION;

    INSERT INTO Dataset
        (codigo_dataset, nombre, fuente, fecha_incorporacion,
         tamano, formato, clasificacion_sensibilidad)
    VALUES
        ('PRUEBA-NEGATIVO', 'Dataset de prueba', 'Prueba',
         GETDATE(), -10, 'CSV', 'Publico');

    ROLLBACK TRANSACTION;

    PRINT 'ERROR: se permitio un tamano negativo.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    PRINT 'CORRECTO: se rechazo el tamano negativo.';
    PRINT ERROR_MESSAGE();
END CATCH;
GO


-- ============================================
-- PRUEBA 4. FECHAS INVALIDAS EN PROYECTO
-- ============================================

PRINT 'PRUEBA 4: fecha de inicio posterior a fecha final';

BEGIN TRY
    BEGIN TRANSACTION;

    INSERT INTO Proyecto
        (codigo_proyecto, nombre, descripcion, fecha_inicio,
         fecha_fin, estado, id_responsable)
    SELECT TOP 1
        'PRUEBA-' + LEFT(CONVERT(VARCHAR(36), NEWID()), 8),
        'Proyecto de prueba',
        'Registro temporal para validar fechas',
        '2026-12-20',
        '2026-01-01',
        'En curso',
        id_cientifico
    FROM Cientifico;

    ROLLBACK TRANSACTION;

    PRINT 'ERROR: se permitieron fechas incorrectas.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    PRINT 'CORRECTO: se rechazaron las fechas incorrectas.';
    PRINT ERROR_MESSAGE();
END CATCH;
GO


-- ============================================
-- PRUEBA 5. METRICA FUERA DEL RANGO PERMITIDO
-- ============================================

PRINT 'PRUEBA 5: metrica fuera del rango permitido';

DECLARE @IdModelo INT;
DECLARE @IdTipoMetrica INT;

SELECT TOP 1 @IdModelo = id_modelo
FROM Modelo;

SELECT TOP 1 @IdTipoMetrica = id_tipo_metrica
FROM Tipo_Metrica
WHERE nombre = 'Accuracy';

IF @IdModelo IS NOT NULL AND @IdTipoMetrica IS NOT NULL
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO Metrica
            (id_modelo, id_tipo_metrica, valor,
             fecha_evaluacion, conjunto_evaluacion)
        VALUES
            (@IdModelo, @IdTipoMetrica, 1.5,
             GETDATE(), 'Prueba');

        ROLLBACK TRANSACTION;

        PRINT 'ERROR: se permitio una metrica fuera del rango.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        PRINT 'CORRECTO: se rechazo la metrica fuera del rango.';
        PRINT ERROR_MESSAGE();
    END CATCH;
END
ELSE
BEGIN
    PRINT 'PRUEBA OMITIDA: no se encontro un modelo o la metrica Accuracy.';
END;
GO


PRINT '============================================';
PRINT 'FINALIZARON LAS PRUEBAS DE INTEGRIDAD';
PRINT '============================================';
GO
