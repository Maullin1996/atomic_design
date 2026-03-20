import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

class AppInputText extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? textEditingController;
  final bool obscureText;
  final void Function(String)? onChange;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextStyle? inputTextStyle;
  final TextInputType? keyboardType;
  final int? maxLines;

  const AppInputText({
    super.key,
    this.label,
    this.hint,
    this.textEditingController,
    this.obscureText = false,
    this.onChange,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.floatingLabelBehavior,
    this.inputTextStyle,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final tokens = AppTokens.of(context);

    return TextFormField(
      controller: textEditingController,
      obscureText: obscureText,
      onChanged: onChange,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style:
          inputTextStyle ??
          TextStyle(
            fontFamily: tokens.typography.fontFamily,
            fontSize: tokens.typography.bodyLg,
            color: colors.textPrimary,
          ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: colors.surfaceMid,
        labelText: label,
        hintText: hint,
        hintStyle: TextStyle(
          color: colors.textDisabled,
          fontFamily: tokens.typography.fontFamily,
          fontSize: tokens.typography.bodyLg,
        ),
        labelStyle: TextStyle(
          color: colors.textSecondary,
          fontFamily: tokens.typography.fontFamily,
          fontSize: tokens.typography.bodyLg,
        ),
        floatingLabelStyle: TextStyle(
          color: colors.primary,
          fontFamily: tokens.typography.fontFamily,
          fontSize: tokens.typography.label,
        ),
        floatingLabelBehavior: floatingLabelBehavior,
        isDense: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(tokens.radius.small),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.radius.small),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.radius.small),
          borderSide: BorderSide(color: colors.focus, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.radius.small),
          borderSide: BorderSide(color: colors.error, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.radius.small),
          borderSide: BorderSide(color: colors.error, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.radius.small),
          borderSide: BorderSide(color: colors.disabled),
        ),
      ),
    );
  }
}
