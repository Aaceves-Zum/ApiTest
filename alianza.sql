-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 16-03-2021 a las 22:29:47
-- Versión del servidor: 8.0.21
-- Versión de PHP: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `alianza`
--
CREATE DATABASE IF NOT EXISTS `alianza` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `alianza`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas`
--

DROP TABLE IF EXISTS `cuentas`;
CREATE TABLE IF NOT EXISTS `cuentas` (
  `NumCuenta` int NOT NULL,
  `TipoCuenta` int NOT NULL,
  `SubtipoCuenta` int NOT NULL,
  `IdSocio` int NOT NULL,
  `Saldo` decimal(10,0) NOT NULL,
  `FechaUltimoMovim` date NOT NULL,
  `FechaRegistro` date NOT NULL,
  `SaldoInicial` decimal(10,0) NOT NULL,
  `ProximoPago` decimal(10,0) NOT NULL,
  `Moneda` varchar(10) NOT NULL,
  `Fecha` date NOT NULL,
  PRIMARY KEY (`NumCuenta`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `cuentas`
--

INSERT INTO `cuentas` (`NumCuenta`, `TipoCuenta`, `SubtipoCuenta`, `IdSocio`, `Saldo`, `FechaUltimoMovim`, `FechaRegistro`, `SaldoInicial`, `ProximoPago`, `Moneda`, `Fecha`) VALUES
(1, 1, 3, 1, '55000', '2021-03-01', '2021-02-01', '60000', '5000', 'MXN', '2021-04-01'),
(2, 2, 3, 1, '130000', '2021-03-01', '2021-02-01', '150000', '5000', 'MXN', '2021-04-01'),
(3, 2, 1, 1, '80000', '2021-02-15', '2020-10-08', '0', '100', 'MXN', '2021-04-15'),
(4, 2, 1, 2, '10000', '2021-02-18', '2020-12-12', '12000', '1000', 'MXN', '2021-04-18'),
(5, 1, 2, 2, '3200', '2021-02-05', '2020-08-08', '5000', '100', 'MXN', '2021-04-08'),
(6, 1, 1, 2, '4350', '2021-02-05', '2020-05-25', '14200', '1350', 'MXN', '2021-04-28'),
(7, 1, 1, 3, '850', '2021-02-18', '2019-06-12', '9800', '600', 'MXN', '2021-03-21'),
(8, 2, 3, 3, '78000', '2021-02-05', '2020-11-21', '80000', '1000', 'MXN', '2021-03-28'),
(9, 1, 1, 3, '9500', '2021-02-05', '2021-01-07', '10000', '500', 'MXN', '2021-04-05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estatusso`
--

