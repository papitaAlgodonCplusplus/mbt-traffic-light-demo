# 📚 Directorio de Librerías - ModelJUnit

## Instrucciones Importantes

Este directorio debe contener el archivo JAR de ModelJUnit para que el proyecto funcione correctamente.

### ¿Qué debe haber aquí?

```
lib/
├── modeljunit-2.5.jar    ← DEBES DESCARGAR ESTE ARCHIVO
└── README.md             ← Este archivo
```

### ¿Cómo obtener ModelJUnit?

#### Opción 1: Descarga Directa (Recomendado)

1. **Visita SourceForge**:
   - URL: https://sourceforge.net/projects/modeljunit/files/ModelJUnit-2.5/

2. **Descarga el archivo**:
   - Buscar: `modeljunit-2.5.jar`
   - Hacer clic en descargar

3. **Coloca el archivo aquí**:
   - Mover `modeljunit-2.5.jar` a este directorio (`lib/`)

4. **Verifica**:
   ```bash
   # El archivo debe estar en:
   modeljunit-implementation/lib/modeljunit-2.5.jar
   ```

#### Opción 2: Usar wget (Linux/Mac)

```bash
cd lib/
wget https://sourceforge.net/projects/modeljunit/files/ModelJUnit-2.5/modeljunit-2.5.jar/download -O modeljunit-2.5.jar
```

#### Opción 3: Usar curl (Linux/Mac)

```bash
cd lib/
curl -L https://sourceforge.net/projects/modeljunit/files/ModelJUnit-2.5/modeljunit-2.5.jar/download -o modeljunit-2.5.jar
```

### Verificar la Instalación

Después de descargar, verifica que el archivo existe:

**Windows (PowerShell)**:
```powershell
Test-Path lib\modeljunit-2.5.jar
# Debe devolver: True
```

**Linux/Mac**:
```bash
ls -lh lib/modeljunit-2.5.jar
# Debe mostrar el archivo con tamaño ~200KB
```

### ¿Por qué no está incluido?

ModelJUnit no está disponible en Maven Central y debe descargarse manualmente desde SourceForge. Por esta razón, no lo incluimos en el repositorio.

### Solución de Problemas

**Problema**: "Cannot find modeljunit-2.5.jar"

**Solución**:
1. Verifica que el archivo está en `modeljunit-implementation/lib/`
2. Verifica que el nombre del archivo es exactamente: `modeljunit-2.5.jar`
3. Verifica los permisos del archivo

**Problema**: "Access denied" o "Permission denied"

**Solución** (Linux/Mac):
```bash
chmod 644 lib/modeljunit-2.5.jar
```

### Más Información

Para instrucciones detalladas de instalación, consulta:
- `SETUP-MODELJUNIT.md` en el directorio padre

### Información del JAR

- **Nombre**: modeljunit-2.5.jar
- **Tamaño aproximado**: ~200 KB
- **Versión**: 2.5
- **Licencia**: GNU LGPL v2.1
- **Fuente**: https://sourceforge.net/projects/modeljunit/

---

**Universidad de Costa Rica** | **CI-0142 Pruebas de Software** | **2025**
