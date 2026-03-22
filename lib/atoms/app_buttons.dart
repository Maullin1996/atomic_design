import 'package:atomic_design/atoms/tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppButtons extends StatelessWidget {
  final Widget? title;
  final Widget? iconForFilledButton;
  final IconData? icon;
  final VoidCallback? onPressed;
  final ButtonType type;
  final double? iconSize;
  final bool isLoading;
  final ShapeBorder? shape;
  final Object? heroTag;
  final double? fontSize;
  final Color? color;
  final String? assetsIcon;

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
    this.iconForFilledButton,
    this.assetsIcon,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ButtonType.primaryFillButton:
        return _buildFilledButton(context);
      case ButtonType.primaryIconFillButton:
        return _buildIconFilledButton(context);
      case ButtonType.primaryTextButton:
        return _buildTextButton(context);
      case ButtonType.primaryIconButton:
        return _buildIconButton(context);
      case ButtonType.primaryFloatingButton:
        return _buildFloatingButton(context);
      case ButtonType.primaryImageButton:
        return _buildImageButton(context);
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

  Widget _buildIconFilledButton(BuildContext context) {
    final colors = AppColors.of(context);

    return ElevatedButton.icon(
      onPressed: isLoading ? null : onPressed,
      label: isLoading
          ? SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: color ?? colors.onPrimary,
              ),
            )
          : title ?? Text('Enter title'),
      icon: iconForFilledButton,
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

  Widget _buildImageButton(BuildContext context) {
    final colors = AppColors.of(context);
    final tokens = AppTokens.of(context);

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(tokens.radius.extraLarge),
      child: Ink(
        padding: EdgeInsets.all(tokens.spacing.small),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: colors.border),
        ),
        child: SvgPicture.asset(
          assetsIcon ?? 'assets/icons/apple-mac.svg',
          width: 28,
          height: 28,
          fit: BoxFit.contain,
          package: 'atomic_design',
          colorFilter: ColorFilter.mode(
            color ?? colors.primary,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

enum ButtonType {
  primaryFillButton,
  primaryIconFillButton,
  primaryTextButton,
  primaryIconButton,
  primaryFloatingButton,
  primaryImageButton,
}
