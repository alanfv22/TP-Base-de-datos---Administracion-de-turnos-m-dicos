package funcs

import (
	"fmt"
	"log"
)

func (d *Database) AtencionDeTurno() {
	for {
		fmt.Println("1. Atencion de turno. Por favor ingrese el numero de turno: ")
		var turno string
		_, err := fmt.Scanf("%s", &turno)
		if err != nil {
			fmt.Println("Error al leer el turno")
			break
		}
		query := fmt.Sprintf("SELECT atencion_de_turno(%s)", turno)
		if _, err = d.tp.Exec(query); err != nil {
			log.Fatal(err)
		}
		fmt.Println("Atencion de turno finalizada")
		fmt.Printf("Desea atender otro turno? (s/n): ")
		var seguir string
		if _, err = fmt.Scanf("%s", &seguir); err != nil {
			fmt.Println("Error al leer la opcion")
			break
		}
		if seguir == "n" {
			break
		}
	}
}

func (d *Database) CancelacionTurnos() {
	for {
		fmt.Println("2. Cancelacion de turnos. Ingrese por favor el dni del mequique: ")
		var dniMedique string
		if _, err := fmt.Scanf("%s", &dniMedique); err != nil {
			fmt.Println("Error al leer el dni")
			break
		}
		fmt.Println("Muchas gracias. Ahora ingrese desde que fecha desea cancelar los turnos (formato: YYYY-MM-DD): ")
		var fechaDesde string
		if _, err := fmt.Scanf("%s", &fechaDesde); err != nil {
			fmt.Println("Error al leer la fecha")
			break
		}
		fmt.Println("Muchas gracias. Ahora ingrese desde que fecha hasta (formato: YYYY-MM-DD): ")
		var fechaHasta string
		if _, err := fmt.Scanf("%s", &fechaHasta); err != nil {
			fmt.Println("Error al leer la fecha")
			break
		}
		query := fmt.Sprintf("BEGIN ISOLATION LEVEL SERIALIZABLE;"+
			"SELECT cancelacion_de_turnos(%s, '%s', '%s');"+
			"COMMIT;", dniMedique, fechaDesde, fechaHasta)
		if _, err := d.tp.Exec(query); err != nil {
			log.Fatal(err)
		}
		fmt.Println("Cancelacion turnos finalizada")
		fmt.Printf("Desea seguir dejando a los pacientes en banda? (s/n): ")
		var seguir string
		if _, err := fmt.Scanf("%s", &seguir); err != nil {
			fmt.Println("Error al leer la opcion")
			break
		}
		if seguir == "n" {
			break
		}
	}
}

func (d *Database) GenerarTurnosDisponibles() {
	for {
		fmt.Println("3. Generar turnos disponibles")
		fmt.Println("Por favor, ingrese el año para el cual quiere generar los turnos: ")
		var anio string
		if _, err := fmt.Scanf("%s", &anio); err != nil {
			fmt.Println("Error al leer el año")
			break
		}
		fmt.Println("Por favor, ingrese el mes para el cual quiere generar los turnos: ")
		var mes string
		if _, err := fmt.Scanf("%s", &mes); err != nil {
			fmt.Println("Error al leer el mes")
			break
		}
		query := fmt.Sprintf("BEGIN ISOLATION LEVEL SERIALIZABLE;"+
			"SELECT generar_turnos_disponibles(%s, %s);"+
			"COMMIT;", anio, mes)
		if _, err := d.tp.Exec(query); err != nil {
			log.Fatal(err)
		}
		fmt.Println("Generacion de turnos finalizada. Muchas gracias")
		fmt.Println("Desea generar turnos para otro anio/mes? (s/n): ")
		var seguir string
		if _, err := fmt.Scanf("%s", &seguir); err != nil {
			fmt.Println("Error al leer la opcion")
			break
		}
		if seguir == "n" {
			break
		}
	}
}

