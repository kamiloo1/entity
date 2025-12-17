# 🧪 Instrucciones para Probar la Aplicación

## ✅ Estado Actual

La aplicación está ejecutándose. Deberías poder acceder a ella en:

- **HTTP**: `http://localhost:5175`
- **HTTPS**: `https://localhost:7115`

## 🔍 Pruebas a Realizar

### 1. Verificar Redirección al Login (Sin Autenticación)

1. Abre tu navegador y ve a: `http://localhost:5175`
2. **Resultado esperado**: 
   - ✅ Debe redirigir automáticamente a `/Identity/Account/Login`
   - ✅ El menú solo debe mostrar "Iniciar sesión" y "Registrarse"
   - ✅ NO debe mostrar: Cultivos, Huertas, Siembras, Roles, Usuarios

### 2. Probar Registro de Usuario

1. En la página de Login, haz clic en **"Crear cuenta nueva"** o ve a: `http://localhost:5175/Identity/Account/Register`
2. Completa el formulario:
   - **Correo electrónico**: `test@agrosoft.com`
   - **Contraseña**: `Password123` (mínimo 6 caracteres, con mayúscula y número)
   - **Confirmar contraseña**: `Password123`
3. Haz clic en **"🌱 Crear Cuenta en AgroSoft"**
4. **Resultado esperado**:
   - ✅ Debe registrar el usuario exitosamente
   - ✅ Debe iniciar sesión automáticamente
   - ✅ Debe redirigir al Home (`/Home`)
   - ✅ El menú ahora debe mostrar todas las opciones
   - ✅ Debe aparecer tu correo electrónico en el menú superior
   - ✅ Debe aparecer el botón "Cerrar sesión"

### 3. Verificar Página de Inicio (Home)

1. Si estás en el Home, verifica que veas:
   - ✅ Título: "🌾 Bienvenido al Sistema de Gestión Agropecuaria"
   - ✅ Tarjetas con iconos para: Cultivos, Huertas, Siembras, Usuarios, Roles
   - ✅ Diseño con colores verdes (temática agrícola)
   - ✅ Botones funcionales que llevan a cada sección

### 4. Probar Cierre de Sesión

1. Haz clic en **"Cerrar sesión"** en el menú superior derecho
2. **Resultado esperado**:
   - ✅ Debe cerrar sesión exitosamente
   - ✅ Debe redirigir al Login
   - ✅ El menú vuelve a mostrar solo "Iniciar sesión" y "Registrarse"
   - ✅ NO puedes acceder directamente a `/Home`

### 5. Probar Inicio de Sesión

1. En la página de Login, ingresa las credenciales que creaste:
   - **Correo**: `test@agrosoft.com`
   - **Contraseña**: `Password123`
2. Opcional: Marca "Mantener sesión activa"
3. Haz clic en **"🌱 Acceder al Sistema"**
4. **Resultado esperado**:
   - ✅ Debe iniciar sesión exitosamente
   - ✅ Debe redirigir al Home
   - ✅ Menú completo visible
   - ✅ Si marcaste "Mantener sesión activa", la sesión debe persistir al cerrar el navegador

### 6. Probar Credenciales Incorrectas

1. Intenta iniciar sesión con credenciales incorrectas:
   - **Correo**: `test@agrosoft.com`
   - **Contraseña**: `PasswordIncorrecta`
2. **Resultado esperado**:
   - ✅ Debe mostrar un mensaje de error claro
   - ✅ NO debe permitir el acceso
   - ✅ Debe permanecer en la página de Login

### 7. Verificar Protección de Controladores

1. Cierra sesión si estás autenticado
2. Intenta acceder directamente a estas URLs:
   - `http://localhost:5175/Home`
   - `http://localhost:5175/Cultivos`
   - `http://localhost:5175/Huertas`
   - `http://localhost:5175/Siembras`
   - `http://localhost:5175/Usuarios`
   - `http://localhost:5175/Roles`
3. **Resultado esperado**:
   - ✅ Todas deben redirigir automáticamente al Login
   - ✅ NO puedes acceder sin autenticarte

### 8. Verificar Diseño y Estilos

1. Verifica que el diseño tenga:
   - ✅ Colores verdes (#28a745) en botones y elementos
   - ✅ Iconos agrícolas (🌾, 🌱, 🏡, 🌿)
   - ✅ Diseño responsive (funciona en móvil y desktop)
   - ✅ Efectos hover en las tarjetas
   - ✅ Estilos consistentes en todas las páginas

## 🐛 Solución de Problemas

### Si la aplicación no inicia:
1. Verifica que MySQL/MariaDB esté ejecutándose
2. Verifica la cadena de conexión en `appsettings.json`
3. Verifica que la base de datos `agrosft` exista
4. Ejecuta: `dotnet restore` y luego `dotnet run`

### Si hay errores de base de datos:
1. Ejecuta el script SQL: `database_agrosft.sql`
2. O crea las migraciones de Identity:
   ```powershell
   dotnet ef migrations add InitialIdentityMigration --context ApplicationDbContext
   dotnet ef database update --context ApplicationDbContext
   ```

### Si no puedes acceder a la aplicación:
1. Verifica que el puerto no esté en uso
2. Revisa los logs en la consola donde ejecutaste `dotnet run`
3. Intenta acceder a `https://localhost:7115` si `http://localhost:5175` no funciona

## ✅ Checklist de Verificación Final

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
- [ ] El diseño tiene temática agrícola (verde)
- [ ] Las páginas de Login y Register están personalizadas

---

**¡Listo para probar!** 🚀

