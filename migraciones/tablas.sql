CREATE TABLE paciente
(
    nro_paciente    int,
    nombre          text,
    apellido        text,
    dni_paciente    int,
    f_nac           date,
    nro_obra_social int,
    nro_afiliade    int,
    domicilio       text,
    telefono        char(12),
    email           text
);


CREATE TABLE medique
(
    dni_medique            int,
    nombre                 text,
    apellido               text,
    especialidad           varchar(64),
    monto_consulta_privada decimal(12, 2),
    telefono               char(12)
);

CREATE TABLE consultorio
(
    nro_consultorio serial,
    nombre          text,
    domicilio       text,
    codigo_postal   char(8),
    telefono        char(12)
);


CREATE TABLE agenda
(
    dni_medique     int,
    dia             int,
    nro_consultorio int,
    hora_desde      time,
    hora_hasta      time,
    duracion_turno  interval
);


CREATE TABLE turno
(
    nro_turno                serial,
    fecha                    timestamp,
    nro_consultorio          int,
    dni_medique              int,
    nro_paciente             int,
    nro_obra_social_consulta int,
    nro_afiliade_consulta    int,
    monto_paciente           decimal(12, 2),
    monto_obra_social        decimal(12, 2),
    f_reserva                timestamp,
    estado                   char(10)
);


CREATE TABLE reprogramacion
(
    nro_turno         int,
    nombre_paciente   text,
    apellido_paciente text,
    telefono_paciente char(12),
    email_paciente    text,
    nombre_medique    text,
    apellido_medique  text,
    estado            char(12)
);


CREATE TABLE error
(
    nro_error       serial,
    f_turno         timestamp,
    nro_consultorio int,
    dni_medique     int,
    nro_paciente    int,
    operacion       char(12),
    f_error         timestamp,
    motivo          varchar(64)
);


CREATE TABLE cobertura
(
    dni_medique       int,
    nro_obra_social   int,
    monto_paciente    decimal(12, 2),
    monto_obra_social decimal(12, 2)
);


CREATE TABLE obra_social
(
    nro_obra_social   int,
    nombre            text,
    contacto_nombre   text,
    contacto_apellido text,
    contacto_telefono char(12),
    contacto_email    text
);


CREATE TABLE liquidacion_cabecera
(
    nro_liquidacion serial,
    nro_obra_social int,
    desde           date,
    hasta           date,
    total           decimal(15, 2)
);


CREATE TABLE liquidacion_detalle
(
    nro_liquidacion   int,
    nro_linea         serial,
    f_atencion        date,
    nro_afiliade      int,
    dni_paciente      int,
    nombre_paciente   text,
    apellido_paciente text,
    dni_medique       int,
    nombre_medique    text,
    apellido_medique  text,
    especialidad      varchar(64),
    monto             decimal(12, 2)
);

CREATE TABLE envio_email
(
    nro_email      serial,
    f_generacion   timestamp,
    email_paciente text,
    asunto         text,
    cuerpo         text,
    f_envio        timestamp,
    estado         char(10)
);


CREATE TABLE solicitud_reservas
(
    nro_orden    int,
    nro_paciente int,
    dni_medique  int,
    fecha        date,
    hora         time
);
