# 🚀 Instrucciones para Ejecutar en Visual Studio 2022

## ✅ Requisitos Previos

Antes de abrir el proyecto en Visual Studio 2022, asegúrate de tener instalado:

1. **Visual Studio 2022** (versión 17.0 o superior)
   - Descarga desde: https://visualstudio.microsoft.com/es/downloads/
   - Asegúrate de instalar la carga de trabajo "Desarrollo de ASP.NET y web"

2. **.NET 8.0 SDK**
   - El proyecto usa .NET 8.0
   - Descarga desde: https://dotnet.microsoft.com/download/dotnet/8.0
   - Verifica la instalación: `dotnet --version` (debe mostrar 8.0.x)

3. **MySQL/MariaDB**
   - El proyecto usa MySQL/MariaDB como base de datos
   - Asegúrate de tener MySQL o MariaDB instalado y ejecutándose

4. **SQL Server Management Studio o MySQL Workbench** (opcional)
   - Para gestionar la base de datos

## 📂 Abrir el Proyecto en Visual Studio 2022

### Opción 1: Abrir desde el Explorador de Archivos
1. Navega a la carpeta del proyecto: `Actividad-master\Actividad-master`
2. Haz doble clic en el archivo `Actividad.sln`
3. Visual Studio 2022 se abrirá automáticamente

### Opción 2: Abrir desde Visual Studio 2022
1. Abre Visual Studio 2022
2. Ve a `Archivo` → `Abrir` → `Proyecto o solución`
3. Navega a la carpeta `Actividad-master\Actividad-master`
4. Selecciona `Actividad.sln` y haz clic en `Abrir`

## 🗄️ Configurar la Base de Datos

### Paso 1: Crear la Base de Datos

**Opción A: Usando el Script SQL (Recomendado)**
1. Abre MySQL Workbench o tu cliente MySQL favorito
2. Conéctate a tu servidor MySQL
3. Abre el archivo `database_agrosft.sql` desde el proyecto
4. Ejecuta todo el script (F9 o botón "Execute")
5. Verifica que se haya creado la base de datos `agrosft`

**Opción B: Usando Migraciones de Entity Framework**
1. Abre la **Consola del Administrador de Paquetes** en Visual Studio:
   - `Herramientas` → `Administrador de paquetes NuGet` → `Consola del Administrador de Paquetes`
2. Ejecuta estos comandos:
   ```powershell
   # Instalar dotnet-ef si no está instalado
   dotnet tool install --global dotnet-ef
   
   # Crear migración para Identity
   dotnet ef migrations add InitialIdentityMigration --context ApplicationDbContext
   
   # Aplicar migración a la base de datos
   dotnet ef database update --context ApplicationDbContext
   ```

### Paso 2: Configurar la Cadena de Conexión

1. En Visual Studio 2022, abre `appsettings.json`
2. Verifica o actualiza la cadena de conexión:
   ```json
   {
     "ConnectionStrings": {
       "conexion": "server=localhost;user=root;password=TU_CONTRASEÑA;database=agrosft"
     }
   }
   ```
3. Si tu MySQL no tiene contraseña, usa:
   ```json
   {
     "ConnectionStrings": {
       "conexion": "server=localhost;user=root;database=agrosft"
     }
   }
   ```

## 🔧 Restaurar Paquetes NuGet

1. Haz clic derecho en la solución `Actividad` en el **Explorador de soluciones**
2. Selecciona `Restaurar paquetes NuGet`
3. O ejecuta desde la **Consola del Administrador de Paquetes**:
   ```powershell
   Update-Package -reinstall
   ```

## ▶️ Ejecutar la Aplicación

### Opción 1: Ejecutar con IIS Express (Recomendado)
1. En Visual Studio 2022, asegúrate de que el perfil de inicio sea **"IIS Express"** o **"https"**
2. Presiona **F5** o haz clic en el botón verde **"Ejecutar"**
3. La aplicación se abrirá automáticamente en tu navegador predeterminado

### Opción 2: Ejecutar con Kestrel
1. Selecciona el perfil **"http"** o **"https"** en la barra de herramientas
2. Presiona **F5** o haz clic en **"Ejecutar"**

### Opción 3: Ejecutar sin depuración
1. Presiona **Ctrl + F5**
2. La aplicación se ejecutará sin el depurador adjunto

