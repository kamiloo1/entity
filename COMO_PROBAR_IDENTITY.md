# 🌾 Cómo Probar que ASP.NET Core Identity Funciona en AgroSoft

## ✅ Paso 1: Crear las Tablas de Identity en la Base de Datos

Antes de ejecutar la aplicación, necesitas crear las tablas de Identity. Ejecuta estos comandos en PowerShell o CMD:

```powershell
cd "C:\Users\DISTRIBUIDORA HUEVOS\Documents\Actividad-master\Actividad-master"

# Crear la migración
dotnet ef migrations add InitialIdentityMigration --context ApplicationDbContext

# Aplicar la migración a la base de datos
dotnet ef database update --context ApplicationDbContext
```

**Si no tienes `dotnet ef` instalado:**
```powershell
dotnet tool install --global dotnet-ef
```

---

## ✅ Paso 2: Verificar que la Base de Datos esté Configurada

Asegúrate de que:
- ✅ MySQL/MariaDB esté ejecutándose
- ✅ La base de datos `agrosft` exista
- ✅ La cadena de conexión en `appsettings.json` sea correcta

Si tu MySQL tiene contraseña, actualiza `appsettings.json`:
```json
{
  "ConnectionStrings": {
    "conexion": "server=localhost;user=root;password=TU_CONTRASEÑA;database=agrosft"
  }
}
```

---

## ✅ Paso 3: Ejecutar la Aplicación

### Opción A: Desde PowerShell/CMD
```powershell
cd "C:\Users\DISTRIBUIDORA HUEVOS\Documents\Actividad-master\Actividad-master"
dotnet run
```

### Opción B: Desde Visual Studio
1. Abre `Actividad.sln`
2. Presiona **F5** o haz clic en "Ejecutar"

### Opción C: Desde Visual Studio Code
1. Abre la carpeta del proyecto
2. Presiona **F5** o ve a "Run and Debug"
3. Selecciona ".NET Core Launch (web)"

La aplicación se ejecutará en:
- **HTTP**: `http://localhost:5175` (o el puerto que indique)
- **HTTPS**: `https://localhost:7115` (o el puerto que indique)

---

## ✅ Paso 4: Probar el Flujo Completo de Autenticación

### 🔹 Test 1: Verificar que la Página Inicial Redirige al Login

1. Abre tu navegador y ve a: `http://localhost:5175` (o el puerto que indique)
2. **Resultado esperado**: Deberías ser redirigido automáticamente a `/Identity/Account/Login`
3. **Verifica que aparezca**:
   - El título "🌾 AgroSoft - Gestión Agropecuaria"
   - El formulario de login personalizado con temática agrícola
   - Los enlaces "Iniciar sesión" y "Registrarse" en el menú

### 🔹 Test 2: Verificar que el Menú Solo Muestra Opciones Públicas

Cuando NO estés autenticado, el menú debe mostrar SOLO:
- ✅ "Iniciar sesión"
- ✅ "Registrarse"
- ❌ NO debe mostrar: Cultivos, Huertas, Siembras, Roles, Usuarios

### 🔹 Test 3: Registrar un Nuevo Usuario

1. Haz clic en **"Registrarse"** o ve a: `http://localhost:5175/Identity/Account/Register`
2. Completa el formulario:
   - **Correo electrónico**: `test@agrosoft.com`
   - **Contraseña**: `Password123` (mínimo 6 caracteres, con mayúscula y número)
   - **Confirmar contraseña**: `Password123`
3. Haz clic en **"🌱 Crear Cuenta en AgroSoft"**
4. **Resultado esperado**:
   - ✅ Deberías ser redirigido automáticamente al Home
   - ✅ El menú ahora debe mostrar todas las opciones (Cultivos, Huertas, etc.)
   - ✅ Debe aparecer tu correo electrónico en el menú superior
   - ✅ Debe aparecer el botón "Cerrar sesión"

### 🔹 Test 4: Verificar que el Home Funciona para Usuarios Autenticados

1. Si estás en el Home, verifica que veas:
   - ✅ El título "Bienvenido al Sistema de Gestión Agropecuaria"
   - ✅ Las tarjetas de Cultivos, Huertas y Siembras
   - ✅ El menú completo de navegación

### 🔹 Test 5: Probar el Cierre de Sesión

