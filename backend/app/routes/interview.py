from fastapi import APIRouter, HTTPException

from app.models.interview import (
    InterviewAnswerRequest,
    InterviewAnswerResponse,
    InterviewFinishRequest,
    InterviewFinishResponse,
    InterviewStartRequest,
    InterviewStartResponse,
)
from app.services.interview_service import InterviewService

router = APIRouter(
    prefix="/interview",
    tags=["Mock Interview"],
)

interview_service = InterviewService()


@router.post(
    "/start",
    response_model=InterviewStartResponse,
)
def start_interview(request: InterviewStartRequest):
    try:
        result = interview_service.start_interview(
            role=request.role,
            difficulty=request.difficulty,
        )

        return InterviewStartResponse(**result)

    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=str(e),
        )


@router.post(
    "/answer",
    response_model=InterviewAnswerResponse,
)
def answer_question(request: InterviewAnswerRequest):
    try:
        result = interview_service.answer_question(
            session_id=request.session_id,
            answer=request.answer,
        )

        return InterviewAnswerResponse(**result)

    except ValueError as e:
        raise HTTPException(
            status_code=404,
            detail=str(e),
        )

    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=str(e),
        )


@router.post(
    "/finish",
)
def finish_interview(request: InterviewFinishRequest):
    try:
        result = interview_service.finish_interview(
            session_id=request.session_id,
        )

        return result

    except ValueError as e:
        raise HTTPException(
            status_code=404,
            detail=str(e),
        )

    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=str(e),
        )