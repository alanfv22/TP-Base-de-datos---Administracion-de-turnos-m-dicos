CREATE OR REPLACE FUNCTION reserva_turno(numhistoria_clinica INT, dni_de_medique INT, fecha_hora TIMESTAMP) RETURNS BOOLEAN AS $$
declare
	resultado record;
	resultadopunto3 record; -- aca guardo nro obra social paciente
	resultadopunto4 record;
	mensajeInvalido text;
	mensajeAError text;

begin
	
	-- que el dni de medique exista. en caso de no cumplir se debe cargar un error con el mensaje "dni medique no valido"

	select * into resultado from medique where medique.dni_medique = dni_de_medique;
	 
	if not found then
	    RAISE NOTICE 'dni de medique no valido';
	--	mensajeInvalido:=mensajeInvalido||' - dni de medique no valido';
		mensajeAError:='?dni de medique no valido';
		select * into resultado from turno where turno.fecha=fecha_hora;
		insert into error (f_turno,nro_consultorio,dni_medique, nro_paciente, operacion,f_error,motivo)
		values(fecha_hora,resultado.nro_consultorio,dni_de_medique,numhistoria_clinica,'reserva',CURRENT_TIMESTAMP,mensajeAError);
		return false;
	end if;
	
	
	-- numero de historia clinica exista en caso de no cumplir se carga mensaje con error ?nro historia clinica no valido
	
	select * into resultado from paciente where paciente.nro_paciente = numhistoria_clinica;
	if not found then
	    RAISE NOTICE 'nro de historia clinica no valido';
		--mensajeInvalido:=mensajeInvalido||' - nro de historia clinica no valido';
		mensajeAError:='?nro de historia clinica no valido';
		select * into resultado from turno where turno.fecha=fecha_hora;
		insert into error (f_turno,nro_consultorio,dni_medique, nro_paciente, operacion,f_error,motivo)
		values(fecha_hora,resultado.nro_consultorio,dni_de_medique,numhistoria_clinica,'reserva',CURRENT_TIMESTAMP,mensajeAError);
		return false;
	end if;
	
	-- si el paciente tiene una obra social, que le medique trabaje con esa obra social
	-- en caso de que no se cumpla, se debe cargar un error con el mensaje 
	-- > ?obra social de paciente no atendida por le medique
	
	-- select * into resultado from paciente, cobertura , medique where paciente.nro_paciente = numhistoria_clinica and 
	--paciente.nro_obra_social = cobertura.nro_obra_social and medique.dni_medique=cobertura.dni_medique;
	select * into resultadopunto3 from paciente where paciente.nro_paciente = numhistoria_clinica;
	
	raise notice 'nro obra social paciente: %', resultadopunto3.nro_obra_social;
	IF resultadopunto3.nro_obra_social IS NOT NULL THEN
        IF NOT EXISTS (
            SELECT 1
            FROM cobertura
            WHERE resultadopunto3.nro_obra_social = cobertura.nro_obra_social and cobertura.dni_medique=dni_de_medique
        ) THEN
	        RAISE NOTICE 'obra social de paciente no atendida por le medique';
            --mensajeInvalido:=mensajeInvalido||' - obra social de paciente no atendida por le medique';
            mensajeAError:='?obra social de paciente no atendida por le medique';
            select * into resultado from turno where turno.fecha=fecha_hora;
            insert into error (f_turno,nro_consultorio,dni_medique, nro_paciente, operacion,f_error,motivo)
            values(fecha_hora,resultado.nro_consultorio,dni_de_medique,numhistoria_clinica,'reserva',CURRENT_TIMESTAMP,mensajeAError);
            return false;
        END IF;
	END IF;
	-- que exista el turno de le medique para la fecha y la hora solicitadas y que se encuentre disponible.
	-- en caso de que no cumpla, debe cargar un error con el mensaje ?turno inexistente o no disponible
	select * into resultado from turno where turno.fecha=fecha_hora and turno.estado='disponible' and turno.dni_medique=dni_de_medique;
	if not found then
		raise notice 'ver fecha resultado No se encontro: %', resultado;
		--mensajeInvalido:=mensajeInvalido||' - turno inexistente o no disponible';
		mensajeAError:='?turno inexistente o no disponible';
		insert into error (f_turno,nro_consultorio,dni_medique, nro_paciente, operacion,f_error,motivo)
		values(fecha_hora,resultado.nro_consultorio,dni_de_medique,numhistoria_clinica,'reserva',CURRENT_TIMESTAMP,mensajeAError);
		return false;
	end if;
	
	-- que le paciente no haya llegado a al limite de 5 turnos en estado de reserva en estado reservado
	-- en caso de que no cumpla , se debe cargar un error con el mensaje 
	-- supera limite de reserva de turnos
	
	select count(*) into resultado from turno where turno.nro_paciente=numhistoria_clinica and turno.estado='reservado';
	raise notice 'contador: %', resultado.count;
	
	if (resultado.count >= 5) then
	    RAISE NOTICE 'supera limite de reserva de turnos';
		mensajeAError:=' ?supera limite de reserva de turnos';
		select * into resultado from turno where turno.fecha=fecha_hora and turno.estado='disponible' and turno.dni_medique=dni_de_medique;
		insert into error (f_turno,nro_consultorio,dni_medique, nro_paciente, operacion,f_error,motivo)
		values(fecha_hora,resultado.nro_consultorio,dni_de_medique,numhistoria_clinica,'reserva',CURRENT_TIMESTAMP,mensajeAError);
		return false;
	end if;

		raise notice 'entonces se reserva';
		select * into resultado from paciente where nro_paciente=numhistoria_clinica;
		select * into resultadopunto4 from cobertura, turno, paciente where turno.dni_medique=cobertura.dni_medique and turno.dni_medique= dni_de_medique and
		 paciente.nro_obra_social=cobertura.nro_obra_social;
		 raise notice 'el monto : %', resultadopunto4.monto_paciente;
		 raise notice 'el monto : %', resultadopunto4.monto_obra_social;
		update turno 
		set nro_paciente=numhistoria_clinica,
			nro_obra_social_consulta=resultado.nro_obra_social,
			nro_afiliade_consulta=resultado.nro_afiliade,
			monto_paciente=resultadopunto4.monto_paciente,
			monto_obra_social=resultadopunto4.monto_obra_social,
			f_reserva=CURRENT_TIMESTAMP,
			estado='reservado' 
		where turno.fecha=fecha_hora and turno.estado='disponible' and turno.dni_medique=dni_de_medique;

	return true;
	
end;
$$ LANGUAGE plpgsql;