func (d *Database) ReservaTurno() {
	for {
		fmt.Println("4. Reservar turno")
		fmt.Println("Por favor, ingrese el numero de historia clinica: ")
		var historiaClinica string
		if _, err := fmt.Scanf("%s", &historiaClinica); err != nil {
			fmt.Println("Error al leer la historia clinica")
			break
		}
		fmt.Println("Por favor, ingrese el dni del medique: ")
		var dniMedique string
		if _, err := fmt.Scanf("%s", &dniMedique); err != nil {
			fmt.Println("Error al leer el dni del medique")
			break
		}
		fmt.Println("Por favor, ingrese la fecha YYYY-MM-DD: ")
		var fecha string
		if _, err := fmt.Scanf("%s", &fecha); err != nil {
			fmt.Println("Error al leer la fecha del turno")
			break
		}
		fmt.Println("Por favor, ingrese la hora HH-MM-SS: ")
		var hora string
		if _, err := fmt.Scanf("%s", &hora); err != nil {
			fmt.Println("Error al leer la hora del turno")
			break
		}
		query := fmt.Sprintf("BEGIN ISOLATION LEVEL SERIALIZABLE;"+
			"SELECT reserva_turno(%s, %s, '%s %s');"+
			"COMMIT;", historiaClinica, dniMedique, fecha, hora)
		if _, err := d.tp.Exec(query); err != nil {
			log.Fatal(err)
		}
		fmt.Println("Reserva de turno finalizada. Muchas gracias")
		fmt.Println("Desea reservar otro turno? (s/n): ")
		var seguir string
		if _, err := fmt.Scanf("%s", &seguir); err != nil {
			fmt.Println("Error al leer la opcion")
			break
		}
		if seguir == "n" {
			break
		}
	}
}

func (d *Database) EnviarEmailPerdidaTurnoReservado() {
	for {
		fmt.Println("5. Enviar email perdida turno. Tener en cuenta que debe ejecutarse una vez al dia y enviara notificacion " +
			"de los turnos perdidos del dia anterior a la fecha: ")
		fmt.Println("Desea continuar? (s/n): ")
		var seguir string
		if _, err := fmt.Scanf("%s", &seguir); err != nil {
			fmt.Println("Error al leer la opcion")
			break
		}
		if seguir == "n" {
			break
		}
		query := fmt.Sprintf("SELECT enviar_email_perdida_turno_reservado()")
		if _, err := d.tp.Exec(query); err != nil {
			log.Fatal(err)
		}
		fmt.Println("Envio de email finalizado. Muchas gracias")
		break
	}
}

func (d *Database) EnviarEmailRecordatorio() {
	for {
		fmt.Println("6. Enviar email recordatorio. Enviar mails a los pacientes que tienen turno dentro de dos dias: ")
		fmt.Println("Desea continuar? (s/n): ")
		var seguir string
		if _, err := fmt.Scanf("%s", &seguir); err != nil {
			fmt.Println("Error al leer la opcion")
			break
		}
		if seguir == "n" {
			break
		}
		query := fmt.Sprintf("SELECT enviar_email_recordatorio()")
		if _, err := d.tp.Exec(query); err != nil {
			log.Fatal(err)
		}
		fmt.Println("Envio de email finalizado. Muchas gracias")
		break
	}
}

func (d *Database) GenerarLiquidacionObrasSociales() {
	for {
		fmt.Println("7. Generar liquidacion de obras sociales")
		fmt.Println("Por favor, ingrese el año para el cual quiere generar la liquidacion: ")
		var anio string
		if _, err := fmt.Scanf("%s", &anio); err != nil {
			fmt.Println("Error al leer el año")
			break
		}
		fmt.Println("Por favor, ingrese el mes para el cual quiere generar la liquidacion: ")
		var mes string
		if _, err := fmt.Scanf("%s", &mes); err != nil {
			fmt.Println("Error al leer el mes")
			break
		}
		query := fmt.Sprintf("SELECT liquidacion_obras_sociales(%s, %s)", anio, mes)
		if _, err := d.tp.Exec(query); err != nil {
			log.Fatal(err)
		}
		fmt.Println("Generacion de liquidacion finalizada. Muchas gracias")
		fmt.Println("Desea generar liquidacion para otro anio/mes? (s/n): ")
		var seguir string
		if _, err := fmt.Scanf("%s", &seguir); err != nil {
			fmt.Println("Error al leer la opcion")
			break
		}
		if seguir == "n" {
			break
		}
	}
}
