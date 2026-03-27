# AI Agent — Permanent Rules (Flutter/Dart)

> Full directive file: `docs/ai-agent-master-directives.md`
> **Read that file before generating any code.**

---

## NON-NEGOTIABLE RULES (Refuse or Warn on Violation)

1. **No `dynamic`** — All types must be explicit.
2. **No business logic in Widgets** — UI = rendering + interaction only.
3. **No Flutter APIs in Domain layer** — Pure Dart only.
4. **File ≤ 300 lines** — CI fails otherwise.
5. **Function ≤ 40 lines** — Prefer ≤ 20.
6. **No `print()`** — Use `debugPrint()` or a logger.
7. **Cubits must NOT use BuildContext** — No navigation/snackbars inside Cubit.
8. **`if (isClosed) return;`** — After every async await in Cubit.
9. **Tests required** — For every new UseCase and Repository.
10. **Either<Failure, Success>** — Functional error handling everywhere.

## Architecture

```
lib/features/<feature>/
├── presentation/  → Widgets + Cubits
├── domain/        → Entities + UseCases (pure Dart)
└── data/          → DTOs + Datasources + Repositories
```

## Self-Check Before Every Output

- [ ] Files ≤ 300 lines
- [ ] Functions ≤ 40 lines
- [ ] No `dynamic`
- [ ] No Flutter in Domain
- [ ] Tests included

## Deviation Protocol

1. Warn with explicit rationale.
2. If user insists → add `// VIOLATION` comment with justification.

## Commit Format

```
feat(<feature>): description — ai-agent
fix(<feature>): description — ai-agent
```
