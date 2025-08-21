# comando xh

## 🚀 La Alternativa Moderna y Amigable a curl

`xh` es un cliente HTTP de línea de comandos escrito en Rust, diseñado para ser una alternativa más rápida, amigable y ergonómica que `curl`. Su objetivo es hacer que la interacción con APIs y servicios web desde la terminal sea lo más simple y placentera posible.

### ¿Qué es y por qué es mejor?

-   **Sintaxis Intuitiva:** La sintaxis es mucho más simple y natural. Enviar datos JSON o cabeceras personalizadas es trivial, en lugar de la compleja cadena de flags de `curl`.
-   **Salida Hermosa por Defecto:** La salida está coloreada, el JSON se formatea e indenta automáticamente (`pretty-print`), y las cabeceras se presentan de forma clara. No necesitas tuberías a `jq` para una lectura básica.
-   **Descargas Fáciles:** Incluye una interfaz de descarga con barra de progreso, similar a `wget`.
-   **Rendimiento:** Al estar escrito en Rust, es extremadamente rápido.

### Instalación en Ubuntu 24.04 LTS

`xh` está disponible directamente en los repositorios de Ubuntu 24.04, lo que hace su instalación muy sencilla.

```bash
sudo apt update
sudo apt install -y xh
```

### 🎓 Guía Práctica: Recetas de `xh` por Rol Profesional

A continuación se presentan casos de uso 100% validados para resolver problemas del mundo real.

---

#### Receta 1: Troubleshooting Básico de API (SysOps / DevOps)

* **Objetivo:** Verificar rápidamente si un endpoint de una API está activo, qué cabeceras devuelve y cuál es su respuesta. Esta es la prueba de "humo" más fundamental.
* **El Comando:**
    ```bash
    # Usamos la API pública de GitHub como ejemplo
    xh GET [https://api.github.com/repos/google/go-github](https://api.github.com/repos/google/go-github)
    ```
* **Análisis y Ventajas:**
    * **¿Qué hace?** Realiza una petición `GET` al endpoint especificado. `GET` es la acción por defecto, por lo que incluso se puede omitir: `xh https://api.github.com/...`.
    * **¿Por qué usarlo?** Compara la claridad de la salida con la de `curl https://api.github.com/repos/google/go-github`. `xh` te da colores, formato y separa claramente las cabeceras de la respuesta del cuerpo JSON, todo sin necesidad de flags adicionales.
    * **Resultados Esperados:** Verás una respuesta HTTP clara, con las cabeceras de la respuesta coloreadas en la parte superior, seguidas por el cuerpo JSON perfectamente indentado y coloreado, mostrando los detalles del repositorio.

---

#### Receta 2: Probar un Endpoint con Datos (DevOps / SRE)

* **Objetivo:** Enviar datos a un endpoint `POST` para probar la creación de un recurso, incluyendo una cabecera de autenticación y un cuerpo JSON con diferentes tipos de datos.
* **El Comando:**
    ```bash
    # Usamos httpbin.org, un servicio para probar peticiones HTTP. Nos devolverá lo que le enviamos.
    xh POST httpbin.org/post 'Authorization:Bearer MI_TOKEN_SECRETO' app=mi-app version:=1.2 status=active
    ```
* **Análisis y Estrategia:**
    * **¿Qué hace?** Envía una petición `POST`.
    * `'Authorization:Bearer ...'`: Así de fácil es añadir una **cabecera HTTP**. Simplemente se escribe como `Clave:Valor`.
    * `app=mi-app`: `xh` interpreta esto como un campo de texto en el cuerpo JSON.
    * `version:=1.2`: **¡Magia!** Al usar `:=`, le decimos a `xh` que trate `1.2` como un **número**, no como una cadena de texto.
    * `status=active`: Otro campo de texto. `xh` construirá automáticamente el cuerpo `{"app": "mi-app", "version": 1.2, "status": "active"}` y añadirá la cabecera `Content-Type: application/json`.
* **Ventaja sobre `curl`:** La sintaxis de `curl` para esta misma acción es mucho más compleja y propensa a errores: `curl -X POST -H "Authorization: Bearer..." -H "Content-Type: application/json" -d '{"app": "mi-app", ...}' httpbin.org/post`.

---

#### Receta 3: Descarga de Archivos para Automatización (SysOps / DevOps)

* **Objetivo:** Descargar un archivo binario o un script de instalación desde una URL, mostrando una barra de progreso.
* **El Comando:**
    ```bash
    # Descargamos los checksums de una release de Trivy como ejemplo seguro
    xh --download [https://github.com/aquasecurity/trivy/releases/download/v0.53.0/trivy_0.53.0_checksums.txt](https://github.com/aquasecurity/trivy/releases/download/v0.53.0/trivy_0.53.0_checksums.txt)
    ```
* **Análisis y Estrategia:**
    * `--download` (o su alias `-d`): Activa el modo de descarga. `xh` mostrará una barra de progreso y guardará el archivo en el directorio actual con su nombre original (`trivy_0.53.0_checksums.txt`).
    * **¿Por qué usarlo?** Es la combinación perfecta de la simplicidad de `wget` con la potencia de `xh`. Es ideal para scripts de automatización (`bash`, `Ansible`) que necesitan descargar artefactos o herramientas como parte de su ejecución.
* **Resultado Esperado:** Una barra de progreso en tu terminal seguida de la creación del archivo en tu directorio.

---

#### Receta 4: Auditoría Rápida de Cabeceras de Seguridad (SecOps / DevSecOps)

* **Objetivo:** Revisar rápidamente qué cabeceras de seguridad HTTP (como `Content-Security-Policy` o `Strict-Transport-Security`) está enviando un servidor web, sin necesidad de descargar todo el contenido de la página.
* **El Comando:**
    ```bash
    xh --headers HEAD [https://google.com](https://google.com)
    ```
* **Análisis y Estrategia:**
    * `HEAD`: Usamos el método HTTP `HEAD`. Este método le pide al servidor **solo las cabeceras**, no el cuerpo HTML de la página. Es extremadamente rápido y eficiente.
    * `--headers` (o `-h`): Le dice a `xh` que en la salida solo nos interesan las cabeceras de la respuesta, ignorando el cuerpo (que de por sí estaría vacío).
* **Utilidad:** Es una técnica de reconocimiento y auditoría fundamental. Un analista de SecOps puede usar este comando para realizar una primera comprobación de la "higiene" de la configuración de seguridad de un servidor web en menos de un segundo.
