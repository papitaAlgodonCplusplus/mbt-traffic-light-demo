# 🎤 Notas para la Presentación

> Guía rápida para la exposición del Semáforo Inteligente MBT

## ⏱️ Timing Sugerido (15 minutos total)

| Sección | Duración | Responsable Sugerido |
|---------|----------|---------------------|
| Introducción | 2 min | Todos |
| Demo ModelJUnit | 4 min | - |
| Demo XState | 4 min | - |
| Comparación | 3 min | - |
| Conclusiones & Q&A | 2 min | Todos |

## 📋 Checklist Pre-Presentación

### 30 Minutos Antes
- [ ] Verificar que el proyector funciona
- [ ] Probar resolución de pantalla
- [ ] Cerrar aplicaciones innecesarias
- [ ] Tener navegador listo con tabs necesarias

### 15 Minutos Antes
- [ ] Ejecutar `demo-presentation.bat` para abrir todas las ventanas
- [ ] Verificar que el visualizador carga correctamente
- [ ] Probar audio (si hay video/demo)
- [ ] Tener agua disponible

### 5 Minutos Antes
- [ ] Ejecutar `run-tests.bat` una vez para verificar que todo funciona
- [ ] Organizar ventanas en pantalla
- [ ] Respirar profundo y estar listo

## 🎬 Script de Presentación Detallado

### 1. Introducción (2 min)

**Presentador 1:**

```
Buenos días/tardes. Somos [nombres] y hoy presentaremos nuestro proyecto sobre
Model-Based Testing utilizando las herramientas ModelJUnit y XState.

[MOSTRAR SLIDE 1: Portada]

Nuestro caso de estudio es un Sistema de Semáforo Inteligente con botón peatonal
que incluye modo nocturno.

[MOSTRAR explorador de archivos con estructura]

Como pueden ver, tenemos dos implementaciones:
- ModelJUnit para Java/Enterprise
- XState para JavaScript/Web
```

**Puntos clave a mencionar:**
- ✅ Model-Based Testing = Generación automática de casos de prueba
- ✅ Dos ecosistemas diferentes (Java vs JavaScript)
- ✅ Mismo modelo, diferentes herramientas

---

### 2. Explicación del Modelo (2 min)

**Presentador 2:**

```
[ABRIR visualizer.html]

Nuestro semáforo tiene 5 estados:
1. VERDE - Paso de vehículos
2. AMARILLO - Transición
3. ROJO - Alto para vehículos
4. PEATONAL - Paso de peatones
5. INTERMITENTE - Modo nocturno

[IR PRESIONANDO BOTONES EN EL VISUALIZADOR]

Los eventos son:
- Temporizador automático
- Botón peatonal
- Modo nocturno ON/OFF
```

**Demo interactiva:**
1. Presionar "Botón Peatonal" → Mostrar cómo cambia el contexto
2. Esperar transición automática
3. Activar modo nocturno → Mostrar luz intermitente
4. Desactivar modo nocturno → Volver a verde

**Puntos clave:**
- ✅ Mostrar log de eventos
- ✅ Explicar contexto (buttonPressed, nightMode)
- ✅ Mencionar que esto es el MODELO que vamos a probar

---

### 3. Demo ModelJUnit (4 min)

**Presentador 3:**

```
[CAMBIAR A VENTANA: ModelJUnit Demo]

ModelJUnit es una biblioteca Java que extiende JUnit para implementar
pruebas basadas en modelos.

[MOSTRAR TrafficLightModel.java brevemente]

Como pueden ver, usamos anotaciones:
- @Action para definir acciones
- Guards para condiciones

Ahora ejecutemos las pruebas...

[EJECUTAR: mvn test]
```

**Mientras se ejecutan las pruebas, explicar:**

```
ModelJUnit ejecuta varios algoritmos:

1. Random Walk - Exploración aleatoria
   → Útil para smoke testing rápido

2. Greedy Random - Prioriza estados no visitados
   → Maximiza cobertura

3. State Coverage - Verifica todos los estados
   → Asegura que ningún estado quede sin probar
```

