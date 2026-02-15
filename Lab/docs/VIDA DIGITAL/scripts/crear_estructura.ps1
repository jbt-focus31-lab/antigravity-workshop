# UTF-8 with BOM
<#
.SYNOPSIS
Crea la estructura de carpetas VIDA DIGITAL

.DESCRIPTION
Este script crea el árbol completo de carpetas según la estructura VIDA DIGITAL definida en VIDA_DIGITAL_Estructura.md.
Soporta modo simulación (-Simular) para revisar antes de crear.

.PARAMETER RutaRaiz
Ruta raíz donde se creará la estructura VIDA DIGITAL (ej. D:\OneDrive\VIDA DIGITAL)

.PARAMETER Simular
Si está presente, muestra qué carpetas se crearían sin crearlas realmente

.EXAMPLE
.\crear_estructura.ps1 -RutaRaiz "D:\OneDrive\VIDA DIGITAL" -Simular

.EXAMPLE
.\crear_estructura.ps1 -RutaRaiz "D:\OneDrive\VIDA DIGITAL"

.NOTES
Generado por: Antigravity
Fecha: 2026-02-14
Versión: 2.0 (UTF-8 with BOM + Emojis)
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$RutaRaiz,
    
    [switch]$Simular
)

# Asegurar que la consola use UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Función para crear carpeta (o simular)
function New-Folder-Safe {
    param([string]$Path)
    
    if ($Simular) {
        if (Test-Path $Path) {
            Write-Host "[SIMULACIÓN] Ya existe: $Path" -ForegroundColor Gray
        }
        else {
            Write-Host "[SIMULACIÓN] Crearía: $Path" -ForegroundColor Yellow
        }
    }
    else {
        if (-not (Test-Path $Path)) {
            New-Item -ItemType Directory -Path $Path -Force | Out-Null
            Write-Host "Creada: $Path" -ForegroundColor Green
        }
        else {
            Write-Host "Ya existe: $Path" -ForegroundColor Gray
        }
    }
}

# Banner
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  CREACIÓN ESTRUCTURA VIDA DIGITAL" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

if ($Simular) {
    Write-Host "MODO SIMULACIÓN: No se creará ninguna carpeta`n" -ForegroundColor Yellow
}

Write-Host "Ruta raíz: $RutaRaiz`n" -ForegroundColor White

# Crear raíz si no existe
New-Folder-Safe $RutaRaiz

# --- 00 📥 INBOX ---
New-Folder-Safe (Join-Path $RutaRaiz "00 📥 INBOX")

# --- 10 🏥 SALUD ---
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\00 🗂️ Admin")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\00 🗂️ Admin\Seguridad Social")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\00 🗂️ Admin\Seguros médicos privados")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\00 🗂️ Admin\Procedimientos y contactos")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\00 🗂️ Admin\Plantillas y modelos")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\00 🗂️ Admin\Autorizaciones globales")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\10 🏥 Pepe")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\10 🏥 Pepe\Médicos")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\10 🏥 Pepe\Médicos\Informes Médicos")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\10 🏥 Pepe\Médicos\Analíticas y pruebas")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\10 🏥 Pepe\Médicos\Tratamientos y Medicación")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\10 🏥 Pepe\Médicos\Citas")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\10 🏥 Pepe\Médicos\Consentimientos informados")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\10 🏥 Pepe\Médicos\Procesos Administrativos y Legales")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\10 🏥 Pepe\Médicos\Seguros y Volantes")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\10 🏥 Pepe\Ejercicio")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\10 🏥 Pepe\Ejercicio\Planes y Rutinas")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\10 🏥 Pepe\Ejercicio\Diario")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\10 🏥 Pepe\Ejercicio\Métricas y Seguimiento")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\10 🏥 Pepe\Ejercicio\Material y Técnica")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\10 🏥 Pepe\Alimentación")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\10 🏥 Pepe\Bienestar y Prevención")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\10 🏥 Pepe\Bienestar y Prevención\Vacunas")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\10 🏥 Pepe\Bienestar y Prevención\Chequeos y revisiones")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\10 🏥 Pepe\Bienestar y Prevención\Programas preventivos")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\20 🏥 Myriam")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\20 🏥 Myriam\Médicos")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\20 🏥 Myriam\Médicos\Informes Médicos")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\20 🏥 Myriam\Médicos\Analíticas y pruebas")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\20 🏥 Myriam\Médicos\Tratamientos y Medicación")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\20 🏥 Myriam\Médicos\Citas")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\20 🏥 Myriam\Médicos\Consentimientos informados")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\20 🏥 Myriam\Médicos\Procesos Administrativos y Legales")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\20 🏥 Myriam\Médicos\Seguros y Volantes")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\20 🏥 Myriam\Ejercicio")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\20 🏥 Myriam\Ejercicio\Planes y Rutinas")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\20 🏥 Myriam\Ejercicio\Diario")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\20 🏥 Myriam\Ejercicio\Métricas y Seguimiento")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\20 🏥 Myriam\Ejercicio\Material y Técnica")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\20 🏥 Myriam\Alimentación")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\20 🏥 Myriam\Bienestar y Prevención")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\20 🏥 Myriam\Bienestar y Prevención\Vacunas")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\20 🏥 Myriam\Bienestar y Prevención\Chequeos y revisiones")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\20 🏥 Myriam\Bienestar y Prevención\Programas preventivos")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\30 🏥 Carla")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\30 🏥 Carla\Médicos")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\30 🏥 Carla\Médicos\Informes Médicos")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\30 🏥 Carla\Médicos\Analíticas y pruebas")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\30 🏥 Carla\Médicos\Tratamientos y Medicación")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\30 🏥 Carla\Médicos\Citas")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\30 🏥 Carla\Médicos\Consentimientos informados")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\30 🏥 Carla\Médicos\Procesos Administrativos y Legales")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\30 🏥 Carla\Médicos\Seguros y Volantes")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\30 🏥 Carla\Ejercicio")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\30 🏥 Carla\Ejercicio\Planes y Rutinas")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\30 🏥 Carla\Ejercicio\Diario")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\30 🏥 Carla\Ejercicio\Métricas y Seguimiento")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\30 🏥 Carla\Ejercicio\Material y Técnica")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\30 🏥 Carla\Alimentación")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\30 🏥 Carla\Bienestar y Prevención")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\30 🏥 Carla\Bienestar y Prevención\Vacunas")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\30 🏥 Carla\Bienestar y Prevención\Chequeos y revisiones")
New-Folder-Safe (Join-Path $RutaRaiz "10 🏥 SALUD\30 🏥 Carla\Bienestar y Prevención\Programas preventivos")

