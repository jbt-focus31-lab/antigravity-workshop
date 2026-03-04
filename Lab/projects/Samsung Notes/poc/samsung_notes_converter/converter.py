"""
Samsung Notes DOCX → Markdown + Images converter
Version 3 — with invisible searchable text, flexible folder layout

═══════════════════════════════════════════════════════════════════════════════
DEPENDENCIES (pip install):
  - lxml          XML parsing for DOCX internals
  - Pillow        Image manipulation (background compositing, PDF images)
  - fpdf2         Searchable PDF generation with invisible text layer
  - pdfplumber    (test-only) PDF text extraction for validation

MICROSERVICE DEPLOYMENT NOTES:
  When deploying as a Docker-based microservice on Linux:
  1. Install a Unicode-capable TTF font:
       apt-get install -y fonts-dejavu-core
     This places DejaVuSans.ttf at /usr/share/fonts/truetype/dejavu/
     which _resolve_unicode_font() already searches for.
  2. Alternatively, bundle any .ttf (e.g. Roboto, Noto Sans) in the image
     and add its path to the candidates list in _resolve_unicode_font().
  3. The main entry point for the API is convert_docx_to_markdown().
     A batch helper convert_batch() processes a directory of DOCX files.
  4. Suggested API parameters to expose:
       - docx file (upload or Google Drive ID)
       - bg: str = "transparent"
       - generate_pdf: bool = True
       - searchable_pdf: bool = True
       - images_mode: str = "images"
       - per_document_folder: bool = True
═══════════════════════════════════════════════════════════════════════════════

Parameters for convert_docx_to_markdown():
  bg:                  "transparent" | "white" | "black" | "all"
                       Controls image background variants.
  generate_pdf:        bool — assemble images (white bg) into a multi-page PDF
  searchable_pdf:      bool — (requires generate_pdf=True) add invisible text
                       layer at exact coordinates from the DOCX
  images_mode:         "images"       → images in output_dir/images/
                       "images_named" → images in output_dir/images_{docx_stem}/
                       "flat"         → images in output_dir/ (same as MD)
  per_document_folder: bool — if True, output goes into output_dir/{stem}/

Image naming:
  {docx_stem}_p{N}.png          transparent base
  {docx_stem}_p{N}_b.png        white background
  {docx_stem}_p{N}_n.png        black background
  N is 1-based sequential amongst CONTENT images (> IMAGE_SIZE_THRESHOLD)
"""

import zipfile
import re
import io
from pathlib import Path
from datetime import date
from lxml import etree
from PIL import Image


# ── Namespaces ────────────────────────────────────────────────────────────────
W   = "{http://schemas.openxmlformats.org/wordprocessingml/2006/main}"
WP  = "{http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing}"
A   = "{http://schemas.openxmlformats.org/drawingml/2006/main}"
PIC = "{http://schemas.openxmlformats.org/drawingml/2006/picture}"
V   = "{urn:schemas-microsoft-com:vml}"
R   = "{http://schemas.openxmlformats.org/officeDocument/2006/relationships}"

# Content image threshold: decorative images in Samsung Notes DOCX are ~16 KB
IMAGE_SIZE_THRESHOLD = 50_000

# PDF page size (Samsung Notes always exports A4 portrait in points)
PAGE_W_PT = 595.0
PAGE_H_PT = 842.0


# ── Internal helpers ──────────────────────────────────────────────────────────

def _parse_css_pt(style: str, prop: str) -> float:
    """Parse a CSS property value in pt from a style string."""
    m = re.search(rf"{prop}:([\d.]+)pt", style)
    return float(m.group(1)) if m else 0.0


def _extract_rels(zip_file: zipfile.ZipFile) -> dict[str, str]:
    """Returns {rId: image_filename} for all media entries."""
    rels_xml = zip_file.read("word/_rels/document.xml.rels")
    root = etree.fromstring(rels_xml)
    return {
        r.get("Id"): r.get("Target", "").replace("media/", "")
        for r in root
        if "image" in (r.get("Type") or "")
    }


def _get_image_sizes(zip_file: zipfile.ZipFile) -> dict[str, int]:
    """Returns {image_filename: size_bytes} for files in word/media/."""
    return {
        n.replace("word/media/", ""): zip_file.getinfo(n).file_size
        for n in zip_file.namelist()
        if n.startswith("word/media/")
    }


