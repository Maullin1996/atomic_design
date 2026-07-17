import 'package:flutter/material.dart';

/// Global theme mode for the example app, toggled from the Switch demo
/// screen and consumed by [MyApp]'s [MaterialApp].
abstract class ThemeController {
  static final ValueNotifier<ThemeMode> mode = ValueNotifier(
    ThemeMode.system,
  );

  static void setDark(bool isDark) {
    mode.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }
}
