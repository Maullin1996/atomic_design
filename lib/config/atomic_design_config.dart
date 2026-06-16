import 'dart:convert';

import 'package:atomic_design/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Global singleton that holds the parsed design-token configuration.
///
/// **Must be initialised once before any widget from the design system is
/// rendered**, typically at the top of `main`:
///
/// ```dart
/// // From a bundled asset:
/// await AtomicDesignConfig.initializeFromAsset('assets/config/app_config.json');
///
/// // Or from an in-memory JSON string (useful in tests):
/// await AtomicDesignConfig.initializeFromJsonString(jsonString);
/// ```
///
/// The JSON file must have `"light"` and `"dark"` top-level keys, each
/// containing a full [AppConfig]-compatible object (colors, typography,
/// spacing, radius, and an optional responsive block).
///
/// After initialisation widgets access the active config through:
/// - [configFor] — returns the [AppConfig] matching the current [Brightness].
/// - [responsiveConfigFor] — convenience method that also resolves the
///   breakpoint for the given [BuildContext].
///
/// See also:
/// - [AppTokens], which wraps the resolved config in a typed, context-aware API.
/// - [AppThemes], which uses this config to build Material [ThemeData].
class AtomicDesignConfig {
  static AtomicDesignConfig? _instance;

  /// The active singleton. Throws if [initializeFromAsset] or
  /// [initializeFromJsonString] has not been called yet.
  static AtomicDesignConfig get instance => _instance!;

  late AppConfig _lightConfig;
  late AppConfig _darkConfig;

  /// The token configuration for light theme.
  AppConfig get lightConfig => _lightConfig;

  /// The token configuration for dark theme.
  AppConfig get darkConfig => _darkConfig;

  /// Returns the [AppConfig] for [brightness].
  AppConfig configFor(Brightness brightness) =>
      brightness == Brightness.dark ? _darkConfig : _lightConfig;

  /// Returns the breakpoint-resolved [ResponsiveConfig] for the given context,
  /// taking both the current brightness and screen width into account.
  ResponsiveConfig responsiveConfigFor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final width = MediaQuery.sizeOf(context).width;
    final base = configFor(brightness);
    return base.resolveFor(width);
  }

  AtomicDesignConfig._();

  /// Initialises the singleton from a raw JSON string.
  ///
  /// Useful for tests where loading from the asset bundle is not possible.
  /// Throws an [Exception] if the JSON cannot be parsed.
  static Future<void> initializeFromJsonString(String jsonString) async {
    _instance = AtomicDesignConfig._();
    try {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      _instance!._lightConfig = AppConfig.fromJson(jsonMap['light']);
      _instance!._darkConfig = AppConfig.fromJson(jsonMap['dark']);
    } catch (e) {
      throw Exception('Error parsing JSON configuration: $e');
    }
  }

  /// Initialises the singleton by loading a JSON file from the asset bundle.
  ///
  /// [assetPath] must be declared in the consuming app's `pubspec.yaml`.
  /// Throws an [Exception] if the asset cannot be loaded or parsed.
  static Future<void> initializeFromAsset(String assetPath) async {
    _instance = AtomicDesignConfig._();
    try {
      final String jsonString = await rootBundle.loadString(assetPath);
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      _instance!._lightConfig = AppConfig.fromJson(jsonMap['light']);
      _instance!._darkConfig = AppConfig.fromJson(jsonMap['dark']);
    } catch (e) {
      throw Exception('Error loading configuration from asset: $e');
    }
  }

  /// Resets the singleton to `null`. Intended for use in tests only.
  @visibleForTesting
  static void reset() => _instance = null;

  /// `true` if the singleton has been initialised.
  static bool get isInitialized => _instance != null;
}