# --- 20 💸 DINERO ---
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Vivienda")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Vivienda\Documentación")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Vivienda\Impuestos")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Vivienda\Mantenimiento")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Suministros")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Suministros\Agua")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Suministros\Luz")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Suministros\Gas")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Suministros\Internet")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Suministros\Otros Servicios")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Vehículo")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Vehículo\2012 Toyota Verso")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Vehículo\2012 Toyota Verso\Documentación")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Vehículo\2012 Toyota Verso\Impuestos")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Vehículo\2012 Toyota Verso\Mantenimiento")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Vehículo\Varios")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Seguros")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Seguros\Hogar")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Seguros\Hogar\Pólizas")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Seguros\Hogar\Siniestros")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Seguros\Vehículo")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Seguros\Vehículo\2012 Toyota Verso")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Seguros\Vehículo\2012 Toyota Verso\Pólizas")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Seguros\Vehículo\2012 Toyota Verso\Siniestros")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Seguros\Vida")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Seguros\Vida\Pólizas")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Seguros\Vida\Siniestros")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Inventario, garantías y manuales")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Inventario, garantías y manuales\Electrodomésticos")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Inventario, garantías y manuales\Electrónica de consumo")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Inventario, garantías y manuales\Informática y móviles")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\00 🏠 Hogar\Inventario, garantías y manuales\Otros")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\10 💼 Trabajo por cuenta ajena")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\10 💼 Trabajo por cuenta ajena\Capgemini")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\10 💼 Trabajo por cuenta ajena\Capgemini\Nóminas")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\10 💼 Trabajo por cuenta ajena\Capgemini\Contratos y anexos")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\10 💼 Trabajo por cuenta ajena\Capgemini\Evaluaciones y feedback")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\10 💼 Trabajo por cuenta ajena\Capgemini\Beneficios sociales")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\10 💼 Trabajo por cuenta ajena\Capgemini\Formación corporativa")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\20 📊 Actividad profesional")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\20 📊 Actividad profesional\Procedimientos")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\20 📊 Actividad profesional\Bitácoras")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\20 📊 Actividad profesional\Facturas")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\20 📊 Actividad profesional\Facturas\Emitidas")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\20 📊 Actividad profesional\Facturas\Recibidas")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\20 📊 Actividad profesional\Hacienda")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\20 📊 Actividad profesional\Hacienda\Modelo 036")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\20 📊 Actividad profesional\Hacienda\Modelos 303-390 IVA")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\20 📊 Actividad profesional\Hacienda\Resultados Actividad Económica")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\20 📊 Actividad profesional\Proyectos")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\20 📊 Actividad profesional\Gastos")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\20 📊 Actividad profesional\Gastos\Proveedores")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\30 🏦 Bancos y brókeres")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\30 🏦 Bancos y brókeres\Bancos y tarjetas")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\30 🏦 Bancos y brókeres\Bancos y tarjetas\Banco Santander")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\30 🏦 Bancos y brókeres\Bancos y tarjetas\Banco Sabadell")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\30 🏦 Bancos y brókeres\Bancos y tarjetas\ING Direct")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\30 🏦 Bancos y brókeres\Bancos y tarjetas\Revolut")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\30 🏦 Bancos y brókeres\Brókeres")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\30 🏦 Bancos y brókeres\Brókeres\Renta 4")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\30 🏦 Bancos y brókeres\Brókeres\MyInvestor")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\30 🏦 Bancos y brókeres\Brókeres\Trade Republic")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\30 🏦 Bancos y brókeres\Brókeres\Interactive Brokers")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\30 🏦 Bancos y brókeres\Criptomonedas")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\30 🏦 Bancos y brókeres\Criptomonedas\Kraken")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\30 🏦 Bancos y brókeres\Criptomonedas\Binance")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\30 🏦 Bancos y brókeres\Inmobiliario")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\30 🏦 Bancos y brókeres\Inmobiliario\Hausera")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\30 🏦 Bancos y brókeres\Inmobiliario\Urbanitae")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\30 🏦 Bancos y brókeres\IBANs")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\30 🏦 Bancos y brókeres\Tarjetas")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\40 📈 Inversiones y cartera")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\40 📈 Inversiones y cartera\Carteras y seguimiento")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\40 📈 Inversiones y cartera\Carteras y seguimiento\Acciones y dividendos")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\40 📈 Inversiones y cartera\Carteras y seguimiento\Forex")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\40 📈 Inversiones y cartera\Carteras y seguimiento\Criptomonedas")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\40 📈 Inversiones y cartera\Análisis de inversiones")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\40 📈 Inversiones y cartera\Análisis de inversiones\Análisis fundamental y técnico")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\40 📈 Inversiones y cartera\Análisis de inversiones\Watchlists")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\40 📈 Inversiones y cartera\Información financiera")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\40 📈 Inversiones y cartera\Información financiera\Investing")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\50 🧾 Seguridad Social y cotizaciones")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\50 🧾 Seguridad Social y cotizaciones\Vida laboral")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\50 🧾 Seguridad Social y cotizaciones\Bases de cotización")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\50 🧾 Seguridad Social y cotizaciones\Certificados de situación laboral")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\50 🧾 Seguridad Social y cotizaciones\Comunicaciones TGSS")
New-Folder-Safe (Join-Path $RutaRaiz "20 💸 DINERO\50 🧾 Seguridad Social y cotizaciones\Autónomos (RETA)")

