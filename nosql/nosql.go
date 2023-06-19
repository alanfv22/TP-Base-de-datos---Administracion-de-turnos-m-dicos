package nosql

import (
	"encoding/json"
	"log"

	bolt "github.com/boltdb/bolt"
)

var (
	dbbolt            *bolt.DB
	err               error
	dataMediques      json.RawMessage
	dataObrasSociales json.RawMessage
	dataPacientes     json.RawMessage
	dataTurnos        json.RawMessage
	dataConsultorios  json.RawMessage
)

type Paciente struct {
	NroPaciente   int
	Nombre        string
	Apellido      string
	DniPaciente   int
	fNac          string
	NroObraSocial int
	NroAFiliade   int
	Domicilio     string
	Telefono      string
	Email         string
}

type Medique struct {
	DniMedique           int
	Nombre               string
	Apellido             string
	Especialidad         string
	MontoConsultaPrivada float32
	Telefono             string
}

type Consultorio struct {
	NroConsultorio int
	Nombre         string
	Domicilio      string
	CodigoPostal   string
	Telefono       string
}

type ObraSocial struct {
	NroObraSocial    int
	Nombre           string
	ContactoNombre   string
	ContactoApellido string
	ContactoTelefono string
	ContactoEmail    string
}

type Turno struct {
	NroTurno              int
	Fecha                 string
	NroConsultorio        int
	DniMedique            int
	NroPaciente           int
	NroObraSocialConsulta int
	NroAfiliadeConsulta   int
	MontoPaciente         float32
	MontoObraSocial       float32
	FReserva              string
	Estado                string
}

func dbBoltConnection() {
	dbbolt, err = bolt.Open("nosql.db", 0o600, nil)
	if err != nil {
		log.Fatalf("Error al conectar a db: %s", err)
	}
}

func CreateUpdate(dbbolt *bolt.DB, bucketName string, key []byte, val []byte) error {
	// abre transaccion de escritura
	tx, err := dbbolt.Begin(true)
	if err != nil {
		return err
	}
	defer tx.Rollback()

	b, err := tx.CreateBucketIfNotExists([]byte(bucketName))
	if err != nil {
		return err
	}

	err = b.Put(key, val)
	if err != nil {
		return err
	}

	// cierra transaccion
	if err := tx.Commit(); err != nil {
		return err
	}

	return nil
}

func ReadUnique(dbbolt *bolt.DB, bucketName string, key []byte) ([]byte, error) {
	var buf []byte

	err := dbbolt.View(func(tx *bolt.Tx) error {
		b := tx.Bucket([]byte(bucketName))
		buf = b.Get(key)
		return nil
	})

	return buf, err
}