1. Haz clic en **"Cerrar sesión"** en el menú superior derecho
2. **Resultado esperado**:
   - ✅ Deberías ser redirigido al Login
   - ✅ El menú vuelve a mostrar solo "Iniciar sesión" y "Registrarse"
   - ✅ NO puedes acceder directamente a `/Home`

### 🔹 Test 6: Probar el Inicio de Sesión

1. En la página de Login, ingresa las credenciales que creaste:
   - **Correo**: `test@agrosoft.com`
   - **Contraseña**: `Password123`
2. Haz clic en **"🌱 Acceder al Sistema"**
3. **Resultado esperado**:
   - ✅ Deberías iniciar sesión exitosamente
   - ✅ Redirección al Home
   - ✅ Menú completo visible

### 🔹 Test 7: Probar Credenciales Incorrectas

1. Intenta iniciar sesión con credenciales incorrectas
2. **Resultado esperado**:
   - ✅ Debe mostrar un mensaje de error claro
   - ✅ NO debe permitir el acceso

### 🔹 Test 8: Verificar que los Controladores Están Protegidos

1. Cierra sesión
2. Intenta acceder directamente a:
   - `http://localhost:5175/Cultivos`
   - `http://localhost:5175/Huertas`
   - `http://localhost:5175/Siembras`
   - `http://localhost:5175/Home`
3. **Resultado esperado**:
   - ✅ Deberías ser redirigido automáticamente al Login
   - ✅ No puedes acceder sin autenticarte

---

## ✅ Paso 5: Verificar las Tablas en la Base de Datos

Para confirmar que Identity está funcionando correctamente, verifica en MySQL:

```sql
-- Conecta a la base de datos
USE agrosft;

-- Verifica que existan las tablas de Identity
SHOW TABLES LIKE 'AspNet%';

-- Deberías ver estas tablas:
-- - AspNetUsers
-- - AspNetRoles (si usas roles)
-- - AspNetUserRoles
-- - AspNetUserClaims
-- - AspNetUserLogins
-- - AspNetUserTokens
-- - AspNetRoleClaims

-- Verifica que tu usuario esté registrado
SELECT Id, UserName, Email, EmailConfirmed FROM AspNetUsers;
```

---

## 🎯 Checklist de Verificación

Marca cada ítem cuando lo pruebes:

- [ ] La aplicación compila sin errores
- [ ] Las migraciones de Identity se crearon correctamente
- [ ] La aplicación se ejecuta sin errores
- [ ] La página inicial redirige al Login cuando no estás autenticado
- [ ] El menú muestra solo opciones públicas cuando no estás autenticado
- [ ] Puedes registrar un nuevo usuario
- [ ] Después del registro, se inicia sesión automáticamente
- [ ] El menú muestra todas las opciones cuando estás autenticado
- [ ] Puedes cerrar sesión correctamente
- [ ] Puedes iniciar sesión con credenciales válidas
- [ ] No puedes iniciar sesión con credenciales incorrectas
- [ ] Los controladores están protegidos (redirigen al Login)
- [ ] Las tablas de Identity se crearon en la base de datos
- [ ] Los usuarios se guardan correctamente en AspNetUsers

---

## 🐛 Solución de Problemas

### Error: "No se puede conectar a la base de datos"
- ✅ Verifica que MySQL/MariaDB esté ejecutándose
- ✅ Revisa la cadena de conexión en `appsettings.json`
- ✅ Asegúrate de que la base de datos `agrosft` exista

### Error: "Ya existe una migración con el nombre..."
- ✅ Elimina la carpeta `Migrations` si existe
- ✅ Vuelve a crear la migración con un nombre diferente

### Error al ejecutar: "Unable to create an object of type..."
- ✅ Asegúrate de tener .NET 8.0 instalado
- ✅ Ejecuta `dotnet restore`

### La página de Login no carga
- ✅ Verifica que el proyecto compile sin errores
- ✅ Revisa la consola del navegador (F12) para ver errores JavaScript
- ✅ Revisa los logs de la aplicación

---

## 📝 Notas Finales

Si todos los tests pasan, **¡Identity está funcionando correctamente!** 🎉

El sistema ahora tiene:
- ✅ Autenticación completa (Registro, Login, Logout)
- ✅ Autorización en todos los controladores
- ✅ Menú protegido
- ✅ Páginas personalizadas con temática agrícola
- ✅ Integración con la base de datos existente

