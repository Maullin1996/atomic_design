import 'package:atomic_design/atoms/app_tokens.dart';
import 'package:flutter/widgets.dart';

abstract class AppTypography {
  static String fontFamilyOf(BuildContext ctx) =>
      AppTokens.of(ctx).typography.fontFamily;
  static double captionOf(BuildContext ctx) =>
      AppTokens.of(ctx).typography.caption;
  static double labelOf(BuildContext ctx) => AppTokens.of(ctx).typography.label;
  static double bodyOf(BuildContext ctx) => AppTokens.of(ctx).typography.body;
  static double bodyLgOf(BuildContext ctx) =>
      AppTokens.of(ctx).typography.bodyLg;
  static double h6Of(BuildContext ctx) => AppTokens.of(ctx).typography.h6;
  static double h5Of(BuildContext ctx) => AppTokens.of(ctx).typography.h5;
  static double h4Of(BuildContext ctx) => AppTokens.of(ctx).typography.h4;
  static double h3Of(BuildContext ctx) => AppTokens.of(ctx).typography.h3;
  static double h2Of(BuildContext ctx) => AppTokens.of(ctx).typography.h2;
  static double h1Of(BuildContext ctx) => AppTokens.of(ctx).typography.h1;
}
