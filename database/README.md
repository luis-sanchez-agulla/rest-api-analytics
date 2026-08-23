# Database

## 📌 Descripción

Base de datos utilizada para gestionar la planificación de producción, las líneas de producción, los productos y las incidencias asociadas a las diferentes ejecuciones (`RUN`).

La base de datos utiliza **MySQL 8.0**, se ejecuta dentro de un contenedor Docker y utiliza **InnoDB** como motor de almacenamiento.

---

## 🗄️ Tecnología

* **Motor:** MySQL 8.0
* **Containerización:** Docker
* **Orquestación:** Docker Compose
* **Lenguaje:** SQL
* **Storage Engine:** InnoDB
* **Base de datos:** `bd_calendario`
* **Contenedor:** `db-calendario`
* **Servicio Docker Compose:** `calendario-db`

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

Se encarga de crear las tablas, relaciones N:M, claves primarias, claves foráneas, restricciones y campos de auditoría.

### `init/02_seed.sql`

Contiene los datos iniciales utilizados para poblar la base de datos.

Actualmente contiene información de:

* Productos
* Líneas de producción
* Runs
* Relaciones Run-Producto y Run-Línea
* Incidencias

### `queries/analysis.sql`

Contendrá las consultas SQL destinadas al análisis de los datos.

### `queries/reports.sql`

Contendrá las consultas SQL utilizadas para obtener información destinada a informes y visualizaciones.

# 🏗️ Modelo de datos

La base de datos está estructurada alrededor de entidades de catálogo (`PRODUCTO`, `LINEA`), el núcleo de planificación (`RUN`), sus tablas intermedias mutables (`RUN_PRODUCTO`, `RUN_LINEA`) y el registro de eventos (`INCIDENCIAS`).

```text
PRODUCTO ─── (N:M) ─── RUN ─── (N:M) ─── LINEA
                        │
                        │ (1:N)
                        ▼
                   INCIDENCIAS
```

## 📋 Tablas

### PRODUCTO

**Descripción:** Catálogo de productos disponibles para producción.

| Campo             | Tipo           | Descripción                       | Restricciones                                     |
| ----------------- | -------------- | --------------------------------- | ------------------------------------------------- |
| `id`              | `BIGINT`       | Identificador del producto        | `PRIMARY KEY`, `AUTO_INCREMENT`, `NOT NULL`       |
| `nombre_producto` | `VARCHAR(80)`  | Nombre del producto               | `NOT NULL`                                        |
| `created_at`      | `DATETIME`     | Fecha de creación                 | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP`           |
| `updated_at`      | `DATETIME`     | Fecha de última actualización     | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP ON UPDATE` |
| `created_by`      | `VARCHAR(255)` | Usuario que creó el registro      | `NOT NULL`, `DEFAULT 'system'`                    |
| `updated_by`      | `VARCHAR(255)` | Usuario que actualizó el registro | `NOT NULL`, `DEFAULT 'system'`                    |

### LINEA

**Descripción:** Catálogo de líneas de producción disponibles.

| Campo        | Tipo           | Descripción                       | Restricciones                                     |
| ------------ | -------------- | --------------------------------- | ------------------------------------------------- |
| `id`         | `BIGINT`       | Identificador de la línea         | `PRIMARY KEY`, `AUTO_INCREMENT`, `NOT NULL`       |
| `created_at` | `DATETIME`     | Fecha de creación                 | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP`           |
| `updated_at` | `DATETIME`     | Fecha de última actualización     | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP ON UPDATE` |
| `created_by` | `VARCHAR(255)` | Usuario que creó el registro      | `NOT NULL`, `DEFAULT 'system'`                    |
| `updated_by` | `VARCHAR(255)` | Usuario que actualizó el registro | `NOT NULL`, `DEFAULT 'system'`                    |

### RUN

**Descripción:** Bloques de tiempo planificados en el calendario.

| Campo               | Tipo           | Descripción                       | Restricciones                                     |
| ------------------- | -------------- | --------------------------------- | ------------------------------------------------- |
| `id`                | `BIGINT`       | Identificador de la run           | `PRIMARY KEY`, `AUTO_INCREMENT`, `NOT NULL`       |
| `fecha_hora_inicio` | `DATETIME`     | Fecha y hora de inicio de la run  | `NOT NULL`                                        |
| `fecha_hora_final`  | `DATETIME`     | Fecha y hora de término de la run | `NOT NULL`                                        |
| `UPM`               | `INT`          | Unidades producidas por minuto    | `NOT NULL`                                        |
| `created_at`        | `DATETIME`     | Fecha de creación                 | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP`           |
| `updated_at`        | `DATETIME`     | Fecha de última actualización     | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP ON UPDATE` |
| `created_by`        | `VARCHAR(255)` | Usuario que creó el registro      | `NOT NULL`, `DEFAULT 'system'`                    |
| `updated_by`        | `VARCHAR(255)` | Usuario que actualizó el registro | `NOT NULL`, `DEFAULT 'system'`                    |

