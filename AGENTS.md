# 🤖 Ecosistema Megacore: Manifiesto de Agentes de IA (AGENTS.md)

Este archivo define las directivas de ejecución y el contexto operativo para cualquier agente autónomo de IA (como Claude Code, Cursor, Cline o GitHub Copilot) que trabaje en este repositorio.

---

## 🛠️ Comandos Canónicos de Ejecución y Optimización (RTK)

Para optimizar la ventana de contexto y ahorrar tokens, el sistema utiliza **RTK (Rust Token Killer)**. Los comandos de consola habituales son interceptados automáticamente o deben ser prefijados para comprimir su salida:

*   **Instalación de Dependencias:** `pnpm install` (o el comando detectado en el gestor de paquetes correspondiente).
*   **Compilación / Construcción:** `pnpm run build` (si aplica).
*   **Ejecución de Pruebas (Tests):** `pnpm run test` o `pytest` (si aplica). En caso de salida verbosa, se ejecuta bajo `rtk` (ej. `rtk pytest`).
*   **Formateo y Calidad Local:** `lefthook run pre-commit` (Biome + Bumblebee).
*   **Proxy de Terminal (RTK):** RTK está configurado de forma global en la máquina mediante alias en la shell para comandos como `git`, `pnpm`, `pytest` y `docker`. Asegúrate de verificar las ganancias de contexto ejecutando `rtk gain`.

---

## 🛡️ Reglas de Comportamiento del Agente (Contexto Operativo)

Al realizar modificaciones en este repositorio, debes cumplir estrictamente las siguientes directivas:

1.  **Validación Pre-commit Obligatoria:** Antes de proponer un commit o push, debes comprobar el formateo y linter local ejecutando `lefthook run pre-commit`. Resuelve los errores de Biome inmediatamente.
2.  **Ediciones Quirúrgicas:** Realiza reemplazos de código localizados. Evita reescribir archivos completos o eliminar comentarios e instrucciones heredadas de otros desarrolladores.
3.  **Gobernanza y Políticas (EU CRA):** Todo cambio en dependencias debe ser auditado de forma segura ejecutando `./scripts/security_audit.sh` (Bumblebee) antes del commit.
4.  **Documentación en OpenWiki:** Si cambias la lógica o añades nuevas funcionalidades, debes actualizar la documentación del wiki técnico ejecutando `openwiki --update`.
5.  **Historial de Git:** Sigue el estándar de *Conventional Commits* para redactar los mensajes de commit (ej. `feat(scope): descripción`, `fix(scope): descripción`).
