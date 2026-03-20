import 'package:flutter/material.dart';

import '../atoms/tokens.dart';

class AppBottomSheet extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget? content;
  final String? confirmLabel;
  final String? cancelLabel;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool isLoading;
  final bool isDangerous;
  final bool showHandle;
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

  // ── Método estático para mostrarlo fácilmente ──────────────
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
      isScrollControlled: true, // permite que crezca con el contenido
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
    // Evita que el teclado tape el contenido cuando hay inputs
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
          tokens.spacing.smallMedium + bottomInset, // respeta el teclado
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Handle ───────────────────────────────────────
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

            // ── Título ───────────────────────────────────────
            if (title != null)
              AppText.h5(
                title!,
                color: isDangerous ? colors.error : colors.textPrimary,
                maxLines: 2,
              ),

            // ── Subtítulo ────────────────────────────────────
            if (subtitle != null) ...[
              SizedBox(height: tokens.spacing.xSmall),
              Text(
                subtitle!,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: colors.textSecondary),
              ),
            ],

            // ── Contenido custom ─────────────────────────────
            if (content != null) ...[
              SizedBox(height: tokens.spacing.small),
              content!,
            ],

            // ── Botones ──────────────────────────────────────
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
    // Si solo hay confirmación, ocupa todo el ancho
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
