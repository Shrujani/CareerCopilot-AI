import logging
import os
import uuid

from fastapi import APIRouter, File, HTTPException, UploadFile

from app.models.resume import ResumeAnalysisResponse
from app.services.llm_service import LLMService
from app.services.resume_service import ResumeService

logger = logging.getLogger("careerpilot.resume_route")

router = APIRouter(
    prefix="/resume",
    tags=["Resume"],
)

llm_service = LLMService()
resume_service = ResumeService()


@router.post("/analyze", response_model=ResumeAnalysisResponse)
async def analyze_resume(file: UploadFile = File(...)):
    if not file.filename or not file.filename.lower().endswith(".pdf"):
        raise HTTPException(status_code=400, detail="Only PDF files are allowed.")

    os.makedirs("uploads", exist_ok=True)

    file_id = str(uuid.uuid4())
    file_path = f"uploads/{file_id}.pdf"

    try:
        content = await file.read()

        with open(file_path, "wb") as f:
            f.write(content)

        resume_text = resume_service.extract_text(file_path)
        if not resume_text.strip():
            raise HTTPException(
                status_code=400,
                detail="We couldn't extract text from the uploaded resume. Please try a different PDF.",
            )

        return llm_service.analyze_resume(resume_text)
    except HTTPException:
        raise
    except Exception as exc:
        logger.exception("Resume analysis failed for file_id=%s", file_id)
        raise HTTPException(
            status_code=502,
            detail="We couldn't analyze your resume right now. Please try again in a moment.",
        ) from exc
    finally:
        if os.path.exists(file_path):
            os.remove(file_path)