// Navbar.js

import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import './Navbar.css';

export default class Navbar extends Component {
  state = {
    selectedCity: 'Veracruz' // Valor inicial por defecto
  };

  // Función para manejar el cambio de ciudad seleccionada
  handleCityChange = (event) => {
    this.setState({
      selectedCity: event.target.value
    });
  };

  render() {
    const { selectedCity } = this.state;

    return (
      <nav className="navbar">
        <div className="container"> 
          <div className="header">
            <div className="img_logo_container">
              <img className="img_logo" src="https://i.postimg.cc/D0SHfRSn/OIG.jpg" alt="logo" />
            </div>
            <h1 className="logo_text">CineHux</h1>
          </div>
          <div className="main_nav">
            <div className="menu_btn">
              <span onClick={this.moveMenu}>&#9776;</span>
            </div>
            <ul id="nav" className="nav">
              <li className="encabezado li_nav">
                <Link className="nav_link" to="/Home">
                  En cartelera
                </Link>
              </li>
              <li className="encabezado li_nav">
                <Link className="nav_link" to="/RegistroUsuario">
                  Registrarse
                </Link>
              </li>
              <li className="encabezado li_nav">
                <Link className="nav_link" to="/Nosotros">
                  Nosotros
                </Link>
              </li>
            </ul>
          </div>
          <div className="city_select_container">
            <label className='label_font' htmlFor="citySelect">Selecciona tu ciudad:</label>
            <select id="citySelect" className="citySelect" value={selectedCity} onChange={this.handleCityChange}>
              <option value="Veracruz">Veracruz</option>
              <option value="Nuevo Veracruz">Nuevo Veracruz</option>
              <option value="Xalapa">Xalapa</option>
            </select>
          </div>
        </div>
      </nav>
    );
  }
}
