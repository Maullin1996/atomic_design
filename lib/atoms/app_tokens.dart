import 'package:atomic_design/config/app_config.dart';
import 'package:atomic_design/config/atomic_design_config.dart';
import 'package:flutter/material.dart';

class AppTokens {
  final AppSpacingTokens spacing;
  final AppRadiusTokens radius;
  final AppTypographyTokens typography;

  AppTokens({
    required this.spacing,
    required this.radius,
    required this.typography,
  });

  factory AppTokens.resolve(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final width = MediaQuery.sizeOf(context).width;
    final base = AtomicDesignConfig.instance.configFor(brightness);
    final resolved = base.resolveFor(width);

    return AppTokens(
      spacing: AppSpacingTokens.fromMap(resolved.spacing),
      radius: AppRadiusTokens.fromMap(resolved.radius),
      typography: AppTypographyTokens.fromConfig(resolved.typography),
    );
  }

  static AppTokens of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<_AppTokensInherited>();
    assert(provider != null, 'AppThemeProvider no encontrado en el árbol');
    return provider!.tokens;
  }
}

class AppSpacingTokens {
  final double xSmall;
  final double small;
  final double smallMedium;
  final double medium;
  final double mediumLarge;
  final double large;
  final double extraLarge;

  const AppSpacingTokens({
    required this.xSmall,
    required this.small,
    required this.smallMedium,
    required this.medium,
    required this.mediumLarge,
    required this.large,
    required this.extraLarge,
  });

  factory AppSpacingTokens.fromMap(Map<String, double> map) {
    return AppSpacingTokens(
      xSmall: map['xSmall']!,
      small: map['small']!,
      smallMedium: map['smallMedium']!,
      medium: map['medium']!,
      mediumLarge: map['mediumLarge']!,
      large: map['large']!,
      extraLarge: map['extraLarge']!,
    );
  }
}

class AppRadiusTokens {
  final double small;
  final double medium;
  final double large;
  final double extraLarge;

  const AppRadiusTokens({
    required this.small,
    required this.medium,
    required this.large,
    required this.extraLarge,
  });

  factory AppRadiusTokens.fromMap(Map<String, double> map) {
    return AppRadiusTokens(
      small: map['small']!,
      medium: map['medium']!,
      large: map['large']!,
      extraLarge: map['extraLarge']!,
    );
  }
}

class AppTypographyTokens {
  final String fontFamily;
  final double caption;
  final double label;
  final double body;
  final double bodyLg;
  final double h6;
  final double h5;
  final double h4;
  final double h3;
  final double h2;
  final double h1;

  const AppTypographyTokens({
    required this.fontFamily,
    required this.caption,
    required this.label,
    required this.body,
    required this.bodyLg,
    required this.h6,
    required this.h5,
    required this.h4,
    required this.h3,
    required this.h2,
    required this.h1,
  });

  factory AppTypographyTokens.fromConfig(TypographyJson config) {
    return AppTypographyTokens(
      fontFamily: config.fonts['fontFamily']!,
      caption: config.sizes['caption']!,
      label: config.sizes['label']!,
      body: config.sizes['body']!,
      bodyLg: config.sizes['bodyLg']!,
      h6: config.sizes['h6']!,
      h5: config.sizes['h5']!,
      h4: config.sizes['h4']!,
      h3: config.sizes['h3']!,
      h2: config.sizes['h2']!,
      h1: config.sizes['h1']!,
    );
  }
}

class _AppTokensInherited extends InheritedWidget {
  final AppTokens tokens;
  const _AppTokensInherited({required super.child, required this.tokens});

  @override
  bool updateShouldNotify(covariant _AppTokensInherited old) =>
      tokens != old.tokens;
}

class AppThemeProvider extends StatefulWidget {
  final Widget child;

  const AppThemeProvider({super.key, required this.child});

  @override
  State<AppThemeProvider> createState() => _AppThemeProviderState();
}

class _AppThemeProviderState extends State<AppThemeProvider>
    with WidgetsBindingObserver {
  late AppTokens _tokens;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tokens = AppTokens.resolve(context);
  }

  @override
  void didChangeMetrics() {
    if (mounted) setState(() => _tokens = AppTokens.resolve(context));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _AppTokensInherited(tokens: _tokens, child: widget.child);
  }
}
