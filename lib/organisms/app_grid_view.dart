import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

enum GridViewType { list, error, empty, loading }

class AppGridView extends StatelessWidget {
  final Widget emptyWidget;
  final Widget errorWidget;
  final Widget elementsList;
  final GridViewType type;
  final Duration switchDuration;

  const AppGridView({
    super.key,
    required this.emptyWidget,
    required this.errorWidget,
    required this.elementsList,
    required this.type,
    this.switchDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: switchDuration,
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: _screenState(),
    );
  }

  Widget _screenState() {
    switch (type) {
      case GridViewType.list:
        return KeyedSubtree(key: const ValueKey('list'), child: elementsList);
      case GridViewType.error:
        return _ContainerErrorAndEmpty(
          key: const ValueKey('list'),
          child: errorWidget,
        );
      case GridViewType.empty:
        return _ContainerErrorAndEmpty(
          key: const ValueKey('empty'),
          child: emptyWidget,
        );
      case GridViewType.loading:
        return _LoadingGridView();
    }
  }
}

class _LoadingGridView extends StatelessWidget {
  const _LoadingGridView();

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final crossAxisCount = _columnCount(width);
    return GridView.builder(
      key: const ValueKey('loading'),
      padding: EdgeInsets.all(tokens.spacing.small),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: tokens.spacing.small,
        crossAxisSpacing: tokens.spacing.small,
        childAspectRatio: 1,
      ),
      itemCount: 8,
      itemBuilder: (_, _) => AppCard(isLoading: true, child: const SizedBox()),
    );
  }

  int _columnCount(double width) {
    if (width < 360) return 1;
    if (width < 414) return 2;
    if (width < 600) return 2;
    if (width < 840) return 3;
    return 4;
  }
}

class _ContainerErrorAndEmpty extends StatelessWidget {
  final Widget child;

  const _ContainerErrorAndEmpty({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final maxWidth = screenWidth < 600
        ? screenWidth * 0.80
        : screenWidth * 0.50.clamp(0.0, 420.0);
    final tokens = AppTokens.of(context);

    return Center(
      child: Container(
        padding: EdgeInsets.all(tokens.spacing.small),
        constraints: BoxConstraints(maxWidth: maxWidth),
        decoration: BoxDecoration(
          color: AppColors.of(context).surfaceHigh,
          borderRadius: BorderRadius.circular(tokens.radius.medium),
        ),
        child: child,
      ),
    );
  }
}
