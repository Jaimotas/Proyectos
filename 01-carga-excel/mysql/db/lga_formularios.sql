-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-01-2026 a las 13:02:45
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

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `comprobacion_valores_pagina` (IN `p_id_modelo` VARCHAR(4), IN `p_columna` VARCHAR(64))   BEGIN
    SET @sql = CONCAT(
        'SELECT ', p_columna, ', COUNT(*) AS total ',
        'FROM lga_autorizaciones ',
        'WHERE ID_MODELO = ? ',
        'GROUP BY ', p_columna
    );

    PREPARE stmt FROM @sql;
    SET @modelo = p_id_modelo;
    EXECUTE stmt USING @modelo;
    DEALLOCATE PREPARE stmt;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `estadistica_por_columna` (IN `p_columna` VARCHAR(64))   BEGIN
    SET @sql = CONCAT(
        'SELECT ', p_columna, ', COUNT(*) AS total ',
        'FROM lga_autorizaciones ',
        'GROUP BY ', p_columna
    );

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lga_autorizaciones`
--

CREATE TABLE `lga_autorizaciones` (
  `COD_MEYSS` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Código del MEYSS de identificación de la autorización',
  `ID_PERMISO` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Código de permiso relacionado con la tabla LGA_PERMISOS',
  `ID_VIA` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Vía de acceso correspondiente a la aplicación de extranjería',
  `ID_MODELO` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Identificador del modelo de formulario a rellenar para solicitar esta autorización',
  `NUM_PLAZO` int DEFAULT NULL COMMENT 'Número del plazo',
  `TIPO_PLAZO` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Tipo de plazo (D: Días - M: Meses - A: Años)',
  `SILENCIO` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Sentido del silencio (P: Positivo - N: Negativo)',
  `EPIGRAFE_TASA_052` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Epigrafe o check a marcar en el impreso de la tasa 052 (para usar en escritos)',
  `EPIGRAFE_TASA_062` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Epigrafe o check a marcar en el impreso de la tasa 062 (para usar en escritos)',
  `DOS_VECES_SMI` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'TASA 062 2 VECES SMI (S: Sí - N: No)',
  `AUTORIZA_TRABAJAR` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Autoriza a trabajar (S: Sí - N: No - I: Instrucciones - R: Resolución - P: Practicas - L: No autoriza a trabajar pero lleva datos laborales - A: Si/No)',
  `DURACION` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Duración (en meses) (DE: No especificado/Desconocido - 01, 02 …..12 ….: 1 mes, 2 meses, … 1 año … - CO: Condicionada - IN: Indefinida)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `lga_autorizaciones`
--

INSERT INTO `lga_autorizaciones` (`COD_MEYSS`, `ID_PERMISO`, `ID_VIA`, `ID_MODELO`, `NUM_PLAZO`, `TIPO_PLAZO`, `SILENCIO`, `EPIGRAFE_TASA_052`, `EPIGRAFE_TASA_062`, `DOS_VECES_SMI`, `AUTORIZA_TRABAJAR`, `DURACION`) VALUES
('A1I000', 'ELI', 'ESE', 'EX00', 2, 'M', 'N', '1.1.1', 'N/A', 'N', 'S', 'DE'),
('A1I001', 'ELI', 'ESC', 'EX00', 2, 'M', 'N', '1.1.1', 'N/A', 'N', 'S', 'DE'),
('A1I002', 'ELI', 'ESI', 'EX00', 15, 'D', 'N', '1.1.1', 'N/A', 'N', 'S', 'DE'),
('A1I003', 'ELI', 'EPE', 'EX00', 2, 'M', 'N', '1.1.1', 'N/A', 'N', 'N', '12'),
('A1I004', 'ELI', 'EPC', 'EX00', 2, 'M', 'N', '1.1.1', 'N/A', 'N', 'N', '12'),
('A1I005', 'ELI', 'PME', 'EX00', 2, 'M', 'N', '1.1.1', 'N/A', 'N', 'N', '12'),
('A1I006', 'ELI', 'PMC', 'EX00', 2, 'M', 'N', '1.1.1', 'N/A', 'N', 'N', '12'),
('A1I007', 'ELI', 'EVE', 'EX00', 2, 'M', 'N', '1.1.1', 'N/A', 'N', 'N', '12'),
('A1I008', 'ELI', 'EVC', 'EX00', 2, 'M', 'N', '1.1.1', 'N/A', 'N', 'N', '12'),
('A1I009', 'ELI', 'FOE', 'EX00', 2, 'M', 'N', '1.1.1', 'N/A', 'N', 'N', '12'),
('A1I010', 'ELI', 'FOC', 'EX00', 2, 'M', 'N', '1.1.1', 'N/A', 'N', 'N', '12'),
('A1I011', 'ELI', 'FIE', 'EX00', 2, 'M', 'N', '1.1.1', 'N/A', 'N', 'N', 'DE'),
('A1I012', 'ELI', 'FIC', 'EX00', 2, 'M', 'N', '1.1.1', 'N/A', 'N', 'N', 'DE'),
('A1I013', 'ELI', 'ASE', 'EX00', 2, 'M', 'N', '1.1.1', 'N/A', 'N', 'S', 'DE'),
('A1I014', 'ELI', 'ASC', 'EX00', 2, 'M', 'N', '1.1.1', 'N/A', 'N', 'S', 'DE'),
('A1I015', 'ELI', 'SFE', 'EX00', 2, 'M', 'N', '1.1.1', 'N/A', 'N', 'N', 'DE'),
('A1I016', 'ELI', 'SFC', 'EX00', 2, 'M', 'N', '1.1.1', 'N/A', 'N', 'N', 'DE'),
('A1I017', 'ELI', 'CDE', 'EX00', 30, 'M', 'N', '1.1.1', 'N/A', 'N', 'N', 'DE'),
('A1I018', 'ELI', 'MUE', 'EX00', 1, 'M', 'N', '1.1.1', 'N/A', 'N', 'N', 'DE'),
('A1I019', 'ELI', 'VP', 'EX00', 2, 'M', 'N', '1.1.1', 'N/A', 'N', 'N', '12'),
('A1I020', 'ELI', 'KH', 'EX00', 2, 'M', 'N', '1.1.1', 'N/A', 'N', 'N', 'DE'),
('A1I021', 'ELI', 'AUP', 'EX00', 2, 'M', 'N', '1.1.1', 'N/A', 'N', 'S', 'DE'),
('A1P000', 'ELP', 'ESP', 'EX00', 1, 'M', 'N', '1.1.2', 'N/A', 'N', 'S', '12'),
('A1P001', 'ELP', 'EPP', 'EX00', 1, 'M', 'N', '1.1.2', 'N/A', 'N', 'N', '12'),
('A1P002', 'ELP', 'EVP', 'EX00', 1, 'M', 'N', '1.1.2', 'N/A', 'N', 'N', '12'),
('A1P003', 'ELP', 'FOP', 'EX00', 1, 'M', 'N', '1.1.2', 'N/A', 'N', 'N', '12'),
('A1P004', 'ELP', 'FEP', 'EX00', 1, 'M', 'N', '1.1.2', 'N/A', 'N', 'N', 'DE'),
('B0I000', 'NLI', 'MEI', 'EX01', 1, 'M', 'N', '2.1.1', NULL, 'N', 'N', '12'),
('B0I001', 'NLI', 'FMI', 'EX01', 1, 'M', 'N', '2.1.1', NULL, 'N', 'N', '12'),
('B0R000', 'NLR', 'MER', 'EX01', 3, 'M', 'N', '2.2.1', NULL, 'N', 'N', '24'),
('B0R001', 'NLR', 'FMR', 'EX01', 3, 'M', 'N', '2.2.1', NULL, 'N', 'N', '24'),
('B1I000', 'RGI', 'RFI', 'EX02', 2, 'M', 'N', '2.1.2', 'N/A', 'N', 'N', '12'),
('B20I00', 'KAI', 'EXA', 'EX03', 3, 'M', 'N', '2.1.3', '3.2.1 a)', 'S', 'S', '12'),
('B20I01', 'KAI', 'EXB', 'EX03', 3, 'M', 'N', '2.1.3', '3.2.1 a)', 'S', 'S', '12'),
('B20I02', 'KAI', 'EXC', 'EX03', 3, 'M', 'N', '2.1.3', '3.2.1 a)', 'S', 'S', '12'),
('B20I03', 'KAI', 'EXD', 'EX03', 3, 'M', 'N', '2.1.3', '3.2.1 a)', 'S', 'S', '12'),
('B20I04', 'KAI', 'ODA', 'EX03', 3, 'M', 'N', '2.1.3', '3.2.1 a)', 'S', 'S', '12'),
('B20I05', 'KAI', 'ODB', 'EX03', 3, 'M', 'N', '2.1.3', '3.2.1 a)', 'S', 'S', '12'),
('B20I06', 'KAI', 'OGA', 'EX03', 3, 'M', 'N', '2.1.3', '3.2.1 a)', 'S', 'S', '12'),
('B20I07', 'KAI', 'OGB', 'EX03', 3, 'M', 'N', '2.1.3', '3.2.1 a)', 'S', 'S', '12'),
('B20I08', 'KAI', 'EA0', 'EX03', 3, 'M', 'N', '2.1.3', '3.2.1 a)', 'S', 'S', '12'),
('B20I09', 'KAI', 'EA1', 'EX03', 3, 'M', 'N', '2.1.3', '3.2.1 a)', 'S', 'S', '12'),
('B20I10', 'KAI', 'EA2', 'EX03', 3, 'M', 'N', '2.1.3', '3.2.1 a)', 'S', 'S', '12'),
('B20I11', 'KAI', 'EA3', 'EX03', 3, 'M', 'N', '2.1.3', '3.2.1 a)', 'S', 'S', '12'),
('B20I12', 'KAI', 'EA4', 'EX03', 3, 'M', 'N', '2.1.3', '3.2.1 a)', 'S', 'S', '12'),
('B20I13', 'KAI', 'EA5', 'EX03', 3, 'M', 'N', '2.1.3', '3.2.1 a)', 'S', 'S', '12'),
('B20I14', 'KAI', 'EFC', 'EX03', 3, 'M', 'N', '2.1.3', '3.2.1 a)', 'S', 'S', '60'),
('B21I00', 'KAI', 'IG0', 'EX03', 1, 'M', 'N', 'N/A', '3.2.1 a)', 'S', 'S', 'DE'),
('B21I01', 'KAI', 'IG1', 'EX03', 1, 'M', 'N', 'N/A', '3.2.1 a)', 'S', 'S', 'DE'),
('B21I02', 'KAI', 'CE0', 'EX03', 1, 'M', 'N', 'N/A', '3.2.1 a)', 'S', 'S', 'DE'),
('B21I03', 'KAI', 'CE1', 'EX03', 1, 'M', 'N', 'N/A', '3.2.1 a)', 'S', 'S', 'DE'),
('B21I04', 'KAI', 'VRE', 'EX03', 3, 'M', 'N', '2.1.3', '3.1.1 a)', 'S', 'S', '12'),
('B2R000', 'KA4', 'SG0', 'EX03', 3, 'M', 'N', '2.2.3', '3.2.2', 'N', 'S', '48'),
('B2R001', 'KA1', 'SG1', 'EX03', 3, 'M', 'N', '2.2.3', '3.2.2', 'N', 'S', '12'),
('B2R002', 'KA4', 'BP0', 'EX03', 3, 'M', 'N', '2.2.3', 'N/A', 'N', 'S', '48'),
('B2R003', 'KA1', 'BP1', 'EX03', 3, 'M', 'N', '2.2.3', 'N/A', 'N', 'S', '12'),
('B2R004', 'KA4', 'ARE', 'EX03', 3, 'M', 'N', '2.2.3', '3.2.2', 'N', 'S', '48'),
('B3I000', 'CPI', 'RFE', 'EX07', 3, 'M', 'N', '2.1.3', '3.1', 'N', 'S', '12'),
('B3I001', 'TPI', 'MAC', 'EX07', 3, 'M', 'N', NULL, NULL, 'N', 'N', 'DE'),
('B3I002', 'CPI', 'CAN', 'EX07', 3, 'M', 'N', '2.1.3', '3.1', 'N', 'S', '60'),
('B3R000', 'CP5', 'PAC', 'EX07', 3, 'M', 'N', '2.2.3', '3.2', 'N', 'S', '48'),
('B3R001', 'CP5', 'POS', 'EX07', 3, 'M', 'N', '2.2.3', '3.2', 'N', 'S', '48'),
('B4I000', 'ETI', 'AQD', 'EX09', 15, 'M', 'N', '2.1.4', 'N/A', 'N', 'S', '12'),
('B4I001', 'ETI', 'AQE', 'EX09', 15, 'M', 'N', '2.1.4', 'N/A', 'N', 'S', '12'),
('B4I002', 'ETA', 'AQF', 'EX09', 2, 'M', 'N', '2.1.4.', 'N/A', 'N', 'S', '12'),
('B4I003', 'ETA', 'AQG', 'EX09', 2, 'M', 'N', '2.1.4', 'N/A', 'N', 'S', '12'),
('B4P000', 'ETR', 'AQH', 'EX09', 3, 'M', 'N', '2.2.4', 'S', 'N', 'S', '48'),
('B6I001', 'FEI', 'EES', 'EX24', 2, 'M', 'N', 'N/A', 'N/A', 'N', 'S', '60'),
('B6I002', 'FEI', 'EFO', 'EX24', 2, 'M', 'N', 'N/A', 'N/A', 'N', 'S', '60'),
('B6I003', 'FEI', 'EFE', 'EX24', 2, 'M', 'N', 'N/A', 'N/A', 'N', 'S', '60'),
('B6I004', 'FEI', 'DT4', 'EX24', 2, 'M', 'N', 'N/A', 'N/A', 'N', 'S', '60'),
('B6I005', 'FIN', 'EFI', 'EX24', 2, 'M', 'N', 'N/A', 'N/A', 'N', 'S', '60'),
('B6R001', 'FRV', 'EFR', 'EX24', 2, 'M', 'N', 'N/A', 'N/A', 'N', 'S', '60'),
('B9PI00', 'RPI', 'EX1', 'EX04', 30, 'D', 'N', '2.1.7', 'Pendiente', 'N', 'N', '12'),
('B9PI01', 'RPI', 'EX2', 'EX04', 30, 'D', 'N', '2.1.7', 'Pendiente', 'N', 'N', 'DE'),
('B9PI02', 'RPI', 'ES1', 'EX04', 30, 'D', 'N', '2.1.7', 'Pendiente', 'N', 'N', '12'),
('B9PI03', 'RPI', 'ES2', 'EX04', 30, 'D', 'N', '2.1.7', 'Pendiente', 'N', 'N', 'DE'),
('B9PI04', 'RIF', 'FA1', 'EX04', 30, 'D', 'N', '2.1.7', 'Pendiente', 'N', 'N', 'DE'),
('B9PR00', 'RPR', 'RE1', 'EX04', 3, 'M', 'N', '2.2.7', 'Pendiente', 'N', 'N', '12'),
('B9PR01', 'RPR', 'RE2', 'EX04', 3, 'M', 'N', '2.2.7', 'Pendiente', 'N', 'N', 'DE'),
('B9PR02', 'RRF', 'FA2', 'EX04', 3, 'M', 'N', '2.2.7', 'Pendiente', 'N', 'N', 'DE'),
('C0C000', 'RAT', 'XX3', 'EX06', 15, 'D', 'N', '2.2.3', '4.2.1', 'N', 'S', '9'),
('C0I000', 'RAI', 'XX1', 'EX06', 1, 'M', 'N', '2.1.3', '4.1.1', 'N', 'S', '3'),
('C0I001', 'RAL', 'XX2', 'EX06', 1, 'M', 'N', '?', '?', 'N', 'S', '3'),
('C0P000', 'RAT', 'XX4', 'EX06', 3, 'M', 'N', '2.2.3', '4.2.1', 'N', 'N', 'DE'),
('C0R000', 'RAT', 'XX5', 'EX06', 1, 'M', 'N', '2.2.3', '4.2.1', 'N', 'S', 'DE'),
('E0I000', 'ARR', 'SO1', 'EX10', 3, 'M', 'N', '2.3.1', 'N/A', 'N', 'S', '12'),
('E0I001', 'ARR', 'SL1', 'EX10', 3, 'M', 'N', '2.3.1', 'N/A', 'N', 'S', '12'),
('E0I002', 'ARR', 'SC1', 'EX10', 3, 'M', 'N', '2.3.1', 'N/A', 'N', 'S', '12'),
('E0I003', 'ARR', 'SF1', 'EX10', 3, 'M', 'N', '2.3.1', 'N/A', 'N', 'S', '12'),
('E0I004', 'ARR', 'ARF', 'EX10', 3, 'M', 'N', '2.3.1', 'N/A', 'N', 'S', '60'),
('E0I005', 'COL', 'PN1', 'EX10', 3, 'M', 'N', '2.3.2.A)', 'N/A', 'N', 'S', '12'),
('E0I006', 'COL', 'CAL', 'EX10', 3, 'M', 'N', '2.3.2.A)', 'N/A', 'N', 'S', '12'),
('E0I007', 'RHU', 'VD1', 'EX10', 3, 'M', 'N', '2.3.2.B)', 'N/A', 'N', 'S', '12'),
('E0I008', 'RHU', 'ES3', 'EX10', 3, 'M', 'N', '2.3.2.A)', 'N/A', 'N', 'S', '12'),
('E0I009', 'RHU', 'PS1', 'EX10', 3, 'M', 'N', '2.3.2.A)', 'N/A', 'N', 'S', '12'),
('E0P000', 'ARR', 'SO2', 'EX10', 3, 'M', 'N', '2.4', 'N/A', 'N', 'S', '12'),
('E0P001', 'ARR', 'SL2', 'EX10', 3, 'M', 'N', '2.4', 'N/A', 'N', 'S', '12'),
('E0P002', 'ARR', 'SC2', 'EX10', 3, 'M', 'N', '2.4', 'N/A', 'N', 'S', '12'),
('E0P003', 'ARR', 'SF2', 'EX10', 3, 'M', 'N', '2.4', 'N/A', 'N', 'S', '12'),
('E0P004', 'COL', 'PN2', 'EX10', 3, 'M', 'N', '2.4', 'N/A', 'N', 'S', '12'),
('E0P005', 'COL', 'CAP', 'EX10', 3, 'M', 'N', '2.4', 'N/A', 'N', 'S', '12'),
('E0P006', 'RHU', 'VD2', 'EX10', 3, 'M', 'N', '2.4', 'N/A', 'N', 'S', '12'),
('E0P007', 'RHU', 'ES4', 'EX10', 3, 'M', 'N', '2.4', 'N/A', 'N', 'S', '12'),
('E0P008', 'RHU', 'PS2', 'EX10', 3, 'M', 'N', '2.4', 'N/A', 'N', 'S', '12'),
('E1I000', 'VGN', 'VI1', 'EX10', 3, 'M', 'N', '2.3.2.B)', 'N/A', 'N', 'S', '60'),
('E1I001', 'VGN', 'VI2', 'EX10', 0, 'M', 'N', '2.3.2.B)', 'N/A', 'N', 'S', 'DE'),
('E1I002', 'VGN', 'HV1', 'EX10', 3, 'M', 'N', '2.3.2.B)', 'N/A', 'N', 'S', '60'),
('E1I003', 'VGN', 'HV2', 'EX10', 0, 'M', 'N', '2.3.2.B)', 'N/A', 'N', 'S', 'DE'),
('E2I000', 'VSX', 'VI3', 'EX10', 3, 'M', 'N', '2.3.2.B)', 'N/A', 'N', 'S', '60'),
('E2I001', 'VSX', 'VI4', 'EX10', 0, 'M', 'N', '2.3.2.B)', 'N/A', 'N', 'S', 'DE'),
('E2I002', 'VSX', 'FA3', 'EX10', 3, 'M', 'N', '2.3.2.B)', 'N/A', 'N', 'S', '60'),
('E2I003', 'VSX', 'FA4', 'EX10', 0, 'M', 'N', '2.3.2.B)', 'N/A', 'N', 'S', 'DE'),
('E2I004', 'VSX', 'AR1', 'EX10', 3, 'M', 'N', '2.3.2.B)', 'N/A', 'N', 'S', '60'),
('E2I005', 'VSX', 'AR2', 'EX10', 0, 'M', 'N', '2.3.2.B)', 'N/A', 'N', 'S', 'DE'),
('E3I000', 'COL', 'FV1', 'EX10', 3, 'M', 'N', '2.3.2.B)', 'N/A', 'N', 'S', '60'),
('E3I001', 'COL', 'FV2', 'EX10', 3, 'M', 'N', 'N/A', 'N/A', 'N', 'S', 'DE'),
('E3I002', 'EXE', 'ER2', 'EX10', 3, 'M', 'N', 'N/A', 'N/A', 'N', 'N', 'DE'),
('E3I003', 'EXE', 'ER1', 'EX10', 3, 'M', 'N', 'N/A', 'N/A', 'N', 'N', 'DE'),
('E4I000', 'TSH', 'VI5', 'EX10', 3, 'M', 'N', '2.3.2.B)', 'N/A', 'N', 'S', '12'),
('E4I001', 'TSH', 'VI6', 'EX10', 3, 'M', 'N', '2.3.2.B)', 'N/A', 'N', 'S', '12'),
('E4I002', 'TSH', 'VI7', 'EX10', 0, 'M', 'N', 'N/A', 'N/A', 'N', 'S', 'DE'),
('E4I003', 'TSH', 'FA5', 'EX10', 3, 'M', 'N', '2.3.2.B)', 'N/A', 'N', 'S', '60'),
('E4I004', 'TSH', 'FA6', 'EX10', 3, 'M', 'N', '2.3.2.B)', 'N/A', 'N', 'S', '60'),
('E4I005', 'TSH', 'FA7', 'EX10', 0, 'M', 'N', 'N/A', 'N/A', 'N', 'S', 'DE'),
('E9I000', 'DA2', 'RE3', 'EX10', 3, 'M', 'N', '2.3.2.A)', 'N/A', 'N', 'S', '12'),
('E9I001', 'PRR', 'RE5', 'EX10', 5, 'M', 'N', 'N/A', 'N/A', 'N', 'N', 'DE'),
('E9P000', 'DA2', 'RE4', 'EX10', 3, 'M', 'N', '2.4', 'N/A', 'N', 'S', '12'),
('E9P001', 'PRR', 'RE6', 'EX10', 5, 'M', 'N', 'N/A', 'N/A', 'N', 'N', 'DE'),
('G00I00', 'RMH', 'SNE', 'EX25', 1, 'M', 'N', '2.1.5', 'N/A', 'N', 'S', '60'),
('G00I01', 'RMH', 'NNE', 'EX25', 1, 'M', 'N', '2.1.5', 'N/A', 'N', 'S', '60'),
('G01I00', 'EMD', 'ME1', 'EX25', 1, 'M', 'N', 'N/A', 'N/A', 'N', 'N', 'DE'),
('G01I01', 'EMD', 'PR1', 'EX25', 1, 'M', 'N', 'N/A', 'N/A', 'N', 'N', 'DE'),
('G01I02', 'RMD', 'ME3', 'EX25', 3, 'M', 'N', '2.1.8', 'N/A', 'N', 'N', '12'),
('G01I03', 'RMD', 'PR3', 'EX25', 3, 'M', 'N', '2.1.8', 'N/A', 'N', 'N', '12'),
('G01I04', 'EMD', 'VAC', 'EX25', 1, 'M', 'N', 'N/A', 'N/A', 'N', 'N', 'DE'),
('G01I05', 'EMD', 'MON', 'EX25', 1, 'M', 'N', 'N/A', 'N/A', 'N', 'N', 'DE'),
('G01I06', 'EMD', 'ES0', 'EX25', 1, 'M', 'N', 'N/A', 'N/A', 'N', 'N', 'DE'),
('G01P00', 'EMD', 'ME2', 'EX25', 1, 'M', 'N', '1.3', 'N/A', 'N', 'N', '3'),
('G01P01', 'EMD', 'PR2', 'EX25', 1, 'M', 'N', '1.3', 'N/A', 'N', 'N', '3'),
('G01P02', 'EMD', 'ESX', 'EX25', 0, 'M', 'N', 'N/A', 'N/A', 'N', 'N', 'DE'),
('G02I00', 'RMA', 'RIN', 'EX25', 1, 'M', 'N', 'N/A', 'N/A', 'N', 'S', '24'),
('G02R00', 'RMB', 'REN', 'EX25', 3, 'M', 'N', 'N/A', 'N/A', 'N', 'S', '36'),
('G10I00', 'RMN', '18S', 'EX25', 3, 'M', 'N', '2.3.2.c)', 'N/A', 'N', 'S', '24'),
('G10I01', 'RMN', '18T', 'EX25', 3, 'M', 'N', '2.3.2.c)', 'N/A', 'N', 'S', '24'),
('G10R00', 'RMT', '18A', 'EX25', 3, 'M', 'N', '2.2.6', 'N/A', 'N', 'S', '24'),
('G10R01', 'RMT', '18B', 'EX25', 3, 'M', 'N', '2.2.6', 'N/A', 'N', 'S', '24'),
('G10R02', 'RMN', '18R', 'EX25', 3, 'M', 'N', '2.4', 'N/A', 'N', 'S', '24'),
('H0U000', 'LUE', 'RUO', 'EX11', 3, 'M', 'N', '2.6', 'N/A', 'N', 'S', '60'),
('H0U001', 'LUE', 'RUE', 'EX11', 3, 'M', 'N', '2.6', 'N/A', 'N', 'S', '60'),
('H0U002', 'LUE', 'RUZ', 'EX11', 3, 'M', 'N', '2.6', 'N/A', 'N', 'S', '60'),
('H0U003', 'LUE', 'RUP', 'EX11', 3, 'M', 'N', '2.6', 'N/A', 'N', 'S', '60'),
('H2E000', 'LDE', 'RDO', 'EX11', 3, 'M', 'N', '2.6', 'N/A', 'N', 'S', '60'),
('H2E001', 'LDE', 'RDE', 'EX11', 3, 'M', 'N', '2.6', 'N/A', 'N', 'S', '60'),
('H2E002', 'LDE', 'RDP', 'EX11', 3, 'M', 'N', '2.6', 'N/A', 'N', 'S', '60'),
('H2E003', 'LDE', 'RDM', 'EX11', 3, 'M', 'N', '2.6', 'N/A', 'N', 'S', '60'),
('H2E004', 'LDE', 'RDT', 'EX11', 3, 'M', 'N', '2.6', 'N/A', 'N', 'S', '60'),
('H2E005', 'LDE', 'RDA', 'EX11', 3, 'M', 'N', '2.6', 'N/A', 'N', 'S', '60'),
('H2E006', 'LDE', 'RDU', 'EX11', 2, 'M', 'N', '2.6', 'N/A', 'N', 'N', '60'),
('H2E007', 'LDE', 'RDL', 'EX11', 2, 'M', 'N', '2.6', 'N/A', 'N', 'S', '60'),
('H2E008', 'LDE', 'RDN', 'EX11', 3, 'M', 'N', '2.6', 'N/A', 'N', 'S', '60'),
('H3E000', 'LDR', 'RDQ', 'EX11', 3, 'M', 'N', '2.6', 'N/A', 'N', 'S', '60'),
('H3E001', 'LDR', 'RDR', 'EX11', 3, 'M', 'N', '2.7', 'N/A', 'N', 'S', '60'),
('H3E002', 'LDR', 'RDX', 'EX11', 3, 'M', 'N', '2.7', 'N/A', 'N', 'S', '60'),
('H3U000', 'LUR', 'RDV', 'EX11', 3, 'M', 'N', '2.7', 'N/A', 'N', 'S', '60'),
('H3U001', 'LUR', 'RUR', 'EX11', 3, 'M', 'N', '2.7', 'N/A', 'N', 'S', '60'),
('H3U002', 'LUR', 'RUV', 'EX11', 3, 'M', 'N', '2.7', 'N/A', 'N', 'S', '60'),
('I0I000', 'MTN', 'MNL', 'EX26', 3, 'M', 'N', '2.5.2', 'N/A', 'N', 'N', '12'),
('I1I000', 'MF1', 'MFE', 'EX26', 3, 'M', 'N', '2.1.2', 'N/A', 'N', 'S', 'DE'),
('I3I000', 'MAI', 'MET', 'EX26', 3, 'M', 'N', '2.5.1', 'N/A', 'N', 'S', '12'),
('I3I001', 'MIA', 'MA1', 'EX26', 3, 'M', 'N', '2.5.2', 'N/A', 'N', 'S', '12'),
('I3I002', 'MAI', 'MA2', 'EX26', 3, 'M', 'N', '2.5.2', 'N/A', 'N', 'S', '12'),
('I3I004', 'MA1', 'MST', 'EX26', 1, 'M', 'N', '2.5.3', 'N/A', 'N', 'S', 'DE'),
('I3I007', 'MIA', 'MTA', 'EX26', 3, 'M', 'N', '2.5.2', 'N/A', 'N', 'S', '24'),
('I3I008', 'MTI', 'MBE', 'EX26', 20, 'M', 'N', '2.1.6', 'N/A', 'N', 'N', '12'),
('I4I000', 'MPI', 'MEA', 'EX26', 3, 'M', 'N', '2.5.1', 'N/A', 'N', 'S', '12'),
('I4I001', 'MPI', 'MA2', 'EX26', 3, 'M', 'N', '2.5.2', 'N/A', 'N', 'S', '12'),
('I4I002', 'MIP', 'MTP', 'EX26', 3, 'M', 'N', '2.5.2', 'N/A', 'N', 'S', '24'),
('I5I001', 'M2I', 'MAP', 'EX26', 3, 'M', 'N', '2.5.3', 'N/A', 'N', 'S', 'DE'),
('I5R000', 'M2R', 'MCA', 'EX26', 3, 'M', 'N', '2.5.2', 'N/A', 'N', 'S', '48'),
('I5R001', 'MAI', 'MIE', 'EX26', 3, 'M', 'N', '2.5.2', 'N/A', 'N', 'S', 'DE'),
('I6I000', 'MTE', 'MEE', 'EX26', 2, 'M', 'N', '2.5.1', 'N/A', 'N', 'N', '12'),
('I6I001', 'MTE', 'MCE', 'EX26', 3, 'M', 'N', '2.5.2', 'N/A', 'N', 'N', '12'),
('J0I001', 'EAI', 'TAI', 'EX00', 0, 'M', 'N', 'N/A', '3.5', 'N', 'S', 'DE'),
('J0P001', 'EAR', 'TAP', 'EX00', 1, 'M', 'N', '1.1.2', '3.5', 'N', 'S', 'DE'),
('J1I000', 'AP5', 'TTF', 'EX07', 3, 'M', 'N', NULL, NULL, 'N', 'S', '12'),
('J1I001', 'EPI', 'TPI', 'EX00', 0, 'M', 'N', 'N/A', '3.5', 'N', 'S', 'DE'),
('J1P000', 'AP6', 'TTP', 'EX07', 3, 'M', 'N', '2.2.3', '3.2', 'N', 'S', '12'),
('J1P001', 'EPR', 'TPP', 'EX00', 1, 'M', 'N', '1.1.2', '3.5', 'N', 'S', 'DE'),
('J2I000', 'ATI', 'IPA', 'EX03', 3, 'M', 'N', 'N/A', 'N/A', 'N', 'S', '6'),
('J2P000', 'AT3', 'IPR', 'EX03', 3, 'M', 'N', 'N/A', 'N/A', 'N', 'S', '6'),
('N0I000', 'TTF', 'SGA', 'EX19', 3, 'M', 'N', 'N/A', 'N/A', 'N', 'S', '60'),
('N0M000', 'TTF', 'MAN', 'EX19', 3, 'M', 'N', 'N/A', 'N/A', 'N', 'S', '60'),
('N0P000', 'TPF', 'REC', 'EX19', 3, 'M', 'N', 'N/A', 'N/A', 'N', 'S', '120'),
('N0R000', 'TTF', 'RET', 'EX19', 3, 'M', 'N', 'N/A', 'N/A', 'N', 'S', '60'),
('U0I000', 'IMI', 'MN1', 'EX25', 3, 'M', 'N', 'N/A', 'N/A', 'N', 'N', 'DE'),
('U0I001', 'IMV', 'MN2', 'EX25', 3, 'M', 'N', 'N/A', 'N/A', 'N', 'N', 'DE'),
('V0I000', 'APM', 'MNC', 'EX25', 0, 'M', 'N', NULL, 'N/A', 'N', 'N', 'DE'),
('V0I001', 'APM', 'MNS', 'EX25', 0, 'M', 'N', NULL, 'N/A', 'N', 'N', 'DE'),
('V0I002', 'APM', 'MND', 'EX25', 0, 'M', 'N', NULL, 'N/A', 'N', 'N', 'DE'),
('V0I003', 'RMP', 'MNP', 'EX25', 0, 'M', 'N', 'N/A', 'N/A', 'N', 'N', 'DE');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lga_modelos`
--

