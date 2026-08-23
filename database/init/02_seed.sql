USE bd_calendario;

-- ---------------------------------------------------------
-- Poblado de la tabla PRODUCTO (24 SKUs de la imagen)
-- ---------------------------------------------------------
INSERT INTO PRODUCTO (sku, nombre_producto) VALUES
(131064, 'Chef Salad w/ Chicken'),
(126123, 'Chicken Chef Salad (AMZ)'),
(126030, 'Chicken Chef Salad (Kroger)'),
(122475, 'Chicken Chef Salad Bowl (WM)'),
(108936, 'Chicken Chef Salad (Sig Select)'),
(127969, 'Chicken Chef Salad (Raleys)'),
(110711, 'Spinach Dijon Salad'),
(129786, 'Sweet Kale Chopped Salad (WM)'),
(102271, 'BLT Round Toss Up Salad Bowl'),
(121499, 'Spinach Dijon Salad (AMZ)'),
(130671, 'Protein Plus Caesar Salad Bowl'),
(102743, 'Caesar w/ Bacon Salad w/ Chicken'),
(125560, 'Caesar Salad w/ Chicken & Bacon (Kroger)'),
(123915, 'Spinach Dijon Salad Bowl'),
(119795, 'Cilantro Avocado Salad'),
(119331, 'Caesar Salad (Good & Gather)'),
(126050, 'Chicken Caesar Salad (Kroger)'),
(126029, 'Santa Fe Salad w/ Chicken (Kroger)'),
(128281, 'Maple Bourbon Chopped Salad Bowl'),
(125639, 'BLT Salad (Kroger)'),
(129782, 'BLT Salad Round Toss Up (WM)'),
(131039, 'Lemon Parmesan Salad'),
(130672, 'Protein Plus Southwest Salad Bowl'),
(127479, 'Sweet Kale Chopped Salad Bowl');

-- ---------------------------------------------------------
-- Poblado de la tabla LINEA
-- ---------------------------------------------------------
INSERT INTO LINEA (id) VALUES
(38),
(39),
(40);

-- ---------------------------------------------------------
-- Poblado de la tabla RUN
-- ---------------------------------------------------------
INSERT INTO RUN (id, fecha_hora_inicio, fecha_hora_final, UPM) VALUES
(1, '2026-08-24 06:00:00', '2026-08-24 14:00:00', 120),
(2, '2026-08-24 14:30:00', '2026-08-24 22:00:00', 110),
(3, '2026-08-25 07:00:00', '2026-08-25 15:00:00', 130);

-- ---------------------------------------------------------
-- Poblado de la tabla RUN_PRODUCTO (Relación N:M)
-- ---------------------------------------------------------
INSERT INTO RUN_PRODUCTO (id_run, id_producto) VALUES
(1, 1),
(2, 2),
(3, 9);

-- ---------------------------------------------------------
-- Poblado de la tabla RUN_LINEA (Relación N:M)
-- ---------------------------------------------------------
INSERT INTO RUN_LINEA (id_run, id_linea) VALUES
(1, 38),
(2, 38),
(3, 39);

-- ---------------------------------------------------------
-- Poblado de la tabla INCIDENCIAS
-- ---------------------------------------------------------
INSERT INTO INCIDENCIAS (id_run, descripcion, created_by, updated_by) VALUES
(1, 'Vamos a alterar el personal para el proyecto de roscon', 'jgarcia', 'jgarcia'),
(2, 'Se va a alterar la velocidad de la run para probar el proyecto 1.23.4', 'mlopez', 'mlopez');