**Cuando terminen las pruebas:**

```
[SEÑALAR EN EL OUTPUT]

Observen las métricas:
- Cobertura de Estados: X% (X/5 estados)
- Cobertura de Transiciones: X%
- Cobertura de Acciones: X% (X/4 acciones)

ModelJUnit generó automáticamente N transiciones y encontró [mencionar
cualquier issue si lo hay, o confirmar que todo pasó].
```

**Puntos clave:**
- ✅ Enfatizar "generación automática"
- ✅ Mostrar métricas de cobertura
- ✅ Mencionar que no escribimos los test cases manualmente

---

### 4. Demo XState (4 min)

**Presentador 4:**

```
[CAMBIAR A VENTANA: XState Demo]

XState es una biblioteca moderna de JavaScript para máquinas de estado.
A diferencia de ModelJUnit, XState se usa tanto en producción como en testing.

[MOSTRAR trafficLightMachine.js brevemente]

La sintaxis es diferente - usamos objetos JavaScript para definir estados
y transiciones. Esto lo hace muy visual y fácil de entender.

[EJECUTAR: npm test]
```

**Mientras se ejecutan las pruebas:**

```
XState + @xstate/test nos da:

1. Model-based test generation
   → Genera paths automáticamente

2. Shortest path coverage
   → Camino más corto a cada estado

3. Verificación de invariantes
   → Propiedades que siempre deben cumplirse

Lo interesante de XState es que la misma máquina que usamos para
testing se puede usar en producción.
```

**Cuando terminen las pruebas:**

```
[SEÑALAR RESULTADOS]

Como ven, todas las pruebas pasaron:
- Normal flow ✓
- Pedestrian flow ✓
- Night mode ✓
- Invariants ✓

Y tenemos X% de cobertura de código.
```

**Puntos clave:**
- ✅ Mencionar que se puede usar en producción
- ✅ Destacar la visualización
- ✅ Comparar con ModelJUnit sutilmente

---

### 5. Comparación (3 min)

**Presentador 5:**

```
[MOSTRAR tabla comparativa en slide o pizarra]

Comparemos ambas herramientas:

MODELJUNIT:
✅ Generación muy exhaustiva
✅ Múltiples algoritmos (Random, Greedy, All-Round-Trips)
✅ Métricas detalladas de cobertura
❌ Solo para testing (no producción)
❌ Curva de aprendizaje con anotaciones
❌ No está en Maven Central

XSTATE:
✅ Visualización interactiva hermosa
✅ Mismo código en testing y producción
✅ Gran comunidad y documentación
✅ Integración con React, Vue, etc.
❌ Menos exhaustivo por default
❌ Requiere @xstate/test adicional

¿Cuándo usar cada una?

ModelJUnit:
- Sistemas enterprise Java
- Necesitas cobertura exhaustiva
- Testing puro, no producción

XState:
- Aplicaciones web/móviles
- Necesitas visualización
- Quieres usar el modelo en producción
```

**Puntos clave:**
- ✅ No hay "ganador absoluto"
- ✅ Depende del contexto
- ✅ Ambas son poderosas para MBT

---

### 6. Conclusiones (2 min)

**Presentador 6 (o Todos):**

```
Para concluir:

1. Model-Based Testing es poderoso
   → Genera casos automáticamente
   → Mayor cobertura con menos esfuerzo

2. Ambas herramientas tienen su lugar
   → ModelJUnit para Java enterprise
   → XState para JavaScript/web

3. Los beneficios del MBT:
   → Encuentra casos edge que no pensaríamos manualmente
   → Reduce tiempo de testing
   → Documenta comportamiento del sistema

4. Lecciones aprendidas:
   → [Mencionar 1-2 retos del PDF]
   → [Mencionar 1-2 soluciones aplicadas]

¿Preguntas?
```

## 💡 Tips de Presentación

### Hacer ✅
- Practicar varias veces antes
- Tener backup slides por si falla la demo
- Sonreír y hacer contacto visual
- Usar ejemplos concretos
- Dejar tiempo para preguntas

