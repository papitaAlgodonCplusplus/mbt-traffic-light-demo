# 📊 Resumen Ejecutivo - Semáforo Inteligente MBT

> **Universidad de Costa Rica** | **CI-0142 Pruebas de Software** | **2025**

## 🎯 Objetivo del Proyecto

Demostrar las capacidades del **Model-Based Testing (MBT)** mediante la implementación de un Sistema de Semáforo Inteligente usando dos herramientas líderes en la industria: **ModelJUnit** (Java) y **XState** (JavaScript).

## 👥 Equipo

- Silvia Aguilar - B80129
- Pablo Cascante - C11731
- Javier Pupo - C06103
- Alexander Quesada - C16131
- Christian Rojas - B86958

## 📋 Descripción del Sistema

**Sistema**: Semáforo Inteligente con Botón Peatonal

**Características**:
- 5 estados: Verde, Amarillo, Rojo, Peatonal, Intermitente (modo nocturno)
- Transiciones automáticas basadas en temporizadores
- Solicitud de cruce peatonal mediante botón
- Modo nocturno automático (10 PM - 6 AM)

## 🛠️ Tecnologías Utilizadas

| Herramienta | Tecnología | Versión | Licencia |
|-------------|------------|---------|----------|
| **ModelJUnit** | Java | 2.5 | GNU LGPL v2.1 |
| **XState** | JavaScript | 5.18.2 | MIT |
| Maven | Build tool | 3.0+ | Apache 2.0 |
| Jest | Testing framework | 29.7.0 | MIT |
| JUnit | Testing framework | 4.13.2 | EPL 1.0 |

## 📊 Resultados Obtenidos

### Métricas de Cobertura

#### ModelJUnit
- ✅ **Cobertura de Estados**: 100% (5/5)
- ✅ **Cobertura de Transiciones**: >90%
- ✅ **Cobertura de Acciones**: 100% (4/4)
- ✅ **Casos de prueba generados**: 50+ automáticamente

#### XState
- ✅ **Cobertura de Estados**: 100%
- ✅ **Cobertura de Transiciones**: 100%
- ✅ **Cobertura de Código**: >85%
- ✅ **Tests implementados**: 10+ (manuales + generados)

### Tiempo de Desarrollo

| Actividad | Horas |
|-----------|-------|
| Investigación y diseño del modelo | 8h |
| Implementación ModelJUnit | 10h |
| Implementación XState | 8h |
| Testing y debugging | 6h |
| Documentación | 5h |
| **TOTAL** | **37h** |

## ✅ Logros Principales

1. ✨ **Implementación exitosa** de MBT en dos ecosistemas diferentes
2. 🎯 **100% de cobertura de estados** en ambas herramientas
3. 🚀 **Generación automática** de casos de prueba (ModelJUnit)
4. 📊 **Visualización interactiva** del modelo (XState)
5. 📚 **Documentación completa** y reutilizable

## 🔍 Comparación de Herramientas

### ModelJUnit

**Ventajas**:
- ✅ Generación automática exhaustiva de casos de prueba
- ✅ Múltiples algoritmos de exploración (Random Walk, Greedy, All-Round-Trips)
- ✅ Métricas detalladas de cobertura
- ✅ Ideal para sistemas enterprise Java

**Desventajas**:
- ❌ No disponible en Maven Central (instalación manual)
- ❌ Curva de aprendizaje con anotaciones
- ❌ Solo para testing (no se usa en producción)
- ❌ Documentación limitada

**Recomendado para**:
- Proyectos Java/Enterprise
- Sistemas críticos que requieren cobertura exhaustiva
- Equipos con experiencia en JUnit

### XState

**Ventajas**:
- ✅ Visualización gráfica interactiva
- ✅ Mismo código en testing y producción
- ✅ Excelente integración con React, Vue, Angular
- ✅ Comunidad activa y documentación extensa

**Desventajas**:
- ❌ Menos exhaustivo por defecto que ModelJUnit
- ❌ Requiere @xstate/test adicional para MBT puro
- ❌ Curva de aprendizaje con statecharts complejos

**Recomendado para**:
- Aplicaciones web/móviles modernas
- Proyectos que necesitan visualización del modelo
- Equipos JavaScript/TypeScript

## 🎓 Lecciones Aprendidas

### Técnicas

1. **Modelado es clave**: Un buen modelo genera mejores pruebas
2. **Visualización ayuda**: Ver el grafo de estados facilita debugging
3. **Generación automática ahorra tiempo**: 50+ tests generados vs escribirlos manualmente
4. **Diferentes herramientas, diferentes fortalezas**: No hay "mejor" herramienta absoluta

### Retos Superados

1. **Sincronización de tiempos**: ModelJUnit no maneja temporizadores nativamente
   - *Solución*: Sistema de eventos discretos con contadores

2. **Instalación de ModelJUnit**: No está en Maven Central
   - *Solución*: Documentación clara y scripts de instalación

3. **Generación de tests en XState**: No tan automático como ModelJUnit
   - *Solución*: Uso de @xstate/test para path generation

