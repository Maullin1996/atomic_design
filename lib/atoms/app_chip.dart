import 'package:atomic_design/atoms/app_colors.dart';
import 'package:atomic_design/atoms/app_tokens.dart';
import 'package:flutter/material.dart';

/// A read-only display chip with an optional leading avatar and delete button.
///
/// Use this for tags, categories, and selected-value labels. For chips the
/// user can toggle on/off, use [AppFilterChip] instead.
///
/// ```dart
/// // Simple tag
/// AppChip(label: 'Flutter')
///
/// // With delete
/// AppChip(
///   label: 'Flutter',
///   onDeleted: () => _removeTech('Flutter'),
/// )
///
/// // With avatar
/// AppChip(
///   label: 'Jane',
///   avatar: CircleAvatar(child: Text('J')),
///   onDeleted: _removeJane,
/// )
/// ```
///
/// See also:
/// - [AppFilterChip], for toggleable filter chips.
class AppChip extends StatelessWidget {
  final String label;

  /// Optional widget shown before the label (e.g. a [CircleAvatar] or [Icon]).
  final Widget? avatar;

  /// When non-null, a delete icon is shown after the label and this callback
  /// is invoked when the user taps it.
  final VoidCallback? onDeleted;

  /// Background color override. Defaults to `AppColors.surfaceHigh`.
  final Color? backgroundColor;

  /// Text color override. Defaults to `AppColors.textPrimary`.
  final Color? textColor;

  const AppChip({
    super.key,
    required this.label,
    this.avatar,
    this.onDeleted,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final tokens = AppTokens.of(context);

    return Chip(
      label: Text(label, style: TextStyle(color: textColor ?? colors.textPrimary)),
      avatar: avatar,
      onDeleted: onDeleted,
      deleteIcon: const Icon(Icons.close, size: 16),
      deleteIconColor: colors.textSecondary,
      backgroundColor: backgroundColor ?? colors.surfaceHigh,
      side: BorderSide(color: colors.border),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(tokens.radius.extraLarge),
      ),
      labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: colors.textPrimary,
      ),
      padding: EdgeInsets.symmetric(horizontal: tokens.spacing.xSmall),
    );
  }
}

/// A toggleable filter chip.
///
/// Use this when the user can activate/deactivate a filter or category.
/// For read-only tags, use [AppChip] instead.
///
/// ```dart
/// AppFilterChip(
///   label: 'In stock',
///   selected: _inStock,
///   onSelected: (v) => setState(() => _inStock = v),
/// )
///
/// // With leading icon
/// AppFilterChip(
///   label: 'Favorites',
///   selected: _favorites,
///   avatar: Icon(Icons.favorite_border, size: 16),
///   onSelected: (v) => setState(() => _favorites = v),
/// )
/// ```
///
/// When [onSelected] is `null` the chip is rendered in a disabled state.
///
/// See also:
/// - [AppChip], for read-only display chips.
class AppFilterChip extends StatelessWidget {
  final String label;

  /// Whether this chip is currently active.
  final bool selected;

  /// Called with the new selected state when the user taps the chip.
  /// Pass `null` to disable interaction.
  final ValueChanged<bool>? onSelected;

  /// Optional widget shown before the label.
  final Widget? avatar;

  const AppFilterChip({
    super.key,
    required this.label,
    required this.selected,
    this.onSelected,
    this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final tokens = AppTokens.of(context);

    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      avatar: avatar,
      backgroundColor: colors.surfaceHigh,
      selectedColor: colors.primary.withAlpha(30),
      checkmarkColor: colors.primary,
      side: BorderSide(
        color: selected ? colors.primary : colors.border,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(tokens.radius.extraLarge),
      ),
      labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: selected ? colors.primary : colors.textPrimary,
        fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
      ),
      padding: EdgeInsets.symmetric(horizontal: tokens.spacing.xSmall),
      showCheckmark: true,
    );
  }
}
