import 'package:atomic_design/atoms/tokens.dart';
import 'package:flutter/material.dart';

class AppButtons extends StatelessWidget {
  final Widget? title;
  final IconData? icon;
  final VoidCallback? onPressed;
  final ButtonType type;
  final double? iconSize;
  final bool isLoading;
  final ShapeBorder? shape;
  final Object? heroTag;
  final double? fontSize;
  final Color? color;

  const AppButtons({
    super.key,
    this.title,
    this.icon,
    this.onPressed,
    required this.type,
    this.iconSize,
    this.isLoading = false,
    this.heroTag,
    this.shape,
    this.fontSize,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ButtonType.primaryFillButton:
        return _buildFilledButton(context);
      case ButtonType.primaryTextButton:
        return _buildTextButton(context);
      case ButtonType.primaryIconButton:
        return _buildIconButton(context);
      case ButtonType.primaryFloatingButton:
        return _buildFloatingButton(context);
    }
  }

  Widget _buildFilledButton(BuildContext context) {
    final colors = AppColors.of(context);

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: color ?? colors.onPrimary,
              ),
            )
          : title,
    );
  }

  Widget _buildTextButton(BuildContext context) {
    final colors = AppColors.of(context);
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colors.primary,
              ),
            )
          : title ?? Text('Enter title'),
    );
  }

  Widget _buildIconButton(BuildContext context) {
    final colors = AppColors.of(context);

    return IconButton(
      onPressed: isLoading ? null : onPressed,
      icon: isLoading
          ? SizedBox(
              height: iconSize ?? 20,
              width: iconSize ?? 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colors.primary,
              ),
            )
          : Icon(icon, size: iconSize ?? 24, color: color ?? colors.primary),
    );
  }

  Widget _buildFloatingButton(BuildContext context) {
    final colors = AppColors.of(context);

    return FloatingActionButton(
      onPressed: onPressed,
      heroTag: heroTag,
      shape: shape,
      backgroundColor: color ?? colors.primary,
      foregroundColor: colors.onPrimary,
      child: Icon(icon),
    );
  }
}

enum ButtonType {
  primaryFillButton,
  primaryTextButton,
  primaryIconButton,
  primaryFloatingButton,
}
