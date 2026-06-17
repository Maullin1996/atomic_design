import 'package:flutter/material.dart';

import '../atoms/tokens.dart';

/// A themed confirmation dialog with optional subtitle, custom content, and
/// confirm / cancel actions.
///
/// The preferred way to show it is via the static [AppDialog.show] factory,
/// which wraps [showDialog] with the correct settings:
///
/// ```dart
/// AppDialog.show(
///   context,
///   title: 'Delete item?',
///   subtitle: 'This cannot be undone.',
///   confirmLabel: 'Delete',
///   cancelLabel: 'Cancel',
///   isDangerous: true,
///   onConfirm: _deleteItem,
/// );
/// ```
///
/// When [isLoading] is `true`:
/// - The confirm button shows a loading indicator and is disabled.
/// - The barrier tap is disabled — the dialog cannot be dismissed.
///
/// When [isDangerous] is `true`, the title and confirm button are styled
/// with the error color from [AppColors].
///
/// The dialog is capped at 90 % of screen width and 80 % of screen height.
class AppDialog extends StatelessWidget {
  final String title;
  final String? subtitle;

  /// Arbitrary widget placed between [subtitle] and the action buttons.
  final Widget? content;

  /// Label for the primary action button. Defaults to `'Aceptar'`.
  final String confirmLabel;

  /// Label for the secondary text button. When `null`, no cancel button is shown.
  final String? cancelLabel;

  final VoidCallback? onConfirm;

  /// Called when the cancel button is tapped. The dialog is automatically
  /// popped after this callback returns.
  final VoidCallback? onCancel;

  /// When `true`, the confirm button is disabled and shows a loading indicator.
  final bool isLoading;

  /// When `true`, the title and confirm button are styled with the error color.
  final bool isDangerous;

  const AppDialog({
    super.key,
    required this.title,
    this.subtitle,
    this.content,
    this.confirmLabel = 'Aceptar',
    this.cancelLabel,
    this.onConfirm,
    this.onCancel,
    this.isLoading = false,
    this.isDangerous = false,
  });

  /// Shows the dialog as a modal overlay.
  static Future<void> show(
    BuildContext context, {
    required String title,
    String? subtitle,
    Widget? content,
    String confirmLabel = 'Aceptar',
    String? cancelLabel,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool isLoading = false,
    bool isDangerous = false,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: !isLoading,
      builder: (_) => AppDialog(
        title: title,
        subtitle: subtitle,
        content: content,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        onConfirm: onConfirm,
        onCancel: onCancel,
        isLoading: isLoading,
        isDangerous: isDangerous,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final tokens = AppTokens.of(context);
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: screenWidth * 0.90,
          maxHeight: screenHeight * 0.80,
        ),
        child: Padding(
          padding: EdgeInsets.all(tokens.spacing.smallMedium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.h5(
                title,
                color: isDangerous ? colors.error : colors.textPrimary,
                maxLines: 2,
              ),

              if (subtitle != null) ...[
                SizedBox(height: tokens.spacing.xSmall),
                AppText.body(
                  subtitle!,
                  color: colors.textSecondary,
                  maxLines: 3,
                ),
              ],

              if (content != null) ...[
                SizedBox(height: tokens.spacing.small),
                content!,
              ],

              SizedBox(height: tokens.spacing.smallMedium),

              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (cancelLabel != null)
                    AppButtons(
                      type: ButtonType.primaryTextButton,
                      title: Text(cancelLabel!),
                      onPressed: isLoading
                          ? null
                          : () {
                              onCancel?.call();
                              Navigator.of(context).pop();
                            },
                    ),
                  SizedBox(width: tokens.spacing.xSmall),
                  _ConfirmButton(
                    label: confirmLabel,
                    isLoading: isLoading,
                    isDangerous: isDangerous,
                    onPressed: onConfirm,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final bool isDangerous;
  final VoidCallback? onPressed;

  const _ConfirmButton({
    required this.label,
    required this.isLoading,
    required this.isDangerous,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final tokens = AppTokens.of(context);

    if (isDangerous) {
      return ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.error,
          foregroundColor: colors.onError,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(tokens.spacing.medium),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colors.onError,
                ),
              )
            : Text(label),
      );
    }

    return AppButtons(
      type: ButtonType.primaryFillButton,
      title: Text(label),
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}
