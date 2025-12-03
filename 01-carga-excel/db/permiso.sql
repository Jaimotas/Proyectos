-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Tiempo de generación: 03-12-2025 a las 17:50:40
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `permisos`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permiso`
--

CREATE TABLE `permiso` (
  `codigo` varchar(3) NOT NULL,
  `descripcion` text NOT NULL,
  `formulario` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `permiso`
--

INSERT INTO `permiso` (`codigo`, `descripcion`, `formulario`) VALUES
('ELI', 'Autorización de estancia de larga duración INICIAL por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('ELI', 'Autorización de estancia de larga duración INICIAL por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('ELI', 'Autorización de estancia de larga duración INICIAL por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('ELI', 'Autorización de estancia de larga duración INICIAL por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('ELI', 'Autorización de estancia de larga duración INICIAL por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('ELI', 'Autorización de estancia de larga duración INICIAL por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('ELI', 'Autorización de estancia de larga duración INICIAL por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('ELI', 'Autorización de estancia de larga duración INICIAL por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('ELI', 'Autorización de estancia de larga duración INICIAL por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('ELI', 'Autorización de estancia de larga duración INICIAL por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('ELI', 'Autorización de estancia de larga duración INICIAL por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('ELI', 'Autorización de estancia de larga duración INICIAL por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('ELI', 'Autorización de estancia de larga duración INICIAL por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('ELI', 'Autorización de estancia de larga duración INICIAL por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('EAI', 'Autorización de trabajo por cuenta ajena INICIAL para titular de estancia de larga duración', 'EX00'),
('EPI', 'Autorización de trabajo por cuenta propia INICIAL para titular de estancia de larga duración ', 'EX00'),
('ELI', 'Autorización de estancia de larga duración INICIAL por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('ELI', 'Autorización de estancia de larga duración INICIAL por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('ELI', 'Autorización de estancia de larga duración INICIAL por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('ELI', 'Autorización de estancia de larga duración INICIAL por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('ELI', 'Autorización de estancia de larga duración INICIAL por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('ELI', 'Autorización de estancia de larga duración INICIAL por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('ELI', 'Autorización de estancia de larga duración INICIAL por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('ELI', 'Autorización de estancia de larga duración INICIAL por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('ELI', 'Autorización de estancia de larga duración INICIAL por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('ELP', 'Autorización de estancia de larga duración PRORROGADA por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('ELP', 'Autorización de estancia de larga duración PRORROGADA por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('ELP', 'Autorización de estancia de larga duración PRORROGADA por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('ELP', 'Autorización de estancia de larga duración PRORROGADA por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('ELP', 'Autorización de estancia de larga duración PRORROGADA por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'EX00'),
('EAR', 'Autorización de trabajo por cuenta ajena para titular de estancia de larga duración PRORROGADA', 'EX00'),
('EPR', 'Autorización de trabajo por cuenta propia para titular de estancia de larga duración PRORROGADA', 'EX00'),
('NLI', 'Residencia temporal NO LUCRATIVA - INICIAL', 'EX01'),
('NLI', 'Residencia temporal NO LUCRATIVA - INICIAL', 'EX01'),
('NLR', 'Residencia temporal NO LUCRATIVA - RENOVACIÓN', 'EX01'),
('NLR', 'Residencia temporal NO LUCRATIVA - RENOVACIÓN', 'EX01'),
('RGI', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL POR REAGRUPACIÓN FAMILIAR INICIAL', 'EX02'),
('RGI', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL POR REAGRUPACIÓN FAMILIAR INICIAL', 'EX02'),
('RFV', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL POR REAGRUPACIÓN FAMILIAR ', 'EX02'),
('RFV', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL POR REAGRUPACIÓN FAMILIAR ', 'EX02'),
('RIT', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL INDPENDIENTE DEL  REAGRUPANTE', 'EX02'),
('RIT', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL INDPENDIENTE DEL  REAGRUPANTE', 'EX02'),
('RIT', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL INDPENDIENTE DEL  REAGRUPANTE', 'EX02'),
('RIT', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL INDPENDIENTE DEL  REAGRUPANTE', 'EX02'),
('RIT', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL INDPENDIENTE DEL  REAGRUPANTE', 'EX02'),
('RIT', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL INDPENDIENTE DEL  REAGRUPANTE', 'EX02'),
('RIT', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL INDPENDIENTE DEL  REAGRUPANTE', 'EX02'),
('RGR', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL POR REAGRUPACIÓN FAMILIAR RENOVADA', 'EX02'),
('TRG', 'AUTORIZACIÓN DE TRABAJO', 'EX02'),
('TRG', 'AUTORIZACIÓN DE TRABAJO', 'EX02'),
('KAI', 'RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA INICIAL', 'EX03'),
('KAI', 'RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA INICIAL', 'EX03'),
('KAI', 'RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA INICIAL', 'EX03'),
('KAI', 'RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA INICIAL', 'EX03'),
('KAI', 'RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA INICIAL', 'EX03'),
('KAI', 'RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA INICIAL', 'EX03'),
('KAI', 'RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA INICIAL', 'EX03'),
('KAI', 'RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA INICIAL', 'EX03'),
('KAI', 'RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA INICIAL', 'EX03'),
('KAI', 'RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA INICIAL', 'EX03'),
('KAI', 'RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA INICIAL', 'EX03'),
('KAI', 'RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA INICIAL', 'EX03'),
('KAI', 'RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA INICIAL', 'EX03'),
('KAI', 'RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA INICIAL', 'EX03'),
('ATI', 'AUTORIZACIÓN PARA TRABAJAR POR CUENTA AJENA Y PROPIA INICIAL', 'EX03'),
('KAI', 'RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA INICIAL', 'EX03'),
('AAI', 'AUTORIZACIÓN PARA TRABAJAR POR CUENTA AJENA INICIAL', 'EX03'),
('KAI', 'RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA INICIAL', 'EX03'),
('KAI', 'RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA INICIAL', 'EX03'),
('KAI', 'RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA INICIAL', 'EX03'),
('KAI', 'RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA INICIAL', 'EX03'),
('KA4', 'RENOVACIÓN RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA CON 4 AÑOS DE DURACIÓN', 'EX03'),
('KA1', 'RENOVACIÓN RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA CON 1 AÑO DE DURACIÓN', 'EX03'),
('KA4', 'RENOVACIÓN RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA CON 4 AÑOS DE DURACIÓN', 'EX03'),
('KA1', 'RENOVACIÓN RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA CON 1 AÑO DE DURACIÓN', 'EX03'),
('AAR', 'AUTORIZACIÓN PARA TRABAJAR POR CUENTA AJENA PRORROGADA', 'EX03'),
('AT3', 'AUTORIZACIÓN PARA TRABAJAR POR CUENTA AJENA Y PROPIA PRORROGADA', 'EX03'),
('KAI', 'RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA INICIAL', 'EX03'),
('KA4', 'RENOVACIÓN RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA CON 4 AÑOS DE DURACIÓN', 'EX03'),
('RPI', 'AUTORIZACIÓN DE RESIDENCIA INICIAL PARA PRÁCTICAS ', 'EX04'),
('RPI', 'AUTORIZACIÓN DE RESIDENCIA INICIAL PARA PRÁCTICAS ', 'EX04'),
('RPI', 'AUTORIZACIÓN DE RESIDENCIA INICIAL PARA PRÁCTICAS ', 'EX04'),
('RPI', 'AUTORIZACIÓN DE RESIDENCIA INICIAL PARA PRÁCTICAS ', 'EX04'),
('RIF', 'AUTORIZACIÓN DE RESIDENCIA INICIAL PARA PRÁCTICAS DE FAMILIAR', 'EX04'),
('RPR', 'AUTORIZACIÓN DE RESIDENCIA RENOVADA PARA PRÁCTICAS ', 'EX04'),
('RPR', 'AUTORIZACIÓN DE RESIDENCIA RENOVADA PARA PRÁCTICAS ', 'EX04'),
('RRF', 'AUTORIZACIÓN DE RESIDENCIA RENOVADA PARA PRÁCTICAS  DE FAMILIAR', 'EX04'),
('RAI', 'RESIDENCIA Y TRABAJO PARA ACTIVIDADES DE TEMPORADA INICIAL.', 'EX06'),
('RAL', 'RESIDENCIA Y TRABAJO PARA ACTIVIDADES DE TEMPORADA LLAMAMIENTOS.', 'EX06'),
('RAT', 'RESIDENCIA Y TRABAJO PARA ACTIVIDADES DE TEMPORADA.', 'EX06'),
('RAT', 'RESIDENCIA Y TRABAJO PARA ACTIVIDADES DE TEMPORADA.', 'EX06'),
('RAT', 'RESIDENCIA Y TRABAJO PARA ACTIVIDADES DE TEMPORADA.', 'EX06');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
