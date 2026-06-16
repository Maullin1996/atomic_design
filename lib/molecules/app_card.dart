import 'package:atomic_design/atoms/app_animations.dart';
import 'package:atomic_design/atoms/tokens.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// A themed card container with an optional shimmer skeleton loading state.
///
/// Wraps Material's [Card] widget and adds an [AnimatedSwitcher] that
/// transitions between the skeleton and the real [child] using a combined
/// fade + slide animation.
///
/// ```dart
/// AppCard(
///   padding: EdgeInsets.all(16),
///   isLoading: _isLoading,
///   child: MyContent(),
/// )
/// ```
///
/// When [isLoading] is `true`, a shimmer skeleton of height [loadingHeight]
/// (default 120 px) is shown instead of [child]. The transition duration is
/// controlled by [switchDuration].
class AppCard extends StatelessWidget {
  /// Override for the card background color. Defaults to the theme card color.
  final Color? color;

  final Widget child;

  /// Padding applied inside the card, around [child] and the loading skeleton.
  final EdgeInsetsGeometry padding;

  /// When `true`, shows a shimmer skeleton instead of [child].
  final bool isLoading;

  /// Height of the shimmer skeleton in logical pixels. Defaults to `120`.
  final double? loadingHeight;

  /// Duration of the fade + slide transition between states.
  final Duration switchDuration;

  const AppCard({
    super.key,
    this.color,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.isLoading = false,
    this.loadingHeight,
    this.switchDuration = AppAnimations.standard,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Padding(
        padding: padding,
        child: AnimatedSwitcher(
          duration: switchDuration,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.05),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: isLoading
              ? _buildShimmer(context)
              : KeyedSubtree(key: const ValueKey('content'), child: child),
        ),
      ),
    );
  }

  Widget _buildShimmer(BuildContext context) {
    final colors = AppColors.of(context);
    final tokens = AppTokens.of(context);

    return Shimmer.fromColors(
      key: const ValueKey('shimmer'),
      baseColor: colors.surfaceHigh,
      highlightColor: colors.surfaceMid,
      child: Container(
        padding: EdgeInsets.all(tokens.spacing.xSmall),
        height: loadingHeight ?? 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _box(double.infinity, 14, tokens.radius.small),
            const SizedBox(height: 10),
            _box(180, 12, tokens.radius.small),
            const SizedBox(height: 16),
            _box(double.infinity, 10, tokens.radius.small),
            const SizedBox(height: 8),
            _box(220, 10, tokens.radius.small),
          ],
        ),
      ),
    );
  }

  Widget _box(double width, double height, double radius) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white, // Shimmer.fromColors needs a solid color here
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
