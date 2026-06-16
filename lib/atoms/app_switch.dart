import 'package:atomic_design/atoms/app_text.dart';
import 'package:atomic_design/atoms/app_tokens.dart';
import 'package:flutter/material.dart';

/// A themed switch with an optional leading label.
///
/// Colors are driven by the `switchTheme` set in [AppThemes]. When [label] is
/// provided the entire row is tappable — the user does not have to hit the
/// thumb precisely.
///
/// ```dart
/// AppSwitch(
///   value: _notifications,
///   label: const Text('Enable notifications'),
///   onChanged: (v) => setState(() => _notifications = v),
/// )
///
/// // Switch only, no label
/// AppSwitch(
///   value: _darkMode,
///   onChanged: (v) => setState(() => _darkMode = v),
/// )
/// ```
///
/// When [onChanged] is `null` the switch is rendered in a disabled state.
class AppSwitch extends StatelessWidget {
  /// Current toggle state.
  final bool value;

  /// Called with the new value when the user taps the switch or the label row.
  /// Pass `null` to disable the switch.
  final ValueChanged<bool>? onChanged;

  /// Optional widget displayed to the left of the switch. Typically a [Text]
  /// or [AppText] widget. When provided the whole row becomes tappable.
  final Widget? label;

  const AppSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final sw = Switch(value: value, onChanged: onChanged);

    if (label == null) return sw;

    final tokens = AppTokens.of(context);
    final enabled = onChanged != null;

    return InkWell(
      onTap: enabled ? () => onChanged!(!value) : null,
      borderRadius: BorderRadius.circular(tokens.radius.small),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: tokens.spacing.xSmall,
          horizontal: tokens.spacing.xSmall,
        ),
        child: Row(
          children: [
            Expanded(
              child: DefaultTextStyle.merge(
                style: TextStyle(
                  color: enabled
                      ? null
                      : Theme.of(context).disabledColor,
                ),
                child: label!,
              ),
            ),
            SizedBox(width: tokens.spacing.small),
            sw,
          ],
        ),
      ),
    );
  }
}
