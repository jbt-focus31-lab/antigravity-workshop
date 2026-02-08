# Antigravity Workshop

> **Laboratorio de experimentación para desarrollar capacidades de IA aplicadas a Ingeniería de Software y Gestión del Conocimiento**

## Contexto del Proyecto

Este es un **entorno de laboratorio** diseñado para desarrollar, probar y perfeccionar capacidades de IA (Skills, Rules, Workflows) utilizando Google Antigravity. El proyecto sirve como repositorio de conocimiento y caja de herramientas reutilizable.

## Propósito

- 🧪 Experimentar con nuevas capacidades de IA
- 📚 Documentar mejores prácticas con Antigravity
- 🛠️ Crear herramientas reutilizables para proyectos futuros
- 🎓 Aprender sobre arquitectura agéntica

## Arquitectura

El proyecto se estructura en tres áreas principales:

### 1. `.agent/` - El Cerebro del Taller

**Contenido versionado en Git**

- **`skills/`** - Capacidades técnicas específicas que el agente puede activar automáticamente
  - Cada skill es una carpeta con `SKILL.md` (obligatorio) + `scripts/` y `resources/` (opcionales)
  - Ejemplos: `generate-stack`, `synthesize-note`
  
- **`rules/`** - Directrices de comportamiento y restricciones siempre activas
  - Definen el "cómo" de todas las operaciones
  - Aseguran consistencia, estilo y seguridad
  
- **`workflows/`** - Procedimientos paso a paso invocados explícitamente
  - Formato: Archivos `.md` con YAML frontmatter
  - Se invocan con comandos como `/deploy`, `/test`, `/review`

### 2. `Lab/` - El Laboratorio

**Contenido versionado en Git**

- **`docs/`** - Documentación del proyecto
  - `Antigravity_Architecture_Design.md` - Documento maestro de arquitectura
  
- **`templates/`** - Plantillas reutilizables
  - Docker Compose, Markdown, configuraciones, etc.
  
- **`scripts/`** - Scripts auxiliares no empaquetados como skills
  
- **`prompts/`** - Prompts de ingeniería y pruebas

### 3. `Workbench/` - El Banco de Trabajo

**⚠️ NO versionado en Git (git-ignored)**

- **`output/`** - Resultados generados por Skills
- **`temp/`** - Archivos temporales de procesamiento

**Importante:** Esta área permite trabajar con datos sensibles (facturas, notas personales, PDFs) sin riesgo de subida accidental al repositorio.

## Dominios de Operación

### 1. Ingeniería de Software (DevOps & Automation)

**Enfoque:** Automatización de infraestructura y desarrollo de stacks

**Caso de uso prioritario:** "El Constructor de Stacks"
- **Skill:** `generate-stack`
- **Objetivo:** Generar scaffolding para servicios (n8n, PostgreSQL, Qdrant) usando plantillas

**Otros casos:**
- Análisis de logs de Docker
- Limpieza de bases de datos de prueba
- Generación de configuraciones

### 2. Gestión de Información (Second Brain & Content)

**Enfoque:** Procesamiento de lenguaje natural, estructuración de datos y gestión documental

**Caso de uso prioritario:** "El Sintetizador de Conocimiento"
- **Skill:** `synthesize-note`
- **Objetivo:** Transformar documentos crudos (PDF, MD desordenado) en notas atómicas estructuradas (Markdown con Frontmatter)

**Otros casos:**
- Organización de facturas (renombrado y clasificación)
- Generación de borradores de artículos
- Extracción de conceptos clave

## Conceptos Clave de Antigravity

### Skills (Habilidades)

