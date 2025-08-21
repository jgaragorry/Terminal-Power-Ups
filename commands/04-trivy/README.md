# comando trivy

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