func GenerarJson() {
	dbBoltConnection()

	Mediques := []Medique{
		{25498763, "Martín", "Palermo", "Cardiología", 8000.00, "11-5234-5578"},
		{28716542, "Juan Román", "Riquelme", "Ginecología", 7000.00, "11-5897-4321"},
		{15716542, "Carlos", "Bianchi", "Osteopatía", 6000.00, "11-6549-8732"},
		{24817634, "Roberto", "Abbondanzieri", "Clínica", 5000.00, "11-4152-6378"},
		{27396518, "Sebastián", "Battaglia", "Clínica", 5500.00, "11-3876-5432"},
		{98205436, "Jorge", "Bermúdez", "Clínica", 6000.00, "11-5234-8765"},
		{23740986, "Diego", "Cagna", "Clínica", 4000.00, "11-2873-2165"},
		{27138502, "Rodolfo", "Arruabarrena", "Clínica", 4500.00, "11-4765-4321"},
		{29261473, "Nicolás", "Burdisso", "Clínica", 4500.00, "11-2468-1357"},
		{25963814, "Guillermo", "Barros Schelotto", "Clínica", 5500.00, "11-2357-9246"},
		{92874609, "Mauricio", "Serna", "Clínica", 3800.00, "11-3698-5214"},
		{24550927, "Clemente", "Rodríguez", "Clínica", 4200.00, "11-7418-5296"},
		{28370196, "Rolando", "Schiavi", "Clínica", 5200.00, "11-4589-6374"},
		{30902738, "Carlos", "Tévez", "Clínica", 4400.00, "11-6541-2398"},
		{23489671, "Fernando", "Gago", "Clínica", 4500.00, "11-6517-5386"},
		{29648215, "Walter", "Samuel", "Clínica", 4700.00, "11-5532-5478"},
		{26177504, "Marcelo", "Delgado", "Clínica", 5600.00, "11-4876-4432"},
		{96543217, "Oscar", "Córdoba", "Clínica", 4100.00, "11-3698-5214"},
		{28925346, "Cristian", "Traverso", "Clínica", 5300.00, "11-6418-5296"},
		{24306781, "Hugo", "Ibarra", "Clínica", 5700.00, "11-6589-6374"},
	}

	dataMediques, err = json.MarshalIndent(Mediques, "", "    ")
	if err != nil {
		log.Fatalf("JSON Error: %s", err)
	}

	ObrasSociales := []ObraSocial{
		{1, "Accord Salud", "Carolina", "Herrera", "11-4333-7110", "c.herrera@accord_salud.com"},
		{2, "Emergencias", "Constanza", "Ceruti", "11-6258-2301", "constanzaceruti@em.com.ar"},
		{3, "Medifé", "Mabel", "Bello", "11-6712-6633", "mbello@medife.com.ar"},
		{4, "Osde", "Silvia", "Gold", "11-6340-0205", "silvia_gold@osde.com.ar"},
		{5, "Swiss Medical", "Gabriela", "Sabio", "11-5523-0521", "gabsabio@swmedical.com"},
	}

	dataObrasSociales, err = json.MarshalIndent(ObrasSociales, "", "    ")
	if err != nil {
		log.Fatalf("JSON Error: %s", err)
	}

	Pacientes := []Paciente{
		{42451, "Lionel", "Messi", 32922321, "1987-06-24", 4, 987654, "Avenida Rivadavia 123", "11-6054-7324", "lionel.messi@gmail.com"},
		{85932, "Eugenia", "Tobal", 24567000, "1975-03-30", 5, 567890, "Avenida Mayo 123", "11-4509-8571", "eugenia.tobal@gmail.com"},
		{29057, "Juan", "Martín Del Potro", 33346578, "1988-09-23", 3, 123456, "Avenida Córdoba 678", "11-6606-3407", "delpo@aol.com"},
		{83541, "Susana", "Giménez", 12555210, "1944-01-29", 5, 567890, "Calle Florida 987", "11-6102-3948", "susana.gimenez@outlook.com"},
		{63407, "Gael", "García Bernal", 25497834, "1978-11-30", 4, 789012, "Calle Lavalle 678", "11-6385-9320", "ggbernal@gmail.com"},
		{52406, "Romina", "Gaetani", 28789043, "1977-04-15", 3, 789012, "Avenida Rivadavia 678", "11-6579-6740", "romina.gaetani@gmail.com"},
		{57324, "Luisana", "Lopilato", 33002123, "1987-05-18", 3, 456789, "Calle Corrientes 456", "11-6886-1824", "luisana.lopilato@yahoo.com"},
		{42098, "Lali", "Espósito", 35437892, "1991-10-10", 2, 90123, "Avenida Corrientes 345", "11-6607-5309", "lali.esposito@gmail.com"},
		{69187, "Benjamin", "Vicuña", 28679000, "1978-11-29", 5, 890123, "Calle Corrientes 9877", "11-6703-7651", "benjamin.vicunaaa@live.com"},
		{76284, "Sebastian", "Estevanez", 22345100, "1974-07-21", 4, 345672, "Calle Callao 7655", "11-6666-9187", "sebastian.estevanez@gmail.com"},
		{23948, "Marcela", "Kloosterboer", 30111201, "1983-07-05", 1, 1901234, "Avenida Santa Fe 87", "11-6209-2186", "marcela.kloosterboer@hotmail.com"},
		{42569, "Catherine", "Fulop", 90123003, "1965-03-11", 3, 234561, "Avenida Corrientes 8766", "11-6942-9057", "catherine.fulop@gmail.com"},
		{61824, "Rocio", "Guirao Diaz", 29414692, "1984-06-27", 2, 45678, "Avenida Belgrano 4324", "11-5301-0473", "guiraor@hotmail.com"},
		{92186, "Pampita", "Ardohain", 25629102, "1978-01-17", 2, 78901, "Avenida Libertador 5433", "11-6604-2569", "pampita@gmail.com"},
		{96740, "Natalia", "Oreiro", 24513972, "1977-05-19", 2, 34567, "Calle Sarmiento 3213", "11-6997-6284", "natalia.oreiro@icloud.com"},
		{37651, "Diego", "Torres", 22456780, "1971-03-09", 5, 678901, "Calle Florida 3212", "11-6404-2098", "diego.torres@icloud.com"},
		{75309, "Julieta", "Venegas", 20423789, "1970-11-24", 4, 901234, "Calle Callao 8902", "11-6905-2406", "julieta.venegas@icloud.com"},
		{14859, "Ricardo", "Darín", 23456789, "1957-01-16", 4, 345678, "Avenida Santa Fe 7891", "11-6108-3541", "ricardo.darin@outlook.com"},
		{98571, "Facundo", "Mazzei", 28789431, "1977-11-19", 1, 1123450, "Calle Lavalle 9871", "11-6841-8745", "facundo.mazzei@live.com"},
		{10473, "Facundo", "Arana", 23456000, "1972-03-31", 5, 456789, "Calle Suipacha 3219", "11-6014-8592", "facundo.arana@icloud.com"},
	}

	dataPacientes, err = json.MarshalIndent(Pacientes, "", "    ")
	if err != nil {
		log.Fatalf("JSON Error: %s", err)
	}

	Consultorios := []Consultorio{
		{1, "Salud Total", "Haedo 500", "B1642BSJ", "4632-8981"},
		{2, "Centro Médico Vital", "Cordoba 1421", "B1708CUU", "6079-0392"},
		{3, "Clínica Sanar", "Balbín 2212", "B1663NDW", "4912-4042"},
		{4, "Centro Médico Avanzado", "Libertador 692", "B1744AAT", "4953-1299"},
		{5, "Centro Médico Familiar", "Libertador 6612", "B1736ACO", "4635-5545"},
	}

	dataConsultorios, err = json.MarshalIndent(Consultorios, "", "    ")
	if err != nil {
		log.Fatalf("JSON Error: %s", err)
	}

	Turnos := []Turno{
		{1, "2023-06-05 11:30:00", 1, 25498763, 32922321, 4, 987654, 8000.00, 7500.00, "2023-05-30", "Reservado"},
		{2, "2023-06-05 13:00:00", 1, 25498763, 25497834, 4, 789012, 8000.00, 7500.00, "2023-05-30", "Reservado"},
		{3, "2023-06-05 14:30:00", 1, 25498763, 22345100, 4, 345672, 8000.00, 7500.00, "2023-05-30", "Reservado"},

		{4, "2023-06-05 09:00:00", 3, 28716542, 23456789, 4, 345678, 7000.00, 6600.00, "2023-05-30", "Reservado"},
		{5, "2023-06-05 10:00:00", 3, 28716542, 20423789, 4, 901234, 7000.00, 6600.00, "2023-05-30", "Reservado"},
		{6, "2023-06-05 11:00:00", 3, 28716542, 22345100, 4, 345672, 7000.00, 6600.00, "2023-05-30", "Reservado"},

		{7, "2023-06-05 09:00:00", 4, 15716542, 28789431, 1, 1123450, 6000.00, 5500.00, "2023-05-30", "Reservado"},
		{8, "2023-06-05 10:00:00", 4, 15716542, 30111201, 1, 1901234, 6000.00, 5500.00, "2023-05-30", "Reservado"},
		{9, "2023-06-05 11:00:00", 4, 15716542, 28789431, 1, 1123450, 6000.00, 5500.00, "2023-05-30", "Reservado"},

		{10, "2023-06-06 10:00:00", 2, 24817634, 29414692, 2, 45678, 5000.00, 5000.00, "2023-05-30", "Reservado"},
		{11, "2023-06-06 10:30:00", 2, 24817634, 24513972, 2, 34567, 5000.00, 5000.00, "2023-05-30", "Reservado"},
		{12, "2023-06-06 11:00:00", 2, 24817634, 25629102, 2, 78901, 5000.00, 5000.00, "2023-05-30", "Reservado"},

		{49, "2023-06-06 11:00:00", 1, 27396518, 32922321, 4, 987654, 5500.00, 5000.00, "2023-05-30", "Reservado"},
		{50, "2023-06-06 11:30:00", 1, 27396518, 25497834, 4, 789012, 5500.00, 5000.00, "2023-05-30", "Reservado"},
		{51, "2023-06-06 12:00:00", 1, 27396518, 22345100, 4, 345672, 5500.00, 5000.00, "2023-05-30", "Reservado"},

		{10, "2023-06-01 09:00:00", 1, 98205436, 28789431, 1, 1123450, 6000.00, 5400.00, "2023-05-30", "Reservado"},
		{11, "2023-06-01 09:30:00", 1, 98205436, 30111201, 1, 1901234, 6000.00, 5400.00, "2023-05-30", "Reservado"},
		{12, "2023-06-01 10:00:00", 1, 98205436, 28789431, 1, 1123450, 6000.00, 5400.00, "2023-05-30", "Reservado"},

		{58, "2023-06-07 13:00:00", 2, 23740986, 28789431, 1, 1123450, 4000.00, 3200.00, "2023-05-30", "Reservado"},
		{59, "2023-06-07 13:30:00", 2, 23740986, 30111201, 1, 1901234, 4000.00, 3200.00, "2023-05-30", "Reservado"},
		{60, "2023-06-07 14:00:00", 2, 23740986, 28789431, 1, 1123450, 4000.00, 3200.00, "2023-05-30", "Reservado"},

		{43, "2023-06-06 15:30:00", 2, 27138502, 90123003, 3, 234561, 4500.00, 3600.00, "2023-05-30", "Reservado"},
		{44, "2023-06-06 16:00:00", 2, 27138502, 28789043, 3, 789012, 4500.00, 3600.00, "2023-05-30", "Reservado"},
		{45, "2023-06-06 16:30:00", 2, 27138502, 33346518, 3, 123456, 4500.00, 3600.00, "2023-05-30", "Reservado"},

		{52, "2023-06-06 10:00:00", 1, 29261473, 24567000, 5, 567890, 4500.00, 4100.00, "2023-05-30", "Reservado"},
		{53, "2023-06-06 10:45:00", 1, 29261473, 12555210, 5, 567891, 4500.00, 4100.00, "2023-05-30", "Reservado"},
		{54, "2023-06-06 11:30:00", 1, 29261473, 23456000, 5, 456789, 4500.00, 4100.00, "2023-05-30", "Reservado"},

		{31, "2023-06-07 10:00:00", 4, 25963814, 24567000, 5, 567890, 5600.00, 5100.00, "2023-05-30", "Reservado"},
		{32, "2023-06-07 10:30:00", 4, 25963814, 12555210, 5, 567891, 5600.00, 5100.00, "2023-05-30", "Reservado"},
		{33, "2023-06-07 11:00:00", 4, 25963814, 23456000, 5, 456789, 5600.00, 5100.00, "2023-05-30", "Reservado"},

		{7, "2023-06-01 16:00:00", 5, 92874609, 24567000, 5, 567890, 3800.00, 3500.00, "2023-05-30", "Reservado"},
		{8, "2023-06-01 16:30:00", 5, 92874609, 12555210, 5, 567891, 3800.00, 3500.00, "2023-05-30", "Reservado"},
		{9, "2023-06-01 17:00:00", 5, 92874609, 23456000, 5, 456789, 3800.00, 3500.00, "2023-05-30", "Reservado"},

		{25, "2023-06-05 09:00:00", 1, 24550927, 32922321, 4, 987654, 4200.00, 3800.00, "2023-05-30", "Reservado"},
		{26, "2023-06-05 09:30:00", 1, 24550927, 25497834, 4, 789012, 4200.00, 3800.00, "2023-05-30", "Reservado"},
		{27, "2023-06-05 10:00:00", 1, 24550927, 22345100, 4, 345672, 4200.00, 3800.00, "2023-05-30", "Reservado"},

		{1, "2023-06-01 08:00:00", 3, 28370196, 28789431, 1, 1123450, 5200.00, 4700.00, "2023-05-30", "Reservado"},
		{2, "2023-06-01 09:00:00", 3, 28370196, 30111201, 1, 1901234, 5200.00, 4700.00, "2023-05-30", "Reservado"},
		{3, "2023-06-01 10:00:00", 3, 28370196, 28789431, 1, 1123450, 5200.00, 4700.00, "2023-05-30", "Reservado"},

		{4, "2023-06-01 08:00:00", 1, 30902738, 90123003, 3, 234561, 4400.00, 4000.00, "2023-05-30", "Reservado"},
		{5, "2023-06-01 08:30:00", 1, 30902738, 28789043, 3, 789012, 4400.00, 4000.00, "2023-05-30", "Reservado"},
		{6, "2023-06-01 09:00:00", 1, 30902738, 33346518, 3, 123456, 4400.00, 4000.00, "2023-05-30", "Reservado"},

		{55, "2023-06-07 09:00:00", 5, 23489671, 24567000, 5, 567890, 4500.00, 4100.00, "2023-05-30", "Reservado"},
		{56, "2023-06-07 09:30:00", 5, 23489671, 12555210, 5, 567891, 4500.00, 4100.00, "2023-05-30", "Reservado"},
		{57, "2023-06-07 10:00:00", 5, 23489671, 23456000, 5, 456789, 4500.00, 4100.00, "2023-05-30", "Reservado"},

		{37, "2023-06-05 09:00:00", 4, 29648215, 90123003, 3, 234561, 4500.00, 4100.00, "2023-05-30", "Reservado"},
		{38, "2023-06-05 09:30:00", 4, 29648215, 28789043, 3, 789012, 4500.00, 4100.00, "2023-05-30", "Reservado"},
		{39, "2023-06-05 10:00:00", 4, 29648215, 33346518, 3, 123456, 4500.00, 4100.00, "2023-05-30", "Reservado"},

		{13, "2023-06-02 14:00:00", 5, 26177504, 24567000, 5, 567890, 5600.00, 5100.00, "2023-05-30", "Reservado"},
		{14, "2023-06-02 14:30:00", 5, 26177504, 12555210, 5, 567891, 5600.00, 5100.00, "2023-05-30", "Reservado"},
		{15, "2023-06-02 15:00:00", 5, 26177504, 23456000, 5, 456789, 5600.00, 5100.00, "2023-05-30", "Reservado"},

		{19, "2023-06-02 10:00:00", 5, 96543217, 29414692, 2, 45678, 4100.00, 3700.00, "2023-05-30", "Reservado"},
		{20, "2023-06-02 10:30:00", 5, 96543217, 24513972, 2, 34567, 4100.00, 3700.00, "2023-05-30", "Reservado"},
		{21, "2023-06-02 11:00:00", 5, 96543217, 25629102, 2, 78901, 4100.00, 3700.00, "2023-05-30", "Reservado"},

		{16, "2023-06-02 09:00:00", 3, 28925346, 32922321, 4, 987654, 5300.00, 4800.00, "2023-05-30", "Reservado"},
		{17, "2023-06-02 09:45:00", 3, 28925346, 25497834, 4, 789012, 5300.00, 4800.00, "2023-05-30", "Reservado"},
		{18, "2023-06-02 10:30:00", 3, 28925346, 22345100, 4, 345672, 5300.00, 4800.00, "2023-05-30", "Reservado"},

		{40, "2023-06-06 16:00:00", 2, 24306781, 90123003, 3, 234561, 4500.00, 4100.00, "2023-05-30", "Reservado"},
		{41, "2023-06-06 16:30:00", 2, 24306781, 28789043, 3, 789012, 4500.00, 4100.00, "2023-05-30", "Reservado"},
		{42, "2023-06-06 17:00:00", 2, 24306781, 33346518, 3, 123456, 4500.00, 4100.00, "2023-05-30", "Reservado"},
	}

	dataTurnos, err = json.MarshalIndent(Turnos, "", "    ")
	if err != nil {
		log.Fatalf("JSON Error: %s", err)
	}
	defer dbbolt.Close()
}

func CargarDatos() {
	dbBoltConnection()

	CreateUpdate(dbbolt, "Mediques", []byte("mediques"), dataMediques)
	if err != nil {
		log.Fatalf("Cargar Mediques error: %s", err)
	}

	CreateUpdate(dbbolt, "Consultorios", []byte("consultorios"), dataConsultorios)
	if err != nil {
		log.Fatalf("Cargar Consultorios error: %s", err)
	}

	CreateUpdate(dbbolt, "Pacientes", []byte("pacientes"), dataPacientes)
	if err != nil {
		log.Fatalf("Cargar Pacientes error: %s", err)
	}

	CreateUpdate(dbbolt, "ObrasSociales", []byte("obrasSociales"), dataObrasSociales)
	if err != nil {
		log.Fatalf("Cargar Obras Sociales error: %s", err)
	}
	CreateUpdate(dbbolt, "Turnos", []byte("Turnos"), dataTurnos)
	if err != nil {
		log.Fatalf("Cargar Turnos error: %s", err)
	}

	defer dbbolt.Close()
}
