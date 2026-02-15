# VIDA DIGITAL - Estructura de Organización

## Estructura de 7 Pilares

### 00 📥 INBOX
Carpeta temporal para archivos sin clasificar. Procesar regularmente.

### 10 🏥 SALUD
Todo lo relacionado con salud física y médica.

**Estructura:**
- `00 🗂️ Admin` - Seguros, Seguridad Social, procedimientos
- `10 🏥 Pepe` - Médicos, Ejercicio, Alimentación, Bienestar y Prevención
- `20 🏥 Myriam` - (estructura análoga)
- `30 🏥 Carla` - (estructura análoga)

### 20 💸 DINERO
Finanzas personales, profesionales e inversiones.

**Estructura:**
- `00 🏠 Hogar` - Vivienda, Suministros, Vehículo, Seguros, Inventario
- `10 💼 Trabajo por cuenta ajena` - Capgemini (nóminas, contratos, etc.)
- `20 📊 Actividad profesional` - Facturas, Hacienda, Proyectos, Gastos
- `30 🏦 Bancos y brókeres` - Bancos, Brókeres, Criptomonedas, Inmobiliario
- `40 📈 Inversiones y cartera` - Carteras, Análisis, Información financiera
- `50 🧾 Seguridad Social y cotizaciones` - Vida laboral, Bases, TGSS

### 30 👨‍👩‍👧 RELACIONES
Familia, amigos, eventos y genealogía.

**Estructura:**
- `00 👪 Familia Núcleo` - Pepe, Myriam, Carla (documentación personal)
- `10 👴 Familia Extendida` - Papá PBS, Tía Mer, Tío Paco Borrás
- `20 🎉 Eventos Familiares` - Eventos con fecha
- `30 🌍 Ocio y Viajes` - Reyes, Vacaciones
- `40 🤝 Amigos`
- `90 📜 Historia Familiar` - ADN, Árboles Genealógicos

### 40 🌱 DESARROLLO PERSONAL
Formación, creatividad, hobbies y crecimiento personal.

**Estructura:**
- `00 📚 Formación` - Por persona (Pepe, Myriam, Carla)
- `10 ✍️ Escritura y creatividad literaria` - Cuentos, Microrrelatos, Blogs, Ideas, Premios
- `20 🎨 Dibujo y arte visual` - Sketches, Referencias, Proyectos
- `30 🧩 Tecnología y experimentación` - IA, Apps, n8n, Scripts
- `40 📸 Multimedia` - Vídeo, Fotografía, Podcasting
- `50 📖 Lecturas y biblioteca personal` - Lecturas, Calibre, Notas
- `60 🎭 Asociaciones y Cultura` - Valencianismo (Rat Penat, Acció Cultural), Otras
- `70 🕊️ Espiritualidad` - Documentos, Participación, Textos personales
- `80 🔄 Hábitos y Rutinas` - Por persona

### 50 🚀 PROYECTOS
Proyectos activos y finalizados.

**Estructura:**
- `00 📅 En curso` - Proyectos activos
- `10 🗃️ Finalizados` - Archivar en su pilar natural
- `20 📋 Plantillas y recursos de gestión` - Plantillas, Modelos

### 90 🖥️ SISTEMA
Infraestructura digital, plantillas y convenciones.

**Estructura:**
- `10 🏗️ Infraestructura digital` - OneDrive, Google Drive, n8n, Cloudflare, MiniPC, Inventario IT
- `20 📝 Plantillas y Convenciones` - Convenciones, Nomenclatura, Plantillas

---

## Reglas de Clasificación

### Principios Generales

1. **Un solo lugar**: Cada archivo debe tener una ubicación principal
2. **Pilar dominante**: Si un archivo pertenece a varios pilares, elegir el más relevante
3. **Contexto sobre contenido**: Clasificar por el contexto de uso, no solo por el tipo de archivo
4. **Personas antes que temas**: En SALUD y DESARROLLO PERSONAL, organizar por persona primero

### Tabla de Ambigüedades

