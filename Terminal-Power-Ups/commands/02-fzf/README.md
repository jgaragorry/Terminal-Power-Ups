# comando `fzf`

## 🚀 Un Buscador Difuso Interactivo para Todo

`fzf` no es tanto un comando, sino un "meta-comando" que se integra con tu shell para darte superpoderes de búsqueda. Convierte cualquier lista de texto (archivos, comandos del historial, procesos, commits de Git, etc.) en un menú de búsqueda interactivo y difuso (fuzzy).

### ¿Qué es y por qué es mejor?

-   **Búsqueda Difusa (Fuzzy):** No necesitas escribir el nombre exacto. Puedes escribir fragmentos, incluso con errores, y `fzf` encontrará la mejor coincidencia en tiempo real.
-   **Interactivo y Visual:** En lugar de encadenar `grep`, `awk` y `sed`, `fzf` te presenta una lista que puedes filtrar y seleccionar visualmente, con una ventana de previsualización.
-   **Universalmente Integrable:** La verdadera magia de `fzf` es cómo se combina con otros comandos a través de tuberías (`|`). `comando_que_genera_una_lista | fzf`.

### Instalación y Configuración en Ubuntu 24.04 LTS

1.  **Instalar el paquete:**
    ```bash
    sudo apt update
    sudo apt install -y fzf
    ```
2.  **Activar la integración con Bash (¡Paso Crucial!):**
    Para obtener las mejores funcionalidades (como el historial con `Ctrl+R`), añade la siguiente línea al final de tu archivo `~/.bashrc`:
    ```bash
    # Añadir al final de ~/.bashrc
    [ -f ~/.fzf.bash ] && source ~/.fzf.bash
    ```
    Luego, reinicia tu terminal o ejecuta `source ~/.bashrc`.

### 🎓 Guía Práctica: Recetas de `fzf` por Rol Profesional

---

#### Receta 1: El Historial de Comandos Definitivo (Para TODOS los Roles)

* **Objetivo:** Encontrar y reutilizar un comando complejo que ejecutaste hace días, sin recordar la sintaxis exacta.
* **La Acción:** Presiona `Ctrl+R` en tu terminal (después de la configuración).
* **Análisis y Estrategia:** En lugar del buscador de historial por defecto de Bash, `fzf` abrirá una ventana interactiva a pantalla completa con todo tu historial. Simplemente empieza a escribir fragmentos de lo que recuerdas (`docker`, `compose`, `nginx`, `-exec`), y la lista se filtrará instantáneamente. Usa las flechas para seleccionar el comando y presiona `Enter` para ejecutarlo o editarlo.
* **Ventaja:** Transforma la búsqueda en el historial de una tarea tediosa a una experiencia rápida y potente, animándote a reutilizar comandos complejos.

---

#### Receta 2: Muerte de Procesos Visual y Segura (SysOps / SRE)

* **Objetivo:** Un proceso se ha quedado colgado y necesitas terminarlo, pero no estás seguro del PID exacto y quieres evitar matar el proceso equivocado.
* **El Comando:**
    ```bash
    ps -ef | fzf --height 40% | awk '{print $2}' | xargs -r kill -9
    ```
* **Análisis y Estrategia:**
    1.  `ps -ef`: Lista todos los procesos en ejecución.
    2.  `| fzf --height 40%`: Esta lista se pasa a `fzf`, que abre un menú de filtrado interactivo en la parte inferior de la pantalla. Empieza a escribir el nombre del proceso (ej: `apache` o `java`).
    3.  Una vez que seleccionas la línea correcta con `Enter`, `awk '{print $2}'` extrae la segunda columna (el PID).
    4.  `| xargs -r kill -9`: `xargs` pasa el PID a `kill`. La opción `-r` evita que `kill` se ejecute si no seleccionas nada, previniendo errores.
* **Utilidad:** Es la forma más segura e interactiva de matar procesos. Eliges visualmente el proceso correcto, eliminando el riesgo de un `pkill` demasiado agresivo o de copiar mal un PID.

---

#### Receta 3: Navegación y Edición Rápida de Archivos (DevOps / SysAdmin)

