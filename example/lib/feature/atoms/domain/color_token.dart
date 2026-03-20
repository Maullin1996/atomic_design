import 'package:flutter/material.dart';

class ColorToken {
  final String name;
  final Color color;
  final Color? onColor;

  const ColorToken(this.name, this.color, {this.onColor});
}

class ColorGroup {
  final String title;
  final List<ColorToken> tokens;

  const ColorGroup(this.title, this.tokens);
}
