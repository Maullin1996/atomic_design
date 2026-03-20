import 'package:atomic_design/config/app_config.dart';
import 'package:atomic_design/config/atomic_design_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utils.dart';

void main() {
  test('AppConfig.fromJson parses numeric maps', () {
    final json = {
      'colors': {'primary': '#000000'},
      'spacing': {'xSmall': 1, 'small': 2, 'smallMedium': 3, 'medium': 4, 'mediumLarge': 5, 'large': 6, 'extraLarge': 7},
      'radius': {'small': 1, 'medium': 2, 'large': 3, 'extraLarge': 4},
      'typography': {
        'fonts': {'fontFamily': 'TestFont'},
        'sizes': {'caption': 10, 'label': 12, 'body': 14, 'bodyLg': 16, 'h6': 18, 'h5': 20, 'h4': 22, 'h3': 24, 'h2': 26, 'h1': 28},
      },
    };

    final config = AppConfig.fromJson(json);
    expect(config.spacing['medium'], 4);
    expect(config.radius['large'], 3);
    expect(config.typography.fonts['fontFamily'], 'TestFont');
  });

  test('ResponsiveTokens resolves breakpoints correctly', () {
    final tokens = ResponsiveTokens(
      xSmall: ResponsiveConfig(
        spacing: {'xSmall': 1},
        radius: {'small': 1},
        typography: TypographyJson(fonts: {'fontFamily': 'A'}, sizes: {'body': 12}),
      ),
      small: ResponsiveConfig(
        spacing: {'xSmall': 2},
        radius: {'small': 2},
        typography: TypographyJson(fonts: {'fontFamily': 'B'}, sizes: {'body': 14}),
      ),
      medium: ResponsiveConfig(
        spacing: {'xSmall': 3},
        radius: {'small': 3},
        typography: TypographyJson(fonts: {'fontFamily': 'C'}, sizes: {'body': 16}),
      ),
      large: ResponsiveConfig(
        spacing: {'xSmall': 4},
        radius: {'small': 4},
        typography: TypographyJson(fonts: {'fontFamily': 'D'}, sizes: {'body': 18}),
      ),
      xLarge: ResponsiveConfig(
        spacing: {'xSmall': 5},
        radius: {'small': 5},
        typography: TypographyJson(fonts: {'fontFamily': 'E'}, sizes: {'body': 20}),
      ),
    );

    expect(tokens.resolve(320).spacing['xSmall'], 1);
    expect(tokens.resolve(380).spacing['xSmall'], 2);
    expect(tokens.resolve(500).spacing['xSmall'], 3);
    expect(tokens.resolve(700).spacing['xSmall'], 4);
    expect(tokens.resolve(900).spacing['xSmall'], 5);
  });

  testWidgets('AtomicDesignConfig.responsiveConfigFor uses width and brightness', (tester) async {
    await initializeTestConfig();

    late ResponsiveConfig resolved;

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: Size(350, 800)),
        child: MaterialApp(
          theme: ThemeData(brightness: Brightness.light),
          home: Builder(
            builder: (context) {
              resolved = AtomicDesignConfig.instance.responsiveConfigFor(context);
              return const SizedBox();
            },
          ),
        ),
      ),
    );

    expect(resolved.spacing['xSmall'], 2);
  });
}
