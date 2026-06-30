class LLMService:

    @staticmethod
    def generate_reply(message: str) -> str:
        return (
            f"You said: '{message}'. "
            "This is a mock AI response. "
            "Later this will come from Gemini."
        )