

-- Crear vista para consultas de consumo por colaborador
CREATE VIEW vw_ConsumoColaborador AS
SELECT 
    c.colaborador_id,
    c.codigo_colaborador,
    c.nombre_completo,
    r.referencia_id,
    r.fecha,
    SUM(rd.valor_subsidiado) AS total_subsidiado,
    SUM(rd.valor_no_subsidio) AS total_no_subsidiado,
    SUM(rd.valor_subsidiado + rd.valor_no_subsidio) AS total_consumo,
    r.estado_nomina
FROM 
    COLABORADORES c
    INNER JOIN RECIBOS r ON c.colaborador_id = r.colaborador_id
    INNER JOIN RECIBO_DETALLES rd ON r.referencia_id = rd.referencia_id
GROUP BY 
    c.colaborador_id,
    c.codigo_colaborador,
    c.nombre_completo,
    r.referencia_id,
    r.fecha,
    r.estado_nomina;

-- Procedimiento almacenado para obtener reporte de consumo quincenal
CREATE PROCEDURE sp_ReporteConsumoQuincenal
    @FechaInicio DATE,
    @FechaFin DATE
AS
BEGIN
    SELECT 
        c.colaborador_id,
        c.codigo_colaborador,
        c.nombre_completo,
        SUM(CASE WHEN r.estado_nomina = 'Pendiente' THEN rd.valor_subsidiado ELSE 0 END) AS total_subsidiado_pendiente,
        SUM(CASE WHEN r.estado_nomina = 'Pendiente' THEN rd.valor_no_subsidio ELSE 0 END) AS total_no_subsidiado_pendiente,
        SUM(CASE WHEN r.estado_nomina = 'Pendiente' THEN (rd.valor_subsidiado + rd.valor_no_subsidio) ELSE 0 END) AS total_a_procesar
    FROM 
        COLABORADORES c
        INNER JOIN RECIBOS r ON c.colaborador_id = r.colaborador_id
        INNER JOIN RECIBO_DETALLES rd ON r.referencia_id = rd.referencia_id
    WHERE 
        r.fecha BETWEEN @FechaInicio AND @FechaFin
    GROUP BY 
        c.colaborador_id,
        c.codigo_colaborador,
        c.nombre_completo
    ORDER BY 
        c.nombre_completo;
END;
GO

-- Trigger para actualizar subsidio en detalle de recibo
CREATE TRIGGER trg_ActualizarSubsidio
ON RECIBO_DETALLES
AFTER INSERT
AS
BEGIN
    UPDATE rd
    SET rd.aplico_subsidio = a.aplica_subsidio,
        rd.valor_subsidiado = CASE WHEN a.aplica_subsidio = 1 THEN i.cantidad * a.valor_empleado ELSE 0 END,
        rd.valor_no_subsidio = CASE WHEN a.aplica_subsidio = 0 THEN i.cantidad * a.valor_empresa ELSE 0 END
    FROM RECIBO_DETALLES rd
    INNER JOIN inserted i ON rd.referencia_id = i.referencia_id AND rd.articulo_id = i.articulo_id
    INNER JOIN ARTICULOS a ON i.articulo_id = a.articulo_id
    WHERE a.estado_id = 1; -- Solo aplica para artículos activos
END;
GO