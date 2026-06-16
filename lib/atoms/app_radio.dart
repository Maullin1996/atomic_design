import 'package:atomic_design/atoms/app_tokens.dart';
import 'package:flutter/material.dart';

/// A themed radio button with an optional trailing label.
///
/// Colors are driven by the active [ColorScheme] (`primary` for the selected
/// state) set in [AppThemes]. When [label] is provided the entire row is
/// tappable.
///
/// [AppRadio] is generic over the group value type `T`. All radio buttons in
/// the same group must share the same type and the same [groupValue] state.
///
/// ```dart
/// // In your state:
/// String _plan = 'free';
///
/// // In your build:
/// AppRadio<String>(
///   value: 'free',
///   groupValue: _plan,
///   label: const Text('Free'),
///   onChanged: (v) => setState(() => _plan = v!),
/// )
/// AppRadio<String>(
///   value: 'pro',
///   groupValue: _plan,
///   label: const Text('Pro'),
///   onChanged: (v) => setState(() => _plan = v!),
/// )
/// ```
///
/// When [onChanged] is `null` the radio button is rendered in a disabled state.
class AppRadio<T> extends StatelessWidget {
  /// The value this radio button represents.
  final T value;

  /// The currently selected value in the group. The button appears selected
  /// when [groupValue] == [value].
  final T? groupValue;

  /// Called with [value] when the user selects this button. Pass `null` to
  /// disable interaction.
  final ValueChanged<T?>? onChanged;

  /// Optional widget displayed to the right of the radio button. Typically a
  /// [Text] or [AppText] widget. When provided the whole row is tappable.
  final Widget? label;

  const AppRadio({
    super.key,
    required this.value,
    required this.groupValue,
    this.onChanged,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final rb = Radio<T>(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
    );

    if (label == null) return rb;

    final tokens = AppTokens.of(context);
    final enabled = onChanged != null;

    return InkWell(
      onTap: enabled ? () => onChanged!(value) : null,
      borderRadius: BorderRadius.circular(tokens.radius.small),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: tokens.spacing.xSmall,
          horizontal: tokens.spacing.xSmall,
        ),
        child: Row(
          children: [
            rb,
            SizedBox(width: tokens.spacing.xSmall),
            Expanded(
              child: DefaultTextStyle.merge(
                style: TextStyle(
                  color: enabled ? null : Theme.of(context).disabledColor,
                ),
                child: label!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
