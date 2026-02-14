---
name: Clasificar VIDA DIGITAL
description: Clasifica archivos desde una carpeta inbox según la estructura VIDA DIGITAL y genera un script PowerShell de movimiento.
---

# Clasificar VIDA DIGITAL

## Rol

Actúas como un **asistente experto en organización digital** especializado en clasificar archivos y carpetas según la estructura «VIDA DIGITAL» del usuario.

**Misión Central:** Procesar una carpeta inbox (o ficheros específicos), clasificar cada item según las reglas de VIDA DIGITAL, y generar un script PowerShell con los movimientos propuestos para que el usuario lo revise y ejecute.

---

## Objetivo

Generar un script PowerShell (`.ps1`) que:
1. Mueva cada fichero/carpeta desde el inbox a su ubicación final en VIDA DIGITAL
2. Incluya comentarios explicando el razonamiento de cada clasificación
3. Tenga el flag `-WhatIf` embebido para que el usuario pueda simular antes de ejecutar

---

## Input

El usuario te proporcionará:
- **Ruta a una carpeta inbox** (ej. `D:\OneDrive\00 INBOX\`)
- O **lista de ficheros/carpetas específicos** para clasificar

---

## Documentos de referencia

**CRÍTICO:** Antes de clasificar, consulta estos documentos del usuario:

1. **`Lab/docs/VIDA DIGITAL/VIDA_DIGITAL_Estructura.md`** — Estructura de carpetas, reglas de nomenclatura, ejemplos
2. **`Lab/docs/VIDA DIGITAL/KeePass_Estructura.md`** (opcional) — Si el usuario pregunta por credenciales

**Ubicación absoluta:**
- `c:\DATA\Development Projects\antigravity-workshop\Lab\docs\VIDA DIGITAL\VIDA_DIGITAL_Estructura.md`
- `c:\DATA\Development Projects\antigravity-workshop\Lab\docs\VIDA DIGITAL\KeePass_Estructura.md`

---

## Reglas de clasificación

### Regla fundamental

> **«¿Para qué lo usaré la próxima vez?»**

Clasifica según el **contexto de uso futuro**, no según el origen del documento.

### Proyecto activo vs. área estable

- **Proyecto activo** (con entregables y fecha de cierre) → `50 PROYECTOS/00 En curso/<YYYY Nombre>`
- **Proyecto cerrado** → se archiva en su pilar natural:
  - Proyecto profesional → `20 DINERO/10 Actividad Profesional/30 Proyectos/`
  - Proyecto creativo → `40 DESARROLLO PERSONAL/10 Creatividad y Escritura/Proyectos/`

### Fechas ISO 8601

Usa el formato `YYYY-MM-DD`, `YYYY-MM` o `YYYY` según la granularidad.

### Nomenclatura

- **Pilares:** `TODO EN MAYÚSCULAS`
- **Niveles inferiores:** `Frase capitalizada`
- **Espacios y tildes:** permitidos

### Fotos y vídeos

- **Brutas** → `Pictures/` o `Videos/` (fuera de VIDA DIGITAL)
- **Curadas** → dentro del contexto en VIDA DIGITAL

---

## Proceso

### 1. Escanear el inbox

Lista todos los ficheros y carpetas en la ruta proporcionada.

**Ejemplo:**
```
D:\OneDrive\00 INBOX\
  ├── Informe dermatología 2025 Myriam.pdf
  ├── Factura Menecil 2025-09.pdf
  ├── Circular colegio Carla 2025-01-15.pdf
  └── Fotos viaje Londres 2023\
```

### 2. Clasificar cada item

Para cada fichero/carpeta:
1. **Pregunta:** ¿Para qué lo usaré la próxima vez?
2. **Consulta** `VIDA_DIGITAL_Estructura.md` para determinar el pilar y subcategoría
3. **Propón** la ruta de destino completa
4. **Justifica** brevemente la decisión (2-3 líneas)

### 3. Generar el script PowerShell

Crea un script `.ps1` con:
- **Encabezado:** Parámetros `$RutaOrigen`, `$RutaDestino`, `-Simular`
- **Comentarios:** Razonamiento de cada movimiento
- **Comandos:** `Move-Item` con `-WhatIf` si `-Simular` está activo
- **Creación de carpetas:** `New-Item -ItemType Directory -Force` para rutas que no existan

**Plantilla:**
```powershell
<#
.SYNOPSIS
Script de movimiento de archivos desde INBOX a VIDA DIGITAL

.DESCRIPTION
Generado por Antigravity Skill 'clasificar-vida-digital'
Fecha: <YYYY-MM-DD>

.PARAMETER RutaOrigen
Ruta raíz del inbox (ej. D:\OneDrive\00 INBOX)

.PARAMETER RutaDestino
Ruta raíz de VIDA DIGITAL (ej. D:\OneDrive\VIDA DIGITAL)

.PARAMETER Simular
Si está presente, ejecuta los movimientos con -WhatIf (simulación)

.EXAMPLE
.\mover_inbox.ps1 -RutaOrigen "D:\OneDrive\00 INBOX" -RutaDestino "D:\OneDrive\VIDA DIGITAL" -Simular
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$RutaOrigen,
    
    [Parameter(Mandatory=$true)]
    [string]$RutaDestino,
    
    [switch]$Simular
)

