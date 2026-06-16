import 'package:atomic_design/atoms/app_animations.dart';
import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

/// The four visual states managed by [AppGridView].
enum GridViewType {
  /// Renders the grid built from [AppGridView.itemBuilder].
  list,

  /// Renders [AppGridView.errorWidget] centred inside a constrained container.
  error,

  /// Renders [AppGridView.emptyWidget] centred inside a constrained container.
  empty,

  /// Renders a shimmer skeleton grid whose column count and aspect ratio match
  /// the real grid.
  loading,
}

/// A responsive grid with four animated states: list, loading, empty, and error.
///
/// The component owns the [GridView] — pass [itemBuilder] and [itemCount]
/// instead of a pre-built widget. The column count is resolved automatically
/// from the screen width for both the real grid and the loading skeleton,
/// so they always match.
///
/// ```dart
/// AppGridView(
///   type: _state,
///   itemCount: _items.length,
///   itemBuilder: (context, index) => ItemCard(item: _items[index]),
///   childAspectRatio: 0.75,
///   emptyWidget: AppStateWidget(type: AppStateType.empty, ...),
///   errorWidget: AppStateWidget(type: AppStateType.error, ...),
/// )
/// ```
///
/// Responsive column breakpoints (logical pixels):
/// - 1 col — < 360
/// - 2 cols — 360 – 599
/// - 3 cols — 600 – 839
/// - 4 cols — ≥ 840
///
/// See also:
/// - [AppCardList], which provides the same four states for a list layout.
/// - [AppStateWidget], the recommended widget for [emptyWidget] / [errorWidget].
class AppGridView extends StatelessWidget {
  /// Widget shown when [type] is [GridViewType.empty].
  final Widget emptyWidget;

  /// Widget shown when [type] is [GridViewType.error].
  final Widget errorWidget;

  /// Builds each grid item. Receives the [BuildContext] and the item index.
  final IndexedWidgetBuilder itemBuilder;

  /// Total number of items in the grid.
  final int itemCount;

  final GridViewType type;

  /// Ratio of cross-axis to main-axis extent for each grid cell.
  /// Applied to both the real grid and the loading skeleton. Defaults to `1.0`.
  final double childAspectRatio;

  /// Duration of the cross-fade animation between states.
  final Duration switchDuration;

  const AppGridView({
    super.key,
    required this.emptyWidget,
    required this.errorWidget,
    required this.itemBuilder,
    required this.itemCount,
    required this.type,
    this.childAspectRatio = 1.0,
    this.switchDuration = AppAnimations.standard,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: switchDuration,
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: _screenState(context),
    );
  }

  Widget _screenState(BuildContext context) {
    switch (type) {
      case GridViewType.list:
        return KeyedSubtree(
          key: const ValueKey('list'),
          child: _RealGrid(
            itemCount: itemCount,
            itemBuilder: itemBuilder,
            childAspectRatio: childAspectRatio,
          ),
        );
      case GridViewType.error:
        return _ContainerErrorAndEmpty(
          key: const ValueKey('error'),
          child: errorWidget,
        );
      case GridViewType.empty:
        return _ContainerErrorAndEmpty(
          key: const ValueKey('empty'),
          child: emptyWidget,
        );
      case GridViewType.loading:
        return _LoadingGridView(
          key: const ValueKey('loading'),
          childAspectRatio: childAspectRatio,
        );
    }
  }
}

class _RealGrid extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double childAspectRatio;

  const _RealGrid({
    required this.itemBuilder,
    required this.itemCount,
    required this.childAspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final crossAxisCount = _columnCount(MediaQuery.sizeOf(context).width);

    return GridView.builder(
      padding: EdgeInsets.all(tokens.spacing.small),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: tokens.spacing.xSmall,
        crossAxisSpacing: tokens.spacing.xSmall,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}

class _LoadingGridView extends StatelessWidget {
  final double childAspectRatio;

  const _LoadingGridView({super.key, required this.childAspectRatio});

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final crossAxisCount = _columnCount(MediaQuery.sizeOf(context).width);

    return GridView.builder(
      padding: EdgeInsets.all(tokens.spacing.small),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: tokens.spacing.small,
        crossAxisSpacing: tokens.spacing.small,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: 8,
      itemBuilder: (_, _) => AppCard(isLoading: true, child: const SizedBox()),
    );
  }
}

int _columnCount(double width) {
  if (width < 360) return 1;
  if (width < 600) return 2;
  if (width < 840) return 3;
  return 4;
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