# --- 30 👨‍👩‍👧 RELACIONES ---
New-Folder-Safe (Join-Path $RutaRaiz "30 👨‍👩‍👧 RELACIONES")
New-Folder-Safe (Join-Path $RutaRaiz "30 👨‍👩‍👧 RELACIONES\00 👪 Familia Núcleo")
New-Folder-Safe (Join-Path $RutaRaiz "30 👨‍👩‍👧 RELACIONES\00 👪 Familia Núcleo\10 🧔🏻‍♂️ Pepe")
New-Folder-Safe (Join-Path $RutaRaiz "30 👨‍👩‍👧 RELACIONES\00 👪 Familia Núcleo\10 🧔🏻‍♂️ Pepe\Documentación personal")
New-Folder-Safe (Join-Path $RutaRaiz "30 👨‍👩‍👧 RELACIONES\00 👪 Familia Núcleo\20 👩🏻 Myriam")
New-Folder-Safe (Join-Path $RutaRaiz "30 👨‍👩‍👧 RELACIONES\00 👪 Familia Núcleo\20 👩🏻 Myriam\Documentación personal")
New-Folder-Safe (Join-Path $RutaRaiz "30 👨‍👩‍👧 RELACIONES\00 👪 Familia Núcleo\30 👧🏻 Carla")
New-Folder-Safe (Join-Path $RutaRaiz "30 👨‍👩‍👧 RELACIONES\00 👪 Familia Núcleo\30 👧🏻 Carla\Documentación personal")
New-Folder-Safe (Join-Path $RutaRaiz "30 👨‍👩‍👧 RELACIONES\10 👴 Familia Extendida")
New-Folder-Safe (Join-Path $RutaRaiz "30 👨‍👩‍👧 RELACIONES\10 👴 Familia Extendida\Papá PBS")
New-Folder-Safe (Join-Path $RutaRaiz "30 👨‍👩‍👧 RELACIONES\10 👴 Familia Extendida\Tía Mer")
New-Folder-Safe (Join-Path $RutaRaiz "30 👨‍👩‍👧 RELACIONES\10 👴 Familia Extendida\Tío Paco Borrás")
New-Folder-Safe (Join-Path $RutaRaiz "30 👨‍👩‍👧 RELACIONES\20 🎉 Eventos Familiares")
New-Folder-Safe (Join-Path $RutaRaiz "30 👨‍👩‍👧 RELACIONES\30 🌍 Ocio y Viajes")
New-Folder-Safe (Join-Path $RutaRaiz "30 👨‍👩‍👧 RELACIONES\30 🌍 Ocio y Viajes\Reyes y Papá Noel")
New-Folder-Safe (Join-Path $RutaRaiz "30 👨‍👩‍👧 RELACIONES\30 🌍 Ocio y Viajes\Vacaciones")
New-Folder-Safe (Join-Path $RutaRaiz "30 👨‍👩‍👧 RELACIONES\40 🤝 Amigos")
New-Folder-Safe (Join-Path $RutaRaiz "30 👨‍👩‍👧 RELACIONES\90 📜 Historia Familiar")
New-Folder-Safe (Join-Path $RutaRaiz "30 👨‍👩‍👧 RELACIONES\90 📜 Historia Familiar\ADN")
New-Folder-Safe (Join-Path $RutaRaiz "30 👨‍👩‍👧 RELACIONES\90 📜 Historia Familiar\Árboles Genealógicos")

