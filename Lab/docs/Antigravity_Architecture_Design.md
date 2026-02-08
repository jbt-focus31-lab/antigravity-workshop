# Antigravity Workshop: Estrategia de Arquitectura y Diseño

Este documento define la estructura, conceptos y estrategia operativa para el "Antigravity Workshop", un entorno de laboratorio diseñado para desarrollar y probar capacidades de IA (Skills, Rules, Workflows) aplicadas tanto a Ingeniería de Software como a Gestión del Conocimiento.

## 1. Conceptos Nucleares de Antigravity

Para operar eficientemente con Antigravity, distinguimos tres componentes clave que definen cómo el agente interactúa con el entorno.

### 1.1 Skills (Habilidades)

> 📚 **Documentación oficial:** [Skills en Antigravity](https://antigravity.google/docs/skills)

*   **Definición:** Extensiones modulares que otorgan capacidades técnicas específicas al agente. Son las "herramientas" en la caja de herramientas del agente.
*   **Activación:** El agente las activa automáticamente cuando su motor de razonamiento identifica que son relevantes para el objetivo del usuario (patrón de "divulgación progresiva").
*   **Función:** Ejecutar lógica compleja, interactuar con APIs/DBs, automatizar tareas repetitivas y gestionar archivos con precisión.
*   **Estructura:**
    *   `SKILL.md` (Obligatorio): Metadatos YAML (nombre, descripción) y manual de instrucciones en Markdown.
    *   `scripts/` (Opcional): Código ejecutable (Python, Bash, Node) que actúa como "caja negra".
    *   `examples/` (Opcional): Implementaciones de referencia y patrones de uso.
    *   `resources/` (Opcional): Plantillas y archivos de configuración.
*   **Ubicación:** `.agent/skills/` (Nivel Workspace).
*   **Mejores prácticas:**
    *   Mantener cada skill enfocado en una capacidad específica.
    *   Escribir descripciones claras para que el agente sepa cuándo activarlas.
    *   Usar scripts como cajas negras con interfaces bien definidas.

### 1.2 Rules (Reglas)

> 📚 **Documentación oficial:** [Rules en Antigravity](https://antigravity.google/docs/rules)

*   **Definición:** Directrices de comportamiento y restricciones. Son la "personalidad" y el "código de conducta" del agente.
*   **Activación:** Pasiva - siempre activas o activadas por tipo de archivo. Se inyectan en el prompt del sistema.
*   **Función:** Asegurar consistencia, estilo y seguridad en todas las operaciones. Actúan como "guardarraíles" que restringen el **CÓMO** se realiza cada tarea.
*   **Tipos:**
    *   **Globales:** Preferencias de usuario universales (idioma, concisión, estilo de código).
    *   **Workspace:** Estándares específicos del proyecto (stack tecnológico, formatos de fecha, convenciones de nombres).
*   **Ubicación:** Configuración Global o `.agent/rules/`.
*   **Ejemplos de uso:**
    *   "Siempre usar TypeScript en modo estricto"
    *   "Nunca hacer commit de secretos"
    *   "Usar formato de fecha ISO 8601"

### 1.3 Workflows (Flujos de Trabajo)

> 📚 **Documentación oficial:** [Workflows en Antigravity](https://antigravity.google/docs/workflows)

*   **Definición:** Algoritmos procedurales paso a paso. Son las "recetas" que guían procesos complejos.
*   **Activación:** Activa - invocados explícitamente por el usuario (ej. `/test`, `/deploy`, `/review`).
*   **Función:** Orquestar tareas secuenciales que pueden involucrar múltiples Skills y validaciones humanas. Actúan como "macros" en un entorno agéntico.
*   **Ubicación:** `.agent/workflows/` (archivos `.md` con YAML frontmatter).
*   **Características:**
    *   Formato: YAML frontmatter + Markdown con pasos secuenciales.
    *   Pueden incluir anotaciones especiales:
        *   `// turbo`: Auto-ejecuta un paso específico que involucra `run_command`.
        *   `// turbo-all`: Auto-ejecuta TODOS los pasos que involucran `run_command`.
    *   Permiten reutilizar información para completar varias tareas.
    *   Facilitan el "apilamiento" de skills para tareas complejas.
*   **Casos de uso:**
    *   Orquestación manual de procesos multi-paso.
    *   Procedimientos estandarizados que requieren intervención humana.
    *   Distribución de flujos de trabajo aprobados en equipos.

---

## 2. Comparativa y Sinergias

| Característica | **RULES** (El CÓMO SOY) | **WORKFLOWS** (El QUÉ SIGO) | **SKILLS** (El QUÉ PUEDO HACER) |
| :--- | :--- | :--- | :--- |
| **Rol** | Manual del Empleado | Receta de Cocina | Caja de Herramientas |
| **Activación** | Pasiva / Siempre activa | Activa / Bajo demanda explícita | Dinámica / Contextual (agente decide) |
| **Naturaleza** | Texto (Instrucciones) | Texto (Markdown con pasos) | Código + Instrucciones |
| **Visibilidad** | Inyectadas en prompt del sistema | Invocadas por comando del usuario | Descubiertas por el agente según necesidad |
| **Propósito** | Restricciones y guardarraíles | Orquestación de procesos | Capacidades técnicas específicas |

**Sinergias Operativas:**
*   Un **Workflow** orquesta el proceso general y define la secuencia de pasos.
*   El Workflow invoca **Skills** para tareas técnicas complejas o especializadas.
*   Las **Rules** supervisan que tanto el Workflow como los Skills se ejecuten bajo los estándares definidos (seguridad, estilo, convenciones).

**Ejemplo práctico:**
```
USER: /deploy-to-production

[WORKFLOW] Lee el archivo .agent/workflows/deploy.md
  ├─ Paso 1: Ejecutar tests → Invoca SKILL "run-tests"
  ├─ Paso 2: Build de producción → Invoca SKILL "build-docker"
  ├─ Paso 3: Deploy → Invoca SKILL "deploy-k8s"
  └─ [RULES] supervisan todo el proceso:
      • "Nunca deployar sin tests pasados"
      • "Siempre usar tags semánticos en Docker"
      • "Notificar al equipo en Slack tras deploy"
```

### Sobre `AGENTS.md`

> 📚 **Contexto:** [AGENTS.md](https://github.com/aibtcdev/agent-tools-ts) es un estándar emergente en la industria para documentar proyectos orientados a IAs.

Aunque es un estándar emergente en la industria para documentar proyectos para IAs, en Antigravity se recomienda su uso principalmente como **documentación de alto nivel** o punto de entrada interoperable.

*   **Estrategia recomendada:** 
    *   Mantener un `AGENTS.md` en la raíz como **"Single Source of Truth"** del contexto del proyecto.
    *   Usar una **Rule** nativa de Antigravity para forzar su lectura al inicio de las sesiones.
    *   Incluir en `AGENTS.md`:
        *   Descripción general del proyecto y su propósito.
        *   Arquitectura de alto nivel.
        *   Referencias a Skills, Workflows y Rules disponibles.
        *   Convenciones y estándares del proyecto.
        *   Puntos de entrada para nuevos colaboradores (humanos o agentes).

---

## 3. Arquitectura del Proyecto "Workshop"

El proyecto se estructura para separar claramente la definición de herramientas (versionadas) del trabajo en curso (efímero).

### 3.1 Estructura de Directorios

```plaintext
antigravity-workshop/
├── .agent/                 # [GIT] El "Cerebro" del Taller
│   ├── skills/             # Definición de capacidades (ej. generate-stack)
│   ├── rules/              # Reglas del laboratorio
│   └── workflows/          # Procedimientos estandarizados
│
├── Lab/                    # [GIT] El "Laboratorio"
│   ├── templates/          # Plantillas para Docker, Markdown, notas...
│   ├── scripts/            # Scripts auxiliares no empaquetados como skills
│   └── prompts/            # Prompts de ingeniería y pruebas
│
├── Workbench/              # [GIT-IGNORE] El "Banco de Trabajo"
│   ├── output/             # Resultados generados por los Skills
│   ├── temp/               # Archivos temporales de procesamiento
│   └── .gitkeep            # Único archivo trackeado para mantener la carpeta
│
├── AGENTS.md               # Contexto general del laboratorio
└── .gitignore              # Configurado para ignorar /Workbench/*
```

### 3.2 Estrategia de Versionado
*   **Repositorio Privado:** `antigravity-workshop` (o nombre similar).
*   **Sync:** Todo el contenido de `.agent` y `Lab` se sincroniza.
*   **Local-Only:** El contenido de `Workbench` es local y efímero, permitiendo procesar datos sensibles (facturas, notas personales) sin riesgo de subida accidental.

---

## 4. Dominios de Operación y Casos de Uso

El taller se utilizará para desarrollar Skills aplicables en dos grandes áreas:

### 4.1 Ingeniería de Software (DevOps & Automation)
*   **Enfoque:** Automatización de infraestructura y desarrollo de stacks.
*   **Caso de Uso Prioritario:** "El Constructor de Stacks".
    *   **Skill:** `generate-stack`.
    *   **Objetivo:** Generar scaffolding para servicios (n8n, PostgreSQL, Qdrant) usando plantillas predefinidas en `Lab/templates`.
*   **Otros Casos:** Análisis de logs de Docker, limpieza de bases de datos de prueba.

### 4.2 Gestión de Información (Second Brain & Content)
*   **Enfoque:** Procesamiento de lenguaje natural, estructuración de datos y gestión documental.
*   **Caso de Uso Prioritario:** "El Sintetizador de Conocimiento".
    *   **Skill:** `synthesize-note`.
    *   **Objetivo:** Transformar documentos crudos (PDF, MD desordenado) en el `Workbench` en notas atómicas estructuradas (Markdown con Frontmatter) listas para el Cerebro Digital.
*   **Otros Casos:** Organización de facturas (renombrado y clasificación), generación de borradores de artículos.
