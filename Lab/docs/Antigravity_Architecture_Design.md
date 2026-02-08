# Antigravity Workshop: Estrategia de Arquitectura y Diseño

Este documento define la estructura, conceptos y estrategia operativa para el "Antigravity Workshop", un entorno de laboratorio diseñado para desarrollar y probar capacidades de IA (Skills, Rules, Workflows) aplicadas tanto a Ingeniería de Software como a Gestión del Conocimiento.

## 1. Conceptos Nucleares de Antigravity

Para operar eficientemente con Antigravity, distinguimos tres componentes clave que definen cómo el agente interactúa con el entorno.

### 1.1 Skills (Habilidades)
*   **Definición:** Extensiones modulares que otorgan capacidades técnicas específicas al agente. Son las "herramientas" en la caja de herramientas del agente.
*   **Función:** Ejecutar lógica compleja, interactuar con APIs/DBs, automatizar tareas repetitivas y gestionar archivos con precisión.
*   **Estructura:**
    *   `SKILL.md` (Obligatorio): Metadatos YAML y manual de instrucciones.
    *   `scripts/` (Opcional): Código ejecutable (Python, Bash, Node).
    *   `resources/` (Opcional): Plantillas y archivos de configuración.
*   **Ubicación:** `.agent/skills/` (Nivel Workspace).

### 1.2 Rules (Reglas)
*   **Definición:** Directrices de comportamiento y restricciones. Son la "personalidad" y el "código de conducta" del agente.
*   **Función:** Asegurar consistencia, estilo y seguridad en todas las operaciones.
*   **Tipos:**
    *   **Globales:** Preferencias de usuario universales (idioma, concisión).
    *   **Workspace:** Estándares específicos del proyecto (stack tecnológico, formatos de fecha).
*   **Ubicación:** Configuración Global o `.agent/rules/`.

### 1.3 Workflows (Flujos de Trabajo)
*   **Definición:** Algoritmos procedurales paso a paso. Son las "recetas" que guían procesos complejos.
*   **Función:** Orquestar tareas secuenciales que pueden involucrar múltiples Skills y validaciones humanas.
*   **Ubicación:** `.agent/workflows/`.

---

## 2. Comparativa y Sinergias

| Característica | **RULES** (El CÓMO SOY) | **WORKFLOWS** (El QUÉ SIGO) | **SKILLS** (El QUÉ PUEDO HACER) |
| :--- | :--- | :--- | :--- |
| **Rol** | Manual del Empleado | Receta de Cocina | Caja de Herramientas |
| **Activación** | Pasiva / Siempre activa | Activa / Bajo demanda | Dinámica / Contextual |
| **Naturaleza** | Texto (Instrucciones) | Texto (Markdown con pasos) | Código + Instrucciones |

**Sinergias Operativas:**
*   Un **Workflow** orquesta el proceso.
*   El Workflow invoca **Skills** para tareas técnicas difíciles.
*   Las **Rules** supervisan que tanto el Workflow como los Skills se ejecuten bajo los estándares definidos.

### Sobre `AGENTS.md`
Aunque es un estándar emergente en la industria para documentar proyectos para IAs, en Antigravity se recomienda su uso principalmente como **documentación de alto nivel** o punto de entrada interoperable.
*   **Estrategia:** Mantener un `AGENTS.md` en la raíz como "Single Source of Truth" del contexto del proyecto y usar una **Rule** nativa para forzar su lectura al inicio de las sesiones.

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
