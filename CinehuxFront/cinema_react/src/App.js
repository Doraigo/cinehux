import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import FuncionesCol from './components/funcionescol/FuncionesCol'; // Asegúrate de ajustar la ruta correcta
import FormularioCompraBoleto from './components/formulario_compra/FormularioCompraBoleto'; // Asegúrate de ajustar la ruta correcta
import Home from './pages/Home';
import Nosotros from './pages/Nosotros';
import Navbar from './components/Navbar';
import RegistroUsuario from './components/formulario_registro/RegistroUsuario';

const App = () => {
  return (
    <div className="app-container">
      <Router>
        <Navbar />
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/Home" element={<Home />} />
          <Route path="/Nosotros" element={<Nosotros />} />
          <Route path="/RegistroUsuario" element={<RegistroUsuario />} />
          {/* Nueva ruta para las funciones */}
          <Route path="/funciones" element={<FuncionesCol />} />
          {/* Nueva ruta para el formulario de compra */}
          <Route path="/formulario-compra" element={<FormularioCompraBoleto  />} />
        </Routes>
      </Router>
    </div>
  );
};

export default App;