| Contenido | Pilar Correcto | Razón |
|-----------|----------------|-------|
| Factura médica | 10 🏥 SALUD | Contexto médico prevalece |
| Nómina | 20 💸 DINERO / 10 💼 Trabajo | Contexto laboral |
| Curso de programación | 40 🌱 DESARROLLO PERSONAL / 00 📚 Formación | Formación personal |
| Proyecto de escritura activo | 50 🚀 PROYECTOS / 00 📅 En curso | Mientras esté activo |
| Proyecto de escritura finalizado | 40 🌱 DESARROLLO PERSONAL / 10 ✍️ Escritura | Archivar en pilar natural |
| Backup de n8n | 90 🖥️ SISTEMA / 10 🏗️ Infraestructura | Infraestructura técnica |
| Foto familiar | Fuera de VIDA DIGITAL | Fotos brutas no se clasifican |
| DNI/Pasaporte | 30 👨‍👩‍👧 RELACIONES / 00 👪 Familia Núcleo / [Persona] | Documentación personal |
| Certificado de nacimiento | 30 👨‍👩‍👧 RELACIONES / 00 👪 Familia Núcleo / [Persona] | Documentación personal |
| Impuestos municipales | 20 💸 DINERO / 00 🏠 Hogar / Vivienda / Impuestos | Hogar |
| Factura emitida (autónomo) | 20 💸 DINERO / 20 📊 Actividad profesional / Facturas / Emitidas | Actividad profesional |
| Seguro médico | 10 🏥 SALUD / 00 🗂️ Admin / Seguros médicos privados | Admin de salud |
| Seguro de hogar | 20 💸 DINERO / 00 🏠 Hogar / Seguros / Hogar | Hogar |

### Nomenclatura de Archivos

**Formato general:**
```
YYYYMMDD_Descripción_Contexto.ext
```

**Ejemplos:**
- `20250214_Informe_Analítica_Pepe.pdf`
- `20250101_Factura_Emitida_Cliente_ABC.pdf`
- `20241225_Foto_Familia_Navidad.jpg` (fuera de VIDA DIGITAL)

**Carpetas con años (nodos finales):**
- Impuestos: `2024`, `2025`, etc.
- Eventos: `2024-05-22 Bodas Oro Paco y Encarna`

---

## Ejemplos de Clasificación

