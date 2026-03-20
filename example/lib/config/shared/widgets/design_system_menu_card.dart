import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

class DesignSystemMenuCard extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String? image;
  final VoidCallback onTap;
  const DesignSystemMenuCard({
    super.key,
    required this.title,
    this.icon,
    this.image,
    required this.onTap,
  }) : assert(
         icon != null || image != null,
         'Either icon or image must be provided',
       );

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final colors = AppColors.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(tokens.radius.medium),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(tokens.spacing.small),
        decoration: BoxDecoration(
          color: colors.surfaceLow,
          border: Border.all(color: colors.border),
          borderRadius: BorderRadius.circular(tokens.radius.medium),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Visual(icon: icon, image: image),
              SizedBox(height: tokens.spacing.small),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Visual extends StatelessWidget {
  final IconData? icon;
  final String? image;

  const _Visual({this.icon, this.image});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      height: 56,
      width: 56,
      decoration: BoxDecoration(
        color: icon != null ? colors.primary.withAlpha(31) : null,
        shape: icon != null ? BoxShape.circle : BoxShape.rectangle,
      ),
      alignment: Alignment.center,
      child: icon != null
          ? Icon(icon, size: 28)
          : Image.asset(image!, fit: BoxFit.contain, height: 56, width: 56),
    );
  }
}
