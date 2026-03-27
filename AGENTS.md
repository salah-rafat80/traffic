# AGENTS.md

## Big Picture (what this app is today)
- This is a Flutter mobile app for Arabic traffic services; UI-first and feature-first under `lib/features/`.
- Runtime entrypoints are `lib/main_dev.dart` (starts at `MainNavigationScreen`) and `lib/main_production.dart` (starts at `SplashScreen`).
- `lib/injection_container.dart` is still a TODO; there is no active DI wiring yet.
- Architecture docs describe Clean Architecture, but most implemented flows are presentation-driven with local widget state.

## Real Structure and Data Flow
- Navigate from home via direct `Navigator.push(MaterialPageRoute(...))`, not named routes (see `lib/features/home/presentation/widgets/service_cards_grid.dart`).
- Shared service shell pattern: each service screen uses `ServiceScreenAppBar` + `AppDrawer` + scrollable content (see `lib/core/widgets/service_screen_appbar.dart`, `lib/core/widgets/app_drawer.dart`).
- Several flows are composed from reusable generic screens:
  - Terms: `lib/core/widgets/generic_terms_screen.dart`
  - Booking: `lib/core/widgets/generic_booking_screen.dart`
  - Document upload: `lib/core/widgets/generic_document_upload_screen.dart`
- Current "data layer" is mostly local dummy models/static lists (for example `ViolationModel.dummyViolations` in `lib/features/violations_inquiry/data/models/violation_model.dart`).

## Developer Workflow (project-specific)
- Install deps: `flutter pub get`
- Static analysis: `flutter analyze`
- File-length gate used by team tooling: `python tools/check_file_lengths.py` (fails if any `lib/**/*.dart` file > 300 lines).
- Tests currently minimal; `test/widget_test.dart` is default counter smoke test and does not match current app behavior.
- If you add/modify runnable Dart code, validate with at least `flutter analyze` and a focused `flutter test` run.

## Conventions You Should Follow Here
- Respect lint policy in `analysis_options.yaml`: no `dynamic`, explicit return types, avoid `print`, prefer `const`, snake_case file names.
- UI is Arabic-first and RTL; many widgets explicitly set `textDirection: TextDirection.rtl`.
- Responsive sizing uses `flutter_screenutil` (`.w`, `.h`, `.sp`) initialized in app roots with `AppSizes.baseWidth/baseHeight`.
- Theme and design tokens live in `lib/core/utils/app_theme.dart` and `lib/core/constants/*` (`AppColors`, `Insets`, `AppSizes`, typography).
- Existing screens favor small reusable widget files (many per feature); preserve this split instead of adding large monolithic screens.

## Integrations and Boundaries
- Device camera flow is implemented in `lib/features/vehicle_inspection/presentation/screens/vehicle_inspection_camera_screen.dart` using `camera`, `path`, and `path_provider`.
- Document upload/preview uses `file_picker` + `open_filex` in `lib/core/widgets/generic_document_upload_screen.dart`.
- SVG-heavy UI uses `flutter_svg`; fonts are declared in `pubspec.yaml` (`Tajawal`, `Cairo`).
- No backend/network client is wired yet (`dio`/API repositories are not present); keep new logic decoupled so API integration can replace dummy data later.

## Practical Do/Don't for Agents
- Do extend existing generic widgets when adding similar service flows.
- Do keep navigation style consistent (MaterialPageRoute) unless you migrate all affected flow points.
- Do not assume Cubit/Bloc is already active; references are mostly TODO comments for future wiring.
- Do not rely on README for architecture details; use code under `lib/` as source of truth.

