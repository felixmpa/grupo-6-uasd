-- 1. Insertar un nuevo colaborador
INSERT INTO COLABORADORES (colaborador_id, estado_id, codigo_colaborador, nombre_completo, limite_credito, correo_electronico)
VALUES (7, 1, 'EMP007', 'Laura Fernández', 2200.00, 'laura.fernandez@contact-center.com');

-- 2. Insertar un nuevo cajero
INSERT INTO CAJEROS (cajero_id, tipo_cajero_id, estado_id, usuario_nombre)
VALUES (5, 2, 1, 'Carla Jiménez');

-- 3. Insertar un nuevo artículo
INSERT INTO ARTICULOS (articulo_id, estado_id, descripcion, valor_empleado, valor_empresa, aplica_subsidio)
VALUES (8, 1, 'Batido de frutas', 80.00, 50.00, 1);

-- 4. Insertar un nuevo recibo
-- (Se asume que ya se creó el colaborador_id 7 y cajero_id 5)
INSERT INTO RECIBOS (colaborador_id, cajero_id, fecha, estado_nomina)
VALUES (7, 5, GETDATE(), 'Pendiente');

-- 5. Insertar un nuevo detalle de recibo
-- (Se asume que el recibo de referencia_id 6 existe en la tabla RECIBOS)
INSERT INTO RECIBO_DETALLES (referencia_id, articulo_id, cantidad, aplico_subsidio, valor_subsidiado, valor_no_subsidio)
VALUES (6, 8, 2, 1, 100.00, 160.00);

-- 6. Actualizar el límite de crédito de un colaborador
UPDATE COLABORADORES
SET limite_credito = limite_credito + 500
WHERE nombre_completo = 'Laura Fernández';

-- 7. Actualizar el estado de un cajero
UPDATE CAJEROS
SET estado_id = 2
WHERE usuario_nombre = 'Carla Jiménez';

-- Actualizar el estado de un cajero
UPDATE CAJEROS
SET estado_id = 2
WHERE usuario_nombre = 'Carla Jiménez';

UPDATE c
SET c.limite_credito = c.limite_credito + 1000
FROM COLABORADORES c
INNER JOIN ESTADOS e ON c.estado_id = e.estado_id
WHERE e.descripcion = 'Activo' AND c.limite_credito < 2000;


-- 8. Eliminar un artículo que esté en estado "Inactivo" y se llame 'Galletas'
DELETE FROM ARTICULOS
WHERE estado_id = 2 AND descripcion = 'Galletas';

-- 9. Consultar recibos junto al nombre del colaborador y del cajero (INNER JOIN)
SELECT r.referencia_id, c.nombre_completo AS colaborador, cj.usuario_nombre AS cajero, r.fecha
FROM RECIBOS r
INNER JOIN COLABORADORES c ON r.colaborador_id = c.colaborador_id
INNER JOIN CAJEROS cj ON r.cajero_id = cj.cajero_id;

-- 10. Consultar detalles de artículos vendidos en cada recibo (INNER JOIN)
SELECT rd.referencia_id, a.descripcion, rd.cantidad, rd.valor_subsidiado, rd.valor_no_subsidio
FROM RECIBO_DETALLES rd
INNER JOIN ARTICULOS a ON rd.articulo_id = a.articulo_id;
-----


SELECT
    r.referencia_id,
    c.codigo_colaborador,
    c.nombre_completo AS nombre_colaborador,
    e.descripcion AS estado_colaborador,
    cj.usuario_nombre AS nombre_cajero,
    tc.descripcion AS tipo_cajero,
    r.fecha AS fecha_recibo,
    r.estado_nomina,
    r.correlativo_nomina,
    r.fecha_procesado,
    a.descripcion AS articulo,
    rd.cantidad,
    rd.aplico_subsidio,
    rd.valor_subsidiado,
    rd.valor_no_subsidio
FROM RECIBOS r
INNER JOIN COLABORADORES c ON r.colaborador_id = c.colaborador_id
INNER JOIN ESTADOS e ON c.estado_id = e.estado_id
INNER JOIN CAJEROS cj ON r.cajero_id = cj.cajero_id
INNER JOIN TIPO_CAJEROS tc ON cj.tipo_cajero_id = tc.tipo_cajero_id
INNER JOIN RECIBO_DETALLES rd ON r.referencia_id = rd.referencia_id
INNER JOIN ARTICULOS a ON rd.articulo_id = a.articulo_id
WHERE e.descripcion = 'Activo' -- opcional: solo colaboradores activos
ORDER BY r.fecha DESC, c.nombre_completo;



----





