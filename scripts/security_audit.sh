#!/usr/bin/env bash
# 🐝 Megacore Security Audit Script (powered by Perplexity Bumblebee)
# Parte del Pilar 5 (Seguridad) del estándar Megacore de Megasoft.

set -euo pipefail

echo -e "\033[1;33m🐝 Iniciando auditoría de seguridad local con Bumblebee...\033[0m"

# Verificar si bumblebee está instalado
if ! command -v bumblebee >/dev/null 2>&1; then
  echo -e "⚠️ \033[1;31mBumblebee no está instalado en el sistema.\033[0m"
  echo "Para instalarlo, ejecuta: go install github.com/perplexityai/bumblebee/cmd/bumblebee@latest"
  echo "O usa el instalador de stack local: python3 /home/asanchez/.gemini/antigravity-cli/brain/7d8cf109-6fa0-4afc-ba5b-adf21bf67abf/scratch/install_hype_tools.py"
  exit 0
fi

# Ejecutar el escaneo de metadatos de dependencias, MCPs y configuración de agentes
# Bumblebee genera NDJSON por defecto. Lo guardamos en logs locales para no comprometer el repo.
LOG_DIR="openwiki/logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/security_audit_last.json"

echo "🔍 Escaneando dependencias, MCPs y extensiones locales..."
if bumblebee scan > "$LOG_FILE" 2>/dev/null; then
  echo -e "✅ \033[1;32mAuditoría completada.\033[0m Informe guardado en: $LOG_FILE"
else
  # Si falla o no devuelve datos
  echo -e "⚠️ \033[1;35mEl escáner no pudo completar el informe. Revisa la configuración de tu entorno.\033[0m"
fi
