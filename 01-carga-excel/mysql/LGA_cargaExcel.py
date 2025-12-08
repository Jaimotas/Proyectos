import signal, sys, os
import mysql.connector
import openpyxl
from mysql.connector import IntegrityError

def cortarPrograma(sig, frame):
    print("\n\n[!]Saliendo ...\n")
    sys.exit(1)


# Ctlr + C
signal.signal(signal.SIGINT, cortarPrograma)
conexion = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="formularios",
    port=3307,
)
cursor = conexion.cursor()
# Obtener el directorio del script
script_dir = os.path.dirname(os.path.abspath(__file__))
docs_dir = os.path.join(script_dir, "docs")

# Crear carpetas si no existen
os.makedirs(docs_dir, exist_ok=True)
fichero_permisos = os.path.join(docs_dir, "excel-cod.xlsx")
wb = openpyxl.load_workbook(fichero_permisos)
def cargaModelos():
    cursor.execute("TRUNCATE TABLE lga_modelos")
    for nombre_hoja in wb.sheetnames:
        id_formulario = nombre_hoja  # el ID viene del nombre de la hoja
        des_modelo = ''               # vacío por ahora

        # Saltar si ID vacío por algún motivo
        if not id_formulario:
            print(f"Hoja ignorada por ID vacío: {nombre_hoja}")
            continue

        try:
            cursor.execute(
                "INSERT INTO LGA_MODELOS (ID, DES_MODELO) VALUES (%s, %s)",
                (id_formulario, des_modelo)
            )
        except IntegrityError as e:
            print(f"Error insertando {id_formulario}: {e}")

    conexion.commit()
    print("Todos los modelos procesados.")

def cargaPermisos():
    cursor.execute("TRUNCATE TABLE lga_permisos")
    for nombre_hoja in wb.sheetnames:
        hoja = wb[nombre_hoja]

        for i, fila in enumerate(hoja.iter_rows(min_row=2, values_only=True), start=2):
            id_permiso = fila[10]      
            des_permiso = fila[3]    
            lucrativo = fila[8] 
            via_defecto = fila[11]
            meses_validez = fila[7]
            reglamento = fila[12]

            # Saltar filas incompletas
            if not id_permiso or not des_permiso or not lucrativo :
                print(f"Fila {i} ignorada por campos vacíos")
                continue

            try:
                cursor.execute(
                    "INSERT INTO LGA_PERMISOS (ID, DES_PERMISO, LUCRATIVO, VIA_DEFECTO, MESES_VALIDEZ, REGLAMENTO) VALUES (%s, %s, %s, %s, %s, %s)",
                    (id_permiso, des_permiso, lucrativo, via_defecto, meses_validez, reglamento)
                )
            except IntegrityError as e:
                print(f"Error insertando {id_permiso} en fila {i}: {e}")

        conexion.commit()
        print(f"Hoja '{hoja.title}' procesada.")

def menu():
    print("Seleccione una opción:")
    print("1. Cargar Modelos")
    print("2. Cargar Permisos")
    print("0. Salir\n")

def menuExcel():
      while True:
        menu()
        opcion = input("Ingrese el número de la opción: ")
        if opcion == "1": 
            # Cargar Modelos
            cargaModelos()
        elif opcion == "2":
            # Cargar Permisos
            cargaPermisos()
        elif opcion == "0":
            print("Saliendo del programa.")
            break
        else:
            print("Opción no válida. Intente de nuevo.\n")
            continue

if __name__ == "__main__":
    menuExcel()