* **Objetivo:** Quieres encontrar un archivo de configuración específico en un proyecto grande y abrirlo en tu editor, viendo su contenido antes de decidir.
* **El Comando:**
    ```bash
    # Presiona Ctrl+T para una búsqueda de archivos o usa este pipeline:
    fzf --preview 'bat --color=always {}' | xargs -r nano
    ```
* **Análisis y Estrategia:**
    * `fzf`: Por defecto, si no se le pasa nada, `fzf` lista todos los archivos en el directorio actual y subdirectorios.
    * `--preview 'bat --color=always {}'`: Esta es la funcionalidad estrella. Mientras navegas por la lista de archivos con las flechas, `fzf` abre una ventana de previsualización a la derecha y ejecuta el comando `bat` sobre el archivo seleccionado (`{}` es el placeholder), mostrándote su contenido con resaltado de sintaxis.
    * `| xargs -r nano`: Una vez que encuentras el archivo correcto y presionas `Enter`, `xargs` lo pasa a `nano` (o tu editor preferido) para su edición.
* **Utilidad:** Combina la búsqueda, previsualización y edición en un solo flujo de trabajo increíblemente rápido. Es la forma definitiva de navegar por un proyecto desde la terminal.

---

### **3. `Terminal-Power-Ups/commands/03-zoxide/README.md`**

````markdown
# comando `zoxide`

## 🚀 Un `cd` con Cerebro

`zoxide` es un reemplazo inteligente para el comando `cd`. Aprende de los directorios que visitas y te permite saltar a ellos en un instante, sin importar en qué parte del sistema de archivos te encuentres. Elimina la necesidad de escribir rutas largas y repetitivas.

### ¿Qué es y por qué es mejor?

-   **Navegación por Frecuencia:** `zoxide` mantiene una base de datos de los directorios que visitas y ordena los resultados por "frecuencia" (una combinación de cuántas veces y qué tan recientemente los has visitado).
-   **Búsqueda Difusa:** No necesitas el nombre exacto. `zoxide` te llevará al mejor resultado coincidente. `z proj` podría llevarte a `~/documentos/proyectos/cliente-importante/`.
-   **Interactivo:** Se integra con `fzf` para ofrecer un menú de búsqueda interactivo para tu historial de directorios.

### Instalación y Configuración en Ubuntu 24.04 LTS

1.  **Instalar con el script oficial:**
    ```bash
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    ```
2.  **Activar la integración con Bash (¡Paso Crucial!):**
    Para que `zoxide` funcione correctamente y reemplace a `cd`, añade la siguiente línea al final de tu archivo `~/.bashrc`:
    ```bash
    # Añadir al final de ~/.bashrc
    eval "$(zoxide init bash)"
    ```
    Luego, reinicia tu terminal o ejecuta `source ~/.bashrc`.

### 🎓 Guía Práctica: Recetas de `zoxide` por Rol Profesional

---

#### Receta 1: El Salto Inteligente entre Directorios (Para TODOS los Roles)

* **Objetivo:** Estás trabajando en `~/proyectos/api/src/` y necesitas revisar un log en `/var/log/nginx/`. Luego, quieres volver inmediatamente al directorio de la API.
* **La Acción:**
    1.  `z nginx` (o `z log` o `z var`). `zoxide` te llevará a `/var/log/nginx/` si lo has visitado antes.
    2.  Haz tu revisión de logs.
    3.  `z api` (o `z src`). `zoxide` te devolverá instantáneamente a `~/proyectos/api/src/`.
* **Análisis y Estrategia:** `zoxide` (que se invoca con `z`) reemplaza la necesidad de recordar y escribir rutas absolutas o relativas complejas. Simplemente le dices a dónde quieres ir con una palabra clave.
* **Pro-Tip:** Para una integración total, muchos usuarios añaden `alias cd="z"` a su `.bashrc`. Así, todos tus hábitos de `cd` existentes se benefician de la inteligencia de `zoxide`.

---

#### Receta 2: Búsqueda Interactiva de Directorios (SysOps / DevOps)

