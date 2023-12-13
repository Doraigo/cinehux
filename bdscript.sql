CREATE DATABASE cinehux;
DROP DATABASE cinehux;

USE cinehux;

SHOW TABLES;

--
-- Table structure for table `Sucursal`
--
Select	* from Proyeccion;
DROP TABLE IF EXISTS `Sucursal`;
CREATE TABLE `Sucursal` (
  `id_sucursal` int(11) AUTO_INCREMENT NOT NULL,
  `ciudad` varchar(10) DEFAULT NULL,
  `no_salas` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_sucursal`)
);
-- DONE

--
-- Dumping data for table `Sucursal`
--

LOCK TABLES `Sucursal` WRITE;
INSERT INTO `Sucursal` (`ciudad`, `no_salas`) VALUES
('Veracruz', 3),
('Nuevo Veracruz', 2),
('Xalapa', 3);
UNLOCK TABLES;
	
SELECT * FROM Cliente;    

--
-- Table structure for table `Sala`
--

DROP TABLE IF EXISTS `Sala`;
CREATE TABLE `Sala` (
  `id_sala` int(11) AUTO_INCREMENT NOT NULL,
  `no_asientos` int(11) DEFAULT NULL,
  `tipo_sala` bool DEFAULT NULL,
  `llena` bool DEFAULT NULL,
  `sucursal_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_sala`),
  KEY `fk_sucursal2_id` (`sucursal_id`),
  CONSTRAINT `fk_sucursal2_id` FOREIGN KEY (`sucursal_id`) REFERENCES `Sucursal` (`id_sucursal`)
);
-- DONE

--
-- Dumping data for table `Sala`
--

LOCK TABLES `Sala` WRITE;
INSERT INTO `Sala` (`no_asientos`, `tipo_sala`, `llena`, `sucursal_id`) VALUES
(50, true, false, 1),  -- Sala 1  Sucursal 1
(50, false, false, 1), -- Sala 2  Sucursal 1
(50, true, false, 2),  -- Sala 1  Sucursal 2
(50, false, false, 2), -- Sala 2  Sucursal 2
(50, true, false, 3),  -- Sala 1  Sucursal 3
(50, false, false, 3); -- Sala 2  Sucursal 3
UNLOCK TABLES;

SELECT * FROM Cliente;
--
-- Table structure for table `Pelicula`
--

DROP TABLE IF EXISTS `Pelicula`;
CREATE TABLE `Pelicula` (
  `id_pelicula` int(11) AUTO_INCREMENT NOT NULL,
  `nombre_pelicula` varchar(30) DEFAULT NULL,
  `director` varchar(40) DEFAULT NULL,
  `clasificacion` varchar(5) DEFAULT NULL,
  `idioma` varchar(10) DEFAULT NULL,
  `duracion` int(11) DEFAULT NULL,
  `proyeccion_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_pelicula`)
);
-- DONE

--
-- Dumping data for table `Pelicula`
--

LOCK TABLES `Pelicula` WRITE;
INSERT INTO `Pelicula` (`nombre_pelicula`, `director`, `clasificacion`, `idioma`, `duracion`) VALUES
('Avengers', 'Russo Brothers', 'PG-13', 'Castellano', 150),
('Rascacielos', 'Rawson Marshall Thurber', 'PG-13', 'Castellano', 120),
('Venom', 'Ruben Fleischer', 'PG-13', 'Ingles', 112),
('Wolverine', 'James Mangold', 'R', 'Ingles', 135);
UNLOCK TABLES;

--
-- Table structure for table `Proyeccion`
--

DROP TABLE IF EXISTS `Proyeccion`;
CREATE TABLE `Proyeccion` (
  `id_proyeccion` int(11) AUTO_INCREMENT NOT NULL,
  `horario` time DEFAULT NULL,
  `dia` date DEFAULT NULL,
  `pelicula_id` int(11) DEFAULT NULL,
  `sala_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_proyeccion`),
  KEY `fk_pelicula_id` (`pelicula_id`),
  KEY `fk_sala2_id` (`sala_id`),
  CONSTRAINT `fk_pelicula_id` FOREIGN KEY (`pelicula_id`) REFERENCES `Pelicula` (`id_pelicula`),
  CONSTRAINT `fk_sala2_id` FOREIGN KEY (`sala_id`) REFERENCES `Sala` (`id_sala`)
);
-- DONE

--
-- Dumping data for table `Proyeccion`
--

LOCK TABLES `Proyeccion` WRITE;
INSERT INTO `Proyeccion` (`horario`, `dia`, `pelicula_id`, `sala_id`) VALUES
('14:00:00', '2023-12-15', 1, 1),  -- Avengers  Sala 1  Sucursal 1
('16:30:00', '2023-12-15', 2, 1),  -- Rascacielos  Sala 1  Sucursal 1

('15:00:00', '2023-12-15', 3, 2),  -- Venom  Sala 2  Sucursal 1
('17:30:00', '2023-12-15', 4, 2),  -- Wolverine  Sala 2  Sucursal 1

('14:30:00', '2023-12-15', 1, 3),  -- Avengers  Sala 1  Sucursal 2
('17:00:00', '2023-12-15', 2, 3),  -- Rascacielos  Sala 1  Sucursal 2

('15:30:00', '2023-12-15', 3, 4),  -- Venom  Sala 2  Sucursal 2
('18:00:00', '2023-12-15', 4, 4),  -- Wolverine  Sala 2  Sucursal 2

('16:00:00', '2023-12-15', 1, 5),  -- Avengers  Sala 1  Sucursal 3
('18:30:00', '2023-12-15', 2, 5),  -- Rascacielos  Sala 1  Sucursal 3

('17:00:00', '2023-12-15', 3, 6),  -- Venom  Sala 2  Sucursal 3
('19:30:00', '2023-12-15', 4, 6);  -- Wolverine  Sala 2  Sucursal 3
UNLOCK TABLES;

--
-- Table structure for table `Cliente`
--

DROP TABLE IF EXISTS `Cliente`;
CREATE TABLE `Cliente` (
  `id_cliente` int(11) AUTO_INCREMENT NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `correo` varchar(255) DEFAULT NULL,
  `numero_tarjeta` BIGINT DEFAULT NULL,
  `pin_tarjeta` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`)
);
-- DONE

