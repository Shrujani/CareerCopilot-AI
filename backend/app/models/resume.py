from pydantic import BaseModel


class ResumeAnalysisResponse(BaseModel):
    ats_score: int
    summary: str
    strengths: list[str]
    weaknesses: list[str]
    missing_skills: list[str]
    improvements: list[str]