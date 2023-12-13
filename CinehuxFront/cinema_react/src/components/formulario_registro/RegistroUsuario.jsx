import React, { useState } from 'react';
import './RegistroUsuario.css';

const RegistroUsuario = () => {
  const [nombre, setNombre] = useState('');
  const [correo, setCorreo] = useState('');
  const [numeroTarjeta, setNumeroTarjeta] = useState('');
  const [pinTarjeta, setPinTarjeta] = useState('');
  const [mensaje, setMensaje] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();

    // Validar que todos los campos estén llenos
    if (!nombre || !correo || !numeroTarjeta || !pinTarjeta) {
      setMensaje('Todos los campos son requeridos');
      return;
    }

    // Crear un nuevo formulario y agregar los campos a él
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = 'http://127.0.0.1:5000/registrar_usuario';

    const addField = (name, value) => {
      const input = document.createElement('input');
      input.type = 'hidden';
      input.name = name;
      input.value = value;
      form.appendChild(input);
    };

    addField('nombre', nombre);
    addField('correo', correo);
    addField('numero_tarjeta', numeroTarjeta);
    addField('pin_tarjeta', pinTarjeta);

    // Enviar el formulario
    document.body.appendChild(form);
    form.submit();

    setMensaje('Enviando formulario...'); // Puedes agregar un mensaje de envío
  };

  return (
    <div className="formulario-registro">
      <h2>Registro de Usuario</h2>
      <form onSubmit={handleSubmit}>
        <div className="form-control">
          <label htmlFor="nombre">Nombre:</label>
          <input type="text" id="nombre" value={nombre} onChange={(e) => setNombre(e.target.value)} required />
        </div>
        <div className="form-control">
          <label htmlFor="correo">Correo Electrónico:</label>
          <input type="email" id="correo" value={correo} onChange={(e) => setCorreo(e.target.value)} required />
        </div>
        <div className="form-control">
          <label htmlFor="numeroTarjeta">Número de Tarjeta:</label>
          <input type="text" id="numeroTarjeta" value={numeroTarjeta} onChange={(e) => setNumeroTarjeta(e.target.value)} required />
        </div>
        <div className="form-control">
          <label htmlFor="pinTarjeta">PIN de la tarjeta:</label>
          <input type="password" id="pinTarjeta" value={pinTarjeta} onChange={(e) => setPinTarjeta(e.target.value)} required />
        </div>
        <button type="submit">Registrar Usuario</button>
      </form>
      {mensaje && <p>{mensaje}</p>}
    </div>
  );
};

export default RegistroUsuario;
