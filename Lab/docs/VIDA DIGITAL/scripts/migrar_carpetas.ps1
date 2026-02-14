<#
.SYNOPSIS
Migra carpetas desde la estructura actual a VIDA DIGITAL

.DESCRIPTION
Este script mueve carpetas y archivos desde la estructura actual del usuario a la nueva estructura VIDA DIGITAL.
Incluye modo simulación (-Simular) para revisar antes de mover.

IMPORTANTE: Este script contiene una tabla de mapeo de EJEMPLO. El usuario debe personalizarla según su estructura actual.

.PARAMETER RutaOrigen
Ruta raíz de la estructura actual (ej. D:\OneDrive\Documentos)

.PARAMETER RutaDestino
Ruta raíz de VIDA DIGITAL (ej. D:\OneDrive\VIDA DIGITAL)

.PARAMETER Simular
Si está presente, muestra qué se movería sin mover realmente

.EXAMPLE
.\migrar_carpetas.ps1 -RutaOrigen "D:\OneDrive\Documentos" -RutaDestino "D:\OneDrive\VIDA DIGITAL" -Simular

.EXAMPLE
.\migrar_carpetas.ps1 -RutaOrigen "D:\OneDrive\Documentos" -RutaDestino "D:\OneDrive\VIDA DIGITAL"

.NOTES
Generado por: Antigravity
Fecha: 2026-02-12
Versión: 1.0

ADVERTENCIA: Revisa la tabla de mapeo antes de ejecutar. Este script es un EJEMPLO.
#>

param(
    [Parameter(Mandatory = $true)]
    [string]$RutaOrigen,
    
    [Parameter(Mandatory = $true)]
    [string]$RutaDestino,
    
    [switch]$Simular
)

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
    
    # Crear carpeta destino si no existe
    $destinationParent = Split-Path $fullDestination -Parent
    if (-not (Test-Path $destinationParent)) {
        if ($Simular) {
            Write-Host "[SIMULACIÓN] Crearía carpeta: $destinationParent" -ForegroundColor Yellow
        }
        else {
            New-Item -ItemType Directory -Path $destinationParent -Force | Out-Null
        }
    }
    
    if ($Simular) {
        Write-Host "[SIMULACIÓN] Movería:" -ForegroundColor Yellow
        Write-Host "  Origen:  $fullSource" -ForegroundColor White
        Write-Host "  Destino: $fullDestination" -ForegroundColor White
        Write-Host "  Razón:   $Reason" -ForegroundColor Cyan
        Write-Host ""
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

# --- TABLA DE MAPEO (EJEMPLO - PERSONALIZAR) ---

# SALUD
Move-Item-Safe -Source "Salud\Informes Pepe" -Destination "10 SALUD\10 Personas\Pepe\01 Informes" -Reason "Informes médicos de Pepe"
Move-Item-Safe -Source "Salud\Informes Myriam" -Destination "10 SALUD\10 Personas\Myriam\01 Informes" -Reason "Informes médicos de Myriam"
Move-Item-Safe -Source "Salud\Informes Carla" -Destination "10 SALUD\10 Personas\Carla\01 Informes" -Reason "Informes médicos de Carla"
Move-Item-Safe -Source "Salud\Seguros" -Destination "10 SALUD\00 Admin\Seguros Médicos" -Reason "Seguros médicos familiares"

# DINERO
Move-Item-Safe -Source "Finanzas\Facturas Emitidas" -Destination "20 DINERO\10 Actividad Profesional\10 Facturas\Emitidas" -Reason "Facturas emitidas de actividad profesional"
Move-Item-Safe -Source "Finanzas\Facturas Recibidas" -Destination "20 DINERO\10 Actividad Profesional\10 Facturas\Recibidas" -Reason "Facturas recibidas de proveedores"
Move-Item-Safe -Source "Finanzas\Hacienda" -Destination "20 DINERO\10 Actividad Profesional\20 Hacienda" -Reason "Documentación fiscal"
Move-Item-Safe -Source "Casa\Suministros" -Destination "20 DINERO\00 Admin\Hogar\Suministros" -Reason "Facturas de suministros del hogar"
Move-Item-Safe -Source "Casa\Vehículo" -Destination "20 DINERO\00 Admin\Hogar\Vehículo" -Reason "Documentación del vehículo"
Move-Item-Safe -Source "Casa\Garantías" -Destination "20 DINERO\00 Admin\Hogar\Inventario, garantías y manuales" -Reason "Garantías y manuales de electrodomésticos"

# RELACIONES
Move-Item-Safe -Source "Familia\Carla\Colegio" -Destination "30 RELACIONES\00 Familia Núcleo\Carla" -Reason "Documentación escolar de Carla"
Move-Item-Safe -Source "Familia\Viajes" -Destination "30 RELACIONES\30 Ocio y Viajes\Vacaciones" -Reason "Documentación de viajes familiares"
Move-Item-Safe -Source "Familia\Eventos" -Destination "30 RELACIONES\40 Eventos Familiares" -Reason "Eventos familiares"
Move-Item-Safe -Source "Familia\ADN" -Destination "30 RELACIONES\10 Historia Familiar\ADN" -Reason "Resultados de ADN y genealogía"

# DESARROLLO PERSONAL
Move-Item-Safe -Source "Formación\Cursos Pepe" -Destination "40 DESARROLLO PERSONAL\00 Formación\10 Pepe\Cursos online" -Reason "Cursos online de Pepe"
Move-Item-Safe -Source "Formación\Certificados Pepe" -Destination "40 DESARROLLO PERSONAL\00 Formación\10 Pepe\Certificaciones y diplomas" -Reason "Certificados de Pepe"
Move-Item-Safe -Source "Escritura\Cuentos" -Destination "40 DESARROLLO PERSONAL\10 Creatividad y Escritura\Proyectos literarios\Cuentos" -Reason "Cuentos escritos"
Move-Item-Safe -Source "Escritura\Microrrelatos" -Destination "40 DESARROLLO PERSONAL\10 Creatividad y Escritura\Proyectos literarios\Microrrelatos" -Reason "Microrrelatos"
Move-Item-Safe -Source "Valencianismo\Lo Rat Penat" -Destination "40 DESARROLLO PERSONAL\60 Asociaciones y Cultura\Valencianismo\Rat Penat" -Reason "Documentación de Lo Rat Penat"

# PROYECTOS (activos)
Move-Item-Safe -Source "Proyectos\2025 Novela Premio Hortensia Roig" -Destination "50 PROYECTOS\00 En curso\2025 Novela Premio Hortensia Roig" -Reason "Proyecto activo de escritura"

# SISTEMA
Move-Item-Safe -Source "Documentación\DNI y Pasaporte" -Destination "90 SISTEMA\10 Identidad y Legal\DNI y Pasaporte" -Reason "Documentos de identidad"
Move-Item-Safe -Source "Tecnología\Dominios" -Destination "90 SISTEMA\20 Dominios y Correo" -Reason "Configuración de dominios"
Move-Item-Safe -Source "Tecnología\n8n" -Destination "90 SISTEMA\30 Infra y Automatización\n8n" -Reason "Workflows de n8n"
Move-Item-Safe -Source "Tecnología\Scripts" -Destination "40 DESARROLLO PERSONAL\30 Tecnología y experimentación\Scripts o herramientas propias" -Reason "Scripts personales"

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

Write-Host "IMPORTANTE: Este script es un EJEMPLO. Personaliza la tabla de mapeo según tu estructura actual.`n" -ForegroundColor Yellow
