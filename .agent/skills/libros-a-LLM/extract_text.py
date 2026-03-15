
import sys
from pypdf import PdfReader

def extract_text(pdf_path, output_path):
    try:
        reader = PdfReader(pdf_path)
        with open(output_path, 'w', encoding='utf-8') as f:
            for page in reader.pages:
                text = page.extract_text()
                if text:
                    f.write(text + "\n\n")
        print(f"Successfully extracted text to {output_path}")
    except Exception as e:
        print(f"Error extracting text: {e}")

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python3 extract_text.py <pdf_path> <output_path>")
        sys.exit(1)
    
    pdf_path = sys.argv[1]
    output_path = sys.argv[2]
    extract_text(pdf_path, output_path)
