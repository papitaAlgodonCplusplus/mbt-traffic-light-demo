package com.example.traffic;

import nz.ac.waikato.modeljunit.*;
import nz.ac.waikato.modeljunit.coverage.*;

/**
 * TrafficLightModel - Modelo de semáforo inteligente con botón peatonal para Model-Based Testing
 *
 * Este modelo representa un sistema de semáforo con las siguientes características:
 * - Estados: VERDE, AMARILLO, ROJO, PEATONAL, INTERMITENTE
 * - Eventos: temporizador, botón peatonal, modo nocturno
 *
 * @author Grupo: Silvia Aguilar, Pablo Cascante, Javier Pupo, Alexander Quesada, Christian Rojas
 */
public class TrafficLightModel implements FsmModel {

    /**
     * Estados posibles del semáforo
     */
    private enum LightState {
        VERDE,          // Luz verde para vehículos
        AMARILLO,       // Luz amarilla de transición
        ROJO,           // Luz roja para vehículos
        PEATONAL,       // Luz verde para peatones (roja para vehículos)
        INTERMITENTE    // Modo nocturno con luz amarilla intermitente
    }

    // Estado actual del sistema
    private LightState currentState = LightState.VERDE;

    // Botón peatonal presionado
    private boolean buttonPressed = false;

    // Modo nocturno activado
    private boolean nightMode = false;

    // Contador de ticks del temporizador (para simular tiempo)
    private int timerTicks = 0;

    /**
     * Devuelve el estado actual del modelo
     */
    @Override
    public Object getState() {
        return currentState;
    }

    /**
     * Resetea el modelo a su estado inicial
     */
    @Override
    public void reset(boolean testing) {
        currentState = LightState.VERDE;
        buttonPressed = false;
        nightMode = false;
        timerTicks = 0;
    }

    // ==================== GUARDAS (Guards) ====================

    /**
     * Permite ejecutar timerExpired solo cuando no estamos en modo nocturno
     */
    public boolean timerExpiredGuard() {
        return !nightMode;
    }

    /**
     * Permite presionar el botón peatonal solo en estado VERDE
     */
    public boolean pedestrianButtonGuard() {
        return currentState == LightState.VERDE && !nightMode;
    }

    /**
     * Permite activar modo nocturno desde cualquier estado excepto INTERMITENTE
     */
    public boolean activateNightModeGuard() {
        return !nightMode;
    }

    /**
     * Permite desactivar modo nocturno solo si está activo
     */
    public boolean deactivateNightModeGuard() {
        return nightMode;
    }

    // ==================== ACCIONES (Actions) ====================

    /**
     * Acción: Expira el temporizador y cambia de estado según la lógica del semáforo
     */
    @Action
    public void timerExpired() {
        if (!timerExpiredGuard()) {
            return; // No hacer nada si estamos en modo nocturno
        }

        switch(currentState) {
            case VERDE:
                // Si el botón fue presionado, ir a amarillo, sino permanecer en verde
                if (buttonPressed) {
                    currentState = LightState.AMARILLO;
                }
                // Si no hay solicitud peatonal, permanecer en verde
                break;

            case AMARILLO:
                // Siempre ir a rojo después de amarillo
                currentState = LightState.ROJO;
                break;

            case ROJO:
                // Si el botón fue presionado, dar paso peatonal
                if (buttonPressed) {
                    currentState = LightState.PEATONAL;
                    buttonPressed = false; // Limpiar la solicitud
                } else {
                    // Volver a verde si no hay solicitud peatonal
                    currentState = LightState.VERDE;
                }
                break;

            case PEATONAL:
                // Después del paso peatonal, volver a rojo y luego a verde
                currentState = LightState.ROJO;
                break;

            case INTERMITENTE:
                // En modo nocturno no cambia con el temporizador
                break;
        }

        timerTicks++;
    }

    /**
     * Acción: Presionar el botón peatonal
     */
    @Action
    public void pedestrianButton() {
        if (pedestrianButtonGuard()) {
            buttonPressed = true;
        }
    }

    /**
     * Acción: Activar modo nocturno (después de 10 PM)
     */
    @Action
    public void activateNightMode() {
        if (activateNightModeGuard()) {
            nightMode = true;
            currentState = LightState.INTERMITENTE;
            buttonPressed = false; // Limpiar solicitudes pendientes
        }
    }

    /**
     * Acción: Desactivar modo nocturno (después de 6 AM)
     */
    @Action
    public void deactivateNightMode() {
        if (deactivateNightModeGuard()) {
            nightMode = false;
            currentState = LightState.VERDE;
            buttonPressed = false;
        }
    }

    // ==================== GETTERS para verificación ====================

    public LightState getCurrentState() {
        return currentState;
    }

    public boolean isButtonPressed() {
        return buttonPressed;
    }

    public boolean isNightMode() {
        return nightMode;
    }

    public int getTimerTicks() {
        return timerTicks;
    }
}
