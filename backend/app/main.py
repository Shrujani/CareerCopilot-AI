import logging

from fastapi import FastAPI, Request
from fastapi.exceptions import RequestValidationError
from fastapi.responses import JSONResponse
from starlette.exceptions import HTTPException as StarletteHTTPException

from app.routes.chat import router as chat_router
from app.routes.interview import router as interview_router
from app.routes.resume import router as resume_router

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("careerpilot.api")

app = FastAPI(
    title="CareerPilot AI API",
    version="1.0.0",
    description="Backend API for CareerPilot AI",
)

# Register routers
app.include_router(chat_router)
app.include_router(interview_router)
app.include_router(resume_router)


@app.exception_handler(StarletteHTTPException)
async def http_exception_handler(request: Request, exc: StarletteHTTPException):
    return JSONResponse(
        status_code=exc.status_code,
        content={
            "success": False,
            "error": {
                "message": exc.detail if isinstance(exc.detail, str) else "Request failed.",
                "code": exc.status_code,
            },
        },
    )


@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request: Request, exc: RequestValidationError):
    return JSONResponse(
        status_code=422,
        content={
            "success": False,
            "error": {
                "message": "Invalid request.",
                "code": 422,
            },
        },
    )


@app.exception_handler(Exception)
async def unhandled_exception_handler(request: Request, exc: Exception):
    logger.exception("Unhandled API error for %s", request.url.path)
    return JSONResponse(
        status_code=500,
        content={
            "success": False,
            "error": {
                "message": "An unexpected error occurred. Please try again later.",
                "code": 500,
            },
        },
    )


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