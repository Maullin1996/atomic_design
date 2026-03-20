import 'dart:convert';

import 'package:atomic_design/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AtomicDesignConfig {
  static AtomicDesignConfig? _instance;
  static AtomicDesignConfig get instance => _instance!;

  late AppConfig _lightConfig;
  late AppConfig _darkConfig;

  AppConfig get lightConfig => _lightConfig;
  AppConfig get darkConfig => _darkConfig;

  /// Returns config based on current brightness
  AppConfig configFor(Brightness brightness) =>
      brightness == Brightness.dark ? _darkConfig : _lightConfig;

  ResponsiveConfig responsiveConfigFor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final width = MediaQuery.sizeOf(context).width;
    final base = configFor(brightness);
    return base.resolveFor(width);
  }

  AtomicDesignConfig._();

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

  @visibleForTesting
  static void reset() => _instance = null;

  static bool get isInitialized => _instance != null;
}
