@echo off
REM ============================================================================
REM Script de Ejecución de Pruebas - Semáforo Inteligente MBT
REM Universidad de Costa Rica - CI-0142 Pruebas de Software
REM ============================================================================

echo.
echo ========================================================================
echo    SEMAFORO INTELIGENTE - MODEL-BASED TESTING DEMO
echo    Universidad de Costa Rica - CI-0142 Pruebas de Software
echo ========================================================================
echo.
echo Equipo:
echo   - Silvia Aguilar B80129
echo   - Pablo Cascante C11731
echo   - Javier Pupo C06103
echo   - Alexander Quesada C16131
echo   - Christian Rojas B86958
echo.
echo ========================================================================
echo.

REM Guardar el directorio actual
set ORIGINAL_DIR=%CD%

REM Ir al directorio raíz del proyecto
cd /d "%~dp0.."

echo [INFO] Directorio del proyecto: %CD%
echo.

REM ============================================================================
REM PARTE 1: PRUEBAS DE MODELJUNIT (JAVA)
REM ============================================================================

echo.
echo ========================================================================
echo  PARTE 1: EJECUTANDO PRUEBAS DE MODELJUNIT (JAVA)
echo ========================================================================
echo.

REM Verificar si Maven está instalado
where mvn >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Maven no encontrado. Por favor instale Maven.
    echo        Descarga: https://maven.apache.org/download.cgi
    pause
    exit /b 1
)

REM Verificar si Java está instalado
where java >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Java no encontrado. Por favor instale Java JDK 8+.
    echo        Descarga: https://www.oracle.com/java/technologies/javase-downloads.html
    pause
    exit /b 1
)

echo [INFO] Maven encontrado:
call mvn --version
echo.

echo [INFO] Java encontrado:
call java -version
echo.

REM Cambiar al directorio de ModelJUnit
cd modeljunit-implementation

echo [INFO] Ejecutando pruebas de ModelJUnit...
echo.

REM Ejecutar las pruebas
call mvn clean test

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] Las pruebas de ModelJUnit fallaron.
    echo [INFO] Revise los logs arriba para más detalles.
    cd "%ORIGINAL_DIR%"
    pause
    exit /b 1
)

echo.
echo [SUCCESS] Pruebas de ModelJUnit completadas exitosamente!
echo.

REM Volver al directorio raíz
cd ..

REM ============================================================================
REM PARTE 2: PRUEBAS DE XSTATE (JAVASCRIPT)
REM ============================================================================

echo.
echo ========================================================================
echo  PARTE 2: EJECUTANDO PRUEBAS DE XSTATE (JAVASCRIPT)
echo ========================================================================
echo.

REM Verificar si Node.js está instalado
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Node.js no encontrado. Por favor instale Node.js 16+.
    echo        Descarga: https://nodejs.org/
    pause
    exit /b 1
)

REM Verificar si npm está instalado
where npm >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] npm no encontrado. Por favor instale npm.
    pause
    exit /b 1
)

echo [INFO] Node.js encontrado:
call node --version
echo.

echo [INFO] npm encontrado:
call npm --version
echo.

REM Cambiar al directorio de XState
cd xstate-implementation

REM Verificar si node_modules existe
if not exist "node_modules\" (
    echo [INFO] Instalando dependencias de npm...
    call npm install
    if %ERRORLEVEL% NEQ 0 (
        echo [ERROR] Falló la instalación de dependencias.
        cd "%ORIGINAL_DIR%"
        pause
        exit /b 1
    )
    echo.
)

echo [INFO] Ejecutando pruebas de XState...
echo.

REM Ejecutar las pruebas con cobertura
call npm test

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] Las pruebas de XState fallaron.
    echo [INFO] Revise los logs arriba para más detalles.
    cd "%ORIGINAL_DIR%"
    pause
    exit /b 1
)

echo.
echo [SUCCESS] Pruebas de XState completadas exitosamente!
echo.

REM Volver al directorio raíz
cd ..

REM ============================================================================
REM RESUMEN FINAL
REM ============================================================================

echo.
echo ========================================================================
echo  RESUMEN DE EJECUCION
echo ========================================================================
echo.
echo [SUCCESS] Todas las pruebas se ejecutaron exitosamente!
echo.
echo Resultados:
echo   - ModelJUnit (Java):  OK
echo   - XState (JavaScript): OK
echo.
echo ========================================================================
echo.
echo Para ver el visualizador interactivo, abra:
echo   xstate-implementation\visualizer.html
echo.
echo ========================================================================
echo.

REM Volver al directorio original
cd "%ORIGINAL_DIR%"

pause
