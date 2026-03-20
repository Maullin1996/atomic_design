import 'package:atomic_design/atoms/tokens.dart';
import 'package:flutter/material.dart';

class AppSnackBarContent extends StatelessWidget {
  final SnackBarType type;
  final String message;
  final String? actionLabel;
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

class AppSnackBar {
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

enum SnackBarType {
  success,
  info,
  warning,
  error;

  Color background(BuildContext context) {
    final colors = AppColors.of(context);

    return switch (this) {
      success => colors.success,
      info => colors.primary,
      warning => colors.warning,
      error => colors.error,
    };
  }

  IconData icon() {
    return switch (this) {
      success => AppIcons.check,
      info => AppIcons.information,
      warning => AppIcons.information,
      error => AppIcons.error,
    };
  }
}
