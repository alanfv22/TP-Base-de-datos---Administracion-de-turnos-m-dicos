-- FOREIGN KEYS --

ALTER TABLE paciente
    DROP CONSTRAINT paciente_obra_social_fk;
ALTER TABLE agenda
    DROP CONSTRAINT agenda_dni_medique_fk;
ALTER TABLE agenda
    DROP CONSTRAINT agenda_nro_consultorio_fk;
ALTER TABLE turno
    DROP CONSTRAINT turno_nro_consultorio_fk;
ALTER TABLE turno
    DROP CONSTRAINT turno_dni_medique_fk;
ALTER TABLE turno
    DROP CONSTRAINT turno_nro_paciente_fk;
ALTER TABLE reprogramacion
    DROP CONSTRAINT reprogramacion_nro_turno_fk;
ALTER TABLE cobertura
    DROP CONSTRAINT cobertura_dni_medique_fk;
ALTER TABLE cobertura
    DROP CONSTRAINT cobertura_nro_obra_social_fk;
ALTER TABLE liquidacion_cabecera
    DROP CONSTRAINT liquidacion_cabecera_nro_obra_social_fk;
ALTER TABLE liquidacion_detalle
    DROP CONSTRAINT liquidacion_detalle_nro_liquidacion_fk;

-- PRIMARY KEYS --

ALTER TABLE paciente
    DROP CONSTRAINT paciente_pk;
ALTER TABLE medique
    DROP CONSTRAINT medique_pk;
ALTER TABLE consultorio
    DROP CONSTRAINT consultorio_pk;
ALTER TABLE agenda
    DROP CONSTRAINT agenda_pk;
ALTER TABLE turno
    DROP CONSTRAINT turno_pk;
ALTER TABLE reprogramacion
    DROP CONSTRAINT reprogramacion_pk;
ALTER TABLE error
    DROP CONSTRAINT error_pk;
ALTER TABLE cobertura
    DROP CONSTRAINT cobertura_pk;
ALTER TABLE obra_social
    DROP CONSTRAINT obra_social_pk;
ALTER TABLE liquidacion_cabecera
    DROP CONSTRAINT liquidacion_cabecera_pk;
ALTER TABLE liquidacion_detalle
    DROP CONSTRAINT liquidacion_detalle_pk;
ALTER TABLE envio_email
    DROP CONSTRAINT envio_email_pk;
