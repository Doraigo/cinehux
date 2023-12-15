import React, { useState } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import './FormularioCompraBoleto.css';

const FormularioCompraBoleto = () => {
  const location = useLocation();

  // Intenta obtener la proyección desde el estado de la ubicación
  const proyeccionFromLocation = location.state ? location.state.proyeccion : null;

  // Si no hay proyección en el estado, intenta obtenerla desde el localStorage
  const proyeccionFromLocalStorage = JSON.parse(localStorage.getItem('proyeccion'));

  // Usa la proyección que tengas disponible
  const proyeccion = proyeccionFromLocation || proyeccionFromLocalStorage;
  const [clienteCorreo, setClienteCorreo] = useState('');
  const [clienteNumeroTarjeta, setClienteNumeroTarjeta] = useState('');
  const [nombreAsiento, setNombreAsiento] = useState('');
  const [mensaje, setMensaje] = useState('');
  if (!proyeccion) {
    // Si no hay proyección, redirige a la raíz
    // Puedes personalizar esto según tus necesidades
    window.location.href = '/';
    return null;
  }



  const handleSubmit = (e) => {
    e.preventDefault();


    // Validar que todos los campos estén llenos
    if (!clienteCorreo || !clienteNumeroTarjeta || !nombreAsiento) {
      setMensaje('Todos los campos son requeridos');
      return;
    }

    // Crear un objeto FormData y agregar campos
    console.log('Correo:', clienteCorreo);
    console.log('Numero Tarjeta:', clienteNumeroTarjeta);
    console.log('Asiento:', nombreAsiento);
    console.log('Proyeccion:', proyeccion.id_proyeccion);

    const formData = new FormData();
    formData.append('correo', clienteCorreo);
    formData.append('numero_tarjeta', clienteNumeroTarjeta);
    formData.append('asiento', nombreAsiento);
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

