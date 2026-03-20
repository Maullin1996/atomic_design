import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

abstract class AppThemes {
  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final cfg = AtomicDesignConfig.instance.configFor(brightness);

    Color c(String key) {
      String hex = cfg.colors[key]!.replaceFirst('#', '');
      if (hex.length == 6) hex = 'FF$hex';
      return Color(int.parse(hex, radix: 16));
    }

    final t = cfg.responsive!.small;

    final isLight = brightness == Brightness.light;

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: c('primary'),
      onPrimary: c('onPrimary'),
      secondary: c('secondary'),
      onSecondary: c('onSecondary'),
      surface: c('surfaceLow'),
      onSurface: c('onSurface'),
      error: c('error'),
      onError: c('onError'),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: t.typography.fonts['fontFamily'],
      colorScheme: colorScheme,

      scaffoldBackgroundColor: c('surfaceMid'),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.primary.withAlpha(34),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: colorScheme.primary);
          }
          return IconThemeData(color: colorScheme.onSurfaceVariant);
        }),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: c('surfaceLow'),
        foregroundColor: c('primary'),
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontFamily: t.typography.fonts['fontFamily'],
          fontSize: t.typography.sizes['h4'],
          fontWeight: FontWeight.w600,
          color: c('primary'),
        ),
      ),

      cardTheme: CardThemeData(
        color: c('surfaceLow'),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(t.radius['medium'] ?? 0.0),
          side: BorderSide(color: c('border'), width: 1),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: c('primary'),
          foregroundColor: c('onPrimary'),
          disabledBackgroundColor: c('primaryDisabled'),
          disabledForegroundColor: c('textDisabled'),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          textStyle: TextStyle(
            fontFamily: t.typography.fonts['fontFamily'],
            fontSize: t.typography.sizes['body'],
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(t.radius['medium'] ?? 0.0),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: c('primary'),
          textStyle: TextStyle(
            fontFamily: t.typography.fonts['fontFamily'],
            fontSize: t.typography.sizes['body'],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c('surfaceLow'),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(t.radius['medium'] ?? 0.0),
          borderSide: BorderSide(color: c('border')),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(t.radius['medium'] ?? 0.0),
          borderSide: BorderSide(color: c('border')),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(t.radius['medium'] ?? 0.0),
          borderSide: BorderSide(color: c('focus'), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(t.radius['medium'] ?? 0.0),
          borderSide: BorderSide(color: c('error')),
        ),
        hintStyle: TextStyle(color: c('textDisabled')),
        labelStyle: TextStyle(color: c('textSecondary')),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: c('surfaceHigh'),
        contentTextStyle: TextStyle(
          color: c('textPrimary'),
          fontFamily: t.typography.fonts['fontFamily'],
          fontSize: t.typography.sizes['body'],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(t.radius['medium'] ?? 0.0),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: c('surfaceLow'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(t.radius['large'] ?? 0.0),
        ),
        titleTextStyle: TextStyle(
          fontFamily: t.typography.fonts['fontFamily'],
          fontSize: t.typography.sizes['h5'],
          fontWeight: FontWeight.w600,
          color: c('textPrimary'),
        ),
      ),

      dividerTheme: DividerThemeData(
        color: c('divider'),
        thickness: 1,
        space: 1,
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return c('primary');
          return isLight ? const Color(0xFF9E9E9E) : const Color(0xFF475569);
        }),
        trackColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return c('primary').withValues(alpha: 0.45);
          }
          return isLight
              ? const Color(0xFF9E9E9E).withValues(alpha: 0.30)
              : const Color(0xFF334155);
        }),
      ),

      datePickerTheme: DatePickerThemeData(
        backgroundColor: c('surfaceLow'),
        headerBackgroundColor: c('primary'),
        headerForegroundColor: c('onPrimary'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(t.radius['large'] ?? 0.0),
        ),
      ),

      timePickerTheme: TimePickerThemeData(
        backgroundColor: c('surfaceLow'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(t.radius['large'] ?? 0.0),
        ),
      ),

      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: t.typography.fonts['fontFamily'],
          fontSize: t.typography.sizes['h1'],
          fontWeight: FontWeight.w700,
          color: c('textPrimary'),
        ),
        displayMedium: TextStyle(
          fontFamily: t.typography.fonts['fontFamily'],
          fontSize: t.typography.sizes['h2'],
          fontWeight: FontWeight.w700,
          color: c('textPrimary'),
        ),
        displaySmall: TextStyle(
          fontFamily: t.typography.fonts['fontFamily'],
          fontSize: t.typography.sizes['h3'],
          fontWeight: FontWeight.w600,
          color: c('textPrimary'),
        ),
        headlineMedium: TextStyle(
          fontFamily: t.typography.fonts['fontFamily'],
          fontSize: t.typography.sizes['h4'],
          fontWeight: FontWeight.w600,
          color: c('textPrimary'),
        ),
        headlineSmall: TextStyle(
          fontFamily: t.typography.fonts['fontFamily'],
          fontSize: t.typography.sizes['h5'],
          fontWeight: FontWeight.w600,
          color: c('textPrimary'),
        ),
        titleLarge: TextStyle(
          fontFamily: t.typography.fonts['fontFamily'],
          fontSize: t.typography.sizes['h6'],
          fontWeight: FontWeight.w500,
          color: c('textPrimary'),
        ),
        bodyLarge: TextStyle(
          fontFamily: t.typography.fonts['fontFamily'],
          fontSize: t.typography.sizes['bodyLg'],
          fontWeight: FontWeight.w400,
          color: c('textPrimary'),
        ),
        bodyMedium: TextStyle(
          fontFamily: t.typography.fonts['fontFamily'],
          fontSize: t.typography.sizes['body'],
          fontWeight: FontWeight.w400,
          color: c('textPrimary'),
        ),
        bodySmall: TextStyle(
          fontFamily: t.typography.fonts['fontFamily'],
          fontSize: t.typography.sizes['label'],
          fontWeight: FontWeight.w400,
          color: c('textSecondary'),
        ),
        labelSmall: TextStyle(
          fontFamily: t.typography.fonts['fontFamily'],
          fontSize: t.typography.sizes['caption'],
          fontWeight: FontWeight.w400,
          color: c('textDisabled'),
        ),
      ),
    );
  }
}
