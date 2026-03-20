import 'package:atomic_design/atoms/tokens.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppCard extends StatelessWidget {
  final Color? color;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool isLoading;
  final double? loadingHeight;
  final Duration switchDuration;

  const AppCard({
    super.key,
    this.color,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.isLoading = false,
    this.loadingHeight,
    this.switchDuration = const Duration(milliseconds: 300),
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
        color: Colors.white, // Shimmer.fromColors necesita un color sólido aquí
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
