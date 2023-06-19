INSERT INTO obra_social (nro_obra_social, nombre, contacto_nombre, contacto_apellido, contacto_telefono, contacto_email)
VALUES  (1, 'Accord Salud', 'Carolina', 'Herrera', '11-4333-7110', 'c.herrera@accord_salud.com'),
        (2, 'Emergencias', 'Constanza', 'Ceruti', '11-6258-2301', 'constanzaceruti@em.com.ar'),
        (3, 'Medifé', 'Mabel', 'Bello', '11-6712-6633', 'mbello@medife.com.ar'),
        (4, 'Osde', 'Silvia', 'Gold', '11-6340-0205', 'silvia_gold@osde.com.ar'),
        (5, 'Swiss Medical', 'Gabriela', 'Sabio', '11-5523-0521', 'gabsabio@swmedical.com');

INSERT INTO medique (dni_medique, nombre, apellido, especialidad, monto_consulta_privada, telefono)
VALUES (25498763, 'Martín', 'Palermo', 'Cardiología', 8000.00, '11-5234-5578'),
       (28716542, 'Juan Román', 'Riquelme', 'Ginecología', 7000.00, '11-5897-4321'),
       (15716542, 'Carlos', 'Bianchi', 'Osteopatía', 6000.00, '11-6549-8732'),
       (24817634, 'Roberto', 'Abbondanzieri', 'Clínica', 5000.00, '11-4152-6378'),
       (27396518, 'Sebastián', 'Battaglia', 'Clínica', 5500.00, '11-3876-5432'),
       (98205436, 'Jorge', 'Bermúdez', 'Clínica', 6000.00, '11-5234-8765'),
       (23740986, 'Diego', 'Cagna', 'Clínica', 4000.00, '11-2873-2165'),
       (27138502, 'Rodolfo', 'Arruabarrena', 'Clínica', 4500.00, '11-4765-4321'),
       (29261473, 'Nicolás', 'Burdisso', 'Clínica', 4500.00, '11-2468-1357'),
       (25963814, 'Guillermo', 'Barros Schelotto', 'Clínica', 5500.00, '11-2357-9246'),
       (92874609, 'Mauricio', 'Serna', 'Clínica', 3800.00, '11-3698-5214'),
       (24550927, 'Clemente', 'Rodríguez', 'Clínica', 4200.00, '11-7418-5296'),
       (28370196, 'Rolando', 'Schiavi', 'Clínica', 5200.00, '11-4589-6374'),
       (30902738, 'Carlos', 'Tévez', 'Clínica', 4400.00, '11-6541-2398'),
       (23489671, 'Fernando', 'Gago', 'Clínica', 4500.00, '11-6517-5386'),
       (29648215, 'Walter', 'Samuel', 'Clínica', 4700.00, '11-5532-5478'),
       (26177504, 'Marcelo', 'Delgado', 'Clínica', 5600.00, '11-4876-4432'),
       (96543217, 'Oscar', 'Córdoba', 'Clínica', 4100.00, '11-3698-5214'),
       (28925346, 'Cristian', 'Traverso', 'Clínica', 5300.00, '11-6418-5296'),
       (24306781, 'Hugo', 'Ibarra', 'Clínica', 5700.00, '11-6589-6374');

