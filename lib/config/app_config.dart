class AppConfig {
  final Map<String, String> colors;
  final Map<String, double> spacing;
  final Map<String, double> radius;
  final TypographyJson typography;
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

  ResponsiveConfig resolveFor(double width) {
    if (responsive != null) return responsive!.resolve(width);

    return ResponsiveConfig(
      spacing: spacing,
      radius: radius,
      typography: typography,
    );
  }
}

class TypographyJson {
  final Map<String, String> fonts;
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

  ResponsiveConfig resolve(double width) {
    if (width < 360) return xSmall;
    if (width < 414) return small;
    if (width < 600) return medium;
    if (width < 840) return large;
    return xLarge;
  }
}
