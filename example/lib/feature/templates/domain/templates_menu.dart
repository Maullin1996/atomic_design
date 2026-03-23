import 'package:atomic_design_example/config/routes/app_routes.dart';
import 'package:atomic_design_example/config/shared/classes/menu_structure.dart';
import 'package:flutter/material.dart';

abstract class TemplatesMenu {
  static const List<MenuStructure> menu = [
    MenuStructure(
      title: 'List Page',
      route: AppRoutes.listPage,
      icon: Icons.list_alt_rounded,
    ),
  ];
}
