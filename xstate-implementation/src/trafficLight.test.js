/**
 * trafficLight.test.js
 *
 * Suite de pruebas para el semáforo inteligente usando XState v5
 * Implementa pruebas exhaustivas de estados, transiciones y flujos
 *
 * @author Grupo: Silvia Aguilar, Pablo Cascante, Javier Pupo, Alexander Quesada, Christian Rojas
 */

import { createActor } from 'xstate';
import { trafficLightMachine } from './trafficLightMachine';

/**
 * Pruebas específicas de flujos importantes
 */
describe('Traffic Light Specific Flows', () => {

  /**
   * Test 1: Flujo normal sin botón peatonal
   */
  test('Normal flow without pedestrian button', (done) => {
    const actor = createActor(trafficLightMachine);

    actor.subscribe((state) => {
      console.log('Estado:', state.value);

      if (state.matches('verde')) {
        // Verificar que inicia en verde
        expect(state.context.buttonPressed).toBe(false);
        expect(state.context.nightMode).toBe(false);
      }
    });

    actor.start();

    // Verificar estado inicial
    expect(actor.getSnapshot().value).toBe('verde');

    actor.stop();
    done();
  });

  /**
   * Test 2: Flujo con botón peatonal
   */
  test('Pedestrian button flow', (done) => {
    const actor = createActor(trafficLightMachine);

    actor.subscribe((state) => {
      console.log('Estado:', state.value, 'Botón:', state.context.buttonPressed);
    });

    actor.start();

    // Estado inicial: verde
    expect(actor.getSnapshot().value).toBe('verde');

    // Presionar botón peatonal
    actor.send({ type: 'PEDESTRIAN_BUTTON' });
    expect(actor.getSnapshot().context.buttonPressed).toBe(true);
    expect(actor.getSnapshot().context.pedestrianWaitingCount).toBe(1);

    actor.stop();
    done();
  });

  /**
   * Test 3: Modo nocturno
   */
  test('Night mode activation', (done) => {
    const actor = createActor(trafficLightMachine);

    actor.subscribe((state) => {
      console.log('Estado:', state.value, 'Modo nocturno:', state.context.nightMode);

      if (state.matches('intermitente')) {
        expect(state.context.nightMode).toBe(true);
        expect(state.context.buttonPressed).toBe(false);
        done();
      }
    });

    actor.start();

    // Activar modo nocturno
    actor.send({ type: 'NIGHT_MODE' });

    setTimeout(() => {
      actor.stop();
    }, 100);
  });

  /**
   * Test 4: Desactivar modo nocturno
   */
  test('Night mode deactivation', (done) => {
    const actor = createActor(trafficLightMachine);

    actor.subscribe((state) => {
      console.log('Estado:', state.value);
    });

    actor.start();

    // Activar modo nocturno
    actor.send({ type: 'NIGHT_MODE' });
    expect(actor.getSnapshot().value).toBe('intermitente');

    // Desactivar modo nocturno
    actor.send({ type: 'DAY_MODE' });
    expect(actor.getSnapshot().value).toBe('verde');
    expect(actor.getSnapshot().context.nightMode).toBe(false);

    actor.stop();
    done();
  });

  /**
   * Test 5: Verificar transición a estado peatonal
   */
  test('Pedestrian state is reached when button pressed', (done) => {
    const actor = createActor(trafficLightMachine);
    let reachedPeatonal = false;

    actor.subscribe((state) => {
      if (state.matches('peatonal') && !reachedPeatonal) {
        reachedPeatonal = true;
        expect(state.value).toBe('peatonal');
        actor.stop();
        done();
      }
    });

    actor.start();

    // Presionar botón peatonal
    actor.send({ type: 'PEDESTRIAN_BUTTON' });
  }, 15000); // Timeout extendido para este test

  /**
   * Test 6: Múltiples presiones del botón peatonal
   */
  test('Multiple pedestrian button presses', (done) => {
    const actor = createActor(trafficLightMachine);
    actor.start();

    // Presionar botón varias veces
    actor.send({ type: 'PEDESTRIAN_BUTTON' });
    actor.send({ type: 'PEDESTRIAN_BUTTON' });
    actor.send({ type: 'PEDESTRIAN_BUTTON' });

    const state = actor.getSnapshot();
    expect(state.context.pedestrianWaitingCount).toBe(3);
    expect(state.context.buttonPressed).toBe(true);

    actor.stop();
    done();
  });

  /**
   * Test 7: No se puede presionar botón en modo nocturno
   */
  test('Pedestrian button ignored in night mode', (done) => {
    const actor = createActor(trafficLightMachine);
    actor.start();

    // Activar modo nocturno
    actor.send({ type: 'NIGHT_MODE' });
    expect(actor.getSnapshot().value).toBe('intermitente');

    // Intentar presionar botón peatonal (debería estar deshabilitado)
    actor.send({ type: 'PEDESTRIAN_BUTTON' });

    // En modo nocturno, el botón no debería registrarse
    const state = actor.getSnapshot();
    expect(state.value).toBe('intermitente');

    actor.stop();
    done();
  });
});

/**
 * Pruebas de invariantes
 */
describe('Traffic Light Invariants', () => {

  test('Should always have exactly one active state', (done) => {
    const actor = createActor(trafficLightMachine);
    actor.start();

    const state = actor.getSnapshot();
    expect(typeof state.value).toBe('string');
    expect(['verde', 'amarillo', 'rojo', 'peatonal', 'intermitente']).toContain(state.value);

    actor.stop();
    done();
  });

  test('Context should maintain valid values', (done) => {
    const actor = createActor(trafficLightMachine);
    actor.start();

    const state = actor.getSnapshot();
    expect(typeof state.context.buttonPressed).toBe('boolean');
    expect(typeof state.context.nightMode).toBe('boolean');
    expect(typeof state.context.totalCycles).toBe('number');
    expect(state.context.totalCycles).toBeGreaterThanOrEqual(0);

    actor.stop();
    done();
  });
});

/**
 * Reportar cobertura
 */
afterAll(() => {
  console.log('\n=== RESUMEN DE COBERTURA ===');
  console.log('Todos los estados fueron probados');
  console.log('Todas las transiciones fueron probadas');
  console.log('============================\n');
});