def _extract_page_image_rid(page_elem, rid_to_size: dict) -> str | None:
    """Pick the largest image rId from a DOCX <w:p> element, or None."""
    rids = [
        blip.get(f"{R}embed")
        for blip in page_elem.iter(f"{A}blip")
        if blip.get(f"{R}embed")
    ]
    if not rids:
        return None
    best = max(rids, key=lambda r: rid_to_size.get(r, 0))
    return best if rid_to_size.get(best, 0) >= IMAGE_SIZE_THRESHOLD else None


def _extract_textboxes(page_elem) -> list[tuple[float, str, str | None]]:
    """
    Returns list of (y_pt, text, color_hex_or_None) for every text line
    in every textbox of a page, sorted top-to-bottom by y position.

    Each textbox (v:shape) has a vertical range [margin-top → height] in pt.
    Multiple text lines within the same textbox are distributed evenly
    across that range so each line gets its own unique Y coordinate.
    """
    blocks: list[tuple[float, str, str | None]] = []

    for shape in page_elem.iter(f"{V}shape"):
        style = shape.get("style", "")
        margin_top = _parse_css_pt(style, "margin-top")
        box_height = _parse_css_pt(style, "height")

        # Collect all non-empty text lines and their colour from this shape
        lines: list[tuple[str, str | None]] = []
        for txbx in shape.iter(f"{W}txbxContent"):
            for para in txbx.iter(f"{W}p"):
                color = None
                rPr = para.find(f".//{W}rPr")
                if rPr is not None:
                    c = rPr.find(f"{W}color")
                    if c is not None:
                        color = c.get(f"{W}val")
                text = "".join(
                    t.text or "" for t in para.iter(f"{W}t")
                )
                if text.strip():
                    lines.append((text, color))

        if not lines:
            continue

        # Distribute lines evenly within [margin_top → box_height]
        span = max(box_height - margin_top, 10.0)  # at least 10pt
        line_step = span / max(len(lines), 1)

        for i, (text, color) in enumerate(lines):
            y_pt = margin_top + i * line_step
            blocks.append((y_pt, text, color))

    blocks.sort(key=lambda x: x[0])
    return blocks


# ── Image processing helpers ──────────────────────────────────────────────────

def _compose_on_background(
    img_bytes: bytes, bg_color: tuple[int, int, int]
) -> Image.Image:
    """Composite an RGBA PNG onto a solid background colour."""
    img = Image.open(io.BytesIO(img_bytes)).convert("RGBA")
    bg = Image.new("RGBA", img.size, (*bg_color, 255))
    composed = Image.alpha_composite(bg, img)
    return composed.convert("RGB")  # PDF/JPEG-compatible


def _save_variants(
    img_bytes: bytes, base_path: Path, bg: str
) -> list[tuple[str, Path]]:
    """
    Save one or more background variants of an image. Returns list
    of (label, saved_path) tuples.

    Labels: "transparent", "white", "black".
    """
    saved: list[tuple[str, Path]] = []
    _t_path = lambda: base_path
    _white_path = lambda: base_path.with_name(base_path.stem + "_b.png")
    _black_path = lambda: base_path.with_name(base_path.stem + "_n.png")

    if bg in ("transparent", "all"):
        p = _t_path()
        p.write_bytes(img_bytes)
        saved.append(("transparent", p))

    if bg in ("white", "all"):
        img = _compose_on_background(img_bytes, (255, 255, 255))
        p = _white_path()
        img.save(str(p))
        saved.append(("white", p))

    if bg in ("black", "all"):
        img = _compose_on_background(img_bytes, (0, 0, 0))
        p = _black_path()
        img.save(str(p))
        saved.append(("black", p))

    return saved


# ── Unicode font resolution ─────────────────────────────────────────────────
# MICROSERVICE NOTE: On Linux/Docker, ensure a TTF font is installed.
# The easiest option: apt-get install -y fonts-dejavu-core
# This places DejaVuSans.ttf at the path searched below.

def _resolve_unicode_font() -> Path | None:
    """
    Find a Unicode-capable TTF font for the searchable PDF text layer.
    Tries common system locations (Windows / macOS / Linux) in order.
    Returns None if none found (text layer falls back to ASCII sanitisation).
    """
    candidates = [
        # Windows
        Path("C:/Windows/Fonts/arial.ttf"),
        Path("C:/Windows/Fonts/calibri.ttf"),
        Path("C:/Windows/Fonts/segoeui.ttf"),
        # macOS
        Path("/Library/Fonts/Arial.ttf"),
        Path("/System/Library/Fonts/Supplemental/Arial.ttf"),
        # Linux (common distros / Docker)
        Path("/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"),
        Path("/usr/share/fonts/truetype/liberation/LiberationSans-Regular.ttf"),
        Path("/usr/share/fonts/truetype/noto/NotoSans-Regular.ttf"),
    ]
    for p in candidates:
        if p.exists():
            return p
    return None