4. **Visualización unificada**: Diferentes formatos de reporte
   - *Solución*: Visualizador HTML custom para demostración

## 💡 Recomendaciones

### Para Futuros Proyectos

1. **Comenzar con el modelo**: Diseñar el modelo de estados ANTES de implementar
2. **Usar ambas herramientas**: Si es posible, combinar para diferentes perspectivas
3. **Automatizar desde el inicio**: Integrar MBT en CI/CD temprano
4. **Documentar el modelo**: Un modelo bien documentado facilita mantenimiento

### Para Selección de Herramienta

**Usar ModelJUnit si**:
- Tu proyecto es Java/JVM
- Necesitas cobertura exhaustiva
- El testing es crítico (sistemas médicos, financieros, etc.)

**Usar XState si**:
- Tu proyecto es JavaScript/web
- Quieres usar el modelo en producción
- La visualización es importante para tu equipo

**Usar ambas si**:
- Tienes tiempo y recursos
- Quieres validar el modelo desde diferentes perspectivas
- Estás investigando MBT para tu organización

## 📈 Impacto del Proyecto

### Académico
- ✅ Dominio de conceptos de Model-Based Testing
- ✅ Experiencia práctica con herramientas industriales
- ✅ Comparación crítica de diferentes enfoques

### Profesional
- ✅ Habilidades aplicables en la industria
- ✅ Portfolio de proyecto completo
- ✅ Experiencia con testing automatizado avanzado

## 🚀 Trabajo Futuro

### Extensiones Propuestas

1. **Modo de Emergencia**: Luz roja parpadeante para vehículos de emergencia
2. **Sensores de Tráfico**: Ajustar tiempos según volumen de tráfico
3. **Múltiples Cruces**: Coordinación de semáforos en intersecciones
4. **Machine Learning**: Optimizar tiempos basado en patrones históricos

### Mejoras Técnicas

1. **CI/CD**: Integración con GitHub Actions
2. **Docker**: Containerización para fácil despliegue
3. **Dashboard**: Métricas en tiempo real
4. **Reportes**: Exportación automática de resultados

## 📊 ROI del Model-Based Testing

### Beneficios Cuantificables

| Métrica | Sin MBT | Con MBT | Mejora |
|---------|---------|---------|--------|
| Casos de prueba escritos | 50 | 10 | **80% menos esfuerzo** |
| Cobertura de estados | ~60% | 100% | **+40%** |
| Tiempo de testing | 20h | 8h | **60% más rápido** |
| Bugs encontrados | 3 | 7 | **2.3x más bugs** |

*Nota: Datos estimados basados en literatura y experiencia del proyecto*

### Beneficios Cualitativos

- 🎯 Mayor confianza en la calidad del software
- 📖 Documentación viva del comportamiento del sistema
- 🔍 Descubrimiento de casos edge inesperados
- 🛡️ Reducción de riesgo en producción

## 🎯 Conclusión

El Model-Based Testing demostró ser una técnica poderosa para:

1. **Automatizar** la generación de casos de prueba
2. **Maximizar** la cobertura de testing
3. **Reducir** el esfuerzo manual
4. **Documentar** el comportamiento del sistema

Tanto **ModelJUnit** como **XState** son herramientas viables y poderosas, cada una con sus fortalezas en diferentes contextos.

La inversión en aprender y aplicar MBT se justifica por:
- ✅ Ahorro de tiempo en el largo plazo
- ✅ Mayor calidad del software
- ✅ Mejor documentación
- ✅ Reducción de costos de mantenimiento

## 📚 Artefactos Entregables

| Artefacto | Descripción | Ubicación |
|-----------|-------------|-----------|
| **Código Fuente** | Implementaciones completas | `modeljunit-implementation/`, `xstate-implementation/` |
| **Documentación** | README, guías, diagramas | Archivos `.md` en raíz |
| **Scripts** | Automatización de pruebas | `scripts/` |
| **Visualizador** | Demo interactiva | `xstate-implementation/visualizer.html` |
| **Reportes de Pruebas** | Resultados de ejecución | Generados por `mvn test` y `npm test` |
| **Presentación** | Notas y guía | `PRESENTATION-NOTES.md` |

## 🏆 Reconocimientos

Este proyecto fue posible gracias a:

- **Profesor Rubén González Villanueva**: Guía y retroalimentación
- **Universidad de Costa Rica**: Recursos y apoyo académico
- **Comunidades Open Source**: ModelJUnit, XState, y ecosistemas Java/JavaScript

---

## 📞 Contacto

Para más información sobre este proyecto:

**Equipo MBT - Universidad de Costa Rica**

- 📧 Email: [a través del profesor]
- 🏫 Institución: Universidad de Costa Rica - ECCI
- 📚 Curso: CI-0142 Pruebas de Software

---

**Generado el**: Octubre 2025
**Versión**: 1.0
**Estado**: ✅ Completo y funcional

---

*"Model-Based Testing: De modelos formales a pruebas automáticas"*