## 🌐 URLs de Acceso

Después de ejecutar la aplicación, puedes acceder a:

- **HTTP**: `http://localhost:5175`
- **HTTPS**: `https://localhost:7115`
- **IIS Express**: `http://localhost:47270` o `https://localhost:44372`

## 🐛 Solución de Problemas Comunes

### Error: "No se puede conectar a la base de datos"
**Solución:**
1. Verifica que MySQL/MariaDB esté ejecutándose
2. Verifica la cadena de conexión en `appsettings.json`
3. Asegúrate de que la base de datos `agrosft` exista
4. Verifica que el usuario tenga permisos para acceder a la base de datos

### Error: "No se encuentra el SDK de .NET 8.0"
**Solución:**
1. Descarga e instala .NET 8.0 SDK desde: https://dotnet.microsoft.com/download/dotnet/8.0
2. Reinicia Visual Studio 2022
3. Verifica la instalación: `dotnet --version` en la terminal

### Error: "Los paquetes NuGet no se restauran"
**Solución:**
1. Ve a `Herramientas` → `Opciones` → `Administrador de paquetes NuGet` → `Orígenes de paquetes`
2. Asegúrate de que `nuget.org` esté habilitado
3. Haz clic derecho en la solución → `Restaurar paquetes NuGet`
4. O ejecuta: `dotnet restore` en la terminal

### Error: "No se puede iniciar IIS Express"
**Solución:**
1. Cierra todas las instancias de IIS Express
2. Reinicia Visual Studio 2022
3. Verifica que el puerto no esté en uso (cambia el puerto en `launchSettings.json` si es necesario)

### Error: "Las migraciones no se aplican"
**Solución:**
1. Asegúrate de tener `dotnet-ef` instalado:
   ```powershell
   dotnet tool install --global dotnet-ef
   ```
2. Verifica que la cadena de conexión sea correcta
3. Ejecuta las migraciones manualmente desde la Consola del Administrador de Paquetes

## 📋 Checklist de Verificación

Antes de ejecutar, verifica:

- [ ] Visual Studio 2022 está instalado (versión 17.0+)
- [ ] .NET 8.0 SDK está instalado
- [ ] MySQL/MariaDB está ejecutándose
- [ ] La base de datos `agrosft` existe
- [ ] La cadena de conexión en `appsettings.json` es correcta
- [ ] Los paquetes NuGet están restaurados
- [ ] El proyecto compila sin errores

## 🎯 Configuración Recomendada para Visual Studio 2022

### Extensiones Útiles (Opcional)
- **Entity Framework Core Power Tools** - Para visualizar el modelo de datos
- **GitHub Extension for Visual Studio** - Si usas Git
- **Productivity Power Tools** - Mejoras de productividad

### Configuración del Proyecto
1. **Configuración de Compilación:**
   - Debug: Para desarrollo
   - Release: Para producción

2. **Perfiles de Inicio:**
   - IIS Express: Para desarrollo local
   - Kestrel: Para pruebas de rendimiento

## 📝 Notas Importantes

1. **Primera Ejecución:**
   - La primera vez que ejecutes el proyecto, Visual Studio puede tardar más tiempo
   - Esto es normal, está compilando y restaurando dependencias

2. **Certificado SSL:**
   - La primera vez que uses HTTPS, Visual Studio puede pedirte confiar en el certificado de desarrollo
   - Acepta el certificado para evitar advertencias en el navegador

3. **Puertos:**
   - Si los puertos están en uso, Visual Studio te preguntará si quieres cambiar el puerto
   - Acepta el cambio o detén el proceso que está usando el puerto

## ✅ Verificación Final

Después de ejecutar la aplicación:

1. ✅ La aplicación se abre en el navegador
2. ✅ Redirige automáticamente al Login (`/Identity/Account/Login`)
3. ✅ Puedes registrar un nuevo usuario
4. ✅ Puedes iniciar sesión
5. ✅ El menú muestra las opciones correctamente
6. ✅ Puedes navegar por las diferentes secciones

---

**¡Listo para desarrollar en Visual Studio 2022!** 🎉

Si tienes algún problema, revisa la sección "Solución de Problemas Comunes" o consulta los logs en la ventana de **Salida** de Visual Studio.