--
-- Dumping data for table `Cliente`
--

LOCK TABLES `Cliente` WRITE;
INSERT INTO `Cliente` (`nombre`,`correo`, `numero_tarjeta`, `pin_tarjeta`) VALUES
('Jack','cliente1@example.com', 1111222233334444, 1234),
('Perla','cliente2@example.com', 5555666677778888, 5678),
('Negra','cliente3@example.com', 9999000011112222, 9876);
UNLOCK TABLES;

--
-- Table structure for table `Asiento`
--

DROP TABLE IF EXISTS `Asiento`;
CREATE TABLE `Asiento` (
  `id_asiento` INT AUTO_INCREMENT NOT NULL,
  `nombre_asiento` varchar(20) DEFAULT NULL,
  `ocupado` boolean DEFAULT NULL,
  `sala_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_asiento`),
  KEY `fk_sala3_id` (`sala_id`),
  CONSTRAINT `fk_sala3_id` FOREIGN KEY (`sala_id`) REFERENCES `Sala` (`id_sala`)
); 
-- DONE

--
-- Dumping data for table `Asiento`
--
UPDATE Asiento
SET ocupado = TRUE
WHERE sala_id = 1 AND nombre_asiento = 'E10';

LOCK TABLES `Asiento` WRITE;
INSERT INTO `Asiento` (`nombre_asiento`, `ocupado`, `sala_id`) VALUES
('A1', false, 1), ('A2', false, 1), ('A3', false, 1), ('A4', false, 1), ('A5', false, 1),
('A6', false, 1), ('A7', false, 1), ('A8', false, 1), ('A9', false, 1), ('A10', false, 1),
('B1', false, 1), ('B2', false, 1), ('B3', false, 1), ('B4', false, 1), ('B5', false, 1),
('B6', false, 1), ('B7', false, 1), ('B8', false, 1), ('B9', false, 1), ('B10', false, 1),
('C1', false, 1), ('C2', false, 1), ('C3', false, 1), ('C4', false, 1), ('C5', false, 1),
('C6', false, 1), ('C7', false, 1), ('C8', false, 1), ('C9', false, 1), ('C10', false, 1),
('D1', false, 1), ('D2', false, 1), ('D3', false, 1), ('D4', false, 1), ('D5', false, 1),
('D6', false, 1), ('D7', false, 1), ('D8', false, 1), ('D9', false, 1), ('D10', false, 1),
('E1', false, 1), ('E2', false, 1), ('E3', false, 1), ('E4', false, 1), ('E5', false, 1),
('E6', false, 1), ('E7', false, 1), ('E8', false, 1), ('E9', false, 1), ('E10', true, 1),
('A1', false, 2), ('A2', false, 2), ('A3', false, 2), ('A4', false, 2), ('A5', false, 2),
('A6', false, 2), ('A7', false, 2), ('A8', false, 2), ('A9', false, 2), ('A10', false, 2),
('B1', false, 2), ('B2', false, 2), ('B3', false, 2), ('B4', false, 2), ('B5', false, 2),
('B6', false, 2), ('B7', false, 2), ('B8', false, 2), ('B9', false, 2), ('B10', false, 2),
('C1', false, 2), ('C2', false, 2), ('C3', false, 2), ('C4', false, 2), ('C5', false, 2),
('C6', false, 2), ('C7', false, 2), ('C8', false, 2), ('C9', false, 2), ('C10', false, 2),
('D1', false, 2), ('D2', false, 2), ('D3', false, 2), ('D4', false, 2), ('D5', false, 2),
('D6', false, 2), ('D7', false, 2), ('D8', false, 2), ('D9', false, 2), ('D10', false, 2),
('E1', false, 2), ('E2', false, 2), ('E3', false, 2), ('E4', false, 2), ('E5', false, 2),
('E6', false, 2), ('E7', false, 2), ('E8', false, 2), ('E9', false, 2), ('E10', false, 2),
('A1', false, 3), ('A2', false, 3), ('A3', false, 3), ('A4', false, 3), ('A5', false, 3),
('A6', false, 3), ('A7', false, 3), ('A8', false, 3), ('A9', false, 3), ('A10', false, 3),
('B1', false, 3), ('B2', false, 3), ('B3', false, 3), ('B4', false, 3), ('B5', false, 3),
('B6', false, 3), ('B7', false, 3), ('B8', false, 3), ('B9', false, 3), ('B10', false, 3),
('C1', false, 3), ('C2', false, 3), ('C3', false, 3), ('C4', false, 3), ('C5', false, 3),
('C6', false, 3), ('C7', false, 3), ('C8', false, 3), ('C9', false, 3), ('C10', false, 3),
('D1', false, 3), ('D2', false, 3), ('D3', false, 3), ('D4', false, 3), ('D5', false, 3),
('D6', false, 3), ('D7', false, 3), ('D8', false, 3), ('D9', false, 3), ('D10', false, 3),
('E1', false, 3), ('E2', false, 3), ('E3', false, 3), ('E4', false, 3), ('E5', false, 3),
('E6', false, 3), ('E7', false, 3), ('E8', false, 3), ('E9', false, 3), ('E10', false, 3),
('A1', false, 4), ('A2', false, 4), ('A3', false, 4), ('A4', false, 4), ('A5', false, 4),
('A6', false, 4), ('A7', false, 4), ('A8', false, 4), ('A9', false, 4), ('A10', false, 4),
('B1', false, 4), ('B2', false, 4), ('B3', false, 4), ('B4', false, 4), ('B5', false, 4),
('B6', false, 4), ('B7', false, 4), ('B8', false, 4), ('B9', false, 4), ('B10', false, 4),
('C1', false, 4), ('C2', false, 4), ('C3', false, 4), ('C4', false, 4), ('C5', false, 4),
('C6', false, 4), ('C7', false, 4), ('C8', false, 4), ('C9', false, 4), ('C10', false, 4),
('D1', false, 4), ('D2', false, 4), ('D3', false, 4), ('D4', false, 4), ('D5', false, 4),
('D6', false, 4), ('D7', false, 4), ('D8', false, 4), ('D9', false, 4), ('D10', false, 4),
('E1', false, 4), ('E2', false, 4), ('E3', false, 4), ('E4', false, 4), ('E5', false, 4),
('E6', false, 4), ('E7', false, 4), ('E8', false, 4), ('E9', false, 4), ('E10', false, 4),
('A1', false, 5), ('A2', false, 5), ('A3', false, 5), ('A4', false, 5), ('A5', false, 5),
('B1', false, 5), ('B2', false, 5), ('B3', false, 5), ('B4', false, 5), ('B5', false, 5),
('C1', false, 5), ('C2', false, 5), ('C3', false, 5), ('C4', false, 5), ('C5', false, 5),
('D1', false, 5), ('D2', false, 5), ('D3', false, 5), ('D4', false, 5), ('D5', false, 5),
('E1', false, 5), ('E2', false, 5), ('E3', false, 5), ('E4', false, 5), ('E5', false, 5),
('A6', false, 5), ('A7', false, 5), ('A8', false, 5), ('A9', false, 5), ('A10', false, 5),
('B6', false, 5), ('B7', false, 5), ('B8', false, 5), ('B9', false, 5), ('B10', false, 5),
('C6', false, 5), ('C7', false, 5), ('C8', false, 5), ('C9', false, 5), ('C10', false, 5),
('D6', false, 5), ('D7', false, 5), ('D8', false, 5), ('D9', false, 5), ('D10', false, 5),
('E6', false, 5), ('E7', false, 5), ('E8', false, 5), ('E9', false, 5), ('E10', false, 5),
('A1', false, 6), ('A2', false, 6), ('A3', false, 6), ('A4', false, 6), ('A5', false, 6),
('A6', false, 6), ('A7', false, 6), ('A8', false, 6), ('A9', false, 6), ('A10', false, 6),
('B1', false, 6), ('B2', false, 6), ('B3', false, 6), ('B4', false, 6), ('B5', false, 6),
('B6', false, 6), ('B7', false, 6), ('B8', false, 6), ('B9', false, 6), ('B10', false, 6),
('C1', false, 6), ('C2', false, 6), ('C3', false, 6), ('C4', false, 6), ('C5', false, 6),
('C6', false, 6), ('C7', false, 6), ('C8', false, 6), ('C9', false, 6), ('C10', false, 6),
('D1', false, 6), ('D2', false, 6), ('D3', false, 6), ('D4', false, 6), ('D5', false, 6),
('D6', false, 6), ('D7', false, 6), ('D8', false, 6), ('D9', false, 6), ('D10', false, 6),
('E1', false, 6), ('E2', false, 6), ('E3', false, 6), ('E4', false, 6), ('E5', false, 6),
('E6', false, 6), ('E7', false, 6), ('E8', false, 6), ('E9', false, 6), ('E10', false, 6);
UNLOCK TABLES;