- **Qué son:** Extensiones modulares con capacidades técnicas específicas
- **Activación:** Automática - el agente decide cuándo usarlas según el contexto
- **Ubicación:** `.agent/skills/`
- **Documentación:** [Skills en Antigravity](https://antigravity.google/docs/skills)

### Rules (Reglas)

- **Qué son:** Directrices de comportamiento y restricciones
- **Activación:** Pasiva - siempre activas
- **Ubicación:** `.agent/rules/` o configuración global
- **Documentación:** [Rules en Antigravity](https://antigravity.google/docs/rules)

### Workflows (Flujos de Trabajo)

- **Qué son:** Recetas paso a paso para procesos complejos
- **Activación:** Explícita - el usuario las invoca con comandos
- **Ubicación:** `.agent/workflows/`
- **Documentación:** [Workflows en Antigravity](https://antigravity.google/docs/workflows)

## Sinergias Operativas

```
┌─────────────────────────────────────────────┐
│  USER: /deploy-to-production                │
└─────────────────┬───────────────────────────┘
                  │
                  ▼
         ┌────────────────┐
         │   WORKFLOW     │ ◄─── Orquesta el proceso
         │  deploy.md     │
         └────────┬───────┘
                  │
        ┌─────────┼─────────┐
        │         │         │
        ▼         ▼         ▼
    ┌──────┐ ┌──────┐ ┌──────┐
    │SKILL │ │SKILL │ │SKILL │ ◄─── Ejecutan tareas
    │tests │ │build │ │deploy│
    └──────┘ └──────┘ └──────┘
        │         │         │
        └─────────┼─────────┘
                  │
                  ▼
            ┌──────────┐
            │  RULES   │ ◄─── Supervisan todo
            │ security │
            │  style   │
            └──────────┘
```

## Convenciones del Proyecto

### Idioma
- **Documentación:** Español
- **Código y comentarios:** Inglés (cuando sea código técnico)
- **Commits:** Español, mensajes descriptivos

### Estructura de Skills
```
.agent/skills/nombre-skill/
├── SKILL.md           # Metadatos YAML + instrucciones
├── scripts/           # Código ejecutable (opcional)
│   └── main.py
└── resources/         # Plantillas y assets (opcional)
    └── templates/
```

### Estructura de Workflows
```yaml
---
description: Descripción breve del workflow
---

# Pasos del workflow

1. Primer paso
2. Segundo paso
// turbo
3. Tercer paso (auto-ejecutable)
```

### Formato de Fechas
- **Estándar:** ISO 8601 (`YYYY-MM-DD`)
- **Con hora:** ISO 8601 completo (`YYYY-MM-DDTHH:mm:ss`)

## Recursos y Referencias

### Documentación del Proyecto
- [README.md](README.md) - Documentación principal
- [Arquitectura y Diseño](Lab/docs/Antigravity_Architecture_Design.md) - Estrategia completa

### Documentación Oficial
- [Antigravity - Get Started](https://antigravity.google/docs/get-started)
- [Skills](https://antigravity.google/docs/skills)
- [Workflows](https://antigravity.google/docs/workflows)
- [Rules](https://antigravity.google/docs/rules)

### Estándares
- [AGENTS.md Standard](https://github.com/aibtcdev/agent-tools-ts) - Estándar emergente para documentación orientada a IA

## Instrucciones para Agentes de IA

### Al Iniciar una Sesión

1. **Leer este archivo** para entender el contexto del proyecto
2. **Revisar** el documento de arquitectura en `Lab/docs/Antigravity_Architecture_Design.md`
3. **Listar Skills disponibles** en `.agent/skills/`
4. **Listar Workflows disponibles** en `.agent/workflows/`
5. **Aplicar Rules** definidas en `.agent/rules/`

### Al Trabajar con Datos

- **Datos sensibles o temporales:** Usar `Workbench/` (nunca se versionará)
- **Plantillas y recursos:** Usar `Lab/templates/` (se versionará)
- **Resultados finales:** Guardar en `Workbench/output/`

### Al Crear Nuevas Capacidades

1. **Skills:** Crear en `.agent/skills/` con estructura estándar
2. **Workflows:** Crear en `.agent/workflows/` con YAML frontmatter
3. **Rules:** Crear en `.agent/rules/` con instrucciones claras
4. **Documentar:** Actualizar este archivo y el README si es relevante

### Mejores Prácticas

- ✅ Mantener Skills enfocados en una capacidad específica
- ✅ Escribir descripciones claras en `SKILL.md`
- ✅ Usar scripts como cajas negras con interfaces bien definidas
- ✅ Documentar decisiones importantes en `Lab/docs/`
- ✅ Probar en `Workbench/` antes de versionar
- ❌ Nunca versionar datos sensibles o personales
- ❌ Nunca hardcodear credenciales en código

## Estado del Proyecto

**Versión:** 1.0.0 (Inicial)  
**Última actualización:** 2026-02-08  
**Estado:** 🧪 Experimental - En desarrollo activo

## Próximos Pasos

1. Crear el primer Skill: `generate-stack`
2. Crear el primer Workflow: `/setup-project`
3. Definir Rules básicas del laboratorio
4. Probar con casos de uso reales en `Workbench/`
5. Documentar hallazgos y mejores prácticas

---

**Para más información, consulta el [README.md](README.md) completo.**
