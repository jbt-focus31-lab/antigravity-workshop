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
Fecha: 2026-02-12
Versión: 1.0
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$RutaRaiz,
    
    [switch]$Simular
)

# Función para crear carpeta (o simular)
function New-Folder {
    param([string]$Path)
    
    if ($Simular) {
        Write-Host "[SIMULACIÓN] Crearía: $Path" -ForegroundColor Yellow
    } else {
        if (-not (Test-Path $Path)) {
            New-Item -ItemType Directory -Path $Path -Force | Out-Null
            Write-Host "Creada: $Path" -ForegroundColor Green
        } else {
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
New-Folder $RutaRaiz

# --- 10 SALUD ---
New-Folder (Join-Path $RutaRaiz "10 SALUD")
New-Folder (Join-Path $RutaRaiz "10 SALUD\00 Admin")
New-Folder (Join-Path $RutaRaiz "10 SALUD\00 Admin\Seguros Médicos")
New-Folder (Join-Path $RutaRaiz "10 SALUD\00 Admin\Seguridad Social")
New-Folder (Join-Path $RutaRaiz "10 SALUD\00 Admin\Citas y Consentimientos")
New-Folder (Join-Path $RutaRaiz "10 SALUD\10 Personas")
New-Folder (Join-Path $RutaRaiz "10 SALUD\10 Personas\Pepe")
New-Folder (Join-Path $RutaRaiz "10 SALUD\10 Personas\Pepe\01 Informes")
New-Folder (Join-Path $RutaRaiz "10 SALUD\10 Personas\Pepe\02 Pruebas")
New-Folder (Join-Path $RutaRaiz "10 SALUD\10 Personas\Pepe\03 Tratamientos")
New-Folder (Join-Path $RutaRaiz "10 SALUD\10 Personas\Pepe\04 Hábitos")
New-Folder (Join-Path $RutaRaiz "10 SALUD\10 Personas\Myriam")
New-Folder (Join-Path $RutaRaiz "10 SALUD\10 Personas\Myriam\01 Informes")
New-Folder (Join-Path $RutaRaiz "10 SALUD\10 Personas\Myriam\02 Pruebas")
New-Folder (Join-Path $RutaRaiz "10 SALUD\10 Personas\Myriam\03 Tratamientos")
New-Folder (Join-Path $RutaRaiz "10 SALUD\10 Personas\Myriam\04 Hábitos")
New-Folder (Join-Path $RutaRaiz "10 SALUD\10 Personas\Carla")
New-Folder (Join-Path $RutaRaiz "10 SALUD\10 Personas\Carla\01 Informes")
New-Folder (Join-Path $RutaRaiz "10 SALUD\10 Personas\Carla\02 Pruebas")
New-Folder (Join-Path $RutaRaiz "10 SALUD\10 Personas\Carla\03 Tratamientos")
New-Folder (Join-Path $RutaRaiz "10 SALUD\10 Personas\Carla\04 Hábitos")

# --- 20 DINERO ---
New-Folder (Join-Path $RutaRaiz "20 DINERO")
New-Folder (Join-Path $RutaRaiz "20 DINERO\00 Admin")
New-Folder (Join-Path $RutaRaiz "20 DINERO\00 Admin\Hogar")
New-Folder (Join-Path $RutaRaiz "20 DINERO\00 Admin\Hogar\Vivienda")
New-Folder (Join-Path $RutaRaiz "20 DINERO\00 Admin\Hogar\Vivienda\Documentación")
New-Folder (Join-Path $RutaRaiz "20 DINERO\00 Admin\Hogar\Vivienda\Impuestos")
New-Folder (Join-Path $RutaRaiz "20 DINERO\00 Admin\Hogar\Vivienda\Mantenimiento")
New-Folder (Join-Path $RutaRaiz "20 DINERO\00 Admin\Hogar\Suministros")
New-Folder (Join-Path $RutaRaiz "20 DINERO\00 Admin\Hogar\Suministros\Agua")
New-Folder (Join-Path $RutaRaiz "20 DINERO\00 Admin\Hogar\Suministros\Luz")
New-Folder (Join-Path $RutaRaiz "20 DINERO\00 Admin\Hogar\Suministros\Gas")
New-Folder (Join-Path $RutaRaiz "20 DINERO\00 Admin\Hogar\Suministros\Internet")
New-Folder (Join-Path $RutaRaiz "20 DINERO\00 Admin\Hogar\Suministros\Otros Servicios")
New-Folder (Join-Path $RutaRaiz "20 DINERO\00 Admin\Hogar\Vehículo")
New-Folder (Join-Path $RutaRaiz "20 DINERO\00 Admin\Hogar\Seguros")
New-Folder (Join-Path $RutaRaiz "20 DINERO\00 Admin\Hogar\Seguros\Hogar")
New-Folder (Join-Path $RutaRaiz "20 DINERO\00 Admin\Hogar\Seguros\Vehículo")
New-Folder (Join-Path $RutaRaiz "20 DINERO\00 Admin\Hogar\Seguros\Vida")
New-Folder (Join-Path $RutaRaiz "20 DINERO\00 Admin\Hogar\Inventario, garantías y manuales")
New-Folder (Join-Path $RutaRaiz "20 DINERO\00 Admin\Hogar\Inventario, garantías y manuales\Electrodomésticos")
New-Folder (Join-Path $RutaRaiz "20 DINERO\00 Admin\Hogar\Inventario, garantías y manuales\Electrónica de consumo")
New-Folder (Join-Path $RutaRaiz "20 DINERO\00 Admin\Hogar\Inventario, garantías y manuales\Informática y móviles")
New-Folder (Join-Path $RutaRaiz "20 DINERO\00 Admin\Hogar\Inventario, garantías y manuales\Otros")
New-Folder (Join-Path $RutaRaiz "20 DINERO\10 Actividad Profesional")
New-Folder (Join-Path $RutaRaiz "20 DINERO\10 Actividad Profesional\10 Facturas")
New-Folder (Join-Path $RutaRaiz "20 DINERO\10 Actividad Profesional\10 Facturas\Emitidas")
New-Folder (Join-Path $RutaRaiz "20 DINERO\10 Actividad Profesional\10 Facturas\Recibidas")
New-Folder (Join-Path $RutaRaiz "20 DINERO\10 Actividad Profesional\20 Hacienda")
New-Folder (Join-Path $RutaRaiz "20 DINERO\10 Actividad Profesional\20 Hacienda\Modelo 036")
New-Folder (Join-Path $RutaRaiz "20 DINERO\10 Actividad Profesional\20 Hacienda\Modelos 303-390 IVA")
New-Folder (Join-Path $RutaRaiz "20 DINERO\10 Actividad Profesional\20 Hacienda\Resultados Actividad Económica")
New-Folder (Join-Path $RutaRaiz "20 DINERO\10 Actividad Profesional\30 Proyectos")
New-Folder (Join-Path $RutaRaiz "20 DINERO\10 Actividad Profesional\40 Gastos")
New-Folder (Join-Path $RutaRaiz "20 DINERO\10 Actividad Profesional\40 Gastos\Proveedores")
New-Folder (Join-Path $RutaRaiz "20 DINERO\20 Inversiones y Banca")
New-Folder (Join-Path $RutaRaiz "20 DINERO\20 Inversiones y Banca\Banca Online")
New-Folder (Join-Path $RutaRaiz "20 DINERO\20 Inversiones y Banca\Análisis Rentabilidad")
New-Folder (Join-Path $RutaRaiz "20 DINERO\20 Inversiones y Banca\Carteras y seguimiento")
New-Folder (Join-Path $RutaRaiz "20 DINERO\20 Inversiones y Banca\Carteras y seguimiento\Acciones y dividendos")
New-Folder (Join-Path $RutaRaiz "20 DINERO\20 Inversiones y Banca\Carteras y seguimiento\Forex")
New-Folder (Join-Path $RutaRaiz "20 DINERO\20 Inversiones y Banca\Carteras y seguimiento\Criptomonedas")
New-Folder (Join-Path $RutaRaiz "20 DINERO\30 Seguridad Social y cotizaciones")
New-Folder (Join-Path $RutaRaiz "20 DINERO\30 Seguridad Social y cotizaciones\Vida laboral")
New-Folder (Join-Path $RutaRaiz "20 DINERO\30 Seguridad Social y cotizaciones\Bases de cotización")
New-Folder (Join-Path $RutaRaiz "20 DINERO\30 Seguridad Social y cotizaciones\Certificados de situación laboral")
New-Folder (Join-Path $RutaRaiz "20 DINERO\30 Seguridad Social y cotizaciones\Comunicaciones TGSS")
New-Folder (Join-Path $RutaRaiz "20 DINERO\30 Seguridad Social y cotizaciones\Autónomos (RETA)")

# --- 30 RELACIONES ---
New-Folder (Join-Path $RutaRaiz "30 RELACIONES")
New-Folder (Join-Path $RutaRaiz "30 RELACIONES\00 Familia Núcleo")
New-Folder (Join-Path $RutaRaiz "30 RELACIONES\00 Familia Núcleo\Pepe")
New-Folder (Join-Path $RutaRaiz "30 RELACIONES\00 Familia Núcleo\Pepe\Documentación personal")
New-Folder (Join-Path $RutaRaiz "30 RELACIONES\00 Familia Núcleo\Myriam")
New-Folder (Join-Path $RutaRaiz "30 RELACIONES\00 Familia Núcleo\Myriam\Documentación personal")
New-Folder (Join-Path $RutaRaiz "30 RELACIONES\00 Familia Núcleo\Myriam\Educación")
New-Folder (Join-Path $RutaRaiz "30 RELACIONES\00 Familia Núcleo\Myriam\Educación\EOI")
New-Folder (Join-Path $RutaRaiz "30 RELACIONES\00 Familia Núcleo\Myriam\Educación\Formación")
New-Folder (Join-Path $RutaRaiz "30 RELACIONES\00 Familia Núcleo\Myriam\Educación\Máster AIMME")
New-Folder (Join-Path $RutaRaiz "30 RELACIONES\00 Familia Núcleo\Carla")
New-Folder (Join-Path $RutaRaiz "30 RELACIONES\00 Familia Núcleo\Carla\Documentación personal")
New-Folder (Join-Path $RutaRaiz "30 RELACIONES\10 Historia Familiar")
New-Folder (Join-Path $RutaRaiz "30 RELACIONES\10 Historia Familiar\ADN")
New-Folder (Join-Path $RutaRaiz "30 RELACIONES\10 Historia Familiar\Árboles Genealógicos")
New-Folder (Join-Path $RutaRaiz "30 RELACIONES\20 Familia Extendida")
New-Folder (Join-Path $RutaRaiz "30 RELACIONES\30 Ocio y Viajes")
New-Folder (Join-Path $RutaRaiz "30 RELACIONES\30 Ocio y Viajes\Reyes y Papá Noel")
New-Folder (Join-Path $RutaRaiz "30 RELACIONES\30 Ocio y Viajes\Vacaciones")
New-Folder (Join-Path $RutaRaiz "30 RELACIONES\40 Eventos Familiares")
New-Folder (Join-Path $RutaRaiz "30 RELACIONES\50 Amigos")

# --- 40 DESARROLLO PERSONAL ---
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\00 Formación")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\00 Formación\10 Pepe")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\00 Formación\10 Pepe\Educación formal")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\00 Formación\10 Pepe\Cursos presenciales")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\00 Formación\10 Pepe\Cursos online")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\00 Formación\10 Pepe\Membresías")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\00 Formación\10 Pepe\Lecturas formativas")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\00 Formación\10 Pepe\Certificaciones y diplomas")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\00 Formación\20 Myriam")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\00 Formación\30 Carla")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\10 Creatividad y Escritura")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\10 Creatividad y Escritura\Proyectos literarios")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\10 Creatividad y Escritura\Proyectos literarios\Cuentos")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\10 Creatividad y Escritura\Proyectos literarios\Microrrelatos")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\10 Creatividad y Escritura\Proyectos literarios\Blogs")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\10 Creatividad y Escritura\Proyectos literarios\Ideas")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\10 Creatividad y Escritura\Proyectos literarios\Premios")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\20 Dibujo y arte visual")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\20 Dibujo y arte visual\Sketches y bocetos")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\20 Dibujo y arte visual\Referencias visuales")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\20 Dibujo y arte visual\Proyectos personales")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\30 Tecnología y experimentación")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\30 Tecnología y experimentación\IA y automatizaciones")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\30 Tecnología y experimentación\Apps y prototipos personales")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\30 Tecnología y experimentación\n8n y flujos de prueba")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\30 Tecnología y experimentación\Scripts o herramientas propias")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\40 Multimedia")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\40 Multimedia\Edición de vídeo")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\40 Multimedia\Fotografía")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\40 Multimedia\Podcasting y sonido")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\40 Multimedia\Pruebas multimedia")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\50 Lecturas y biblioteca personal")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\50 Lecturas y biblioteca personal\Lecturas personales")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\50 Lecturas y biblioteca personal\Notas de colecciones y lecturas en curso")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\60 Asociaciones y Cultura")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\60 Asociaciones y Cultura\Valencianismo")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\60 Asociaciones y Cultura\Valencianismo\Rat Penat")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\60 Asociaciones y Cultura\Valencianismo\Acció Cultural")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\60 Asociaciones y Cultura\Otras asociaciones")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\60 Asociaciones y Cultura\Colaboraciones o soporte técnico-cultural")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\60 Asociaciones y Cultura\Eventos culturales o conferencias")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\70 Espiritualidad")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\70 Espiritualidad\Documentos de referencia")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\70 Espiritualidad\Participación en actividades")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\70 Espiritualidad\Textos personales y diarios espirituales")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\80 Hábitos y Rutinas")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\80 Hábitos y Rutinas\Pepe")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\80 Hábitos y Rutinas\Myriam")
New-Folder (Join-Path $RutaRaiz "40 DESARROLLO PERSONAL\80 Hábitos y Rutinas\Carla")

