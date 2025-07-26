# Makefile para GoShell - Cross-platform build system
# Compatible con make en GitBash, Linux, macOS

.PHONY: all clean windows linux macos freebsd test help

# Variables
BINARY_NAME=goshell
BUILD_DIR=builds
VERSION=1.0.0
LDFLAGS=-ldflags="-s -w -X main.version=$(VERSION)"

# Colores para output
RED=\033[0;31m
GREEN=\033[0;32m
YELLOW=\033[1;33m
BLUE=\033[0;34m
PURPLE=\033[0;35m
CYAN=\033[0;36m
NC=\033[0m # No Color

# Target por defecto
all: clean windows linux macos freebsd
	@echo "$(GREEN)🎉 Todos los builds completados!$(NC)"
	@echo "$(CYAN)📁 Ejecutables disponibles en $(BUILD_DIR)/$(NC)"

# Crear directorios de build
$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)/{windows,linux,macos,freebsd}

# Windows builds
windows: $(BUILD_DIR)
	@echo "$(BLUE)🪟 Compilando para Windows...$(NC)"
	@GOOS=windows GOARCH=amd64 go build $(LDFLAGS) -o $(BUILD_DIR)/windows/$(BINARY_NAME)-windows-amd64.exe .
	@GOOS=windows GOARCH=386 go build $(LDFLAGS) -o $(BUILD_DIR)/windows/$(BINARY_NAME)-windows-386.exe .
	@GOOS=windows GOARCH=arm64 go build $(LDFLAGS) -o $(BUILD_DIR)/windows/$(BINARY_NAME)-windows-arm64.exe .
	@echo "$(GREEN)✅ Windows builds completados$(NC)"

# Linux builds
linux: $(BUILD_DIR)
	@echo "$(BLUE)🐧 Compilando para Linux...$(NC)"
	@GOOS=linux GOARCH=amd64 go build $(LDFLAGS) -o $(BUILD_DIR)/linux/$(BINARY_NAME)-linux-amd64 .
	@GOOS=linux GOARCH=386 go build $(LDFLAGS) -o $(BUILD_DIR)/linux/$(BINARY_NAME)-linux-386 .
	@GOOS=linux GOARCH=arm64 go build $(LDFLAGS) -o $(BUILD_DIR)/linux/$(BINARY_NAME)-linux-arm64 .
	@GOOS=linux GOARCH=arm go build $(LDFLAGS) -o $(BUILD_DIR)/linux/$(BINARY_NAME)-linux-arm .
	@echo "$(GREEN)✅ Linux builds completados$(NC)"

# macOS builds
macos: $(BUILD_DIR)
	@echo "$(BLUE)🍎 Compilando para macOS...$(NC)"
	@GOOS=darwin GOARCH=amd64 go build $(LDFLAGS) -o $(BUILD_DIR)/macos/$(BINARY_NAME)-darwin-amd64 .
	@GOOS=darwin GOARCH=arm64 go build $(LDFLAGS) -o $(BUILD_DIR)/macos/$(BINARY_NAME)-darwin-arm64 .
	@echo "$(GREEN)✅ macOS builds completados$(NC)"

# FreeBSD builds
freebsd: $(BUILD_DIR)
	@echo "$(BLUE)😈 Compilando para FreeBSD...$(NC)"
	@GOOS=freebsd GOARCH=amd64 go build $(LDFLAGS) -o $(BUILD_DIR)/freebsd/$(BINARY_NAME)-freebsd-amd64 .
	@GOOS=freebsd GOARCH=386 go build $(LDFLAGS) -o $(BUILD_DIR)/freebsd/$(BINARY_NAME)-freebsd-386 .
	@echo "$(GREEN)✅ FreeBSD builds completados$(NC)"

# Build solo para el sistema actual
local:
	@echo "$(YELLOW)📦 Compilando para sistema local...$(NC)"
	@go build $(LDFLAGS) -o $(BINARY_NAME) .
	@echo "$(GREEN)✅ Build local completado: ./$(BINARY_NAME)$(NC)"

# Ejecutar tests
test:
	@echo "$(YELLOW)🧪 Ejecutando tests...$(NC)"
	@go test -v ./...
	@echo "$(GREEN)✅ Tests completados$(NC)"

# Limpiar builds
clean:
	@echo "$(RED)🧹 Limpiando builds anteriores...$(NC)"
	@rm -rf $(BUILD_DIR)
	@rm -f $(BINARY_NAME)
	@echo "$(GREEN)✅ Limpieza completada$(NC)"

# Mostrar información de builds
info:
	@echo "$(CYAN)📊 Información de builds:$(NC)"
	@if [ -d "$(BUILD_DIR)" ]; then \
		find $(BUILD_DIR) -name "$(BINARY_NAME)-*" -exec ls -lh {} \; | \
		awk '{print "  • " $$9 " (" $$5 ")"}'; \
	else \
		echo "$(YELLOW)  No hay builds disponibles. Ejecuta 'make all' primero.$(NC)"; \
	fi

# Mostrar ayuda
help:
	@echo "$(CYAN)╔══════════════════════════════════════════════════════════════════╗$(NC)"
	@echo "$(CYAN)║                    🚀 GoShell Build System                       ║$(NC)"
	@echo "$(CYAN)║                        Makefile Help                             ║$(NC)"
	@echo "$(CYAN)╚══════════════════════════════════════════════════════════════════╝$(NC)"
	@echo ""
	@echo "$(YELLOW)Targets disponibles:$(NC)"
	@echo "  $(GREEN)all$(NC)      - Compila para todos los sistemas operativos"
	@echo "  $(GREEN)windows$(NC)  - Compila solo para Windows (amd64, 386, arm64)"
	@echo "  $(GREEN)linux$(NC)    - Compila solo para Linux (amd64, 386, arm64, arm)"
	@echo "  $(GREEN)macos$(NC)    - Compila solo para macOS (amd64, arm64)"
	@echo "  $(GREEN)freebsd$(NC)  - Compila solo para FreeBSD (amd64, 386)"
	@echo "  $(GREEN)local$(NC)    - Compila solo para el sistema actual"
	@echo "  $(GREEN)test$(NC)     - Ejecuta los tests unitarios"
	@echo "  $(GREEN)clean$(NC)    - Limpia todos los builds"
	@echo "  $(GREEN)info$(NC)     - Muestra información de builds existentes"
	@echo "  $(GREEN)help$(NC)     - Muestra esta ayuda"
	@echo ""
	@echo "$(YELLOW)Ejemplos de uso:$(NC)"
	@echo "  $(CYAN)make all$(NC)      # Compila para todos los SO"
	@echo "  $(CYAN)make windows$(NC)  # Solo Windows"
	@echo "  $(CYAN)make test$(NC)     # Ejecutar tests"
	@echo "  $(CYAN)make clean$(NC)    # Limpiar builds"
	@echo ""
	@echo "$(YELLOW)Para probar en diferentes terminales:$(NC)"
	@echo "  $(PURPLE)GitBash:$(NC)     ./builds/windows/$(BINARY_NAME)-windows-amd64.exe"
	@echo "  $(PURPLE)CMD:$(NC)         builds\\windows\\$(BINARY_NAME)-windows-amd64.exe"
	@echo "  $(PURPLE)PowerShell:$(NC)  .\\builds\\windows\\$(BINARY_NAME)-windows-amd64.exe"