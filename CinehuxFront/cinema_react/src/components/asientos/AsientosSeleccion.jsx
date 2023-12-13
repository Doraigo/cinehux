// AsientosSeleccion.jsx
import React, { useState } from 'react';
import './Est_Sle.css';

const AsientosSeleccion = () => {
  // Aquí puedes colocar el código relacionado con la selección de asientos si es necesario
  return (
    <div className="seleccion-asientos-container">
      <h2>Seleccionar Asientos</h2>
      <div className="screen">Pantalla</div>
      <div className="seats">
        {/* Contenedor de asientos generado por JavaScript */}
      </div>
      <p>Seleccionados: <span id="selectedSeats">0</span></p>
    </div>
  );
}

export default AsientosSeleccion;