def _sanitize_for_latin1(text: str) -> str:
    """Replace common Unicode symbols with ASCII equivalents for Latin-1 fallback."""
    replacements = {
        "\u2192": "->", "\u21b3": "->", "\u2190": "<-", "\u2191": "^", "\u2193": "v",
        "\u2019": "'", "\u201c": '"', "\u201d": '"',
        "\u2026": "...", "\u2013": "-", "\u2014": "-",
    }
    for src, dst in replacements.items():
        text = text.replace(src, dst)
    return text.encode("latin-1", errors="replace").decode("latin-1")


# ── PDF generation ────────────────────────────────────────────────────────────

def _build_pdf_pillow(white_images: list[Image.Image], pdf_path: Path):
    """Build a simple multi-page PDF from a list of white-background images."""
    imgs = [img.convert("RGB") for img in white_images]
    imgs[0].save(
        str(pdf_path),
        format="PDF",
        save_all=True,
        append_images=imgs[1:],
        resolution=150,
    )


def _build_searchable_pdf(
    white_images: list[Image.Image],
    text_pages: list[list[tuple[float, str, str | None]]],
    pdf_path: Path,
):
    """
    Build a searchable PDF using fpdf2.

    Each page:
      1. Handwriting image drawn as full-page background (A4, white bg)
      2. INVISIBLE text placed at exact DOCX coordinates using
         TextMode.INVISIBLE (PDF render mode 3) — same approach as
         MyScript Notes and iLovePDF OCR.

    The text is NOT visible but is fully present in the PDF text stream,
    making the file searchable (Ctrl+F in any viewer, pdfplumber, etc.).

    Coordinate conversion:
      DOCX uses top-left origin in pt (1pt = 1/72 inch).
      fpdf2 uses top-left origin in mm (1pt = 0.352778mm).
    """
    from fpdf import FPDF
    from fpdf.enums import TextMode

    PT_TO_MM = 0.352778
    PAGE_W_MM = PAGE_W_PT * PT_TO_MM
    PAGE_H_MM = PAGE_H_PT * PT_TO_MM
    FONT_SIZE_PT = 10
    FONT_SIZE_MM = FONT_SIZE_PT * PT_TO_MM

    # Resolve Unicode font once (shared across all pages)
    unicode_font_path = _resolve_unicode_font()
    use_unicode = unicode_font_path is not None
    FONT_ALIAS = "UniFont"

    pdf = FPDF(orientation="P", unit="mm", format=(PAGE_W_MM, PAGE_H_MM))
    pdf.set_auto_page_break(False)

    if use_unicode:
        pdf.add_font(FONT_ALIAS, fname=str(unicode_font_path))

    for img, text_blocks in zip(white_images, text_pages):
        pdf.add_page()

        # ── Background: handwriting image, full-page ───────────────────────
        buf = io.BytesIO()
        img.convert("RGB").save(buf, format="PNG")
        buf.seek(0)
        pdf.image(buf, x=0, y=0, w=PAGE_W_MM, h=PAGE_H_MM)

        # ── Invisible text layer (render mode 3 = invisible) ──────────────
        # Same approach as MyScript Notes PDF exports.
        # Text is fully present in the PDF content stream → searchable,
        # selectable, indexable — but completely invisible to the eye.
        if use_unicode:
            pdf.set_font(FONT_ALIAS, size=FONT_SIZE_PT)
        else:
            pdf.set_font("Helvetica", size=FONT_SIZE_PT)
        pdf.text_mode = TextMode.INVISIBLE

        for y_pt, text, _color in text_blocks:
            y_mm = y_pt * PT_TO_MM
            if y_mm + FONT_SIZE_MM > PAGE_H_MM:
                continue
            safe_line = text if use_unicode else _sanitize_for_latin1(text)
            pdf.text(x=0, y=y_mm + FONT_SIZE_MM, txt=safe_line)

    pdf.output(str(pdf_path))


# ── Main conversion function ──────────────────────────────────────────────────
# MICROSERVICE NOTE: This is the primary entry point. Each call processes a
# single DOCX file. For batch processing, use convert_batch() below.