### RUN_PRODUCTO

**Descripción:** Relación dinámica (N:M) entre una `RUN` y sus productos asignados.

| Campo         | Tipo           | Descripción                  | Restricciones                                     |
| ------------- | -------------- | ---------------------------- | ------------------------------------------------- |
| `id_run`      | `BIGINT`       | Identificador de la run      | `NOT NULL`, `FOREIGN KEY`                         |
| `id_producto` | `BIGINT`       | Identificador del producto   | `NOT NULL`, `FOREIGN KEY`                         |
| `created_at`  | `DATETIME`     | Fecha de asignación          | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP`           |
| `updated_at`  | `DATETIME`     | Fecha de última modificación | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP ON UPDATE` |
| `created_by`  | `VARCHAR(255)` | Usuario que asignó           | `NOT NULL`, `DEFAULT 'system'`                    |
| `updated_by`  | `VARCHAR(255)` | Usuario que modificó         | `NOT NULL`, `DEFAULT 'system'`                    |

* **Primary Key compuesta:** `(id_run, id_producto)`

### RUN_LINEA

**Descripción:** Relación dinámica (N:M) entre una `RUN` y las líneas asignadas.

| Campo        | Tipo           | Descripción                  | Restricciones                                     |
| ------------ | -------------- | ---------------------------- | ------------------------------------------------- |
| `id_run`     | `BIGINT`       | Identificador de la run      | `NOT NULL`, `FOREIGN KEY`                         |
| `id_linea`   | `BIGINT`       | Identificador de la línea    | `NOT NULL`, `FOREIGN KEY`                         |
| `created_at` | `DATETIME`     | Fecha de asignación          | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP`           |
| `updated_at` | `DATETIME`     | Fecha de última modificación | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP ON UPDATE` |
| `created_by` | `VARCHAR(255)` | Usuario que asignó           | `NOT NULL`, `DEFAULT 'system'`                    |
| `updated_by` | `VARCHAR(255)` | Usuario que modificó         | `NOT NULL`, `DEFAULT 'system'`                    |

* **Primary Key compuesta:** `(id_run, id_linea)`

### INCIDENCIAS

**Descripción:** Eventos, proyectos o incidencias asociados directamente a una `RUN`.

| Campo         | Tipo            | Descripción                         | Restricciones                                     |
| ------------- | --------------- | ----------------------------------- | ------------------------------------------------- |
| `id`          | `BIGINT`        | Identificador de la incidencia      | `PRIMARY KEY`, `AUTO_INCREMENT`, `NOT NULL`       |
| `id_run`      | `BIGINT`        | Run asociada                        | `NOT NULL`, `FOREIGN KEY`                         |
| `descripcion` | `VARCHAR(2000)` | Detalle de la incidencia            | `NOT NULL`                                        |
| `created_at`  | `DATETIME`      | Fecha de creación                   | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP`           |
| `updated_at`  | `DATETIME`      | Fecha de última actualización       | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP ON UPDATE` |
| `created_by`  | `VARCHAR(255)`  | Usuario que creó la incidencia      | `NOT NULL`                                        |
| `updated_by`  | `VARCHAR(255)`  | Usuario que actualizó la incidencia | `NOT NULL`                                        |

# 🔗 Relaciones

| Tabla origen   | Campo         | Tabla destino | Campo | Relación | Modificación        |
| -------------- | ------------- | ------------- | ----- | -------- | ------------------- |
| `RUN_PRODUCTO` | `id_run`      | `RUN`         | `id`  | N:1      | `ON DELETE CASCADE` |
| `RUN_PRODUCTO` | `id_producto` | `PRODUCTO`    | `id`  | N:1      | `ON DELETE CASCADE` |
| `RUN_LINEA`    | `id_run`      | `RUN`         | `id`  | N:1      | `ON DELETE CASCADE` |
| `RUN_LINEA`    | `id_linea`    | `LINEA`       | `id`  | N:1      | `ON DELETE CASCADE` |
| `INCIDENCIAS`  | `id_run`      | `RUN`         | `id`  | N:1      | `ON DELETE CASCADE` |

# 🔑 Claves

## Primary Keys

| Tabla          | Primary Key             |
| -------------- | ----------------------- |
| `PRODUCTO`     | `id`                    |
| `LINEA`        | `id`                    |
| `RUN`          | `id`                    |
| `RUN_PRODUCTO` | `(id_run, id_producto)` |
| `RUN_LINEA`    | `(id_run, id_linea)`    |
| `INCIDENCIAS`  | `id`                    |

