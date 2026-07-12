#!/bin/bash
# Megacore Project Compliance Status Dashboard (2026)

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}====================================================${NC}"
echo -e "${CYAN} 🌌 Ecosistema Megacore 2026 - Compliance Status ${NC}"
echo -e "${CYAN}====================================================${NC}"

# 1. Check Git & no-mistakes gate
echo -e "\n${BLUE}[1/5] Git & no-mistakes Proxy Gate:${NC}"
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git rev-parse --abbrev-ref HEAD)
  echo -e "  • Rama actual: ${GREEN}$branch${NC}"
  
  if git remote | grep -q "no-mistakes"; then
    gate_url=$(git remote get-url no-mistakes)
    echo -e "  • Remote no-mistakes: ${GREEN}Activo${NC} ($gate_url)"
    
    # Check if pushurl is redirected
    push_url=$(git remote get-url --push origin 2>/dev/null)
    if [[ "$push_url" == *"/no-mistakes/"* ]]; then
      echo -e "  • Push redirection (origin): ${GREEN}Redirigido de forma segura (OK)${NC}"
    else
      echo -e "  • Push redirection (origin): ${YELLOW}No redirigido a no-mistakes${NC}"
    fi
  else
    echo -e "  • Remote no-mistakes: ${RED}No configurado${NC}"
  fi
else
  echo -e "  • ${RED}No es un repositorio Git válido.${NC}"
fi

# 2. Check Biome Configuration
echo -e "\n${BLUE}[2/5] Calidad de Código (Biome):${NC}"
if [[ -f "biome.json" ]]; then
  echo -e "  • Archivo biome.json: ${GREEN}Presente${NC}"
  if command -v npx >/dev/null 2>&1; then
    if npx @biomejs/biome check . >/dev/null 2>&1; then
      echo -e "  • Estado del linter/formateador: ${GREEN}Sin fallos (100% Calidad)${NC}"
    else
      echo -e "  • Estado del linter/formateador: ${YELLOW}Errores pendientes de corregir${NC} (Ejecuta: npx @biomejs/biome check --write .)"
    fi
  else
    echo -e "  • Estado: ${YELLOW}npx no disponible para verificar en local${NC}"
  fi
else
  echo -e "  • Archivo biome.json: ${RED}Ausente${NC}"
fi

# 3. Check Pre-commit hooks (Lefthook)
echo -e "\n${BLUE}[3/5] Orquestación de Hooks (Lefthook):${NC}"
if [[ -f "lefthook.yml" ]]; then
  echo -e "  • Archivo lefthook.yml: ${GREEN}Presente${NC}"
  if [[ -f ".git/hooks/pre-commit" ]]; then
    echo -e "  • Hooks activos: ${GREEN}Lefthook instalado en pre-commit (OK)${NC}"
  else
    echo -e "  • Hooks activos: ${RED}No instalados en .git${NC} (Ejecuta: lefthook install)"
  fi
else
  echo -e "  • Archivo lefthook.yml: ${RED}Ausente${NC}"
fi

# 4. Check Security Supply Chain (Bumblebee)
echo -e "\n${BLUE}[4/5] Seguridad de Dependencias (Bumblebee):${NC}"
if [[ -f "scripts/security_audit.sh" ]]; then
  echo -e "  • Script de auditoría: ${GREEN}Presente${NC}"
  if [[ -f "openwiki/logs/security_audit_last.json" ]]; then
    echo -e "  • Último escaneo: ${GREEN}Guardado${NC}"
  else
    echo -e "  • Último escaneo: ${YELLOW}No realizado aún${NC} (Ejecuta: ./scripts/security_audit.sh)"
  fi
else
  echo -e "  • Script de auditoría: ${RED}Ausente${NC}"
fi

# 5. Check Documentation (OpenWiki)
echo -e "\n${BLUE}[5/5] Documentación Técnica (OpenWiki):${NC}"
if [[ -d "openwiki" ]]; then
  echo -e "  • Directorio openwiki: ${GREEN}Presente${NC}"
  if [[ -f "openwiki/quickstart.md" ]]; then
    echo -e "  • Fichero quickstart.md: ${GREEN}Presente (Listo para onboarding)${NC}"
  else
    echo -e "  • Fichero quickstart.md: ${RED}Ausente${NC}"
  fi
else
  echo -e "  • Directorio openwiki: ${RED}Ausente${NC}"
fi

echo -e "${CYAN}====================================================${NC}"
