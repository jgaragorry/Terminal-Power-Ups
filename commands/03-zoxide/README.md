# comando zoxide

## 🚀 Un `cd` con Cerebro

`zoxide` es un reemplazo inteligente para el comando `cd`. Aprende de los directorios que visitas y te permite saltar a ellos en un instante, sin importar en qué parte del sistema de archivos te encuentres. Elimina la necesidad de escribir rutas largas y repetitivas.

### ¿Qué es y por qué es mejor?

-   **Navegación por Frecuencia:** `zoxide` mantiene una base de datos de los directorios que visitas y ordena los resultados por "frecuencia" (una combinación de cuántas veces y qué tan recientemente los has visitado).
-   **Búsqueda Difusa:** No necesitas el nombre exacto. `zoxide` te llevará al mejor resultado coincidente. `z proj` podría llevarte a `~/documentos/proyectos/cliente-importante/`.
-   **Interactivo:** Se integra con `fzf` para ofrecer un menú de búsqueda interactivo para tu historial de directorios.

### Instalación y Configuración en Ubuntu 24.04 LTS

1.  **Instalar con el script oficial:**
    ```bash
    curl -sS [https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh](https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh) | bash
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
