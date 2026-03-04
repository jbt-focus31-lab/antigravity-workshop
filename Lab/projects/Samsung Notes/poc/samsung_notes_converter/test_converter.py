"""
Tests de validación v3 - Samsung Notes DOCX → Markdown converter
Cubre:
  - Bloques 1-4: regresión (ZIP, texto, naming, bg modes)
  - Bloque 5: PDF básico
  - Bloque 6: PDF buscable con TextMode.INVISIBLE
  - Bloque 7: images_mode variantes (flat, images_named)
  - Bloque 8: per_document_folder=False
  - Bloque 9: Batch conversion (5 ficheros, flat, PDF buscable)
  - Bloque 10: Regresión: conversión completa de los 5 ficheros

Ejecutar:
  $env:PYTHONIOENCODING="utf-8"
  python "Lab\\projects\\Samsung Notes\\poc\\samsung_notes_converter\\test_converter.py"
"""

import sys
import zipfile
import re
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from converter import (
    convert_docx_to_markdown,
    convert_batch,
    _extract_rels,
    _extract_textboxes,
    _get_image_sizes,
    _extract_page_image_rid,
    IMAGE_SIZE_THRESHOLD,
    W,
)
from lxml import etree

# ── Rutas ─────────────────────────────────────────────────────────────────────
SAMPLES_DIR = Path(__file__).parent.parent.parent / "samples" / "docx"
OUTPUT_DIR  = Path(__file__).parent.parent / "output_v3"
DOCX_FILES  = sorted(SAMPLES_DIR.glob("*.docx"))
SMALL_DOCX  = DOCX_FILES[-1]   # WOM GONZALO — el más pequeño

PASS = "PASS"
FAIL = "FAIL"
results = []


def check(name: str, condition: bool, detail: str = ""):
    status = "OK  " if condition else "ERR "
    print(f"  [{status}] {name}")
    if detail:
        print(f"           {detail}")
    results.append((name, condition))
    return condition


# ══════════════════════════════════════════════════════════════════════════════
# BLOQUE 1 — Regresión: estructura ZIP
# ══════════════════════════════════════════════════════════════════════════════
print("\n" + "="*60)
print("BLOQUE 1 — Estructura ZIP (regresion)")
print("="*60)

check("5 ficheros DOCX de muestra encontrados",
      len(DOCX_FILES) == 5, f"Dir: {SAMPLES_DIR}")

for f in DOCX_FILES:
    print(f"\n  [fichero] {f.name}")
    with zipfile.ZipFile(f) as zf:
        names     = zf.namelist()
        sizes     = _get_image_sizes(zf)
        big_imgs  = [fn for fn, sz in sizes.items() if sz >= IMAGE_SIZE_THRESHOLD]
        small_imgs = [fn for fn, sz in sizes.items() if sz < IMAGE_SIZE_THRESHOLD]
    check("word/document.xml presente",       "word/document.xml" in names)
    check("word/_rels/document.xml.rels presente", "word/_rels/document.xml.rels" in names)
    check(f"Imagenes en media/ ({len(big_imgs + small_imgs)} total)",
          len(big_imgs + small_imgs) > 0)
    check(f"Imagenes grandes (contenido): {len(big_imgs)}",  len(big_imgs) > 0)


# ══════════════════════════════════════════════════════════════════════════════
# BLOQUE 2 — Extraccion de texto (regresion)
# ══════════════════════════════════════════════════════════════════════════════
print("\n" + "="*60)
print("BLOQUE 2 — Extraccion de texto (regresion)")
print("="*60)

for f in DOCX_FILES:
    print(f"\n  [fichero] {f.name}")
    with zipfile.ZipFile(f) as zf:
        xml_bytes = zf.read("word/document.xml")
    root = etree.fromstring(xml_bytes)
    body = root.find(f"{W}body")
    blocks = []
    for page in body.findall(f"{W}p"):
        blocks.extend(_extract_textboxes(page))
    total_chars = sum(len(txt) for _, txt, _ in blocks)
    check(f"Texto extraido: {len(blocks)} bloques, {total_chars} chars",
          len(blocks) > 0 and total_chars > 0)
    if blocks:
        sample = blocks[0][1][:80].replace("\n", " | ")
        print(f"           Muestra: \"{sample}\"")


