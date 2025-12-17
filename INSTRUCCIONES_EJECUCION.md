# Instrucciones para Ejecutar la Aplicación

## Paso 1: Crear las Migraciones de Identity

Antes de ejecutar la aplicación, necesitas crear las tablas de Identity en la base de datos. Abre una terminal (PowerShell o CMD) en la carpeta del proyecto y ejecuta:

```bash
cd "C:\Users\DISTRIBUIDORA HUEVOS\Documents\Actividad-master\Actividad-master"
dotnet ef migrations add InitialIdentityMigration --context ApplicationDbContext
dotnet ef database update --context ApplicationDbContext
```

**Nota:** Si no tienes instalado `dotnet ef`, instálalo primero con:
```bash
dotnet tool install --global dotnet-ef
```

**Importante:** Es necesario especificar `--context ApplicationDbContext` porque el proyecto tiene dos contextos de base de datos:
- `ApplicationDbContext` - Para Identity (tablas AspNet*)
- `AgrosftContext` - Para las tablas de negocio existentes

## Paso 2: Verificar la Conexión a la Base de Datos

Asegúrate de que:
- MySQL/MariaDB esté ejecutándose
- La base de datos `agrosft` exista
- Las credenciales en `appsettings.json` sean correctas:
  ```json
  "ConnectionStrings": {
    "conexion": "server=localhost;user=root;database=agrosft"
  }
  ```

Si tu contraseña de MySQL no está vacía, agrega `password=tu_contraseña` a la cadena de conexión.

## Paso 3: Ejecutar la Aplicación

### Opción A: Desde la Terminal (Recomendado)

```bash
cd "Documents\Actividad-master\Actividad-master"
dotnet run
```

La aplicación se ejecutará en:
- HTTP: `http://localhost:5175`
- HTTPS: `https://localhost:7115`

### Opción B: Desde Visual Studio

1. Abre el archivo `Actividad.sln` en Visual Studio
2. Presiona `F5` o haz clic en el botón "Ejecutar"
3. La aplicación se abrirá automáticamente en tu navegador

### Opción C: Desde Visual Studio Code

1. Abre la carpeta del proyecto en VS Code
2. Presiona `F5` o ve a la pestaña "Run and Debug"
3. Selecciona ".NET Core Launch (web)" y presiona play

## Paso 4: Probar la Aplicación

1. **Al abrir la aplicación**, serás redirigido automáticamente a la página de Login
2. **Registra un nuevo usuario:**
   - Haz clic en "Registrarse" o ve a `/Identity/Account/Register`
   - Completa el formulario con:
     - Correo electrónico
     - Contraseña (mínimo 6 caracteres, con mayúsculas y números)
     - Confirmar contraseña
3. **Inicia sesión** con las credenciales que acabas de crear
4. **Verifica que el menú aparezca** solo después de iniciar sesión
5. **Prueba el cierre de sesión** desde el menú superior derecho

## Solución de Problemas

### Error: "No se puede conectar a la base de datos"
- Verifica que MySQL/MariaDB esté ejecutándose
- Revisa la cadena de conexión en `appsettings.json`
- Asegúrate de que la base de datos `agrosft` exista

### Error: "No se encuentra el comando dotnet ef"
- Instala las herramientas de EF Core:
  ```bash
  dotnet tool install --global dotnet-ef
  ```

### Error: "Ya existe una migración con el nombre..."
- Elimina la carpeta `Migrations` si existe y vuelve a crear la migración
- O usa un nombre diferente: `dotnet ef migrations add NombreMigracion`

### Error al ejecutar: "Unable to create an object of type..."
- Asegúrate de tener la versión correcta de .NET (8.0)
- Verifica que todos los paquetes NuGet estén instalados:
  ```bash
  dotnet restore
  ```

## Estructura de la Base de Datos

Después de ejecutar las migraciones, se crearán las siguientes tablas de Identity:
- `AspNetUsers` - Usuarios del sistema
- `AspNetRoles` - Roles (si los usas)
- `AspNetUserRoles` - Relación usuarios-roles
- `AspNetUserClaims` - Claims de usuarios
- `AspNetUserLogins` - Logins externos
- `AspNetUserTokens` - Tokens de usuarios
- `AspNetRoleClaims` - Claims de roles

¡Listo! Tu aplicación debería estar funcionando correctamente.

