-- PRIMARY KEYS --
ALTER TABLE paciente
    ADD CONSTRAINT paciente_pk PRIMARY KEY (nro_paciente);
ALTER TABLE medique
    ADD CONSTRAINT medique_pk PRIMARY KEY (dni_medique);
ALTER TABLE consultorio
    ADD CONSTRAINT consultorio_pk PRIMARY KEY (nro_consultorio);
ALTER TABLE agenda
    ADD CONSTRAINT agenda_pk PRIMARY KEY (dni_medique, dia);
ALTER TABLE turno
    ADD CONSTRAINT turno_pk PRIMARY KEY (nro_turno);
ALTER TABLE reprogramacion
    ADD CONSTRAINT reprogramacion_pk PRIMARY KEY (nro_turno);
ALTER TABLE error
    ADD CONSTRAINT error_pk PRIMARY KEY (nro_error);
ALTER TABLE cobertura
    ADD CONSTRAINT cobertura_pk PRIMARY KEY (dni_medique, nro_obra_social);
ALTER TABLE obra_social
    ADD CONSTRAINT obra_social_pk PRIMARY KEY (nro_obra_social);
ALTER TABLE liquidacion_cabecera
    ADD CONSTRAINT liquidacion_cabecera_pk PRIMARY KEY (nro_liquidacion);
ALTER TABLE liquidacion_detalle
    ADD CONSTRAINT liquidacion_detalle_pk PRIMARY KEY (nro_liquidacion, nro_linea);
ALTER TABLE envio_email
    ADD CONSTRAINT envio_email_pk PRIMARY KEY (nro_email);


-- FOREIGN KEYS --
ALTER TABLE paciente
    ADD CONSTRAINT paciente_obra_social_fk FOREIGN KEY (nro_obra_social) REFERENCES obra_social (nro_obra_social);
ALTER TABLE agenda
    ADD CONSTRAINT agenda_dni_medique_fk FOREIGN KEY (dni_medique) REFERENCES medique (dni_medique);
ALTER TABLE agenda
    ADD CONSTRAINT agenda_nro_consultorio_fk FOREIGN KEY (nro_consultorio) REFERENCES consultorio (nro_consultorio);
ALTER TABLE turno
    ADD CONSTRAINT turno_nro_consultorio_fk FOREIGN KEY (nro_consultorio) REFERENCES consultorio (nro_consultorio);
ALTER TABLE turno
    ADD CONSTRAINT turno_dni_medique_fk FOREIGN KEY (dni_medique) REFERENCES medique (dni_medique);
ALTER TABLE turno
    ADD CONSTRAINT turno_nro_paciente_fk FOREIGN KEY (nro_paciente) REFERENCES paciente (nro_paciente);
-- ALTER TABLE turno --
--  ADD CONSTRAINT turno_nro_obra_social_fk FOREIGN KEY (nro_obra_social_consulta) REFERENCES obra_social (nro_obra_social); -- 
-- VER SI ESTO HACE REFERENCIA A LA TABLA OBRA SOCIAL O AL ATRIBUTO DE LA TABLA PACIENTE. PRIMER CASO SE DEJA, SEGUNDO CASO SE SACA. TMB PUEDE SER A TABLA COBERTURA
ALTER TABLE reprogramacion
    ADD CONSTRAINT reprogramacion_nro_turno_fk FOREIGN KEY (nro_turno) REFERENCES turno (nro_turno);
/*ALTER TABLE error
    ADD CONSTRAINT error_nro_consultorio_fk FOREIGN KEY (nro_consultorio) REFERENCES consultorio (nro_consultorio);
ALTER TABLE error
    ADD CONSTRAINT error_dni_medique_fk FOREIGN KEY (dni_medique) REFERENCES medique (dni_medique);
ALTER TABLE error*/
 --   ADD CONSTRAINT error_nro_paciente_fk FOREIGN KEY (nro_paciente) REFERENCES paciente (nro_paciente);
ALTER TABLE cobertura
    ADD CONSTRAINT cobertura_dni_medique_fk FOREIGN KEY (dni_medique) REFERENCES medique (dni_medique);
ALTER TABLE cobertura
    ADD CONSTRAINT cobertura_nro_obra_social_fk FOREIGN KEY (nro_obra_social) REFERENCES obra_social (nro_obra_social);
ALTER TABLE liquidacion_cabecera
    ADD CONSTRAINT liquidacion_cabecera_nro_obra_social_fk FOREIGN KEY (nro_obra_social) REFERENCES obra_social (nro_obra_social); --Analizar a que tabla apunta nro_obra_social
ALTER TABLE liquidacion_detalle
    ADD CONSTRAINT liquidacion_detalle_nro_liquidacion_fk FOREIGN KEY (nro_liquidacion) REFERENCES liquidacion_cabecera(nro_liquidacion);


