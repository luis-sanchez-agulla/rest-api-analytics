-- Seleccionamos la base de las incidencias del calendario
USE bd_calendario;

-- ---------------------------------------------------------
-- Creación de tablas
-- ---------------------------------------------------------

-- Tabla de productos
CREATE TABLE IF NOT EXISTS PRODUCTO (
        -- Clave primaria
        id                              BIGINT          NOT NULL AUTO_INCREMENT,

        -- Atributos
        sku                             BIGINT          NOT NULL,
        nombre_producto                 VARCHAR(80)     NOT NULL,

        -- Auditoria
        created_at                      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at                      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        created_by                      VARCHAR(255)    NOT NULL DEFAULT 'system',
        updated_by                      VARCHAR(255)    NOT NULL DEFAULT 'system',

        -- Constraints
        PRIMARY KEY (id)
) ENGINE = InnoDB
COMMENT = "Tabla de productos: catálogo de productos disponibles para producción";


-- Tabla de líneas
CREATE TABLE IF NOT EXISTS LINEA (
        -- Clave primaria
        id                              BIGINT          NOT NULL AUTO_INCREMENT,

        -- Auditoria
        created_at                      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at                      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        created_by                      VARCHAR(255)    NOT NULL DEFAULT 'system',
        updated_by                      VARCHAR(255)    NOT NULL DEFAULT 'system',

        -- Constraints
        PRIMARY KEY (id)
) ENGINE = InnoDB
COMMENT = "Tabla de las líneas: contiene información de las líneas de producción";


-- Tabla de runs (Planificación de bloques en el calendario)
CREATE TABLE IF NOT EXISTS RUN (
        -- Clave primaria
        id                              BIGINT          NOT NULL AUTO_INCREMENT,

        -- Atributos
        fecha_hora_inicio               DATETIME        NOT NULL,
        fecha_hora_final                DATETIME        NOT NULL,
        UPM                             INT             NOT NULL,

        -- Auditoria
        created_at                      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at                      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        created_by                      VARCHAR(255)    NOT NULL DEFAULT 'system',
        updated_by                      VARCHAR(255)    NOT NULL DEFAULT 'system',

        -- Constraints
        PRIMARY KEY (id)
) ENGINE = InnoDB
COMMENT = "Tabla de las runs: bloques de tiempo planificados en el calendario";


-- Tabla intermedia N:M: Relación entre RUN y PRODUCTO
CREATE TABLE IF NOT EXISTS RUN_PRODUCTO (
        id_run                          BIGINT          NOT NULL,
        id_producto                     BIGINT          NOT NULL,

        -- Auditoria Completa
        created_at                      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at                      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        created_by                      VARCHAR(255)    NOT NULL DEFAULT 'system',
        updated_by                      VARCHAR(255)    NOT NULL DEFAULT 'system',

        -- Constraints
        PRIMARY KEY (id_run, id_producto),
        CONSTRAINT fk_runprod_run FOREIGN KEY (id_run) REFERENCES RUN (id) ON DELETE CASCADE,
        CONSTRAINT fk_runprod_prod FOREIGN KEY (id_producto) REFERENCES PRODUCTO (id) ON DELETE CASCADE
) ENGINE = InnoDB
COMMENT = "Relación dinámica N:M entre una RUN y sus productos asignados";


-- Tabla intermedia N:M: Relación entre RUN y LINEA
CREATE TABLE IF NOT EXISTS RUN_LINEA (
        id_run                          BIGINT          NOT NULL,
        id_linea                        BIGINT          NOT NULL,

        -- Auditoria Completa
        created_at                      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at                      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        created_by                      VARCHAR(255)    NOT NULL DEFAULT 'system',
        updated_by                      VARCHAR(255)    NOT NULL DEFAULT 'system',

        -- Constraints
        PRIMARY KEY (id_run, id_linea),
        CONSTRAINT fk_runlin_run FOREIGN KEY (id_run) REFERENCES RUN (id) ON DELETE CASCADE,
        CONSTRAINT fk_runlin_lin FOREIGN KEY (id_linea) REFERENCES LINEA (id) ON DELETE CASCADE
) ENGINE = InnoDB
COMMENT = "Relación dinámica N:M entre una RUN y las líneas asignadas";


-- Tabla de incidencias
CREATE TABLE IF NOT EXISTS INCIDENCIAS (
        -- Clave primaria
        id                              BIGINT          NOT NULL AUTO_INCREMENT,

        -- Atributos
        id_run                          BIGINT          NOT NULL,
        descripcion                     VARCHAR(2000)   NOT NULL,

        -- Auditoria
        created_at                      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at                      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        created_by                      VARCHAR(255)    NOT NULL DEFAULT 'system',
        updated_by                      VARCHAR(255)    NOT NULL DEFAULT 'system',

        -- Constraints
        PRIMARY KEY (id),
        CONSTRAINT fk_incidencias_run FOREIGN KEY (id_run) REFERENCES RUN (id) ON DELETE CASCADE
) ENGINE = InnoDB
COMMENT = "Eventos, proyectos e incidencias reales asociados a una RUN";
