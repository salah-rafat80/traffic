<!--
Sync Impact Report:
- Version change: 1.0.0 -> 1.1.0
- Modified principles:
  - Updated: IV. UI/UX & Theming Standards (Mandated flutter_screenutil)
- Added sections: None
- Removed sections: None
- Templates requiring updates:
  - ✅ d:\StudioProjects\traffic\traffic\.specify\templates\plan-template.md (Updated Constitution Check)
  - ✅ d:\StudioProjects\traffic\traffic\.specify\templates\tasks-template.md (Added screenutil setup task)
  - ✅ d:\StudioProjects\traffic\traffic\.specify\templates\spec-template.md (Added screenutil requirement)
- Follow-up TODOs: None
-->
# Moroork (Smart Traffic Platform) Constitution

## Core Principles

### I. Strict Clean Architecture & Modularization
The application MUST follow strict Clean Architecture principles. Code must be logically divided into Presentation, Domain, Data, and Core layers. Separation of concerns is mandatory to ensure scalability and maintainability.

### II. Deferred State Management (Cubit)
State management will use `Cubit`. CRITICAL RULE: Setup the architectural boundaries, folders, and abstractions for Cubit, but DEFER the actual implementation and API integrations. Use dummy data and UI logic until the backend APIs are officially received.

### III. Absolute Code Quality & Null-Safety (NON-NEGOTIABLE)
100% Sound Null-Safety is required. Code must pass `flutter analyze` with ZERO warnings. Strict linting (`flutter_lints`) must be enforced. Do not use `print()` statements; strictly use structured logging via `dart:developer`. Follow SOLID principles and prefer Composition over Inheritance.

### IV. UI/UX & Theming Standards
Use Material 3, `ThemeData`, and `ColorScheme.fromSeed` for centralized theming (supporting both Light/Dark modes). UI MUST be responsive using the `flutter_screenutil` package. All sizes, dimensions, padding, margins, and radii MUST use screenutil extensions (e.g., `.w`, `.h`, `.r`). All font sizes MUST use the `.sp` extension. Strictly avoid hardcoded double values for any sizing without applying screenutil extensions, to ensure consistent scaling across all devices and prevent layout breaks. Widgets (especially `StatelessWidget`) must be immutable using `const` constructors. Ensure Accessibility (A11Y) with Semantic labels and minimum 4.5:1 contrast ratios.

### V. Routing & Dependency Injection
Use `go_router` for declarative navigation, deep-linking, and role-based redirects. Use manual constructor injection (or a simple Service Locator) to manage dependencies explicitly across layers without tight coupling.

## Core Domain & Features
The platform handles smart traffic services in Egypt including:
- AI vehicle violation detection (Computer Vision).
- NLP Chatbot for legal/traffic guidance.
- License renewals, fine payments, and technical/medical inspection bookings.
- Specialized role-based dashboards for Citizens, Traffic Officers, Doctors, and Admins.

## Testing Strategy
Write testable code prioritizing the Arrange-Act-Assert pattern. Keep business logic (Domain/Data) completely independent of the Flutter SDK to allow for pure Dart unit testing.

## Governance
This Constitution supersedes all other practices. All generated Flutter code MUST verify compliance with these architectural boundaries. UI generation must not include tight coupling to business logic.

**Version**: 1.1.0 | **Ratified**: 2026-02-26 | **Last Amended**: 2026-02-26
