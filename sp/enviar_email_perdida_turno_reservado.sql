CREATE OR REPLACE FUNCTION enviar_email_perdida_turno_reservado() RETURNS VOID AS $$
DECLARE
    fecha_turno date := current_date - 1;
    asunto_text text := 'Pérdida de turno reservado';
    cuerpo_text text;
    email_data record;
BEGIN
FOR email_data IN (
        SELECT p.nombre AS paciente_nombre, p.apellido AS paciente_apellido, p.email, t.fecha AS f_turno,
               t.nro_consultorio AS consultorio, m.apellido AS medique_apellido
        FROM paciente p
        JOIN turno t ON p.nro_paciente = t.nro_paciente
        JOIN medique m ON t.dni_medique = m.dni_medique
        WHERE t.estado = 'reservado'
        AND t.fecha::DATE = fecha_turno -- para comparar el dia indistintamente de la hora. Como se ejecuta al final del dia, se ven los turnos que no han sido atendidos
    ) LOOP
        cuerpo_text := 'Estimado/a ' || email_data.paciente_nombre || ' ' || email_data.paciente_apellido || ', ';
        cuerpo_text := cuerpo_text || 'en el dia de la fecha ' || email_data.f_turno::DATE || ' no ha concurrido a su turno con le médique ' || email_data.medique_apellido;
        cuerpo_text := cuerpo_text || ' en el consultorio numero ' || email_data.consultorio;
        cuerpo_text := cuerpo_text || '\n Saludos cordiales';

        IF NOT EXISTS (SELECT 1 FROM envio_email WHERE asunto = asunto_text AND cuerpo = cuerpo_text) THEN
        INSERT INTO envio_email (f_generacion, email_paciente, asunto, cuerpo, f_envio, estado)
        VALUES (current_date, email_data.email, asunto_text, cuerpo_text, current_date, 'pendiente');
        END IF;
    END LOOP;
    RETURN;
END;
$$ LANGUAGE plpgsql;