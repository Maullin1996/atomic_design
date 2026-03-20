import 'package:flutter/material.dart';

enum AppTextVariant {
  displayLarge, // h1
  displayMedium, // h2
  displaySmall, // h3
  headlineMedium, // h4
  headlineSmall, // h5
  titleLarge, // h6
  bodyLarge, // bodyLg
  bodyMedium, // body  ← default
  bodySmall, // label
  labelSmall, // caption
}

class AppText extends StatelessWidget {
  final String text;
  final AppTextVariant variant;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final FontWeight? fontWeight;
  final bool softWrap;
  const AppText(
    this.text, {
    super.key,
    this.variant = AppTextVariant.bodyMedium,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.fontWeight,
    this.softWrap = true,
  });

  const AppText.h1(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.fontWeight,
    this.softWrap = true,
  }) : variant = AppTextVariant.displayLarge,
       overflow = TextOverflow.ellipsis;

  const AppText.h2(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.fontWeight,
    this.softWrap = true,
  }) : variant = AppTextVariant.displayMedium,
       overflow = TextOverflow.ellipsis;

  const AppText.h3(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.fontWeight,
    this.softWrap = true,
  }) : variant = AppTextVariant.displaySmall,
       overflow = TextOverflow.ellipsis;

  const AppText.h4(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.fontWeight,
    this.softWrap = true,
  }) : variant = AppTextVariant.headlineMedium,
       overflow = TextOverflow.ellipsis;

  const AppText.h5(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.fontWeight,
    this.softWrap = true,
  }) : variant = AppTextVariant.headlineSmall,
       overflow = TextOverflow.ellipsis;

  const AppText.h6(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.fontWeight,
    this.softWrap = true,
  }) : variant = AppTextVariant.titleLarge,
       overflow = TextOverflow.ellipsis;

  const AppText.bodyLg(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.fontWeight,
    this.softWrap = true,
  }) : variant = AppTextVariant.bodyLarge,
       overflow = TextOverflow.ellipsis;

  const AppText.body(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.fontWeight,
    this.softWrap = true,
  }) : variant = AppTextVariant.bodyMedium,
       overflow = TextOverflow.ellipsis;

  const AppText.label(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.fontWeight,
    this.softWrap = true,
  }) : variant = AppTextVariant.bodySmall,
       overflow = TextOverflow.ellipsis;

  const AppText.caption(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.fontWeight,
    this.softWrap = true,
  }) : variant = AppTextVariant.labelSmall,
       overflow = TextOverflow.ellipsis;
  @override
  Widget build(BuildContext context) {
    final base = _resolveStyle(context);

    return Text(
      text,
      style: base?.copyWith(color: color, fontWeight: fontWeight),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  TextStyle? _resolveStyle(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return switch (variant) {
      AppTextVariant.displayLarge => tt.displayLarge,
      AppTextVariant.displayMedium => tt.displayMedium,
      AppTextVariant.displaySmall => tt.displaySmall,
      AppTextVariant.headlineMedium => tt.headlineMedium,
      AppTextVariant.headlineSmall => tt.headlineSmall,
      AppTextVariant.titleLarge => tt.titleLarge,
      AppTextVariant.bodyLarge => tt.bodyLarge,
      AppTextVariant.bodyMedium => tt.bodyMedium,
      AppTextVariant.bodySmall => tt.bodySmall,
      AppTextVariant.labelSmall => tt.labelSmall,
    };
  }
}