# ══════════════════════════════════════════════════════════════════════════════
# BLOQUE 3 — Renombrado secuencial de imagenes
# ══════════════════════════════════════════════════════════════════════════════
print("\n" + "="*60)
print("BLOQUE 3 — Renombrado secuencial de imagenes")
print("="*60)

out3 = OUTPUT_DIR / "seq_naming"
md = convert_docx_to_markdown(SMALL_DOCX, out3)
images_dir = out3 / re.sub(r'[<>:"/\\|?*]', "_", SMALL_DOCX.stem) / "images"
saved_imgs = sorted(images_dir.glob("*.png"))

print(f"\n  [fichero] {SMALL_DOCX.name}")
check("Imagen nombrada con stem del DOCX + _p1",
      any("_p1.png" in p.name for p in saved_imgs),
      f"Ficheros: {[p.name for p in saved_imgs]}")
check("Nombre NO contiene 'image' (nomenclatura antigua)",
      not any(p.name.startswith("image") for p in saved_imgs))
check("Referencia en MD usa nuevo nombre",
      "_p1.png" in (md.read_text(encoding="utf-8")))


# ══════════════════════════════════════════════════════════════════════════════
# BLOQUE 4 — Modos de fondo (bg)
# ══════════════════════════════════════════════════════════════════════════════
print("\n" + "="*60)
print("BLOQUE 4 — Modos de fondo (bg)")
print("="*60)

for bg_mode, expected_suffixes, unexpected_suffixes in [
    ("transparent", ["_p1.png"],    ["_p1_b.png", "_p1_n.png"]),
    ("white",       ["_p1_b.png"],  ["_p1.png",   "_p1_n.png"]),
    ("black",       ["_p1_n.png"],  ["_p1.png",   "_p1_b.png"]),
    ("all",         ["_p1.png", "_p1_b.png", "_p1_n.png"], []),
]:
    out_bg = OUTPUT_DIR / f"bg_{bg_mode}"
    convert_docx_to_markdown(SMALL_DOCX, out_bg, bg=bg_mode)
    safe = re.sub(r'[<>:"/\\|?*]', "_", SMALL_DOCX.stem)
    imgs = {p.name for p in (out_bg / safe / "images").glob("*.png")}

    print(f"\n  [bg={bg_mode}]")
    for suf in expected_suffixes:
        check(f"Genera variante '{suf}'",
              any(suf in n for n in imgs),
              f"Imagenes: {sorted(imgs)}")
    for suf in unexpected_suffixes:
        check(f"NO genera variante '{suf}'",
              not any(suf in n for n in imgs))

# Validate MD reference: transparent preferred
md_all_dir = OUTPUT_DIR / "bg_all" / re.sub(r'[<>:"/\\|?*]', "_", SMALL_DOCX.stem)
for md_path in md_all_dir.glob("*.md"):
    md_text = md_path.read_text(encoding="utf-8")
    check("bg=all: MD referencia PNG transparente (sin sufijo)",
          "_p1.png" in md_text and "_p1_b.png" not in md_text and "_p1_n.png" not in md_text,
          "La version transparente es la que va en el ![[...]]")


# ══════════════════════════════════════════════════════════════════════════════
# BLOQUE 5 — Generacion de PDF (fondo blanco, Pillow)
# ══════════════════════════════════════════════════════════════════════════════
print("\n" + "="*60)
print("BLOQUE 5 — Generacion de PDF (generate_pdf=True)")
print("="*60)

out5 = OUTPUT_DIR / "pdf_basic"
convert_docx_to_markdown(SMALL_DOCX, out5, generate_pdf=True)
safe_stem = re.sub(r'[<>:"/\\|?*]', "_", SMALL_DOCX.stem)
pdf_path = out5 / safe_stem / f"{safe_stem}.pdf"

print(f"\n  [fichero] {SMALL_DOCX.name}")
check("PDF generado en output_dir",
      pdf_path.exists(), f"Esperado: {pdf_path}")

