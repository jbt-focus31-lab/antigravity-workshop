# UTF-8 with BOM
<#
.SYNOPSIS
Migra carpetas desde la estructura actual a VIDA DIGITAL

.DESCRIPTION
Este script mueve carpetas y archivos desde la estructura actual del usuario a la nueva estructura VIDA DIGITAL.
Incluye modo simulación (-Simular) para revisar antes de mover.

IMPORTANTE: Este script contiene mapeos basados en la estructura detectada. Revisar antes de ejecutar.

.PARAMETER RutaOrigen
Ruta raíz de la estructura actual (ej. C:\Users\Pepe\OneDrive\Documentos)

.PARAMETER RutaDestino
Ruta raíz de VIDA DIGITAL (ej. C:\Users\Pepe\OneDrive\Documentos\VIDA DIGITAL)

.PARAMETER Simular
Si está presente, muestra qué se movería sin mover realmente

.EXAMPLE
.\migrar_carpetas.ps1 -RutaOrigen "C:\Users\Pepe\OneDrive\Documentos" -RutaDestino "C:\Users\Pepe\OneDrive\Documentos\VIDA DIGITAL" -Simular

.EXAMPLE
.\migrar_carpetas.ps1 -RutaOrigen "C:\Users\Pepe\OneDrive\Documentos" -RutaDestino "C:\Users\Pepe\OneDrive\Documentos\VIDA DIGITAL"

.NOTES
Generado por: Antigravity
Fecha: 2026-02-14
Versión: 2.0 (UTF-8 with BOM + Emojis)

ADVERTENCIA: Revisa los mapeos antes de ejecutar.
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$RutaOrigen,
    
    [Parameter(Mandatory = $true)]
    [string]$RutaDestino,
    
    [switch]$Simular
)

# Asegurar que la consola use UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Función para mover carpeta/archivo (o simular)
function Move-Item-Safe {
    param(
        [string]$Source,
        [string]$Destination,
        [string]$Reason
    )
    
    $fullSource = Join-Path $RutaOrigen $Source
    $fullDestination = Join-Path $RutaDestino $Destination
    
    if (-not (Test-Path $fullSource)) {
        Write-Host "[OMITIDO] No existe: $fullSource" -ForegroundColor Gray
        return
    }
    
    # Determinar si el destino debe ser una carpeta o un archivo
    $isSourceDirectory = Test-Path $fullSource -PathType Container
    
    # Si el origen es una carpeta, el destino también debe serlo
    if ($isSourceDirectory) {
        $destinationPath = $fullDestination
    }
    else {
        # Si el origen es un archivo, el destino es la carpeta padre
        $destinationPath = Split-Path $fullDestination -Parent
    }
    
    # Crear toda la ruta de carpetas de destino si no existe
    if (-not (Test-Path $destinationPath)) {
        if ($Simular) {
            Write-Host "[SIMULACIÓN] Crearía carpeta: $destinationPath" -ForegroundColor Yellow
        }
        else {
            New-Item -ItemType Directory -Path $destinationPath -Force | Out-Null
        }
    }
    
    if ($Simular) {
        if (Test-Path $fullDestination) {
            Write-Host "[SIMULACIÓN] Ya existe en destino:" -ForegroundColor Gray
            Write-Host "  Origen:  $fullSource" -ForegroundColor White
            Write-Host "  Destino: $fullDestination" -ForegroundColor White
            Write-Host "  Razón:   $Reason" -ForegroundColor Cyan
            Write-Host ""
        }
        else {
            Write-Host "[SIMULACIÓN] Movería:" -ForegroundColor Yellow
            Write-Host "  Origen:  $fullSource" -ForegroundColor White
            Write-Host "  Destino: $fullDestination" -ForegroundColor White
            Write-Host "  Razón:   $Reason" -ForegroundColor Cyan
            Write-Host ""
        }
    }
    else {
        try {
            Move-Item -Path $fullSource -Destination $fullDestination -Force
            Write-Host "[MOVIDO]" -ForegroundColor Green
            Write-Host "  Origen:  $fullSource" -ForegroundColor White
            Write-Host "  Destino: $fullDestination" -ForegroundColor White
            Write-Host "  Razón:   $Reason" -ForegroundColor Cyan
            Write-Host ""
        }
        catch {
            Write-Host "[ERROR] No se pudo mover: $fullSource" -ForegroundColor Red
            Write-Host "  Error: $_" -ForegroundColor Red
            Write-Host ""
        }
    }
}

# Banner
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  MIGRACIÓN A VIDA DIGITAL" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

if ($Simular) {
    Write-Host "MODO SIMULACIÓN: No se moverá ningún archivo`n" -ForegroundColor Yellow
}

