package com.example.traffic;

import nz.ac.waikato.modeljunit.*;
import nz.ac.waikato.modeljunit.coverage.*;
import nz.ac.waikato.modeljunit.coverage.ActionCoverage;
import nz.ac.waikato.modeljunit.coverage.StateCoverage;
import nz.ac.waikato.modeljunit.coverage.TransitionCoverage;
import org.junit.Test;

import java.util.Random;

/**
 * TrafficLightTest - Suite de pruebas para el modelo de semáforo inteligente
 *
 * Ejecuta diferentes algoritmos de generación de pruebas:
 * - Random Walk: Exploración aleatoria
 * - Greedy Random: Exploración con preferencia por estados no visitados
 * - All Round Trips: Cobertura de todos los ciclos
 *
 * @author Grupo: Silvia Aguilar, Pablo Cascante, Javier Pupo, Alexander Quesada, Christian Rojas
 */
public class TrafficLightTest {

    /**
     * Prueba usando Random Walk
     * Explora el modelo de forma aleatoria
     */
    @Test
    public void testRandomWalk() {
        System.out.println("\n=== RANDOM WALK TEST ===");

        TrafficLightModel model = new TrafficLightModel();
        Tester tester = new RandomTester(model);

        // Agregar listeners para métricas de cobertura
        tester.addListener(new StopOnFailureListener());
        tester.addListener(new VerboseListener());

        // Generar 50 transiciones aleatorias
        tester.generate(50);

        // Imprimir métricas de cobertura
        printCoverageMetrics(tester);
    }

    /**
     * Prueba usando Greedy Random Tester
     * Explora preferentemente estados no visitados
     */
    @Test
    public void testGreedyRandom() {
        System.out.println("\n=== GREEDY RANDOM TEST ===");

        TrafficLightModel model = new TrafficLightModel();
        GreedyTester tester = new GreedyTester(model);

        // Configurar seed para reproducibilidad
        tester.setRandom(new Random(123));

        tester.addListener(new StopOnFailureListener());
        tester.addListener(new VerboseListener());

        // Generar 100 transiciones con estrategia greedy
        tester.generate(100);

        printCoverageMetrics(tester);
    }

    /**
     * Prueba para cobertura de estados
     * Verifica que se visiten todos los estados posibles
     */
    @Test
    public void testStateCoverage() {
        System.out.println("\n=== STATE COVERAGE TEST ===");

        TrafficLightModel model = new TrafficLightModel();
        GraphListener graphListener = new GraphListener();
        GreedyTester tester = new GreedyTester(model);

        tester.addListener(graphListener);
        tester.addListener(new VerboseListener());

        // Generar hasta alcanzar buena cobertura
        tester.generate(200);

        // Imprimir el grafo generado si está disponible
        if (graphListener.getGraph() != null) {
            System.out.println("\nGraph:\n" + graphListener.getGraph().toString());
        } else {
            System.out.println("\nGraph not available (this is normal with some ModelJUnit versions)");
        }

        printCoverageMetrics(tester);
    }

    /**
     * Prueba de transición específica: Flujo normal sin botón peatonal
     */
    @Test
    public void testNormalFlow() {
        System.out.println("\n=== NORMAL FLOW TEST (Sin botón peatonal) ===");

        TrafficLightModel model = new TrafficLightModel();
        model.reset(true);

        // Estado inicial debe ser VERDE
        assert String.valueOf(model.getCurrentState()).equals("VERDE");
        System.out.println("Estado inicial: " + model.getCurrentState());

        // Sin presionar botón, debe permanecer en VERDE
        model.timerExpired();
        assert String.valueOf(model.getCurrentState()).equals("VERDE");
        System.out.println("Después de timer (sin botón): " + model.getCurrentState());

        System.out.println("✓ Flujo normal funciona correctamente");
    }