# --- 40 🌱 DESARROLLO PERSONAL ---
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\00 📚 Formación")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\00 📚 Formación\10 📚 Pepe")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\00 📚 Formación\10 📚 Pepe\🎓 Educación formal")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\00 📚 Formación\10 📚 Pepe\Cursos presenciales")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\00 📚 Formación\10 📚 Pepe\Cursos online")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\00 📚 Formación\10 📚 Pepe\Membresías")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\00 📚 Formación\10 📚 Pepe\Lecturas formativas")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\00 📚 Formación\10 📚 Pepe\Certificaciones y diplomas")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\00 📚 Formación\20 📚 Myriam")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\00 📚 Formación\30 📚 Carla")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\10 ✍️ Escritura y creatividad literaria")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\10 ✍️ Escritura y creatividad literaria\Proyectos literarios")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\10 ✍️ Escritura y creatividad literaria\Proyectos literarios\Cuentos")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\10 ✍️ Escritura y creatividad literaria\Proyectos literarios\Microrrelatos")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\10 ✍️ Escritura y creatividad literaria\Proyectos literarios\Blogs")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\10 ✍️ Escritura y creatividad literaria\Proyectos literarios\Ideas")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\10 ✍️ Escritura y creatividad literaria\Proyectos literarios\Premios")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\20 🎨 Dibujo y arte visual")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\20 🎨 Dibujo y arte visual\Sketches y bocetos")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\20 🎨 Dibujo y arte visual\Referencias visuales")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\20 🎨 Dibujo y arte visual\Proyectos personales")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\30 🧩 Tecnología y experimentación")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\30 🧩 Tecnología y experimentación\IA y automatizaciones")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\30 🧩 Tecnología y experimentación\Apps y prototipos personales")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\30 🧩 Tecnología y experimentación\n8n y flujos de prueba")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\30 🧩 Tecnología y experimentación\Scripts o herramientas propias")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\40 📸 Multimedia")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\40 📸 Multimedia\Edición de vídeo")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\40 📸 Multimedia\Fotografía")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\40 📸 Multimedia\Podcasting y sonido")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\40 📸 Multimedia\Pruebas multimedia")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\50 📖 Lecturas y biblioteca personal")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\50 📖 Lecturas y biblioteca personal\Lecturas personales")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\50 📖 Lecturas y biblioteca personal\Notas de colecciones y lecturas en curso")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\60 🎭 Asociaciones y Cultura")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\60 🎭 Asociaciones y Cultura\Valencianismo")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\60 🎭 Asociaciones y Cultura\Valencianismo\Rat Penat")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\60 🎭 Asociaciones y Cultura\Valencianismo\Acció Cultural")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\60 🎭 Asociaciones y Cultura\Otras asociaciones")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\60 🎭 Asociaciones y Cultura\Colaboraciones o soporte técnico-cultural")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\60 🎭 Asociaciones y Cultura\Eventos culturales o conferencias")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\70 🕊️ Espiritualidad")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\70 🕊️ Espiritualidad\Documentos de referencia")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\70 🕊️ Espiritualidad\Participación en actividades")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\70 🕊️ Espiritualidad\Textos personales y diarios espirituales")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\80 🔄 Hábitos y Rutinas")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\80 🔄 Hábitos y Rutinas\Pepe")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\80 🔄 Hábitos y Rutinas\Myriam")
New-Folder-Safe (Join-Path $RutaRaiz "40 🌱 DESARROLLO PERSONAL\80 🔄 Hábitos y Rutinas\Carla")

