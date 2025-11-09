/**
 * trafficLightMachine.js
 *
 * Máquina de estados del semáforo inteligente implementada con XState
 *
 * Estados: verde, amarillo, rojo, peatonal, intermitente
 * Eventos: TIMER, PEDESTRIAN_BUTTON, NIGHT_MODE, DAY_MODE
 *
 * @author Grupo: Silvia Aguilar, Pablo Cascante, Javier Pupo, Alexander Quesada, Christian Rojas
 */

import { createMachine, assign } from 'xstate';

/**
 * Configuración de tiempos (en milisegundos)
 */
const TIMERS = {
  VERDE: 3000,      // 3 segundos en verde
  AMARILLO: 1000,   // 1 segundo en amarillo
  ROJO: 3000,       // 3 segundos en rojo
  PEATONAL: 5000    // 5 segundos para peatones
};

/**
 * Máquina de estados del semáforo
 */
export const trafficLightMachine = createMachine({
  id: 'trafficLight',
  initial: 'verde',

  // Contexto: datos compartidos entre estados
  context: () => ({
    buttonPressed: false,
    nightMode: false,
    pedestrianWaitingCount: 0,
    totalCycles: 0
  }),

  // Definición de estados
  states: {
    /**
     * Estado VERDE - Luz verde para vehículos
     */
    verde: {
      entry: assign({
        totalCycles: ({ context }) => context.totalCycles + 1
      }),

      on: {
        // Evento: presionar botón peatonal
        PEDESTRIAN_BUTTON: {
          actions: assign({
            buttonPressed: true,
            pedestrianWaitingCount: ({ context }) => context.pedestrianWaitingCount + 1
          })
        },

        // Evento: activar modo nocturno
        NIGHT_MODE: {
          target: 'intermitente',
          actions: assign({
            nightMode: true,
            buttonPressed: false
          })
        }
      },

      // Transición automática después del tiempo definido
      after: {
        [TIMERS.VERDE]: [
          // Si el botón fue presionado, ir a amarillo
          {
            target: 'amarillo',
            guard: ({ context }) => context.buttonPressed
          },
          // Sino, permanecer en verde (reiniciar timer)
          {
            target: 'verde',
            reenter: true
          }
        ]
      }
    },

    /**
     * Estado AMARILLO - Luz amarilla de transición
     */
    amarillo: {
      // En amarillo no se puede presionar el botón
      on: {
        NIGHT_MODE: {
          target: 'intermitente',
          actions: assign({
            nightMode: true,
            buttonPressed: false
          })
        }
      },

      after: {
        [TIMERS.AMARILLO]: 'rojo'
      }
    },

    /**
     * Estado ROJO - Luz roja para vehículos
     */
    rojo: {
      on: {
        NIGHT_MODE: {
          target: 'intermitente',
          actions: assign({
            nightMode: true,
            buttonPressed: false
          })
        }
      },

      after: {
        [TIMERS.ROJO]: [
          // Si había solicitud peatonal, dar paso peatonal
          {
            target: 'peatonal',
            guard: ({ context }) => context.buttonPressed,
            actions: assign({
              buttonPressed: false
            })
          },
          // Sino, volver a verde
          {
            target: 'verde'
          }
        ]
      }
    },

    /**
     * Estado PEATONAL - Luz verde para peatones
     */
    peatonal: {
      entry: 'notifyPedestrianCrossing',

      on: {
        NIGHT_MODE: {
          target: 'intermitente',
          actions: assign({
            nightMode: true
          })
        }
      },

      after: {
        [TIMERS.PEATONAL]: 'rojo'
      }
    },

    /**
     * Estado INTERMITENTE - Modo nocturno
     */
    intermitente: {
      entry: assign({
        buttonPressed: false
      }),

      on: {
        // Desactivar modo nocturno (volver a operación normal)
        DAY_MODE: {
          target: 'verde',
          actions: assign({
            nightMode: false
          })
        }
      }
    }
  }
}, {
  // Acciones definidas (implementaciones)
  actions: {
    notifyPedestrianCrossing: ({ context, event }) => {
      console.log('🚶 Peatones cruzando - Luz verde peatonal');
    }
  },

  // Guardas (condiciones) definidas
  guards: {
    buttonWasPressed: ({ context }) => context.buttonPressed
  }
});

/**
 * Servicio para inicializar la máquina
 */
export const createTrafficLightService = () => {
  return trafficLightMachine;
};

/**
 * Exportar para testing
 */
export default trafficLightMachine;
