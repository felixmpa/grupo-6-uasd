-- Scripts SQL para la creación de tablas en SQL Server
-- Sistema de Gestión de Subsidio de Alimentación para Colaboradores

-- Eliminar base de datos (inicial)
IF DB_ID('cafeteria_development') IS NOT NULL
BEGIN
    ALTER DATABASE cafeteria_development SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE cafeteria_development;
END
GO


-- Crear base de datos
CREATE DATABASE cafeteria_development;
GO

USE cafeteria_development;
GO

-- Tabla ESTADOS
CREATE TABLE ESTADOS (
    estado_id INT PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL
);

-- Tabla TIPO_CAJEROS
CREATE TABLE TIPO_CAJEROS (
    tipo_cajero_id INT PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL
);

-- Tabla COLABORADORES
CREATE TABLE COLABORADORES (
    colaborador_id INT PRIMARY KEY,
    estado_id INT NOT NULL,
    codigo_colaborador VARCHAR(10) NOT NULL,
    nombre_completo VARCHAR(100) NOT NULL,
    limite_credito DECIMAL(10,2) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL,
    fecha_creacion DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Colaboradores_Estados FOREIGN KEY (estado_id) REFERENCES ESTADOS(estado_id)
);


-- Tabla CAJEROS
CREATE TABLE CAJEROS (
    cajero_id INT PRIMARY KEY,
    tipo_cajero_id INT NOT NULL,
    estado_id INT NOT NULL,
    usuario_nombre VARCHAR(50) NOT NULL,
    fecha_creacion DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Cajeros_TipoCajeros FOREIGN KEY (tipo_cajero_id) REFERENCES TIPO_CAJEROS(tipo_cajero_id),
    CONSTRAINT FK_Cajeros_Estados FOREIGN KEY (estado_id) REFERENCES ESTADOS(estado_id)
);

-- Tabla ARTICULOS
CREATE TABLE ARTICULOS (
    articulo_id INT PRIMARY KEY,
    estado_id INT NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    valor_empleado DECIMAL(10,2) NOT NULL,
    valor_empresa DECIMAL(10,2) NOT NULL,
    aplica_subsidio BIT NOT NULL,
    fecha_creacion DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Articulos_Estados FOREIGN KEY (estado_id) REFERENCES ESTADOS(estado_id)
);


-- Tabla RECIBOS
CREATE TABLE RECIBOS (
    referencia_id INT PRIMARY KEY IDENTITY(1,1),
    colaborador_id INT NOT NULL,
    cajero_id INT NOT NULL,
    fecha DATETIME NOT NULL DEFAULT GETDATE(),
    estado_nomina VARCHAR(20) NULL,
    correlativo_nomina VARCHAR(20) NULL,
    fecha_procesado DATETIME NULL,
    CONSTRAINT FK_Recibos_Colaboradores FOREIGN KEY (colaborador_id) REFERENCES COLABORADORES(colaborador_id),
    CONSTRAINT FK_Recibos_Cajeros FOREIGN KEY (cajero_id) REFERENCES CAJEROS(cajero_id)
);

-- Tabla RECIBO_DETALLES
CREATE TABLE RECIBO_DETALLES (
    referencia_id INT NOT NULL,
    articulo_id INT NOT NULL,
    cantidad INT NOT NULL,
    aplico_subsidio BIT NOT NULL,
    valor_subsidiado DECIMAL(10,2) NOT NULL,
    valor_no_subsidio DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_ReciboDetalles PRIMARY KEY (referencia_id, articulo_id),
    CONSTRAINT FK_ReciboDetalles_Recibos FOREIGN KEY (referencia_id) REFERENCES RECIBOS(referencia_id),
    CONSTRAINT FK_ReciboDetalles_Articulos FOREIGN KEY (articulo_id) REFERENCES ARTICULOS(articulo_id)
);