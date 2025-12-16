# Visual Style Guide

## Typography
- Headings: Tajawal
  - H1: 32, bold, line height 1.3, letter spacing 0
  - H2: 28, bold, line height 1.3, letter spacing 0
  - H3: 24, bold, line height 1.3, letter spacing 0
- Subheadings: Tajawal
  - 22/20/18, semibold, line height 1.3
- Body: Tajawal
  - 16 regular, line height 1.4
  - 14 regular, line height 1.4
- Captions: Tajawal
  - 12 regular, line height 1.3
- English pages: Roboto with the same sizes; letter spacing 0–0.2 for headings, 0 for body.

## Color Palette
- Primary: #2E7D32
- Secondary: #27AE60
- Background: #FFFFFF
- Surface: #F7F7F7
- Text primary: #222222
- Text secondary: #6B7280
- Border: #E5E7EB
- Error: #D32F2F
- On primary: #FFFFFF

## Spacing
- Scale: 8, 12, 16, 24, 32, 40
- Standard screen padding: 16 horizontal
- Vertical spacing between major sections: 24

## Radii
- Components: 8
- Small elements: 4

## Shadows
- Low elevation: offset 0,4; blur 16; color black 8%

## Components
- Primary button: full width when appropriate; padding 24×16; radius 8; background primary; text white.
- Text links: underline only for contextual actions; use text primary color.

## Accessibility
- Minimum contrast: 4.5:1 for normal text, 3:1 for large text.
- Tap targets: ≥ 44×44.
- RTL support: Arabic default; ensure alignment and padding remain symmetric.

## Usage
- Import `AppTheme.light()` in `MaterialApp`.
- Use `Theme.of(context).textTheme` for text styles.
- Use `Insets` for consistent padding and `Radii` for corner radii.