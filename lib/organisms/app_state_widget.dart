import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

enum AppStateType { empty, error }

class AppStateWidget extends StatelessWidget {
  final AppStateType type;
  final String? image;
  final IconData? icon;
  final double? widthImage;
  final double? heightImage;
  final double? iconSize;
  final Color? iconColor;
  final String title;
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
