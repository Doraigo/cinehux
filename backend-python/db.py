import mysql.connector

# Configuracion de la conexion a la base de datos
db_config = {
    "host": "127.0.0.1",
    "user": "root",
    "passwd": "contrasena123",
    "database": "cinehux"
}

# Establecer conexion a la base de datos
connection = mysql.connector.connect(**db_config)

# Objeto cursos para ejecutar consultar
cursor = connection.cursor(dictionary=True)