if pdf_path.exists():
    import pdfplumber
    with pdfplumber.open(str(pdf_path)) as pdf:
        n_pages = len(pdf.pages)
    check("PDF tiene 1 pagina (1 imagen de contenido)", n_pages == 1,
          f"Paginas encontradas: {n_pages}")
    check("Fichero PDF tiene tamanyo > 10KB",
          pdf_path.stat().st_size > 10_000,
          f"Tamanyo: {pdf_path.stat().st_size:,} bytes")


# ══════════════════════════════════════════════════════════════════════════════
# BLOQUE 6 — PDF buscable (searchable_pdf=True, TextMode.INVISIBLE)
# ══════════════════════════════════════════════════════════════════════════════
print("\n" + "="*60)
print("BLOQUE 6 — PDF buscable (searchable_pdf=True)")
print("="*60)

out6 = OUTPUT_DIR / "pdf_searchable"
convert_docx_to_markdown(
    SMALL_DOCX, out6, generate_pdf=True, searchable_pdf=True
)
spdf_path = out6 / safe_stem / f"{safe_stem}.pdf"

print(f"\n  [fichero] {SMALL_DOCX.name}")
check("PDF buscable generado", spdf_path.exists(), f"Esperado: {spdf_path}")

if spdf_path.exists():
    check("Fichero PDF buscable tiene tamanyo > 10KB",
          spdf_path.stat().st_size > 10_000,
          f"Tamanyo: {spdf_path.stat().st_size:,} bytes")

    import pdfplumber
    with pdfplumber.open(str(spdf_path)) as pdf:
        extracted = " ".join(
            (p.extract_text() or "") for p in pdf.pages
        )
    extracted_upper = extracted.upper()
    extracted_chars = set(extracted_upper)

    def letters_present(word: str, char_set: set) -> bool:
        return all(c in char_set for c in word.upper() if c.isalpha())

    check("PDF buscable tiene texto embebido (capa de texto no vacia)",
          len(extracted_upper.replace(" ", "").replace("\n", "")) > 10,
          f"Chars extraidos: {len(extracted_upper)}, muestra: {extracted[:100]!r}")
    check("PDF buscable contiene letras de 'CONSUM'",
          letters_present("CONSUM", extracted_chars),
          f"Chars en PDF: {sorted(extracted_chars)[:30]}")
    check("PDF buscable contiene letras de 'ROL'",
          letters_present("ROL", extracted_chars),
          f"Chars en PDF: {sorted(extracted_chars)[:30]}")


# ══════════════════════════════════════════════════════════════════════════════
# BLOQUE 7 — Modos de carpeta de imagenes
# ══════════════════════════════════════════════════════════════════════════════
print("\n" + "="*60)
print("BLOQUE 7 — images_mode variantes")
print("="*60)

# images_mode="flat"
out7_flat = OUTPUT_DIR / "img_flat"
md7flat = convert_docx_to_markdown(SMALL_DOCX, out7_flat, images_mode="flat")
flat_dir = md7flat.parent
flat_pngs = list(flat_dir.glob("*.png"))
check("images_mode='flat': PNGs en misma carpeta que MD",
      len(flat_pngs) > 0,
      f"PNGs: {[p.name for p in flat_pngs]}")
check("images_mode='flat': MD referencia sin prefijo 'images/'",
      "images/" not in md7flat.read_text(encoding="utf-8"))

# images_mode="images_named"
out7_named = OUTPUT_DIR / "img_named"
md7named = convert_docx_to_markdown(SMALL_DOCX, out7_named, images_mode="images_named")
expected_img_dir = md7named.parent / f"images_{safe_stem}"
check("images_mode='images_named': carpeta images_{stem} creada",
      expected_img_dir.exists() and expected_img_dir.is_dir(),
      f"Dir esperado: {expected_img_dir}")
named_pngs = list(expected_img_dir.glob("*.png")) if expected_img_dir.exists() else []
check("images_mode='images_named': PNGs en subcarpeta",
      len(named_pngs) > 0)


# ══════════════════════════════════════════════════════════════════════════════
# BLOQUE 8 — per_document_folder=False
# ══════════════════════════════════════════════════════════════════════════════
print("\n" + "="*60)
print("BLOQUE 8 — per_document_folder=False")
print("="*60)

