CREATE OR REPLACE FUNCTION enviar_email_recordatorio() RETURNS VOID AS $$
DECLARE
    fecha_turno date := current_date + interval '2 days';
    cuerpo_text text;
    email_data record;
    asunto_email text := 'Recordatorio de turno';

BEGIN
FOR email_data IN (
        SELECT p.nombre AS paciente_nombre, p.apellido AS paciente_apellido , p.email ,t.fecha AS fecha_turno, m.apellido AS medique_apellido
        FROM paciente p
        JOIN turno t ON p.nro_paciente = t.nro_paciente
        JOIN medique m ON t.dni_medique = m.dni_medique
        WHERE t.estado = 'reservado'
        AND t.fecha::DATE = fecha_turno -- para comparar el dia indistintamente de la hora
    ) LOOP
        cuerpo_text := 'Estimado/a ' || email_data.paciente_nombre || ' ' || email_data.paciente_apellido || ', ';
        cuerpo_text := cuerpo_text || 'le recordamos que tiene un turno reservado para el día ' || email_data.fecha_turno || ' con el médique ' || email_data.medique_apellido;
        cuerpo_text := cuerpo_text || '\n Por favor, asegúrese de asistir a su consulta 15 minutos antes del horario establecido.';
        cuerpo_text := cuerpo_text || '\n Saludos cordiales';

    IF NOT EXISTS (SELECT 1 FROM envio_email WHERE asunto = asunto_email AND cuerpo = cuerpo_text) THEN
        INSERT INTO envio_email (f_generacion, email_paciente, asunto, cuerpo, f_envio, estado)
        VALUES (current_date, email_data.email, asunto_email, cuerpo_text, current_date, 'pendiente');
    END IF;
END LOOP;
    RETURN;
END;
$$ LANGUAGE plpgsql;