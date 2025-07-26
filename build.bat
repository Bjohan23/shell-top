@echo off
REM Script de build para Windows - Compatible con CMD y PowerShell
REM Genera ejecutables para diferentes arquitecturas y terminales

echo.
echo ╔══════════════════════════════════════════════════════════════════╗
echo ║                    🚀 GoShell Build Script                       ║
echo ║                   Compilando para Windows                        ║
echo ╚══════════════════════════════════════════════════════════════════╝
echo.

REM Crear directorio de builds si no existe
if not exist "builds" mkdir builds
if not exist "builds\windows" mkdir builds\windows

echo 📦 Compilando para Windows x64 (CMD/PowerShell)...
set GOOS=windows
set GOARCH=amd64
go build -o builds\windows\goshell-windows-amd64.exe -ldflags="-s -w"
if %errorlevel% neq 0 (
    echo ❌ Error compilando para Windows x64
    exit /b 1
)
echo ✅ goshell-windows-amd64.exe creado

echo.
echo 📦 Compilando para Windows x86...
set GOARCH=386
go build -o builds\windows\goshell-windows-386.exe -ldflags="-s -w"
if %errorlevel% neq 0 (
    echo ❌ Error compilando para Windows x86
    exit /b 1
)
echo ✅ goshell-windows-386.exe creado

echo.
echo 📦 Compilando para Windows ARM64...
set GOARCH=arm64
go build -o builds\windows\goshell-windows-arm64.exe -ldflags="-s -w"
if %errorlevel% neq 0 (
    echo ❌ Error compilando para Windows ARM64
    exit /b 1
)
echo ✅ goshell-windows-arm64.exe creado

echo.
echo 🎉 ¡Builds de Windows completados!
echo.
echo 📁 Ejecutables disponibles en builds\windows\:
dir builds\windows\*.exe
echo.
echo 🧪 Para probar:
echo   • CMD:        builds\windows\goshell-windows-amd64.exe
echo   • PowerShell: builds\windows\goshell-windows-amd64.exe
echo   • GitBash:    ./builds/windows/goshell-windows-amd64.exe
echo.
pause