out8 = OUTPUT_DIR / "no_subfolder"
md8 = convert_docx_to_markdown(SMALL_DOCX, out8, per_document_folder=False)
check("per_document_folder=False: MD en output_dir directamente",
      md8.parent == out8,
      f"MD parent: {md8.parent}, expected: {out8}")
check("per_document_folder=False: images/ en output_dir",
      (out8 / "images").exists())

# Flat + no subfolder
out8b = OUTPUT_DIR / "no_subfolder_flat"
md8b = convert_docx_to_markdown(SMALL_DOCX, out8b,
                                 per_document_folder=False,
                                 images_mode="flat")
check("flat + no_subfolder: MD y PNG en misma carpeta",
      md8b.parent == out8b and len(list(out8b.glob("*.png"))) > 0)


# ══════════════════════════════════════════════════════════════════════════════
# BLOQUE 9 — Batch conversion (5 ficheros, flat, PDF buscable)
# ══════════════════════════════════════════════════════════════════════════════
print("\n" + "="*60)
print("BLOQUE 9 — Batch conversion (flat, searchable PDF)")
print("="*60)

out9 = OUTPUT_DIR / "batch_flat"
mds = convert_batch(
    SAMPLES_DIR, out9,
    bg="transparent",
    generate_pdf=True,
    searchable_pdf=True,
    images_mode="flat",
    per_document_folder=False,
)
check("Batch: 5 ficheros MD generados",
      len(mds) == 5,
      f"MDs: {len(mds)}")
check("Batch: todos en misma carpeta",
      all(m.parent == out9 for m in mds))
pdfs = list(out9.glob("*.pdf"))
check("Batch: 5 PDFs buscables generados",
      len(pdfs) == 5,
      f"PDFs: {[p.name for p in pdfs]}")
pngs = list(out9.glob("*.png"))
check("Batch: PNGs en carpeta raiz (flat)",
      len(pngs) > 0,
      f"PNGs: {len(pngs)} ficheros")


# ══════════════════════════════════════════════════════════════════════════════
# BLOQUE 10 — Conversion completa de los 5 ficheros (regresion + PDF)
# ══════════════════════════════════════════════════════════════════════════════
print("\n" + "="*60)
print("BLOQUE 10 — Conversion completa (regresion + opciones)")
print("="*60)

out10 = OUTPUT_DIR / "all_files"
for f in DOCX_FILES:
    try:
        md = convert_docx_to_markdown(
            f, out10,
            bg="all",
            generate_pdf=True,
            searchable_pdf=True,
        )
        safe = re.sub(r'[<>:"/\\|?*]', "_", f.stem)
        doc_out = out10 / safe
        pages_count = md.read_text(encoding="utf-8").count("## Pagina") + \
                      md.read_text(encoding="utf-8").count("## Página")
        imgs_t = list((doc_out / "images").glob("*_p*.png"))
        imgs_b = list((doc_out / "images").glob("*_p*_b.png"))
        imgs_n = list((doc_out / "images").glob("*_p*_n.png"))
        pdf  = doc_out / f"{safe}.pdf"
        check(
            f"{f.name[:45]:<45} OK ({pages_count} pag, {len(imgs_t)} imgs, PDF={'YES' if pdf.exists() else 'NO'})",
            pdf.exists() and pages_count > 0 and len(imgs_t) > 0
        )
    except Exception as e:
        check(f"{f.name[:45]:<45} ERROR: {e}", False)


# ══════════════════════════════════════════════════════════════════════════════
# RESUMEN
# ══════════════════════════════════════════════════════════════════════════════
print("\n" + "="*60)
passed = sum(1 for _, ok in results if ok)
total  = len(results)
print(f"RESUMEN: {passed}/{total} checks pasados")
print("="*60)

if passed == total:
    print("\nPoC v3 completada con exito.")
    print(f"Output en: {OUTPUT_DIR}")
else:
    failed = [name for name, ok in results if not ok]
    print(f"\n{total - passed} checks fallaron:")
    for name in failed:
        print(f"  - {name}")

sys.exit(0 if passed == total else 1)
