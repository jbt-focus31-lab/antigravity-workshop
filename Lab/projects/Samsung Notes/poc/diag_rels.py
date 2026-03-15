"""Analyze MyScript PDF: how is the text layer made invisible?"""
import pdfplumber, zlib, re
from pathlib import Path

pdf_path = Path(r'c:\DATA\Development Projects\antigravity-workshop\Lab\projects\Samsung Notes\samples\myscript_notes_sample.pdf')

# 1. Extract text to confirm it's searchable
with pdfplumber.open(str(pdf_path)) as pdf:
    for i, page in enumerate(pdf.pages[:2]):
        txt = page.extract_text() or ""
        chars = page.objects.get('char', [])
        if chars:
            # Check text rendering mode and color
            sample = chars[:5]
            for c in sample:
                print(f"  char='{c.get('text','?')}' font={c.get('fontname','')} "
                      f"size={c.get('size',0):.1f} "
                      f"non_stroking_color={c.get('non_stroking_color','')} "
                      f"stroking_color={c.get('stroking_color','')}")
        print(f"Page {i+1}: {len(txt)} chars, {len(chars)} char objects")
        print(f"  text[:100]: {txt[:100]!r}")
        print()

# 2. Inspect raw PDF for text rendering mode (Tr operator)
raw = pdf_path.read_bytes()
streams = list(re.finditer(rb'stream\r?\n(.*?)\r?\nendstream', raw, re.DOTALL))
print(f"Total streams: {len(streams)}")

for i, m in enumerate(streams[:10]):
    data = m.group(1)
    try:
        dec = zlib.decompress(data)
    except:
        dec = data
    
    if b'BT' in dec and b'Tj' in dec:
        print(f"\nStream {i+1}: {len(dec)} bytes (has text)")
        # Find text rendering mode (Tr operator)
        for tr_match in re.finditer(rb'(\d+)\s+Tr', dec):
            print(f"  Text render mode: {tr_match.group(1)} (3=invisible)")
        # Find color operators near text
        lines = dec.split(b'\n')
        text_area = False
        for line in lines[:50]:
            stripped = line.strip()
            if b'BT' in stripped:
                text_area = True
            if text_area and any(op in stripped for op in [b'Tr', b'rg', b'RG', b'Tf', b'Tj', b'TJ', b'Td', b'Tm']):
                print(f"  {stripped[:120]}")
            if b'ET' in stripped:
                text_area = False
                break