### NO Hacer ❌
- Leer directamente de las slides
- Dar la espalda a la audiencia
- Hablar muy rápido
- Usar mucho jargon técnico sin explicar
- Ignorar preguntas difíciles

## 🔧 Plan B (Si algo falla)

### Si falla ModelJUnit:
1. Mostrar screenshots pre-tomados de la ejecución
2. Explicar qué DEBERÍA pasar
3. Mostrar código del modelo
4. Continuar con XState

### Si falla XState:
1. Usar el visualizador HTML (que es standalone)
2. Explicar basándose en el código
3. Mostrar screenshots
4. Continuar con comparación

### Si falla el visualizador:
1. Dibujar en pizarra el diagrama de estados
2. Usar slides de respaldo
3. Demostrar con pseudocódigo

### Si falla TODO:
1. Tener slides con screenshots
2. Explicar conceptos teóricamente
3. Mostrar código en papel/impreso
4. Pedir disculpas y ofrecer demo después

## 📊 Slides Sugeridas

1. **Portada**
   - Título: Semáforo Inteligente MBT
   - Nombres del equipo
   - Logo UCR

2. **¿Qué es MBT?**
   - Definición
   - Beneficios
   - Comparación con testing tradicional

3. **Nuestro Caso de Estudio**
   - Diagrama del semáforo
   - Estados y transiciones
   - Por qué elegimos este caso

4. **ModelJUnit**
   - Logo y descripción
   - Características principales
   - Snippet de código

5. **XState**
   - Logo y descripción
   - Características principales
   - Screenshot del visualizador

6. **Comparación**
   - Tabla lado a lado
   - Ventajas/desventajas

7. **Resultados**
   - Métricas de cobertura
   - Screenshots de pruebas

8. **Conclusiones**
   - Lecciones aprendidas
   - Recomendaciones
   - Agradecimientos

## 🎯 Preguntas Frecuentes Anticipadas

**P: ¿Por qué usar MBT en vez de pruebas normales?**
R: MBT genera casos automáticamente y encuentra edge cases que no pensaríamos. Reduce esfuerzo y aumenta cobertura.

**P: ¿Cuál herramienta es mejor?**
R: Depende. ModelJUnit para Java enterprise con cobertura exhaustiva. XState para web con necesidad de visualización y uso en producción.

**P: ¿Cuánto tiempo tomó implementar esto?**
R: [Ser honesto] Aproximadamente X horas. La curva de aprendizaje fue lo más retador.

**P: ¿Esto se usa en la industria real?**
R: Sí. [Mencionar ejemplos del PDF: Microsoft, Amazon, Spotify usan XState]

**P: ¿Encontraron bugs con esto?**
R: [Si sí, mencionar. Si no:] No encontramos bugs porque desarrollamos el modelo y la implementación juntos, pero en un sistema real, MBT es excelente para encontrar bugs.

**P: ¿Cuál fue el mayor reto?**
R: [Mencionar del PDF - probablemente sincronización de tiempos o configuración de ModelJUnit]

## 📞 División de Roles Sugerida

| Rol | Responsable |
|-----|-------------|
| Introducción | Persona 1 |
| Explicación del Modelo | Persona 2 |
| Demo ModelJUnit | Persona 3 |
| Demo XState | Persona 4 |
| Comparación | Persona 5 |
| Conclusiones | Todos |
| Manejo técnico (cambiar ventanas, etc.) | Persona designada |
| Time keeper (controlar tiempo) | Persona designada |

## ✨ Cierre Memorable

```
El Model-Based Testing no es magia - es sistematización.
Al modelar el comportamiento esperado, generamos pruebas
automáticamente y encontramos bugs que nunca hubiéramos
imaginado.

Como demostró nuestro semáforo inteligente, tanto ModelJUnit
como XState nos dan superpoderes de testing.

Gracias por su atención. ¿Preguntas?
```

---

**¡Mucha suerte en la presentación!** 🍀

**Universidad de Costa Rica** | **CI-0142 Pruebas de Software** | **2025**