# --- 50 🚀 PROYECTOS ---
New-Folder-Safe (Join-Path $RutaRaiz "50 🚀 PROYECTOS")
New-Folder-Safe (Join-Path $RutaRaiz "50 🚀 PROYECTOS\00 📅 En curso")
New-Folder-Safe (Join-Path $RutaRaiz "50 🚀 PROYECTOS\10 🗃️ Finalizados")
New-Folder-Safe (Join-Path $RutaRaiz "50 🚀 PROYECTOS\20 📋 Plantillas y recursos de gestión")
New-Folder-Safe (Join-Path $RutaRaiz "50 🚀 PROYECTOS\20 📋 Plantillas y recursos de gestión\Plantilla de seguimiento de proyectos")
New-Folder-Safe (Join-Path $RutaRaiz "50 🚀 PROYECTOS\20 📋 Plantillas y recursos de gestión\Modelos de actas y entregables")

# --- 90 🖥️ SISTEMA ---
New-Folder-Safe (Join-Path $RutaRaiz "90 🖥️ SISTEMA")
New-Folder-Safe (Join-Path $RutaRaiz "90 🖥️ SISTEMA\10 🏗️ Infraestructura digital")
New-Folder-Safe (Join-Path $RutaRaiz "90 🖥️ SISTEMA\10 🏗️ Infraestructura digital\OneDrive")
New-Folder-Safe (Join-Path $RutaRaiz "90 🖥️ SISTEMA\10 🏗️ Infraestructura digital\Google Drive")
New-Folder-Safe (Join-Path $RutaRaiz "90 🖥️ SISTEMA\10 🏗️ Infraestructura digital\n8n")
New-Folder-Safe (Join-Path $RutaRaiz "90 🖥️ SISTEMA\10 🏗️ Infraestructura digital\Cloudflare")
New-Folder-Safe (Join-Path $RutaRaiz "90 🖥️ SISTEMA\10 🏗️ Infraestructura digital\MiniPC servidor")
New-Folder-Safe (Join-Path $RutaRaiz "90 🖥️ SISTEMA\10 🏗️ Infraestructura digital\Inventario técnico (IT)")
New-Folder-Safe (Join-Path $RutaRaiz "90 🖥️ SISTEMA\10 🏗️ Infraestructura digital\Inventario técnico (IT)\Red doméstica")
New-Folder-Safe (Join-Path $RutaRaiz "90 🖥️ SISTEMA\10 🏗️ Infraestructura digital\Inventario técnico (IT)\Servidores y mini-PCs")
New-Folder-Safe (Join-Path $RutaRaiz "90 🖥️ SISTEMA\10 🏗️ Infraestructura digital\Inventario técnico (IT)\End-user")
New-Folder-Safe (Join-Path $RutaRaiz "90 🖥️ SISTEMA\10 🏗️ Infraestructura digital\Inventario técnico (IT)\Licencias y software")
New-Folder-Safe (Join-Path $RutaRaiz "90 🖥️ SISTEMA\20 📝 Plantillas y Convenciones")
New-Folder-Safe (Join-Path $RutaRaiz "90 🖥️ SISTEMA\20 📝 Plantillas y Convenciones\Convenciones de clasificación")
New-Folder-Safe (Join-Path $RutaRaiz "90 🖥️ SISTEMA\20 📝 Plantillas y Convenciones\Nomenclatura")
New-Folder-Safe (Join-Path $RutaRaiz "90 🖥️ SISTEMA\20 📝 Plantillas y Convenciones\Plantillas de documentos")

# Resumen
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  RESUMEN" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

if ($Simular) {
    Write-Host "MODO SIMULACIÓN: No se creó ninguna carpeta." -ForegroundColor Yellow
    Write-Host "Ejecuta sin -Simular para crear la estructura.`n" -ForegroundColor Yellow
}
else {
    Write-Host "Estructura VIDA DIGITAL creada correctamente en:" -ForegroundColor Green
    Write-Host "$RutaRaiz`n" -ForegroundColor White
}
