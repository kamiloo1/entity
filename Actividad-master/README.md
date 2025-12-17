# 🌾 Entity - Sistema de Gestión Agropecuaria

Sistema web desarrollado con ASP.NET Core 8.0 y ASP.NET Core Identity para la gestión de cultivos, huertas, siembras y más.

## 🚀 Características

- ✅ Autenticación y autorización con ASP.NET Core Identity
- ✅ Gestión de Cultivos
- ✅ Gestión de Huertas
- ✅ Gestión de Siembras
- ✅ Gestión de Usuarios y Roles
- ✅ Interfaz moderna con temática agrícola
- ✅ Base de datos MySQL/MariaDB

## 📋 Requisitos

- Visual Studio 2022 o superior
- .NET 8.0 SDK
- MySQL/MariaDB 10.4+
- Windows 10/11 o Windows Server 2016+

## 🛠️ Instalación

1. Clona el repositorio:
```bash
git clone https://github.com/TU_USUARIO/entity.git
cd entity
```

2. Restaura los paquetes NuGet:
```bash
dotnet restore
```

3. Configura la base de datos:
   - Ejecuta el script `database_agrosft.sql` en MySQL
   - Actualiza la cadena de conexión en `appsettings.json`

4. Ejecuta la aplicación:
```bash
dotnet run
```

O abre `Actividad.sln` en Visual Studio 2022 y presiona F5.

## 📚 Documentación

- `INSTRUCCIONES_VISUAL_STUDIO_2022.md` - Guía completa para Visual Studio 2022
- `ENTREGA_IDENTITY.md` - Documentación de la implementación de Identity
- `COMO_PROBAR_IDENTITY.md` - Guía de pruebas
- `database_agrosft.sql` - Script de base de datos

## 🗄️ Base de Datos

El proyecto utiliza MySQL/MariaDB. Ejecuta el script `database_agrosft.sql` para crear todas las tablas necesarias.

## 🔐 Autenticación

El sistema incluye:
- Registro de usuarios
- Inicio de sesión
- Cierre de sesión
- Protección de rutas con `[Authorize]`
- Menú dinámico según estado de autenticación

## 📝 Estructura del Proyecto

```
entity/
├── Areas/
│   └── Identity/          # Páginas de Identity
├── Controllers/           # Controladores MVC
├── Models/               # Modelos de datos
├── Views/                # Vistas Razor
├── wwwroot/              # Archivos estáticos
├── Program.cs            # Configuración de la aplicación
└── appsettings.json      # Configuración
```

## 🧪 Pruebas

Para probar la aplicación:

1. Ejecuta la aplicación
2. Accede a `http://localhost:5175`
3. Registra un nuevo usuario
4. Inicia sesión
5. Explora las diferentes secciones

## 📄 Licencia

Este proyecto es parte de una actividad académica.

## 👤 Autor

Desarrollado como parte de la formación en ASP.NET Core Identity.

---

**Desarrollado con ❤️ usando ASP.NET Core**

