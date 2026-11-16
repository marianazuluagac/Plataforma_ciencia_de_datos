# Pruebas de integridad – Caso 11

## 1. Objetivo

Comprobar que la base de datos Plataforma_Ciencia_Datos cumpla las restricciones y reglas establecidas, evitando que se almacenen datos incorrectos o que no tengan relación con la información registrada.

## 2. Pruebas realizadas

Se ejecutaron cinco pruebas en SQL Server Management Studio para verificar el funcionamiento de las restricciones de integridad.

| N.º | Prueba | Resultado esperado | Resultado obtenido |
|---|---|---|---|
| 1 | Registrar un científico con un correo duplicado | Rechazar el registro | Correcto |
| 2 | Registrar una participación con un proyecto inexistente | Rechazar la clave foránea | Correcto |
| 3 | Registrar un dataset con tamaño negativo | Rechazar el valor | Correcto |
| 4 | Registrar un proyecto con fecha de inicio posterior a la fecha final | Rechazar las fechas | Correcto |
| 5 | Registrar una métrica Accuracy con valor fuera del rango permitido | Rechazar la métrica | Correcto |

## 3. Resultados obtenidos

Todas las pruebas se ejecutaron correctamente. SQL Server rechazó los registros que no cumplían las reglas definidas.

- El correo duplicado fue rechazado por la restricción de unicidad.
- La participación con una referencia inexistente fue rechazada por la clave foránea.
- El tamaño negativo fue rechazado por la restricción CHECK.
- Las fechas incorrectas fueron rechazadas por la restricción de fechas del proyecto.
- La métrica fuera del rango permitido fue rechazada por el trigger de validación.

Las pruebas utilizaron transacciones y operaciones de reversión (ROLLBACK), evitando conservar los registros temporales.

## 4. Conclusión

Los resultados permiten comprobar que las restricciones y reglas de integridad de la base de datos están funcionando correctamente.

También se verificó que el trigger encargado de validar el rango de las métricas impide registrar valores que no corresponden con los límites establecidos.

En conclusión, las cinco pruebas realizadas fueron satisfactorias y permiten confirmar que la base de datos cuenta con controles para evitar información incorrecta. 