

-- Insertar datos de ejemplo en tabla ESTADOS
INSERT INTO ESTADOS (estado_id, descripcion) VALUES
(1, 'Activo'),
(2, 'Inactivo'),
(3, 'Suspendido');

-- Insertar datos de ejemplo en tabla TIPO_CAJEROS
INSERT INTO TIPO_CAJEROS (tipo_cajero_id, descripcion) VALUES
(1, 'Cajero Senior'),
(2, 'Cajero Junior');

-- Insertar datos de ejemplo en tabla COLABORADORES
INSERT INTO COLABORADORES (colaborador_id, estado_id, codigo_colaborador, nombre_completo, limite_credito, correo_electronico, fecha_creacion) VALUES
(1, 1, 'EMP001', 'Juan Pérez Rodríguez', 2000.00, 'juan.perez@contact-center.com', '2023-01-15'),
(2, 1, 'EMP002', 'Ana Díaz', 1500.00, 'maria.gonzalez@contact-center.com', '2023-02-10'),
(3, 1, 'EMP003', 'Carlos Ramírez Díaz', 2500.00, 'carlos.ramirez@contact-center.com', '2022-11-05'),
(4, 1, 'EMP004', 'Miguel Pérez', 1800.00, 'ana.martinez@contact-center.com', '2023-03-20'),
(5, 1, 'EMP005', 'Pedro Rodríguez Pérez', 1800.00, 'ana.martinez@contact-center.com', '2023-03-20'),
(6, 1, 'EMP006', 'Jose Alcantara Abreu', 1800.00, 'ana.martinez@contact-center.com', '2023-03-20');

-- Insertar datos de ejemplo en tabla CAJEROS
INSERT INTO CAJEROS (cajero_id, tipo_cajero_id, estado_id, usuario_nombre, fecha_creacion) VALUES
(1, 1, 1, 'Kelvin Feliz', '2023-01-01'),
(2, 2, 1, 'Felix Perez', '2023-01-05'),
(3, 2, 1, 'Miguel Consoro', '2023-02-15'),
(4, 2, 1, 'Luis Gonzalez', '2023-01-10');


-- Insertar datos de ejemplo en tabla ARTICULOS
INSERT INTO ARTICULOS (articulo_id, estado_id, descripcion, valor_empleado, valor_empresa, aplica_subsidio, fecha_creacion) VALUES
(1, 1, 'Café americano', 25.00, 25.00, 1, '2023-01-02'),
(2, 1, 'Sándwich de jamón y queso', 100.00, 50.00, 1, '2023-01-02'),
(3, 1, 'Torta de chocolate', 150.00, 0.00, 0, '2023-01-05'),
(4, 1, 'Plato del día', 100.00, 75.00, 1, '2023-01-05'),
(5, 1, 'Refresco', 35.00, 35.00, 1, '2023-01-03'),
(6, 2, 'Galletas', 15.00, 15.00, 0, '2023-01-04'),
(7, 1, 'Ensalada César', 100.00, 50.00, 1, '2023-01-03');


-- Insertar datos de ejemplo en tabla RECIBOS
INSERT INTO RECIBOS (colaborador_id, cajero_id, fecha, estado_nomina, correlativo_nomina, fecha_procesado) VALUES
(1, 2, '2025-04-10', 'Procesado', 'N-ABRIL-25', NULL),
(2, 2, '2025-04-10', 'Procesado', 'N-ABRIL-25', NULL),
(2, 2, '2025-04-11', 'Procesado', 'N-ABRIL-25', NULL),
(3, 2, '2025-04-12', 'Pendiente', NULL, NULL),
(2, 1, '2025-04-12', 'Pendiente', NULL, NULL);

-- Insertar datos de ejemplo en tabla RECIBO_DETALLES
INSERT INTO RECIBO_DETALLES (referencia_id, articulo_id, cantidad, aplico_subsidio, valor_subsidiado, valor_no_subsidio) VALUES
(1, 1, 1, 1, 25.00, 25.00),
(2, 1, 1, 1, 25.00, 25.00),
(2, 4, 1, 1, 75.00, 100.00),
(2, 3, 2, 1, 0.00, 300.00);