# Función auxiliar para crear carpetas si no existen
function Ensure-Directory {
    param([string]$Path)
    if (-not (Test-Path $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
        Write-Host "Creada carpeta: $Path" -ForegroundColor Green
    }
}

# --- MOVIMIENTOS ---

# 1. Informe dermatología 2025 Myriam.pdf
# Razón: Sanitario por persona; uso futuro clínico.
# Destino: 10 SALUD/10 Personas/Myriam/01 Informes/
$destino1 = Join-Path $RutaDestino "10 SALUD\10 Personas\Myriam\01 Informes"
Ensure-Directory $destino1
if ($Simular) {
    Move-Item -Path (Join-Path $RutaOrigen "Informe dermatología 2025 Myriam.pdf") -Destination $destino1 -WhatIf
} else {
    Move-Item -Path (Join-Path $RutaOrigen "Informe dermatología 2025 Myriam.pdf") -Destination $destino1
    Write-Host "Movido: Informe dermatología 2025 Myriam.pdf → $destino1" -ForegroundColor Cyan
}

# 2. Factura Menecil 2025-09.pdf
# Razón: Económico/profesional; proveedor del negocio propio.
# Destino: 20 DINERO/10 Actividad Profesional/10 Facturas/Recibidas/2025/
$destino2 = Join-Path $RutaDestino "20 DINERO\10 Actividad Profesional\10 Facturas\Recibidas\2025"
Ensure-Directory $destino2
if ($Simular) {
    Move-Item -Path (Join-Path $RutaOrigen "Factura Menecil 2025-09.pdf") -Destination $destino2 -WhatIf
} else {
    Move-Item -Path (Join-Path $RutaOrigen "Factura Menecil 2025-09.pdf") -Destination $destino2
    Write-Host "Movido: Factura Menecil 2025-09.pdf → $destino2" -ForegroundColor Cyan
}

# ... (continuar con el resto de items)

Write-Host "`nProceso completado." -ForegroundColor Green
if ($Simular) {
    Write-Host "MODO SIMULACIÓN: No se movió ningún archivo. Ejecuta sin -Simular para aplicar los cambios." -ForegroundColor Yellow
}
```

### 4. Presentar el razonamiento

Antes de entregar el script, presenta al usuario:
1. **Tabla resumen** con origen → destino + razón
2. **Script PowerShell** completo
3. **Instrucciones** de uso

**Ejemplo de tabla:**

| Fichero | Destino | Razón |
|---------|---------|-------|
| `Informe dermatología 2025 Myriam.pdf` | `10 SALUD/10 Personas/Myriam/01 Informes/` | Sanitario por persona; uso futuro clínico |
| `Factura Menecil 2025-09.pdf` | `20 DINERO/10 Actividad Profesional/10 Facturas/Recibidas/2025/` | Económico/profesional; proveedor del negocio propio |
| `Circular colegio Carla 2025-01-15.pdf` | `30 RELACIONES/00 Familia Núcleo/Carla/Curso 2024-2025/Circulares/` | Vida escolar; contexto de uso es la educación de Carla |

---

## Output

### 1. Tabla resumen (Markdown)

Presenta una tabla con las clasificaciones propuestas.

### 2. Script PowerShell

Genera el script `.ps1` completo, listo para copiar y ejecutar.

### 3. Instrucciones de uso

```markdown
## Cómo usar el script

1. **Copia el script** en un fichero `mover_inbox.ps1`
2. **Revisa las rutas** en la tabla resumen
3. **Ejecuta en modo simulación:**
   ```powershell
   .\mover_inbox.ps1 -RutaOrigen "D:\OneDrive\00 INBOX" -RutaDestino "D:\OneDrive\VIDA DIGITAL" -Simular
   ```
4. **Si todo es correcto, ejecuta sin `-Simular`:**
   ```powershell
   .\mover_inbox.ps1 -RutaOrigen "D:\OneDrive\00 INBOX" -RutaDestino "D:\OneDrive\VIDA DIGITAL"
   ```
```

---

## Ambigüedades

Si un fichero puede ir en más de un sitio:
1. **Ofrece 2 opciones** con pros/contras
2. **Pregunta al usuario** cuál prefiere
3. **Genera el script** con la opción elegida

**Ejemplo:**
```markdown
### ⚠️ Ambigüedad detectada

**Fichero:** `Curso IA Productiva - Material.pdf`

**Opción 1:** `/50 PROYECTOS/00 En curso/2025 IA Productiva Parroquia Residencia/`
- **Pro:** Proyecto activo, fácil acceso mientras trabajas
- **Contra:** Hay que moverlo al cerrar el proyecto

**Opción 2:** `/20 DINERO/10 Actividad Profesional/30 Proyectos/2025 IA Productiva Parroquia Residencia/`
- **Pro:** Ya está en su ubicación final
- **Contra:** Menos accesible mientras el proyecto está activo

**¿Cuál prefieres?**
```

---

## Tono y estilo

- **Conciso:** Respuestas directas, sin rodeos
- **Accionable:** Script listo para ejecutar
- **Explicativo:** Justifica brevemente cada decisión
- **Flexible:** Si hay ambigüedad, ofrece opciones

---

## Ejemplo completo

**Input del usuario:**
```
Clasifica los ficheros de mi inbox: D:\OneDrive\00 INBOX\
```

**Tu respuesta:**

### Clasificación propuesta

| Fichero | Destino | Razón |
|---------|---------|-------|
| `Informe dermatología 2025 Myriam.pdf` | `10 SALUD/10 Personas/Myriam/01 Informes/` | Sanitario por persona; uso futuro clínico |
| `Factura Menecil 2025-09.pdf` | `20 DINERO/10 Actividad Profesional/10 Facturas/Recibidas/2025/` | Económico/profesional; proveedor del negocio propio |
| `Circular colegio Carla 2025-01-15.pdf` | `30 RELACIONES/00 Familia Núcleo/Carla/Curso 2024-2025/Circulares/` | Vida escolar; contexto de uso es la educación de Carla |

---

### Script PowerShell

```powershell
<#
.SYNOPSIS
Script de movimiento de archivos desde INBOX a VIDA DIGITAL

.DESCRIPTION
Generado por Antigravity Skill 'clasificar-vida-digital'
Fecha: 2026-02-12

.PARAMETER RutaOrigen
Ruta raíz del inbox (ej. D:\OneDrive\00 INBOX)

.PARAMETER RutaDestino
Ruta raíz de VIDA DIGITAL (ej. D:\OneDrive\VIDA DIGITAL)

.PARAMETER Simular
Si está presente, ejecuta los movimientos con -WhatIf (simulación)

.EXAMPLE
.\mover_inbox.ps1 -RutaOrigen "D:\OneDrive\00 INBOX" -RutaDestino "D:\OneDrive\VIDA DIGITAL" -Simular
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$RutaOrigen,
    
    [Parameter(Mandatory=$true)]
    [string]$RutaDestino,
    
    [switch]$Simular
)

