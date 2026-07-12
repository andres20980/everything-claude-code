# 🤖 everything-claude-code (ECC Universal)

[![Version](https://img.shields.io/badge/version-2.0.0-blue.svg)](./VERSION)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)
[![Platform](https://img.shields.io/badge/platform-Universal-orange.svg)](#)

`everything-claude-code` (**ECC Universal**) es un sistema operativo de agentes y entorno de pruebas (*harness*) nativo diseñado para unificar flujos de trabajo de IA en terminales y entornos de desarrollo como **Claude Code, Cursor IDE, Codex, OpenCode y Gemini**. 

El proyecto proporciona un plano de control unificado, convenciones MCP (Model Context Protocol), disparadores (*hooks*), directrices de comportamiento (*rules*) y habilidades avanzadas que permiten a los agentes de IA operar de forma autónoma, segura y alineada con las mejores prácticas de ingeniería de software.

---

## 📖 Descripción General

Este repositorio actúa como el **núcleo operativo (Control Plane)** para desarrolladores que utilizan asistentes de IA autónomos o semi-autónomos en su día a día. A diferencia de las configuraciones básicas de agentes, **ECC** implementa un entorno de ejecución dual (Node.js/TypeScript y Python) que expone herramientas avanzadas, validaciones de seguridad en tiempo real y flujos iterativos de autoevaluación.

### Capacidades Principales
*   **Orquestación GAN-Harness (`gan-harness.sh`):** Ciclo generador-evaluador automatizado basado en las metodologías de Anthropic para el desarrollo de aplicaciones de larga duración.
*   **Compatibilidad MCP Nativa (`.mcp.json`):** Integración inmediata con el Model Context Protocol para proporcionar herramientas del sistema de manera estandarizada.
*   **Gestión de Contexto y Memoria:** Arquitectura preparada para el almacenamiento de contexto a largo plazo mediante configuraciones de memoria (`mem0.yaml`) y personalidades de agentes (`SOUL.md`).
*   **Panel de Operador (`ecc_dashboard.py`):** Interfaz visual y funcional para monitorizar las tareas ejecutadas por los agentes en segundo plano.

---

## 🛠️ Tecnologías y Librerías Utilizadas

El proyecto combina un ecosistema de herramientas de alto rendimiento para garantizar un análisis y ejecución ágiles:

*   **Runtimes:** Node.js (>=18) y Python 3.10+.
*   **Frontend/Dashboard:** Python Dashboard (`ecc_dashboard.py`) y servidor Nginx en contenedor Docker para despliegues estáticos.
*   **Librerías Node.js:** `@iarna/toml` (análisis de configuraciones), `ajv` (validación de esquemas JSON), `sql.js` (base de datos SQLite ligera en memoria) y utilidades de linting (ESLint, Biome).
*   **Entorno de IA en Python:** Proveedores locales de LLM (`src/llm/providers/ollama.py`), resolutores de contexto y herramientas de ejecución sandbox (`executor.py`).
*   **Automatización de Calidad:** Lefthook (gestión de git hooks), Biome (formateador y linter ultrarrápido) y Markdownlint.

---

## 📁 Estructura del Repositorio

La arquitectura del proyecto está organizada para separar los motores de ejecución (Node y Python), las reglas del agente y los entornos de automatización:

```bash
everything-claude-code/
├── .claude-plugin/ / .agents/  # Manifiestos y plugins específicos de plataformas de IA
├── src/llm/                     # Núcleo del motor de ejecución de LLM en Python
│   ├── cli/                     # CLI de selección y configuración de modelos
│   ├── core/                    # Tipos del sistema e interfaces de abstracción
│   ├── providers/               # Integraciones de proveedores (ej. Ollama local)
│   └── tools/                   # Herramientas de ejecución seguras (executor.py)
├── scripts/                     # Scripts operativos e integraciones de control
│   ├── ecc.js                   # CLI principal de ECC Universal
│   ├── control-pane.js          # Control de procesos e interfaz de comando
│   ├── gan-harness.sh           # Orquestador del ciclo de evaluación generativa (Adversarial)
│   └── worktree-lifecycle.js    # Gestión avanzada de ramas de trabajo de Git
├── docs/                        # Guías detalladas y traducciones de la documentación
├── agent.yaml                   # Definición de propiedades y comportamiento del agente
├── mem0.yaml                    # Configuración de persistencia de memoria
├── RULES.md / SOUL.md           # Reglas de conducta y guía de personalidad para la IA
├── ecc_dashboard.py             # Dashboard en Python para control de flujos de trabajo
├── .mcp.json                    # Configuración de servidores del Model Context Protocol
├── Dockerfile / nginx.conf      # Configuración de despliegue contenerizado del panel
└── pyproject.toml / package.json# Gestores de dependencias de Python y Node.js
```

---

## 🚀 Instalación y Ejecución Local

### Requisitos Previos
*   **Node.js** v18 o superior (con `yarn` o `npm`).
*   **Python** 3.10 o superior (con soporte para entornos virtuales o Poetry).
*   **Ollama** instalado y ejecutándose localmente (opcional, para modelos locales).

---

### Paso 1: Instalación del Entorno

Puedes configurar de forma automática todas las dependencias y entornos usando el script multiplataforma provisto:

#### En macOS/Linux:
```bash
chmod +x install.sh
./install.sh
```

#### En Windows (PowerShell):
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\install.ps1
```

*Este script detectará los runtimes instalados, configurará el entorno virtual de Python, instalará las dependencias de Node.js y verificará la presencia de herramientas críticas.*

---

### Paso 2: Configuración del Entorno Virtual

Si prefieres realizar el setup de forma manual:

#### Dependencias de Node.js:
```bash
npm install
```

#### Dependencias de Python:
El proyecto soporta ejecución de CLI y Dashboards a través de su módulo LLM. Instala los paquetes requeridos usando el archivo `pyproject.toml` (o mediante `pip install -e .` en el directorio raíz):
```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt # O utilizando tu gestor preferido compatible con pyproject.toml
```

---

### Paso 3: Ejecución de Herramientas Clave

#### 1. Iniciar el Panel de Control (Operator Dashboard):
Para visualizar y monitorizar el estado de tus agentes y la telemetría del sistema:
```bash
python ecc_dashboard.py
```

#### 2. Ejecutar el Generador-Evaluador de Tareas (GAN Harness):
Inicia una tarea de desarrollo compleja con bucles automáticos de retroalimentación de calidad:
```bash
./scripts/gan-harness.sh "Construir una API de consulta de logs"
```
*Este script utiliza las directrices de robustez de Anthropic para validar, refinar y corregir el código generado de manera iterativa hasta alcanzar el estándar esperado.*

#### 3. Ejecutar comandos mediante la CLI de ECC:
```bash
node scripts/ecc.js --help
```

---

## ⚙️ Gobernanza del Proyecto

Este repositorio utiliza estándares avanzados de desarrollo automatizado de **Megasoft** para asegurar que cada contribución y ejecución de agentes mantenga la máxima integridad:

*   **Validación Local Activa:** Mediante **Lefthook**, se ejecutan hooks de Git automatizados (`lefthook.yml`) para asegurar que el código generado no rompa reglas del proyecto.
*   **Estilo y Calidad:** Se utiliza **Biome** (`biome.json`) junto a **ESLint** para garantizar un formateo rápido y libre de errores antes de cada commit.
*   **Seguridad de Operaciones:** El proxy git de protección de ramas y las configuraciones de `.no-mistakes.yaml` previenen la inclusión accidental de claves secretas, credenciales o confirmaciones destructivas directamente en el flujo de trabajo del agente de desarrollo.

---
*Megacore - Automatizando y estandarizando la calidad del software en Megasoft.*