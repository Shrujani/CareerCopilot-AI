import os

from dotenv import load_dotenv
from google import genai

from app.services.conversation_service import ConversationService

load_dotenv()


class LLMService:
    def __init__(self):
        api_key = os.getenv("GEMINI_API_KEY")

        if not api_key:
            raise ValueError("GEMINI_API_KEY not found.")

        self.client = genai.Client(api_key=api_key)
        self.conversation = ConversationService()

    def generate_reply(self, message: str) -> str:

        # Save user message
        self.conversation.add_user_message(message)

        history = self.conversation.build_prompt()

        prompt = f"""
You are CareerPilot AI.

You are a professional career mentor.

Help users with:
- Career guidance
- Resume improvement
- Interview preparation
- DSA roadmap
- Software engineering
- College placements
- Motivation

Always remember the previous conversation.

Conversation so far:

{history}

Assistant:
"""

        try:
            response = self.client.models.generate_content(
                model="gemini-2.5-flash",
                contents=prompt,
            )

            reply = response.text

            # Save AI response
            self.conversation.add_ai_message(reply)

            return reply

        except Exception as e:
            return f"Gemini Error: {e}"

    def clear_history(self):
        self.conversation.clear()