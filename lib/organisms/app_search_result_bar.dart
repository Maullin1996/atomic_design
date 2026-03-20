import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

class AppResultSearchBar extends StatelessWidget {
  final Widget? child;
  final Duration switchDuration;

  const AppResultSearchBar({
    super.key,
    this.child,
    this.switchDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    final hasResults = child != null;
    final tokens = AppTokens.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedSwitcher(
          duration: switchDuration,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position:
                    Tween<Offset>(
                      begin: const Offset(0, -0.05), // ✅ baja suavemente
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(parent: animation, curve: Curves.easeOut),
                    ),
                child: child,
              ),
            );
          },
          // ✅ key le dice al AnimatedSwitcher que el contenido cambió
          child: hasResults
              ? ConstrainedBox(
                  key: const ValueKey('results'),
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: Container(
                    margin: EdgeInsets.only(top: tokens.spacing.small),
                    padding: EdgeInsets.all(tokens.spacing.small),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(tokens.radius.small),
                      color: AppColors.of(context).surfaceMid,
                    ),
                    child: child,
                  ),
                )
              : const SizedBox.shrink(key: ValueKey('empty')), // ✅ key distinta
        ),
      ],
    );
  }
}
