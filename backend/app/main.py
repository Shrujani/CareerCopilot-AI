from fastapi import FastAPI
from app.routes.chat import router as chat_router

app = FastAPI(
    title="CareerPilot AI API",
    version="1.0.0",
    description="Backend API for CareerPilot AI",
)

app.include_router(chat_router)


@app.get("/")
def root():
    return {
        "message": "Welcome to CareerPilot AI Backend"
    }


@app.get("/health")
def health():
    return {
        "status": "healthy"
    }