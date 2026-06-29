# System Architecture

## Project Name

CareerPilot AI – An Agentic AI Career Mentor

Version: 1.0

---

# 1. Introduction

This document describes the overall architecture of CareerPilot AI. It explains the major software components, their responsibilities, and how they interact to provide personalized AI-powered career guidance.

The architecture is designed to be modular, scalable, maintainable, and easy to extend with additional AI agents and features in future versions.

---

# 2. High-Level Architecture

The system consists of five major layers:

1. Presentation Layer
2. Backend Layer
3. AI Layer
4. Data Layer
5. External Services

Each layer has a specific responsibility and communicates with the other layers through well-defined interfaces.

---

# 3. Presentation Layer

Technology:
- Flutter

Responsibilities:

- User Registration
- Login
- Dashboard
- Career Goal Setup
- AI Chat Interface
- Resume Upload
- Learning Roadmap
- Progress Dashboard
- Settings

The frontend is responsible only for displaying information and collecting user input. It does not contain business logic or AI decision-making.

---

# 4. Backend Layer

Technology:
- FastAPI

Responsibilities:

- Authentication
- API Management
- User Management
- Database Operations
- AI Request Handling
- Business Logic
- Response Processing

The backend acts as the central communication layer between the frontend, database, and AI services.

---

# 5. AI Layer

The AI Layer is responsible for generating intelligent and personalized career guidance.

Instead of using a single AI model, CareerPilot AI follows an Agentic AI architecture consisting of multiple specialized AI agents coordinated by a central AI Coordinator.

## AI Coordinator

The AI Coordinator receives user requests and determines which specialized AI agents should process the request.

It combines the outputs from multiple agents into one personalized response.

## Specialized AI Agents

- Career Agent
- Skill Gap Agent
- Learning Roadmap Agent
- Resume Analysis Agent
- Project Recommendation Agent
- Interview Agent
- Progress Tracking Agent

Each agent is responsible for a specific domain and collaborates with the AI Coordinator.

---

# 6. Data Layer

Technology:
- PostgreSQL

Responsibilities:

- User Information
- Career Goals
- Skills
- Learning Progress
- Resume Data
- AI Conversations
- Roadmaps
- Interview Results

The database stores all persistent application data.

---

# 7. External Services

The system communicates with external services including:

- Firebase Authentication
- Large Language Model (LLM)
- Vector Database (Future)
- GitHub API (Future)
- LinkedIn API (Future)

These services extend the capabilities of the application.

---

# 8. Data Flow

The overall workflow of the application is as follows:

1. The user interacts with the Flutter application.
2. The frontend sends API requests to the FastAPI backend.
3. The backend authenticates the user.
4. The backend processes the request.
5. If AI processing is required, the request is forwarded to the AI Coordinator.
6. The AI Coordinator delegates tasks to one or more specialized AI agents.
7. The agents generate their outputs.
8. The AI Coordinator combines the outputs into a final response.
9. The backend stores relevant information in the database.
10. The final response is returned to the frontend and displayed to the user.

---

# 9. Architectural Principles

The system is designed following the following principles:

- Modular Architecture
- Separation of Concerns
- Scalability
- Maintainability
- Reusability
- Security
- Extensibility

These principles ensure that new features and AI agents can be added with minimal impact on existing components.

---

# 10. Future Improvements

Future versions of the architecture may include:

- Retrieval-Augmented Generation (RAG)
- Long-Term Memory
- AI Workflow Engine
- Event-Driven Communication
- Microservices
- Multi-LLM Support
- Voice Interaction
- Real-Time Collaboration

---

# Conclusion

The proposed architecture provides a strong foundation for building CareerPilot AI as a scalable, modular, and intelligent career mentoring platform. The use of multiple specialized AI agents coordinated through a central AI Coordinator enables personalized, context-aware, and extensible career guidance.