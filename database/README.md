# Database

## 📌 Descripción

Descripción de la base de datos del proyecto.

<!-- Explica brevemente qué información almacena y cuál es su propósito. -->

## 🗄️ Tecnología

* **Motor de base de datos:** MySQL
* **Contenedores:** Docker
* **Lenguaje de consultas:** SQL

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

## 🏗️ Modelo de datos

Descripción general de cómo está estructurada la base de datos.

<!-- Explica aquí las relaciones principales entre las tablas. -->

## 📋 Tablas

### Tabla 1:

**Descripción:**

| Campo | Tipo | Descripción | Restricciones |
| ----- | ---- | ----------- | ------------- |
|       |      |             |               |
|       |      |             |               |
|       |      |             |               |

---

### Tabla 2:

**Descripción:**

| Campo | Tipo | Descripción | Restricciones |
| ----- | ---- | ----------- | ------------- |
|       |      |             |               |
|       |      |             |               |
|       |      |             |               |

---

### Tabla 3:

**Descripción:**

| Campo | Tipo | Descripción | Restricciones |
| ----- | ---- | ----------- | ------------- |
|       |      |             |               |
|       |      |             |               |
|       |      |             |               |

---

### Tabla 4:

**Descripción:**

| Campo | Tipo | Descripción | Restricciones |
| ----- | ---- | ----------- | ------------- |
|       |      |             |               |
|       |      |             |               |
|       |      |             |               |

## 🔗 Relaciones

Describe aquí las relaciones entre las tablas.

| Tabla origen | Campo | Tabla destino | Campo | Relación |
| ------------ | ----- | ------------- | ----- | -------- |
|              |       |               |       |          |
|              |       |               |       |          |
|              |       |               |       |          |

## 🔑 Claves

### Primary Keys

Indica aquí las claves primarias de cada tabla.

| Tabla | Primary Key |
| ----- | ----------- |
|       |             |
|       |             |
|       |             |

### Foreign Keys

Indica aquí las claves foráneas.

| Tabla | Foreign Key | Referencia |
| ----- | ----------- | ---------- |
|       |             |            |
|       |             |            |
|       |             |            |

## 📊 Datos

### Fuente de los datos

**Fuente:**

**URL:**

**Descripción:**

### Datos iniciales

Los datos iniciales de la base de datos se encuentran en:

```text
init/02_seed.sql
```

## 🔎 Consultas

### Análisis

Las consultas relacionadas con el análisis de datos se encuentran en:

```text
queries/analysis.sql
```

Descripción:

### Reports

Las consultas destinadas a informes y visualizaciones se encuentran en:

```text
queries/reports.sql
```

Descripción:

## 🐳 Docker

La base de datos se ejecuta mediante Docker.

**Nombre del servicio:**

**Puerto:**

**Nombre de la base de datos:**

**Usuario:**

> Las credenciales y variables de configuración no deben almacenarse directamente en el repositorio. Utiliza variables de entorno.

## ⚙️ Variables de entorno

Las variables necesarias para conectar con MySQL son:

```env
MYSQL_DATABASE=
MYSQL_USER=
MYSQL_PASSWORD=
MYSQL_ROOT_PASSWORD=
MYSQL_PORT=
```

## 🚀 Inicialización

Describe aquí cómo inicializar la base de datos mediante Docker.

```bash
```

## 📝 Notas

*
*
*

