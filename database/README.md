# Database

## 📌 Descripción

Base de datos utilizada para gestionar la planificación de producción, las líneas de producción, los productos y las incidencias asociadas a las diferentes ejecuciones (`RUN`).

La base de datos utiliza **MySQL** y se ejecuta dentro de un contenedor Docker.

---

## 🗄️ Tecnología

* **Motor:** MySQL
* **Containerización:** Docker
* **Lenguaje:** SQL
* **Storage Engine:** InnoDB

---

## 📁 Estructura

```text
database/
│
├── init/
│   ├── 01_schema.sql
│   └── 02_seed.sql
│
├── queries/
│   ├── analysis.sql
│   └── reports.sql
│
└── README.md
```

### `init/01_schema.sql`

Contiene la definición de la estructura de la base de datos.

Se encarga de crear las tablas, columnas, claves primarias, claves foráneas, restricciones y campos de auditoría.

### `init/02_seed.sql`

Contiene los datos iniciales utilizados para poblar la base de datos.

Actualmente contiene información de:

* Productos
* Líneas de producción
* Runs
* Incidencias

### `queries/analysis.sql`

Contendrá las consultas SQL destinadas al análisis de los datos.

**Consultas incluidas:**

*
*
*

### `queries/reports.sql`

Contendrá las consultas SQL utilizadas para obtener información destinada a informes y visualizaciones.

**Consultas incluidas:**

*
*
*

---

# 🏗️ Modelo de datos

La base de datos está estructurada alrededor de cuatro entidades principales:

```text
PRODUCTO
    │
    │
    ▼
  RUN ◄──── LINEA
    │
    │
    ▼
INCIDENCIAS
```

## 📋 Tablas

### PRODUCTO

**Descripción:**

Tabla que contiene los productos que pueden ser producidos durante las diferentes `RUN`.

**Campos:**

| Campo             | Tipo           | Descripción                       | Restricciones                               |
| ----------------- | -------------- | --------------------------------- | ------------------------------------------- |
| `id`              | `BIGINT`       | Identificador del producto        | `PRIMARY KEY`, `AUTO_INCREMENT`, `NOT NULL` |
| `nombre_producto` | `VARCHAR(80)`  | Nombre del producto               | `NOT NULL`                                  |
| `created_at`      | `DATETIME`     | Fecha de creación                 | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP`     |
| `updated_at`      | `DATETIME`     | Fecha de última actualización     | `NOT NULL`, `ON UPDATE`                     |
| `created_by`      | `VARCHAR(255)` | Usuario que creó el registro      | `NOT NULL`                                  |
| `updated_by`      | `VARCHAR(255)` | Usuario que actualizó el registro | `NOT NULL`                                  |

---

### LINEA

**Descripción:**

Tabla que representa las líneas de producción disponibles.

**Campos:**

| Campo | Tipo     | Descripción               | Restricciones                               |
| ----- | -------- | ------------------------- | ------------------------------------------- |
| `id`  | `BIGINT` | Identificador de la línea | `PRIMARY KEY`, `AUTO_INCREMENT`, `NOT NULL` |
|       |          |                           |                                             |
|       |          |                           |                                             |
|       |          |                           |                                             |

---

### RUN

**Descripción:**

Tabla que contiene las ejecuciones o periodos de producción planificados.

Cada `RUN` está asociada a un producto y a una línea de producción.

**Campos:**

| Campo         | Tipo           | Descripción                            | Restricciones                               |
| ------------- | -------------- | -------------------------------------- | ------------------------------------------- |
| `id`          | `BIGINT`       | Identificador de la run                | `PRIMARY KEY`, `AUTO_INCREMENT`, `NOT NULL` |
| `id_producto` | `BIGINT`       | Producto que se va a producir          | `NOT NULL`, `FOREIGN KEY`                   |
| `id_linea`    | `BIGINT`       | Línea donde se realizará la producción | `NOT NULL`, `FOREIGN KEY`                   |
| `hora_incio`  | `DATETIME`     | Fecha y hora de inicio                 | `NOT NULL`                                  |
| `hora_final`  | `DATETIME`     | Fecha y hora de finalización           | `NOT NULL`                                  |
| `UPM`         | `INT`          | Unidades producidas por minuto         | `NOT NULL`                                  |
| `created_at`  | `DATETIME`     | Fecha de creación                      | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP`     |
| `updated_at`  | `DATETIME`     | Fecha de última actualización          | `NOT NULL`, `ON UPDATE`                     |
| `created_by`  | `VARCHAR(255)` | Usuario que creó el registro           | `NOT NULL`                                  |
| `updated_by`  | `VARCHAR(255)` | Usuario que actualizó el registro      | `NOT NULL`                                  |

---

### INCIDENCIAS

**Descripción:**

Tabla que almacena las incidencias producidas durante las diferentes `RUN`.

Una incidencia está relacionada con una run, una línea y un producto.

**Campos:**