* **Objetivo:** Recuerdas que trabajaste en un directorio de configuración de un cliente hace semanas, pero no recuerdas la ruta exacta, solo que contenía la palabra "cliente".
* **El Comando:**
    ```bash
    # Este comando abre un menú interactivo con fzf
    z -i
    ```
* **Análisis y Estrategia:** La opción `-i` (interactiva) invoca a `fzf` para mostrarte tu lista completa de directorios visitados, ordenados por frecuencia. Ahora puedes usar el poder de la búsqueda difusa para encontrar ese directorio perdido. Simplemente escribe "cliente" y la lista se reducirá a las coincidencias relevantes.
* **Utilidad:** Es como tener `Ctrl+R` (búsqueda en el historial), pero para tu historial de navegación de directorios. Es perfecto para encontrar ubicaciones de proyectos o configuraciones que no visitas con frecuencia.

---

#### Receta 3: Uso en Scripts para Rutas Dinámicas (DevOps / SRE)

* **Objetivo:** Estás escribiendo un script de despliegue que necesita copiar artefactos a un directorio de "releases" del proyecto, pero no quieres codificar la ruta completa (`/srv/www/mi-app/releases`) en el script para que sea más portable.
* **El Comando dentro de un Script:**
    ```bash
    #!/bin/bash
    
    # Encuentra la ruta del directorio de releases usando la base de datos de zoxide
    RELEASE_DIR=$(zoxide query -s releases)
    
    if [ -d "$RELEASE_DIR" ]; then
        echo "Directorio de releases encontrado en: $RELEASE_DIR"
        cp ./mi-app.jar "$RELEASE_DIR/"
        echo "Artefacto desplegado."
    else
        echo "Error: Directorio 'releases' no encontrado en el historial de zoxide."
        exit 1
    fi
    ```
* **Análisis y Estrategia:**
    * `zoxide query`: Permite acceder a la base de datos de `zoxide` de forma programática.
    * `-s`: Imprime el resultado único (`--score` más alto), evitando ambigüedades.
* **Utilidad:** Desacopla tus scripts de las rutas de archivo codificadas. Siempre que hayas visitado el directorio `releases` en el pasado, el script lo encontrará, haciendo tu automatización más robusta y adaptable a diferentes entornos.

---

### **4. `Terminal-Power-Ups/commands/04-trivy/README.md`**

````markdown
# comando `trivy`

## 🚀 Escáner de Seguridad Todo en Uno

`trivy` es un escáner de seguridad completo, simple y rápido. Se especializa en encontrar vulnerabilidades, malas configuraciones, secretos, información de SBOM (Software Bill of Materials) y más, en una gran variedad de objetivos.

### ¿Qué es y por qué es mejor?

-   **Cobertura Amplia:** Escanea imágenes de contenedores, sistemas de archivos, repositorios de Git, clusters de Kubernetes, plantillas de IaC (Terraform, CloudFormation) y más.
-   **Simple y Rápido:** No requiere una configuración compleja. La sintaxis es clara y los escaneos son extremadamente rápidos.
-   **Base de Datos Comprensiva:** Utiliza múltiples fuentes de datos de vulnerabilidades para ofrecer resultados precisos y actualizados.
-   **Enfocado en la Acción:** La salida es clara, priorizada por severidad (CRITICAL, HIGH, etc.) e a menudo incluye la versión de la librería que corrige la vulnerabilidad.

### Instalación en Ubuntu 24.04 LTS

El método de instalación recomendado por los desarrolladores es a través de su script oficial.

```bash
# Este comando descarga e instala trivy en /usr/local/bin
curl -sfL [https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh](https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh) | sudo sh -s -- -b /usr/local/bin
```

### 🎓 Guía Práctica: Recetas de `trivy` por Rol Profesional

---

#### Receta 1: Escaneo de Imágenes de Contenedores (DevOps / DevSecOps)

