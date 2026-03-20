import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

class AppCardList extends StatelessWidget {
  final Widget emptyWidget;
  final Widget errorWidget;
  final Widget elementsList;
  final CardListType type;
  final Duration switchDuration;

  const AppCardList({
    super.key,
    required this.emptyWidget,
    required this.type,
    required this.errorWidget,
    required this.elementsList,
    this.switchDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: switchDuration,
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: screenState(state: type),
    );
  }

  Widget screenState({required CardListType state}) {
    switch (state) {
      case CardListType.list:
        return KeyedSubtree(key: const ValueKey('list'), child: elementsList);
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

enum CardListType { list, error, empty, loading }

class _LoadingCardList extends StatelessWidget {
  const _LoadingCardList();

  @override
  Widget build(BuildContext context) {
    final cardHeight = MediaQuery.sizeOf(context).height * 0.12;
    final tokens = AppTokens.of(context);
    return ListView.separated(
      key: const ValueKey('loading'),
      padding: EdgeInsets.all(tokens.spacing.xSmall),
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
