# Contexto de Laboratorio: Samsung Notes → Markdown/PDF Converter

Este documento resume las decisiones técnicas, la arquitectura final y el "happy path" resultante de la fase de experimentación (PoC). Sirve como base de conocimiento para la implementación del microservicio de producción.

## 1. El Origen: ¿Por qué DOCX?

Tras analizar las opciones de exportación de Samsung Notes (PDF, DOCX, SDOCX, Imágenes), se descartó la ingeniería inversa del formato propietario `SDOCX` por riesgo de rotura ante actualizaciones.

**Decisión estratégica:** Usar el **DOCX** como fuente de verdad.
- **Razón:** El DOCX exportado por Samsung es un contenedor ZIP que ya incluye el **OCR realizado por la tablet** (en cajas de texto con coordenadas) y los **trazos manuscritos como imágenes PNG transparentes**.
- **Ventaja:** No necesitamos implementar nuestro propio OCR pesado en el servidor; aprovechamos el hardware de la tablet/Galaxy AI.

---

## 2. Anatomía del DOCX de Samsung Notes

El análisis forense del archivo reveló un patrón constante:
1. **Imágenes:** En la carpeta `word/media/` coexisten imágenes pequeñas (decorativas, logos, separadores) e imágenes grandes (>50KB). Estas últimas son los lienzos de escritura.
2. **Estructura XML:** El archivo `word/document.xml` organiza la nota en páginas.
   - Cada página de contenido tiene un elemento `<w:drawing>` apuntando a la imagen del trazo.
   - El texto reconocido reside en elementos `<v:shape>` (VML) con estilos CSS como `margin-top` y `height`.
3. **Desafío superado:** El texto OCR no viene en párrafos, sino en cajas superpuestas. El conversor ahora agrupa y ordena estas cajas por su posición vertical (Y) y distribuye las líneas de texto equitativamente dentro de la altura de cada caja para evitar solapamientos.

---

## 3. Arquitectura del Conversor (`converter.py`)

Se ha desarrollado una utilidad modular en Python con las siguientes capacidades:

### A. Capa de Texto Invisible (Searchable PDF)
Inspirándonos en el éxito de *MyScript Notes*, el PDF resultante utiliza el estándar **PDF Render Mode 3 (Invisible)**.
- **Técnica:** Se coloca el texto sobre la imagen de fondo con `fpdf2.TextMode.INVISIBLE`.
- **Resultado:** El usuario ve exactamente su escritura manual (fondo blanco), pero puede hacer `Ctrl+F` para buscar palabras, seleccionar texto y copiarlo. Es un PDF 100% "leíble" por máquinas pero "limpio" para humanos.

### B. Gestión Flexible de Salida
Para adaptarse a diferentes flujos (Obsidian, Archivo Histórico, n8n), el conversor admite:
- **`images_mode`**: Controla si las imágenes van en la misma carpeta (`flat`), en una carpeta `images/` genérica, o en una carpeta nombrada por el documento.
- **`per_document_folder`**: Decide si cada nota se encapsula en su propia subcarpeta o se genera todo en la raíz del output.
- **`link_images` / `export_images`**: Permite generar el Markdown "limpio" (solo texto) y el PDF, sin necesidad de inundar el disco con archivos PNG si solo se desea el archivo final.

### C. Soporte Unicode y Microservicio
- El script incluye lógica para localizar fuentes TTF (`DejaVu`, `Arial`, `Noto`) tanto en Windows como en Linux/Docker para manejar caracteres especiales (`ñ`, tildes, símbolos).
- Se ha estructurado el código con una función `convert_batch()` para procesar volúmenes de notas en una sola llamada.

---

## 4. El "Happy Path" hacia el Microservicio

Para el siguiente proyecto (Backend/API), el flujo de éxito validado es:

1. **Entrada:** Recepción de un archivo `.docx` (vía `UploadFile` en FastAPI o desde Google Drive).
2. **Procesamiento:**
   ```python
   # Ejemplo de llamada ideal
   convert_docx_to_markdown(
       docx_path="nota.docx",
       output_dir="storage/",
       bg="transparent",
       generate_pdf=True,
       searchable_pdf=True,
       link_images=False,      # Típico para microservicio que devuelve PDF+MD
       export_images=False,    # Evita basura en el server
       per_document_folder=False
   )
   ```
3. **Salida:** Un archivo `.md` estructurado y un `.pdf` buscable de alta calidad.

---

## 5. Glosario de Archivos Clave para Traspaso

Si vas a clonar este trabajo a otro repositorio, estos son los archivos que contienen toda la inteligencia:

| Archivo | Función |
|---------|---------|
| `converter.py` | El motor lógico completo. **Este es el archivo principal.** |
| `test_converter.py` | Suite de 69 tests que garantizan que el microservicio no rompa la lógica de negocio. |
| `run_demo.py` | Script de ejemplo para ejecución batch rápida. |
| `poc_plan_y_resultados.md` | Detalle técnico de los checks de validación y estructura XML interna. |

**Nota final sobre fuentes en Producción:**
En un contenedor Docker (Linux), es vital ejecutar `apt-get install -y fonts-dejavu-core` para que el PDF invisible pueda renderizar caracteres españoles correctamente. El código ya está preparado para buscar estas rutas automáticamente.
