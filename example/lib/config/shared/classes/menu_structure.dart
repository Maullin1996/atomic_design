import 'package:flutter/material.dart';

class MenuStructure {
  final String title;
  final String? image;
  final IconData? icon;
  final String route;

  const MenuStructure({
    required this.title,
    this.image,
    required this.route,
    this.icon,
  });
}
