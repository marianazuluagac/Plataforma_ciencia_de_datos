# Diccionario de datos
## Caso 11 - Plataforma de ciencia de datos e inteligencia artificial

En este documento se describen las tablas de la base de datos, sus campos, tipos de datos y algunas de sus características.

## 1. Cientifico

Guarda la información de los científicos que trabajan en los proyectos.

| Campo | Tipo de dato | Descripción |
|---|---|---|
| id_cientifico | INT | Identificador del científico (PK). |
| nombre | VARCHAR(100) | Nombre del científico. |
| correo | VARCHAR(150) | Correo electrónico, no se puede repetir. |
| especialidad | VARCHAR(100) | Especialidad del científico. |

## 2. Proyecto

Guarda la información de los proyectos que se realizan.

| Campo | Tipo de dato | Descripción |
|---|---|---|
| id_proyecto | INT | Identificador del proyecto (PK). |
| codigo_proyecto | VARCHAR(30) | Código único del proyecto. |
| nombre | VARCHAR(150) | Nombre del proyecto. |
| descripcion | VARCHAR(MAX) | Descripción del proyecto. |
| fecha_inicio | DATE | Fecha en la que inicia. |
| fecha_fin | DATE | Fecha en la que termina. |
| estado | VARCHAR(30) | Estado del proyecto. |
| id_responsable | INT | Científico encargado del proyecto (FK). |

## 3. Participacion

Registra los científicos que participan en cada proyecto.

| Campo | Tipo de dato | Descripción |
|---|---|---|
| id_participacion | INT | Identificador de la participación (PK). |
| id_cientifico | INT | Científico que participa (FK). |
| id_proyecto | INT | Proyecto en el que participa (FK). |
| rol | VARCHAR(50) | Función que cumple en el proyecto. |
| fecha_inicio | DATE | Fecha de inicio de su participación. |
| fecha_fin | DATE | Fecha de finalización de su participación. |

También se utiliza una restricción UNIQUE sobre id_cientifico e id_proyecto para evitar repetir la misma participación.

## 4. Dataset

Almacena la información de los conjuntos de datos que se utilizan.

| Campo | Tipo de dato | Descripción |
|---|---|---|
| id_dataset | INT | Identificador del dataset (PK). |
| codigo_dataset | VARCHAR(30) | Código único del dataset. |
| nombre | VARCHAR(150) | Nombre del conjunto de datos. |
| fuente | VARCHAR(200) | De dónde provienen los datos. |
| fecha_incorporacion | DATE | Fecha en que se agregó. |
| tamano | DECIMAL(12,2) | Tamaño del dataset. |
| formato | VARCHAR(30) | Formato de los datos, por ejemplo CSV o JPG. |
| clasificacion_sensibilidad | VARCHAR(30) | Nivel de sensibilidad de los datos. |

## 5. Proyecto_Dataset

Relaciona los proyectos con los datasets que utilizan.

| Campo | Tipo de dato | Descripción |
|---|---|---|
| id_proyecto | INT | Identificador del proyecto (PK, FK). |
| id_dataset | INT | Identificador del dataset (PK, FK). |
| proposito | VARCHAR(150) | Para qué se utiliza el dataset. |
| fecha_asociacion | DATE | Fecha en que se relacionó con el proyecto. |

Esta tabla tiene una clave primaria compuesta por id_proyecto e id_dataset.

## 6. Experimento

Guarda los experimentos que se realizan en cada proyecto.

| Campo | Tipo de dato | Descripción |
|---|---|---|
| id_experimento | INT | Identificador del experimento (PK). |
| id_proyecto | INT | Proyecto al que pertenece (FK). |
| id_cientifico | INT | Científico encargado (FK). |
| fecha_experimento | DATE | Fecha en que se realizó el experimento. |
| version_codigo | VARCHAR(50) | Versión del código utilizado. |
| estado | VARCHAR(30) | Estado del experimento. |
| configuracion | NVARCHAR(MAX) | Configuración del experimento almacenada como texto. |

El estado tiene un valor por defecto de 'En curso' y una restricción para aceptar los estados permitidos.

## 7. Experimento_Dataset

Indica qué datasets se utilizaron en cada experimento y para qué se utilizaron.

| Campo | Tipo de dato | Descripción |
|---|---|---|
| id_experimento | INT | Identificador del experimento (PK, FK). |
| id_dataset | INT | Identificador del dataset (PK, FK). |
| tipo_uso | VARCHAR(30) | Indica si el dataset se utiliza para entrenamiento, validación o prueba. |

Tiene una clave primaria compuesta por id_experimento e id_dataset.

## 8. Modelo

Guarda los modelos que se crean a partir de los experimentos.

| Campo | Tipo de dato | Descripción |
|---|---|---|
| id_modelo | INT | Identificador del modelo (PK). |
| id_experimento | INT | Experimento del que salió el modelo (FK). |
| nombre | VARCHAR(150) | Nombre del modelo. |
| version | VARCHAR(50) | Versión del modelo. |
| algoritmo | VARCHAR(100) | Algoritmo utilizado. |
| fecha_creacion | DATE | Fecha de creación del modelo. |
| estado | VARCHAR(30) | Estado actual del modelo. |

## 9. Tipo_Metrica

Guarda los tipos de métricas que se pueden utilizar para evaluar los modelos.

| Campo | Tipo de dato | Descripción |
|---|---|---|
| id_tipo_metrica | INT | Identificador del tipo de métrica (PK). |
| nombre | VARCHAR(100) | Nombre de la métrica, por ejemplo Accuracy o MAE. |
| descripcion | VARCHAR(250) | Explicación de la métrica. |
| unidad | VARCHAR(50) | Unidad en la que se mide. |
| rango_minimo | DECIMAL(18,6) | Valor mínimo permitido o de referencia. |
| rango_maximo | DECIMAL(18,6) | Valor máximo permitido o de referencia. |

## 10. Metrica

Guarda los resultados que obtienen los modelos cuando son evaluados.

| Campo | Tipo de dato | Descripción |
|---|---|---|
| id_metrica | INT | Identificador de la métrica (PK). |
| id_modelo | INT | Modelo que se está evaluando (FK). |
| id_tipo_metrica | INT | Tipo de métrica utilizada (FK). |
| valor | DECIMAL(18,6) | Resultado obtenido. |
| fecha_evaluacion | DATE | Fecha en que se realizó la evaluación.