import 'package:flutter/material.dart';

/// Animation duration and curve constants for the design system.
///
/// Use these instead of hardcoded `Duration(milliseconds: 300)` values so
/// that transitions stay consistent and can be updated from a single place.
///
/// ```dart
/// AnimatedSwitcher(
///   duration: AppAnimations.standard,
///   child: ...,
/// )
///
/// CurvedAnimation(
///   parent: controller,
///   curve: AppAnimations.easeOut,
/// )
/// ```
abstract class AppAnimations {
  /// 150 ms — icon swaps, micro-interactions, immediate feedback.
  static const Duration fast = Duration(milliseconds: 150);

  /// 300 ms — default transition used across the design system for state
  /// changes, card shimmer switches, and overlay reveals.
  static const Duration standard = Duration(milliseconds: 300);

  /// 500 ms — large layout shifts, page-level entries.
  static const Duration slow = Duration(milliseconds: 500);

  /// Symmetric ease — appropriate for elements that enter and exit in place.
  static const Curve easeInOut = Curves.easeInOut;

  /// Decelerating ease — appropriate for elements entering the screen.
  static const Curve easeOut = Curves.easeOut;

  /// Accelerating ease — appropriate for elements leaving the screen.
  static const Curve easeIn = Curves.easeIn;
}
