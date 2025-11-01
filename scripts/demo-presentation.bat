@echo off
REM ============================================================================
REM Script de Demostración para Presentación
REM Semáforo Inteligente - Model-Based Testing
REM Universidad de Costa Rica - CI-0142 Pruebas de Software
REM ============================================================================

echo.
echo ========================================================================
echo    DEMO DE PRESENTACION - SEMAFORO INTELIGENTE MBT
echo    Universidad de Costa Rica - CI-0142 Pruebas de Software
echo ========================================================================
echo.

REM Guardar el directorio actual
set ORIGINAL_DIR=%CD%

REM Ir al directorio raíz del proyecto
cd /d "%~dp0.."

echo.
echo [1/4] Abriendo visualizador interactivo en el navegador...
echo.

REM Abrir el visualizador HTML
start "" "xstate-implementation\visualizer.html"

timeout /t 2 >nul

echo.
echo [2/4] Preparando terminal para demostración de ModelJUnit...
echo.

REM Abrir nueva ventana de cmd para ModelJUnit
start "ModelJUnit Demo" cmd /k "cd /d %CD%\modeljunit-implementation && echo. && echo ========================================== && echo   MODELJUNIT - Listo para ejecutar && echo ========================================== && echo. && echo Para ejecutar las pruebas, escriba: && echo   mvn test && echo."

timeout /t 2 >nul

echo.
echo [3/4] Preparando terminal para demostración de XState...
echo.

REM Abrir nueva ventana de cmd para XState
start "XState Demo" cmd /k "cd /d %CD%\xstate-implementation && echo. && echo ========================================== && echo   XSTATE - Listo para ejecutar && echo ========================================== && echo. && echo Para ejecutar las pruebas, escriba: && echo   npm test && echo. && echo Para instalar dependencias (si es necesario): && echo   npm install && echo."

timeout /t 2 >nul

echo.
echo [4/4] Abriendo explorador de archivos con la estructura del proyecto...
echo.

REM Abrir explorador de archivos
start "" "%CD%"

echo.
echo ========================================================================
echo  DEMO PREPARADA PARA LA PRESENTACION
echo ========================================================================
echo.
echo Se han abierto:
echo   [X] Visualizador interactivo en el navegador
echo   [X] Terminal para demostración de ModelJUnit
echo   [X] Terminal para demostración de XState
echo   [X] Explorador de archivos con estructura del proyecto
echo.
echo ========================================================================
echo.
echo ORDEN SUGERIDO PARA LA PRESENTACION:
echo.
echo 1. Mostrar estructura del proyecto (explorador de archivos)
echo 2. Explicar el modelo del semáforo (visualizador HTML)
echo 3. Demo ModelJUnit:
echo    - Ir a la ventana "ModelJUnit Demo"
echo    - Ejecutar: mvn test
echo    - Explicar output y métricas de cobertura
echo.
echo 4. Demo XState:
echo    - Ir a la ventana "XState Demo"
echo    - Ejecutar: npm test
echo    - Mostrar resultados
echo.
echo 5. Demostración interactiva:
echo    - Volver al visualizador HTML
echo    - Presionar botones y mostrar transiciones en vivo
echo    - Mostrar log de eventos
echo    - Explicar contexto y estado
echo.
echo ========================================================================
echo.

REM Volver al directorio original
cd "%ORIGINAL_DIR%"

pause
