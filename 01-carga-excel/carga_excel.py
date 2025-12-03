import mysql.connector
import openpyxl

conexion = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="permisos",
    port=3307,
)
cursor = conexion.cursor()


wb = openpyxl.load_workbook("docs/excel-cod.xlsx")

def cargaPermisos():
    for nombre_hoja in wb.sheetnames:
        hoja = wb[nombre_hoja]
        for fila in hoja.iter_rows(min_row=2, values_only=True):
            codigo = fila[10]        
            descripcion = fila[3]
            formulario = hoja.title 
            cursor.execute(
                "INSERT INTO permiso (codigo, descripcion, formulario) VALUES (%s, %s, %s)",
                (codigo, descripcion, formulario)
            )
            conexion.commit()

if __name__ == "__main__":
    cargaPermisos()