## Foreign Keys

| Tabla          | Foreign Key   | Referencia     | Acción              |
| -------------- | ------------- | -------------- | ------------------- |
| `RUN_PRODUCTO` | `id_run`      | `RUN(id)`      | `ON DELETE CASCADE` |
| `RUN_PRODUCTO` | `id_producto` | `PRODUCTO(id)` | `ON DELETE CASCADE` |
| `RUN_LINEA`    | `id_run`      | `RUN(id)`      | `ON DELETE CASCADE` |
| `RUN_LINEA`    | `id_linea`    | `LINEA(id)`    | `ON DELETE CASCADE` |
| `INCIDENCIAS`  | `id_run`      | `RUN(id)`      | `ON DELETE CASCADE` |

# 📊 Datos iniciales (`02_seed.sql`)

* **PRODUCTO:** 24 productos precargados (con nombre y SKU explicativo).
* **LINEA:** 3 líneas precargadas (`38`, `39`, `40`).
* **RUN:** 3 ejecuciones iniciales definidas en fechas de agosto 2026.
* **RUN_PRODUCTO / RUN_LINEA:** Enlaces de asignación entre las runs, sus líneas y sus productos.
* **INCIDENCIAS:** 2 incidencias registradas ligadas a sus respectivas `RUN`.

# 🐳 Docker

La base de datos se ejecuta mediante **Docker Compose** utilizando un servicio independiente de MySQL.

## Servicio `calendario-db`

| Configuración             | Valor                |
| ------------------------- | -------------------- |
| **Servicio**              | `calendario-db`      |
| **Imagen**                | `mysql:8.0`          |
| **Contenedor**            | `db-calendario`      |
| **Base de datos**         | `bd_calendario`      |
| **Usuario de aplicación** | `app`                |
| **Puerto**                | `3306`               |
| **Red**                   | `calendario_network` |
| **Storage Engine**        | `InnoDB`             |

La configuración utilizada en Docker Compose es:

```yaml
services:

  ## BASE DE DATOS DEL CALENDARIO
  calendario-db:
    image: mysql:8.0
    container_name: db-calendario

    ports:
      - "3306:3306"

    environment:
      MYSQL_ROOT_PASSWORD: "rootpass"
      MYSQL_DATABASE: "bd_calendario"
      MYSQL_USER: "app"
      MYSQL_PASSWORD: "apppass"

    volumes:
      - mysql_data:/var/lib/mysql
      - ./mysql/conf.d:/etc/mysql/conf.d:ro
      - ./mysql/init-db:/docker-entrypoint-initdb.d:ro
      - ./mysql/init-scripts:/docker-entrypoint-initdb.d:ro

    networks:
      - calendario_network

    healthcheck:
      test:
        ["CMD", "mysqladmin", "ping", "-h", "127.0.0.1", "-uroot", "-prootpass"]
      interval: 10s
      timeout: 5s
      retries: 10

networks:
  calendario_network:
    driver: bridge

volumes:
  mysql_data:
```

## 💾 Persistencia

MySQL utiliza un volumen Docker nombrado para conservar los datos:

```yaml
volumes:
  - mysql_data:/var/lib/mysql
```

El volumen `mysql_data` se monta en:

```text
/var/lib/mysql
```

Esto permite conservar los datos de MySQL aunque el contenedor sea eliminado o recreado.

> ⚠️ Los scripts de inicialización solo se ejecutan automáticamente cuando el directorio de datos de MySQL está vacío.

## 📂 Configuración adicional

La configuración adicional de MySQL se encuentra en:

```text
./mysql/conf.d
```

Este directorio se monta dentro del contenedor en:

```text
/etc/mysql/conf.d
```

en modo **solo lectura**:

```yaml
- ./mysql/conf.d:/etc/mysql/conf.d:ro
```

Los archivos `.cnf` incluidos en este directorio permiten añadir configuraciones específicas de MySQL.

## 🚀 Scripts de inicialización

Los scripts de inicialización se montan en:

```text
/docker-entrypoint-initdb.d
```

mediante los siguientes directorios:

```yaml
- ./mysql/init-db:/docker-entrypoint-initdb.d:ro
- ./mysql/init-scripts:/docker-entrypoint-initdb.d:ro
```

Estos directorios contienen los scripts necesarios para la creación e inicialización de la base de datos, incluyendo la creación de usuarios, roles, vistas y plugins.

> **Nota:** Ambos directorios se montan sobre el mismo destino (`/docker-entrypoint-initdb.d`). Los scripts de inicialización deben estar organizados para evitar conflictos y garantizar el orden correcto de ejecución.

