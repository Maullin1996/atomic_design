/// Data models that represent a parsed design-token configuration.
///
/// These classes are populated by [AtomicDesignConfig] when it reads the
/// JSON config file (one entry per theme — `light` and `dark`).  Consumers
/// rarely need to interact with these types directly; use [AppTokens] or the
/// static helpers ([AppColors], [AppSpacing], etc.) inside widgets instead.
library;

/// Holds all raw design tokens for a single theme (light **or** dark).
///
/// Colors are stored as hex strings (e.g. `"#2563EB"` or `"2563EB"`).
/// Spacing and radius values are stored as logical pixels.
///
/// When the config JSON includes a `responsive` block, [resolveFor] picks the
/// breakpoint-appropriate [ResponsiveConfig]; otherwise the base [spacing],
/// [radius], and [typography] values are returned directly.
class AppConfig {
  /// Semantic color palette keyed by token name (e.g. `"primary"`, `"error"`).
  final Map<String, String> colors;

  /// Base spacing scale before responsive overrides are applied.
  final Map<String, double> spacing;

  /// Base border-radius scale before responsive overrides are applied.
  final Map<String, double> radius;

  /// Base typography (font family + size scale) before responsive overrides.
  final TypographyJson typography;

  /// Optional per-breakpoint overrides for spacing, radius, and typography.
  final ResponsiveTokens? responsive;

  AppConfig({
    required this.colors,
    required this.typography,
    required this.spacing,
    required this.radius,
    this.responsive,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    final responsiveJson = json['responsive'] as Map<String, dynamic>?;
    return AppConfig(
      colors: Map<String, String>.from(json['colors']),
      radius: Map<String, double>.from(
        (json['radius'] as Map).map(
          (k, v) => MapEntry(k, (v as num).toDouble()),
        ),
      ),
      spacing: Map<String, double>.from(
        (json['spacing'] as Map).map(
          (k, v) => MapEntry(k, (v as num).toDouble()),
        ),
      ),
      typography: TypographyJson.fromJson(json['typography']),
      responsive: responsiveJson != null
          ? ResponsiveTokens.fromJson(responsiveJson)
          : null,
    );
  }

  /// Returns the [ResponsiveConfig] that matches [width] in logical pixels.
  ///
  /// Falls back to a [ResponsiveConfig] built from the base tokens when no
  /// [responsive] block is present in the config.
  ResponsiveConfig resolveFor(double width) {
    if (responsive != null) return responsive!.resolve(width);

    return ResponsiveConfig(
      spacing: spacing,
      radius: radius,
      typography: typography,
    );
  }
}

/// Raw typography tokens: font-family names and size scale.
class TypographyJson {
  /// Font-family overrides keyed by role. Must include at least `"fontFamily"`.
  final Map<String, String> fonts;

  /// Named size scale (e.g. `"body"`, `"h4"`) in logical pixels.
  final Map<String, double> sizes;

  TypographyJson({required this.fonts, required this.sizes});

  factory TypographyJson.fromJson(Map<String, dynamic> json) {
    return TypographyJson(
      fonts: Map<String, String>.from(json['fonts']),
      sizes: Map<String, double>.from(
        (json['sizes'] as Map).map(
          (k, v) => MapEntry(k, (v as num).toDouble()),
        ),
      ),
    );
  }
}

/// The resolved token set for a specific screen-width breakpoint.
///
/// Produced by [ResponsiveTokens.resolve] and consumed by [AppTokens.resolve]
/// to build the [AppTokens] that widgets read at runtime.
class ResponsiveConfig {
  final Map<String, double> spacing;
  final Map<String, double> radius;
  final TypographyJson typography;

  ResponsiveConfig({
    required this.spacing,
    required this.radius,
    required this.typography,
  });

  factory ResponsiveConfig.fromJson(Map<String, dynamic> json) {
    return ResponsiveConfig(
      spacing: Map<String, double>.from(
        (json['spacing'] as Map).map(
          (k, v) => MapEntry(k, (v as num).toDouble()),
        ),
      ),
      radius: Map<String, double>.from(
        (json['radius'] as Map).map(
          (k, v) => MapEntry(k, (v as num).toDouble()),
        ),
      ),
      typography: TypographyJson.fromJson(json['typography']),
    );
  }
}

/// Stores five [ResponsiveConfig] breakpoints and selects the right one for a
/// given screen width.
///
/// Breakpoints (logical pixels):
/// - `xSmall` — < 360
/// - `small`  — 360 – 413
/// - `medium` — 414 – 599
/// - `large`  — 600 – 839
/// - `xLarge` — ≥ 840
class ResponsiveTokens {
  final ResponsiveConfig xSmall;
  final ResponsiveConfig small;
  final ResponsiveConfig medium;
  final ResponsiveConfig large;
  final ResponsiveConfig xLarge;

  ResponsiveTokens({
    required this.xSmall,
    required this.small,
    required this.medium,
    required this.large,
    required this.xLarge,
  });

  factory ResponsiveTokens.fromJson(Map<String, dynamic> json) {
    return ResponsiveTokens(
      xSmall: ResponsiveConfig.fromJson(json['xSmall']),
      small: ResponsiveConfig.fromJson(json['small']),
      medium: ResponsiveConfig.fromJson(json['medium']),
      large: ResponsiveConfig.fromJson(json['large']),
      xLarge: ResponsiveConfig.fromJson(json['xLarge']),
    );
  }

  /// Returns the [ResponsiveConfig] whose breakpoint contains [width].
  ResponsiveConfig resolve(double width) {
    if (width < 360) return xSmall;
    if (width < 414) return small;
    if (width < 600) return medium;
    if (width < 840) return large;
    return xLarge;
  }
}
