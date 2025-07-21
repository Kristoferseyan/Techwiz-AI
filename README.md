# Techwiz

TechWiz is a mobile app that helps users troubleshoot common computer and laptop issues. Built with a Flutter frontend and a Spring Boot backend, it features secure login and clean architecture. The app now includes a lightweight AI assistant powered by a locally hosted language model (via Ollama), which analyzes user-reported problems and suggests the most relevant fixes from a structured database. Still a work in progress, but it's steadily evolving into a real-world full-stack project.

## 🛠️ Technologies Used

### Frontend (Flutter)
- **Framework**: Flutter 3.8.1+
- **Language**: Dart
- **State Management**: 
  - Provider 6.1.1+
  - Flutter BLoC
- **HTTP Client**: 
  - Dio 5.4.0+
  - HTTP 1.1.0+
- **Storage**: SharedPreferences 2.2.2+
- **Environment Variables**: Flutter DotEnv
- **UI**: Material Design 3

### Backend (Spring Boot)
- **Framework**: Spring Boot 3.5.3
- **Language**: Java 21
- **Build Tool**: Maven
- **Core Dependencies**:
  - Spring Boot Starter Web
  - Spring Boot Starter Data JPA
  - Spring Boot Starter Security
  - Spring Boot Starter Validation
  - Spring Boot Starter Actuator
- **Database**: MySQL (with MySQL Connector/J)
- **Authentication**: JWT (JSON Web Tokens)
  - jjwt-api 0.12.6
  - jjwt-impl 0.12.6
  - jjwt-jackson 0.12.6

### AI Integration
- **Language Model**: openhermes (locally hosted)
- **Purpose**: Intelligent problem analysis and solution matching

TechWiz is a mobile app that helps users troubleshoot common computer and laptop issues. Built with a Flutter frontend and a Spring Boot backend, it features secure login and clean architecture. The app now includes a lightweight AI assistant powered by a locally hosted language model (via Ollama), which analyzes user-reported problems and suggests the most relevant fixes from a structured database. Still a work in progress, but it’s steadily evolving into a real-world full-stack project.

## 📱 App Screenshots

### Login & Authentication
<img src="docs/techwiz-pics/login-page.png" alt="Login Page" width="300">

### Main Dashboard
<img src="docs/techwiz-pics/dashboard.png" alt="Dashboard" width="300">

### Issue Management
<div style="display: flex; gap: 20px;">
  <img src="docs/techwiz-pics/all-issues-page.png" alt="All Issues Page" width="300">
  <img src="docs/techwiz-pics/issue-dialog.png" alt="Issue Dialog" width="300">
</div>

### AI-Powered Solutions
<div style="display: flex; gap: 20px;">
  <img src="docs/techwiz-pics/ai-matching.png" alt="AI Matching" width="300">
  <img src="docs/techwiz-pics/solutions-page.png" alt="Solutions Page" width="300">
</div>


