# Convenciones del Workspace

## Idioma y Comunicación

- Todo en **español**: documentación, conversación, nombres de archivos, comentarios.
- Nombres de archivos y carpetas con **acentos y espacios** cuando sea natural (ej. `Análisis de ventas.md`, `Facturas Pendientes/`).
- Excepción: identificadores técnicos internos de Antigravity (nombres de skills, scripts, claves YAML) pueden usar kebab-case o snake_case por compatibilidad.

## Propósito del Workspace

Este es un **taller de herramientas y manipulación de información**. El agente debe entender que aquí:

- Se crean y prueban **Skills y Workflows** de automatización.
- Se manipulan **documentos**: Markdown, texto plano, CSV y potencialmente ficheros Office (DOCX, XLSX).
- Existe un flujo natural de **ad-hoc → formalización**: muchas tareas empiezan como manipulaciones puntuales y, cuando se repiten o generalizan, se convierten en Skills o Workflows.
- El agente debe estar atento a ese patrón: si una tarea ad-hoc parece generalizable, **sugerir** (no imponer) su conversión en Skill o Workflow.

## Estructura de Trabajo

- **`Workbench/`**: zona de trabajo para datos reales, temporales o sensibles. Nunca se versiona.
- **`Workbench/temp/`**: entrada de datos a procesar.
- **`Workbench/output/`**: resultados generados.
- **`Lab/`**: recursos versionados (plantillas, scripts, prompts, documentación).
- **`.agent/`**: definiciones de Skills, Rules y Workflows.

## Estilo de Interacción

- Preferencia por **explicaciones concisas** y directas.
- **Preguntar antes de tomar decisiones estructurales** (crear carpetas nuevas, reorganizar archivos, cambiar convenciones).
- Para tareas ad-hoc: ejecutar directamente sin ceremonial excesivo.
- Para formalizar Skills/Workflows: proponer la estructura y confirmar antes de crear.

## Seguridad

- **Nunca versionar** datos personales, facturas, documentos sensibles ni credenciales.
- Los datos sensibles van siempre a `Workbench/` (git-ignored).
