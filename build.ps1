# Script de build para PowerShell
# Genera ejecutables optimizados para diferentes sistemas operativos

Write-Host ""
Write-Host "╔══════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                    🚀 GoShell Build Script                       ║" -ForegroundColor Cyan
Write-Host "║                  PowerShell Build System                         ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Crear directorios de build
$buildDirs = @("builds", "builds/windows", "builds/linux", "builds/macos", "builds/freebsd")
foreach ($dir in $buildDirs) {
    if (!(Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }
}

# Función para compilar
function Build-Target {
    param(
        [string]$OS,
        [string]$Arch,
        [string]$Extension,
        [string]$Directory
    )
    
    Write-Host "📦 Compilando para $OS/$Arch..." -ForegroundColor Yellow
    
    $env:GOOS = $OS
    $env:GOARCH = $Arch
    
    $outputPath = "builds/$Directory/goshell-$OS-$Arch$Extension"
    
    $result = & go build -o $outputPath -ldflags="-s -w" .
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ goshell-$OS-$Arch$Extension creado" -ForegroundColor Green
        
        # Mostrar tamaño del archivo
        $fileSize = (Get-Item $outputPath).Length
        $fileSizeMB = [math]::Round($fileSize / 1MB, 2)
        Write-Host "   📏 Tamaño: $fileSizeMB MB" -ForegroundColor Gray
    } else {
        Write-Host "❌ Error compilando para $OS/$Arch" -ForegroundColor Red
        return $false
    }
    return $true
}

# Windows builds
Write-Host "🪟 Compilando para Windows..." -ForegroundColor Blue
Build-Target "windows" "amd64" ".exe" "windows"
Build-Target "windows" "386" ".exe" "windows"
Build-Target "windows" "arm64" ".exe" "windows"

Write-Host ""
# Linux builds
Write-Host "🐧 Compilando para Linux..." -ForegroundColor Blue
Build-Target "linux" "amd64" "" "linux"
Build-Target "linux" "386" "" "linux"
Build-Target "linux" "arm64" "" "linux"

Write-Host ""
# macOS builds
Write-Host "🍎 Compilando para macOS..." -ForegroundColor Blue
Build-Target "darwin" "amd64" "" "macos"
Build-Target "darwin" "arm64" "" "macos"

Write-Host ""
# FreeBSD builds
Write-Host "😈 Compilando para FreeBSD..." -ForegroundColor Blue
Build-Target "freebsd" "amd64" "" "freebsd"

Write-Host ""
Write-Host "🎉 ¡Todos los builds completados!" -ForegroundColor Green
Write-Host ""

# Mostrar resumen de builds
Write-Host "📁 Ejecutables generados:" -ForegroundColor Yellow
Get-ChildItem -Path "builds" -Recurse -Filter "goshell-*" | ForEach-Object {
    $size = [math]::Round($_.Length / 1MB, 2)
    Write-Host "  • $($_.FullName) ($size MB)" -ForegroundColor Gray
}

Write-Host ""
Write-Host "🧪 Comandos para probar en diferentes terminales:" -ForegroundColor Magenta
Write-Host "  • PowerShell:     .\builds\windows\goshell-windows-amd64.exe" -ForegroundColor Cyan
Write-Host "  • CMD:            builds\windows\goshell-windows-amd64.exe" -ForegroundColor Cyan
Write-Host "  • GitBash:        ./builds/windows/goshell-windows-amd64.exe" -ForegroundColor Cyan

Write-Host ""
Write-Host "💡 Tips para testing:" -ForegroundColor Yellow
Write-Host "  • Los colores ANSI funcionan mejor en Windows Terminal" -ForegroundColor Gray
Write-Host "  • CMD tradicional puede mostrar códigos de escape" -ForegroundColor Gray
Write-Host "  • GitBash soporta completamente los colores ANSI" -ForegroundColor Gray

# Limpiar variables de entorno
Remove-Item Env:GOOS -ErrorAction SilentlyContinue
Remove-Item Env:GOARCH -ErrorAction SilentlyContinue