| Campo         | Tipo            | Descripción                            | Restricciones                               |
| ------------- | --------------- | -------------------------------------- | ------------------------------------------- |
| `id`          | `BIGINT`        | Identificador de la incidencia         | `PRIMARY KEY`, `AUTO_INCREMENT`, `NOT NULL` |
| `id_run`      | `BIGINT`        | Run en la que ocurrió la incidencia    | `NOT NULL`, `FOREIGN KEY`                   |
| `id_linea`    | `BIGINT`        | Línea relacionada con la incidencia    | `NOT NULL`, `FOREIGN KEY`                   |
| `id_producto` | `BIGINT`        | Producto relacionado con la incidencia | `NOT NULL`, `FOREIGN KEY`                   |
| `descripcion` | `VARCHAR(2000)` | Descripción de la incidencia           | `NOT NULL`                                  |
| `created_at`  | `DATETIME`      | Fecha de creación                      | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP`     |
| `updated_at`  | `DATETIME`      | Fecha de última actualización          | `NOT NULL`, `ON UPDATE`                     |
| `created_by`  | `VARCHAR(255)`  | Usuario que creó el registro           | `NOT NULL`                                  |
| `updated_by`  | `VARCHAR(255)`  | Usuario que actualizó el registro      | `NOT NULL`                                  |

---

# 🔗 Relaciones

| Tabla origen  | Campo         | Tabla destino | Campo | Relación |
| ------------- | ------------- | ------------- | ----- | -------- |
| `RUN`         | `id_producto` | `PRODUCTO`    | `id`  | N:1      |
| `RUN`         | `id_linea`    | `LINEA`       | `id`  | N:1      |
| `INCIDENCIAS` | `id_run`      | `RUN`         | `id`  | N:1      |
| `INCIDENCIAS` | `id_linea`    | `LINEA`       | `id`  | N:1      |
| `INCIDENCIAS` | `id_producto` | `PRODUCTO`    | `id`  | N:1      |

### Resumen

```text
PRODUCTO 1 ─────────── N RUN
                         │
                         │
LINEA    1 ─────────── N RUN
                         │
                         │
                         N
                    INCIDENCIAS
```

---

# 🔑 Claves

## Primary Keys

| Tabla         | Primary Key |
| ------------- | ----------- |
| `PRODUCTO`    | `id`        |
| `LINEA`       | `id`        |
| `RUN`         | `id`        |
| `INCIDENCIAS` | `id`        |

## Foreign Keys

| Tabla         | Foreign Key   | Referencia     |
| ------------- | ------------- | -------------- |
| `RUN`         | `id_producto` | `PRODUCTO(id)` |
| `RUN`         | `id_linea`    | `LINEA(id)`    |
| `INCIDENCIAS` | `id_run`      | `RUN(id)`      |
| `INCIDENCIAS` | `id_linea`    | `LINEA(id)`    |
| `INCIDENCIAS` | `id_producto` | `PRODUCTO(id)` |

---

# 📊 Datos iniciales

## PRODUCTO

Actualmente se han definido **24 productos**.

Los productos contienen:

* Identificador.
* Nombre del producto.

## LINEA

Actualmente se han definido **3 líneas de producción**:

*
*
*

## RUN

Actualmente se han definido **3 runs iniciales**.

Cada run contiene:

* Producto.
* Línea de producción.
* Fecha y hora de inicio.
* Fecha y hora de finalización.
* UPM.

## INCIDENCIAS

Actualmente se han definido **2 incidencias iniciales**.

Cada incidencia contiene:

* Run asociada.
* Línea.
* Producto.
* Descripción.
* Información de auditoría.

---

# 🐳 Docker

La base de datos se ejecuta mediante Docker Compose.

**Servicio:**

```text
________________
```

**Imagen de MySQL:**

```text
________________
```

**Puerto:**

```text
________________
```

**Base de datos:**

```text
bd_calendario
```

**Usuario:**

```text
________________
```

---

# ⚙️ Variables de entorno

Las credenciales y configuración de MySQL se gestionan mediante variables de entorno.

```env
MYSQL_DATABASE=bd_calendario
MYSQL_USER=
MYSQL_PASSWORD=
MYSQL_ROOT_PASSWORD=
MYSQL_PORT=
```

> No almacenar credenciales reales en el repositorio.

---

# 🚀 Inicialización

Los scripts de inicialización se encuentran en:

```text
database/init/
```

El orden de ejecución esperado es:

```text
01_schema.sql
      ↓
02_seed.sql
```

Primero se crea la estructura de la base de datos y posteriormente se introducen los datos iniciales.

---

# 🔎 Consultas

## Analysis

Archivo:

```text
queries/analysis.sql
```

**Objetivo:**

Consultas destinadas a obtener métricas y realizar análisis sobre la producción.

**Consultas previstas:**

*
*
*

---

## Reports

Archivo:

```text
queries/reports.sql
```

**Objetivo:**

Consultas destinadas a proporcionar información que posteriormente podrá ser utilizada por la API y el sistema de visualización.

**Consultas previstas:**

*
*
*

---

# 📝 Decisiones de diseño

## Auditoría

Las tablas incorporan campos para registrar:

* Fecha de creación.
* Fecha de actualización.
* Usuario creador.
* Usuario que realizó la última actualización.

## Integridad referencial

Las relaciones entre las entidades se gestionan mediante claves foráneas.

Esto permite mantener la consistencia entre:

```text
PRODUCTO
    ↓
RUN
    ↓
INCIDENCIAS
```

## Motor

Se utiliza **InnoDB** para disponer de soporte para claves foráneas y transacciones.

---

# 🚧 Pendiente

* [ ] Revisar y validar el modelo de datos.
* [ ] Completar las restricciones de las tablas.
* [ ] Definir las relaciones definitivas.
* [ ] Añadir datos de prueba adicionales.
* [ ] Crear consultas de análisis.
* [ ] Crear consultas para los reports.
* [ ] Documentar las consultas.
* [ ] Integrar la base de datos con la API REST.
* [ ] Integrar la base de datos con el sistema de visualización.

