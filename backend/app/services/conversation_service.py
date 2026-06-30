class ConversationService:
    def __init__(self):
        self.history = []

    def add_user_message(self, message: str):
        self.history.append({
            "role": "user",
            "text": message,
        })

    def add_ai_message(self, message: str):
        self.history.append({
            "role": "assistant",
            "text": message,
        })

    def build_prompt(self):
        prompt = ""

        for message in self.history:
            role = "User" if message["role"] == "user" else "Assistant"
            prompt += f"{role}: {message['text']}\n"

        return prompt

    def clear(self):
        self.history.clear()