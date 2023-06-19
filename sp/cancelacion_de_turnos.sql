CREATE OR REPLACE FUNCTION cancelacion_de_turnos(dni_medique_param int, desde date, hasta date) RETURNS INTEGER AS
$$
DECLARE
    cancelados integer := 0;
    _record RECORD;
    estado_cancelado char(9) := 'cancelado';
BEGIN
    for _record in (select * from turno WHERE turno.dni_medique = dni_medique_param
                AND estado IN ('disponible', 'reservado')
                AND fecha BETWEEN desde AND hasta) loop
        cancelados := cancelados + 1;
    UPDATE turno SET estado = estado_cancelado WHERE _record.nro_turno = turno.nro_turno;

    IF _record.estado = 'reservado' THEN
        INSERT INTO reprogramacion (nro_turno, nombre_paciente, apellido_paciente, telefono_paciente, email_paciente,
                                    nombre_medique, apellido_medique, estado)
    SELECT turno2.nro_turno, p.nombre, p.apellido, p.telefono, p.email, m.nombre, m.apellido, estado_cancelado
    FROM turno turno2
             JOIN paciente p ON turno2.nro_paciente = p.nro_paciente
             JOIN medique m ON turno2.dni_medique = m.dni_medique
    WHERE turno2.nro_turno = _record.nro_turno;
    END IF;
    end loop;
    RETURN cancelados;
END;
$$ LANGUAGE plpgsql;