Use Case Analysis

CareerPilot AI

Version: 1.0

---

1. Introduction

This document identifies all major interactions between users and the CareerPilot AI system. It defines the actors involved, the actions they perform, and how the system responds. These use cases serve as the foundation for system design, API development, database design, and implementation.

---

2. Actors

Primary Actor

User

The user is the primary actor who interacts with the application to receive personalized career guidance.

The user can:

- Register
- Login
- Update profile
- Set career goals
- Upload resume
- Chat with AI
- Receive roadmap
- Complete tasks
- Track progress
- Take mock interviews

---

Secondary Actors

Authentication Service

Responsible for verifying user identity and managing secure login sessions.

---

AI Coordinator Agent

Receives user requests and coordinates communication between specialized AI agents.

---

Career Agent

Analyzes career goals and suggests suitable career paths.

---

Skill Gap Agent

Identifies missing technical and non-technical skills.

---

Learning Roadmap Agent

Generates structured learning plans.

---

Resume Agent

Analyzes resumes and provides improvement suggestions.

---

Interview Agent

Conducts AI-powered mock interviews and evaluates responses.

---

Project Recommendation Agent

Suggests projects aligned with the user's goals.

---

Progress Tracking Agent

Monitors completed tasks and overall learning progress.

---

Database

Stores user profiles, learning progress, roadmaps, conversations, and AI outputs.

---

3. User Use Cases

UC-01 Register Account

Actor:
User

Description:
The user creates a new account.

Expected Outcome:
User account is successfully created.

---

UC-02 Login

Actor:
User

Description:
The user logs into the application.

Expected Outcome:
User accesses their personalized dashboard.

---

UC-03 Complete Profile

Actor:
User

Description:
The user provides education, skills, projects, interests, and experience.

Expected Outcome:
A complete career profile is created.

---

UC-04 Set Career Goal

Actor:
User

Description:
The user selects a target career role and desired companies.

Expected Outcome:
The AI understands the user's objective.

---

UC-05 Skill Analysis

Actor:
Skill Gap Agent

Description:
The system compares the user's profile with industry requirements.

Expected Outcome:
Missing skills are identified.

---

UC-06 Generate Learning Roadmap

Actor:
Learning Roadmap Agent

Description:
The AI creates a personalized study plan.

Expected Outcome:
A weekly and monthly roadmap is generated.

---

UC-07 Upload Resume

Actor:
User

Description:
The user uploads a resume for evaluation.

Expected Outcome:
Resume analysis begins.

---

UC-08 Resume Review

Actor:
Resume Agent

Description:
The AI evaluates the uploaded resume.

Expected Outcome:
Improvement suggestions are generated.

---

UC-09 Project Recommendation

Actor:
Project Recommendation Agent

Description:
The AI recommends projects based on career goals.

Expected Outcome:
A personalized list of projects is displayed.

---

UC-10 AI Career Chat

Actor:
User

Description:
The user asks career-related questions.

Expected Outcome:
The AI provides contextual guidance.

---

UC-11 Mock Interview

Actor:
Interview Agent

Description:
The AI conducts a mock interview.

Expected Outcome:
Interview score and feedback are generated.

---

UC-12 Progress Dashboard

Actor:
Progress Tracking Agent

Description:
The system tracks completed activities and milestones.

Expected Outcome:
Users visualize their progress.

---

4. Business Rules

- Every user must create an account.
- Career goals can be updated at any time.
- AI recommendations must be personalized.
- User data must remain private.
- AI responses should include reasoning whenever possible.
- Progress should update automatically after task completion.

---

5. Future Use Cases

- GitHub Analysis
- LinkedIn Analysis
- Voice Conversation
- Company-Specific Preparation
- Placement Prediction
- Team Study Groups
- Mentor Collaboration
- AI Productivity Coach