from flask import Flask, jsonify, request
from datetime import datetime
from flask_cors import CORS
import db


app = Flask(__name__)
CORS(app, origins='*')

@app.route('/')
def index():
    return 'Hello world'


# Ver proyecciones
from datetime import datetime

@app.route('/sucursales/1/proyecciones', methods=['GET'])
def get_proyecciones_sucursal1():
    db.cursor.execute("SELECT p.id_proyeccion, p.horario, p.dia, pl.nombre_pelicula FROM Proyeccion p JOIN Sala s ON p.sala_id = s.id_sala JOIN Pelicula pl ON p.pelicula_id = pl.id_pelicula WHERE s.sucursal_id = 1")
    proyecciones = db.cursor.fetchall()

    if proyecciones:
        # Convertir objetos timedelta a cadenas de texto
        proyecciones_converted = []
        for proyeccion in proyecciones:
            proyeccion['horario'] = str(proyeccion['horario'])
            # Format the date to a more readable format
            proyeccion['dia'] = datetime.strptime(str(proyeccion['dia']), '%Y-%m-%d').strftime('%A, %d %B %Y')
            proyecciones_converted.append(proyeccion)
        return jsonify(proyecciones_converted)
    else:
        return jsonify({'message': 'No hay proyecciones para la sucursal especificada'}), 404


    
# Ruta para ver qué asientos están ocupados dependiendo de la sala
@app.route('/salas/<int:sala_id>/asientos_ocupados', methods=['GET'])
def get_asientos_ocupados_by_sala_id(sala_id):
    db.cursor.execute("SELECT id_asiento FROM Asiento WHERE sala_id = %s AND ocupado = TRUE", (sala_id,))
    asientos_ocupados = [asiento[0] for asiento in db.cursor.fetchall()]  # Convertir a lista de números de asiento
    

    return jsonify(asientos_ocupados)


@app.route('/registrar_usuario', methods=['POST'])
def registrar_usuario():
    nombre = request.form.get('nombre')
    correo = request.form.get('correo')
    numero_tarjeta = request.form.get('numero_tarjeta')
    pin_tarjeta = request.form.get('pin_tarjeta')

    if not all([nombre, correo, numero_tarjeta, pin_tarjeta]):
        return jsonify({'message': 'Todos los campos son requeridos'}), 400

    # Insertar el nuevo usuario en la tabla 'Cliente'
    db.cursor.execute("INSERT INTO Cliente (nombre, correo, numero_tarjeta, pin_tarjeta) VALUES (%s, %s, %s, %s)",
                      (nombre, correo, numero_tarjeta, pin_tarjeta))
    db.connection.commit()

    # Obtener el ID del usuario recién insertado
    usuario_id = db.cursor.lastrowid

    return jsonify({'message': 'Usuario registrado exitosamente', 'usuario_id': usuario_id}), 201


@app.route('/comprar_boleto', methods=['POST'])
def comprar_boleto():
    print("debug:")
    print(request.form)
    cliente_correo = request.form.get('correo')
    cliente_numero_tarjeta = request.form.get('numero_tarjeta')
    nombre_asiento = request.form.get('asiento')
    proyeccion_id = request.form.get('proyeccion')  # El frontend debe enviar el ID de la proyección seleccionada

    if not all([cliente_correo, cliente_numero_tarjeta, nombre_asiento, proyeccion_id]):
        return jsonify({'message': 'Todos los campos son requeridos'}), 400

    # Buscar al cliente en la tabla 'Cliente' por correo y número de tarjeta
    db.cursor.execute("SELECT id_cliente FROM Cliente WHERE correo = %s AND numero_tarjeta = %s",
                      (cliente_correo, cliente_numero_tarjeta))
    cliente_id = db.cursor.fetchone()

    if not cliente_id:
        return jsonify({'message': 'Cliente no encontrado. Regístrese antes de comprar un boleto'}), 404

    # Buscar el ID del asiento por su nombre y el ID de la sala (con sucursal_id = 1) en la tabla 'Asiento'
    db.cursor.execute("SELECT a.id_asiento FROM Asiento a JOIN Sala s ON a.sala_id = s.id_sala WHERE a.nombre_asiento = %s AND s.sucursal_id = 1",
                      (nombre_asiento,))
    asiento_id = db.cursor.fetchone()
    # Print the value of asiento_id
    print("asiento_id:", asiento_id)

    # Verificar si el ID del asiento se recuperó correctamente
    if asiento_id is not None and asiento_id and asiento_id['id_asiento']:
    # Verificar si el asiento está ocupado
        db.cursor.execute("SELECT ocupado FROM Asiento WHERE id_asiento = %s", (asiento_id[0],))
        asiento_ocupado_result = db.cursor.fetchone()

    # Verificar si se obtuvo el resultado y el valor de 'ocupado'
        if not asiento_ocupado_result or not asiento_ocupado_result[0]:
            return jsonify({'message': 'Asiento no encontrado'}), 404

        asiento_ocupado = asiento_ocupado_result[0]

        if asiento_ocupado:
            return jsonify({'message': 'El asiento está ocupado'}), 400

    # Actualizar el estado del asiento a ocupado
        db.cursor.execute("UPDATE Asiento SET ocupado = TRUE WHERE id_asiento = %s", (asiento_id[0],))
        db.connection.commit()

    # Insertar el nuevo boleto en la tabla 'Boleto' sin incluir el campo 'precio' o 'proyeccion_id'
        db.cursor.execute("INSERT INTO Boleto (asiento_id, cliente_id) VALUES (%s, %s)",
                      (asiento_id[0], cliente_id[0]))
        db.connection.commit()

        return jsonify({'message': 'Boleto comprado exitosamente'}), 201
    else:
        return jsonify({'message': 'Asiento no encontrado'}), 404




if __name__ == "__main__":
    app.run(debug=True)
