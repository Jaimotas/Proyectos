-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-01-2026 a las 11:38:53
-- Versión del servidor: 8.0.44
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `lga_formularios`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lga_autorizaciones`
--

CREATE TABLE `lga_autorizaciones` (
  `COD_MEYSS` varchar(6) NOT NULL COMMENT 'Código del MEYSS de identificación de la autorización',
  `ID_PERMISO` varchar(3) NOT NULL COMMENT 'Código de permiso relacionado con la tabla LGA_PERMISOS',
  `ID_VIA` varchar(3) NOT NULL COMMENT 'Vía de acceso correspondiente a la aplicación de extranjería',
  `ID_MODELO` varchar(4) NOT NULL COMMENT 'Identificador del modelo de formulario a rellenar para solicitar esta autorización',
  `NUM_PLAZO` int DEFAULT NULL COMMENT 'Número del plazo',
  `TIPO_PLAZO` varchar(1) DEFAULT NULL COMMENT 'Tipo de plazo: D - Días, M - Meses, A - Años',
  `SILENCIO` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Sentido del silencio: P - Positivo, N - Negativo',
  `EPIGRAFE_TASA_052` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Epigrafe o check a marcar en el impreso de la tasa 052 (para usar en escritos)',
  `EPIGRAFE_TASA_062` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Epigrafe o check a marcar en el impreso de la tasa 062 (para usar en escritos)',
  `DOS_VECES_SMI` varchar(1) DEFAULT NULL COMMENT 'TASA 062 2 VECES SMI: S - Sí, N - No'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lga_modelos`
--

CREATE TABLE `lga_modelos` (
  `ID` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Identificador del formulario (EX00, EX01, EX02, …)',
  `DES_MODELO` varchar(300) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Descripción identificativa del modelo de formulario'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lga_permisos`
--

CREATE TABLE `lga_permisos` (
  `ID` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Código de permiso correspondiente a la aplicación de extranjería',
  `DES_PERMISO` varchar(300) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Descripción identificativa del permiso',
  `LUCRATIVO` varchar(1) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'N' COMMENT 'Lucrativo (S/N)',
  `RESIDENCIA` varchar(1) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'N' COMMENT 'Es permiso de residencia',
  `VIA_DEFECTO` varchar(3) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Vía por defecto al abrir',
  `MESES_VALIDEZ` decimal(10,0) DEFAULT NULL COMMENT 'Meses validez del Permiso',
  `REGLAMENTO` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Reglamento por defecto de la autorización'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lga_via_acceso`
--

CREATE TABLE `lga_via_acceso` (
  `ID` varchar(3) NOT NULL COMMENT 'Identificador de la vía de acceso correspondiente a la aplicación de extranjería',
  `DES_VIA_ACCESO` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Descripción identificativa de la vía de acceso (supuesto)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `lga_autorizaciones`
--
ALTER TABLE `lga_autorizaciones`
  ADD PRIMARY KEY (`COD_MEYSS`),
  ADD KEY `fk_id_via_acceso` (`ID_VIA`) INVISIBLE,
  ADD KEY `fk_id_permiso` (`ID_PERMISO`) INVISIBLE,
  ADD KEY `fk_id_modelo` (`ID_MODELO`);

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

--
-- Indices de la tabla `lga_via_acceso`
--
ALTER TABLE `lga_via_acceso`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID_UNIQUE` (`ID`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `lga_autorizaciones`
--
ALTER TABLE `lga_autorizaciones`
  ADD CONSTRAINT `FK_ID_MODELO` FOREIGN KEY (`ID_MODELO`) REFERENCES `lga_modelos` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ID_PERMISO` FOREIGN KEY (`ID_PERMISO`) REFERENCES `lga_permisos` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ID_VIA` FOREIGN KEY (`ID_VIA`) REFERENCES `lga_via_acceso` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