* **Objetivo:** Antes de desplegar una nueva imagen de contenedor en producción, verificar que no contenga vulnerabilidades de severidad `CRITICAL` o `HIGH`.
* **El Comando:**
    ```bash
    # Escanea una imagen pública de Python como ejemplo
    # El flag --severity filtra la salida para mostrar solo lo que nos importa
    trivy image --severity HIGH,CRITICAL python:3.11-slim
    ```
* **Análisis y Estrategia:** Esta es la práctica fundamental de "Shift Left Security". `trivy image` descarga la imagen (si no está localmente) y la analiza capa por capa, comparando las librerías y binarios instalados con bases de datos de vulnerabilidades conocidas (CVEs).
* **Utilidad:** Se integra perfectamente en pipelines de CI/CD (Jenkins, GitLab CI, GitHub Actions). El pipeline puede fallar automáticamente si `trivy` encuentra una vulnerabilidad crítica, bloqueando el despliegue de software inseguro.

---

#### Receta 2: Auditoría de un Repositorio (DevSecOps / SRE)

* **Objetivo:** Realizar una auditoría de seguridad completa sobre un repositorio de código antes de un lanzamiento, buscando no solo vulnerabilidades en las dependencias, sino también malas configuraciones en archivos de IaC y secretos expuestos.
* **El Comando:**
    ```bash
    # Clona un repositorio y ejecútalo en su raíz
    # Escanea el sistema de archivos (fs) buscando config, secretos y vulnerabilidades
    trivy fs --scanners config,secret,vuln .
    ```
* **Análisis y Estrategia:**
    * `trivy fs`: Activa el modo de escaneo de sistema de archivos.
    * `--scanners config,secret,vuln`: Le decimos a `trivy` qué buscar específicamente: `config` (malas configuraciones en Dockerfiles, Terraform, etc.), `secret` (secretos expuestos como los que buscamos con `rg`) y `vuln` (vulnerabilidades en archivos de dependencias como `package-lock.json` o `requirements.txt`).
    * `.`: Escanea el directorio actual.
* **Utilidad:** Proporciona un informe de seguridad 360° de un proyecto. Es la herramienta perfecta para los equipos de SRE y SecOps para obtener una visión rápida y completa del estado de seguridad de una aplicación.

---

#### Receta 3: Escaneo de un Cluster de Kubernetes en Vivo (SRE / SecOps)

* **Objetivo:** Evaluar la postura de seguridad de un cluster de Kubernetes en ejecución, identificando recursos con configuraciones inseguras (ej: contenedores corriendo como root, capacidades de kernel peligrosas, etc.).
* **El Comando:**
    ```bash
    # Asume que tu kubectl está configurado para apuntar al cluster que quieres escanear
    trivy k8s --report summary cluster
    ```
* **Análisis y Estrategia:**
    * `trivy k8s`: Activa el modo de escaneo de Kubernetes.
    * `cluster`: Le dice que escanee todos los recursos a los que el usuario actual de `kubectl` tiene acceso en el cluster.
    * `--report summary`: Muestra un resumen conciso de los resultados, en lugar de un volcado detallado de cada recurso.
* **Utilidad:** Es una herramienta de auditoría indispensable para cualquiera que gestione Kubernetes. Proporciona una lista de acciones priorizadas para "endurecer" la configuración del cluster y reducir la superficie de ataque, basándose en estándares de la industria como los Pod Security Standards (PSS).

---

### **5. `Terminal-Power-Ups/commands/05-yt-dlp/README.md`**

````markdown
# comando `yt-dlp`

## 🚀 La Herramienta Definitiva para Descargar Vídeo y Audio

`yt-dlp` es un fork del popular proyecto `youtube-dl`, con funcionalidades adicionales y un ritmo de actualizaciones mucho más rápido. Es la herramienta de línea de comandos más potente y fiable para descargar vídeos y audio de miles de sitios web.

### ¿Qué es y por qué es mejor?

-   **Soporte Masivo de Sitios:** Funciona con YouTube, Vimeo, Twitch, Twitter, y cientos de otros sitios.
-   **Control Total:** Permite seleccionar formato, calidad, resolución, extraer solo el audio, descargar subtítulos, listas de reproducción completas, y mucho más.
-   **Resistencia y Actualizaciones:** Se actualiza frecuentemente para mantenerse al día con los cambios en los sitios web, asegurando que siga funcionando.
-   **Velocidad:** Soporta descargas paralelas para acelerar el proceso.

