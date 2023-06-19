CREATE OR REPLACE FUNCTION atencion_de_turno(nro_turno_aux INT) RETURNS BOOLEAN AS $$
DECLARE
   _turno RECORD;
BEGIN
   SELECT estado, f_reserva, nro_consultorio, dni_medique, nro_paciente INTO _turno
   FROM turno
   WHERE nro_turno = nro_turno_aux;

   IF _turno.estado IS NULL THEN
      INSERT INTO error(f_turno, nro_consultorio, dni_medique, nro_paciente, operacion, f_error, motivo)
      VALUES (_turno.f_reserva, _turno.nro_consultorio, _turno.dni_medique, _turno.nro_paciente, 'atencion', current_date, '?nro de turno no válido');
      RETURN FALSE;
   END IF;

   IF _turno.estado <> 'reservado' THEN
      INSERT INTO error(f_turno, nro_consultorio, dni_medique, nro_paciente, operacion, f_error, motivo)
      VALUES (_turno.f_reserva, _turno.nro_consultorio, _turno.dni_medique, _turno.nro_paciente, 'atencion', current_date, '?turno no reservado');
      RETURN FALSE;
   END IF;

   IF _turno.f_reserva::DATE <> current_date THEN -- Solo se compara la fecha sin importar la hora
      INSERT INTO error(f_turno, nro_consultorio, dni_medique, nro_paciente, operacion, f_error, motivo)
      VALUES (_turno.f_reserva, _turno.nro_consultorio, _turno.dni_medique, _turno.nro_paciente, 'atencion', current_date, '?turno no corresponde a la fecha del día');
      RETURN FALSE;
   END IF;

   UPDATE turno SET estado = 'atendido' WHERE nro_turno = nro_turno_aux;

   RETURN TRUE;
END;
$$ LANGUAGE plpgsql;