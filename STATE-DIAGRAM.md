# 🚦 Diagrama de Estados - Semáforo Inteligente

## Diagrama Visual

```
                    ┌─────────────────────────────────────┐
                    │                                     │
                    │      SISTEMA INICIALIZADO           │
                    │                                     │
                    └──────────────┬──────────────────────┘
                                   │
                                   ▼
                    ┌──────────────────────────┐
                    │                          │
                    │   ESTADO: VERDE          │◄──────────────┐
                    │   (Vehículos pasan)      │               │
                    │                          │               │
                    └──────────┬───────────────┘               │
                               │                               │
                               │ Timer + Botón presionado      │
                               │                               │
                               ▼                               │
                    ┌──────────────────────────┐               │
                    │                          │               │
                    │   ESTADO: AMARILLO       │               │
                    │   (Precaución)           │               │
                    │                          │               │
                    └──────────┬───────────────┘               │
                               │                               │
                               │ Timer (1 segundo)             │
                               │                               │
                               ▼                               │
                    ┌──────────────────────────┐               │
                    │                          │               │
                    │   ESTADO: ROJO           │               │
                    │   (Vehículos detenidos)  │               │
                    │                          │               │
                    └──────┬────────┬──────────┘               │
                           │        │                          │
        Botón presionado   │        │ Sin botón               │
                           │        │                          │
                           ▼        └──────────────────────────┘
                ┌──────────────────────────┐
                │                          │
                │   ESTADO: PEATONAL       │
                │   (Peatones cruzan)      │
                │                          │
                └──────────┬───────────────┘
                           │
                           │ Timer (5 segundos)
                           │
                           ▼
                ┌──────────────────────────┐
                │                          │
                │   ESTADO: ROJO           │
                │   (Vehículos detenidos)  │
                │                          │
                └──────────────────────────┘
                           │
                           │ Timer
                           │
                           └──────────────────────────────────┐
                                                              │
                                                              ▼
                                                    ┌─────────────────┐
                                                    │   VERDE         │
                                                    └─────────────────┘


                    MODO NOCTURNO (desde cualquier estado)
                    ═════════════════════════════════════

            Cualquier Estado ──[NIGHT_MODE]──► INTERMITENTE ──[DAY_MODE]──► VERDE
                                                   (Amarillo
                                                  parpadeante)
```

## Estados del Sistema

| Estado | Descripción | Luz | Duración |
|--------|-------------|-----|----------|
| 🟢 **VERDE** | Vehículos pueden pasar | Verde ON | 3 segundos |
| 🟡 **AMARILLO** | Preparar para detenerse | Amarilla ON | 1 segundo |
| 🔴 **ROJO** | Vehículos detenidos | Roja ON | 3 segundos |
| 🚶 **PEATONAL** | Peatones cruzan (semáforo rojo) | Roja ON + Señal peatonal | 5 segundos |
| ⚡ **INTERMITENTE** | Modo nocturno | Amarilla PARPADEANDO | Indefinido |

## Eventos/Transiciones

| Evento | Desde Estado | A Estado | Condición |
|--------|--------------|----------|-----------|
| ⏱️ **Timer** | VERDE | VERDE | Sin botón presionado |
| ⏱️ **Timer + Botón** | VERDE | AMARILLO | Botón presionado |
| ⏱️ **Timer** | AMARILLO | ROJO | Siempre |
| ⏱️ **Timer** | ROJO | PEATONAL | Botón presionado |
| ⏱️ **Timer** | ROJO | VERDE | Sin botón presionado |
| ⏱️ **Timer** | PEATONAL | ROJO | Siempre |
| 🚶 **Botón Peatonal** | VERDE | VERDE | Marca botón como presionado |
| 🌙 **Modo Nocturno** | Cualquiera | INTERMITENTE | Hora > 10 PM |
| ☀️ **Modo Diurno** | INTERMITENTE | VERDE | Hora > 6 AM |

## Contexto del Sistema

```javascript
{
  buttonPressed: boolean,        // ¿Botón peatonal presionado?
  nightMode: boolean,            // ¿Modo nocturno activo?
  pedestrianWaitingCount: number, // Cantidad de solicitudes peatonales
  totalCycles: number            // Ciclos completos realizados
}
```

## Flujos Principales

### Flujo Normal (Sin Peatones)

```
VERDE (3s) → VERDE (3s) → VERDE (3s) → ...
```

El semáforo permanece en verde indefinidamente si no hay solicitudes peatonales.

### Flujo con Peatón

```
1. VERDE (vehículo circula)
   ↓
2. Usuario presiona botón peatonal
   ↓
3. VERDE (espera hasta fin de ciclo - 3s)
   ↓
4. AMARILLO (1s)
   ↓
5. ROJO (3s)
   ↓
6. PEATONAL (5s) ← Peatones cruzan
   ↓
7. ROJO (3s)
   ↓
8. VERDE (volver a flujo normal)
```

