import 'package:atomic_design/atoms/app_buttons.dart';
import 'package:flutter/material.dart';

class ButtonToken {
  final String title;
  final ButtonType type;
  final bool hasIcon;
  final Object? heroTag;
  final ShapeBorder? shape;

  const ButtonToken({
    required this.title,
    required this.type,
    this.hasIcon = false,
    this.heroTag,
    this.shape,
  });
}
