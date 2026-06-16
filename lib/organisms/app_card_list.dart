import 'package:atomic_design/atoms/app_animations.dart';
import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

/// A list container with four animated states: list, loading, empty, and error.
///
/// The component owns the [ListView] — pass [itemBuilder] and [itemCount]
/// instead of a pre-built widget. This ensures the loading skeleton and the
/// real list share the same spacing and layout.
///
/// ```dart
/// AppCardList(
///   type: _state,
///   itemCount: _items.length,
///   itemBuilder: (context, index) => ItemTile(item: _items[index]),
///   emptyWidget: AppStateWidget(type: AppStateType.empty, ...),
///   errorWidget: AppStateWidget(type: AppStateType.error, ...),
/// )
/// ```
///
/// By default, items are separated by a [SizedBox] of height
/// `tokens.spacing.xSmall`. Pass [separatorBuilder] to override this.
///
/// State transitions are animated with a [FadeTransition] whose duration is
/// controlled by [switchDuration].
///
/// See also:
/// - [AppGridView], which provides the same four states for a grid layout.
/// - [AppStateWidget], the recommended widget for [emptyWidget] / [errorWidget].
class AppCardList extends StatelessWidget {
  /// Widget shown when [type] is [CardListType.empty].
  final Widget emptyWidget;

  /// Widget shown when [type] is [CardListType.error].
  final Widget errorWidget;

  /// Builds each list item. Receives the [BuildContext] and the item index.
  final IndexedWidgetBuilder itemBuilder;

  /// Total number of items in the list.
  final int itemCount;

  final CardListType type;

  /// Builds the separator between items. Defaults to a vertical gap of
  /// `tokens.spacing.xSmall` when `null`.
  final IndexedWidgetBuilder? separatorBuilder;

  /// Duration of the cross-fade animation between states.
  final Duration switchDuration;

  const AppCardList({
    super.key,
    required this.emptyWidget,
    required this.errorWidget,
    required this.itemBuilder,
    required this.itemCount,
    required this.type,
    this.separatorBuilder,
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
      case CardListType.list:
        return KeyedSubtree(
          key: const ValueKey('list'),
          child: _RealList(
            itemCount: itemCount,
            itemBuilder: itemBuilder,
            separatorBuilder: separatorBuilder,
          ),
        );
      case CardListType.error:
        return _ContainerErrorAndEmpty(
          key: const ValueKey('error'),
          child: errorWidget,
        );
      case CardListType.empty:
        return _ContainerErrorAndEmpty(
          key: const ValueKey('empty'),
          child: emptyWidget,
        );
      case CardListType.loading:
        return const _LoadingCardList();
    }
  }
}

/// The four visual states managed by [AppCardList].
enum CardListType {
  /// Renders the list built from [AppCardList.itemBuilder].
  list,

  /// Renders [AppCardList.errorWidget] centred inside a constrained container.
  error,

  /// Renders [AppCardList.emptyWidget] centred inside a constrained container.
  empty,

  /// Renders a shimmer skeleton list of 10 [AppCard] placeholders.
  loading,
}

class _RealList extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final IndexedWidgetBuilder? separatorBuilder;

  const _RealList({
    required this.itemBuilder,
    required this.itemCount,
    this.separatorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);

    return ListView.separated(
      padding: EdgeInsets.all(tokens.spacing.small),
      itemCount: itemCount,
      separatorBuilder: separatorBuilder ??
          (_, _) => SizedBox(height: tokens.spacing.xSmall),
      itemBuilder: itemBuilder,
    );
  }
}

class _LoadingCardList extends StatelessWidget {
  const _LoadingCardList();

  @override
  Widget build(BuildContext context) {
    final cardHeight = MediaQuery.sizeOf(context).height * 0.12;
    final tokens = AppTokens.of(context);

    return ListView.separated(
      key: const ValueKey('loading'),
      padding: EdgeInsets.all(tokens.spacing.small),
      itemCount: 10,
      separatorBuilder: (_, _) => SizedBox(height: tokens.spacing.xSmall),
      itemBuilder: (_, _) =>
          AppCard(isLoading: true, child: SizedBox(height: cardHeight)),
    );
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
