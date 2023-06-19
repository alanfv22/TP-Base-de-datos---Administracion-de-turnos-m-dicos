package main

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/lib/pq"
	"main.go/funcs"
	"main.go/nosql"
)

func main() {
	postgresDb, err := sql.Open("postgres", "user=postgres host=localhost dbname=postgres sslmode=disable")
	if err != nil {
		log.Fatal(err)
	}
	defer postgresDb.Close()
	tpDb, err := sql.Open("postgres", "user=postgres host=localhost dbname=tp sslmode=disable")
	if err != nil {
		log.Fatal(err)
	}
	defer tpDb.Close()
	db := funcs.NewDB(postgresDb, tpDb)
	var entrada int
	var seguir string
	for {
		// imprimo el menu
	menu:
		printMenuPrincipal()
		fmt.Printf("Ingrese numero: ")
		fmt.Scanf("%d", &entrada)
		fmt.Printf("Opcion: %d \n", entrada)
		switch entrada {
		case 1:
			for {
				// imprimo el submenu
				printPostgresSubMenu()
				fmt.Printf("Ingrese numero: ")
				fmt.Scanf("%d", &entrada)
				fmt.Printf("Opcion: %d \n", entrada)
				switch entrada {
				case 1:
					db.DeleteDatabase()
					db.CreateDatabase()
					db.CrearTablas()
					db.DefinirPksFks()
					db.CargarDatosEnTablas()
					db.CargarStoredProcedures()
					fmt.Printf("Creamos base de datos - carga tablas - pk y fk - cargamos datos en tabla - cargamos StoredProcedures (uso rapido)\n")
				case 2:
					tpDb.Close()
					db.DeleteDatabase()
					tpDb, _ = sql.Open("postgres", "user=postgres host=localhost dbname=tp sslmode=disable")
					db = funcs.NewDB(postgresDb, tpDb)
					fmt.Printf("\nBorro base de datos\n")
				case 3:
					db.CreateDatabase()
					fmt.Printf("\nSe creo la base de datos\n")
				case 4:
					db.CrearTablas()
					fmt.Printf("\nSe crearon las tablas\n")
				case 5:
					db.DefinirPksFks()
					fmt.Printf("\nSe crearon las pks y fks\n")
				case 6:
					db.CargarDatosEnTablas()
					fmt.Printf("\nSe cargaron los datos en tablas\n")
				case 7:
					db.CargarStoredProcedures()
					fmt.Printf("\nSe cargaron los stored procedures\n")
				case 8:
					for {
						printStoredProceduresSubMenu()
						fmt.Printf("Ingrese numero: ")
						fmt.Scanf("%d", &entrada)
						fmt.Printf("Opcion: %d \n", entrada)
						switch entrada {
						case 1:
							db.AtencionDeTurno()
						case 2:
							db.CancelacionTurnos()
						case 3:
							db.GenerarTurnosDisponibles()
						case 4:
							db.ReservaTurno()
						case 5:
							db.EnviarEmailPerdidaTurnoReservado()
						case 6:
							db.EnviarEmailRecordatorio()
						case 7:
							db.GenerarLiquidacionObrasSociales()
						case 9:
							break
						default:
							fmt.Printf("Opcion no valida\n")
						}
						fmt.Printf("\nDesea seguir en el submenu de stored procedures? s/n: \n")
						fmt.Scanf("%s", &seguir)
						if seguir == "n" {
							break
						}
					}
				case 9:
					db.BorrarPksFks()
					fmt.Printf("\nSe Borraron las pks y fks\n")
				case 10:
					goto menu
				default:
					fmt.Printf("Opcion no valida\n")
				}
			}
		case 2:
			for {
				// imprimo el submenu
				printNosqlSubMenu()
				fmt.Printf("Ingrese numero: ")
				fmt.Scanf("%d", &entrada)
				fmt.Printf("Opcion: %d \n", entrada)
				switch entrada {
				case 1:
					nosql.GenerarJson()
					fmt.Printf("Json generados \n")
				case 2:
					nosql.CargarDatos()
					fmt.Printf("\nDatos cargados\n")
				case 9:
					goto menu
				default:
					fmt.Printf("Opcion no valida\n")
				}
			}
		case 9:
			goto out
		default:
			fmt.Printf("Opcion no valida\n")
		}
	}
out:
	fmt.Printf("\n  *******  SALIENDO ******* \n")
}

func printPostgresSubMenu() {
	fmt.Printf("\n\n*********************\nSeleccione: " +
		"\n 1 - Creamos base de datos - carga tablas - pk y fk - carga datos - cargar stored procedures (uso rapido)" +
		"\n 2 - Borrar base de datos" +
		"\n 3 - Crear base de datos" +
		"\n 4 - Crear tablas" +
		"\n 5 - Crear pks y fks" +
		"\n 6 - Cargar datos" +
		"\n 7 - Cargar Stored Procedures & triggers" +
		"\n 8 - SubMenu Stored Procedures" +
		"\n 9 - Borrar pks y fks" +
		"\n 10 - Exit " +
		"\n*********************\n")
}

func printMenuPrincipal() {
	fmt.Printf("\n *** Menu principal *** \nSeleccione: " +
		"\n 1 - Trabajar con postgress" +
		"\n 2 - Trabajar con boltdb" +
		"\n 9 - Exit \n")
}

func printStoredProceduresSubMenu() {
	fmt.Printf("\n\n********************* \nSeleccione: " +
		"\n 1 - Atencion turno " +
		"\n 2 - Cancelacion turnos" +
		"\n 3 - Generador turnos disponibles" +
		"\n 4 - Reserva de turno" +
		"\n 5 - Enviar email perdida turno reservado" +
		"\n 6 - Enviar email recordatorio" +
		"\n 7 - Generar Liquidacion Obras Sociales" +
		"\n 9 - Exit" +
		"*********************\n")
}

func printNosqlSubMenu() {
	fmt.Printf("\n\n*********************\nSeleccione: " +
		"\n 1 - Generar datos Json " +
		"\n 2 - Cargar datos en bd nosql" +
		"\n 9 - Exit" +
		"\n*********************\n")
}
