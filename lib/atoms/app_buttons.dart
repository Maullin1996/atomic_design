import 'package:atomic_design/atoms/tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A unified button widget that covers all button variants in the design system.
///
/// Select the variant through the required [type] parameter:
///
/// ```dart
/// // Filled primary button with loading state
/// AppButtons(
///   type: ButtonType.primaryFillButton,
///   title: Text('Save'),
///   isLoading: _isSaving,
///   onPressed: _save,
/// )
///
/// // Icon-only button
/// AppButtons(
///   type: ButtonType.primaryIconButton,
///   icon: AppIcons.edit,
///   onPressed: _edit,
/// )
///
/// // Circular button with an SVG asset from the package
/// AppButtons(
///   type: ButtonType.primaryImageButton,
///   assetsIcon: 'assets/icons/github.svg',
///   onPressed: _loginWithGitHub,
/// )
/// ```
///
/// When [isLoading] is `true`, the button is disabled and a
/// [CircularProgressIndicator] replaces the label or icon.
///
/// See also:
/// - [ButtonType], which documents each available variant.
class AppButtons extends StatelessWidget {
  /// The label widget, used by [ButtonType.primaryFillButton],
  /// [ButtonType.primaryIconFillButton], and [ButtonType.primaryTextButton].
  final Widget? title;

  /// The leading icon for [ButtonType.primaryIconFillButton].
  final Widget? iconForFilledButton;

  /// The icon data for [ButtonType.primaryIconButton] and
  /// [ButtonType.primaryFloatingButton].
  final IconData? icon;

  final VoidCallback? onPressed;

  /// Determines which button variant to render.
  final ButtonType type;

  /// Icon size override for [ButtonType.primaryIconButton].
  final double? iconSize;

  /// When `true`, the button is disabled and shows a loading indicator.
  final bool isLoading;

  /// Shape override for [ButtonType.primaryFloatingButton].
  final ShapeBorder? shape;

  /// Hero tag for [ButtonType.primaryFloatingButton]. Pass `null` to disable
  /// the hero animation when multiple FABs coexist on the same route.
  final Object? heroTag;

  final double? fontSize;

  /// Tint color for [ButtonType.primaryFloatingButton] background and
  /// [ButtonType.primaryIconButton] icon. Also used as the SVG color filter
  /// in [ButtonType.primaryImageButton].
  final Color? color;

  /// Asset path for [ButtonType.primaryImageButton]. Must be a valid SVG path
  /// declared in the `atomic_design` package assets (e.g.
  /// `'assets/icons/github.svg'`).
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

/// The visual and behavioral variants available for [AppButtons].
enum ButtonType {
  /// Full-width filled button. Uses the theme's [ElevatedButton] style.
  primaryFillButton,

  /// Filled button with a leading icon widget ([AppButtons.iconForFilledButton]).
  primaryIconFillButton,

  /// Ghost / text-only button. Uses the theme's [TextButton] style.
  primaryTextButton,

  /// Circular icon-only button. Uses [AppButtons.icon] and [AppButtons.iconSize].
  primaryIconButton,

  /// Material [FloatingActionButton]. Requires [AppButtons.icon].
  primaryFloatingButton,

  /// Circular button that renders an SVG asset from the `atomic_design`
  /// package. Requires [AppButtons.assetsIcon].
  primaryImageButton,
}
