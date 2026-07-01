from pydantic import BaseModel


class InterviewStartRequest(BaseModel):
    role: str
    difficulty: str


class InterviewStartResponse(BaseModel):
    session_id: str
    first_question: str


class InterviewAnswerRequest(BaseModel):
    session_id: str
    answer: str


class InterviewAnswerResponse(BaseModel):
    next_question: str
    interview_finished: bool


class InterviewFinishRequest(BaseModel):
    session_id: str


class InterviewFinishResponse(BaseModel):
    technical_score: int
    communication_score: int
    confidence_score: int
    overall_score: int

    strengths: list[str]
    weaknesses: list[str]
    recommendations: list[str]

    feedback: str