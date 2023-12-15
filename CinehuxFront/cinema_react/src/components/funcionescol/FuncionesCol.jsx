import React, { useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import './FuncionesCol.css';
import forma from '../../assets/Venon.jpg';
import forma1 from '../../assets/Rascacielos.jpg';
import forma2 from '../../assets/Avenger.jpg';
import forma3 from '../../assets/Wolwerine.jpg';

// import proyeccionesData from './proyecciones.json';

const FuncionesCol = () => {
  const navigate = useNavigate();
  const [proyecciones, setProyecciones] = useState([]);
  const [showForm, setShowForm] = useState(false);
  const [selectedProyeccion, setSelectedProyeccion] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        // Llamada a la API para obtener las proyecciones de la sucursal 1
        const response = await fetch('http://127.0.0.1:5000/sucursales/1/proyecciones');
        const data = await response.json();
        setProyecciones(data);
      } catch (error) {
        console.error('Error al obtener las proyecciones:', error);
      }
    };

    fetchData();
  }, []);

  const handleCompraBoleto = (proyeccion) => {
    console.log('Proyeccion antes de la redirección:', proyeccion);
    localStorage.setItem('proyeccion', JSON.stringify(proyeccion));
    setSelectedProyeccion(proyeccion);
    navigate('/formulario-compra',);
  };
  
  

  const getImagenUrl = (nombrePelicula) => {
    if (nombrePelicula === 'Rascacielos') {
      return forma1;
    } else if (nombrePelicula === 'Avengers') {
      return forma2;
    } else if (nombrePelicula === 'Venom') {
      return forma;
    } else if (nombrePelicula === 'Wolverine') {
      return forma3;
    }
    return forma; // Otra imagen por defecto
  };

  const getSinopsis = (nombrePelicula) => {
    if (nombrePelicula === 'Rascacielos') {
      return (
        <p>
          En una misión en Hong Kong, es acusado de provocar un incendio en el edificio más alto y seguro del mundo, The Pearl. Él debe encontrar a los responsables, limpiar su nombre y rescatar a su familia, que está atrapada dentro del edificio en llamas.
        </p>
      );
    } else if (nombrePelicula === 'Avengers') {
      return (
        <p>
          El director de la Agencia SHIELD decide reclutar a un equipo para salvar al mundo de un desastre casi seguro cuando un enemigo inesperado surge como una gran amenaza para la seguridad mundial.
        </p>
      );
    } else if (nombrePelicula === 'Venom') {
      return (
        <p>
          Brock establece una simbiosis con un ente alienígena que le ofrece superpoderes, pero el ser se apodera de su personalidad y lo vuelve perverso.
        </p>
      );
    } else if (nombrePelicula === 'Wolverine') {
      return (
        <p>
          Un Logan amnésico investiga su pasado en el mundo del crimen organizado japonés. Vulnerable por primera vez y desafiando sus límites físicos y emocionales, no sólo se enfrentará al letal acero samurái, sino que además mantendrá una lucha interna contra su inmortalidad, que lo hará más fuerte.        </p>
      );
    }

    return null;
  };

  return (
    <div className="col-Funciones">
      {proyecciones.map((proyeccion) => (
        <div className="tarjeta" key={proyeccion.id_proyeccion}>
          <img src={getImagenUrl(proyeccion.nombre_pelicula)} alt="" />
          <div className="info-tarjeta">
            <h3>{proyeccion.nombre_pelicula}</h3>
            <p>Sala: {proyeccion.id_proyeccion}</p>
            <p>Horario: {proyeccion.horario}</p>
            <p>Fecha: {proyeccion.dia}</p>
            <Link to={{
              pathname: "/formulario-compra",
              state: { proyeccion: selectedProyeccion }
            }}>
              <button onClick={() => handleCompraBoleto(proyeccion)}>Comprar Boleto</button>
            </Link>
          </div>
          <div className="sinopsis">{getSinopsis(proyeccion.nombre_pelicula)}</div>
        </div>
      ))}

      {proyecciones.length === 0 && <p>No hay proyecciones disponibles.</p>}
    </div>
  );
};

export default FuncionesCol;

