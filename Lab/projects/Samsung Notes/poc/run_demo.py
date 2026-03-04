import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent / 'samsung_notes_converter'))
from converter import convert_batch

convert_batch(
    docx_dir=r'c:\DATA\Development Projects\antigravity-workshop\Lab\projects\Samsung Notes\samples\docx',
    output_dir=r'c:\DATA\Development Projects\antigravity-workshop\Lab\projects\Samsung Notes\poc\output_demo_final',
    bg='transparent',
    generate_pdf=True,
    searchable_pdf=True,
    images_mode='flat',
    per_document_folder=False,
)
print("Demo batch completado.")
