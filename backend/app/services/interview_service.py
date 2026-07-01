import uuid

from app.services.llm_service import LLMService


class InterviewService:

    def __init__(self):
        self.llm = LLMService()

        # Temporary in-memory storage
        self.sessions = {}

    def start_interview(self, role: str, difficulty: str):

        session_id = str(uuid.uuid4())

        prompt = f"""
You are an experienced technical interviewer.

Start a mock interview.

Role:
{role}

Difficulty:
{difficulty}

Rules:
- Ask only ONE interview question.
- Do not provide explanations.
- Do not provide answers.
- Wait for the candidate's response.
"""

        first_question = self.llm.generate_reply(prompt)

        self.sessions[session_id] = {
            "role": role,
            "difficulty": difficulty,
            "history": [
                {
                    "question": first_question,
                    "answer": "",
                }
            ],
        }

        return {
            "session_id": session_id,
            "first_question": first_question,
        }

    def answer_question(self, session_id: str, answer: str):

        session = self.sessions.get(session_id)

        if session is None:
            raise ValueError("Interview session not found.")

        session["history"][-1]["answer"] = answer

        history = ""

        for item in session["history"]:
            history += f"""
Question:
{item['question']}

Answer:
{item['answer']}

"""

        prompt = f"""
You are conducting a technical interview.

Role:
{session['role']}

Difficulty:
{session['difficulty']}

Previous conversation:

{history}

Rules:

- Ask ONLY the next interview question.
- Do not evaluate yet.
- Do not give hints.
- Do not answer your own question.
- Ask one question only.
"""

        next_question = self.llm.generate_reply(prompt)

        session["history"].append({
            "question": next_question,
            "answer": "",
        })

        finished = len(session["history"]) > 5

        return {
            "next_question": next_question,
            "interview_finished": finished,
        }

    def finish_interview(self, session_id: str):

        session = self.sessions.get(session_id)

        if session is None:
            raise ValueError("Interview session not found.")

        history = ""

        for item in session["history"]:
            history += f"""
Question:
{item['question']}

Answer:
{item['answer']}

"""

        prompt = f"""
You are an interview evaluator.

Candidate Role:
{session['role']}

Interview Transcript:

{history}

Evaluate the interview.

Return ONLY valid JSON.

Format:

{{
    "technical_score":85,
    "communication_score":80,
    "confidence_score":78,
    "overall_score":81,
    "strengths":[
        "...",
        "...",
        "..."
    ],
    "weaknesses":[
        "...",
        "...",
        "..."
    ],
    "recommendations":[
        "...",
        "...",
        "..."
    ],
    "feedback":"..."
}}
"""

        report = self.llm.generate_reply(prompt)

        return report