CREATE TABLE `lga_modelos` (
  `ID` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Identificador del formulario (EX00, EX01, EX02, …)',
  `DES_MODELO` varchar(300) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Descripción identificativa del modelo de formulario'
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
  `ID` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Código de permiso correspondiente a la aplicación de extranjería',
  `DES_PERMISO` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Descripción identificativa del permiso',
  `LUCRATIVO` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'N' COMMENT 'Lucrativo (S/N)',
  `RESIDENCIA` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'N' COMMENT 'Es permiso de residencia',
  `VIA_DEFECTO` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Vía por defecto al abrir',
  `MESES_VALIDEZ` decimal(10,0) DEFAULT NULL COMMENT 'Meses validez del Permiso',
  `REGLAMENTO` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Reglamento por defecto de la autorización'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `lga_permisos`
--

INSERT INTO `lga_permisos` (`ID`, `DES_PERMISO`, `LUCRATIVO`, `RESIDENCIA`, `VIA_DEFECTO`, `MESES_VALIDEZ`, `REGLAMENTO`) VALUES
('AAI', 'AUTORIZACIÓN PARA TRABAJAR POR CUENTA AJENA INICIAL', 'S', 'N', 'SGT', NULL, 'RD1155'),
('AAR', 'AUTORIZACIÓN PARA TRABAJAR POR CUENTA AJENA PRORROGADA', 'S', 'N', 'ATF', NULL, 'RD1155'),
('AP5', 'AUTORIZACIÓN PARA TRABAJAR POR CUENTA PROPIA INICIAL', 'N', 'N', 'TTF', NULL, 'RD1155/24'),
('AP6', 'AUTORIZACIÓN PARA TRABAJAR POR CUENTA PROPIA PRORROGADA', 'S', 'S', 'TTP', NULL, 'RD1155/24'),
('APM', 'REPATRIACIÓN MENA. Actuaciones', 'N', 'N', 'MNC', NULL, NULL),
('ARR', 'RESIDENCIA TEMPORAL POR RAZONES DE ARRAIGO', 'N', 'S', 'SO1', NULL, 'RD1155'),
('AT3', 'AUTORIZACIÓN PARA TRABAJAR POR CUENTA AJENA Y PROPIA PRORROGADA', 'N', 'N', 'IPR', NULL, 'RD1155'),
('ATI', 'AUTORIZACIÓN PARA TRABAJAR POR CUENTA AJENA Y PROPIA INICIAL', 'N', 'N', 'IPA', NULL, 'RD1155'),
('COL', 'RESIDENCIA TEMPORAL POR COLABORACIÓN', 'N', 'S', 'PN1', NULL, 'RD1155'),
('CP5', 'RESIDENCIA TEMPORAL Y TRABAJO POR CUENTA PROPIA RENOVADA', 'S', 'S', 'PAC', NULL, 'RD1155/24'),
('CPI', 'RESIDENCIA TEMPORAL Y TRABAJO POR CUENTA PROPIA INICIAL', 'S', 'S', 'RFE', NULL, 'RD1155/24'),
('DA2', 'RESIDENCIA TEMPORAL POR CIRCUNSTANCIAS NO PREVISTAS EN REGLAMENTO', 'N', 'S', 'RE3', NULL, 'RD1155'),
('DT5', 'RESIDENCIA TEMPORAL POR CIRCUNSTANCIAS EXCEPCIONALES DE LA DT 5ª', 'N', 'S', 'SO1', NULL, 'RD1156'),
('EAI', 'Autorización de trabajo por cuenta ajena INICIAL para titular de estancia de larga duración', 'S', 'N', 'TAI', NULL, 'RD1155/2024'),
('EAR', 'Autorización de trabajo por cuenta ajena para titular de estancia de larga duración PRORROGADA', 'S', 'S', 'TAP', NULL, 'RD1155/2024'),
('ELI', 'Autorización de estancia de larga duración INICIAL por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'N', 'S', 'ESE', NULL, 'RD1155/2024'),
('ELP', 'Autorización de estancia de larga duración PRORROGADA por estudios, movilidad de alumnos, servicios de voluntariado o actividades formativas', 'N', 'S', 'ESP', NULL, 'RD1155/2024'),
('EMD', 'Desplazamiento temporal de menores extranjeros en el marco de programas de carácter humanitario. Estancia', 'N', 'N', 'ME1', NULL, 'RD1155/2026'),
('EPI', 'Autorización de trabajo por cuenta propia INICIAL para titular de estancia de larga duración ', 'S', 'N', 'TPI', NULL, 'RD1155/2024'),
('EPR', 'Autorización de trabajo por cuenta propia para titular de estancia de larga duración PRORROGADA', 'S', 'S', 'TPP', NULL, 'RD1155/2024'),
('ETA', 'RESIDENCIA TEMPORAL CON EXCEPCIÓN DE LA AUTORIZACIÓN DE TRABAJO INICIAL (art.89.5)', 'N', 'S', 'AQF', NULL, 'RD1155'),
('ETI', 'RESIDENCIA TEMPORAL CON EXCEPCIÓN DE LA AUTORIZACIÓN DE TRABAJO INICIAL ( art.88)', 'N', 'S', 'AQD', NULL, 'RD1155'),
('ETR', 'RESIDENCIA TEMPORAL  CON EXCEPCIÓN DE LA AUTORIZACIÓN DE TRABAJO PRORROGADA ( art.88.7)', 'S', 'S', 'AQH', NULL, 'RD1155'),
('EXE', 'DECLARACIÓN DE EXENCIÓN DE RESPONSABILIDAD', 'N', 'N', 'ER2', NULL, 'RD1155'),
('FEI', 'Residencia temporal de familiar de ciudadano español - INICIAL', 'N', 'N', 'EES', NULL, 'RD1155'),
('FIN', 'Residencia temporal de familiar de ciudadano español - INDEPENDIENTE', 'N', 'N', 'EFI', NULL, 'RD1155'),
('FRV', 'Residencia temporal de familiar de ciudadano español - RENOVACIÓN', 'N', 'N', 'EFR', NULL, 'RD1155'),
('IMI', 'INFORME VISADO MENORES ADOPTADOS O CON FINES DE ADOPCIÓN', 'N', 'N', 'MN1', NULL, 'RD1155/2043'),
('IMV', 'INFORME PREVIO PARA DESPLAZAMIENTO DE MENORES', 'N', 'N', 'MN2', NULL, 'RD1155/2044'),
('KA1', 'RENOVACIÓN RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA CON 1 AÑO DE DURACIÓN', 'S', 'S', 'SG1', NULL, 'RD1155'),
('KA4', 'RENOVACIÓN RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA CON 4 AÑOS DE DURACIÓN', 'S', 'S', 'SG0', NULL, 'RD1155'),
('KAI', 'RESIDENCIA TEMPORAL Y TRABAJO CUENTA AJENA INICIAL', 'S', 'S', 'EXA', NULL, 'RD1155'),
('LDE', 'RESIDENCIA DE LARGA DURACIÓN EN ESPAÑA', 'N', 'S', 'RDA', NULL, 'RD1155'),
('LDR', 'RESIDENCIA DE LARGA DURACIÓN EN ESPAÑA (RECUPERACIÓN)', 'N', 'S', 'RDQ', NULL, 'RD1155'),
('LUE', 'RESIDENCIA DE LARGA DURACIÓN UE', 'N', 'S', 'RUE', NULL, 'RD1155'),
('LUR', 'RESIDENCIA DE LARGA DURACIÓN UE (RECUPERACIÓN)', 'N', 'S', 'RDV', NULL, 'RD1155'),
('M2I', 'AUTORIZACIÓN DE TRABAJO POR CUENTA PROPIA', 'N', 'S', 'MAP', NULL, 'RD1155'),
('M2R', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL Y TRABAJO POR CUENTA AJENA Y PROPIA', 'N', 'S', 'MCP', NULL, 'RD1155'),
('MA1', 'MODIFICACIÓN DE ALCANCE DE AUTORIZACIÓN INICIAL DE RESIDENCIA Y TRABAJO POR CUENTA AJENA', 'N', 'S', 'MST', NULL, 'RD1155'),
('MAI', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL Y TRABAJO POR CUENTA AJENA', 'N', 'S', 'MIE', NULL, 'RD1155'),
('MF1', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL POR REAGRUPACIÓN FAMILIAR', 'N', 'S', 'MFE', NULL, 'RD1155'),
('MIA', 'AUTORIZACIÓN INICIAL DE RESIDENCIA TEMPORAL Y TRABAJO POR CUENTA AJENA', 'N', 'S', 'MTA', NULL, 'RD1155'),
('MIP', 'AUTORIZACIÓN INICIAL DE RESIDENCIA TEMPORAL Y TRABAJO POR CUENTA PROPIA', 'N', 'S', 'MTP', NULL, 'RD1155'),
('MPI', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL Y TRABAJO POR CUENTA PROPIA', 'N', 'S', 'MIE', NULL, 'RD1155'),
('MTE', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL Y EXCEPCIÓN DE AUTORIZACIÓN DE TRABAJO', 'N', 'S', 'MCE', NULL, 'RD1155'),
('MTI', 'AUTORIZACION INICIAL DE RESIDENCIA TEMPORAL NO LUCRATIVA', 'N', 'S', 'MBE', NULL, 'RD1155'),
('MTN', 'AUTORIZACION DE RESIDENCIA TEMPORAL NO LUCRATIVA', 'N', 'S', 'MNL', NULL, 'RD1155'),
('NLI', 'Residencia temporal NO LUCRATIVA - INICIAL', 'N', 'S', 'MEI', NULL, 'RD1155'),
('NLR', 'Residencia temporal NO LUCRATIVA - RENOVACIÓN', 'N', 'S', 'MER', NULL, 'RD1155'),
('PRR', 'ESTANCIA TEMPORAL POR CIRCUNSTANCIAS EXCEPCIONALES – PERÍODO DE RESTABLECIMIENTO Y REFLEXIÓN ', 'N', 'N', 'RE5', NULL, 'RD1155'),
('RAI', 'RESIDENCIA Y TRABAJO PARA ACTIVIDADES DE TEMPORADA INICIAL.', 'S', 'S', 'XX1', NULL, 'RD1155'),
('RAL', 'RESIDENCIA Y TRABAJO PARA ACTIVIDADES DE TEMPORADA LLAMAMIENTOS.', 'S', 'S', 'XX2', NULL, 'RD1155'),
('RAT', 'RESIDENCIA Y TRABAJO PARA ACTIVIDADES DE TEMPORADA.', 'S', 'S', 'XX3', NULL, 'RD1155'),
('RFV', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL POR REAGRUPACIÓN FAMILIAR ', 'N', 'S', 'RED', NULL, 'RD1155/2024'),
('RGI', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL POR REAGRUPACIÓN FAMILIAR INICIAL', 'N', 'S', 'RFI', NULL, 'RD1155/2024'),
('RGR', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL POR REAGRUPACIÓN FAMILIAR RENOVADA', 'N', 'S', 'RFR', NULL, 'RD1155/2025'),
('RHU', 'RESIDENCIA TEMPORAL POR CIRCUNSTANCIAS EXCEPCIONALES – RAZONES HUMANITARIAS ', 'N', 'S', 'VD1', NULL, 'RD1155'),
('RIF', 'AUTORIZACIÓN DE RESIDENCIA INICIAL PARA PRÁCTICAS DE FAMILIAR', 'S', 'S', 'FA1', NULL, 'RD1155'),
('RIT', 'AUTORIZACIÓN DE RESIDENCIA TEMPORAL INDPENDIENTE DEL  REAGRUPANTE', 'N', 'S', 'INI', NULL, 'RD1155/2025'),
('RMA', 'Residencia temporal de menores extranjeros no acompañados. Art 172', 'N', 'N', 'RIN', NULL, 'RD1155/2036'),
('RMB', 'Residencia temporal de menores extranjeros no acompañados. Art. 172.5', 'N', 'N', 'REN', NULL, 'RD1155/2037'),
('RMD', 'Desplazamiento temporal de menores extranjeros en el marco de programas de carácter humanitario. Residencia', 'N', 'S', 'ME3', NULL, 'RD1155/2030'),
('RMH', 'Residencia temporal inicial de hijo o residente', 'N', 'S', 'SNE', NULL, 'RD1155/2024'),
('RMN', 'Residencia temporal de menores extranjeros no acompañados. Art. 174', 'N', 'S', '18S', NULL, 'RD1155/2040'),
('RMP', 'REPATRIACIÓN MENA. Procedimiento', 'N', 'N', 'MNP', NULL, 'RD557'),
('RMT', 'Residencia temporal de menores extranjeros no acompañados. Art. 173', 'N', 'S', '18A', NULL, 'RD1155/2038'),
('RPI', 'AUTORIZACIÓN DE RESIDENCIA INICIAL PARA PRÁCTICAS ', 'S', 'S', 'EX1', NULL, 'RD1155'),
('RPR', 'AUTORIZACIÓN DE RESIDENCIA RENOVADA PARA PRÁCTICAS ', 'S', 'S', 'RE1', NULL, 'RD1155'),
('RRF', 'AUTORIZACIÓN DE RESIDENCIA RENOVADA PARA PRÁCTICAS  DE FAMILIAR', 'S', 'S', 'FA2', NULL, 'RD1155'),
('TPF', 'TARJETA DE RESIDENCIA PERMANENTE DE FAMILIAR DE LA UE', 'N', 'N', 'REC', NULL, 'Real Decreto 240/20207'),
('TPI', 'AUTORIZACION DE TRABAJO POR CUENTA PROPIA INICIAL', 'N', 'N', 'MAC', NULL, 'RD1155/24'),
('TRG', 'AUTORIZACIÓN DE TRABAJO', 'S', 'N', 'ASA', NULL, 'RD1155/2026'),
('TSH', 'RESIDENCIA TEMPORAL POR CIRCUNSTANCIAS EXCEPCIONALES - VÍCTIMAS DE TRATA DE SERES HUMANOS', 'N', 'S', 'VI5', NULL, 'RD1155'),
('TTF', 'TARJETA DE RESIDENCIA TEMPORAL DE FAMILIAR DE LA UE', 'N', 'N', 'SGA', NULL, 'Real Decreto 240/20207'),
('VGN', 'RESIDENCIA TEMPORAL Y TRABAJO POR CIRCUNSTANCIAS EXCEPCIONALES - VÍCTIMAS DE VIOLENCIA DE GÉNERO', 'N', 'S', 'VI1', NULL, 'RD1155'),
('VSX', 'RESIDENCIA TEMPORAL Y TRABAJO POR CIRCUNSTANCIAS EXCEPCIONALES - VÍCTIMAS DE VIOLENCIA SEXUAL', 'N', 'S', 'VI3', NULL, 'RD1155');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lga_via_acceso`
--

CREATE TABLE `lga_via_acceso` (
  `ID` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Identificador de la vía de acceso correspondiente a la aplicación de extranjería',
  `DES_VIA_ACCESO` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Descripción identificativa de la vía de acceso (supuesto)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `lga_via_acceso`
--

INSERT INTO `lga_via_acceso` (`ID`, `DES_VIA_ACCESO`) VALUES
('18A', NULL),
('18B', NULL),
('18R', NULL),
('18S', NULL),
('18T', NULL),
('AQD', 'Religioso o miembro de confesiones y comunidades religiosas'),
('AQE', 'Otros.  art88 (a.b.c.d.e.f.h.i) Desplegable'),
('AQF', 'Religioso o miembro de confesiones y comunidades religiosas'),
('AQG', 'Otros art88 (a.b.c.d.e.f.h.i). Desplegable'),
('AQH', NULL),
('AR1', 'DEFINITIVA'),
('AR2', 'PROVISIONAL'),
('ARE', NULL),
('ARF', 'Inicial'),
('ASA', NULL),
('ASC', NULL),
('ASE', NULL),
('ASP', NULL),
('ATF', NULL),
('AUP', NULL),
('BP0', 'Beneficiario de prestación contributiva por desempleo o asistencial (art. 80.2.c) vigencia anterior = 1 año'),
('BP1', 'Beneficiario de prestación contributiva por desempleo o asistencial (art. 80.2.c) vigencia anterior < 1 año'),
('CAL', 'Inicial'),
('CAN', 'Ciudadanos andorranos'),
('CAP', 'Prórroga'),
('CDE', NULL),
('CE0', 'Autorización anterior = 1 año'),
('CE1', 'Autorización anterior < 1 año'),
('DT4', 'Hijos y ascendientes de la disposición transitoria cuarta (DT4)'),
('EA0', 'Deportistas profesionales (Acuerdo Cº Mº 2005) (contrato >= 1 año)'),
('EA1', 'Deportistas profesionales (Acuerdo Cº Mº 2005) (contrato < 1 año)'),
('EA2', 'Enrolado en buque español Marina Mercante (Acuerdo Cº Mº 2007) (contrato >= 1 año)'),
('EA3', 'Enrolado en buque español Marina Mercante (Acuerdo Cº Mº 2007) (contrato < 1 año)'),
('EA4', 'Enrolado en buque español sin acuerdo internacional pesca (Acuerdo Cº Mº 2019) (contrato >= 1 año)'),
('EA5', 'Enrolado en buque español sin acuerdo internacional pesca (Acuerdo Cº Mº 2019) (contrato < 1 año)'),
('EES', 'Español en territorio nacional y familiar extranjero en origen (art. 97.1.a)'),
('EFC', 'Nacional andorrano'),
('EFE', 'Español y familiar extranjero en España (art. 97.1.c)'),
('EFI', 'Residencia Independiente (art. 99)'),
('EFO', 'Español y familiar extranjero fuera de España (art. 97.1.b)'),
('EFR', 'Renovación (art. 95.4)'),
('EPC', '* Tipo de estudios:\n       - Bachillerato\n       - Enseñanzas artísticas profesionaes de música o danza\n       - Formación profesional de grado medio\n       - Enseñanzas profesionales de artes plásticas y diseño de grado medio, o títulos de especialización de grado medio\n       - Enseñanzas deportivas de grado medio\n       '),
('EPE', '* Tipo de estudios:\n       - Bachillerato\n       - Enseñanzas artísticas profesionaes de música o danza\n       - Formación profesional de grado medio\n       - Enseñanzas profesionales de artes plásticas y diseño de grado medio, o títulos de especialización de grado medio\n       - Enseñanzas deportivas de grado medio\n       '),
('EPP', '* Prórrogas:\n     - 1ª prórroga\n     - 2º prórroga'),
('ER1', 'Exención de responsabilidad por colaboración - víctima de trata de seres humanos (art. 151)'),
('ER2', 'Exención de responsabilidad por colaboración -  redes organizadas (art. 142)'),
('ES0', NULL),
('ES1', NULL),
('ES2', NULL),
('ES3', 'Inicial '),
('ES4', 'Prórroga'),
('ESC', '* Tipo de estudios:\n       - Enseñanza universitaria título oficial\n       - Enseñanza universitaria título propio.\n       - Enseñanzas artísticas superiores\n       - Formación profesional de grado superior, títulos de especialización de grado superior o Máster de FP\n       - Enseñanzas profesionales de artes plásticas y diseño de grado superior\n       - Enseñanzas deportivas de grado superior\n       - Formación superior no reglada'),
('ESE', '* Tipo de estudios:\n       - Enseñanza universitaria título oficial\n       - Enseñanza universitaria título propio.\n       - Enseñanzas artísticas superiores\n       - Formación profesional de grado superior, títulos de especialización de grado superior o Máster de FP\n       - Enseñanzas profesionales de artes plásticas y diseño de grado superior\n       - Enseñanzas deportivas de grado superior\n       - Formación superior no reglada'),
('ESI', '* Tipo de estudios:\n       - Enseñanza universitaria título oficial\n       - Enseñanza universitaria título propio.\n       - Enseñanzas artísticas superiores\n       - Formación profesional de grado superior, títulos de especialización de grado superior o Máster de FP\n       - Enseñanzas profesionales de artes plásticas y diseño de grado superior\n       - Enseñanzas deportivas de grado superior\n       - Formación superior no reglada'),
('ESP', '* Prórrogas:\n     - 1ª prórroga\n     - 2º prórroga'),
('ESX', NULL),
('EVC', NULL),
('EVE', NULL),
('EVP', NULL),
('EX1', NULL),
('EX2', NULL),
('EXA', 'contrato >= 1 año'),
('EXB', 'contrato < 1 año'),
('EXC', 'contrato >= 1 año'),
('EXD', 'contrato < 1 año'),
('FA1', 'Vinculo familiar:\n   - Conyuge\n   - Pareja de Hecho\n   - Hijo menor de 18 años \n   - Hijo no capaz mayor de 18 años'),
('FA2', 'Vinculo familiar:\n   - Conyuge\n   - Pareja de Hecho\n   - Hijo menor de 18 años \n   - Hijo no capaz mayor de 18 años'),
('FA3', 'DEFINITIVA'),
('FA4', 'PROVISIONAL'),
('FA5', 'DEFINITIVA - Situación personal (SEM)'),
('FA6', 'DEFINITIVA - Colaboración en la investigación del delito (SES)'),
('FA7', 'PROVISIONAL - Colaboración en la investigación del delito o situación personal'),
('FEP', 'Vinculo:\n     - Conyuge\n     - Pareja registrada\n     - Pareja estable\n     - Hijos menores de edad\n     - Hijos mayores de edad discapacitados'),
('FIC', '* Vinculo:\n     - Conyuge\n     - Pareja registrada\n     - Pareja estable\n     - Hijos menores de edad\n     - Hijos mayores de edad discapacitados'),
('FIE', '* Vinculo:\n     - Conyuge\n     - Pareja registrada\n     - Pareja estable\n     - Hijos menores de edad\n     - Hijos mayores de edad discapacitados'),
('FMI', 'Familiar del titular de los medios económicos de la autorización'),
('FMR', 'Familiar del titular de los medios económicos de la autorización'),
('FOC', '* Actividad (art. 52.1.e):\n     - 1 Auxiliares de conversación. \n     - 2 Estudios idiomáticos\n     - 3 Curso preparatorio a formación sanitaria especializada\n     - 4 Certificado de aptitud o habilitación profesional\n     - 5 Certificados profesionales grado C (nivel 2 y 3) LO 3/2022'),
('FOE', '* Actividad (art. 52.1.e):\n     - 1 Auxiliares de conversación. \n     - 2 Estudios idiomáticos\n     - 3 Curso preparatorio a formación sanitaria especializada\n     - 4 Certificado de aptitud o habilitación profesional\n     - 5 Certificados profesionales grado C (nivel 2 y 3) LO 3/2022'),
('FOP', '* Actividad (art. 52.1.e):\n     - 1 Auxiliares de conversación. \n     - 2 Estudios idiomáticos\n     - 3 Curso preparatorio a formación sanitaria especializada\n     - 4 Certificado de aptitud o habilitación profesional\n     - 5 Certificados profesionales grado C (nivel 2 y 3) LO 3/2022'),
('FUE', NULL),
('FV1', 'DEFINITIVA'),
('FV2', 'PROVISIONAL'),
('HV1', 'DEFINITIVA'),
('HV2', 'PROVISIONAL'),
('IG0', 'Autorización anterior = 1 año'),
('IG1', 'Autorización anterior < 1 año'),
('INA', NULL),
('INE', 'Vínculo:   \n   - Hijo menor 18 años\n   - Hijo mayor de 18 años  con discapacidad\n   - Menor de 18 años representada legalmente \n   - Mayor de 18 años discapacitada represenada legalmente '),
('INF', NULL),
('INI', 'vinculo:\n   - cónyuge\n   - Pareja registrada\n   - Pareja no registrada\n  \nMedios economicos\n   - Medios economicos art. 67\n   - Requisitos autorización cuenta propia\n   - Requisitos autorización cuenta ajena'),
('INR', 'Motivo:\n   - Ruptura vínculo conyugal, separación de derecho\n   - Ruptura vínculo conyugal, disolución matrimonial\n   - Ruptura vínculo conyugal, nulidad o cancelación inscripción'),
('INU', NULL),
('INV', 'Motivo:\n   - Víctima violencia de género\n   - Víctima violencia sexual\n   - Víctima violencia entorno familiar\n   - Víctima trata seres humanso\n   - Victima delito abandono'),
('IPA', NULL),
('IPR', NULL),
('KH', 'Vinculo:\n     - Conyuge\n     - Pareja registrada\n     - Pareja estable\n     - Hijos menores de edad\n     - Hijos mayores de edad discapacitados'),
('MA1', 'LLEVANDO MENOS DE UN AÑO (191.2)'),
('MA2', 'LLEVANDO AL MENOS UN AÑO (191.4)'),
('MAC', NULL),
('MAN', '2º desplegable'),
('MAP', 'Modificación art. 192.2'),
('MBE', 'Para búsqueda de empleo o proyecto empresarial (DA 17ª DE LA LEY 14/2013)'),
('MCA', 'LLEVANDO MÁS DE UN AÑO (191.3)'),
('MCE', 'Artículos 99.7 y 191.8'),
('MCL', 'LLEVANDO MENOS DE UN AÑO (191.2)'),
('MCO', 'LLEVANDO MENOS DE UN AÑO (191.2)'),
('MCP', 'LLEVANDO MÁS DE UN AÑO (191.3)'),
('ME1', NULL),
('ME2', NULL),
('ME3', NULL),
('MEA', 'Estudios superiores, enseñanza secundaria o actividades formativas  (art. 52.a),b),4º-5º e),58 y 190.3)'),
('MEE', 'Estudios superiores, enseñanza secundaria o actividades formativas  (art. 52.a),b),4º-5º e),58 y 190.4)'),
('MEI', 'Titular de los medios económicos de la autorización'),
('MER', 'Titular de los medios económicos de la autorización'),
('MET', 'Estudios superiores, enseñanza secundaria o actividades formativas  (art. 52.a),b),4º-5º e),58 y 190.2)'),
('MFE', 'titular de autorización de estancia de larga duración como Familiar de estudiante, art. 190.5'),
('MGT', 'Modificación de sector de actividad y/o ámbito territorial, art. 192.1'),
('MIE', 'Artículos 99.7 y 191.8'),
('MN1', NULL),
('MN2', NULL),
('MNC', NULL),
('MND', NULL),
('MNL', 'Artículos 99.7  y 191.8'),
('MNP', NULL),
('MNS', NULL),
('MON', NULL),
('MST', 'Modificación de ocupación y/o ámbito territorial, art. 192.1'),
('MTA', 'Artículo 191.6 b 1º'),
('MTP', 'Artículo 191.6 b 2º'),
('MUE', '* Solicitado:\n     - En España\n     - En Oficina consular\n\n* Movilidad por:\n     - Programa de la UE. Art.59,2\n     - Programa multilateral. Art.59,2\n     - Acuerdfo instituciones ensxeñanza superior. Art.59,2\n     - realización/ampliación est. Sup. no cubiertos. Art. 59,3'),
('NNE', NULL),
('ODA', 'contrato >= 1 año'),
('ODB', 'contrato < 1 año'),
('OGA', 'contrato >= 1 año'),
('OGB', 'contrato < 1 año'),
('PAC', 'Continuidad actividad'),
('PMC', '* Tipo de estudios:\n       - ESO\n       - Bachillerato\n       - Enseñanzas artísticas profesionaes de música o danza\n       - Formación profesional de grado medio\n       - Enseñanzas profesionales de artes plásticas y diseño de grado medio, o títulos de especialización de grado medio\n       - Enseñanzas deportivas de grado medio\n       '),
('PME', '* Tipo de estudios:\n       - ESO\n       - Bachillerato\n       - Enseñanzas artísticas profesionaes de música o danza\n       - Formación profesional de grado medio\n       - Enseñanzas profesionales de artes plásticas y diseño de grado medio, o títulos de especialización de grado medio\n       - Enseñanzas deportivas de grado medio\n       '),
('PN1', 'Inicial'),
('PN2', 'Prórroga'),
('POS', 'Otros supuestos'),
('PR1', NULL),
('PR2', NULL),
('PR3', NULL),
('PS1', 'Inicial '),
('PS2', 'Prórroga'),
('RB1', 'LLEVANDO MENOS DE UN AÑO (191.2)'),
('RBE', 'LLEVANDO AL MENOS UN AÑO (191.4)'),
('RDA', 'Apátridas o refugiados en territorio español reconocido el respectivo estatuto con 5 años de permanencia'),
('RDE', 'Español de origen que haya perdido la nacionalidad española '),
('RDL', 'Titular RLD UE motivo laboral'),
('RDM', 'Residente en los tres años inmediatamente anteriores a la solicitud, >18 años y nacido en España '),
('RDN', 'Contribución notoria.OFICIO'),
('RDO', 'Supuesto general 5 años de residencia continuada en España '),
('RDP', 'Residente beneficiario de pensión contributiva de jubilación o beneficiario de incapacidad permanente absoluta o gran invalidez '),
('RDQ', 'Reagrupado que renueva autorización inicial siendo el reagrupante titular de residencia larga duración.RF1-RF2 a RLD'),
('RDR', 'Recuperación. Ausencia de la UE durante 12 meses consecutivos.'),
('RDT', 'Residente tutelado por entidad pública 5 años consecutivos inmediatamente anteriores a la mayoría de edad '),
('RDU', 'Titular RLD UE motivo no lucrativo'),
('RDV', 'Recuperación. Extranjero retornado finalizado el periodo de compromiso de no retorno. '),
('RDX', 'Recuperación. Haber adquirido residencia larga duración-UE en otro EM. Presentada en OE a  residir'),
('RE1', NULL),
('RE2', NULL),
('RE3', 'Inicial'),
('RE4', 'Prórroga'),
('RE5', 'Inicial'),
('RE6', 'Prórroga'),
('REC', '3º desplegable'),
('RED', 'vinculo:\n- Hijo menor de 18 años\n- Hijo mayor de 18 años discapacitado\n- Hijo mayor de 18 años no capaz por salud'),
('REN', 'Inicio:\n-De oficio\n  -A instancia de parte'),
('RET', NULL),
('RFE', NULL),
('RFI', 'vinculo (art. 66)\n   - cónyuge\n   - Pareja registrada \n   - Pareja no registrada \n   - Hijo/a menor 18 años\n   - Hijo/a mayor de 18 años  con discapacidad\n   - Menor de 18 años representada legalmente\n   - Mayor de 18 años discapacitada represenada \n   - Ascendiente mayor de 65 años\n   - Ascendiente menor de 65 años\n   - Hijo/a mayor 18 años, cuidador\n\nSituación del Reagrupante:\n - Residente temporal\n  - Residente larga duración o larga duración UE en España'),
('RFR', 'vinculo (art. 66)\n   - cónyuge\n   - Pareja registrada \n   - Pareja no registrada \n   - Hijo/a menor 18 años\n   - Hijo/a mayor de 18 años  con discapacidad\n   - Menor de 18 años representada legalmente\n   - Mayor de 18 años discapacitada represenada \n   - Ascendiente mayor de 65 años\n   - Ascendiente menor de 65 años\n   - Hijo/a mayor 18 años, cuidador'),
('RIN', 'Inicio:\n-Orden superior\n-De oficio\n- A instancia de parte'),
('RUE', 'Residente en España con autorización anterior de estancia por estudios, intercambio o prácticas no laborales que computa al 50% '),
('RUO', 'Supuesto general 5 años de residencia continuada en España, con recursos económicos y seguro de enfermedad '),
('RUP', 'Supuesto general 5 años de residencia continuada en España, con recursos económicos y seguro de enfermedad '),
('RUR', 'Recuperación. Ausencia de la UE durante + 6 AÑOS.Presentado en OE de residencia'),
('RUV', 'Recuperación. Haber adquirido residencia larga duración-UE en otro EM. Presentada en OE a  residir'),
('RUZ', 'Residente en España en los 2 años inmediatamente anteriores y 3 ó más en otro EM, con tarjeta azul-UE'),
('SC1', 'Inicial'),
('SC2', 'Prórroga'),
('SF1', 'Inicial'),
('SF2', 'Prórroga'),
('SFC', '* Vinculo:\n     - Conyuge\n     - Pareja registrada\n     - Pareja estable\n     - Hijos menores de edad\n     - Hijos mayores de edad discapacitados'),
('SFE', '* Vinculo:\n     - Conyuge\n     - Pareja registrada\n     - Pareja estable\n     - Hijos menores de edad\n     - Hijos mayores de edad discapacitados'),
('SG0', 'supuesto general artículo 81.1 vigencia anterior = 1 año (párrafo 1)'),
('SG1', 'supuesto general artículo 81.1 vigencia anterior < 1 año (párrafo 2)'),
('SGA', '1º desplegable'),
('SGT', NULL),
('SL1', 'Inicial'),
('SL2', 'Prórroga'),
('SNE', NULL),
('SO1', 'Inicial'),
('SO2', 'Prórroga'),
('TAI', NULL),
('TAP', NULL),
('TPI', NULL),
('TPP', NULL),
('TSH', 'vinculo:\n- Hijo menor de 18 años\n- Hijo mayor de 18 años discapacitado\n- Hijo mayor de 18 años no capaz por salud'),
('TTF', NULL),
('TTP', NULL),
('VAC', NULL),
('VD1', 'Inicial '),
('VD2', 'Prórroga'),
('VI1', 'DEFINITIVA'),
('VI2', 'PROVISIONAL'),
('VI3', 'DEFINITIVA'),
('VI4', 'PROVISIONAL'),
('VI5', 'DEFINITIVA - Situación personal (SEM)'),
('VI6', 'DEFINITIVA - Situación personal (SES)'),
('VI7', 'PROVISIONAL - Colaboración en la investigación del delito o situación personal'),
('VP', NULL),
('VRE', NULL),
('XX1', NULL),
('XX2', NULL),
('XX3', 'Cambio de empleador'),
('XX4', 'Prórroga de la actividad'),
('XX5', 'Renovación de la autorización');

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
  ADD PRIMARY KEY (`ID`);

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
