# 📦 Configuración de ModelJUnit

ModelJUnit no está disponible en Maven Central, por lo que debe instalarse manualmente.

## Opción 1: Descarga Manual (Recomendado)

### Paso 1: Descargar ModelJUnit

1. Visitar: https://sourceforge.net/projects/modeljunit/files/ModelJUnit-2.5/
2. Descargar el archivo: `modeljunit-2.5.jar`

### Paso 2: Colocar el JAR en el Proyecto

```bash
# Crear el directorio lib si no existe
cd modeljunit-implementation
mkdir lib

# Mover el JAR descargado a lib/
# Windows (PowerShell):
Move-Item -Path "C:\Users\TuUsuario\Downloads\modeljunit-2.5.jar" -Destination "lib\"

# Linux/Mac:
mv ~/Downloads/modeljunit-2.5.jar lib/
```

### Paso 3: Verificar la Instalación

El archivo debe estar en:
```
modeljunit-implementation/
└── lib/
    └── modeljunit-2.5.jar
```

### Paso 4: Compilar y Ejecutar

```bash
# Compilar
mvn clean compile

# Ejecutar pruebas
mvn test
```

## Opción 2: Instalación en Repositorio Local de Maven

Si prefieres instalar ModelJUnit en tu repositorio local de Maven:

```bash
# Descargar modeljunit-2.5.jar primero (Paso 1 de Opción 1)

# Instalar en repositorio local de Maven
mvn install:install-file \
  -Dfile=modeljunit-2.5.jar \
  -DgroupId=nz.ac.waikato.modeljunit \
  -DartifactId=modeljunit \
  -Dversion=2.5 \
  -Dpackaging=jar

# Luego modificar pom.xml para quitar systemPath y usar scope compile
```

## Verificar Requisitos

### Java

```bash
java -version
# Debe ser Java 8 o superior
```

Si no tienes Java:
- **Windows/Linux/Mac**: https://www.oracle.com/java/technologies/javase-downloads.html
- **Ubuntu/Debian**: `sudo apt install openjdk-11-jdk`
- **Mac con Homebrew**: `brew install openjdk@11`

### Maven

```bash
mvn --version
# Debe ser Maven 3.0 o superior
```

Si no tienes Maven:
- **Windows**: https://maven.apache.org/download.cgi
- **Ubuntu/Debian**: `sudo apt install maven`
- **Mac con Homebrew**: `brew install maven`

## Solución de Problemas

### Error: "Cannot resolve dependency"

**Problema**: Maven no encuentra el JAR de ModelJUnit

**Solución**:
1. Verificar que `lib/modeljunit-2.5.jar` existe
2. Verificar que el path en `pom.xml` es correcto:
   ```xml
   <systemPath>${project.basedir}/lib/modeljunit-2.5.jar</systemPath>
   ```

### Error: "Java version not compatible"

**Problema**: Versión de Java muy antigua

**Solución**:
```bash
# Verificar versión
java -version

# Actualizar JAVA_HOME si es necesario (Windows)
set JAVA_HOME=C:\Program Files\Java\jdk-11

# Actualizar JAVA_HOME (Linux/Mac)
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
```

### Error: "Package nz.ac.waikato.modeljunit does not exist"

**Problema**: El JAR no está en el classpath

**Solución**:
1. Limpiar y recompilar:
   ```bash
   mvn clean compile
   ```
2. Verificar que el JAR existe en `lib/`
3. Verificar que el `pom.xml` tiene la dependencia correcta

## Recursos Adicionales

- **Documentación oficial**: http://www.cs.waikato.ac.nz/~marku/mbt/modeljunit/
- **Repositorio SourceForge**: https://sourceforge.net/projects/modeljunit/
- **Ejemplos**: Incluidos en el JAR descargado

## Contacto

Si tienes problemas con la instalación, contacta al equipo del proyecto.
