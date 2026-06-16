import 'package:atomic_design/atoms/tokens.dart';
import 'package:flutter/material.dart';

/// The inline content widget used inside a [SnackBar] produced by [AppSnackBar].
///
/// Renders a semantic icon, the [message] text, and an optional action button
/// side-by-side. The icon and action color are chosen from [AppColors] based
/// on [type].
///
/// This widget is not typically used directly — use [AppSnackBar.show] instead.
class AppSnackBarContent extends StatelessWidget {
  final SnackBarType type;
  final String message;

  /// Label for an optional inline action button.
  final String? actionLabel;

  /// Called when the action button is tapped.
  final VoidCallback? onAction;

  const AppSnackBarContent({
    super.key,
    required this.type,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final tokens = AppTokens.of(context);

    return Row(
      children: [
        Icon(type.icon(), color: colors.textInverse),

        SizedBox(width: tokens.spacing.small),

        Expanded(
          child: AppText.bodyLg(
            message,
            color: colors.textInverse,
            maxLines: 3,
          ),
        ),

        if (actionLabel != null) ...[
          SizedBox(width: tokens.spacing.xSmall),
          AppButtons(
            type: ButtonType.primaryTextButton,
            onPressed: onAction,
            title: AppText.body(
              actionLabel!,
              color: colors.textInverse,
              maxLines: 1,
            ),
          ),
        ],
      ],
    );
  }
}

/// Shows a floating, themed [SnackBar] with semantic color and icon.
///
/// ```dart
/// AppSnackBar.show(
///   context,
///   type: SnackBarType.success,
///   message: 'Changes saved',
/// );
///
/// AppSnackBar.show(
///   context,
///   type: SnackBarType.error,
///   message: 'Upload failed',
///   actionLabel: 'Retry',
///   onAction: _retry,
/// );
/// ```
///
/// The background is the semantic color for [type] at 86 % opacity, allowing
/// the content behind the snack bar to show through slightly.
class AppSnackBar {
  /// Displays a floating snack bar on the nearest [ScaffoldMessenger].
  ///
  /// [duration] defaults to 3 seconds. Any previous snack bars are replaced.
  static void show(
    BuildContext context, {
    required SnackBarType type,
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
  }) {
    final background = type.background(context);
    final tokens = AppTokens.of(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        behavior: SnackBarBehavior.floating,
        backgroundColor: background.withAlpha(220),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(tokens.radius.medium),
        ),
        padding: EdgeInsets.all(tokens.spacing.small),
        content: AppSnackBarContent(
          type: type,
          message: message,
          actionLabel: actionLabel,
          onAction: onAction,
        ),
      ),
    );
  }
}

/// Semantic severity levels for [AppSnackBar] and [AppSnackBarContent].
enum SnackBarType {
  success,
  info,
  warning,
  error;

  /// Returns the background [Color] for this type from [AppColors].
  Color background(BuildContext context) {
    final colors = AppColors.of(context);

    return switch (this) {
      success => colors.success,
      info => colors.primary,
      warning => colors.warning,
      error => colors.error,
    };
  }

  /// Returns the leading [IconData] shown in [AppSnackBarContent].
  IconData icon() {
    return switch (this) {
      success => AppIcons.check,
      info => AppIcons.information,
      warning => AppIcons.information,
      error => AppIcons.error,
    };
  }
}
