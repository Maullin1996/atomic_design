import 'package:atomic_design_example/config/routes/app_routes.dart';
import 'package:atomic_design_example/config/shared/classes/menu_structure.dart';
import 'package:flutter/material.dart';

abstract class MoleculesMenu {
  static const List<MenuStructure> menu = [
    MenuStructure(
      title: 'Search Bar',
      route: AppRoutes.searchBar,
      icon: Icons.search,
    ),
    MenuStructure(
      title: 'Custom Cards',
      route: AppRoutes.customCard,
      icon: Icons.crop_landscape,
    ),
    MenuStructure(
      title: 'Custom Snack Bar Message',
      icon: Icons.message_outlined,
      route: AppRoutes.snackBar,
    ),
    MenuStructure(
      title: 'Custom Dialogs',
      route: AppRoutes.dialogs,
      icon: Icons.question_answer,
    ),
    MenuStructure(
      title: 'Custom Bottom Sheet',
      route: AppRoutes.bottomSheet,
      icon: Icons.expand_less,
    ),
  ];
}
