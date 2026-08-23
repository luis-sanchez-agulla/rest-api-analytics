-- Seleccionamos la base de las incidencias del calendario
USE bd_calendario;

 ---------------------------------------------------------Creacion de tablas---------------------------------------------------------

-- Tabla de prouctos 
CREATE TABLE IF NOT EXISTS PRODUCTO (
	-- Clave primaria
	id				BIGINT		NOT NULL AUTO_INCREMENT,

	-- Atributos
	nombre_producto			VARCHAR(80)	NOT NULL,

	-- Auditoria
	created_at 			DATETIME 	NOT NULL DEFAULT CURRENT_TIMESTAMP,
    	updated_at 			DATETIME 	NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    	created_by 			VARCHAR(255) 	NOT NULL DEFAULT 'system',
    	updated_by 			VARCHAR(255) 	NOT NULL DEFAULT 'system',

	-- Constraints
	PRIMARY KEY (id),

) ENGINE = InnoDB
COMMENT = "tabla de productos: en esta tabla vamos a meter los productos que vamos a producir en las runs";

CREATE TABLE IF NOT EXISTS LINEA (
	-- Clave primaria
	id				BIGINT 		NOT NULL AUTO_INCREMENT,

	-- Atributos

	-- Auditoria
	created_at 			DATETIME 	NOT NULL DEFAULT CURRENT_TIMESTAMP,
    	updated_at 			DATETIME 	NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    	created_by 			VARCHAR(255) 	NOT NULL DEFAULT 'system',
    	updated_by 			VARCHAR(255) 	NOT NULL DEFAULT 'system',

	-- Constraints	
)ENGINE=InnoDB
COMMENT = "tabla de las lineas: contiene informacion de las lineas";


-- Tabla de runs
CREATE TABLE IF NOT EXISTS RUN (
	-- Clave primaria
	id 				BIGINT 		NOT NULL AUTO_INCREMENT,

	-- Atributos
	id_producto			BIGINT		NOT NULL,
	id_linea			BIGINT		NOT NULL,
	hora_incio			DATETIME	NOT NULL,
	hora_final			DATETIME	NOT NULL,
	UPM				INT		NOT NULL,

	-- Auditoria
    	created_at 			DATETIME 	NOT NULL DEFAULT CURRENT_TIMESTAMP,
    	updated_at 			DATETIME 	NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    	created_by 			VARCHAR(255) 	NOT NULL DEFAULT 'system',
    	updated_by 			VARCHAR(255) 	NOT NULL DEFAULT 'system',

	-- Constraints
	PRIMARY KEY	(id),
	CONSTRAINT 	fk_id_producto	FOREING KEY (id_producto)	REFERENCES PRODUCTO (id),
	CONSTRAINT 	fk_id_linea	FOREING KEY (id_linea)		REFERENCES LINEA    (id),
) ENGINE=InnoDB
COMMENT = "tabla de las runs: contiene informacion para añadir al calendario de las runs que se van a hacer durante la semana";


-- Tabla de incidencias
CREATE TABLE IF NOT EXISTS INCIDENCIAS (
	-- Clave primaria
	id 				BIGINT 		NOT NULL AUTO_INCREMENT,

	-- Atributos
	id_run				BIGINT		NOT NULL,
	id_linea			BIGINT		NOT NULL,
	id_producto			BIGINT		NOT NULL,
	descripcion			VARCHAR(2000)	NOT NULL,

	-- Auditoria
	created_at 			DATETIME 	NOT NULL DEFAULT CURRENT_TIMESTAMP,
    	updated_at 			DATETIME 	NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    	created_by 			VARCHAR(255) 	NOT NULL,
    	updated_by 			VARCHAR(255) 	NOT NULL DEFAULT 'system',


	-- Constraints
	PRIMARY KEY	(id),
	CONSTRAINT 	fk_id_producto	FOREING KEY (id_producto)	REFERENCES PRODUCTO (id),
	CONSTRAINT 	fk_id_linea	FOREING KEY (id_linea)		REFERENCES LINEA    (id),
	CONSTRAINT	fk_id_run	FOREING KEY (id_run)		REFERENCES RUN	    (id),
) ENGINE=InnoDB
COMMENT = "tabla de las incidencias: contiene las tablas de las incidencias/proyectos que se van a hacer en las runs";
