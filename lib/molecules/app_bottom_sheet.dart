import 'package:flutter/material.dart';

import '../atoms/tokens.dart';

/// A themed modal bottom sheet with optional title, subtitle, custom content,
/// and confirm / cancel actions.
///
/// The preferred way to show it is via the static [AppBottomSheet.show]
/// factory, which calls [showModalBottomSheet] with the correct settings:
///
/// ```dart
/// AppBottomSheet.show(
///   context,
///   title: 'Delete account',
///   subtitle: 'This action cannot be undone.',
///   confirmLabel: 'Delete',
///   cancelLabel: 'Cancel',
///   isDangerous: true,
///   onConfirm: _deleteAccount,
/// );
/// ```
///
/// When [isLoading] is `true`:
/// - The confirm button shows a loading indicator.
/// - Dismissal by drag or barrier tap is disabled regardless of
///   [isDismissible].
///
/// When [isDangerous] is `true`, the title and confirm button use the error
/// color from [AppColors].
///
/// The sheet is capped at 90 % of the screen height and automatically
/// shifts up to accommodate the on-screen keyboard.
class AppBottomSheet extends StatelessWidget {
  final String? title;
  final String? subtitle;

  /// Arbitrary widget placed between [subtitle] and the action buttons.
  final Widget? content;

  /// Label for the primary action button. When `null`, no confirm button is shown.
  final String? confirmLabel;

  /// Label for the secondary text button. When `null`, the confirm button
  /// spans the full width.
  final String? cancelLabel;

  final VoidCallback? onConfirm;

  /// Called when the cancel button is tapped. The sheet is automatically
  /// popped after this callback returns.
  final VoidCallback? onCancel;

  /// When `true`, the confirm button is disabled and shows a loading indicator.
  /// Dismissal is also disabled while loading.
  final bool isLoading;

  /// When `true`, the title and confirm button are styled with the error color.
  final bool isDangerous;

  /// When `true`, a drag handle is rendered at the top of the sheet.
  final bool showHandle;

  /// When `false`, the sheet cannot be dismissed by tapping the barrier or
  /// dragging. Has no effect while [isLoading] is `true`.
  final bool isDismissible;

  const AppBottomSheet({
    super.key,
    this.title,
    this.subtitle,
    this.content,
    this.confirmLabel,
    this.cancelLabel,
    this.onConfirm,
    this.onCancel,
    this.isLoading = false,
    this.isDangerous = false,
    this.showHandle = true,
    this.isDismissible = true,
  });

  /// Shows the bottom sheet as a modal overlay.
  ///
  /// Returns the value passed to [Navigator.pop] when the sheet is dismissed,
  /// or `null` if it was closed without a result.
  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    String? subtitle,
    Widget? content,
    String? confirmLabel,
    String? cancelLabel,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool isLoading = false,
    bool isDangerous = false,
    bool showHandle = true,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible && !isLoading,
      enableDrag: isDismissible && !isLoading,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AppBottomSheet(
        title: title,
        subtitle: subtitle,
        content: content,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        onConfirm: onConfirm,
        onCancel: onCancel,
        isLoading: isLoading,
        isDangerous: isDangerous,
        showHandle: showHandle,
        isDismissible: isDismissible,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final tokens = AppTokens.of(context);

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: screenHeight * 0.90 - bottomInset),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surfaceLow,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(tokens.radius.extraLarge),
            topRight: Radius.circular(tokens.radius.extraLarge),
          ),
        ),
        padding: EdgeInsets.fromLTRB(
          tokens.spacing.smallMedium,
          tokens.spacing.small,
          tokens.spacing.smallMedium,
          tokens.spacing.smallMedium + bottomInset,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showHandle)
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: EdgeInsets.only(bottom: tokens.spacing.small),
                  decoration: BoxDecoration(
                    color: colors.border,
                    borderRadius: BorderRadius.circular(tokens.radius.small),
                  ),
                ),
              ),

            if (title != null)
              AppText.h5(
                title!,
                color: isDangerous ? colors.error : colors.textPrimary,
                maxLines: 2,
              ),

            if (subtitle != null) ...[
              SizedBox(height: tokens.spacing.xSmall),
              Text(
                subtitle!,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: colors.textSecondary),
              ),
            ],

            if (content != null) ...[
              SizedBox(height: tokens.spacing.small),
              content!,
            ],

            if (confirmLabel != null || cancelLabel != null) ...[
              SizedBox(height: tokens.spacing.smallMedium),
              _buildButtons(context, colors),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context, colors) {
    final tokens = AppTokens.of(context);
    if (cancelLabel == null && confirmLabel != null) {
      return SizedBox(
        width: double.infinity,
        child: _ConfirmButton(
          label: confirmLabel!,
          isLoading: isLoading,
          isDangerous: isDangerous,
          onPressed: onConfirm,
        ),
      );
    }

    return Row(
      children: [
        if (cancelLabel != null)
          Expanded(
            child: AppButtons(
              type: ButtonType.primaryTextButton,
              title: Text(cancelLabel!),
              onPressed: isLoading
                  ? null
                  : () {
                      onCancel?.call();
                      Navigator.of(context).pop();
                    },
            ),
          ),
        if (cancelLabel != null) SizedBox(width: tokens.spacing.xSmall),
        if (confirmLabel != null)
          Expanded(
            child: _ConfirmButton(
              label: confirmLabel!,
              isLoading: isLoading,
              isDangerous: isDangerous,
              onPressed: onConfirm,
            ),
          ),
      ],
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
          minimumSize: const Size(double.infinity, 44),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(tokens.radius.medium),
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
