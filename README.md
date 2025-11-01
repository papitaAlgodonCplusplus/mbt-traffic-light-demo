# 🚦 Semáforo Inteligente - Model-Based Testing Demo

> Caso práctico de Model-Based Testing usando ModelJUnit y XState

## 📋 Descripción del Proyecto

Este proyecto implementa un **Sistema de Semáforo Inteligente con Botón Peatonal** para demostrar las capacidades del Model-Based Testing (MBT) utilizando dos herramientas principales:

- **ModelJUnit**: Framework de MBT para Java que extiende JUnit
- **XState**: Biblioteca de máquinas de estado para JavaScript/TypeScript

### Sistema Bajo Prueba

El semáforo inteligente modela los siguientes **estados**:

- 🟢 **VERDE**: Luz verde para vehículos
- 🟡 **AMARILLO**: Luz amarilla de transición
- 🔴 **ROJO**: Luz roja para vehículos
- 🚶 **PEATONAL**: Luz verde para peatones (roja para vehículos)
- ⚡ **INTERMITENTE**: Modo nocturno con luz amarilla intermitente

### Eventos/Transiciones

- ⏱️ **Temporizador automático**: Cambio de estado después de un tiempo definido
- 🚶 **Botón peatonal presionado**: Solicitud de cruce peatonal
- 🌙 **Activación modo nocturno**: Después de las 10 PM
- ☀️ **Desactivación modo nocturno**: Después de las 6 AM

---

## 🎓 Información Académica

**Universidad de Costa Rica**
**Escuela de Ciencias de Computación e Informática**
**Curso**: CI-0142 Pruebas de Software
**Profesor**: Rubén González Villanueva

### 👥 Equipo de Desarrollo

- Silvia Aguilar - B80129
- Pablo Cascante - C11731
- Javier Pupo - C06103
- Alexander Quesada - C16131
- Christian Rojas - B86958

---

## 📁 Estructura del Proyecto

```
mbt-traffic-light-demo/
├── modeljunit-implementation/          # Implementación con ModelJUnit (Java)
│   ├── src/
│   │   ├── main/java/
│   │   │   └── TrafficLightModel.java  # Modelo del semáforo
│   │   └── test/java/
│   │       └── TrafficLightTest.java   # Suite de pruebas
│   ├── lib/                            # Dependencias locales
│   │   └── modeljunit-2.5.jar         # (descargar manualmente)
│   └── pom.xml                         # Configuración Maven
│
├── xstate-implementation/              # Implementación con XState (JavaScript)
│   ├── src/
│   │   ├── trafficLightMachine.js     # Máquina de estados
│   │   └── trafficLight.test.js       # Suite de pruebas
│   ├── package.json                    # Configuración npm
│   └── visualizer.html                 # Visualizador interactivo
│
├── scripts/                            # Scripts de automatización
│   ├── run-tests.bat                   # Ejecutar todas las pruebas (Windows)
│   ├── run-tests.sh                    # Ejecutar todas las pruebas (Unix)
│   └── demo-presentation.bat           # Script para la presentación
│
└── README.md                           # Este archivo
```

---

## 🚀 Instalación y Configuración

### Prerrequisitos

