import json
import logging
import os
import time

from dotenv import load_dotenv
from google import genai

from app.services.conversation_service import ConversationService

load_dotenv()

logger = logging.getLogger("careerpilot.llm")


class LLMService:
    def __init__(self):
        api_key = os.getenv("GEMINI_API_KEY")

        if not api_key:
            raise ValueError("GEMINI_API_KEY not found.")

        self.client = genai.Client(api_key=api_key)
        self.conversation = ConversationService()

    # ---------------------------------------------------
    # AI Mentor Chat
    # ---------------------------------------------------

    def generate_reply(self, message: str) -> str:

        self.conversation.add_user_message(message)

        history = self.conversation.build_prompt()

        prompt = f"""
You are CareerPilot AI.

You are an expert career mentor.

Help users with:

- Resume building
- Software engineering
- DSA
- Interview preparation
- Placements
- Career guidance
- Motivation

Remember previous conversation.

Conversation:

{history}

Assistant:
"""

        response = self.client.models.generate_content(
            model="gemini-2.5-flash",
            contents=prompt,
        )

        reply = response.text

        self.conversation.add_ai_message(reply)

        return reply

    @staticmethod
    def _is_transient_error(exc: Exception) -> bool:
        status_code = getattr(exc, "status_code", None)
        if status_code == 503:
            return True

        message = str(exc).lower()
        return any(
            marker in message
            for marker in ("503", "service unavailable", "temporarily unavailable", "rate limit")
        )

    # ---------------------------------------------------
    # Resume Analyzer
    # ---------------------------------------------------

    def analyze_resume(self, resume_text: str):

        prompt = f"""
You are an ATS Resume Analyzer.

Analyze the resume below.

Return ONLY JSON.

The JSON format MUST be:

{{
    "ats_score": 0,
    "summary":"",
    "strengths":[],
    "weaknesses":[],
    "missing_skills":[],
    "improvements":[]
}}

Resume:

{resume_text}
"""

        last_error = None

        for attempt in range(1, 4):
            try:
                response = self.client.models.generate_content(
                    model="gemini-2.5-flash",
                    contents=prompt,
                )

                text = response.text.strip()

                if text.startswith("```"):
                    text = text.replace("```json", "").replace("```", "").strip()

                parsed = json.loads(text)

                if not isinstance(parsed, dict):
                    raise ValueError("Gemini returned invalid resume analysis data.")

                return parsed
            except Exception as exc:
                last_error = exc

                if attempt < 3 and self._is_transient_error(exc):
                    wait_time = 2 ** (attempt - 1)
                    logger.warning(
                        "Gemini resume analysis attempt %s/3 failed with a transient error. Retrying in %ss.",
                        attempt,
                        wait_time,
                    )
                    time.sleep(wait_time)
                    continue

                logger.exception("Gemini resume analysis failed after %s attempt(s)", attempt)
                break

        raise RuntimeError("We couldn't analyze your resume right now. Please try again in a moment.") from last_error

    # ---------------------------------------------------
    # Future Features
    # ---------------------------------------------------

    def generate_roadmap(self, prompt: str):
        pass

    def generate_cover_letter(self, prompt: str):
        pass

    def generate_interview_questions(self, prompt: str):
        pass

    def evaluate_interview(self, prompt: str):
        pass

    def analyze_job_match(self, prompt: str):
        pass

    def skill_gap_analysis(self, prompt: str):
        pass

    def clear_history(self):
        self.conversation.clear()