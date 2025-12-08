-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Tiempo de generación: 06-12-2025 a las 19:42:54
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
-- Base de datos: `formularios`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lga_modelos`
--

CREATE TABLE `lga_modelos` (
  `ID` varchar(4) NOT NULL COMMENT 'Identificador del formulario (EX00, EX01, EX02, …)',
  `DES_MODELO` varchar(300) NOT NULL COMMENT 'Descripción identificativa del modelo de formulario'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `lga_modelos`
--

INSERT INTO `lga_modelos` (`ID`, `DES_MODELO`) VALUES
('EX00', ''),
('EX01', ''),
('EX02', ''),
('EX03', ''),
('EX04', ''),
('EX06', ''),
('EX07', ''),
('EX09', ''),
('EX10', ''),
('EX11', ''),
('EX19', ''),
('EX24', ''),
('EX25', ''),
('EX26', ''),
('EX30', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lga_permisos`
--

CREATE TABLE `lga_permisos` (
  `ID` varchar(3) NOT NULL COMMENT 'Código de permiso correspondiente a la aplicación de extranjería',
  `DES_PERMISO` varchar(300) NOT NULL COMMENT 'Descripción identificativa del permiso',
  `LUCRATIVO` varchar(1) NOT NULL DEFAULT 'N' COMMENT 'Lucrativo (S/N)\r\n',
  `RESIDENCIA` varchar(1) NOT NULL DEFAULT 'N' COMMENT 'Es permiso de residencia\r\n',
  `VIA_DEFECTO` varchar(3) DEFAULT NULL COMMENT 'Vía por defecto al abrir\r\n',
  `MESES_VALIDEZ` decimal(10,0) DEFAULT NULL COMMENT 'Meses validez del Permiso\r\n',
  `REGLAMENTO` varchar(11) DEFAULT NULL COMMENT 'Reglamento por defecto de la autorización\r\n'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `lga_permisos`
--

INSERT INTO `lga_permisos` (`ID`, `DES_PERMISO`, `LUCRATIVO`, `RESIDENCIA`, `VIA_DEFECTO`, `MESES_VALIDEZ`, `REGLAMENTO`) VALUES
('AAI', 'AUTORIZACIÓN PARA TRABAJAR POR CUENTA AJENA INICIAL', 'N', 'N', 'SGT', 3, 'RD1155'),
('AAR', 'AUTORIZACIÓN PARA TRABAJAR POR CUENTA AJENA PRORROGADA', 'P', 'N', 'ATF', 3, 'RD1155'),
('AP5', 'AUTORIZACIÓN PARA TRABAJAR POR CUENTA PROPIA INICIAL', 'N', 'N', 'TTF', 3, 'RD1155/24'),
('AP6', 'AUTORIZACIÓN PARA TRABAJAR POR CUENTA PROPIA PRORROGADA', 'P', 'N', 'TTP', 3, 'RD1155/24'),
('ARR', 'RESIDENCIA TEMPORAL POR RAZONES DE ARRAIGO', 'N', 'N', 'SO1', 3, 'RD1155'),
('AT3', 'AUTORIZACIÓN PARA TRABAJAR POR CUENTA AJENA Y PROPIA PRORROGADA', 'P', 'N', 'IPR', 3, 'RD1155'),
('ATI', 'AUTORIZACIÓN PARA TRABAJAR POR CUENTA AJENA Y PROPIA INICIAL', 'N', 'N', 'IPA', 3, 'RD1155'),
('COL', 'RESIDENCIA TEMPORAL POR COLABORACIÓN', 'N', 'N', 'PN1', 3, 'RD1155'),
('CP5', 'RESIDENCIA TEMPORAL Y TRABAJO POR CUENTA PROPIA RENOVADA', 'P', 'N', 'PAC', 3, 'RD1155/24'),
('CPI', 'RESIDENCIA TEMPORAL Y TRABAJO POR CUENTA PROPIA INICIAL', 'N', 'N', 'RFE', 3, 'RD1155/24'),
('DA2', 'RESIDENCIA TEMPORAL POR CIRCUNSTANCIAS NO PREVISTAS EN REGLAMENTO', 'N', 'N', 'RE3', 3, 'RD1155'),
('DT5', 'RESIDENCIA TEMPORAL POR CIRCUNSTANCIAS EXCEPCIONALES DE LA DT 5ª', 'N', 'N', 'SO1', 3, 'RD1156'),
('EAI', 'Autorización de trabajo por cuenta ajena INICIAL para titular de estancia de larga duración', 'N', 'N', 'TAI', NULL, 'RD1155/2024'),
('EAR', 'Autorización de trabajo por cuenta ajena para titular de estancia de larga duración PRORROGADA', 'N', 'N', 'TAP', 1, 'RD1155/2024'),
('ELI', 'Autorización de estancia de larga duración INICIAL por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'N', 'N', 'ESE', 2, 'RD1155/2024'),
('ELP', 'Autorización de estancia de larga duración PRORROGADA por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'N', 'N', 'ESP', 1, 'RD1155/2024'),
('EMD', 'Desplazamiento temporal de menores extranjeros en el marco de programas de carácter humanitario. Estancia', 'N', 'N', 'ME1', 1, 'RD 1155/202'),
('EPI', 'Autorización de trabajo por cuenta propia INICIAL para titular de estancia de larga duración ', 'N', 'N', 'TPI', NULL, 'RD1155/2024'),
('EPR', 'Autorización de trabajo por cuenta propia para titular de estancia de larga duración PRORROGADA', 'N', 'N', 'TPP', 1, 'RD1155/2024'),
('ETA', 'RESIDENCIA TEMPORAL CON EXCEPCIÓN DE LA AUTORIZACIÓN DE TRABAJO INICIAL (art.89.5)', 'N', 'N', 'AQF', 2, 'RD1155'),
('ETI', 'RESIDENCIA TEMPORAL CON EXCEPCIÓN DE LA AUTORIZACIÓN DE TRABAJO INICIAL ( art.88)', 'N', 'N', 'AQD', 15, 'RD1155'),
('ETR', 'RESIDENCIA TEMPORAL  CON EXCEPCIÓN DE LA AUTORIZACIÓN DE TRABAJO PRORROGADA ( art.88.7)', 'P', 'N', 'AQH', 3, 'RD1155'),
('EXE', 'DECLARACIÓN DE EXENCIÓN DE RESPONSABILIDAD', 'N', 'N', 'ER2', 3, 'RD1155'),
('FEI', 'Residencia temporal de familiar de ciudadano español - INICIAL', 'N', 'N', 'EES', 2, 'RD1155'),
('FIN', 'Residencia temporal de familiar de ciudadano español - INDEPENDIENTE', 'N', 'N', 'EFI', 2, 'RD1155'),
('FRV', 'Residencia temporal de familiar de ciudadano español - RENOVACIÓN', 'P', 'N', 'EFR', 2, 'RD1155'),
('IMI', 'INFORME VISADO MENORES ADOPTADOS O CON FINES DE ADOPCIÓN', 'N', 'N', 'MN1', 3, 'RD557'),
('IMV', 'INFORME PREVIO PARA DESPLAZAMIENTO DE MENORES', 'N', 'N', 'MN2', 3, 'RD557'),
('KA1', 'RENOVACIÓN RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA CON 1 AÑO DE DURACIÓN', 'P', 'N', 'SG1', 3, 'RD1155'),
('KA4', 'RENOVACIÓN RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA CON 4 AÑOS DE DURACIÓN', 'P', 'N', 'SG0', 3, 'RD1155'),
('KAI', 'RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA INICIAL', 'N', 'N', 'EXA', 3, 'RD1155'),
('LDE', 'RESIDENCIA DE LARGA DURACIÓN EN ESPAÑA', 'P', 'N', 'RDA', 3, 'RD1155'),
('LDR', 'RESIDENCIA DE LARGA DURACIÓN EN ESPAÑA (RECUPERACIÓN)', 'P', 'N', 'RDQ', 3, 'RD1155'),
('LUE', 'RESIDENCIA DE LARGA DURACIÓN UE', 'P', 'N', 'RUE', 3, 'RD1155'),
('LUR', 'RESIDENCIA DE LARGA DURACIÓN UE (RECUPERACIÓN)', 'P', 'N', 'RDV', 3, 'RD1155'),
('M2I', 'AUTORIZACIÓN DE TRABAJO POR CUENTA PROPIA', 'N', 'N', 'MAP', 3, 'RD1155'),
('M2R', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL Y TRABAJO POR CUENTA AJENA Y PROPIA', 'N', 'N', 'MCP', 3, 'RD1155'),
('MA1', 'MODIFICACIÓN DE ALCANCE DE AUTORIZACIÓN INICIAL DE RESIDENCIA Y TRABAJO POR CUENTA AJENA', 'P', 'N', 'MST', 1, 'RD1155'),
('MAI', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL Y TRABAJO POR CUENTA AJENA', 'N', 'N', 'MIE', 3, 'RD1155'),
('MF1', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL POR REAGRUPACIÓN FAMILIAR', 'N', 'N', 'MFE', 3, 'RD1155'),
('MIA', 'AUTORIZACIÓN INICIAL DE RESIDENCIA TEMPORAL Y TRABAJO POR CUENTA AJENA', 'N', 'N', 'MTA', 3, 'RD1155'),
('MIP', 'AUTORIZACIÓN INICIAL DE RESIDENCIA TEMPORAL Y TRABAJO POR CUENTA PROPIA', 'N', 'N', 'MTP', 3, 'RD1155'),
('MPI', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL Y TRABAJO POR CUENTA PROPIA', 'N', 'N', 'MIE', 3, 'RD1155'),
('MTE', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL Y EXCEPCIÓN DE AUTORIZACIÓN DE TRABAJO', 'N', 'N', 'MCE', 3, 'RD1155'),
('MTI', 'AUTORIZACION INICIAL DE RESIDENCIA TEMPORAL NO LUCRATIVA', 'P', 'N', 'MBE', 20, 'RD1155'),
('MTN', 'AUTORIZACION DE RESIDENCIA TEMPORAL NO LUCRATIVA', 'N', 'N', 'MNL', 3, 'RD1155'),
('NLI', 'Residencia temporal NO LUCRATIVA - INICIAL', 'N', 'N', 'MEI', 1, 'RD1155'),
('NLR', 'Residencia temporal NO LUCRATIVA - RENOVACIÓN', 'P', 'N', 'MER', 3, 'RD1155'),
('PRR', 'ESTANCIA TEMPORAL POR CIRCUNSTANCIAS EXCEPCIONALES – PERÍODO DE RESTABLECIMIENTO Y REFLEXIÓN ', 'P', 'N', 'RE5', 5, 'RD1155'),
('RAI', 'RESIDENCIA Y TRABAJO PARA ACTIVIDADES DE TEMPORADA INICIAL.', 'N', 'N', 'XX1', 1, 'RD1155'),
('RAL', 'RESIDENCIA Y TRABAJO PARA ACTIVIDADES DE TEMPORADA LLAMAMIENTOS.', 'P', 'N', 'XX2', 1, 'RD1155'),
('RAT', 'RESIDENCIA Y TRABAJO PARA ACTIVIDADES DE TEMPORADA.', 'N', 'N', 'XX3', 15, 'RD1155'),
('RFV', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL POR REAGRUPACIÓN FAMILIAR ', 'N', 'N', 'RED', 2, 'RD1155/2024'),
('RGI', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL POR REAGRUPACIÓN FAMILIAR INICIAL', 'N', 'N', 'RFI', 2, 'RD1155/2024'),
('RGR', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL POR REAGRUPACIÓN FAMILIAR RENOVADA', 'p', 'N', 'RFR', 3, 'RD1155/2025'),
('RHU', 'RESIDENCIA TEMPORAL POR CIRCUNSTANCIAS EXCEPCIONALES – RAZONES HUMANITARIAS ', 'N', 'N', 'VD1', 3, 'RD1155'),
('RIF', 'AUTORIZACIÓN DE RESIDENCIA INICIAL PARA PRÁCTICAS DE FAMILIAR', 'P', 'N', 'FA1', 30, 'RD1155'),
('RIT', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL INDPENDIENTE DEL  REAGRUPANTE', 'N', 'N', 'INI', 2, 'RD1155/2025'),
('RMA', 'Residencia temporal de menores extranjeros no acompañados. Art 172', 'N', 'N', 'RIN', 1, 'RD 1155/202'),
('RMB', 'Residencia temporal de menores extranjeros no acompañados. Art. 172.5', 'P', 'N', 'REN', 3, 'RD 1155/202'),
('RMD', 'Desplazamiento temporal de menores extranjeros en el marco de programas de carácter humanitario. Residencia', 'N', 'N', 'ME3', 3, 'RD 1155/202'),
('RMH', 'Residencia temporal inicial de hijo o residente', 'N', 'N', 'SNE', 1, 'RD 1155/202'),
('RMN', 'Residencia temporal de menores extranjeros no acompañados. Art. 174', 'N', 'N', '18S', 3, 'RD 1155/202'),
('RMP', 'REPATRIACIÓN MENA. Procedimiento', 'N', 'N', 'MNP', 0, 'RD557'),
('RMT', 'Residencia temporal de menores extranjeros no acompañados. Art. 173', 'P', 'N', '18A', 3, 'RD 1155/202'),
('RPI', 'AUTORIZACIÓN DE RESIDENCIA INICIAL PARA PRÁCTICAS ', 'P', 'N', 'EX1', 30, 'RD1155'),
('RPR', 'AUTORIZACIÓN DE RESIDENCIA RENOVADA PARA PRÁCTICAS ', 'P', 'N', 'RE1', 3, 'RD1155'),
('RRF', 'AUTORIZACIÓN DE RESIDENCIA RENOVADA PARA PRÁCTICAS  DE FAMILIAR', 'P', 'N', 'FA2', 3, 'RD1155'),
('TPF', 'TARJETA DE RESIDENCIA PERMANENTE DE FAMILIAR DE LA UE', 'N', 'N', 'REC', 3, '10 años'),
('TPI', 'AUTORIZACION DE TRABAJO POR CUENTA PROPIA INICIAL', 'N', 'N', 'MAC', 3, 'RD1155/24'),
('TRG', 'AUTORIZACIÓN DE TRABAJO', '/', 'N', 'ASA', 0, 'RD1155/2026'),
('TSH', 'RESIDENCIA TEMPORAL POR CIRCUNSTANCIAS EXCEPCIONALES - VÍCTIMAS DE TRATA DE SERES HUMANOS', 'N', 'N', 'VI5', 3, 'RD1155'),
('TTF', 'TARJETA DE RESIDENCIA TEMPORAL DE FAMILIAR DE LA UE', 'N', 'N', 'SGA', 3, '5 años'),
('VGN', 'RESIDENCIA TEMPORAL Y TRABAJO POR CIRCUNSTANCIAS EXCEPCIONALES - VÍCTIMAS DE VIOLENCIA DE GÉNERO', 'N', 'N', 'VI1', 3, 'RD1155'),
('VSX', 'RESIDENCIA TEMPORAL Y TRABAJO POR CIRCUNSTANCIAS EXCEPCIONALES - VÍCTIMAS DE VIOLENCIA SEXUAL', 'N', 'N', 'VI3', 3, 'RD1155');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `lga_modelos`
--
ALTER TABLE `lga_modelos`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `lga_permisos`
--
ALTER TABLE `lga_permisos`
  ADD PRIMARY KEY (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