#### Para ModelJUnit (Java):
- ☕ **Java JDK 8 o superior** ([Descargar](https://www.oracle.com/java/technologies/javase-downloads.html))
- 📦 **Maven 3.0+** ([Descargar](https://maven.apache.org/download.cgi))
- 📚 **ModelJUnit 2.5** ([Descargar](https://sourceforge.net/projects/modeljunit/files/ModelJUnit-2.5/))

#### Para XState (JavaScript):
- 🟢 **Node.js 16+** ([Descargar](https://nodejs.org/))
- 📦 **npm** (incluido con Node.js)

### Instalación Paso a Paso

#### 1. Configurar ModelJUnit

```bash
# Navegar al directorio de ModelJUnit
cd modeljunit-implementation

# Crear directorio para librerías
mkdir lib

# Descargar ModelJUnit 2.5 y colocar el JAR en lib/
# URL: https://sourceforge.net/projects/modeljunit/files/ModelJUnit-2.5/

# Compilar el proyecto
mvn clean compile

# Ejecutar las pruebas
mvn test
```

#### 2. Configurar XState

```bash
# Navegar al directorio de XState
cd xstate-implementation

# Instalar dependencias
npm install

# Ejecutar las pruebas
npm test

# Ejecutar con cobertura
npm test -- --coverage
```

---

## 🧪 Ejecutar las Pruebas

### Opción 1: Scripts Automatizados (Recomendado para Presentación)

#### Windows:
```cmd
.\scripts\run-tests.bat
```

#### Linux/Mac:
```bash
chmod +x scripts/run-tests.sh
./scripts/run-tests.sh
```

### Opción 2: Manual

#### ModelJUnit:
```bash
cd modeljunit-implementation
mvn test
```

#### XState:
```bash
cd xstate-implementation
npm test
```

---

## 📊 Visualización Interactiva

Para la **demostración en vivo** durante la presentación:

### 1. Abrir el Visualizador

```bash
# Opción 1: Doble clic en el archivo
xstate-implementation/visualizer.html

# Opción 2: Servir con un servidor local
cd xstate-implementation
npx http-server -p 8080
# Luego abrir: http://localhost:8080/visualizer.html
```

### 2. Interactuar con el Semáforo

El visualizador permite:
- 🚶 **Presionar el botón peatonal** para solicitar cruce
- 🌙 **Activar modo nocturno** para ver el estado intermitente
- ☀️ **Desactivar modo nocturno** para volver a operación normal
- 🔄 **Reiniciar** el sistema
- 📊 **Ver métricas** de contexto en tiempo real
- 📝 **Log de eventos** con timestamp

---

## 🎯 Casos de Prueba Principales

### ModelJUnit

1. **Random Walk**: Exploración aleatoria del modelo
2. **Greedy Random**: Exploración con preferencia por estados no visitados
3. **State Coverage**: Verificación de cobertura de todos los estados
4. **Normal Flow**: Ciclo normal sin intervención peatonal
5. **Pedestrian Flow**: Ciclo completo con botón peatonal
6. **Night Mode**: Activación y desactivación del modo nocturno

### XState

1. **Model-Based Test Generation**: Generación automática de paths
2. **Pedestrian Button Flow**: Flujo con solicitud peatonal
3. **Night Mode Activation**: Modo nocturno
4. **Complete Cycle**: Secuencia verde → amarillo → rojo → peatonal
5. **Invariants Testing**: Verificación de invariantes del sistema

---

## 📈 Métricas de Cobertura

### ModelJUnit
- ✅ **Cobertura de Estados**: 100% (5/5 estados)
- ✅ **Cobertura de Transiciones**: >90%
- ✅ **Cobertura de Acciones**: 100% (4/4 acciones)

### XState
- ✅ **Cobertura de Estados**: 100%
- ✅ **Cobertura de Transiciones**: 100%
- ✅ **Cobertura de Código**: >85%

---

## 🔍 Algoritmos de Generación de Pruebas

### ModelJUnit

| Algoritmo | Descripción | Uso |
|-----------|-------------|-----|
| **Random Walk** | Exploración aleatoria | Pruebas de humo rápidas |
| **Greedy Random** | Prioriza estados no visitados | Maximizar cobertura |
| **All Round Trips** | Todos los ciclos posibles | Cobertura exhaustiva |

### XState

| Método | Descripción | Uso |
|--------|-------------|-----|
| **Shortest Paths** | Caminos más cortos a cada estado | Cobertura básica |
| **Simple Paths** | Todos los caminos simples | Cobertura completa |
| **Model-Based Testing** | Generación automática de casos | MBT puro |

---

## 🎬 Script de Demostración para Presentación

### Preparación (5 minutos antes)

```bash
# 1. Verificar que todo funcione
cd mbt-traffic-light-demo
.\scripts\run-tests.bat

# 2. Abrir el visualizador en navegador
start xstate-implementation\visualizer.html

# 3. Preparar terminal para demostración en vivo
```

### Durante la Presentación

1. **Introducción (2 min)**
   - Mostrar estructura del proyecto
   - Explicar el sistema bajo prueba

2. **Demo ModelJUnit (5 min)**
   ```bash
   cd modeljunit-implementation
   mvn test
   ```
   - Mostrar output de Random Walk
   - Explicar métricas de cobertura
   - Mostrar código del modelo

3. **Demo XState (5 min)**
   ```bash
   cd xstate-implementation
   npm test
   ```
   - Mostrar tests ejecutándose
   - Abrir visualizador HTML
   - **Interacción en vivo**: Presionar botones y mostrar transiciones

4. **Comparación (3 min)**
   - Ventajas/desventajas de cada herramienta
   - Casos de uso recomendados

---

## 🔧 Solución de Problemas

### ModelJUnit

**Error: "Cannot find modeljunit jar"**
```bash
# Solución: Descargar manualmente y colocar en lib/
# URL: https://sourceforge.net/projects/modeljunit/files/ModelJUnit-2.5/
```

**Error: "Java version not compatible"**
```bash
# Solución: Usar JDK 8 o superior
java -version
# Si es necesario, actualizar JAVA_HOME
```

### XState

**Error: "Module not found"**
```bash
# Solución: Reinstalar dependencias
cd xstate-implementation
rm -rf node_modules package-lock.json
npm install
```

**Error: "Jest tests failing"**
```bash
# Solución: Verificar configuración de Babel
npm install --save-dev @babel/core @babel/preset-env babel-jest
```

---

## 📚 Referencias

### Documentación Oficial

- [ModelJUnit Documentation](http://www.cs.waikato.ac.nz/~marku/mbt/modeljunit/)
- [XState Documentation](https://stately.ai/docs/xstate)
- [XState Visualizer](https://stately.ai/viz)
- [@xstate/test](https://xstate.js.org/docs/packages/xstate-test/)

### Artículos Académicos

1. M. Utting et al., "A taxonomy of model-based testing approaches" (2012)
2. A. Dias Neto et al., "A survey on model-based testing approaches" (2007)
3. D. Harel, "Statecharts: A visual formalism for complex systems" (1987)

### Recursos Adicionales

- [Practical Model-Based Testing (Utting & Legeard)](https://www.amazon.com/Practical-Model-Based-Testing-Mark-Utting/dp/0123725011)
- [JUnit Documentation](https://junit.org/junit4/)
- [Jest Testing Framework](https://jestjs.io/)

---

## 🎓 Lecciones Aprendidas

### ModelJUnit

**Ventajas:**
- ✅ Generación automática exhaustiva de casos de prueba
- ✅ Excelente para sistemas empresariales Java
- ✅ Métricas de cobertura detalladas
- ✅ Múltiples algoritmos de exploración

**Desafíos:**
- ⚠️ Curva de aprendizaje con anotaciones
- ⚠️ No está en Maven Central (instalación manual)
- ⚠️ Documentación limitada

### XState

**Ventajas:**
- ✅ Visualización gráfica interactiva
- ✅ Excelente integración con ecosistema JavaScript
- ✅ Statecharts jerárquicos y paralelos
- ✅ Comunidad activa

**Desafíos:**
- ⚠️ Requiere @xstate/test adicional para MBT puro
- ⚠️ Menos exhaustivo que ModelJUnit por defecto
- ⚠️ Necesita configuración adicional para testing

---

## 🚀 Trabajo Futuro

- [ ] Implementar modo de emergencia
- [ ] Agregar sensores de tráfico simulados
- [ ] Integración con CI/CD (GitHub Actions)
- [ ] Dashboard de métricas en tiempo real
- [ ] Exportar reportes de cobertura en formato HTML
- [ ] Dockerizar ambas implementaciones

---

## 📄 Licencia

Este proyecto es para fines educativos en el curso CI-0142 Pruebas de Software de la Universidad de Costa Rica.

- **ModelJUnit**: GNU LGPL v2.1
- **XState**: MIT License

---

## 🙏 Agradecimientos

- Profesor Rubén González Villanueva por la guía en el curso
- Universidad de Costa Rica - Escuela de Ciencias de Computación e Informática
- Comunidades de ModelJUnit y XState por las herramientas open source

---

## 📞 Contacto

Para preguntas sobre este proyecto, contactar a cualquier miembro del equipo:

- Silvia Aguilar - B80129
- Pablo Cascante - C11731
- Javier Pupo - C06103
- Alexander Quesada - C16131
- Christian Rojas - B86958

---

**Universidad de Costa Rica** | **CI-0142 Pruebas de Software** | **2025**
