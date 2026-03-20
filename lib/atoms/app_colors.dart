import 'package:atomic_design/config/atomic_design_config.dart';
import 'package:flutter/material.dart';

class AppColors {
  final Brightness _brightness;
  AppColors._(this._brightness);

  static AppColors of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return AppColors._(brightness);
  }

  // ===== Brand =====
  Color get primary => _get('primary');
  Color get primaryHover => _get('primaryHover');
  Color get primaryPressed => _get('primaryPressed');
  Color get primaryDisabled => _get('primaryDisabled');
  Color get onPrimary => _get('onPrimary');

  Color get secondary => _get('secondary');
  Color get secondaryHover => _get('secondaryHover');
  Color get secondaryPressed => _get('secondaryPressed');
  Color get secondaryDisabled => _get('secondaryDisabled');
  Color get onSecondary => _get('onSecondary');

  // ===== Surfaces =====
  Color get background => _get('background');
  Color get surfaceLow => _get('surfaceLow');
  Color get surfaceMid => _get('surfaceMid');
  Color get surfaceHigh => _get('surfaceHigh');
  Color get onSurface => _get('onSurface');
  Color get onSurfaceVariant => _get('onSurfaceVariant');

  // ===== Text =====
  Color get textPrimary => _get('textPrimary');
  Color get textSecondary => _get('textSecondary');
  Color get textDisabled => _get('textDisabled');
  Color get textInverse => _get('textInverse');

  // ===== Feedback =====
  Color get success => _get('success');
  Color get onSuccess => _get('onSuccess');
  Color get warning => _get('warning');
  Color get onWarning => _get('onWarning');
  Color get error => _get('error');
  Color get onError => _get('onError');
  Color get info => _get('info');
  Color get onInfo => _get('onInfo');

  // ===== States =====
  Color get disabled => _get('disabled');
  Color get onDisabled => _get('onDisabled');
  Color get focus => _get('focus');
  Color get divider => _get('divider');
  Color get border => _get('border');

  Color _get(String key) {
    final config = AtomicDesignConfig.instance.configFor(_brightness);
    String hex = config.colors[key]!;
    hex = hex.replaceFirst('#', '');
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.parse(hex, radix: 16));
  }
}
