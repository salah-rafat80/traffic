# AI Agent Master Directives — Flutter/Dart

> **Hard rule:** Agent must refuse or warn when a request forces a violation of any non-negotiable rule. Any approved deviation must be recorded in the PR description with justification and linked ticket.

---

## 1. Core Principles

| Principle | Rule |
|-----------|------|
| **YAGNI** | Implement only requested features |
| **KISS** | Prefer the simplest readable solution |
| **DRY** | Avoid duplication; do not over-abstract |
| **Logic Separation** | UI = rendering + interaction only. No business logic, network, or heavy transformations in Widgets |
| **Explicit types** | `dynamic` is **FORBIDDEN**. All types must be declared |

---

## 2. Architecture: Clean + Feature-First

```
lib/features/<feature>/
├── presentation/   → Widgets, Cubits, view models
├── domain/         → Entities, UseCases (pure Dart, NO Flutter deps)
└── data/           → DTOs, datasources, repositories
```

**Mapping rule:** Data layer maps DTOs → Entities. Presentation only consumes Entities or view models derived from Entities.

---

## 3. File & Code Constraints (CI Enforced)

| Rule | Limit |
|------|-------|
| File length | ≤ 300 lines |
| Function length | ≤ 40 lines (prefer ≤ 20) |
| Public classes per file | 1 |
| Widget building | Use `const StatelessWidget` classes, NOT private `_buildX()` methods |

- Always annotate constructors/fields with `const` where possible.

---

## 4. State Management — Cubit Standard

- Use `Cubit` from `flutter_bloc`.
- Use `Freezed` for state definitions.
- **Cubit MUST NOT** use `BuildContext`, navigation, Snackbars, or direct UI APIs.
- After every `async` await, check: `if (isClosed) return;`
- Provide Cubits via `BlocProvider`; handle one-shot events in UI with `BlocListener`.

```dart
// auth_state.dart
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.success(UserEntity user) = _Success;
  const factory AuthState.error(String message) = _Error;
}

// auth_cubit.dart
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  AuthCubit(this._loginUseCase) : super(const AuthState.initial());

  Future<void> login(String email, String password) async {
    emit(const AuthState.loading());
    final result = await _loginUseCase(LoginParams(email, password));
    if (isClosed) return; // safety after await
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (user) => emit(AuthState.success(user)),
    );
  }
}
```

---

## 5. Naming & Comments

- Files: `snake_case.dart`
- Classes: `PascalCase` | Variables/methods: `lowerCamelCase`
- Comments: **WHY only**. Use `///` for public API docs. No obvious comments.
- TODOs must include ticket reference: `// TODO(feat-123): add pagination after backend supports it`

---

## 6. Error Handling & Data Flow

- Use `Either<Failure, Success>` for functional error handling.
- Catch and map exceptions in Data/Domain layer into `Failure` objects (`message`, optional `code`).
- Convert `Failure` → user-friendly message in Cubit before emitting UI state.

---

## 7. Performance & Tooling

- **NEVER** use `dynamic`. Explicit types only.
- **NEVER** use `print()` in production. Use `debugPrint()` or a logger.
- Favor `const` constructors and const widgets everywhere.

---

## 8. AI Agent Execution Protocol

Before delivering any code, the agent **MUST** self-check:

- [ ] Files ≤ 300 lines
- [ ] Functions ≤ 40 lines
- [ ] No `dynamic` used
- [ ] No Flutter APIs in Domain layer
- [ ] Tests generated for new UseCases/Repositories

**Output policy:** Provide minimal diff — only changed/added files and relevant imports. Include test skeletons when introducing business logic.

**Commit message format:**
```
feat(<feature>): short description — ai-agent
fix(<feature>): short description — ai-agent
# include: refs: <ticket>  if provided
```

**Deviation handling:**
1. Warn with explicit rationale.
2. If user insists → generate code with `// VIOLATION` comment + justification.

---

## 9. Unit Test Skeleton

```dart
// auth_cubit_test.dart
void main() {
  group('AuthCubit', () {
    late MockLoginUseCase mockLoginUseCase;
    late AuthCubit cubit;

    setUp(() {
      mockLoginUseCase = MockLoginUseCase();
      cubit = AuthCubit(mockLoginUseCase);
    });

    test('initial state is initial', () {
      expect(cubit.state, const AuthState.initial());
    });

    blocTest<AuthCubit, AuthState>(
      'emits loading then success when login succeeds',
      build: () {
        when(() => mockLoginUseCase(any()))
            .thenAnswer((_) async => Right(UserEntity(...)));
        return cubit;
      },
      act: (cubit) => cubit.login('a@b.com', 'pass'),
      expect: () => [
        const AuthState.loading(),
        AuthState.success(UserEntity(...)),
      ],
    );
  });
}
```
