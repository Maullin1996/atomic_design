# atomic_design

A Flutter design-system package built on the **Atomic Design** methodology. It provides a token-driven component library — atoms, molecules, and organisms — whose colors, spacing, typography, and border radii are fully driven by a JSON configuration file, with built-in support for light/dark themes and five responsive breakpoints.

---

## Table of contents

- [Installation](#installation)
- [Setup](#setup)
- [Configuration file](#configuration-file)
- [Responsive breakpoints](#responsive-breakpoints)
- [Atoms](#atoms)
  - [AppTokens](#apptokens)
  - [AppColors](#appcolors)
  - [AppAnimations](#appanimations)
  - [AppText](#apptext)
  - [AppButtons](#appbuttons)
  - [AppInputText](#appinputtext)
  - [AppSwitch](#appswitch)
  - [AppCheckbox](#appcheckbox)
  - [AppRadio](#appradio)
  - [AppChip & AppFilterChip](#appchip--appfilterchip)
  - [AppIcons](#appicons)
  - [AppNetworkImage](#appnetworkimage)
  - [AppAssetsImage](#appassetsimage)
- [Molecules](#molecules)
  - [AppCard](#appcard)
  - [AppSearchBar](#appsearchbar)
  - [AppBottomSheet](#appbottomsheet)
  - [AppDialog](#appdialog)
  - [AppSnackBar](#appsnackbar)
- [Organisms](#organisms)
  - [AppLoginForm](#apploginform)
  - [AppCardList](#appcardlist)
  - [AppGridView](#appgridview)
  - [AppBottomNavBar](#appbottomnavbar)
  - [AppDrawer](#appdrawer)
  - [AppStateWidget](#appstatewidget)
  - [AppResultSearchBar](#appresultsearchbar)

---

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  atomic_design:
    path: ../atomic_design   # adjust to your local path
```

Then run:

```bash
flutter pub get
```

---

## Setup

### 1. Add the config asset

Copy the JSON config file to your app's assets folder and declare it in `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/config/app_config.json
```

### 2. Initialise the singleton

Call `AtomicDesignConfig.initializeFromAsset` **before** `runApp` — no widget from this package will work without it:

```dart
import 'package:atomic_design/design_system.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AtomicDesignConfig.initializeFromAsset('assets/config/app_config.json');
  runApp(const MyApp());
}
```

### 3. Wire up the themes and provider

Wrap `MaterialApp` with `AppThemeProvider` and pass the design-system themes:

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppThemeProvider(
      child: MaterialApp(
        theme: AppThemes.light,
        darkTheme: AppThemes.dark,
        themeMode: ThemeMode.system,
        home: const HomePage(),
      ),
    );
  }
}
```

`AppThemeProvider` is an `InheritedWidget` that re-resolves tokens on brightness changes and screen resizes. It must be present in the tree for `AppTokens.of(context)` and `AppColors.of(context)` to work.

---

## Configuration file

The config file drives every token — colors, typography, spacing, and radius — for both themes. The top-level structure is:

```json
{
  "light": { ... },
  "dark":  { ... }
}
```

Each theme object has the following shape:

```json
{
  "colors": {
    "primary": "#2563EB",
    "onPrimary": "#FFFFFF",
    "secondary": "#0D9488",
    "background": "#F9FAFB",
    "surfaceLow": "#FFFFFF",
    "surfaceMid": "#F3F4F6",
    "surfaceHigh": "#E5E7EB",
    "textPrimary": "#111827",
    "textSecondary": "#4B5563",
    "textDisabled": "#9CA3AF",
    "error": "#DC2626",
    "success": "#16A34A",
    "border": "#D1D5DB"
    // ... see AppColors for the full list
  },
  "typography": {
    "fonts": { "fontFamily": "Inter" },
    "sizes": {
      "caption": 11, "label": 12, "body": 14, "bodyLg": 16,
      "h6": 16, "h5": 18, "h4": 22, "h3": 26, "h2": 30, "h1": 36
    }
  },
  "spacing": {
    "xSmall": 8, "small": 12, "smallMedium": 24,
    "medium": 34, "mediumLarge": 44, "large": 64, "extraLarge": 124
  },
  "radius": {
    "small": 8, "medium": 12, "large": 16, "extraLarge": 24
  },
  "responsive": { ... }   // optional — see Responsive breakpoints
}
```

> All spacing and radius values are in logical pixels. Colors accept `#RRGGBB` or `#AARRGGBB`.

---

## Responsive breakpoints

Add an optional `"responsive"` block inside each theme to override tokens per screen width:

```json
"responsive": {
  "xSmall": { "typography": {...}, "spacing": {...}, "radius": {...} },
  "small":   { ... },
  "medium":  { ... },
  "large":   { ... },
  "xLarge":  { ... }
}
```

| Key      | Screen width          |
|----------|-----------------------|
| xSmall   | < 360 px              |
| small    | 360 – 413 px          |
| medium   | 414 – 599 px          |
| large    | 600 – 839 px          |
| xLarge   | ≥ 840 px              |

When a `"responsive"` block is present, `AppTokens` automatically picks the correct breakpoint on every build. When it is absent, the base tokens are used for all screen sizes.

---

## Atoms

Import everything with a single line:

```dart
import 'package:atomic_design/design_system.dart';
```

### AppTokens

The typed token set for the current context. Read it once per build and destructure what you need:

```dart
final tokens = AppTokens.of(context);

SizedBox(height: tokens.spacing.small)
BorderRadius.circular(tokens.radius.medium)
TextStyle(fontSize: tokens.typography.body)
```

Static helpers are available for single-value lookups:

```dart
AppSpacing.smallOf(context)
AppRadius.mediumOf(context)
AppTypography.bodyOf(context)
```

### AppColors

Semantic color palette resolved from the current brightness:

```dart
final colors = AppColors.of(context);

Container(color: colors.primary)
Text('Error', style: TextStyle(color: colors.error))
```

**Available tokens**

| Group      | Tokens |
|------------|--------|
| Brand      | `primary`, `primaryHover`, `primaryPressed`, `primaryDisabled`, `onPrimary`, `secondary`, `secondaryHover`, `secondaryPressed`, `secondaryDisabled`, `onSecondary` |
| Surfaces   | `background`, `surfaceLow`, `surfaceMid`, `surfaceHigh`, `onSurface`, `onSurfaceVariant` |
| Text       | `textPrimary`, `textSecondary`, `textDisabled`, `textInverse` |
| Feedback   | `success`, `onSuccess`, `warning`, `onWarning`, `error`, `onError`, `info`, `onInfo` |
| States     | `disabled`, `onDisabled`, `focus`, `divider`, `border` |

### AppAnimations

Duration and curve constants. Use these instead of hardcoded `Duration(milliseconds: 300)` to keep transitions consistent across the app:

```dart
AnimatedSwitcher(
  duration: AppAnimations.standard,  // 300 ms
  child: ...,
)

CurvedAnimation(
  parent: controller,
  curve: AppAnimations.easeOut,
)
```

| Constant             | Value                  |
|----------------------|------------------------|
| `AppAnimations.fast`     | 150 ms             |
| `AppAnimations.standard` | 300 ms (default)   |
| `AppAnimations.slow`     | 500 ms             |
| `AppAnimations.easeInOut`| `Curves.easeInOut` |
| `AppAnimations.easeOut`  | `Curves.easeOut`   |
| `AppAnimations.easeIn`   | `Curves.easeIn`    |

### AppText

Themed text widget with named constructors for every type-scale step:

```dart
AppText.h1('Display title')
AppText.h4('Section heading')
AppText.body('Paragraph text', color: colors.textSecondary)
AppText.caption('12 items', maxLines: 1)
```

| Constructor     | TextTheme slot   | Approx. use    |
|-----------------|------------------|----------------|
| `AppText.h1`    | displayLarge     | Hero headlines |
| `AppText.h2`    | displayMedium    | Page titles    |
| `AppText.h3`    | displaySmall     | Section titles |
| `AppText.h4`    | headlineMedium   | Card headings  |
| `AppText.h5`    | headlineSmall    | Dialog titles  |
| `AppText.h6`    | titleLarge       | List headings  |
| `AppText.bodyLg`| bodyLarge        | Lead text      |
| `AppText.body`  | bodyMedium       | Default body   |
| `AppText.label` | bodySmall        | Labels, hints  |
| `AppText.caption`| labelSmall      | Metadata, tags |

All named constructors default `overflow` to `TextOverflow.ellipsis`. Use the base `AppText(text, variant: ...)` constructor when you need a different overflow.

### AppButtons

Single widget for all button variants, selected via `type`:

```dart
// Filled primary button
AppButtons(
  type: ButtonType.primaryFillButton,
  title: const Text('Save'),
  isLoading: _isSaving,
  onPressed: _save,
)

// Text button
AppButtons(
  type: ButtonType.primaryTextButton,
  title: const Text('Cancel'),
  onPressed: Navigator.of(context).pop,
)

// Icon button
AppButtons(
  type: ButtonType.primaryIconButton,
  icon: AppIcons.edit,
  onPressed: _edit,
)

// FAB
AppButtons(
  type: ButtonType.primaryFloatingButton,
  icon: AppIcons.add,
  heroTag: 'main-fab',
  onPressed: _create,
)

// Circular SVG button (social login)
AppButtons(
  type: ButtonType.primaryImageButton,
  assetsIcon: 'assets/icons/google-circle.svg',
  onPressed: _loginWithGoogle,
)
```

When `isLoading: true`, the button is disabled and a `CircularProgressIndicator` replaces the label or icon.

| Type                    | Required params               |
|-------------------------|-------------------------------|
| `primaryFillButton`     | `title`                       |
| `primaryIconFillButton` | `title`, `iconForFilledButton`|
| `primaryTextButton`     | `title`                       |
| `primaryIconButton`     | `icon`                        |
| `primaryFloatingButton` | `icon`                        |
| `primaryImageButton`    | `assetsIcon`                  |

### AppInputText

Themed `TextFormField` that adapts borders and colors from the active tokens:

```dart
AppInputText(
  label: 'Email',
  hint: 'you@example.com',
  textEditingController: _emailController,
  keyboardType: TextInputType.emailAddress,
  prefixIcon: const Icon(Icons.email_outlined),
  validator: (v) => v!.contains('@') ? null : 'Invalid email',
)
```

For password fields:

```dart
AppInputText(
  label: 'Password',
  obscureText: _obscure,
  suffixIcon: AppButtons(
    type: ButtonType.primaryIconButton,
    icon: _obscure ? AppIcons.showPassword : AppIcons.obscurePassword,
    onPressed: () => setState(() => _obscure = !_obscure),
  ),
)
```

### AppSwitch

Themed switch with an optional tappable label row:

```dart
AppSwitch(
  value: _notifications,
  label: const Text('Enable notifications'),
  onChanged: (v) => setState(() => _notifications = v),
)

// Switch only, no label
AppSwitch(value: _darkMode, onChanged: _toggle)
```

When `onChanged` is `null` the switch and label are rendered disabled. The entire row (label + thumb) is tappable when a label is provided.

### AppCheckbox

Themed checkbox with an optional tappable label row:

```dart
AppCheckbox(
  value: _accepted,
  label: const Text('I accept the terms and conditions'),
  onChanged: (v) => setState(() => _accepted = v ?? false),
)

// Tristate (null = indeterminate)
AppCheckbox(
  value: _partial,
  tristate: true,
  label: const Text('Select all'),
  onChanged: (v) => setState(() => _partial = v),
)
```

### AppRadio

Themed radio button with an optional tappable label row. Generic over the group value type:

```dart
// In state:
String _plan = 'free';

// In build:
AppRadio<String>(
  value: 'free',
  groupValue: _plan,
  label: const Text('Free'),
  onChanged: (v) => setState(() => _plan = v!),
)
AppRadio<String>(
  value: 'pro',
  groupValue: _plan,
  label: const Text('Pro'),
  onChanged: (v) => setState(() => _plan = v!),
)
```

All radio buttons in the same group must share the same value type and `groupValue` state.

### AppChip & AppFilterChip

**`AppChip`** — read-only display chip for tags and labels:

```dart
// Simple tag
AppChip(label: 'Flutter')

// With delete button
AppChip(
  label: 'Flutter',
  onDeleted: () => _removeTech('Flutter'),
)

// With avatar
AppChip(
  label: 'Jane',
  avatar: const CircleAvatar(child: Text('J')),
  onDeleted: _removeJane,
)
```

**`AppFilterChip`** — toggleable chip for filters and categories:

```dart
AppFilterChip(
  label: 'In stock',
  selected: _inStock,
  onSelected: (v) => setState(() => _inStock = v),
)
```

When selected, the chip uses the `primary` color for its border, label, and checkmark. Pass `onSelected: null` to disable.

### AppIcons

Intent-based `IconData` constants:

```dart
Icon(AppIcons.user)
Icon(AppIcons.error, color: colors.error)
Icon(AppIcons.backIcon)
```

See `lib/atoms/app_icons.dart` for the full catalogue.

### AppNetworkImage

Cached network image with shimmer loading and error fallback:

```dart
AppNetworkImage(
  url: user.avatarUrl,
  widthImage: 48,
  heightImage: 48,
  fit: BoxFit.cover,
  errorWidget: const Icon(Icons.person),
)
```

Pass `memCacheWidth` / `memCacheHeight` to reduce memory usage for large source images displayed at a small size.

### AppAssetsImage

Asset image with size constraint and error fallback:

```dart
AppAssetsImage(
  path: 'assets/images/empty_icon.png',
  widthImage: 120,
  heightImage: 120,
  errorWidget: Icon(AppIcons.brokenImage),
)
```

---

## Molecules

### AppCard

Themed card with an optional shimmer skeleton loading state:

```dart
AppCard(
  padding: const EdgeInsets.all(16),
  isLoading: _isLoading,
  loadingHeight: 100,
  child: MyContent(),
)
```

The transition between the skeleton and content uses a combined fade + slide animation. The duration is configurable via `switchDuration`.

### AppSearchBar

Search input with a leading search icon:

```dart
AppSearchBar(
  controller: _searchController,
  onChanged: _onSearch,
  hintText: 'Search products…',
)
```

Pair with `AppResultSearchBar` to show an animated results overlay below the bar.

### AppBottomSheet

Modal bottom sheet with title, subtitle, custom content, and confirm / cancel actions:

```dart
AppBottomSheet.show(
  context,
  title: 'Delete account',
  subtitle: 'This action cannot be undone.',
  confirmLabel: 'Delete',
  cancelLabel: 'Cancel',
  isDangerous: true,
  onConfirm: _deleteAccount,
);
```

Key behaviours:
- `isDangerous: true` — title and confirm button use the error color.
- `isLoading: true` — confirm button shows a spinner; barrier dismissal is disabled.
- The sheet is capped at 90 % of screen height and shifts up when the keyboard appears.

### AppDialog

Confirmation dialog with the same API as `AppBottomSheet`:

```dart
AppDialog.show(
  context,
  title: 'Discard changes?',
  subtitle: 'Your edits will be lost.',
  confirmLabel: 'Discard',
  cancelLabel: 'Keep editing',
  onConfirm: Navigator.of(context).pop,
);
```

Key behaviours:
- `isDangerous: true` — title and confirm button use the error color.
- `isLoading: true` — confirm button shows a spinner; barrier tap is disabled.
- The dialog is capped at 90 % of screen width and 80 % of screen height.

### AppSnackBar

Floating, themed snack bar with semantic color and icon:

```dart
AppSnackBar.show(
  context,
  type: SnackBarType.success,
  message: 'Profile saved',
);

AppSnackBar.show(
  context,
  type: SnackBarType.error,
  message: 'Upload failed',
  actionLabel: 'Retry',
  onAction: _retry,
  duration: const Duration(seconds: 5),
);
```

| Type      | Color   | Icon        |
|-----------|---------|-------------|
| `success` | success | check       |
| `info`    | primary | information |
| `warning` | warning | information |
| `error`   | error   | error       |

---

## Organisms

### AppLoginForm

Self-contained login form with username/password fields, social login buttons, and a registration link. The form owns its own controllers and validation state — the parent only receives validated values via `onSignIn`.

```dart
AppLoginForm(
  title: 'Welcome back',
  isLoading: _isLoading,
  onSignIn: (user, password) => _bloc.login(user, password),
  onGoogle: _loginWithGoogle,
  onGitHub: _loginWithGitHub,
  onRegister: () => context.push('/register'),
)
```

Social login buttons are rendered only when their callbacks are non-null.

### AppCardList

List container with four animated states. The component owns the `ListView`, so the loading skeleton and the real list always share the same spacing:

```dart
AppCardList(
  type: switch (_state) {
    Loading() => CardListType.loading,
    Empty()   => CardListType.empty,
    Error()   => CardListType.error,
    Data()    => CardListType.list,
  },
  itemCount: _items.length,
  itemBuilder: (context, index) => ItemTile(item: _items[index]),
  emptyWidget: AppStateWidget(
    type: AppStateType.empty,
    image: 'assets/images/empty_icon.png',
    title: 'No items yet',
    buttonChild: const Text('Refresh'),
    onPressed: _refresh,
  ),
  errorWidget: AppStateWidget(
    type: AppStateType.error,
    icon: AppIcons.error,
    title: 'Something went wrong',
    buttonChild: const Text('Try again'),
    onPressed: _retry,
  ),
)
```

The loading state renders 10 shimmer `AppCard` skeletons automatically. Pass `separatorBuilder` to override the default `xSmall` gap between items.

### AppGridView

Same four-state API as `AppCardList` but for grids. The component owns the `GridView`, so the loading skeleton column count and aspect ratio always match the real grid:

```dart
AppGridView(
  type: _state,
  itemCount: _items.length,
  itemBuilder: (context, index) => ItemCard(item: _items[index]),
  childAspectRatio: 0.75,
  emptyWidget: ...,
  errorWidget: ...,
)
```

Responsive column breakpoints (applied to both the real grid and the skeleton):

| Screen width | Columns |
|---|---|
| < 360 px   | 1 |
| 360–599 px | 2 |
| 600–839 px | 3 |
| ≥ 840 px   | 4 |

### AppBottomNavBar

Material 3 `NavigationBar` wrapper. Requires 2–5 items:

```dart
AppBottomNavBar(
  currentIndex: _selectedIndex,
  onTap: (i) => setState(() => _selectedIndex = i),
  items: const [
    BottomNavItem(icon: Icons.home_outlined,
                  selectedIcon: Icons.home, label: 'Home'),
    BottomNavItem(icon: Icons.person_outlined,
                  selectedIcon: Icons.person, label: 'Profile'),
  ],
)
```

### AppDrawer

Navigation drawer with optional user header and logout button:

```dart
AppDrawer(
  userName: user.name,
  userEmail: user.email,
  avatarUrl: user.photoUrl,
  onLogout: _signOut,
  items: [
    DrawerItem(
      icon: AppIcons.user,
      label: 'Profile',
      isSelected: _currentRoute == '/profile',
      onTap: () => context.push('/profile'),
    ),
    DrawerItem(
      icon: AppIcons.save,
      label: 'Settings',
      onTap: () => context.push('/settings'),
    ),
  ],
)
```

The header section is shown only when at least one of `userName`, `userEmail`, or `avatarUrl` is provided. The avatar displays the user's initials when `avatarUrl` is null or fails to load.

### AppStateWidget

Full-page empty or error state with a visual, title, and primary action button. Requires either `image` or `icon`:

```dart
// With asset image
AppStateWidget(
  type: AppStateType.empty,
  image: 'assets/images/empty_icon.png',
  widthImage: 160,
  heightImage: 160,
  title: 'No results found',
  buttonChild: const Text('Clear filters'),
  onPressed: _clearFilters,
)

// With icon (error variant)
AppStateWidget(
  type: AppStateType.error,
  icon: AppIcons.error,
  iconSize: 64,
  title: 'Connection failed',
  buttonChild: const Text('Retry'),
  onPressed: _retry,
)
```

When `type` is `AppStateType.error`, the title and icon are tinted with `AppColors.error`.

### AppResultSearchBar

Animated overlay that reveals a results panel below a search bar. Pass `null` to hide it:

```dart
Column(
  children: [
    AppSearchBar(
      controller: _controller,
      onChanged: _onSearch,
    ),
    AppResultSearchBar(
      child: _results.isEmpty ? null : ListView.builder(
        shrinkWrap: true,
        itemCount: _results.length,
        itemBuilder: (_, i) => ResultTile(item: _results[i]),
      ),
    ),
  ],
)
```

The panel is capped at 300 px in height and uses a fade + slide-down animation.
