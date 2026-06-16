import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

/// The two semantic states represented by [AppStateWidget].
enum AppStateType {
  /// Neutral empty state — uses default text color.
  empty,

  /// Error state — title and icon use the error color from [AppColors].
  error,
}

/// A full-page empty or error state widget with a visual, a title, and a
/// primary action button.
///
/// Provide either [image] (asset path) or [icon] ([IconData]) as the visual
/// — at least one must be non-null (asserted at construction time).
///
/// ```dart
/// AppStateWidget(
///   type: AppStateType.empty,
///   image: 'assets/images/empty_icon.png',
///   widthImage: 120,
///   heightImage: 120,
///   title: 'No results found',
///   buttonChild: Text('Try again'),
///   onPressed: _retry,
/// )
/// ```
///
/// When [type] is [AppStateType.error], the title and icon are tinted with
/// [AppColors.error].
///
/// Typically used as the [emptyWidget] or [errorWidget] inside [AppCardList]
/// or [AppGridView].
class AppStateWidget extends StatelessWidget {
  final AppStateType type;

  /// Asset path for the image visual. Mutually optional with [icon] — one
  /// must be provided.
  final String? image;

  /// Icon visual. Used when [image] is `null`.
  final IconData? icon;

  final double? widthImage;
  final double? heightImage;
  final double? iconSize;

  /// Overrides the icon color. Defaults to [AppColors.error] for
  /// [AppStateType.error] and the inherited icon color otherwise.
  final Color? iconColor;

  /// Heading text displayed below the visual.
  final String title;

  /// The content of the primary action button (e.g. `Text('Retry')`).
  final Widget buttonChild;

  final VoidCallback onPressed;

  const AppStateWidget({
    super.key,
    required this.type,
    required this.title,
    required this.buttonChild,
    required this.onPressed,
    this.image,
    this.icon,
    this.widthImage,
    this.heightImage,
    this.iconSize,
    this.iconColor,
  }) : assert(
         image != null || icon != null,
         'AppStateWidget requiere image o icon',
       );

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _visual(context),
        SizedBox(height: tokens.spacing.small),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: type == AppStateType.error
                ? AppColors.of(context).error
                : null,
          ),
        ),
        SizedBox(height: tokens.spacing.small),
        SizedBox(
          width: double.infinity,
          child: AppButtons(
            type: ButtonType.primaryFillButton,
            onPressed: onPressed,
            title: buttonChild,
          ),
        ),
      ],
    );
  }

  Widget _visual(BuildContext context) {
    if (image != null) {
      return AppAssetsImage(
        path: image!,
        errorWidget: Icon(AppIcons.error),
        widthImage: widthImage,
        heightImage: heightImage,
      );
    }
    return Icon(
      icon!,
      size: iconSize,
      color:
          iconColor ??
          (type == AppStateType.error ? AppColors.of(context).error : null),
    );
  }
}
