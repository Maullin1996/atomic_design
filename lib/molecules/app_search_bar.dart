import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

/// A themed search input field with a leading search icon.
///
/// A thin wrapper around [AppInputText] that fixes the label as the hint
/// (via [FloatingLabelBehavior.never]) and prepends a search icon.
///
/// ```dart
/// AppSearchBar(
///   controller: _searchController,
///   onChanged: _onSearch,
///   hintText: 'Search users…',
/// )
/// ```
///
/// Pair with [AppResultSearchBar] to display an animated results overlay
/// beneath the bar.
class AppSearchBar extends StatelessWidget {
  final TextEditingController? controller;

  /// Called with the current text every time the user edits the field.
  final ValueChanged<String>? onChanged;

  /// When `false`, the field is read-only and visually dimmed.
  final bool enabled;

  /// Placeholder text shown inside the field. Defaults to `'Buscar…'`.
  final String hintText;

  final Color? fillColor;

  const AppSearchBar({
    super.key,
    this.controller,
    this.onChanged,
    this.enabled = true,
    this.hintText = 'Buscar…',
    this.fillColor,
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
      fillColor: fillColor,
    );
  }
}
