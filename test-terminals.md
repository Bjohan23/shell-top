# 🧪 Guía de Testing para Diferentes Terminales

Esta guía te ayudará a probar GoShell en diferentes terminales y sistemas operativos.

## 🚀 Compilar los Ejecutables

Primero, compila los ejecutables usando cualquiera de estos métodos:

### Opción 1: Script de Windows (CMD/PowerShell)
```cmd
build.bat
```

### Opción 2: Script de PowerShell
```powershell
.\build.ps1
```

### Opción 3: Script de Bash (GitBash/Linux/macOS)
```bash
chmod +x build.sh
./build.sh
```

### Opción 4: Makefile (GitBash/Linux/macOS)
```bash
make all
```

## 🖥️ Testing en Windows

### 1. **CMD (Command Prompt)**
```cmd
# Navegar al directorio
cd "C:\Users\becer\OneDrive\Escritorio\TALLER DE LENGUAJES DE PROGRAMACIÓN - B\shell-top"

# Ejecutar
builds\windows\goshell-windows-amd64.exe
```

**Características esperadas:**
- ✅ Funcionalidad completa
- ⚠️ Colores ANSI pueden no mostrarse correctamente en CMD antiguo
- ✅ Comandos internos (cd, exit) funcionan
- ✅ Comandos externos funcionan

### 2. **PowerShell**
```powershell
# Navegar al directorio
Set-Location "C:\Users\becer\OneDrive\Escritorio\TALLER DE LENGUAJES DE PROGRAMACIÓN - B\shell-top"

# Ejecutar
.\builds\windows\goshell-windows-amd64.exe
```

**Características esperadas:**
- ✅ Funcionalidad completa
- ✅ Colores ANSI soportados (especialmente en Windows Terminal)
- ✅ ASCII art se muestra correctamente
- ✅ Todos los comandos funcionan

### 3. **GitBash (MSYS2)**
```bash
# Navegar al directorio
cd "/c/Users/becer/OneDrive/Escritorio/TALLER DE LENGUAJES DE PROGRAMACIÓN - B/shell-top"

# Ejecutar
./builds/windows/goshell-windows-amd64.exe
```

**Características esperadas:**
- ✅ Funcionalidad completa
- ✅ Excelente soporte de colores ANSI
- ✅ ASCII art perfecto
- ✅ Comportamiento más similar a Linux/Unix

## 🧪 Casos de Prueba Recomendados

### Test Básico de Funcionalidad
```bash
# 1. Verificar mensaje de bienvenida
./goshell

# 2. Probar comando interno cd
goshell> cd /tmp
goshell> pwd

# 3. Probar comandos externos
goshell> ls
goshell> echo "Hola Mundo"

# 4. Probar segundo plano
goshell> sleep 5 &

# 5. Salir
goshell> exit
```

### Test de Colores y Visualización
```bash
# Verificar que se muestren:
# - Header con marco de la shell
# - ASCII art de r77vera y Bjohan23
# - Enlaces de GitHub en color cian
# - Prompt colorizado: usuario en verde, directorio en azul
```

### Test de Compatibilidad de Rutas
```bash
# Windows paths
goshell> cd C:\Users
goshell> cd "C:\Program Files"

# Unix-style paths (en GitBash)
goshell> cd /c/Users
goshell> cd /tmp
```

## 📊 Matriz de Compatibilidad Esperada

| Terminal | Colores ANSI | ASCII Art | Funcionalidad | Rutas Windows | Comandos Externos |
|----------|--------------|-----------|---------------|---------------|-------------------|
| **CMD** (antiguo) | ❌/⚠️ | ❌/⚠️ | ✅ | ✅ | ✅ |
| **CMD** (nuevo) | ✅ | ✅ | ✅ | ✅ | ✅ |
| **PowerShell 5** | ⚠️ | ⚠️ | ✅ | ✅ | ✅ |
| **PowerShell 7** | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Windows Terminal** | ✅ | ✅ | ✅ | ✅ | ✅ |
| **GitBash** | ✅ | ✅ | ✅ | ✅ | ✅ |

## 🔧 Solución de Problemas

### Problema: Colores no se muestran
**Solución:**
- Usa Windows Terminal en lugar de CMD clásico
- En PowerShell: `$Host.UI.SupportsVirtualTerminal = $true`

### Problema: ASCII art se ve mal
**Solución:**
- Cambiar encoding de la terminal a UTF-8
- Usar fuente que soporte caracteres Unicode

### Problema: Rutas con espacios
**Solución:**
```bash
goshell> cd "C:\Program Files"
# o
goshell> cd C:\Progra~1
```

### Problema: Comando no encontrado
**Solución:**
- Verificar que el comando esté en PATH
- Usar ruta completa: `C:\Windows\System32\notepad.exe`

## 📝 Reporte de Testing

Después de probar, documenta:

1. **Terminal utilizada**: CMD/PowerShell/GitBash
2. **Versión de Windows**: 10/11
3. **Funcionalidades que funcionan**: ✅
4. **Problemas encontrados**: ❌
5. **Screenshots** de la shell funcionando

## 🎯 Comandos de Ejemplo para Probar

```bash
# Navegación
goshell> cd C:\Users
goshell> cd ..
goshell> pwd

# Listado de archivos
goshell> dir          # Windows
goshell> ls           # Unix-style (en GitBash)

# Crear y ver archivos
goshell> echo "test" > test.txt
goshell> type test.txt    # Windows
goshell> cat test.txt     # Unix-style

# Procesos en segundo plano
goshell> ping google.com &
goshell> tasklist | findstr ping

# Comando de sistema
goshell> systeminfo
goshell> whoami
goshell> date /t
```

¡Ahora tienes todo lo necesario para probar GoShell en todos tus terminales! 🚀