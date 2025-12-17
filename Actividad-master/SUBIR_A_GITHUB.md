# 🚀 Instrucciones para Subir el Proyecto a GitHub

## ✅ Estado Actual

El proyecto ya está preparado con Git y tiene un commit inicial. Ahora necesitas crear el repositorio en GitHub y subirlo.

## 📋 Pasos para Subir a GitHub

### Paso 1: Crear el Repositorio en GitHub

1. Ve a [GitHub.com](https://github.com) e inicia sesión
2. Haz clic en el botón **"+"** en la esquina superior derecha
3. Selecciona **"New repository"**
4. Configura el repositorio:
   - **Repository name**: `entity`
   - **Description**: `Sistema de Gestión Agropecuaria con ASP.NET Core Identity`
   - **Visibility**: Elige **Public** o **Private**
   - **NO marques** "Initialize this repository with a README" (ya tenemos uno)
   - **NO marques** "Add .gitignore" (ya tenemos uno)
   - **NO marques** "Choose a license"
5. Haz clic en **"Create repository"**

### Paso 2: Conectar el Repositorio Local con GitHub

Después de crear el repositorio, GitHub te mostrará instrucciones. Ejecuta estos comandos en PowerShell o CMD desde la carpeta del proyecto:

```powershell
# Navega a la carpeta del proyecto
cd "C:\Users\adminsena\Downloads\Actividad-master\Actividad-master"

# Agrega el repositorio remoto (reemplaza TU_USUARIO con tu usuario de GitHub)
git remote add origin https://github.com/TU_USUARIO/entity.git

# Verifica que se agregó correctamente
git remote -v

# Cambia el nombre de la rama principal a 'main' (si GitHub usa 'main')
git branch -M main

# Sube el código a GitHub
git push -u origin main
```

### Paso 3: Autenticación

Si es la primera vez que subes código a GitHub desde esta computadora, te pedirá autenticarte:

**Opción A: Usando GitHub CLI (Recomendado)**
```powershell
# Instala GitHub CLI si no lo tienes
winget install GitHub.cli

# Autentícate
gh auth login

# Luego haz push
git push -u origin main
```

**Opción B: Usando Personal Access Token**
1. Ve a GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Genera un nuevo token con permisos `repo`
3. Cuando hagas `git push`, usa tu usuario de GitHub y el token como contraseña

**Opción C: Usando GitHub Desktop**
1. Descarga GitHub Desktop desde: https://desktop.github.com/
2. Abre GitHub Desktop
3. File → Add Local Repository
4. Selecciona la carpeta del proyecto
5. Publish repository

## 🔄 Comandos Alternativos (Si ya tienes SSH configurado)

Si prefieres usar SSH en lugar de HTTPS:

```powershell
# Cambia la URL del remoto a SSH
git remote set-url origin git@github.com:TU_USUARIO/entity.git

# Haz push
git push -u origin main
```

## ✅ Verificación

Después de hacer push, verifica que todo esté correcto:

1. Ve a tu repositorio en GitHub: `https://github.com/TU_USUARIO/entity`
2. Deberías ver todos los archivos del proyecto
3. El README.md debería aparecer en la página principal

## 📝 Comandos Útiles para el Futuro

```powershell
# Ver el estado de los archivos
git status

# Agregar cambios
git add .

# Hacer commit
git commit -m "Descripción de los cambios"

# Subir cambios a GitHub
git push

# Descargar cambios de GitHub
git pull

# Ver el historial de commits
git log
```

## 🐛 Solución de Problemas

### Error: "remote origin already exists"
```powershell
# Elimina el remoto existente
git remote remove origin

# Agrega el nuevo remoto
git remote add origin https://github.com/TU_USUARIO/entity.git
```

### Error: "failed to push some refs"
```powershell
# Primero haz pull para sincronizar
git pull origin main --allow-unrelated-histories

# Luego haz push
git push -u origin main
```

### Error de autenticación
- Asegúrate de tener un Personal Access Token válido
- O configura SSH keys en GitHub
- O usa GitHub Desktop para una interfaz gráfica

## 📚 Recursos Adicionales

- [Documentación de Git](https://git-scm.com/doc)
- [Guía de GitHub](https://docs.github.com/)
- [GitHub Desktop](https://desktop.github.com/)

---

**¡Listo para subir a GitHub!** 🎉

Si tienes problemas, revisa la sección de "Solución de Problemas" o consulta la documentación de GitHub.

