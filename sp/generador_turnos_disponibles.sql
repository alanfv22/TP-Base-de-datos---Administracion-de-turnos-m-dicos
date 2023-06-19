CREATE OR REPLACE FUNCTION generar_turnos_disponibles(anio INT, mes INT) RETURNS BOOLEAN AS $$
DECLARE
    ultimo_dia INT;
    primer_dia_semana INT;
    dia_actual INT;
    _agenda agenda;
    num_turnos INT;
BEGIN
    -- Verificar si ya existen turnos generados para el mes y año solicitado
    IF EXISTS (
        SELECT 1
        FROM turno
        WHERE EXTRACT(YEAR FROM fecha) = anio AND EXTRACT(MONTH FROM fecha) = mes
    ) THEN
        RETURN FALSE;
    END IF;

    -- Calcular el último día para el mes y año solicitado
     ultimo_dia := EXTRACT(DAY FROM DATE(anio || '-' || mes || '-01') + INTERVAL '1 month - 1 day');


    -- Calcular primer dia de la semana para el mes y año solicitado expresado en número 1=Lunes,2=Martes...
    SELECT EXTRACT(DOW FROM DATE(anio || '-' || mes || '-01'))
    INTO primer_dia_semana;
   
    dia_actual := primer_dia_semana;

    -- Generar los turnos disponibles para cada día del mes

    FOR d IN 1..ultimo_dia  -- Recorro los dias del mes solicitado
LOOP
FOR _agenda IN SELECT * FROM agenda WHERE dia = dia_actual  -- Obtengo de agenda los medicos que trabajen en el dia actual
LOOP
num_turnos := (EXTRACT(EPOCH FROM _agenda.hora_hasta) - EXTRACT(EPOCH FROM _agenda.hora_desde)) / EXTRACT(EPOCH FROM _agenda.duracion_turno); -- Obtengo la cantidad de turnos por dia de cada medico
FOR t IN 1..num_turnos -- Inserto la cantidad de turnos correspondientes a cada medico
LOOP      
INSERT INTO turno (fecha, nro_consultorio, dni_medique, estado)
VALUES (TO_TIMESTAMP(anio || '-' || mes || '-' || d || ' ' || _agenda.hora_desde, 'YYYY-MM-DD HH24:MI'), _agenda.nro_consultorio, _agenda.dni_medique, 'disponible');
_agenda.hora_desde := _agenda.hora_desde + _agenda.duracion_turno;
END LOOP;
END LOOP;

        dia_actual := CASE -- Reset de semana
            WHEN dia_actual = 6 THEN 0
            ELSE dia_actual + 1
        END;
       
END LOOP;

    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;