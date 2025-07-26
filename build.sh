#!/bin/bash
# Script de build multiplataforma - Compatible con GitBash, Linux, macOS
# Genera ejecutables para diferentes sistemas operativos

echo
echo "╔══════════════════════════════════════════════════════════════════╗"
echo "║                    🚀 GoShell Build Script                       ║"
echo "║                Compilando para múltiples SO                      ║"
echo "╚══════════════════════════════════════════════════════════════════╝"
echo

# Crear directorios de build
mkdir -p builds/{windows,linux,macos,freebsd}

# Función para compilar
build_target() {
    local os=$1
    local arch=$2
    local ext=$3
    local dir=$4
    
    echo "📦 Compilando para $os/$arch..."
    
    GOOS=$os GOARCH=$arch go build \
        -o "builds/$dir/goshell-$os-$arch$ext" \
        -ldflags="-s -w" \
        .
    
    if [ $? -eq 0 ]; then
        echo "✅ goshell-$os-$arch$ext creado"
    else
        echo "❌ Error compilando para $os/$arch"
        return 1
    fi
}

# Windows builds
echo "🪟 Compilando para Windows..."
build_target "windows" "amd64" ".exe" "windows"
build_target "windows" "386" ".exe" "windows"
build_target "windows" "arm64" ".exe" "windows"

echo
# Linux builds
echo "🐧 Compilando para Linux..."
build_target "linux" "amd64" "" "linux"
build_target "linux" "386" "" "linux"
build_target "linux" "arm64" "" "linux"
build_target "linux" "arm" "" "linux"

echo
# macOS builds
echo "🍎 Compilando para macOS..."
build_target "darwin" "amd64" "" "macos"
build_target "darwin" "arm64" "" "macos"

echo
# FreeBSD builds
echo "😈 Compilando para FreeBSD..."
build_target "freebsd" "amd64" "" "freebsd"
build_target "freebsd" "386" "" "freebsd"

echo
echo "🎉 ¡Todos los builds completados!"
echo
echo "📁 Estructura de builds:"
find builds -type f -name "goshell-*" | sort

echo
echo "🧪 Para probar en diferentes terminales:"
echo "  • GitBash (Windows):  ./builds/windows/goshell-windows-amd64.exe"
echo "  • CMD (Windows):      builds\\windows\\goshell-windows-amd64.exe"
echo "  • PowerShell:         .\\builds\\windows\\goshell-windows-amd64.exe"
echo "  • Linux Terminal:     ./builds/linux/goshell-linux-amd64"
echo "  • macOS Terminal:     ./builds/macos/goshell-darwin-amd64"

echo
echo "💡 Tip: Los ejecutables son estáticos, no requieren Go instalado"