--
-- Table structure for table `Boleto`
--

DROP TABLE IF EXISTS `Boleto`;
CREATE TABLE `Boleto` (
  `id_boleto` INT AUTO_INCREMENT NOT NULL,
  `precio` float DEFAULT NULL,
  `cliente_id` int(11) DEFAULT NULL,
  `proyeccion_id` int(11) DEFAULT NULL,
  `asiento_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_boleto`),
  KEY `fk_cliente_id` (`cliente_id`),
  KEY `fk_proyeccion2_id` (`proyeccion_id`),
  KEY `fk_asiento_id` (`asiento_id`),
  CONSTRAINT `fk_cliente_id` FOREIGN KEY (`cliente_id`) REFERENCES `Cliente` (`id_cliente`),
  CONSTRAINT `fk_proyeccion2_id` FOREIGN KEY (`proyeccion_id`) REFERENCES `Proyeccion` (`id_proyeccion`),
  CONSTRAINT `fk_asiento_id` FOREIGN KEY (`asiento_id`) REFERENCES `Asiento` (`id_asiento`)
);
-- DONE


--
-- Dumping data for table `Boleto`
--

LOCK TABLES `Boleto` WRITE;
INSERT INTO `Boleto` (`precio`, `cliente_id`, `proyeccion_id`, `asiento_id`) VALUES
(10.50, 1, 1, 1),  -- Sample ticket for Cliente 1, Proyeccion 1, and Asiento A1
(8.75, 2, 3, 11),  -- Sample ticket for Cliente 2, Proyeccion 3, and Asiento B1
(12.00, 3, 5, 21);  -- Sample ticket for Cliente 3, Proyeccion 5, and Asiento C1
UNLOCK TABLES;


SHOW TABLES;