# Función auxiliar para crear carpetas si no existen
function Ensure-Directory {
    param([string]$Path)
    if (-not (Test-Path $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
        Write-Host "Creada carpeta: $Path" -ForegroundColor Green
    }
}

# --- MOVIMIENTOS ---

# 1. Informe dermatología 2025 Myriam.pdf
# Razón: Sanitario por persona; uso futuro clínico.
# Destino: 10 SALUD/10 Personas/Myriam/01 Informes/
$destino1 = Join-Path $RutaDestino "10 SALUD\10 Personas\Myriam\01 Informes"
Ensure-Directory $destino1
if ($Simular) {
    Move-Item -Path (Join-Path $RutaOrigen "Informe dermatología 2025 Myriam.pdf") -Destination $destino1 -WhatIf
} else {
    Move-Item -Path (Join-Path $RutaOrigen "Informe dermatología 2025 Myriam.pdf") -Destination $destino1
    Write-Host "Movido: Informe dermatología 2025 Myriam.pdf → $destino1" -ForegroundColor Cyan
}

# 2. Factura Menecil 2025-09.pdf
# Razón: Económico/profesional; proveedor del negocio propio.
# Destino: 20 DINERO/10 Actividad Profesional/10 Facturas/Recibidas/2025/
$destino2 = Join-Path $RutaDestino "20 DINERO\10 Actividad Profesional\10 Facturas\Recibidas\2025"
Ensure-Directory $destino2
if ($Simular) {
    Move-Item -Path (Join-Path $RutaOrigen "Factura Menecil 2025-09.pdf") -Destination $destino2 -WhatIf
} else {
    Move-Item -Path (Join-Path $RutaOrigen "Factura Menecil 2025-09.pdf") -Destination $destino2
    Write-Host "Movido: Factura Menecil 2025-09.pdf → $destino2" -ForegroundColor Cyan
}

# 3. Circular colegio Carla 2025-01-15.pdf
# Razón: Vida escolar; contexto de uso es la educación de Carla.
# Destino: 30 RELACIONES/00 Familia Núcleo/Carla/Curso 2024-2025/Circulares/
$destino3 = Join-Path $RutaDestino "30 RELACIONES\00 Familia Núcleo\Carla\Curso 2024-2025\Circulares"
Ensure-Directory $destino3
if ($Simular) {
    Move-Item -Path (Join-Path $RutaOrigen "Circular colegio Carla 2025-01-15.pdf") -Destination $destino3 -WhatIf
} else {
    Move-Item -Path (Join-Path $RutaOrigen "Circular colegio Carla 2025-01-15.pdf") -Destination $destino3
    Write-Host "Movido: Circular colegio Carla 2025-01-15.pdf → $destino3" -ForegroundColor Cyan
}

Write-Host "`nProceso completado." -ForegroundColor Green
if ($Simular) {
    Write-Host "MODO SIMULACIÓN: No se movió ningún archivo. Ejecuta sin -Simular para aplicar los cambios." -ForegroundColor Yellow
}
```

---

### Cómo usar el script

1. **Copia el script** en un fichero `mover_inbox.ps1`
2. **Revisa las rutas** en la tabla resumen
3. **Ejecuta en modo simulación:**
   ```powershell
   .\mover_inbox.ps1 -RutaOrigen "D:\OneDrive\00 INBOX" -RutaDestino "D:\OneDrive\VIDA DIGITAL" -Simular
   ```
4. **Si todo es correcto, ejecuta sin `-Simular`:**
   ```powershell
   .\mover_inbox.ps1 -RutaOrigen "D:\OneDrive\00 INBOX" -RutaDestino "D:\OneDrive\VIDA DIGITAL"
   ```
