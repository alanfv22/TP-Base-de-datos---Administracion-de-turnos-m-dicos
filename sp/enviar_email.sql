CREATE OR REPLACE FUNCTION enviar_email()
RETURNS TRIGGER AS $$
BEGIN

--Envio de email cuando un turno es reservado

IF NEW.estado = 'reservado' THEN
DECLARE
    _turno_datos text;
    _medico_datos text;
    _email_paciente text;
BEGIN
    SELECT 'Fecha de turno: ' || NEW.fecha || E'\n' ||
            'Consultorio: ' || NEW.nro_consultorio || E'\n' ||
            'DNI Médico: ' || NEW.dni_medique
    INTO _turno_datos
    FROM turno
    WHERE nro_turno = NEW.nro_turno;

    SELECT 'Nombre Médico: ' || m.nombre   || ' ' || m.apellido|| E'\n' ||
            'Especialidad: ' || m.especialidad || E'\n' ||
            'Telefono: ' || m.telefono
    INTO _medico_datos
    FROM turno t
    JOIN medique m ON t.dni_medique = m.dni_medique
    WHERE t.nro_turno = NEW.nro_turno;

    SELECT email
    INTO _email_paciente
    FROM paciente p
    WHERE NEW.nro_paciente =  p.nro_paciente;

    INSERT INTO envio_email (f_generacion, email_paciente, asunto, cuerpo, f_envio, estado)
    VALUES (CURRENT_TIMESTAMP, _email_paciente, 'Reserva de turno', _turno_datos || E'\n' || _medico_datos, NULL, 'pendiente');
END;
END IF;


--Envio de email cuando un turno es cancelado

IF  NEW.estado = 'cancelado' THEN
DECLARE
    _turno_datos text;
    _medico_datos text;
    _email_paciente text;
BEGIN
    SELECT 'Fecha de turno: ' || NEW.fecha || E'\n' ||
            'Consultorio: ' || NEW.nro_consultorio || E'\n' ||
            'DNI Médico: ' || NEW.dni_medique
    INTO _turno_datos
    FROM turno
    WHERE nro_turno = NEW.nro_turno;

    SELECT 'Nombre Médico: ' || m.nombre   || ' ' || m.apellido|| E'\n' ||
            'Especialidad: ' || m.especialidad || E'\n' ||
            'Telefono: ' || m.telefono
    INTO _medico_datos
    FROM turno t
    JOIN medique m ON t.dni_medique = m.dni_medique
    WHERE t.nro_turno = NEW.nro_turno;

    SELECT email
    INTO _email_paciente
    FROM paciente p
    WHERE NEW.nro_paciente =  p.nro_paciente;

    INSERT INTO envio_email (f_generacion, email_paciente, asunto, cuerpo, f_envio, estado)
    VALUES (CURRENT_TIMESTAMP, _email_paciente, 'Cancelacion de turno', _turno_datos || E'\n' || _medico_datos, NULL, 'pendiente');
END;
END IF;

RETURN NEW;
END;
$$ LANGUAGE plpgsql;