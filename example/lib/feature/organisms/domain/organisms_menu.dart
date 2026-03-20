import 'package:atomic_design_example/config/routes/app_routes.dart';
import 'package:atomic_design_example/config/shared/classes/menu_structure.dart';
import 'package:flutter/material.dart';

abstract class OrganismsMenu {
  static const List<MenuStructure> menu = [
    MenuStructure(
      title: 'Search Result',
      route: AppRoutes.searchResults,
      icon: Icons.search,
    ),
    MenuStructure(
      title: 'Card List',
      route: AppRoutes.cardList,
      icon: Icons.list_alt,
    ),
    MenuStructure(
      title: 'Empty State',
      route: AppRoutes.emptyState,
      icon: Icons.inbox,
    ),
    MenuStructure(
      title: 'Error State',
      route: AppRoutes.errorState,
      icon: Icons.close,
    ),
    MenuStructure(
      title: 'Drawer',
      route: AppRoutes.drawer,
      icon: Icons.menu_open,
    ),
    MenuStructure(
      title: 'Bottom Navigation Bar',
      route: AppRoutes.bottomNavBar,
      icon: Icons.home,
    ),
    MenuStructure(
      title: 'Grid View',
      route: AppRoutes.gridView,
      icon: Icons.grid_view_rounded,
    ),
  ];
}
