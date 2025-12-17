-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-12-2025 a las 00:43:20
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
-- Base de datos: `agrosft`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `abonos`
--

CREATE TABLE `abonos` (
  `id` int(11) NOT NULL,
  `siembra_id` int(11) DEFAULT NULL,
  `aplicado_por` int(11) DEFAULT NULL,
  `tipo_abono` varchar(120) DEFAULT NULL,
  `cantidad` decimal(10,2) DEFAULT NULL,
  `fecha_programada` date DEFAULT NULL,
  `fecha_aplicacion` date DEFAULT NULL,
  `estado` enum('PROGRAMADO','APLICADO','CANCELADO') NOT NULL DEFAULT 'PROGRAMADO',
  `observaciones` text DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividades`
--

CREATE TABLE `actividades` (
  `id_actividad` bigint(20) NOT NULL,
  `id_cultivo` int(11) DEFAULT NULL,
  `tipo_actividad` varchar(150) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_actividad` date DEFAULT NULL,
  `trabajador_responsable` varchar(255) DEFAULT NULL,
  `estado` varchar(50) NOT NULL DEFAULT 'PENDIENTE',
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `animales`
--

CREATE TABLE `animales` (
  `id` int(11) NOT NULL,
  `codigo_identificacion` varchar(80) NOT NULL,
  `tipo_animal` varchar(80) DEFAULT NULL,
  `raza` varchar(120) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `estado_salud` enum('SALUDABLE','EN_TRATAMIENTO','BAJA') NOT NULL DEFAULT 'SALUDABLE',
  `responsable_id` int(11) DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aspnetroleclaims`
--

CREATE TABLE `aspnetroleclaims` (
  `Id` int(11) NOT NULL,
  `RoleId` varchar(255) NOT NULL,
  `ClaimType` longtext DEFAULT NULL,
  `ClaimValue` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aspnetroles`
--

CREATE TABLE `aspnetroles` (
  `Id` varchar(255) NOT NULL,
  `Name` varchar(256) DEFAULT NULL,
  `NormalizedName` varchar(256) DEFAULT NULL,
  `ConcurrencyStamp` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aspnetuserclaims`
--

CREATE TABLE `aspnetuserclaims` (
  `Id` int(11) NOT NULL,
  `UserId` varchar(255) NOT NULL,
  `ClaimType` longtext DEFAULT NULL,
  `ClaimValue` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aspnetuserlogins`
--

CREATE TABLE `aspnetuserlogins` (
  `LoginProvider` varchar(128) NOT NULL,
  `ProviderKey` varchar(128) NOT NULL,
  `ProviderDisplayName` longtext DEFAULT NULL,
  `UserId` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aspnetuserroles`
--

CREATE TABLE `aspnetuserroles` (
  `UserId` varchar(255) NOT NULL,
  `RoleId` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aspnetusers`
--

CREATE TABLE `aspnetusers` (
  `Id` varchar(255) NOT NULL,
  `UserName` varchar(256) DEFAULT NULL,
  `NormalizedUserName` varchar(256) DEFAULT NULL,
  `Email` varchar(256) DEFAULT NULL,
  `NormalizedEmail` varchar(256) DEFAULT NULL,
  `EmailConfirmed` tinyint(1) NOT NULL DEFAULT 0,
  `PasswordHash` longtext DEFAULT NULL,
  `SecurityStamp` longtext DEFAULT NULL,
  `ConcurrencyStamp` longtext DEFAULT NULL,
  `PhoneNumber` longtext DEFAULT NULL,
  `PhoneNumberConfirmed` tinyint(1) NOT NULL DEFAULT 0,
  `TwoFactorEnabled` tinyint(1) NOT NULL DEFAULT 0,
  `LockoutEnd` datetime(6) DEFAULT NULL,
  `LockoutEnabled` tinyint(1) NOT NULL DEFAULT 0,
  `AccessFailedCount` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aspnetusertokens`
--

CREATE TABLE `aspnetusertokens` (
  `UserId` varchar(255) NOT NULL,
  `LoginProvider` varchar(128) NOT NULL,
  `Name` varchar(128) NOT NULL,
  `Value` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cultivos`
--

CREATE TABLE `cultivos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `tipo` varchar(100) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `area` varchar(100) DEFAULT NULL,
  `estado` varchar(50) NOT NULL DEFAULT 'Activo',
  `fecha_siembra` date DEFAULT NULL,
  `fecha_cosecha` date DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detecciones_plagas`
--

CREATE TABLE `detecciones_plagas` (
  `id` int(11) NOT NULL,
  `siembra_id` int(11) DEFAULT NULL,
  `plaga_id` int(11) DEFAULT NULL,
  `reportado_por` int(11) DEFAULT NULL,
  `fecha_reporte` datetime NOT NULL DEFAULT current_timestamp(),
  `caracteristicas` text DEFAULT NULL,
  `acciones_tomadas` text DEFAULT NULL,
  `estado` enum('PENDIENTE','EN_REVISION','RESUELTO') NOT NULL DEFAULT 'PENDIENTE',
  `imagen_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fincas`
--

CREATE TABLE `fincas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `ubicacion` varchar(255) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ganado`
--

CREATE TABLE `ganado` (
  `id_ganado` bigint(20) NOT NULL,
  `tipo` varchar(80) DEFAULT NULL,
  `raza` varchar(120) DEFAULT NULL,
  `edad` int(11) DEFAULT NULL,
  `peso` decimal(10,2) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `estado_salud` varchar(50) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_medico`
--

CREATE TABLE `historial_medico` (
  `id` int(11) NOT NULL,
  `animal_id` int(11) NOT NULL,
  `veterinario_id` int(11) DEFAULT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `tratamiento` text DEFAULT NULL,
  `dosis` varchar(100) DEFAULT NULL,
  `vacunado` tinyint(1) NOT NULL DEFAULT 0,
  `descripcion` text DEFAULT NULL,
  `proxima_visita` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `huertas`
--

CREATE TABLE `huertas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `ubicacion` varchar(255) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `responsable_id` int(11) DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `observaciones_huerta`
--

CREATE TABLE `observaciones_huerta` (
  `id` int(11) NOT NULL,
  `huerta_id` int(11) NOT NULL,
  `registrado_por` int(11) DEFAULT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `comentario` text DEFAULT NULL,
  `fotos_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paciente`
--

CREATE TABLE `paciente` (
  `id` bigint(20) NOT NULL,
  `nombre` varchar(150) DEFAULT NULL,
  `especie` varchar(100) DEFAULT NULL,
  `raza` varchar(120) DEFAULT NULL,
  `edad` varchar(50) DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plagas`
--

CREATE TABLE `plagas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `severidad` enum('BAJA','MEDIA','ALTA') NOT NULL DEFAULT 'MEDIA',
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `podas`
--

CREATE TABLE `podas` (
  `id` int(11) NOT NULL,
  `siembra_id` int(11) DEFAULT NULL,
  `realizada_por` int(11) DEFAULT NULL,
  `tipo_poda` varchar(120) DEFAULT NULL,
  `fecha_programada` date DEFAULT NULL,
  `fecha_realizada` date DEFAULT NULL,
  `estado` enum('PROGRAMADA','REALIZADA','CANCELADA') NOT NULL DEFAULT 'PROGRAMADA',
  `observaciones` text DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `riegos`
--

CREATE TABLE `riegos` (
  `id` int(11) NOT NULL,
  `siembra_id` int(11) DEFAULT NULL,
  `realizado_por` int(11) DEFAULT NULL,
  `fecha_programada` date DEFAULT NULL,
  `fecha_realizada` date DEFAULT NULL,
  `cantidad_agua_litros` decimal(12,2) DEFAULT NULL,
  `estado` enum('PROGRAMADO','REALIZADO','SUSPENDIDO') NOT NULL DEFAULT 'PROGRAMADO',
  `observaciones` text DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `nombre`, `descripcion`, `creado_en`) VALUES
(1, 'Administrador', 'Rol con acceso completo al sistema', '2025-12-17 23:43:15'),
(2, 'Usuario', 'Rol de usuario estándar', '2025-12-17 23:43:15'),
(3, 'Trabajador', 'Rol para trabajadores de campo', '2025-12-17 23:43:15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `siembras`
--

CREATE TABLE `siembras` (
  `id` int(11) NOT NULL,
  `cultivo_id` int(11) NOT NULL,
  `finca_id` int(11) DEFAULT NULL,
  `trabajador_id` int(11) DEFAULT NULL,
  `fecha_siembra` date DEFAULT NULL,
  `area` decimal(10,2) DEFAULT NULL,
  `estado` enum('PLANIFICADA','EN_CURSO','FINALIZADA','CANCELADA') NOT NULL DEFAULT 'PLANIFICADA',
  `observaciones` text DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tareas`
--

CREATE TABLE `tareas` (
  `id` int(11) NOT NULL,
  `titulo` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `tipo` enum('ABONO','PODA','RIEGO','PLAGA','SIEMBRA','GENERICA') NOT NULL DEFAULT 'GENERICA',
  `asignado_por` int(11) DEFAULT NULL,
  `asignado_a` int(11) DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_vencimiento` datetime DEFAULT NULL,
  `estado` enum('PENDIENTE','EN_PROGRESO','COMPLETADA','CANCELADA') NOT NULL DEFAULT 'PENDIENTE',
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tratamientos`
--

CREATE TABLE `tratamientos` (
  `id_tratamiento` bigint(20) NOT NULL,
  `id_ganado` bigint(20) DEFAULT NULL,
  `tipo_tratamiento` varchar(150) DEFAULT NULL,
  `fecha_tratamiento` date DEFAULT NULL,
  `veterinario_responsable` varchar(255) DEFAULT NULL,
  `costo` decimal(10,2) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(120) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `numero_documento` varchar(50) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `ultimo_login` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `__efmigrationshistory`
--

CREATE TABLE `__efmigrationshistory` (
  `MigrationId` varchar(150) NOT NULL,
  `ProductVersion` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `abonos`
--
ALTER TABLE `abonos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `siembra_id` (`siembra_id`),
  ADD KEY `aplicado_por` (`aplicado_por`);

--
-- Indices de la tabla `actividades`
--
ALTER TABLE `actividades`
  ADD PRIMARY KEY (`id_actividad`),
  ADD KEY `idx_actividades_cultivo` (`id_cultivo`),
  ADD KEY `idx_actividades_fecha` (`fecha_actividad`);

--
-- Indices de la tabla `animales`
--
ALTER TABLE `animales`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codigo_identificacion` (`codigo_identificacion`),
  ADD KEY `responsable_id` (`responsable_id`);

--
-- Indices de la tabla `aspnetroleclaims`
--
ALTER TABLE `aspnetroleclaims`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `IX_AspNetRoleClaims_RoleId` (`RoleId`);

--
-- Indices de la tabla `aspnetroles`
--
ALTER TABLE `aspnetroles`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `RoleNameIndex` (`NormalizedName`);

--
-- Indices de la tabla `aspnetuserclaims`
--
ALTER TABLE `aspnetuserclaims`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `IX_AspNetUserClaims_UserId` (`UserId`);

--
-- Indices de la tabla `aspnetuserlogins`
--
ALTER TABLE `aspnetuserlogins`
  ADD PRIMARY KEY (`LoginProvider`,`ProviderKey`),
  ADD KEY `IX_AspNetUserLogins_UserId` (`UserId`);

--
-- Indices de la tabla `aspnetuserroles`
--
ALTER TABLE `aspnetuserroles`
  ADD PRIMARY KEY (`UserId`,`RoleId`),
  ADD KEY `IX_AspNetUserRoles_RoleId` (`RoleId`);

--
-- Indices de la tabla `aspnetusers`
--
ALTER TABLE `aspnetusers`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `UserNameIndex` (`NormalizedUserName`),
  ADD KEY `EmailIndex` (`NormalizedEmail`);

--
-- Indices de la tabla `aspnetusertokens`
--
ALTER TABLE `aspnetusertokens`
  ADD PRIMARY KEY (`UserId`,`LoginProvider`,`Name`);

--
-- Indices de la tabla `cultivos`
--
ALTER TABLE `cultivos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cultivos_nombre` (`nombre`),
  ADD KEY `idx_cultivos_estado` (`estado`);

--
-- Indices de la tabla `detecciones_plagas`
--
ALTER TABLE `detecciones_plagas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `siembra_id` (`siembra_id`),
  ADD KEY `plaga_id` (`plaga_id`),
  ADD KEY `reportado_por` (`reportado_por`);

--
-- Indices de la tabla `fincas`
--
ALTER TABLE `fincas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ganado`
--
ALTER TABLE `ganado`
  ADD PRIMARY KEY (`id_ganado`),
  ADD KEY `idx_ganado_tipo` (`tipo`),
  ADD KEY `idx_ganado_estado` (`estado_salud`),
  ADD KEY `idx_ganado_activo` (`activo`);

--
-- Indices de la tabla `historial_medico`
--
ALTER TABLE `historial_medico`
  ADD PRIMARY KEY (`id`),
  ADD KEY `animal_id` (`animal_id`),
  ADD KEY `veterinario_id` (`veterinario_id`);

--
-- Indices de la tabla `huertas`
--
ALTER TABLE `huertas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_huertas_responsable` (`responsable_id`);

--
-- Indices de la tabla `observaciones_huerta`
--
ALTER TABLE `observaciones_huerta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_observaciones_huerta_id` (`huerta_id`),
  ADD KEY `idx_observaciones_registrado_por` (`registrado_por`);

--
-- Indices de la tabla `paciente`
--
ALTER TABLE `paciente`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `plagas`
--
ALTER TABLE `plagas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `podas`
--
ALTER TABLE `podas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `siembra_id` (`siembra_id`),
  ADD KEY `realizada_por` (`realizada_por`);

--
-- Indices de la tabla `riegos`
--
ALTER TABLE `riegos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `siembra_id` (`siembra_id`),
  ADD KEY `realizado_por` (`realizado_por`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `siembras`
--
ALTER TABLE `siembras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cultivo_id` (`cultivo_id`),
  ADD KEY `finca_id` (`finca_id`),
  ADD KEY `trabajador_id` (`trabajador_id`);

--
-- Indices de la tabla `tareas`
--
ALTER TABLE `tareas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `asignado_por` (`asignado_por`),
  ADD KEY `asignado_a` (`asignado_a`);

--
-- Indices de la tabla `tratamientos`
--
ALTER TABLE `tratamientos`
  ADD PRIMARY KEY (`id_tratamiento`),
  ADD KEY `idx_tratamientos_ganado` (`id_ganado`),
  ADD KEY `idx_tratamientos_fecha` (`fecha_tratamiento`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD UNIQUE KEY `idx_usuarios_numero_documento` (`numero_documento`),
  ADD KEY `idx_usuarios_role` (`role_id`);

--
-- Indices de la tabla `__efmigrationshistory`
--
ALTER TABLE `__efmigrationshistory`
  ADD PRIMARY KEY (`MigrationId`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `abonos`
--
ALTER TABLE `abonos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `actividades`
--
ALTER TABLE `actividades`
  MODIFY `id_actividad` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `animales`
--
ALTER TABLE `animales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `aspnetroleclaims`
--
ALTER TABLE `aspnetroleclaims`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `aspnetuserclaims`
--
ALTER TABLE `aspnetuserclaims`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cultivos`
--
ALTER TABLE `cultivos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detecciones_plagas`
--
ALTER TABLE `detecciones_plagas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `fincas`
--
ALTER TABLE `fincas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ganado`
--
ALTER TABLE `ganado`
  MODIFY `id_ganado` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `historial_medico`
--
ALTER TABLE `historial_medico`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `huertas`
--
ALTER TABLE `huertas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `observaciones_huerta`
--
ALTER TABLE `observaciones_huerta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `paciente`
--
ALTER TABLE `paciente`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `plagas`
--
ALTER TABLE `plagas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `podas`
--
ALTER TABLE `podas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `riegos`
--
ALTER TABLE `riegos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `siembras`
--
ALTER TABLE `siembras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tareas`
--
ALTER TABLE `tareas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tratamientos`
--
ALTER TABLE `tratamientos`
  MODIFY `id_tratamiento` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `abonos`
--
ALTER TABLE `abonos`
  ADD CONSTRAINT `abonos_ibfk_1` FOREIGN KEY (`siembra_id`) REFERENCES `siembras` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `abonos_ibfk_2` FOREIGN KEY (`aplicado_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `actividades`
--
ALTER TABLE `actividades`
  ADD CONSTRAINT `actividades_ibfk_1` FOREIGN KEY (`id_cultivo`) REFERENCES `cultivos` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `animales`
--
ALTER TABLE `animales`
  ADD CONSTRAINT `animales_ibfk_1` FOREIGN KEY (`responsable_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `aspnetroleclaims`
--
ALTER TABLE `aspnetroleclaims`
  ADD CONSTRAINT `FK_AspNetRoleClaims_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `aspnetroles` (`Id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `aspnetuserclaims`
--
ALTER TABLE `aspnetuserclaims`
  ADD CONSTRAINT `FK_AspNetUserClaims_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `aspnetuserlogins`
--
ALTER TABLE `aspnetuserlogins`
  ADD CONSTRAINT `FK_AspNetUserLogins_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `aspnetuserroles`
--
ALTER TABLE `aspnetuserroles`
  ADD CONSTRAINT `FK_AspNetUserRoles_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `aspnetroles` (`Id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_AspNetUserRoles_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `aspnetusertokens`
--
ALTER TABLE `aspnetusertokens`
  ADD CONSTRAINT `FK_AspNetUserTokens_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `detecciones_plagas`
--
ALTER TABLE `detecciones_plagas`
  ADD CONSTRAINT `detecciones_plagas_ibfk_1` FOREIGN KEY (`plaga_id`) REFERENCES `plagas` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `detecciones_plagas_ibfk_2` FOREIGN KEY (`siembra_id`) REFERENCES `siembras` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `detecciones_plagas_ibfk_3` FOREIGN KEY (`reportado_por`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `historial_medico`
--
ALTER TABLE `historial_medico`
  ADD CONSTRAINT `historial_medico_ibfk_1` FOREIGN KEY (`animal_id`) REFERENCES `animales` (`id`),
  ADD CONSTRAINT `historial_medico_ibfk_2` FOREIGN KEY (`veterinario_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `huertas`
--
ALTER TABLE `huertas`
  ADD CONSTRAINT `huertas_ibfk_1` FOREIGN KEY (`responsable_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `observaciones_huerta`
--
ALTER TABLE `observaciones_huerta`
  ADD CONSTRAINT `observaciones_huerta_ibfk_1` FOREIGN KEY (`huerta_id`) REFERENCES `huertas` (`id`),
  ADD CONSTRAINT `observaciones_huerta_ibfk_2` FOREIGN KEY (`registrado_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `podas`
--
ALTER TABLE `podas`
  ADD CONSTRAINT `podas_ibfk_1` FOREIGN KEY (`siembra_id`) REFERENCES `siembras` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `podas_ibfk_2` FOREIGN KEY (`realizada_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `riegos`
--
ALTER TABLE `riegos`
  ADD CONSTRAINT `riegos_ibfk_1` FOREIGN KEY (`siembra_id`) REFERENCES `siembras` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `riegos_ibfk_2` FOREIGN KEY (`realizado_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `siembras`
--
ALTER TABLE `siembras`
  ADD CONSTRAINT `siembras_ibfk_1` FOREIGN KEY (`cultivo_id`) REFERENCES `cultivos` (`id`),
  ADD CONSTRAINT `siembras_ibfk_2` FOREIGN KEY (`finca_id`) REFERENCES `fincas` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `siembras_ibfk_3` FOREIGN KEY (`trabajador_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `tareas`
--
ALTER TABLE `tareas`
  ADD CONSTRAINT `tareas_ibfk_1` FOREIGN KEY (`asignado_a`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `tareas_ibfk_2` FOREIGN KEY (`asignado_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `tratamientos`
--
ALTER TABLE `tratamientos`
  ADD CONSTRAINT `tratamientos_ibfk_1` FOREIGN KEY (`id_ganado`) REFERENCES `ganado` (`id_ganado`) ON DELETE SET NULL;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
