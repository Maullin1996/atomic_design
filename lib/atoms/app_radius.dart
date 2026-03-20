import 'package:atomic_design/atoms/app_tokens.dart';
import 'package:flutter/widgets.dart';

abstract class AppRadius {
  static double smallOf(BuildContext ctx) => AppTokens.of(ctx).radius.small;
  static double mediumOf(BuildContext ctx) => AppTokens.of(ctx).radius.medium;
  static double largeOf(BuildContext ctx) => AppTokens.of(ctx).radius.large;
  static double extraLargeOf(BuildContext ctx) =>
      AppTokens.of(ctx).radius.extraLarge;
}
