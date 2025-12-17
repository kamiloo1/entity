-- =============================================
-- Script de Base de Datos para AgroSoft
-- Sistema de Gestión Agropecuaria
-- =============================================

-- Crear la base de datos si no existe
CREATE DATABASE IF NOT EXISTS `agrosft` 
DEFAULT CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE `agrosft`;

-- =============================================
-- TABLAS DE NEGOCIO (AgrosftContext)
-- =============================================

-- Tabla: roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(120) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `numero_documento` varchar(50) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `ultimo_login` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `correo` (`correo`),
  UNIQUE KEY `idx_usuarios_numero_documento` (`numero_documento`),
  KEY `idx_usuarios_role` (`role_id`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: cultivos
CREATE TABLE IF NOT EXISTS `cultivos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `tipo` varchar(100) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `area` varchar(100) DEFAULT NULL,
  `estado` varchar(50) NOT NULL DEFAULT 'Activo',
  `fecha_siembra` date DEFAULT NULL,
  `fecha_cosecha` date DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cultivos_nombre` (`nombre`),
  KEY `idx_cultivos_estado` (`estado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: fincas
CREATE TABLE IF NOT EXISTS `fincas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `ubicacion` varchar(255) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: huertas
CREATE TABLE IF NOT EXISTS `huertas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `ubicacion` varchar(255) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `responsable_id` int(11) DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_huertas_responsable` (`responsable_id`),
  CONSTRAINT `huertas_ibfk_1` FOREIGN KEY (`responsable_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: siembras
CREATE TABLE IF NOT EXISTS `siembras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cultivo_id` int(11) NOT NULL,
  `finca_id` int(11) DEFAULT NULL,
  `trabajador_id` int(11) DEFAULT NULL,
  `fecha_siembra` date DEFAULT NULL,
  `area` decimal(10,2) DEFAULT NULL,
  `estado` enum('PLANIFICADA','EN_CURSO','FINALIZADA','CANCELADA') NOT NULL DEFAULT 'PLANIFICADA',
  `observaciones` text DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `cultivo_id` (`cultivo_id`),
  KEY `finca_id` (`finca_id`),
  KEY `trabajador_id` (`trabajador_id`),
  CONSTRAINT `siembras_ibfk_1` FOREIGN KEY (`cultivo_id`) REFERENCES `cultivos` (`id`),
  CONSTRAINT `siembras_ibfk_2` FOREIGN KEY (`finca_id`) REFERENCES `fincas` (`id`) ON DELETE SET NULL,
  CONSTRAINT `siembras_ibfk_3` FOREIGN KEY (`trabajador_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: plagas
CREATE TABLE IF NOT EXISTS `plagas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `severidad` enum('BAJA','MEDIA','ALTA') NOT NULL DEFAULT 'MEDIA',
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: detecciones_plagas
CREATE TABLE IF NOT EXISTS `detecciones_plagas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siembra_id` int(11) DEFAULT NULL,
  `plaga_id` int(11) DEFAULT NULL,
  `reportado_por` int(11) DEFAULT NULL,
  `fecha_reporte` datetime NOT NULL DEFAULT current_timestamp(),
  `caracteristicas` text DEFAULT NULL,
  `acciones_tomadas` text DEFAULT NULL,
  `estado` enum('PENDIENTE','EN_REVISION','RESUELTO') NOT NULL DEFAULT 'PENDIENTE',
  `imagen_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `siembra_id` (`siembra_id`),
  KEY `plaga_id` (`plaga_id`),
  KEY `reportado_por` (`reportado_por`),
  CONSTRAINT `detecciones_plagas_ibfk_1` FOREIGN KEY (`plaga_id`) REFERENCES `plagas` (`id`) ON DELETE SET NULL,
  CONSTRAINT `detecciones_plagas_ibfk_2` FOREIGN KEY (`siembra_id`) REFERENCES `siembras` (`id`) ON DELETE SET NULL,
  CONSTRAINT `detecciones_plagas_ibfk_3` FOREIGN KEY (`reportado_por`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: abonos
CREATE TABLE IF NOT EXISTS `abonos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siembra_id` int(11) DEFAULT NULL,
  `aplicado_por` int(11) DEFAULT NULL,
  `tipo_abono` varchar(120) DEFAULT NULL,
  `cantidad` decimal(10,2) DEFAULT NULL,
  `fecha_programada` date DEFAULT NULL,
  `fecha_aplicacion` date DEFAULT NULL,
  `estado` enum('PROGRAMADO','APLICADO','CANCELADO') NOT NULL DEFAULT 'PROGRAMADO',
  `observaciones` text DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `siembra_id` (`siembra_id`),
  KEY `aplicado_por` (`aplicado_por`),
  CONSTRAINT `abonos_ibfk_1` FOREIGN KEY (`siembra_id`) REFERENCES `siembras` (`id`) ON DELETE SET NULL,
  CONSTRAINT `abonos_ibfk_2` FOREIGN KEY (`aplicado_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: riegos
CREATE TABLE IF NOT EXISTS `riegos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siembra_id` int(11) DEFAULT NULL,
  `realizado_por` int(11) DEFAULT NULL,
  `fecha_programada` date DEFAULT NULL,
  `fecha_realizada` date DEFAULT NULL,
  `cantidad_agua_litros` decimal(12,2) DEFAULT NULL,
  `estado` enum('PROGRAMADO','REALIZADO','SUSPENDIDO') NOT NULL DEFAULT 'PROGRAMADO',
  `observaciones` text DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `siembra_id` (`siembra_id`),
  KEY `realizado_por` (`realizado_por`),
  CONSTRAINT `riegos_ibfk_1` FOREIGN KEY (`siembra_id`) REFERENCES `siembras` (`id`) ON DELETE SET NULL,
  CONSTRAINT `riegos_ibfk_2` FOREIGN KEY (`realizado_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: podas
CREATE TABLE IF NOT EXISTS `podas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siembra_id` int(11) DEFAULT NULL,
  `realizada_por` int(11) DEFAULT NULL,
  `tipo_poda` varchar(120) DEFAULT NULL,
  `fecha_programada` date DEFAULT NULL,
  `fecha_realizada` date DEFAULT NULL,
  `estado` enum('PROGRAMADA','REALIZADA','CANCELADA') NOT NULL DEFAULT 'PROGRAMADA',
  `observaciones` text DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `siembra_id` (`siembra_id`),
  KEY `realizada_por` (`realizada_por`),
  CONSTRAINT `podas_ibfk_1` FOREIGN KEY (`siembra_id`) REFERENCES `siembras` (`id`) ON DELETE SET NULL,
  CONSTRAINT `podas_ibfk_2` FOREIGN KEY (`realizada_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: actividades
CREATE TABLE IF NOT EXISTS `actividades` (
  `id_actividad` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_cultivo` int(11) DEFAULT NULL,
  `tipo_actividad` varchar(150) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_actividad` date DEFAULT NULL,
  `trabajador_responsable` varchar(255) DEFAULT NULL,
  `estado` varchar(50) NOT NULL DEFAULT 'PENDIENTE',
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_actividad`),
  KEY `idx_actividades_cultivo` (`id_cultivo`),
  KEY `idx_actividades_fecha` (`fecha_actividad`),
  CONSTRAINT `actividades_ibfk_1` FOREIGN KEY (`id_cultivo`) REFERENCES `cultivos` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: observaciones_huerta
CREATE TABLE IF NOT EXISTS `observaciones_huerta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `huerta_id` int(11) NOT NULL,
  `registrado_por` int(11) DEFAULT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `comentario` text DEFAULT NULL,
  `fotos_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_observaciones_huerta_id` (`huerta_id`),
  KEY `idx_observaciones_registrado_por` (`registrado_por`),
  CONSTRAINT `observaciones_huerta_ibfk_1` FOREIGN KEY (`huerta_id`) REFERENCES `huertas` (`id`),
  CONSTRAINT `observaciones_huerta_ibfk_2` FOREIGN KEY (`registrado_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: tareas
CREATE TABLE IF NOT EXISTS `tareas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `tipo` enum('ABONO','PODA','RIEGO','PLAGA','SIEMBRA','GENERICA') NOT NULL DEFAULT 'GENERICA',
  `asignado_por` int(11) DEFAULT NULL,
  `asignado_a` int(11) DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_vencimiento` datetime DEFAULT NULL,
  `estado` enum('PENDIENTE','EN_PROGRESO','COMPLETADA','CANCELADA') NOT NULL DEFAULT 'PENDIENTE',
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `asignado_por` (`asignado_por`),
  KEY `asignado_a` (`asignado_a`),
  CONSTRAINT `tareas_ibfk_1` FOREIGN KEY (`asignado_a`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL,
  CONSTRAINT `tareas_ibfk_2` FOREIGN KEY (`asignado_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: ganado
CREATE TABLE IF NOT EXISTS `ganado` (
  `id_ganado` bigint(20) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(80) DEFAULT NULL,
  `raza` varchar(120) DEFAULT NULL,
  `edad` int(11) DEFAULT NULL,
  `peso` decimal(10,2) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `estado_salud` varchar(50) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_ganado`),
  KEY `idx_ganado_tipo` (`tipo`),
  KEY `idx_ganado_estado` (`estado_salud`),
  KEY `idx_ganado_activo` (`activo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: tratamientos
CREATE TABLE IF NOT EXISTS `tratamientos` (
  `id_tratamiento` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_ganado` bigint(20) DEFAULT NULL,
  `tipo_tratamiento` varchar(150) DEFAULT NULL,
  `fecha_tratamiento` date DEFAULT NULL,
  `veterinario_responsable` varchar(255) DEFAULT NULL,
  `costo` decimal(10,2) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_tratamiento`),
  KEY `idx_tratamientos_ganado` (`id_ganado`),
  KEY `idx_tratamientos_fecha` (`fecha_tratamiento`),
  CONSTRAINT `tratamientos_ibfk_1` FOREIGN KEY (`id_ganado`) REFERENCES `ganado` (`id_ganado`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: animales
CREATE TABLE IF NOT EXISTS `animales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_identificacion` varchar(80) NOT NULL,
  `tipo_animal` varchar(80) DEFAULT NULL,
  `raza` varchar(120) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `estado_salud` enum('SALUDABLE','EN_TRATAMIENTO','BAJA') NOT NULL DEFAULT 'SALUDABLE',
  `responsable_id` int(11) DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo_identificacion` (`codigo_identificacion`),
  KEY `responsable_id` (`responsable_id`),
  CONSTRAINT `animales_ibfk_1` FOREIGN KEY (`responsable_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: historial_medico
CREATE TABLE IF NOT EXISTS `historial_medico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `animal_id` int(11) NOT NULL,
  `veterinario_id` int(11) DEFAULT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `tratamiento` text DEFAULT NULL,
  `dosis` varchar(100) DEFAULT NULL,
  `vacunado` tinyint(1) NOT NULL DEFAULT 0,
  `descripcion` text DEFAULT NULL,
  `proxima_visita` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `animal_id` (`animal_id`),
  KEY `veterinario_id` (`veterinario_id`),
  CONSTRAINT `historial_medico_ibfk_1` FOREIGN KEY (`animal_id`) REFERENCES `animales` (`id`),
  CONSTRAINT `historial_medico_ibfk_2` FOREIGN KEY (`veterinario_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: paciente
CREATE TABLE IF NOT EXISTS `paciente` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) DEFAULT NULL,
  `especie` varchar(100) DEFAULT NULL,
  `raza` varchar(120) DEFAULT NULL,
  `edad` varchar(50) DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- TABLAS DE IDENTITY (ASP.NET Core Identity)
-- =============================================
-- Estas tablas se crean automáticamente con las migraciones de Entity Framework
-- pero se incluyen aquí para referencia completa

-- Tabla: AspNetUsers
CREATE TABLE IF NOT EXISTS `AspNetUsers` (
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
  `AccessFailedCount` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UserNameIndex` (`NormalizedUserName`),
  KEY `EmailIndex` (`NormalizedEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: AspNetRoles
CREATE TABLE IF NOT EXISTS `AspNetRoles` (
  `Id` varchar(255) NOT NULL,
  `Name` varchar(256) DEFAULT NULL,
  `NormalizedName` varchar(256) DEFAULT NULL,
  `ConcurrencyStamp` longtext DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `RoleNameIndex` (`NormalizedName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: AspNetUserRoles
CREATE TABLE IF NOT EXISTS `AspNetUserRoles` (
  `UserId` varchar(255) NOT NULL,
  `RoleId` varchar(255) NOT NULL,
  PRIMARY KEY (`UserId`, `RoleId`),
  KEY `IX_AspNetUserRoles_RoleId` (`RoleId`),
  CONSTRAINT `FK_AspNetUserRoles_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `AspNetRoles` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_AspNetUserRoles_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: AspNetUserClaims
CREATE TABLE IF NOT EXISTS `AspNetUserClaims` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` varchar(255) NOT NULL,
  `ClaimType` longtext DEFAULT NULL,
  `ClaimValue` longtext DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_AspNetUserClaims_UserId` (`UserId`),
  CONSTRAINT `FK_AspNetUserClaims_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: AspNetUserLogins
CREATE TABLE IF NOT EXISTS `AspNetUserLogins` (
  `LoginProvider` varchar(128) NOT NULL,
  `ProviderKey` varchar(128) NOT NULL,
  `ProviderDisplayName` longtext DEFAULT NULL,
  `UserId` varchar(255) NOT NULL,
  PRIMARY KEY (`LoginProvider`, `ProviderKey`),
  KEY `IX_AspNetUserLogins_UserId` (`UserId`),
  CONSTRAINT `FK_AspNetUserLogins_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: AspNetUserTokens
CREATE TABLE IF NOT EXISTS `AspNetUserTokens` (
  `UserId` varchar(255) NOT NULL,
  `LoginProvider` varchar(128) NOT NULL,
  `Name` varchar(128) NOT NULL,
  `Value` longtext DEFAULT NULL,
  PRIMARY KEY (`UserId`, `LoginProvider`, `Name`),
  CONSTRAINT `FK_AspNetUserTokens_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: AspNetRoleClaims
CREATE TABLE IF NOT EXISTS `AspNetRoleClaims` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `RoleId` varchar(255) NOT NULL,
  `ClaimType` longtext DEFAULT NULL,
  `ClaimValue` longtext DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_AspNetRoleClaims_RoleId` (`RoleId`),
  CONSTRAINT `FK_AspNetRoleClaims_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `AspNetRoles` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: __EFMigrationsHistory (para Entity Framework)
CREATE TABLE IF NOT EXISTS `__EFMigrationsHistory` (
  `MigrationId` varchar(150) NOT NULL,
  `ProductVersion` varchar(32) NOT NULL,
  PRIMARY KEY (`MigrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- DATOS INICIALES (Opcional)
-- =============================================

-- Insertar algunos roles básicos
INSERT IGNORE INTO `roles` (`id`, `nombre`, `descripcion`) VALUES
(1, 'Administrador', 'Rol con acceso completo al sistema'),
(2, 'Usuario', 'Rol de usuario estándar'),
(3, 'Trabajador', 'Rol para trabajadores de campo');

-- =============================================
-- FIN DEL SCRIPT
-- =============================================