# --- 50 PROYECTOS ---
New-Folder (Join-Path $RutaRaiz "50 PROYECTOS")
New-Folder (Join-Path $RutaRaiz "50 PROYECTOS\00 En curso")
New-Folder (Join-Path $RutaRaiz "50 PROYECTOS\10 Finalizados")
New-Folder (Join-Path $RutaRaiz "50 PROYECTOS\20 Plantillas y recursos de gestión")

# --- 90 SISTEMA ---
New-Folder (Join-Path $RutaRaiz "90 SISTEMA")
New-Folder (Join-Path $RutaRaiz "90 SISTEMA\10 Identidad y Legal")
New-Folder (Join-Path $RutaRaiz "90 SISTEMA\10 Identidad y Legal\DNI y Pasaporte")
New-Folder (Join-Path $RutaRaiz "90 SISTEMA\10 Identidad y Legal\Libros de familia")
New-Folder (Join-Path $RutaRaiz "90 SISTEMA\10 Identidad y Legal\Certificados")
New-Folder (Join-Path $RutaRaiz "90 SISTEMA\20 Dominios y Correo")
New-Folder (Join-Path $RutaRaiz "90 SISTEMA\30 Infra y Automatización")
New-Folder (Join-Path $RutaRaiz "90 SISTEMA\30 Infra y Automatización\OneDrive")
New-Folder (Join-Path $RutaRaiz "90 SISTEMA\30 Infra y Automatización\Google Drive")
New-Folder (Join-Path $RutaRaiz "90 SISTEMA\30 Infra y Automatización\n8n")
New-Folder (Join-Path $RutaRaiz "90 SISTEMA\30 Infra y Automatización\Cloudflare")
New-Folder (Join-Path $RutaRaiz "90 SISTEMA\30 Infra y Automatización\MiniPC servidor")
New-Folder (Join-Path $RutaRaiz "90 SISTEMA\30 Infra y Automatización\Inventario técnico (IT)")
New-Folder (Join-Path $RutaRaiz "90 SISTEMA\30 Infra y Automatización\Inventario técnico (IT)\Red doméstica")
New-Folder (Join-Path $RutaRaiz "90 SISTEMA\30 Infra y Automatización\Inventario técnico (IT)\Servidores y mini-PCs")
New-Folder (Join-Path $RutaRaiz "90 SISTEMA\30 Infra y Automatización\Inventario técnico (IT)\End-user")
New-Folder (Join-Path $RutaRaiz "90 SISTEMA\30 Infra y Automatización\Inventario técnico (IT)\Licencias y software")
New-Folder (Join-Path $RutaRaiz "90 SISTEMA\40 Plantillas y Convenciones")
New-Folder (Join-Path $RutaRaiz "90 SISTEMA\40 Plantillas y Convenciones\Convenciones de clasificación")
New-Folder (Join-Path $RutaRaiz "90 SISTEMA\40 Plantillas y Convenciones\Nomenclatura")
New-Folder (Join-Path $RutaRaiz "90 SISTEMA\40 Plantillas y Convenciones\Plantillas de documentos")

# Resumen
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  RESUMEN" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

if ($Simular) {
    Write-Host "MODO SIMULACIÓN: No se creó ninguna carpeta." -ForegroundColor Yellow
    Write-Host "Ejecuta sin -Simular para crear la estructura.`n" -ForegroundColor Yellow
} else {
    Write-Host "Estructura VIDA DIGITAL creada correctamente en:" -ForegroundColor Green
    Write-Host "$RutaRaiz`n" -ForegroundColor White
}
