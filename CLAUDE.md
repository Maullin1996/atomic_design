# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

Run from the package root (`G:\Archivos\movile_apps\atomic_design`):

```bash
# Get dependencies
flutter pub get

# Run the example app
cd example && flutter run

# Analyze
flutter analyze

# Run tests
flutter test

# Run a single test file
flutter test test/my_test.dart
```

The example app also has its own `pubspec.yaml` — run `flutter pub get` inside `example/` when working there.

## Architecture

This is a Flutter **design system package** (`atomic_design`) that follows the Atomic Design methodology. It ships reusable UI components in layers, and is consumed by apps through a single barrel export.

### Initialization (required before use)

The entire system depends on a singleton `AtomicDesignConfig` that must be initialized once at app startup before any widget is rendered. It parses a JSON config file that defines all design tokens for both light and dark themes:

```dart
await AtomicDesignConfig.initializeFromAsset('assets/config/app_config.json');
```

The JSON config shape is `{ "light": { colors, typography, spacing, radius, responsive }, "dark": { ... } }`. The `responsive` block contains five breakpoints (`xSmall`/`small`/`medium`/`large`/`xLarge`) that override tokens based on screen width (breakpoints: <360, <414, <600, <840, 840+).

### Token resolution flow

```
app_config.json
  └─ AtomicDesignConfig (singleton)          lib/config/atomic_design_config.dart
       └─ AppConfig (light | dark)            lib/config/app_config.dart
            └─ ResponsiveTokens.resolve(width)
                 └─ ResponsiveConfig (spacing, radius, typography)
                      └─ AppTokens.resolve(context)   lib/atoms/app_tokens.dart
                           └─ AppThemeProvider (InheritedWidget)
```

`AppThemeProvider` must wrap the widget tree. Widgets read resolved tokens via `AppTokens.of(context)`, and colors via `AppColors.of(context)`. Static helpers (`AppSpacing`, `AppRadius`, `AppTypography`) are thin wrappers that delegate to `AppTokens.of(context)`.

### Atomic layers

| Layer | Path | Contents |
|---|---|---|
| Atoms | `lib/atoms/` | Tokens, colors, spacing, radius, typography, text, buttons, icons, input, images, themes |
| Molecules | `lib/molecules/` | Card, search bar, bottom sheet, dialog, snack bar |
| Organisms | `lib/organisms/` | Login form, card list, grid view, bottom nav bar, drawer, state widget, search result bar |

The single public entry point is `lib/design_system.dart`, which re-exports all layers. Consumers `import 'package:atomic_design/design_system.dart'`.

### AppThemes

`AppThemes.light` / `AppThemes.dark` build full Material 3 `ThemeData` objects from the config. They must be used together with `AppThemeProvider` in `MaterialApp`:

```dart
MaterialApp(
  theme: AppThemes.light,
  darkTheme: AppThemes.dark,
  themeMode: ThemeMode.system,
  home: AppThemeProvider(child: ...),
)
```

`AppThemeProvider` listens to `WidgetsBindingObserver` to re-resolve tokens on screen resize/rotation.

### Example app

`example/` is a standalone Flutter app demonstrating every component. It has its own config at `example/assets/config/app_config.json`. Routes are declared in `example/lib/config/routes/app_routes.dart` and features are organized under `example/lib/feature/{atoms,molecules,organisms,templates}/`.
