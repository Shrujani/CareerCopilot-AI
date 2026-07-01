import fitz


class ResumeService:
    @staticmethod
    def extract_text(pdf_path: str) -> str:
        """Extract text from a PDF file and return it as a single string."""
        document = fitz.open(pdf_path)

        try:
            pages = [page.get_text() for page in document]
        finally:
            document.close()

        return "".join(pages).strip()