CREATE OR REPLACE FUNCTION liquidacion_obras_sociales(anio INT, mes INT) RETURNS VOID AS $$

    DECLARE
    _turno RECORD;
    obra_social_id INT;
    monto INT;
    _paciente RECORD;
    _medique RECORD;
    ultimo_dia INT;
    _desde DATE;
    _hasta DATE;
    _liquidacion_cabeceraID INT;

BEGIN
    _desde := anio || '-' || mes || '-' || '01';
    -- Calcular el último día para el mes y año solicitado
    ultimo_dia := EXTRACT(DAY FROM DATE(anio || '-' || mes || '-01') + INTERVAL '1 month - 1 day');
    _hasta := anio || '-' || mes || '-' || ultimo_dia;

    FOR obra_social_id IN (SELECT nro_obra_social FROM obra_social) LOOP
        monto := 0;

          -- obtengo todos los turnos de esa obra social en el mes y año correspondiente
        FOR _turno IN (SELECT * FROM turno t WHERE t.nro_obra_social_consulta = obra_social_id
            AND t.estado = 'atendido'
            AND EXTRACT(YEAR FROM t.fecha) = anio
            AND EXTRACT(MONTH FROM t.fecha) = mes) LOOP
            monto := monto + _turno.monto_obra_social;
        END LOOP;

        INSERT INTO liquidacion_cabecera (nro_obra_social, desde, hasta, total)
        VALUES (obra_social_id, _desde, _hasta, monto) RETURNING nro_liquidacion INTO _liquidacion_cabeceraID;

        -- obtengo todos los turnos de esa obra social en el mes y año correspondiente
        FOR _turno IN (SELECT * FROM turno t WHERE t.nro_obra_social_consulta = obra_social_id
            AND t.estado = 'atendido'
            AND EXTRACT(YEAR FROM t.fecha) = anio
            AND EXTRACT(MONTH FROM t.fecha) = mes) LOOP

        SELECT * INTO _paciente FROM paciente p WHERE p.nro_paciente = _turno.nro_paciente;
        SELECT * INTO _medique FROM medique m WHERE m.dni_medique = _turno.dni_medique;

        INSERT INTO liquidacion_detalle (nro_liquidacion, f_atencion, nro_afiliade, dni_paciente, nombre_paciente, apellido_paciente,
        dni_medique, nombre_medique, apellido_medique, especialidad, monto)
        VALUES (_liquidacion_cabeceraID, _turno.fecha, _turno.nro_afiliade_consulta, _paciente.dni_paciente, _paciente.nombre, _paciente.apellido,
                _turno.dni_medique, _medique.nombre, _medique.apellido, _medique.especialidad, _turno.monto_obra_social);

        UPDATE turno SET estado = 'liquidado' WHERE nro_turno = _turno.nro_turno;
        END LOOP;

    END LOOP;
END;
$$ LANGUAGE plpgsql;
