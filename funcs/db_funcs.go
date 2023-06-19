package funcs

import (
	"database/sql"
	"fmt"
	"log"
	"os"
)

type Database struct {
	postgres *sql.DB
	tp       *sql.DB
}

func NewDB(postgres *sql.DB, tp *sql.DB) Database {
	return Database{postgres: postgres, tp: tp}
}

func (d *Database) CreateDatabase() {
	migrations, err := os.ReadFile("migraciones/db.sql")
	if err != nil {
		log.Fatal(err)
	}
	_, err = d.postgres.Exec(string(migrations))
	if err != nil {
		log.Fatal(err)
	}
}

func (d *Database) DeleteDatabase() {
	tablas, err := os.ReadFile("migraciones/borrar_base_de_datos.sql")
	if err != nil {
		log.Fatal(err)
	}
	_, err = d.postgres.Exec(string(tablas))
	if err != nil {
		log.Fatal(err)
	}
}

func (d *Database) CrearTablas() {
	tablas, err := os.ReadFile("migraciones/tablas.sql")
	if err != nil {
		log.Fatal(err)
	}
	_, err = d.tp.Exec(string(tablas))
	if err != nil {
		log.Fatal(err)
	}
}

func (d *Database) DefinirPksFks() {
	pksfks, err := os.ReadFile("migraciones/crear_pks_fks.sql")
	if err != nil {
		log.Fatal(err)
	}
	_, err = d.tp.Exec(string(pksfks))
	if err != nil {
		log.Fatal(err)
	}
}

func (d *Database) BorrarPksFks() {
	deletepksfks, err := os.ReadFile("migraciones/eliminar_pks_fks.sql")
	if err != nil {
		log.Fatal(err)
	}
	_, err = d.tp.Exec(string(deletepksfks))
	if err != nil {
		log.Fatal(err)
	}
}

func (d *Database) CargarDatosEnTablas() {
	populate, err := os.ReadFile("migraciones/populate.sql")
	if err != nil {
		log.Fatal(err)
	}
	_, err = d.tp.Exec(string(populate))
	if err != nil {
		log.Fatal(err)
	}
}

func (d *Database) CargarStoredProcedures() {
	files, err := os.ReadDir("./sp")
	if err != nil {
		log.Fatal(err)
	}
	for _, file := range files {
		sp, err := os.ReadFile(fmt.Sprintf("sp/%s", file.Name()))
		if err != nil {
			log.Fatal(err)
		}
		_, err = d.tp.Exec(string(sp))
		if err != nil {
			log.Fatal(err)
		}
	}
}