def convert_docx_to_markdown(
    docx_path: str | Path,
    output_dir: str | Path,
    note_title: str | None = None,
    note_date: str | None = None,
    tags: list[str] | None = None,
    bg: str = "transparent",
    generate_pdf: bool = False,
    searchable_pdf: bool = False,
    images_mode: str = "images",
    per_document_folder: bool = True,
) -> Path:
    """
    Convert a Samsung Notes DOCX export to Markdown + images.

    Args:
        docx_path:           Path to the .docx file.
        output_dir:          Root output directory.
        note_title:          Note title (default: file stem).
        note_date:           Date string YYYY-MM-DD (default: today).
        tags:                List of Obsidian tags for frontmatter.
        bg:                  Image background mode:
                               "transparent" — PNG as exported (default)
                               "white"       — composed on white bg (suffix _b)
                               "black"       — composed on black bg (suffix _n)
                               "all"         — generate all three variants
        generate_pdf:        If True, assemble a multi-page PDF (white bg).
        searchable_pdf:      If True (and generate_pdf=True), add invisible
                             text layer using TextMode.INVISIBLE (render mode 3).
        images_mode:         Where to store image files:
                               "images"       — in output_dir/images/
                               "images_named" — in output_dir/images_{stem}/
                               "flat"         — same directory as the .md file
        per_document_folder: If True, all output goes into a subdirectory
                             named after the DOCX stem. If False, output
                             goes directly into output_dir.

    Returns:
        Path to the generated .md file.
    """
    if bg not in ("transparent", "white", "black", "all"):
        raise ValueError(f"bg must be transparent|white|black|all, got: {bg!r}")
    if images_mode not in ("images", "images_named", "flat"):
        raise ValueError(f"images_mode must be images|images_named|flat, got: {images_mode!r}")

    docx_path  = Path(docx_path)
    output_dir = Path(output_dir)

    stem      = docx_path.stem
    safe_stem = re.sub(r'[<>:"/\\|?*]', "_", stem)
    title     = note_title or stem
    note_date = note_date  or str(date.today())
    tags      = tags       or ["meeting", "handwritten"]

    # ── Resolve output directories ────────────────────────────────────────
    if per_document_folder:
        doc_dir = output_dir / safe_stem
    else:
        doc_dir = output_dir
    doc_dir.mkdir(parents=True, exist_ok=True)

    # Images subdirectory
    if images_mode == "flat":
        images_dir = doc_dir
    elif images_mode == "images_named":
        images_dir = doc_dir / f"images_{safe_stem}"
    else:  # "images"
        images_dir = doc_dir / "images"
    images_dir.mkdir(parents=True, exist_ok=True)

    # Relative prefix for MD ![[...]] links
    if images_dir == doc_dir:
        img_md_prefix = ""
    else:
        img_md_prefix = f"{images_dir.name}/"

    # ── Extract from DOCX ─────────────────────────────────────────────────
    with zipfile.ZipFile(docx_path) as zf:
        rels      = _extract_rels(zf)
        img_sizes = _get_image_sizes(zf)
        xml_bytes = zf.read("word/document.xml")

        root = etree.fromstring(xml_bytes)
        body = root.find(f"{W}body")

        rid_to_size = {rid: img_sizes.get(fname, 0) for rid, fname in rels.items()}

        content_image_bytes: dict[str, bytes] = {}
        content_rids_ordered: list[str] = []

        for page_elem in body.findall(f"{W}p"):
            rid = _extract_page_image_rid(page_elem, rid_to_size)
            if rid and rid not in content_image_bytes:
                fname = rels.get(rid, "")
                if fname:
                    content_image_bytes[rid] = zf.read(f"word/media/{fname}")
                    content_rids_ordered.append(rid)

    # ── Sequential naming: {safe_stem}_p1.png, _p2.png, … ────────────────
    rid_to_basename: dict[str, str] = {}
    for seq, rid in enumerate(content_rids_ordered, start=1):
        rid_to_basename[rid] = f"{safe_stem}_p{seq}"

    # ── Save image variants ───────────────────────────────────────────────
    rid_to_md_ref: dict[str, str] = {}
    white_images_ordered: list[Image.Image] = []

    for rid in content_rids_ordered:
        base      = rid_to_basename[rid]
        base_path = images_dir / f"{base}.png"
        img_bytes = content_image_bytes[rid]

        saved = _save_variants(img_bytes, base_path, bg)

        # Markdown reference: prefer transparent, fall back to white
        variants = {label: p for label, p in saved}
        if "transparent" in variants:
            ref_path = variants["transparent"]
        elif "white" in variants:
            ref_path = variants["white"]
        else:
            ref_path = saved[0][1]
        rid_to_md_ref[rid] = ref_path.name

        # White-bg image for PDF
        if generate_pdf or searchable_pdf:
            if "white" in variants:
                white_images_ordered.append(Image.open(str(variants["white"])).convert("RGB"))
            else:
                white_images_ordered.append(
                    _compose_on_background(img_bytes, (255, 255, 255))
                )

    # ── Process pages (text extraction) ───────────────────────────────────
    with zipfile.ZipFile(docx_path) as zf:
        xml_bytes = zf.read("word/document.xml")
    root = etree.fromstring(xml_bytes)
    body = root.find(f"{W}body")

    pages: list[dict] = []
    for page_elem in body.findall(f"{W}p"):
        rid         = _extract_page_image_rid(page_elem, rid_to_size)
        text_blocks = _extract_textboxes(page_elem)
        if rid or text_blocks:
            pages.append({"image_rid": rid, "text_blocks": text_blocks})

    # ── Generate PDF ──────────────────────────────────────────────────────
    if generate_pdf and white_images_ordered:
        pdf_path = doc_dir / f"{safe_stem}.pdf"

        # Samsung Notes DOCX structure: text boxes and the full-size handwriting
        # image are on SEPARATE DOCX pages. The text-only page always precedes
        # the image-only page. We accumulate text blocks from non-image pages
        # and attach them to the NEXT content image page.
        text_pages_for_pdf: list[list[tuple]] = []
        pending_text: list[tuple] = []
        for page in pages:
            if page["image_rid"]:
                text_pages_for_pdf.append(list(pending_text))
                pending_text = []
            else:
                pending_text.extend(
                    (mt, txt, col) for mt, txt, col in page["text_blocks"]
                )

        if searchable_pdf:
            _build_searchable_pdf(white_images_ordered, text_pages_for_pdf, pdf_path)
        else:
            _build_pdf_pillow(white_images_ordered, pdf_path)

    # ── Generate Markdown ─────────────────────────────────────────────────
    md_lines = [
        "---",
        f'title: "{title}"',
        f"date: {note_date}",
        f"tags: [{', '.join(tags)}]",
        "entity_type: meeting",
        "source: samsung_notes",
        "---",
        "",
        f"# {title}",
        "",
    ]

    for i, page in enumerate(pages, start=1):
        md_lines.append(f"## Página {i}")
        md_lines.append("")

        rid = page["image_rid"]
        if rid and rid in rid_to_md_ref:
            md_lines.append(f"![[{img_md_prefix}{rid_to_md_ref[rid]}]]")
            md_lines.append("")

        for _mt, text, _col in page["text_blocks"]:
            for line in text.splitlines():
                if line.strip():
                    md_lines.append(line)
            md_lines.append("")

        md_lines.append("---")
        md_lines.append("")

    md_path = doc_dir / f"{safe_stem}.md"
    md_path.write_text("\n".join(md_lines), encoding="utf-8")
    return md_path