Write-Host "Origen:  $RutaOrigen" -ForegroundColor White
Write-Host "Destino: $RutaDestino`n" -ForegroundColor White

# --- TABLA DE MAPEO ---

# === 10 🏥 SALUD ===
Move-Item-Safe -Source "Salut" -Destination "10 🏥 SALUD" -Reason "Carpeta completa de Salud (contiene subcarpetas por persona)"

# === 20 💸 DINERO ===

# Administración Pública - DNIs y Pasaportes
Move-Item-Safe -Source "Administració Pública\DNIs\Pepe" -Destination "30 👨‍👩‍👧 RELACIONES\00 👪 Familia Núcleo\10 🧔🏻‍♂️ Pepe\Documentación personal\DNI" -Reason "DNI de Pepe → Documentación personal"
Move-Item-Safe -Source "Administració Pública\DNIs\Myriam" -Destination "30 👨‍👩‍👧 RELACIONES\00 👪 Familia Núcleo\20 👩🏻 Myriam\Documentación personal\DNI" -Reason "DNI de Myriam → Documentación personal"
Move-Item-Safe -Source "Administració Pública\DNIs\Carla" -Destination "30 👨‍👩‍👧 RELACIONES\00 👪 Familia Núcleo\30 👧🏻 Carla\Documentación personal\DNI" -Reason "DNI de Carla → Documentación personal"
Move-Item-Safe -Source "Administració Pública\Passaports - Pasaportes" -Destination "30 👨‍👩‍👧 RELACIONES\00 👪 Familia Núcleo\Pasaportes" -Reason "Pasaportes familiares → Documentación personal"
Move-Item-Safe -Source "Administració Pública\Certificado nacimiento" -Destination "30 👨‍👩‍👧 RELACIONES\00 👪 Familia Núcleo\Certificados" -Reason "Certificados de nacimiento → Documentación personal"

# Impuestos Municipales (carpetas con años)
Move-Item-Safe -Source "Administració Pública\Imposts Municipals\2019" -Destination "20 💸 DINERO\00 🏠 Hogar\Vivienda\Impuestos\2019" -Reason "Impuestos municipales 2019"
Move-Item-Safe -Source "Administració Pública\Imposts Municipals\2020" -Destination "20 💸 DINERO\00 🏠 Hogar\Vivienda\Impuestos\2020" -Reason "Impuestos municipales 2020"
Move-Item-Safe -Source "Administració Pública\Imposts Municipals\2021" -Destination "20 💸 DINERO\00 🏠 Hogar\Vivienda\Impuestos\2021" -Reason "Impuestos municipales 2021"
Move-Item-Safe -Source "Administració Pública\Imposts Municipals\2022" -Destination "20 💸 DINERO\00 🏠 Hogar\Vivienda\Impuestos\2022" -Reason "Impuestos municipales 2022"
Move-Item-Safe -Source "Administració Pública\Imposts Municipals\2023" -Destination "20 💸 DINERO\00 🏠 Hogar\Vivienda\Impuestos\2023" -Reason "Impuestos municipales 2023"
Move-Item-Safe -Source "Administració Pública\Imposts Municipals\2024" -Destination "20 💸 DINERO\00 🏠 Hogar\Vivienda\Impuestos\2024" -Reason "Impuestos municipales 2024"
Move-Item-Safe -Source "Administració Pública\Imposts Municipals\2025" -Destination "20 💸 DINERO\00 🏠 Hogar\Vivienda\Impuestos\2025" -Reason "Impuestos municipales 2025"

# Pis Manises
Move-Item-Safe -Source "Pis Manises" -Destination "20 💸 DINERO\00 🏠 Hogar\Vivienda\Documentación" -Reason "Documentación de vivienda"

# Facturas y garantías
Move-Item-Safe -Source "Factures (garantia)" -Destination "20 💸 DINERO\00 🏠 Hogar\Inventario, garantías y manuales" -Reason "Facturas y garantías de electrodomésticos"
Move-Item-Safe -Source "Manuals" -Destination "20 💸 DINERO\00 🏠 Hogar\Inventario, garantías y manuales" -Reason "Manuales de electrodomésticos"

# Multas
Move-Item-Safe -Source "Multes" -Destination "20 💸 DINERO\00 🏠 Hogar\Varios" -Reason "Multas y sanciones"

# Finanzas y Negocios
Move-Item-Safe -Source "Finances i Negocis" -Destination "20 💸 DINERO" -Reason "Carpeta completa de finanzas (revisar contenido y redistribuir)"

# Capgemini
Move-Item-Safe -Source "Capgemini" -Destination "20 💸 DINERO\10 💼 Trabajo por cuenta ajena\Capgemini" -Reason "Documentación laboral de Capgemini"

