# 🚀 Antigravity Workshop

> **Un laboratorio de experimentación para desarrollar capacidades de IA aplicadas a Ingeniería de Software y Gestión del Conocimiento**

[![Antigravity](https://img.shields.io/badge/Powered%20by-Antigravity-blue)](https://antigravity.google)
[![License](https://img.shields.io/badge/License-Private-red)]()

---

## 📋 Tabla de Contenidos

- [Descripción](#-descripción)
- [Arquitectura](#-arquitectura)
- [Estructura del Proyecto](#-estructura-del-proyecto)
- [Conceptos Clave](#-conceptos-clave)
- [Primeros Pasos](#-primeros-pasos)
- [Casos de Uso](#-casos-de-uso)
- [Documentación](#-documentación)
- [Contribuir](#-contribuir)

---

## 🎯 Descripción

**Antigravity Workshop** es un entorno de laboratorio diseñado para desarrollar, probar y perfeccionar capacidades de IA (Skills, Rules, Workflows) utilizando [Google Antigravity](https://antigravity.google). 

Este proyecto sirve como:
- 🧪 **Laboratorio de experimentación** para nuevas capacidades de IA
- 📚 **Repositorio de conocimiento** sobre mejores prácticas con Antigravity
- 🛠️ **Caja de herramientas** reutilizable para proyectos futuros
- 🎓 **Recurso educativo** para entender la arquitectura agéntica

### Dominios de Aplicación

1. **Ingeniería de Software (DevOps & Automation)**
   - Automatización de infraestructura
   - Generación de stacks tecnológicos
   - Análisis de logs y debugging
   - Gestión de contenedores y orquestación

2. **Gestión de Información (Second Brain & Content)**
   - Procesamiento de lenguaje natural
   - Estructuración de documentos
   - Síntesis de conocimiento
   - Organización documental automatizada

---

## 🏗️ Arquitectura

El proyecto sigue una arquitectura modular basada en tres pilares fundamentales de Antigravity:

```
┌─────────────────────────────────────────────────────────┐
│                    ANTIGRAVITY AGENT                     │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐         │
│  │  RULES   │    │ WORKFLOWS│    │  SKILLS  │         │
│  │          │    │          │    │          │         │
│  │ El CÓMO  │◄───┤ El QUÉ   │───►│ El PUEDO │         │
│  │   SOY    │    │  SIGO    │    │  HACER   │         │
│  └──────────┘    └──────────┘    └──────────┘         │
│       ▲               │                 ▲               │
│       │               │                 │               │
│       └───────────────┴─────────────────┘               │
│              Sinergias Operativas                       │
└─────────────────────────────────────────────────────────┘
```

### Componentes

| Componente | Propósito | Activación | Ubicación |
|------------|-----------|------------|-----------|
| **[Skills](https://antigravity.google/docs/skills)** | Capacidades técnicas específicas | Automática (agente decide) | `.agent/skills/` |
| **[Rules](https://antigravity.google/docs/rules)** | Restricciones y guardarraíles | Pasiva (siempre activa) | `.agent/rules/` |
| **[Workflows](https://antigravity.google/docs/workflows)** | Orquestación de procesos | Explícita (usuario invoca) | `.agent/workflows/` |

Para más detalles, consulta el [Documento de Arquitectura](Lab/docs/Antigravity_Architecture_Design.md).

---

## 📁 Estructura del Proyecto

```plaintext
antigravity-workshop/
├── .agent/                 # 🧠 El "Cerebro" del Taller
│   ├── skills/             #    Definición de capacidades (ej. generate-stack)
│   ├── rules/              #    Reglas del laboratorio
│   └── workflows/          #    Procedimientos estandarizados
│
├── Lab/                    # 🔬 El "Laboratorio"
│   ├── docs/               #    Documentación y diseño
│   ├── templates/          #    Plantillas para Docker, Markdown, etc.
│   ├── scripts/            #    Scripts auxiliares
│   └── prompts/            #    Prompts de ingeniería y pruebas
│
├── Workbench/              # 🔧 El "Banco de Trabajo" (git-ignored)
│   ├── output/             #    Resultados generados por Skills
│   ├── temp/               #    Archivos temporales
│   └── .gitkeep            #    Mantiene la carpeta en git
│
├── AGENTS.md               # 📄 Contexto general del laboratorio
├── README.md               # 📖 Este archivo
└── .gitignore              # 🚫 Configuración de exclusiones
```

### Estrategia de Versionado

- **✅ Versionado (Git):** Todo el contenido de `.agent/` y `Lab/`
- **❌ Local-Only:** El contenido de `Workbench/` es efímero y no se versiona
  - Permite procesar datos sensibles sin riesgo de subida accidental
  - Ideal para pruebas con datos personales (facturas, notas, etc.)

---

## 💡 Conceptos Clave

### Skills (Habilidades)

Las **Skills** son extensiones modulares que otorgan capacidades técnicas específicas al agente.

**Características:**
- 🎯 Activación automática basada en contexto
- 📦 Estructura modular (`SKILL.md` + `scripts/` + `resources/`)
- 🔌 Actúan como "cajas negras" con interfaces bien definidas

**Ejemplo de estructura:**
```
.agent/skills/generate-stack/
├── SKILL.md           # Metadatos y documentación
├── scripts/
│   └── generator.py   # Lógica de generación
└── resources/
    └── templates/     # Plantillas de configuración
```

### Rules (Reglas)

Las **Rules** son directrices de comportamiento que aseguran consistencia y seguridad.

**Tipos:**
- 🌍 **Globales:** Preferencias universales del usuario
- 📁 **Workspace:** Estándares específicos del proyecto

**Ejemplos:**
- "Siempre usar TypeScript en modo estricto"
- "Nunca hacer commit de secretos"
- "Usar formato de fecha ISO 8601"

### Workflows (Flujos de Trabajo)

Los **Workflows** son recetas paso a paso para procesos complejos.

**Características:**
- 🎬 Invocación explícita por el usuario (ej. `/deploy`, `/test`)
- 📝 Formato: YAML frontmatter + Markdown
- ⚡ Soporte para auto-ejecución con anotaciones `// turbo`

**Ejemplo de invocación:**
```bash
/deploy-to-production
```

---

## 🚀 Primeros Pasos

### Prerrequisitos

- [Google Antigravity](https://antigravity.google) instalado y configurado
- Git para control de versiones
- (Opcional) Python 3.8+ para Skills con scripts Python
- (Opcional) Node.js 16+ para Skills con scripts JavaScript

### Instalación

1. **Clonar el repositorio:**
   ```bash
   git clone <repository-url> antigravity-workshop
   cd antigravity-workshop
   ```

2. **Verificar la estructura:**
   ```bash
   # Asegurarse de que las carpetas principales existen
   ls -la .agent Lab Workbench
   ```

3. **Abrir en Antigravity:**
   - Abre Antigravity
   - Carga el workspace `antigravity-workshop`
   - El agente detectará automáticamente Skills, Rules y Workflows

### Primer Uso

1. **Explorar los Skills disponibles:**
   - El agente mostrará automáticamente los Skills al inicio
   - Revisa `.agent/skills/` para ver las capacidades disponibles

2. **Probar un Workflow:**
   ```
   /help
   ```
   Esto mostrará los workflows disponibles.

3. **Experimentar en el Workbench:**
   - Coloca archivos de prueba en `Workbench/temp/`
   - Invoca Skills para procesarlos
   - Los resultados aparecerán en `Workbench/output/`

---

## 🎯 Casos de Uso

### 1. El Constructor de Stacks (DevOps)

**Objetivo:** Generar scaffolding completo para servicios (n8n, PostgreSQL, Qdrant)

**Skill:** `generate-stack`

**Uso:**
```
Necesito crear un stack de Docker Compose con PostgreSQL, Redis y n8n
```

El agente activará automáticamente el skill `generate-stack` y generará:
- `docker-compose.yml`
- `.env` y `.env.example`
- Scripts de inicialización
- Documentación README

---

### 2. El Sintetizador de Conocimiento (Second Brain)

**Objetivo:** Transformar documentos crudos en notas estructuradas

**Skill:** `synthesize-note`

**Uso:**
```
Procesa el PDF en Workbench/temp/research-paper.pdf y crea una nota estructurada
```

El agente:
1. Lee el PDF
2. Extrae conceptos clave
3. Genera Markdown con frontmatter
4. Guarda en `Workbench/output/`

---

## 📚 Documentación

### Documentación del Proyecto

- [Arquitectura y Diseño](Lab/docs/Antigravity_Architecture_Design.md) - Estrategia completa del proyecto
- [AGENTS.md](AGENTS.md) - Contexto general para agentes de IA

### Documentación Oficial de Antigravity

- [Get Started](https://antigravity.google/docs/get-started) - Introducción a Antigravity
- [Skills](https://antigravity.google/docs/skills) - Guía completa de Skills
- [Workflows](https://antigravity.google/docs/workflows) - Guía completa de Workflows
- [Rules](https://antigravity.google/docs/rules) - Guía completa de Rules

### Recursos Adicionales

- [AGENTS.md Standard](https://github.com/aibtcdev/agent-tools-ts) - Estándar emergente para documentación orientada a IA

---

## 🤝 Contribuir

Este es un proyecto personal de experimentación, pero las ideas y sugerencias son bienvenidas.

### Flujo de Trabajo Sugerido

1. **Experimenta** en tu copia local
2. **Documenta** tus hallazgos en `Lab/docs/`
3. **Crea Skills** reutilizables en `.agent/skills/`
4. **Define Workflows** para procesos repetibles
5. **Establece Rules** para mantener consistencia

### Convenciones

- **Commits:** Mensajes descriptivos en español
- **Branches:** `feature/nombre-descriptivo` para nuevas capacidades
- **Documentación:** Mantener actualizado el `Antigravity_Architecture_Design.md`

---

## 📝 Licencia

Este proyecto es privado y de uso personal.

---

## 🙏 Agradecimientos

- **Google Antigravity Team** - Por crear una herramienta revolucionaria
- **Comunidad de IA Agéntica** - Por impulsar el estándar AGENTS.md

---

<div align="center">

**Construido con ❤️ usando [Google Antigravity](https://antigravity.google)**

</div>
