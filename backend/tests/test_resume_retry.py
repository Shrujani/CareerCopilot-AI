import json
from unittest.mock import MagicMock, patch

from app.services.llm_service import LLMService


class DummyResponse:
    def __init__(self, text):
        self.text = text


def test_analyze_resume_retries_on_transient_gemini_error():
    service = LLMService.__new__(LLMService)
    service.client = MagicMock()
    service.conversation = MagicMock()

    service.client.models.generate_content.side_effect = [
        Exception("503 Service Unavailable"),
        Exception("503 Service Unavailable"),
        DummyResponse('{"ats_score": 80, "summary": "ok", "strengths": [], "weaknesses": [], "missing_skills": [], "improvements": []}'),
    ]

    with patch("app.services.llm_service.time.sleep", return_value=None):
        result = service.analyze_resume("resume text")

    assert result["ats_score"] == 80
    assert service.client.models.generate_content.call_count == 3
