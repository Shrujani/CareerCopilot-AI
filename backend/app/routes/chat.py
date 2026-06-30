from fastapi import APIRouter

from app.models.chat import ChatRequest, ChatResponse
from app.services.llm_service import LLMService

router = APIRouter(
    prefix="/chat",
    tags=["Chat"],
)

llm_service = LLMService()


@router.post("", response_model=ChatResponse)
def chat(request: ChatRequest):

    reply = llm_service.generate_reply(request.message)

    return ChatResponse(reply=reply)


@router.delete("/history")
def clear_history():

    llm_service.clear_history()
