import 'package:flutter/material.dart';

/// The typographic variants available for [AppText].
///
/// Each variant maps to a slot in Material's [TextTheme]:
///
/// | Variant          | TextTheme slot   | Approx. role |
/// |------------------|------------------|--------------|
/// | displayLarge     | displayLarge     | h1           |
/// | displayMedium    | displayMedium    | h2           |
/// | displaySmall     | displaySmall     | h3           |
/// | headlineMedium   | headlineMedium   | h4           |
/// | headlineSmall    | headlineSmall    | h5           |
/// | titleLarge       | titleLarge       | h6           |
/// | bodyLarge        | bodyLarge        | bodyLg       |
/// | bodyMedium       | bodyMedium       | body (default)|
/// | bodySmall        | bodySmall        | label        |
/// | labelSmall       | labelSmall       | caption      |
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

/// A text widget that reads its style from the active [Theme].
///
/// Use the named constructors for the most common type scales to avoid
/// specifying a [variant] manually:
///
/// ```dart
/// AppText.h4('Section title')
/// AppText.body('Paragraph text', color: colors.textSecondary)
/// AppText.caption('12 items', maxLines: 1)
/// ```
///
/// All named constructors default `overflow` to [TextOverflow.ellipsis].  The
/// base constructor allows a custom [overflow] value.
///
/// See also:
/// - [AppTextVariant], which lists all available type scale variants.
/// - [AppTypography], for raw font-size values when a full widget is not needed.
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

  /// Largest display style — maps to `h1` in the type scale.
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

  /// Second display style — maps to `h2` in the type scale.
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

  /// Third display style — maps to `h3` in the type scale.
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

  /// Section heading — maps to `h4` in the type scale.
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

  /// Sub-section heading — maps to `h5` in the type scale.
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

  /// Small heading / title — maps to `h6` in the type scale.
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

  /// Large body text.
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

  /// Default body text.
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

  /// Small label text — maps to `label` in the type scale.
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

  /// Smallest caption text.
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
