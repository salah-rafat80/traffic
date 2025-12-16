## Goals
- Establish professional typography, spacing, palette, shadows, and radii.
- Centralize styling in a reusable design system and apply it to onboarding UI.
- Verify responsiveness and accessibility across devices and Flutter Web.
- Produce a concise style guide documenting all decisions.

## Typography
- Fonts: Use `Tajawal` for Arabic and `Roboto` for English.
- Integration option A (preferred): Add `google_fonts` and compose `TextTheme` with `GoogleFonts.tajawalTextTheme()` and `GoogleFonts.robotoTextTheme()` merged per `Locale`.
- Integration option B (offline): Bundle TTF files for Tajawal/Roboto in `assets/fonts` and declare in `pubspec.yaml`.
- Hierarchy and sizes (line height ≈ 1.3, letter spacing: Arabic 0, English 0–0.2):
  - H1: 32, H2: 24–28, Subtitle: 18–22, Body: 16, Body small: 14, Caption: 12–14.
- Map to `TextTheme`: `headlineLarge/Small`, `titleMedium`, `bodyLarge/Medium`, `labelSmall`.

## Color Palette
- Limited cohesive palette:
  - Primary: `#2E7D32` (accessible dark green)
  - Secondary: `#27AE60` (accent green)
  - Background: `#FFFFFF`, Surface: `#F7F7F7`
  - Text primary: `#222222`, Text secondary: `#6B7280`
  - Border: `#E5E7EB`, Error: `#D32F2F`
- Verify contrast (WCAG 2.1 AA): ensure text contrast ≥ 4.5:1; adjust if any item falls short.

## Spacing, Radii, Shadows
- Spacing scale (8-based): 8, 12, 16, 24, 32, 40.
- Corner radii: 8 for components, 4 for small elements.
- Shadows: subtle elevation preset (e.g., `offset 0,4`, `blur 16`, `color black 8%`).

## Design System Implementation
- Create `lib/design_system/`:
  - `colors.dart`: `AppColors` constants.
  - `spacing.dart`: `Insets` constants and helpers (`Insets.h16`, `Insets.v24`).
  - `radii.dart`: `Radii` constants.
  - `shadows.dart`: `AppShadows` presets.
  - `typography.dart`: `AppTypography` builder returning a merged `TextTheme` based on `Locale` with Tajawal/Roboto.
  - `app_theme.dart`: `ThemeData` factory (`AppTheme.light`) setting `colorScheme`, `textTheme`, `useMaterial3: true`, and `ButtonThemes` with consistent padding, radii, and colors.
- Add `google_fonts` to `pubspec.yaml` (if using option A).

## Apply to Screens
- `lib/main.dart`: use `theme: AppTheme.light` and set `locale` if needed.
- `lib/onboarding_screen.dart`:
  - Replace inline font sizes with `Theme.of(context).textTheme` entries.
  - Replace magic spacers with `Insets` constants (e.g., `Insets.v16`, `Insets.v24`).
  - Use `ElevatedButtonTheme` instead of per-widget `styleFrom` for consistency.
  - Keep the responsive image sizing with `LayoutBuilder`; ensure minimum/maximum caps for very small/large screens.

## Accessibility & Responsiveness
- Respect `MediaQuery.textScaleFactor` and dynamic type.
- Ensure tap targets ≥ 44x44.
- Verify contrast with a checker; adjust palette if needed.
- Test on iPhone 13 mini size, a mid Android device, and Flutter Web (Chrome) to confirm responsive spacing and typography.

## Style Guide Document
- Create `STYLE_GUIDE.md` with:
  - Fonts and hierarchy, sizes, line heights, letter spacing.
  - Color tokens (hex), usage guidelines and contrast notes.
  - Spacing scale, radii, shadow presets.
  - Component examples (buttons, links) and code snippets for usage.

## Validation
- Run `flutter analyze` and ensure no style regressions.
- Manual visual QA across devices; confirm RTL layout consistency for Arabic.

## Deliverables
- Design system files under `lib/design_system/` and applied theme in `main.dart`.
- Updated onboarding screen using the design system.
- `STYLE_GUIDE.md` documenting decisions.

## Next Step
- On approval, I will implement the design system, update screens, add fonts, and produce the style guide, then verify accessibility and responsiveness.