# Caso 11: Plataforma de seguimiento de proyectos de ciencia de datos e inteligencia artificial

## 1. Descripción del proyecto

Este proyecto consiste en el diseño e implementación de una base de datos relacional para una plataforma de seguimiento de proyectos de ciencia de datos e inteligencia artificial.

La plataforma permite organizar la información de los científicos, proyectos, participantes, conjuntos de datos, experimentos, modelos y métricas de evaluación. Su objetivo es facilitar el almacenamiento, consulta y seguimiento de la información relacionada con el desarrollo de proyectos de ciencia de datos e IA.

## 2. Objetivo general

Diseñar e implementar una base de datos que permita gestionar la información de los proyectos de ciencia de datos e inteligencia artificial, manteniendo la integridad de los datos y facilitando su consulta mediante instrucciones SQL.

## 3. Tecnologías utilizadas

- **Microsoft SQL Server:** sistema de gestión de bases de datos.
- **SQL Server Management Studio 22:** herramienta utilizada para crear y administrar la base de datos.
- **SQL:** lenguaje utilizado para la creación de tablas, restricciones, consultas y vistas.
- **Git y GitHub:** herramientas para el control de versiones y almacenamiento del proyecto.

## 4. Estructura de la base de datos

La base de datos se llama `Plataforma_Ciencia_Datos` y está compuesta por diez entidades:

| Entidad | Descripción |
|---|---|
| Cientifico | Almacena los datos de los científicos. |
| Proyecto | Registra los proyectos de ciencia de datos e IA. |
| Participacion | Relaciona científicos con proyectos y registra sus roles. |
| Dataset | Almacena información de los conjuntos de datos. |
| Proyecto_Dataset | Relaciona los proyectos con los datasets utilizados. |
| Experimento | Registra los experimentos realizados. |
| Experimento_Dataset | Indica qué datasets utiliza cada experimento y su tipo de uso. |
| Modelo | Almacena los modelos desarrollados en los experimentos. |
| Tipo_Metrica | Define los tipos de métricas y sus rangos permitidos. |
| Metrica | Registra los resultados de evaluación de los modelos. |

## 5. Organización de los archivos

Los archivos del proyecto se organizan de la siguiente manera:

- `documentacion/`: contiene el diccionario de datos y los documentos de diseño.
- `modelo/`: contiene los modelos de la base de datos.
- `scripts/`: contiene los scripts SQL para crear las tablas, insertar datos y realizar consultas.
- `evidencias/`: contiene capturas de pantalla que muestran el desarrollo y las pruebas del proyecto.

*Nota: las carpetas y nombres de archivos deben coincidir con la organización real del repositorio.*

## 6. Scripts SQL

Los scripts se ejecutan en el siguiente orden:

1. **01_crear_base_y_tablas.sql:** creación de la base de datos y sus diez tablas, con sus claves primarias y foráneas.
2. **02_restricciones_y_reglas.sql:** implementación de restricciones y reglas de integridad, incluyendo el trigger para validar los rangos de las métricas.
3. **03_datos_semilla.sql:** inserción de datos de ejemplo para probar la base de datos.
4. **04_consultas_negocio.sql:** consultas SQL para obtener información relevante sobre proyectos, experimentos, datasets, modelos y métricas.
5. **05_vistas.sql:** creación de vistas para facilitar la consulta de la información.

## 7. Reglas de integridad

La base de datos implementa diferentes reglas para mantener la consistencia de la información:

- Claves primarias para identificar cada registro.
- Claves foráneas para relacionar las tablas.
- Restricciones UNIQUE para evitar códigos y correos duplicados.
- Validación de fechas de inicio y finalización.
- Validación para que el tamaño de los datasets no sea negativo.
- Validación de los estados de los experimentos.
- Validación del tipo de uso de los datasets.
- Un trigger llamado `TR_Validar_Rango_Metrica` que comprueba que los valores de las métricas estén dentro de los rangos definidos en `Tipo_Metrica`.

## 8. Pruebas realizadas

Se realizaron pruebas de inserción de datos, consultas y validación de restricciones.

También se probó el trigger de métricas insertando un valor de Accuracy de 1.5, cuando el rango permitido estaba entre 0 y 1. La base de datos rechazó la operación y mostró el mensaje de error correspondiente, comprobando que la validación funciona correctamente.

## 9. Consideraciones

La implementación de este proyecto se realiza en Microsoft SQL Server. La configuración de los experimentos se almacena en el campo `configuracion` de la tabla `Experimento`, utilizando el tipo de dato `NVARCHAR(MAX)`.

## 10. Conclusión

El desarrollo de esta base de datos permitió aplicar conceptos de modelado relacional, creación de tablas, relaciones, claves primarias y foráneas, restricciones, consultas y vistas.

Además, se implementaron reglas para mantener la integridad de los datos y facilitar el seguimiento de los proyectos de ciencia de datos e inteligencia artificial.