La estructura puede organizarse de la siguiente manera:

```text
mysql/
├── conf.d/
│   └── *.cnf
│
├── init-db/
│   └── *.sql
│
└── init-scripts/
    └── *.sql
```

## ❤️ Healthcheck

El contenedor incorpora un `healthcheck` para comprobar que el servidor MySQL está disponible:

```yaml
healthcheck:
  test:
    ["CMD", "mysqladmin", "ping", "-h", "127.0.0.1", "-uroot", "-prootpass"]
  interval: 10s
  timeout: 5s
  retries: 10
```

| Parámetro  | Valor | Descripción                                                      |
| ---------- | ----: | ---------------------------------------------------------------- |
| `interval` | `10s` | Tiempo entre comprobaciones                                      |
| `timeout`  |  `5s` | Tiempo máximo de cada comprobación                               |
| `retries`  |  `10` | Número de intentos antes de marcar el servicio como no saludable |

El healthcheck permite comprobar que MySQL no solo está ejecutándose, sino que está preparado para aceptar conexiones.

## 🌐 Red Docker

La base de datos utiliza una red Docker personalizada:

```yaml
networks:
  calendario_network:
    driver: bridge
```

El servicio `calendario-db` está conectado a esta red:

```yaml
networks:
  - calendario_network
```

Los demás servicios Docker conectados a esta misma red pueden acceder a MySQL utilizando:

```text
Host: calendario-db
Port: 3306
Database: bd_calendario
User: app
```

Desde otro contenedor se debe utilizar `calendario-db` como host, no `localhost`.

Desde la máquina host, el acceso se realiza mediante:

```text
localhost:3306
```

## 🔌 Puerto

El puerto de MySQL se publica mediante:

```yaml
ports:
  - "3306:3306"
```

La correspondencia es:

```text
HOST                  CONTENEDOR
3306       ────────►  3306
```

Por tanto:

* **Desde el host:** `localhost:3306`
* **Desde otros contenedores:** `calendario-db:3306`

# ⚙️ Variables de entorno

Las credenciales y configuración de MySQL se gestionan mediante variables de entorno:

```env
MYSQL_DATABASE=bd_calendario
MYSQL_USER=app
MYSQL_PASSWORD=apppass
MYSQL_ROOT_PASSWORD=rootpass
MYSQL_PORT=3306
```

> ⚠️ No almacenar credenciales reales en el repositorio. Las credenciales incluidas en esta documentación están destinadas únicamente al entorno de desarrollo.

# 🚀 Inicialización

Los scripts de inicialización de la base de datos se encuentran en los directorios montados sobre `/docker-entrypoint-initdb.d`.

La inicialización lógica de la base de datos sigue el siguiente flujo:

```text
01_schema.sql ──► 02_seed.sql
```

Los scripts se ejecutan automáticamente durante el primer arranque de MySQL cuando el volumen de datos está vacío.

## Reinicialización

Para eliminar completamente el contenedor y el volumen de datos:

```bash
docker compose down -v
```

Posteriormente se puede volver a iniciar la base de datos:

```bash
docker compose up -d calendario-db
```

> ⚠️ `docker compose down -v` elimina el volumen `mysql_data` y, por tanto, **todos los datos almacenados en MySQL**.

# 🛠️ Comandos Docker

### Iniciar la base de datos

```bash
docker compose up -d calendario-db
```

### Ver el estado

```bash
docker compose ps
```

### Ver los logs

```bash
docker compose logs calendario-db
```

### Seguir los logs en tiempo real

```bash
docker compose logs -f calendario-db
```

### Detener la base de datos

```bash
docker compose stop calendario-db
```

### Eliminar el contenedor

```bash
docker compose rm calendario-db
```

# 📝 Decisiones de diseño

* **Desacoplamiento N:M:** El uso de `RUN_PRODUCTO` y `RUN_LINEA` permite asignar múltiples líneas o productos a una sola ejecución sin duplicar datos en la tabla principal `RUN`.
* **Auditoría completa:** Cada registro cuenta con marcas temporales (`created_at`, `updated_at`) y trazabilidad de usuario (`created_by`, `updated_by`).
* **Simplificación de Incidencias:** Las incidencias dependen únicamente de `id_run`, derivando implícitamente la línea y producto de las tablas intermedias.
* **Persistencia mediante volumen:** El volumen `mysql_data` permite conservar los datos de MySQL independientemente del ciclo de vida del contenedor.
* **Aislamiento mediante red Docker:** `calendario_network` permite la comunicación controlada entre la base de datos y el resto de servicios del proyecto.
* **Healthcheck:** El contenedor incorpora una comprobación automática para verificar la disponibilidad real del servidor MySQL.

