import 'package:atomic_design/atoms/app_animations.dart';
import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

/// An animated overlay that reveals a results panel below a search bar.
///
/// When [child] is non-null the panel slides down and fades in; when it is
/// `null` the panel collapses with a slide-up fade-out transition.
///
/// ```dart
/// Column(
///   children: [
///     AppSearchBar(controller: _controller, onChanged: _onSearch),
///     AppResultSearchBar(
///       child: _results.isEmpty ? null : _ResultsList(items: _results),
///     ),
///   ],
/// )
/// ```
///
/// The panel is capped at 300 logical pixels in height and scrolls when the
/// content overflows.  Background, border, and radius values come from
/// [AppColors] and [AppTokens].
///
/// See also:
/// - [AppSearchBar], the input field typically placed above this widget.
class AppResultSearchBar extends StatelessWidget {
  /// When non-null, the results panel is visible and displays this widget.
  /// Pass `null` to hide the panel.
  final Widget? child;

  /// Duration of the fade + slide transition.
  final Duration switchDuration;

  const AppResultSearchBar({
    super.key,
    this.child,
    this.switchDuration = AppAnimations.standard,
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
                      begin: const Offset(0, -0.05),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(parent: animation, curve: Curves.easeOut),
                    ),
                child: child,
              ),
            );
          },
          child: hasResults
              ? ConstrainedBox(
                  key: const ValueKey('results'),
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: Container(
                    padding: EdgeInsets.all(tokens.spacing.small),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(tokens.radius.small),
                      color: AppColors.of(context).surfaceHigh,
                      border: Border.all(color: AppColors.of(context).border),
                    ),
                    child: child,
                  ),
                )
              : const SizedBox.shrink(key: ValueKey('empty')),
        ),
      ],
    );
  }
}
