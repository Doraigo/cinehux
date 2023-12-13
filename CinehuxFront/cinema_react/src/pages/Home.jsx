// pages/Home.js
import React from 'react';
import FuncionesCol from '../components/funcionescol/FuncionesCol';

const slides = [
  
];


const Home = () => {
  return (
    <div>
      <FuncionesCol />
      <div className="image-slider">
        {slides.map((slide, index) => (
          <div key={index} className="slide">
            <img src={slide.url} alt={slide.title} />
          </div>
        ))}
      </div>
    </div>
  );
};

export default Home;
