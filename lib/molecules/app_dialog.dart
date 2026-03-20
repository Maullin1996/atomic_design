import 'package:flutter/material.dart';

import '../atoms/tokens.dart';

class AppDialog extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? content;
  final String confirmLabel;
  final String? cancelLabel;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool isLoading;
  final bool isDangerous; // para acciones destructivas como "Eliminar"

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

  // ── Método estático para mostrarlo fácilmente ──────────────
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
          maxWidth:
              screenWidth *
              0.90, // máx 90% del ancho — nunca se pega a los bordes
          maxHeight:
              screenHeight *
              0.80, // máx 80% del alto — deja aire arriba y abajo
        ),
        child: Padding(
          padding: EdgeInsets.all(tokens.spacing.smallMedium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Título ──────────────────────────────────────
              AppText.h5(
                title,
                color: isDangerous ? colors.error : colors.textPrimary,
                maxLines: 2,
              ),

              // ── Subtítulo ────────────────────────────────────
              if (subtitle != null) ...[
                SizedBox(height: tokens.spacing.xSmall),
                AppText.body(
                  subtitle!,
                  color: colors.textSecondary,
                  maxLines: 3,
                ),
              ],

              // ── Contenido custom ─────────────────────────────
              if (content != null) ...[
                SizedBox(height: tokens.spacing.small),
                content!,
              ],

              SizedBox(height: tokens.spacing.smallMedium),

              // ── Botones ──────────────────────────────────────
              Row(
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

// ── Botón de confirmación con variante danger ─────────────────
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
      // Botón rojo para acciones destructivas
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