# === 30 👨‍👩‍👧 RELACIONES ===

# Familia
Move-Item-Safe -Source "Família" -Destination "30 👨‍👩‍👧 RELACIONES" -Reason "Carpeta completa de familia (revisar contenido y redistribuir)"

# Amigos
Move-Item-Safe -Source "Amics" -Destination "30 👨‍👩‍👧 RELACIONES\40 🤝 Amigos" -Reason "Documentación de amigos"

# Ocio, cultura, viajes
Move-Item-Safe -Source "Oci, cultura, viages" -Destination "30 👨‍👩‍👧 RELACIONES\30 🌍 Ocio y Viajes" -Reason "Ocio y viajes familiares"

# === 40 🌱 DESARROLLO PERSONAL ===

# Formación
Move-Item-Safe -Source "Formació" -Destination "40 🌱 DESARROLLO PERSONAL\00 📚 Formación" -Reason "Carpeta completa de formación (revisar contenido y redistribuir por persona)"

# Escritura
Move-Item-Safe -Source "Escritura" -Destination "40 🌱 DESARROLLO PERSONAL\10 ✍️ Escritura y creatividad literaria" -Reason "Carpeta completa de escritura"

# Espiritualidad
Move-Item-Safe -Source "Espiritualitat" -Destination "40 🌱 DESARROLLO PERSONAL\70 🕊️ Espiritualidad" -Reason "Carpeta completa de espiritualidad"
Move-Item-Safe -Source "Brúixola" -Destination "40 🌱 DESARROLLO PERSONAL\70 🕊️ Espiritualidad\Brúixola" -Reason "Contenido de Brúixola (espiritualidad)"

# Lectura
Move-Item-Safe -Source "Llectura" -Destination "40 🌱 DESARROLLO PERSONAL\50 📖 Lecturas y biblioteca personal\Notas de colecciones y lecturas en curso" -Reason "Notas de lectura"
Move-Item-Safe -Source "Calibre Portable\Calibre Library" -Destination "40 🌱 DESARROLLO PERSONAL\50 📖 Lecturas y biblioteca personal\Lecturas personales\Calibre Library" -Reason "Biblioteca de Calibre"

# Tecnología
Move-Item-Safe -Source "Tecnologia" -Destination "40 🌱 DESARROLLO PERSONAL\30 🧩 Tecnología y experimentación" -Reason "Carpeta completa de tecnología"
Move-Item-Safe -Source "Productivitat" -Destination "40 🌱 DESARROLLO PERSONAL\30 🧩 Tecnología y experimentación\Productividad" -Reason "Herramientas de productividad"

# Valencianismo
Move-Item-Safe -Source "Valencianisme" -Destination "40 🌱 DESARROLLO PERSONAL\60 🎭 Asociaciones y Cultura\Valencianismo" -Reason "Carpeta completa de valencianismo"

# Hobbys y Proyectos
Move-Item-Safe -Source "Hobbys - Proyectes" -Destination "40 🌱 DESARROLLO PERSONAL" -Reason "Hobbys (revisar contenido y redistribuir según tipo)"

# Política
Move-Item-Safe -Source "Política" -Destination "40 🌱 DESARROLLO PERSONAL\60 🎭 Asociaciones y Cultura\Política" -Reason "Contenido político-cultural"

# === 50 🚀 PROYECTOS ===
# (Los proyectos activos se mueven manualmente según el caso)

# === 90 🖥️ SISTEMA ===

# Digital Brain
Move-Item-Safe -Source "Digital Brain" -Destination "90 🖥️ SISTEMA\20 📝 Plantillas y Convenciones" -Reason "Sistema de organización digital"

# Resumen
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  RESUMEN" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

if ($Simular) {
    Write-Host "MODO SIMULACIÓN: No se movió ningún archivo." -ForegroundColor Yellow
    Write-Host "Revisa las rutas y ejecuta sin -Simular para aplicar los cambios.`n" -ForegroundColor Yellow
}
else {
    Write-Host "Migración completada." -ForegroundColor Green
    Write-Host "Revisa las carpetas destino para confirmar que todo está correcto.`n" -ForegroundColor White
}

Write-Host "IMPORTANTE: Algunas carpetas requieren revisión manual y redistribución:" -ForegroundColor Yellow
Write-Host "  - Finances i Negocis (redistribuir según subcarpetas)" -ForegroundColor Yellow
Write-Host "  - Família (redistribuir según subcarpetas)" -ForegroundColor Yellow
Write-Host "  - Formació (redistribuir por persona)" -ForegroundColor Yellow
Write-Host "  - Hobbys - Proyectes (redistribuir según tipo de hobby)`n" -ForegroundColor Yellow
