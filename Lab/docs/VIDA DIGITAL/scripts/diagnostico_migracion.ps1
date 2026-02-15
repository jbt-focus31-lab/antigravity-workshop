# UTF-8 with BOM
<#
.SYNOPSIS
Diagnóstico del estado de la migración VIDA DIGITAL

.DESCRIPTION
Este script revisa qué carpetas se movieron correctamente y cuáles quedaron en el origen.

.PARAMETER RutaOrigen
Ruta de origen (ej. C:\Users\Pepe\OneDrive\Documentos)

.PARAMETER RutaDestino
Ruta de VIDA DIGITAL (ej. C:\Users\Pepe\OneDrive\Documentos\VIDA DIGITAL)

.EXAMPLE
.\diagnostico_migracion.ps1 -RutaOrigen "C:\Users\Pepe\OneDrive\Documentos" -RutaDestino "C:\Users\Pepe\OneDrive\Documentos\VIDA DIGITAL"
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$RutaOrigen,
    
    [Parameter(Mandatory = $true)]
    [string]$RutaDestino
)

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  DIAGNÓSTICO DE MIGRACIÓN" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Lista de carpetas que se intentaron migrar
$carpetasAMigrar = @(
    "Salut",
    "Administració Pública\DNIs\Pepe",
    "Administració Pública\DNIs\Myriam",
    "Administració Pública\DNIs\Carla",
    "Administració Pública\Passaports - Pasaportes",
    "Administració Pública\Certificado nacimiento",
    "Administració Pública\Imposts Municipals\2019",
    "Administració Pública\Imposts Municipals\2020",
    "Administració Pública\Imposts Municipals\2021",
    "Administració Pública\Imposts Municipals\2022",
    "Administració Pública\Imposts Municipals\2023",
    "Administració Pública\Imposts Municipals\2024",
    "Administració Pública\Imposts Municipals\2025",
    "Pis Manises",
    "Factures (garantia)",
    "Manuals",
    "Multes",
    "Finances i Negocis",
    "Capgemini",
    "Família",
    "Amics",
    "Oci, cultura, viages",
    "Formació",
    "Escritura",
    "Espiritualitat",
    "Brúixola",
    "Llectura",
    "Calibre Portable\Calibre Library",
    "Tecnologia",
    "Productivitat",
    "Valencianisme",
    "Hobbys - Proyectes",
    "Política",
    "Digital Brain"
)

$movidas = @()
$quedaron = @()
$noExistian = @()

foreach ($carpeta in $carpetasAMigrar) {
    $rutaCompleta = Join-Path $RutaOrigen $carpeta
    
    if (Test-Path $rutaCompleta) {
        $quedaron += $carpeta
        Write-Host "[QUEDÓ EN ORIGEN] $carpeta" -ForegroundColor Yellow
    }
    elseif (-not (Test-Path $rutaCompleta)) {
        # Verificar si existe en destino (se movió)
        $posibleDestino = $carpeta -replace "\\", "\"
        $buscarEnDestino = Get-ChildItem -Path $RutaDestino -Recurse -Directory -ErrorAction SilentlyContinue | 
        Where-Object { $_.FullName -like "*$($carpeta.Split('\')[-1])*" }
        
        if ($buscarEnDestino) {
            $movidas += $carpeta
            Write-Host "[SE MOVIÓ] $carpeta" -ForegroundColor Green
        }
        else {
            $noExistian += $carpeta
            Write-Host "[NO EXISTÍA] $carpeta" -ForegroundColor Gray
        }
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  RESUMEN" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

Write-Host "Carpetas que SE MOVIERON correctamente: $($movidas.Count)" -ForegroundColor Green
Write-Host "Carpetas que QUEDARON en origen: $($quedaron.Count)" -ForegroundColor Yellow
Write-Host "Carpetas que NO EXISTÍAN: $($noExistian.Count)" -ForegroundColor Gray

if ($quedaron.Count -gt 0) {
    Write-Host "`n⚠️  Hay $($quedaron.Count) carpetas que quedaron en el origen." -ForegroundColor Yellow
    Write-Host "Puedes volver a ejecutar el script de migración (ya corregido) para completar la migración.`n" -ForegroundColor Yellow
}
