CREATE OR REPLACE FUNCTION test_reserva_turnos() RETURNS void AS $$
DECLARE
    solicitud solicitud_reservas%ROWTYPE;
BEGIN
    FOR solicitud IN SELECT * FROM solicitud_reservas ORDER BY nro_orden
    LOOP
        -- Obtener los valores de la solicitud
        DECLARE
            _historia_clinica INT := solicitud.nro_paciente;
            _dni_medique INT := solicitud.dni_medique;
            _fecha_hora TIMESTAMP := solicitud.fecha + solicitud.hora;
        BEGIN
            -- Llamar a la función reserva_turno
            PERFORM reserva_turno(_historia_clinica, _dni_medique, _fecha_hora);
        END;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

