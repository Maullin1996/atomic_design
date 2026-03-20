import 'dart:convert';

import 'package:atomic_design/atoms/app_themes.dart';
import 'package:atomic_design/atoms/app_tokens.dart';
import 'package:atomic_design/config/atomic_design_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

String buildTestConfigJson() {
  Map<String, double> spacing(double base) => {
        'xSmall': base,
        'small': base + 1,
        'smallMedium': base + 2,
        'medium': base + 3,
        'mediumLarge': base + 4,
        'large': base + 5,
        'extraLarge': base + 6,
      };

  Map<String, double> radius(double base) => {
        'small': base,
        'medium': base + 1,
        'large': base + 2,
        'extraLarge': base + 3,
      };

  Map<String, dynamic> typography() => {
        'fonts': {'fontFamily': 'TestFont'},
        'sizes': {
          'caption': 10,
          'label': 12,
          'body': 14,
          'bodyLg': 16,
          'h6': 18,
          'h5': 20,
          'h4': 22,
          'h3': 24,
          'h2': 26,
          'h1': 28,
        },
      };

  Map<String, dynamic> responsive(double base) => {
        'spacing': spacing(base),
        'radius': radius(base),
        'typography': typography(),
      };

  Map<String, String> colors(String primaryHex) => {
        'primary': primaryHex,
        'primaryHover': '#2F5AE0',
        'primaryPressed': '#2647B8',
        'primaryDisabled': '#9DB4FF',
        'onPrimary': '#FFFFFF',
        'secondary': '#00BFA5',
        'secondaryHover': '#00A18C',
        'secondaryPressed': '#00806E',
        'secondaryDisabled': '#7FDCCF',
        'onSecondary': '#FFFFFF',
        'background': '#F7F8FA',
        'surfaceLow': '#FFFFFF',
        'surfaceMid': '#F1F3F6',
        'surfaceHigh': '#E6EAF0',
        'onSurface': '#111827',
        'onSurfaceVariant': '#6B7280',
        'textPrimary': '#111827',
        'textSecondary': '#6B7280',
        'textDisabled': '#9CA3AF',
        'textInverse': '#FFFFFF',
        'success': '#16A34A',
        'onSuccess': '#FFFFFF',
        'warning': '#F59E0B',
        'onWarning': '#111827',
        'error': '#DC2626',
        'onError': '#FFFFFF',
        'info': '#2563EB',
        'onInfo': '#FFFFFF',
        'disabled': '#E5E7EB',
        'onDisabled': '#9CA3AF',
        'focus': '#3B82F6',
        'divider': '#E5E7EB',
        'border': '#D1D5DB',
      };

  Map<String, dynamic> buildConfig(String primaryHex) => {
        'colors': colors(primaryHex),
        'spacing': spacing(6),
        'radius': radius(6),
        'typography': typography(),
        'responsive': {
          'xSmall': responsive(2),
          'small': responsive(4),
          'medium': responsive(6),
          'large': responsive(8),
          'xLarge': responsive(10),
        },
      };

  final config = {
    'light': buildConfig('#3366FF'),
    'dark': buildConfig('#FF9933'),
  };

  return jsonEncode(config);
}

Color parseHexColor(String hex) {
  var value = hex.replaceFirst('#', '');
  if (value.length == 6) value = 'FF$value';
  return Color(int.parse(value, radix: 16));
}

Future<void> initializeTestConfig() async {
  AtomicDesignConfig.reset();
  await AtomicDesignConfig.initializeFromJsonString(buildTestConfigJson());
}

Future<void> pumpTestWidget(
  WidgetTester tester,
  Widget child, {
  Size size = const Size(400, 800),
  Brightness brightness = Brightness.light,
}) async {
  await tester.binding.setSurfaceSize(size);
  addTearDown(() => tester.binding.setSurfaceSize(null));

  final theme = brightness == Brightness.dark
      ? AppThemes.dark
      : AppThemes.light;

  await tester.pumpWidget(
    MediaQuery(
      data: MediaQueryData(size: size),
      child: MaterialApp(
        theme: theme,
        darkTheme: AppThemes.dark,
        themeMode:
            brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
        home: AppThemeProvider(
          child: Scaffold(body: Center(child: child)),
        ),
      ),
    ),
  );
  await tester.pump();
}
