#!/bin/bash

# ==============================================================================
# SCRIPT DE INSTALACIÓN PARA TERMINAL POWER-UPS
# PROBADO EN UBUNTU SERVER 24.04 LTS
# ==============================================================================

set -e # Salir inmediatamente si un comando falla

# --- Función para registrar mensajes ---
log() {
    echo "🚀 [LOG] $1"
}

# --- Función para registrar errores y salir ---
error_exit() {
    echo "❌ [ERROR] $1" >&2
    exit 1
}

log "Iniciando la instalación de la colección 'Terminal Power-Ups'..."

# --- Actualizar repositorios y asegurar prerrequisitos ---
log "Actualizando repositorios y asegurando prerrequisitos (curl, apt-transport-https)..."
sudo apt-get update || error_exit "No se pudo actualizar los repositorios."
sudo apt-get install -y curl apt-transport-https || error_exit "No se pudieron instalar los prerrequisitos."


# --- 1. xh (Alternativa a curl) ---
log "Instalando xh..."
sudo apt-get install -y xh || error_exit "Falló la instalación de xh."


# --- 2. fzf (Buscador Difuso) ---
log "Instalando fzf..."
sudo apt-get install -y fzf || error_exit "Falló la instalación de fzf."


# --- 3. zoxide (cd inteligente) ---
log "Instalando zoxide..."
if ! command -v zoxide &> /dev/null; then
    # Usamos el método oficial de instalación con su script
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash || error_exit "Falló la instalación de zoxide."
    # Añadimos zoxide al PATH para la sesión actual
    export PATH="$HOME/.local/bin:$PATH"
else
    log "zoxide ya parece estar instalado."
fi


# --- 4. trivy (Escáner de Seguridad) ---
log "Instalando trivy..."
if ! command -v trivy &> /dev/null; then
    # Usamos el método oficial de instalación con su script, en /usr/local/bin
    curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sudo sh -s -- -b /usr/local/bin || error_exit "Falló la instalación de trivy."
else
    log "trivy ya parece estar instalado."
fi


# --- 5. yt-dlp (Descargador de Medios) ---
log "Instalando yt-dlp..."
# Usamos el método recomendado de descarga directa para tener la última versión
sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp || error_exit "Falló la descarga de yt-dlp."
sudo chmod a+rx /usr/local/bin/yt-dlp || error_exit "Falló al dar permisos de ejecución a yt-dlp."


log "=========================================================================================="
log "🎉 ¡Instalación completada!"
log "⚠️  ACCIÓN REQUERIDA: Para activar la integración completa de 'fzf' y 'zoxide',"
log "   añade las siguientes líneas al final de tu archivo ~/.bashrc y luego reinicia tu terminal:"
log ''
log '   # Integración de fzf (búsqueda de historial con Ctrl+R)'
log '   [ -f ~/.fzf.bash ] && source ~/.fzf.bash'
log ''
log '   # Integración de zoxide (cd inteligente)'
log '   eval "$(zoxide init bash)"'
log "=========================================================================================="
