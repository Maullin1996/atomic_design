import 'package:flutter/material.dart';

import '../atoms/tokens.dart';

/// A self-contained login form with user, password, social login buttons, and
/// a registration link.
///
/// The form manages its own [TextEditingController]s and validation state
/// internally. When the user taps **Sign In** and all fields are valid,
/// [onSignIn] is called with the trimmed username and raw password — the
/// parent screen is responsible for the authentication logic.
///
/// ```dart
/// AppLoginForm(
///   title: 'Welcome back',
///   isLoading: _authState.isLoading,
///   onSignIn: (user, password) => _authBloc.login(user, password),
///   onGoogle: _loginWithGoogle,
///   onRegister: () => context.push('/register'),
/// )
/// ```
///
/// Social login buttons ([onGitHub], [onGoogle], [onFacebook]) are only
/// rendered when their respective callbacks are non-null.
class AppLoginForm extends StatefulWidget {
  /// Called with the validated username and password when the Sign In button
  /// is tapped. Receives `(user, password)`.
  final void Function(String user, String password)? onSignIn;

  /// Called when the registration text button is tapped.
  final VoidCallback? onRegister;

  /// Shows a GitHub SVG icon button when non-null.
  final VoidCallback? onGitHub;

  /// Shows a Google SVG icon button when non-null.
  final VoidCallback? onGoogle;

  /// Shows a Facebook SVG icon button when non-null.
  final VoidCallback? onFacebook;

  /// When `true`, the Sign In button is disabled and shows a loading indicator.
  final bool isLoading;

  /// Heading text displayed at the top of the form.
  final String title;

  const AppLoginForm({
    super.key,
    this.onSignIn,
    this.onRegister,
    this.onGitHub,
    this.onGoogle,
    this.onFacebook,
    this.isLoading = false,
    this.title = 'Login Form',
  });

  @override
  State<AppLoginForm> createState() => _AppLoginFormState();
}

class _AppLoginFormState extends State<AppLoginForm> {
  bool _obscure = true;
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onSignIn?.call(
        _userController.text.trim(),
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final tokens = AppTokens.of(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: AppText.h4(
              widget.title,
              color: colors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: tokens.spacing.smallMedium),

          AppInputText(
            label: 'User',
            textEditingController: _userController,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: Icon(AppIcons.user),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El campo no puede estar vacío';
              }
              if (value.length < 4) return 'Usuario inválido';
              return null;
            },
          ),
          SizedBox(height: tokens.spacing.smallMedium),

          AppInputText(
            label: 'Password',
            textEditingController: _passwordController,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            obscureText: _obscure,
            prefixIcon: Icon(AppIcons.obscurePassword),
            suffixIcon: AppButtons(
              type: ButtonType.primaryIconButton,
              icon: _obscure ? AppIcons.showPassword : AppIcons.obscurePassword,
              onPressed: () => setState(() => _obscure = !_obscure),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El campo no puede estar vacío';
              }
              if (value.length < 4) return 'Contraseña muy corta';
              return null;
            },
          ),
          SizedBox(height: tokens.spacing.large),

          SizedBox(
            width: double.infinity,
            child: AppButtons(
              type: ButtonType.primaryFillButton,
              isLoading: widget.isLoading,
              onPressed: _submit,
              title: AppText.h4('Sign In', color: colors.textInverse),
            ),
          ),
          SizedBox(height: tokens.spacing.large),

          Center(
            child: AppText.h6('or Sign In With', fontWeight: FontWeight.w400),
          ),
          SizedBox(height: tokens.spacing.smallMedium),

          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.onGitHub != null)
                  AppButtons(
                    type: ButtonType.primaryImageButton,
                    onPressed: widget.onGitHub,
                    assetsIcon: 'assets/icons/github.svg',
                    color: colors.textPrimary,
                  ),
                if (widget.onGoogle != null) ...[
                  SizedBox(width: tokens.spacing.small),
                  AppButtons(
                    type: ButtonType.primaryImageButton,
                    onPressed: widget.onGoogle,
                    assetsIcon: 'assets/icons/facebook.svg',
                  ),
                ],
                if (widget.onFacebook != null) ...[
                  SizedBox(width: tokens.spacing.small),
                  AppButtons(
                    type: ButtonType.primaryImageButton,
                    onPressed: widget.onFacebook,
                    assetsIcon: 'assets/icons/google-circle.svg',
                    color: colors.textPrimary,
                  ),
                ],
              ],
            ),
          ),

          if (widget.onRegister != null)
            Padding(
              padding: EdgeInsets.only(top: tokens.spacing.smallMedium),
              child: AppButtons(
                type: ButtonType.primaryTextButton,
                title: AppText.h5('Registrarse', color: colors.primary),
                onPressed: widget.onRegister,
              ),
            ),
        ],
      ),
    );
  }
}