### Instalación en Ubuntu 24.04 LTS

La forma más robusta de instalar `yt-dlp` y mantenerlo actualizado es descargando el binario directamente.

```bash
# Descarga el último binario a /usr/local/bin
sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
# Dale permisos de ejecución
sudo chmod a+rx /usr/local/bin/yt-dlp
```

### 🎓 Guía Práctica: Recetas de `yt-dlp` por Rol Profesional

---

#### Receta 1: Archivar Contenido Formativo (Para TODOS los Roles)

* **Objetivo:** Descargar un tutorial o la charla de una conferencia importante desde YouTube para verla offline o para guardarla en la base de conocimiento del equipo.
* **El Comando:**
    ```bash
    # Simplemente pasa la URL del vídeo entre comillas
    yt-dlp "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
    ```
* **Análisis y Estrategia:** Este es el uso más simple y directo. `yt-dlp` analizará la página, encontrará la mejor calidad de vídeo y audio disponible, las descargará y las fusionará en un único archivo (`.mp4` o similar) en tu directorio actual.
* **Utilidad:** Permite construir una librería de formación permanente, accesible incluso sin conexión a internet.

---

#### Receta 2: Crear un Podcast Personalizado (SysOps / DevOps / SRE)

* **Objetivo:** Hay una larga lista de reproducción en YouTube con charlas técnicas que quieres escuchar mientras te desplazas o haces otras tareas, sin necesidad del vídeo.
* **El Comando:**
    ```bash
    # -x para extraer audio, --audio-format para convertir a mp3
    # -o para dar un formato de nombre de archivo limpio
    yt-dlp -x --audio-format mp3 -o '%(playlist_index)s - %(title)s.%(ext)s' "URL_DE_LA_PLAYLIST_DE_YOUTUBE"
    ```
* **Análisis y Estrategia:**
    * `-x` o `--extract-audio`: Le dice a `yt-dlp` que ignore el vídeo y se quede solo con la pista de audio.
    * `--audio-format mp3`: Convierte el audio extraído al formato MP3, que es universalmente compatible.
    * `-o '%(playlist_index)s - %(title)s.%(ext)s'`: Esta es una plantilla de salida. Le decimos que nombre cada archivo con el número del vídeo en la lista (`playlist_index`), el título del vídeo (`title`) y la extensión correcta (`ext`).
* **Utilidad:** Transforma contenido de vídeo en un formato de solo audio fácil de consumir, perfecto para el aprendizaje continuo de profesionales ocupados.

---

#### Receta 3: Análisis Forense y de Contenido (SecOps)

* **Objetivo:** Como parte de una investigación, necesitas descargar todos los vídeos de un canal o usuario sospechoso en una plataforma para un análisis offline, incluyendo todos los metadatos disponibles (fecha de subida, descripción, etc.) en un archivo separado.
* **El Comando:**
    ```bash
    # --write-info-json guarda los metadatos
    # --download-archive usado para registrar descargas y evitar duplicados
    yt-dlp --write-info-json --download-archive downloaded_videos.txt "URL_DEL_CANAL_O_USUARIO"
    ```
* **Análisis y Estrategia:**
    * `--write-info-json`: Por cada vídeo descargado, guarda un archivo `.json` complementario que contiene todos los metadatos que la plataforma proporciona (descripción, etiquetas, fecha, duración, etc.).
    * `--download-archive downloaded_videos.txt`: Crea un archivo que registra los IDs de todos los vídeos descargados. Si vuelves a ejecutar el comando, `yt-dlp` leerá este archivo y se saltará los vídeos que ya tiene, descargando solo los nuevos.
* **Utilidad:** Es una herramienta indispensable para la inteligencia de fuentes abiertas (OSINT) y el análisis forense digital. Permite archivar evidencia digital de forma masiva y registrar qué se ha descargado y cuándo, asegurando que no se pierda información si el contenido original es eliminado.