INSERT INTO paciente (nro_paciente, nombre, apellido, dni_paciente, f_nac, nro_obra_social, nro_afiliade, domicilio, telefono, email)
VALUES  (1, 'Lionel', 'Messi', 32922321, '1987-06-24', 4, 987654, 'Avenida Rivadavia 123', '11-6054-7324', 'lionel.messi@gmail.com'),
        (85932, 'Eugenia', 'Tobal', 24567000, '1975-03-30', 5, 567890, 'Avenida Mayo 123', '11-4509-8571', 'eugenia.tobal@gmail.com'),
        (29057, 'Juan', 'Martín Del Potro', 33346578, '1988-09-23', 3, 123456, 'Avenida Córdoba 678', '11-6606-3407', 'delpo@aol.com'),
        (83541, 'Susana', 'Giménez', 12555210, '1944-01-29', 5, 567890, 'Calle Florida 987', '11-6102-3948', 'susana.gimenez@outlook.com'),
        (63407, 'Gael', 'García Bernal', 25497834, '1978-11-30', 4, 789012, 'Calle Lavalle 678', '11-6385-9320', 'ggbernal@gmail.com'),
        (52406, 'Romina', 'Gaetani', 28789043, '1977-04-15', 3, 789012, 'Avenida Rivadavia 678', '11-6579-6740', 'romina.gaetani@gmail.com'),
        (57324, 'Luisana', 'Lopilato', 33002123, '1987-05-18', 3, 456789, 'Calle Corrientes 456', '11-6886-1824', 'luisana.lopilato@yahoo.com'),
        (42098, 'Lali', 'Espósito', 35437892, '1991-10-10', 2, 90123, 'Avenida Corrientes 345', '11-6607-5309', 'lali.esposito@gmail.com'),
        (69187, 'Benjamin', 'Vicuña', 28679000, '1978-11-29', 5, 890123, 'Calle Corrientes 9877', '11-6703-7651', 'benjamin.vicunaaa@live.com'),
        (76284, 'Sebastian', 'Estevanez', 22345100, '1974-07-21', 4, 345672, 'Calle Callao 7655', '11-6666-9187', 'sebastian.estevanez@gmail.com'),
        (23948, 'Marcela', 'Kloosterboer', 30111201, '1983-07-05', 1, 1901234, 'Avenida Santa Fe 87', '11-6209-2186', 'marcela.kloosterboer@hotmail.com'),
        (42569, 'Catherine', 'Fulop', 90123003, '1965-03-11', 3, 234561, 'Avenida Corrientes 8766', '11-6942-9057', 'catherine.fulop@gmail.com'),
        (61824, 'Rocio', 'Guirao Diaz', 29414692, '1984-06-27', 2, 45678, 'Avenida Belgrano 4324', '11-5301-0473', 'guiraor@hotmail.com'),
        (92186, 'Pampita', 'Ardohain', 25629102, '1978-01-17', 2, 78901, 'Avenida Libertador 5433', '11-6604-2569', 'pampita@gmail.com'),
        (96740, 'Natalia', 'Oreiro', 24513972, '1977-05-19', 2, 34567, 'Calle Sarmiento 3213', '11-6997-6284', 'natalia.oreiro@icloud.com'),
        (37651, 'Diego', 'Torres', 22456780, '1971-03-09', 5, 678901, 'Calle Florida 3212', '11-6404-2098', 'diego.torres@icloud.com'),
        (75309, 'Julieta', 'Venegas', 20423789, '1970-11-24', 4, 901234, 'Calle Callao 8902', '11-6905-2406', 'julieta.venegas@icloud.com'),
        (14859, 'Ricardo', 'Darín', 23456789, '1957-01-16', 4, 345678, 'Avenida Santa Fe 7891', '11-6108-3541', 'ricardo.darin@outlook.com'),
        (98571, 'Facundo', 'Mazzei', 28789431, '1977-11-19', 1, 1123450, 'Calle Lavalle 9871', '11-6841-8745', 'facundo.mazzei@live.com'),
        (10473, 'Facundo', 'Arana', 23456000, '1972-03-31', 5, 456789, 'Calle Suipacha 3219', '11-6014-8592', 'facundo.arana@icloud.com');

INSERT INTO cobertura (dni_medique, nro_obra_social, monto_paciente, monto_obra_social)
VALUES  (98205436, 1, 6000.00, 5400.00),
        (96543217, 2, 4100.00, 3700.00),
        (92874609, 5, 3800.00, 3500.00),
        (30902738, 3, 4400.00, 4000.00),
        (29648215, 3, 4700.00, 4200.00),
        (29261473, 5, 4500.00, 4100.00),
        (28925346, 4, 5300.00, 4800.00),
        (28716542, 4, 7000.00, 6600.00),
        (28716542, 2, 7000.00, 6300.00),
        (28370196, 1, 5200.00, 4700.00),
        (27396518, 4, 5500.00, 5000.00),
        (27138502, 3, 4500.00, 3600.00),
        (26177504, 5, 5600.00, 5100.00),
        (25963814, 2, 5500.00, 5000.00),
        (25498763, 4, 8000.00, 7500.00),
        (25498763, 2, 8000.00, 7200.00),
        (24817634, 2, 5000.00, 5000.00),
        (24550927, 4, 4200.00, 3800.00),
        (24306781, 3, 5700.00, 5200.00),
        (23740986, 1, 4000.00, 3200.00),
        (23489671, 5, 4500.00, 4100.00),
        (15716542, 1, 6000.00, 5500.00);

