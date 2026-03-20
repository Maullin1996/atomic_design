import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

class AppSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final String hintText;

  const AppSearchBar({
    super.key,
    this.controller,
    this.onChanged,
    this.enabled = true,
    this.hintText = 'Buscar…',
  });

  @override
  Widget build(BuildContext context) {
    return AppInputText(
      label: hintText,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      textEditingController: controller,
      onChange: onChanged,
      prefixIcon: Icon(
        Icons.search_rounded,
        color: AppColors.of(context).textSecondary,
      ),
    );
  }
}
