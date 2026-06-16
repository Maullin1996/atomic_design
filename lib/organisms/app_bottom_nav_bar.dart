import 'package:flutter/material.dart';

/// Data model for a single destination in [AppBottomNavBar].
class BottomNavItem {
  /// Icon shown when this destination is not selected.
  final IconData icon;

  /// Icon shown when this destination is selected. Falls back to [icon] when
  /// `null`.
  final IconData? selectedIcon;

  final String label;

  const BottomNavItem({
    required this.icon,
    required this.label,
    this.selectedIcon,
  });
}

/// A Material 3 [NavigationBar] wrapper configured with design-system tokens.
///
/// Requires between 2 and 5 [items] (asserted at construction time).
///
/// ```dart
/// AppBottomNavBar(
///   currentIndex: _selectedIndex,
///   onTap: (i) => setState(() => _selectedIndex = i),
///   items: [
///     BottomNavItem(icon: AppIcons.home, label: 'Home'),
///     BottomNavItem(icon: AppIcons.user,  label: 'Profile'),
///   ],
/// )
/// ```
///
/// Colors (background, indicator, icon) are sourced from the
/// `navigationBarTheme` set by [AppThemes].
class AppBottomNavBar extends StatelessWidget {
  final List<BottomNavItem> items;

  /// Index of the currently active destination.
  final int currentIndex;

  /// Called with the tapped destination index.
  final ValueChanged<int> onTap;

  const AppBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  }) : assert(
         items.length >= 2 && items.length <= 5,
         'BottomNavBar requiere entre 2 y 5 items',
       );

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: items.map((item) {
        return NavigationDestination(
          icon: Icon(item.icon),
          selectedIcon: Icon(item.selectedIcon ?? item.icon),
          label: item.label,
        );
      }).toList(),
    );
  }
}
