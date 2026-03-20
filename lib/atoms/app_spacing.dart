import 'package:atomic_design/atoms/app_tokens.dart';
import 'package:flutter/widgets.dart';

abstract class AppSpacing {
  static double xSmallOf(BuildContext ctx) => AppTokens.of(ctx).spacing.xSmall;
  static double smallOf(BuildContext ctx) => AppTokens.of(ctx).spacing.small;
  static double smallMediumOf(BuildContext ctx) =>
      AppTokens.of(ctx).spacing.smallMedium;
  static double mediumOf(BuildContext ctx) => AppTokens.of(ctx).spacing.medium;
  static double mediumLargeOf(BuildContext ctx) =>
      AppTokens.of(ctx).spacing.mediumLarge;
  static double largeOf(BuildContext ctx) => AppTokens.of(ctx).spacing.large;
  static double extraLargeOf(BuildContext ctx) =>
      AppTokens.of(ctx).spacing.extraLarge;
}
