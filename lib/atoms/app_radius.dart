import 'package:atomic_design/atoms/app_tokens.dart';
import 'package:flutter/widgets.dart';

/// Static helpers for reading border-radius tokens from the current context.
///
/// Each method reads from [AppTokens.of], which requires [AppThemeProvider]
/// to be present in the widget tree.
///
/// ```dart
/// BorderRadius.circular(AppRadius.mediumOf(context))
/// ```
///
/// For multi-value usage prefer [AppTokens.of] directly to avoid repeated
/// context lookups.
abstract class AppRadius {
  static double smallOf(BuildContext ctx) => AppTokens.of(ctx).radius.small;
  static double mediumOf(BuildContext ctx) => AppTokens.of(ctx).radius.medium;
  static double largeOf(BuildContext ctx) => AppTokens.of(ctx).radius.large;
  static double extraLargeOf(BuildContext ctx) =>
      AppTokens.of(ctx).radius.extraLarge;
}
