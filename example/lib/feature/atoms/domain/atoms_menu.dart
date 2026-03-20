import 'package:atomic_design_example/config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:atomic_design_example/config/shared/classes/menu_structure.dart';

abstract class AtomsMenu {
  static const List<MenuStructure> menu = [
    MenuStructure(
      title: 'Colors',
      icon: Icons.color_lens,
      route: AppRoutes.colors,
    ),
    MenuStructure(
      title: 'Typography',
      icon: Icons.text_format,
      route: AppRoutes.typography,
    ),
    MenuStructure(
      title: 'Buttons',
      icon: Icons.smart_button,
      route: AppRoutes.buttons,
    ),
    MenuStructure(
      title: 'Icons',
      icon: Icons.insert_emoticon,
      route: AppRoutes.icons,
    ),
    MenuStructure(
      title: 'Spacing & Radius',
      route: AppRoutes.spacing,
      icon: Icons.space_bar_outlined,
    ),
    MenuStructure(
      title: 'Input Text',
      icon: Icons.text_fields,
      route: AppRoutes.inputText,
    ),
  ];
}
