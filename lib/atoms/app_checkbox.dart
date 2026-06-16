import 'package:atomic_design/atoms/app_tokens.dart';
import 'package:flutter/material.dart';

/// A themed checkbox with an optional trailing label.
///
/// Colors are driven by the active [ColorScheme] (`primary` for the checked
/// state) set in [AppThemes]. When [label] is provided the entire row is
/// tappable — the user does not have to hit the box precisely.
///
/// ```dart
/// AppCheckbox(
///   value: _accepted,
///   label: const Text('I accept the terms and conditions'),
///   onChanged: (v) => setState(() => _accepted = v ?? false),
/// )
///
/// // Tristate (null = indeterminate)
/// AppCheckbox(
///   value: _partial,
///   tristate: true,
///   label: const Text('Select all'),
///   onChanged: (v) => setState(() => _partial = v),
/// )
/// ```
///
/// When [onChanged] is `null` the checkbox is rendered in a disabled state.
class AppCheckbox extends StatelessWidget {
  /// Current checked state. `null` represents the indeterminate state, which
  /// is only meaningful when [tristate] is `true`.
  final bool? value;

  /// Called with the new value when the user taps the checkbox or the label
  /// row. Pass `null` to disable interaction.
  final ValueChanged<bool?>? onChanged;

  /// Optional widget displayed to the right of the checkbox. Typically a
  /// [Text] or [AppText] widget. When provided the whole row is tappable.
  final Widget? label;

  /// When `true`, the checkbox cycles through `false → true → null`.
  /// Defaults to `false`.
  final bool tristate;

  const AppCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
    this.tristate = false,
  });

  @override
  Widget build(BuildContext context) {
    final cb = Checkbox(
      value: value,
      tristate: tristate,
      onChanged: onChanged,
    );

    if (label == null) return cb;

    final tokens = AppTokens.of(context);
    final enabled = onChanged != null;

    return InkWell(
      onTap: enabled ? () => _toggle() : null,
      borderRadius: BorderRadius.circular(tokens.radius.small),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: tokens.spacing.xSmall,
          horizontal: tokens.spacing.xSmall,
        ),
        child: Row(
          children: [
            cb,
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

  void _toggle() {
    if (onChanged == null) return;
    if (tristate) {
      if (value == false) {
        onChanged!(true);
      } else if (value == true) {
        onChanged!(null);
      } else {
        onChanged!(false);
      }
    } else {
      onChanged!(!(value ?? false));
    }
  }
}