### Ejemplo 1: Informe Médico de Pepe
**Archivo:** `20250214_Informe_Cardiología_Pepe.pdf`  
**Ubicación:** `10 🏥 SALUD\10 🏥 Pepe\Médicos\Informes Médicos\`  
**Razón:** Informe médico de Pepe → Pilar SALUD, persona Pepe, subcarpeta Médicos/Informes

### Ejemplo 2: Factura Emitida (Autónomo)
**Archivo:** `20250131_Factura_001_Cliente_XYZ.pdf`  
**Ubicación:** `20 💸 DINERO\20 📊 Actividad profesional\Facturas\Emitidas\`  
**Razón:** Factura de actividad profesional → Pilar DINERO, Actividad profesional

### Ejemplo 3: Certificado de Curso Online
**Archivo:** `20241215_Certificado_Python_Udemy.pdf`  
**Ubicación:** `40 🌱 DESARROLLO PERSONAL\00 📚 Formación\10 📚 Pepe\Certificaciones y diplomas\`  
**Razón:** Formación personal de Pepe → Pilar DESARROLLO PERSONAL

### Ejemplo 4: Proyecto de Escritura Activo
**Archivo:** `2025_Novela_Premio_Hortensia_Roig.docx`  
**Ubicación:** `50 🚀 PROYECTOS\00 📅 En curso\2025 Novela Premio Hortensia Roig\`  
**Razón:** Proyecto activo → Pilar PROYECTOS. Al finalizar, mover a `40 🌱 DESARROLLO PERSONAL\10 ✍️ Escritura`

### Ejemplo 5: Backup de n8n
**Archivo:** `20250214_n8n_workflows_backup.json`  
**Ubicación:** `90 🖥️ SISTEMA\10 🏗️ Infraestructura digital\n8n\`  
**Razón:** Infraestructura técnica → Pilar SISTEMA

### Ejemplo 6: DNI de Carla
**Archivo:** `20230515_DNI_Carla_Frente.jpg`  
**Ubicación:** `30 👨‍👩‍👧 RELACIONES\00 👪 Familia Núcleo\30 👧🏻 Carla\Documentación personal\`  
**Razón:** Documento de identidad personal → Pilar RELACIONES, Familia Núcleo, persona Carla

### Ejemplo 7: Impuesto Municipal 2024
**Archivo:** `20241201_IBI_2024.pdf`  
**Ubicación:** `20 💸 DINERO\00 🏠 Hogar\Vivienda\Impuestos\2024\`  
**Razón:** Impuesto de vivienda → Pilar DINERO, Hogar, subcarpeta con año

### Ejemplo 8: Foto Evento Familiar
**Archivo:** `20240522_Bodas_Oro_Paco_Encarna.jpg`  
**Ubicación:** `30 👨‍👩‍👧 RELACIONES\20 🎉 Eventos Familiares\2024-05-22 Bodas Oro Paco y Encarna\`  
**Razón:** Evento familiar → Pilar RELACIONES, carpeta con fecha y descripción

### Ejemplo 9: Libro de Calibre
**Archivo:** `El_Quijote_Cervantes.epub`  
**Ubicación:** `40 🌱 DESARROLLO PERSONAL\50 📖 Lecturas y biblioteca personal\Lecturas personales\Calibre Library\`  
**Razón:** Biblioteca personal → Pilar DESARROLLO PERSONAL, Lecturas

### Ejemplo 10: Script Personal de Python
**Archivo:** `clasificador_archivos.py`  
**Ubicación:** `40 🌱 DESARROLLO PERSONAL\30 🧩 Tecnología y experimentación\Scripts o herramientas propias\`  
**Razón:** Experimentación técnica personal → Pilar DESARROLLO PERSONAL, Tecnología

---

## Notas Importantes

1. **INBOX**: Procesar regularmente (semanal). No dejar archivos sin clasificar más de 1 mes.
2. **Proyectos activos**: Mientras estén activos, en `50 🚀 PROYECTOS`. Al finalizar, mover al pilar natural.
3. **Fotos y vídeos brutos**: NO clasificar en VIDA DIGITAL. Mantener en carpetas separadas (`Imágenes`, `Vídeos`).
4. **Música y audio**: NO clasificar en VIDA DIGITAL. Mantener en carpetas separadas.
5. **Backups automáticos**: Configurar en `90 🖥️ SISTEMA\10 🏗️ Infraestructura digital\`.
6. **Calibre**: Mantener biblioteca completa en `40 🌱 DESARROLLO PERSONAL\50 📖 Lecturas\Lecturas personales\Calibre Library\`.

---

## Migración desde Estructura Antigua

Ver `plan_migracion.md` para detalles completos de migración.

**Carpetas principales a migrar:**
- `Documentos\Salut` → `10 🏥 SALUD`
- `Documentos\Finances i Negocis` → `20 💸 DINERO`
- `Documentos\Família` → `30 👨‍👩‍👧 RELACIONES`
- `Documentos\Formació` → `40 🌱 DESARROLLO PERSONAL\00 📚 Formación`
- `Documentos\Escritura` → `40 🌱 DESARROLLO PERSONAL\10 ✍️ Escritura`
- `Documentos\Tecnologia` → `40 🌱 DESARROLLO PERSONAL\30 🧩 Tecnología`
- `Documentos\Valencianisme` → `40 🌱 DESARROLLO PERSONAL\60 🎭 Asociaciones\Valencianismo`
- `Documentos\Administració Pública` → `30 👨‍👩‍👧 RELACIONES\00 👪 Familia Núcleo` (DNIs, Pasaportes)

**Omitir de migración:**
- Carpetas raíz de OneDrive (FARMACIA, MENECIL, Imágenes, Vídeos, Música, etc.)
- Carpetas temporales (Descargas, _TEMP)
- Aplicaciones portables (Calibre Portable → solo migrar Library)
