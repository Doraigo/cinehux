  import React, { useState } from 'react';
  import './FormularioCompraBoleto.css';

  const FormularioCompraBoleto = ({ proyeccion }) => {
    console.log('Proyeccion received:', proyeccion);
    const [clienteCorreo, setClienteCorreo] = useState('');
    const [clienteNumeroTarjeta, setClienteNumeroTarjeta] = useState('');
    const [nombreAsiento, setNombreAsiento] = useState('');
    const [mensaje, setMensaje] = useState('');

    const handleSubmit = (e) => {
      e.preventDefault();

      // Validar que todos los campos estén llenos
      if (!clienteCorreo || !clienteNumeroTarjeta || !nombreAsiento) {
        setMensaje('Todos los campos son requeridos');
        return;
      }

      // Obtener el formulario y crear un objeto FormData
      const form = e.target;
      const formData = new FormData(form);

      // Agregar el id de la proyección al FormData
      formData.append('proyeccion', proyeccion.id_proyeccion);

      // Enviar el formulario al backend utilizando fetch
      fetch('http://127.0.0.1:5000/comprar_boleto', {
        method: 'POST',
        body: formData,
      })
        .then((response) => response.json())
        .then((data) => {
          // Aquí puedes manejar la respuesta del backend, mostrar mensajes, redireccionar, etc.
          console.log(data);
        })
        .catch((error) => {
          // Manejo de errores
          console.error('Error al enviar el formulario:', error);
        });
    };

    return (
      <div className="formulario-compra-container">
        <h2>Comprar Boleto</h2>
        <form className="formulario-compra-form" onSubmit={handleSubmit}>
          <div className="form-control">
            <label htmlFor="clienteCorreo">Correo Electrónico:</label>
            <input
              type="email"
              id="clienteCorreo"
              name="correo" // Nombre del campo para que coincida con el backend
              value={clienteCorreo}
              onChange={(e) => setClienteCorreo(e.target.value)}
              required
            />
          </div>
          <div className="form-control">
            <label htmlFor="clienteNumeroTarjeta">Número de Tarjeta:</label>
            <input
              type="text"
              id="clienteNumeroTarjeta"
              name="numero_tarjeta" // Nombre del campo para que coincida con el backend
              value={clienteNumeroTarjeta}
              onChange={(e) => setClienteNumeroTarjeta(e.target.value)}
              required
            />
          </div>
          <div className="form-control">
            <label htmlFor="nombreAsiento">Numero de Asiento:</label>
            <input
              type="text"
              id="nombreAsiento"
              name="asiento" // Nombre del campo para que coincida con el backend
              value={nombreAsiento}
              onChange={(e) => setNombreAsiento(e.target.value)}
              required
            />
          </div>
          <button type="submit">Comprar Boleto</button>
        </form>
        {mensaje && <p>{mensaje}</p>}
      </div>
    );
  };

  export default FormularioCompraBoleto;