### Flujo Modo Nocturno

```
Cualquier Estado
   ↓ [Evento: NIGHT_MODE]
INTERMITENTE (amarillo parpadeante)
   ↓ [Permanece hasta DAY_MODE]
   ↓ [Evento: DAY_MODE]
VERDE
```

## Invariantes del Sistema

Propiedades que SIEMPRE deben cumplirse:

1. ✅ **Un solo estado activo**: El sistema nunca puede estar en dos estados simultáneamente
2. ✅ **Seguridad peatonal**: Solo se activa paso peatonal cuando el semáforo está en ROJO
3. ✅ **Transición ordenada**: VERDE → AMARILLO → ROJO (nunca VERDE → ROJO directamente)
4. ✅ **Botón en modo correcto**: El botón peatonal solo funciona en VERDE (modo diurno)
5. ✅ **Modo nocturno**: En INTERMITENTE, no hay transiciones automáticas excepto DAY_MODE

## Guardas (Guards)

Condiciones que deben cumplirse para permitir transiciones:

```java
// ModelJUnit
public boolean timerExpiredGuard() {
    return !nightMode;
}

public boolean pedestrianButtonGuard() {
    return currentState == VERDE && !nightMode;
}
```

```javascript
// XState
{
  cond: (context) => context.buttonPressed
}
```

## Casos de Prueba Derivados

Del modelo se derivan automáticamente:

### Casos Básicos
1. ✅ Transición VERDE → VERDE (sin intervención)
2. ✅ Transición VERDE → AMARILLO → ROJO → VERDE (ciclo normal)
3. ✅ Transición con botón peatonal: VERDE → AMARILLO → ROJO → PEATONAL → ROJO → VERDE

### Casos de Borde
4. ✅ Presionar botón en ROJO (debe ignorarse)
5. ✅ Presionar botón múltiples veces (solo cuenta una vez por ciclo)
6. ✅ Activar modo nocturno desde PEATONAL
7. ✅ Desactivar modo nocturno y volver a operación normal

### Casos de Error
8. ✅ Intentar transición inválida (ej: VERDE → PEATONAL directamente)
9. ✅ Estado sin temporizador definido
10. ✅ Contexto en estado inválido

## Métricas de Cobertura

### Cobertura de Estados
- **Total de estados**: 5
- **Estados cubiertos por pruebas**: 5
- **Cobertura**: 100%

### Cobertura de Transiciones
- **Total de transiciones posibles**: ~12
- **Transiciones cubiertas**: ~11-12
- **Cobertura**: >90%

### Cobertura de Acciones
- **Total de acciones**: 4 (timerExpired, pedestrianButton, activateNightMode, deactivateNightMode)
- **Acciones cubiertas**: 4
- **Cobertura**: 100%

## Análisis de Complejidad

### Complejidad Ciclomática
```
V(G) = E - N + 2P
Donde:
  E = número de aristas (transiciones) ≈ 12
  N = número de nodos (estados) = 5
  P = componentes conectados = 1

V(G) ≈ 12 - 5 + 2(1) = 9
```

**Interpretación**: Complejidad moderada, manejable con testing sistemático.

### Paths Independientes
Ejemplos de paths independientes que deben ser probados:

1. `VERDE → VERDE → VERDE ...`
2. `VERDE → AMARILLO → ROJO → VERDE`
3. `VERDE → AMARILLO → ROJO → PEATONAL → ROJO → VERDE`
4. `VERDE → INTERMITENTE → VERDE`
5. `PEATONAL → ROJO → VERDE`

## Implementación en las Herramientas

### ModelJUnit

```java
@State("VERDE")
public class TrafficLightModel implements FsmModel {
    private enum LightState { VERDE, AMARILLO, ROJO, PEATONAL, INTERMITENTE }

    @Action
    public void timerExpired() { /* lógica */ }

    @Action
    public void pedestrianButton() { /* lógica */ }
}
```

### XState

```javascript
const trafficLightMachine = createMachine({
  id: 'trafficLight',
  initial: 'verde',
  states: {
    verde: {
      on: { PEDESTRIAN_BUTTON: { actions: 'setButtonPressed' } },
      after: { 3000: [
        { target: 'amarillo', cond: 'buttonWasPressed' },
        { target: 'verde' }
      ]}
    },
    // ... otros estados
  }
});
```

## Referencias

- **Statecharts**: Harel, D. (1987). "Statecharts: A visual formalism for complex systems"
- **Model-Based Testing**: Utting & Legeard (2007). "Practical Model-Based Testing"
- **Finite State Machines**: Hopcroft & Ullman (1979). "Introduction to Automata Theory"

---

**Universidad de Costa Rica** | **CI-0142 Pruebas de Software** | **2025**