INSERT INTO consultorio (nombre, domicilio, codigo_postal, telefono)
VALUES  ('Salud Total', 'Haedo 500', 'B1642BSJ', '4632-8981'),
        ('Centro Médico Vital', 'Cordoba 1421', 'B1708CUU', '6079-0392'),
        ('Clínica Sanar', 'Balbín 2212', 'B1663NDW', '4912-4042'),
        ('Centro Médico Avanzado', 'Libertador 692', 'B1744AAT', '4953-1299'),
        ('Centro Médico Familiar', 'Libertador 6612', 'B1736ACO', '4635-5545');

INSERT INTO agenda (dni_medique, dia, nro_consultorio, hora_desde, hora_hasta, duracion_turno)
VALUES  (15716542, 1, 4, '09:00:00', '12:00:00', '1 hours'),
        (15716542, 2, 4, '09:00:00', '12:00:00', '1 hours'),
        (23489671, 3, 5, '09:00:00', '11:00:00', '30 mins'),
        (23740986, 3, 2, '13:00:00', '18:00:00', '30 mins'),
        (24306781, 2, 2, '15:00:00', '17:00:00', '30 mins'),
        (24550927, 1, 1, '09:00:00', '10:00:00', '30 mins'),
        (24817634, 2, 2, '09:00:00', '16:00:00', '30 mins'),
        (25498763, 1, 1, '10:00:00', '16:00:00', '1 hours 30 mins'),
        (25498763, 3, 1, '10:00:00', '19:00:00', '1 hours 30 mins'),
        (25963814, 3, 4, '10:00:00', '13:00:00', '30 mins'),
        (26177504, 1, 5, '14:00:00', '17:00:00', '30 mins'),
        (26177504, 3, 5, '14:00:00', '17:00:00', '30 mins'),
        (26177504, 5, 5, '14:00:00', '17:00:00', '30 mins'),
        (27138502, 3, 4, '09:00:00', '16:00:00', '30 mins'), 
        (27396518, 2, 1, '11:00:00', '16:00:00', '30 mins'),
        (28370196, 4, 3, '08:00:00', '13:00:00', '1 hours'),
        (28716542, 1, 3, '09:00:00', '12:00:00', '1 hours'),
        (28925346, 5, 3, '09:00:00', '12:00:00', '45 mins'),
        (29261473, 2, 1, '10:00:00', '13:00:00', '45 mins'),
        (29648215, 1, 4, '09:00:00', '13:00:00', '30 mins'),
        (30902738, 4, 1, '08:00:00', '10:00:00', '30 mins'),
        (92874609, 4, 5, '16:00:00', '19:00:00', '30 mins'),
        (96543217, 5, 5, '10:00:00', '17:00:00', '30 mins'),
        (98205436, 2, 1, '09:00:00', '12:00:00', '30 mins'),
        (98205436, 3, 1, '09:00:00', '12:00:00', '30 mins'),
        (98205436, 4, 1, '09:00:00', '12:00:00', '30 mins');

INSERT INTO solicitud_reservas (nro_orden,nro_paciente, dni_medique, fecha, hora)
VALUES  (3,1,28925346,'2023-06-09','09:00:00'), -- Carga exitosa
        (2,1,28925346,'2024-06-09','09:00:00'), -- Turno inexistente o no disponible
        (4,2,28925346,'2023-06-09','09:30:00'), -- Nro de historia clinica no valido
        (1,1,28925347,'2023-06-09','09:30:00'), -- Dni de medique no valido 
        (5,1,98205436,'2023-06-09','09:30:00'), -- Obra social de paciente no atendida por le medique
        (6,85932,92874609,'2023-06-15','16:00:00'), -- Carga exitosa
        (7,85932,92874609,'2023-06-15','17:00:00'), -- Carga exitosa
        (8,85932,92874609,'2023-06-15','18:00:00'), -- Carga exitosa
        (9,85932,29261473,'2023-06-06','10:00:00'), -- Carga exitosa
        (10,85932,29261473,'2023-06-06','10:45:00'), -- Carga exitosa
        (11,85932,29261473,'2023-06-06','11:30:00'); -- Supera limite de reserva de turnos