DROP TABLE IF EXISTS `estatusso`;
CREATE TABLE IF NOT EXISTS `estatusso` (
  `IEstatus` int NOT NULL,
  `Descripcion` varchar(20) NOT NULL,
  PRIMARY KEY (`IEstatus`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `estatusso`
--

INSERT INTO `estatusso` (`IEstatus`, `Descripcion`) VALUES
(1, 'ACTIVO'),
(2, 'BAJA'),
(3, 'DESOCUPADA'),
(4, 'BLOQUEADO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos`
--

DROP TABLE IF EXISTS `movimientos`;
CREATE TABLE IF NOT EXISTS `movimientos` (
  `IdMovimiento` int NOT NULL,
  `Tipo` varchar(10) NOT NULL,
  `Origen` varchar(10) NOT NULL,
  `NumCuenta` int NOT NULL,
  `FechaTransaccion` datetime NOT NULL,
  `Monto` decimal(10,0) NOT NULL,
  `Descripcion` varchar(50) NOT NULL,
  PRIMARY KEY (`IdMovimiento`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `movimientos`
--

INSERT INTO `movimientos` (`IdMovimiento`, `Tipo`, `Origen`, `NumCuenta`, `FechaTransaccion`, `Monto`, `Descripcion`) VALUES
(1, 'DEBITO', 'SUCURSAL', 1, '2021-03-09 15:36:05', '1500', 'RETIRO EFECTIVO SUCURSAL'),
(2, 'DEBITO', 'SUCURSAL', 1, '2020-01-20 15:36:05', '800', 'RETIRO EFECTIVO SUCURSAL'),
(3, 'CREDITO', 'CAJERO', 1, '2021-02-09 15:36:05', '1500', 'RETIRO EFECTIVO CAJERO'),
(4, 'DEBITO', 'CAJERO', 1, '2020-11-09 15:36:05', '750', 'PAGO EFECTIVO SUCURSAL'),
(5, 'CREDITO', 'SUCURSAL', 1, '2020-06-09 15:36:05', '100', 'RETIRO EFECTIVO SUCURSAL'),
(6, 'CREDITO', 'CAJERO', 2, '2021-01-09 15:36:05', '1500', 'RETIRO EFECTIVO CAJERO'),
(7, 'DEBITO', 'CAJERO', 2, '2020-08-09 15:36:05', '200', 'PAGO EFECTIVO SUCURSAL'),
(8, 'DEBITO', 'CAJERO', 2, '2021-01-09 15:36:05', '1300', 'RETIRO EFECTIVO SUCURSAL'),
(9, 'CREDITO', 'SUCURSAL', 2, '2020-10-09 15:36:05', '850', 'PAGO EFECTIVO SUCURSAL'),
(10, 'DEBITO', 'SUCURSAL', 2, '2021-02-09 15:36:05', '1500', 'RETIRO EFECTIVO SUCURSAL'),
(11, 'DEBITO', 'CAJERO', 3, '2020-11-09 15:36:05', '750', 'PAGO EFECTIVO SUCURSAL'),
(12, 'CREDITO', 'SUCURSAL', 3, '2021-02-24 15:36:05', '1000', 'RETIRO EFECTIVO CAJERO'),
(13, 'CREDITO', 'CAJERO', 3, '2021-02-23 15:36:05', '400', 'RETIRO EFECTIVO SUCURSAL'),
(14, 'DEBITO', 'CAJERO', 3, '2020-12-15 15:36:05', '1500', 'PAGO EFECTIVO SUCURSAL'),
(15, 'CREDITO', 'SUCURSAL', 3, '2020-12-22 15:36:05', '1500', 'RETIRO EFECTIVO CAJERO'),
(16, 'CREDITO', 'CAJERO', 4, '2021-03-14 15:36:05', '700', 'RETIRO EFECTIVO SUCURSAL'),
(17, 'DEBITO', 'SUCURSAL', 4, '2021-03-15 15:36:05', '800', 'RETIRO EFECTIVO SUCURSAL'),
(18, 'CREDITO', 'SUCURSAL', 4, '2021-01-24 15:36:05', '1300', 'RETIRO EFECTIVO SUCURSAL'),
(19, 'DEBITO', 'SUCURSAL', 5, '2021-02-13 15:36:05', '600', 'RETIRO EFECTIVO CAJERO'),
(20, 'DEBITO', 'SUCURSAL', 5, '2021-03-01 15:36:05', '800', 'RETIRO EFECTIVO SUCURSAL'),
(21, 'CREDITO', 'SUCURSAL', 5, '2021-02-16 15:36:05', '1500', 'RETIRO EFECTIVO SUCURSAL'),
(22, 'DEBITO', 'CAJERO', 6, '2021-01-14 15:36:05', '400', 'PAGO EFECTIVO CAJERO'),
(23, 'DEBITO', 'SUCURSAL', 6, '2020-12-18 15:36:05', '1500', 'RETIRO EFECTIVO CAJERO'),
(24, 'CREDITO', 'CAJERO', 6, '2020-11-24 15:36:05', '3000', 'RETIRO EFECTIVO SUCURSAL'),
(25, 'DEBITO', 'SUCURSAL', 7, '2021-03-01 15:36:05', '4000', 'PAGO EFECTIVO SUCURSAL'),
(26, 'DEBITO', 'CAJERO', 7, '2020-12-28 15:36:05', '5000', 'RETIRO EFECTIVO SUCURSAL'),
(27, 'CREDITO', 'CAJERO', 7, '2021-02-21 15:36:05', '150', 'PAGO EFECTIVO CAJERO'),
(28, 'DEBITO', 'SUCURSAL', 8, '2020-11-19 15:36:05', '7850', 'RETIRO EFECTIVO SUCURSAL'),
(29, 'DEBITO', 'SUCURSAL', 8, '2021-03-05 15:36:05', '1500', 'RETIRO EFECTIVO CAJERO'),
(30, 'CREDITO', 'CAJERO', 8, '2020-10-15 15:36:05', '380', 'PAGO EFECTIVO SUCURSAL');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `socios`
--

DROP TABLE IF EXISTS `socios`;
CREATE TABLE IF NOT EXISTS `socios` (
  `IdSocio` int NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  `ApellidoPaterno` varchar(50) NOT NULL,
  `ApellidoMaterno` varchar(50) NOT NULL,
  `Tipo` int NOT NULL,
  `Estatus` int NOT NULL,
  `NumeroSucursal` int NOT NULL,
  `CorreoElec` varchar(150) NOT NULL,
  `Telefono` int NOT NULL,
  `TipoMovil` bit(1) NOT NULL,
  `Numero` int NOT NULL,
  `Curp` varchar(16) NOT NULL,
  `Genero` varchar(10) NOT NULL,
  `FechaNacimiento` date NOT NULL,
  `Rfc` varchar(16) NOT NULL,
  `Calle` varchar(30) NOT NULL,
  `Colonia` varchar(30) NOT NULL,
  `NumeroExter` int NOT NULL,
  `Ciudad` varchar(20) NOT NULL,
  `CodigoEstado` int NOT NULL,
  `CodigoPostal` int NOT NULL,
  `Pais` varchar(15) NOT NULL,
  `Ocupacion` varchar(50) NOT NULL,
  PRIMARY KEY (`IdSocio`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `socios`
--

INSERT INTO `socios` (`IdSocio`, `Nombre`, `ApellidoPaterno`, `ApellidoMaterno`, `Tipo`, `Estatus`, `NumeroSucursal`, `CorreoElec`, `Telefono`, `TipoMovil`, `Numero`, `Curp`, `Genero`, `FechaNacimiento`, `Rfc`, `Calle`, `Colonia`, `NumeroExter`, `Ciudad`, `CodigoEstado`, `CodigoPostal`, `Pais`, `Ocupacion`) VALUES
(1, 'Patito', 'Power', 'Aguiñaga', 1, 1, 121, 'patitopow@gmail.com', 477121427, b'1', 477124145, 'PATPOW2342HT0', 'M', '1992-03-08', 'PATPOW23NA', 'Calle pato', 'Lomas del pato', 117, 'Leon', 11, 37000, 'Mexico', 'Periodista'),
(2, 'Conde', 'Patula', 'Aguiñaga', 1, 1, 10, 'conde@gmail.com', 477721827, b'1', 47719855, 'CONPAT2342HT0', 'M', '1985-10-08', 'CONDPAT23NA', 'Lucas', 'Valle de atema', 205, 'Guadalajara', 14, 28540, 'Mexico', 'Carpintero'),
(3, 'Lucas', 'Estrada', 'Perez', 1, 1, 5, 'lucasper@gmail.com', 477797827, b'1', 47719789, 'LUCPER2342GT0', 'M', '1980-07-18', 'LUCPER2342', 'Condesa', 'Real Patula', 88, 'Aguascalientes', 1, 14778, 'Mexico', 'Surtidor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subtipocuenta`
--

DROP TABLE IF EXISTS `subtipocuenta`;
CREATE TABLE IF NOT EXISTS `subtipocuenta` (
  `IdSubtipoCuenta` int NOT NULL,
  `Descripcion` varchar(20) NOT NULL,
  PRIMARY KEY (`IdSubtipoCuenta`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `subtipocuenta`
--

INSERT INTO `subtipocuenta` (`IdSubtipoCuenta`, `Descripcion`) VALUES
(1, 'AHORRO'),
(2, 'PLAZO FIJO'),
(3, 'PRESTAMO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipocuenta`
--

DROP TABLE IF EXISTS `tipocuenta`;
CREATE TABLE IF NOT EXISTS `tipocuenta` (
  `IdTipoCuenta` int NOT NULL,
  `Descripcion` varchar(20) NOT NULL,
  PRIMARY KEY (`IdTipoCuenta`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `tipocuenta`
--

INSERT INTO `tipocuenta` (`IdTipoCuenta`, `Descripcion`) VALUES
(1, 'PRESTAMO'),
(2, 'NEGOCIO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiposocio`
--

DROP TABLE IF EXISTS `tiposocio`;
CREATE TABLE IF NOT EXISTS `tiposocio` (
  `IdTipoSocio` int NOT NULL,
  `Descripcion` varchar(20) NOT NULL,
  PRIMARY KEY (`IdTipoSocio`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `tiposocio`
--

INSERT INTO `tiposocio` (`IdTipoSocio`, `Descripcion`) VALUES
(1, 'SOCIO'),
(2, 'MENOR'),
(3, 'CONYUGE'),
(4, 'AVAL'),
(5, 'NO SOCIO'),
(6, 'PRESOCIO'),
(7, 'APOYO GOBIERNO');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
