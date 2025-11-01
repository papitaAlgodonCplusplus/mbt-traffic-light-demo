# 🚀 Inicio Rápido - Semáforo Inteligente MBT

Esta guía te ayudará a ejecutar el proyecto en menos de 5 minutos.

## ⚡ Instalación Express

### Paso 1: Instalar Prerequisitos

#### Windows (usando Chocolatey)
```powershell
# Instalar Chocolatey primero: https://chocolatey.org/install

# Instalar Java, Maven y Node.js
choco install openjdk11 maven nodejs -y
```

#### Mac (usando Homebrew)
```bash
# Instalar Homebrew primero: https://brew.sh/

# Instalar Java, Maven y Node.js
brew install openjdk@11 maven node
```

#### Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install openjdk-11-jdk maven nodejs npm -y
```

### Paso 2: Descargar ModelJUnit

```bash
# Crear directorio lib
mkdir -p modeljunit-implementation/lib

# Descargar manualmente desde:
# https://sourceforge.net/projects/modeljunit/files/ModelJUnit-2.5/

# Colocar modeljunit-2.5.jar en:
# modeljunit-implementation/lib/modeljunit-2.5.jar
```

### Paso 3: Configurar XState

```bash
cd xstate-implementation
npm install
cd ..
```

### Paso 4: ¡Ejecutar las Pruebas!

#### Opción A: Script Automatizado (Recomendado)

**Windows:**
```cmd
.\scripts\run-tests.bat
```

**Linux/Mac:**
```bash
chmod +x scripts/run-tests.sh
./scripts/run-tests.sh
```

#### Opción B: Manual

**ModelJUnit:**
```bash
cd modeljunit-implementation
mvn test
```

**XState:**
```bash
cd xstate-implementation
npm test
```

## 🎬 Para la Presentación

### Demostración Completa

```cmd
# Windows
.\scripts\demo-presentation.bat

# Linux/Mac
chmod +x scripts/demo-presentation.sh
./scripts/demo-presentation.sh
```

Esto abrirá:
- ✅ Visualizador interactivo en el navegador
- ✅ Terminal para ModelJUnit
- ✅ Terminal para XState
- ✅ Explorador de archivos

### Solo el Visualizador

```bash
# Abrir directamente en el navegador
start xstate-implementation/visualizer.html

# O con un servidor HTTP local
cd xstate-implementation
npx http-server -p 8080
# Luego abrir: http://localhost:8080/visualizer.html
```

## 🔧 Verificar Instalación

```bash
# Verificar Java
java -version
# Esperado: openjdk version "11.0.x" o superior

# Verificar Maven
mvn -version
# Esperado: Apache Maven 3.x.x

# Verificar Node.js
node --version
# Esperado: v16.x.x o superior

# Verificar npm
npm --version
# Esperado: 8.x.x o superior
```

## 📊 Estructura de Archivos Esperada

```
mbt-traffic-light-demo/
├── modeljunit-implementation/
│   ├── lib/
│   │   └── modeljunit-2.5.jar    ← IMPORTANTE: Descargar manualmente
│   ├── src/
│   └── pom.xml
├── xstate-implementation/
│   ├── node_modules/              ← Se crea con npm install
│   ├── src/
│   ├── package.json
│   └── visualizer.html
├── scripts/
├── README.md
└── QUICKSTART.md                  ← Estás aquí
```

## ❌ Solución de Problemas Comunes

### "Cannot find modeljunit jar"
**Solución**: Descarga `modeljunit-2.5.jar` y colócalo en `modeljunit-implementation/lib/`

### "Maven not found"
**Solución**:
```bash
# Instalar Maven
# Windows: choco install maven
# Mac: brew install maven
# Linux: sudo apt install maven
```

### "Module not found" en XState
**Solución**:
```bash
cd xstate-implementation
rm -rf node_modules package-lock.json
npm install
```

### "Java version not compatible"
**Solución**: Asegúrate de usar Java 8 o superior
```bash
java -version
# Si es necesario, actualizar JAVA_HOME
```

## 📝 Checklist de Pre-Presentación

- [ ] Java instalado y funcionando
- [ ] Maven instalado y funcionando
- [ ] Node.js y npm instalados
- [ ] ModelJUnit JAR descargado en `lib/`
- [ ] Dependencias de npm instaladas
- [ ] Pruebas de ModelJUnit ejecutándose correctamente
- [ ] Pruebas de XState ejecutándose correctamente
- [ ] Visualizador HTML abriendo correctamente
- [ ] Script de demostración probado

## 🎯 Comandos Esenciales

```bash
# Ejecutar TODAS las pruebas
.\scripts\run-tests.bat                    # Windows
./scripts/run-tests.sh                     # Linux/Mac

# Demo completa para presentación
.\scripts\demo-presentation.bat            # Windows

# Solo pruebas de ModelJUnit
cd modeljunit-implementation && mvn test

# Solo pruebas de XState
cd xstate-implementation && npm test

# Abrir visualizador
start xstate-implementation\visualizer.html  # Windows
open xstate-implementation/visualizer.html   # Mac
xdg-open xstate-implementation/visualizer.html  # Linux
```

## 📚 Documentación Completa

Para más detalles, consulta:
- `README.md` - Documentación completa del proyecto
- `modeljunit-implementation/SETUP-MODELJUNIT.md` - Configuración de ModelJUnit
- `modeljunit-implementation/lib/README.md` - Instrucciones del JAR

## 🆘 Ayuda

Si tienes problemas, contacta al equipo:
- Silvia Aguilar - B80129
- Pablo Cascante - C11731
- Javier Pupo - C06103
- Alexander Quesada - C16131
- Christian Rojas - B86958

---

**¡Listo para la presentación!** 🎉

**Universidad de Costa Rica** | **CI-0142 Pruebas de Software**