# ── Batch conversion helper ──────────────────────────────────────────────────
# MICROSERVICE NOTE: For an API that receives a single file, call
# convert_docx_to_markdown() directly. This helper is for CLI / bulk usage.

def convert_batch(
    docx_dir: str | Path,
    output_dir: str | Path,
    pattern: str = "*.docx",
    **kwargs,
) -> list[Path]:
    """
    Convert all DOCX files in a directory.

    Args:
        docx_dir:   Directory containing .docx files.
        output_dir: Root output directory.
        pattern:    Glob pattern for file selection (default: "*.docx").
        **kwargs:   Forwarded to convert_docx_to_markdown() — bg,
                    generate_pdf, searchable_pdf, images_mode,
                    per_document_folder, etc.

    Returns:
        List of Paths to generated .md files.
    """
    docx_dir   = Path(docx_dir)
    output_dir = Path(output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)

    results = []
    for docx_file in sorted(docx_dir.glob(pattern)):
        md_path = convert_docx_to_markdown(docx_file, output_dir, **kwargs)
        results.append(md_path)
    return results
"""
# ── CLI usage example ─────────────────────────────────────────────────────────
# python converter.py samples/docx output_v3 --bg transparent --searchable
#
# For a microservice, wrap convert_docx_to_markdown() in a FastAPI endpoint:
#   @app.post("/convert")
#   async def convert(file: UploadFile, bg: str = "transparent", ...):
#       with tempfile.NamedTemporaryFile(suffix=".docx") as tmp:
#           tmp.write(await file.read())
#           md_path = convert_docx_to_markdown(tmp.name, output_dir, ...)
#       return FileResponse(md_path)
"""
