import 'package:flutter/material.dart';

// Modelo
class BottomNavItem {
  final IconData icon;
  final IconData? selectedIcon;
  final String label;

  const BottomNavItem({
    required this.icon,
    required this.label,
    this.selectedIcon,
  });
}

// Organismo
class AppBottomNavBar extends StatelessWidget {
  final List<BottomNavItem> items;
  final int currentIndex;
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
