#!/bin/bash

# ============================================================================
# Script de Ejecución de Pruebas - Semáforo Inteligente MBT
# Universidad de Costa Rica - CI-0142 Pruebas de Software
# ============================================================================

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo ""
echo "========================================================================"
echo "   SEMAFORO INTELIGENTE - MODEL-BASED TESTING DEMO"
echo "   Universidad de Costa Rica - CI-0142 Pruebas de Software"
echo "========================================================================"
echo ""
echo "Equipo:"
echo "  - Silvia Aguilar B80129"
echo "  - Pablo Cascante C11731"
echo "  - Javier Pupo C06103"
echo "  - Alexander Quesada C16131"
echo "  - Christian Rojas B86958"
echo ""
echo "========================================================================"
echo ""

# Guardar el directorio actual
ORIGINAL_DIR=$(pwd)

# Ir al directorio raíz del proyecto (un nivel arriba de scripts/)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$( cd "$SCRIPT_DIR/.." && pwd )"
cd "$PROJECT_DIR"

echo -e "${BLUE}[INFO]${NC} Directorio del proyecto: $PROJECT_DIR"
echo ""

# ============================================================================
# PARTE 1: PRUEBAS DE MODELJUNIT (JAVA)
# ============================================================================

echo ""
echo "========================================================================"
echo " PARTE 1: EJECUTANDO PRUEBAS DE MODELJUNIT (JAVA)"
echo "========================================================================"
echo ""

# Verificar si Maven está instalado
if ! command -v mvn &> /dev/null; then
    echo -e "${RED}[ERROR]${NC} Maven no encontrado. Por favor instale Maven."
    echo "       Descarga: https://maven.apache.org/download.cgi"
    exit 1
fi

# Verificar si Java está instalado
if ! command -v java &> /dev/null; then
    echo -e "${RED}[ERROR]${NC} Java no encontrado. Por favor instale Java JDK 8+."
    echo "       Descarga: https://www.oracle.com/java/technologies/javase-downloads.html"
    exit 1
fi

echo -e "${BLUE}[INFO]${NC} Maven encontrado:"
mvn --version
echo ""

echo -e "${BLUE}[INFO]${NC} Java encontrado:"
java -version
echo ""

# Cambiar al directorio de ModelJUnit
cd modeljunit-implementation

echo -e "${BLUE}[INFO]${NC} Ejecutando pruebas de ModelJUnit..."
echo ""

# Ejecutar las pruebas
mvn clean test

if [ $? -ne 0 ]; then
    echo ""
    echo -e "${RED}[ERROR]${NC} Las pruebas de ModelJUnit fallaron."
    echo -e "${YELLOW}[INFO]${NC} Revise los logs arriba para más detalles."
    cd "$ORIGINAL_DIR"
    exit 1
fi

echo ""
echo -e "${GREEN}[SUCCESS]${NC} Pruebas de ModelJUnit completadas exitosamente!"
echo ""

# Volver al directorio raíz
cd "$PROJECT_DIR"

# ============================================================================
# PARTE 2: PRUEBAS DE XSTATE (JAVASCRIPT)
# ============================================================================

echo ""
echo "========================================================================"
echo " PARTE 2: EJECUTANDO PRUEBAS DE XSTATE (JAVASCRIPT)"
echo "========================================================================"
echo ""

# Verificar si Node.js está instalado
if ! command -v node &> /dev/null; then
    echo -e "${RED}[ERROR]${NC} Node.js no encontrado. Por favor instale Node.js 16+."
    echo "       Descarga: https://nodejs.org/"
    exit 1
fi

# Verificar si npm está instalado
if ! command -v npm &> /dev/null; then
    echo -e "${RED}[ERROR]${NC} npm no encontrado. Por favor instale npm."
    exit 1
fi

echo -e "${BLUE}[INFO]${NC} Node.js encontrado:"
node --version
echo ""

echo -e "${BLUE}[INFO]${NC} npm encontrado:"
npm --version
echo ""

# Cambiar al directorio de XState
cd xstate-implementation

# Verificar si node_modules existe
if [ ! -d "node_modules" ]; then
    echo -e "${BLUE}[INFO]${NC} Instalando dependencias de npm..."
    npm install
    if [ $? -ne 0 ]; then
        echo -e "${RED}[ERROR]${NC} Falló la instalación de dependencias."
        cd "$ORIGINAL_DIR"
        exit 1
    fi
    echo ""
fi

echo -e "${BLUE}[INFO]${NC} Ejecutando pruebas de XState..."
echo ""

# Ejecutar las pruebas con cobertura
npm test

if [ $? -ne 0 ]; then
    echo ""
    echo -e "${RED}[ERROR]${NC} Las pruebas de XState fallaron."
    echo -e "${YELLOW}[INFO]${NC} Revise los logs arriba para más detalles."
    cd "$ORIGINAL_DIR"
    exit 1
fi

echo ""
echo -e "${GREEN}[SUCCESS]${NC} Pruebas de XState completadas exitosamente!"
echo ""

# Volver al directorio raíz
cd "$PROJECT_DIR"

# ============================================================================
# RESUMEN FINAL
# ============================================================================

echo ""
echo "========================================================================"
echo " RESUMEN DE EJECUCION"
echo "========================================================================"
echo ""
echo -e "${GREEN}[SUCCESS]${NC} Todas las pruebas se ejecutaron exitosamente!"
echo ""
echo "Resultados:"
echo "  - ModelJUnit (Java):   ✓ OK"
echo "  - XState (JavaScript): ✓ OK"
echo ""
echo "========================================================================"
echo ""
echo "Para ver el visualizador interactivo, abra:"
echo "  xstate-implementation/visualizer.html"
echo ""
echo "========================================================================"
echo ""

# Volver al directorio original
cd "$ORIGINAL_DIR"
