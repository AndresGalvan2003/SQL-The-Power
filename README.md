# Proyecto SQL - Shakila Database

## Descripción

Este proyecto consiste en la realización de una serie de consultas SQL sobre la base de datos Shakila utilizando PostgreSQL y DBeaver.

El objetivo principal ha sido practicar y consolidar conocimientos sobre SQL trabajando con una base de datos relacional real. A lo largo del proyecto he realizado consultas simples y avanzadas utilizando filtros, funciones de agregación, agrupaciones, subconsultas, vistas, tablas temporales y diferentes tipos de JOIN.

---

## Herramientas utilizadas

- PostgreSQL
- DBeaver
- GitHub

---

## Proceso seguido

### 1. Importación de la base de datos

El primer paso fue importar correctamente la base de datos Shakila en PostgreSQL utilizando el archivo proporcionado para el proyecto.

Una vez importada, comprobé que todas las tablas se habían creado correctamente y que las relaciones entre ellas funcionaban correctamente.

---

### 2. Exploración del esquema de la base de datos

Antes de comenzar con las consultas revisé la estructura de la base de datos para entender cómo se relacionaban las tablas.

Las tablas que más utilicé durante el proyecto fueron:

- film
- actor
- customer
- rental
- inventory
- payment
- category
- film_actor
- film_category
- store
- staff

Comprender las relaciones entre estas tablas fue fundamental para poder construir correctamente las consultas posteriores.

---

### 3. Desarrollo de las consultas

Durante el proyecto realicé consultas relacionadas con:

- Filtrado de datos mediante WHERE.
- Ordenación de resultados con ORDER BY.
- Funciones de agregación como COUNT, SUM, AVG, MIN, MAX, STDDEV y VARIANCE.
- Agrupaciones mediante GROUP BY.
- Filtrado de grupos mediante HAVING.
- Subconsultas.
- Creación de VIEWS.
- Creación de tablas temporales.
- Uso de INNER JOIN, LEFT JOIN, FULL OUTER JOIN y CROSS JOIN.
- Manejo de valores NULL.

---

## Principales dificultades encontradas

### Comprender los diferentes tipos de JOIN

Una de las primeras dificultades fue entender cuándo utilizar cada tipo de JOIN.

Aprendí que:

- INNER JOIN devuelve únicamente los registros que tienen coincidencia en ambas tablas.
- LEFT JOIN mantiene todos los registros de la tabla izquierda aunque no exista coincidencia.
- FULL OUTER JOIN mantiene todos los registros de ambas tablas.
- CROSS JOIN genera todas las combinaciones posibles entre dos tablas.

Especialmente me costó identificar cuándo era necesario utilizar LEFT JOIN para conservar registros que no tenían relación en otra tabla.

---

### Entender cuándo usar GROUP BY

Al principio tuve problemas para entender por qué algunas consultas devolvían errores cuando utilizaba funciones de agregación.

Aprendí que todas las columnas seleccionadas que no forman parte de una función agregada deben incluirse dentro del GROUP BY.

También comprendí que GROUP BY puede utilizar varias columnas cuando se necesita agrupar por una combinación de valores.

---

### Diferencia entre COUNT(*) y COUNT(columna)

Otra duda frecuente fue entender cuándo utilizar:

```sql
COUNT(*)
```

y cuándo utilizar:

```sql
COUNT(columna)
```

Aprendí que:

- COUNT(*) cuenta todas las filas.
- COUNT(columna) cuenta únicamente los valores no nulos de esa columna.

---

### Uso correcto de HAVING

En varias ocasiones intenté utilizar funciones agregadas dentro de cláusulas WHERE, lo que provocaba errores.

Gracias a ello aprendí que:

- WHERE filtra filas antes de agrupar.
- HAVING filtra grupos después de realizar las agregaciones.

---

### Uso de COUNT(DISTINCT)

Una de las dudas más importantes apareció en ejercicios relacionados con clientes que habían alquilado películas distintas.

Inicialmente confundí:

- Número de alquileres.
- Número de películas diferentes.

Finalmente comprendí que:

```sql
COUNT(DISTINCT film_id)
```

permite contar únicamente películas diferentes, independientemente de cuántas veces se hayan alquilado.

---

### Trabajo con subconsultas

Las subconsultas fueron una de las partes más complejas del proyecto.

Tuve dificultades especialmente cuando intentaba utilizar alias de la consulta principal dentro de una subconsulta.

Aprendí que cada consulta tiene su propio ámbito (scope) y que los alias definidos en una consulta no siempre están disponibles dentro de una subconsulta.

También aprendí a utilizar funciones como MIN() o MAX() dentro de subconsultas para obtener valores de referencia utilizados posteriormente en consultas principales.

---

### Comprender el uso de NULL

Otra parte importante fue entender cómo funcionan los valores NULL.

Aprendí que:

```sql
IS NULL
```

se utiliza para encontrar valores vacíos.

Y que:

```sql
IS NOT NULL
```

permite localizar registros que sí contienen información.

También comprendí que muchos NULL aparecen como resultado de LEFT JOIN cuando no existe una relación entre tablas.

---

### Uso de CROSS JOIN

Antes de este proyecto no había utilizado CROSS JOIN.

Aprendí que genera todas las combinaciones posibles entre dos tablas y que normalmente no se utiliza para consultas de negocio reales, aunque puede ser útil para generar combinaciones o realizar pruebas.

---

## Conceptos reforzados durante el proyecto

Gracias a la realización de los ejercicios he reforzado especialmente los siguientes conceptos:

- Consultas SELECT.
- Filtrado con WHERE.
- Ordenación con ORDER BY.
- Funciones de agregación.
- GROUP BY.
- HAVING.
- Subconsultas.
- INNER JOIN.
- LEFT JOIN.
- FULL OUTER JOIN.
- CROSS JOIN.
- DISTINCT.
- COUNT(DISTINCT).
- Vistas (VIEW).
- Tablas temporales (TEMP TABLE).
- Manejo de valores NULL.

---

## Conclusión

Este proyecto me ha permitido mejorar significativamente mis conocimientos de SQL mediante la resolución de problemas prácticos sobre una base de datos relacional real.

Además de aprender sintaxis, he desarrollado una mejor comprensión de cómo relacionar tablas, cuándo utilizar cada tipo de JOIN, cómo agrupar información correctamente y cómo resolver problemas utilizando subconsultas y funciones de agregación.

Las principales dificultades estuvieron relacionadas con el uso de JOINs, agrupaciones y subconsultas, pero precisamente esos retos me ayudaron a comprender mejor el funcionamiento de SQL y a ganar más soltura trabajando con bases de datos relacionales.
