/*
=====================================================
PROYECTO: CASO 11
PLATAFORMA DE SEGUIMIENTO DE PROYECTOS DE CIENCIA
DE DATOS E INTELIGENCIA ARTIFICIAL

ARCHIVO: 00_reiniciar_base_datos.sql

DESCRIPCION:
Permite eliminar la base de datos Plataforma_Ciencia_Datos
para iniciar nuevamente el proyecto desde cero.

ADVERTENCIA:
Este proceso elimina todas las tablas y todos los datos
almacenados en la base de datos.
=====================================================
*/

USE master;
GO

-- =============================================
-- 1. CONFIRMACION DE SEGURIDAD
-- =============================================

DECLARE @Confirmar BIT = 0;

IF @Confirmar <> 1
BEGIN
    PRINT 'REINICIO CANCELADO.';
    PRINT 'Para continuar, cambia @Confirmar = 0 por @Confirmar = 1.';
    RETURN;
END;
GO

-- =============================================
-- 2. VERIFICAR SI EXISTE LA BASE DE DATOS
-- =============================================

IF DB_ID('Plataforma_Ciencia_Datos') IS NOT NULL
BEGIN
    PRINT 'Se encontro la base de datos.';
    PRINT 'Iniciando proceso de eliminacion...';

    ALTER DATABASE Plataforma_Ciencia_Datos
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    DROP DATABASE Plataforma_Ciencia_Datos;

    PRINT 'La base de datos fue eliminada correctamente.';
END
ELSE
BEGIN
    PRINT 'La base de datos no existe.';
    PRINT 'No hay nada que eliminar.';
END;
GO

-- =============================================
-- 3. FINALIZAR
-- =============================================

PRINT 'Proceso de reinicio finalizado.';
PRINT 'Ahora puedes ejecutar el script 01_crear_base_y_tablas.sql.';
GO