    /**
     * Prueba de transición específica: Flujo con botón peatonal
     */
    @Test
    public void testPedestrianFlow() {
        System.out.println("\n=== PEDESTRIAN FLOW TEST (Con botón peatonal) ===");

        TrafficLightModel model = new TrafficLightModel();
        model.reset(true);

        // Estado inicial: VERDE
        System.out.println("Estado inicial: " + model.getCurrentState());
        assert String.valueOf(model.getCurrentState()).equals("VERDE");

        // Presionar botón peatonal
        model.pedestrianButton();
        assert model.isButtonPressed();
        System.out.println("Botón peatonal presionado: " + model.isButtonPressed());

        // Timer expira -> debe ir a AMARILLO
        model.timerExpired();
        assert String.valueOf(model.getCurrentState()).equals("AMARILLO");
        System.out.println("Después de timer con botón: " + model.getCurrentState());

        // Timer expira -> debe ir a ROJO
        model.timerExpired();
        assert String.valueOf(model.getCurrentState()).equals("ROJO");
        System.out.println("Siguiente estado: " + model.getCurrentState());

        // Timer expira -> debe ir a PEATONAL
        model.timerExpired();
        assert String.valueOf(model.getCurrentState()).equals("PEATONAL");
        System.out.println("Estado peatonal: " + model.getCurrentState());

        // Timer expira -> vuelve a ROJO
        model.timerExpired();
        assert String.valueOf(model.getCurrentState()).equals("ROJO");
        System.out.println("Después de peatonal: " + model.getCurrentState());

        System.out.println("✓ Flujo peatonal funciona correctamente");
    }

    /**
     * Prueba de modo nocturno
     */
    @Test
    public void testNightMode() {
        System.out.println("\n=== NIGHT MODE TEST ===");

        TrafficLightModel model = new TrafficLightModel();
        model.reset(true);

        // Activar modo nocturno
        model.activateNightMode();
        assert model.isNightMode();
        assert String.valueOf(model.getCurrentState()).equals("INTERMITENTE");
        System.out.println("Modo nocturno activado: " + model.getCurrentState());

        // El timer no debería cambiar el estado en modo nocturno
        model.timerExpired();
        assert String.valueOf(model.getCurrentState()).equals("INTERMITENTE");
        System.out.println("Estado después de timer (modo nocturno): " + model.getCurrentState());

        // Desactivar modo nocturno
        model.deactivateNightMode();
        assert !model.isNightMode();
        assert String.valueOf(model.getCurrentState()).equals("VERDE");
        System.out.println("Modo nocturno desactivado: " + model.getCurrentState());

        System.out.println("✓ Modo nocturno funciona correctamente");
    }

    /**
     * Método auxiliar para imprimir métricas de cobertura
     */
    private void printCoverageMetrics(Tester tester) {
        System.out.println("\n--- MÉTRICAS DE COBERTURA ---");

        // Cobertura de estados
        StateCoverage stateCov = new StateCoverage();
        tester.buildGraph();
        tester.addCoverageMetric(stateCov);
        System.out.println("Cobertura de Estados: " +
            stateCov.getPercentage() + "% " +
            "(" + stateCov.getCoverage() + "/" + stateCov.getMaximum() + " estados)");

        // Cobertura de transiciones
        TransitionCoverage transCov = new TransitionCoverage();
        tester.addCoverageMetric(transCov);
        System.out.println("Cobertura de Transiciones: " +
            transCov.getPercentage() + "% " +
            "(" + transCov.getCoverage() + "/" + transCov.getMaximum() + " transiciones)");

        // Cobertura de acciones
        ActionCoverage actionCov = new ActionCoverage();
        tester.addCoverageMetric(actionCov);
        System.out.println("Cobertura de Acciones: " +
            actionCov.getPercentage() + "% " +
            "(" + actionCov.getCoverage() + "/" + actionCov.getMaximum() + " acciones)");

        System.out.println("-----------------------------\n");
    }
}
